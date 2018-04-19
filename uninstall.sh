#!/usr/bin/env bash
orgin=`git rev-parse --show-toplevel`
cd $orgin
if [ ! -d .git ];
then exit 0
fi
rm -rf .clang-format .spacecommander .codeFormat .git/hooks/pre-commit .codeFormatForBytedance
echo "remove all"
exit 0