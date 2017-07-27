#!/usr/bin/env bash
orgin=`git rev-parse --show-toplevel`
if [ ! -d .git ];
then exit 0
fi
if [ -d .spacecommander ];
then rm -rf .spacecommander
fi
mkdir .codeFormat
cd .codeFormat
git clone https://github.com/Bupterambition/objc-format-check.git -b feature/KEEP codeFormat
cd $orgin
bash "$(pwd)/.codeFormat/codeFormat/setup-repo.sh"
exit 0