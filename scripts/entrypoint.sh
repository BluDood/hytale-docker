#!/bin/bash
set -e

cd /opt/hytale

if [ ! -f "data/HytaleServer.jar" ]; then
    if [ -f "data/.hytale-downloader-credentials.json" ]; then
        echo "Downloader credentials found, copying..."
        cp data/.hytale-downloader-credentials.json .hytale-downloader-credentials.json
    fi

    ./scripts/download.sh
else
    echo "Hytale server files already exist, skipping download."
fi

exec ./scripts/server.sh