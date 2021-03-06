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

-module(hearlpix_nif).
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

-on_load(init/0).

-spec init() -> ok | error().
init() ->
    SoName = case code:priv_dir(?MODULE) of
                 {error, bad_name} ->
                     case code:which(?MODULE) of
                         Filename when is_list(Filename) ->
                             filename:join([filename:dirname(Filename),"../priv", "hearlpix_nif"]);
                         _ ->
                             filename:join("../priv", "hearlpix_nif")
                     end;
                 Dir ->
                     filename:join(Dir, "hearlpix_nif")
             end,
    erlang:load_nif(SoName, 0).


-spec new(Order::integer(), Scheme::atom()) -> hearlpix_base() | error().
new(Order, Scheme) ->
    erlang:nif_error({error, not_loaded}).


-spec ring2z(Base::hearlpix_base(), Ring::integer()) -> float() | error().
ring2z(Base, Ring) ->
    erlang:nif_error({error, not_loaded}).

-spec pix2ring(Base::hearlpix_base(), Pix::integer()) -> integer() | error().
pix2ring(Base, Pix) ->
    erlang:nif_error({error, not_loaded}).

-spec nest2ring(Base::hearlpix_base(), Pix::integer()) -> integer() | error().
nest2ring(Base, Pix) ->
    erlang:nif_error({error, not_loaded}).

-spec ring2nest(Base::hearlpix_base(), Pix::integer()) -> integer() | error().
ring2nest(Base, Pix) ->
    erlang:nif_error({error, not_loaded}).

-spec nest2peano(Base::hearlpix_base(), Pix::integer()) -> integer() | error().
nest2peano(Base, Pix) ->
    erlang:nif_error({error, not_loaded}).

-spec peano2nest(Base::hearlpix_base(), Pix::integer()) -> integer() | error().
peano2nest(Base, Pix) ->
    erlang:nif_error({error, not_loaded}).



-spec zphi2pix(Base::hearlpix_base(), Z::float(), Phi::float()) -> integer() | error().
zphi2pix(Base, Z, Phi) ->
    erlang:nif_error({error, not_loaded}).

-spec latlng2pix(Base::hearlpix_base(), Latitude::float(), Longitude::float()) -> integer() | error().
latlng2pix(Base, Latitude, Longitude) ->
    erlang:nif_error({error, not_loaded}).

-spec ang2pix(Base::hearlpix_base(), Theta::float(), Phi::float()) -> integer() | error().
ang2pix(Base, Theta, Phi) ->
    erlang:nif_error({error, not_loaded}).

-spec vec2pix(Base::hearlpix_base(), X::float(), Y::float(), Z::float()) -> integer() | error().
vec2pix(Base, X, Y, Z) ->
    erlang:nif_error({error, not_loaded}).


-spec pix2zphi(Base::hearlpix_base(), Pix::integer()) -> {Z::float(), Phi::float()} | error().
pix2zphi(Base, Pix) ->
    erlang:nif_error({error, not_loaded}).

-spec pix2latlng(Base::hearlpix_base(), Pix::integer()) -> {Latitude::float(), Longitude::float()} | error().
pix2latlng(Base, Pix) ->
    erlang:nif_error({error, not_loaded}).

-spec pix2ang(Base::hearlpix_base(), Pix::integer()) -> {Theta::float(), Phi::float()} | error().
pix2ang(Base, Pix) ->
    erlang:nif_error({error, not_loaded}).

-spec pix2vec(Base::hearlpix_base(), Pix::integer()) -> {X::float(), Y::float(), Z::float()} | error().
pix2vec(Base, Pix) ->
    erlang:nif_error({error, not_loaded}).


-spec query_disc(Base::hearlpix_base(), Theta::float(), Phi::float(), Radius::float()) -> pix_range() | error().           
query_disc(Base, Theta, Phi, Radius) ->
    erlang:nif_error({error, not_loaded}).

-spec query_disc(Base::hearlpix_base(), X::float(), Y::float(), Z::float(), Radius::float()) -> pix_range() | error().
query_disc(Base, X, Y, Z, Radius) ->
    erlang:nif_error({error, not_loaded}).

-spec query_disc_inclusive(Base::hearlpix_base(), Theta::float(), Phi::float(), Radius::float(), Fact::integer()) -> pix_range() | error().
query_disc_inclusive(Base, Theta, Phi, Radius, Fact) ->
    erlang:nif_error({error, not_loaded}).

-spec query_disc_inclusive(Base::hearlpix_base(), X::float(), Y::float(), Z::float(), Radius::float(), Fact::integer()) -> pix_range() | error().
query_disc_inclusive(Base, X, Y, Z, Radius, Fact) ->
    erlang:nif_error({error, not_loaded}).


