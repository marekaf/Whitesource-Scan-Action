#!/bin/sh -l

set -e

if [ -z "$INPUT_APIKEY" ]; then
  echo "You must set an API key!"
  exit 126
fi

if [ -z "$INPUT_CONFIGFILE" ] && [ -z "$INPUT_PROJECTNAME" ]; then
  echo "'projectName' or 'configFile' path must be set."
  exit 126
fi

# Download latest Unified Agent release from Whitesource
curl -LJO  https://github.com/whitesource/unified-agent-distribution/releases/latest/download/wss-unified-agent.jar

# Run additional commands if necessary
if [ -n "$INPUT_EXTRACOMMANDSFILE" ]; then
  echo "Executing file: $INPUT_EXTRACOMMANDSFILE"
  chmod +x $INPUT_EXTRACOMMANDSFILE
  ./$INPUT_EXTRACOMMANDSFILE
fi

# Execute Unified Agent (2 settings)
if [ -z  "$INPUT_CONFIGFILE" ]; then
  java -jar wss-unified-agent.jar -noConfig true -apiKey $INPUT_APIKEY -project "$INPUT_PROJECTNAME" -product "$INPUT_PRODUCTNAME" \
    -d . -wss.url $INPUT_WSSURL -resolveAllDependencies true
else
  java -jar wss-unified-agent.jar -apiKey $INPUT_APIKEY -c "$INPUT_CONFIGFILE" -d .
fi
