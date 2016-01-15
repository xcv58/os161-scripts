#!/usr/bin/env zsh
build() {
    target=$1
    echo "Build for" ${target}
    cd ~/src/kern/conf
    ./config ${target} > /dev/null
    cd ~/src/kern/compile/${target}
    bmake depend > /dev/null
    bmake | sed -e '/mips-harvard-os161.*/d'
    bmake install | tail -n 1
}

run() {
    if [[ $@ == *rw* ]] then
        COMMAND="sys161 -w kernel"
    else
        COMMAND="sys161 kernel"
    fi
    shift
    eval ${COMMAND} $@
}

debug() {
    os161-gdb kernel
}

help() {
    echo "No arguments supplied! You should provide arguments:
    b: build for DUMBVM
    bv: build for GENERIC vm
    r: run your kernel
    rw: run your kernel in debug mode
    d: run gdb for your kernel
    "
    echo "example:
    build_run_os161.sh brw
    build and run your kernel but wait for gdb

    build_run_os161.sh d
    run gdb to connect your kernel in another terminal"
    exit
}

[ $# -eq 0 ] && help
[[ $@ == *h* ]] && help

if [[ $@ == *b* ]] then
    if [[ $@ == *v* ]] then
        target=GENERIC
    else
        target=DUMBVM
    fi
    if [[ $1 == *o* ]]
    then
        target=$target-OPT
    fi
    build ${target}
fi

cd ~/os161/root
if [[ $@ == *r* ]] then
    run $@
fi

if [[ $@ == *d* ]] then
    debug $@
fi
