#!/bin/bash
clients=("192.168.1.101" "192.168.1.102")
for client in "${clients[@]}"; do
    ssh user@$client "$@"
done