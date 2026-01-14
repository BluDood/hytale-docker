cd /opt/hytale/data

echo "Starting the Hytale server..."

JAVA_OPTS="${HYTALE_SERVER_JAVA_OPTS:-}"
EXTRA_ARGS="${HYTALE_SERVER_EXTRA_ARGS:-}"
MIN_HEAP="${HYTALE_SERVER_MIN_HEAP:-2G}"
MAX_HEAP="${HYTALE_SERVER_MAX_HEAP:-4G}"

exec java \
    -Xms$MIN_HEAP \
    -Xmx$MAX_HEAP \
    $JAVA_OPTS \
    -jar HytaleServer.jar \
    --assets Assets.zip \
    --boot-command "auth persistence Encrypted" \
    --boot-command "auth login device" \
    $EXTRA_ARGS