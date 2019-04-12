#!/bin/bash
# Creates a md file for Slate from publicApi.yaml in the wisetack development.

echo "Copying publicApi.yaml to current directory."

cp ../wisetack/aws/src/main/resources/publicApi.yaml publicApi.yaml

echo "Creating json file from yaml."

java -jar xyaml2json.jar publicApi.yaml publicApi.json

echo "Create markdown for Slate."

widdershins --search false --language_tabs 'curl:Curl' --summary publicApi.json -o index.html.md

echo "Markdown created."

cp index.html.md source/index.html.md

echo "The new OpenAPI spec has been deployed locally."


