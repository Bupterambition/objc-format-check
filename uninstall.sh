#!/usr/bin/env bash
orgin=`git rev-parse --show-toplevel`
if [ ! -d .git ];
then exit 0
fi
if [ -d .format-check ];
then rm -rf .format-check
echo "remove all"
fi
exit 0