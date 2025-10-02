.PHONY: help build test clean run lint format install debug release all

# Default target
.DEFAULT_GOAL := help

# Variables
SWIFT_BUILD_FLAGS=
SWIFT_TEST_FLAGS=
PROJECT_NAME = MySwiftApp
CLI_NAME = MySwiftAppCLI

# Colors for terminal output
GREEN = \033[0;32m
YELLOW = \033[0;33m
NC = \033[0m # No Color

## help: Show this help message
help:
	@echo "$(GREEN)Available targets:$(NC)"
	@echo ""
	@echo "  $(YELLOW)build$(NC)       - Build the project in debug mode"
	@echo "  $(YELLOW)release$(NC)     - Build the project in release mode"
	@echo "  $(YELLOW)test$(NC)        - Run all tests"
	@echo "  $(YELLOW)test-verbose$(NC) - Run tests with verbose output"
	@echo "  $(YELLOW)clean$(NC)       - Remove build artifacts"
	@echo "  $(YELLOW)run$(NC)         - Run the CLI application"
	@echo "  $(YELLOW)lint$(NC)        - Run SwiftLint on the codebase"
	@echo "  $(YELLOW)format$(NC)      - Auto-format code with SwiftLint"
	@echo "  $(YELLOW)install$(NC)     - Resolve and fetch dependencies"
	@echo "  $(YELLOW)debug$(NC)       - Build with debug symbols"
	@echo "  $(YELLOW)all$(NC)         - Build and run tests"
	@echo ""
	@echo "$(GREEN)Example usage:$(NC)"
	@echo "  make build"
	@echo "  make test"
	@echo "  make run"
	@echo ""

## build: Build the project in debug mode
build:
	@echo "$(GREEN)Building $(PROJECT_NAME)...$(NC)"
	swift build $(SWIFT_BUILD_FLAGS)

## debug: Build with debug symbols (alias for build)
debug: build

## release: Build the project in release mode with optimizations
release:
	@echo "$(GREEN)Building $(PROJECT_NAME) in release mode...$(NC)"
	swift build -c release

## test: Run all tests
test:
	@echo "$(GREEN)Running tests...$(NC)"
	swift test $(SWIFT_TEST_FLAGS)

## test-verbose: Run tests with verbose output
test-verbose:
	@echo "$(GREEN)Running tests with verbose output...$(NC)"
	swift test --verbose

## clean: Remove build artifacts
clean:
	@echo "$(GREEN)Cleaning build artifacts...$(NC)"
	swift package clean
## run: Run the CLI application
run: build
	@echo "$(GREEN)Running $(CLI_NAME)...$(NC)"
	swift run $(CLI_NAME)

## lint: Run SwiftLint on the codebase
lint:
	@echo "$(GREEN)Running SwiftLint...$(NC)"
	@if command -v swiftlint >/dev/null 2>&1; then \
		swiftlint lint; \
	else \
		echo "$(YELLOW)SwiftLint is not installed. Install it with: brew install swiftlint$(NC)"; \
	fi

## format: Auto-format code with SwiftLint
format:
	@echo "$(GREEN)Formatting code with SwiftLint...$(NC)"
	@if command -v swiftlint >/dev/null 2>&1; then \
		swiftlint --fix; \
	else \
		echo "$(YELLOW)SwiftLint is not installed. Install it with: brew install swiftlint$(NC)"; \
	fi

## install: Resolve and fetch dependencies
install:
	@echo "$(GREEN)Resolving dependencies...$(NC)"
	swift package resolve

## all: Build and run tests
all: build test
	@echo "$(GREEN)Build and test complete!$(NC)"
