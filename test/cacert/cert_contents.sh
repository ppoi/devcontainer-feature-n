#!/bin/bash

set -e 

source dev-container-features-test-lib

check cafile ls /etc/ssl/certs

reportResults
