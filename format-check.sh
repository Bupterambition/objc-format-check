#!/usr/bin/env bash
gitdir_root=`git rev-parse --show-toplevel`
if [ ! -d .git ];
then exit 0
fi

if [ -d .spacecommander ];
then rm -rf .spacecommander
fi

mkdir .spacecommander
cd .spacecommander
git clone https://github.com/Bupterambition/objc-format-check.git spacecommander
cd "$gitdir_root"
bash "$(pwd)/.spacecommander/spacecommander/setup-repo.sh"

if [ -f "$gitdir_root/.clang-format" ];
then
    echo "💕 Installation has been completed. 💕"
else
    echo "💣 Installation failed. 💣"
    exit 1
fi

exit 0