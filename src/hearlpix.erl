% (The MIT License)

% Copyright (c) 2013 Nathan Aschbacher

% Permission is hereby granted, free of charge, to any person obtaining
% a copy of this software and associated documentation files (the
% 'Software'), to deal in the Software without restriction, including
% without limitation the rights to use, copy, modify, merge, publish,
% distribute, sublicense, and/or sell copies of the Software, and to
% permit persons to whom the Software is furnished to do so, subject to
% the following conditions:

% The above copyright notice and this permission notice shall be
% included in all copies or substantial portions of the Software.

% THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
% EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
% MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
% IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
% CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
% TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
% SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

-module(hearlpix).
-author('Nathan Aschbacher <nathan@basho.com>').

-export([new/2]).
-export([ring2z/2, pix2ring/2, nest2ring/2, ring2nest/2, nest2peano/2, peano2nest/2]).
-export([zphi2pix/3, latlng2pix/3, ang2pix/3, vec2pix/4, pix2zphi/2, pix2latlng/2, pix2ang/2, pix2vec/2]).
-export([query_disc/4, query_disc/5, query_disc_inclusive/5, query_disc_inclusive/6]).
-export([query_polygon/2, query_polygon_inclusive/3]).
-export([query_strip/3, query_strip_inclusive/3]).
-export([get_ring_info/2, get_ring_info2/2, get_ring_small/2]).
-export([neighbors/2, get_interpol/3, get_interpol/4]).
-export([get_order/1, get_nside/1, get_npix/1, get_scheme/1, conformable/2, max_pixrad/1, max_pixrad/2]).
-export([boundaries_as_vec/3, boundaries_as_ang/3, boundaries_as_latlng/3]).
-export([nside2order/1, npix2nside/1]).

-include("hearlpix.hrl").

-spec new(Order::integer(), Scheme::atom()) -> hearlpix_base() | error().
new(Order, Scheme) when Order >= 0, Order =< 29, Scheme == ring; Scheme == nest ->
    hearlpix_nif:new(Order, Scheme).


-spec ring2z(Base::hearlpix_base(), Ring::integer()) -> float() | error().
ring2z(Base, Ring) ->
    hearlpix_nif:ring2z(Base, Ring).

-spec pix2ring(Base::hearlpix_base(), Pix::integer()) -> integer() | error().
pix2ring(Base, Pix) ->
    hearlpix_nif:pix2ring(Base, Pix).

-spec nest2ring(Base::hearlpix_base(), Pix::integer()) -> integer() | error().
nest2ring(Base, Pix) ->
    hearlpix_nif:nest2ring(Base, Pix).

-spec ring2nest(Base::hearlpix_base(), Pix::integer()) -> integer() | error().
ring2nest(Base, Pix) ->
    hearlpix_nif:ring2nest(Base, Pix).

-spec nest2peano(Base::hearlpix_base(), Pix::integer()) -> integer() | error().
nest2peano(Base, Pix) ->
    hearlpix_nif:nest2peano(Base, Pix).

-spec peano2nest(Base::hearlpix_base(), Pix::integer()) -> integer() | error().
peano2nest(Base, Pix) ->
    hearlpix_nif:peano2nest(Base, Pix).



-spec zphi2pix(Base::hearlpix_base(), Z::float(), Phi::float()) -> integer() | error().
zphi2pix(Base, Z, Phi) ->
    hearlpix_nif:zphi2pix(Base, Z, Phi).

-spec latlng2pix(Base::hearlpix_base(), Latitude::float(), Longitude::float()) -> integer() | error().
latlng2pix(Base, Latitude, Longitude) ->
    hearlpix_nif:latlng2pix(Base, Latitude, Longitude).

-spec ang2pix(Base::hearlpix_base(), Theta::float(), Phi::float()) -> integer() | error().
ang2pix(Base, Theta, Phi) ->
    hearlpix_nif:ang2pix(Base, Theta, Phi).

-spec vec2pix(Base::hearlpix_base(), X::float(), Y::float(), Z::float()) -> integer() | error().
vec2pix(Base, X, Y, Z) ->
    hearlpix_nif:vec2pix(Base, X, Y, Z).


-spec pix2zphi(Base::hearlpix_base(), Pix::integer()) -> {Z::float(), Phi::float()} | error().
pix2zphi(Base, Pix) ->
    hearlpix_nif:pix2zphi(Base, Pix).

-spec pix2latlng(Base::hearlpix_base(), Pix::integer()) -> {Latitude::float(), Longitude::float()} | error().
pix2latlng(Base, Pix) ->
    hearlpix_nif:pix2latlng(Base, Pix).

-spec pix2ang(Base::hearlpix_base(), Pix::integer()) -> {Theta::float(), Phi::float()} | error().
pix2ang(Base, Pix) ->
    hearlpix_nif:pix2ang(Base, Pix).

-spec pix2vec(Base::hearlpix_base(), Pix::integer()) -> {X::float(), Y::float(), Z::float()} | error().
pix2vec(Base, Pix) ->
    hearlpix_nif:pix2vec(Base, Pix).


-spec query_disc(Base::hearlpix_base(), Theta::float(), Phi::float(), Radius::float()) -> pix_range() | error().           
query_disc(Base, Theta, Phi, Radius) ->
    hearlpix_nif:query_disc(Base, Theta, Phi, Radius).

-spec query_disc(Base::hearlpix_base(), X::float(), Y::float(), Z::float(), Radius::float()) -> pix_range() | error().
query_disc(Base, X, Y, Z, Radius) ->
    hearlpix_nif:query_disc(Base, X, Y, Z, Radius).

