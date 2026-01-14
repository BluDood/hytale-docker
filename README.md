# Docker Image for Hytale Server
Dead simple Docker hosting solution for Hytale's game server.

## Getting Started
When you create your server for the first time, you will need to authenticate your Hytale account to download and register the server. When this is done, you can simply start and stop the server as you would any other Docker container.
### First-time Setup
1. Create a `compose.yml` like this:
    ```yml
    services:
      hytale:
        image: ghcr.io/bludood/hytale:latest
        stdin_open: true
        tty: true
        environment:
          - HYTALE_SERVER_EXTRA_ARGS=
          - HYTALE_SERVER_JAVA_OPTS=-XX:+UseG1GC
          - HYTALE_SERVER_MIN_HEAP=2G
          - HYTALE_SERVER_MAX_HEAP=4G
        volumes:
          - ./data:/opt/hytale/data
        ports:
          - "5520:5520/udp"
    ```
2. Run `docker compose up` interactively to start initializing the server
3. Open the provided link and authenticate your Hytale account to the downloader
4. Wait for the download to complete, and for the server to start
5. When server startup is complete, open the new authorization link to register your server to your account
6. Once this is complete, you can stop the container again using `CTRL+C` or `docker compose down`
### Starting and Stopping the Server
After you have set up the server for the first time, you can simply start and stop the server using:
```bash
docker compose up -d # start the server
docker compose down # stop the server
```
### Accessing the Server Console
To access the server console to run commands, you can use:
```bash
docker compose attach hytale
```
### Development
For development, you can merge in the `compose.dev.yml` file to build the image from the local `Dockerfile`:
```bash
docker compose -f compose.yml -f compose.dev.yml up --build # build and start the server
```
## Configuration
After the initial setup is complete, your server files live in the `data` directory. Here you'll find your universe, configuration, mods, etc. You can edit the configuration in `data/config.json`. You can find more information about the server files in [this article](https://support.hytale.com/hc/en-us/articles/45326769420827-Hytale-Server-Manual#file-structure).

## Ports
The server runs on UDP port `5520` inside the container. If you would like to change the exposed port, you can modify the `ports` section in your `compose.yml`:
```yaml
ports:
  - 25565:5520/udp # host:container
```

## Environment Variables
You can configure the server further by using environment variables. The following environment variables are supported:
- `HYTALE_SERVER_EXTRA_ARGS`: Additional command line arguments to pass to the server on startup.
- `HYTALE_SERVER_JAVA_OPTS`: Additional Java options to pass to the JVM running the server.
- `HYTALE_SERVER_MIN_HEAP`: Minimum heap size for the JVM (default: `2G`).
- `HYTALE_SERVER_MAX_HEAP`: Maximum heap size for the JVM (default: `4G`).

Example:
```yaml
environment:
  - HYTALE_SERVER_EXTRA_ARGS=--event-debug
  - HYTALE_SERVER_JAVA_OPTS=-XX:+UseG1GC
  - HYTALE_SERVER_MIN_HEAP=4G
  - HYTALE_SERVER_MAX_HEAP=8G
```

## Troubleshooting
### Manual Download
If you for some reason cannot use the Hytale Downloader to download the server files (e.g. unsupported architecture), you can manually download and copy the server files:
1. Locate your installed game files. Usually found in:
    - **Windows**: `%appdata%\Hytale\install\release\package\game\latest`
    - **Linux**: `$XDG_DATA_HOME/Hytale/install/release/package/game/latest`
    - **MacOS**: `~/Application Support/Hytale/install/release/package/game/latest`
2. Copy the following files to your `data` directory:
    - `Server/HytaleServer.jar` -> `data/HytaleServer.jar`
    - `Assets.zip` -> `data/Assets.zip`
3. Start the server using `docker compose up` and proceed with the server registration step (step 5 in [First-time Setup](#first-time-setup))

## Licensing
By authenticating your Hytale account and downloading the server, you agree to the licenses of the software provided by Hypixel Studios. The licenses can be located under `data/Licenses` after the server is downloaded.