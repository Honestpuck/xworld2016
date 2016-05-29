#!/bin/bash

pandoc -t revealjs xworld2016-bash.md -f markdown+pipe_tables --slide-level=3 -s -o index.html \
    -V theme=white 
 
