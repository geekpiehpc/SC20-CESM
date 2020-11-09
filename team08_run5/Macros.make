
SUPPORTS_CXX := FALSE
ifeq ($(COMPILER),intel)
  SUPPORTS_CXX := TRUE
  CFLAGS :=   -qno-opt-dynamic-align -fp-model precise -std=gnu99
  CXX_LDFLAGS :=  -cxxlib
  CXX_LINKER := FORTRAN
  FC_AUTO_R8 :=  -r8
  FFLAGS :=  -qno-opt-dynamic-align  -convert big_endian -assume byterecl -ftz -traceback -assume realloc_lhs -fp-model source
  FFLAGS_NOOPT :=  -O0
  FIXEDFLAGS :=  -fixed -132
  FREEFLAGS :=  -free
  MPICC :=  mpiicc
  MPICXX :=  mpiicpc
  MPIFC :=  mpiifort
  SCC :=  icc
  SCXX :=  icpc
  SFC :=  ifort
  NETCDF_PATH :=  /opt/nonspack/netcdf-c-intel-19.0.5.281-parallel/
  HDF5_PATH := /opt/nonspack//hdf5-intel-19.0.5.281-parallel/
  PNETCDF_PATH := /opt/nonspack/pnetcdf-1.12.1-intel/
SLIBS += -L${NETCDF_PATH}/lib -lnetcdff -lnetcdf -L${PNETCDF_PATH}/lib -L${HDF5_PATH}/lib -lhdf5_hl -lhdf5 -ldl -lm -lz -L${MKLROOT}/lib/intel64 -lmkl_rt -lpthread -ldl
LDFLAGS += -L${NETCDF_PATH}/lib -lnetcdff -lnetcdf -L${PNETCDF_PATH}/lib -L${HDF5_PATH}/lib -lhdf5_hl -lhdf5 -lm -lz -L${MKLROOT}/lib/intel64 -lmkl_rt


endif
ifeq ($(MODEL),pop)
  CPPDEFS := $(CPPDEFS)  -D_USE_FLOW_CONTROL
endif
ifeq ($(COMPILER),intel)
  CPPDEFS := $(CPPDEFS)  -DFORTRANUNDERSCORE -DCPRINTEL
  ifeq ($(compile_threaded),true)
    CFLAGS := $(CFLAGS)  -qopenmp
    FFLAGS := $(FFLAGS)  -qopenmp
  endif
  ifeq ($(DEBUG),FALSE)
    CFLAGS := $(CFLAGS)  -O2 -debug minimal
    FFLAGS := $(FFLAGS)  -O2 -debug minimal
  endif
  ifeq ($(DEBUG),TRUE)
    CFLAGS := $(CFLAGS)  -O0 -g
    FFLAGS := $(FFLAGS)  -O0 -g -check uninit -check bounds -check pointers -fpe0 -check noarg_temp_created
  endif

  ifeq ($(compile_threaded),true)
    FFLAGS_NOOPT := $(FFLAGS_NOOPT)  -qopenmp
    LDFLAGS := $(LDFLAGS)  -qopenmp
  endif
endif

