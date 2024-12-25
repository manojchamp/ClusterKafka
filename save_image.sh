#!/bin/bash

# Define a folder to store tar files
OUTPUT_DIR="./docker_images"
ZIP_FILE="docker_images1.zip"

# Create the folder if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# List of Docker images with tags
IMAGES=(
  "bitnami/zookeeper:latest"
  "bitnami/kafka:latest"
  "provectuslabs/kafka-ui:latest"
  
)

# Save each image as a tar file
echo "Saving Docker images as tar files..."
for IMAGE in "${IMAGES[@]}"; do
  IMAGE_NAME=$(echo "$IMAGE" | tr '/:' '_') # Replace / and : with _ for filename
  TAR_FILE="${OUTPUT_DIR}/${IMAGE_NAME}.tar"
  echo "Saving $IMAGE to $TAR_FILE"
  docker save -o "$TAR_FILE" "$IMAGE"
done

# Zip all tar files
echo "Compressing all tar files into $ZIP_FILE..."
zip -r "$ZIP_FILE" "$OUTPUT_DIR"

# Confirm success
echo "Docker images saved and compressed into $ZIP_FILE"
