// swap-polarizations-100hr.cc
// author: Michael Eastwood
//
// This program fixes an error in the March 19, 2016 "100 hr run" where antennas that were given an
// odd delay (ie. the number of samples was odd) had their polarizations swapped.
//
// We will also apply an additional polarization swap to a number of antennas that seem to have a
// polarization swap unrelated to the delay firmware.

#include <iostream>
#include <string>
#include <casa/Arrays.h>
#include <tables/Tables.h>
#include <ms/MeasurementSets.h>

using namespace std;
using namespace casacore;

void odd_odd(Array<Complex>& data, int baseline) {
    IPosition shape = data.shape();
    for (int channel = 0; channel < shape[1]; ++channel) {
        Complex xx = data(IPosition(3, 0, channel, baseline));
        Complex xy = data(IPosition(3, 1, channel, baseline));
        Complex yx = data(IPosition(3, 2, channel, baseline));
        Complex yy = data(IPosition(3, 3, channel, baseline));
        data(IPosition(3, 0, channel, baseline)) = yy;
        data(IPosition(3, 1, channel, baseline)) = yx;
        data(IPosition(3, 2, channel, baseline)) = xy;
        data(IPosition(3, 3, channel, baseline)) = xx;
    }
}

void odd_even(Array<Complex>& data, int baseline) {
    IPosition shape = data.shape();
    for (int channel = 0; channel < shape[1]; ++channel) {
        Complex xx = data(IPosition(3, 0, channel, baseline));
        Complex xy = data(IPosition(3, 1, channel, baseline));
        Complex yx = data(IPosition(3, 2, channel, baseline));
        Complex yy = data(IPosition(3, 3, channel, baseline));
        data(IPosition(3, 0, channel, baseline)) = yx;
        data(IPosition(3, 1, channel, baseline)) = yy;
        data(IPosition(3, 2, channel, baseline)) = xx;
        data(IPosition(3, 3, channel, baseline)) = xy;
    }
}

void even_odd(Array<Complex>& data, int baseline) {
    IPosition shape = data.shape();
    for (int channel = 0; channel < shape[1]; ++channel) {
        Complex xx = data(IPosition(3, 0, channel, baseline));
        Complex xy = data(IPosition(3, 1, channel, baseline));
        Complex yx = data(IPosition(3, 2, channel, baseline));
        Complex yy = data(IPosition(3, 3, channel, baseline));
        data(IPosition(3, 0, channel, baseline)) = xy;
        data(IPosition(3, 1, channel, baseline)) = xx;
        data(IPosition(3, 2, channel, baseline)) = yy;
        data(IPosition(3, 3, channel, baseline)) = yx;
    }
}

int main(int argc, char* argv[]) {
    if (argc != 2) {
        cout << "provide the name of exactly one measurement set" << endl;
        return 0;
    }
    string name(argv[1]);

    MeasurementSet ms(name, Table::Update);
    MSColumns columns(ms);
    ScalarColumn<Int> antenna1_column = columns.antenna1();
    ScalarColumn<Int> antenna2_column = columns.antenna2();
    ArrayColumn<Complex> data_column = columns.data();
    Vector<Int> antenna1 = antenna1_column.getColumn();
    Vector<Int> antenna2 = antenna2_column.getColumn();
    Array<Complex> data = data_column.getColumn();

    // this list was given to me by Marin
    bool swap[256] = {1, 0, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 1, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 0, 1, 0, 1, 0, 0, 1, 1, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1, 1, 0, 0, 1, 1, 1, 0, 1, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 1, 1, 0, 1, 0, 1, 0, 0, 1, 1, 1, 0, 0, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 1, 1, 1, 1, 0, 0, 1, 1, 0, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 1, 1, 1, 1, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 0, 0, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, 1, 1, 1, 0, 1, 0, 0, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 0, 1};

    // in addition to the polarizations that were swapped due to a bug in the firmware for applying
    // delays, there are some antennas that seem to have an additional polarization swap (presumably
    // to some swapped cables)
    swap[120] = !swap[120];
    swap[185] = !swap[185];
    swap[186] = !swap[186];

    IPosition shape = data.shape();
    for (int baseline = 0; baseline < shape[2]; ++baseline) {
        int ant1 = antenna1[baseline];
        int ant2 = antenna2[baseline];
        if (swap[ant1] && swap[ant2]) {
            odd_odd(data, baseline);
        } else if (swap[ant1] && !swap[ant2]) {
            odd_even(data, baseline);
        } else if (!swap[ant1] && swap[ant2]) {
            even_odd(data, baseline);
        }
    }

    data_column.putColumn(data);

    return 0;
}

