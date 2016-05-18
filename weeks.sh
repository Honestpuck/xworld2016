#!/bin/bash

WEEKS=$1
DAYS=`expr $WEEKS '*' '7'`
date -v +${DAYS}d 
