#!/usr/bin/env bash
orgin=`git rev-parse --show-toplevel`
if [ ! -d .git ];
then exit 0
fi
if [ -d .spacecommander ];
then rm -rf .clang-format .spacecommander
echo "remove all"
fi
exit 0