#!/bin/bash

pandoc -t revealjs -i xworld2016-bash.md --slide-level=3 -s -V theme=white -o slides.html

