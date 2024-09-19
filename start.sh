#!/bin/bash

read -p "Enter the Ubuntu version (e.g., 20.04): " UBUNTU_VERSION
read -p "Enter the Go version (e.g., 1.21.4): " GO_VERSION
read -p "Enter the output binary name (e.g., my_project_binary): " PROJECT_NAME
read -p "Enter the folder name (e.g., golang_app): " FOLDER_NAME

# Build the Docker container with the provided arguments
docker build \
  --build-arg UBUNTU_VERSION=${UBUNTU_VERSION} \
  --build-arg GO_VERSION=${GO_VERSION} \
  --build-arg PROJECT_NAME=${PROJECT_NAME} \
  --build-arg FOLDER_NAME=${FOLDER_NAME} \
  -t my_golang_builder .

# Run the Docker container
docker run --rm \
  -v $(pwd)/binary:/root \
  my_golang_builder
