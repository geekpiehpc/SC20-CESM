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
  MPICC :=  mpicc  
  MPICXX :=  mpicxx 
  MPIFC :=  mpif90 
  SCC :=  icc 
  SCXX :=  icpc 
  SFC :=  ifort 
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
  ifeq ($(MPILIB),mpich)
    SLIBS := $(SLIBS)  -mkl=cluster 
  endif
  ifeq ($(MPILIB),mpich2)
    SLIBS := $(SLIBS)  -mkl=cluster 
  endif
  ifeq ($(MPILIB),mvapich)
    SLIBS := $(SLIBS)  -mkl=cluster 
  endif
  ifeq ($(MPILIB),mvapich2)
    SLIBS := $(SLIBS)  -mkl=cluster 
  endif
  ifeq ($(MPILIB),mpt)
    SLIBS := $(SLIBS)  -mkl=cluster 
  endif
  ifeq ($(MPILIB),openmpi)
    SLIBS := $(SLIBS)  -mkl=cluster 
  endif
  ifeq ($(MPILIB),impi)
    SLIBS := $(SLIBS)  -mkl=cluster 
  endif
  ifeq ($(MPILIB),mpi-serial)
    SLIBS := $(SLIBS)  -mkl 
  endif
  ifeq ($(compile_threaded),true)
    FFLAGS_NOOPT := $(FFLAGS_NOOPT)  -qopenmp 
    LDFLAGS := $(LDFLAGS)  -qopenmp 
  endif
endif
