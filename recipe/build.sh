# Disabling tests requiring incoming connection
sed -i '/udp_multicast_join/d' ./test/test-list.h
sed -i '/udp_multicast_join6/d' ./test/test-list.h

# This particular test intermittently fails on osx
if [ "${target_platform}" == 'osx-64' ]; then
   # see https://github.com/libuv/libuv/issues/3862
   sed -i '/fs_read_bufs/d' ./test/test-list.h
   sed -i '/fs_event_error_reporting/d' ./test/test-list.h
   sed -i '/fs_event_watch_dir/d' ./test/test-list.h
   sed -i '/fs_event_watch_dir_recursive/d' ./test/test-list.h
   sed -i '/fs_event_close_in_callback/d' ./test/test-list.h
fi

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
