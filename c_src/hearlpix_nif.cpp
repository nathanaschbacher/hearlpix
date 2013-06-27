#include <vector>
#include "erl_nif.h"
#include "hearlpix_nif.h"
#include "healpix_base.h"

typedef int64 I;

static ErlNifResourceType* HEALPIX_BASE_RESOURCE;

typedef struct 
{
    T_Healpix_Base<I>* base;
} healpix_handle;

namespace hearlpix {
	ERL_NIF_TERM ATOM_OK;
	ERL_NIF_TERM ATOM_ERROR;
	ERL_NIF_TERM ATOM_BADARG;
	ERL_NIF_TERM ATOM_TRUE;
	ERL_NIF_TERM ATOM_FALSE;

	static ERL_NIF_TERM new_base (ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) 
	{
		I order;
		Healpix_Ordering_Scheme scheme;
		unsigned len;
		char scheme_atom[MAX_ATOM_LENGTH];

		if(enif_get_int64(env, argv[0], &order) && enif_get_atom_length(env, argv[1], &len, ERL_NIF_LATIN1) && enif_get_atom(env, argv[1], (char *)&scheme_atom, len+1, ERL_NIF_LATIN1))
		{
			if(!strcmp(scheme_atom, "ring")) 
			{
				scheme = RING;
			}
			else if(!strcmp(scheme_atom, "nest"))
			{
				scheme = NEST;
			}
			else
			{
				return enif_make_tuple2(env, hearlpix::ATOM_ERROR, enif_make_string(env, "Invalid scheme argument", ERL_NIF_LATIN1));
			}

			healpix_handle* handle = (healpix_handle*)enif_alloc_resource(HEALPIX_BASE_RESOURCE, sizeof(healpix_handle)); 

	        T_Healpix_Base<I> hp_base(order, scheme);
	        handle->base = &hp_base;
	        
	        ERL_NIF_TERM result = enif_make_resource(env, handle);
	        enif_release_resource(handle);
	        
	        return enif_make_tuple2(env, hearlpix::ATOM_OK, result);
		}
		else
		{
			return enif_make_badarg(env);
		}
	};


	static ERL_NIF_TERM ring2z (ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) 
	{
		healpix_handle* hpx;
		I ring;

		if(enif_get_resource(env, argv[0], HEALPIX_BASE_RESOURCE, (void**)&hpx) && enif_get_int64(env, argv[1], &ring)) 
		{
			return enif_make_double(env, hpx->base->ring2z(ring));
		}
		else 
		{
			return enif_make_badarg(env);
		}
	};

	static ERL_NIF_TERM pix2ring (ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) 
	{
		healpix_handle* hpx;
		I pix;

		if(enif_get_resource(env, argv[0], HEALPIX_BASE_RESOURCE, (void**)&hpx) && enif_get_int64(env, argv[1], &pix)) 
		{
			return enif_make_int64(env, hpx->base->pix2ring(pix));
		}
		else 
		{
			return enif_make_badarg(env);
		}
	};

	static ERL_NIF_TERM nest2ring (ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) 
	{
		healpix_handle* hpx;
		I pix;

		if(enif_get_resource(env, argv[0], HEALPIX_BASE_RESOURCE, (void**)&hpx) && enif_get_int64(env, argv[1], &pix)) 
		{
			return enif_make_int64(env, hpx->base->nest2ring(pix));
		}
		else 
		{
			return enif_make_badarg(env);
		}
	};

	static ERL_NIF_TERM ring2nest (ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) 
	{
		healpix_handle* hpx;
		I pix;

		if(enif_get_resource(env, argv[0], HEALPIX_BASE_RESOURCE, (void**)&hpx) && enif_get_int64(env, argv[1], &pix)) 
		{
			return enif_make_int64(env, hpx->base->ring2nest(pix));
		}
		else 
		{
			return enif_make_badarg(env);
		}
	};

	static ERL_NIF_TERM nest2peano (ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) 
	{
		healpix_handle* hpx;
		I pix;

		if(enif_get_resource(env, argv[0], HEALPIX_BASE_RESOURCE, (void**)&hpx) && enif_get_int64(env, argv[1], &pix)) 
		{
			return enif_make_int64(env, hpx->base->nest2peano(pix));
		}
		else 
		{
			return enif_make_badarg(env);
		}
	};

