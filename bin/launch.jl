#!/usr/bin/env julia-0.6

info(now())
using ArgParse

function parse_commandline()
    s = ArgParseSettings()
    @add_arg_table s begin
        "--local-workers"
            help = "the number of local workers to launch"
            arg_type = Int
        "--remote-workers"
            help = "the number of remote workers to launch"
            arg_type = Int
        "--all-to-all"
            help = "all the workers must connect to all of the other workers"
            action = :store_true
        "--exclude"
            help = "exclude the given ASTM nodes (eg. `--exclude 4 5 12`)"
            arg_type = Int
            nargs = '+'
        "driver"
            help = "path to a Julia file that defines `Driver.go(...)`"
            arg_type = String
            required = true
        "args"
            help = "any remaining arguments will be passed to `Driver.go(...)`"
            nargs = '*'
    end
    return parse_args(s)
end

const args = parse_commandline()
const path = abspath(normpath(args["driver"]))
include(path)

name(astm) = @sprintf("xhall@lwacalim%02d", astm)
function time_worker_spawn(astm, number, topology)
    @elapsed addprocs(fill(name(astm), number))#, tunnel = true, topology = topology
end

function time_load_code(worker, path)
    time = @elapsed remotecall_wait(include, worker, path)
    hostname = remotecall_fetch(worker) do
        chomp(readstring(`hostname`))
    end
    time, hostname
end

function main(args)
    topology = args["all-to-all"] ? :all_to_all : :master_slave

    if args["local-workers"] !== nothing
        info("Launching local workers")
        addprocs(args["local-workers"], topology=topology)
    end

    if args["remote-workers"] !== nothing
        ##info("Launching local workers")
        ##time_worker_spawn(9, args["remote-workers"], topology)
        info("Launching remote workers")
        number = args["remote-workers"]
        for astm = 1:10
            astm in args["exclude"] && continue
            time = time_worker_spawn(astm, number, topology)
            println(" ", rpad(name(astm)*" ", 7, "─"), lpad(@sprintf(" %.1f s", time), 8, "─"))
        end
    end

    if args["local-workers"] !== nothing || args["remote-workers"] !== nothing
        info("Loading code")
        lck = ReentrantLock()
        function print_loading_time(worker, hostname, time)
            lock(lck)
            println(" ", rpad(lpad(worker, 2)*" ", 4, "─"),
                    " ", rpad(hostname*" ", 7, "─"), lpad(@sprintf(" %.1f s", time), 9, "─"))
            unlock(lck)
        end
        @sync for worker in workers()
            @async begin
                time, hostname = time_load_code(worker, path)
                print_loading_time(worker, hostname, time)
            end
        end
    end

    info("Starting computation")
    Driver.go(args["args"]...)
end
main(args)

