ROOT=$(CURDIR)

all:
	#clean out ./priv
	rm -rf $(ROOT)/priv/*
	
	#build and install cfitsio lib to ./priv/cfitsio
	cd $(ROOT)/c_src/cfitsio && LDFLAGS="-arch x86_64" CFLAGS="-arch x86_64 -Wall -O3 -fPIC" CXXFLAGS="-arch x86_64 -Wall -O3 -fPIC" ./configure && make && make install
	mkdir -p $(ROOT)/priv/cfitsio
	mv $(ROOT)/c_src/cfitsio/include $(ROOT)/priv/cfitsio/include
	mv $(ROOT)/c_src/cfitsio/lib $(ROOT)/priv/cfitsio/lib

	#build and install healpix C++ lib to ./priv/healpix_cxx
	cd $(ROOT)/c_src/healpix/src/cxx && LDFLAGS="-arch x86_64" CFLAGS="-arch x86_64 -Wall -O3 -fPIC" CXXFLAGS="-arch x86_64 -Wall -O3 -fPIC" ./configure --with-libcfitsio=$(ROOT)/priv/cfitsio/ && make
	mkdir -p $(ROOT)/priv/healpix_cxx
	mv $(ROOT)/c_src/healpix/src/cxx/auto/* $(ROOT)/priv/healpix_cxx/
	
	cd $(ROOT)
	./rebar get-deps compile

clean:
	rm -rf $(ROOT)/c_src/cfitsio/*.o
	rm -rf $(ROOT)/c_src/healpix/src/cxx/build.auto
	rm -rf $(ROOT)/priv/*