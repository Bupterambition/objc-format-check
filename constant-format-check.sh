#!/usr/bin/env bash
orgin=`git rev-parse --show-toplevel`
if [ ! -d .git ];
then exit 0
fi
if [ -d .spacecommander ];
then exit 0
fi
curl -ssl https://raw.githubusercontent.com/Bupterambition/objc-format-check/feature/KEEP/format-check.sh|bash
exit 0
