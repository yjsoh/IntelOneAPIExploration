NVCC=nvcc
DPCPP=dpcpp
DPCPP_FLAGS=-I/opt/intel/inteloneapi/dpcpp-ct/latest/include/
RM=rm -f

CXX = dpcpp
CXXFLAGS = -o
LDFLAGS = -lOpenCL -lsycl
EXE_NAME = vector_add
SOURCES = dpct_output/vector_add.dp.cpp
BINDIR = bin

all: main

main:
	[ -d $(BINDIR) ] || mkdir $(BINDIR)
	$(CXX) $(CXXFLAGS) $(BINDIR)/$(EXE_NAME) $(SOURCES) $(LDFLAGS)

cudabin: src/vector_add.cu
	$(NVCC) $^ -O0 -o $@

dpbin: dpct_output/vector_add.dp.cpp
	LD_LIBRARY_PATH=/opt/intel/inteloneapi/compiler/2021.1-beta04/linux/compiler/lib/intel64 $(DPCPP) $^ $(DPCPP_FLAGS) -o $@

dpct_output/vector_add.dp.cpp: src/vector_add.cu
	./build.sh

run:
	$(BINDIR)/$(EXE_NAME)

clean:
	$(RM) cudabin dpbin
	$(RM) compile_commands.json
	$(RM) -r dpct_output bin
	$(RM) $(BINDIR)/$(EXE_NAME)
