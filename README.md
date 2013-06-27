## Overview

Erlang HEALPix library wrapping the HEALPix C++ implementation (sans FITSIO).

__NOTE:__ This is currently not working properly.  The shared resource for the `T_Healpix_Base<I>` instance isn't being properly maintained across the barrier between Erlang and C

## Installation

**Pre-requisites:** You must already have Erlang R14B04 or later installed on your machine.

	$ git clone git@github.com:nathanaschbacher/hearlpix.git .
	$ cd hearlpix
	$ make
	
This should automatically build the `cfitsio` and `healpix_cxx` dependencies and move the headers, libraries, and binaries to the `priv/` directory.

## Usage

    $ erl -pa ebin/
    
    Eshell V5.9.1  (abort with ^G)
    1> {ok, H} = hearlpix:new(12, nest).
    {ok,<<>>}
    2> hearlpix:get_scheme(H).
    nest
    
Except the above isn't what happens.  Instead the result of #2 will be `{error,"Scheme not set."}`.  Need to get this sorted out.

I know it's related to how I'm handling the `enif_alloc_resource` `enif_make_resource` and `enif_get_resource`, but I can't isolate what exactly.


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