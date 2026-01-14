#!/bin/bash
set -e

mkdir -p /opt/hytale/tmp

echo "Starting Hytale download..."
hytale-downloader -download-path /opt/hytale/tmp/hytale.zip

echo "Extracting Hytale files..."
unzip /opt/hytale/tmp/hytale.zip -d /opt/hytale/tmp

echo "Moving server files..."
mv /opt/hytale/tmp/Server/HytaleServer.jar /opt/hytale/data/HytaleServer.jar
mv /opt/hytale/tmp/Server/Licenses /opt/hytale/data/Licenses
mv /opt/hytale/tmp/Assets.zip /opt/hytale/data/Assets.zip

echo "Caching downloader credentials..."
cp .hytale-downloader-credentials.json /opt/hytale/data/.hytale-downloader-credentials.json

echo "Cleaning up temporary files..."
rm -rf /opt/hytale/tmp