	static ERL_NIF_TERM peano2nest (ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) 
	{
		healpix_handle* hpx;
		I pix;

		if(enif_get_resource(env, argv[0], HEALPIX_BASE_RESOURCE, (void**)&hpx) && enif_get_int64(env, argv[1], &pix)) 
		{
			return enif_make_int64(env, hpx->base->peano2nest(pix));
		}
		else 
		{
			return enif_make_badarg(env);
		}
	};

	static ERL_NIF_TERM zphi2pix (ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) 
	{
		healpix_handle* hpx;
		double z;
		double phi;

		if(enif_get_resource(env, argv[0], HEALPIX_BASE_RESOURCE, (void**)&hpx) 
		&& enif_get_double(env, argv[1], &z)
		&& enif_get_double(env, argv[2], &phi)) 
		{
			return enif_make_int64(env, hpx->base->zphi2pix(z, phi));
		}
		else 
		{
			return enif_make_badarg(env);
		}
	};

	static ERL_NIF_TERM ang2pix (ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) 
	{
		healpix_handle* hpx;
		double theta;
		double phi;

		if(enif_get_resource(env, argv[0], HEALPIX_BASE_RESOURCE, (void**)&hpx) 
		&& enif_get_double(env, argv[1], &theta)
		&& enif_get_double(env, argv[2], &phi)) 
		{
			pointing ptg = pointing(theta, phi);

			return enif_make_int64(env, hpx->base->ang2pix(ptg));
		}
		else 
		{
			return enif_make_badarg(env);
		}
	};

	static ERL_NIF_TERM vec2pix (ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) 
	{
		healpix_handle* hpx;
		double x;
		double y;
		double z;

		if(enif_get_resource(env, argv[0], HEALPIX_BASE_RESOURCE, (void**)&hpx) 
		&& enif_get_double(env, argv[1], &x)
		&& enif_get_double(env, argv[2], &y)
		&& enif_get_double(env, argv[3], &z)) 
		{
			vec3 v = vec3(x,y,z);

			return enif_make_int64(env, hpx->base->vec2pix(v));
		}
		else 
		{
			return enif_make_badarg(env);
		}
	};


	static ERL_NIF_TERM pix2zphi (ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) {
		healpix_handle* hpx;
		I pix;
		
		if(enif_get_resource(env, argv[0], HEALPIX_BASE_RESOURCE, (void**)&hpx) && enif_get_int64(env, argv[1], &pix)) 
		{
			double z;
			double phi;

			hpx->base->pix2zphi(pix, z, phi);

			return enif_make_tuple2(env, enif_make_double(env, z), enif_make_double(env, phi));
		}
		else 
		{
			return enif_make_badarg(env);
		}
	};

	static ERL_NIF_TERM pix2ang (ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) 
	{
		healpix_handle* hpx;
		I pix;
		
		if(enif_get_resource(env, argv[0], HEALPIX_BASE_RESOURCE, (void**)&hpx) && enif_get_int64(env, argv[1], &pix)) 
		{
			pointing ptg;
			
			ptg = hpx->base->pix2ang(pix);

			return enif_make_tuple2(env, enif_make_double(env, ptg.theta), enif_make_double(env, ptg.phi));
		}
		else 
		{
			return enif_make_badarg(env);
		}
	};

	static ERL_NIF_TERM pix2vec (ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) 
	{
		healpix_handle* hpx;
		I pix;
		
		if(enif_get_resource(env, argv[0], HEALPIX_BASE_RESOURCE, (void**)&hpx) && enif_get_int64(env, argv[1], &pix)) 
		{
			vec3 v;
			v = hpx->base->pix2vec(pix);

			return enif_make_tuple3(env, enif_make_double(env, v.x), enif_make_double(env, v.y), enif_make_double(env, v.z));
		}
		else 
		{
			return enif_make_badarg(env);
		}
	};

