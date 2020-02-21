# $< - name of all prerequisites
# $@ - name of the target

# HEADERS - *.hpp header files
# SOURCES - *.cpp source files
# OBJECTS - *.o object files without directories in path
HEADERS=$(shell find . -type f -name "*.hpp")
SOURCES=$(shell find . -type f -name "*.cpp")
OBJECTS=$(subst .cpp,.o,$(notdir $(SOURCES)))

# Generating folders if they don't exist
$(shell [ ! -d Objects ] && mkdir Objects)
$(shell [ ! -d Build ] && mkdir Build)

# Adding to vpath path to source *.cpp files
vpath %.cpp = $(dir $(SOURCES))

all: target

# Linking all *.o files into *.exe
target: $(addprefix Objects/,$(OBJECTS))
	g++ $(addprefix Objects/,$(OBJECTS)) -o Build/Target.exe

# Compiling each *.cpp file into *.o file
Objects/%.o: %.cpp
	g++ -c -o $@ $<
