#!/usr/bin/env zsh
if [ $# -eq 0 ]
then
    echo "No arguments supplied! You should type 0 or 1 or 2 or 3."
    exit
fi
if [[ $@ == v* ]]
then
    target=DUMBVM
else
    target=GENERIC
fi
if [[ $1 == *o ]]
then
    target=$target-OPT
fi
echo "Build for" $target
cd ~/src/kern/conf
./config $target > /dev/null
cd ~/src/kern/compile/$target
bmake depend > /dev/null
bmake | sed -e '/mips-harvard-os161.*/d'
bmake install | tail -n 1

cd ~/os161/root
if [[ $@ == *rw* ]]
then
    if [[ $# > 1 ]]
    then
        shift
        sys161 -w kernel $@
    else
        sys161 -w kernel
    fi
else if [[ $@ == *r* ]]
then
    if [[ $# > 1 ]]
    then
        shift
        sys161 kernel $@
    else
        sys161 kernel
    fi
fi
 fi
