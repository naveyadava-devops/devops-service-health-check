#!/bin/bash

if [ "$#" -lt 1 ]; then
    echo "Usage: $0 <service1> [service2] [service3]"
    exit 1
fi

echo "Starting service health check..."

check_service() {
    if systemctl is-active --quiet "$1"; then
        echo "Service: $1 -> Running"
        return 0
    else
        echo "Service: $1 -> Not Running"
        return 1
    fi
}

failed=0

for service in "$@"; do
    if ! check_service "$service"; then
        failed=1
    fi
done

if [ "$failed" -eq 0 ]; then
    echo "All services are running."
    exit 0
else
    echo "One or more services are not running."
    exit 1
fi
