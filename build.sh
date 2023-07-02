#!/bin/sh

podman build -t bowmanjd/posix-playground:latest -t "bowmanjd/posix-playground:$(date +%Y.%m.%d)" .
