#CASACORE_INC_DIR := /opt/astro/casacore-2.0.3/include/casacore
#CASACORE_LIB_DIR := /opt/astro/casacore-2.0.3/lib
CASACORE_INC_DIR := /opt/include/casacore
CASACORE_LIB_DIR := /opt/lib

CXX = g++

all: swap-polarizations-100hr swap-polarizations-rainy swap-polarizations-2018-03

swap-polarizations-100hr: swap-polarizations-100hr.cc
	$(CXX) -O3 -std=c++11 -I$(CASACORE_INC_DIR) -L$(CASACORE_LIB_DIR) \
		-o swap-polarizations-100hr swap-polarizations-100hr.cc \
		-lcasa_casa -lcasa_tables -lcasa_ms

swap-polarizations-rainy: swap-polarizations-rainy.cc
	$(CXX) -O3 -std=c++11 -I$(CASACORE_INC_DIR) -L$(CASACORE_LIB_DIR) \
		-o swap-polarizations-rainy swap-polarizations-rainy.cc \
		-lcasa_casa -lcasa_tables -lcasa_ms

swap-polarizations-2018-03: swap-polarizations-2018-03.cc
	$(CXX) -O3 -std=c++11 -I$(CASACORE_INC_DIR) -L$(CASACORE_LIB_DIR) \
		-o swap-polarizations-2018-03 swap-polarizations-2018-03.cc \
		-lcasa_casa -lcasa_tables -lcasa_ms

clean:
	rm swap-polarizations-100hr
	rm swap-polarizations-rainy
	rm swap-polarizations-2018-03

