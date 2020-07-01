#!/bin/bash

CONFIG=(
    "tagdns-config.xml"
)

for config in $(CONFIG[@]); do
    cat config/items/$(config) | java -jar lib/jenkins-cli.jar -s http://localhost:8080 create-job tagdns
done