-spec query_polygon(Base::hearlpix_base(), [{Theta::float(), Phi::float()}]) -> pix_range() | error();
                   (Base::hearlpix_base(), [{X::float(), Y::float(), Z::float()}]) -> pix_range() | error().
query_polygon(Base, Verticies) ->
    erlang:nif_error({error, not_loaded}).

-spec query_polygon_inclusive(Base::hearlpix_base(), [{Theta::float(), Phi::float()}], Fact::integer()) -> pix_range() | error();
                             (Base::hearlpix_base(), [{X::float(), Y::float(), Z::float()}], Fact::integer()) -> pix_range() | error().
query_polygon_inclusive(Base, Vertices, Fact) ->
    erlang:nif_error({error, not_loaded}).


-spec query_strip(Base::hearlpix_base(), Theta1::float(), Theta2::float()) -> pix_range() | error().
query_strip(Base, Theta1, Theta2) ->
    erlang:nif_error({error, not_loaded}).

-spec query_strip_inclusive(Base::hearlpix_base(), Theta1::float(), Theta2::float()) -> pix_range() | error().
query_strip_inclusive(Base, Theta1, Theta2) ->
    erlang:nif_error({error, not_loaded}).


-spec get_ring_info(Base::hearlpix_base(), Ring::integer()) -> {StartPix::integer(), RingPix::integer(), CosTheta::float(), SinTheta::float(), Shifted::boolean()} | error().
get_ring_info(Base, Ring) ->
    erlang:nif_error({error, not_loaded}).

-spec get_ring_info2(Base::hearlpix_base(), Ring::integer()) -> {StartPix::integer(), RingPix::integer(), Theta::float(), Shifted::boolean()} | error().
get_ring_info2(Base, Ring) ->
    erlang:nif_error({error, not_loaded}).

-spec get_ring_small(Base::hearlpix_base(), Ring::integer()) -> {StartPix::integer(), RingPix::integer(), Shifted::boolean()} | error().
get_ring_small(Base, Ring) ->
    erlang:nif_error({error, not_loaded}).


-spec neighbors(Base::hearlpix_base(), Pix::integer()) ->  
    {SW::integer(), W::integer(), NW::integer(), N::integer(), NE::integer(), E::integer(), SE::integer(), S::integer()} | error().
neighbors(Base, Pix) ->
    erlang:nif_error({error, not_loaded}).


-spec get_interpol(Base::hearlpix_base(), Theta::float(), Phi::float()) -> [integer()] | error().
get_interpol(Base, Theta, Phi) ->
    erlang:nif_error({error, not_loaded}).

-spec get_interpol(Base::hearlpix_base(), X::float(), Y::float(), Z::float()) -> [integer()] | error().
get_interpol(Base, X, Y, Z) ->
    erlang:nif_error({error, not_loaded}).

-spec get_order(Base::hearlpix_base()) -> integer() | error().
get_order(Base) ->
    erlang:nif_error({error, not_loaded}).

-spec get_nside(Base::hearlpix_base()) -> integer() | error().
get_nside(Base) ->
    erlang:nif_error({error, not_loaded}).

-spec get_npix(Base::hearlpix_base()) -> integer() | error().
get_npix(Base) ->
    erlang:nif_error({error, not_loaded}).

-spec get_scheme(Base::hearlpix_base()) -> integer() | error().
get_scheme(Base) ->
    erlang:nif_error({error, not_loaded}).


-spec conformable(Base::hearlpix_base(), Base::hearlpix_base()) -> boolean() | error().
conformable(Base1, Base2) ->
    erlang:nif_error({error, not_loaded}).


-spec max_pixrad(Base::hearlpix_base()) -> float() | error().
max_pixrad(Base) ->
    erlang:nif_error({error, not_loaded}).

-spec max_pixrad(Base::hearlpix_base(), Ring::integer()) -> float() | error().
max_pixrad(Base, Ring) ->
    erlang:nif_error({error, not_loaded}).

-spec boundaries_as_vec(Base::hearlpix_base(), Pix::integer(), Step::integer()) -> [integer()] | error().
boundaries_as_vec(Base, Pix, Step) ->
    erlang:nif_error({error, not_loaded}).

-spec boundaries_as_ang(Base::hearlpix_base(), Pix::integer(), Step::integer()) -> [integer()] | error().
boundaries_as_ang(Base, Pix, Step) ->
    erlang:nif_error({error, not_loaded}).

-spec boundaries_as_latlng(Base::hearlpix_base(), Pix::integer(), Step::integer()) -> [integer()] | error().
boundaries_as_latlng(Base, Pix, Step) ->
    erlang:nif_error({error, not_loaded}).

-spec nside2order(Nside::integer()) -> integer() | error().
nside2order(Nside) ->
    erlang:nif_error({error, not_loaded}).

-spec npix2nside(Npix::integer()) -> integer() | error().
npix2nside(Npix) ->
    erlang:nif_error({error, not_loaded}).

