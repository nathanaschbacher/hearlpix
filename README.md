## Overview

Erlang HEALPix library wrapping the HEALPix C++ implementation (sans FITSIO).


## Installation

**Pre-requisites:** You must already have Erlang R14B04 or later installed on your machine.

	$ git clone git@github.com:nathanaschbacher/hearlpix.git .
	$ cd hearlpix
	$ ./rebar compile
	
This should automatically build the `cfitsio` and `healpix_cxx` dependencies and move the headers, libraries, and binaries to the `priv/` directory.

## Usage

    $ erl -pa ebin/
    
    Eshell V5.9.1  (abort with ^G)
    1> {ok, H} = hearlpix:new(12, nest).
    {ok,<<>>}
    2> hearlpix:get_scheme(H).
    nest
    3> hearlpix:pix2ang(H, 23).
    {1.5693314825210272,0.7865486489883625}


## License

(The MIT License)

Copyright (c) 2013 Nathan Aschbacher

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.