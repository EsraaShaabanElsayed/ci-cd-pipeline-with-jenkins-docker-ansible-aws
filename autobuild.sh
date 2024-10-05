#!/bin/bash

echo "MAVEN.."
mvn package

echo "running docker build .."
docker build -t petclinic-tomcat .
