#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Docker Compose Commands
up() {
    print_status "Starting Docker containers..."
    docker-compose up -d
    if [ $? -eq 0 ]; then
        print_success "Containers started successfully"
        print_status "Access your app at: http://localhost:8080"
        print_status "Access your app at: http://localhost:8080"
    else
        print_error "Failed to start containers"
        exit 1
    fi
}

down() {
    print_status "Stopping Docker containers..."
    docker-compose down
    if [ $? -eq 0 ]; then
        print_success "Containers stopped successfully"
    else
        print_error "Failed to stop containers"
        exit 1
    fi
}

restart() {
    print_status "Restarting Docker containers..."
    docker-compose down
    docker-compose up -d
    if [ $? -eq 0 ]; then
        print_success "Containers restarted successfully"
    else
        print_error "Failed to restart containers"
        exit 1
    fi
}

logs() {
    print_status "Showing container logs..."
    docker-compose logs -f
}

status() {
    print_status "Container status:"
    docker-compose ps
}

# Development Commands
clean() {
    print_status "Cleaning up..."
    docker-compose down
    docker system prune -f
    print_success "Cleanup completed"
}

build() {
    print_status "Building containers..."
    docker-compose build
    if [ $? -eq 0 ]; then
        print_success "Build completed successfully"
    else
        print_error "Build failed"
        exit 1
    fi
}

# Help function
help() {
    echo "Usage: sh $0 <command>"
    echo ""
    echo "Available commands:"
    echo "  up        - Start Docker containers"
    echo "  down      - Stop Docker containers"
    echo "  restart   - Restart Docker containers"
    echo "  logs      - Show container logs"
    echo "  status    - Show container status"
    echo "  build     - Build Docker containers"
    echo "  clean     - Stop containers and clean up Docker system"
    echo ""
    echo "Other:"
    echo "  help      - Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 up"
    echo "  $0 logs"
    echo "  $0 git-push"
}

# Main command dispatcher
main() {
    case "$1" in
        "up")
            up
            ;;
        "down")
            down
            ;;
        "restart")
            restart
            ;;
        "logs")
            logs
            ;;
        "status")
            status
            ;;
        "build")
            build
            ;;
        "clean")
            clean
            ;;
        "help"|"--help"|"-h")
            help
            ;;
        "")
            print_error "No command provided"
            help
            exit 1
            ;;
        *)
            print_error "Unknown command: $1"
            help
            exit 1
            ;;
    esac
}

# Run main function with all arguments
main "$@"