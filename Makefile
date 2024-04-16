# choose a compiler based on the OS
UNAME_S := $(shell hostname)
ifeq ($(UNAME_S),uan01)
    CXX := CC 
else 
    CXX := g++ 
endif

# set the directory for the binary files
BIN_DIR = bin

# defaul instruction, run the program
run: birds
	@ $(BIN_DIR)/main.out


test: $(BIN_DIR)/test.out
	@ $(BIN_DIR)/test.out

# compile the program
birds: main.cc $(BIN_DIR)/simulation.o
	$(CXX) -std=c++11 -Wall -openmp -o $(BIN_DIR)/main.out main.cc $(BIN_DIR)/simulation.o

	

# compile the program with openMP
openMP: main.cc $(BIN_DIR)/simulation.o
	$(CXX) -std=c++11 -openmp   -DUSE_OPENMP_FUNCTION -Wall -o $(BIN_DIR)/main_openMP.out main.cc $(BIN_DIR)/simulation.o



# compile the program
$(BIN_DIR)/test.out: test.cc $(BIN_DIR)/simulation.o
	$(CXX) -std=c++11 -Wall -o $(BIN_DIR)/test.out test.cc $(BIN_DIR)/simulation.o


# compile the simulation file
$(BIN_DIR)/simulation.o: simulation.cc simulation.h
	$(CXX) -std=c++11 -Wall -openmp -c simulation.cc -o $(BIN_DIR)/simulation.o

# clean the binary files
clean:
	rm -f $(BIN_DIR)/*.o $(BIN_DIR)/*.out
