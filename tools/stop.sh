#!/bin/bash

cd airbyte/; docker-compose down -v; cd ..
cd airflow/; docker-compose down -v; cd ..
docker stop dest && docker rm dest -v

docker network rm airflow_summit_network

# Cleanup old state files
rm -rf airbyte/*/*/state.yaml
