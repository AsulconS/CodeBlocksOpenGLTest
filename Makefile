CC	= gcc
CXX	= g++

GRAPHICS	= display.o shader.o camera.o texture.o mesh.o model.o light.o
SYSTEM		= time.o
OBJECTS		= glad.o $(GRAPHICS) $(SYSTEM) main.o
CXX_FLAGS	= -std=c++11
INCLUDE		= -Iinclude/

C_OS		:=
LIBS		:=
ifeq ($(OS),Windows_NT)
	C_OS += Windows
	LIBS += -lglfw3 -lopengl32 -lglu32 -lgdi32 -luser32 -lkernel32 -lassimp
else
	C_OS += Linux
	LIBS += -lglfw -lGL -lX11 -lpthread -lXrandr -lXi -ldl -lassimp
endif

all: os build trash

os:
	@echo $(C_OS)

build: $(OBJECTS)
	$(CXX) $(CXX_FLAGS) $(OBJECTS) $(INCLUDE) $(LIBS) -o main

glad.o: src/glad.c
	$(CC) -c src/glad.c

# GRAPHICS
display.o: src/display.cpp
	$(CXX) $(CXX_FLAGS) $(INCLUDE) -c src/display.cpp

shader.o: src/shader.cpp
	$(CXX) $(CXX_FLAGS) $(INCLUDE) -c src/shader.cpp

camera.o: src/camera.cpp
	$(CXX) $(CXX_FLAGS) $(INCLUDE) -c src/camera.cpp

texture.o: src/texture.cpp
	$(CXX) $(CXX_FLAGS) $(INCLUDE) -c src/texture.cpp

mesh.o: src/mesh.cpp
	$(CXX) $(CXX_FLAGS) $(INCLUDE) -c src/mesh.cpp

model.o: src/model.cpp
	$(CXX) $(CXX_FLAGS) $(INCLUDE) -c src/model.cpp

light.o: src/light.cpp
	$(CXX) $(CXX_FLAGS) $(INCLUDE) -c src/light.cpp

# SYSTEM
time.o: src/time.cpp
	$(CXX) $(CXX_FLAGS) $(INCLUDE) -c src/time.cpp

# MAIN
main.o: src/main.cpp
	$(CXX) $(CXX_FLAGS) $(INCLUDE) -c src/main.cpp

trash:
	rm -rf *.o

clean:
	rm -rf *.o main
