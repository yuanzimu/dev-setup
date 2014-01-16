#!/bin/sh

# Run this from within the Vagrant VM to run all tests sequentially.

# Test [rt](https://github.com/stucco/rt)
cd /stucco/rt
sbt test

# Test [document-service](https://github.com/stucco/document-service)
cd /stucco/document-service
npm test
