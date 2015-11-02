#!/bin/bash
BASENAME=$(dirname $0)

if [ -z "$RTE_SDK" ]; then
    echo "DPDK path not set!"
    exit 1
fi

CFLAGS="" CXXFLAGS=$CFLAGS \
./configure --with-dpdk-dir=$RTE_SDK --enable-sse4.2=yes \
CC="gcc" \
--enable-shared \
--disable-static
make clean && make -j || make -j || make

# sanity check
export LD_LIBRARY_PATH=$RTE_SDK/$RTE_TARGET/lib:$BASENAME/src/agent/.libs/:$BASENAME/src/datastore/.libs:$BASENAME/src/lib/.libs:$BASENAME/src/dataplane/.libs
$BASENAME/src/cmds/lagopus --version && echo "Build successed."