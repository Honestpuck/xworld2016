#!/bin/bash

echo -n "Word: " ; read WORD

while [ $WORD -ne "" ] ; do
    case $WORD in
        ( "Foo" )       echo "Bar" ;;
        ( "Bar" )       echo "Foo" ;;
        ( "FooBar" )    echo "No Way" ;;
        ( * )           echo "FooBar" ;;
    esac
done

