#!/bin/bash

echo "MAVEN.."
mvn package

echo "running docker compose up.."
docker compose up

