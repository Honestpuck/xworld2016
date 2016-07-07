#!/bin/bash

WORD="Start"

while [ "$WORD" != "" ] ; do
echo -n "Word: " ; read WORD
    case "$WORD" in
        ( "Foo" )       echo "Bar" ;;
        ( "Bar" )       echo "Foo" ;;
        ( "FooBar" )    echo "No Way" ;;
        ( "" ) ;;
        ( * )           echo "FooBar" ;;
    esac
done

