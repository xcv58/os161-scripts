PWD=$(shell pwd)
BINDIR=/usr/local/bin
SYS161DIR=~/os161/root
GDBINIT=~

default:
	ln -fs ${PWD}/build_run_os161.sh ${BINDIR}/a
	ln -fs ${PWD}/.gdbinit ${GDBINIT}/.gdbinit

rm:remove
clean:remove
uninstall:remove
remove:
	rm ${BINDIR}/a
	rm ${SYS161DIR}/.gdbinit
