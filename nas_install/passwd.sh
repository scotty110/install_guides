#!/bin/bash
export LC_CTYPE=C
(tr -c -d '[:graph:]' < /dev/urandom | head -c64) | pbcopy