-spec query_disc_inclusive(Base::hearlpix_base(), Theta::float(), Phi::float(), Radius::float(), Fact::integer()) -> pix_range() | error().
query_disc_inclusive(Base, Theta, Phi, Radius, Fact) ->
    hearlpix_nif:query_disc_inclusive(Base, Theta, Phi, Radius, Fact).

-spec query_disc_inclusive(Base::hearlpix_base(), X::float(), Y::float(), Z::float(), Radius::float(), Fact::integer()) -> pix_range() | error().
query_disc_inclusive(Base, X, Y, Z, Radius, Fact) ->
    hearlpix_nif:query_disc_inclusive(Base, X, Y, Z, Radius, Fact).


-spec query_polygon(Base::hearlpix_base(), [{Theta::float(), Phi::float()}]) -> pix_range() | error();
                   (Base::hearlpix_base(), [{X::float(), Y::float(), Z::float()}]) -> pix_range() | error().
query_polygon(Base, Verticies) ->
    hearlpix_nif:query_polygon(Base, Verticies).

-spec query_polygon_inclusive(Base::hearlpix_base(), [{Theta::float(), Phi::float()}], Fact::integer()) -> pix_range() | error();
                             (Base::hearlpix_base(), [{X::float(), Y::float(), Z::float()}], Fact::integer()) -> pix_range() | error().
query_polygon_inclusive(Base, Vertices, Fact) ->
    hearlpix_nif:query_polygon_inclusive(Base, Vertices, Fact).


-spec query_strip(Base::hearlpix_base(), Theta1::float(), Theta2::float()) -> pix_range() | error().
query_strip(Base, Theta1, Theta2) ->
    hearlpix_nif:query_strip(Base, Theta1, Theta2).

-spec query_strip_inclusive(Base::hearlpix_base(), Theta1::float(), Theta2::float()) -> pix_range() | error().
query_strip_inclusive(Base, Theta1, Theta2) ->
    hearlpix_nif:query_strip_inclusive(Base, Theta1, Theta2).


-spec get_ring_info(Base::hearlpix_base(), Ring::integer()) -> {StartPix::integer(), RingPix::integer(), CosTheta::float(), SinTheta::float(), Shifted::boolean()} | error().
get_ring_info(Base, Ring) ->
    hearlpix_nif:get_ring_info(Base, Ring).

-spec get_ring_info2(Base::hearlpix_base(), Ring::integer()) -> {StartPix::integer(), RingPix::integer(), Theta::float(), Shifted::boolean()} | error().
get_ring_info2(Base, Ring) ->
    hearlpix_nif:get_ring_info2(Base, Ring).

-spec get_ring_small(Base::hearlpix_base(), Ring::integer()) -> {StartPix::integer(), RingPix::integer(), Shifted::boolean()} | error().
get_ring_small(Base, Ring) ->
    hearlpix_nif:get_ring_small(Base, Ring).


-spec neighbors(Base::hearlpix_base(), Pix::integer()) ->  
    {SW::integer(), W::integer(), NW::integer(), N::integer(), NE::integer(), E::integer(), SE::integer(), S::integer()} | error().
neighbors(Base, Pix) ->
    hearlpix_nif:neighbors(Base, Pix).


-spec get_interpol(Base::hearlpix_base(), Theta::float(), Phi::float()) -> [integer()] | error().
get_interpol(Base, Theta, Phi) ->
    hearlpix_nif:get_interpol(Base, Theta, Phi).

-spec get_interpol(Base::hearlpix_base(), X::float(), Y::float(), Z::float()) -> [integer()] | error().
get_interpol(Base, X, Y, Z) ->
    hearlpix_nif:get_interpol(Base, X, Y, Z).

-spec get_order(Base::hearlpix_base()) -> integer() | error().
get_order(Base) ->
    hearlpix_nif:get_order(Base).

-spec get_nside(Base::hearlpix_base()) -> integer() | error().
get_nside(Base) ->
    hearlpix_nif:get_nside(Base).

-spec get_npix(Base::hearlpix_base()) -> integer() | error().
get_npix(Base) ->
    hearlpix_nif:get_npix(Base).

-spec get_scheme(Base::hearlpix_base()) -> integer() | error().
get_scheme(Base) ->
    hearlpix_nif:get_scheme(Base).


-spec conformable(Base::hearlpix_base(), Base::hearlpix_base()) -> boolean() | error().
conformable(Base1, Base2) ->
    hearlpix_nif:conformable(Base1, Base2).


-spec max_pixrad(Base::hearlpix_base()) -> float() | error().
max_pixrad(Base) ->
    hearlpix_nif:max_pixrad(Base).

-spec max_pixrad(Base::hearlpix_base(), Ring::integer()) -> float() | error().
max_pixrad(Base, Ring) ->
    hearlpix_nif:max_pixrad(Base, Ring).

-spec boundaries_as_vec(Base::hearlpix_base(), Pix::integer(), Step::integer()) -> [integer()] | error().
boundaries_as_vec(Base, Pix, Step) ->
    hearlpix_nif:boundaries_as_vec(Base, Pix, Step).

-spec boundaries_as_ang(Base::hearlpix_base(), Pix::integer(), Step::integer()) -> [integer()] | error().
boundaries_as_ang(Base, Pix, Step) ->
    hearlpix_nif:boundaries_as_ang(Base, Pix, Step).

-spec boundaries_as_latlng(Base::hearlpix_base(), Pix::integer(), Step::integer()) -> [integer()] | error().
boundaries_as_latlng(Base, Pix, Step) ->
    hearlpix_nif:boundaries_as_latlng(Base, Pix, Step).

-spec nside2order(Nside::integer()) -> integer() | error().
nside2order(Nside) ->
    hearlpix_nif:nside2order(Nside).

-spec npix2nside(Npix::integer()) -> integer() | error().
npix2nside(Npix) ->
    hearlpix_nif:npix2nside(Npix).


