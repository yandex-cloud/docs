#!/bin/sh

if [ ! -e ../.git/hooks_orig ]; then
 echo "backup hooks"
 mv ../.git/hooks ../.git/hooks_orig
else
 echo "hooks_orig exists"
fi

rm -r ../.git/hooks
cp -r ./hooks ../.git/hooks
