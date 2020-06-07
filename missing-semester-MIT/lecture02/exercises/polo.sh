#!/bin/sh
polo() {
    echo "Before I am here $(pwd)"
    cd $dir || exit
    echo "After I am here $(pwd)"
}