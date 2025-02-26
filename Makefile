CXX := g++-14
STD := c++26
TARGET := a.out

SRCS := $(wildcard *.cpp)
OBJS := $(SRCS:.cpp=.o)
DEPENDS := $(OBJS:.o=.d)

DEBUG_FLAGS := -g3 -DDEBUG -O0 -fno-omit-frame-pointer -fsanitize=address
WARNINGS := -Wall -Wextra -Wpedantic
CXXFLAGS := $(WARNINGS) $(DEBUG_FLAGS) -std=$(STD) -MMD -MP

.PHONY: all clean

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CXX) $^ -o $@ $(CXXFLAGS)

%.o: %.cpp
	$(CXX) -c $< -o $@ $(CXXFLAGS)

-include $(DEPENDS)

clean:
	rm -f $(TARGET) *.o *.d

commit: clean
	git add .
	git commit -m f
