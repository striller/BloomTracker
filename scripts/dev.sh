#!/bin/bash
# Development script for bloomtracker project
# Run with: ./scripts/dev.sh <command>

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_step() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Ensure we're in a virtual environment
if [[ -z "$VIRTUAL_ENV" ]]; then
    print_warning "Not in a virtual environment. Activating venv..."
    if [[ -f "venv/bin/activate" ]]; then
        source venv/bin/activate
    else
        print_error "Virtual environment not found. Please run: python3 -m venv venv && source venv/bin/activate"
        exit 1
    fi
fi

# Main commands
case "${1:-help}" in
    "lint")
        print_step "Running pylint..."
        pylint bloomtracker/*.py
        print_success "Linting completed!"
        ;;
    
    "license-check")
        print_step "Checking license compatibility..."
        licensecheck --zero
        print_success "License check completed!"
        ;;
    
    "test")
        print_step "Running tests..."
        python -m pytest tests/ -v
        print_success "Tests completed!"
        ;;
    
    "check-all")
        print_step "Running comprehensive checks..."
        echo
        print_step "1. Linting with pylint..."
        pylint bloomtracker/*.py
        echo
        print_step "2. Checking license compatibility..."
        licensecheck --zero
        echo
        print_step "3. Running tests..."
        python -m pytest tests/ -v
        echo
        print_success "All checks passed!"
        ;;
    
    "install-dev")
        print_step "Installing development dependencies..."
        pip install -e ".[dev]"
        print_success "Development dependencies installed!"
        ;;
    
    "clean")
        print_step "Cleaning cache files..."
        find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
        find . -type f -name "*.pyc" -delete 2>/dev/null || true
        find . -type d -name "*.egg-info" -exec rm -rf {} + 2>/dev/null || true
        print_success "Cache files cleaned!"
        ;;
    
    "help"|*)
        echo "Development script for bloomtracker"
        echo
        echo "Usage: $0 <command>"
        echo
        echo "Commands:"
        echo "  lint           Run pylint on all Python files"
        echo "  license-check  Check license compatibility of dependencies"
        echo "  test           Run all tests"
        echo "  check-all      Run all checks (lint, license, tests)"
        echo "  install-dev    Install development dependencies"
        echo "  clean          Clean cache files"
        echo "  help           Show this help message"
        echo
        ;;
esac
