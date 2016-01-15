TARGET=~/.os161-scripts
[[ $# > 0 ]] && TARGET=$*
git clone https://github.com/xcv58/os161-scripts.git ${TARGET}
cd ${TARGET}
make
