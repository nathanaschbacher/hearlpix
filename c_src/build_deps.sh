#!/bin/sh

set -e

ROOT="$PWD"

# detecting gmake and if exists use it
# if not use make
# (code from github.com/tuncer/re2/c_src/build_deps.sh
which gmake 1>/dev/null 2>/dev/null && MAKE=gmake
MAKE=${MAKE:-make}

# Changed "make" to $MAKE

case "$1" in
    clean)
        rm -rf $ROOT/c_src/cfitsio/*.o
		rm -rf $ROOT/c_src/healpix/src/cxx/build.auto
        ;;

    *)
		export CFLAGS="$CFLAGS -arch x86_64 -m64 -Wall -O3 -fPIC -I $ROOT/priv/cfitsio/include -I $ROOT/priv/healpix_cxx/include -L $ROOT/priv/cfitsio/lib/ -L $ROOT/priv/healpix_cxx/lib/"
        export CXXFLAGS="$CXXFLAGS -arch x86_64 -m64 -Wall -O3 -fPIC -I $ROOT/priv/cfitsio/include -I $ROOT/priv/healpix_cxx/include -L $ROOT/priv/cfitsio/lib/ -L $ROOT/priv/healpix_cxx/lib/"
        export LDFLAGS="$LDFLAGS -L $ROOT/priv/cfitsio/lib/ -L $ROOT/priv/healpix_cxx/lib/ -lhealpix_cxx -lcxxsupport -lstdc++"

        #build and install cfitsio lib to ./priv/cfitsio
		cd $ROOT/c_src/cfitsio && LDFLAGS="-arch x86_64" CFLAGS="-arch x86_64 -Wall -O3 -fPIC" CXXFLAGS="-arch x86_64 -Wall -O3 -fPIC" ./configure && make && make install
		mkdir -p $ROOT/priv/cfitsio
		mv $ROOT/c_src/cfitsio/include $ROOT/priv/cfitsio/include
		mv $ROOT/c_src/cfitsio/lib $ROOT/priv/cfitsio/lib

		#build and install healpix C++ lib to ./priv/healpix_cxx
		cd $ROOT/c_src/healpix/src/cxx && LDFLAGS="-arch x86_64" CFLAGS="-arch x86_64 -Wall -O3 -fPIC" CXXFLAGS="-arch x86_64 -Wall -O3 -fPIC" ./configure --with-libcfitsio=$ROOT/priv/cfitsio/ && make
		mkdir -p $ROOT/priv/healpix_cxx
		mv $ROOT/c_src/healpix/src/cxx/auto/* $ROOT/priv/healpix_cxx/
		
		cd $ROOT
        ;;
esac
