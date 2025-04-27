.PHONY: all setup clean

all: setup

setup:
	@echo "Running setup..."
	@chmod +x setup.sh
	@./setup.sh

clean:
	@echo "Cleaning build directories..."
	rm -rf build-binutils build-gcc src
