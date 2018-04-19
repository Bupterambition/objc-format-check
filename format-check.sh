#!/usr/bin/env bash
orgin=`git rev-parse --show-toplevel`
if [ ! -d .git ];
then exit 0
fi
if [ -d .spacecommander ];
then rm -rf .spacecommander
fi
mkdir .codeFormatForBytedance
cd .codeFormatForBytedance
git clone https://github.com/Bupterambition/objc-format-check.git -b feature/KEEP codeFormatForBytedance
cd $orgin
bash "$(pwd)/.codeFormatForBytedance/codeFormatForBytedance/setup-repo.sh"
exit 0
