#!/bin/zsh

here="$(dirname $0)"

if [ -e /dev/fd/3 ] ; then
    . =($1 | $here/add-export.zsh | tee /dev/stderr | tee /dev/fd/3)
else
    . =($1 | $here/add-export.zsh | tee /dev/fd/2)
fi

