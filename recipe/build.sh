# Disabling tests requiring incoming connection
sed -i '/udp_multicast_join/d' ./test/test-list.h
sed -i '/udp_multicast_join6/d' ./test/test-list.h

# LIBTOOLIZE setting is required to workaround missing glibtoolize on OS X:
# https://github.com/joyent/libuv/issues/1200
LIBTOOLIZE=libtoolize sh ./autogen.sh
export UV_RUN_AS_ROOT=1

./configure \
   --disable-dependency-tracking \
   --disable-silent-rules \
   --prefix="$PREFIX" \

make
make check
make install