	static ERL_NIF_TERM query_disc (ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) 
	{
		healpix_handle* hpx;
		pointing ptg;
		double radius;
		rangeset<I> pixset;

		if(argc == 4) { // Handle Theta, Phi pointing angle
			double theta; // argv[1]
			double phi; // argv[2]

			if(enif_get_resource(env, argv[0], HEALPIX_BASE_RESOURCE, (void**)&hpx)
			&& enif_get_double(env, argv[1], &theta)
			&& enif_get_double(env, argv[2], &phi)
			&& enif_get_double(env, argv[3], &radius))
			{
				ptg = pointing(theta, phi);
			}
			else
			{
				return enif_make_badarg(env);
			}
		}
		else if(argc == 5) { // Handle X, Y, Z vector angle
			double x; // argv[1]
			double y; // argv[2]
			double z; // argv[3]

			if(enif_get_resource(env, argv[0], HEALPIX_BASE_RESOURCE, (void**)&hpx)
			&& enif_get_double(env, argv[1], &x)
			&& enif_get_double(env, argv[2], &y)
			&& enif_get_double(env, argv[3], &z)
			&& enif_get_double(env, argv[4], &radius))
			{
				vec3_t<double> v(x,y,z);
				ptg = pointing(v);

			}
			else
			{
				return enif_make_badarg(env);
			}
		}
		else {
			return enif_make_badarg(env);
		}

		std::vector<I> pixels;
		std::vector<ERL_NIF_TERM> terms;

		hpx->base->query_disc(ptg, radius, pixset);
		pixset.toVector(pixels);

		terms.reserve(pixels.size()); 

		for(unsigned i=0; i < pixels.size(); i++) {
			terms.push_back(enif_make_int64(env, pixels[i]));
		}

		return enif_make_list_from_array(env, &terms[0], terms.size());
	};

	static ERL_NIF_TERM query_disc_inclusive (ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) 
	{
		healpix_handle* hpx;
		pointing ptg;
		double radius;
		int fact;
		rangeset<I> pixset;

		if(argc == 4) { // Handle Theta, Phi pointing angle
			double theta; // argv[1]
			double phi; // argv[2]

			if(enif_get_resource(env, argv[0], HEALPIX_BASE_RESOURCE, (void**)&hpx)
			&& enif_get_double(env, argv[1], &theta)
			&& enif_get_double(env, argv[2], &phi)
			&& enif_get_double(env, argv[3], &radius)
			&& enif_get_int(env, argv[4], &fact))
			{
				ptg = pointing(theta, phi);
			}
			else
			{
				return enif_make_badarg(env);
			}
		}
		else if(argc == 5) { // Handle X, Y, Z vector angle
			double x; // argv[1]
			double y; // argv[2]
			double z; // argv[3]

			if(enif_get_resource(env, argv[0], HEALPIX_BASE_RESOURCE, (void**)&hpx)
			&& enif_get_double(env, argv[1], &x)
			&& enif_get_double(env, argv[2], &y)
			&& enif_get_double(env, argv[3], &z)
			&& enif_get_double(env, argv[4], &radius)
			&& enif_get_int(env, argv[5], &fact))
			{
				vec3_t<double> v(x,y,z);
				ptg = pointing(v);
			}
			else
			{
				return enif_make_badarg(env);
			}
		}
		else {
			return enif_make_badarg(env);
		}

		std::vector<I> pixels;
		std::vector<ERL_NIF_TERM> terms;

		hpx->base->query_disc_inclusive(ptg, radius, pixset, fact);
		pixset.toVector(pixels);

		terms.reserve(pixels.size()); 

		for(unsigned i=0; i < pixels.size(); i++) {
			terms.push_back(enif_make_int64(env, pixels[i]));
		}

		return enif_make_list_from_array(env, &terms[0], terms.size());
	};

	static ERL_NIF_TERM query_polygon (ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) 
	{
		return enif_make_tuple1(env, hearlpix::ATOM_ERROR);
	};

	static ERL_NIF_TERM query_polygon_inclusive (ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) 
	{
		return enif_make_tuple1(env, hearlpix::ATOM_ERROR);
	};

	static ERL_NIF_TERM query_strip (ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) 
	{
		return enif_make_tuple1(env, hearlpix::ATOM_ERROR);
	};

	static ERL_NIF_TERM query_strip_inclusive (ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) 
	{
		return enif_make_tuple1(env, hearlpix::ATOM_ERROR);
	};

	static ERL_NIF_TERM get_ring_info (ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) 
	{
		return enif_make_tuple1(env, hearlpix::ATOM_ERROR);
	};

	static ERL_NIF_TERM get_ring_info2 (ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) 
	{
		return enif_make_tuple1(env, hearlpix::ATOM_ERROR);
	};

	static ERL_NIF_TERM get_ring_small (ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) 
	{
		return enif_make_tuple1(env, hearlpix::ATOM_ERROR);
	};

