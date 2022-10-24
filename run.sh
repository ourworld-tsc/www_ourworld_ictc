# TODO: Check other paths for binary executable ?
if [[ ! -f "tailwindcss" ]]
then
    # checks os and architecture for correct release
    # https://stackoverflow.com/a/8597411 
    echo "Installing & building tailwind..."
    ASSET="tailwindcss"

    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        ASSET="$ASSET-linux"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        ASSET="$ASSET-macos"
    fi
    if [[ "$(uname -m)" == "x86_64"* ]]; then
        ASSET="$ASSET-x64"
    elif [[ "$(uname -m)" == "arm64"* ]]; then
        ASSET="$ASSET-arm64"
    fi

    curl -sLO "https://github.com/tailwindlabs/tailwindcss/releases/latest/download/${ASSET}"
    chmod +x $ASSET
    mv $ASSET tailwindcss        
fi


rm -rf public static/css
./tailwindcss -i static/index.css -o ./static/css/index.css --minify 
v . -g
v run ticket.v