	static ERL_NIF_TERM neighbors (ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) 
	{
		healpix_handle* hpx;
		I pix;

		if(enif_get_resource(env, argv[0], HEALPIX_BASE_RESOURCE, (void**)&hpx) && enif_get_int64(env, argv[1], &pix)) 
		{
			fix_arr<I,8> neighbors_arr;

			hpx->base->neighbors(pix, neighbors_arr);

			return enif_make_tuple8(env, 
				enif_make_int64(env, neighbors_arr[0]),
				enif_make_int64(env, neighbors_arr[1]),
				enif_make_int64(env, neighbors_arr[2]),
				enif_make_int64(env, neighbors_arr[3]),
				enif_make_int64(env, neighbors_arr[4]),
				enif_make_int64(env, neighbors_arr[5]),
				enif_make_int64(env, neighbors_arr[6]),
				enif_make_int64(env, neighbors_arr[7])
			);
		}
		else 
		{
			return enif_make_badarg(env);
		}
	};

	static ERL_NIF_TERM get_interpol (ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) 
	{
		return enif_make_tuple1(env, hearlpix::ATOM_ERROR);
	};

	static ERL_NIF_TERM get_order (ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) 
	{
		healpix_handle* hpx;

		if(enif_get_resource(env, argv[0], HEALPIX_BASE_RESOURCE, (void**)&hpx)) 
		{
			return enif_make_int(env, hpx->base->Order());
		}
		else 
		{
			return enif_make_badarg(env);
		}
	};

	static ERL_NIF_TERM get_nside (ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) 
	{
		healpix_handle* hpx;

		if(enif_get_resource(env, argv[0], HEALPIX_BASE_RESOURCE, (void**)&hpx)) 
		{
			return enif_make_int64(env, hpx->base->Nside());
		}
		else 
		{
			return enif_make_badarg(env);
		}
	};

	static ERL_NIF_TERM get_npix (ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) 
	{
		healpix_handle* hpx;

		if(enif_get_resource(env, argv[0], HEALPIX_BASE_RESOURCE, (void**)&hpx)) 
		{
			return enif_make_int64(env, hpx->base->Npix());
		}
		else 
		{
			return enif_make_badarg(env);
		}
	};

	static ERL_NIF_TERM get_scheme (ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) 
	{
		healpix_handle* hpx;

		if(enif_get_resource(env, argv[0], HEALPIX_BASE_RESOURCE, (void**)&hpx)) 
		{
			if(hpx->base->Scheme() == RING)
			{
				return enif_make_atom(env, "ring\0");
			}
			else if(hpx->base->Scheme() == NEST)
			{
				return enif_make_atom(env, "nest\0");
			}
			else
			{
				return enif_make_tuple2(env, hearlpix::ATOM_ERROR, enif_make_string(env, "Scheme not set.", ERL_NIF_LATIN1));
			}
		}
		else 
		{
			return enif_make_badarg(env);
		}
	};

	static ERL_NIF_TERM conformable (ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) 
	{
		return enif_make_tuple1(env, hearlpix::ATOM_ERROR);
	};

	static ERL_NIF_TERM max_pixrad (ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) 
	{
		healpix_handle* hpx;

		if(argc == 1) 
		{
			if(enif_get_resource(env, argv[0], HEALPIX_BASE_RESOURCE, (void**)&hpx))
			{
				return enif_make_double(env, hpx->base->max_pixrad());
			}
			else
			{
				return enif_make_badarg(env);
			}
		}
		else if(argc == 2)
		{
			I ring;
			if(enif_get_resource(env, argv[0], HEALPIX_BASE_RESOURCE, (void**)&hpx) && enif_get_int64(env, argv[1], &ring))
			{			
				return enif_make_double(env, hpx->base->max_pixrad(ring));
			}
			else
			{
				return enif_make_badarg(env);
			}
		}
		else {
			return enif_make_badarg(env);
		}
	};

	static ERL_NIF_TERM boundaries (ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[])
	{
		return enif_make_tuple1(env, hearlpix::ATOM_ERROR);
	};

	static ERL_NIF_TERM nside2order (ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) 
	{
		I nside;

		if(enif_get_long(env, argv[0], &nside)) 
		{
			int order = T_Healpix_Base<I>::nside2order(nside);
			return enif_make_tuple2(env, hearlpix::ATOM_OK, enif_make_int(env, order));
		}
		else 
		{
			return enif_make_badarg(env);
		}
	};

	static ERL_NIF_TERM npix2nside (ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) 
	{
		I npix; 

		if(enif_get_long(env, argv[0], &npix)) 
		{
			I nside = T_Healpix_Base<I>::npix2nside(npix);
			return enif_make_tuple2(env, hearlpix::ATOM_OK, enif_make_int64(env, nside));
		}
		else 
		{
			return enif_make_badarg(env);
		}
	};

	static ErlNifFunc nif_funcs[] = 
	{
		{"new", 2, hearlpix::new_base},
	    
	    {"ring2z", 2, hearlpix::ring2z},
	    {"pix2ring", 2, hearlpix::pix2ring},
	    {"nest2ring", 2, hearlpix::nest2ring},
	    {"ring2nest", 2, hearlpix::ring2nest},
	    {"nest2peano", 2, hearlpix::nest2peano},
	    {"peano2nest", 2, hearlpix::peano2nest},
	    
	    {"zphi2pix", 3, hearlpix::zphi2pix},
	    {"ang2pix", 3, hearlpix::ang2pix},
	    {"vec2pix", 4, hearlpix::vec2pix},
	    
	    {"pix2zphi", 2, hearlpix::pix2zphi},
	    {"pix2ang", 2, hearlpix::pix2ang},
	    {"pix2vec", 2, hearlpix::pix2vec},
	    
	    {"query_disc", 4, hearlpix::query_disc},
	    {"query_disc", 5, hearlpix::query_disc},
	    {"query_disc_inclusive", 5, hearlpix::query_disc},
	    {"query_disc_inclusive", 6, hearlpix::query_disc_inclusive},
	    {"query_polygon", 2, hearlpix::query_polygon},
	    {"query_polygon_inclusive", 3, hearlpix::query_polygon_inclusive},
	    {"query_strip", 3, hearlpix::query_strip},
	    {"query_strip_inclusive", 3, hearlpix::query_strip_inclusive},

	    {"get_ring_info", 2, hearlpix::get_ring_info},
	    {"get_ring_info2", 2, hearlpix::get_ring_info2},
	    {"get_ring_small", 2, hearlpix::get_ring_small},
	    
	    {"neighbors", 2, hearlpix::neighbors},
	    
	    {"get_interpol", 3, hearlpix::get_interpol},
	    {"get_interpol", 4, hearlpix::get_interpol},
	    {"get_order", 1, hearlpix::get_order},
	    {"get_nside", 1, hearlpix::get_nside},
	    {"get_npix", 1, hearlpix::get_npix},
	    {"get_scheme", 1, hearlpix::get_scheme},
	    
	    {"conformable", 2, hearlpix::conformable},
	    
	    {"max_pixrad", 1, hearlpix::max_pixrad},
	    {"max_pixrad", 2, hearlpix::max_pixrad},
	    {"boundaries", 3, hearlpix::boundaries},

	    {"nside2order", 1, hearlpix::nside2order},
	    {"npix2nside", 1, hearlpix::npix2nside}
	};

	void base_resource_dtor(ErlNifEnv* env, void* arg)
	{
		return;
	}

	static int on_nif_load(ErlNifEnv* env, void** priv_data, ERL_NIF_TERM load_info) 
	{
		// Initialize common atoms
		#define ATOM(Id, Value) { Id = enif_make_atom(env, Value); }
		    ATOM(hearlpix::ATOM_OK, "ok");
		    ATOM(hearlpix::ATOM_ERROR, "error");
		    ATOM(hearlpix::ATOM_BADARG, "badarg");
		    ATOM(hearlpix::ATOM_TRUE, "true");
		    ATOM(hearlpix::ATOM_FALSE, "false");
		#undef ATOM

		ErlNifResourceFlags flags = (ErlNifResourceFlags)(ERL_NIF_RT_CREATE | ERL_NIF_RT_TAKEOVER);
		HEALPIX_BASE_RESOURCE = enif_open_resource_type(
															env,
															"hearlpix", 
															"healpix_base_resource", 
															&hearlpix::base_resource_dtor, 
															flags,
	                                                    	NULL
                                                    	);

	    return 0;
	}
}

extern "C" 
{
    ERL_NIF_INIT(hearlpix, hearlpix::nif_funcs, hearlpix::on_nif_load, NULL, NULL, NULL);
}

