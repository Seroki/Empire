--
-- PostgreSQL database dump
--

\restrict FRRoywX9CHvZ0DFT8Uhmc4zj1dN7KknNkMr8HLJyWm0ipVVrMcXRg7NKx1NA6Jc

-- Dumped from database version 15.19
-- Dumped by pg_dump version 15.19

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE IF EXISTS ONLY public.world_resource_fields DROP CONSTRAINT IF EXISTS world_resource_fields_owner_city_id_fkey;
ALTER TABLE IF EXISTS ONLY public.wall_fortification_capacity DROP CONSTRAINT IF EXISTS wall_fortification_capacity_city_id_fkey;
ALTER TABLE IF EXISTS ONLY public.unit_research_requirements DROP CONSTRAINT IF EXISTS unit_research_requirements_unit_type_id_fkey;
ALTER TABLE IF EXISTS ONLY public.unit_research_requirements DROP CONSTRAINT IF EXISTS unit_research_requirements_research_id_fkey;
ALTER TABLE IF EXISTS ONLY public.unit_research_requirements DROP CONSTRAINT IF EXISTS unit_research_requirements_requires_building_id_fkey;
ALTER TABLE IF EXISTS ONLY public.research_queue DROP CONSTRAINT IF EXISTS research_queue_research_node_id_fkey;
ALTER TABLE IF EXISTS ONLY public.research_queue DROP CONSTRAINT IF EXISTS research_queue_player_id_fkey;
ALTER TABLE IF EXISTS ONLY public.research_queue DROP CONSTRAINT IF EXISTS research_queue_city_id_fkey;
ALTER TABLE IF EXISTS ONLY public.research_nodes DROP CONSTRAINT IF EXISTS research_nodes_linked_building_id_fkey;
ALTER TABLE IF EXISTS ONLY public.research_node_prerequisites DROP CONSTRAINT IF EXISTS research_node_prerequisites_research_node_id_fkey;
ALTER TABLE IF EXISTS ONLY public.research_node_prerequisites DROP CONSTRAINT IF EXISTS research_node_prerequisites_required_building_type_id_fkey;
ALTER TABLE IF EXISTS ONLY public.research_node_prerequisites DROP CONSTRAINT IF EXISTS research_node_prerequisites_prerequisite_node_id_fkey;
ALTER TABLE IF EXISTS ONLY public.recruitment_queue DROP CONSTRAINT IF EXISTS recruitment_queue_unit_type_id_fkey;
ALTER TABLE IF EXISTS ONLY public.recruitment_queue DROP CONSTRAINT IF EXISTS recruitment_queue_city_id_fkey;
ALTER TABLE IF EXISTS ONLY public.recruitment_queue DROP CONSTRAINT IF EXISTS recruitment_queue_building_id_fkey;
ALTER TABLE IF EXISTS ONLY public.player_researches DROP CONSTRAINT IF EXISTS player_researches_research_node_id_fkey;
ALTER TABLE IF EXISTS ONLY public.player_researches DROP CONSTRAINT IF EXISTS player_researches_player_id_fkey;
ALTER TABLE IF EXISTS ONLY public.player_completed_research_nodes DROP CONSTRAINT IF EXISTS player_completed_research_nodes_research_node_id_fkey;
ALTER TABLE IF EXISTS ONLY public.player_completed_research_nodes DROP CONSTRAINT IF EXISTS player_completed_research_nodes_player_id_fkey;
ALTER TABLE IF EXISTS ONLY public.player_bonus_totals DROP CONSTRAINT IF EXISTS player_bonus_totals_player_id_fkey;
ALTER TABLE IF EXISTS ONLY public.map_tiles DROP CONSTRAINT IF EXISTS map_tiles_owner_city_id_fkey;
ALTER TABLE IF EXISTS ONLY public.map_tiles DROP CONSTRAINT IF EXISTS map_tiles_city_id_fkey;
ALTER TABLE IF EXISTS ONLY public.heroes DROP CONSTRAINT IF EXISTS heroes_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.heroes DROP CONSTRAINT IF EXISTS heroes_city_id_fkey;
ALTER TABLE IF EXISTS ONLY public.hero_candidates DROP CONSTRAINT IF EXISTS hero_candidates_hero_id_fkey;
ALTER TABLE IF EXISTS ONLY public.hero_candidates DROP CONSTRAINT IF EXISTS hero_candidates_city_id_fkey;
ALTER TABLE IF EXISTS ONLY public.construction_queue DROP CONSTRAINT IF EXISTS construction_queue_city_id_fkey;
ALTER TABLE IF EXISTS ONLY public.construction_queue DROP CONSTRAINT IF EXISTS construction_queue_building_id_fkey;
ALTER TABLE IF EXISTS ONLY public.city_wounded_troops DROP CONSTRAINT IF EXISTS city_wounded_troops_unit_type_id_fkey;
ALTER TABLE IF EXISTS ONLY public.city_wounded_troops DROP CONSTRAINT IF EXISTS city_wounded_troops_city_id_fkey;
ALTER TABLE IF EXISTS ONLY public.city_units DROP CONSTRAINT IF EXISTS city_units_unit_type_id_fkey;
ALTER TABLE IF EXISTS ONLY public.city_units DROP CONSTRAINT IF EXISTS city_units_city_id_fkey;
ALTER TABLE IF EXISTS ONLY public.city_resources DROP CONSTRAINT IF EXISTS city_resources_city_id_fkey;
ALTER TABLE IF EXISTS ONLY public.city_buildings DROP CONSTRAINT IF EXISTS city_buildings_city_id_fkey;
ALTER TABLE IF EXISTS ONLY public.city_buildings DROP CONSTRAINT IF EXISTS city_buildings_building_type_id_fkey;
ALTER TABLE IF EXISTS ONLY public.cities DROP CONSTRAINT IF EXISTS cities_owner_id_fkey;
ALTER TABLE IF EXISTS ONLY public.cities DROP CONSTRAINT IF EXISTS cities_owner_city_id_fkey;
ALTER TABLE IF EXISTS ONLY public.building_prerequisites DROP CONSTRAINT IF EXISTS building_prerequisites_req_research_node_id_fkey;
ALTER TABLE IF EXISTS ONLY public.building_prerequisites DROP CONSTRAINT IF EXISTS building_prerequisites_req_building_type_id_fkey;
ALTER TABLE IF EXISTS ONLY public.building_prerequisites DROP CONSTRAINT IF EXISTS building_prerequisites_building_type_id_fkey;
ALTER TABLE IF EXISTS ONLY public.building_levels DROP CONSTRAINT IF EXISTS building_levels_building_type_id_fkey;
DROP INDEX IF EXISTS public.research_node_prerequisites_research_pair_uidx;
DROP INDEX IF EXISTS public.idx_building_prereqs_lookup;
ALTER TABLE IF EXISTS ONLY public.world_valleys DROP CONSTRAINT IF EXISTS world_valleys_x_y_key;
ALTER TABLE IF EXISTS ONLY public.world_valleys DROP CONSTRAINT IF EXISTS world_valleys_pkey;
ALTER TABLE IF EXISTS ONLY public.world_resource_fields DROP CONSTRAINT IF EXISTS world_resource_fields_x_y_key;
ALTER TABLE IF EXISTS ONLY public.world_resource_fields DROP CONSTRAINT IF EXISTS world_resource_fields_pkey;
ALTER TABLE IF EXISTS ONLY public.wall_fortification_capacity DROP CONSTRAINT IF EXISTS wall_fortification_capacity_pkey;
ALTER TABLE IF EXISTS ONLY public.unit_types DROP CONSTRAINT IF EXISTS unit_types_pkey;
ALTER TABLE IF EXISTS ONLY public.unit_types DROP CONSTRAINT IF EXISTS unit_types_code_key;
ALTER TABLE IF EXISTS ONLY public.unit_research_requirements DROP CONSTRAINT IF EXISTS unit_research_requirements_pkey;
ALTER TABLE IF EXISTS ONLY public.tax_happiness_bands DROP CONSTRAINT IF EXISTS tax_happiness_bands_pkey;
ALTER TABLE IF EXISTS ONLY public.system_effects DROP CONSTRAINT IF EXISTS system_effects_pkey;
ALTER TABLE IF EXISTS ONLY public.system_effects DROP CONSTRAINT IF EXISTS system_effects_branch_system_key;
ALTER TABLE IF EXISTS ONLY public.research_queue DROP CONSTRAINT IF EXISTS research_queue_pkey;
ALTER TABLE IF EXISTS ONLY public.research_nodes DROP CONSTRAINT IF EXISTS research_nodes_pkey;
ALTER TABLE IF EXISTS ONLY public.research_nodes DROP CONSTRAINT IF EXISTS research_nodes_name_key;
ALTER TABLE IF EXISTS ONLY public.research_node_prerequisites DROP CONSTRAINT IF EXISTS research_node_prerequisites_pkey;
ALTER TABLE IF EXISTS ONLY public.recruitment_queue DROP CONSTRAINT IF EXISTS recruitment_queue_pkey;
ALTER TABLE IF EXISTS ONLY public.players DROP CONSTRAINT IF EXISTS players_username_key;
ALTER TABLE IF EXISTS ONLY public.players DROP CONSTRAINT IF EXISTS players_pkey;
ALTER TABLE IF EXISTS ONLY public.player_researches DROP CONSTRAINT IF EXISTS player_researches_pkey;
ALTER TABLE IF EXISTS ONLY public.player_completed_research_nodes DROP CONSTRAINT IF EXISTS player_completed_research_nodes_pkey;
ALTER TABLE IF EXISTS ONLY public.player_bonus_totals DROP CONSTRAINT IF EXISTS player_bonus_totals_player_id_bonus_type_key;
ALTER TABLE IF EXISTS ONLY public.player_bonus_totals DROP CONSTRAINT IF EXISTS player_bonus_totals_pkey;
ALTER TABLE IF EXISTS ONLY public.npc_cities DROP CONSTRAINT IF EXISTS npc_cities_x_y_key;
ALTER TABLE IF EXISTS ONLY public.npc_cities DROP CONSTRAINT IF EXISTS npc_cities_pkey;
ALTER TABLE IF EXISTS ONLY public.map_tiles DROP CONSTRAINT IF EXISTS map_tiles_x_y_key;
ALTER TABLE IF EXISTS ONLY public.map_tiles DROP CONSTRAINT IF EXISTS map_tiles_pkey;
ALTER TABLE IF EXISTS ONLY public.heroes DROP CONSTRAINT IF EXISTS heroes_pkey;
ALTER TABLE IF EXISTS ONLY public.hero_hiring_tiers DROP CONSTRAINT IF EXISTS hero_hiring_tiers_pkey;
ALTER TABLE IF EXISTS ONLY public.hero_candidates DROP CONSTRAINT IF EXISTS hero_candidates_pkey;
ALTER TABLE IF EXISTS ONLY public.construction_queue DROP CONSTRAINT IF EXISTS construction_queue_pkey;
ALTER TABLE IF EXISTS ONLY public.city_wounded_troops DROP CONSTRAINT IF EXISTS city_wounded_troops_pkey;
ALTER TABLE IF EXISTS ONLY public.city_units DROP CONSTRAINT IF EXISTS city_units_pkey;
ALTER TABLE IF EXISTS ONLY public.city_resources DROP CONSTRAINT IF EXISTS city_resources_pkey;
ALTER TABLE IF EXISTS ONLY public.city_buildings DROP CONSTRAINT IF EXISTS city_buildings_pkey;
ALTER TABLE IF EXISTS ONLY public.cities DROP CONSTRAINT IF EXISTS cities_pkey;
ALTER TABLE IF EXISTS ONLY public.building_types DROP CONSTRAINT IF EXISTS building_types_pkey;
ALTER TABLE IF EXISTS ONLY public.building_types DROP CONSTRAINT IF EXISTS building_types_name_key;
ALTER TABLE IF EXISTS ONLY public.building_prerequisites DROP CONSTRAINT IF EXISTS building_prerequisites_pkey;
ALTER TABLE IF EXISTS ONLY public.building_levels DROP CONSTRAINT IF EXISTS building_levels_pkey;
ALTER TABLE IF EXISTS ONLY public.building_levels DROP CONSTRAINT IF EXISTS building_levels_building_type_id_level_key;
ALTER TABLE IF EXISTS public.world_valleys ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.world_resource_fields ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.wall_fortification_capacity ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.unit_types ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.unit_research_requirements ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.system_effects ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.research_queue ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.research_nodes ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.research_node_prerequisites ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.recruitment_queue ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.players ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.player_researches ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.player_bonus_totals ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.npc_cities ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.map_tiles ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.heroes ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.hero_hiring_tiers ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.hero_candidates ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.construction_queue ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.city_wounded_troops ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.city_buildings ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.cities ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.building_types ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.building_prerequisites ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.building_levels ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE IF EXISTS public.world_valleys_id_seq;
DROP TABLE IF EXISTS public.world_valleys;
DROP SEQUENCE IF EXISTS public.world_resource_fields_id_seq;
DROP TABLE IF EXISTS public.world_resource_fields;
DROP SEQUENCE IF EXISTS public.wall_fortification_capacity_id_seq;
DROP TABLE IF EXISTS public.wall_fortification_capacity;
DROP SEQUENCE IF EXISTS public.unit_types_id_seq;
DROP TABLE IF EXISTS public.unit_types;
DROP SEQUENCE IF EXISTS public.unit_research_requirements_id_seq;
DROP TABLE IF EXISTS public.unit_research_requirements;
DROP TABLE IF EXISTS public.tax_happiness_bands;
DROP SEQUENCE IF EXISTS public.system_effects_id_seq;
DROP TABLE IF EXISTS public.system_effects;
DROP SEQUENCE IF EXISTS public.research_queue_id_seq;
DROP TABLE IF EXISTS public.research_queue;
DROP SEQUENCE IF EXISTS public.research_nodes_id_seq;
DROP TABLE IF EXISTS public.research_nodes;
DROP SEQUENCE IF EXISTS public.research_node_prerequisites_id_seq;
DROP TABLE IF EXISTS public.research_node_prerequisites;
DROP SEQUENCE IF EXISTS public.recruitment_queue_id_seq;
DROP TABLE IF EXISTS public.recruitment_queue;
DROP SEQUENCE IF EXISTS public.players_id_seq;
DROP TABLE IF EXISTS public.players;
DROP SEQUENCE IF EXISTS public.player_researches_id_seq;
DROP TABLE IF EXISTS public.player_researches;
DROP TABLE IF EXISTS public.player_completed_research_nodes;
DROP SEQUENCE IF EXISTS public.player_bonus_totals_id_seq;
DROP TABLE IF EXISTS public.player_bonus_totals;
DROP SEQUENCE IF EXISTS public.npc_cities_id_seq;
DROP TABLE IF EXISTS public.npc_cities;
DROP SEQUENCE IF EXISTS public.map_tiles_id_seq;
DROP TABLE IF EXISTS public.map_tiles;
DROP SEQUENCE IF EXISTS public.heroes_id_seq;
DROP TABLE IF EXISTS public.heroes;
DROP SEQUENCE IF EXISTS public.hero_hiring_tiers_id_seq;
DROP TABLE IF EXISTS public.hero_hiring_tiers;
DROP SEQUENCE IF EXISTS public.hero_candidates_id_seq;
DROP TABLE IF EXISTS public.hero_candidates;
DROP SEQUENCE IF EXISTS public.construction_queue_id_seq;
DROP TABLE IF EXISTS public.construction_queue;
DROP SEQUENCE IF EXISTS public.city_wounded_troops_id_seq;
DROP TABLE IF EXISTS public.city_wounded_troops;
DROP TABLE IF EXISTS public.city_units;
DROP TABLE IF EXISTS public.city_resources;
DROP SEQUENCE IF EXISTS public.city_buildings_id_seq;
DROP TABLE IF EXISTS public.city_buildings;
DROP SEQUENCE IF EXISTS public.cities_id_seq;
DROP TABLE IF EXISTS public.cities;
DROP SEQUENCE IF EXISTS public.building_types_id_seq;
DROP TABLE IF EXISTS public.building_types;
DROP SEQUENCE IF EXISTS public.building_prerequisites_id_seq;
DROP TABLE IF EXISTS public.building_prerequisites;
DROP SEQUENCE IF EXISTS public.building_levels_id_seq;
DROP TABLE IF EXISTS public.building_levels;
SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: building_levels; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.building_levels (
    id integer NOT NULL,
    building_type_id integer NOT NULL,
    level integer NOT NULL,
    food_cost integer NOT NULL,
    wood_cost integer NOT NULL,
    stone_cost integer NOT NULL,
    iron_cost integer NOT NULL,
    gold_cost integer NOT NULL,
    build_seconds integer NOT NULL,
    food_per_hour integer DEFAULT 0,
    wood_per_hour integer DEFAULT 0,
    stone_per_hour integer DEFAULT 0,
    iron_per_hour integer DEFAULT 0,
    gold_per_hour integer DEFAULT 0,
    population_capacity integer DEFAULT 0,
    storage_capacity integer DEFAULT 0,
    hospital_capacity integer
);


ALTER TABLE public.building_levels OWNER TO postgres;

--
-- Name: building_levels_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.building_levels_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.building_levels_id_seq OWNER TO postgres;

--
-- Name: building_levels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.building_levels_id_seq OWNED BY public.building_levels.id;


--
-- Name: building_prerequisites; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.building_prerequisites (
    id integer NOT NULL,
    building_type_id integer NOT NULL,
    target_level integer NOT NULL,
    req_building_type_id integer,
    req_building_level integer,
    req_research_node_id integer,
    req_research_level integer,
    CONSTRAINT building_prerequisites_req_building_level_check CHECK (((req_building_level >= 1) AND (req_building_level <= 10))),
    CONSTRAINT building_prerequisites_target_level_check CHECK (((target_level >= 1) AND (target_level <= 10))),
    CONSTRAINT chk_has_prereq CHECK (((req_building_type_id IS NOT NULL) OR (req_research_node_id IS NOT NULL)))
);


ALTER TABLE public.building_prerequisites OWNER TO postgres;

--
-- Name: building_prerequisites_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.building_prerequisites_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.building_prerequisites_id_seq OWNER TO postgres;

--
-- Name: building_prerequisites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.building_prerequisites_id_seq OWNED BY public.building_prerequisites.id;


--
-- Name: building_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.building_types (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    category character varying(30) NOT NULL,
    max_level integer NOT NULL,
    description text,
    unlock_th_level integer DEFAULT 0,
    slot_pool character varying(20) DEFAULT 'inner'::character varying,
    is_unique boolean DEFAULT true NOT NULL
);


ALTER TABLE public.building_types OWNER TO postgres;

--
-- Name: building_types_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.building_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.building_types_id_seq OWNER TO postgres;

--
-- Name: building_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.building_types_id_seq OWNED BY public.building_types.id;


--
-- Name: cities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cities (
    id integer NOT NULL,
    owner_id integer NOT NULL,
    name character varying(100) NOT NULL,
    x integer NOT NULL,
    y integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    owner_city_id integer
);


ALTER TABLE public.cities OWNER TO postgres;

--
-- Name: cities_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cities_id_seq OWNER TO postgres;

--
-- Name: cities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cities_id_seq OWNED BY public.cities.id;


--
-- Name: city_buildings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.city_buildings (
    id integer NOT NULL,
    city_id integer NOT NULL,
    building_type_id integer NOT NULL,
    level integer DEFAULT 1 NOT NULL,
    position_x integer DEFAULT 0 NOT NULL,
    position_y integer DEFAULT 0 NOT NULL,
    population_capacity integer DEFAULT 0,
    slot_pool character varying(20),
    stored_resource integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    last_collected_at timestamp without time zone
);


ALTER TABLE public.city_buildings OWNER TO postgres;

--
-- Name: city_buildings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.city_buildings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.city_buildings_id_seq OWNER TO postgres;

--
-- Name: city_buildings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.city_buildings_id_seq OWNED BY public.city_buildings.id;


--
-- Name: city_resources; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.city_resources (
    city_id integer NOT NULL,
    population integer DEFAULT 1000,
    loyalty integer DEFAULT 100,
    happiness integer DEFAULT 100,
    morale_updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    tax_rate numeric(5,2) DEFAULT 10.00,
    levy_pool integer DEFAULT 0,
    levy_updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    call_to_arms_active boolean DEFAULT false,
    food bigint DEFAULT 5000,
    wood bigint DEFAULT 5000,
    stone bigint DEFAULT 5000,
    iron bigint DEFAULT 5000,
    gold bigint DEFAULT 1000,
    workers integer DEFAULT 10,
    gold_updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    gold_remainder numeric(12,6) DEFAULT 0 NOT NULL
);


ALTER TABLE public.city_resources OWNER TO postgres;

--
-- Name: city_units; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.city_units (
    city_id integer NOT NULL,
    unit_type_id integer NOT NULL,
    amount integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.city_units OWNER TO postgres;

--
-- Name: city_wounded_troops; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.city_wounded_troops (
    id integer NOT NULL,
    city_id integer NOT NULL,
    unit_type_id integer NOT NULL,
    quantity integer NOT NULL,
    source text NOT NULL,
    admitted_at timestamp without time zone,
    expires_at timestamp without time zone,
    heal_complete_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.city_wounded_troops OWNER TO postgres;

--
-- Name: city_wounded_troops_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.city_wounded_troops_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.city_wounded_troops_id_seq OWNER TO postgres;

--
-- Name: city_wounded_troops_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.city_wounded_troops_id_seq OWNED BY public.city_wounded_troops.id;


--
-- Name: construction_queue; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.construction_queue (
    id integer NOT NULL,
    city_id integer NOT NULL,
    building_id integer NOT NULL,
    target_level integer NOT NULL,
    started_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    finish_time timestamp without time zone NOT NULL,
    finish_at timestamp without time zone,
    workers_used integer DEFAULT 0,
    is_demolition boolean DEFAULT false,
    refund_food integer DEFAULT 0,
    refund_wood integer DEFAULT 0,
    refund_stone integer DEFAULT 0,
    refund_iron integer DEFAULT 0,
    refund_gold integer DEFAULT 0
);


ALTER TABLE public.construction_queue OWNER TO postgres;

--
-- Name: construction_queue_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.construction_queue_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.construction_queue_id_seq OWNER TO postgres;

--
-- Name: construction_queue_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.construction_queue_id_seq OWNED BY public.construction_queue.id;


--
-- Name: hero_candidates; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hero_candidates (
    id integer NOT NULL,
    hero_id integer,
    city_id integer,
    status character varying(20) DEFAULT 'available'::character varying,
    selected_at timestamp without time zone
);


ALTER TABLE public.hero_candidates OWNER TO postgres;

--
-- Name: hero_candidates_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.hero_candidates_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hero_candidates_id_seq OWNER TO postgres;

--
-- Name: hero_candidates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.hero_candidates_id_seq OWNED BY public.hero_candidates.id;


--
-- Name: hero_hiring_tiers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hero_hiring_tiers (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    power_level integer NOT NULL,
    loyalty_cost integer NOT NULL,
    gold_cost integer NOT NULL,
    description text
);


ALTER TABLE public.hero_hiring_tiers OWNER TO postgres;

--
-- Name: hero_hiring_tiers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.hero_hiring_tiers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hero_hiring_tiers_id_seq OWNER TO postgres;

--
-- Name: hero_hiring_tiers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.hero_hiring_tiers_id_seq OWNED BY public.hero_hiring_tiers.id;


--
-- Name: heroes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.heroes (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    type character varying(30) NOT NULL,
    power_level integer DEFAULT 1,
    loyalty integer DEFAULT 50,
    experience integer DEFAULT 0,
    city_id integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    level integer DEFAULT 1,
    politics integer DEFAULT 0,
    role character varying(20) DEFAULT 'NONE'::character varying,
    attack integer DEFAULT 0,
    intelligence integer DEFAULT 0,
    hired boolean DEFAULT false,
    hire_cost integer DEFAULT 0,
    is_mayor boolean DEFAULT false,
    status character varying(20) DEFAULT 'IDLE'::character varying,
    user_id integer
);


ALTER TABLE public.heroes OWNER TO postgres;

--
-- Name: heroes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.heroes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.heroes_id_seq OWNER TO postgres;

--
-- Name: heroes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.heroes_id_seq OWNED BY public.heroes.id;


--
-- Name: map_tiles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.map_tiles (
    id integer NOT NULL,
    x integer NOT NULL,
    y integer NOT NULL,
    tile_type character varying(20) NOT NULL,
    resource_type character varying(50),
    resource_level integer,
    npc_level integer,
    city_id integer,
    name character varying(100),
    owner_city_id integer
);


ALTER TABLE public.map_tiles OWNER TO postgres;

--
-- Name: map_tiles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.map_tiles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.map_tiles_id_seq OWNER TO postgres;

--
-- Name: map_tiles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.map_tiles_id_seq OWNED BY public.map_tiles.id;


--
-- Name: npc_cities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.npc_cities (
    id integer NOT NULL,
    x integer NOT NULL,
    y integer NOT NULL,
    level integer NOT NULL,
    warrior integer DEFAULT 0 NOT NULL,
    pikeman integer DEFAULT 0 NOT NULL,
    swordsman integer DEFAULT 0 NOT NULL,
    archer integer DEFAULT 0 NOT NULL,
    cavalry integer DEFAULT 0 NOT NULL,
    traps integer DEFAULT 0 NOT NULL,
    abatis integer DEFAULT 0 NOT NULL,
    archer_tower integer DEFAULT 0 NOT NULL,
    rolling_log integer DEFAULT 0 NOT NULL,
    defensive_trebuchet integer DEFAULT 0 NOT NULL,
    food bigint DEFAULT 0 NOT NULL,
    lumber bigint DEFAULT 0 NOT NULL,
    stone bigint DEFAULT 0 NOT NULL,
    iron bigint DEFAULT 0 NOT NULL,
    gold bigint DEFAULT 0 NOT NULL,
    wall_level integer DEFAULT 1 NOT NULL,
    loyalty integer DEFAULT 90 NOT NULL,
    last_regen_tick_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.npc_cities OWNER TO postgres;

--
-- Name: npc_cities_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.npc_cities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.npc_cities_id_seq OWNER TO postgres;

--
-- Name: npc_cities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.npc_cities_id_seq OWNED BY public.npc_cities.id;


--
-- Name: player_bonus_totals; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.player_bonus_totals (
    id integer NOT NULL,
    player_id integer NOT NULL,
    bonus_type text NOT NULL,
    total_value numeric(8,2) DEFAULT 0 NOT NULL
);


ALTER TABLE public.player_bonus_totals OWNER TO postgres;

--
-- Name: player_bonus_totals_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.player_bonus_totals_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.player_bonus_totals_id_seq OWNER TO postgres;

--
-- Name: player_bonus_totals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.player_bonus_totals_id_seq OWNED BY public.player_bonus_totals.id;


--
-- Name: player_completed_research_nodes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.player_completed_research_nodes (
    player_id integer NOT NULL,
    research_node_id integer NOT NULL,
    completed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.player_completed_research_nodes OWNER TO postgres;

--
-- Name: player_researches; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.player_researches (
    id integer NOT NULL,
    player_id integer,
    research_node_id integer,
    progress integer DEFAULT 0,
    started_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    completed_at timestamp without time zone
);


ALTER TABLE public.player_researches OWNER TO postgres;

--
-- Name: player_researches_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.player_researches_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.player_researches_id_seq OWNER TO postgres;

--
-- Name: player_researches_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.player_researches_id_seq OWNED BY public.player_researches.id;


--
-- Name: players; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.players (
    id integer NOT NULL,
    username character varying(50) NOT NULL,
    password_hash text NOT NULL,
    title character varying(50) DEFAULT 'Squire'::character varying,
    prestige integer DEFAULT 0,
    honor integer DEFAULT 0,
    alliance text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    last_login timestamp without time zone
);


ALTER TABLE public.players OWNER TO postgres;

--
-- Name: players_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.players_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.players_id_seq OWNER TO postgres;

--
-- Name: players_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.players_id_seq OWNED BY public.players.id;


--
-- Name: recruitment_queue; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.recruitment_queue (
    id integer NOT NULL,
    city_id integer,
    unit_type_id integer,
    quantity integer NOT NULL,
    started_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    finish_at timestamp without time zone,
    building_id integer
);


ALTER TABLE public.recruitment_queue OWNER TO postgres;

--
-- Name: recruitment_queue_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.recruitment_queue_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.recruitment_queue_id_seq OWNER TO postgres;

--
-- Name: recruitment_queue_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.recruitment_queue_id_seq OWNED BY public.recruitment_queue.id;


--
-- Name: research_node_prerequisites; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.research_node_prerequisites (
    research_node_id integer NOT NULL,
    prerequisite_node_id integer,
    id integer NOT NULL,
    requirement_type text DEFAULT 'RESEARCH'::text NOT NULL,
    required_academy_level integer,
    required_building_type_id integer,
    required_building_level integer,
    CONSTRAINT research_node_prerequisites_requirement_type_check CHECK ((requirement_type = ANY (ARRAY['RESEARCH'::text, 'ACADEMY'::text, 'BUILDING'::text]))),
    CONSTRAINT research_node_prerequisites_shape_check CHECK ((((requirement_type = 'RESEARCH'::text) AND (prerequisite_node_id IS NOT NULL) AND (required_academy_level IS NULL) AND (required_building_type_id IS NULL) AND (required_building_level IS NULL)) OR ((requirement_type = 'ACADEMY'::text) AND (required_academy_level IS NOT NULL) AND (prerequisite_node_id IS NULL) AND (required_building_type_id IS NULL) AND (required_building_level IS NULL)) OR ((requirement_type = 'BUILDING'::text) AND (required_building_type_id IS NOT NULL) AND (required_building_level IS NOT NULL) AND (prerequisite_node_id IS NULL) AND (required_academy_level IS NULL))))
);


ALTER TABLE public.research_node_prerequisites OWNER TO postgres;

--
-- Name: research_node_prerequisites_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.research_node_prerequisites_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.research_node_prerequisites_id_seq OWNER TO postgres;

--
-- Name: research_node_prerequisites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.research_node_prerequisites_id_seq OWNED BY public.research_node_prerequisites.id;


--
-- Name: research_nodes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.research_nodes (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    description text,
    research_seconds integer NOT NULL,
    gold_cost integer NOT NULL,
    food_cost integer NOT NULL,
    discipline text NOT NULL,
    branch_code text NOT NULL,
    branch_name text NOT NULL,
    level integer NOT NULL,
    step integer DEFAULT 0 NOT NULL,
    effect_type text DEFAULT 'BONUS'::text NOT NULL,
    requires_academy_level integer DEFAULT 1 NOT NULL,
    linked_building_id integer,
    is_gateway boolean DEFAULT false,
    quarry_bonus_pct numeric(4,2) DEFAULT 0.00,
    requires_quarry_level integer DEFAULT 0,
    bonus_pct numeric(5,2),
    bonus_type text,
    bonus_value numeric(6,2)
);


ALTER TABLE public.research_nodes OWNER TO postgres;

--
-- Name: research_nodes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.research_nodes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.research_nodes_id_seq OWNER TO postgres;

--
-- Name: research_nodes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.research_nodes_id_seq OWNED BY public.research_nodes.id;


--
-- Name: research_queue; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.research_queue (
    id integer NOT NULL,
    player_id integer NOT NULL,
    city_id integer NOT NULL,
    research_node_id integer NOT NULL,
    started_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    finish_at timestamp without time zone NOT NULL,
    status text DEFAULT 'IN_PROGRESS'::text NOT NULL
);


ALTER TABLE public.research_queue OWNER TO postgres;

--
-- Name: research_queue_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.research_queue_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.research_queue_id_seq OWNER TO postgres;

--
-- Name: research_queue_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.research_queue_id_seq OWNED BY public.research_queue.id;


--
-- Name: system_effects; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.system_effects (
    id integer NOT NULL,
    branch_system text NOT NULL,
    step_bonus_pct numeric NOT NULL
);


ALTER TABLE public.system_effects OWNER TO postgres;

--
-- Name: system_effects_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.system_effects_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.system_effects_id_seq OWNER TO postgres;

--
-- Name: system_effects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.system_effects_id_seq OWNED BY public.system_effects.id;


--
-- Name: tax_happiness_bands; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tax_happiness_bands (
    tax_rate_pct numeric(5,2) NOT NULL,
    base_happiness_penalty integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.tax_happiness_bands OWNER TO postgres;

--
-- Name: unit_research_requirements; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.unit_research_requirements (
    id integer NOT NULL,
    unit_type_id integer NOT NULL,
    research_id integer,
    requires_building_id integer,
    requires_building_level integer
);


ALTER TABLE public.unit_research_requirements OWNER TO postgres;

--
-- Name: unit_research_requirements_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.unit_research_requirements_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.unit_research_requirements_id_seq OWNER TO postgres;

--
-- Name: unit_research_requirements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.unit_research_requirements_id_seq OWNED BY public.unit_research_requirements.id;


--
-- Name: unit_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.unit_types (
    id integer NOT NULL,
    code text NOT NULL,
    name text NOT NULL,
    category text NOT NULL,
    attack integer DEFAULT 0 NOT NULL,
    defense integer DEFAULT 0 NOT NULL,
    range_yards integer DEFAULT 0 NOT NULL,
    population_cost integer DEFAULT 1 NOT NULL,
    food_cost integer DEFAULT 0 NOT NULL,
    wood_cost integer DEFAULT 0 NOT NULL,
    stone_cost integer DEFAULT 0 NOT NULL,
    iron_cost integer DEFAULT 0 NOT NULL,
    gold_cost integer DEFAULT 0 NOT NULL,
    base_training_seconds integer DEFAULT 60 NOT NULL,
    req_building_code text,
    req_building_level integer,
    min_barracks_level integer DEFAULT 1 NOT NULL,
    required_workshop_level integer,
    required_stable_level integer,
    is_npc_only boolean DEFAULT false NOT NULL,
    upkeep numeric DEFAULT 0 NOT NULL,
    base_hp integer DEFAULT 1 NOT NULL,
    load_capacity integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.unit_types OWNER TO postgres;

--
-- Name: unit_types_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.unit_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.unit_types_id_seq OWNER TO postgres;

--
-- Name: unit_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.unit_types_id_seq OWNED BY public.unit_types.id;


--
-- Name: wall_fortification_capacity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wall_fortification_capacity (
    id integer NOT NULL,
    city_id integer,
    current_capacity integer DEFAULT 0,
    max_capacity integer DEFAULT 100,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.wall_fortification_capacity OWNER TO postgres;

--
-- Name: wall_fortification_capacity_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wall_fortification_capacity_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wall_fortification_capacity_id_seq OWNER TO postgres;

--
-- Name: wall_fortification_capacity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wall_fortification_capacity_id_seq OWNED BY public.wall_fortification_capacity.id;


--
-- Name: world_resource_fields; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.world_resource_fields (
    id integer NOT NULL,
    resource_type character varying(20) NOT NULL,
    x integer NOT NULL,
    y integer NOT NULL,
    resource_level integer DEFAULT 1 NOT NULL,
    warrior integer DEFAULT 0 NOT NULL,
    pikeman integer DEFAULT 0 NOT NULL,
    swordsman integer DEFAULT 0 NOT NULL,
    archer integer DEFAULT 0 NOT NULL,
    owner_city_id integer,
    occupied_at timestamp without time zone,
    recall_at timestamp without time zone,
    last_harvested_at timestamp without time zone
);


ALTER TABLE public.world_resource_fields OWNER TO postgres;

--
-- Name: world_resource_fields_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.world_resource_fields_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.world_resource_fields_id_seq OWNER TO postgres;

--
-- Name: world_resource_fields_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.world_resource_fields_id_seq OWNED BY public.world_resource_fields.id;


--
-- Name: world_valleys; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.world_valleys (
    id integer NOT NULL,
    name character varying(50),
    x integer NOT NULL,
    y integer NOT NULL,
    width integer,
    depth integer,
    resource_bonus numeric(5,2) DEFAULT 1.0,
    owner_city_id integer,
    occupied_at timestamp without time zone,
    recall_at timestamp without time zone,
    hero_id integer,
    field_type character varying(20),
    level integer,
    warrior integer,
    pikeman integer,
    swordsman integer,
    archer integer,
    cavalry integer,
    cataphract integer DEFAULT 0,
    ballista integer DEFAULT 0,
    battering_ram integer DEFAULT 0,
    catapult integer DEFAULT 0,
    scout integer DEFAULT 0,
    transporter integer DEFAULT 0
);


ALTER TABLE public.world_valleys OWNER TO postgres;

--
-- Name: world_valleys_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.world_valleys_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.world_valleys_id_seq OWNER TO postgres;

--
-- Name: world_valleys_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.world_valleys_id_seq OWNED BY public.world_valleys.id;


--
-- Name: building_levels id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.building_levels ALTER COLUMN id SET DEFAULT nextval('public.building_levels_id_seq'::regclass);


--
-- Name: building_prerequisites id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.building_prerequisites ALTER COLUMN id SET DEFAULT nextval('public.building_prerequisites_id_seq'::regclass);


--
-- Name: building_types id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.building_types ALTER COLUMN id SET DEFAULT nextval('public.building_types_id_seq'::regclass);


--
-- Name: cities id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cities ALTER COLUMN id SET DEFAULT nextval('public.cities_id_seq'::regclass);


--
-- Name: city_buildings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.city_buildings ALTER COLUMN id SET DEFAULT nextval('public.city_buildings_id_seq'::regclass);


--
-- Name: city_wounded_troops id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.city_wounded_troops ALTER COLUMN id SET DEFAULT nextval('public.city_wounded_troops_id_seq'::regclass);


--
-- Name: construction_queue id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.construction_queue ALTER COLUMN id SET DEFAULT nextval('public.construction_queue_id_seq'::regclass);


--
-- Name: hero_candidates id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hero_candidates ALTER COLUMN id SET DEFAULT nextval('public.hero_candidates_id_seq'::regclass);


--
-- Name: hero_hiring_tiers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hero_hiring_tiers ALTER COLUMN id SET DEFAULT nextval('public.hero_hiring_tiers_id_seq'::regclass);


--
-- Name: heroes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.heroes ALTER COLUMN id SET DEFAULT nextval('public.heroes_id_seq'::regclass);


--
-- Name: map_tiles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.map_tiles ALTER COLUMN id SET DEFAULT nextval('public.map_tiles_id_seq'::regclass);


--
-- Name: npc_cities id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.npc_cities ALTER COLUMN id SET DEFAULT nextval('public.npc_cities_id_seq'::regclass);


--
-- Name: player_bonus_totals id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player_bonus_totals ALTER COLUMN id SET DEFAULT nextval('public.player_bonus_totals_id_seq'::regclass);


--
-- Name: player_researches id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player_researches ALTER COLUMN id SET DEFAULT nextval('public.player_researches_id_seq'::regclass);


--
-- Name: players id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.players ALTER COLUMN id SET DEFAULT nextval('public.players_id_seq'::regclass);


--
-- Name: recruitment_queue id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recruitment_queue ALTER COLUMN id SET DEFAULT nextval('public.recruitment_queue_id_seq'::regclass);


--
-- Name: research_node_prerequisites id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.research_node_prerequisites ALTER COLUMN id SET DEFAULT nextval('public.research_node_prerequisites_id_seq'::regclass);


--
-- Name: research_nodes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.research_nodes ALTER COLUMN id SET DEFAULT nextval('public.research_nodes_id_seq'::regclass);


--
-- Name: research_queue id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.research_queue ALTER COLUMN id SET DEFAULT nextval('public.research_queue_id_seq'::regclass);


--
-- Name: system_effects id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.system_effects ALTER COLUMN id SET DEFAULT nextval('public.system_effects_id_seq'::regclass);


--
-- Name: unit_research_requirements id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.unit_research_requirements ALTER COLUMN id SET DEFAULT nextval('public.unit_research_requirements_id_seq'::regclass);


--
-- Name: unit_types id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.unit_types ALTER COLUMN id SET DEFAULT nextval('public.unit_types_id_seq'::regclass);


--
-- Name: wall_fortification_capacity id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wall_fortification_capacity ALTER COLUMN id SET DEFAULT nextval('public.wall_fortification_capacity_id_seq'::regclass);


--
-- Name: world_resource_fields id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.world_resource_fields ALTER COLUMN id SET DEFAULT nextval('public.world_resource_fields_id_seq'::regclass);


--
-- Name: world_valleys id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.world_valleys ALTER COLUMN id SET DEFAULT nextval('public.world_valleys_id_seq'::regclass);


--
-- Data for Name: building_levels; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.building_levels (id, building_type_id, level, food_cost, wood_cost, stone_cost, iron_cost, gold_cost, build_seconds, food_per_hour, wood_per_hour, stone_per_hour, iron_per_hour, gold_per_hour, population_capacity, storage_capacity, hospital_capacity) FROM stdin;
4	2	1	100	100	100	100	100	900	0	0	0	0	0	0	500	\N
5	3	1	100	100	100	100	100	900	0	0	0	0	0	0	500	\N
6	4	1	100	100	100	100	100	900	0	0	0	0	0	0	500	\N
7	5	1	100	100	100	100	100	900	100	0	0	0	0	0	500	\N
8	6	1	100	100	100	100	100	900	0	100	0	0	0	0	500	\N
303	17	1	150	1000	3000	300	0	450	0	0	0	0	0	0	0	\N
304	17	2	300	2000	6000	600	0	900	0	0	0	0	0	0	0	\N
11	9	1	100	100	100	100	100	900	0	0	0	0	0	0	500	\N
13	11	1	100	100	100	100	100	900	0	0	0	0	0	0	1000	\N
50	18	2	100	100	100	100	100	1800	0	0	0	0	0	0	500	\N
51	19	2	100	100	100	100	100	1800	0	0	0	0	0	0	500	\N
52	20	2	100	100	100	100	100	1800	0	0	0	0	0	0	500	\N
53	21	2	100	100	100	100	100	1800	0	0	0	0	0	0	500	\N
56	24	2	100	100	100	100	100	1800	0	0	0	0	0	0	500	\N
58	26	2	100	100	100	100	100	1800	0	0	0	0	0	0	500	\N
64	2	3	100	100	100	100	100	2700	0	0	0	0	0	0	500	\N
65	3	3	100	100	100	100	100	2700	0	0	0	0	0	0	500	\N
66	4	3	100	100	100	100	100	2700	0	0	0	0	0	0	500	\N
67	5	3	100	100	100	100	100	2700	300	0	0	0	0	0	500	\N
68	6	3	100	100	100	100	100	2700	0	300	0	0	0	0	500	\N
71	9	3	100	100	100	100	100	2700	0	0	0	0	0	0	500	\N
73	11	3	100	100	100	100	100	2700	0	0	0	0	0	0	2000	\N
74	12	3	100	100	100	100	100	2700	0	0	0	0	0	0	500	\N
75	13	3	100	100	100	100	100	2700	0	0	0	0	0	0	500	\N
76	14	3	100	100	100	100	100	2700	0	0	0	0	0	0	500	\N
77	15	3	100	100	100	100	100	2700	0	0	0	0	0	0	500	\N
78	16	3	100	100	100	100	100	2700	0	0	0	0	0	0	500	\N
266	24	9	100	100	100	100	100	8100	0	0	0	0	0	0	500	\N
268	26	9	100	100	100	100	100	8100	0	0	0	0	0	0	500	\N
274	2	10	100	100	100	100	100	9000	0	0	0	0	0	0	500	\N
275	3	10	100	100	100	100	100	9000	0	0	0	0	0	0	500	\N
276	4	10	100	100	100	100	100	9000	0	0	0	0	0	0	500	\N
277	5	10	100	100	100	100	100	9000	1000	0	0	0	0	0	500	\N
278	6	10	100	100	100	100	100	9000	0	1000	0	0	0	0	500	\N
80	18	3	100	100	100	100	100	2700	0	0	0	0	0	0	500	\N
81	19	3	100	100	100	100	100	2700	0	0	0	0	0	0	500	\N
82	20	3	100	100	100	100	100	2700	0	0	0	0	0	0	500	\N
83	21	3	100	100	100	100	100	2700	0	0	0	0	0	0	500	\N
86	24	3	100	100	100	100	100	2700	0	0	0	0	0	0	500	\N
88	26	3	100	100	100	100	100	2700	0	0	0	0	0	0	500	\N
104	12	4	100	100	100	100	100	3600	0	0	0	0	0	0	500	\N
105	13	4	100	100	100	100	100	3600	0	0	0	0	0	0	500	\N
106	14	4	100	100	100	100	100	3600	0	0	0	0	0	0	500	\N
107	15	4	100	100	100	100	100	3600	0	0	0	0	0	0	500	\N
108	16	4	100	100	100	100	100	3600	0	0	0	0	0	0	500	\N
110	18	4	100	100	100	100	100	3600	0	0	0	0	0	0	500	\N
111	19	4	100	100	100	100	100	3600	0	0	0	0	0	0	500	\N
112	20	4	100	100	100	100	100	3600	0	0	0	0	0	0	500	\N
113	21	4	100	100	100	100	100	3600	0	0	0	0	0	0	500	\N
116	24	4	100	100	100	100	100	3600	0	0	0	0	0	0	500	\N
118	26	4	100	100	100	100	100	3600	0	0	0	0	0	0	500	\N
124	2	5	100	100	100	100	100	4500	0	0	0	0	0	0	500	\N
125	3	5	100	100	100	100	100	4500	0	0	0	0	0	0	500	\N
126	4	5	100	100	100	100	100	4500	0	0	0	0	0	0	500	\N
127	5	5	100	100	100	100	100	4500	500	0	0	0	0	0	500	\N
128	6	5	100	100	100	100	100	4500	0	500	0	0	0	0	500	\N
131	9	5	100	100	100	100	100	4500	0	0	0	0	0	0	500	\N
133	11	5	100	100	100	100	100	4500	0	0	0	0	0	0	3000	\N
134	12	5	100	100	100	100	100	4500	0	0	0	0	0	0	500	\N
135	13	5	100	100	100	100	100	4500	0	0	0	0	0	0	500	\N
136	14	5	100	100	100	100	100	4500	0	0	0	0	0	0	500	\N
137	15	5	100	100	100	100	100	4500	0	0	0	0	0	0	500	\N
138	16	5	100	100	100	100	100	4500	0	0	0	0	0	0	500	\N
140	18	5	100	100	100	100	100	4500	0	0	0	0	0	0	500	\N
141	19	5	100	100	100	100	100	4500	0	0	0	0	0	0	500	\N
142	20	5	100	100	100	100	100	4500	0	0	0	0	0	0	500	\N
143	21	5	100	100	100	100	100	4500	0	0	0	0	0	0	500	\N
9	7	1	100	100	100	100	100	900	0	0	100	0	0	0	500	\N
12	10	1	100	100	100	100	100	900	1000	1000	0	0	0	100	500	\N
1	1	1	100	100	100	100	100	900	100	100	100	100	100	200	500	\N
69	7	3	100	100	100	100	100	2700	0	0	300	0	0	0	500	\N
279	7	10	100	100	100	100	100	9000	0	0	1000	0	0	0	500	\N
129	7	5	100	100	100	100	100	4500	0	0	500	0	0	0	500	\N
10	8	1	100	100	100	100	100	900	0	0	0	100	0	0	500	\N
70	8	3	100	100	100	100	100	2700	0	0	0	300	0	0	500	\N
280	8	10	100	100	100	100	100	9000	0	0	0	1000	0	0	500	\N
130	8	5	100	100	100	100	100	4500	0	0	0	500	0	0	500	\N
305	17	3	600	4000	12000	1200	0	1800	0	0	0	0	0	0	0	\N
306	17	4	1200	8000	24000	2400	0	3600	0	0	0	0	0	0	0	\N
57	25	2	100	100	100	100	100	1800	0	0	0	0	0	0	500	200
267	25	9	100	100	100	100	100	8100	0	0	0	0	0	0	500	900
87	25	3	100	100	100	100	100	2700	0	0	0	0	0	0	500	300
117	25	4	100	100	100	100	100	3600	0	0	0	0	0	0	500	400
307	17	5	2400	16000	48000	4800	0	7200	0	0	0	0	0	0	0	\N
308	17	6	4800	32000	96000	9600	0	14400	0	0	0	0	0	0	0	\N
309	17	7	9600	64000	192000	19200	0	28800	0	0	0	0	0	0	0	\N
94	2	4	100	100	100	100	100	3600	0	0	0	0	0	0	500	\N
95	3	4	100	100	100	100	100	3600	0	0	0	0	0	0	500	\N
96	4	4	100	100	100	100	100	3600	0	0	0	0	0	0	500	\N
97	5	4	100	100	100	100	100	3600	400	0	0	0	0	0	500	\N
98	6	4	100	100	100	100	100	3600	0	400	0	0	0	0	500	\N
101	9	4	100	100	100	100	100	3600	0	0	0	0	0	0	500	\N
103	11	4	100	100	100	100	100	3600	0	0	0	0	0	0	2500	\N
146	24	5	100	100	100	100	100	4500	0	0	0	0	0	0	500	\N
148	26	5	100	100	100	100	100	4500	0	0	0	0	0	0	500	\N
154	2	6	100	100	100	100	100	5400	0	0	0	0	0	0	500	\N
155	3	6	100	100	100	100	100	5400	0	0	0	0	0	0	500	\N
156	4	6	100	100	100	100	100	5400	0	0	0	0	0	0	500	\N
157	5	6	100	100	100	100	100	5400	600	0	0	0	0	0	500	\N
158	6	6	100	100	100	100	100	5400	0	600	0	0	0	0	500	\N
161	9	6	100	100	100	100	100	5400	0	0	0	0	0	0	500	\N
163	11	6	100	100	100	100	100	5400	0	0	0	0	0	0	3500	\N
164	12	6	100	100	100	100	100	5400	0	0	0	0	0	0	500	\N
165	13	6	100	100	100	100	100	5400	0	0	0	0	0	0	500	\N
166	14	6	100	100	100	100	100	5400	0	0	0	0	0	0	500	\N
167	15	6	100	100	100	100	100	5400	0	0	0	0	0	0	500	\N
168	16	6	100	100	100	100	100	5400	0	0	0	0	0	0	500	\N
170	18	6	100	100	100	100	100	5400	0	0	0	0	0	0	500	\N
171	19	6	100	100	100	100	100	5400	0	0	0	0	0	0	500	\N
172	20	6	100	100	100	100	100	5400	0	0	0	0	0	0	500	\N
173	21	6	100	100	100	100	100	5400	0	0	0	0	0	0	500	\N
176	24	6	100	100	100	100	100	5400	0	0	0	0	0	0	500	\N
194	12	7	100	100	100	100	100	6300	0	0	0	0	0	0	500	\N
195	13	7	100	100	100	100	100	6300	0	0	0	0	0	0	500	\N
196	14	7	100	100	100	100	100	6300	0	0	0	0	0	0	500	\N
197	15	7	100	100	100	100	100	6300	0	0	0	0	0	0	500	\N
198	16	7	100	100	100	100	100	6300	0	0	0	0	0	0	500	\N
200	18	7	100	100	100	100	100	6300	0	0	0	0	0	0	500	\N
201	19	7	100	100	100	100	100	6300	0	0	0	0	0	0	500	\N
202	20	7	100	100	100	100	100	6300	0	0	0	0	0	0	500	\N
203	21	7	100	100	100	100	100	6300	0	0	0	0	0	0	500	\N
206	24	7	100	100	100	100	100	6300	0	0	0	0	0	0	500	\N
208	26	7	100	100	100	100	100	6300	0	0	0	0	0	0	500	\N
214	2	8	100	100	100	100	100	7200	0	0	0	0	0	0	500	\N
215	3	8	100	100	100	100	100	7200	0	0	0	0	0	0	500	\N
216	4	8	100	100	100	100	100	7200	0	0	0	0	0	0	500	\N
217	5	8	100	100	100	100	100	7200	800	0	0	0	0	0	500	\N
218	6	8	100	100	100	100	100	7200	0	800	0	0	0	0	500	\N
221	9	8	100	100	100	100	100	7200	0	0	0	0	0	0	500	\N
223	11	8	100	100	100	100	100	7200	0	0	0	0	0	0	4500	\N
224	12	8	100	100	100	100	100	7200	0	0	0	0	0	0	500	\N
298	26	10	100	100	100	100	100	9000	0	0	0	0	0	0	500	\N
102	10	4	100	100	100	100	100	3600	4000	4000	0	0	0	500	500	\N
93	1	4	100	100	100	100	100	3600	0	0	0	0	0	200	500	\N
99	7	4	100	100	100	100	100	3600	0	0	400	0	0	0	500	\N
159	7	6	100	100	100	100	100	5400	0	0	600	0	0	0	500	\N
219	7	8	100	100	100	100	100	7200	0	0	800	0	0	0	500	\N
100	8	4	100	100	100	100	100	3600	0	0	0	400	0	0	500	\N
160	8	6	100	100	100	100	100	5400	0	0	0	600	0	0	500	\N
220	8	8	100	100	100	100	100	7200	0	0	0	800	0	0	500	\N
147	25	5	100	100	100	100	100	4500	0	0	0	0	0	0	500	500
177	25	6	100	100	100	100	100	5400	0	0	0	0	0	0	500	600
207	25	7	100	100	100	100	100	6300	0	0	0	0	0	0	500	700
310	17	8	19200	128000	384000	38400	0	57600	0	0	0	0	0	0	0	\N
311	17	9	38400	256000	768000	76800	0	115200	0	0	0	0	0	0	0	\N
312	17	10	76800	512000	1536000	153600	0	230400	0	0	0	0	0	0	0	\N
178	26	6	100	100	100	100	100	5400	0	0	0	0	0	0	500	\N
184	2	7	100	100	100	100	100	6300	0	0	0	0	0	0	500	\N
185	3	7	100	100	100	100	100	6300	0	0	0	0	0	0	500	\N
186	4	7	100	100	100	100	100	6300	0	0	0	0	0	0	500	\N
187	5	7	100	100	100	100	100	6300	700	0	0	0	0	0	500	\N
188	6	7	100	100	100	100	100	6300	0	700	0	0	0	0	500	\N
191	9	7	100	100	100	100	100	6300	0	0	0	0	0	0	500	\N
193	11	7	100	100	100	100	100	6300	0	0	0	0	0	0	4000	\N
192	10	7	100	100	100	100	100	6300	7000	7000	0	0	0	1700	500	\N
183	1	7	100	100	100	100	100	6300	0	0	0	0	0	200	500	\N
189	7	7	100	100	100	100	100	6300	0	0	700	0	0	0	500	\N
190	8	7	100	100	100	100	100	6300	0	0	0	700	0	0	500	\N
42	10	2	100	100	100	100	100	1800	2000	2000	0	0	0	200	500	\N
72	10	3	100	100	100	100	100	2700	3000	3000	0	0	0	300	500	\N
33	1	2	100	100	100	100	100	1800	0	0	0	0	0	200	500	\N
14	12	1	100	100	100	100	100	900	0	0	0	0	0	0	500	\N
15	13	1	100	100	100	100	100	900	0	0	0	0	0	0	500	\N
16	14	1	100	100	100	100	100	900	0	0	0	0	0	0	500	\N
17	15	1	100	100	100	100	100	900	0	0	0	0	0	0	500	\N
63	1	3	100	100	100	100	100	2700	0	0	0	0	0	200	500	\N
273	1	10	100	100	100	100	100	9000	0	0	0	0	0	200	500	\N
39	7	2	100	100	100	100	100	1800	0	0	200	0	0	0	500	\N
40	8	2	100	100	100	100	100	1800	0	0	0	200	0	0	500	\N
27	25	1	100	100	100	100	100	900	0	0	0	0	0	0	500	100
18	16	1	100	100	100	100	100	900	0	0	0	0	0	0	500	\N
20	18	1	100	100	100	100	100	900	0	0	0	0	0	0	500	\N
21	19	1	100	100	100	100	100	900	0	0	0	0	0	0	500	\N
22	20	1	100	100	100	100	100	900	0	0	0	0	0	0	500	\N
23	21	1	100	100	100	100	100	900	0	0	0	0	0	0	500	\N
26	24	1	100	100	100	100	100	900	0	0	0	0	0	0	500	\N
28	26	1	100	100	100	100	100	900	0	0	0	0	0	0	500	\N
34	2	2	100	100	100	100	100	1800	0	0	0	0	0	0	500	\N
35	3	2	100	100	100	100	100	1800	0	0	0	0	0	0	500	\N
36	4	2	100	100	100	100	100	1800	0	0	0	0	0	0	500	\N
37	5	2	100	100	100	100	100	1800	200	0	0	0	0	0	500	\N
38	6	2	100	100	100	100	100	1800	0	200	0	0	0	0	500	\N
41	9	2	100	100	100	100	100	1800	0	0	0	0	0	0	500	\N
43	11	2	100	100	100	100	100	1800	0	0	0	0	0	0	1500	\N
44	12	2	100	100	100	100	100	1800	0	0	0	0	0	0	500	\N
45	13	2	100	100	100	100	100	1800	0	0	0	0	0	0	500	\N
46	14	2	100	100	100	100	100	1800	0	0	0	0	0	0	500	\N
47	15	2	100	100	100	100	100	1800	0	0	0	0	0	0	500	\N
48	16	2	100	100	100	100	100	1800	0	0	0	0	0	0	500	\N
132	10	5	100	100	100	100	100	4500	5000	5000	0	0	0	800	500	\N
162	10	6	100	100	100	100	100	5400	6000	6000	0	0	0	1200	500	\N
222	10	8	100	100	100	100	100	7200	8000	8000	0	0	0	2300	500	\N
123	1	5	100	100	100	100	100	4500	0	0	0	0	0	200	500	\N
153	1	6	100	100	100	100	100	5400	0	0	0	0	0	200	500	\N
213	1	8	100	100	100	100	100	7200	0	0	0	0	0	200	500	\N
252	10	9	100	100	100	100	100	8100	9000	9000	0	0	0	3000	500	\N
225	13	8	100	100	100	100	100	7200	0	0	0	0	0	0	500	\N
226	14	8	100	100	100	100	100	7200	0	0	0	0	0	0	500	\N
227	15	8	100	100	100	100	100	7200	0	0	0	0	0	0	500	\N
228	16	8	100	100	100	100	100	7200	0	0	0	0	0	0	500	\N
230	18	8	100	100	100	100	100	7200	0	0	0	0	0	0	500	\N
231	19	8	100	100	100	100	100	7200	0	0	0	0	0	0	500	\N
232	20	8	100	100	100	100	100	7200	0	0	0	0	0	0	500	\N
233	21	8	100	100	100	100	100	7200	0	0	0	0	0	0	500	\N
236	24	8	100	100	100	100	100	7200	0	0	0	0	0	0	500	\N
238	26	8	100	100	100	100	100	7200	0	0	0	0	0	0	500	\N
244	2	9	100	100	100	100	100	8100	0	0	0	0	0	0	500	\N
245	3	9	100	100	100	100	100	8100	0	0	0	0	0	0	500	\N
246	4	9	100	100	100	100	100	8100	0	0	0	0	0	0	500	\N
247	5	9	100	100	100	100	100	8100	900	0	0	0	0	0	500	\N
248	6	9	100	100	100	100	100	8100	0	900	0	0	0	0	500	\N
251	9	9	100	100	100	100	100	8100	0	0	0	0	0	0	500	\N
253	11	9	100	100	100	100	100	8100	0	0	0	0	0	0	5000	\N
254	12	9	100	100	100	100	100	8100	0	0	0	0	0	0	500	\N
255	13	9	100	100	100	100	100	8100	0	0	0	0	0	0	500	\N
256	14	9	100	100	100	100	100	8100	0	0	0	0	0	0	500	\N
257	15	9	100	100	100	100	100	8100	0	0	0	0	0	0	500	\N
258	16	9	100	100	100	100	100	8100	0	0	0	0	0	0	500	\N
260	18	9	100	100	100	100	100	8100	0	0	0	0	0	0	500	\N
261	19	9	100	100	100	100	100	8100	0	0	0	0	0	0	500	\N
262	20	9	100	100	100	100	100	8100	0	0	0	0	0	0	500	\N
263	21	9	100	100	100	100	100	8100	0	0	0	0	0	0	500	\N
281	9	10	100	100	100	100	100	9000	0	0	0	0	0	0	500	\N
283	11	10	100	100	100	100	100	9000	0	0	0	0	0	0	5500	\N
284	12	10	100	100	100	100	100	9000	0	0	0	0	0	0	500	\N
285	13	10	100	100	100	100	100	9000	0	0	0	0	0	0	500	\N
286	14	10	100	100	100	100	100	9000	0	0	0	0	0	0	500	\N
287	15	10	100	100	100	100	100	9000	0	0	0	0	0	0	500	\N
288	16	10	100	100	100	100	100	9000	0	0	0	0	0	0	500	\N
290	18	10	100	100	100	100	100	9000	0	0	0	0	0	0	500	\N
291	19	10	100	100	100	100	100	9000	0	0	0	0	0	0	500	\N
292	20	10	100	100	100	100	100	9000	0	0	0	0	0	0	500	\N
293	21	10	100	100	100	100	100	9000	0	0	0	0	0	0	500	\N
296	24	10	100	100	100	100	100	9000	0	0	0	0	0	0	500	\N
282	10	10	100	100	100	100	100	9000	10000	10000	0	0	0	5000	500	\N
243	1	9	100	100	100	100	100	8100	0	0	0	0	0	200	500	\N
249	7	9	100	100	100	100	100	8100	0	0	900	0	0	0	500	\N
250	8	9	100	100	100	100	100	8100	0	0	0	900	0	0	500	\N
237	25	8	100	100	100	100	100	7200	0	0	0	0	0	0	500	800
297	25	10	100	100	100	100	100	9000	0	0	0	0	0	0	500	1000
\.


--
-- Data for Name: building_prerequisites; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.building_prerequisites (id, building_type_id, target_level, req_building_type_id, req_building_level, req_research_node_id, req_research_level) FROM stdin;
14	5	4	\N	\N	10	1
15	5	6	\N	\N	11	2
16	5	8	\N	\N	12	3
17	5	10	\N	\N	13	4
18	10	3	\N	\N	14	1
19	5	5	\N	\N	14	1
20	10	5	\N	\N	15	2
21	5	7	\N	\N	15	2
22	10	7	\N	\N	16	3
23	5	9	\N	\N	16	3
24	10	9	\N	\N	17	4
25	8	2	\N	\N	30	1
26	8	4	\N	\N	31	2
27	8	6	\N	\N	32	3
28	8	8	\N	\N	33	4
29	6	3	\N	\N	34	1
30	16	2	\N	\N	34	1
31	6	5	\N	\N	35	2
32	5	6	\N	\N	35	2
33	16	4	\N	\N	35	2
34	6	8	\N	\N	36	3
35	5	9	\N	\N	36	3
36	16	6	\N	\N	36	3
37	16	8	\N	\N	37	4
38	11	2	\N	\N	38	1
39	11	4	\N	\N	39	2
40	11	6	\N	\N	40	3
41	11	8	\N	\N	41	4
42	12	2	\N	\N	42	1
43	24	2	\N	\N	42	1
44	12	4	\N	\N	43	2
45	24	4	\N	\N	43	2
46	12	6	\N	\N	44	3
47	24	6	\N	\N	44	3
48	12	8	\N	\N	45	4
49	24	8	\N	\N	45	4
50	13	2	\N	\N	46	1
51	13	4	\N	\N	47	2
52	13	6	\N	\N	48	3
53	13	8	\N	\N	49	4
54	26	2	\N	\N	50	1
55	13	3	\N	\N	50	1
56	26	4	\N	\N	51	2
57	13	5	\N	\N	51	2
58	26	6	\N	\N	52	3
59	13	7	\N	\N	52	3
60	26	8	\N	\N	53	4
61	13	9	\N	\N	53	4
62	3	2	\N	\N	1	1
63	7	2	\N	\N	1	1
64	3	6	\N	\N	27	2
65	14	2	\N	\N	66	1
66	14	4	\N	\N	67	2
67	14	6	\N	\N	68	3
68	14	8	\N	\N	69	4
69	15	2	\N	\N	70	1
70	15	4	\N	\N	71	2
71	15	6	\N	\N	72	3
72	15	8	\N	\N	73	4
73	22	2	\N	\N	74	1
74	22	4	\N	\N	75	2
75	22	6	\N	\N	76	3
76	22	8	\N	\N	77	4
82	17	3	\N	\N	88	1
83	17	5	\N	\N	89	2
84	17	7	\N	\N	90	3
85	17	9	\N	\N	91	4
86	25	2	\N	\N	108	1
87	25	3	\N	\N	109	2
88	25	4	\N	\N	110	3
89	25	5	\N	\N	111	4
90	25	6	\N	\N	112	5
91	25	7	\N	\N	113	6
92	25	8	\N	\N	114	7
93	25	9	\N	\N	115	8
94	25	10	\N	\N	116	9
95	6	2	\N	\N	118	1
96	15	2	\N	\N	118	1
97	6	3	\N	\N	119	2
98	15	3	\N	\N	119	2
99	6	4	\N	\N	120	3
100	15	4	\N	\N	120	3
101	6	5	\N	\N	121	4
102	15	5	\N	\N	121	4
103	6	6	\N	\N	122	5
104	15	6	\N	\N	122	5
105	6	7	\N	\N	123	6
106	15	7	\N	\N	123	6
107	6	8	\N	\N	124	7
108	15	8	\N	\N	124	7
109	6	9	\N	\N	125	8
110	15	9	\N	\N	125	8
111	6	10	\N	\N	126	9
112	15	10	\N	\N	126	9
113	10	2	\N	\N	128	1
114	10	3	\N	\N	129	2
115	10	4	\N	\N	130	3
116	10	5	\N	\N	131	4
117	10	6	\N	\N	132	5
118	10	7	\N	\N	133	6
119	10	8	\N	\N	134	7
120	10	9	\N	\N	135	8
121	10	10	\N	\N	136	9
122	12	3	\N	\N	140	3
123	12	5	\N	\N	142	5
124	12	7	\N	\N	144	7
125	12	9	\N	\N	146	9
126	20	2	\N	\N	149	1
127	3	4	\N	\N	5	1
128	10	6	\N	\N	187	2
129	7	4	\N	\N	187	2
130	10	7	\N	\N	195	3
131	7	6	\N	\N	195	3
132	3	8	\N	\N	28	3
133	10	10	\N	\N	203	4
134	7	8	\N	\N	203	4
135	3	10	\N	\N	29	4
136	1	10	3	9	\N	\N
137	1	10	2	9	\N	\N
138	1	9	12	8	\N	\N
139	1	9	19	8	\N	\N
140	1	8	11	7	\N	\N
141	1	8	18	7	\N	\N
142	1	7	21	6	\N	\N
143	1	7	3	6	\N	\N
144	1	6	2	5	\N	\N
145	1	6	17	5	\N	\N
146	1	5	16	4	\N	\N
147	1	5	15	4	\N	\N
148	1	4	13	3	\N	\N
149	1	4	14	3	\N	\N
150	1	3	18	2	\N	\N
151	1	3	20	2	\N	\N
152	1	2	10	1	\N	\N
153	1	2	5	1	\N	\N
154	2	10	3	10	\N	\N
155	2	9	3	9	\N	\N
156	2	8	3	8	\N	\N
157	2	7	3	7	\N	\N
158	2	6	3	6	\N	\N
159	2	5	3	5	\N	\N
160	2	4	3	4	\N	\N
161	2	3	3	4	\N	\N
162	2	2	3	4	\N	\N
163	2	1	3	4	\N	\N
164	3	3	7	3	\N	\N
165	4	9	3	10	\N	\N
166	4	8	3	9	\N	\N
167	4	7	3	8	\N	\N
168	4	6	3	7	\N	\N
169	4	5	3	6	\N	\N
170	4	4	3	5	\N	\N
171	4	3	3	4	\N	\N
172	4	2	3	3	\N	\N
173	4	1	3	3	\N	\N
\.


--
-- Data for Name: building_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.building_types (id, name, category, max_level, description, unlock_th_level, slot_pool, is_unique) FROM stdin;
2	Keep	Core	10	Defensive command center; determines wall durability and garrison capacity.	4	inner	t
14	Stable	Military	10	Trains mounted units; increases cavalry speed.	3	inner	t
15	Workshop	Military	10	Builds siege engines and traps.	3	inner	t
16	Forge	Military	10	Produces weapons and armor; unlocks advanced troop tiers.	3	inner	t
18	Academy	Research	10	Researches technologies for economy, military, and logistics.	2	inner	t
19	Embassy	Research	10	Allows alliances, reinforcements, and coalition defense.	5	inner	t
25	Hospital	Optional	10	Heals wounded troops instead of losing them permanently.	4	inner	t
1	Town Hall	Core	10	The heart of every city.	1	inner	t
11	Warehouse	Infrastructure	10	Protects resources from plunder.	3	inner	t
12	Market	Infrastructure	10	Enables resource trading with other players or NPC merchants.	3	inner	t
20	Inn	Research	10	Recruits heroes with random stats.	1	inner	t
21	Feasting Hall	Research	10	Houses heroes; increases hero capacity.	1	inner	t
3	Walls	Core	10	City perimeter defense; increases fortification slots and defense bonuses.	2	inner	t
22	Trap Factory	Defense	10	Builds traps for walls (spikes, abatis, rolling logs).	5	inner	t
17	Beacon Tower	Military	10	Provides scouting reports and early warnings of enemy attacks.	2	inner	t
5	Farm	Economy	10	Produces food; required for troop upkeep.	1	outer	f
6	Sawmill	Economy	10	Produces lumber; used for construction.	1	outer	f
7	Quarry	Economy	10	Produces stone; used for walls and heavy structures.	2	outer	f
8	Iron Mine	Economy	10	Produces iron; used for advanced troops and buildings.	2	outer	f
9	Gold Mine	Economy	10	Produces gold directly. Not yet active.	1	outer	f
13	Barracks	Military	10	Trains infantry, cavalry, archers, siege units.	2	inner	f
10	Cottage	Infrastructure	10	Increases population and worker availability.	1	inner	f
4	Gate	Core	10	Controls whether troops defend or hide during attacks.	3	inner	t
24	Relief Station	Optional	10	Boosts troop movement speed.	3	inner	t
26	Rally Spot	Military	10	Organizes group attacks and troop rallies.	3	inner	t
\.


--
-- Data for Name: cities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cities (id, owner_id, name, x, y, created_at, owner_city_id) FROM stdin;
6	6	Capital	94	5	2026-08-29 15:26:15.900901	\N
7	7	Capital	29	51	2026-08-29 15:31:49.347263	\N
8	8	Capital	82	79	2026-08-29 15:36:19.351189	\N
9	9	Capital	2	78	2026-08-29 16:04:12.648237	\N
10	10	Capital	60	1	2026-08-29 17:26:30.207005	\N
11	12	Captial	64	57	2026-08-29 18:50:59.97493	\N
\.


--
-- Data for Name: city_buildings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.city_buildings (id, city_id, building_type_id, level, position_x, position_y, population_capacity, slot_pool, stored_resource, created_at, last_collected_at) FROM stdin;
214	11	6	4	0	0	0	\N	0	2026-09-15 18:01:08.835871	2026-09-19 10:29:48.053302
218	11	19	1	0	0	0	\N	0	2026-09-17 15:32:08.776857	\N
219	11	12	1	0	0	0	\N	0	2026-09-17 15:32:15.685772	\N
215	11	6	4	0	0	0	\N	0	2026-09-15 18:01:13.841768	2026-09-19 10:29:48.988299
220	11	26	1	0	0	0	\N	0	2026-09-17 15:32:24.4239	\N
198	11	8	4	0	0	0	\N	0	2026-09-04 13:58:50.13884	2026-09-19 10:29:50.498321
189	11	6	4	0	0	0	\N	0	2026-08-31 23:12:00.302102	2026-09-19 10:29:52.703176
213	11	13	4	0	0	0	\N	0	2026-09-15 18:00:36.270185	\N
202	11	11	3	0	0	0	\N	0	2026-09-12 15:09:51.00262	\N
203	11	16	3	0	0	0	\N	0	2026-09-12 15:10:22.328725	\N
195	11	18	3	0	0	0	\N	0	2026-09-04 12:41:11.199798	\N
186	11	10	5	0	0	0	\N	0	2026-08-31 23:12:00.302102	\N
210	11	24	2	0	0	0	\N	0	2026-09-15 18:00:16.687658	\N
211	11	25	4	0	0	0	\N	0	2026-09-15 18:00:21.118555	\N
212	11	10	5	0	0	0	\N	0	2026-09-15 18:00:23.444759	\N
221	11	10	4	0	0	0	\N	0	2026-09-17 15:32:29.755197	\N
192	11	21	5	0	0	0	\N	0	2026-08-31 23:18:32.684089	\N
204	11	15	3	0	0	0	\N	0	2026-09-12 15:10:27.815111	\N
3	6	3	1	943	50	0	inner	0	2026-08-31 23:12:00.302102	\N
33	7	3	1	293	510	0	inner	0	2026-08-31 23:12:00.302102	\N
63	8	3	1	823	790	0	inner	0	2026-08-31 23:12:00.302102	\N
199	11	10	5	0	0	0	\N	0	2026-09-04 14:10:38.55616	\N
196	11	10	5	0	0	0	\N	0	2026-09-04 13:25:27.933891	\N
187	11	20	5	0	0	0	\N	0	2026-08-31 23:12:00.302102	\N
185	11	1	6	0	0	0	\N	0	2026-08-31 23:12:00.302102	\N
205	11	14	3	0	0	0	\N	0	2026-09-12 15:10:33.189084	\N
222	11	9	2	0	0	0	\N	0	2026-09-18 15:08:36.813031	2026-09-19 10:29:39.176204
216	11	6	4	0	0	0	\N	0	2026-09-15 20:51:19.778397	2026-09-19 10:29:43.500556
206	11	7	4	0	0	0	\N	0	2026-09-12 15:10:47.926909	2026-09-19 10:29:45.518425
1	6	1	1	941	51	0	inner	0	2026-08-31 23:12:00.302102	\N
2	6	2	1	942	52	0	inner	0	2026-08-31 23:12:00.302102	\N
4	6	4	1	944	51	0	inner	0	2026-08-31 23:12:00.302102	\N
5	6	5	1	940	52	0	outer	0	2026-08-31 23:12:00.302102	\N
6	6	6	1	941	50	0	outer	0	2026-08-31 23:12:00.302102	\N
7	6	7	1	942	51	0	outer	0	2026-08-31 23:12:00.302102	\N
8	6	8	1	943	52	0	outer	0	2026-08-31 23:12:00.302102	\N
9	6	9	1	944	50	0	outer	0	2026-08-31 23:12:00.302102	\N
10	6	10	1	940	51	0	inner	0	2026-08-31 23:12:00.302102	\N
11	6	11	1	941	52	0	inner	0	2026-08-31 23:12:00.302102	\N
12	6	12	1	942	50	0	inner	0	2026-08-31 23:12:00.302102	\N
13	6	13	1	943	51	0	inner	0	2026-08-31 23:12:00.302102	\N
14	6	14	1	944	52	0	inner	0	2026-08-31 23:12:00.302102	\N
15	6	15	1	940	50	0	inner	0	2026-08-31 23:12:00.302102	\N
16	6	16	1	941	51	0	inner	0	2026-08-31 23:12:00.302102	\N
207	11	5	4	0	0	0	\N	0	2026-09-12 15:24:46.660017	2026-09-19 10:29:46.155003
18	6	18	1	943	50	0	inner	0	2026-08-31 23:12:00.302102	\N
19	6	19	1	944	51	0	inner	0	2026-08-31 23:12:00.302102	\N
20	6	20	1	940	52	0	inner	0	2026-08-31 23:12:00.302102	\N
21	6	21	1	941	50	0	inner	0	2026-08-31 23:12:00.302102	\N
208	11	8	4	0	0	0	\N	0	2026-09-12 15:24:53.623636	2026-09-19 10:29:46.819407
209	11	8	4	0	0	0	\N	0	2026-09-12 15:24:57.141545	2026-09-19 10:29:47.429113
24	6	24	1	944	50	0	inner	0	2026-08-31 23:12:00.302102	\N
25	6	25	1	940	51	0	inner	0	2026-08-31 23:12:00.302102	\N
26	6	26	1	941	52	0	inner	0	2026-08-31 23:12:00.302102	\N
193	11	6	4	0	0	0	\N	0	2026-09-01 00:59:15.832881	2026-09-19 10:29:51.617725
31	7	1	1	291	511	0	inner	0	2026-08-31 23:12:00.302102	\N
32	7	2	1	292	512	0	inner	0	2026-08-31 23:12:00.302102	\N
34	7	4	1	294	511	0	inner	0	2026-08-31 23:12:00.302102	\N
35	7	5	1	290	512	0	outer	0	2026-08-31 23:12:00.302102	\N
36	7	6	1	291	510	0	outer	0	2026-08-31 23:12:00.302102	\N
37	7	7	1	292	511	0	outer	0	2026-08-31 23:12:00.302102	\N
38	7	8	1	293	512	0	outer	0	2026-08-31 23:12:00.302102	\N
39	7	9	1	294	510	0	outer	0	2026-08-31 23:12:00.302102	\N
40	7	10	1	290	511	0	inner	0	2026-08-31 23:12:00.302102	\N
41	7	11	1	291	512	0	inner	0	2026-08-31 23:12:00.302102	\N
42	7	12	1	292	510	0	inner	0	2026-08-31 23:12:00.302102	\N
43	7	13	1	293	511	0	inner	0	2026-08-31 23:12:00.302102	\N
44	7	14	1	294	512	0	inner	0	2026-08-31 23:12:00.302102	\N
45	7	15	1	290	510	0	inner	0	2026-08-31 23:12:00.302102	\N
46	7	16	1	291	511	0	inner	0	2026-08-31 23:12:00.302102	\N
48	7	18	1	293	510	0	inner	0	2026-08-31 23:12:00.302102	\N
49	7	19	1	294	511	0	inner	0	2026-08-31 23:12:00.302102	\N
50	7	20	1	290	512	0	inner	0	2026-08-31 23:12:00.302102	\N
51	7	21	1	291	510	0	inner	0	2026-08-31 23:12:00.302102	\N
54	7	24	1	294	510	0	inner	0	2026-08-31 23:12:00.302102	\N
55	7	25	1	290	511	0	inner	0	2026-08-31 23:12:00.302102	\N
56	7	26	1	291	512	0	inner	0	2026-08-31 23:12:00.302102	\N
61	8	1	1	821	791	0	inner	0	2026-08-31 23:12:00.302102	\N
62	8	2	1	822	792	0	inner	0	2026-08-31 23:12:00.302102	\N
64	8	4	1	824	791	0	inner	0	2026-08-31 23:12:00.302102	\N
65	8	5	1	820	792	0	outer	0	2026-08-31 23:12:00.302102	\N
66	8	6	1	821	790	0	outer	0	2026-08-31 23:12:00.302102	\N
67	8	7	1	822	791	0	outer	0	2026-08-31 23:12:00.302102	\N
68	8	8	1	823	792	0	outer	0	2026-08-31 23:12:00.302102	\N
69	8	9	1	824	790	0	outer	0	2026-08-31 23:12:00.302102	\N
70	8	10	1	820	791	0	inner	0	2026-08-31 23:12:00.302102	\N
71	8	11	1	821	792	0	inner	0	2026-08-31 23:12:00.302102	\N
72	8	12	1	822	790	0	inner	0	2026-08-31 23:12:00.302102	\N
73	8	13	1	823	791	0	inner	0	2026-08-31 23:12:00.302102	\N
74	8	14	1	824	792	0	inner	0	2026-08-31 23:12:00.302102	\N
75	8	15	1	820	790	0	inner	0	2026-08-31 23:12:00.302102	\N
76	8	16	1	821	791	0	inner	0	2026-08-31 23:12:00.302102	\N
78	8	18	1	823	790	0	inner	0	2026-08-31 23:12:00.302102	\N
79	8	19	1	824	791	0	inner	0	2026-08-31 23:12:00.302102	\N
80	8	20	1	820	792	0	inner	0	2026-08-31 23:12:00.302102	\N
81	8	21	1	821	790	0	inner	0	2026-08-31 23:12:00.302102	\N
84	8	24	1	824	790	0	inner	0	2026-08-31 23:12:00.302102	\N
85	8	25	1	820	791	0	inner	0	2026-08-31 23:12:00.302102	\N
86	8	26	1	821	792	0	inner	0	2026-08-31 23:12:00.302102	\N
200	11	5	4	0	0	0	\N	0	2026-09-04 14:56:27.318694	2026-09-18 23:33:16.610596
91	9	1	1	21	781	0	inner	0	2026-08-31 23:12:00.302102	\N
92	9	2	1	22	782	0	inner	0	2026-08-31 23:12:00.302102	\N
94	9	4	1	24	781	0	inner	0	2026-08-31 23:12:00.302102	\N
95	9	5	1	20	782	0	outer	0	2026-08-31 23:12:00.302102	\N
96	9	6	1	21	780	0	outer	0	2026-08-31 23:12:00.302102	\N
97	9	7	1	22	781	0	outer	0	2026-08-31 23:12:00.302102	\N
98	9	8	1	23	782	0	outer	0	2026-08-31 23:12:00.302102	\N
99	9	9	1	24	780	0	outer	0	2026-08-31 23:12:00.302102	\N
100	9	10	1	20	781	0	inner	0	2026-08-31 23:12:00.302102	\N
101	9	11	1	21	782	0	inner	0	2026-08-31 23:12:00.302102	\N
102	9	12	1	22	780	0	inner	0	2026-08-31 23:12:00.302102	\N
103	9	13	1	23	781	0	inner	0	2026-08-31 23:12:00.302102	\N
104	9	14	1	24	782	0	inner	0	2026-08-31 23:12:00.302102	\N
105	9	15	1	20	780	0	inner	0	2026-08-31 23:12:00.302102	\N
106	9	16	1	21	781	0	inner	0	2026-08-31 23:12:00.302102	\N
108	9	18	1	23	780	0	inner	0	2026-08-31 23:12:00.302102	\N
109	9	19	1	24	781	0	inner	0	2026-08-31 23:12:00.302102	\N
110	9	20	1	20	782	0	inner	0	2026-08-31 23:12:00.302102	\N
111	9	21	1	21	780	0	inner	0	2026-08-31 23:12:00.302102	\N
217	11	8	3	0	0	0	\N	0	2026-09-15 21:00:20.835982	2026-09-19 10:29:42.778637
114	9	24	1	24	780	0	inner	0	2026-08-31 23:12:00.302102	\N
115	9	25	1	20	781	0	inner	0	2026-08-31 23:12:00.302102	\N
116	9	26	1	21	782	0	inner	0	2026-08-31 23:12:00.302102	\N
201	11	5	4	0	0	0	\N	0	2026-09-04 14:56:34.972894	2026-09-19 10:29:44.826354
197	11	7	4	0	0	0	\N	0	2026-09-04 13:25:35.497451	2026-09-19 10:29:51.034183
191	11	5	4	0	0	0	\N	0	2026-08-31 23:18:16.612426	2026-09-19 10:29:52.146411
188	11	5	4	0	0	0	\N	0	2026-08-31 23:12:00.302102	2026-09-19 10:29:53.311828
121	10	1	1	601	11	0	inner	0	2026-08-31 23:12:00.302102	\N
122	10	2	1	602	12	0	inner	0	2026-08-31 23:12:00.302102	\N
124	10	4	1	604	11	0	inner	0	2026-08-31 23:12:00.302102	\N
125	10	5	1	600	12	0	outer	0	2026-08-31 23:12:00.302102	\N
126	10	6	1	601	10	0	outer	0	2026-08-31 23:12:00.302102	\N
127	10	7	1	602	11	0	outer	0	2026-08-31 23:12:00.302102	\N
128	10	8	1	603	12	0	outer	0	2026-08-31 23:12:00.302102	\N
129	10	9	1	604	10	0	outer	0	2026-08-31 23:12:00.302102	\N
130	10	10	1	600	11	0	inner	0	2026-08-31 23:12:00.302102	\N
131	10	11	1	601	12	0	inner	0	2026-08-31 23:12:00.302102	\N
132	10	12	1	602	10	0	inner	0	2026-08-31 23:12:00.302102	\N
133	10	13	1	603	11	0	inner	0	2026-08-31 23:12:00.302102	\N
134	10	14	1	604	12	0	inner	0	2026-08-31 23:12:00.302102	\N
135	10	15	1	600	10	0	inner	0	2026-08-31 23:12:00.302102	\N
136	10	16	1	601	11	0	inner	0	2026-08-31 23:12:00.302102	\N
138	10	18	1	603	10	0	inner	0	2026-08-31 23:12:00.302102	\N
139	10	19	1	604	11	0	inner	0	2026-08-31 23:12:00.302102	\N
140	10	20	1	600	12	0	inner	0	2026-08-31 23:12:00.302102	\N
141	10	21	1	601	10	0	inner	0	2026-08-31 23:12:00.302102	\N
144	10	24	1	604	10	0	inner	0	2026-08-31 23:12:00.302102	\N
145	10	25	1	600	11	0	inner	0	2026-08-31 23:12:00.302102	\N
146	10	26	1	601	12	0	inner	0	2026-08-31 23:12:00.302102	\N
194	11	13	5	0	0	0	\N	0	2026-09-04 12:41:06.227487	\N
93	9	3	1	23	780	0	inner	0	2026-08-31 23:12:00.302102	\N
123	10	3	1	603	10	0	inner	0	2026-08-31 23:12:00.302102	\N
\.


--
-- Data for Name: city_resources; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.city_resources (city_id, population, loyalty, happiness, morale_updated_at, tax_rate, levy_pool, levy_updated_at, call_to_arms_active, food, wood, stone, iron, gold, workers, gold_updated_at, updated_at, gold_remainder) FROM stdin;
7	1000	100	100	2026-08-29 15:31:49.347263	10.00	0	2026-08-29 15:31:49.347263	f	5000	5000	5000	5000	1000	10	2026-08-29 15:31:49.347263	2026-08-29 15:31:49.347263	0.000000
8	1000	100	100	2026-08-29 15:36:19.351189	10.00	0	2026-08-29 15:36:19.351189	f	5000	5000	5000	5000	1000	10	2026-08-29 15:36:19.351189	2026-08-29 15:36:19.351189	0.000000
6	1000	100	100	2026-08-29 15:30:02.556256	10.00	8	2026-08-29 16:02:32.468595	f	5000	5000	5000	5000	1000	10	2026-08-29 15:30:02.556256	2026-08-29 15:30:02.556256	0.000000
9	1000	100	100	2026-08-29 16:04:12.648237	10.00	0	2026-08-29 16:04:12.648237	f	5000	5000	5000	5000	1000	10	2026-08-29 16:04:12.648237	2026-08-29 16:04:12.648237	0.000000
10	1000	100	100	2026-08-29 17:26:30.207005	10.00	13	2026-08-29 18:16:07.816208	f	5000	5000	5000	5000	1166	10	2026-08-29 18:16:07.846298	2026-08-29 17:26:30.207005	0.000000
11	4100	100	100	2026-08-29 18:50:59.97493	50.00	100	2026-09-19 10:48:02.954882	f	200152	139824	139116	131540	1509173	2540	2026-09-19 11:55:39.044572	2026-09-19 11:55:39.044572	0.509958
\.


--
-- Data for Name: city_units; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.city_units (city_id, unit_type_id, amount) FROM stdin;
11	7	125
11	8	177
11	10	86
11	6	100
\.


--
-- Data for Name: city_wounded_troops; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.city_wounded_troops (id, city_id, unit_type_id, quantity, source, admitted_at, expires_at, heal_complete_at, created_at) FROM stdin;
1	11	7	5	NPC	2026-09-18 19:48:39.330858	\N	2026-09-18 19:51:43.035288	2026-09-18 19:48:39.305025
2	11	8	5	NPC	2026-09-18 19:48:39.330858	\N	2026-09-18 19:53:01.359056	2026-09-18 19:48:39.324654
3	11	10	4	NPC	2026-09-18 19:48:39.330858	\N	2026-09-18 19:54:18.650595	2026-09-18 19:48:39.327537
4	11	7	4	NPC	\N	2026-09-18 20:22:48.044923	\N	2026-09-18 19:52:48.044923
5	11	8	4	NPC	\N	2026-09-18 20:22:48.059395	\N	2026-09-18 19:52:48.059395
6	11	10	4	NPC	\N	2026-09-18 20:22:48.061883	\N	2026-09-18 19:52:48.061883
7	11	7	7	NPC	\N	2026-09-18 20:25:02.804556	\N	2026-09-18 19:55:02.804556
8	11	8	7	NPC	\N	2026-09-18 20:25:02.818402	\N	2026-09-18 19:55:02.818402
9	11	10	7	NPC	\N	2026-09-18 20:25:02.820473	\N	2026-09-18 19:55:02.820473
10	11	7	3	VALLEY	\N	2026-09-19 00:22:19.540503	\N	2026-09-18 23:52:19.540503
11	11	8	3	VALLEY	\N	2026-09-19 00:22:19.559088	\N	2026-09-18 23:52:19.559088
12	11	10	3	VALLEY	\N	2026-09-19 00:22:19.561768	\N	2026-09-18 23:52:19.561768
13	11	7	3	VALLEY	\N	2026-09-19 11:01:10.677776	\N	2026-09-19 10:31:10.677776
14	11	8	3	VALLEY	\N	2026-09-19 11:01:10.694676	\N	2026-09-19 10:31:10.694676
15	11	10	3	VALLEY	\N	2026-09-19 11:01:10.697296	\N	2026-09-19 10:31:10.697296
\.


--
-- Data for Name: construction_queue; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.construction_queue (id, city_id, building_id, target_level, started_at, finish_time, finish_at, workers_used, is_demolition, refund_food, refund_wood, refund_stone, refund_iron, refund_gold) FROM stdin;
\.


--
-- Data for Name: hero_candidates; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.hero_candidates (id, hero_id, city_id, status, selected_at) FROM stdin;
1	1	11	hired	2026-09-01 12:59:00.213697
3	3	11	hired	2026-09-01 13:06:10.819343
6	6	11	hired	2026-09-07 19:52:09.25049
10	10	11	hired	2026-09-15 03:35:29.771503
13	13	11	hired	2026-09-15 19:42:24.151779
17	17	11	hired	2026-09-18 13:29:54.805135
23	23	11	available	2026-09-18 23:37:32.139527
24	24	11	available	2026-09-18 23:37:32.139527
25	25	11	available	2026-09-18 23:37:32.139527
26	26	11	available	2026-09-18 23:37:32.139527
27	27	11	available	2026-09-18 23:37:32.139527
\.


--
-- Data for Name: hero_hiring_tiers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.hero_hiring_tiers (id, name, power_level, loyalty_cost, gold_cost, description) FROM stdin;
1	Apprentice	1	10	100	Low-power hero
2	Journeyman	2	25	250	Mid-power hero
3	Master	3	50	500	High-power hero
4	Grandmaster	4	100	1000	Elite hero
\.


--
-- Data for Name: heroes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.heroes (id, name, type, power_level, loyalty, experience, city_id, created_at, level, politics, role, attack, intelligence, hired, hire_cost, is_mayor, status, user_id) FROM stdin;
3	Tarpeia C.	Apprentice	1	10	0	\N	2026-09-01 13:06:10.819343	1	32	NONE	37	33	f	100	f	RELEASED	12
1	Iphigenia V.	Apprentice	1	10	0	\N	2026-09-01 12:59:00.213697	1	27	NONE	21	17	f	100	f	RELEASED	12
2	Hadrian B.	Apprentice	1	10	0	\N	2026-09-01 12:59:08.885419	1	22	NONE	32	30	f	100	f	RELEASED	\N
6	Maximus F.	Journeyman	2	25	0	\N	2026-09-07 19:52:09.25049	1	54	NONE	54	56	f	250	f	RELEASED	12
12	Claudius C.	Journeyman	2	25	0	11	2026-09-15 19:42:24.151779	1	33	NONE	37	59	f	250	f	available	\N
14	Sabina I.	Apprentice	1	10	0	11	2026-09-15 19:42:24.151779	1	25	NONE	23	38	f	100	f	available	\N
4	Drusilla U.	Apprentice	1	10	0	11	2026-09-03 18:56:31.757113	1	33	NONE	28	28	f	100	f	available	\N
5	Octavius C.	Apprentice	1	10	0	11	2026-09-07 19:52:09.25049	1	26	NONE	30	15	f	100	f	available	\N
7	Zenobia D.	Apprentice	1	10	0	11	2026-09-13 15:43:41.705597	1	22	NONE	45	34	f	100	f	available	\N
8	Percival N.	Apprentice	1	10	0	11	2026-09-13 15:43:41.705597	1	28	NONE	31	26	f	100	f	available	\N
9	Servilia F.	Journeyman	2	25	0	11	2026-09-15 03:35:29.771503	1	47	NONE	38	51	f	250	f	available	\N
11	Eudoxia X.	Apprentice	1	10	0	11	2026-09-15 03:35:29.771503	1	20	NONE	21	29	f	100	f	available	\N
13	Drusilla C.	Journeyman	2	25	0	11	2026-09-15 19:42:24.151779	1	59	NONE	53	58	t	250	f	idle	12
15	Zenobia F.	Journeyman	2	25	0	11	2026-09-18 13:29:54.805135	1	45	NONE	48	34	f	250	f	available	\N
10	Lucilla I.	Journeyman	2	25	0	11	2026-09-15 03:35:29.771503	1	69	NONE	58	34	t	250	f	idle	12
16	Octavia E.	Journeyman	2	25	0	11	2026-09-18 13:29:54.805135	1	43	NONE	30	30	f	250	f	available	\N
18	Aurelia G.	Journeyman	2	25	0	11	2026-09-18 13:29:54.805135	1	44	NONE	54	47	f	250	f	available	\N
19	Severus T.	Journeyman	2	25	0	11	2026-09-18 13:56:16.257625	1	36	NONE	46	34	f	250	f	available	\N
20	Marcus O.	Master	3	50	0	11	2026-09-18 13:56:16.257625	1	56	NONE	62	77	f	500	f	available	\N
21	Electra I.	Apprentice	1	10	0	11	2026-09-18 13:56:16.257625	1	33	NONE	16	15	f	100	f	available	\N
22	Sabina M.	Journeyman	2	25	0	11	2026-09-18 13:56:16.257625	1	30	NONE	37	34	f	250	f	available	\N
17	Sulla O.	Master	3	50	181	11	2026-09-18 13:29:54.805135	5	55	NONE	84	73	t	500	t	idle	12
23	Volumnia Z.	Journeyman	2	25	0	11	2026-09-18 23:37:32.139527	1	43	NONE	46	33	f	250	f	available	\N
24	Valeria T.	Apprentice	1	10	0	11	2026-09-18 23:37:32.139527	1	19	NONE	29	23	f	100	f	available	\N
25	Zoe H.	Apprentice	1	10	0	11	2026-09-18 23:37:32.139527	1	29	NONE	17	18	f	100	f	available	\N
26	Leonidas P.	Master	3	50	0	11	2026-09-18 23:37:32.139527	1	54	NONE	65	80	f	500	f	available	\N
27	Aeneas Q.	Journeyman	2	25	0	11	2026-09-18 23:37:32.139527	1	38	NONE	34	32	f	250	f	available	\N
\.


--
-- Data for Name: map_tiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.map_tiles (id, x, y, tile_type, resource_type, resource_level, npc_level, city_id, name, owner_city_id) FROM stdin;
1	0	0	EMPTY	\N	\N	\N	\N	\N	\N
2	0	1	RESOURCE	wood	5	\N	\N	\N	\N
3	0	2	NPC	\N	\N	5	\N	Barbarian Camp (Lv 5)	\N
4	0	3	NPC	\N	\N	8	\N	Barbarian Camp (Lv 8)	\N
5	0	4	EMPTY	\N	\N	\N	\N	\N	\N
6	0	5	EMPTY	\N	\N	\N	\N	\N	\N
7	0	6	EMPTY	\N	\N	\N	\N	\N	\N
8	0	7	EMPTY	\N	\N	\N	\N	\N	\N
9	0	8	RESOURCE	food	5	\N	\N	\N	\N
10	0	9	EMPTY	\N	\N	\N	\N	\N	\N
11	0	10	EMPTY	\N	\N	\N	\N	\N	\N
12	0	11	EMPTY	\N	\N	\N	\N	\N	\N
13	0	12	RESOURCE	stone	1	\N	\N	\N	\N
14	0	13	EMPTY	\N	\N	\N	\N	\N	\N
15	0	14	VALLEY	\N	\N	\N	\N	Valley (0, 14)	\N
16	0	15	EMPTY	\N	\N	\N	\N	\N	\N
17	0	16	EMPTY	\N	\N	\N	\N	\N	\N
18	0	17	EMPTY	\N	\N	\N	\N	\N	\N
19	0	18	EMPTY	\N	\N	\N	\N	\N	\N
20	0	19	EMPTY	\N	\N	\N	\N	\N	\N
21	0	20	VALLEY	\N	\N	\N	\N	Valley (0, 20)	\N
22	0	21	EMPTY	\N	\N	\N	\N	\N	\N
23	0	22	EMPTY	\N	\N	\N	\N	\N	\N
24	0	23	EMPTY	\N	\N	\N	\N	\N	\N
25	0	24	RESOURCE	iron	4	\N	\N	\N	\N
26	0	25	EMPTY	\N	\N	\N	\N	\N	\N
27	0	26	EMPTY	\N	\N	\N	\N	\N	\N
28	0	27	EMPTY	\N	\N	\N	\N	\N	\N
29	0	28	EMPTY	\N	\N	\N	\N	\N	\N
30	0	29	EMPTY	\N	\N	\N	\N	\N	\N
31	0	30	EMPTY	\N	\N	\N	\N	\N	\N
32	0	31	EMPTY	\N	\N	\N	\N	\N	\N
33	0	32	EMPTY	\N	\N	\N	\N	\N	\N
34	0	33	EMPTY	\N	\N	\N	\N	\N	\N
35	0	34	EMPTY	\N	\N	\N	\N	\N	\N
36	0	35	EMPTY	\N	\N	\N	\N	\N	\N
37	0	36	EMPTY	\N	\N	\N	\N	\N	\N
38	0	37	EMPTY	\N	\N	\N	\N	\N	\N
39	0	38	VALLEY	\N	\N	\N	\N	Valley (0, 38)	\N
40	0	39	EMPTY	\N	\N	\N	\N	\N	\N
41	0	40	EMPTY	\N	\N	\N	\N	\N	\N
42	0	41	RESOURCE	stone	3	\N	\N	\N	\N
43	0	42	EMPTY	\N	\N	\N	\N	\N	\N
44	0	43	NPC	\N	\N	10	\N	Barbarian Camp (Lv 10)	\N
45	0	44	EMPTY	\N	\N	\N	\N	\N	\N
46	0	45	EMPTY	\N	\N	\N	\N	\N	\N
47	0	46	EMPTY	\N	\N	\N	\N	\N	\N
48	0	47	EMPTY	\N	\N	\N	\N	\N	\N
49	0	48	RESOURCE	food	5	\N	\N	\N	\N
50	0	49	RESOURCE	food	5	\N	\N	\N	\N
51	0	50	EMPTY	\N	\N	\N	\N	\N	\N
52	0	51	EMPTY	\N	\N	\N	\N	\N	\N
53	0	52	EMPTY	\N	\N	\N	\N	\N	\N
54	0	53	VALLEY	\N	\N	\N	\N	Valley (0, 53)	\N
55	0	54	EMPTY	\N	\N	\N	\N	\N	\N
56	0	55	EMPTY	\N	\N	\N	\N	\N	\N
57	0	56	EMPTY	\N	\N	\N	\N	\N	\N
58	0	57	EMPTY	\N	\N	\N	\N	\N	\N
59	0	58	EMPTY	\N	\N	\N	\N	\N	\N
60	0	59	EMPTY	\N	\N	\N	\N	\N	\N
61	0	60	EMPTY	\N	\N	\N	\N	\N	\N
62	0	61	EMPTY	\N	\N	\N	\N	\N	\N
63	0	62	EMPTY	\N	\N	\N	\N	\N	\N
64	0	63	EMPTY	\N	\N	\N	\N	\N	\N
65	0	64	EMPTY	\N	\N	\N	\N	\N	\N
66	0	65	EMPTY	\N	\N	\N	\N	\N	\N
67	0	66	EMPTY	\N	\N	\N	\N	\N	\N
68	0	67	EMPTY	\N	\N	\N	\N	\N	\N
69	0	68	EMPTY	\N	\N	\N	\N	\N	\N
70	0	69	EMPTY	\N	\N	\N	\N	\N	\N
71	0	70	EMPTY	\N	\N	\N	\N	\N	\N
72	0	71	EMPTY	\N	\N	\N	\N	\N	\N
73	0	72	EMPTY	\N	\N	\N	\N	\N	\N
74	0	73	EMPTY	\N	\N	\N	\N	\N	\N
75	0	74	EMPTY	\N	\N	\N	\N	\N	\N
76	0	75	EMPTY	\N	\N	\N	\N	\N	\N
77	0	76	NPC	\N	\N	1	\N	Barbarian Camp (Lv 1)	\N
78	0	77	EMPTY	\N	\N	\N	\N	\N	\N
79	0	78	NPC	\N	\N	7	\N	Barbarian Camp (Lv 7)	\N
80	0	79	EMPTY	\N	\N	\N	\N	\N	\N
81	0	80	EMPTY	\N	\N	\N	\N	\N	\N
82	0	81	EMPTY	\N	\N	\N	\N	\N	\N
83	0	82	EMPTY	\N	\N	\N	\N	\N	\N
84	0	83	RESOURCE	iron	2	\N	\N	\N	\N
85	0	84	EMPTY	\N	\N	\N	\N	\N	\N
86	0	85	EMPTY	\N	\N	\N	\N	\N	\N
87	0	86	EMPTY	\N	\N	\N	\N	\N	\N
88	0	87	EMPTY	\N	\N	\N	\N	\N	\N
89	0	88	EMPTY	\N	\N	\N	\N	\N	\N
90	0	89	EMPTY	\N	\N	\N	\N	\N	\N
91	0	90	VALLEY	\N	\N	\N	\N	Valley (0, 90)	\N
92	0	91	EMPTY	\N	\N	\N	\N	\N	\N
93	0	92	EMPTY	\N	\N	\N	\N	\N	\N
94	0	93	EMPTY	\N	\N	\N	\N	\N	\N
95	0	94	EMPTY	\N	\N	\N	\N	\N	\N
96	0	95	EMPTY	\N	\N	\N	\N	\N	\N
97	0	96	VALLEY	\N	\N	\N	\N	Valley (0, 96)	\N
98	0	97	EMPTY	\N	\N	\N	\N	\N	\N
99	0	98	EMPTY	\N	\N	\N	\N	\N	\N
100	0	99	EMPTY	\N	\N	\N	\N	\N	\N
101	1	0	EMPTY	\N	\N	\N	\N	\N	\N
102	1	1	EMPTY	\N	\N	\N	\N	\N	\N
103	1	2	EMPTY	\N	\N	\N	\N	\N	\N
104	1	3	EMPTY	\N	\N	\N	\N	\N	\N
105	1	4	NPC	\N	\N	8	\N	Barbarian Camp (Lv 8)	\N
106	1	5	EMPTY	\N	\N	\N	\N	\N	\N
107	1	6	EMPTY	\N	\N	\N	\N	\N	\N
108	1	7	EMPTY	\N	\N	\N	\N	\N	\N
109	1	8	EMPTY	\N	\N	\N	\N	\N	\N
110	1	9	EMPTY	\N	\N	\N	\N	\N	\N
111	1	10	EMPTY	\N	\N	\N	\N	\N	\N
112	1	11	EMPTY	\N	\N	\N	\N	\N	\N
113	1	12	EMPTY	\N	\N	\N	\N	\N	\N
114	1	13	RESOURCE	stone	3	\N	\N	\N	\N
115	1	14	EMPTY	\N	\N	\N	\N	\N	\N
116	1	15	EMPTY	\N	\N	\N	\N	\N	\N
117	1	16	EMPTY	\N	\N	\N	\N	\N	\N
118	1	17	EMPTY	\N	\N	\N	\N	\N	\N
119	1	18	EMPTY	\N	\N	\N	\N	\N	\N
120	1	19	EMPTY	\N	\N	\N	\N	\N	\N
121	1	20	EMPTY	\N	\N	\N	\N	\N	\N
122	1	21	EMPTY	\N	\N	\N	\N	\N	\N
123	1	22	EMPTY	\N	\N	\N	\N	\N	\N
124	1	23	NPC	\N	\N	4	\N	Barbarian Camp (Lv 4)	\N
125	1	24	EMPTY	\N	\N	\N	\N	\N	\N
126	1	25	EMPTY	\N	\N	\N	\N	\N	\N
127	1	26	EMPTY	\N	\N	\N	\N	\N	\N
128	1	27	EMPTY	\N	\N	\N	\N	\N	\N
129	1	28	EMPTY	\N	\N	\N	\N	\N	\N
130	1	29	EMPTY	\N	\N	\N	\N	\N	\N
131	1	30	EMPTY	\N	\N	\N	\N	\N	\N
132	1	31	EMPTY	\N	\N	\N	\N	\N	\N
133	1	32	EMPTY	\N	\N	\N	\N	\N	\N
134	1	33	EMPTY	\N	\N	\N	\N	\N	\N
135	1	34	EMPTY	\N	\N	\N	\N	\N	\N
136	1	35	EMPTY	\N	\N	\N	\N	\N	\N
137	1	36	EMPTY	\N	\N	\N	\N	\N	\N
138	1	37	EMPTY	\N	\N	\N	\N	\N	\N
139	1	38	EMPTY	\N	\N	\N	\N	\N	\N
140	1	39	EMPTY	\N	\N	\N	\N	\N	\N
141	1	40	EMPTY	\N	\N	\N	\N	\N	\N
142	1	41	EMPTY	\N	\N	\N	\N	\N	\N
143	1	42	EMPTY	\N	\N	\N	\N	\N	\N
144	1	43	EMPTY	\N	\N	\N	\N	\N	\N
145	1	44	EMPTY	\N	\N	\N	\N	\N	\N
146	1	45	EMPTY	\N	\N	\N	\N	\N	\N
147	1	46	EMPTY	\N	\N	\N	\N	\N	\N
148	1	47	EMPTY	\N	\N	\N	\N	\N	\N
149	1	48	EMPTY	\N	\N	\N	\N	\N	\N
150	1	49	EMPTY	\N	\N	\N	\N	\N	\N
151	1	50	EMPTY	\N	\N	\N	\N	\N	\N
152	1	51	EMPTY	\N	\N	\N	\N	\N	\N
153	1	52	EMPTY	\N	\N	\N	\N	\N	\N
154	1	53	EMPTY	\N	\N	\N	\N	\N	\N
155	1	54	EMPTY	\N	\N	\N	\N	\N	\N
156	1	55	EMPTY	\N	\N	\N	\N	\N	\N
157	1	56	EMPTY	\N	\N	\N	\N	\N	\N
158	1	57	EMPTY	\N	\N	\N	\N	\N	\N
159	1	58	EMPTY	\N	\N	\N	\N	\N	\N
160	1	59	EMPTY	\N	\N	\N	\N	\N	\N
161	1	60	EMPTY	\N	\N	\N	\N	\N	\N
162	1	61	VALLEY	\N	\N	\N	\N	Valley (1, 61)	\N
163	1	62	RESOURCE	iron	4	\N	\N	\N	\N
164	1	63	EMPTY	\N	\N	\N	\N	\N	\N
165	1	64	RESOURCE	food	3	\N	\N	\N	\N
166	1	65	EMPTY	\N	\N	\N	\N	\N	\N
167	1	66	EMPTY	\N	\N	\N	\N	\N	\N
168	1	67	EMPTY	\N	\N	\N	\N	\N	\N
169	1	68	EMPTY	\N	\N	\N	\N	\N	\N
170	1	69	EMPTY	\N	\N	\N	\N	\N	\N
171	1	70	EMPTY	\N	\N	\N	\N	\N	\N
172	1	71	EMPTY	\N	\N	\N	\N	\N	\N
173	1	72	EMPTY	\N	\N	\N	\N	\N	\N
174	1	73	EMPTY	\N	\N	\N	\N	\N	\N
175	1	74	NPC	\N	\N	8	\N	Barbarian Camp (Lv 8)	\N
176	1	75	EMPTY	\N	\N	\N	\N	\N	\N
177	1	76	NPC	\N	\N	8	\N	Barbarian Camp (Lv 8)	\N
178	1	77	EMPTY	\N	\N	\N	\N	\N	\N
179	1	78	EMPTY	\N	\N	\N	\N	\N	\N
180	1	79	EMPTY	\N	\N	\N	\N	\N	\N
181	1	80	EMPTY	\N	\N	\N	\N	\N	\N
182	1	81	EMPTY	\N	\N	\N	\N	\N	\N
183	1	82	EMPTY	\N	\N	\N	\N	\N	\N
184	1	83	EMPTY	\N	\N	\N	\N	\N	\N
185	1	84	RESOURCE	stone	1	\N	\N	\N	\N
186	1	85	RESOURCE	stone	2	\N	\N	\N	\N
187	1	86	EMPTY	\N	\N	\N	\N	\N	\N
188	1	87	EMPTY	\N	\N	\N	\N	\N	\N
189	1	88	EMPTY	\N	\N	\N	\N	\N	\N
190	1	89	EMPTY	\N	\N	\N	\N	\N	\N
191	1	90	EMPTY	\N	\N	\N	\N	\N	\N
192	1	91	EMPTY	\N	\N	\N	\N	\N	\N
193	1	92	EMPTY	\N	\N	\N	\N	\N	\N
194	1	93	EMPTY	\N	\N	\N	\N	\N	\N
195	1	94	EMPTY	\N	\N	\N	\N	\N	\N
196	1	95	EMPTY	\N	\N	\N	\N	\N	\N
197	1	96	EMPTY	\N	\N	\N	\N	\N	\N
198	1	97	NPC	\N	\N	9	\N	Barbarian Camp (Lv 9)	\N
199	1	98	VALLEY	\N	\N	\N	\N	Valley (1, 98)	\N
200	1	99	EMPTY	\N	\N	\N	\N	\N	\N
201	2	0	EMPTY	\N	\N	\N	\N	\N	\N
202	2	1	RESOURCE	stone	3	\N	\N	\N	\N
203	2	2	EMPTY	\N	\N	\N	\N	\N	\N
204	2	3	EMPTY	\N	\N	\N	\N	\N	\N
205	2	4	EMPTY	\N	\N	\N	\N	\N	\N
206	2	5	EMPTY	\N	\N	\N	\N	\N	\N
207	2	6	EMPTY	\N	\N	\N	\N	\N	\N
208	2	7	EMPTY	\N	\N	\N	\N	\N	\N
209	2	8	VALLEY	\N	\N	\N	\N	Valley (2, 8)	\N
210	2	9	EMPTY	\N	\N	\N	\N	\N	\N
211	2	10	EMPTY	\N	\N	\N	\N	\N	\N
212	2	11	EMPTY	\N	\N	\N	\N	\N	\N
213	2	12	EMPTY	\N	\N	\N	\N	\N	\N
214	2	13	RESOURCE	wood	4	\N	\N	\N	\N
215	2	14	EMPTY	\N	\N	\N	\N	\N	\N
216	2	15	EMPTY	\N	\N	\N	\N	\N	\N
217	2	16	EMPTY	\N	\N	\N	\N	\N	\N
218	2	17	RESOURCE	food	1	\N	\N	\N	\N
219	2	18	EMPTY	\N	\N	\N	\N	\N	\N
220	2	19	EMPTY	\N	\N	\N	\N	\N	\N
221	2	20	EMPTY	\N	\N	\N	\N	\N	\N
222	2	21	RESOURCE	food	1	\N	\N	\N	\N
223	2	22	EMPTY	\N	\N	\N	\N	\N	\N
224	2	23	NPC	\N	\N	5	\N	Barbarian Camp (Lv 5)	\N
225	2	24	EMPTY	\N	\N	\N	\N	\N	\N
226	2	25	EMPTY	\N	\N	\N	\N	\N	\N
227	2	26	EMPTY	\N	\N	\N	\N	\N	\N
228	2	27	EMPTY	\N	\N	\N	\N	\N	\N
229	2	28	EMPTY	\N	\N	\N	\N	\N	\N
230	2	29	EMPTY	\N	\N	\N	\N	\N	\N
231	2	30	EMPTY	\N	\N	\N	\N	\N	\N
232	2	31	EMPTY	\N	\N	\N	\N	\N	\N
233	2	32	EMPTY	\N	\N	\N	\N	\N	\N
234	2	33	EMPTY	\N	\N	\N	\N	\N	\N
235	2	34	EMPTY	\N	\N	\N	\N	\N	\N
236	2	35	EMPTY	\N	\N	\N	\N	\N	\N
237	2	36	EMPTY	\N	\N	\N	\N	\N	\N
238	2	37	EMPTY	\N	\N	\N	\N	\N	\N
239	2	38	RESOURCE	stone	2	\N	\N	\N	\N
240	2	39	NPC	\N	\N	5	\N	Barbarian Camp (Lv 5)	\N
241	2	40	EMPTY	\N	\N	\N	\N	\N	\N
242	2	41	RESOURCE	stone	5	\N	\N	\N	\N
243	2	42	RESOURCE	stone	3	\N	\N	\N	\N
244	2	43	EMPTY	\N	\N	\N	\N	\N	\N
245	2	44	VALLEY	\N	\N	\N	\N	Valley (2, 44)	\N
246	2	45	NPC	\N	\N	8	\N	Barbarian Camp (Lv 8)	\N
247	2	46	EMPTY	\N	\N	\N	\N	\N	\N
248	2	47	EMPTY	\N	\N	\N	\N	\N	\N
249	2	48	EMPTY	\N	\N	\N	\N	\N	\N
250	2	49	EMPTY	\N	\N	\N	\N	\N	\N
251	2	50	EMPTY	\N	\N	\N	\N	\N	\N
252	2	51	EMPTY	\N	\N	\N	\N	\N	\N
253	2	52	EMPTY	\N	\N	\N	\N	\N	\N
254	2	53	EMPTY	\N	\N	\N	\N	\N	\N
255	2	54	EMPTY	\N	\N	\N	\N	\N	\N
256	2	55	EMPTY	\N	\N	\N	\N	\N	\N
257	2	56	RESOURCE	iron	4	\N	\N	\N	\N
258	2	57	EMPTY	\N	\N	\N	\N	\N	\N
259	2	58	EMPTY	\N	\N	\N	\N	\N	\N
260	2	59	EMPTY	\N	\N	\N	\N	\N	\N
261	2	60	EMPTY	\N	\N	\N	\N	\N	\N
262	2	61	RESOURCE	food	2	\N	\N	\N	\N
263	2	62	EMPTY	\N	\N	\N	\N	\N	\N
264	2	63	EMPTY	\N	\N	\N	\N	\N	\N
265	2	64	EMPTY	\N	\N	\N	\N	\N	\N
266	2	65	EMPTY	\N	\N	\N	\N	\N	\N
267	2	66	EMPTY	\N	\N	\N	\N	\N	\N
268	2	67	EMPTY	\N	\N	\N	\N	\N	\N
269	2	68	EMPTY	\N	\N	\N	\N	\N	\N
270	2	69	NPC	\N	\N	1	\N	Barbarian Camp (Lv 1)	\N
271	2	70	EMPTY	\N	\N	\N	\N	\N	\N
272	2	71	RESOURCE	food	5	\N	\N	\N	\N
273	2	72	EMPTY	\N	\N	\N	\N	\N	\N
274	2	73	EMPTY	\N	\N	\N	\N	\N	\N
275	2	74	EMPTY	\N	\N	\N	\N	\N	\N
276	2	75	EMPTY	\N	\N	\N	\N	\N	\N
277	2	76	EMPTY	\N	\N	\N	\N	\N	\N
278	2	77	EMPTY	\N	\N	\N	\N	\N	\N
280	2	79	EMPTY	\N	\N	\N	\N	\N	\N
281	2	80	EMPTY	\N	\N	\N	\N	\N	\N
282	2	81	EMPTY	\N	\N	\N	\N	\N	\N
283	2	82	EMPTY	\N	\N	\N	\N	\N	\N
284	2	83	EMPTY	\N	\N	\N	\N	\N	\N
285	2	84	RESOURCE	wood	4	\N	\N	\N	\N
286	2	85	RESOURCE	stone	5	\N	\N	\N	\N
287	2	86	EMPTY	\N	\N	\N	\N	\N	\N
288	2	87	EMPTY	\N	\N	\N	\N	\N	\N
289	2	88	EMPTY	\N	\N	\N	\N	\N	\N
290	2	89	EMPTY	\N	\N	\N	\N	\N	\N
291	2	90	EMPTY	\N	\N	\N	\N	\N	\N
292	2	91	EMPTY	\N	\N	\N	\N	\N	\N
293	2	92	EMPTY	\N	\N	\N	\N	\N	\N
294	2	93	EMPTY	\N	\N	\N	\N	\N	\N
295	2	94	NPC	\N	\N	1	\N	Barbarian Camp (Lv 1)	\N
296	2	95	EMPTY	\N	\N	\N	\N	\N	\N
297	2	96	EMPTY	\N	\N	\N	\N	\N	\N
298	2	97	EMPTY	\N	\N	\N	\N	\N	\N
299	2	98	EMPTY	\N	\N	\N	\N	\N	\N
300	2	99	EMPTY	\N	\N	\N	\N	\N	\N
301	3	0	VALLEY	\N	\N	\N	\N	Valley (3, 0)	\N
302	3	1	EMPTY	\N	\N	\N	\N	\N	\N
303	3	2	EMPTY	\N	\N	\N	\N	\N	\N
304	3	3	NPC	\N	\N	4	\N	Barbarian Camp (Lv 4)	\N
305	3	4	EMPTY	\N	\N	\N	\N	\N	\N
306	3	5	EMPTY	\N	\N	\N	\N	\N	\N
307	3	6	EMPTY	\N	\N	\N	\N	\N	\N
308	3	7	EMPTY	\N	\N	\N	\N	\N	\N
309	3	8	EMPTY	\N	\N	\N	\N	\N	\N
310	3	9	EMPTY	\N	\N	\N	\N	\N	\N
311	3	10	EMPTY	\N	\N	\N	\N	\N	\N
312	3	11	EMPTY	\N	\N	\N	\N	\N	\N
313	3	12	EMPTY	\N	\N	\N	\N	\N	\N
314	3	13	EMPTY	\N	\N	\N	\N	\N	\N
315	3	14	RESOURCE	stone	1	\N	\N	\N	\N
316	3	15	EMPTY	\N	\N	\N	\N	\N	\N
317	3	16	EMPTY	\N	\N	\N	\N	\N	\N
318	3	17	EMPTY	\N	\N	\N	\N	\N	\N
319	3	18	EMPTY	\N	\N	\N	\N	\N	\N
320	3	19	EMPTY	\N	\N	\N	\N	\N	\N
321	3	20	EMPTY	\N	\N	\N	\N	\N	\N
322	3	21	EMPTY	\N	\N	\N	\N	\N	\N
323	3	22	EMPTY	\N	\N	\N	\N	\N	\N
324	3	23	EMPTY	\N	\N	\N	\N	\N	\N
325	3	24	RESOURCE	wood	2	\N	\N	\N	\N
326	3	25	EMPTY	\N	\N	\N	\N	\N	\N
327	3	26	EMPTY	\N	\N	\N	\N	\N	\N
328	3	27	EMPTY	\N	\N	\N	\N	\N	\N
329	3	28	EMPTY	\N	\N	\N	\N	\N	\N
330	3	29	EMPTY	\N	\N	\N	\N	\N	\N
331	3	30	EMPTY	\N	\N	\N	\N	\N	\N
332	3	31	EMPTY	\N	\N	\N	\N	\N	\N
333	3	32	EMPTY	\N	\N	\N	\N	\N	\N
334	3	33	EMPTY	\N	\N	\N	\N	\N	\N
335	3	34	NPC	\N	\N	2	\N	Barbarian Camp (Lv 2)	\N
336	3	35	EMPTY	\N	\N	\N	\N	\N	\N
337	3	36	EMPTY	\N	\N	\N	\N	\N	\N
338	3	37	EMPTY	\N	\N	\N	\N	\N	\N
339	3	38	EMPTY	\N	\N	\N	\N	\N	\N
340	3	39	EMPTY	\N	\N	\N	\N	\N	\N
341	3	40	EMPTY	\N	\N	\N	\N	\N	\N
342	3	41	NPC	\N	\N	7	\N	Barbarian Camp (Lv 7)	\N
343	3	42	EMPTY	\N	\N	\N	\N	\N	\N
344	3	43	EMPTY	\N	\N	\N	\N	\N	\N
345	3	44	EMPTY	\N	\N	\N	\N	\N	\N
346	3	45	RESOURCE	wood	2	\N	\N	\N	\N
347	3	46	RESOURCE	stone	2	\N	\N	\N	\N
348	3	47	EMPTY	\N	\N	\N	\N	\N	\N
349	3	48	EMPTY	\N	\N	\N	\N	\N	\N
350	3	49	EMPTY	\N	\N	\N	\N	\N	\N
351	3	50	EMPTY	\N	\N	\N	\N	\N	\N
352	3	51	EMPTY	\N	\N	\N	\N	\N	\N
353	3	52	EMPTY	\N	\N	\N	\N	\N	\N
354	3	53	EMPTY	\N	\N	\N	\N	\N	\N
355	3	54	EMPTY	\N	\N	\N	\N	\N	\N
356	3	55	EMPTY	\N	\N	\N	\N	\N	\N
357	3	56	EMPTY	\N	\N	\N	\N	\N	\N
358	3	57	EMPTY	\N	\N	\N	\N	\N	\N
359	3	58	EMPTY	\N	\N	\N	\N	\N	\N
360	3	59	EMPTY	\N	\N	\N	\N	\N	\N
361	3	60	EMPTY	\N	\N	\N	\N	\N	\N
362	3	61	EMPTY	\N	\N	\N	\N	\N	\N
363	3	62	EMPTY	\N	\N	\N	\N	\N	\N
364	3	63	EMPTY	\N	\N	\N	\N	\N	\N
365	3	64	RESOURCE	iron	5	\N	\N	\N	\N
366	3	65	NPC	\N	\N	3	\N	Barbarian Camp (Lv 3)	\N
367	3	66	EMPTY	\N	\N	\N	\N	\N	\N
368	3	67	EMPTY	\N	\N	\N	\N	\N	\N
369	3	68	EMPTY	\N	\N	\N	\N	\N	\N
370	3	69	EMPTY	\N	\N	\N	\N	\N	\N
371	3	70	EMPTY	\N	\N	\N	\N	\N	\N
372	3	71	EMPTY	\N	\N	\N	\N	\N	\N
373	3	72	EMPTY	\N	\N	\N	\N	\N	\N
374	3	73	EMPTY	\N	\N	\N	\N	\N	\N
375	3	74	EMPTY	\N	\N	\N	\N	\N	\N
376	3	75	EMPTY	\N	\N	\N	\N	\N	\N
377	3	76	EMPTY	\N	\N	\N	\N	\N	\N
378	3	77	EMPTY	\N	\N	\N	\N	\N	\N
379	3	78	RESOURCE	stone	3	\N	\N	\N	\N
380	3	79	EMPTY	\N	\N	\N	\N	\N	\N
381	3	80	EMPTY	\N	\N	\N	\N	\N	\N
382	3	81	NPC	\N	\N	4	\N	Barbarian Camp (Lv 4)	\N
383	3	82	EMPTY	\N	\N	\N	\N	\N	\N
384	3	83	EMPTY	\N	\N	\N	\N	\N	\N
385	3	84	EMPTY	\N	\N	\N	\N	\N	\N
386	3	85	EMPTY	\N	\N	\N	\N	\N	\N
387	3	86	EMPTY	\N	\N	\N	\N	\N	\N
388	3	87	EMPTY	\N	\N	\N	\N	\N	\N
389	3	88	EMPTY	\N	\N	\N	\N	\N	\N
390	3	89	EMPTY	\N	\N	\N	\N	\N	\N
391	3	90	EMPTY	\N	\N	\N	\N	\N	\N
392	3	91	EMPTY	\N	\N	\N	\N	\N	\N
393	3	92	EMPTY	\N	\N	\N	\N	\N	\N
394	3	93	RESOURCE	wood	4	\N	\N	\N	\N
395	3	94	EMPTY	\N	\N	\N	\N	\N	\N
396	3	95	EMPTY	\N	\N	\N	\N	\N	\N
397	3	96	NPC	\N	\N	3	\N	Barbarian Camp (Lv 3)	\N
398	3	97	RESOURCE	food	3	\N	\N	\N	\N
399	3	98	EMPTY	\N	\N	\N	\N	\N	\N
400	3	99	EMPTY	\N	\N	\N	\N	\N	\N
401	4	0	EMPTY	\N	\N	\N	\N	\N	\N
402	4	1	EMPTY	\N	\N	\N	\N	\N	\N
403	4	2	EMPTY	\N	\N	\N	\N	\N	\N
404	4	3	EMPTY	\N	\N	\N	\N	\N	\N
405	4	4	EMPTY	\N	\N	\N	\N	\N	\N
406	4	5	NPC	\N	\N	8	\N	Barbarian Camp (Lv 8)	\N
407	4	6	EMPTY	\N	\N	\N	\N	\N	\N
408	4	7	EMPTY	\N	\N	\N	\N	\N	\N
409	4	8	EMPTY	\N	\N	\N	\N	\N	\N
410	4	9	EMPTY	\N	\N	\N	\N	\N	\N
411	4	10	EMPTY	\N	\N	\N	\N	\N	\N
412	4	11	EMPTY	\N	\N	\N	\N	\N	\N
413	4	12	EMPTY	\N	\N	\N	\N	\N	\N
414	4	13	EMPTY	\N	\N	\N	\N	\N	\N
415	4	14	EMPTY	\N	\N	\N	\N	\N	\N
416	4	15	EMPTY	\N	\N	\N	\N	\N	\N
417	4	16	EMPTY	\N	\N	\N	\N	\N	\N
418	4	17	EMPTY	\N	\N	\N	\N	\N	\N
419	4	18	EMPTY	\N	\N	\N	\N	\N	\N
420	4	19	EMPTY	\N	\N	\N	\N	\N	\N
421	4	20	EMPTY	\N	\N	\N	\N	\N	\N
422	4	21	EMPTY	\N	\N	\N	\N	\N	\N
423	4	22	EMPTY	\N	\N	\N	\N	\N	\N
424	4	23	EMPTY	\N	\N	\N	\N	\N	\N
425	4	24	EMPTY	\N	\N	\N	\N	\N	\N
426	4	25	EMPTY	\N	\N	\N	\N	\N	\N
427	4	26	EMPTY	\N	\N	\N	\N	\N	\N
428	4	27	EMPTY	\N	\N	\N	\N	\N	\N
429	4	28	EMPTY	\N	\N	\N	\N	\N	\N
430	4	29	EMPTY	\N	\N	\N	\N	\N	\N
431	4	30	EMPTY	\N	\N	\N	\N	\N	\N
432	4	31	EMPTY	\N	\N	\N	\N	\N	\N
433	4	32	NPC	\N	\N	1	\N	Barbarian Camp (Lv 1)	\N
434	4	33	EMPTY	\N	\N	\N	\N	\N	\N
435	4	34	EMPTY	\N	\N	\N	\N	\N	\N
436	4	35	EMPTY	\N	\N	\N	\N	\N	\N
437	4	36	EMPTY	\N	\N	\N	\N	\N	\N
438	4	37	EMPTY	\N	\N	\N	\N	\N	\N
439	4	38	EMPTY	\N	\N	\N	\N	\N	\N
440	4	39	EMPTY	\N	\N	\N	\N	\N	\N
441	4	40	EMPTY	\N	\N	\N	\N	\N	\N
442	4	41	EMPTY	\N	\N	\N	\N	\N	\N
443	4	42	EMPTY	\N	\N	\N	\N	\N	\N
444	4	43	RESOURCE	food	1	\N	\N	\N	\N
445	4	44	VALLEY	\N	\N	\N	\N	Valley (4, 44)	\N
446	4	45	RESOURCE	wood	2	\N	\N	\N	\N
447	4	46	NPC	\N	\N	9	\N	Barbarian Camp (Lv 9)	\N
448	4	47	EMPTY	\N	\N	\N	\N	\N	\N
449	4	48	EMPTY	\N	\N	\N	\N	\N	\N
450	4	49	NPC	\N	\N	7	\N	Barbarian Camp (Lv 7)	\N
451	4	50	EMPTY	\N	\N	\N	\N	\N	\N
452	4	51	EMPTY	\N	\N	\N	\N	\N	\N
453	4	52	EMPTY	\N	\N	\N	\N	\N	\N
454	4	53	EMPTY	\N	\N	\N	\N	\N	\N
455	4	54	EMPTY	\N	\N	\N	\N	\N	\N
456	4	55	EMPTY	\N	\N	\N	\N	\N	\N
457	4	56	EMPTY	\N	\N	\N	\N	\N	\N
458	4	57	EMPTY	\N	\N	\N	\N	\N	\N
459	4	58	EMPTY	\N	\N	\N	\N	\N	\N
460	4	59	EMPTY	\N	\N	\N	\N	\N	\N
461	4	60	RESOURCE	stone	5	\N	\N	\N	\N
462	4	61	RESOURCE	food	1	\N	\N	\N	\N
463	4	62	EMPTY	\N	\N	\N	\N	\N	\N
464	4	63	EMPTY	\N	\N	\N	\N	\N	\N
465	4	64	EMPTY	\N	\N	\N	\N	\N	\N
466	4	65	EMPTY	\N	\N	\N	\N	\N	\N
467	4	66	EMPTY	\N	\N	\N	\N	\N	\N
468	4	67	EMPTY	\N	\N	\N	\N	\N	\N
469	4	68	EMPTY	\N	\N	\N	\N	\N	\N
470	4	69	VALLEY	\N	\N	\N	\N	Valley (4, 69)	\N
471	4	70	EMPTY	\N	\N	\N	\N	\N	\N
472	4	71	EMPTY	\N	\N	\N	\N	\N	\N
473	4	72	EMPTY	\N	\N	\N	\N	\N	\N
474	4	73	VALLEY	\N	\N	\N	\N	Valley (4, 73)	\N
475	4	74	EMPTY	\N	\N	\N	\N	\N	\N
476	4	75	EMPTY	\N	\N	\N	\N	\N	\N
477	4	76	EMPTY	\N	\N	\N	\N	\N	\N
478	4	77	EMPTY	\N	\N	\N	\N	\N	\N
479	4	78	EMPTY	\N	\N	\N	\N	\N	\N
480	4	79	EMPTY	\N	\N	\N	\N	\N	\N
481	4	80	EMPTY	\N	\N	\N	\N	\N	\N
482	4	81	EMPTY	\N	\N	\N	\N	\N	\N
483	4	82	EMPTY	\N	\N	\N	\N	\N	\N
484	4	83	EMPTY	\N	\N	\N	\N	\N	\N
485	4	84	EMPTY	\N	\N	\N	\N	\N	\N
486	4	85	EMPTY	\N	\N	\N	\N	\N	\N
487	4	86	EMPTY	\N	\N	\N	\N	\N	\N
488	4	87	EMPTY	\N	\N	\N	\N	\N	\N
489	4	88	EMPTY	\N	\N	\N	\N	\N	\N
490	4	89	EMPTY	\N	\N	\N	\N	\N	\N
491	4	90	EMPTY	\N	\N	\N	\N	\N	\N
492	4	91	EMPTY	\N	\N	\N	\N	\N	\N
493	4	92	EMPTY	\N	\N	\N	\N	\N	\N
494	4	93	EMPTY	\N	\N	\N	\N	\N	\N
495	4	94	EMPTY	\N	\N	\N	\N	\N	\N
496	4	95	EMPTY	\N	\N	\N	\N	\N	\N
497	4	96	VALLEY	\N	\N	\N	\N	Valley (4, 96)	\N
498	4	97	EMPTY	\N	\N	\N	\N	\N	\N
499	4	98	EMPTY	\N	\N	\N	\N	\N	\N
500	4	99	EMPTY	\N	\N	\N	\N	\N	\N
501	5	0	EMPTY	\N	\N	\N	\N	\N	\N
502	5	1	EMPTY	\N	\N	\N	\N	\N	\N
503	5	2	EMPTY	\N	\N	\N	\N	\N	\N
504	5	3	EMPTY	\N	\N	\N	\N	\N	\N
505	5	4	RESOURCE	wood	5	\N	\N	\N	\N
506	5	5	EMPTY	\N	\N	\N	\N	\N	\N
507	5	6	EMPTY	\N	\N	\N	\N	\N	\N
508	5	7	EMPTY	\N	\N	\N	\N	\N	\N
509	5	8	EMPTY	\N	\N	\N	\N	\N	\N
510	5	9	NPC	\N	\N	7	\N	Barbarian Camp (Lv 7)	\N
511	5	10	VALLEY	\N	\N	\N	\N	Valley (5, 10)	\N
512	5	11	EMPTY	\N	\N	\N	\N	\N	\N
513	5	12	EMPTY	\N	\N	\N	\N	\N	\N
514	5	13	EMPTY	\N	\N	\N	\N	\N	\N
515	5	14	EMPTY	\N	\N	\N	\N	\N	\N
516	5	15	EMPTY	\N	\N	\N	\N	\N	\N
517	5	16	EMPTY	\N	\N	\N	\N	\N	\N
518	5	17	EMPTY	\N	\N	\N	\N	\N	\N
519	5	18	EMPTY	\N	\N	\N	\N	\N	\N
520	5	19	EMPTY	\N	\N	\N	\N	\N	\N
521	5	20	EMPTY	\N	\N	\N	\N	\N	\N
522	5	21	EMPTY	\N	\N	\N	\N	\N	\N
523	5	22	EMPTY	\N	\N	\N	\N	\N	\N
524	5	23	EMPTY	\N	\N	\N	\N	\N	\N
525	5	24	EMPTY	\N	\N	\N	\N	\N	\N
526	5	25	EMPTY	\N	\N	\N	\N	\N	\N
527	5	26	EMPTY	\N	\N	\N	\N	\N	\N
528	5	27	EMPTY	\N	\N	\N	\N	\N	\N
529	5	28	EMPTY	\N	\N	\N	\N	\N	\N
530	5	29	EMPTY	\N	\N	\N	\N	\N	\N
531	5	30	EMPTY	\N	\N	\N	\N	\N	\N
532	5	31	EMPTY	\N	\N	\N	\N	\N	\N
533	5	32	RESOURCE	iron	5	\N	\N	\N	\N
534	5	33	EMPTY	\N	\N	\N	\N	\N	\N
535	5	34	EMPTY	\N	\N	\N	\N	\N	\N
536	5	35	EMPTY	\N	\N	\N	\N	\N	\N
537	5	36	NPC	\N	\N	4	\N	Barbarian Camp (Lv 4)	\N
538	5	37	EMPTY	\N	\N	\N	\N	\N	\N
539	5	38	EMPTY	\N	\N	\N	\N	\N	\N
540	5	39	EMPTY	\N	\N	\N	\N	\N	\N
541	5	40	EMPTY	\N	\N	\N	\N	\N	\N
542	5	41	RESOURCE	wood	5	\N	\N	\N	\N
543	5	42	EMPTY	\N	\N	\N	\N	\N	\N
544	5	43	EMPTY	\N	\N	\N	\N	\N	\N
545	5	44	EMPTY	\N	\N	\N	\N	\N	\N
546	5	45	EMPTY	\N	\N	\N	\N	\N	\N
547	5	46	EMPTY	\N	\N	\N	\N	\N	\N
548	5	47	EMPTY	\N	\N	\N	\N	\N	\N
549	5	48	VALLEY	\N	\N	\N	\N	Valley (5, 48)	\N
550	5	49	EMPTY	\N	\N	\N	\N	\N	\N
551	5	50	EMPTY	\N	\N	\N	\N	\N	\N
552	5	51	RESOURCE	iron	5	\N	\N	\N	\N
553	5	52	EMPTY	\N	\N	\N	\N	\N	\N
554	5	53	EMPTY	\N	\N	\N	\N	\N	\N
555	5	54	EMPTY	\N	\N	\N	\N	\N	\N
556	5	55	EMPTY	\N	\N	\N	\N	\N	\N
557	5	56	EMPTY	\N	\N	\N	\N	\N	\N
558	5	57	EMPTY	\N	\N	\N	\N	\N	\N
559	5	58	EMPTY	\N	\N	\N	\N	\N	\N
560	5	59	NPC	\N	\N	9	\N	Barbarian Camp (Lv 9)	\N
561	5	60	EMPTY	\N	\N	\N	\N	\N	\N
562	5	61	RESOURCE	stone	3	\N	\N	\N	\N
563	5	62	EMPTY	\N	\N	\N	\N	\N	\N
564	5	63	EMPTY	\N	\N	\N	\N	\N	\N
565	5	64	EMPTY	\N	\N	\N	\N	\N	\N
566	5	65	EMPTY	\N	\N	\N	\N	\N	\N
567	5	66	EMPTY	\N	\N	\N	\N	\N	\N
568	5	67	EMPTY	\N	\N	\N	\N	\N	\N
569	5	68	EMPTY	\N	\N	\N	\N	\N	\N
570	5	69	EMPTY	\N	\N	\N	\N	\N	\N
571	5	70	EMPTY	\N	\N	\N	\N	\N	\N
572	5	71	EMPTY	\N	\N	\N	\N	\N	\N
573	5	72	EMPTY	\N	\N	\N	\N	\N	\N
574	5	73	EMPTY	\N	\N	\N	\N	\N	\N
575	5	74	EMPTY	\N	\N	\N	\N	\N	\N
576	5	75	EMPTY	\N	\N	\N	\N	\N	\N
577	5	76	EMPTY	\N	\N	\N	\N	\N	\N
578	5	77	EMPTY	\N	\N	\N	\N	\N	\N
579	5	78	EMPTY	\N	\N	\N	\N	\N	\N
580	5	79	EMPTY	\N	\N	\N	\N	\N	\N
581	5	80	EMPTY	\N	\N	\N	\N	\N	\N
582	5	81	EMPTY	\N	\N	\N	\N	\N	\N
583	5	82	EMPTY	\N	\N	\N	\N	\N	\N
584	5	83	EMPTY	\N	\N	\N	\N	\N	\N
585	5	84	NPC	\N	\N	3	\N	Barbarian Camp (Lv 3)	\N
586	5	85	EMPTY	\N	\N	\N	\N	\N	\N
587	5	86	EMPTY	\N	\N	\N	\N	\N	\N
588	5	87	EMPTY	\N	\N	\N	\N	\N	\N
589	5	88	EMPTY	\N	\N	\N	\N	\N	\N
590	5	89	EMPTY	\N	\N	\N	\N	\N	\N
591	5	90	EMPTY	\N	\N	\N	\N	\N	\N
592	5	91	EMPTY	\N	\N	\N	\N	\N	\N
593	5	92	EMPTY	\N	\N	\N	\N	\N	\N
594	5	93	EMPTY	\N	\N	\N	\N	\N	\N
595	5	94	EMPTY	\N	\N	\N	\N	\N	\N
596	5	95	EMPTY	\N	\N	\N	\N	\N	\N
597	5	96	EMPTY	\N	\N	\N	\N	\N	\N
598	5	97	EMPTY	\N	\N	\N	\N	\N	\N
599	5	98	EMPTY	\N	\N	\N	\N	\N	\N
600	5	99	EMPTY	\N	\N	\N	\N	\N	\N
601	6	0	EMPTY	\N	\N	\N	\N	\N	\N
602	6	1	EMPTY	\N	\N	\N	\N	\N	\N
603	6	2	EMPTY	\N	\N	\N	\N	\N	\N
604	6	3	EMPTY	\N	\N	\N	\N	\N	\N
605	6	4	EMPTY	\N	\N	\N	\N	\N	\N
606	6	5	EMPTY	\N	\N	\N	\N	\N	\N
607	6	6	EMPTY	\N	\N	\N	\N	\N	\N
608	6	7	NPC	\N	\N	6	\N	Barbarian Camp (Lv 6)	\N
609	6	8	EMPTY	\N	\N	\N	\N	\N	\N
610	6	9	EMPTY	\N	\N	\N	\N	\N	\N
611	6	10	EMPTY	\N	\N	\N	\N	\N	\N
612	6	11	EMPTY	\N	\N	\N	\N	\N	\N
613	6	12	EMPTY	\N	\N	\N	\N	\N	\N
614	6	13	EMPTY	\N	\N	\N	\N	\N	\N
615	6	14	RESOURCE	stone	1	\N	\N	\N	\N
616	6	15	RESOURCE	stone	3	\N	\N	\N	\N
617	6	16	EMPTY	\N	\N	\N	\N	\N	\N
618	6	17	EMPTY	\N	\N	\N	\N	\N	\N
619	6	18	EMPTY	\N	\N	\N	\N	\N	\N
620	6	19	EMPTY	\N	\N	\N	\N	\N	\N
621	6	20	EMPTY	\N	\N	\N	\N	\N	\N
622	6	21	EMPTY	\N	\N	\N	\N	\N	\N
623	6	22	NPC	\N	\N	9	\N	Barbarian Camp (Lv 9)	\N
624	6	23	EMPTY	\N	\N	\N	\N	\N	\N
625	6	24	EMPTY	\N	\N	\N	\N	\N	\N
626	6	25	RESOURCE	wood	5	\N	\N	\N	\N
627	6	26	EMPTY	\N	\N	\N	\N	\N	\N
628	6	27	VALLEY	\N	\N	\N	\N	Valley (6, 27)	\N
629	6	28	EMPTY	\N	\N	\N	\N	\N	\N
630	6	29	EMPTY	\N	\N	\N	\N	\N	\N
631	6	30	EMPTY	\N	\N	\N	\N	\N	\N
632	6	31	EMPTY	\N	\N	\N	\N	\N	\N
633	6	32	NPC	\N	\N	5	\N	Barbarian Camp (Lv 5)	\N
634	6	33	EMPTY	\N	\N	\N	\N	\N	\N
635	6	34	EMPTY	\N	\N	\N	\N	\N	\N
636	6	35	EMPTY	\N	\N	\N	\N	\N	\N
637	6	36	EMPTY	\N	\N	\N	\N	\N	\N
638	6	37	EMPTY	\N	\N	\N	\N	\N	\N
639	6	38	EMPTY	\N	\N	\N	\N	\N	\N
640	6	39	EMPTY	\N	\N	\N	\N	\N	\N
641	6	40	EMPTY	\N	\N	\N	\N	\N	\N
642	6	41	EMPTY	\N	\N	\N	\N	\N	\N
643	6	42	EMPTY	\N	\N	\N	\N	\N	\N
644	6	43	EMPTY	\N	\N	\N	\N	\N	\N
645	6	44	EMPTY	\N	\N	\N	\N	\N	\N
646	6	45	RESOURCE	wood	1	\N	\N	\N	\N
647	6	46	RESOURCE	food	4	\N	\N	\N	\N
648	6	47	EMPTY	\N	\N	\N	\N	\N	\N
649	6	48	EMPTY	\N	\N	\N	\N	\N	\N
650	6	49	NPC	\N	\N	3	\N	Barbarian Camp (Lv 3)	\N
651	6	50	EMPTY	\N	\N	\N	\N	\N	\N
652	6	51	EMPTY	\N	\N	\N	\N	\N	\N
653	6	52	EMPTY	\N	\N	\N	\N	\N	\N
654	6	53	RESOURCE	food	5	\N	\N	\N	\N
655	6	54	EMPTY	\N	\N	\N	\N	\N	\N
656	6	55	EMPTY	\N	\N	\N	\N	\N	\N
657	6	56	EMPTY	\N	\N	\N	\N	\N	\N
658	6	57	EMPTY	\N	\N	\N	\N	\N	\N
659	6	58	EMPTY	\N	\N	\N	\N	\N	\N
660	6	59	NPC	\N	\N	3	\N	Barbarian Camp (Lv 3)	\N
661	6	60	NPC	\N	\N	8	\N	Barbarian Camp (Lv 8)	\N
662	6	61	EMPTY	\N	\N	\N	\N	\N	\N
663	6	62	EMPTY	\N	\N	\N	\N	\N	\N
664	6	63	EMPTY	\N	\N	\N	\N	\N	\N
665	6	64	EMPTY	\N	\N	\N	\N	\N	\N
666	6	65	EMPTY	\N	\N	\N	\N	\N	\N
667	6	66	EMPTY	\N	\N	\N	\N	\N	\N
668	6	67	EMPTY	\N	\N	\N	\N	\N	\N
669	6	68	EMPTY	\N	\N	\N	\N	\N	\N
670	6	69	EMPTY	\N	\N	\N	\N	\N	\N
671	6	70	EMPTY	\N	\N	\N	\N	\N	\N
672	6	71	EMPTY	\N	\N	\N	\N	\N	\N
673	6	72	EMPTY	\N	\N	\N	\N	\N	\N
674	6	73	EMPTY	\N	\N	\N	\N	\N	\N
675	6	74	EMPTY	\N	\N	\N	\N	\N	\N
676	6	75	EMPTY	\N	\N	\N	\N	\N	\N
677	6	76	EMPTY	\N	\N	\N	\N	\N	\N
678	6	77	NPC	\N	\N	7	\N	Barbarian Camp (Lv 7)	\N
679	6	78	EMPTY	\N	\N	\N	\N	\N	\N
680	6	79	EMPTY	\N	\N	\N	\N	\N	\N
681	6	80	EMPTY	\N	\N	\N	\N	\N	\N
682	6	81	RESOURCE	iron	5	\N	\N	\N	\N
683	6	82	EMPTY	\N	\N	\N	\N	\N	\N
684	6	83	EMPTY	\N	\N	\N	\N	\N	\N
685	6	84	EMPTY	\N	\N	\N	\N	\N	\N
686	6	85	NPC	\N	\N	6	\N	Barbarian Camp (Lv 6)	\N
687	6	86	EMPTY	\N	\N	\N	\N	\N	\N
688	6	87	EMPTY	\N	\N	\N	\N	\N	\N
689	6	88	EMPTY	\N	\N	\N	\N	\N	\N
690	6	89	EMPTY	\N	\N	\N	\N	\N	\N
691	6	90	EMPTY	\N	\N	\N	\N	\N	\N
692	6	91	EMPTY	\N	\N	\N	\N	\N	\N
693	6	92	EMPTY	\N	\N	\N	\N	\N	\N
694	6	93	EMPTY	\N	\N	\N	\N	\N	\N
695	6	94	EMPTY	\N	\N	\N	\N	\N	\N
696	6	95	EMPTY	\N	\N	\N	\N	\N	\N
697	6	96	VALLEY	\N	\N	\N	\N	Valley (6, 96)	\N
698	6	97	EMPTY	\N	\N	\N	\N	\N	\N
699	6	98	EMPTY	\N	\N	\N	\N	\N	\N
700	6	99	EMPTY	\N	\N	\N	\N	\N	\N
701	7	0	EMPTY	\N	\N	\N	\N	\N	\N
702	7	1	EMPTY	\N	\N	\N	\N	\N	\N
703	7	2	EMPTY	\N	\N	\N	\N	\N	\N
704	7	3	EMPTY	\N	\N	\N	\N	\N	\N
705	7	4	EMPTY	\N	\N	\N	\N	\N	\N
706	7	5	EMPTY	\N	\N	\N	\N	\N	\N
707	7	6	EMPTY	\N	\N	\N	\N	\N	\N
708	7	7	EMPTY	\N	\N	\N	\N	\N	\N
709	7	8	EMPTY	\N	\N	\N	\N	\N	\N
710	7	9	EMPTY	\N	\N	\N	\N	\N	\N
711	7	10	EMPTY	\N	\N	\N	\N	\N	\N
712	7	11	EMPTY	\N	\N	\N	\N	\N	\N
713	7	12	EMPTY	\N	\N	\N	\N	\N	\N
714	7	13	EMPTY	\N	\N	\N	\N	\N	\N
715	7	14	EMPTY	\N	\N	\N	\N	\N	\N
716	7	15	EMPTY	\N	\N	\N	\N	\N	\N
717	7	16	EMPTY	\N	\N	\N	\N	\N	\N
718	7	17	EMPTY	\N	\N	\N	\N	\N	\N
719	7	18	EMPTY	\N	\N	\N	\N	\N	\N
720	7	19	EMPTY	\N	\N	\N	\N	\N	\N
721	7	20	EMPTY	\N	\N	\N	\N	\N	\N
722	7	21	EMPTY	\N	\N	\N	\N	\N	\N
723	7	22	EMPTY	\N	\N	\N	\N	\N	\N
724	7	23	EMPTY	\N	\N	\N	\N	\N	\N
725	7	24	NPC	\N	\N	5	\N	Barbarian Camp (Lv 5)	\N
726	7	25	EMPTY	\N	\N	\N	\N	\N	\N
727	7	26	EMPTY	\N	\N	\N	\N	\N	\N
728	7	27	EMPTY	\N	\N	\N	\N	\N	\N
729	7	28	EMPTY	\N	\N	\N	\N	\N	\N
730	7	29	EMPTY	\N	\N	\N	\N	\N	\N
731	7	30	EMPTY	\N	\N	\N	\N	\N	\N
732	7	31	EMPTY	\N	\N	\N	\N	\N	\N
733	7	32	EMPTY	\N	\N	\N	\N	\N	\N
734	7	33	EMPTY	\N	\N	\N	\N	\N	\N
735	7	34	EMPTY	\N	\N	\N	\N	\N	\N
736	7	35	RESOURCE	food	2	\N	\N	\N	\N
737	7	36	EMPTY	\N	\N	\N	\N	\N	\N
738	7	37	EMPTY	\N	\N	\N	\N	\N	\N
739	7	38	EMPTY	\N	\N	\N	\N	\N	\N
740	7	39	EMPTY	\N	\N	\N	\N	\N	\N
741	7	40	EMPTY	\N	\N	\N	\N	\N	\N
742	7	41	EMPTY	\N	\N	\N	\N	\N	\N
743	7	42	EMPTY	\N	\N	\N	\N	\N	\N
744	7	43	EMPTY	\N	\N	\N	\N	\N	\N
745	7	44	EMPTY	\N	\N	\N	\N	\N	\N
746	7	45	RESOURCE	wood	1	\N	\N	\N	\N
747	7	46	EMPTY	\N	\N	\N	\N	\N	\N
748	7	47	EMPTY	\N	\N	\N	\N	\N	\N
749	7	48	EMPTY	\N	\N	\N	\N	\N	\N
750	7	49	EMPTY	\N	\N	\N	\N	\N	\N
751	7	50	EMPTY	\N	\N	\N	\N	\N	\N
752	7	51	NPC	\N	\N	1	\N	Barbarian Camp (Lv 1)	\N
753	7	52	EMPTY	\N	\N	\N	\N	\N	\N
754	7	53	EMPTY	\N	\N	\N	\N	\N	\N
755	7	54	EMPTY	\N	\N	\N	\N	\N	\N
756	7	55	EMPTY	\N	\N	\N	\N	\N	\N
757	7	56	EMPTY	\N	\N	\N	\N	\N	\N
758	7	57	EMPTY	\N	\N	\N	\N	\N	\N
759	7	58	EMPTY	\N	\N	\N	\N	\N	\N
760	7	59	EMPTY	\N	\N	\N	\N	\N	\N
761	7	60	EMPTY	\N	\N	\N	\N	\N	\N
762	7	61	EMPTY	\N	\N	\N	\N	\N	\N
763	7	62	EMPTY	\N	\N	\N	\N	\N	\N
764	7	63	EMPTY	\N	\N	\N	\N	\N	\N
765	7	64	EMPTY	\N	\N	\N	\N	\N	\N
766	7	65	EMPTY	\N	\N	\N	\N	\N	\N
767	7	66	EMPTY	\N	\N	\N	\N	\N	\N
768	7	67	EMPTY	\N	\N	\N	\N	\N	\N
769	7	68	EMPTY	\N	\N	\N	\N	\N	\N
770	7	69	EMPTY	\N	\N	\N	\N	\N	\N
771	7	70	EMPTY	\N	\N	\N	\N	\N	\N
772	7	71	EMPTY	\N	\N	\N	\N	\N	\N
773	7	72	EMPTY	\N	\N	\N	\N	\N	\N
774	7	73	EMPTY	\N	\N	\N	\N	\N	\N
775	7	74	EMPTY	\N	\N	\N	\N	\N	\N
776	7	75	EMPTY	\N	\N	\N	\N	\N	\N
777	7	76	RESOURCE	stone	2	\N	\N	\N	\N
778	7	77	EMPTY	\N	\N	\N	\N	\N	\N
779	7	78	EMPTY	\N	\N	\N	\N	\N	\N
780	7	79	EMPTY	\N	\N	\N	\N	\N	\N
781	7	80	NPC	\N	\N	10	\N	Barbarian Camp (Lv 10)	\N
782	7	81	EMPTY	\N	\N	\N	\N	\N	\N
783	7	82	RESOURCE	stone	5	\N	\N	\N	\N
784	7	83	EMPTY	\N	\N	\N	\N	\N	\N
785	7	84	EMPTY	\N	\N	\N	\N	\N	\N
786	7	85	EMPTY	\N	\N	\N	\N	\N	\N
787	7	86	RESOURCE	stone	4	\N	\N	\N	\N
788	7	87	NPC	\N	\N	9	\N	Barbarian Camp (Lv 9)	\N
789	7	88	EMPTY	\N	\N	\N	\N	\N	\N
790	7	89	RESOURCE	food	3	\N	\N	\N	\N
791	7	90	EMPTY	\N	\N	\N	\N	\N	\N
792	7	91	EMPTY	\N	\N	\N	\N	\N	\N
793	7	92	EMPTY	\N	\N	\N	\N	\N	\N
794	7	93	EMPTY	\N	\N	\N	\N	\N	\N
795	7	94	EMPTY	\N	\N	\N	\N	\N	\N
796	7	95	EMPTY	\N	\N	\N	\N	\N	\N
797	7	96	NPC	\N	\N	9	\N	Barbarian Camp (Lv 9)	\N
798	7	97	RESOURCE	wood	1	\N	\N	\N	\N
799	7	98	EMPTY	\N	\N	\N	\N	\N	\N
800	7	99	VALLEY	\N	\N	\N	\N	Valley (7, 99)	\N
801	8	0	EMPTY	\N	\N	\N	\N	\N	\N
802	8	1	NPC	\N	\N	9	\N	Barbarian Camp (Lv 9)	\N
803	8	2	EMPTY	\N	\N	\N	\N	\N	\N
804	8	3	EMPTY	\N	\N	\N	\N	\N	\N
805	8	4	EMPTY	\N	\N	\N	\N	\N	\N
806	8	5	RESOURCE	wood	3	\N	\N	\N	\N
807	8	6	EMPTY	\N	\N	\N	\N	\N	\N
808	8	7	RESOURCE	iron	1	\N	\N	\N	\N
809	8	8	EMPTY	\N	\N	\N	\N	\N	\N
810	8	9	EMPTY	\N	\N	\N	\N	\N	\N
811	8	10	RESOURCE	wood	2	\N	\N	\N	\N
812	8	11	EMPTY	\N	\N	\N	\N	\N	\N
813	8	12	EMPTY	\N	\N	\N	\N	\N	\N
814	8	13	EMPTY	\N	\N	\N	\N	\N	\N
815	8	14	EMPTY	\N	\N	\N	\N	\N	\N
816	8	15	RESOURCE	food	3	\N	\N	\N	\N
817	8	16	EMPTY	\N	\N	\N	\N	\N	\N
818	8	17	EMPTY	\N	\N	\N	\N	\N	\N
819	8	18	EMPTY	\N	\N	\N	\N	\N	\N
820	8	19	EMPTY	\N	\N	\N	\N	\N	\N
821	8	20	EMPTY	\N	\N	\N	\N	\N	\N
822	8	21	EMPTY	\N	\N	\N	\N	\N	\N
823	8	22	EMPTY	\N	\N	\N	\N	\N	\N
824	8	23	EMPTY	\N	\N	\N	\N	\N	\N
825	8	24	EMPTY	\N	\N	\N	\N	\N	\N
826	8	25	NPC	\N	\N	9	\N	Barbarian Camp (Lv 9)	\N
827	8	26	EMPTY	\N	\N	\N	\N	\N	\N
828	8	27	EMPTY	\N	\N	\N	\N	\N	\N
829	8	28	EMPTY	\N	\N	\N	\N	\N	\N
830	8	29	EMPTY	\N	\N	\N	\N	\N	\N
831	8	30	EMPTY	\N	\N	\N	\N	\N	\N
832	8	31	EMPTY	\N	\N	\N	\N	\N	\N
833	8	32	VALLEY	\N	\N	\N	\N	Valley (8, 32)	\N
834	8	33	EMPTY	\N	\N	\N	\N	\N	\N
835	8	34	EMPTY	\N	\N	\N	\N	\N	\N
836	8	35	EMPTY	\N	\N	\N	\N	\N	\N
837	8	36	EMPTY	\N	\N	\N	\N	\N	\N
838	8	37	RESOURCE	wood	5	\N	\N	\N	\N
839	8	38	EMPTY	\N	\N	\N	\N	\N	\N
840	8	39	EMPTY	\N	\N	\N	\N	\N	\N
841	8	40	EMPTY	\N	\N	\N	\N	\N	\N
842	8	41	RESOURCE	wood	5	\N	\N	\N	\N
843	8	42	EMPTY	\N	\N	\N	\N	\N	\N
844	8	43	EMPTY	\N	\N	\N	\N	\N	\N
845	8	44	EMPTY	\N	\N	\N	\N	\N	\N
846	8	45	EMPTY	\N	\N	\N	\N	\N	\N
847	8	46	NPC	\N	\N	10	\N	Barbarian Camp (Lv 10)	\N
848	8	47	EMPTY	\N	\N	\N	\N	\N	\N
849	8	48	EMPTY	\N	\N	\N	\N	\N	\N
850	8	49	EMPTY	\N	\N	\N	\N	\N	\N
851	8	50	EMPTY	\N	\N	\N	\N	\N	\N
852	8	51	EMPTY	\N	\N	\N	\N	\N	\N
853	8	52	RESOURCE	wood	3	\N	\N	\N	\N
854	8	53	EMPTY	\N	\N	\N	\N	\N	\N
855	8	54	EMPTY	\N	\N	\N	\N	\N	\N
856	8	55	EMPTY	\N	\N	\N	\N	\N	\N
857	8	56	EMPTY	\N	\N	\N	\N	\N	\N
858	8	57	RESOURCE	stone	3	\N	\N	\N	\N
859	8	58	EMPTY	\N	\N	\N	\N	\N	\N
860	8	59	EMPTY	\N	\N	\N	\N	\N	\N
861	8	60	EMPTY	\N	\N	\N	\N	\N	\N
862	8	61	EMPTY	\N	\N	\N	\N	\N	\N
863	8	62	NPC	\N	\N	8	\N	Barbarian Camp (Lv 8)	\N
864	8	63	EMPTY	\N	\N	\N	\N	\N	\N
865	8	64	EMPTY	\N	\N	\N	\N	\N	\N
866	8	65	EMPTY	\N	\N	\N	\N	\N	\N
867	8	66	EMPTY	\N	\N	\N	\N	\N	\N
868	8	67	EMPTY	\N	\N	\N	\N	\N	\N
869	8	68	EMPTY	\N	\N	\N	\N	\N	\N
870	8	69	EMPTY	\N	\N	\N	\N	\N	\N
871	8	70	RESOURCE	stone	4	\N	\N	\N	\N
872	8	71	NPC	\N	\N	8	\N	Barbarian Camp (Lv 8)	\N
873	8	72	EMPTY	\N	\N	\N	\N	\N	\N
874	8	73	EMPTY	\N	\N	\N	\N	\N	\N
875	8	74	EMPTY	\N	\N	\N	\N	\N	\N
876	8	75	EMPTY	\N	\N	\N	\N	\N	\N
877	8	76	EMPTY	\N	\N	\N	\N	\N	\N
878	8	77	EMPTY	\N	\N	\N	\N	\N	\N
879	8	78	EMPTY	\N	\N	\N	\N	\N	\N
880	8	79	EMPTY	\N	\N	\N	\N	\N	\N
881	8	80	EMPTY	\N	\N	\N	\N	\N	\N
882	8	81	RESOURCE	stone	4	\N	\N	\N	\N
883	8	82	EMPTY	\N	\N	\N	\N	\N	\N
884	8	83	EMPTY	\N	\N	\N	\N	\N	\N
885	8	84	EMPTY	\N	\N	\N	\N	\N	\N
886	8	85	EMPTY	\N	\N	\N	\N	\N	\N
887	8	86	EMPTY	\N	\N	\N	\N	\N	\N
888	8	87	EMPTY	\N	\N	\N	\N	\N	\N
889	8	88	RESOURCE	iron	2	\N	\N	\N	\N
890	8	89	EMPTY	\N	\N	\N	\N	\N	\N
891	8	90	EMPTY	\N	\N	\N	\N	\N	\N
892	8	91	RESOURCE	iron	1	\N	\N	\N	\N
893	8	92	EMPTY	\N	\N	\N	\N	\N	\N
894	8	93	EMPTY	\N	\N	\N	\N	\N	\N
895	8	94	EMPTY	\N	\N	\N	\N	\N	\N
896	8	95	RESOURCE	food	2	\N	\N	\N	\N
897	8	96	VALLEY	\N	\N	\N	\N	Valley (8, 96)	\N
898	8	97	RESOURCE	food	5	\N	\N	\N	\N
899	8	98	EMPTY	\N	\N	\N	\N	\N	\N
900	8	99	RESOURCE	food	1	\N	\N	\N	\N
901	9	0	EMPTY	\N	\N	\N	\N	\N	\N
902	9	1	EMPTY	\N	\N	\N	\N	\N	\N
903	9	2	EMPTY	\N	\N	\N	\N	\N	\N
904	9	3	EMPTY	\N	\N	\N	\N	\N	\N
905	9	4	EMPTY	\N	\N	\N	\N	\N	\N
906	9	5	EMPTY	\N	\N	\N	\N	\N	\N
907	9	6	RESOURCE	stone	3	\N	\N	\N	\N
908	9	7	EMPTY	\N	\N	\N	\N	\N	\N
909	9	8	EMPTY	\N	\N	\N	\N	\N	\N
910	9	9	EMPTY	\N	\N	\N	\N	\N	\N
911	9	10	EMPTY	\N	\N	\N	\N	\N	\N
912	9	11	RESOURCE	iron	2	\N	\N	\N	\N
913	9	12	EMPTY	\N	\N	\N	\N	\N	\N
914	9	13	EMPTY	\N	\N	\N	\N	\N	\N
915	9	14	EMPTY	\N	\N	\N	\N	\N	\N
916	9	15	EMPTY	\N	\N	\N	\N	\N	\N
917	9	16	EMPTY	\N	\N	\N	\N	\N	\N
918	9	17	EMPTY	\N	\N	\N	\N	\N	\N
919	9	18	EMPTY	\N	\N	\N	\N	\N	\N
920	9	19	EMPTY	\N	\N	\N	\N	\N	\N
921	9	20	EMPTY	\N	\N	\N	\N	\N	\N
922	9	21	EMPTY	\N	\N	\N	\N	\N	\N
923	9	22	EMPTY	\N	\N	\N	\N	\N	\N
924	9	23	EMPTY	\N	\N	\N	\N	\N	\N
925	9	24	EMPTY	\N	\N	\N	\N	\N	\N
926	9	25	EMPTY	\N	\N	\N	\N	\N	\N
927	9	26	EMPTY	\N	\N	\N	\N	\N	\N
928	9	27	EMPTY	\N	\N	\N	\N	\N	\N
929	9	28	EMPTY	\N	\N	\N	\N	\N	\N
930	9	29	EMPTY	\N	\N	\N	\N	\N	\N
931	9	30	EMPTY	\N	\N	\N	\N	\N	\N
932	9	31	EMPTY	\N	\N	\N	\N	\N	\N
933	9	32	RESOURCE	stone	2	\N	\N	\N	\N
934	9	33	EMPTY	\N	\N	\N	\N	\N	\N
935	9	34	EMPTY	\N	\N	\N	\N	\N	\N
936	9	35	EMPTY	\N	\N	\N	\N	\N	\N
937	9	36	EMPTY	\N	\N	\N	\N	\N	\N
938	9	37	EMPTY	\N	\N	\N	\N	\N	\N
939	9	38	EMPTY	\N	\N	\N	\N	\N	\N
940	9	39	EMPTY	\N	\N	\N	\N	\N	\N
941	9	40	EMPTY	\N	\N	\N	\N	\N	\N
942	9	41	EMPTY	\N	\N	\N	\N	\N	\N
943	9	42	EMPTY	\N	\N	\N	\N	\N	\N
944	9	43	EMPTY	\N	\N	\N	\N	\N	\N
945	9	44	EMPTY	\N	\N	\N	\N	\N	\N
946	9	45	EMPTY	\N	\N	\N	\N	\N	\N
947	9	46	RESOURCE	iron	5	\N	\N	\N	\N
948	9	47	NPC	\N	\N	8	\N	Barbarian Camp (Lv 8)	\N
949	9	48	EMPTY	\N	\N	\N	\N	\N	\N
950	9	49	EMPTY	\N	\N	\N	\N	\N	\N
951	9	50	EMPTY	\N	\N	\N	\N	\N	\N
952	9	51	EMPTY	\N	\N	\N	\N	\N	\N
953	9	52	EMPTY	\N	\N	\N	\N	\N	\N
954	9	53	EMPTY	\N	\N	\N	\N	\N	\N
955	9	54	EMPTY	\N	\N	\N	\N	\N	\N
956	9	55	EMPTY	\N	\N	\N	\N	\N	\N
957	9	56	EMPTY	\N	\N	\N	\N	\N	\N
958	9	57	EMPTY	\N	\N	\N	\N	\N	\N
959	9	58	EMPTY	\N	\N	\N	\N	\N	\N
960	9	59	EMPTY	\N	\N	\N	\N	\N	\N
961	9	60	EMPTY	\N	\N	\N	\N	\N	\N
962	9	61	EMPTY	\N	\N	\N	\N	\N	\N
963	9	62	EMPTY	\N	\N	\N	\N	\N	\N
964	9	63	EMPTY	\N	\N	\N	\N	\N	\N
965	9	64	EMPTY	\N	\N	\N	\N	\N	\N
966	9	65	EMPTY	\N	\N	\N	\N	\N	\N
967	9	66	EMPTY	\N	\N	\N	\N	\N	\N
968	9	67	EMPTY	\N	\N	\N	\N	\N	\N
969	9	68	EMPTY	\N	\N	\N	\N	\N	\N
970	9	69	NPC	\N	\N	2	\N	Barbarian Camp (Lv 2)	\N
971	9	70	EMPTY	\N	\N	\N	\N	\N	\N
972	9	71	EMPTY	\N	\N	\N	\N	\N	\N
973	9	72	EMPTY	\N	\N	\N	\N	\N	\N
974	9	73	NPC	\N	\N	3	\N	Barbarian Camp (Lv 3)	\N
975	9	74	EMPTY	\N	\N	\N	\N	\N	\N
976	9	75	EMPTY	\N	\N	\N	\N	\N	\N
977	9	76	EMPTY	\N	\N	\N	\N	\N	\N
978	9	77	EMPTY	\N	\N	\N	\N	\N	\N
979	9	78	EMPTY	\N	\N	\N	\N	\N	\N
980	9	79	NPC	\N	\N	4	\N	Barbarian Camp (Lv 4)	\N
981	9	80	RESOURCE	iron	3	\N	\N	\N	\N
982	9	81	EMPTY	\N	\N	\N	\N	\N	\N
983	9	82	EMPTY	\N	\N	\N	\N	\N	\N
984	9	83	EMPTY	\N	\N	\N	\N	\N	\N
985	9	84	EMPTY	\N	\N	\N	\N	\N	\N
986	9	85	EMPTY	\N	\N	\N	\N	\N	\N
987	9	86	EMPTY	\N	\N	\N	\N	\N	\N
988	9	87	EMPTY	\N	\N	\N	\N	\N	\N
989	9	88	EMPTY	\N	\N	\N	\N	\N	\N
990	9	89	EMPTY	\N	\N	\N	\N	\N	\N
991	9	90	EMPTY	\N	\N	\N	\N	\N	\N
992	9	91	EMPTY	\N	\N	\N	\N	\N	\N
993	9	92	EMPTY	\N	\N	\N	\N	\N	\N
994	9	93	EMPTY	\N	\N	\N	\N	\N	\N
995	9	94	EMPTY	\N	\N	\N	\N	\N	\N
996	9	95	EMPTY	\N	\N	\N	\N	\N	\N
997	9	96	EMPTY	\N	\N	\N	\N	\N	\N
998	9	97	EMPTY	\N	\N	\N	\N	\N	\N
999	9	98	EMPTY	\N	\N	\N	\N	\N	\N
1000	9	99	EMPTY	\N	\N	\N	\N	\N	\N
1001	10	0	RESOURCE	stone	1	\N	\N	\N	\N
1002	10	1	EMPTY	\N	\N	\N	\N	\N	\N
1003	10	2	EMPTY	\N	\N	\N	\N	\N	\N
1004	10	3	EMPTY	\N	\N	\N	\N	\N	\N
1005	10	4	EMPTY	\N	\N	\N	\N	\N	\N
1006	10	5	EMPTY	\N	\N	\N	\N	\N	\N
1007	10	6	EMPTY	\N	\N	\N	\N	\N	\N
1008	10	7	EMPTY	\N	\N	\N	\N	\N	\N
1009	10	8	EMPTY	\N	\N	\N	\N	\N	\N
1010	10	9	EMPTY	\N	\N	\N	\N	\N	\N
1011	10	10	EMPTY	\N	\N	\N	\N	\N	\N
1012	10	11	EMPTY	\N	\N	\N	\N	\N	\N
1013	10	12	EMPTY	\N	\N	\N	\N	\N	\N
1014	10	13	EMPTY	\N	\N	\N	\N	\N	\N
1015	10	14	RESOURCE	iron	4	\N	\N	\N	\N
1016	10	15	EMPTY	\N	\N	\N	\N	\N	\N
1017	10	16	EMPTY	\N	\N	\N	\N	\N	\N
1018	10	17	EMPTY	\N	\N	\N	\N	\N	\N
1019	10	18	EMPTY	\N	\N	\N	\N	\N	\N
1020	10	19	EMPTY	\N	\N	\N	\N	\N	\N
1021	10	20	EMPTY	\N	\N	\N	\N	\N	\N
1022	10	21	EMPTY	\N	\N	\N	\N	\N	\N
1023	10	22	EMPTY	\N	\N	\N	\N	\N	\N
1024	10	23	EMPTY	\N	\N	\N	\N	\N	\N
1025	10	24	EMPTY	\N	\N	\N	\N	\N	\N
1026	10	25	RESOURCE	food	3	\N	\N	\N	\N
1027	10	26	EMPTY	\N	\N	\N	\N	\N	\N
1028	10	27	EMPTY	\N	\N	\N	\N	\N	\N
1029	10	28	EMPTY	\N	\N	\N	\N	\N	\N
1030	10	29	EMPTY	\N	\N	\N	\N	\N	\N
1031	10	30	EMPTY	\N	\N	\N	\N	\N	\N
1032	10	31	EMPTY	\N	\N	\N	\N	\N	\N
1033	10	32	EMPTY	\N	\N	\N	\N	\N	\N
1034	10	33	EMPTY	\N	\N	\N	\N	\N	\N
1035	10	34	EMPTY	\N	\N	\N	\N	\N	\N
1036	10	35	EMPTY	\N	\N	\N	\N	\N	\N
1037	10	36	EMPTY	\N	\N	\N	\N	\N	\N
1038	10	37	EMPTY	\N	\N	\N	\N	\N	\N
1039	10	38	EMPTY	\N	\N	\N	\N	\N	\N
1040	10	39	EMPTY	\N	\N	\N	\N	\N	\N
1041	10	40	EMPTY	\N	\N	\N	\N	\N	\N
1042	10	41	EMPTY	\N	\N	\N	\N	\N	\N
1043	10	42	EMPTY	\N	\N	\N	\N	\N	\N
1044	10	43	EMPTY	\N	\N	\N	\N	\N	\N
1045	10	44	EMPTY	\N	\N	\N	\N	\N	\N
1046	10	45	EMPTY	\N	\N	\N	\N	\N	\N
1047	10	46	EMPTY	\N	\N	\N	\N	\N	\N
1048	10	47	EMPTY	\N	\N	\N	\N	\N	\N
1049	10	48	EMPTY	\N	\N	\N	\N	\N	\N
1050	10	49	RESOURCE	food	2	\N	\N	\N	\N
1051	10	50	EMPTY	\N	\N	\N	\N	\N	\N
1052	10	51	EMPTY	\N	\N	\N	\N	\N	\N
1053	10	52	EMPTY	\N	\N	\N	\N	\N	\N
1054	10	53	EMPTY	\N	\N	\N	\N	\N	\N
1055	10	54	EMPTY	\N	\N	\N	\N	\N	\N
1056	10	55	EMPTY	\N	\N	\N	\N	\N	\N
1057	10	56	EMPTY	\N	\N	\N	\N	\N	\N
1058	10	57	EMPTY	\N	\N	\N	\N	\N	\N
1059	10	58	EMPTY	\N	\N	\N	\N	\N	\N
1060	10	59	NPC	\N	\N	2	\N	Barbarian Camp (Lv 2)	\N
1061	10	60	EMPTY	\N	\N	\N	\N	\N	\N
1062	10	61	EMPTY	\N	\N	\N	\N	\N	\N
1063	10	62	EMPTY	\N	\N	\N	\N	\N	\N
1064	10	63	EMPTY	\N	\N	\N	\N	\N	\N
1065	10	64	EMPTY	\N	\N	\N	\N	\N	\N
1066	10	65	VALLEY	\N	\N	\N	\N	Valley (10, 65)	\N
1067	10	66	EMPTY	\N	\N	\N	\N	\N	\N
1068	10	67	EMPTY	\N	\N	\N	\N	\N	\N
1069	10	68	EMPTY	\N	\N	\N	\N	\N	\N
1070	10	69	EMPTY	\N	\N	\N	\N	\N	\N
1071	10	70	EMPTY	\N	\N	\N	\N	\N	\N
1072	10	71	EMPTY	\N	\N	\N	\N	\N	\N
1073	10	72	NPC	\N	\N	2	\N	Barbarian Camp (Lv 2)	\N
1074	10	73	EMPTY	\N	\N	\N	\N	\N	\N
1075	10	74	EMPTY	\N	\N	\N	\N	\N	\N
1076	10	75	EMPTY	\N	\N	\N	\N	\N	\N
1077	10	76	EMPTY	\N	\N	\N	\N	\N	\N
1078	10	77	EMPTY	\N	\N	\N	\N	\N	\N
1079	10	78	EMPTY	\N	\N	\N	\N	\N	\N
1080	10	79	EMPTY	\N	\N	\N	\N	\N	\N
1081	10	80	RESOURCE	food	4	\N	\N	\N	\N
1082	10	81	EMPTY	\N	\N	\N	\N	\N	\N
1083	10	82	EMPTY	\N	\N	\N	\N	\N	\N
1084	10	83	EMPTY	\N	\N	\N	\N	\N	\N
1085	10	84	EMPTY	\N	\N	\N	\N	\N	\N
1086	10	85	EMPTY	\N	\N	\N	\N	\N	\N
1087	10	86	EMPTY	\N	\N	\N	\N	\N	\N
1088	10	87	EMPTY	\N	\N	\N	\N	\N	\N
1089	10	88	EMPTY	\N	\N	\N	\N	\N	\N
1090	10	89	VALLEY	\N	\N	\N	\N	Valley (10, 89)	\N
1091	10	90	EMPTY	\N	\N	\N	\N	\N	\N
1092	10	91	EMPTY	\N	\N	\N	\N	\N	\N
1093	10	92	EMPTY	\N	\N	\N	\N	\N	\N
1094	10	93	EMPTY	\N	\N	\N	\N	\N	\N
1095	10	94	EMPTY	\N	\N	\N	\N	\N	\N
1096	10	95	EMPTY	\N	\N	\N	\N	\N	\N
1097	10	96	EMPTY	\N	\N	\N	\N	\N	\N
1098	10	97	NPC	\N	\N	3	\N	Barbarian Camp (Lv 3)	\N
1099	10	98	EMPTY	\N	\N	\N	\N	\N	\N
1100	10	99	EMPTY	\N	\N	\N	\N	\N	\N
1101	11	0	RESOURCE	food	5	\N	\N	\N	\N
1102	11	1	EMPTY	\N	\N	\N	\N	\N	\N
1103	11	2	EMPTY	\N	\N	\N	\N	\N	\N
1104	11	3	VALLEY	\N	\N	\N	\N	Valley (11, 3)	\N
1105	11	4	EMPTY	\N	\N	\N	\N	\N	\N
1106	11	5	EMPTY	\N	\N	\N	\N	\N	\N
1107	11	6	NPC	\N	\N	9	\N	Barbarian Camp (Lv 9)	\N
1108	11	7	EMPTY	\N	\N	\N	\N	\N	\N
1109	11	8	EMPTY	\N	\N	\N	\N	\N	\N
1110	11	9	EMPTY	\N	\N	\N	\N	\N	\N
1111	11	10	EMPTY	\N	\N	\N	\N	\N	\N
1112	11	11	RESOURCE	stone	1	\N	\N	\N	\N
1113	11	12	NPC	\N	\N	8	\N	Barbarian Camp (Lv 8)	\N
1114	11	13	EMPTY	\N	\N	\N	\N	\N	\N
1115	11	14	EMPTY	\N	\N	\N	\N	\N	\N
1116	11	15	EMPTY	\N	\N	\N	\N	\N	\N
1117	11	16	EMPTY	\N	\N	\N	\N	\N	\N
1118	11	17	EMPTY	\N	\N	\N	\N	\N	\N
1119	11	18	EMPTY	\N	\N	\N	\N	\N	\N
1120	11	19	EMPTY	\N	\N	\N	\N	\N	\N
1121	11	20	EMPTY	\N	\N	\N	\N	\N	\N
1122	11	21	EMPTY	\N	\N	\N	\N	\N	\N
1123	11	22	EMPTY	\N	\N	\N	\N	\N	\N
1124	11	23	EMPTY	\N	\N	\N	\N	\N	\N
1125	11	24	EMPTY	\N	\N	\N	\N	\N	\N
1126	11	25	EMPTY	\N	\N	\N	\N	\N	\N
1127	11	26	EMPTY	\N	\N	\N	\N	\N	\N
1128	11	27	EMPTY	\N	\N	\N	\N	\N	\N
1129	11	28	EMPTY	\N	\N	\N	\N	\N	\N
1130	11	29	VALLEY	\N	\N	\N	\N	Valley (11, 29)	\N
1131	11	30	EMPTY	\N	\N	\N	\N	\N	\N
1132	11	31	NPC	\N	\N	1	\N	Barbarian Camp (Lv 1)	\N
1133	11	32	EMPTY	\N	\N	\N	\N	\N	\N
1134	11	33	EMPTY	\N	\N	\N	\N	\N	\N
1135	11	34	EMPTY	\N	\N	\N	\N	\N	\N
1136	11	35	EMPTY	\N	\N	\N	\N	\N	\N
1137	11	36	EMPTY	\N	\N	\N	\N	\N	\N
1138	11	37	EMPTY	\N	\N	\N	\N	\N	\N
1139	11	38	EMPTY	\N	\N	\N	\N	\N	\N
1140	11	39	EMPTY	\N	\N	\N	\N	\N	\N
1141	11	40	EMPTY	\N	\N	\N	\N	\N	\N
1142	11	41	EMPTY	\N	\N	\N	\N	\N	\N
1143	11	42	EMPTY	\N	\N	\N	\N	\N	\N
1144	11	43	EMPTY	\N	\N	\N	\N	\N	\N
1145	11	44	EMPTY	\N	\N	\N	\N	\N	\N
1146	11	45	NPC	\N	\N	3	\N	Barbarian Camp (Lv 3)	\N
1147	11	46	VALLEY	\N	\N	\N	\N	Valley (11, 46)	\N
1148	11	47	EMPTY	\N	\N	\N	\N	\N	\N
1149	11	48	EMPTY	\N	\N	\N	\N	\N	\N
1150	11	49	EMPTY	\N	\N	\N	\N	\N	\N
1151	11	50	EMPTY	\N	\N	\N	\N	\N	\N
1152	11	51	EMPTY	\N	\N	\N	\N	\N	\N
1153	11	52	EMPTY	\N	\N	\N	\N	\N	\N
1154	11	53	EMPTY	\N	\N	\N	\N	\N	\N
1155	11	54	EMPTY	\N	\N	\N	\N	\N	\N
1156	11	55	RESOURCE	food	4	\N	\N	\N	\N
1157	11	56	EMPTY	\N	\N	\N	\N	\N	\N
1158	11	57	EMPTY	\N	\N	\N	\N	\N	\N
1159	11	58	EMPTY	\N	\N	\N	\N	\N	\N
1160	11	59	EMPTY	\N	\N	\N	\N	\N	\N
1161	11	60	EMPTY	\N	\N	\N	\N	\N	\N
1162	11	61	EMPTY	\N	\N	\N	\N	\N	\N
1163	11	62	EMPTY	\N	\N	\N	\N	\N	\N
1164	11	63	EMPTY	\N	\N	\N	\N	\N	\N
1165	11	64	RESOURCE	stone	2	\N	\N	\N	\N
1166	11	65	EMPTY	\N	\N	\N	\N	\N	\N
1167	11	66	EMPTY	\N	\N	\N	\N	\N	\N
1168	11	67	EMPTY	\N	\N	\N	\N	\N	\N
1169	11	68	EMPTY	\N	\N	\N	\N	\N	\N
1170	11	69	RESOURCE	stone	3	\N	\N	\N	\N
1171	11	70	EMPTY	\N	\N	\N	\N	\N	\N
1172	11	71	EMPTY	\N	\N	\N	\N	\N	\N
1173	11	72	EMPTY	\N	\N	\N	\N	\N	\N
1174	11	73	EMPTY	\N	\N	\N	\N	\N	\N
1175	11	74	EMPTY	\N	\N	\N	\N	\N	\N
1176	11	75	EMPTY	\N	\N	\N	\N	\N	\N
1177	11	76	EMPTY	\N	\N	\N	\N	\N	\N
1178	11	77	EMPTY	\N	\N	\N	\N	\N	\N
1179	11	78	EMPTY	\N	\N	\N	\N	\N	\N
1180	11	79	EMPTY	\N	\N	\N	\N	\N	\N
1181	11	80	EMPTY	\N	\N	\N	\N	\N	\N
1182	11	81	RESOURCE	stone	5	\N	\N	\N	\N
1183	11	82	EMPTY	\N	\N	\N	\N	\N	\N
1184	11	83	EMPTY	\N	\N	\N	\N	\N	\N
1185	11	84	NPC	\N	\N	2	\N	Barbarian Camp (Lv 2)	\N
1186	11	85	EMPTY	\N	\N	\N	\N	\N	\N
1187	11	86	EMPTY	\N	\N	\N	\N	\N	\N
1188	11	87	NPC	\N	\N	7	\N	Barbarian Camp (Lv 7)	\N
1189	11	88	EMPTY	\N	\N	\N	\N	\N	\N
1190	11	89	EMPTY	\N	\N	\N	\N	\N	\N
1191	11	90	EMPTY	\N	\N	\N	\N	\N	\N
1192	11	91	EMPTY	\N	\N	\N	\N	\N	\N
1193	11	92	EMPTY	\N	\N	\N	\N	\N	\N
1194	11	93	EMPTY	\N	\N	\N	\N	\N	\N
1195	11	94	RESOURCE	iron	5	\N	\N	\N	\N
1196	11	95	EMPTY	\N	\N	\N	\N	\N	\N
1197	11	96	EMPTY	\N	\N	\N	\N	\N	\N
1198	11	97	RESOURCE	wood	4	\N	\N	\N	\N
1199	11	98	RESOURCE	stone	1	\N	\N	\N	\N
1200	11	99	EMPTY	\N	\N	\N	\N	\N	\N
1201	12	0	EMPTY	\N	\N	\N	\N	\N	\N
1202	12	1	EMPTY	\N	\N	\N	\N	\N	\N
1203	12	2	EMPTY	\N	\N	\N	\N	\N	\N
1204	12	3	EMPTY	\N	\N	\N	\N	\N	\N
1205	12	4	NPC	\N	\N	6	\N	Barbarian Camp (Lv 6)	\N
1206	12	5	EMPTY	\N	\N	\N	\N	\N	\N
1207	12	6	EMPTY	\N	\N	\N	\N	\N	\N
1208	12	7	EMPTY	\N	\N	\N	\N	\N	\N
1209	12	8	EMPTY	\N	\N	\N	\N	\N	\N
1210	12	9	EMPTY	\N	\N	\N	\N	\N	\N
1211	12	10	EMPTY	\N	\N	\N	\N	\N	\N
1212	12	11	EMPTY	\N	\N	\N	\N	\N	\N
1213	12	12	EMPTY	\N	\N	\N	\N	\N	\N
1214	12	13	EMPTY	\N	\N	\N	\N	\N	\N
1215	12	14	RESOURCE	stone	2	\N	\N	\N	\N
1216	12	15	EMPTY	\N	\N	\N	\N	\N	\N
1217	12	16	EMPTY	\N	\N	\N	\N	\N	\N
1218	12	17	EMPTY	\N	\N	\N	\N	\N	\N
1219	12	18	EMPTY	\N	\N	\N	\N	\N	\N
1220	12	19	EMPTY	\N	\N	\N	\N	\N	\N
1221	12	20	EMPTY	\N	\N	\N	\N	\N	\N
1222	12	21	EMPTY	\N	\N	\N	\N	\N	\N
1223	12	22	EMPTY	\N	\N	\N	\N	\N	\N
1224	12	23	NPC	\N	\N	1	\N	Barbarian Camp (Lv 1)	\N
1225	12	24	EMPTY	\N	\N	\N	\N	\N	\N
1226	12	25	EMPTY	\N	\N	\N	\N	\N	\N
1227	12	26	EMPTY	\N	\N	\N	\N	\N	\N
1228	12	27	EMPTY	\N	\N	\N	\N	\N	\N
1229	12	28	EMPTY	\N	\N	\N	\N	\N	\N
1230	12	29	EMPTY	\N	\N	\N	\N	\N	\N
1231	12	30	EMPTY	\N	\N	\N	\N	\N	\N
1232	12	31	EMPTY	\N	\N	\N	\N	\N	\N
1233	12	32	EMPTY	\N	\N	\N	\N	\N	\N
1234	12	33	NPC	\N	\N	4	\N	Barbarian Camp (Lv 4)	\N
1235	12	34	EMPTY	\N	\N	\N	\N	\N	\N
1236	12	35	EMPTY	\N	\N	\N	\N	\N	\N
1237	12	36	EMPTY	\N	\N	\N	\N	\N	\N
1238	12	37	EMPTY	\N	\N	\N	\N	\N	\N
1239	12	38	EMPTY	\N	\N	\N	\N	\N	\N
1240	12	39	EMPTY	\N	\N	\N	\N	\N	\N
1241	12	40	EMPTY	\N	\N	\N	\N	\N	\N
1242	12	41	RESOURCE	iron	2	\N	\N	\N	\N
1243	12	42	EMPTY	\N	\N	\N	\N	\N	\N
1244	12	43	EMPTY	\N	\N	\N	\N	\N	\N
1245	12	44	VALLEY	\N	\N	\N	\N	Valley (12, 44)	\N
1246	12	45	EMPTY	\N	\N	\N	\N	\N	\N
1247	12	46	EMPTY	\N	\N	\N	\N	\N	\N
1248	12	47	EMPTY	\N	\N	\N	\N	\N	\N
1249	12	48	EMPTY	\N	\N	\N	\N	\N	\N
1250	12	49	EMPTY	\N	\N	\N	\N	\N	\N
1251	12	50	EMPTY	\N	\N	\N	\N	\N	\N
1252	12	51	NPC	\N	\N	9	\N	Barbarian Camp (Lv 9)	\N
1253	12	52	EMPTY	\N	\N	\N	\N	\N	\N
1254	12	53	EMPTY	\N	\N	\N	\N	\N	\N
1255	12	54	EMPTY	\N	\N	\N	\N	\N	\N
1256	12	55	EMPTY	\N	\N	\N	\N	\N	\N
1257	12	56	EMPTY	\N	\N	\N	\N	\N	\N
1258	12	57	EMPTY	\N	\N	\N	\N	\N	\N
1259	12	58	EMPTY	\N	\N	\N	\N	\N	\N
1260	12	59	EMPTY	\N	\N	\N	\N	\N	\N
1261	12	60	EMPTY	\N	\N	\N	\N	\N	\N
1262	12	61	EMPTY	\N	\N	\N	\N	\N	\N
1263	12	62	EMPTY	\N	\N	\N	\N	\N	\N
1264	12	63	EMPTY	\N	\N	\N	\N	\N	\N
1265	12	64	EMPTY	\N	\N	\N	\N	\N	\N
1266	12	65	NPC	\N	\N	3	\N	Barbarian Camp (Lv 3)	\N
1267	12	66	EMPTY	\N	\N	\N	\N	\N	\N
1268	12	67	EMPTY	\N	\N	\N	\N	\N	\N
1269	12	68	EMPTY	\N	\N	\N	\N	\N	\N
1270	12	69	EMPTY	\N	\N	\N	\N	\N	\N
1271	12	70	EMPTY	\N	\N	\N	\N	\N	\N
1272	12	71	EMPTY	\N	\N	\N	\N	\N	\N
1273	12	72	EMPTY	\N	\N	\N	\N	\N	\N
1274	12	73	EMPTY	\N	\N	\N	\N	\N	\N
1275	12	74	EMPTY	\N	\N	\N	\N	\N	\N
1276	12	75	EMPTY	\N	\N	\N	\N	\N	\N
1277	12	76	EMPTY	\N	\N	\N	\N	\N	\N
1278	12	77	EMPTY	\N	\N	\N	\N	\N	\N
1279	12	78	EMPTY	\N	\N	\N	\N	\N	\N
1280	12	79	RESOURCE	iron	5	\N	\N	\N	\N
1281	12	80	EMPTY	\N	\N	\N	\N	\N	\N
1282	12	81	NPC	\N	\N	8	\N	Barbarian Camp (Lv 8)	\N
1283	12	82	NPC	\N	\N	3	\N	Barbarian Camp (Lv 3)	\N
1284	12	83	EMPTY	\N	\N	\N	\N	\N	\N
1285	12	84	EMPTY	\N	\N	\N	\N	\N	\N
1286	12	85	EMPTY	\N	\N	\N	\N	\N	\N
1287	12	86	EMPTY	\N	\N	\N	\N	\N	\N
1288	12	87	EMPTY	\N	\N	\N	\N	\N	\N
1289	12	88	EMPTY	\N	\N	\N	\N	\N	\N
1290	12	89	VALLEY	\N	\N	\N	\N	Valley (12, 89)	\N
1291	12	90	EMPTY	\N	\N	\N	\N	\N	\N
1292	12	91	NPC	\N	\N	8	\N	Barbarian Camp (Lv 8)	\N
1293	12	92	EMPTY	\N	\N	\N	\N	\N	\N
1294	12	93	EMPTY	\N	\N	\N	\N	\N	\N
1295	12	94	EMPTY	\N	\N	\N	\N	\N	\N
1296	12	95	EMPTY	\N	\N	\N	\N	\N	\N
1297	12	96	EMPTY	\N	\N	\N	\N	\N	\N
1298	12	97	VALLEY	\N	\N	\N	\N	Valley (12, 97)	\N
1299	12	98	NPC	\N	\N	9	\N	Barbarian Camp (Lv 9)	\N
1300	12	99	EMPTY	\N	\N	\N	\N	\N	\N
1301	13	0	EMPTY	\N	\N	\N	\N	\N	\N
1302	13	1	EMPTY	\N	\N	\N	\N	\N	\N
1303	13	2	EMPTY	\N	\N	\N	\N	\N	\N
1304	13	3	RESOURCE	iron	2	\N	\N	\N	\N
1305	13	4	EMPTY	\N	\N	\N	\N	\N	\N
1306	13	5	EMPTY	\N	\N	\N	\N	\N	\N
1307	13	6	EMPTY	\N	\N	\N	\N	\N	\N
1308	13	7	EMPTY	\N	\N	\N	\N	\N	\N
1309	13	8	EMPTY	\N	\N	\N	\N	\N	\N
1310	13	9	EMPTY	\N	\N	\N	\N	\N	\N
1311	13	10	EMPTY	\N	\N	\N	\N	\N	\N
1312	13	11	EMPTY	\N	\N	\N	\N	\N	\N
1313	13	12	EMPTY	\N	\N	\N	\N	\N	\N
1314	13	13	EMPTY	\N	\N	\N	\N	\N	\N
1315	13	14	EMPTY	\N	\N	\N	\N	\N	\N
1316	13	15	EMPTY	\N	\N	\N	\N	\N	\N
1317	13	16	EMPTY	\N	\N	\N	\N	\N	\N
1318	13	17	VALLEY	\N	\N	\N	\N	Valley (13, 17)	\N
1319	13	18	EMPTY	\N	\N	\N	\N	\N	\N
1320	13	19	EMPTY	\N	\N	\N	\N	\N	\N
1321	13	20	EMPTY	\N	\N	\N	\N	\N	\N
1322	13	21	EMPTY	\N	\N	\N	\N	\N	\N
1323	13	22	EMPTY	\N	\N	\N	\N	\N	\N
1324	13	23	RESOURCE	wood	5	\N	\N	\N	\N
1325	13	24	VALLEY	\N	\N	\N	\N	Valley (13, 24)	\N
1326	13	25	EMPTY	\N	\N	\N	\N	\N	\N
1327	13	26	EMPTY	\N	\N	\N	\N	\N	\N
1328	13	27	EMPTY	\N	\N	\N	\N	\N	\N
1329	13	28	EMPTY	\N	\N	\N	\N	\N	\N
1330	13	29	EMPTY	\N	\N	\N	\N	\N	\N
1331	13	30	EMPTY	\N	\N	\N	\N	\N	\N
1332	13	31	EMPTY	\N	\N	\N	\N	\N	\N
1333	13	32	EMPTY	\N	\N	\N	\N	\N	\N
1334	13	33	EMPTY	\N	\N	\N	\N	\N	\N
1335	13	34	EMPTY	\N	\N	\N	\N	\N	\N
1336	13	35	EMPTY	\N	\N	\N	\N	\N	\N
1337	13	36	VALLEY	\N	\N	\N	\N	Valley (13, 36)	\N
1338	13	37	EMPTY	\N	\N	\N	\N	\N	\N
1339	13	38	EMPTY	\N	\N	\N	\N	\N	\N
1340	13	39	EMPTY	\N	\N	\N	\N	\N	\N
1341	13	40	EMPTY	\N	\N	\N	\N	\N	\N
1342	13	41	RESOURCE	food	1	\N	\N	\N	\N
1343	13	42	EMPTY	\N	\N	\N	\N	\N	\N
1344	13	43	EMPTY	\N	\N	\N	\N	\N	\N
1345	13	44	EMPTY	\N	\N	\N	\N	\N	\N
1346	13	45	EMPTY	\N	\N	\N	\N	\N	\N
1347	13	46	EMPTY	\N	\N	\N	\N	\N	\N
1348	13	47	EMPTY	\N	\N	\N	\N	\N	\N
1349	13	48	RESOURCE	food	5	\N	\N	\N	\N
1350	13	49	EMPTY	\N	\N	\N	\N	\N	\N
1351	13	50	EMPTY	\N	\N	\N	\N	\N	\N
1352	13	51	VALLEY	\N	\N	\N	\N	Valley (13, 51)	\N
1353	13	52	EMPTY	\N	\N	\N	\N	\N	\N
1354	13	53	RESOURCE	stone	1	\N	\N	\N	\N
1355	13	54	EMPTY	\N	\N	\N	\N	\N	\N
1356	13	55	EMPTY	\N	\N	\N	\N	\N	\N
1357	13	56	EMPTY	\N	\N	\N	\N	\N	\N
1358	13	57	EMPTY	\N	\N	\N	\N	\N	\N
1359	13	58	EMPTY	\N	\N	\N	\N	\N	\N
1360	13	59	EMPTY	\N	\N	\N	\N	\N	\N
1361	13	60	EMPTY	\N	\N	\N	\N	\N	\N
1362	13	61	EMPTY	\N	\N	\N	\N	\N	\N
1363	13	62	EMPTY	\N	\N	\N	\N	\N	\N
1364	13	63	EMPTY	\N	\N	\N	\N	\N	\N
1365	13	64	EMPTY	\N	\N	\N	\N	\N	\N
1366	13	65	EMPTY	\N	\N	\N	\N	\N	\N
1367	13	66	RESOURCE	food	2	\N	\N	\N	\N
1368	13	67	EMPTY	\N	\N	\N	\N	\N	\N
1369	13	68	EMPTY	\N	\N	\N	\N	\N	\N
1370	13	69	EMPTY	\N	\N	\N	\N	\N	\N
1371	13	70	EMPTY	\N	\N	\N	\N	\N	\N
1372	13	71	EMPTY	\N	\N	\N	\N	\N	\N
1373	13	72	EMPTY	\N	\N	\N	\N	\N	\N
1374	13	73	EMPTY	\N	\N	\N	\N	\N	\N
1375	13	74	EMPTY	\N	\N	\N	\N	\N	\N
1376	13	75	EMPTY	\N	\N	\N	\N	\N	\N
1377	13	76	EMPTY	\N	\N	\N	\N	\N	\N
1378	13	77	EMPTY	\N	\N	\N	\N	\N	\N
1379	13	78	RESOURCE	stone	2	\N	\N	\N	\N
1380	13	79	EMPTY	\N	\N	\N	\N	\N	\N
1381	13	80	EMPTY	\N	\N	\N	\N	\N	\N
1382	13	81	EMPTY	\N	\N	\N	\N	\N	\N
1383	13	82	RESOURCE	wood	2	\N	\N	\N	\N
1384	13	83	EMPTY	\N	\N	\N	\N	\N	\N
1385	13	84	EMPTY	\N	\N	\N	\N	\N	\N
1386	13	85	EMPTY	\N	\N	\N	\N	\N	\N
1387	13	86	EMPTY	\N	\N	\N	\N	\N	\N
1388	13	87	EMPTY	\N	\N	\N	\N	\N	\N
1389	13	88	EMPTY	\N	\N	\N	\N	\N	\N
1390	13	89	RESOURCE	iron	4	\N	\N	\N	\N
1391	13	90	EMPTY	\N	\N	\N	\N	\N	\N
1392	13	91	EMPTY	\N	\N	\N	\N	\N	\N
1393	13	92	EMPTY	\N	\N	\N	\N	\N	\N
1394	13	93	EMPTY	\N	\N	\N	\N	\N	\N
1395	13	94	EMPTY	\N	\N	\N	\N	\N	\N
1396	13	95	RESOURCE	food	5	\N	\N	\N	\N
1397	13	96	EMPTY	\N	\N	\N	\N	\N	\N
1398	13	97	EMPTY	\N	\N	\N	\N	\N	\N
1399	13	98	EMPTY	\N	\N	\N	\N	\N	\N
1400	13	99	EMPTY	\N	\N	\N	\N	\N	\N
1401	14	0	EMPTY	\N	\N	\N	\N	\N	\N
1402	14	1	RESOURCE	food	5	\N	\N	\N	\N
1403	14	2	NPC	\N	\N	4	\N	Barbarian Camp (Lv 4)	\N
1404	14	3	NPC	\N	\N	5	\N	Barbarian Camp (Lv 5)	\N
1405	14	4	EMPTY	\N	\N	\N	\N	\N	\N
1406	14	5	EMPTY	\N	\N	\N	\N	\N	\N
1407	14	6	EMPTY	\N	\N	\N	\N	\N	\N
1408	14	7	RESOURCE	iron	3	\N	\N	\N	\N
1409	14	8	RESOURCE	wood	1	\N	\N	\N	\N
1410	14	9	EMPTY	\N	\N	\N	\N	\N	\N
1411	14	10	EMPTY	\N	\N	\N	\N	\N	\N
1412	14	11	RESOURCE	food	4	\N	\N	\N	\N
1413	14	12	RESOURCE	food	5	\N	\N	\N	\N
1414	14	13	EMPTY	\N	\N	\N	\N	\N	\N
1415	14	14	RESOURCE	food	3	\N	\N	\N	\N
1416	14	15	EMPTY	\N	\N	\N	\N	\N	\N
1417	14	16	EMPTY	\N	\N	\N	\N	\N	\N
1418	14	17	EMPTY	\N	\N	\N	\N	\N	\N
1419	14	18	EMPTY	\N	\N	\N	\N	\N	\N
1420	14	19	EMPTY	\N	\N	\N	\N	\N	\N
1421	14	20	RESOURCE	food	3	\N	\N	\N	\N
1422	14	21	EMPTY	\N	\N	\N	\N	\N	\N
1423	14	22	EMPTY	\N	\N	\N	\N	\N	\N
1424	14	23	EMPTY	\N	\N	\N	\N	\N	\N
1425	14	24	EMPTY	\N	\N	\N	\N	\N	\N
1426	14	25	EMPTY	\N	\N	\N	\N	\N	\N
1427	14	26	EMPTY	\N	\N	\N	\N	\N	\N
1428	14	27	VALLEY	\N	\N	\N	\N	Valley (14, 27)	\N
1429	14	28	EMPTY	\N	\N	\N	\N	\N	\N
1430	14	29	EMPTY	\N	\N	\N	\N	\N	\N
1431	14	30	EMPTY	\N	\N	\N	\N	\N	\N
1432	14	31	EMPTY	\N	\N	\N	\N	\N	\N
1433	14	32	EMPTY	\N	\N	\N	\N	\N	\N
1434	14	33	EMPTY	\N	\N	\N	\N	\N	\N
1435	14	34	EMPTY	\N	\N	\N	\N	\N	\N
1436	14	35	EMPTY	\N	\N	\N	\N	\N	\N
1437	14	36	EMPTY	\N	\N	\N	\N	\N	\N
1438	14	37	RESOURCE	wood	5	\N	\N	\N	\N
1439	14	38	EMPTY	\N	\N	\N	\N	\N	\N
1440	14	39	EMPTY	\N	\N	\N	\N	\N	\N
1441	14	40	NPC	\N	\N	6	\N	Barbarian Camp (Lv 6)	\N
1442	14	41	EMPTY	\N	\N	\N	\N	\N	\N
1443	14	42	EMPTY	\N	\N	\N	\N	\N	\N
1444	14	43	RESOURCE	wood	4	\N	\N	\N	\N
1445	14	44	EMPTY	\N	\N	\N	\N	\N	\N
1446	14	45	EMPTY	\N	\N	\N	\N	\N	\N
1447	14	46	EMPTY	\N	\N	\N	\N	\N	\N
1448	14	47	EMPTY	\N	\N	\N	\N	\N	\N
1449	14	48	EMPTY	\N	\N	\N	\N	\N	\N
1450	14	49	EMPTY	\N	\N	\N	\N	\N	\N
1451	14	50	EMPTY	\N	\N	\N	\N	\N	\N
1452	14	51	EMPTY	\N	\N	\N	\N	\N	\N
1453	14	52	RESOURCE	iron	2	\N	\N	\N	\N
1454	14	53	EMPTY	\N	\N	\N	\N	\N	\N
1455	14	54	EMPTY	\N	\N	\N	\N	\N	\N
1456	14	55	EMPTY	\N	\N	\N	\N	\N	\N
1457	14	56	EMPTY	\N	\N	\N	\N	\N	\N
1458	14	57	EMPTY	\N	\N	\N	\N	\N	\N
1459	14	58	EMPTY	\N	\N	\N	\N	\N	\N
1460	14	59	EMPTY	\N	\N	\N	\N	\N	\N
1461	14	60	EMPTY	\N	\N	\N	\N	\N	\N
1462	14	61	EMPTY	\N	\N	\N	\N	\N	\N
1463	14	62	EMPTY	\N	\N	\N	\N	\N	\N
1464	14	63	NPC	\N	\N	2	\N	Barbarian Camp (Lv 2)	\N
1465	14	64	EMPTY	\N	\N	\N	\N	\N	\N
1466	14	65	EMPTY	\N	\N	\N	\N	\N	\N
1467	14	66	EMPTY	\N	\N	\N	\N	\N	\N
1468	14	67	EMPTY	\N	\N	\N	\N	\N	\N
1469	14	68	EMPTY	\N	\N	\N	\N	\N	\N
1470	14	69	EMPTY	\N	\N	\N	\N	\N	\N
1471	14	70	EMPTY	\N	\N	\N	\N	\N	\N
1472	14	71	EMPTY	\N	\N	\N	\N	\N	\N
1473	14	72	EMPTY	\N	\N	\N	\N	\N	\N
1474	14	73	EMPTY	\N	\N	\N	\N	\N	\N
1475	14	74	EMPTY	\N	\N	\N	\N	\N	\N
1476	14	75	EMPTY	\N	\N	\N	\N	\N	\N
1477	14	76	EMPTY	\N	\N	\N	\N	\N	\N
1478	14	77	EMPTY	\N	\N	\N	\N	\N	\N
1479	14	78	EMPTY	\N	\N	\N	\N	\N	\N
1480	14	79	EMPTY	\N	\N	\N	\N	\N	\N
1481	14	80	EMPTY	\N	\N	\N	\N	\N	\N
1482	14	81	RESOURCE	wood	3	\N	\N	\N	\N
1483	14	82	EMPTY	\N	\N	\N	\N	\N	\N
1484	14	83	EMPTY	\N	\N	\N	\N	\N	\N
1485	14	84	EMPTY	\N	\N	\N	\N	\N	\N
1486	14	85	EMPTY	\N	\N	\N	\N	\N	\N
1487	14	86	EMPTY	\N	\N	\N	\N	\N	\N
1488	14	87	EMPTY	\N	\N	\N	\N	\N	\N
1489	14	88	EMPTY	\N	\N	\N	\N	\N	\N
1490	14	89	EMPTY	\N	\N	\N	\N	\N	\N
1491	14	90	EMPTY	\N	\N	\N	\N	\N	\N
1492	14	91	EMPTY	\N	\N	\N	\N	\N	\N
1493	14	92	EMPTY	\N	\N	\N	\N	\N	\N
1494	14	93	EMPTY	\N	\N	\N	\N	\N	\N
1495	14	94	EMPTY	\N	\N	\N	\N	\N	\N
1496	14	95	EMPTY	\N	\N	\N	\N	\N	\N
1497	14	96	EMPTY	\N	\N	\N	\N	\N	\N
1498	14	97	EMPTY	\N	\N	\N	\N	\N	\N
1499	14	98	EMPTY	\N	\N	\N	\N	\N	\N
1500	14	99	EMPTY	\N	\N	\N	\N	\N	\N
1501	15	0	RESOURCE	iron	3	\N	\N	\N	\N
1502	15	1	EMPTY	\N	\N	\N	\N	\N	\N
1503	15	2	NPC	\N	\N	4	\N	Barbarian Camp (Lv 4)	\N
1504	15	3	RESOURCE	wood	3	\N	\N	\N	\N
1505	15	4	EMPTY	\N	\N	\N	\N	\N	\N
1506	15	5	EMPTY	\N	\N	\N	\N	\N	\N
1507	15	6	NPC	\N	\N	6	\N	Barbarian Camp (Lv 6)	\N
1508	15	7	EMPTY	\N	\N	\N	\N	\N	\N
1509	15	8	EMPTY	\N	\N	\N	\N	\N	\N
1510	15	9	EMPTY	\N	\N	\N	\N	\N	\N
1511	15	10	EMPTY	\N	\N	\N	\N	\N	\N
1512	15	11	EMPTY	\N	\N	\N	\N	\N	\N
1513	15	12	RESOURCE	iron	4	\N	\N	\N	\N
1514	15	13	NPC	\N	\N	3	\N	Barbarian Camp (Lv 3)	\N
1515	15	14	NPC	\N	\N	4	\N	Barbarian Camp (Lv 4)	\N
1516	15	15	EMPTY	\N	\N	\N	\N	\N	\N
1517	15	16	EMPTY	\N	\N	\N	\N	\N	\N
1518	15	17	NPC	\N	\N	2	\N	Barbarian Camp (Lv 2)	\N
1519	15	18	EMPTY	\N	\N	\N	\N	\N	\N
1520	15	19	EMPTY	\N	\N	\N	\N	\N	\N
1521	15	20	EMPTY	\N	\N	\N	\N	\N	\N
1522	15	21	EMPTY	\N	\N	\N	\N	\N	\N
1523	15	22	EMPTY	\N	\N	\N	\N	\N	\N
1524	15	23	RESOURCE	iron	2	\N	\N	\N	\N
1525	15	24	EMPTY	\N	\N	\N	\N	\N	\N
1526	15	25	EMPTY	\N	\N	\N	\N	\N	\N
1527	15	26	EMPTY	\N	\N	\N	\N	\N	\N
1528	15	27	RESOURCE	stone	2	\N	\N	\N	\N
1529	15	28	RESOURCE	wood	1	\N	\N	\N	\N
1530	15	29	EMPTY	\N	\N	\N	\N	\N	\N
1531	15	30	EMPTY	\N	\N	\N	\N	\N	\N
1532	15	31	RESOURCE	stone	2	\N	\N	\N	\N
1533	15	32	EMPTY	\N	\N	\N	\N	\N	\N
1534	15	33	RESOURCE	wood	5	\N	\N	\N	\N
1535	15	34	EMPTY	\N	\N	\N	\N	\N	\N
1536	15	35	EMPTY	\N	\N	\N	\N	\N	\N
1537	15	36	EMPTY	\N	\N	\N	\N	\N	\N
1538	15	37	EMPTY	\N	\N	\N	\N	\N	\N
1539	15	38	EMPTY	\N	\N	\N	\N	\N	\N
1540	15	39	EMPTY	\N	\N	\N	\N	\N	\N
1541	15	40	EMPTY	\N	\N	\N	\N	\N	\N
1542	15	41	EMPTY	\N	\N	\N	\N	\N	\N
1543	15	42	EMPTY	\N	\N	\N	\N	\N	\N
1544	15	43	EMPTY	\N	\N	\N	\N	\N	\N
1545	15	44	EMPTY	\N	\N	\N	\N	\N	\N
1546	15	45	EMPTY	\N	\N	\N	\N	\N	\N
1547	15	46	VALLEY	\N	\N	\N	\N	Valley (15, 46)	\N
1548	15	47	EMPTY	\N	\N	\N	\N	\N	\N
1549	15	48	EMPTY	\N	\N	\N	\N	\N	\N
1550	15	49	EMPTY	\N	\N	\N	\N	\N	\N
1551	15	50	EMPTY	\N	\N	\N	\N	\N	\N
1552	15	51	EMPTY	\N	\N	\N	\N	\N	\N
1553	15	52	EMPTY	\N	\N	\N	\N	\N	\N
1554	15	53	EMPTY	\N	\N	\N	\N	\N	\N
1555	15	54	EMPTY	\N	\N	\N	\N	\N	\N
1556	15	55	EMPTY	\N	\N	\N	\N	\N	\N
1557	15	56	EMPTY	\N	\N	\N	\N	\N	\N
1558	15	57	NPC	\N	\N	9	\N	Barbarian Camp (Lv 9)	\N
1559	15	58	EMPTY	\N	\N	\N	\N	\N	\N
1560	15	59	EMPTY	\N	\N	\N	\N	\N	\N
1561	15	60	EMPTY	\N	\N	\N	\N	\N	\N
1562	15	61	EMPTY	\N	\N	\N	\N	\N	\N
1563	15	62	EMPTY	\N	\N	\N	\N	\N	\N
1564	15	63	EMPTY	\N	\N	\N	\N	\N	\N
1565	15	64	EMPTY	\N	\N	\N	\N	\N	\N
1566	15	65	EMPTY	\N	\N	\N	\N	\N	\N
1567	15	66	VALLEY	\N	\N	\N	\N	Valley (15, 66)	\N
1568	15	67	EMPTY	\N	\N	\N	\N	\N	\N
1569	15	68	EMPTY	\N	\N	\N	\N	\N	\N
1570	15	69	EMPTY	\N	\N	\N	\N	\N	\N
1571	15	70	EMPTY	\N	\N	\N	\N	\N	\N
1572	15	71	EMPTY	\N	\N	\N	\N	\N	\N
1573	15	72	EMPTY	\N	\N	\N	\N	\N	\N
1574	15	73	NPC	\N	\N	1	\N	Barbarian Camp (Lv 1)	\N
1575	15	74	RESOURCE	stone	3	\N	\N	\N	\N
1576	15	75	EMPTY	\N	\N	\N	\N	\N	\N
1577	15	76	EMPTY	\N	\N	\N	\N	\N	\N
1578	15	77	EMPTY	\N	\N	\N	\N	\N	\N
1579	15	78	RESOURCE	iron	1	\N	\N	\N	\N
1580	15	79	EMPTY	\N	\N	\N	\N	\N	\N
1581	15	80	EMPTY	\N	\N	\N	\N	\N	\N
1582	15	81	EMPTY	\N	\N	\N	\N	\N	\N
1583	15	82	EMPTY	\N	\N	\N	\N	\N	\N
1584	15	83	EMPTY	\N	\N	\N	\N	\N	\N
1585	15	84	RESOURCE	stone	2	\N	\N	\N	\N
1586	15	85	EMPTY	\N	\N	\N	\N	\N	\N
1587	15	86	EMPTY	\N	\N	\N	\N	\N	\N
1588	15	87	EMPTY	\N	\N	\N	\N	\N	\N
1589	15	88	RESOURCE	food	3	\N	\N	\N	\N
1590	15	89	EMPTY	\N	\N	\N	\N	\N	\N
1591	15	90	EMPTY	\N	\N	\N	\N	\N	\N
1592	15	91	EMPTY	\N	\N	\N	\N	\N	\N
1593	15	92	EMPTY	\N	\N	\N	\N	\N	\N
1594	15	93	EMPTY	\N	\N	\N	\N	\N	\N
1595	15	94	EMPTY	\N	\N	\N	\N	\N	\N
1596	15	95	EMPTY	\N	\N	\N	\N	\N	\N
1597	15	96	EMPTY	\N	\N	\N	\N	\N	\N
1598	15	97	EMPTY	\N	\N	\N	\N	\N	\N
1599	15	98	EMPTY	\N	\N	\N	\N	\N	\N
1600	15	99	EMPTY	\N	\N	\N	\N	\N	\N
1601	16	0	EMPTY	\N	\N	\N	\N	\N	\N
1602	16	1	EMPTY	\N	\N	\N	\N	\N	\N
1603	16	2	RESOURCE	iron	2	\N	\N	\N	\N
1604	16	3	EMPTY	\N	\N	\N	\N	\N	\N
1605	16	4	EMPTY	\N	\N	\N	\N	\N	\N
1606	16	5	RESOURCE	iron	4	\N	\N	\N	\N
1607	16	6	RESOURCE	iron	4	\N	\N	\N	\N
1608	16	7	EMPTY	\N	\N	\N	\N	\N	\N
1609	16	8	EMPTY	\N	\N	\N	\N	\N	\N
1610	16	9	EMPTY	\N	\N	\N	\N	\N	\N
1611	16	10	NPC	\N	\N	1	\N	Barbarian Camp (Lv 1)	\N
1612	16	11	EMPTY	\N	\N	\N	\N	\N	\N
1613	16	12	EMPTY	\N	\N	\N	\N	\N	\N
1614	16	13	EMPTY	\N	\N	\N	\N	\N	\N
1615	16	14	EMPTY	\N	\N	\N	\N	\N	\N
1616	16	15	EMPTY	\N	\N	\N	\N	\N	\N
1617	16	16	EMPTY	\N	\N	\N	\N	\N	\N
1618	16	17	NPC	\N	\N	4	\N	Barbarian Camp (Lv 4)	\N
1619	16	18	EMPTY	\N	\N	\N	\N	\N	\N
1620	16	19	RESOURCE	iron	3	\N	\N	\N	\N
1621	16	20	EMPTY	\N	\N	\N	\N	\N	\N
1622	16	21	EMPTY	\N	\N	\N	\N	\N	\N
1623	16	22	EMPTY	\N	\N	\N	\N	\N	\N
1624	16	23	EMPTY	\N	\N	\N	\N	\N	\N
1625	16	24	EMPTY	\N	\N	\N	\N	\N	\N
1626	16	25	EMPTY	\N	\N	\N	\N	\N	\N
1627	16	26	EMPTY	\N	\N	\N	\N	\N	\N
1628	16	27	EMPTY	\N	\N	\N	\N	\N	\N
1629	16	28	EMPTY	\N	\N	\N	\N	\N	\N
1630	16	29	EMPTY	\N	\N	\N	\N	\N	\N
1631	16	30	NPC	\N	\N	10	\N	Barbarian Camp (Lv 10)	\N
1632	16	31	EMPTY	\N	\N	\N	\N	\N	\N
1633	16	32	EMPTY	\N	\N	\N	\N	\N	\N
1634	16	33	EMPTY	\N	\N	\N	\N	\N	\N
1635	16	34	EMPTY	\N	\N	\N	\N	\N	\N
1636	16	35	EMPTY	\N	\N	\N	\N	\N	\N
1637	16	36	EMPTY	\N	\N	\N	\N	\N	\N
1638	16	37	EMPTY	\N	\N	\N	\N	\N	\N
1639	16	38	NPC	\N	\N	6	\N	Barbarian Camp (Lv 6)	\N
1640	16	39	EMPTY	\N	\N	\N	\N	\N	\N
1641	16	40	EMPTY	\N	\N	\N	\N	\N	\N
1642	16	41	EMPTY	\N	\N	\N	\N	\N	\N
1643	16	42	EMPTY	\N	\N	\N	\N	\N	\N
1644	16	43	EMPTY	\N	\N	\N	\N	\N	\N
1645	16	44	EMPTY	\N	\N	\N	\N	\N	\N
1646	16	45	EMPTY	\N	\N	\N	\N	\N	\N
1647	16	46	EMPTY	\N	\N	\N	\N	\N	\N
1648	16	47	NPC	\N	\N	5	\N	Barbarian Camp (Lv 5)	\N
1649	16	48	EMPTY	\N	\N	\N	\N	\N	\N
1650	16	49	EMPTY	\N	\N	\N	\N	\N	\N
1651	16	50	EMPTY	\N	\N	\N	\N	\N	\N
1652	16	51	EMPTY	\N	\N	\N	\N	\N	\N
1653	16	52	EMPTY	\N	\N	\N	\N	\N	\N
1654	16	53	EMPTY	\N	\N	\N	\N	\N	\N
1655	16	54	EMPTY	\N	\N	\N	\N	\N	\N
1656	16	55	EMPTY	\N	\N	\N	\N	\N	\N
1657	16	56	EMPTY	\N	\N	\N	\N	\N	\N
1658	16	57	EMPTY	\N	\N	\N	\N	\N	\N
1659	16	58	NPC	\N	\N	6	\N	Barbarian Camp (Lv 6)	\N
1660	16	59	EMPTY	\N	\N	\N	\N	\N	\N
1661	16	60	EMPTY	\N	\N	\N	\N	\N	\N
1662	16	61	EMPTY	\N	\N	\N	\N	\N	\N
1663	16	62	EMPTY	\N	\N	\N	\N	\N	\N
1664	16	63	EMPTY	\N	\N	\N	\N	\N	\N
1665	16	64	EMPTY	\N	\N	\N	\N	\N	\N
1666	16	65	RESOURCE	food	5	\N	\N	\N	\N
1667	16	66	RESOURCE	iron	4	\N	\N	\N	\N
1668	16	67	EMPTY	\N	\N	\N	\N	\N	\N
1669	16	68	NPC	\N	\N	8	\N	Barbarian Camp (Lv 8)	\N
1670	16	69	EMPTY	\N	\N	\N	\N	\N	\N
1671	16	70	EMPTY	\N	\N	\N	\N	\N	\N
1672	16	71	EMPTY	\N	\N	\N	\N	\N	\N
1673	16	72	EMPTY	\N	\N	\N	\N	\N	\N
1674	16	73	EMPTY	\N	\N	\N	\N	\N	\N
1675	16	74	EMPTY	\N	\N	\N	\N	\N	\N
1676	16	75	EMPTY	\N	\N	\N	\N	\N	\N
1677	16	76	EMPTY	\N	\N	\N	\N	\N	\N
1678	16	77	NPC	\N	\N	10	\N	Barbarian Camp (Lv 10)	\N
1679	16	78	EMPTY	\N	\N	\N	\N	\N	\N
1680	16	79	EMPTY	\N	\N	\N	\N	\N	\N
1681	16	80	EMPTY	\N	\N	\N	\N	\N	\N
1682	16	81	EMPTY	\N	\N	\N	\N	\N	\N
1683	16	82	EMPTY	\N	\N	\N	\N	\N	\N
1684	16	83	EMPTY	\N	\N	\N	\N	\N	\N
1685	16	84	EMPTY	\N	\N	\N	\N	\N	\N
1686	16	85	EMPTY	\N	\N	\N	\N	\N	\N
1687	16	86	VALLEY	\N	\N	\N	\N	Valley (16, 86)	\N
1688	16	87	EMPTY	\N	\N	\N	\N	\N	\N
1689	16	88	EMPTY	\N	\N	\N	\N	\N	\N
1690	16	89	EMPTY	\N	\N	\N	\N	\N	\N
1691	16	90	RESOURCE	iron	2	\N	\N	\N	\N
1692	16	91	EMPTY	\N	\N	\N	\N	\N	\N
1693	16	92	EMPTY	\N	\N	\N	\N	\N	\N
1694	16	93	EMPTY	\N	\N	\N	\N	\N	\N
1695	16	94	EMPTY	\N	\N	\N	\N	\N	\N
1696	16	95	EMPTY	\N	\N	\N	\N	\N	\N
1697	16	96	RESOURCE	stone	4	\N	\N	\N	\N
1698	16	97	NPC	\N	\N	7	\N	Barbarian Camp (Lv 7)	\N
1699	16	98	RESOURCE	wood	1	\N	\N	\N	\N
1700	16	99	EMPTY	\N	\N	\N	\N	\N	\N
1701	17	0	EMPTY	\N	\N	\N	\N	\N	\N
1702	17	1	EMPTY	\N	\N	\N	\N	\N	\N
1703	17	2	EMPTY	\N	\N	\N	\N	\N	\N
1704	17	3	EMPTY	\N	\N	\N	\N	\N	\N
1705	17	4	EMPTY	\N	\N	\N	\N	\N	\N
1706	17	5	EMPTY	\N	\N	\N	\N	\N	\N
1707	17	6	RESOURCE	iron	3	\N	\N	\N	\N
1708	17	7	EMPTY	\N	\N	\N	\N	\N	\N
1709	17	8	EMPTY	\N	\N	\N	\N	\N	\N
1710	17	9	VALLEY	\N	\N	\N	\N	Valley (17, 9)	\N
1711	17	10	RESOURCE	iron	3	\N	\N	\N	\N
1712	17	11	VALLEY	\N	\N	\N	\N	Valley (17, 11)	\N
1713	17	12	EMPTY	\N	\N	\N	\N	\N	\N
1714	17	13	EMPTY	\N	\N	\N	\N	\N	\N
1715	17	14	EMPTY	\N	\N	\N	\N	\N	\N
1716	17	15	EMPTY	\N	\N	\N	\N	\N	\N
1717	17	16	EMPTY	\N	\N	\N	\N	\N	\N
1718	17	17	NPC	\N	\N	3	\N	Barbarian Camp (Lv 3)	\N
1719	17	18	EMPTY	\N	\N	\N	\N	\N	\N
1720	17	19	RESOURCE	stone	2	\N	\N	\N	\N
1721	17	20	EMPTY	\N	\N	\N	\N	\N	\N
1722	17	21	RESOURCE	food	5	\N	\N	\N	\N
1723	17	22	EMPTY	\N	\N	\N	\N	\N	\N
1724	17	23	EMPTY	\N	\N	\N	\N	\N	\N
1725	17	24	RESOURCE	food	5	\N	\N	\N	\N
1726	17	25	EMPTY	\N	\N	\N	\N	\N	\N
1727	17	26	NPC	\N	\N	10	\N	Barbarian Camp (Lv 10)	\N
1728	17	27	EMPTY	\N	\N	\N	\N	\N	\N
1729	17	28	EMPTY	\N	\N	\N	\N	\N	\N
1730	17	29	EMPTY	\N	\N	\N	\N	\N	\N
1731	17	30	EMPTY	\N	\N	\N	\N	\N	\N
1732	17	31	EMPTY	\N	\N	\N	\N	\N	\N
1733	17	32	EMPTY	\N	\N	\N	\N	\N	\N
1734	17	33	EMPTY	\N	\N	\N	\N	\N	\N
1735	17	34	EMPTY	\N	\N	\N	\N	\N	\N
1736	17	35	EMPTY	\N	\N	\N	\N	\N	\N
1737	17	36	EMPTY	\N	\N	\N	\N	\N	\N
1738	17	37	EMPTY	\N	\N	\N	\N	\N	\N
1739	17	38	EMPTY	\N	\N	\N	\N	\N	\N
1740	17	39	RESOURCE	stone	5	\N	\N	\N	\N
1741	17	40	RESOURCE	iron	3	\N	\N	\N	\N
1742	17	41	EMPTY	\N	\N	\N	\N	\N	\N
1743	17	42	EMPTY	\N	\N	\N	\N	\N	\N
1744	17	43	EMPTY	\N	\N	\N	\N	\N	\N
1745	17	44	EMPTY	\N	\N	\N	\N	\N	\N
1746	17	45	EMPTY	\N	\N	\N	\N	\N	\N
1747	17	46	EMPTY	\N	\N	\N	\N	\N	\N
1748	17	47	EMPTY	\N	\N	\N	\N	\N	\N
1749	17	48	RESOURCE	iron	2	\N	\N	\N	\N
1750	17	49	EMPTY	\N	\N	\N	\N	\N	\N
1751	17	50	EMPTY	\N	\N	\N	\N	\N	\N
1752	17	51	EMPTY	\N	\N	\N	\N	\N	\N
1753	17	52	EMPTY	\N	\N	\N	\N	\N	\N
1754	17	53	EMPTY	\N	\N	\N	\N	\N	\N
1755	17	54	EMPTY	\N	\N	\N	\N	\N	\N
1756	17	55	EMPTY	\N	\N	\N	\N	\N	\N
1757	17	56	EMPTY	\N	\N	\N	\N	\N	\N
1758	17	57	EMPTY	\N	\N	\N	\N	\N	\N
1759	17	58	EMPTY	\N	\N	\N	\N	\N	\N
1760	17	59	EMPTY	\N	\N	\N	\N	\N	\N
1761	17	60	EMPTY	\N	\N	\N	\N	\N	\N
1762	17	61	EMPTY	\N	\N	\N	\N	\N	\N
1763	17	62	EMPTY	\N	\N	\N	\N	\N	\N
1764	17	63	EMPTY	\N	\N	\N	\N	\N	\N
1765	17	64	EMPTY	\N	\N	\N	\N	\N	\N
1766	17	65	EMPTY	\N	\N	\N	\N	\N	\N
1767	17	66	RESOURCE	stone	5	\N	\N	\N	\N
1768	17	67	EMPTY	\N	\N	\N	\N	\N	\N
1769	17	68	NPC	\N	\N	7	\N	Barbarian Camp (Lv 7)	\N
1770	17	69	EMPTY	\N	\N	\N	\N	\N	\N
1771	17	70	RESOURCE	food	3	\N	\N	\N	\N
1772	17	71	EMPTY	\N	\N	\N	\N	\N	\N
1773	17	72	EMPTY	\N	\N	\N	\N	\N	\N
1774	17	73	EMPTY	\N	\N	\N	\N	\N	\N
1775	17	74	EMPTY	\N	\N	\N	\N	\N	\N
1776	17	75	EMPTY	\N	\N	\N	\N	\N	\N
1777	17	76	NPC	\N	\N	10	\N	Barbarian Camp (Lv 10)	\N
1778	17	77	EMPTY	\N	\N	\N	\N	\N	\N
1779	17	78	EMPTY	\N	\N	\N	\N	\N	\N
1780	17	79	EMPTY	\N	\N	\N	\N	\N	\N
1781	17	80	EMPTY	\N	\N	\N	\N	\N	\N
1782	17	81	RESOURCE	wood	1	\N	\N	\N	\N
1783	17	82	EMPTY	\N	\N	\N	\N	\N	\N
1784	17	83	EMPTY	\N	\N	\N	\N	\N	\N
1785	17	84	VALLEY	\N	\N	\N	\N	Valley (17, 84)	\N
1786	17	85	EMPTY	\N	\N	\N	\N	\N	\N
1787	17	86	EMPTY	\N	\N	\N	\N	\N	\N
1788	17	87	EMPTY	\N	\N	\N	\N	\N	\N
1789	17	88	EMPTY	\N	\N	\N	\N	\N	\N
1790	17	89	EMPTY	\N	\N	\N	\N	\N	\N
1791	17	90	EMPTY	\N	\N	\N	\N	\N	\N
1792	17	91	EMPTY	\N	\N	\N	\N	\N	\N
1793	17	92	EMPTY	\N	\N	\N	\N	\N	\N
1794	17	93	EMPTY	\N	\N	\N	\N	\N	\N
1795	17	94	EMPTY	\N	\N	\N	\N	\N	\N
1796	17	95	EMPTY	\N	\N	\N	\N	\N	\N
1797	17	96	EMPTY	\N	\N	\N	\N	\N	\N
1798	17	97	EMPTY	\N	\N	\N	\N	\N	\N
1799	17	98	EMPTY	\N	\N	\N	\N	\N	\N
1800	17	99	EMPTY	\N	\N	\N	\N	\N	\N
1801	18	0	EMPTY	\N	\N	\N	\N	\N	\N
1802	18	1	EMPTY	\N	\N	\N	\N	\N	\N
1803	18	2	RESOURCE	iron	3	\N	\N	\N	\N
1804	18	3	EMPTY	\N	\N	\N	\N	\N	\N
1805	18	4	EMPTY	\N	\N	\N	\N	\N	\N
1806	18	5	EMPTY	\N	\N	\N	\N	\N	\N
1807	18	6	EMPTY	\N	\N	\N	\N	\N	\N
1808	18	7	EMPTY	\N	\N	\N	\N	\N	\N
1809	18	8	EMPTY	\N	\N	\N	\N	\N	\N
1810	18	9	EMPTY	\N	\N	\N	\N	\N	\N
1811	18	10	EMPTY	\N	\N	\N	\N	\N	\N
1812	18	11	EMPTY	\N	\N	\N	\N	\N	\N
1813	18	12	EMPTY	\N	\N	\N	\N	\N	\N
1814	18	13	EMPTY	\N	\N	\N	\N	\N	\N
1815	18	14	EMPTY	\N	\N	\N	\N	\N	\N
1816	18	15	EMPTY	\N	\N	\N	\N	\N	\N
1817	18	16	RESOURCE	food	4	\N	\N	\N	\N
1818	18	17	EMPTY	\N	\N	\N	\N	\N	\N
1819	18	18	EMPTY	\N	\N	\N	\N	\N	\N
1820	18	19	EMPTY	\N	\N	\N	\N	\N	\N
1821	18	20	EMPTY	\N	\N	\N	\N	\N	\N
1822	18	21	EMPTY	\N	\N	\N	\N	\N	\N
1823	18	22	EMPTY	\N	\N	\N	\N	\N	\N
1824	18	23	EMPTY	\N	\N	\N	\N	\N	\N
1825	18	24	NPC	\N	\N	9	\N	Barbarian Camp (Lv 9)	\N
1826	18	25	EMPTY	\N	\N	\N	\N	\N	\N
1827	18	26	EMPTY	\N	\N	\N	\N	\N	\N
1828	18	27	EMPTY	\N	\N	\N	\N	\N	\N
1829	18	28	EMPTY	\N	\N	\N	\N	\N	\N
1830	18	29	RESOURCE	iron	5	\N	\N	\N	\N
1831	18	30	EMPTY	\N	\N	\N	\N	\N	\N
1832	18	31	EMPTY	\N	\N	\N	\N	\N	\N
1833	18	32	EMPTY	\N	\N	\N	\N	\N	\N
1834	18	33	EMPTY	\N	\N	\N	\N	\N	\N
1835	18	34	EMPTY	\N	\N	\N	\N	\N	\N
1836	18	35	EMPTY	\N	\N	\N	\N	\N	\N
1837	18	36	EMPTY	\N	\N	\N	\N	\N	\N
1838	18	37	EMPTY	\N	\N	\N	\N	\N	\N
1839	18	38	EMPTY	\N	\N	\N	\N	\N	\N
1840	18	39	EMPTY	\N	\N	\N	\N	\N	\N
1841	18	40	RESOURCE	wood	2	\N	\N	\N	\N
1842	18	41	EMPTY	\N	\N	\N	\N	\N	\N
1843	18	42	EMPTY	\N	\N	\N	\N	\N	\N
1844	18	43	EMPTY	\N	\N	\N	\N	\N	\N
1845	18	44	EMPTY	\N	\N	\N	\N	\N	\N
1846	18	45	EMPTY	\N	\N	\N	\N	\N	\N
1847	18	46	EMPTY	\N	\N	\N	\N	\N	\N
1848	18	47	EMPTY	\N	\N	\N	\N	\N	\N
1849	18	48	EMPTY	\N	\N	\N	\N	\N	\N
1850	18	49	EMPTY	\N	\N	\N	\N	\N	\N
1851	18	50	NPC	\N	\N	4	\N	Barbarian Camp (Lv 4)	\N
1852	18	51	EMPTY	\N	\N	\N	\N	\N	\N
1853	18	52	EMPTY	\N	\N	\N	\N	\N	\N
1854	18	53	EMPTY	\N	\N	\N	\N	\N	\N
1855	18	54	NPC	\N	\N	1	\N	Barbarian Camp (Lv 1)	\N
1856	18	55	EMPTY	\N	\N	\N	\N	\N	\N
1857	18	56	EMPTY	\N	\N	\N	\N	\N	\N
1858	18	57	RESOURCE	iron	1	\N	\N	\N	\N
1859	18	58	EMPTY	\N	\N	\N	\N	\N	\N
1860	18	59	EMPTY	\N	\N	\N	\N	\N	\N
1861	18	60	EMPTY	\N	\N	\N	\N	\N	\N
1862	18	61	EMPTY	\N	\N	\N	\N	\N	\N
1863	18	62	NPC	\N	\N	2	\N	Barbarian Camp (Lv 2)	\N
1864	18	63	NPC	\N	\N	9	\N	Barbarian Camp (Lv 9)	\N
1865	18	64	EMPTY	\N	\N	\N	\N	\N	\N
1866	18	65	EMPTY	\N	\N	\N	\N	\N	\N
1867	18	66	EMPTY	\N	\N	\N	\N	\N	\N
1868	18	67	EMPTY	\N	\N	\N	\N	\N	\N
1869	18	68	EMPTY	\N	\N	\N	\N	\N	\N
1870	18	69	RESOURCE	wood	5	\N	\N	\N	\N
1871	18	70	EMPTY	\N	\N	\N	\N	\N	\N
1872	18	71	EMPTY	\N	\N	\N	\N	\N	\N
1873	18	72	EMPTY	\N	\N	\N	\N	\N	\N
1874	18	73	EMPTY	\N	\N	\N	\N	\N	\N
1875	18	74	EMPTY	\N	\N	\N	\N	\N	\N
1876	18	75	EMPTY	\N	\N	\N	\N	\N	\N
1877	18	76	EMPTY	\N	\N	\N	\N	\N	\N
1878	18	77	EMPTY	\N	\N	\N	\N	\N	\N
1879	18	78	EMPTY	\N	\N	\N	\N	\N	\N
1880	18	79	NPC	\N	\N	8	\N	Barbarian Camp (Lv 8)	\N
1881	18	80	EMPTY	\N	\N	\N	\N	\N	\N
1882	18	81	EMPTY	\N	\N	\N	\N	\N	\N
1883	18	82	EMPTY	\N	\N	\N	\N	\N	\N
1884	18	83	NPC	\N	\N	5	\N	Barbarian Camp (Lv 5)	\N
1885	18	84	NPC	\N	\N	4	\N	Barbarian Camp (Lv 4)	\N
1886	18	85	EMPTY	\N	\N	\N	\N	\N	\N
1887	18	86	EMPTY	\N	\N	\N	\N	\N	\N
1888	18	87	EMPTY	\N	\N	\N	\N	\N	\N
1889	18	88	EMPTY	\N	\N	\N	\N	\N	\N
1890	18	89	EMPTY	\N	\N	\N	\N	\N	\N
1891	18	90	EMPTY	\N	\N	\N	\N	\N	\N
1892	18	91	EMPTY	\N	\N	\N	\N	\N	\N
1893	18	92	EMPTY	\N	\N	\N	\N	\N	\N
1894	18	93	EMPTY	\N	\N	\N	\N	\N	\N
1895	18	94	RESOURCE	stone	1	\N	\N	\N	\N
1896	18	95	EMPTY	\N	\N	\N	\N	\N	\N
1897	18	96	EMPTY	\N	\N	\N	\N	\N	\N
1898	18	97	EMPTY	\N	\N	\N	\N	\N	\N
1899	18	98	RESOURCE	food	2	\N	\N	\N	\N
1900	18	99	NPC	\N	\N	9	\N	Barbarian Camp (Lv 9)	\N
1901	19	0	EMPTY	\N	\N	\N	\N	\N	\N
1902	19	1	EMPTY	\N	\N	\N	\N	\N	\N
1903	19	2	EMPTY	\N	\N	\N	\N	\N	\N
1904	19	3	EMPTY	\N	\N	\N	\N	\N	\N
1905	19	4	EMPTY	\N	\N	\N	\N	\N	\N
1906	19	5	EMPTY	\N	\N	\N	\N	\N	\N
1907	19	6	RESOURCE	wood	2	\N	\N	\N	\N
1908	19	7	EMPTY	\N	\N	\N	\N	\N	\N
1909	19	8	EMPTY	\N	\N	\N	\N	\N	\N
1910	19	9	EMPTY	\N	\N	\N	\N	\N	\N
1911	19	10	EMPTY	\N	\N	\N	\N	\N	\N
1912	19	11	EMPTY	\N	\N	\N	\N	\N	\N
1913	19	12	EMPTY	\N	\N	\N	\N	\N	\N
1914	19	13	EMPTY	\N	\N	\N	\N	\N	\N
1915	19	14	EMPTY	\N	\N	\N	\N	\N	\N
1916	19	15	EMPTY	\N	\N	\N	\N	\N	\N
1917	19	16	EMPTY	\N	\N	\N	\N	\N	\N
1918	19	17	EMPTY	\N	\N	\N	\N	\N	\N
1919	19	18	EMPTY	\N	\N	\N	\N	\N	\N
1920	19	19	EMPTY	\N	\N	\N	\N	\N	\N
1921	19	20	EMPTY	\N	\N	\N	\N	\N	\N
1922	19	21	EMPTY	\N	\N	\N	\N	\N	\N
1923	19	22	EMPTY	\N	\N	\N	\N	\N	\N
1924	19	23	EMPTY	\N	\N	\N	\N	\N	\N
1925	19	24	EMPTY	\N	\N	\N	\N	\N	\N
1926	19	25	NPC	\N	\N	4	\N	Barbarian Camp (Lv 4)	\N
1927	19	26	EMPTY	\N	\N	\N	\N	\N	\N
1928	19	27	EMPTY	\N	\N	\N	\N	\N	\N
1929	19	28	EMPTY	\N	\N	\N	\N	\N	\N
1930	19	29	EMPTY	\N	\N	\N	\N	\N	\N
1931	19	30	NPC	\N	\N	6	\N	Barbarian Camp (Lv 6)	\N
1932	19	31	EMPTY	\N	\N	\N	\N	\N	\N
1933	19	32	EMPTY	\N	\N	\N	\N	\N	\N
1934	19	33	EMPTY	\N	\N	\N	\N	\N	\N
1935	19	34	EMPTY	\N	\N	\N	\N	\N	\N
1936	19	35	EMPTY	\N	\N	\N	\N	\N	\N
1937	19	36	EMPTY	\N	\N	\N	\N	\N	\N
1938	19	37	EMPTY	\N	\N	\N	\N	\N	\N
1939	19	38	EMPTY	\N	\N	\N	\N	\N	\N
1940	19	39	EMPTY	\N	\N	\N	\N	\N	\N
1941	19	40	EMPTY	\N	\N	\N	\N	\N	\N
1942	19	41	EMPTY	\N	\N	\N	\N	\N	\N
1943	19	42	RESOURCE	stone	1	\N	\N	\N	\N
1944	19	43	EMPTY	\N	\N	\N	\N	\N	\N
1945	19	44	EMPTY	\N	\N	\N	\N	\N	\N
1946	19	45	EMPTY	\N	\N	\N	\N	\N	\N
1947	19	46	EMPTY	\N	\N	\N	\N	\N	\N
1948	19	47	EMPTY	\N	\N	\N	\N	\N	\N
1949	19	48	EMPTY	\N	\N	\N	\N	\N	\N
1950	19	49	EMPTY	\N	\N	\N	\N	\N	\N
1951	19	50	EMPTY	\N	\N	\N	\N	\N	\N
1952	19	51	EMPTY	\N	\N	\N	\N	\N	\N
1953	19	52	EMPTY	\N	\N	\N	\N	\N	\N
1954	19	53	EMPTY	\N	\N	\N	\N	\N	\N
1955	19	54	EMPTY	\N	\N	\N	\N	\N	\N
1956	19	55	EMPTY	\N	\N	\N	\N	\N	\N
1957	19	56	EMPTY	\N	\N	\N	\N	\N	\N
1958	19	57	EMPTY	\N	\N	\N	\N	\N	\N
1959	19	58	EMPTY	\N	\N	\N	\N	\N	\N
1960	19	59	EMPTY	\N	\N	\N	\N	\N	\N
1961	19	60	EMPTY	\N	\N	\N	\N	\N	\N
1962	19	61	EMPTY	\N	\N	\N	\N	\N	\N
1963	19	62	EMPTY	\N	\N	\N	\N	\N	\N
1964	19	63	EMPTY	\N	\N	\N	\N	\N	\N
1965	19	64	EMPTY	\N	\N	\N	\N	\N	\N
1966	19	65	EMPTY	\N	\N	\N	\N	\N	\N
1967	19	66	VALLEY	\N	\N	\N	\N	Valley (19, 66)	\N
1968	19	67	EMPTY	\N	\N	\N	\N	\N	\N
1969	19	68	NPC	\N	\N	7	\N	Barbarian Camp (Lv 7)	\N
1970	19	69	EMPTY	\N	\N	\N	\N	\N	\N
1971	19	70	EMPTY	\N	\N	\N	\N	\N	\N
1972	19	71	EMPTY	\N	\N	\N	\N	\N	\N
1973	19	72	EMPTY	\N	\N	\N	\N	\N	\N
1974	19	73	EMPTY	\N	\N	\N	\N	\N	\N
1975	19	74	NPC	\N	\N	7	\N	Barbarian Camp (Lv 7)	\N
1976	19	75	EMPTY	\N	\N	\N	\N	\N	\N
1977	19	76	EMPTY	\N	\N	\N	\N	\N	\N
1978	19	77	EMPTY	\N	\N	\N	\N	\N	\N
1979	19	78	EMPTY	\N	\N	\N	\N	\N	\N
1980	19	79	EMPTY	\N	\N	\N	\N	\N	\N
1981	19	80	EMPTY	\N	\N	\N	\N	\N	\N
1982	19	81	EMPTY	\N	\N	\N	\N	\N	\N
1983	19	82	EMPTY	\N	\N	\N	\N	\N	\N
1984	19	83	EMPTY	\N	\N	\N	\N	\N	\N
1985	19	84	EMPTY	\N	\N	\N	\N	\N	\N
1986	19	85	EMPTY	\N	\N	\N	\N	\N	\N
1987	19	86	EMPTY	\N	\N	\N	\N	\N	\N
1988	19	87	EMPTY	\N	\N	\N	\N	\N	\N
1989	19	88	EMPTY	\N	\N	\N	\N	\N	\N
1990	19	89	EMPTY	\N	\N	\N	\N	\N	\N
1991	19	90	EMPTY	\N	\N	\N	\N	\N	\N
1992	19	91	EMPTY	\N	\N	\N	\N	\N	\N
1993	19	92	EMPTY	\N	\N	\N	\N	\N	\N
1994	19	93	RESOURCE	stone	3	\N	\N	\N	\N
1995	19	94	VALLEY	\N	\N	\N	\N	Valley (19, 94)	\N
1996	19	95	RESOURCE	iron	3	\N	\N	\N	\N
1997	19	96	EMPTY	\N	\N	\N	\N	\N	\N
1998	19	97	EMPTY	\N	\N	\N	\N	\N	\N
1999	19	98	EMPTY	\N	\N	\N	\N	\N	\N
2000	19	99	EMPTY	\N	\N	\N	\N	\N	\N
2001	20	0	NPC	\N	\N	7	\N	Barbarian Camp (Lv 7)	\N
2002	20	1	EMPTY	\N	\N	\N	\N	\N	\N
2003	20	2	EMPTY	\N	\N	\N	\N	\N	\N
2004	20	3	RESOURCE	wood	3	\N	\N	\N	\N
2005	20	4	RESOURCE	food	4	\N	\N	\N	\N
2006	20	5	EMPTY	\N	\N	\N	\N	\N	\N
2007	20	6	EMPTY	\N	\N	\N	\N	\N	\N
2008	20	7	EMPTY	\N	\N	\N	\N	\N	\N
2009	20	8	EMPTY	\N	\N	\N	\N	\N	\N
2010	20	9	EMPTY	\N	\N	\N	\N	\N	\N
2011	20	10	RESOURCE	iron	5	\N	\N	\N	\N
2012	20	11	EMPTY	\N	\N	\N	\N	\N	\N
2013	20	12	NPC	\N	\N	8	\N	Barbarian Camp (Lv 8)	\N
2014	20	13	EMPTY	\N	\N	\N	\N	\N	\N
2015	20	14	EMPTY	\N	\N	\N	\N	\N	\N
2016	20	15	EMPTY	\N	\N	\N	\N	\N	\N
2017	20	16	EMPTY	\N	\N	\N	\N	\N	\N
2018	20	17	EMPTY	\N	\N	\N	\N	\N	\N
2019	20	18	RESOURCE	food	4	\N	\N	\N	\N
2020	20	19	EMPTY	\N	\N	\N	\N	\N	\N
2021	20	20	EMPTY	\N	\N	\N	\N	\N	\N
2022	20	21	EMPTY	\N	\N	\N	\N	\N	\N
2023	20	22	RESOURCE	wood	4	\N	\N	\N	\N
2024	20	23	EMPTY	\N	\N	\N	\N	\N	\N
2025	20	24	EMPTY	\N	\N	\N	\N	\N	\N
2026	20	25	EMPTY	\N	\N	\N	\N	\N	\N
2027	20	26	EMPTY	\N	\N	\N	\N	\N	\N
2028	20	27	EMPTY	\N	\N	\N	\N	\N	\N
2029	20	28	EMPTY	\N	\N	\N	\N	\N	\N
2030	20	29	RESOURCE	wood	2	\N	\N	\N	\N
2031	20	30	EMPTY	\N	\N	\N	\N	\N	\N
2032	20	31	EMPTY	\N	\N	\N	\N	\N	\N
2033	20	32	EMPTY	\N	\N	\N	\N	\N	\N
2034	20	33	EMPTY	\N	\N	\N	\N	\N	\N
2035	20	34	EMPTY	\N	\N	\N	\N	\N	\N
2036	20	35	EMPTY	\N	\N	\N	\N	\N	\N
2037	20	36	EMPTY	\N	\N	\N	\N	\N	\N
2038	20	37	EMPTY	\N	\N	\N	\N	\N	\N
2039	20	38	EMPTY	\N	\N	\N	\N	\N	\N
2040	20	39	EMPTY	\N	\N	\N	\N	\N	\N
2041	20	40	EMPTY	\N	\N	\N	\N	\N	\N
2042	20	41	EMPTY	\N	\N	\N	\N	\N	\N
2043	20	42	EMPTY	\N	\N	\N	\N	\N	\N
2044	20	43	RESOURCE	wood	5	\N	\N	\N	\N
2045	20	44	EMPTY	\N	\N	\N	\N	\N	\N
2046	20	45	RESOURCE	iron	4	\N	\N	\N	\N
2047	20	46	EMPTY	\N	\N	\N	\N	\N	\N
2048	20	47	EMPTY	\N	\N	\N	\N	\N	\N
2049	20	48	EMPTY	\N	\N	\N	\N	\N	\N
2050	20	49	VALLEY	\N	\N	\N	\N	Valley (20, 49)	\N
2051	20	50	EMPTY	\N	\N	\N	\N	\N	\N
2052	20	51	EMPTY	\N	\N	\N	\N	\N	\N
2053	20	52	RESOURCE	wood	4	\N	\N	\N	\N
2054	20	53	EMPTY	\N	\N	\N	\N	\N	\N
2055	20	54	EMPTY	\N	\N	\N	\N	\N	\N
2056	20	55	EMPTY	\N	\N	\N	\N	\N	\N
2057	20	56	EMPTY	\N	\N	\N	\N	\N	\N
2058	20	57	RESOURCE	food	3	\N	\N	\N	\N
2059	20	58	EMPTY	\N	\N	\N	\N	\N	\N
2060	20	59	EMPTY	\N	\N	\N	\N	\N	\N
2061	20	60	EMPTY	\N	\N	\N	\N	\N	\N
2062	20	61	EMPTY	\N	\N	\N	\N	\N	\N
2063	20	62	EMPTY	\N	\N	\N	\N	\N	\N
2064	20	63	VALLEY	\N	\N	\N	\N	Valley (20, 63)	\N
2065	20	64	EMPTY	\N	\N	\N	\N	\N	\N
2066	20	65	EMPTY	\N	\N	\N	\N	\N	\N
2067	20	66	NPC	\N	\N	1	\N	Barbarian Camp (Lv 1)	\N
2068	20	67	RESOURCE	iron	4	\N	\N	\N	\N
2069	20	68	EMPTY	\N	\N	\N	\N	\N	\N
2070	20	69	EMPTY	\N	\N	\N	\N	\N	\N
2071	20	70	EMPTY	\N	\N	\N	\N	\N	\N
2072	20	71	EMPTY	\N	\N	\N	\N	\N	\N
2073	20	72	EMPTY	\N	\N	\N	\N	\N	\N
2074	20	73	EMPTY	\N	\N	\N	\N	\N	\N
2075	20	74	EMPTY	\N	\N	\N	\N	\N	\N
2076	20	75	EMPTY	\N	\N	\N	\N	\N	\N
2077	20	76	VALLEY	\N	\N	\N	\N	Valley (20, 76)	\N
2078	20	77	EMPTY	\N	\N	\N	\N	\N	\N
2079	20	78	EMPTY	\N	\N	\N	\N	\N	\N
2080	20	79	EMPTY	\N	\N	\N	\N	\N	\N
2081	20	80	EMPTY	\N	\N	\N	\N	\N	\N
2082	20	81	EMPTY	\N	\N	\N	\N	\N	\N
2083	20	82	EMPTY	\N	\N	\N	\N	\N	\N
2084	20	83	NPC	\N	\N	8	\N	Barbarian Camp (Lv 8)	\N
2085	20	84	EMPTY	\N	\N	\N	\N	\N	\N
2086	20	85	EMPTY	\N	\N	\N	\N	\N	\N
2087	20	86	EMPTY	\N	\N	\N	\N	\N	\N
2088	20	87	EMPTY	\N	\N	\N	\N	\N	\N
2089	20	88	EMPTY	\N	\N	\N	\N	\N	\N
2090	20	89	NPC	\N	\N	5	\N	Barbarian Camp (Lv 5)	\N
2091	20	90	EMPTY	\N	\N	\N	\N	\N	\N
2092	20	91	RESOURCE	stone	4	\N	\N	\N	\N
2093	20	92	EMPTY	\N	\N	\N	\N	\N	\N
2094	20	93	EMPTY	\N	\N	\N	\N	\N	\N
2095	20	94	EMPTY	\N	\N	\N	\N	\N	\N
2096	20	95	EMPTY	\N	\N	\N	\N	\N	\N
2097	20	96	EMPTY	\N	\N	\N	\N	\N	\N
2098	20	97	EMPTY	\N	\N	\N	\N	\N	\N
2099	20	98	EMPTY	\N	\N	\N	\N	\N	\N
2100	20	99	EMPTY	\N	\N	\N	\N	\N	\N
2101	21	0	EMPTY	\N	\N	\N	\N	\N	\N
2102	21	1	EMPTY	\N	\N	\N	\N	\N	\N
2103	21	2	EMPTY	\N	\N	\N	\N	\N	\N
2104	21	3	NPC	\N	\N	8	\N	Barbarian Camp (Lv 8)	\N
2105	21	4	RESOURCE	wood	1	\N	\N	\N	\N
2106	21	5	EMPTY	\N	\N	\N	\N	\N	\N
2107	21	6	EMPTY	\N	\N	\N	\N	\N	\N
2108	21	7	EMPTY	\N	\N	\N	\N	\N	\N
2109	21	8	NPC	\N	\N	8	\N	Barbarian Camp (Lv 8)	\N
2110	21	9	EMPTY	\N	\N	\N	\N	\N	\N
2111	21	10	EMPTY	\N	\N	\N	\N	\N	\N
2112	21	11	EMPTY	\N	\N	\N	\N	\N	\N
2113	21	12	EMPTY	\N	\N	\N	\N	\N	\N
2114	21	13	EMPTY	\N	\N	\N	\N	\N	\N
2115	21	14	EMPTY	\N	\N	\N	\N	\N	\N
2116	21	15	EMPTY	\N	\N	\N	\N	\N	\N
2117	21	16	EMPTY	\N	\N	\N	\N	\N	\N
2118	21	17	EMPTY	\N	\N	\N	\N	\N	\N
2119	21	18	EMPTY	\N	\N	\N	\N	\N	\N
2120	21	19	EMPTY	\N	\N	\N	\N	\N	\N
2121	21	20	EMPTY	\N	\N	\N	\N	\N	\N
2122	21	21	RESOURCE	stone	2	\N	\N	\N	\N
2123	21	22	EMPTY	\N	\N	\N	\N	\N	\N
2124	21	23	NPC	\N	\N	2	\N	Barbarian Camp (Lv 2)	\N
2125	21	24	EMPTY	\N	\N	\N	\N	\N	\N
2126	21	25	EMPTY	\N	\N	\N	\N	\N	\N
2127	21	26	EMPTY	\N	\N	\N	\N	\N	\N
2128	21	27	EMPTY	\N	\N	\N	\N	\N	\N
2129	21	28	RESOURCE	wood	3	\N	\N	\N	\N
2130	21	29	EMPTY	\N	\N	\N	\N	\N	\N
2131	21	30	EMPTY	\N	\N	\N	\N	\N	\N
2132	21	31	EMPTY	\N	\N	\N	\N	\N	\N
2133	21	32	EMPTY	\N	\N	\N	\N	\N	\N
2134	21	33	EMPTY	\N	\N	\N	\N	\N	\N
2135	21	34	RESOURCE	food	1	\N	\N	\N	\N
2136	21	35	EMPTY	\N	\N	\N	\N	\N	\N
2137	21	36	EMPTY	\N	\N	\N	\N	\N	\N
2138	21	37	NPC	\N	\N	1	\N	Barbarian Camp (Lv 1)	\N
2139	21	38	EMPTY	\N	\N	\N	\N	\N	\N
2140	21	39	EMPTY	\N	\N	\N	\N	\N	\N
2141	21	40	EMPTY	\N	\N	\N	\N	\N	\N
2142	21	41	EMPTY	\N	\N	\N	\N	\N	\N
2143	21	42	EMPTY	\N	\N	\N	\N	\N	\N
2144	21	43	EMPTY	\N	\N	\N	\N	\N	\N
2145	21	44	EMPTY	\N	\N	\N	\N	\N	\N
2146	21	45	NPC	\N	\N	10	\N	Barbarian Camp (Lv 10)	\N
2147	21	46	EMPTY	\N	\N	\N	\N	\N	\N
2148	21	47	EMPTY	\N	\N	\N	\N	\N	\N
2149	21	48	EMPTY	\N	\N	\N	\N	\N	\N
2150	21	49	EMPTY	\N	\N	\N	\N	\N	\N
2151	21	50	EMPTY	\N	\N	\N	\N	\N	\N
2152	21	51	EMPTY	\N	\N	\N	\N	\N	\N
2153	21	52	VALLEY	\N	\N	\N	\N	Valley (21, 52)	\N
2154	21	53	EMPTY	\N	\N	\N	\N	\N	\N
2155	21	54	EMPTY	\N	\N	\N	\N	\N	\N
2156	21	55	EMPTY	\N	\N	\N	\N	\N	\N
2157	21	56	RESOURCE	iron	3	\N	\N	\N	\N
2158	21	57	RESOURCE	iron	3	\N	\N	\N	\N
2159	21	58	EMPTY	\N	\N	\N	\N	\N	\N
2160	21	59	EMPTY	\N	\N	\N	\N	\N	\N
2161	21	60	EMPTY	\N	\N	\N	\N	\N	\N
2162	21	61	EMPTY	\N	\N	\N	\N	\N	\N
2163	21	62	VALLEY	\N	\N	\N	\N	Valley (21, 62)	\N
2164	21	63	EMPTY	\N	\N	\N	\N	\N	\N
2165	21	64	RESOURCE	stone	3	\N	\N	\N	\N
2166	21	65	EMPTY	\N	\N	\N	\N	\N	\N
2167	21	66	EMPTY	\N	\N	\N	\N	\N	\N
2168	21	67	EMPTY	\N	\N	\N	\N	\N	\N
2169	21	68	EMPTY	\N	\N	\N	\N	\N	\N
2170	21	69	EMPTY	\N	\N	\N	\N	\N	\N
2171	21	70	NPC	\N	\N	5	\N	Barbarian Camp (Lv 5)	\N
2172	21	71	RESOURCE	food	4	\N	\N	\N	\N
2173	21	72	RESOURCE	wood	2	\N	\N	\N	\N
2174	21	73	EMPTY	\N	\N	\N	\N	\N	\N
2175	21	74	EMPTY	\N	\N	\N	\N	\N	\N
2176	21	75	EMPTY	\N	\N	\N	\N	\N	\N
2177	21	76	NPC	\N	\N	9	\N	Barbarian Camp (Lv 9)	\N
2178	21	77	EMPTY	\N	\N	\N	\N	\N	\N
2179	21	78	EMPTY	\N	\N	\N	\N	\N	\N
2180	21	79	EMPTY	\N	\N	\N	\N	\N	\N
2181	21	80	EMPTY	\N	\N	\N	\N	\N	\N
2182	21	81	RESOURCE	food	1	\N	\N	\N	\N
2183	21	82	EMPTY	\N	\N	\N	\N	\N	\N
2184	21	83	EMPTY	\N	\N	\N	\N	\N	\N
2185	21	84	EMPTY	\N	\N	\N	\N	\N	\N
2186	21	85	EMPTY	\N	\N	\N	\N	\N	\N
2187	21	86	EMPTY	\N	\N	\N	\N	\N	\N
2188	21	87	RESOURCE	wood	1	\N	\N	\N	\N
2189	21	88	NPC	\N	\N	8	\N	Barbarian Camp (Lv 8)	\N
2190	21	89	RESOURCE	wood	3	\N	\N	\N	\N
2191	21	90	RESOURCE	wood	5	\N	\N	\N	\N
2192	21	91	EMPTY	\N	\N	\N	\N	\N	\N
2193	21	92	EMPTY	\N	\N	\N	\N	\N	\N
2194	21	93	EMPTY	\N	\N	\N	\N	\N	\N
2195	21	94	EMPTY	\N	\N	\N	\N	\N	\N
2196	21	95	EMPTY	\N	\N	\N	\N	\N	\N
2197	21	96	EMPTY	\N	\N	\N	\N	\N	\N
2198	21	97	EMPTY	\N	\N	\N	\N	\N	\N
2199	21	98	EMPTY	\N	\N	\N	\N	\N	\N
2200	21	99	NPC	\N	\N	6	\N	Barbarian Camp (Lv 6)	\N
2201	22	0	EMPTY	\N	\N	\N	\N	\N	\N
2202	22	1	EMPTY	\N	\N	\N	\N	\N	\N
2203	22	2	EMPTY	\N	\N	\N	\N	\N	\N
2204	22	3	EMPTY	\N	\N	\N	\N	\N	\N
2205	22	4	EMPTY	\N	\N	\N	\N	\N	\N
2206	22	5	EMPTY	\N	\N	\N	\N	\N	\N
2207	22	6	EMPTY	\N	\N	\N	\N	\N	\N
2208	22	7	EMPTY	\N	\N	\N	\N	\N	\N
2209	22	8	EMPTY	\N	\N	\N	\N	\N	\N
2210	22	9	RESOURCE	stone	3	\N	\N	\N	\N
2211	22	10	EMPTY	\N	\N	\N	\N	\N	\N
2212	22	11	EMPTY	\N	\N	\N	\N	\N	\N
2213	22	12	RESOURCE	wood	3	\N	\N	\N	\N
2214	22	13	EMPTY	\N	\N	\N	\N	\N	\N
2215	22	14	NPC	\N	\N	5	\N	Barbarian Camp (Lv 5)	\N
2216	22	15	EMPTY	\N	\N	\N	\N	\N	\N
2217	22	16	EMPTY	\N	\N	\N	\N	\N	\N
2218	22	17	EMPTY	\N	\N	\N	\N	\N	\N
2219	22	18	EMPTY	\N	\N	\N	\N	\N	\N
2220	22	19	EMPTY	\N	\N	\N	\N	\N	\N
2221	22	20	EMPTY	\N	\N	\N	\N	\N	\N
2222	22	21	RESOURCE	wood	4	\N	\N	\N	\N
2223	22	22	EMPTY	\N	\N	\N	\N	\N	\N
2224	22	23	EMPTY	\N	\N	\N	\N	\N	\N
2225	22	24	EMPTY	\N	\N	\N	\N	\N	\N
2226	22	25	EMPTY	\N	\N	\N	\N	\N	\N
2227	22	26	EMPTY	\N	\N	\N	\N	\N	\N
2228	22	27	EMPTY	\N	\N	\N	\N	\N	\N
2229	22	28	EMPTY	\N	\N	\N	\N	\N	\N
2230	22	29	EMPTY	\N	\N	\N	\N	\N	\N
2231	22	30	EMPTY	\N	\N	\N	\N	\N	\N
2232	22	31	EMPTY	\N	\N	\N	\N	\N	\N
2233	22	32	EMPTY	\N	\N	\N	\N	\N	\N
2234	22	33	EMPTY	\N	\N	\N	\N	\N	\N
2235	22	34	EMPTY	\N	\N	\N	\N	\N	\N
2236	22	35	RESOURCE	stone	1	\N	\N	\N	\N
2237	22	36	EMPTY	\N	\N	\N	\N	\N	\N
2238	22	37	EMPTY	\N	\N	\N	\N	\N	\N
2239	22	38	EMPTY	\N	\N	\N	\N	\N	\N
2240	22	39	EMPTY	\N	\N	\N	\N	\N	\N
2241	22	40	EMPTY	\N	\N	\N	\N	\N	\N
2242	22	41	RESOURCE	food	2	\N	\N	\N	\N
2243	22	42	EMPTY	\N	\N	\N	\N	\N	\N
2244	22	43	EMPTY	\N	\N	\N	\N	\N	\N
2245	22	44	EMPTY	\N	\N	\N	\N	\N	\N
2246	22	45	EMPTY	\N	\N	\N	\N	\N	\N
2247	22	46	EMPTY	\N	\N	\N	\N	\N	\N
2248	22	47	EMPTY	\N	\N	\N	\N	\N	\N
2249	22	48	EMPTY	\N	\N	\N	\N	\N	\N
2250	22	49	EMPTY	\N	\N	\N	\N	\N	\N
2251	22	50	EMPTY	\N	\N	\N	\N	\N	\N
2252	22	51	EMPTY	\N	\N	\N	\N	\N	\N
2253	22	52	EMPTY	\N	\N	\N	\N	\N	\N
2254	22	53	EMPTY	\N	\N	\N	\N	\N	\N
2255	22	54	RESOURCE	food	1	\N	\N	\N	\N
2256	22	55	EMPTY	\N	\N	\N	\N	\N	\N
2257	22	56	EMPTY	\N	\N	\N	\N	\N	\N
2258	22	57	EMPTY	\N	\N	\N	\N	\N	\N
2259	22	58	EMPTY	\N	\N	\N	\N	\N	\N
2260	22	59	EMPTY	\N	\N	\N	\N	\N	\N
2261	22	60	EMPTY	\N	\N	\N	\N	\N	\N
2262	22	61	EMPTY	\N	\N	\N	\N	\N	\N
2263	22	62	EMPTY	\N	\N	\N	\N	\N	\N
2264	22	63	RESOURCE	iron	1	\N	\N	\N	\N
2265	22	64	EMPTY	\N	\N	\N	\N	\N	\N
2266	22	65	RESOURCE	food	3	\N	\N	\N	\N
2267	22	66	RESOURCE	food	5	\N	\N	\N	\N
2268	22	67	EMPTY	\N	\N	\N	\N	\N	\N
2269	22	68	EMPTY	\N	\N	\N	\N	\N	\N
2270	22	69	EMPTY	\N	\N	\N	\N	\N	\N
2271	22	70	EMPTY	\N	\N	\N	\N	\N	\N
2272	22	71	EMPTY	\N	\N	\N	\N	\N	\N
2273	22	72	EMPTY	\N	\N	\N	\N	\N	\N
2274	22	73	NPC	\N	\N	6	\N	Barbarian Camp (Lv 6)	\N
2275	22	74	EMPTY	\N	\N	\N	\N	\N	\N
2276	22	75	EMPTY	\N	\N	\N	\N	\N	\N
2277	22	76	EMPTY	\N	\N	\N	\N	\N	\N
2278	22	77	EMPTY	\N	\N	\N	\N	\N	\N
2279	22	78	RESOURCE	stone	3	\N	\N	\N	\N
2280	22	79	EMPTY	\N	\N	\N	\N	\N	\N
2281	22	80	EMPTY	\N	\N	\N	\N	\N	\N
2282	22	81	EMPTY	\N	\N	\N	\N	\N	\N
2283	22	82	EMPTY	\N	\N	\N	\N	\N	\N
2284	22	83	EMPTY	\N	\N	\N	\N	\N	\N
2285	22	84	EMPTY	\N	\N	\N	\N	\N	\N
2286	22	85	EMPTY	\N	\N	\N	\N	\N	\N
2287	22	86	EMPTY	\N	\N	\N	\N	\N	\N
2288	22	87	EMPTY	\N	\N	\N	\N	\N	\N
2289	22	88	EMPTY	\N	\N	\N	\N	\N	\N
2290	22	89	EMPTY	\N	\N	\N	\N	\N	\N
2291	22	90	EMPTY	\N	\N	\N	\N	\N	\N
2292	22	91	RESOURCE	iron	4	\N	\N	\N	\N
2293	22	92	EMPTY	\N	\N	\N	\N	\N	\N
2294	22	93	EMPTY	\N	\N	\N	\N	\N	\N
2295	22	94	RESOURCE	stone	5	\N	\N	\N	\N
2296	22	95	EMPTY	\N	\N	\N	\N	\N	\N
2297	22	96	EMPTY	\N	\N	\N	\N	\N	\N
2298	22	97	EMPTY	\N	\N	\N	\N	\N	\N
2299	22	98	EMPTY	\N	\N	\N	\N	\N	\N
2300	22	99	EMPTY	\N	\N	\N	\N	\N	\N
2301	23	0	EMPTY	\N	\N	\N	\N	\N	\N
2302	23	1	EMPTY	\N	\N	\N	\N	\N	\N
2303	23	2	EMPTY	\N	\N	\N	\N	\N	\N
2304	23	3	EMPTY	\N	\N	\N	\N	\N	\N
2305	23	4	EMPTY	\N	\N	\N	\N	\N	\N
2306	23	5	RESOURCE	wood	5	\N	\N	\N	\N
2307	23	6	EMPTY	\N	\N	\N	\N	\N	\N
2308	23	7	EMPTY	\N	\N	\N	\N	\N	\N
2309	23	8	EMPTY	\N	\N	\N	\N	\N	\N
2310	23	9	EMPTY	\N	\N	\N	\N	\N	\N
2311	23	10	VALLEY	\N	\N	\N	\N	Valley (23, 10)	\N
2312	23	11	EMPTY	\N	\N	\N	\N	\N	\N
2313	23	12	EMPTY	\N	\N	\N	\N	\N	\N
2314	23	13	EMPTY	\N	\N	\N	\N	\N	\N
2315	23	14	EMPTY	\N	\N	\N	\N	\N	\N
2316	23	15	EMPTY	\N	\N	\N	\N	\N	\N
2317	23	16	EMPTY	\N	\N	\N	\N	\N	\N
2318	23	17	EMPTY	\N	\N	\N	\N	\N	\N
2319	23	18	EMPTY	\N	\N	\N	\N	\N	\N
2320	23	19	EMPTY	\N	\N	\N	\N	\N	\N
2321	23	20	EMPTY	\N	\N	\N	\N	\N	\N
2322	23	21	EMPTY	\N	\N	\N	\N	\N	\N
2323	23	22	EMPTY	\N	\N	\N	\N	\N	\N
2324	23	23	RESOURCE	food	5	\N	\N	\N	\N
2325	23	24	EMPTY	\N	\N	\N	\N	\N	\N
2326	23	25	EMPTY	\N	\N	\N	\N	\N	\N
2327	23	26	EMPTY	\N	\N	\N	\N	\N	\N
2328	23	27	EMPTY	\N	\N	\N	\N	\N	\N
2329	23	28	EMPTY	\N	\N	\N	\N	\N	\N
2330	23	29	EMPTY	\N	\N	\N	\N	\N	\N
2331	23	30	EMPTY	\N	\N	\N	\N	\N	\N
2332	23	31	EMPTY	\N	\N	\N	\N	\N	\N
2333	23	32	RESOURCE	iron	3	\N	\N	\N	\N
2334	23	33	EMPTY	\N	\N	\N	\N	\N	\N
2335	23	34	EMPTY	\N	\N	\N	\N	\N	\N
2336	23	35	RESOURCE	stone	2	\N	\N	\N	\N
2337	23	36	EMPTY	\N	\N	\N	\N	\N	\N
2338	23	37	EMPTY	\N	\N	\N	\N	\N	\N
2339	23	38	NPC	\N	\N	4	\N	Barbarian Camp (Lv 4)	\N
2340	23	39	RESOURCE	wood	5	\N	\N	\N	\N
2341	23	40	EMPTY	\N	\N	\N	\N	\N	\N
2342	23	41	EMPTY	\N	\N	\N	\N	\N	\N
2343	23	42	NPC	\N	\N	10	\N	Barbarian Camp (Lv 10)	\N
2344	23	43	EMPTY	\N	\N	\N	\N	\N	\N
2345	23	44	EMPTY	\N	\N	\N	\N	\N	\N
2346	23	45	EMPTY	\N	\N	\N	\N	\N	\N
2347	23	46	EMPTY	\N	\N	\N	\N	\N	\N
2348	23	47	EMPTY	\N	\N	\N	\N	\N	\N
2349	23	48	EMPTY	\N	\N	\N	\N	\N	\N
2350	23	49	EMPTY	\N	\N	\N	\N	\N	\N
2351	23	50	EMPTY	\N	\N	\N	\N	\N	\N
2352	23	51	EMPTY	\N	\N	\N	\N	\N	\N
2353	23	52	EMPTY	\N	\N	\N	\N	\N	\N
2354	23	53	EMPTY	\N	\N	\N	\N	\N	\N
2355	23	54	EMPTY	\N	\N	\N	\N	\N	\N
2356	23	55	EMPTY	\N	\N	\N	\N	\N	\N
2357	23	56	EMPTY	\N	\N	\N	\N	\N	\N
2358	23	57	EMPTY	\N	\N	\N	\N	\N	\N
2359	23	58	EMPTY	\N	\N	\N	\N	\N	\N
2360	23	59	NPC	\N	\N	7	\N	Barbarian Camp (Lv 7)	\N
2361	23	60	EMPTY	\N	\N	\N	\N	\N	\N
2362	23	61	EMPTY	\N	\N	\N	\N	\N	\N
2363	23	62	EMPTY	\N	\N	\N	\N	\N	\N
2364	23	63	EMPTY	\N	\N	\N	\N	\N	\N
2365	23	64	EMPTY	\N	\N	\N	\N	\N	\N
2366	23	65	EMPTY	\N	\N	\N	\N	\N	\N
2367	23	66	EMPTY	\N	\N	\N	\N	\N	\N
2368	23	67	EMPTY	\N	\N	\N	\N	\N	\N
2369	23	68	EMPTY	\N	\N	\N	\N	\N	\N
2370	23	69	EMPTY	\N	\N	\N	\N	\N	\N
2371	23	70	EMPTY	\N	\N	\N	\N	\N	\N
2372	23	71	EMPTY	\N	\N	\N	\N	\N	\N
2373	23	72	EMPTY	\N	\N	\N	\N	\N	\N
2374	23	73	EMPTY	\N	\N	\N	\N	\N	\N
2375	23	74	EMPTY	\N	\N	\N	\N	\N	\N
2376	23	75	EMPTY	\N	\N	\N	\N	\N	\N
2377	23	76	NPC	\N	\N	5	\N	Barbarian Camp (Lv 5)	\N
2378	23	77	EMPTY	\N	\N	\N	\N	\N	\N
2379	23	78	EMPTY	\N	\N	\N	\N	\N	\N
2380	23	79	EMPTY	\N	\N	\N	\N	\N	\N
2381	23	80	NPC	\N	\N	6	\N	Barbarian Camp (Lv 6)	\N
2382	23	81	EMPTY	\N	\N	\N	\N	\N	\N
2383	23	82	EMPTY	\N	\N	\N	\N	\N	\N
2384	23	83	EMPTY	\N	\N	\N	\N	\N	\N
2385	23	84	EMPTY	\N	\N	\N	\N	\N	\N
2386	23	85	EMPTY	\N	\N	\N	\N	\N	\N
2387	23	86	EMPTY	\N	\N	\N	\N	\N	\N
2388	23	87	EMPTY	\N	\N	\N	\N	\N	\N
2389	23	88	EMPTY	\N	\N	\N	\N	\N	\N
2390	23	89	RESOURCE	wood	2	\N	\N	\N	\N
2391	23	90	EMPTY	\N	\N	\N	\N	\N	\N
2392	23	91	EMPTY	\N	\N	\N	\N	\N	\N
2393	23	92	RESOURCE	food	5	\N	\N	\N	\N
2394	23	93	EMPTY	\N	\N	\N	\N	\N	\N
2395	23	94	EMPTY	\N	\N	\N	\N	\N	\N
2396	23	95	EMPTY	\N	\N	\N	\N	\N	\N
2397	23	96	EMPTY	\N	\N	\N	\N	\N	\N
2398	23	97	EMPTY	\N	\N	\N	\N	\N	\N
2399	23	98	EMPTY	\N	\N	\N	\N	\N	\N
2400	23	99	EMPTY	\N	\N	\N	\N	\N	\N
2401	24	0	EMPTY	\N	\N	\N	\N	\N	\N
2402	24	1	EMPTY	\N	\N	\N	\N	\N	\N
2403	24	2	EMPTY	\N	\N	\N	\N	\N	\N
2404	24	3	RESOURCE	wood	5	\N	\N	\N	\N
2405	24	4	EMPTY	\N	\N	\N	\N	\N	\N
2406	24	5	EMPTY	\N	\N	\N	\N	\N	\N
2407	24	6	EMPTY	\N	\N	\N	\N	\N	\N
2408	24	7	EMPTY	\N	\N	\N	\N	\N	\N
2409	24	8	EMPTY	\N	\N	\N	\N	\N	\N
2410	24	9	EMPTY	\N	\N	\N	\N	\N	\N
2411	24	10	EMPTY	\N	\N	\N	\N	\N	\N
2412	24	11	EMPTY	\N	\N	\N	\N	\N	\N
2413	24	12	EMPTY	\N	\N	\N	\N	\N	\N
2414	24	13	EMPTY	\N	\N	\N	\N	\N	\N
2415	24	14	EMPTY	\N	\N	\N	\N	\N	\N
2416	24	15	EMPTY	\N	\N	\N	\N	\N	\N
2417	24	16	EMPTY	\N	\N	\N	\N	\N	\N
2418	24	17	EMPTY	\N	\N	\N	\N	\N	\N
2419	24	18	EMPTY	\N	\N	\N	\N	\N	\N
2420	24	19	EMPTY	\N	\N	\N	\N	\N	\N
2421	24	20	EMPTY	\N	\N	\N	\N	\N	\N
2422	24	21	EMPTY	\N	\N	\N	\N	\N	\N
2423	24	22	EMPTY	\N	\N	\N	\N	\N	\N
2424	24	23	EMPTY	\N	\N	\N	\N	\N	\N
2425	24	24	EMPTY	\N	\N	\N	\N	\N	\N
2426	24	25	EMPTY	\N	\N	\N	\N	\N	\N
2427	24	26	EMPTY	\N	\N	\N	\N	\N	\N
2428	24	27	EMPTY	\N	\N	\N	\N	\N	\N
2429	24	28	EMPTY	\N	\N	\N	\N	\N	\N
2430	24	29	EMPTY	\N	\N	\N	\N	\N	\N
2431	24	30	EMPTY	\N	\N	\N	\N	\N	\N
2432	24	31	EMPTY	\N	\N	\N	\N	\N	\N
2433	24	32	EMPTY	\N	\N	\N	\N	\N	\N
2434	24	33	EMPTY	\N	\N	\N	\N	\N	\N
2435	24	34	EMPTY	\N	\N	\N	\N	\N	\N
2436	24	35	EMPTY	\N	\N	\N	\N	\N	\N
2437	24	36	EMPTY	\N	\N	\N	\N	\N	\N
2438	24	37	EMPTY	\N	\N	\N	\N	\N	\N
2439	24	38	EMPTY	\N	\N	\N	\N	\N	\N
2440	24	39	RESOURCE	wood	5	\N	\N	\N	\N
2441	24	40	EMPTY	\N	\N	\N	\N	\N	\N
2442	24	41	EMPTY	\N	\N	\N	\N	\N	\N
2443	24	42	EMPTY	\N	\N	\N	\N	\N	\N
2444	24	43	EMPTY	\N	\N	\N	\N	\N	\N
2445	24	44	EMPTY	\N	\N	\N	\N	\N	\N
2446	24	45	EMPTY	\N	\N	\N	\N	\N	\N
2447	24	46	EMPTY	\N	\N	\N	\N	\N	\N
2448	24	47	EMPTY	\N	\N	\N	\N	\N	\N
2449	24	48	RESOURCE	food	3	\N	\N	\N	\N
2450	24	49	EMPTY	\N	\N	\N	\N	\N	\N
2451	24	50	EMPTY	\N	\N	\N	\N	\N	\N
2452	24	51	EMPTY	\N	\N	\N	\N	\N	\N
2453	24	52	EMPTY	\N	\N	\N	\N	\N	\N
2454	24	53	EMPTY	\N	\N	\N	\N	\N	\N
2455	24	54	EMPTY	\N	\N	\N	\N	\N	\N
2456	24	55	EMPTY	\N	\N	\N	\N	\N	\N
2457	24	56	VALLEY	\N	\N	\N	\N	Valley (24, 56)	\N
2458	24	57	EMPTY	\N	\N	\N	\N	\N	\N
2459	24	58	EMPTY	\N	\N	\N	\N	\N	\N
2460	24	59	NPC	\N	\N	10	\N	Barbarian Camp (Lv 10)	\N
2461	24	60	RESOURCE	wood	4	\N	\N	\N	\N
2462	24	61	RESOURCE	stone	2	\N	\N	\N	\N
2463	24	62	EMPTY	\N	\N	\N	\N	\N	\N
2464	24	63	EMPTY	\N	\N	\N	\N	\N	\N
2465	24	64	NPC	\N	\N	5	\N	Barbarian Camp (Lv 5)	\N
2466	24	65	EMPTY	\N	\N	\N	\N	\N	\N
2467	24	66	NPC	\N	\N	1	\N	Barbarian Camp (Lv 1)	\N
2468	24	67	RESOURCE	food	1	\N	\N	\N	\N
2469	24	68	EMPTY	\N	\N	\N	\N	\N	\N
2470	24	69	EMPTY	\N	\N	\N	\N	\N	\N
2471	24	70	EMPTY	\N	\N	\N	\N	\N	\N
2472	24	71	RESOURCE	stone	2	\N	\N	\N	\N
2473	24	72	EMPTY	\N	\N	\N	\N	\N	\N
2474	24	73	RESOURCE	iron	2	\N	\N	\N	\N
2475	24	74	RESOURCE	wood	3	\N	\N	\N	\N
2476	24	75	EMPTY	\N	\N	\N	\N	\N	\N
2477	24	76	EMPTY	\N	\N	\N	\N	\N	\N
2478	24	77	VALLEY	\N	\N	\N	\N	Valley (24, 77)	\N
2479	24	78	EMPTY	\N	\N	\N	\N	\N	\N
2480	24	79	EMPTY	\N	\N	\N	\N	\N	\N
2481	24	80	EMPTY	\N	\N	\N	\N	\N	\N
2482	24	81	EMPTY	\N	\N	\N	\N	\N	\N
2483	24	82	VALLEY	\N	\N	\N	\N	Valley (24, 82)	\N
2484	24	83	EMPTY	\N	\N	\N	\N	\N	\N
2485	24	84	NPC	\N	\N	7	\N	Barbarian Camp (Lv 7)	\N
2486	24	85	EMPTY	\N	\N	\N	\N	\N	\N
2487	24	86	EMPTY	\N	\N	\N	\N	\N	\N
2488	24	87	RESOURCE	stone	5	\N	\N	\N	\N
2489	24	88	EMPTY	\N	\N	\N	\N	\N	\N
2490	24	89	EMPTY	\N	\N	\N	\N	\N	\N
2491	24	90	EMPTY	\N	\N	\N	\N	\N	\N
2492	24	91	EMPTY	\N	\N	\N	\N	\N	\N
2493	24	92	EMPTY	\N	\N	\N	\N	\N	\N
2494	24	93	NPC	\N	\N	10	\N	Barbarian Camp (Lv 10)	\N
2495	24	94	RESOURCE	stone	2	\N	\N	\N	\N
2496	24	95	EMPTY	\N	\N	\N	\N	\N	\N
2497	24	96	EMPTY	\N	\N	\N	\N	\N	\N
2498	24	97	EMPTY	\N	\N	\N	\N	\N	\N
2499	24	98	EMPTY	\N	\N	\N	\N	\N	\N
2500	24	99	EMPTY	\N	\N	\N	\N	\N	\N
2501	25	0	EMPTY	\N	\N	\N	\N	\N	\N
2502	25	1	NPC	\N	\N	5	\N	Barbarian Camp (Lv 5)	\N
2503	25	2	RESOURCE	iron	5	\N	\N	\N	\N
2504	25	3	EMPTY	\N	\N	\N	\N	\N	\N
2505	25	4	RESOURCE	iron	2	\N	\N	\N	\N
2506	25	5	EMPTY	\N	\N	\N	\N	\N	\N
2507	25	6	EMPTY	\N	\N	\N	\N	\N	\N
2508	25	7	EMPTY	\N	\N	\N	\N	\N	\N
2509	25	8	EMPTY	\N	\N	\N	\N	\N	\N
2510	25	9	EMPTY	\N	\N	\N	\N	\N	\N
2511	25	10	EMPTY	\N	\N	\N	\N	\N	\N
2512	25	11	EMPTY	\N	\N	\N	\N	\N	\N
2513	25	12	EMPTY	\N	\N	\N	\N	\N	\N
2514	25	13	EMPTY	\N	\N	\N	\N	\N	\N
2515	25	14	EMPTY	\N	\N	\N	\N	\N	\N
2516	25	15	EMPTY	\N	\N	\N	\N	\N	\N
2517	25	16	EMPTY	\N	\N	\N	\N	\N	\N
2518	25	17	EMPTY	\N	\N	\N	\N	\N	\N
2519	25	18	NPC	\N	\N	4	\N	Barbarian Camp (Lv 4)	\N
2520	25	19	NPC	\N	\N	4	\N	Barbarian Camp (Lv 4)	\N
2521	25	20	EMPTY	\N	\N	\N	\N	\N	\N
2522	25	21	EMPTY	\N	\N	\N	\N	\N	\N
2523	25	22	EMPTY	\N	\N	\N	\N	\N	\N
2524	25	23	EMPTY	\N	\N	\N	\N	\N	\N
2525	25	24	EMPTY	\N	\N	\N	\N	\N	\N
2526	25	25	NPC	\N	\N	2	\N	Barbarian Camp (Lv 2)	\N
2527	25	26	EMPTY	\N	\N	\N	\N	\N	\N
2528	25	27	EMPTY	\N	\N	\N	\N	\N	\N
2529	25	28	EMPTY	\N	\N	\N	\N	\N	\N
2530	25	29	EMPTY	\N	\N	\N	\N	\N	\N
2531	25	30	EMPTY	\N	\N	\N	\N	\N	\N
2532	25	31	EMPTY	\N	\N	\N	\N	\N	\N
2533	25	32	EMPTY	\N	\N	\N	\N	\N	\N
2534	25	33	EMPTY	\N	\N	\N	\N	\N	\N
2535	25	34	EMPTY	\N	\N	\N	\N	\N	\N
2536	25	35	EMPTY	\N	\N	\N	\N	\N	\N
2537	25	36	NPC	\N	\N	8	\N	Barbarian Camp (Lv 8)	\N
2538	25	37	EMPTY	\N	\N	\N	\N	\N	\N
2539	25	38	EMPTY	\N	\N	\N	\N	\N	\N
2540	25	39	EMPTY	\N	\N	\N	\N	\N	\N
2541	25	40	EMPTY	\N	\N	\N	\N	\N	\N
2542	25	41	EMPTY	\N	\N	\N	\N	\N	\N
2543	25	42	EMPTY	\N	\N	\N	\N	\N	\N
2544	25	43	EMPTY	\N	\N	\N	\N	\N	\N
2545	25	44	EMPTY	\N	\N	\N	\N	\N	\N
2546	25	45	EMPTY	\N	\N	\N	\N	\N	\N
2547	25	46	EMPTY	\N	\N	\N	\N	\N	\N
2548	25	47	NPC	\N	\N	1	\N	Barbarian Camp (Lv 1)	\N
2549	25	48	EMPTY	\N	\N	\N	\N	\N	\N
2550	25	49	EMPTY	\N	\N	\N	\N	\N	\N
2551	25	50	EMPTY	\N	\N	\N	\N	\N	\N
2552	25	51	EMPTY	\N	\N	\N	\N	\N	\N
2553	25	52	EMPTY	\N	\N	\N	\N	\N	\N
2554	25	53	EMPTY	\N	\N	\N	\N	\N	\N
2555	25	54	EMPTY	\N	\N	\N	\N	\N	\N
2556	25	55	EMPTY	\N	\N	\N	\N	\N	\N
2557	25	56	EMPTY	\N	\N	\N	\N	\N	\N
2558	25	57	EMPTY	\N	\N	\N	\N	\N	\N
2559	25	58	EMPTY	\N	\N	\N	\N	\N	\N
2560	25	59	EMPTY	\N	\N	\N	\N	\N	\N
2561	25	60	EMPTY	\N	\N	\N	\N	\N	\N
2562	25	61	EMPTY	\N	\N	\N	\N	\N	\N
2563	25	62	EMPTY	\N	\N	\N	\N	\N	\N
2564	25	63	EMPTY	\N	\N	\N	\N	\N	\N
2565	25	64	RESOURCE	iron	4	\N	\N	\N	\N
2566	25	65	EMPTY	\N	\N	\N	\N	\N	\N
2567	25	66	NPC	\N	\N	2	\N	Barbarian Camp (Lv 2)	\N
2568	25	67	EMPTY	\N	\N	\N	\N	\N	\N
2569	25	68	RESOURCE	stone	2	\N	\N	\N	\N
2570	25	69	EMPTY	\N	\N	\N	\N	\N	\N
2571	25	70	EMPTY	\N	\N	\N	\N	\N	\N
2572	25	71	EMPTY	\N	\N	\N	\N	\N	\N
2573	25	72	EMPTY	\N	\N	\N	\N	\N	\N
2574	25	73	EMPTY	\N	\N	\N	\N	\N	\N
2575	25	74	EMPTY	\N	\N	\N	\N	\N	\N
2576	25	75	EMPTY	\N	\N	\N	\N	\N	\N
2577	25	76	EMPTY	\N	\N	\N	\N	\N	\N
2578	25	77	EMPTY	\N	\N	\N	\N	\N	\N
2579	25	78	EMPTY	\N	\N	\N	\N	\N	\N
2580	25	79	EMPTY	\N	\N	\N	\N	\N	\N
2581	25	80	EMPTY	\N	\N	\N	\N	\N	\N
2582	25	81	EMPTY	\N	\N	\N	\N	\N	\N
2583	25	82	EMPTY	\N	\N	\N	\N	\N	\N
2584	25	83	RESOURCE	food	2	\N	\N	\N	\N
2585	25	84	EMPTY	\N	\N	\N	\N	\N	\N
2586	25	85	EMPTY	\N	\N	\N	\N	\N	\N
2587	25	86	EMPTY	\N	\N	\N	\N	\N	\N
2588	25	87	EMPTY	\N	\N	\N	\N	\N	\N
2589	25	88	EMPTY	\N	\N	\N	\N	\N	\N
2590	25	89	EMPTY	\N	\N	\N	\N	\N	\N
2591	25	90	EMPTY	\N	\N	\N	\N	\N	\N
2592	25	91	EMPTY	\N	\N	\N	\N	\N	\N
2593	25	92	EMPTY	\N	\N	\N	\N	\N	\N
2594	25	93	EMPTY	\N	\N	\N	\N	\N	\N
2595	25	94	EMPTY	\N	\N	\N	\N	\N	\N
2596	25	95	EMPTY	\N	\N	\N	\N	\N	\N
2597	25	96	EMPTY	\N	\N	\N	\N	\N	\N
2598	25	97	EMPTY	\N	\N	\N	\N	\N	\N
2599	25	98	EMPTY	\N	\N	\N	\N	\N	\N
2600	25	99	RESOURCE	food	3	\N	\N	\N	\N
2601	26	0	EMPTY	\N	\N	\N	\N	\N	\N
2602	26	1	RESOURCE	food	3	\N	\N	\N	\N
2603	26	2	RESOURCE	food	5	\N	\N	\N	\N
2604	26	3	EMPTY	\N	\N	\N	\N	\N	\N
2605	26	4	EMPTY	\N	\N	\N	\N	\N	\N
2606	26	5	VALLEY	\N	\N	\N	\N	Valley (26, 5)	\N
2607	26	6	RESOURCE	wood	3	\N	\N	\N	\N
2608	26	7	EMPTY	\N	\N	\N	\N	\N	\N
2609	26	8	RESOURCE	wood	5	\N	\N	\N	\N
2610	26	9	EMPTY	\N	\N	\N	\N	\N	\N
2611	26	10	EMPTY	\N	\N	\N	\N	\N	\N
2612	26	11	EMPTY	\N	\N	\N	\N	\N	\N
2613	26	12	EMPTY	\N	\N	\N	\N	\N	\N
2614	26	13	EMPTY	\N	\N	\N	\N	\N	\N
2615	26	14	EMPTY	\N	\N	\N	\N	\N	\N
2616	26	15	NPC	\N	\N	2	\N	Barbarian Camp (Lv 2)	\N
2617	26	16	EMPTY	\N	\N	\N	\N	\N	\N
2618	26	17	EMPTY	\N	\N	\N	\N	\N	\N
2619	26	18	EMPTY	\N	\N	\N	\N	\N	\N
2620	26	19	EMPTY	\N	\N	\N	\N	\N	\N
2621	26	20	EMPTY	\N	\N	\N	\N	\N	\N
2622	26	21	EMPTY	\N	\N	\N	\N	\N	\N
2623	26	22	EMPTY	\N	\N	\N	\N	\N	\N
2624	26	23	EMPTY	\N	\N	\N	\N	\N	\N
2625	26	24	EMPTY	\N	\N	\N	\N	\N	\N
2626	26	25	EMPTY	\N	\N	\N	\N	\N	\N
2627	26	26	EMPTY	\N	\N	\N	\N	\N	\N
2628	26	27	EMPTY	\N	\N	\N	\N	\N	\N
2629	26	28	EMPTY	\N	\N	\N	\N	\N	\N
2630	26	29	RESOURCE	food	3	\N	\N	\N	\N
2631	26	30	EMPTY	\N	\N	\N	\N	\N	\N
2632	26	31	EMPTY	\N	\N	\N	\N	\N	\N
2633	26	32	EMPTY	\N	\N	\N	\N	\N	\N
2634	26	33	EMPTY	\N	\N	\N	\N	\N	\N
2635	26	34	EMPTY	\N	\N	\N	\N	\N	\N
2636	26	35	EMPTY	\N	\N	\N	\N	\N	\N
2637	26	36	EMPTY	\N	\N	\N	\N	\N	\N
2638	26	37	EMPTY	\N	\N	\N	\N	\N	\N
2639	26	38	EMPTY	\N	\N	\N	\N	\N	\N
2640	26	39	EMPTY	\N	\N	\N	\N	\N	\N
2641	26	40	RESOURCE	wood	4	\N	\N	\N	\N
2642	26	41	RESOURCE	stone	1	\N	\N	\N	\N
2643	26	42	EMPTY	\N	\N	\N	\N	\N	\N
2644	26	43	EMPTY	\N	\N	\N	\N	\N	\N
2645	26	44	EMPTY	\N	\N	\N	\N	\N	\N
2646	26	45	EMPTY	\N	\N	\N	\N	\N	\N
2647	26	46	EMPTY	\N	\N	\N	\N	\N	\N
2648	26	47	EMPTY	\N	\N	\N	\N	\N	\N
2649	26	48	EMPTY	\N	\N	\N	\N	\N	\N
2650	26	49	EMPTY	\N	\N	\N	\N	\N	\N
2651	26	50	NPC	\N	\N	6	\N	Barbarian Camp (Lv 6)	\N
2652	26	51	EMPTY	\N	\N	\N	\N	\N	\N
2653	26	52	NPC	\N	\N	10	\N	Barbarian Camp (Lv 10)	\N
2654	26	53	EMPTY	\N	\N	\N	\N	\N	\N
2655	26	54	EMPTY	\N	\N	\N	\N	\N	\N
2656	26	55	EMPTY	\N	\N	\N	\N	\N	\N
2657	26	56	EMPTY	\N	\N	\N	\N	\N	\N
2658	26	57	EMPTY	\N	\N	\N	\N	\N	\N
2659	26	58	EMPTY	\N	\N	\N	\N	\N	\N
2660	26	59	EMPTY	\N	\N	\N	\N	\N	\N
2661	26	60	EMPTY	\N	\N	\N	\N	\N	\N
2662	26	61	EMPTY	\N	\N	\N	\N	\N	\N
2663	26	62	EMPTY	\N	\N	\N	\N	\N	\N
2664	26	63	EMPTY	\N	\N	\N	\N	\N	\N
2665	26	64	EMPTY	\N	\N	\N	\N	\N	\N
2666	26	65	EMPTY	\N	\N	\N	\N	\N	\N
2667	26	66	EMPTY	\N	\N	\N	\N	\N	\N
2668	26	67	EMPTY	\N	\N	\N	\N	\N	\N
2669	26	68	EMPTY	\N	\N	\N	\N	\N	\N
2670	26	69	EMPTY	\N	\N	\N	\N	\N	\N
2671	26	70	EMPTY	\N	\N	\N	\N	\N	\N
2672	26	71	EMPTY	\N	\N	\N	\N	\N	\N
2673	26	72	EMPTY	\N	\N	\N	\N	\N	\N
2674	26	73	EMPTY	\N	\N	\N	\N	\N	\N
2675	26	74	EMPTY	\N	\N	\N	\N	\N	\N
2676	26	75	EMPTY	\N	\N	\N	\N	\N	\N
2677	26	76	EMPTY	\N	\N	\N	\N	\N	\N
2678	26	77	EMPTY	\N	\N	\N	\N	\N	\N
2679	26	78	EMPTY	\N	\N	\N	\N	\N	\N
2680	26	79	EMPTY	\N	\N	\N	\N	\N	\N
2681	26	80	EMPTY	\N	\N	\N	\N	\N	\N
2682	26	81	EMPTY	\N	\N	\N	\N	\N	\N
2683	26	82	RESOURCE	wood	2	\N	\N	\N	\N
2684	26	83	EMPTY	\N	\N	\N	\N	\N	\N
2685	26	84	EMPTY	\N	\N	\N	\N	\N	\N
2686	26	85	EMPTY	\N	\N	\N	\N	\N	\N
2687	26	86	EMPTY	\N	\N	\N	\N	\N	\N
2688	26	87	EMPTY	\N	\N	\N	\N	\N	\N
2689	26	88	EMPTY	\N	\N	\N	\N	\N	\N
2690	26	89	EMPTY	\N	\N	\N	\N	\N	\N
2691	26	90	EMPTY	\N	\N	\N	\N	\N	\N
2692	26	91	EMPTY	\N	\N	\N	\N	\N	\N
2693	26	92	EMPTY	\N	\N	\N	\N	\N	\N
2694	26	93	EMPTY	\N	\N	\N	\N	\N	\N
2695	26	94	EMPTY	\N	\N	\N	\N	\N	\N
2696	26	95	NPC	\N	\N	8	\N	Barbarian Camp (Lv 8)	\N
2697	26	96	EMPTY	\N	\N	\N	\N	\N	\N
2698	26	97	EMPTY	\N	\N	\N	\N	\N	\N
2699	26	98	EMPTY	\N	\N	\N	\N	\N	\N
2700	26	99	VALLEY	\N	\N	\N	\N	Valley (26, 99)	\N
2701	27	0	EMPTY	\N	\N	\N	\N	\N	\N
2702	27	1	RESOURCE	food	2	\N	\N	\N	\N
2703	27	2	EMPTY	\N	\N	\N	\N	\N	\N
2704	27	3	EMPTY	\N	\N	\N	\N	\N	\N
2705	27	4	EMPTY	\N	\N	\N	\N	\N	\N
2706	27	5	RESOURCE	wood	5	\N	\N	\N	\N
2707	27	6	EMPTY	\N	\N	\N	\N	\N	\N
2708	27	7	EMPTY	\N	\N	\N	\N	\N	\N
2709	27	8	EMPTY	\N	\N	\N	\N	\N	\N
2710	27	9	EMPTY	\N	\N	\N	\N	\N	\N
2711	27	10	EMPTY	\N	\N	\N	\N	\N	\N
2712	27	11	EMPTY	\N	\N	\N	\N	\N	\N
2713	27	12	EMPTY	\N	\N	\N	\N	\N	\N
2714	27	13	EMPTY	\N	\N	\N	\N	\N	\N
2715	27	14	EMPTY	\N	\N	\N	\N	\N	\N
2716	27	15	EMPTY	\N	\N	\N	\N	\N	\N
2717	27	16	EMPTY	\N	\N	\N	\N	\N	\N
2718	27	17	EMPTY	\N	\N	\N	\N	\N	\N
2719	27	18	RESOURCE	wood	2	\N	\N	\N	\N
2720	27	19	EMPTY	\N	\N	\N	\N	\N	\N
2721	27	20	EMPTY	\N	\N	\N	\N	\N	\N
2722	27	21	EMPTY	\N	\N	\N	\N	\N	\N
2723	27	22	EMPTY	\N	\N	\N	\N	\N	\N
2724	27	23	EMPTY	\N	\N	\N	\N	\N	\N
2725	27	24	EMPTY	\N	\N	\N	\N	\N	\N
2726	27	25	EMPTY	\N	\N	\N	\N	\N	\N
2727	27	26	EMPTY	\N	\N	\N	\N	\N	\N
2728	27	27	EMPTY	\N	\N	\N	\N	\N	\N
2729	27	28	EMPTY	\N	\N	\N	\N	\N	\N
2730	27	29	EMPTY	\N	\N	\N	\N	\N	\N
2731	27	30	EMPTY	\N	\N	\N	\N	\N	\N
2732	27	31	EMPTY	\N	\N	\N	\N	\N	\N
2733	27	32	EMPTY	\N	\N	\N	\N	\N	\N
2734	27	33	EMPTY	\N	\N	\N	\N	\N	\N
2735	27	34	EMPTY	\N	\N	\N	\N	\N	\N
2736	27	35	EMPTY	\N	\N	\N	\N	\N	\N
2737	27	36	RESOURCE	food	5	\N	\N	\N	\N
2738	27	37	RESOURCE	food	4	\N	\N	\N	\N
2739	27	38	EMPTY	\N	\N	\N	\N	\N	\N
2740	27	39	EMPTY	\N	\N	\N	\N	\N	\N
2741	27	40	EMPTY	\N	\N	\N	\N	\N	\N
2742	27	41	EMPTY	\N	\N	\N	\N	\N	\N
2743	27	42	EMPTY	\N	\N	\N	\N	\N	\N
2744	27	43	EMPTY	\N	\N	\N	\N	\N	\N
2745	27	44	EMPTY	\N	\N	\N	\N	\N	\N
2746	27	45	EMPTY	\N	\N	\N	\N	\N	\N
2747	27	46	EMPTY	\N	\N	\N	\N	\N	\N
2748	27	47	EMPTY	\N	\N	\N	\N	\N	\N
2749	27	48	EMPTY	\N	\N	\N	\N	\N	\N
2750	27	49	EMPTY	\N	\N	\N	\N	\N	\N
2751	27	50	EMPTY	\N	\N	\N	\N	\N	\N
2752	27	51	EMPTY	\N	\N	\N	\N	\N	\N
2753	27	52	EMPTY	\N	\N	\N	\N	\N	\N
2754	27	53	NPC	\N	\N	7	\N	Barbarian Camp (Lv 7)	\N
2755	27	54	EMPTY	\N	\N	\N	\N	\N	\N
2756	27	55	EMPTY	\N	\N	\N	\N	\N	\N
2757	27	56	EMPTY	\N	\N	\N	\N	\N	\N
2758	27	57	EMPTY	\N	\N	\N	\N	\N	\N
2759	27	58	VALLEY	\N	\N	\N	\N	Valley (27, 58)	\N
2760	27	59	EMPTY	\N	\N	\N	\N	\N	\N
2761	27	60	EMPTY	\N	\N	\N	\N	\N	\N
2762	27	61	EMPTY	\N	\N	\N	\N	\N	\N
2763	27	62	EMPTY	\N	\N	\N	\N	\N	\N
2764	27	63	EMPTY	\N	\N	\N	\N	\N	\N
2765	27	64	RESOURCE	stone	3	\N	\N	\N	\N
2766	27	65	EMPTY	\N	\N	\N	\N	\N	\N
2767	27	66	EMPTY	\N	\N	\N	\N	\N	\N
2768	27	67	EMPTY	\N	\N	\N	\N	\N	\N
2769	27	68	EMPTY	\N	\N	\N	\N	\N	\N
2770	27	69	EMPTY	\N	\N	\N	\N	\N	\N
2771	27	70	EMPTY	\N	\N	\N	\N	\N	\N
2772	27	71	EMPTY	\N	\N	\N	\N	\N	\N
2773	27	72	EMPTY	\N	\N	\N	\N	\N	\N
2774	27	73	EMPTY	\N	\N	\N	\N	\N	\N
2775	27	74	EMPTY	\N	\N	\N	\N	\N	\N
2776	27	75	EMPTY	\N	\N	\N	\N	\N	\N
2777	27	76	EMPTY	\N	\N	\N	\N	\N	\N
2778	27	77	EMPTY	\N	\N	\N	\N	\N	\N
2779	27	78	EMPTY	\N	\N	\N	\N	\N	\N
2780	27	79	EMPTY	\N	\N	\N	\N	\N	\N
2781	27	80	EMPTY	\N	\N	\N	\N	\N	\N
2782	27	81	EMPTY	\N	\N	\N	\N	\N	\N
2783	27	82	EMPTY	\N	\N	\N	\N	\N	\N
2784	27	83	EMPTY	\N	\N	\N	\N	\N	\N
2785	27	84	EMPTY	\N	\N	\N	\N	\N	\N
2786	27	85	EMPTY	\N	\N	\N	\N	\N	\N
2787	27	86	EMPTY	\N	\N	\N	\N	\N	\N
2788	27	87	EMPTY	\N	\N	\N	\N	\N	\N
2789	27	88	EMPTY	\N	\N	\N	\N	\N	\N
2790	27	89	EMPTY	\N	\N	\N	\N	\N	\N
2791	27	90	EMPTY	\N	\N	\N	\N	\N	\N
2792	27	91	EMPTY	\N	\N	\N	\N	\N	\N
2793	27	92	EMPTY	\N	\N	\N	\N	\N	\N
2794	27	93	VALLEY	\N	\N	\N	\N	Valley (27, 93)	\N
2795	27	94	EMPTY	\N	\N	\N	\N	\N	\N
2796	27	95	EMPTY	\N	\N	\N	\N	\N	\N
2797	27	96	NPC	\N	\N	8	\N	Barbarian Camp (Lv 8)	\N
2798	27	97	EMPTY	\N	\N	\N	\N	\N	\N
2799	27	98	EMPTY	\N	\N	\N	\N	\N	\N
2800	27	99	VALLEY	\N	\N	\N	\N	Valley (27, 99)	\N
2801	28	0	EMPTY	\N	\N	\N	\N	\N	\N
2802	28	1	EMPTY	\N	\N	\N	\N	\N	\N
2803	28	2	EMPTY	\N	\N	\N	\N	\N	\N
2804	28	3	EMPTY	\N	\N	\N	\N	\N	\N
2805	28	4	EMPTY	\N	\N	\N	\N	\N	\N
2806	28	5	EMPTY	\N	\N	\N	\N	\N	\N
2807	28	6	EMPTY	\N	\N	\N	\N	\N	\N
2808	28	7	EMPTY	\N	\N	\N	\N	\N	\N
2809	28	8	EMPTY	\N	\N	\N	\N	\N	\N
2810	28	9	EMPTY	\N	\N	\N	\N	\N	\N
2811	28	10	RESOURCE	food	3	\N	\N	\N	\N
2812	28	11	EMPTY	\N	\N	\N	\N	\N	\N
2813	28	12	EMPTY	\N	\N	\N	\N	\N	\N
2814	28	13	EMPTY	\N	\N	\N	\N	\N	\N
2815	28	14	EMPTY	\N	\N	\N	\N	\N	\N
2816	28	15	EMPTY	\N	\N	\N	\N	\N	\N
2817	28	16	EMPTY	\N	\N	\N	\N	\N	\N
2818	28	17	EMPTY	\N	\N	\N	\N	\N	\N
2819	28	18	EMPTY	\N	\N	\N	\N	\N	\N
2820	28	19	EMPTY	\N	\N	\N	\N	\N	\N
2821	28	20	EMPTY	\N	\N	\N	\N	\N	\N
2822	28	21	EMPTY	\N	\N	\N	\N	\N	\N
2823	28	22	EMPTY	\N	\N	\N	\N	\N	\N
2824	28	23	EMPTY	\N	\N	\N	\N	\N	\N
2825	28	24	RESOURCE	wood	3	\N	\N	\N	\N
2826	28	25	EMPTY	\N	\N	\N	\N	\N	\N
2827	28	26	EMPTY	\N	\N	\N	\N	\N	\N
2828	28	27	EMPTY	\N	\N	\N	\N	\N	\N
2829	28	28	EMPTY	\N	\N	\N	\N	\N	\N
2830	28	29	EMPTY	\N	\N	\N	\N	\N	\N
2831	28	30	EMPTY	\N	\N	\N	\N	\N	\N
2832	28	31	EMPTY	\N	\N	\N	\N	\N	\N
2833	28	32	EMPTY	\N	\N	\N	\N	\N	\N
2834	28	33	EMPTY	\N	\N	\N	\N	\N	\N
2835	28	34	EMPTY	\N	\N	\N	\N	\N	\N
2836	28	35	RESOURCE	wood	5	\N	\N	\N	\N
2837	28	36	EMPTY	\N	\N	\N	\N	\N	\N
2838	28	37	EMPTY	\N	\N	\N	\N	\N	\N
2839	28	38	EMPTY	\N	\N	\N	\N	\N	\N
2840	28	39	EMPTY	\N	\N	\N	\N	\N	\N
2841	28	40	EMPTY	\N	\N	\N	\N	\N	\N
2842	28	41	NPC	\N	\N	2	\N	Barbarian Camp (Lv 2)	\N
2843	28	42	EMPTY	\N	\N	\N	\N	\N	\N
2844	28	43	EMPTY	\N	\N	\N	\N	\N	\N
2845	28	44	EMPTY	\N	\N	\N	\N	\N	\N
2846	28	45	EMPTY	\N	\N	\N	\N	\N	\N
2847	28	46	EMPTY	\N	\N	\N	\N	\N	\N
2848	28	47	EMPTY	\N	\N	\N	\N	\N	\N
2849	28	48	EMPTY	\N	\N	\N	\N	\N	\N
2850	28	49	EMPTY	\N	\N	\N	\N	\N	\N
2851	28	50	EMPTY	\N	\N	\N	\N	\N	\N
2852	28	51	EMPTY	\N	\N	\N	\N	\N	\N
2853	28	52	EMPTY	\N	\N	\N	\N	\N	\N
2854	28	53	EMPTY	\N	\N	\N	\N	\N	\N
2855	28	54	EMPTY	\N	\N	\N	\N	\N	\N
2856	28	55	EMPTY	\N	\N	\N	\N	\N	\N
2857	28	56	EMPTY	\N	\N	\N	\N	\N	\N
2858	28	57	NPC	\N	\N	7	\N	Barbarian Camp (Lv 7)	\N
2859	28	58	EMPTY	\N	\N	\N	\N	\N	\N
2860	28	59	EMPTY	\N	\N	\N	\N	\N	\N
2861	28	60	EMPTY	\N	\N	\N	\N	\N	\N
2862	28	61	EMPTY	\N	\N	\N	\N	\N	\N
2863	28	62	EMPTY	\N	\N	\N	\N	\N	\N
2864	28	63	EMPTY	\N	\N	\N	\N	\N	\N
2865	28	64	EMPTY	\N	\N	\N	\N	\N	\N
2866	28	65	EMPTY	\N	\N	\N	\N	\N	\N
2867	28	66	EMPTY	\N	\N	\N	\N	\N	\N
2868	28	67	EMPTY	\N	\N	\N	\N	\N	\N
2869	28	68	EMPTY	\N	\N	\N	\N	\N	\N
2870	28	69	EMPTY	\N	\N	\N	\N	\N	\N
2871	28	70	EMPTY	\N	\N	\N	\N	\N	\N
2872	28	71	EMPTY	\N	\N	\N	\N	\N	\N
2873	28	72	EMPTY	\N	\N	\N	\N	\N	\N
2874	28	73	EMPTY	\N	\N	\N	\N	\N	\N
2875	28	74	EMPTY	\N	\N	\N	\N	\N	\N
2876	28	75	RESOURCE	stone	2	\N	\N	\N	\N
2877	28	76	EMPTY	\N	\N	\N	\N	\N	\N
2878	28	77	EMPTY	\N	\N	\N	\N	\N	\N
2879	28	78	EMPTY	\N	\N	\N	\N	\N	\N
2880	28	79	EMPTY	\N	\N	\N	\N	\N	\N
2881	28	80	EMPTY	\N	\N	\N	\N	\N	\N
2882	28	81	EMPTY	\N	\N	\N	\N	\N	\N
2883	28	82	EMPTY	\N	\N	\N	\N	\N	\N
2884	28	83	EMPTY	\N	\N	\N	\N	\N	\N
2885	28	84	NPC	\N	\N	7	\N	Barbarian Camp (Lv 7)	\N
2886	28	85	EMPTY	\N	\N	\N	\N	\N	\N
2887	28	86	EMPTY	\N	\N	\N	\N	\N	\N
2888	28	87	EMPTY	\N	\N	\N	\N	\N	\N
2889	28	88	EMPTY	\N	\N	\N	\N	\N	\N
2890	28	89	EMPTY	\N	\N	\N	\N	\N	\N
2891	28	90	EMPTY	\N	\N	\N	\N	\N	\N
2892	28	91	VALLEY	\N	\N	\N	\N	Valley (28, 91)	\N
2893	28	92	EMPTY	\N	\N	\N	\N	\N	\N
2894	28	93	EMPTY	\N	\N	\N	\N	\N	\N
2895	28	94	RESOURCE	wood	4	\N	\N	\N	\N
2896	28	95	EMPTY	\N	\N	\N	\N	\N	\N
2897	28	96	EMPTY	\N	\N	\N	\N	\N	\N
2898	28	97	EMPTY	\N	\N	\N	\N	\N	\N
2899	28	98	EMPTY	\N	\N	\N	\N	\N	\N
2900	28	99	RESOURCE	food	3	\N	\N	\N	\N
2901	29	0	EMPTY	\N	\N	\N	\N	\N	\N
2902	29	1	EMPTY	\N	\N	\N	\N	\N	\N
2903	29	2	EMPTY	\N	\N	\N	\N	\N	\N
2904	29	3	EMPTY	\N	\N	\N	\N	\N	\N
2905	29	4	EMPTY	\N	\N	\N	\N	\N	\N
2906	29	5	RESOURCE	stone	4	\N	\N	\N	\N
2907	29	6	EMPTY	\N	\N	\N	\N	\N	\N
2908	29	7	RESOURCE	iron	4	\N	\N	\N	\N
2909	29	8	EMPTY	\N	\N	\N	\N	\N	\N
2910	29	9	EMPTY	\N	\N	\N	\N	\N	\N
2911	29	10	RESOURCE	wood	3	\N	\N	\N	\N
2912	29	11	EMPTY	\N	\N	\N	\N	\N	\N
2913	29	12	EMPTY	\N	\N	\N	\N	\N	\N
2914	29	13	EMPTY	\N	\N	\N	\N	\N	\N
2915	29	14	EMPTY	\N	\N	\N	\N	\N	\N
2916	29	15	EMPTY	\N	\N	\N	\N	\N	\N
2917	29	16	EMPTY	\N	\N	\N	\N	\N	\N
2918	29	17	NPC	\N	\N	5	\N	Barbarian Camp (Lv 5)	\N
2919	29	18	EMPTY	\N	\N	\N	\N	\N	\N
2920	29	19	EMPTY	\N	\N	\N	\N	\N	\N
2921	29	20	VALLEY	\N	\N	\N	\N	Valley (29, 20)	\N
2922	29	21	EMPTY	\N	\N	\N	\N	\N	\N
2923	29	22	EMPTY	\N	\N	\N	\N	\N	\N
2924	29	23	EMPTY	\N	\N	\N	\N	\N	\N
2925	29	24	RESOURCE	stone	3	\N	\N	\N	\N
2926	29	25	RESOURCE	iron	3	\N	\N	\N	\N
2927	29	26	EMPTY	\N	\N	\N	\N	\N	\N
2928	29	27	EMPTY	\N	\N	\N	\N	\N	\N
2929	29	28	EMPTY	\N	\N	\N	\N	\N	\N
2930	29	29	EMPTY	\N	\N	\N	\N	\N	\N
2931	29	30	EMPTY	\N	\N	\N	\N	\N	\N
2932	29	31	RESOURCE	iron	2	\N	\N	\N	\N
2933	29	32	EMPTY	\N	\N	\N	\N	\N	\N
2934	29	33	EMPTY	\N	\N	\N	\N	\N	\N
2935	29	34	EMPTY	\N	\N	\N	\N	\N	\N
2936	29	35	EMPTY	\N	\N	\N	\N	\N	\N
2937	29	36	EMPTY	\N	\N	\N	\N	\N	\N
2938	29	37	EMPTY	\N	\N	\N	\N	\N	\N
2939	29	38	NPC	\N	\N	3	\N	Barbarian Camp (Lv 3)	\N
2940	29	39	EMPTY	\N	\N	\N	\N	\N	\N
2941	29	40	EMPTY	\N	\N	\N	\N	\N	\N
2942	29	41	EMPTY	\N	\N	\N	\N	\N	\N
2943	29	42	NPC	\N	\N	2	\N	Barbarian Camp (Lv 2)	\N
2944	29	43	EMPTY	\N	\N	\N	\N	\N	\N
2945	29	44	EMPTY	\N	\N	\N	\N	\N	\N
2946	29	45	EMPTY	\N	\N	\N	\N	\N	\N
2947	29	46	EMPTY	\N	\N	\N	\N	\N	\N
2948	29	47	EMPTY	\N	\N	\N	\N	\N	\N
2949	29	48	NPC	\N	\N	9	\N	Barbarian Camp (Lv 9)	\N
2950	29	49	EMPTY	\N	\N	\N	\N	\N	\N
2951	29	50	EMPTY	\N	\N	\N	\N	\N	\N
2953	29	52	EMPTY	\N	\N	\N	\N	\N	\N
2954	29	53	EMPTY	\N	\N	\N	\N	\N	\N
2955	29	54	EMPTY	\N	\N	\N	\N	\N	\N
2956	29	55	EMPTY	\N	\N	\N	\N	\N	\N
2957	29	56	EMPTY	\N	\N	\N	\N	\N	\N
2958	29	57	EMPTY	\N	\N	\N	\N	\N	\N
2959	29	58	NPC	\N	\N	3	\N	Barbarian Camp (Lv 3)	\N
2960	29	59	EMPTY	\N	\N	\N	\N	\N	\N
2961	29	60	EMPTY	\N	\N	\N	\N	\N	\N
2962	29	61	NPC	\N	\N	9	\N	Barbarian Camp (Lv 9)	\N
2963	29	62	EMPTY	\N	\N	\N	\N	\N	\N
2964	29	63	EMPTY	\N	\N	\N	\N	\N	\N
2965	29	64	EMPTY	\N	\N	\N	\N	\N	\N
2966	29	65	EMPTY	\N	\N	\N	\N	\N	\N
2967	29	66	RESOURCE	food	1	\N	\N	\N	\N
2968	29	67	EMPTY	\N	\N	\N	\N	\N	\N
2969	29	68	NPC	\N	\N	9	\N	Barbarian Camp (Lv 9)	\N
2970	29	69	EMPTY	\N	\N	\N	\N	\N	\N
2971	29	70	EMPTY	\N	\N	\N	\N	\N	\N
2972	29	71	RESOURCE	wood	5	\N	\N	\N	\N
2973	29	72	NPC	\N	\N	9	\N	Barbarian Camp (Lv 9)	\N
2974	29	73	EMPTY	\N	\N	\N	\N	\N	\N
2975	29	74	EMPTY	\N	\N	\N	\N	\N	\N
2976	29	75	EMPTY	\N	\N	\N	\N	\N	\N
2977	29	76	EMPTY	\N	\N	\N	\N	\N	\N
2978	29	77	EMPTY	\N	\N	\N	\N	\N	\N
2979	29	78	EMPTY	\N	\N	\N	\N	\N	\N
2980	29	79	EMPTY	\N	\N	\N	\N	\N	\N
2981	29	80	EMPTY	\N	\N	\N	\N	\N	\N
2982	29	81	EMPTY	\N	\N	\N	\N	\N	\N
2983	29	82	EMPTY	\N	\N	\N	\N	\N	\N
2984	29	83	EMPTY	\N	\N	\N	\N	\N	\N
2985	29	84	EMPTY	\N	\N	\N	\N	\N	\N
2986	29	85	EMPTY	\N	\N	\N	\N	\N	\N
2987	29	86	EMPTY	\N	\N	\N	\N	\N	\N
2988	29	87	EMPTY	\N	\N	\N	\N	\N	\N
2989	29	88	EMPTY	\N	\N	\N	\N	\N	\N
2990	29	89	EMPTY	\N	\N	\N	\N	\N	\N
2991	29	90	EMPTY	\N	\N	\N	\N	\N	\N
2992	29	91	EMPTY	\N	\N	\N	\N	\N	\N
2993	29	92	EMPTY	\N	\N	\N	\N	\N	\N
2994	29	93	EMPTY	\N	\N	\N	\N	\N	\N
2995	29	94	EMPTY	\N	\N	\N	\N	\N	\N
2996	29	95	EMPTY	\N	\N	\N	\N	\N	\N
2997	29	96	EMPTY	\N	\N	\N	\N	\N	\N
2998	29	97	RESOURCE	food	4	\N	\N	\N	\N
2999	29	98	RESOURCE	iron	5	\N	\N	\N	\N
3000	29	99	EMPTY	\N	\N	\N	\N	\N	\N
3001	30	0	RESOURCE	stone	3	\N	\N	\N	\N
3002	30	1	EMPTY	\N	\N	\N	\N	\N	\N
3003	30	2	RESOURCE	iron	4	\N	\N	\N	\N
3004	30	3	EMPTY	\N	\N	\N	\N	\N	\N
3005	30	4	EMPTY	\N	\N	\N	\N	\N	\N
3006	30	5	EMPTY	\N	\N	\N	\N	\N	\N
3007	30	6	EMPTY	\N	\N	\N	\N	\N	\N
3008	30	7	RESOURCE	food	3	\N	\N	\N	\N
3009	30	8	EMPTY	\N	\N	\N	\N	\N	\N
3010	30	9	RESOURCE	food	3	\N	\N	\N	\N
3011	30	10	EMPTY	\N	\N	\N	\N	\N	\N
3012	30	11	EMPTY	\N	\N	\N	\N	\N	\N
3013	30	12	EMPTY	\N	\N	\N	\N	\N	\N
3014	30	13	EMPTY	\N	\N	\N	\N	\N	\N
3015	30	14	RESOURCE	stone	4	\N	\N	\N	\N
3016	30	15	EMPTY	\N	\N	\N	\N	\N	\N
3017	30	16	EMPTY	\N	\N	\N	\N	\N	\N
3018	30	17	RESOURCE	wood	5	\N	\N	\N	\N
3019	30	18	VALLEY	\N	\N	\N	\N	Valley (30, 18)	\N
3020	30	19	EMPTY	\N	\N	\N	\N	\N	\N
3021	30	20	EMPTY	\N	\N	\N	\N	\N	\N
3022	30	21	EMPTY	\N	\N	\N	\N	\N	\N
3023	30	22	EMPTY	\N	\N	\N	\N	\N	\N
3024	30	23	EMPTY	\N	\N	\N	\N	\N	\N
3025	30	24	EMPTY	\N	\N	\N	\N	\N	\N
3026	30	25	EMPTY	\N	\N	\N	\N	\N	\N
3027	30	26	EMPTY	\N	\N	\N	\N	\N	\N
3028	30	27	EMPTY	\N	\N	\N	\N	\N	\N
3029	30	28	EMPTY	\N	\N	\N	\N	\N	\N
3030	30	29	NPC	\N	\N	1	\N	Barbarian Camp (Lv 1)	\N
3031	30	30	EMPTY	\N	\N	\N	\N	\N	\N
3032	30	31	EMPTY	\N	\N	\N	\N	\N	\N
3033	30	32	EMPTY	\N	\N	\N	\N	\N	\N
3034	30	33	EMPTY	\N	\N	\N	\N	\N	\N
3035	30	34	EMPTY	\N	\N	\N	\N	\N	\N
3036	30	35	RESOURCE	wood	5	\N	\N	\N	\N
3037	30	36	EMPTY	\N	\N	\N	\N	\N	\N
3038	30	37	EMPTY	\N	\N	\N	\N	\N	\N
3039	30	38	EMPTY	\N	\N	\N	\N	\N	\N
3040	30	39	EMPTY	\N	\N	\N	\N	\N	\N
3041	30	40	EMPTY	\N	\N	\N	\N	\N	\N
3042	30	41	VALLEY	\N	\N	\N	\N	Valley (30, 41)	\N
3043	30	42	EMPTY	\N	\N	\N	\N	\N	\N
3044	30	43	EMPTY	\N	\N	\N	\N	\N	\N
3045	30	44	EMPTY	\N	\N	\N	\N	\N	\N
3046	30	45	EMPTY	\N	\N	\N	\N	\N	\N
3047	30	46	EMPTY	\N	\N	\N	\N	\N	\N
3048	30	47	EMPTY	\N	\N	\N	\N	\N	\N
3049	30	48	EMPTY	\N	\N	\N	\N	\N	\N
3050	30	49	EMPTY	\N	\N	\N	\N	\N	\N
3051	30	50	EMPTY	\N	\N	\N	\N	\N	\N
3052	30	51	RESOURCE	wood	3	\N	\N	\N	\N
3053	30	52	NPC	\N	\N	2	\N	Barbarian Camp (Lv 2)	\N
3054	30	53	EMPTY	\N	\N	\N	\N	\N	\N
3055	30	54	EMPTY	\N	\N	\N	\N	\N	\N
3056	30	55	EMPTY	\N	\N	\N	\N	\N	\N
3057	30	56	EMPTY	\N	\N	\N	\N	\N	\N
3058	30	57	EMPTY	\N	\N	\N	\N	\N	\N
3059	30	58	NPC	\N	\N	7	\N	Barbarian Camp (Lv 7)	\N
3060	30	59	EMPTY	\N	\N	\N	\N	\N	\N
3061	30	60	EMPTY	\N	\N	\N	\N	\N	\N
3062	30	61	EMPTY	\N	\N	\N	\N	\N	\N
3063	30	62	NPC	\N	\N	8	\N	Barbarian Camp (Lv 8)	\N
3064	30	63	EMPTY	\N	\N	\N	\N	\N	\N
3065	30	64	EMPTY	\N	\N	\N	\N	\N	\N
3066	30	65	EMPTY	\N	\N	\N	\N	\N	\N
3067	30	66	NPC	\N	\N	1	\N	Barbarian Camp (Lv 1)	\N
3068	30	67	EMPTY	\N	\N	\N	\N	\N	\N
3069	30	68	EMPTY	\N	\N	\N	\N	\N	\N
3070	30	69	EMPTY	\N	\N	\N	\N	\N	\N
3071	30	70	RESOURCE	stone	4	\N	\N	\N	\N
3072	30	71	EMPTY	\N	\N	\N	\N	\N	\N
3073	30	72	EMPTY	\N	\N	\N	\N	\N	\N
3074	30	73	EMPTY	\N	\N	\N	\N	\N	\N
3075	30	74	VALLEY	\N	\N	\N	\N	Valley (30, 74)	\N
3076	30	75	EMPTY	\N	\N	\N	\N	\N	\N
3077	30	76	VALLEY	\N	\N	\N	\N	Valley (30, 76)	\N
3078	30	77	EMPTY	\N	\N	\N	\N	\N	\N
3079	30	78	EMPTY	\N	\N	\N	\N	\N	\N
3080	30	79	EMPTY	\N	\N	\N	\N	\N	\N
3081	30	80	EMPTY	\N	\N	\N	\N	\N	\N
3082	30	81	EMPTY	\N	\N	\N	\N	\N	\N
3083	30	82	EMPTY	\N	\N	\N	\N	\N	\N
3084	30	83	EMPTY	\N	\N	\N	\N	\N	\N
3085	30	84	EMPTY	\N	\N	\N	\N	\N	\N
3086	30	85	EMPTY	\N	\N	\N	\N	\N	\N
3087	30	86	EMPTY	\N	\N	\N	\N	\N	\N
3088	30	87	EMPTY	\N	\N	\N	\N	\N	\N
3089	30	88	EMPTY	\N	\N	\N	\N	\N	\N
3090	30	89	EMPTY	\N	\N	\N	\N	\N	\N
3091	30	90	EMPTY	\N	\N	\N	\N	\N	\N
3092	30	91	EMPTY	\N	\N	\N	\N	\N	\N
3093	30	92	EMPTY	\N	\N	\N	\N	\N	\N
3094	30	93	EMPTY	\N	\N	\N	\N	\N	\N
3095	30	94	EMPTY	\N	\N	\N	\N	\N	\N
3096	30	95	EMPTY	\N	\N	\N	\N	\N	\N
3097	30	96	EMPTY	\N	\N	\N	\N	\N	\N
3098	30	97	EMPTY	\N	\N	\N	\N	\N	\N
3099	30	98	EMPTY	\N	\N	\N	\N	\N	\N
3100	30	99	EMPTY	\N	\N	\N	\N	\N	\N
3101	31	0	EMPTY	\N	\N	\N	\N	\N	\N
3102	31	1	EMPTY	\N	\N	\N	\N	\N	\N
3103	31	2	EMPTY	\N	\N	\N	\N	\N	\N
3104	31	3	EMPTY	\N	\N	\N	\N	\N	\N
3105	31	4	EMPTY	\N	\N	\N	\N	\N	\N
3106	31	5	EMPTY	\N	\N	\N	\N	\N	\N
3107	31	6	EMPTY	\N	\N	\N	\N	\N	\N
3108	31	7	RESOURCE	food	4	\N	\N	\N	\N
3109	31	8	EMPTY	\N	\N	\N	\N	\N	\N
3110	31	9	EMPTY	\N	\N	\N	\N	\N	\N
3111	31	10	EMPTY	\N	\N	\N	\N	\N	\N
3112	31	11	EMPTY	\N	\N	\N	\N	\N	\N
3113	31	12	EMPTY	\N	\N	\N	\N	\N	\N
3114	31	13	EMPTY	\N	\N	\N	\N	\N	\N
3115	31	14	EMPTY	\N	\N	\N	\N	\N	\N
3116	31	15	EMPTY	\N	\N	\N	\N	\N	\N
3117	31	16	EMPTY	\N	\N	\N	\N	\N	\N
3118	31	17	EMPTY	\N	\N	\N	\N	\N	\N
3119	31	18	EMPTY	\N	\N	\N	\N	\N	\N
3120	31	19	EMPTY	\N	\N	\N	\N	\N	\N
3121	31	20	EMPTY	\N	\N	\N	\N	\N	\N
3122	31	21	EMPTY	\N	\N	\N	\N	\N	\N
3123	31	22	EMPTY	\N	\N	\N	\N	\N	\N
3124	31	23	EMPTY	\N	\N	\N	\N	\N	\N
3125	31	24	EMPTY	\N	\N	\N	\N	\N	\N
3126	31	25	NPC	\N	\N	7	\N	Barbarian Camp (Lv 7)	\N
3127	31	26	EMPTY	\N	\N	\N	\N	\N	\N
3128	31	27	EMPTY	\N	\N	\N	\N	\N	\N
3129	31	28	EMPTY	\N	\N	\N	\N	\N	\N
3130	31	29	EMPTY	\N	\N	\N	\N	\N	\N
3131	31	30	EMPTY	\N	\N	\N	\N	\N	\N
3132	31	31	EMPTY	\N	\N	\N	\N	\N	\N
3133	31	32	EMPTY	\N	\N	\N	\N	\N	\N
3134	31	33	EMPTY	\N	\N	\N	\N	\N	\N
3135	31	34	EMPTY	\N	\N	\N	\N	\N	\N
3136	31	35	EMPTY	\N	\N	\N	\N	\N	\N
3137	31	36	EMPTY	\N	\N	\N	\N	\N	\N
3138	31	37	EMPTY	\N	\N	\N	\N	\N	\N
3139	31	38	EMPTY	\N	\N	\N	\N	\N	\N
3140	31	39	EMPTY	\N	\N	\N	\N	\N	\N
3141	31	40	EMPTY	\N	\N	\N	\N	\N	\N
3142	31	41	NPC	\N	\N	8	\N	Barbarian Camp (Lv 8)	\N
3143	31	42	EMPTY	\N	\N	\N	\N	\N	\N
3144	31	43	EMPTY	\N	\N	\N	\N	\N	\N
3145	31	44	EMPTY	\N	\N	\N	\N	\N	\N
3146	31	45	EMPTY	\N	\N	\N	\N	\N	\N
3147	31	46	EMPTY	\N	\N	\N	\N	\N	\N
3148	31	47	EMPTY	\N	\N	\N	\N	\N	\N
3149	31	48	EMPTY	\N	\N	\N	\N	\N	\N
3150	31	49	EMPTY	\N	\N	\N	\N	\N	\N
3151	31	50	EMPTY	\N	\N	\N	\N	\N	\N
3152	31	51	EMPTY	\N	\N	\N	\N	\N	\N
3153	31	52	EMPTY	\N	\N	\N	\N	\N	\N
3154	31	53	NPC	\N	\N	2	\N	Barbarian Camp (Lv 2)	\N
3155	31	54	EMPTY	\N	\N	\N	\N	\N	\N
3156	31	55	RESOURCE	iron	4	\N	\N	\N	\N
3157	31	56	EMPTY	\N	\N	\N	\N	\N	\N
3158	31	57	EMPTY	\N	\N	\N	\N	\N	\N
3159	31	58	EMPTY	\N	\N	\N	\N	\N	\N
3160	31	59	EMPTY	\N	\N	\N	\N	\N	\N
3161	31	60	EMPTY	\N	\N	\N	\N	\N	\N
3162	31	61	VALLEY	\N	\N	\N	\N	Valley (31, 61)	\N
3163	31	62	EMPTY	\N	\N	\N	\N	\N	\N
3164	31	63	EMPTY	\N	\N	\N	\N	\N	\N
3165	31	64	EMPTY	\N	\N	\N	\N	\N	\N
3166	31	65	EMPTY	\N	\N	\N	\N	\N	\N
3167	31	66	EMPTY	\N	\N	\N	\N	\N	\N
3168	31	67	EMPTY	\N	\N	\N	\N	\N	\N
3169	31	68	EMPTY	\N	\N	\N	\N	\N	\N
3170	31	69	EMPTY	\N	\N	\N	\N	\N	\N
3171	31	70	EMPTY	\N	\N	\N	\N	\N	\N
3172	31	71	EMPTY	\N	\N	\N	\N	\N	\N
3173	31	72	EMPTY	\N	\N	\N	\N	\N	\N
3174	31	73	EMPTY	\N	\N	\N	\N	\N	\N
3175	31	74	EMPTY	\N	\N	\N	\N	\N	\N
3176	31	75	EMPTY	\N	\N	\N	\N	\N	\N
3177	31	76	EMPTY	\N	\N	\N	\N	\N	\N
3178	31	77	EMPTY	\N	\N	\N	\N	\N	\N
3179	31	78	EMPTY	\N	\N	\N	\N	\N	\N
3180	31	79	EMPTY	\N	\N	\N	\N	\N	\N
3181	31	80	EMPTY	\N	\N	\N	\N	\N	\N
3182	31	81	EMPTY	\N	\N	\N	\N	\N	\N
3183	31	82	EMPTY	\N	\N	\N	\N	\N	\N
3184	31	83	EMPTY	\N	\N	\N	\N	\N	\N
3185	31	84	EMPTY	\N	\N	\N	\N	\N	\N
3186	31	85	RESOURCE	wood	1	\N	\N	\N	\N
3187	31	86	EMPTY	\N	\N	\N	\N	\N	\N
3188	31	87	EMPTY	\N	\N	\N	\N	\N	\N
3189	31	88	VALLEY	\N	\N	\N	\N	Valley (31, 88)	\N
3190	31	89	EMPTY	\N	\N	\N	\N	\N	\N
3191	31	90	NPC	\N	\N	9	\N	Barbarian Camp (Lv 9)	\N
3192	31	91	EMPTY	\N	\N	\N	\N	\N	\N
3193	31	92	EMPTY	\N	\N	\N	\N	\N	\N
3194	31	93	EMPTY	\N	\N	\N	\N	\N	\N
3195	31	94	EMPTY	\N	\N	\N	\N	\N	\N
3196	31	95	EMPTY	\N	\N	\N	\N	\N	\N
3197	31	96	EMPTY	\N	\N	\N	\N	\N	\N
3198	31	97	EMPTY	\N	\N	\N	\N	\N	\N
3199	31	98	EMPTY	\N	\N	\N	\N	\N	\N
3200	31	99	EMPTY	\N	\N	\N	\N	\N	\N
3201	32	0	EMPTY	\N	\N	\N	\N	\N	\N
3202	32	1	EMPTY	\N	\N	\N	\N	\N	\N
3203	32	2	EMPTY	\N	\N	\N	\N	\N	\N
3204	32	3	EMPTY	\N	\N	\N	\N	\N	\N
3205	32	4	NPC	\N	\N	10	\N	Barbarian Camp (Lv 10)	\N
3206	32	5	EMPTY	\N	\N	\N	\N	\N	\N
3207	32	6	EMPTY	\N	\N	\N	\N	\N	\N
3208	32	7	EMPTY	\N	\N	\N	\N	\N	\N
3209	32	8	EMPTY	\N	\N	\N	\N	\N	\N
3210	32	9	EMPTY	\N	\N	\N	\N	\N	\N
3211	32	10	EMPTY	\N	\N	\N	\N	\N	\N
3212	32	11	EMPTY	\N	\N	\N	\N	\N	\N
3213	32	12	EMPTY	\N	\N	\N	\N	\N	\N
3214	32	13	EMPTY	\N	\N	\N	\N	\N	\N
3215	32	14	EMPTY	\N	\N	\N	\N	\N	\N
3216	32	15	EMPTY	\N	\N	\N	\N	\N	\N
3217	32	16	EMPTY	\N	\N	\N	\N	\N	\N
3218	32	17	EMPTY	\N	\N	\N	\N	\N	\N
3219	32	18	EMPTY	\N	\N	\N	\N	\N	\N
3220	32	19	EMPTY	\N	\N	\N	\N	\N	\N
3221	32	20	EMPTY	\N	\N	\N	\N	\N	\N
3222	32	21	EMPTY	\N	\N	\N	\N	\N	\N
3223	32	22	EMPTY	\N	\N	\N	\N	\N	\N
3224	32	23	EMPTY	\N	\N	\N	\N	\N	\N
3225	32	24	EMPTY	\N	\N	\N	\N	\N	\N
3226	32	25	EMPTY	\N	\N	\N	\N	\N	\N
3227	32	26	EMPTY	\N	\N	\N	\N	\N	\N
3228	32	27	EMPTY	\N	\N	\N	\N	\N	\N
3229	32	28	EMPTY	\N	\N	\N	\N	\N	\N
3230	32	29	NPC	\N	\N	7	\N	Barbarian Camp (Lv 7)	\N
3231	32	30	EMPTY	\N	\N	\N	\N	\N	\N
3232	32	31	EMPTY	\N	\N	\N	\N	\N	\N
3233	32	32	EMPTY	\N	\N	\N	\N	\N	\N
3234	32	33	EMPTY	\N	\N	\N	\N	\N	\N
3235	32	34	EMPTY	\N	\N	\N	\N	\N	\N
3236	32	35	EMPTY	\N	\N	\N	\N	\N	\N
3237	32	36	EMPTY	\N	\N	\N	\N	\N	\N
3238	32	37	EMPTY	\N	\N	\N	\N	\N	\N
3239	32	38	EMPTY	\N	\N	\N	\N	\N	\N
3240	32	39	EMPTY	\N	\N	\N	\N	\N	\N
3241	32	40	EMPTY	\N	\N	\N	\N	\N	\N
3242	32	41	EMPTY	\N	\N	\N	\N	\N	\N
3243	32	42	EMPTY	\N	\N	\N	\N	\N	\N
3244	32	43	EMPTY	\N	\N	\N	\N	\N	\N
3245	32	44	EMPTY	\N	\N	\N	\N	\N	\N
3246	32	45	EMPTY	\N	\N	\N	\N	\N	\N
3247	32	46	EMPTY	\N	\N	\N	\N	\N	\N
3248	32	47	EMPTY	\N	\N	\N	\N	\N	\N
3249	32	48	RESOURCE	food	4	\N	\N	\N	\N
3250	32	49	EMPTY	\N	\N	\N	\N	\N	\N
3251	32	50	EMPTY	\N	\N	\N	\N	\N	\N
3252	32	51	RESOURCE	wood	5	\N	\N	\N	\N
3253	32	52	NPC	\N	\N	8	\N	Barbarian Camp (Lv 8)	\N
3254	32	53	EMPTY	\N	\N	\N	\N	\N	\N
3255	32	54	EMPTY	\N	\N	\N	\N	\N	\N
3256	32	55	EMPTY	\N	\N	\N	\N	\N	\N
3257	32	56	EMPTY	\N	\N	\N	\N	\N	\N
3258	32	57	EMPTY	\N	\N	\N	\N	\N	\N
3259	32	58	EMPTY	\N	\N	\N	\N	\N	\N
3260	32	59	EMPTY	\N	\N	\N	\N	\N	\N
3261	32	60	RESOURCE	iron	5	\N	\N	\N	\N
3262	32	61	EMPTY	\N	\N	\N	\N	\N	\N
3263	32	62	EMPTY	\N	\N	\N	\N	\N	\N
3264	32	63	EMPTY	\N	\N	\N	\N	\N	\N
3265	32	64	EMPTY	\N	\N	\N	\N	\N	\N
3266	32	65	EMPTY	\N	\N	\N	\N	\N	\N
3267	32	66	EMPTY	\N	\N	\N	\N	\N	\N
3268	32	67	EMPTY	\N	\N	\N	\N	\N	\N
3269	32	68	EMPTY	\N	\N	\N	\N	\N	\N
3270	32	69	EMPTY	\N	\N	\N	\N	\N	\N
3271	32	70	EMPTY	\N	\N	\N	\N	\N	\N
3272	32	71	EMPTY	\N	\N	\N	\N	\N	\N
3273	32	72	EMPTY	\N	\N	\N	\N	\N	\N
3274	32	73	EMPTY	\N	\N	\N	\N	\N	\N
3275	32	74	EMPTY	\N	\N	\N	\N	\N	\N
3276	32	75	EMPTY	\N	\N	\N	\N	\N	\N
3277	32	76	EMPTY	\N	\N	\N	\N	\N	\N
3278	32	77	EMPTY	\N	\N	\N	\N	\N	\N
3279	32	78	EMPTY	\N	\N	\N	\N	\N	\N
3280	32	79	EMPTY	\N	\N	\N	\N	\N	\N
3281	32	80	EMPTY	\N	\N	\N	\N	\N	\N
3282	32	81	EMPTY	\N	\N	\N	\N	\N	\N
3283	32	82	EMPTY	\N	\N	\N	\N	\N	\N
3284	32	83	RESOURCE	iron	5	\N	\N	\N	\N
3285	32	84	EMPTY	\N	\N	\N	\N	\N	\N
3286	32	85	EMPTY	\N	\N	\N	\N	\N	\N
3287	32	86	NPC	\N	\N	1	\N	Barbarian Camp (Lv 1)	\N
3288	32	87	EMPTY	\N	\N	\N	\N	\N	\N
3289	32	88	EMPTY	\N	\N	\N	\N	\N	\N
3290	32	89	EMPTY	\N	\N	\N	\N	\N	\N
3291	32	90	EMPTY	\N	\N	\N	\N	\N	\N
3292	32	91	EMPTY	\N	\N	\N	\N	\N	\N
3293	32	92	RESOURCE	food	3	\N	\N	\N	\N
3294	32	93	EMPTY	\N	\N	\N	\N	\N	\N
3295	32	94	RESOURCE	food	5	\N	\N	\N	\N
3296	32	95	EMPTY	\N	\N	\N	\N	\N	\N
3297	32	96	EMPTY	\N	\N	\N	\N	\N	\N
3298	32	97	EMPTY	\N	\N	\N	\N	\N	\N
3299	32	98	EMPTY	\N	\N	\N	\N	\N	\N
3300	32	99	EMPTY	\N	\N	\N	\N	\N	\N
3301	33	0	EMPTY	\N	\N	\N	\N	\N	\N
3302	33	1	EMPTY	\N	\N	\N	\N	\N	\N
3303	33	2	EMPTY	\N	\N	\N	\N	\N	\N
3304	33	3	EMPTY	\N	\N	\N	\N	\N	\N
3305	33	4	EMPTY	\N	\N	\N	\N	\N	\N
3306	33	5	EMPTY	\N	\N	\N	\N	\N	\N
3307	33	6	NPC	\N	\N	8	\N	Barbarian Camp (Lv 8)	\N
3308	33	7	EMPTY	\N	\N	\N	\N	\N	\N
3309	33	8	EMPTY	\N	\N	\N	\N	\N	\N
3310	33	9	EMPTY	\N	\N	\N	\N	\N	\N
3311	33	10	EMPTY	\N	\N	\N	\N	\N	\N
3312	33	11	EMPTY	\N	\N	\N	\N	\N	\N
3313	33	12	EMPTY	\N	\N	\N	\N	\N	\N
3314	33	13	EMPTY	\N	\N	\N	\N	\N	\N
3315	33	14	EMPTY	\N	\N	\N	\N	\N	\N
3316	33	15	RESOURCE	iron	2	\N	\N	\N	\N
3317	33	16	EMPTY	\N	\N	\N	\N	\N	\N
3318	33	17	EMPTY	\N	\N	\N	\N	\N	\N
3319	33	18	EMPTY	\N	\N	\N	\N	\N	\N
3320	33	19	EMPTY	\N	\N	\N	\N	\N	\N
3321	33	20	EMPTY	\N	\N	\N	\N	\N	\N
3322	33	21	EMPTY	\N	\N	\N	\N	\N	\N
3323	33	22	RESOURCE	wood	1	\N	\N	\N	\N
3324	33	23	EMPTY	\N	\N	\N	\N	\N	\N
3325	33	24	EMPTY	\N	\N	\N	\N	\N	\N
3326	33	25	NPC	\N	\N	8	\N	Barbarian Camp (Lv 8)	\N
3327	33	26	EMPTY	\N	\N	\N	\N	\N	\N
3328	33	27	EMPTY	\N	\N	\N	\N	\N	\N
3329	33	28	EMPTY	\N	\N	\N	\N	\N	\N
3330	33	29	EMPTY	\N	\N	\N	\N	\N	\N
3331	33	30	EMPTY	\N	\N	\N	\N	\N	\N
3332	33	31	EMPTY	\N	\N	\N	\N	\N	\N
3333	33	32	NPC	\N	\N	2	\N	Barbarian Camp (Lv 2)	\N
3334	33	33	EMPTY	\N	\N	\N	\N	\N	\N
3335	33	34	EMPTY	\N	\N	\N	\N	\N	\N
3336	33	35	EMPTY	\N	\N	\N	\N	\N	\N
3337	33	36	EMPTY	\N	\N	\N	\N	\N	\N
3338	33	37	EMPTY	\N	\N	\N	\N	\N	\N
3339	33	38	EMPTY	\N	\N	\N	\N	\N	\N
3340	33	39	EMPTY	\N	\N	\N	\N	\N	\N
3341	33	40	EMPTY	\N	\N	\N	\N	\N	\N
3342	33	41	EMPTY	\N	\N	\N	\N	\N	\N
3343	33	42	EMPTY	\N	\N	\N	\N	\N	\N
3344	33	43	EMPTY	\N	\N	\N	\N	\N	\N
3345	33	44	EMPTY	\N	\N	\N	\N	\N	\N
3346	33	45	EMPTY	\N	\N	\N	\N	\N	\N
3347	33	46	EMPTY	\N	\N	\N	\N	\N	\N
3348	33	47	RESOURCE	iron	1	\N	\N	\N	\N
3349	33	48	EMPTY	\N	\N	\N	\N	\N	\N
3350	33	49	EMPTY	\N	\N	\N	\N	\N	\N
3351	33	50	EMPTY	\N	\N	\N	\N	\N	\N
3352	33	51	EMPTY	\N	\N	\N	\N	\N	\N
3353	33	52	RESOURCE	food	3	\N	\N	\N	\N
3354	33	53	EMPTY	\N	\N	\N	\N	\N	\N
3355	33	54	EMPTY	\N	\N	\N	\N	\N	\N
3356	33	55	EMPTY	\N	\N	\N	\N	\N	\N
3357	33	56	EMPTY	\N	\N	\N	\N	\N	\N
3358	33	57	EMPTY	\N	\N	\N	\N	\N	\N
3359	33	58	EMPTY	\N	\N	\N	\N	\N	\N
3360	33	59	EMPTY	\N	\N	\N	\N	\N	\N
3361	33	60	EMPTY	\N	\N	\N	\N	\N	\N
3362	33	61	EMPTY	\N	\N	\N	\N	\N	\N
3363	33	62	EMPTY	\N	\N	\N	\N	\N	\N
3364	33	63	RESOURCE	food	5	\N	\N	\N	\N
3365	33	64	EMPTY	\N	\N	\N	\N	\N	\N
3366	33	65	EMPTY	\N	\N	\N	\N	\N	\N
3367	33	66	EMPTY	\N	\N	\N	\N	\N	\N
3368	33	67	EMPTY	\N	\N	\N	\N	\N	\N
3369	33	68	RESOURCE	food	5	\N	\N	\N	\N
3370	33	69	EMPTY	\N	\N	\N	\N	\N	\N
3371	33	70	EMPTY	\N	\N	\N	\N	\N	\N
3372	33	71	EMPTY	\N	\N	\N	\N	\N	\N
3373	33	72	EMPTY	\N	\N	\N	\N	\N	\N
3374	33	73	EMPTY	\N	\N	\N	\N	\N	\N
3375	33	74	VALLEY	\N	\N	\N	\N	Valley (33, 74)	\N
3376	33	75	EMPTY	\N	\N	\N	\N	\N	\N
3377	33	76	EMPTY	\N	\N	\N	\N	\N	\N
3378	33	77	EMPTY	\N	\N	\N	\N	\N	\N
3379	33	78	EMPTY	\N	\N	\N	\N	\N	\N
3380	33	79	EMPTY	\N	\N	\N	\N	\N	\N
3381	33	80	EMPTY	\N	\N	\N	\N	\N	\N
3382	33	81	EMPTY	\N	\N	\N	\N	\N	\N
3383	33	82	EMPTY	\N	\N	\N	\N	\N	\N
3384	33	83	EMPTY	\N	\N	\N	\N	\N	\N
3385	33	84	EMPTY	\N	\N	\N	\N	\N	\N
3386	33	85	EMPTY	\N	\N	\N	\N	\N	\N
3387	33	86	EMPTY	\N	\N	\N	\N	\N	\N
3388	33	87	EMPTY	\N	\N	\N	\N	\N	\N
3389	33	88	EMPTY	\N	\N	\N	\N	\N	\N
3390	33	89	EMPTY	\N	\N	\N	\N	\N	\N
3391	33	90	EMPTY	\N	\N	\N	\N	\N	\N
3392	33	91	EMPTY	\N	\N	\N	\N	\N	\N
3393	33	92	EMPTY	\N	\N	\N	\N	\N	\N
3394	33	93	RESOURCE	iron	5	\N	\N	\N	\N
3395	33	94	NPC	\N	\N	3	\N	Barbarian Camp (Lv 3)	\N
3396	33	95	EMPTY	\N	\N	\N	\N	\N	\N
3397	33	96	EMPTY	\N	\N	\N	\N	\N	\N
3398	33	97	EMPTY	\N	\N	\N	\N	\N	\N
3399	33	98	EMPTY	\N	\N	\N	\N	\N	\N
3400	33	99	EMPTY	\N	\N	\N	\N	\N	\N
3401	34	0	EMPTY	\N	\N	\N	\N	\N	\N
3402	34	1	EMPTY	\N	\N	\N	\N	\N	\N
3403	34	2	EMPTY	\N	\N	\N	\N	\N	\N
3404	34	3	RESOURCE	wood	5	\N	\N	\N	\N
3405	34	4	RESOURCE	stone	1	\N	\N	\N	\N
3406	34	5	EMPTY	\N	\N	\N	\N	\N	\N
3407	34	6	EMPTY	\N	\N	\N	\N	\N	\N
3408	34	7	EMPTY	\N	\N	\N	\N	\N	\N
3409	34	8	EMPTY	\N	\N	\N	\N	\N	\N
3410	34	9	EMPTY	\N	\N	\N	\N	\N	\N
3411	34	10	EMPTY	\N	\N	\N	\N	\N	\N
3412	34	11	EMPTY	\N	\N	\N	\N	\N	\N
3413	34	12	EMPTY	\N	\N	\N	\N	\N	\N
3414	34	13	EMPTY	\N	\N	\N	\N	\N	\N
3415	34	14	EMPTY	\N	\N	\N	\N	\N	\N
3416	34	15	EMPTY	\N	\N	\N	\N	\N	\N
3417	34	16	EMPTY	\N	\N	\N	\N	\N	\N
3418	34	17	EMPTY	\N	\N	\N	\N	\N	\N
3419	34	18	EMPTY	\N	\N	\N	\N	\N	\N
3420	34	19	EMPTY	\N	\N	\N	\N	\N	\N
3421	34	20	EMPTY	\N	\N	\N	\N	\N	\N
3422	34	21	EMPTY	\N	\N	\N	\N	\N	\N
3423	34	22	EMPTY	\N	\N	\N	\N	\N	\N
3424	34	23	EMPTY	\N	\N	\N	\N	\N	\N
3425	34	24	EMPTY	\N	\N	\N	\N	\N	\N
3426	34	25	EMPTY	\N	\N	\N	\N	\N	\N
3427	34	26	EMPTY	\N	\N	\N	\N	\N	\N
3428	34	27	EMPTY	\N	\N	\N	\N	\N	\N
3429	34	28	EMPTY	\N	\N	\N	\N	\N	\N
3430	34	29	EMPTY	\N	\N	\N	\N	\N	\N
3431	34	30	EMPTY	\N	\N	\N	\N	\N	\N
3432	34	31	EMPTY	\N	\N	\N	\N	\N	\N
3433	34	32	EMPTY	\N	\N	\N	\N	\N	\N
3434	34	33	EMPTY	\N	\N	\N	\N	\N	\N
3435	34	34	EMPTY	\N	\N	\N	\N	\N	\N
3436	34	35	RESOURCE	stone	5	\N	\N	\N	\N
3437	34	36	RESOURCE	food	3	\N	\N	\N	\N
3438	34	37	EMPTY	\N	\N	\N	\N	\N	\N
3439	34	38	RESOURCE	wood	5	\N	\N	\N	\N
3440	34	39	EMPTY	\N	\N	\N	\N	\N	\N
3441	34	40	NPC	\N	\N	5	\N	Barbarian Camp (Lv 5)	\N
3442	34	41	EMPTY	\N	\N	\N	\N	\N	\N
3443	34	42	EMPTY	\N	\N	\N	\N	\N	\N
3444	34	43	EMPTY	\N	\N	\N	\N	\N	\N
3445	34	44	NPC	\N	\N	10	\N	Barbarian Camp (Lv 10)	\N
3446	34	45	EMPTY	\N	\N	\N	\N	\N	\N
3447	34	46	EMPTY	\N	\N	\N	\N	\N	\N
3448	34	47	RESOURCE	food	5	\N	\N	\N	\N
3449	34	48	EMPTY	\N	\N	\N	\N	\N	\N
3450	34	49	EMPTY	\N	\N	\N	\N	\N	\N
3451	34	50	RESOURCE	iron	3	\N	\N	\N	\N
3452	34	51	NPC	\N	\N	1	\N	Barbarian Camp (Lv 1)	\N
3453	34	52	RESOURCE	food	1	\N	\N	\N	\N
3454	34	53	EMPTY	\N	\N	\N	\N	\N	\N
3455	34	54	EMPTY	\N	\N	\N	\N	\N	\N
3456	34	55	EMPTY	\N	\N	\N	\N	\N	\N
3457	34	56	EMPTY	\N	\N	\N	\N	\N	\N
3458	34	57	EMPTY	\N	\N	\N	\N	\N	\N
3459	34	58	EMPTY	\N	\N	\N	\N	\N	\N
3460	34	59	EMPTY	\N	\N	\N	\N	\N	\N
3461	34	60	RESOURCE	iron	3	\N	\N	\N	\N
3462	34	61	VALLEY	\N	\N	\N	\N	Valley (34, 61)	\N
3463	34	62	EMPTY	\N	\N	\N	\N	\N	\N
3464	34	63	EMPTY	\N	\N	\N	\N	\N	\N
3465	34	64	NPC	\N	\N	10	\N	Barbarian Camp (Lv 10)	\N
3466	34	65	EMPTY	\N	\N	\N	\N	\N	\N
3467	34	66	EMPTY	\N	\N	\N	\N	\N	\N
3468	34	67	EMPTY	\N	\N	\N	\N	\N	\N
3469	34	68	RESOURCE	stone	1	\N	\N	\N	\N
3470	34	69	EMPTY	\N	\N	\N	\N	\N	\N
3471	34	70	EMPTY	\N	\N	\N	\N	\N	\N
3472	34	71	EMPTY	\N	\N	\N	\N	\N	\N
3473	34	72	EMPTY	\N	\N	\N	\N	\N	\N
3474	34	73	EMPTY	\N	\N	\N	\N	\N	\N
3475	34	74	EMPTY	\N	\N	\N	\N	\N	\N
3476	34	75	EMPTY	\N	\N	\N	\N	\N	\N
3477	34	76	EMPTY	\N	\N	\N	\N	\N	\N
3478	34	77	EMPTY	\N	\N	\N	\N	\N	\N
3479	34	78	VALLEY	\N	\N	\N	\N	Valley (34, 78)	\N
3480	34	79	EMPTY	\N	\N	\N	\N	\N	\N
3481	34	80	EMPTY	\N	\N	\N	\N	\N	\N
3482	34	81	EMPTY	\N	\N	\N	\N	\N	\N
3483	34	82	RESOURCE	stone	3	\N	\N	\N	\N
3484	34	83	EMPTY	\N	\N	\N	\N	\N	\N
3485	34	84	EMPTY	\N	\N	\N	\N	\N	\N
3486	34	85	EMPTY	\N	\N	\N	\N	\N	\N
3487	34	86	EMPTY	\N	\N	\N	\N	\N	\N
3488	34	87	EMPTY	\N	\N	\N	\N	\N	\N
3489	34	88	EMPTY	\N	\N	\N	\N	\N	\N
3490	34	89	EMPTY	\N	\N	\N	\N	\N	\N
3491	34	90	EMPTY	\N	\N	\N	\N	\N	\N
3492	34	91	EMPTY	\N	\N	\N	\N	\N	\N
3493	34	92	EMPTY	\N	\N	\N	\N	\N	\N
3494	34	93	RESOURCE	stone	5	\N	\N	\N	\N
3495	34	94	RESOURCE	food	5	\N	\N	\N	\N
3496	34	95	RESOURCE	stone	4	\N	\N	\N	\N
3497	34	96	EMPTY	\N	\N	\N	\N	\N	\N
3498	34	97	VALLEY	\N	\N	\N	\N	Valley (34, 97)	\N
3499	34	98	EMPTY	\N	\N	\N	\N	\N	\N
3500	34	99	EMPTY	\N	\N	\N	\N	\N	\N
3501	35	0	EMPTY	\N	\N	\N	\N	\N	\N
3502	35	1	EMPTY	\N	\N	\N	\N	\N	\N
3503	35	2	EMPTY	\N	\N	\N	\N	\N	\N
3504	35	3	EMPTY	\N	\N	\N	\N	\N	\N
3505	35	4	RESOURCE	iron	4	\N	\N	\N	\N
3506	35	5	EMPTY	\N	\N	\N	\N	\N	\N
3507	35	6	EMPTY	\N	\N	\N	\N	\N	\N
3508	35	7	EMPTY	\N	\N	\N	\N	\N	\N
3509	35	8	EMPTY	\N	\N	\N	\N	\N	\N
3510	35	9	EMPTY	\N	\N	\N	\N	\N	\N
3511	35	10	RESOURCE	wood	5	\N	\N	\N	\N
3512	35	11	EMPTY	\N	\N	\N	\N	\N	\N
3513	35	12	EMPTY	\N	\N	\N	\N	\N	\N
3514	35	13	EMPTY	\N	\N	\N	\N	\N	\N
3515	35	14	EMPTY	\N	\N	\N	\N	\N	\N
3516	35	15	EMPTY	\N	\N	\N	\N	\N	\N
3517	35	16	EMPTY	\N	\N	\N	\N	\N	\N
3518	35	17	RESOURCE	food	1	\N	\N	\N	\N
3519	35	18	EMPTY	\N	\N	\N	\N	\N	\N
3520	35	19	NPC	\N	\N	10	\N	Barbarian Camp (Lv 10)	\N
3521	35	20	EMPTY	\N	\N	\N	\N	\N	\N
3522	35	21	EMPTY	\N	\N	\N	\N	\N	\N
3523	35	22	RESOURCE	wood	1	\N	\N	\N	\N
3524	35	23	EMPTY	\N	\N	\N	\N	\N	\N
3525	35	24	EMPTY	\N	\N	\N	\N	\N	\N
3526	35	25	EMPTY	\N	\N	\N	\N	\N	\N
3527	35	26	EMPTY	\N	\N	\N	\N	\N	\N
3528	35	27	EMPTY	\N	\N	\N	\N	\N	\N
3529	35	28	EMPTY	\N	\N	\N	\N	\N	\N
3530	35	29	EMPTY	\N	\N	\N	\N	\N	\N
3531	35	30	EMPTY	\N	\N	\N	\N	\N	\N
3532	35	31	EMPTY	\N	\N	\N	\N	\N	\N
3533	35	32	EMPTY	\N	\N	\N	\N	\N	\N
3534	35	33	EMPTY	\N	\N	\N	\N	\N	\N
3535	35	34	EMPTY	\N	\N	\N	\N	\N	\N
3536	35	35	EMPTY	\N	\N	\N	\N	\N	\N
3537	35	36	EMPTY	\N	\N	\N	\N	\N	\N
3538	35	37	EMPTY	\N	\N	\N	\N	\N	\N
3539	35	38	EMPTY	\N	\N	\N	\N	\N	\N
3540	35	39	EMPTY	\N	\N	\N	\N	\N	\N
3541	35	40	EMPTY	\N	\N	\N	\N	\N	\N
3542	35	41	EMPTY	\N	\N	\N	\N	\N	\N
3543	35	42	EMPTY	\N	\N	\N	\N	\N	\N
3544	35	43	EMPTY	\N	\N	\N	\N	\N	\N
3545	35	44	EMPTY	\N	\N	\N	\N	\N	\N
3546	35	45	EMPTY	\N	\N	\N	\N	\N	\N
3547	35	46	NPC	\N	\N	2	\N	Barbarian Camp (Lv 2)	\N
3548	35	47	EMPTY	\N	\N	\N	\N	\N	\N
3549	35	48	EMPTY	\N	\N	\N	\N	\N	\N
3550	35	49	EMPTY	\N	\N	\N	\N	\N	\N
3551	35	50	EMPTY	\N	\N	\N	\N	\N	\N
3552	35	51	VALLEY	\N	\N	\N	\N	Valley (35, 51)	\N
3553	35	52	EMPTY	\N	\N	\N	\N	\N	\N
3554	35	53	EMPTY	\N	\N	\N	\N	\N	\N
3555	35	54	EMPTY	\N	\N	\N	\N	\N	\N
3556	35	55	VALLEY	\N	\N	\N	\N	Valley (35, 55)	\N
3557	35	56	RESOURCE	food	5	\N	\N	\N	\N
3558	35	57	EMPTY	\N	\N	\N	\N	\N	\N
3559	35	58	EMPTY	\N	\N	\N	\N	\N	\N
3560	35	59	EMPTY	\N	\N	\N	\N	\N	\N
3561	35	60	EMPTY	\N	\N	\N	\N	\N	\N
3562	35	61	EMPTY	\N	\N	\N	\N	\N	\N
3563	35	62	RESOURCE	iron	4	\N	\N	\N	\N
3564	35	63	EMPTY	\N	\N	\N	\N	\N	\N
3565	35	64	NPC	\N	\N	8	\N	Barbarian Camp (Lv 8)	\N
3566	35	65	EMPTY	\N	\N	\N	\N	\N	\N
3567	35	66	EMPTY	\N	\N	\N	\N	\N	\N
3568	35	67	EMPTY	\N	\N	\N	\N	\N	\N
3569	35	68	EMPTY	\N	\N	\N	\N	\N	\N
3570	35	69	EMPTY	\N	\N	\N	\N	\N	\N
3571	35	70	EMPTY	\N	\N	\N	\N	\N	\N
3572	35	71	EMPTY	\N	\N	\N	\N	\N	\N
3573	35	72	EMPTY	\N	\N	\N	\N	\N	\N
3574	35	73	EMPTY	\N	\N	\N	\N	\N	\N
3575	35	74	EMPTY	\N	\N	\N	\N	\N	\N
3576	35	75	EMPTY	\N	\N	\N	\N	\N	\N
3577	35	76	EMPTY	\N	\N	\N	\N	\N	\N
3578	35	77	EMPTY	\N	\N	\N	\N	\N	\N
3579	35	78	EMPTY	\N	\N	\N	\N	\N	\N
3580	35	79	EMPTY	\N	\N	\N	\N	\N	\N
3581	35	80	RESOURCE	iron	2	\N	\N	\N	\N
3582	35	81	EMPTY	\N	\N	\N	\N	\N	\N
3583	35	82	EMPTY	\N	\N	\N	\N	\N	\N
3584	35	83	EMPTY	\N	\N	\N	\N	\N	\N
3585	35	84	EMPTY	\N	\N	\N	\N	\N	\N
3586	35	85	EMPTY	\N	\N	\N	\N	\N	\N
3587	35	86	EMPTY	\N	\N	\N	\N	\N	\N
3588	35	87	EMPTY	\N	\N	\N	\N	\N	\N
3589	35	88	RESOURCE	iron	4	\N	\N	\N	\N
3590	35	89	EMPTY	\N	\N	\N	\N	\N	\N
3591	35	90	EMPTY	\N	\N	\N	\N	\N	\N
3592	35	91	EMPTY	\N	\N	\N	\N	\N	\N
3593	35	92	EMPTY	\N	\N	\N	\N	\N	\N
3594	35	93	EMPTY	\N	\N	\N	\N	\N	\N
3595	35	94	EMPTY	\N	\N	\N	\N	\N	\N
3596	35	95	EMPTY	\N	\N	\N	\N	\N	\N
3597	35	96	EMPTY	\N	\N	\N	\N	\N	\N
3598	35	97	EMPTY	\N	\N	\N	\N	\N	\N
3599	35	98	EMPTY	\N	\N	\N	\N	\N	\N
3600	35	99	EMPTY	\N	\N	\N	\N	\N	\N
3601	36	0	EMPTY	\N	\N	\N	\N	\N	\N
3602	36	1	EMPTY	\N	\N	\N	\N	\N	\N
3603	36	2	RESOURCE	stone	2	\N	\N	\N	\N
3604	36	3	EMPTY	\N	\N	\N	\N	\N	\N
3605	36	4	EMPTY	\N	\N	\N	\N	\N	\N
3606	36	5	EMPTY	\N	\N	\N	\N	\N	\N
3607	36	6	EMPTY	\N	\N	\N	\N	\N	\N
3608	36	7	EMPTY	\N	\N	\N	\N	\N	\N
3609	36	8	EMPTY	\N	\N	\N	\N	\N	\N
3610	36	9	EMPTY	\N	\N	\N	\N	\N	\N
3611	36	10	EMPTY	\N	\N	\N	\N	\N	\N
3612	36	11	NPC	\N	\N	3	\N	Barbarian Camp (Lv 3)	\N
3613	36	12	EMPTY	\N	\N	\N	\N	\N	\N
3614	36	13	RESOURCE	iron	2	\N	\N	\N	\N
3615	36	14	EMPTY	\N	\N	\N	\N	\N	\N
3616	36	15	EMPTY	\N	\N	\N	\N	\N	\N
3617	36	16	EMPTY	\N	\N	\N	\N	\N	\N
3618	36	17	NPC	\N	\N	3	\N	Barbarian Camp (Lv 3)	\N
3619	36	18	EMPTY	\N	\N	\N	\N	\N	\N
3620	36	19	EMPTY	\N	\N	\N	\N	\N	\N
3621	36	20	EMPTY	\N	\N	\N	\N	\N	\N
3622	36	21	EMPTY	\N	\N	\N	\N	\N	\N
3623	36	22	VALLEY	\N	\N	\N	\N	Valley (36, 22)	\N
3624	36	23	EMPTY	\N	\N	\N	\N	\N	\N
3625	36	24	EMPTY	\N	\N	\N	\N	\N	\N
3626	36	25	EMPTY	\N	\N	\N	\N	\N	\N
3627	36	26	EMPTY	\N	\N	\N	\N	\N	\N
3628	36	27	EMPTY	\N	\N	\N	\N	\N	\N
3629	36	28	EMPTY	\N	\N	\N	\N	\N	\N
3630	36	29	RESOURCE	food	3	\N	\N	\N	\N
3631	36	30	EMPTY	\N	\N	\N	\N	\N	\N
3632	36	31	EMPTY	\N	\N	\N	\N	\N	\N
3633	36	32	EMPTY	\N	\N	\N	\N	\N	\N
3634	36	33	EMPTY	\N	\N	\N	\N	\N	\N
3635	36	34	EMPTY	\N	\N	\N	\N	\N	\N
3636	36	35	EMPTY	\N	\N	\N	\N	\N	\N
3637	36	36	EMPTY	\N	\N	\N	\N	\N	\N
3638	36	37	EMPTY	\N	\N	\N	\N	\N	\N
3639	36	38	EMPTY	\N	\N	\N	\N	\N	\N
3640	36	39	EMPTY	\N	\N	\N	\N	\N	\N
3641	36	40	EMPTY	\N	\N	\N	\N	\N	\N
3642	36	41	EMPTY	\N	\N	\N	\N	\N	\N
3643	36	42	EMPTY	\N	\N	\N	\N	\N	\N
3644	36	43	EMPTY	\N	\N	\N	\N	\N	\N
3645	36	44	EMPTY	\N	\N	\N	\N	\N	\N
3646	36	45	EMPTY	\N	\N	\N	\N	\N	\N
3647	36	46	NPC	\N	\N	7	\N	Barbarian Camp (Lv 7)	\N
3648	36	47	RESOURCE	food	3	\N	\N	\N	\N
3649	36	48	EMPTY	\N	\N	\N	\N	\N	\N
3650	36	49	EMPTY	\N	\N	\N	\N	\N	\N
3651	36	50	EMPTY	\N	\N	\N	\N	\N	\N
3652	36	51	EMPTY	\N	\N	\N	\N	\N	\N
3653	36	52	EMPTY	\N	\N	\N	\N	\N	\N
3654	36	53	RESOURCE	iron	2	\N	\N	\N	\N
3655	36	54	EMPTY	\N	\N	\N	\N	\N	\N
3656	36	55	EMPTY	\N	\N	\N	\N	\N	\N
3657	36	56	EMPTY	\N	\N	\N	\N	\N	\N
3658	36	57	EMPTY	\N	\N	\N	\N	\N	\N
3659	36	58	EMPTY	\N	\N	\N	\N	\N	\N
3660	36	59	EMPTY	\N	\N	\N	\N	\N	\N
3661	36	60	EMPTY	\N	\N	\N	\N	\N	\N
3662	36	61	EMPTY	\N	\N	\N	\N	\N	\N
3663	36	62	EMPTY	\N	\N	\N	\N	\N	\N
3664	36	63	EMPTY	\N	\N	\N	\N	\N	\N
3665	36	64	EMPTY	\N	\N	\N	\N	\N	\N
3666	36	65	EMPTY	\N	\N	\N	\N	\N	\N
3667	36	66	EMPTY	\N	\N	\N	\N	\N	\N
3668	36	67	EMPTY	\N	\N	\N	\N	\N	\N
3669	36	68	EMPTY	\N	\N	\N	\N	\N	\N
3670	36	69	EMPTY	\N	\N	\N	\N	\N	\N
3671	36	70	EMPTY	\N	\N	\N	\N	\N	\N
3672	36	71	RESOURCE	food	3	\N	\N	\N	\N
3673	36	72	EMPTY	\N	\N	\N	\N	\N	\N
3674	36	73	EMPTY	\N	\N	\N	\N	\N	\N
3675	36	74	EMPTY	\N	\N	\N	\N	\N	\N
3676	36	75	RESOURCE	stone	5	\N	\N	\N	\N
3677	36	76	EMPTY	\N	\N	\N	\N	\N	\N
3678	36	77	NPC	\N	\N	5	\N	Barbarian Camp (Lv 5)	\N
3679	36	78	EMPTY	\N	\N	\N	\N	\N	\N
3680	36	79	EMPTY	\N	\N	\N	\N	\N	\N
3681	36	80	EMPTY	\N	\N	\N	\N	\N	\N
3682	36	81	EMPTY	\N	\N	\N	\N	\N	\N
3683	36	82	EMPTY	\N	\N	\N	\N	\N	\N
3684	36	83	EMPTY	\N	\N	\N	\N	\N	\N
3685	36	84	EMPTY	\N	\N	\N	\N	\N	\N
3686	36	85	EMPTY	\N	\N	\N	\N	\N	\N
3687	36	86	VALLEY	\N	\N	\N	\N	Valley (36, 86)	\N
3688	36	87	VALLEY	\N	\N	\N	\N	Valley (36, 87)	\N
3689	36	88	EMPTY	\N	\N	\N	\N	\N	\N
3690	36	89	EMPTY	\N	\N	\N	\N	\N	\N
3691	36	90	EMPTY	\N	\N	\N	\N	\N	\N
3692	36	91	EMPTY	\N	\N	\N	\N	\N	\N
3693	36	92	EMPTY	\N	\N	\N	\N	\N	\N
3694	36	93	EMPTY	\N	\N	\N	\N	\N	\N
3695	36	94	EMPTY	\N	\N	\N	\N	\N	\N
3696	36	95	EMPTY	\N	\N	\N	\N	\N	\N
3697	36	96	EMPTY	\N	\N	\N	\N	\N	\N
3698	36	97	EMPTY	\N	\N	\N	\N	\N	\N
3699	36	98	NPC	\N	\N	7	\N	Barbarian Camp (Lv 7)	\N
3700	36	99	EMPTY	\N	\N	\N	\N	\N	\N
3701	37	0	EMPTY	\N	\N	\N	\N	\N	\N
3702	37	1	EMPTY	\N	\N	\N	\N	\N	\N
3703	37	2	EMPTY	\N	\N	\N	\N	\N	\N
3704	37	3	EMPTY	\N	\N	\N	\N	\N	\N
3705	37	4	EMPTY	\N	\N	\N	\N	\N	\N
3706	37	5	EMPTY	\N	\N	\N	\N	\N	\N
3707	37	6	EMPTY	\N	\N	\N	\N	\N	\N
3708	37	7	EMPTY	\N	\N	\N	\N	\N	\N
3709	37	8	EMPTY	\N	\N	\N	\N	\N	\N
3710	37	9	EMPTY	\N	\N	\N	\N	\N	\N
3711	37	10	EMPTY	\N	\N	\N	\N	\N	\N
3712	37	11	EMPTY	\N	\N	\N	\N	\N	\N
3713	37	12	EMPTY	\N	\N	\N	\N	\N	\N
3714	37	13	EMPTY	\N	\N	\N	\N	\N	\N
3715	37	14	EMPTY	\N	\N	\N	\N	\N	\N
3716	37	15	EMPTY	\N	\N	\N	\N	\N	\N
3717	37	16	EMPTY	\N	\N	\N	\N	\N	\N
3718	37	17	NPC	\N	\N	5	\N	Barbarian Camp (Lv 5)	\N
3719	37	18	EMPTY	\N	\N	\N	\N	\N	\N
3720	37	19	EMPTY	\N	\N	\N	\N	\N	\N
3721	37	20	EMPTY	\N	\N	\N	\N	\N	\N
3722	37	21	EMPTY	\N	\N	\N	\N	\N	\N
3723	37	22	RESOURCE	stone	5	\N	\N	\N	\N
3724	37	23	EMPTY	\N	\N	\N	\N	\N	\N
3725	37	24	EMPTY	\N	\N	\N	\N	\N	\N
3726	37	25	RESOURCE	wood	2	\N	\N	\N	\N
3727	37	26	EMPTY	\N	\N	\N	\N	\N	\N
3728	37	27	EMPTY	\N	\N	\N	\N	\N	\N
3729	37	28	EMPTY	\N	\N	\N	\N	\N	\N
3730	37	29	EMPTY	\N	\N	\N	\N	\N	\N
3731	37	30	EMPTY	\N	\N	\N	\N	\N	\N
3732	37	31	EMPTY	\N	\N	\N	\N	\N	\N
3733	37	32	EMPTY	\N	\N	\N	\N	\N	\N
3734	37	33	EMPTY	\N	\N	\N	\N	\N	\N
3735	37	34	EMPTY	\N	\N	\N	\N	\N	\N
3736	37	35	EMPTY	\N	\N	\N	\N	\N	\N
3737	37	36	EMPTY	\N	\N	\N	\N	\N	\N
3738	37	37	EMPTY	\N	\N	\N	\N	\N	\N
3739	37	38	EMPTY	\N	\N	\N	\N	\N	\N
3740	37	39	EMPTY	\N	\N	\N	\N	\N	\N
3741	37	40	NPC	\N	\N	1	\N	Barbarian Camp (Lv 1)	\N
3742	37	41	EMPTY	\N	\N	\N	\N	\N	\N
3743	37	42	EMPTY	\N	\N	\N	\N	\N	\N
3744	37	43	EMPTY	\N	\N	\N	\N	\N	\N
3745	37	44	EMPTY	\N	\N	\N	\N	\N	\N
3746	37	45	EMPTY	\N	\N	\N	\N	\N	\N
3747	37	46	EMPTY	\N	\N	\N	\N	\N	\N
3748	37	47	EMPTY	\N	\N	\N	\N	\N	\N
3749	37	48	NPC	\N	\N	1	\N	Barbarian Camp (Lv 1)	\N
3750	37	49	EMPTY	\N	\N	\N	\N	\N	\N
3751	37	50	VALLEY	\N	\N	\N	\N	Valley (37, 50)	\N
3752	37	51	NPC	\N	\N	9	\N	Barbarian Camp (Lv 9)	\N
3753	37	52	EMPTY	\N	\N	\N	\N	\N	\N
3754	37	53	EMPTY	\N	\N	\N	\N	\N	\N
3755	37	54	EMPTY	\N	\N	\N	\N	\N	\N
3756	37	55	EMPTY	\N	\N	\N	\N	\N	\N
3757	37	56	EMPTY	\N	\N	\N	\N	\N	\N
3758	37	57	EMPTY	\N	\N	\N	\N	\N	\N
3759	37	58	EMPTY	\N	\N	\N	\N	\N	\N
3760	37	59	EMPTY	\N	\N	\N	\N	\N	\N
3761	37	60	EMPTY	\N	\N	\N	\N	\N	\N
3762	37	61	EMPTY	\N	\N	\N	\N	\N	\N
3763	37	62	EMPTY	\N	\N	\N	\N	\N	\N
3764	37	63	EMPTY	\N	\N	\N	\N	\N	\N
3765	37	64	EMPTY	\N	\N	\N	\N	\N	\N
3766	37	65	EMPTY	\N	\N	\N	\N	\N	\N
3767	37	66	RESOURCE	stone	5	\N	\N	\N	\N
3768	37	67	EMPTY	\N	\N	\N	\N	\N	\N
3769	37	68	EMPTY	\N	\N	\N	\N	\N	\N
3770	37	69	EMPTY	\N	\N	\N	\N	\N	\N
3771	37	70	EMPTY	\N	\N	\N	\N	\N	\N
3772	37	71	EMPTY	\N	\N	\N	\N	\N	\N
3773	37	72	EMPTY	\N	\N	\N	\N	\N	\N
3774	37	73	EMPTY	\N	\N	\N	\N	\N	\N
3775	37	74	EMPTY	\N	\N	\N	\N	\N	\N
3776	37	75	EMPTY	\N	\N	\N	\N	\N	\N
3777	37	76	EMPTY	\N	\N	\N	\N	\N	\N
3778	37	77	EMPTY	\N	\N	\N	\N	\N	\N
3779	37	78	EMPTY	\N	\N	\N	\N	\N	\N
3780	37	79	EMPTY	\N	\N	\N	\N	\N	\N
3781	37	80	NPC	\N	\N	4	\N	Barbarian Camp (Lv 4)	\N
3782	37	81	EMPTY	\N	\N	\N	\N	\N	\N
3783	37	82	EMPTY	\N	\N	\N	\N	\N	\N
3784	37	83	EMPTY	\N	\N	\N	\N	\N	\N
3785	37	84	RESOURCE	wood	1	\N	\N	\N	\N
3786	37	85	EMPTY	\N	\N	\N	\N	\N	\N
3787	37	86	EMPTY	\N	\N	\N	\N	\N	\N
3788	37	87	EMPTY	\N	\N	\N	\N	\N	\N
3789	37	88	EMPTY	\N	\N	\N	\N	\N	\N
3790	37	89	EMPTY	\N	\N	\N	\N	\N	\N
3791	37	90	EMPTY	\N	\N	\N	\N	\N	\N
3792	37	91	EMPTY	\N	\N	\N	\N	\N	\N
3793	37	92	EMPTY	\N	\N	\N	\N	\N	\N
3794	37	93	EMPTY	\N	\N	\N	\N	\N	\N
3795	37	94	EMPTY	\N	\N	\N	\N	\N	\N
3796	37	95	EMPTY	\N	\N	\N	\N	\N	\N
3797	37	96	EMPTY	\N	\N	\N	\N	\N	\N
3798	37	97	EMPTY	\N	\N	\N	\N	\N	\N
3799	37	98	EMPTY	\N	\N	\N	\N	\N	\N
3800	37	99	EMPTY	\N	\N	\N	\N	\N	\N
3801	38	0	EMPTY	\N	\N	\N	\N	\N	\N
3802	38	1	NPC	\N	\N	9	\N	Barbarian Camp (Lv 9)	\N
3803	38	2	EMPTY	\N	\N	\N	\N	\N	\N
3804	38	3	NPC	\N	\N	6	\N	Barbarian Camp (Lv 6)	\N
3805	38	4	EMPTY	\N	\N	\N	\N	\N	\N
3806	38	5	EMPTY	\N	\N	\N	\N	\N	\N
3807	38	6	EMPTY	\N	\N	\N	\N	\N	\N
3808	38	7	EMPTY	\N	\N	\N	\N	\N	\N
3809	38	8	RESOURCE	wood	1	\N	\N	\N	\N
3810	38	9	EMPTY	\N	\N	\N	\N	\N	\N
3811	38	10	EMPTY	\N	\N	\N	\N	\N	\N
3812	38	11	EMPTY	\N	\N	\N	\N	\N	\N
3813	38	12	EMPTY	\N	\N	\N	\N	\N	\N
3814	38	13	EMPTY	\N	\N	\N	\N	\N	\N
3815	38	14	EMPTY	\N	\N	\N	\N	\N	\N
3816	38	15	EMPTY	\N	\N	\N	\N	\N	\N
3817	38	16	EMPTY	\N	\N	\N	\N	\N	\N
3818	38	17	RESOURCE	food	5	\N	\N	\N	\N
3819	38	18	RESOURCE	wood	1	\N	\N	\N	\N
3820	38	19	RESOURCE	stone	4	\N	\N	\N	\N
3821	38	20	NPC	\N	\N	2	\N	Barbarian Camp (Lv 2)	\N
3822	38	21	EMPTY	\N	\N	\N	\N	\N	\N
3823	38	22	EMPTY	\N	\N	\N	\N	\N	\N
3824	38	23	RESOURCE	iron	5	\N	\N	\N	\N
3825	38	24	EMPTY	\N	\N	\N	\N	\N	\N
3826	38	25	EMPTY	\N	\N	\N	\N	\N	\N
3827	38	26	EMPTY	\N	\N	\N	\N	\N	\N
3828	38	27	EMPTY	\N	\N	\N	\N	\N	\N
3829	38	28	EMPTY	\N	\N	\N	\N	\N	\N
3830	38	29	EMPTY	\N	\N	\N	\N	\N	\N
3831	38	30	EMPTY	\N	\N	\N	\N	\N	\N
3832	38	31	EMPTY	\N	\N	\N	\N	\N	\N
3833	38	32	EMPTY	\N	\N	\N	\N	\N	\N
3834	38	33	EMPTY	\N	\N	\N	\N	\N	\N
3835	38	34	EMPTY	\N	\N	\N	\N	\N	\N
3836	38	35	EMPTY	\N	\N	\N	\N	\N	\N
3837	38	36	EMPTY	\N	\N	\N	\N	\N	\N
3838	38	37	EMPTY	\N	\N	\N	\N	\N	\N
3839	38	38	EMPTY	\N	\N	\N	\N	\N	\N
3840	38	39	EMPTY	\N	\N	\N	\N	\N	\N
3841	38	40	EMPTY	\N	\N	\N	\N	\N	\N
3842	38	41	EMPTY	\N	\N	\N	\N	\N	\N
3843	38	42	EMPTY	\N	\N	\N	\N	\N	\N
3844	38	43	EMPTY	\N	\N	\N	\N	\N	\N
3845	38	44	EMPTY	\N	\N	\N	\N	\N	\N
3846	38	45	RESOURCE	iron	2	\N	\N	\N	\N
3847	38	46	EMPTY	\N	\N	\N	\N	\N	\N
3848	38	47	EMPTY	\N	\N	\N	\N	\N	\N
3849	38	48	EMPTY	\N	\N	\N	\N	\N	\N
3850	38	49	EMPTY	\N	\N	\N	\N	\N	\N
3851	38	50	EMPTY	\N	\N	\N	\N	\N	\N
3852	38	51	EMPTY	\N	\N	\N	\N	\N	\N
3853	38	52	EMPTY	\N	\N	\N	\N	\N	\N
3854	38	53	EMPTY	\N	\N	\N	\N	\N	\N
3855	38	54	EMPTY	\N	\N	\N	\N	\N	\N
3856	38	55	EMPTY	\N	\N	\N	\N	\N	\N
3857	38	56	EMPTY	\N	\N	\N	\N	\N	\N
3858	38	57	EMPTY	\N	\N	\N	\N	\N	\N
3859	38	58	EMPTY	\N	\N	\N	\N	\N	\N
3860	38	59	EMPTY	\N	\N	\N	\N	\N	\N
3861	38	60	EMPTY	\N	\N	\N	\N	\N	\N
3862	38	61	EMPTY	\N	\N	\N	\N	\N	\N
3863	38	62	EMPTY	\N	\N	\N	\N	\N	\N
3864	38	63	RESOURCE	stone	1	\N	\N	\N	\N
3865	38	64	EMPTY	\N	\N	\N	\N	\N	\N
3866	38	65	EMPTY	\N	\N	\N	\N	\N	\N
3867	38	66	EMPTY	\N	\N	\N	\N	\N	\N
3868	38	67	EMPTY	\N	\N	\N	\N	\N	\N
3869	38	68	EMPTY	\N	\N	\N	\N	\N	\N
3870	38	69	EMPTY	\N	\N	\N	\N	\N	\N
3871	38	70	EMPTY	\N	\N	\N	\N	\N	\N
3872	38	71	EMPTY	\N	\N	\N	\N	\N	\N
3873	38	72	EMPTY	\N	\N	\N	\N	\N	\N
3874	38	73	EMPTY	\N	\N	\N	\N	\N	\N
3875	38	74	EMPTY	\N	\N	\N	\N	\N	\N
3876	38	75	EMPTY	\N	\N	\N	\N	\N	\N
3877	38	76	EMPTY	\N	\N	\N	\N	\N	\N
3878	38	77	VALLEY	\N	\N	\N	\N	Valley (38, 77)	\N
3879	38	78	EMPTY	\N	\N	\N	\N	\N	\N
3880	38	79	RESOURCE	iron	1	\N	\N	\N	\N
3881	38	80	EMPTY	\N	\N	\N	\N	\N	\N
3882	38	81	EMPTY	\N	\N	\N	\N	\N	\N
3883	38	82	EMPTY	\N	\N	\N	\N	\N	\N
3884	38	83	EMPTY	\N	\N	\N	\N	\N	\N
3885	38	84	EMPTY	\N	\N	\N	\N	\N	\N
3886	38	85	EMPTY	\N	\N	\N	\N	\N	\N
3887	38	86	EMPTY	\N	\N	\N	\N	\N	\N
3888	38	87	EMPTY	\N	\N	\N	\N	\N	\N
3889	38	88	NPC	\N	\N	2	\N	Barbarian Camp (Lv 2)	\N
3890	38	89	EMPTY	\N	\N	\N	\N	\N	\N
3891	38	90	EMPTY	\N	\N	\N	\N	\N	\N
3892	38	91	EMPTY	\N	\N	\N	\N	\N	\N
3893	38	92	EMPTY	\N	\N	\N	\N	\N	\N
3894	38	93	EMPTY	\N	\N	\N	\N	\N	\N
3895	38	94	EMPTY	\N	\N	\N	\N	\N	\N
3896	38	95	EMPTY	\N	\N	\N	\N	\N	\N
3897	38	96	EMPTY	\N	\N	\N	\N	\N	\N
3898	38	97	EMPTY	\N	\N	\N	\N	\N	\N
3899	38	98	RESOURCE	wood	1	\N	\N	\N	\N
3900	38	99	EMPTY	\N	\N	\N	\N	\N	\N
3901	39	0	EMPTY	\N	\N	\N	\N	\N	\N
3902	39	1	EMPTY	\N	\N	\N	\N	\N	\N
3903	39	2	EMPTY	\N	\N	\N	\N	\N	\N
3904	39	3	EMPTY	\N	\N	\N	\N	\N	\N
3905	39	4	EMPTY	\N	\N	\N	\N	\N	\N
3906	39	5	NPC	\N	\N	10	\N	Barbarian Camp (Lv 10)	\N
3907	39	6	EMPTY	\N	\N	\N	\N	\N	\N
3908	39	7	EMPTY	\N	\N	\N	\N	\N	\N
3909	39	8	RESOURCE	wood	3	\N	\N	\N	\N
3910	39	9	EMPTY	\N	\N	\N	\N	\N	\N
3911	39	10	EMPTY	\N	\N	\N	\N	\N	\N
3912	39	11	EMPTY	\N	\N	\N	\N	\N	\N
3913	39	12	EMPTY	\N	\N	\N	\N	\N	\N
3914	39	13	EMPTY	\N	\N	\N	\N	\N	\N
3915	39	14	EMPTY	\N	\N	\N	\N	\N	\N
3916	39	15	NPC	\N	\N	5	\N	Barbarian Camp (Lv 5)	\N
3917	39	16	EMPTY	\N	\N	\N	\N	\N	\N
3918	39	17	EMPTY	\N	\N	\N	\N	\N	\N
3919	39	18	EMPTY	\N	\N	\N	\N	\N	\N
3920	39	19	EMPTY	\N	\N	\N	\N	\N	\N
3921	39	20	EMPTY	\N	\N	\N	\N	\N	\N
3922	39	21	EMPTY	\N	\N	\N	\N	\N	\N
3923	39	22	EMPTY	\N	\N	\N	\N	\N	\N
3924	39	23	EMPTY	\N	\N	\N	\N	\N	\N
3925	39	24	EMPTY	\N	\N	\N	\N	\N	\N
3926	39	25	EMPTY	\N	\N	\N	\N	\N	\N
3927	39	26	EMPTY	\N	\N	\N	\N	\N	\N
3928	39	27	EMPTY	\N	\N	\N	\N	\N	\N
3929	39	28	EMPTY	\N	\N	\N	\N	\N	\N
3930	39	29	EMPTY	\N	\N	\N	\N	\N	\N
3931	39	30	EMPTY	\N	\N	\N	\N	\N	\N
3932	39	31	VALLEY	\N	\N	\N	\N	Valley (39, 31)	\N
3933	39	32	EMPTY	\N	\N	\N	\N	\N	\N
3934	39	33	EMPTY	\N	\N	\N	\N	\N	\N
3935	39	34	EMPTY	\N	\N	\N	\N	\N	\N
3936	39	35	EMPTY	\N	\N	\N	\N	\N	\N
3937	39	36	EMPTY	\N	\N	\N	\N	\N	\N
3938	39	37	EMPTY	\N	\N	\N	\N	\N	\N
3939	39	38	EMPTY	\N	\N	\N	\N	\N	\N
3940	39	39	EMPTY	\N	\N	\N	\N	\N	\N
3941	39	40	EMPTY	\N	\N	\N	\N	\N	\N
3942	39	41	EMPTY	\N	\N	\N	\N	\N	\N
3943	39	42	EMPTY	\N	\N	\N	\N	\N	\N
3944	39	43	EMPTY	\N	\N	\N	\N	\N	\N
3945	39	44	EMPTY	\N	\N	\N	\N	\N	\N
3946	39	45	EMPTY	\N	\N	\N	\N	\N	\N
3947	39	46	EMPTY	\N	\N	\N	\N	\N	\N
3948	39	47	EMPTY	\N	\N	\N	\N	\N	\N
3949	39	48	EMPTY	\N	\N	\N	\N	\N	\N
3950	39	49	RESOURCE	food	1	\N	\N	\N	\N
3951	39	50	EMPTY	\N	\N	\N	\N	\N	\N
3952	39	51	EMPTY	\N	\N	\N	\N	\N	\N
3953	39	52	RESOURCE	wood	2	\N	\N	\N	\N
3954	39	53	EMPTY	\N	\N	\N	\N	\N	\N
3955	39	54	EMPTY	\N	\N	\N	\N	\N	\N
3956	39	55	EMPTY	\N	\N	\N	\N	\N	\N
3957	39	56	EMPTY	\N	\N	\N	\N	\N	\N
3958	39	57	EMPTY	\N	\N	\N	\N	\N	\N
3959	39	58	EMPTY	\N	\N	\N	\N	\N	\N
3960	39	59	EMPTY	\N	\N	\N	\N	\N	\N
3961	39	60	EMPTY	\N	\N	\N	\N	\N	\N
3962	39	61	EMPTY	\N	\N	\N	\N	\N	\N
3963	39	62	EMPTY	\N	\N	\N	\N	\N	\N
3964	39	63	RESOURCE	stone	2	\N	\N	\N	\N
3965	39	64	EMPTY	\N	\N	\N	\N	\N	\N
3966	39	65	EMPTY	\N	\N	\N	\N	\N	\N
3967	39	66	EMPTY	\N	\N	\N	\N	\N	\N
3968	39	67	EMPTY	\N	\N	\N	\N	\N	\N
3969	39	68	EMPTY	\N	\N	\N	\N	\N	\N
3970	39	69	RESOURCE	wood	2	\N	\N	\N	\N
3971	39	70	EMPTY	\N	\N	\N	\N	\N	\N
3972	39	71	EMPTY	\N	\N	\N	\N	\N	\N
3973	39	72	EMPTY	\N	\N	\N	\N	\N	\N
3974	39	73	EMPTY	\N	\N	\N	\N	\N	\N
3975	39	74	NPC	\N	\N	10	\N	Barbarian Camp (Lv 10)	\N
3976	39	75	EMPTY	\N	\N	\N	\N	\N	\N
3977	39	76	RESOURCE	wood	1	\N	\N	\N	\N
3978	39	77	EMPTY	\N	\N	\N	\N	\N	\N
3979	39	78	EMPTY	\N	\N	\N	\N	\N	\N
3980	39	79	EMPTY	\N	\N	\N	\N	\N	\N
3981	39	80	EMPTY	\N	\N	\N	\N	\N	\N
3982	39	81	EMPTY	\N	\N	\N	\N	\N	\N
3983	39	82	RESOURCE	stone	4	\N	\N	\N	\N
3984	39	83	EMPTY	\N	\N	\N	\N	\N	\N
3985	39	84	EMPTY	\N	\N	\N	\N	\N	\N
3986	39	85	EMPTY	\N	\N	\N	\N	\N	\N
3987	39	86	EMPTY	\N	\N	\N	\N	\N	\N
3988	39	87	EMPTY	\N	\N	\N	\N	\N	\N
3989	39	88	EMPTY	\N	\N	\N	\N	\N	\N
3990	39	89	EMPTY	\N	\N	\N	\N	\N	\N
3991	39	90	EMPTY	\N	\N	\N	\N	\N	\N
3992	39	91	EMPTY	\N	\N	\N	\N	\N	\N
3993	39	92	EMPTY	\N	\N	\N	\N	\N	\N
3994	39	93	EMPTY	\N	\N	\N	\N	\N	\N
3995	39	94	EMPTY	\N	\N	\N	\N	\N	\N
3996	39	95	EMPTY	\N	\N	\N	\N	\N	\N
3997	39	96	VALLEY	\N	\N	\N	\N	Valley (39, 96)	\N
3998	39	97	EMPTY	\N	\N	\N	\N	\N	\N
3999	39	98	RESOURCE	wood	2	\N	\N	\N	\N
4000	39	99	EMPTY	\N	\N	\N	\N	\N	\N
4001	40	0	EMPTY	\N	\N	\N	\N	\N	\N
4002	40	1	EMPTY	\N	\N	\N	\N	\N	\N
4003	40	2	EMPTY	\N	\N	\N	\N	\N	\N
4004	40	3	EMPTY	\N	\N	\N	\N	\N	\N
4005	40	4	EMPTY	\N	\N	\N	\N	\N	\N
4006	40	5	EMPTY	\N	\N	\N	\N	\N	\N
4007	40	6	EMPTY	\N	\N	\N	\N	\N	\N
4008	40	7	EMPTY	\N	\N	\N	\N	\N	\N
4009	40	8	EMPTY	\N	\N	\N	\N	\N	\N
4010	40	9	EMPTY	\N	\N	\N	\N	\N	\N
4011	40	10	EMPTY	\N	\N	\N	\N	\N	\N
4012	40	11	EMPTY	\N	\N	\N	\N	\N	\N
4013	40	12	RESOURCE	wood	3	\N	\N	\N	\N
4014	40	13	VALLEY	\N	\N	\N	\N	Valley (40, 13)	\N
4015	40	14	EMPTY	\N	\N	\N	\N	\N	\N
4016	40	15	EMPTY	\N	\N	\N	\N	\N	\N
4017	40	16	EMPTY	\N	\N	\N	\N	\N	\N
4018	40	17	EMPTY	\N	\N	\N	\N	\N	\N
4019	40	18	EMPTY	\N	\N	\N	\N	\N	\N
4020	40	19	EMPTY	\N	\N	\N	\N	\N	\N
4021	40	20	EMPTY	\N	\N	\N	\N	\N	\N
4022	40	21	EMPTY	\N	\N	\N	\N	\N	\N
4023	40	22	EMPTY	\N	\N	\N	\N	\N	\N
4024	40	23	EMPTY	\N	\N	\N	\N	\N	\N
4025	40	24	EMPTY	\N	\N	\N	\N	\N	\N
4026	40	25	RESOURCE	food	2	\N	\N	\N	\N
4027	40	26	EMPTY	\N	\N	\N	\N	\N	\N
4028	40	27	NPC	\N	\N	4	\N	Barbarian Camp (Lv 4)	\N
4029	40	28	EMPTY	\N	\N	\N	\N	\N	\N
4030	40	29	EMPTY	\N	\N	\N	\N	\N	\N
4031	40	30	EMPTY	\N	\N	\N	\N	\N	\N
4032	40	31	EMPTY	\N	\N	\N	\N	\N	\N
4033	40	32	EMPTY	\N	\N	\N	\N	\N	\N
4034	40	33	EMPTY	\N	\N	\N	\N	\N	\N
4035	40	34	EMPTY	\N	\N	\N	\N	\N	\N
4036	40	35	EMPTY	\N	\N	\N	\N	\N	\N
4037	40	36	EMPTY	\N	\N	\N	\N	\N	\N
4038	40	37	EMPTY	\N	\N	\N	\N	\N	\N
4039	40	38	EMPTY	\N	\N	\N	\N	\N	\N
4040	40	39	EMPTY	\N	\N	\N	\N	\N	\N
4041	40	40	NPC	\N	\N	4	\N	Barbarian Camp (Lv 4)	\N
4042	40	41	EMPTY	\N	\N	\N	\N	\N	\N
4043	40	42	EMPTY	\N	\N	\N	\N	\N	\N
4044	40	43	EMPTY	\N	\N	\N	\N	\N	\N
4045	40	44	EMPTY	\N	\N	\N	\N	\N	\N
4046	40	45	EMPTY	\N	\N	\N	\N	\N	\N
4047	40	46	EMPTY	\N	\N	\N	\N	\N	\N
4048	40	47	RESOURCE	food	5	\N	\N	\N	\N
4049	40	48	EMPTY	\N	\N	\N	\N	\N	\N
4050	40	49	EMPTY	\N	\N	\N	\N	\N	\N
4051	40	50	EMPTY	\N	\N	\N	\N	\N	\N
4052	40	51	EMPTY	\N	\N	\N	\N	\N	\N
4053	40	52	EMPTY	\N	\N	\N	\N	\N	\N
4054	40	53	NPC	\N	\N	5	\N	Barbarian Camp (Lv 5)	\N
4055	40	54	EMPTY	\N	\N	\N	\N	\N	\N
4056	40	55	EMPTY	\N	\N	\N	\N	\N	\N
4057	40	56	RESOURCE	stone	2	\N	\N	\N	\N
4058	40	57	EMPTY	\N	\N	\N	\N	\N	\N
4059	40	58	RESOURCE	wood	3	\N	\N	\N	\N
4060	40	59	EMPTY	\N	\N	\N	\N	\N	\N
4061	40	60	EMPTY	\N	\N	\N	\N	\N	\N
4062	40	61	EMPTY	\N	\N	\N	\N	\N	\N
4063	40	62	EMPTY	\N	\N	\N	\N	\N	\N
4064	40	63	EMPTY	\N	\N	\N	\N	\N	\N
4065	40	64	EMPTY	\N	\N	\N	\N	\N	\N
4066	40	65	EMPTY	\N	\N	\N	\N	\N	\N
4067	40	66	EMPTY	\N	\N	\N	\N	\N	\N
4068	40	67	EMPTY	\N	\N	\N	\N	\N	\N
4069	40	68	NPC	\N	\N	9	\N	Barbarian Camp (Lv 9)	\N
4070	40	69	RESOURCE	food	1	\N	\N	\N	\N
4071	40	70	EMPTY	\N	\N	\N	\N	\N	\N
4072	40	71	EMPTY	\N	\N	\N	\N	\N	\N
4073	40	72	RESOURCE	stone	4	\N	\N	\N	\N
4074	40	73	EMPTY	\N	\N	\N	\N	\N	\N
4075	40	74	EMPTY	\N	\N	\N	\N	\N	\N
4076	40	75	EMPTY	\N	\N	\N	\N	\N	\N
4077	40	76	EMPTY	\N	\N	\N	\N	\N	\N
4078	40	77	EMPTY	\N	\N	\N	\N	\N	\N
4079	40	78	EMPTY	\N	\N	\N	\N	\N	\N
4080	40	79	EMPTY	\N	\N	\N	\N	\N	\N
4081	40	80	VALLEY	\N	\N	\N	\N	Valley (40, 80)	\N
4082	40	81	EMPTY	\N	\N	\N	\N	\N	\N
4083	40	82	RESOURCE	food	2	\N	\N	\N	\N
4084	40	83	EMPTY	\N	\N	\N	\N	\N	\N
4085	40	84	EMPTY	\N	\N	\N	\N	\N	\N
4086	40	85	EMPTY	\N	\N	\N	\N	\N	\N
4087	40	86	EMPTY	\N	\N	\N	\N	\N	\N
4088	40	87	EMPTY	\N	\N	\N	\N	\N	\N
4089	40	88	NPC	\N	\N	5	\N	Barbarian Camp (Lv 5)	\N
4090	40	89	EMPTY	\N	\N	\N	\N	\N	\N
4091	40	90	EMPTY	\N	\N	\N	\N	\N	\N
4092	40	91	EMPTY	\N	\N	\N	\N	\N	\N
4093	40	92	VALLEY	\N	\N	\N	\N	Valley (40, 92)	\N
4094	40	93	EMPTY	\N	\N	\N	\N	\N	\N
4095	40	94	EMPTY	\N	\N	\N	\N	\N	\N
4096	40	95	EMPTY	\N	\N	\N	\N	\N	\N
4097	40	96	EMPTY	\N	\N	\N	\N	\N	\N
4098	40	97	EMPTY	\N	\N	\N	\N	\N	\N
4099	40	98	VALLEY	\N	\N	\N	\N	Valley (40, 98)	\N
4100	40	99	EMPTY	\N	\N	\N	\N	\N	\N
4101	41	0	EMPTY	\N	\N	\N	\N	\N	\N
4102	41	1	EMPTY	\N	\N	\N	\N	\N	\N
4103	41	2	EMPTY	\N	\N	\N	\N	\N	\N
4104	41	3	EMPTY	\N	\N	\N	\N	\N	\N
4105	41	4	EMPTY	\N	\N	\N	\N	\N	\N
4106	41	5	EMPTY	\N	\N	\N	\N	\N	\N
4107	41	6	EMPTY	\N	\N	\N	\N	\N	\N
4108	41	7	EMPTY	\N	\N	\N	\N	\N	\N
4109	41	8	EMPTY	\N	\N	\N	\N	\N	\N
4110	41	9	EMPTY	\N	\N	\N	\N	\N	\N
4111	41	10	EMPTY	\N	\N	\N	\N	\N	\N
4112	41	11	EMPTY	\N	\N	\N	\N	\N	\N
4113	41	12	NPC	\N	\N	5	\N	Barbarian Camp (Lv 5)	\N
4114	41	13	EMPTY	\N	\N	\N	\N	\N	\N
4115	41	14	EMPTY	\N	\N	\N	\N	\N	\N
4116	41	15	EMPTY	\N	\N	\N	\N	\N	\N
4117	41	16	EMPTY	\N	\N	\N	\N	\N	\N
4118	41	17	EMPTY	\N	\N	\N	\N	\N	\N
4119	41	18	VALLEY	\N	\N	\N	\N	Valley (41, 18)	\N
4120	41	19	RESOURCE	iron	3	\N	\N	\N	\N
4121	41	20	EMPTY	\N	\N	\N	\N	\N	\N
4122	41	21	EMPTY	\N	\N	\N	\N	\N	\N
4123	41	22	EMPTY	\N	\N	\N	\N	\N	\N
4124	41	23	EMPTY	\N	\N	\N	\N	\N	\N
4125	41	24	NPC	\N	\N	6	\N	Barbarian Camp (Lv 6)	\N
4126	41	25	EMPTY	\N	\N	\N	\N	\N	\N
4127	41	26	RESOURCE	stone	2	\N	\N	\N	\N
4128	41	27	RESOURCE	iron	2	\N	\N	\N	\N
4129	41	28	EMPTY	\N	\N	\N	\N	\N	\N
4130	41	29	RESOURCE	wood	5	\N	\N	\N	\N
4131	41	30	EMPTY	\N	\N	\N	\N	\N	\N
4132	41	31	NPC	\N	\N	4	\N	Barbarian Camp (Lv 4)	\N
4133	41	32	EMPTY	\N	\N	\N	\N	\N	\N
4134	41	33	EMPTY	\N	\N	\N	\N	\N	\N
4135	41	34	EMPTY	\N	\N	\N	\N	\N	\N
4136	41	35	EMPTY	\N	\N	\N	\N	\N	\N
4137	41	36	EMPTY	\N	\N	\N	\N	\N	\N
4138	41	37	EMPTY	\N	\N	\N	\N	\N	\N
4139	41	38	EMPTY	\N	\N	\N	\N	\N	\N
4140	41	39	NPC	\N	\N	3	\N	Barbarian Camp (Lv 3)	\N
4141	41	40	EMPTY	\N	\N	\N	\N	\N	\N
4142	41	41	EMPTY	\N	\N	\N	\N	\N	\N
4143	41	42	EMPTY	\N	\N	\N	\N	\N	\N
4144	41	43	NPC	\N	\N	3	\N	Barbarian Camp (Lv 3)	\N
4145	41	44	EMPTY	\N	\N	\N	\N	\N	\N
4146	41	45	EMPTY	\N	\N	\N	\N	\N	\N
4147	41	46	EMPTY	\N	\N	\N	\N	\N	\N
4148	41	47	EMPTY	\N	\N	\N	\N	\N	\N
4149	41	48	EMPTY	\N	\N	\N	\N	\N	\N
4150	41	49	EMPTY	\N	\N	\N	\N	\N	\N
4151	41	50	EMPTY	\N	\N	\N	\N	\N	\N
4152	41	51	EMPTY	\N	\N	\N	\N	\N	\N
4153	41	52	EMPTY	\N	\N	\N	\N	\N	\N
4154	41	53	EMPTY	\N	\N	\N	\N	\N	\N
4155	41	54	EMPTY	\N	\N	\N	\N	\N	\N
4156	41	55	EMPTY	\N	\N	\N	\N	\N	\N
4157	41	56	EMPTY	\N	\N	\N	\N	\N	\N
4158	41	57	EMPTY	\N	\N	\N	\N	\N	\N
4159	41	58	NPC	\N	\N	3	\N	Barbarian Camp (Lv 3)	\N
4160	41	59	EMPTY	\N	\N	\N	\N	\N	\N
4161	41	60	EMPTY	\N	\N	\N	\N	\N	\N
4162	41	61	EMPTY	\N	\N	\N	\N	\N	\N
4163	41	62	EMPTY	\N	\N	\N	\N	\N	\N
4164	41	63	EMPTY	\N	\N	\N	\N	\N	\N
4165	41	64	RESOURCE	stone	3	\N	\N	\N	\N
4166	41	65	NPC	\N	\N	3	\N	Barbarian Camp (Lv 3)	\N
4167	41	66	EMPTY	\N	\N	\N	\N	\N	\N
4168	41	67	NPC	\N	\N	2	\N	Barbarian Camp (Lv 2)	\N
4169	41	68	EMPTY	\N	\N	\N	\N	\N	\N
4170	41	69	EMPTY	\N	\N	\N	\N	\N	\N
4171	41	70	RESOURCE	wood	2	\N	\N	\N	\N
4172	41	71	NPC	\N	\N	3	\N	Barbarian Camp (Lv 3)	\N
4173	41	72	EMPTY	\N	\N	\N	\N	\N	\N
4174	41	73	EMPTY	\N	\N	\N	\N	\N	\N
4175	41	74	RESOURCE	wood	4	\N	\N	\N	\N
4176	41	75	EMPTY	\N	\N	\N	\N	\N	\N
4177	41	76	EMPTY	\N	\N	\N	\N	\N	\N
4178	41	77	EMPTY	\N	\N	\N	\N	\N	\N
4179	41	78	EMPTY	\N	\N	\N	\N	\N	\N
4180	41	79	EMPTY	\N	\N	\N	\N	\N	\N
4181	41	80	EMPTY	\N	\N	\N	\N	\N	\N
4182	41	81	EMPTY	\N	\N	\N	\N	\N	\N
4183	41	82	RESOURCE	wood	4	\N	\N	\N	\N
4184	41	83	EMPTY	\N	\N	\N	\N	\N	\N
4185	41	84	EMPTY	\N	\N	\N	\N	\N	\N
4186	41	85	EMPTY	\N	\N	\N	\N	\N	\N
4187	41	86	EMPTY	\N	\N	\N	\N	\N	\N
4188	41	87	RESOURCE	iron	1	\N	\N	\N	\N
4189	41	88	EMPTY	\N	\N	\N	\N	\N	\N
4190	41	89	EMPTY	\N	\N	\N	\N	\N	\N
4191	41	90	EMPTY	\N	\N	\N	\N	\N	\N
4192	41	91	NPC	\N	\N	1	\N	Barbarian Camp (Lv 1)	\N
4193	41	92	RESOURCE	stone	3	\N	\N	\N	\N
4194	41	93	EMPTY	\N	\N	\N	\N	\N	\N
4195	41	94	RESOURCE	stone	1	\N	\N	\N	\N
4196	41	95	EMPTY	\N	\N	\N	\N	\N	\N
4197	41	96	RESOURCE	food	3	\N	\N	\N	\N
4198	41	97	EMPTY	\N	\N	\N	\N	\N	\N
4199	41	98	VALLEY	\N	\N	\N	\N	Valley (41, 98)	\N
4200	41	99	EMPTY	\N	\N	\N	\N	\N	\N
4201	42	0	NPC	\N	\N	2	\N	Barbarian Camp (Lv 2)	\N
4202	42	1	EMPTY	\N	\N	\N	\N	\N	\N
4203	42	2	EMPTY	\N	\N	\N	\N	\N	\N
4204	42	3	EMPTY	\N	\N	\N	\N	\N	\N
4205	42	4	EMPTY	\N	\N	\N	\N	\N	\N
4206	42	5	EMPTY	\N	\N	\N	\N	\N	\N
4207	42	6	EMPTY	\N	\N	\N	\N	\N	\N
4208	42	7	EMPTY	\N	\N	\N	\N	\N	\N
4209	42	8	EMPTY	\N	\N	\N	\N	\N	\N
4210	42	9	NPC	\N	\N	6	\N	Barbarian Camp (Lv 6)	\N
4211	42	10	EMPTY	\N	\N	\N	\N	\N	\N
4212	42	11	EMPTY	\N	\N	\N	\N	\N	\N
4213	42	12	EMPTY	\N	\N	\N	\N	\N	\N
4214	42	13	RESOURCE	food	5	\N	\N	\N	\N
4215	42	14	EMPTY	\N	\N	\N	\N	\N	\N
4216	42	15	EMPTY	\N	\N	\N	\N	\N	\N
4217	42	16	EMPTY	\N	\N	\N	\N	\N	\N
4218	42	17	EMPTY	\N	\N	\N	\N	\N	\N
4219	42	18	EMPTY	\N	\N	\N	\N	\N	\N
4220	42	19	EMPTY	\N	\N	\N	\N	\N	\N
4221	42	20	EMPTY	\N	\N	\N	\N	\N	\N
4222	42	21	EMPTY	\N	\N	\N	\N	\N	\N
4223	42	22	EMPTY	\N	\N	\N	\N	\N	\N
4224	42	23	RESOURCE	iron	5	\N	\N	\N	\N
4225	42	24	EMPTY	\N	\N	\N	\N	\N	\N
4226	42	25	EMPTY	\N	\N	\N	\N	\N	\N
4227	42	26	EMPTY	\N	\N	\N	\N	\N	\N
4228	42	27	EMPTY	\N	\N	\N	\N	\N	\N
4229	42	28	EMPTY	\N	\N	\N	\N	\N	\N
4230	42	29	VALLEY	\N	\N	\N	\N	Valley (42, 29)	\N
4231	42	30	RESOURCE	iron	1	\N	\N	\N	\N
4232	42	31	NPC	\N	\N	10	\N	Barbarian Camp (Lv 10)	\N
4233	42	32	RESOURCE	wood	5	\N	\N	\N	\N
4234	42	33	EMPTY	\N	\N	\N	\N	\N	\N
4235	42	34	RESOURCE	wood	4	\N	\N	\N	\N
4236	42	35	EMPTY	\N	\N	\N	\N	\N	\N
4237	42	36	EMPTY	\N	\N	\N	\N	\N	\N
4238	42	37	EMPTY	\N	\N	\N	\N	\N	\N
4239	42	38	EMPTY	\N	\N	\N	\N	\N	\N
4240	42	39	EMPTY	\N	\N	\N	\N	\N	\N
4241	42	40	EMPTY	\N	\N	\N	\N	\N	\N
4242	42	41	EMPTY	\N	\N	\N	\N	\N	\N
4243	42	42	EMPTY	\N	\N	\N	\N	\N	\N
4244	42	43	EMPTY	\N	\N	\N	\N	\N	\N
4245	42	44	EMPTY	\N	\N	\N	\N	\N	\N
4246	42	45	EMPTY	\N	\N	\N	\N	\N	\N
4247	42	46	EMPTY	\N	\N	\N	\N	\N	\N
4248	42	47	EMPTY	\N	\N	\N	\N	\N	\N
4249	42	48	EMPTY	\N	\N	\N	\N	\N	\N
4250	42	49	EMPTY	\N	\N	\N	\N	\N	\N
4251	42	50	EMPTY	\N	\N	\N	\N	\N	\N
4252	42	51	EMPTY	\N	\N	\N	\N	\N	\N
4253	42	52	RESOURCE	food	5	\N	\N	\N	\N
4254	42	53	EMPTY	\N	\N	\N	\N	\N	\N
4255	42	54	EMPTY	\N	\N	\N	\N	\N	\N
4256	42	55	EMPTY	\N	\N	\N	\N	\N	\N
4257	42	56	RESOURCE	wood	4	\N	\N	\N	\N
4258	42	57	EMPTY	\N	\N	\N	\N	\N	\N
4259	42	58	RESOURCE	wood	5	\N	\N	\N	\N
4260	42	59	EMPTY	\N	\N	\N	\N	\N	\N
4261	42	60	EMPTY	\N	\N	\N	\N	\N	\N
4262	42	61	EMPTY	\N	\N	\N	\N	\N	\N
4263	42	62	EMPTY	\N	\N	\N	\N	\N	\N
4264	42	63	RESOURCE	stone	2	\N	\N	\N	\N
4265	42	64	EMPTY	\N	\N	\N	\N	\N	\N
4266	42	65	EMPTY	\N	\N	\N	\N	\N	\N
4267	42	66	EMPTY	\N	\N	\N	\N	\N	\N
4268	42	67	VALLEY	\N	\N	\N	\N	Valley (42, 67)	\N
4269	42	68	VALLEY	\N	\N	\N	\N	Valley (42, 68)	\N
4270	42	69	EMPTY	\N	\N	\N	\N	\N	\N
4271	42	70	NPC	\N	\N	2	\N	Barbarian Camp (Lv 2)	\N
4272	42	71	EMPTY	\N	\N	\N	\N	\N	\N
4273	42	72	EMPTY	\N	\N	\N	\N	\N	\N
4274	42	73	EMPTY	\N	\N	\N	\N	\N	\N
4275	42	74	EMPTY	\N	\N	\N	\N	\N	\N
4276	42	75	EMPTY	\N	\N	\N	\N	\N	\N
4277	42	76	EMPTY	\N	\N	\N	\N	\N	\N
4278	42	77	EMPTY	\N	\N	\N	\N	\N	\N
4279	42	78	EMPTY	\N	\N	\N	\N	\N	\N
4280	42	79	RESOURCE	food	4	\N	\N	\N	\N
4281	42	80	EMPTY	\N	\N	\N	\N	\N	\N
4282	42	81	EMPTY	\N	\N	\N	\N	\N	\N
4283	42	82	EMPTY	\N	\N	\N	\N	\N	\N
4284	42	83	EMPTY	\N	\N	\N	\N	\N	\N
4285	42	84	EMPTY	\N	\N	\N	\N	\N	\N
4286	42	85	EMPTY	\N	\N	\N	\N	\N	\N
4287	42	86	EMPTY	\N	\N	\N	\N	\N	\N
4288	42	87	EMPTY	\N	\N	\N	\N	\N	\N
4289	42	88	EMPTY	\N	\N	\N	\N	\N	\N
4290	42	89	RESOURCE	wood	4	\N	\N	\N	\N
4291	42	90	NPC	\N	\N	5	\N	Barbarian Camp (Lv 5)	\N
4292	42	91	EMPTY	\N	\N	\N	\N	\N	\N
4293	42	92	EMPTY	\N	\N	\N	\N	\N	\N
4294	42	93	EMPTY	\N	\N	\N	\N	\N	\N
4295	42	94	EMPTY	\N	\N	\N	\N	\N	\N
4296	42	95	EMPTY	\N	\N	\N	\N	\N	\N
4297	42	96	RESOURCE	stone	3	\N	\N	\N	\N
4298	42	97	EMPTY	\N	\N	\N	\N	\N	\N
4299	42	98	EMPTY	\N	\N	\N	\N	\N	\N
4300	42	99	EMPTY	\N	\N	\N	\N	\N	\N
4301	43	0	EMPTY	\N	\N	\N	\N	\N	\N
4302	43	1	EMPTY	\N	\N	\N	\N	\N	\N
4303	43	2	EMPTY	\N	\N	\N	\N	\N	\N
4304	43	3	EMPTY	\N	\N	\N	\N	\N	\N
4305	43	4	EMPTY	\N	\N	\N	\N	\N	\N
4306	43	5	NPC	\N	\N	5	\N	Barbarian Camp (Lv 5)	\N
4307	43	6	NPC	\N	\N	9	\N	Barbarian Camp (Lv 9)	\N
4308	43	7	EMPTY	\N	\N	\N	\N	\N	\N
4309	43	8	EMPTY	\N	\N	\N	\N	\N	\N
4310	43	9	EMPTY	\N	\N	\N	\N	\N	\N
4311	43	10	EMPTY	\N	\N	\N	\N	\N	\N
4312	43	11	EMPTY	\N	\N	\N	\N	\N	\N
4313	43	12	EMPTY	\N	\N	\N	\N	\N	\N
4314	43	13	RESOURCE	iron	2	\N	\N	\N	\N
4315	43	14	EMPTY	\N	\N	\N	\N	\N	\N
4316	43	15	EMPTY	\N	\N	\N	\N	\N	\N
4317	43	16	EMPTY	\N	\N	\N	\N	\N	\N
4318	43	17	EMPTY	\N	\N	\N	\N	\N	\N
4319	43	18	EMPTY	\N	\N	\N	\N	\N	\N
4320	43	19	EMPTY	\N	\N	\N	\N	\N	\N
4321	43	20	EMPTY	\N	\N	\N	\N	\N	\N
4322	43	21	EMPTY	\N	\N	\N	\N	\N	\N
4323	43	22	EMPTY	\N	\N	\N	\N	\N	\N
4324	43	23	EMPTY	\N	\N	\N	\N	\N	\N
4325	43	24	EMPTY	\N	\N	\N	\N	\N	\N
4326	43	25	RESOURCE	food	2	\N	\N	\N	\N
4327	43	26	EMPTY	\N	\N	\N	\N	\N	\N
4328	43	27	EMPTY	\N	\N	\N	\N	\N	\N
4329	43	28	VALLEY	\N	\N	\N	\N	Valley (43, 28)	\N
4330	43	29	RESOURCE	iron	3	\N	\N	\N	\N
4331	43	30	RESOURCE	stone	1	\N	\N	\N	\N
4332	43	31	EMPTY	\N	\N	\N	\N	\N	\N
4333	43	32	EMPTY	\N	\N	\N	\N	\N	\N
4334	43	33	EMPTY	\N	\N	\N	\N	\N	\N
4335	43	34	EMPTY	\N	\N	\N	\N	\N	\N
4336	43	35	EMPTY	\N	\N	\N	\N	\N	\N
4337	43	36	EMPTY	\N	\N	\N	\N	\N	\N
4338	43	37	EMPTY	\N	\N	\N	\N	\N	\N
4339	43	38	RESOURCE	stone	5	\N	\N	\N	\N
4340	43	39	EMPTY	\N	\N	\N	\N	\N	\N
4341	43	40	EMPTY	\N	\N	\N	\N	\N	\N
4342	43	41	EMPTY	\N	\N	\N	\N	\N	\N
4343	43	42	EMPTY	\N	\N	\N	\N	\N	\N
4344	43	43	EMPTY	\N	\N	\N	\N	\N	\N
4345	43	44	EMPTY	\N	\N	\N	\N	\N	\N
4346	43	45	EMPTY	\N	\N	\N	\N	\N	\N
4347	43	46	EMPTY	\N	\N	\N	\N	\N	\N
4348	43	47	EMPTY	\N	\N	\N	\N	\N	\N
4349	43	48	EMPTY	\N	\N	\N	\N	\N	\N
4350	43	49	NPC	\N	\N	10	\N	Barbarian Camp (Lv 10)	\N
4351	43	50	EMPTY	\N	\N	\N	\N	\N	\N
4352	43	51	EMPTY	\N	\N	\N	\N	\N	\N
4353	43	52	EMPTY	\N	\N	\N	\N	\N	\N
4354	43	53	EMPTY	\N	\N	\N	\N	\N	\N
4355	43	54	EMPTY	\N	\N	\N	\N	\N	\N
4356	43	55	EMPTY	\N	\N	\N	\N	\N	\N
4357	43	56	EMPTY	\N	\N	\N	\N	\N	\N
4358	43	57	RESOURCE	food	4	\N	\N	\N	\N
4359	43	58	RESOURCE	food	3	\N	\N	\N	\N
4360	43	59	EMPTY	\N	\N	\N	\N	\N	\N
4361	43	60	EMPTY	\N	\N	\N	\N	\N	\N
4362	43	61	EMPTY	\N	\N	\N	\N	\N	\N
4363	43	62	EMPTY	\N	\N	\N	\N	\N	\N
4364	43	63	RESOURCE	food	5	\N	\N	\N	\N
4365	43	64	EMPTY	\N	\N	\N	\N	\N	\N
4366	43	65	EMPTY	\N	\N	\N	\N	\N	\N
4367	43	66	EMPTY	\N	\N	\N	\N	\N	\N
4368	43	67	EMPTY	\N	\N	\N	\N	\N	\N
4369	43	68	EMPTY	\N	\N	\N	\N	\N	\N
4370	43	69	RESOURCE	food	3	\N	\N	\N	\N
4371	43	70	EMPTY	\N	\N	\N	\N	\N	\N
4372	43	71	EMPTY	\N	\N	\N	\N	\N	\N
4373	43	72	EMPTY	\N	\N	\N	\N	\N	\N
4374	43	73	EMPTY	\N	\N	\N	\N	\N	\N
4375	43	74	RESOURCE	food	2	\N	\N	\N	\N
4376	43	75	EMPTY	\N	\N	\N	\N	\N	\N
4377	43	76	EMPTY	\N	\N	\N	\N	\N	\N
4378	43	77	EMPTY	\N	\N	\N	\N	\N	\N
4379	43	78	EMPTY	\N	\N	\N	\N	\N	\N
4380	43	79	EMPTY	\N	\N	\N	\N	\N	\N
4381	43	80	EMPTY	\N	\N	\N	\N	\N	\N
4382	43	81	RESOURCE	wood	1	\N	\N	\N	\N
4383	43	82	EMPTY	\N	\N	\N	\N	\N	\N
4384	43	83	EMPTY	\N	\N	\N	\N	\N	\N
4385	43	84	EMPTY	\N	\N	\N	\N	\N	\N
4386	43	85	EMPTY	\N	\N	\N	\N	\N	\N
4387	43	86	EMPTY	\N	\N	\N	\N	\N	\N
4388	43	87	EMPTY	\N	\N	\N	\N	\N	\N
4389	43	88	EMPTY	\N	\N	\N	\N	\N	\N
4390	43	89	EMPTY	\N	\N	\N	\N	\N	\N
4391	43	90	EMPTY	\N	\N	\N	\N	\N	\N
4392	43	91	RESOURCE	wood	2	\N	\N	\N	\N
4393	43	92	EMPTY	\N	\N	\N	\N	\N	\N
4394	43	93	EMPTY	\N	\N	\N	\N	\N	\N
4395	43	94	EMPTY	\N	\N	\N	\N	\N	\N
4396	43	95	EMPTY	\N	\N	\N	\N	\N	\N
4397	43	96	EMPTY	\N	\N	\N	\N	\N	\N
4398	43	97	EMPTY	\N	\N	\N	\N	\N	\N
4399	43	98	VALLEY	\N	\N	\N	\N	Valley (43, 98)	\N
4400	43	99	EMPTY	\N	\N	\N	\N	\N	\N
4401	44	0	NPC	\N	\N	5	\N	Barbarian Camp (Lv 5)	\N
4402	44	1	EMPTY	\N	\N	\N	\N	\N	\N
4403	44	2	EMPTY	\N	\N	\N	\N	\N	\N
4404	44	3	RESOURCE	iron	1	\N	\N	\N	\N
4405	44	4	EMPTY	\N	\N	\N	\N	\N	\N
4406	44	5	EMPTY	\N	\N	\N	\N	\N	\N
4407	44	6	EMPTY	\N	\N	\N	\N	\N	\N
4408	44	7	RESOURCE	wood	5	\N	\N	\N	\N
4409	44	8	EMPTY	\N	\N	\N	\N	\N	\N
4410	44	9	EMPTY	\N	\N	\N	\N	\N	\N
4411	44	10	EMPTY	\N	\N	\N	\N	\N	\N
4412	44	11	EMPTY	\N	\N	\N	\N	\N	\N
4413	44	12	RESOURCE	food	4	\N	\N	\N	\N
4414	44	13	EMPTY	\N	\N	\N	\N	\N	\N
4415	44	14	EMPTY	\N	\N	\N	\N	\N	\N
4416	44	15	EMPTY	\N	\N	\N	\N	\N	\N
4417	44	16	EMPTY	\N	\N	\N	\N	\N	\N
4418	44	17	EMPTY	\N	\N	\N	\N	\N	\N
4419	44	18	EMPTY	\N	\N	\N	\N	\N	\N
4420	44	19	EMPTY	\N	\N	\N	\N	\N	\N
4421	44	20	EMPTY	\N	\N	\N	\N	\N	\N
4422	44	21	EMPTY	\N	\N	\N	\N	\N	\N
4423	44	22	EMPTY	\N	\N	\N	\N	\N	\N
4424	44	23	EMPTY	\N	\N	\N	\N	\N	\N
4425	44	24	EMPTY	\N	\N	\N	\N	\N	\N
4426	44	25	EMPTY	\N	\N	\N	\N	\N	\N
4427	44	26	EMPTY	\N	\N	\N	\N	\N	\N
4428	44	27	EMPTY	\N	\N	\N	\N	\N	\N
4429	44	28	EMPTY	\N	\N	\N	\N	\N	\N
4430	44	29	EMPTY	\N	\N	\N	\N	\N	\N
4431	44	30	RESOURCE	iron	1	\N	\N	\N	\N
4432	44	31	EMPTY	\N	\N	\N	\N	\N	\N
4433	44	32	EMPTY	\N	\N	\N	\N	\N	\N
4434	44	33	EMPTY	\N	\N	\N	\N	\N	\N
4435	44	34	EMPTY	\N	\N	\N	\N	\N	\N
4436	44	35	RESOURCE	food	3	\N	\N	\N	\N
4437	44	36	EMPTY	\N	\N	\N	\N	\N	\N
4438	44	37	NPC	\N	\N	4	\N	Barbarian Camp (Lv 4)	\N
4439	44	38	EMPTY	\N	\N	\N	\N	\N	\N
4440	44	39	EMPTY	\N	\N	\N	\N	\N	\N
4441	44	40	EMPTY	\N	\N	\N	\N	\N	\N
4442	44	41	EMPTY	\N	\N	\N	\N	\N	\N
4443	44	42	EMPTY	\N	\N	\N	\N	\N	\N
4444	44	43	EMPTY	\N	\N	\N	\N	\N	\N
4445	44	44	EMPTY	\N	\N	\N	\N	\N	\N
4446	44	45	EMPTY	\N	\N	\N	\N	\N	\N
4447	44	46	EMPTY	\N	\N	\N	\N	\N	\N
4448	44	47	EMPTY	\N	\N	\N	\N	\N	\N
4449	44	48	EMPTY	\N	\N	\N	\N	\N	\N
4450	44	49	EMPTY	\N	\N	\N	\N	\N	\N
4451	44	50	EMPTY	\N	\N	\N	\N	\N	\N
4452	44	51	EMPTY	\N	\N	\N	\N	\N	\N
4453	44	52	EMPTY	\N	\N	\N	\N	\N	\N
4454	44	53	EMPTY	\N	\N	\N	\N	\N	\N
4455	44	54	EMPTY	\N	\N	\N	\N	\N	\N
4456	44	55	EMPTY	\N	\N	\N	\N	\N	\N
4457	44	56	EMPTY	\N	\N	\N	\N	\N	\N
4458	44	57	EMPTY	\N	\N	\N	\N	\N	\N
4459	44	58	EMPTY	\N	\N	\N	\N	\N	\N
4460	44	59	EMPTY	\N	\N	\N	\N	\N	\N
4461	44	60	EMPTY	\N	\N	\N	\N	\N	\N
4462	44	61	VALLEY	\N	\N	\N	\N	Valley (44, 61)	\N
4463	44	62	EMPTY	\N	\N	\N	\N	\N	\N
4464	44	63	EMPTY	\N	\N	\N	\N	\N	\N
4465	44	64	EMPTY	\N	\N	\N	\N	\N	\N
4466	44	65	EMPTY	\N	\N	\N	\N	\N	\N
4467	44	66	NPC	\N	\N	5	\N	Barbarian Camp (Lv 5)	\N
4468	44	67	EMPTY	\N	\N	\N	\N	\N	\N
4469	44	68	EMPTY	\N	\N	\N	\N	\N	\N
4470	44	69	EMPTY	\N	\N	\N	\N	\N	\N
4471	44	70	NPC	\N	\N	4	\N	Barbarian Camp (Lv 4)	\N
4472	44	71	EMPTY	\N	\N	\N	\N	\N	\N
4473	44	72	EMPTY	\N	\N	\N	\N	\N	\N
4474	44	73	EMPTY	\N	\N	\N	\N	\N	\N
4475	44	74	EMPTY	\N	\N	\N	\N	\N	\N
4476	44	75	EMPTY	\N	\N	\N	\N	\N	\N
4477	44	76	EMPTY	\N	\N	\N	\N	\N	\N
4478	44	77	RESOURCE	wood	1	\N	\N	\N	\N
4479	44	78	NPC	\N	\N	4	\N	Barbarian Camp (Lv 4)	\N
4480	44	79	EMPTY	\N	\N	\N	\N	\N	\N
4481	44	80	VALLEY	\N	\N	\N	\N	Valley (44, 80)	\N
4482	44	81	EMPTY	\N	\N	\N	\N	\N	\N
4483	44	82	EMPTY	\N	\N	\N	\N	\N	\N
4484	44	83	EMPTY	\N	\N	\N	\N	\N	\N
4485	44	84	EMPTY	\N	\N	\N	\N	\N	\N
4486	44	85	EMPTY	\N	\N	\N	\N	\N	\N
4487	44	86	EMPTY	\N	\N	\N	\N	\N	\N
4488	44	87	NPC	\N	\N	2	\N	Barbarian Camp (Lv 2)	\N
4489	44	88	EMPTY	\N	\N	\N	\N	\N	\N
4490	44	89	EMPTY	\N	\N	\N	\N	\N	\N
4491	44	90	EMPTY	\N	\N	\N	\N	\N	\N
4492	44	91	EMPTY	\N	\N	\N	\N	\N	\N
4493	44	92	EMPTY	\N	\N	\N	\N	\N	\N
4494	44	93	EMPTY	\N	\N	\N	\N	\N	\N
4495	44	94	EMPTY	\N	\N	\N	\N	\N	\N
4496	44	95	EMPTY	\N	\N	\N	\N	\N	\N
4497	44	96	EMPTY	\N	\N	\N	\N	\N	\N
4498	44	97	EMPTY	\N	\N	\N	\N	\N	\N
4499	44	98	EMPTY	\N	\N	\N	\N	\N	\N
4500	44	99	EMPTY	\N	\N	\N	\N	\N	\N
4501	45	0	EMPTY	\N	\N	\N	\N	\N	\N
4502	45	1	EMPTY	\N	\N	\N	\N	\N	\N
4503	45	2	EMPTY	\N	\N	\N	\N	\N	\N
4504	45	3	EMPTY	\N	\N	\N	\N	\N	\N
4505	45	4	EMPTY	\N	\N	\N	\N	\N	\N
4506	45	5	EMPTY	\N	\N	\N	\N	\N	\N
4507	45	6	EMPTY	\N	\N	\N	\N	\N	\N
4508	45	7	EMPTY	\N	\N	\N	\N	\N	\N
4509	45	8	EMPTY	\N	\N	\N	\N	\N	\N
4510	45	9	EMPTY	\N	\N	\N	\N	\N	\N
4511	45	10	EMPTY	\N	\N	\N	\N	\N	\N
4512	45	11	EMPTY	\N	\N	\N	\N	\N	\N
4513	45	12	RESOURCE	iron	1	\N	\N	\N	\N
4514	45	13	EMPTY	\N	\N	\N	\N	\N	\N
4515	45	14	EMPTY	\N	\N	\N	\N	\N	\N
4516	45	15	RESOURCE	wood	4	\N	\N	\N	\N
4517	45	16	EMPTY	\N	\N	\N	\N	\N	\N
4518	45	17	EMPTY	\N	\N	\N	\N	\N	\N
4519	45	18	EMPTY	\N	\N	\N	\N	\N	\N
4520	45	19	NPC	\N	\N	6	\N	Barbarian Camp (Lv 6)	\N
4521	45	20	EMPTY	\N	\N	\N	\N	\N	\N
4522	45	21	EMPTY	\N	\N	\N	\N	\N	\N
4523	45	22	EMPTY	\N	\N	\N	\N	\N	\N
4524	45	23	EMPTY	\N	\N	\N	\N	\N	\N
4525	45	24	RESOURCE	wood	3	\N	\N	\N	\N
4526	45	25	EMPTY	\N	\N	\N	\N	\N	\N
4527	45	26	VALLEY	\N	\N	\N	\N	Valley (45, 26)	\N
4528	45	27	VALLEY	\N	\N	\N	\N	Valley (45, 27)	\N
4529	45	28	EMPTY	\N	\N	\N	\N	\N	\N
4530	45	29	EMPTY	\N	\N	\N	\N	\N	\N
4531	45	30	EMPTY	\N	\N	\N	\N	\N	\N
4532	45	31	EMPTY	\N	\N	\N	\N	\N	\N
4533	45	32	EMPTY	\N	\N	\N	\N	\N	\N
4534	45	33	EMPTY	\N	\N	\N	\N	\N	\N
4535	45	34	EMPTY	\N	\N	\N	\N	\N	\N
4536	45	35	EMPTY	\N	\N	\N	\N	\N	\N
4537	45	36	EMPTY	\N	\N	\N	\N	\N	\N
4538	45	37	EMPTY	\N	\N	\N	\N	\N	\N
4539	45	38	EMPTY	\N	\N	\N	\N	\N	\N
4540	45	39	EMPTY	\N	\N	\N	\N	\N	\N
4541	45	40	EMPTY	\N	\N	\N	\N	\N	\N
4542	45	41	EMPTY	\N	\N	\N	\N	\N	\N
4543	45	42	EMPTY	\N	\N	\N	\N	\N	\N
4544	45	43	EMPTY	\N	\N	\N	\N	\N	\N
4545	45	44	EMPTY	\N	\N	\N	\N	\N	\N
4546	45	45	EMPTY	\N	\N	\N	\N	\N	\N
4547	45	46	EMPTY	\N	\N	\N	\N	\N	\N
4548	45	47	EMPTY	\N	\N	\N	\N	\N	\N
4549	45	48	EMPTY	\N	\N	\N	\N	\N	\N
4550	45	49	VALLEY	\N	\N	\N	\N	Valley (45, 49)	\N
4551	45	50	EMPTY	\N	\N	\N	\N	\N	\N
4552	45	51	EMPTY	\N	\N	\N	\N	\N	\N
4553	45	52	NPC	\N	\N	6	\N	Barbarian Camp (Lv 6)	\N
4554	45	53	EMPTY	\N	\N	\N	\N	\N	\N
4555	45	54	EMPTY	\N	\N	\N	\N	\N	\N
4556	45	55	EMPTY	\N	\N	\N	\N	\N	\N
4557	45	56	EMPTY	\N	\N	\N	\N	\N	\N
4558	45	57	EMPTY	\N	\N	\N	\N	\N	\N
4559	45	58	EMPTY	\N	\N	\N	\N	\N	\N
4560	45	59	EMPTY	\N	\N	\N	\N	\N	\N
4561	45	60	EMPTY	\N	\N	\N	\N	\N	\N
4562	45	61	EMPTY	\N	\N	\N	\N	\N	\N
4563	45	62	EMPTY	\N	\N	\N	\N	\N	\N
4564	45	63	EMPTY	\N	\N	\N	\N	\N	\N
4565	45	64	EMPTY	\N	\N	\N	\N	\N	\N
4566	45	65	EMPTY	\N	\N	\N	\N	\N	\N
4567	45	66	EMPTY	\N	\N	\N	\N	\N	\N
4568	45	67	EMPTY	\N	\N	\N	\N	\N	\N
4569	45	68	EMPTY	\N	\N	\N	\N	\N	\N
4570	45	69	EMPTY	\N	\N	\N	\N	\N	\N
4571	45	70	EMPTY	\N	\N	\N	\N	\N	\N
4572	45	71	EMPTY	\N	\N	\N	\N	\N	\N
4573	45	72	EMPTY	\N	\N	\N	\N	\N	\N
4574	45	73	EMPTY	\N	\N	\N	\N	\N	\N
4575	45	74	EMPTY	\N	\N	\N	\N	\N	\N
4576	45	75	RESOURCE	wood	1	\N	\N	\N	\N
4577	45	76	EMPTY	\N	\N	\N	\N	\N	\N
4578	45	77	EMPTY	\N	\N	\N	\N	\N	\N
4579	45	78	EMPTY	\N	\N	\N	\N	\N	\N
4580	45	79	EMPTY	\N	\N	\N	\N	\N	\N
4581	45	80	EMPTY	\N	\N	\N	\N	\N	\N
4582	45	81	EMPTY	\N	\N	\N	\N	\N	\N
4583	45	82	EMPTY	\N	\N	\N	\N	\N	\N
4584	45	83	EMPTY	\N	\N	\N	\N	\N	\N
4585	45	84	RESOURCE	stone	1	\N	\N	\N	\N
4586	45	85	EMPTY	\N	\N	\N	\N	\N	\N
4587	45	86	EMPTY	\N	\N	\N	\N	\N	\N
4588	45	87	EMPTY	\N	\N	\N	\N	\N	\N
4589	45	88	VALLEY	\N	\N	\N	\N	Valley (45, 88)	\N
4590	45	89	EMPTY	\N	\N	\N	\N	\N	\N
4591	45	90	EMPTY	\N	\N	\N	\N	\N	\N
4592	45	91	RESOURCE	iron	1	\N	\N	\N	\N
4593	45	92	EMPTY	\N	\N	\N	\N	\N	\N
4594	45	93	EMPTY	\N	\N	\N	\N	\N	\N
4595	45	94	EMPTY	\N	\N	\N	\N	\N	\N
4596	45	95	RESOURCE	iron	2	\N	\N	\N	\N
4597	45	96	EMPTY	\N	\N	\N	\N	\N	\N
4598	45	97	EMPTY	\N	\N	\N	\N	\N	\N
4599	45	98	EMPTY	\N	\N	\N	\N	\N	\N
4600	45	99	EMPTY	\N	\N	\N	\N	\N	\N
4601	46	0	EMPTY	\N	\N	\N	\N	\N	\N
4602	46	1	EMPTY	\N	\N	\N	\N	\N	\N
4603	46	2	EMPTY	\N	\N	\N	\N	\N	\N
4604	46	3	EMPTY	\N	\N	\N	\N	\N	\N
4605	46	4	EMPTY	\N	\N	\N	\N	\N	\N
4606	46	5	EMPTY	\N	\N	\N	\N	\N	\N
4607	46	6	EMPTY	\N	\N	\N	\N	\N	\N
4608	46	7	EMPTY	\N	\N	\N	\N	\N	\N
4609	46	8	EMPTY	\N	\N	\N	\N	\N	\N
4610	46	9	RESOURCE	stone	4	\N	\N	\N	\N
4611	46	10	EMPTY	\N	\N	\N	\N	\N	\N
4612	46	11	EMPTY	\N	\N	\N	\N	\N	\N
4613	46	12	EMPTY	\N	\N	\N	\N	\N	\N
4614	46	13	EMPTY	\N	\N	\N	\N	\N	\N
4615	46	14	EMPTY	\N	\N	\N	\N	\N	\N
4616	46	15	EMPTY	\N	\N	\N	\N	\N	\N
4617	46	16	EMPTY	\N	\N	\N	\N	\N	\N
4618	46	17	EMPTY	\N	\N	\N	\N	\N	\N
4619	46	18	EMPTY	\N	\N	\N	\N	\N	\N
4620	46	19	EMPTY	\N	\N	\N	\N	\N	\N
4621	46	20	NPC	\N	\N	2	\N	Barbarian Camp (Lv 2)	\N
4622	46	21	EMPTY	\N	\N	\N	\N	\N	\N
4623	46	22	EMPTY	\N	\N	\N	\N	\N	\N
4624	46	23	EMPTY	\N	\N	\N	\N	\N	\N
4625	46	24	EMPTY	\N	\N	\N	\N	\N	\N
4626	46	25	NPC	\N	\N	6	\N	Barbarian Camp (Lv 6)	\N
4627	46	26	EMPTY	\N	\N	\N	\N	\N	\N
4628	46	27	EMPTY	\N	\N	\N	\N	\N	\N
4629	46	28	EMPTY	\N	\N	\N	\N	\N	\N
4630	46	29	EMPTY	\N	\N	\N	\N	\N	\N
4631	46	30	EMPTY	\N	\N	\N	\N	\N	\N
4632	46	31	EMPTY	\N	\N	\N	\N	\N	\N
4633	46	32	EMPTY	\N	\N	\N	\N	\N	\N
4634	46	33	EMPTY	\N	\N	\N	\N	\N	\N
4635	46	34	EMPTY	\N	\N	\N	\N	\N	\N
4636	46	35	EMPTY	\N	\N	\N	\N	\N	\N
4637	46	36	EMPTY	\N	\N	\N	\N	\N	\N
4638	46	37	EMPTY	\N	\N	\N	\N	\N	\N
4639	46	38	EMPTY	\N	\N	\N	\N	\N	\N
4640	46	39	EMPTY	\N	\N	\N	\N	\N	\N
4641	46	40	EMPTY	\N	\N	\N	\N	\N	\N
4642	46	41	EMPTY	\N	\N	\N	\N	\N	\N
4643	46	42	EMPTY	\N	\N	\N	\N	\N	\N
4644	46	43	EMPTY	\N	\N	\N	\N	\N	\N
4645	46	44	EMPTY	\N	\N	\N	\N	\N	\N
4646	46	45	EMPTY	\N	\N	\N	\N	\N	\N
4647	46	46	RESOURCE	iron	3	\N	\N	\N	\N
4648	46	47	EMPTY	\N	\N	\N	\N	\N	\N
4649	46	48	EMPTY	\N	\N	\N	\N	\N	\N
4650	46	49	EMPTY	\N	\N	\N	\N	\N	\N
4651	46	50	RESOURCE	food	1	\N	\N	\N	\N
4652	46	51	EMPTY	\N	\N	\N	\N	\N	\N
4653	46	52	NPC	\N	\N	7	\N	Barbarian Camp (Lv 7)	\N
4654	46	53	EMPTY	\N	\N	\N	\N	\N	\N
4655	46	54	EMPTY	\N	\N	\N	\N	\N	\N
4656	46	55	EMPTY	\N	\N	\N	\N	\N	\N
4657	46	56	EMPTY	\N	\N	\N	\N	\N	\N
4658	46	57	EMPTY	\N	\N	\N	\N	\N	\N
4659	46	58	EMPTY	\N	\N	\N	\N	\N	\N
4660	46	59	EMPTY	\N	\N	\N	\N	\N	\N
4661	46	60	EMPTY	\N	\N	\N	\N	\N	\N
4662	46	61	NPC	\N	\N	3	\N	Barbarian Camp (Lv 3)	\N
4663	46	62	EMPTY	\N	\N	\N	\N	\N	\N
4664	46	63	EMPTY	\N	\N	\N	\N	\N	\N
4665	46	64	EMPTY	\N	\N	\N	\N	\N	\N
4666	46	65	RESOURCE	food	1	\N	\N	\N	\N
4667	46	66	EMPTY	\N	\N	\N	\N	\N	\N
4668	46	67	EMPTY	\N	\N	\N	\N	\N	\N
4669	46	68	EMPTY	\N	\N	\N	\N	\N	\N
4670	46	69	EMPTY	\N	\N	\N	\N	\N	\N
4671	46	70	VALLEY	\N	\N	\N	\N	Valley (46, 70)	\N
4672	46	71	EMPTY	\N	\N	\N	\N	\N	\N
4673	46	72	EMPTY	\N	\N	\N	\N	\N	\N
4674	46	73	EMPTY	\N	\N	\N	\N	\N	\N
4675	46	74	RESOURCE	stone	5	\N	\N	\N	\N
4676	46	75	EMPTY	\N	\N	\N	\N	\N	\N
4677	46	76	EMPTY	\N	\N	\N	\N	\N	\N
4678	46	77	RESOURCE	stone	2	\N	\N	\N	\N
4679	46	78	EMPTY	\N	\N	\N	\N	\N	\N
4680	46	79	RESOURCE	wood	5	\N	\N	\N	\N
4681	46	80	EMPTY	\N	\N	\N	\N	\N	\N
4682	46	81	EMPTY	\N	\N	\N	\N	\N	\N
4683	46	82	NPC	\N	\N	2	\N	Barbarian Camp (Lv 2)	\N
4684	46	83	EMPTY	\N	\N	\N	\N	\N	\N
4685	46	84	EMPTY	\N	\N	\N	\N	\N	\N
4686	46	85	RESOURCE	wood	2	\N	\N	\N	\N
4687	46	86	EMPTY	\N	\N	\N	\N	\N	\N
4688	46	87	EMPTY	\N	\N	\N	\N	\N	\N
4689	46	88	EMPTY	\N	\N	\N	\N	\N	\N
4690	46	89	EMPTY	\N	\N	\N	\N	\N	\N
4691	46	90	EMPTY	\N	\N	\N	\N	\N	\N
4692	46	91	EMPTY	\N	\N	\N	\N	\N	\N
4693	46	92	EMPTY	\N	\N	\N	\N	\N	\N
4694	46	93	EMPTY	\N	\N	\N	\N	\N	\N
4695	46	94	EMPTY	\N	\N	\N	\N	\N	\N
4696	46	95	EMPTY	\N	\N	\N	\N	\N	\N
4697	46	96	EMPTY	\N	\N	\N	\N	\N	\N
4698	46	97	EMPTY	\N	\N	\N	\N	\N	\N
4699	46	98	EMPTY	\N	\N	\N	\N	\N	\N
4700	46	99	EMPTY	\N	\N	\N	\N	\N	\N
4701	47	0	RESOURCE	iron	5	\N	\N	\N	\N
4702	47	1	EMPTY	\N	\N	\N	\N	\N	\N
4703	47	2	EMPTY	\N	\N	\N	\N	\N	\N
4704	47	3	EMPTY	\N	\N	\N	\N	\N	\N
4705	47	4	EMPTY	\N	\N	\N	\N	\N	\N
4706	47	5	EMPTY	\N	\N	\N	\N	\N	\N
4707	47	6	EMPTY	\N	\N	\N	\N	\N	\N
4708	47	7	EMPTY	\N	\N	\N	\N	\N	\N
4709	47	8	EMPTY	\N	\N	\N	\N	\N	\N
4710	47	9	EMPTY	\N	\N	\N	\N	\N	\N
4711	47	10	EMPTY	\N	\N	\N	\N	\N	\N
4712	47	11	EMPTY	\N	\N	\N	\N	\N	\N
4713	47	12	EMPTY	\N	\N	\N	\N	\N	\N
4714	47	13	EMPTY	\N	\N	\N	\N	\N	\N
4715	47	14	EMPTY	\N	\N	\N	\N	\N	\N
4716	47	15	EMPTY	\N	\N	\N	\N	\N	\N
4717	47	16	EMPTY	\N	\N	\N	\N	\N	\N
4718	47	17	EMPTY	\N	\N	\N	\N	\N	\N
4719	47	18	EMPTY	\N	\N	\N	\N	\N	\N
4720	47	19	EMPTY	\N	\N	\N	\N	\N	\N
4721	47	20	EMPTY	\N	\N	\N	\N	\N	\N
4722	47	21	EMPTY	\N	\N	\N	\N	\N	\N
4723	47	22	EMPTY	\N	\N	\N	\N	\N	\N
4724	47	23	RESOURCE	wood	5	\N	\N	\N	\N
4725	47	24	EMPTY	\N	\N	\N	\N	\N	\N
4726	47	25	EMPTY	\N	\N	\N	\N	\N	\N
4727	47	26	EMPTY	\N	\N	\N	\N	\N	\N
4728	47	27	EMPTY	\N	\N	\N	\N	\N	\N
4729	47	28	EMPTY	\N	\N	\N	\N	\N	\N
4730	47	29	NPC	\N	\N	8	\N	Barbarian Camp (Lv 8)	\N
4731	47	30	EMPTY	\N	\N	\N	\N	\N	\N
4732	47	31	EMPTY	\N	\N	\N	\N	\N	\N
4733	47	32	EMPTY	\N	\N	\N	\N	\N	\N
4734	47	33	RESOURCE	stone	3	\N	\N	\N	\N
4735	47	34	EMPTY	\N	\N	\N	\N	\N	\N
4736	47	35	NPC	\N	\N	4	\N	Barbarian Camp (Lv 4)	\N
4737	47	36	RESOURCE	iron	1	\N	\N	\N	\N
4738	47	37	EMPTY	\N	\N	\N	\N	\N	\N
4739	47	38	EMPTY	\N	\N	\N	\N	\N	\N
4740	47	39	NPC	\N	\N	10	\N	Barbarian Camp (Lv 10)	\N
4741	47	40	EMPTY	\N	\N	\N	\N	\N	\N
4742	47	41	EMPTY	\N	\N	\N	\N	\N	\N
4743	47	42	EMPTY	\N	\N	\N	\N	\N	\N
4744	47	43	EMPTY	\N	\N	\N	\N	\N	\N
4745	47	44	EMPTY	\N	\N	\N	\N	\N	\N
4746	47	45	VALLEY	\N	\N	\N	\N	Valley (47, 45)	\N
4747	47	46	EMPTY	\N	\N	\N	\N	\N	\N
4748	47	47	EMPTY	\N	\N	\N	\N	\N	\N
4749	47	48	EMPTY	\N	\N	\N	\N	\N	\N
4750	47	49	NPC	\N	\N	1	\N	Barbarian Camp (Lv 1)	\N
4751	47	50	EMPTY	\N	\N	\N	\N	\N	\N
4752	47	51	RESOURCE	wood	4	\N	\N	\N	\N
4753	47	52	EMPTY	\N	\N	\N	\N	\N	\N
4754	47	53	EMPTY	\N	\N	\N	\N	\N	\N
4755	47	54	EMPTY	\N	\N	\N	\N	\N	\N
4756	47	55	EMPTY	\N	\N	\N	\N	\N	\N
4757	47	56	EMPTY	\N	\N	\N	\N	\N	\N
4758	47	57	VALLEY	\N	\N	\N	\N	Valley (47, 57)	\N
4759	47	58	EMPTY	\N	\N	\N	\N	\N	\N
4760	47	59	EMPTY	\N	\N	\N	\N	\N	\N
4761	47	60	EMPTY	\N	\N	\N	\N	\N	\N
4762	47	61	EMPTY	\N	\N	\N	\N	\N	\N
4763	47	62	EMPTY	\N	\N	\N	\N	\N	\N
4764	47	63	EMPTY	\N	\N	\N	\N	\N	\N
4765	47	64	EMPTY	\N	\N	\N	\N	\N	\N
4766	47	65	NPC	\N	\N	8	\N	Barbarian Camp (Lv 8)	\N
4767	47	66	EMPTY	\N	\N	\N	\N	\N	\N
4768	47	67	EMPTY	\N	\N	\N	\N	\N	\N
4769	47	68	NPC	\N	\N	6	\N	Barbarian Camp (Lv 6)	\N
4770	47	69	EMPTY	\N	\N	\N	\N	\N	\N
4771	47	70	EMPTY	\N	\N	\N	\N	\N	\N
4772	47	71	EMPTY	\N	\N	\N	\N	\N	\N
4773	47	72	EMPTY	\N	\N	\N	\N	\N	\N
4774	47	73	EMPTY	\N	\N	\N	\N	\N	\N
4775	47	74	EMPTY	\N	\N	\N	\N	\N	\N
4776	47	75	EMPTY	\N	\N	\N	\N	\N	\N
4777	47	76	EMPTY	\N	\N	\N	\N	\N	\N
4778	47	77	EMPTY	\N	\N	\N	\N	\N	\N
4779	47	78	EMPTY	\N	\N	\N	\N	\N	\N
4780	47	79	EMPTY	\N	\N	\N	\N	\N	\N
4781	47	80	EMPTY	\N	\N	\N	\N	\N	\N
4782	47	81	EMPTY	\N	\N	\N	\N	\N	\N
4783	47	82	RESOURCE	stone	1	\N	\N	\N	\N
4784	47	83	EMPTY	\N	\N	\N	\N	\N	\N
4785	47	84	EMPTY	\N	\N	\N	\N	\N	\N
4786	47	85	RESOURCE	stone	4	\N	\N	\N	\N
4787	47	86	EMPTY	\N	\N	\N	\N	\N	\N
4788	47	87	EMPTY	\N	\N	\N	\N	\N	\N
4789	47	88	EMPTY	\N	\N	\N	\N	\N	\N
4790	47	89	EMPTY	\N	\N	\N	\N	\N	\N
4791	47	90	EMPTY	\N	\N	\N	\N	\N	\N
4792	47	91	EMPTY	\N	\N	\N	\N	\N	\N
4793	47	92	EMPTY	\N	\N	\N	\N	\N	\N
4794	47	93	EMPTY	\N	\N	\N	\N	\N	\N
4795	47	94	EMPTY	\N	\N	\N	\N	\N	\N
4796	47	95	EMPTY	\N	\N	\N	\N	\N	\N
4797	47	96	EMPTY	\N	\N	\N	\N	\N	\N
4798	47	97	EMPTY	\N	\N	\N	\N	\N	\N
4799	47	98	EMPTY	\N	\N	\N	\N	\N	\N
4800	47	99	EMPTY	\N	\N	\N	\N	\N	\N
4801	48	0	EMPTY	\N	\N	\N	\N	\N	\N
4802	48	1	EMPTY	\N	\N	\N	\N	\N	\N
4803	48	2	EMPTY	\N	\N	\N	\N	\N	\N
4804	48	3	RESOURCE	iron	5	\N	\N	\N	\N
4805	48	4	EMPTY	\N	\N	\N	\N	\N	\N
4806	48	5	EMPTY	\N	\N	\N	\N	\N	\N
4807	48	6	EMPTY	\N	\N	\N	\N	\N	\N
4808	48	7	EMPTY	\N	\N	\N	\N	\N	\N
4809	48	8	EMPTY	\N	\N	\N	\N	\N	\N
4810	48	9	EMPTY	\N	\N	\N	\N	\N	\N
4811	48	10	EMPTY	\N	\N	\N	\N	\N	\N
4812	48	11	EMPTY	\N	\N	\N	\N	\N	\N
4813	48	12	EMPTY	\N	\N	\N	\N	\N	\N
4814	48	13	EMPTY	\N	\N	\N	\N	\N	\N
4815	48	14	EMPTY	\N	\N	\N	\N	\N	\N
4816	48	15	EMPTY	\N	\N	\N	\N	\N	\N
4817	48	16	EMPTY	\N	\N	\N	\N	\N	\N
4818	48	17	EMPTY	\N	\N	\N	\N	\N	\N
4819	48	18	EMPTY	\N	\N	\N	\N	\N	\N
4820	48	19	EMPTY	\N	\N	\N	\N	\N	\N
4821	48	20	EMPTY	\N	\N	\N	\N	\N	\N
4822	48	21	EMPTY	\N	\N	\N	\N	\N	\N
4823	48	22	EMPTY	\N	\N	\N	\N	\N	\N
4824	48	23	EMPTY	\N	\N	\N	\N	\N	\N
4825	48	24	EMPTY	\N	\N	\N	\N	\N	\N
4826	48	25	EMPTY	\N	\N	\N	\N	\N	\N
4827	48	26	EMPTY	\N	\N	\N	\N	\N	\N
4828	48	27	EMPTY	\N	\N	\N	\N	\N	\N
4829	48	28	EMPTY	\N	\N	\N	\N	\N	\N
4830	48	29	EMPTY	\N	\N	\N	\N	\N	\N
4831	48	30	EMPTY	\N	\N	\N	\N	\N	\N
4832	48	31	EMPTY	\N	\N	\N	\N	\N	\N
4833	48	32	EMPTY	\N	\N	\N	\N	\N	\N
4834	48	33	EMPTY	\N	\N	\N	\N	\N	\N
4835	48	34	NPC	\N	\N	10	\N	Barbarian Camp (Lv 10)	\N
4836	48	35	EMPTY	\N	\N	\N	\N	\N	\N
4837	48	36	NPC	\N	\N	4	\N	Barbarian Camp (Lv 4)	\N
4838	48	37	EMPTY	\N	\N	\N	\N	\N	\N
4839	48	38	EMPTY	\N	\N	\N	\N	\N	\N
4840	48	39	NPC	\N	\N	1	\N	Barbarian Camp (Lv 1)	\N
4841	48	40	NPC	\N	\N	10	\N	Barbarian Camp (Lv 10)	\N
4842	48	41	NPC	\N	\N	7	\N	Barbarian Camp (Lv 7)	\N
4843	48	42	VALLEY	\N	\N	\N	\N	Valley (48, 42)	\N
4844	48	43	EMPTY	\N	\N	\N	\N	\N	\N
4845	48	44	NPC	\N	\N	5	\N	Barbarian Camp (Lv 5)	\N
4846	48	45	EMPTY	\N	\N	\N	\N	\N	\N
4847	48	46	EMPTY	\N	\N	\N	\N	\N	\N
4848	48	47	EMPTY	\N	\N	\N	\N	\N	\N
4849	48	48	EMPTY	\N	\N	\N	\N	\N	\N
4850	48	49	EMPTY	\N	\N	\N	\N	\N	\N
4851	48	50	EMPTY	\N	\N	\N	\N	\N	\N
4852	48	51	EMPTY	\N	\N	\N	\N	\N	\N
4853	48	52	EMPTY	\N	\N	\N	\N	\N	\N
4854	48	53	EMPTY	\N	\N	\N	\N	\N	\N
4855	48	54	EMPTY	\N	\N	\N	\N	\N	\N
4856	48	55	EMPTY	\N	\N	\N	\N	\N	\N
4857	48	56	EMPTY	\N	\N	\N	\N	\N	\N
4858	48	57	EMPTY	\N	\N	\N	\N	\N	\N
4859	48	58	EMPTY	\N	\N	\N	\N	\N	\N
4860	48	59	EMPTY	\N	\N	\N	\N	\N	\N
4861	48	60	RESOURCE	wood	1	\N	\N	\N	\N
4862	48	61	EMPTY	\N	\N	\N	\N	\N	\N
4863	48	62	EMPTY	\N	\N	\N	\N	\N	\N
4864	48	63	NPC	\N	\N	8	\N	Barbarian Camp (Lv 8)	\N
4865	48	64	EMPTY	\N	\N	\N	\N	\N	\N
4866	48	65	EMPTY	\N	\N	\N	\N	\N	\N
4867	48	66	EMPTY	\N	\N	\N	\N	\N	\N
4868	48	67	EMPTY	\N	\N	\N	\N	\N	\N
4869	48	68	EMPTY	\N	\N	\N	\N	\N	\N
4870	48	69	EMPTY	\N	\N	\N	\N	\N	\N
4871	48	70	EMPTY	\N	\N	\N	\N	\N	\N
4872	48	71	EMPTY	\N	\N	\N	\N	\N	\N
4873	48	72	EMPTY	\N	\N	\N	\N	\N	\N
4874	48	73	EMPTY	\N	\N	\N	\N	\N	\N
4875	48	74	EMPTY	\N	\N	\N	\N	\N	\N
4876	48	75	EMPTY	\N	\N	\N	\N	\N	\N
4877	48	76	EMPTY	\N	\N	\N	\N	\N	\N
4878	48	77	NPC	\N	\N	4	\N	Barbarian Camp (Lv 4)	\N
4879	48	78	EMPTY	\N	\N	\N	\N	\N	\N
4880	48	79	EMPTY	\N	\N	\N	\N	\N	\N
4881	48	80	EMPTY	\N	\N	\N	\N	\N	\N
4882	48	81	EMPTY	\N	\N	\N	\N	\N	\N
4883	48	82	RESOURCE	food	5	\N	\N	\N	\N
4884	48	83	EMPTY	\N	\N	\N	\N	\N	\N
4885	48	84	EMPTY	\N	\N	\N	\N	\N	\N
4886	48	85	EMPTY	\N	\N	\N	\N	\N	\N
4887	48	86	EMPTY	\N	\N	\N	\N	\N	\N
4888	48	87	RESOURCE	iron	5	\N	\N	\N	\N
4889	48	88	NPC	\N	\N	9	\N	Barbarian Camp (Lv 9)	\N
4890	48	89	EMPTY	\N	\N	\N	\N	\N	\N
4891	48	90	EMPTY	\N	\N	\N	\N	\N	\N
4892	48	91	RESOURCE	food	4	\N	\N	\N	\N
4893	48	92	EMPTY	\N	\N	\N	\N	\N	\N
4894	48	93	EMPTY	\N	\N	\N	\N	\N	\N
4895	48	94	EMPTY	\N	\N	\N	\N	\N	\N
4896	48	95	EMPTY	\N	\N	\N	\N	\N	\N
4897	48	96	EMPTY	\N	\N	\N	\N	\N	\N
4898	48	97	EMPTY	\N	\N	\N	\N	\N	\N
4899	48	98	EMPTY	\N	\N	\N	\N	\N	\N
4900	48	99	EMPTY	\N	\N	\N	\N	\N	\N
4901	49	0	EMPTY	\N	\N	\N	\N	\N	\N
4902	49	1	EMPTY	\N	\N	\N	\N	\N	\N
4903	49	2	EMPTY	\N	\N	\N	\N	\N	\N
4904	49	3	NPC	\N	\N	7	\N	Barbarian Camp (Lv 7)	\N
4905	49	4	EMPTY	\N	\N	\N	\N	\N	\N
4906	49	5	EMPTY	\N	\N	\N	\N	\N	\N
4907	49	6	EMPTY	\N	\N	\N	\N	\N	\N
4908	49	7	RESOURCE	iron	3	\N	\N	\N	\N
4909	49	8	EMPTY	\N	\N	\N	\N	\N	\N
4910	49	9	EMPTY	\N	\N	\N	\N	\N	\N
4911	49	10	EMPTY	\N	\N	\N	\N	\N	\N
4912	49	11	EMPTY	\N	\N	\N	\N	\N	\N
4913	49	12	RESOURCE	wood	4	\N	\N	\N	\N
4914	49	13	RESOURCE	stone	1	\N	\N	\N	\N
4915	49	14	RESOURCE	stone	4	\N	\N	\N	\N
4916	49	15	VALLEY	\N	\N	\N	\N	Valley (49, 15)	\N
4917	49	16	EMPTY	\N	\N	\N	\N	\N	\N
4918	49	17	EMPTY	\N	\N	\N	\N	\N	\N
4919	49	18	NPC	\N	\N	10	\N	Barbarian Camp (Lv 10)	\N
4920	49	19	EMPTY	\N	\N	\N	\N	\N	\N
4921	49	20	EMPTY	\N	\N	\N	\N	\N	\N
4922	49	21	EMPTY	\N	\N	\N	\N	\N	\N
4923	49	22	EMPTY	\N	\N	\N	\N	\N	\N
4924	49	23	EMPTY	\N	\N	\N	\N	\N	\N
4925	49	24	EMPTY	\N	\N	\N	\N	\N	\N
4926	49	25	NPC	\N	\N	3	\N	Barbarian Camp (Lv 3)	\N
4927	49	26	EMPTY	\N	\N	\N	\N	\N	\N
4928	49	27	EMPTY	\N	\N	\N	\N	\N	\N
4929	49	28	EMPTY	\N	\N	\N	\N	\N	\N
4930	49	29	EMPTY	\N	\N	\N	\N	\N	\N
4931	49	30	EMPTY	\N	\N	\N	\N	\N	\N
4932	49	31	RESOURCE	iron	1	\N	\N	\N	\N
4933	49	32	EMPTY	\N	\N	\N	\N	\N	\N
4934	49	33	RESOURCE	stone	2	\N	\N	\N	\N
4935	49	34	EMPTY	\N	\N	\N	\N	\N	\N
4936	49	35	EMPTY	\N	\N	\N	\N	\N	\N
4937	49	36	VALLEY	\N	\N	\N	\N	Valley (49, 36)	\N
4938	49	37	EMPTY	\N	\N	\N	\N	\N	\N
4939	49	38	EMPTY	\N	\N	\N	\N	\N	\N
4940	49	39	EMPTY	\N	\N	\N	\N	\N	\N
4941	49	40	EMPTY	\N	\N	\N	\N	\N	\N
4942	49	41	EMPTY	\N	\N	\N	\N	\N	\N
4943	49	42	EMPTY	\N	\N	\N	\N	\N	\N
4944	49	43	VALLEY	\N	\N	\N	\N	Valley (49, 43)	\N
4945	49	44	EMPTY	\N	\N	\N	\N	\N	\N
4946	49	45	EMPTY	\N	\N	\N	\N	\N	\N
4947	49	46	EMPTY	\N	\N	\N	\N	\N	\N
4948	49	47	EMPTY	\N	\N	\N	\N	\N	\N
4949	49	48	NPC	\N	\N	5	\N	Barbarian Camp (Lv 5)	\N
4950	49	49	EMPTY	\N	\N	\N	\N	\N	\N
4951	49	50	EMPTY	\N	\N	\N	\N	\N	\N
4952	49	51	EMPTY	\N	\N	\N	\N	\N	\N
4953	49	52	EMPTY	\N	\N	\N	\N	\N	\N
4954	49	53	EMPTY	\N	\N	\N	\N	\N	\N
4955	49	54	EMPTY	\N	\N	\N	\N	\N	\N
4956	49	55	NPC	\N	\N	4	\N	Barbarian Camp (Lv 4)	\N
4957	49	56	EMPTY	\N	\N	\N	\N	\N	\N
4958	49	57	EMPTY	\N	\N	\N	\N	\N	\N
4959	49	58	EMPTY	\N	\N	\N	\N	\N	\N
4960	49	59	EMPTY	\N	\N	\N	\N	\N	\N
4961	49	60	EMPTY	\N	\N	\N	\N	\N	\N
4962	49	61	RESOURCE	food	5	\N	\N	\N	\N
4963	49	62	EMPTY	\N	\N	\N	\N	\N	\N
4964	49	63	EMPTY	\N	\N	\N	\N	\N	\N
4965	49	64	RESOURCE	iron	4	\N	\N	\N	\N
4966	49	65	EMPTY	\N	\N	\N	\N	\N	\N
4967	49	66	EMPTY	\N	\N	\N	\N	\N	\N
4968	49	67	NPC	\N	\N	6	\N	Barbarian Camp (Lv 6)	\N
4969	49	68	EMPTY	\N	\N	\N	\N	\N	\N
4970	49	69	EMPTY	\N	\N	\N	\N	\N	\N
4971	49	70	NPC	\N	\N	7	\N	Barbarian Camp (Lv 7)	\N
4972	49	71	EMPTY	\N	\N	\N	\N	\N	\N
4973	49	72	EMPTY	\N	\N	\N	\N	\N	\N
4974	49	73	RESOURCE	iron	5	\N	\N	\N	\N
4975	49	74	EMPTY	\N	\N	\N	\N	\N	\N
4976	49	75	EMPTY	\N	\N	\N	\N	\N	\N
4977	49	76	RESOURCE	food	4	\N	\N	\N	\N
4978	49	77	EMPTY	\N	\N	\N	\N	\N	\N
4979	49	78	RESOURCE	iron	1	\N	\N	\N	\N
4980	49	79	EMPTY	\N	\N	\N	\N	\N	\N
4981	49	80	EMPTY	\N	\N	\N	\N	\N	\N
4982	49	81	EMPTY	\N	\N	\N	\N	\N	\N
4983	49	82	EMPTY	\N	\N	\N	\N	\N	\N
4984	49	83	EMPTY	\N	\N	\N	\N	\N	\N
4985	49	84	EMPTY	\N	\N	\N	\N	\N	\N
4986	49	85	EMPTY	\N	\N	\N	\N	\N	\N
4987	49	86	EMPTY	\N	\N	\N	\N	\N	\N
4988	49	87	EMPTY	\N	\N	\N	\N	\N	\N
4989	49	88	RESOURCE	food	2	\N	\N	\N	\N
4990	49	89	NPC	\N	\N	2	\N	Barbarian Camp (Lv 2)	\N
4991	49	90	EMPTY	\N	\N	\N	\N	\N	\N
4992	49	91	EMPTY	\N	\N	\N	\N	\N	\N
4993	49	92	EMPTY	\N	\N	\N	\N	\N	\N
4994	49	93	EMPTY	\N	\N	\N	\N	\N	\N
4995	49	94	EMPTY	\N	\N	\N	\N	\N	\N
4996	49	95	EMPTY	\N	\N	\N	\N	\N	\N
4997	49	96	EMPTY	\N	\N	\N	\N	\N	\N
4998	49	97	EMPTY	\N	\N	\N	\N	\N	\N
4999	49	98	EMPTY	\N	\N	\N	\N	\N	\N
5000	49	99	EMPTY	\N	\N	\N	\N	\N	\N
5001	50	0	EMPTY	\N	\N	\N	\N	\N	\N
5002	50	1	VALLEY	\N	\N	\N	\N	Valley (50, 1)	\N
5003	50	2	EMPTY	\N	\N	\N	\N	\N	\N
5004	50	3	EMPTY	\N	\N	\N	\N	\N	\N
5005	50	4	RESOURCE	wood	2	\N	\N	\N	\N
5006	50	5	EMPTY	\N	\N	\N	\N	\N	\N
5007	50	6	EMPTY	\N	\N	\N	\N	\N	\N
5008	50	7	EMPTY	\N	\N	\N	\N	\N	\N
5009	50	8	EMPTY	\N	\N	\N	\N	\N	\N
5010	50	9	EMPTY	\N	\N	\N	\N	\N	\N
5011	50	10	EMPTY	\N	\N	\N	\N	\N	\N
5012	50	11	EMPTY	\N	\N	\N	\N	\N	\N
5013	50	12	EMPTY	\N	\N	\N	\N	\N	\N
5014	50	13	EMPTY	\N	\N	\N	\N	\N	\N
5015	50	14	EMPTY	\N	\N	\N	\N	\N	\N
5016	50	15	VALLEY	\N	\N	\N	\N	Valley (50, 15)	\N
5017	50	16	RESOURCE	wood	1	\N	\N	\N	\N
5018	50	17	EMPTY	\N	\N	\N	\N	\N	\N
5019	50	18	EMPTY	\N	\N	\N	\N	\N	\N
5020	50	19	EMPTY	\N	\N	\N	\N	\N	\N
5021	50	20	EMPTY	\N	\N	\N	\N	\N	\N
5022	50	21	RESOURCE	stone	4	\N	\N	\N	\N
5023	50	22	EMPTY	\N	\N	\N	\N	\N	\N
5024	50	23	EMPTY	\N	\N	\N	\N	\N	\N
5025	50	24	EMPTY	\N	\N	\N	\N	\N	\N
5026	50	25	RESOURCE	iron	1	\N	\N	\N	\N
5027	50	26	EMPTY	\N	\N	\N	\N	\N	\N
5028	50	27	EMPTY	\N	\N	\N	\N	\N	\N
5029	50	28	EMPTY	\N	\N	\N	\N	\N	\N
5030	50	29	EMPTY	\N	\N	\N	\N	\N	\N
5031	50	30	EMPTY	\N	\N	\N	\N	\N	\N
5032	50	31	EMPTY	\N	\N	\N	\N	\N	\N
5033	50	32	EMPTY	\N	\N	\N	\N	\N	\N
5034	50	33	RESOURCE	iron	2	\N	\N	\N	\N
5035	50	34	EMPTY	\N	\N	\N	\N	\N	\N
5036	50	35	EMPTY	\N	\N	\N	\N	\N	\N
5037	50	36	EMPTY	\N	\N	\N	\N	\N	\N
5038	50	37	EMPTY	\N	\N	\N	\N	\N	\N
5039	50	38	EMPTY	\N	\N	\N	\N	\N	\N
5040	50	39	EMPTY	\N	\N	\N	\N	\N	\N
5041	50	40	RESOURCE	food	2	\N	\N	\N	\N
5042	50	41	EMPTY	\N	\N	\N	\N	\N	\N
5043	50	42	NPC	\N	\N	4	\N	Barbarian Camp (Lv 4)	\N
5044	50	43	EMPTY	\N	\N	\N	\N	\N	\N
5045	50	44	EMPTY	\N	\N	\N	\N	\N	\N
5046	50	45	NPC	\N	\N	10	\N	Barbarian Camp (Lv 10)	\N
5047	50	46	EMPTY	\N	\N	\N	\N	\N	\N
5048	50	47	EMPTY	\N	\N	\N	\N	\N	\N
5049	50	48	EMPTY	\N	\N	\N	\N	\N	\N
5050	50	49	EMPTY	\N	\N	\N	\N	\N	\N
5051	50	50	EMPTY	\N	\N	\N	\N	\N	\N
5052	50	51	EMPTY	\N	\N	\N	\N	\N	\N
5053	50	52	EMPTY	\N	\N	\N	\N	\N	\N
5054	50	53	EMPTY	\N	\N	\N	\N	\N	\N
5055	50	54	RESOURCE	wood	2	\N	\N	\N	\N
5056	50	55	EMPTY	\N	\N	\N	\N	\N	\N
5057	50	56	EMPTY	\N	\N	\N	\N	\N	\N
5058	50	57	EMPTY	\N	\N	\N	\N	\N	\N
5059	50	58	EMPTY	\N	\N	\N	\N	\N	\N
5060	50	59	EMPTY	\N	\N	\N	\N	\N	\N
5061	50	60	EMPTY	\N	\N	\N	\N	\N	\N
5062	50	61	EMPTY	\N	\N	\N	\N	\N	\N
5063	50	62	EMPTY	\N	\N	\N	\N	\N	\N
5064	50	63	NPC	\N	\N	4	\N	Barbarian Camp (Lv 4)	\N
5065	50	64	EMPTY	\N	\N	\N	\N	\N	\N
5066	50	65	EMPTY	\N	\N	\N	\N	\N	\N
5067	50	66	EMPTY	\N	\N	\N	\N	\N	\N
5068	50	67	VALLEY	\N	\N	\N	\N	Valley (50, 67)	\N
5069	50	68	NPC	\N	\N	4	\N	Barbarian Camp (Lv 4)	\N
5070	50	69	EMPTY	\N	\N	\N	\N	\N	\N
5071	50	70	EMPTY	\N	\N	\N	\N	\N	\N
5072	50	71	EMPTY	\N	\N	\N	\N	\N	\N
5073	50	72	EMPTY	\N	\N	\N	\N	\N	\N
5074	50	73	EMPTY	\N	\N	\N	\N	\N	\N
5075	50	74	NPC	\N	\N	6	\N	Barbarian Camp (Lv 6)	\N
5076	50	75	EMPTY	\N	\N	\N	\N	\N	\N
5077	50	76	EMPTY	\N	\N	\N	\N	\N	\N
5078	50	77	EMPTY	\N	\N	\N	\N	\N	\N
5079	50	78	EMPTY	\N	\N	\N	\N	\N	\N
5080	50	79	EMPTY	\N	\N	\N	\N	\N	\N
5081	50	80	EMPTY	\N	\N	\N	\N	\N	\N
5082	50	81	EMPTY	\N	\N	\N	\N	\N	\N
5083	50	82	EMPTY	\N	\N	\N	\N	\N	\N
5084	50	83	EMPTY	\N	\N	\N	\N	\N	\N
5085	50	84	EMPTY	\N	\N	\N	\N	\N	\N
5086	50	85	EMPTY	\N	\N	\N	\N	\N	\N
5087	50	86	EMPTY	\N	\N	\N	\N	\N	\N
5088	50	87	EMPTY	\N	\N	\N	\N	\N	\N
5089	50	88	EMPTY	\N	\N	\N	\N	\N	\N
5090	50	89	EMPTY	\N	\N	\N	\N	\N	\N
5091	50	90	EMPTY	\N	\N	\N	\N	\N	\N
5092	50	91	EMPTY	\N	\N	\N	\N	\N	\N
5093	50	92	EMPTY	\N	\N	\N	\N	\N	\N
5094	50	93	EMPTY	\N	\N	\N	\N	\N	\N
5095	50	94	EMPTY	\N	\N	\N	\N	\N	\N
5096	50	95	NPC	\N	\N	10	\N	Barbarian Camp (Lv 10)	\N
5097	50	96	EMPTY	\N	\N	\N	\N	\N	\N
5098	50	97	EMPTY	\N	\N	\N	\N	\N	\N
5099	50	98	EMPTY	\N	\N	\N	\N	\N	\N
5100	50	99	EMPTY	\N	\N	\N	\N	\N	\N
5101	51	0	EMPTY	\N	\N	\N	\N	\N	\N
5102	51	1	RESOURCE	iron	1	\N	\N	\N	\N
5103	51	2	EMPTY	\N	\N	\N	\N	\N	\N
5104	51	3	EMPTY	\N	\N	\N	\N	\N	\N
5105	51	4	EMPTY	\N	\N	\N	\N	\N	\N
5106	51	5	EMPTY	\N	\N	\N	\N	\N	\N
5107	51	6	EMPTY	\N	\N	\N	\N	\N	\N
5108	51	7	RESOURCE	stone	3	\N	\N	\N	\N
5109	51	8	RESOURCE	stone	4	\N	\N	\N	\N
5110	51	9	EMPTY	\N	\N	\N	\N	\N	\N
5111	51	10	EMPTY	\N	\N	\N	\N	\N	\N
5112	51	11	EMPTY	\N	\N	\N	\N	\N	\N
5113	51	12	EMPTY	\N	\N	\N	\N	\N	\N
5114	51	13	EMPTY	\N	\N	\N	\N	\N	\N
5115	51	14	EMPTY	\N	\N	\N	\N	\N	\N
5116	51	15	EMPTY	\N	\N	\N	\N	\N	\N
5117	51	16	EMPTY	\N	\N	\N	\N	\N	\N
5118	51	17	EMPTY	\N	\N	\N	\N	\N	\N
5119	51	18	EMPTY	\N	\N	\N	\N	\N	\N
5120	51	19	EMPTY	\N	\N	\N	\N	\N	\N
5121	51	20	EMPTY	\N	\N	\N	\N	\N	\N
5122	51	21	EMPTY	\N	\N	\N	\N	\N	\N
5123	51	22	NPC	\N	\N	2	\N	Barbarian Camp (Lv 2)	\N
5124	51	23	EMPTY	\N	\N	\N	\N	\N	\N
5125	51	24	EMPTY	\N	\N	\N	\N	\N	\N
5126	51	25	EMPTY	\N	\N	\N	\N	\N	\N
5127	51	26	EMPTY	\N	\N	\N	\N	\N	\N
5128	51	27	EMPTY	\N	\N	\N	\N	\N	\N
5129	51	28	EMPTY	\N	\N	\N	\N	\N	\N
5130	51	29	EMPTY	\N	\N	\N	\N	\N	\N
5131	51	30	EMPTY	\N	\N	\N	\N	\N	\N
5132	51	31	EMPTY	\N	\N	\N	\N	\N	\N
5133	51	32	EMPTY	\N	\N	\N	\N	\N	\N
5134	51	33	RESOURCE	wood	2	\N	\N	\N	\N
5135	51	34	RESOURCE	wood	4	\N	\N	\N	\N
5136	51	35	RESOURCE	iron	5	\N	\N	\N	\N
5137	51	36	EMPTY	\N	\N	\N	\N	\N	\N
5138	51	37	RESOURCE	stone	4	\N	\N	\N	\N
5139	51	38	EMPTY	\N	\N	\N	\N	\N	\N
5140	51	39	EMPTY	\N	\N	\N	\N	\N	\N
5141	51	40	NPC	\N	\N	5	\N	Barbarian Camp (Lv 5)	\N
5142	51	41	EMPTY	\N	\N	\N	\N	\N	\N
5143	51	42	EMPTY	\N	\N	\N	\N	\N	\N
5144	51	43	EMPTY	\N	\N	\N	\N	\N	\N
5145	51	44	RESOURCE	food	2	\N	\N	\N	\N
5146	51	45	EMPTY	\N	\N	\N	\N	\N	\N
5147	51	46	EMPTY	\N	\N	\N	\N	\N	\N
5148	51	47	NPC	\N	\N	1	\N	Barbarian Camp (Lv 1)	\N
5149	51	48	EMPTY	\N	\N	\N	\N	\N	\N
5150	51	49	EMPTY	\N	\N	\N	\N	\N	\N
5151	51	50	EMPTY	\N	\N	\N	\N	\N	\N
5152	51	51	EMPTY	\N	\N	\N	\N	\N	\N
5153	51	52	EMPTY	\N	\N	\N	\N	\N	\N
5154	51	53	EMPTY	\N	\N	\N	\N	\N	\N
5155	51	54	EMPTY	\N	\N	\N	\N	\N	\N
5156	51	55	EMPTY	\N	\N	\N	\N	\N	\N
5157	51	56	EMPTY	\N	\N	\N	\N	\N	\N
5158	51	57	RESOURCE	wood	1	\N	\N	\N	\N
5159	51	58	EMPTY	\N	\N	\N	\N	\N	\N
5160	51	59	EMPTY	\N	\N	\N	\N	\N	\N
5161	51	60	EMPTY	\N	\N	\N	\N	\N	\N
5162	51	61	EMPTY	\N	\N	\N	\N	\N	\N
5163	51	62	EMPTY	\N	\N	\N	\N	\N	\N
5164	51	63	NPC	\N	\N	3	\N	Barbarian Camp (Lv 3)	\N
5165	51	64	EMPTY	\N	\N	\N	\N	\N	\N
5166	51	65	EMPTY	\N	\N	\N	\N	\N	\N
5167	51	66	EMPTY	\N	\N	\N	\N	\N	\N
5168	51	67	RESOURCE	food	4	\N	\N	\N	\N
5169	51	68	EMPTY	\N	\N	\N	\N	\N	\N
5170	51	69	EMPTY	\N	\N	\N	\N	\N	\N
5171	51	70	NPC	\N	\N	1	\N	Barbarian Camp (Lv 1)	\N
5172	51	71	EMPTY	\N	\N	\N	\N	\N	\N
5173	51	72	EMPTY	\N	\N	\N	\N	\N	\N
5174	51	73	EMPTY	\N	\N	\N	\N	\N	\N
5175	51	74	EMPTY	\N	\N	\N	\N	\N	\N
5176	51	75	EMPTY	\N	\N	\N	\N	\N	\N
5177	51	76	EMPTY	\N	\N	\N	\N	\N	\N
5178	51	77	EMPTY	\N	\N	\N	\N	\N	\N
5179	51	78	EMPTY	\N	\N	\N	\N	\N	\N
5180	51	79	EMPTY	\N	\N	\N	\N	\N	\N
5181	51	80	EMPTY	\N	\N	\N	\N	\N	\N
5182	51	81	EMPTY	\N	\N	\N	\N	\N	\N
5183	51	82	EMPTY	\N	\N	\N	\N	\N	\N
5184	51	83	EMPTY	\N	\N	\N	\N	\N	\N
5185	51	84	NPC	\N	\N	10	\N	Barbarian Camp (Lv 10)	\N
5186	51	85	EMPTY	\N	\N	\N	\N	\N	\N
5187	51	86	NPC	\N	\N	5	\N	Barbarian Camp (Lv 5)	\N
5188	51	87	EMPTY	\N	\N	\N	\N	\N	\N
5189	51	88	EMPTY	\N	\N	\N	\N	\N	\N
5190	51	89	EMPTY	\N	\N	\N	\N	\N	\N
5191	51	90	EMPTY	\N	\N	\N	\N	\N	\N
5192	51	91	EMPTY	\N	\N	\N	\N	\N	\N
5193	51	92	EMPTY	\N	\N	\N	\N	\N	\N
5194	51	93	EMPTY	\N	\N	\N	\N	\N	\N
5195	51	94	EMPTY	\N	\N	\N	\N	\N	\N
5196	51	95	RESOURCE	food	5	\N	\N	\N	\N
5197	51	96	EMPTY	\N	\N	\N	\N	\N	\N
5198	51	97	EMPTY	\N	\N	\N	\N	\N	\N
5199	51	98	EMPTY	\N	\N	\N	\N	\N	\N
5200	51	99	EMPTY	\N	\N	\N	\N	\N	\N
5201	52	0	EMPTY	\N	\N	\N	\N	\N	\N
5202	52	1	EMPTY	\N	\N	\N	\N	\N	\N
5203	52	2	EMPTY	\N	\N	\N	\N	\N	\N
5204	52	3	EMPTY	\N	\N	\N	\N	\N	\N
5205	52	4	RESOURCE	food	5	\N	\N	\N	\N
5206	52	5	EMPTY	\N	\N	\N	\N	\N	\N
5207	52	6	NPC	\N	\N	6	\N	Barbarian Camp (Lv 6)	\N
5208	52	7	EMPTY	\N	\N	\N	\N	\N	\N
5209	52	8	EMPTY	\N	\N	\N	\N	\N	\N
5210	52	9	EMPTY	\N	\N	\N	\N	\N	\N
5211	52	10	EMPTY	\N	\N	\N	\N	\N	\N
5212	52	11	EMPTY	\N	\N	\N	\N	\N	\N
5213	52	12	EMPTY	\N	\N	\N	\N	\N	\N
5214	52	13	EMPTY	\N	\N	\N	\N	\N	\N
5215	52	14	EMPTY	\N	\N	\N	\N	\N	\N
5216	52	15	EMPTY	\N	\N	\N	\N	\N	\N
5217	52	16	EMPTY	\N	\N	\N	\N	\N	\N
5218	52	17	EMPTY	\N	\N	\N	\N	\N	\N
5219	52	18	RESOURCE	wood	1	\N	\N	\N	\N
5220	52	19	EMPTY	\N	\N	\N	\N	\N	\N
5221	52	20	EMPTY	\N	\N	\N	\N	\N	\N
5222	52	21	EMPTY	\N	\N	\N	\N	\N	\N
5223	52	22	EMPTY	\N	\N	\N	\N	\N	\N
5224	52	23	RESOURCE	food	1	\N	\N	\N	\N
5225	52	24	EMPTY	\N	\N	\N	\N	\N	\N
5226	52	25	EMPTY	\N	\N	\N	\N	\N	\N
5227	52	26	EMPTY	\N	\N	\N	\N	\N	\N
5228	52	27	EMPTY	\N	\N	\N	\N	\N	\N
5229	52	28	EMPTY	\N	\N	\N	\N	\N	\N
5230	52	29	EMPTY	\N	\N	\N	\N	\N	\N
5231	52	30	EMPTY	\N	\N	\N	\N	\N	\N
5232	52	31	EMPTY	\N	\N	\N	\N	\N	\N
5233	52	32	EMPTY	\N	\N	\N	\N	\N	\N
5234	52	33	EMPTY	\N	\N	\N	\N	\N	\N
5235	52	34	EMPTY	\N	\N	\N	\N	\N	\N
5236	52	35	EMPTY	\N	\N	\N	\N	\N	\N
5237	52	36	EMPTY	\N	\N	\N	\N	\N	\N
5238	52	37	EMPTY	\N	\N	\N	\N	\N	\N
5239	52	38	EMPTY	\N	\N	\N	\N	\N	\N
5240	52	39	EMPTY	\N	\N	\N	\N	\N	\N
5241	52	40	RESOURCE	wood	1	\N	\N	\N	\N
5242	52	41	EMPTY	\N	\N	\N	\N	\N	\N
5243	52	42	NPC	\N	\N	2	\N	Barbarian Camp (Lv 2)	\N
5244	52	43	EMPTY	\N	\N	\N	\N	\N	\N
5245	52	44	EMPTY	\N	\N	\N	\N	\N	\N
5246	52	45	EMPTY	\N	\N	\N	\N	\N	\N
5247	52	46	EMPTY	\N	\N	\N	\N	\N	\N
5248	52	47	EMPTY	\N	\N	\N	\N	\N	\N
5249	52	48	EMPTY	\N	\N	\N	\N	\N	\N
5250	52	49	EMPTY	\N	\N	\N	\N	\N	\N
5251	52	50	EMPTY	\N	\N	\N	\N	\N	\N
5252	52	51	EMPTY	\N	\N	\N	\N	\N	\N
5253	52	52	EMPTY	\N	\N	\N	\N	\N	\N
5254	52	53	EMPTY	\N	\N	\N	\N	\N	\N
5255	52	54	NPC	\N	\N	5	\N	Barbarian Camp (Lv 5)	\N
5256	52	55	EMPTY	\N	\N	\N	\N	\N	\N
5257	52	56	EMPTY	\N	\N	\N	\N	\N	\N
5258	52	57	EMPTY	\N	\N	\N	\N	\N	\N
5259	52	58	EMPTY	\N	\N	\N	\N	\N	\N
5260	52	59	EMPTY	\N	\N	\N	\N	\N	\N
5261	52	60	EMPTY	\N	\N	\N	\N	\N	\N
5262	52	61	EMPTY	\N	\N	\N	\N	\N	\N
5263	52	62	EMPTY	\N	\N	\N	\N	\N	\N
5264	52	63	EMPTY	\N	\N	\N	\N	\N	\N
5265	52	64	EMPTY	\N	\N	\N	\N	\N	\N
5266	52	65	EMPTY	\N	\N	\N	\N	\N	\N
5267	52	66	EMPTY	\N	\N	\N	\N	\N	\N
5268	52	67	EMPTY	\N	\N	\N	\N	\N	\N
5269	52	68	EMPTY	\N	\N	\N	\N	\N	\N
5270	52	69	VALLEY	\N	\N	\N	\N	Valley (52, 69)	\N
5271	52	70	NPC	\N	\N	9	\N	Barbarian Camp (Lv 9)	\N
5272	52	71	EMPTY	\N	\N	\N	\N	\N	\N
5273	52	72	EMPTY	\N	\N	\N	\N	\N	\N
5274	52	73	EMPTY	\N	\N	\N	\N	\N	\N
5275	52	74	EMPTY	\N	\N	\N	\N	\N	\N
5276	52	75	EMPTY	\N	\N	\N	\N	\N	\N
5277	52	76	EMPTY	\N	\N	\N	\N	\N	\N
5278	52	77	EMPTY	\N	\N	\N	\N	\N	\N
5279	52	78	EMPTY	\N	\N	\N	\N	\N	\N
5280	52	79	EMPTY	\N	\N	\N	\N	\N	\N
5281	52	80	EMPTY	\N	\N	\N	\N	\N	\N
5282	52	81	EMPTY	\N	\N	\N	\N	\N	\N
5283	52	82	EMPTY	\N	\N	\N	\N	\N	\N
5284	52	83	RESOURCE	iron	4	\N	\N	\N	\N
5285	52	84	EMPTY	\N	\N	\N	\N	\N	\N
5286	52	85	EMPTY	\N	\N	\N	\N	\N	\N
5287	52	86	EMPTY	\N	\N	\N	\N	\N	\N
5288	52	87	EMPTY	\N	\N	\N	\N	\N	\N
5289	52	88	EMPTY	\N	\N	\N	\N	\N	\N
5290	52	89	EMPTY	\N	\N	\N	\N	\N	\N
5291	52	90	EMPTY	\N	\N	\N	\N	\N	\N
5292	52	91	EMPTY	\N	\N	\N	\N	\N	\N
5293	52	92	EMPTY	\N	\N	\N	\N	\N	\N
5294	52	93	EMPTY	\N	\N	\N	\N	\N	\N
5295	52	94	EMPTY	\N	\N	\N	\N	\N	\N
5296	52	95	EMPTY	\N	\N	\N	\N	\N	\N
5297	52	96	EMPTY	\N	\N	\N	\N	\N	\N
5298	52	97	EMPTY	\N	\N	\N	\N	\N	\N
5299	52	98	EMPTY	\N	\N	\N	\N	\N	\N
5300	52	99	EMPTY	\N	\N	\N	\N	\N	\N
5301	53	0	EMPTY	\N	\N	\N	\N	\N	\N
5302	53	1	EMPTY	\N	\N	\N	\N	\N	\N
5303	53	2	EMPTY	\N	\N	\N	\N	\N	\N
5304	53	3	EMPTY	\N	\N	\N	\N	\N	\N
5305	53	4	EMPTY	\N	\N	\N	\N	\N	\N
5306	53	5	EMPTY	\N	\N	\N	\N	\N	\N
5307	53	6	NPC	\N	\N	7	\N	Barbarian Camp (Lv 7)	\N
5308	53	7	EMPTY	\N	\N	\N	\N	\N	\N
5309	53	8	EMPTY	\N	\N	\N	\N	\N	\N
5310	53	9	EMPTY	\N	\N	\N	\N	\N	\N
5311	53	10	EMPTY	\N	\N	\N	\N	\N	\N
5312	53	11	EMPTY	\N	\N	\N	\N	\N	\N
5313	53	12	EMPTY	\N	\N	\N	\N	\N	\N
5314	53	13	EMPTY	\N	\N	\N	\N	\N	\N
5315	53	14	EMPTY	\N	\N	\N	\N	\N	\N
5316	53	15	EMPTY	\N	\N	\N	\N	\N	\N
5317	53	16	EMPTY	\N	\N	\N	\N	\N	\N
5318	53	17	EMPTY	\N	\N	\N	\N	\N	\N
5319	53	18	RESOURCE	food	1	\N	\N	\N	\N
5320	53	19	EMPTY	\N	\N	\N	\N	\N	\N
5321	53	20	RESOURCE	iron	4	\N	\N	\N	\N
5322	53	21	EMPTY	\N	\N	\N	\N	\N	\N
5323	53	22	EMPTY	\N	\N	\N	\N	\N	\N
5324	53	23	EMPTY	\N	\N	\N	\N	\N	\N
5325	53	24	EMPTY	\N	\N	\N	\N	\N	\N
5326	53	25	EMPTY	\N	\N	\N	\N	\N	\N
5327	53	26	EMPTY	\N	\N	\N	\N	\N	\N
5328	53	27	EMPTY	\N	\N	\N	\N	\N	\N
5329	53	28	RESOURCE	iron	5	\N	\N	\N	\N
5330	53	29	EMPTY	\N	\N	\N	\N	\N	\N
5331	53	30	EMPTY	\N	\N	\N	\N	\N	\N
5332	53	31	EMPTY	\N	\N	\N	\N	\N	\N
5333	53	32	EMPTY	\N	\N	\N	\N	\N	\N
5334	53	33	EMPTY	\N	\N	\N	\N	\N	\N
5335	53	34	EMPTY	\N	\N	\N	\N	\N	\N
5336	53	35	RESOURCE	iron	3	\N	\N	\N	\N
5337	53	36	EMPTY	\N	\N	\N	\N	\N	\N
5338	53	37	EMPTY	\N	\N	\N	\N	\N	\N
5339	53	38	EMPTY	\N	\N	\N	\N	\N	\N
5340	53	39	EMPTY	\N	\N	\N	\N	\N	\N
5341	53	40	EMPTY	\N	\N	\N	\N	\N	\N
5342	53	41	EMPTY	\N	\N	\N	\N	\N	\N
5343	53	42	EMPTY	\N	\N	\N	\N	\N	\N
5344	53	43	EMPTY	\N	\N	\N	\N	\N	\N
5345	53	44	EMPTY	\N	\N	\N	\N	\N	\N
5346	53	45	EMPTY	\N	\N	\N	\N	\N	\N
5347	53	46	EMPTY	\N	\N	\N	\N	\N	\N
5348	53	47	EMPTY	\N	\N	\N	\N	\N	\N
5349	53	48	EMPTY	\N	\N	\N	\N	\N	\N
5350	53	49	NPC	\N	\N	6	\N	Barbarian Camp (Lv 6)	\N
5351	53	50	EMPTY	\N	\N	\N	\N	\N	\N
5352	53	51	EMPTY	\N	\N	\N	\N	\N	\N
5353	53	52	EMPTY	\N	\N	\N	\N	\N	\N
5354	53	53	EMPTY	\N	\N	\N	\N	\N	\N
5355	53	54	EMPTY	\N	\N	\N	\N	\N	\N
5356	53	55	EMPTY	\N	\N	\N	\N	\N	\N
5357	53	56	EMPTY	\N	\N	\N	\N	\N	\N
5358	53	57	EMPTY	\N	\N	\N	\N	\N	\N
5359	53	58	EMPTY	\N	\N	\N	\N	\N	\N
5360	53	59	EMPTY	\N	\N	\N	\N	\N	\N
5361	53	60	EMPTY	\N	\N	\N	\N	\N	\N
5362	53	61	EMPTY	\N	\N	\N	\N	\N	\N
5363	53	62	EMPTY	\N	\N	\N	\N	\N	\N
5364	53	63	EMPTY	\N	\N	\N	\N	\N	\N
5365	53	64	EMPTY	\N	\N	\N	\N	\N	\N
5366	53	65	RESOURCE	wood	4	\N	\N	\N	\N
5367	53	66	EMPTY	\N	\N	\N	\N	\N	\N
5368	53	67	EMPTY	\N	\N	\N	\N	\N	\N
5369	53	68	EMPTY	\N	\N	\N	\N	\N	\N
5370	53	69	EMPTY	\N	\N	\N	\N	\N	\N
5371	53	70	EMPTY	\N	\N	\N	\N	\N	\N
5372	53	71	EMPTY	\N	\N	\N	\N	\N	\N
5373	53	72	EMPTY	\N	\N	\N	\N	\N	\N
5374	53	73	EMPTY	\N	\N	\N	\N	\N	\N
5375	53	74	EMPTY	\N	\N	\N	\N	\N	\N
5376	53	75	RESOURCE	food	3	\N	\N	\N	\N
5377	53	76	EMPTY	\N	\N	\N	\N	\N	\N
5378	53	77	EMPTY	\N	\N	\N	\N	\N	\N
5379	53	78	EMPTY	\N	\N	\N	\N	\N	\N
5380	53	79	EMPTY	\N	\N	\N	\N	\N	\N
5381	53	80	EMPTY	\N	\N	\N	\N	\N	\N
5382	53	81	EMPTY	\N	\N	\N	\N	\N	\N
5383	53	82	EMPTY	\N	\N	\N	\N	\N	\N
5384	53	83	EMPTY	\N	\N	\N	\N	\N	\N
5385	53	84	EMPTY	\N	\N	\N	\N	\N	\N
5386	53	85	EMPTY	\N	\N	\N	\N	\N	\N
5387	53	86	EMPTY	\N	\N	\N	\N	\N	\N
5388	53	87	EMPTY	\N	\N	\N	\N	\N	\N
5389	53	88	EMPTY	\N	\N	\N	\N	\N	\N
5390	53	89	RESOURCE	stone	3	\N	\N	\N	\N
5391	53	90	EMPTY	\N	\N	\N	\N	\N	\N
5392	53	91	EMPTY	\N	\N	\N	\N	\N	\N
5393	53	92	EMPTY	\N	\N	\N	\N	\N	\N
5394	53	93	EMPTY	\N	\N	\N	\N	\N	\N
5395	53	94	EMPTY	\N	\N	\N	\N	\N	\N
5396	53	95	EMPTY	\N	\N	\N	\N	\N	\N
5397	53	96	EMPTY	\N	\N	\N	\N	\N	\N
5398	53	97	EMPTY	\N	\N	\N	\N	\N	\N
5399	53	98	EMPTY	\N	\N	\N	\N	\N	\N
5400	53	99	EMPTY	\N	\N	\N	\N	\N	\N
5401	54	0	EMPTY	\N	\N	\N	\N	\N	\N
5402	54	1	EMPTY	\N	\N	\N	\N	\N	\N
5403	54	2	EMPTY	\N	\N	\N	\N	\N	\N
5404	54	3	EMPTY	\N	\N	\N	\N	\N	\N
5405	54	4	EMPTY	\N	\N	\N	\N	\N	\N
5406	54	5	EMPTY	\N	\N	\N	\N	\N	\N
5407	54	6	VALLEY	\N	\N	\N	\N	Valley (54, 6)	\N
5408	54	7	EMPTY	\N	\N	\N	\N	\N	\N
5409	54	8	EMPTY	\N	\N	\N	\N	\N	\N
5410	54	9	EMPTY	\N	\N	\N	\N	\N	\N
5411	54	10	EMPTY	\N	\N	\N	\N	\N	\N
5412	54	11	EMPTY	\N	\N	\N	\N	\N	\N
5413	54	12	EMPTY	\N	\N	\N	\N	\N	\N
5414	54	13	EMPTY	\N	\N	\N	\N	\N	\N
5415	54	14	EMPTY	\N	\N	\N	\N	\N	\N
5416	54	15	EMPTY	\N	\N	\N	\N	\N	\N
5417	54	16	EMPTY	\N	\N	\N	\N	\N	\N
5418	54	17	EMPTY	\N	\N	\N	\N	\N	\N
5419	54	18	EMPTY	\N	\N	\N	\N	\N	\N
5420	54	19	EMPTY	\N	\N	\N	\N	\N	\N
5421	54	20	EMPTY	\N	\N	\N	\N	\N	\N
5422	54	21	EMPTY	\N	\N	\N	\N	\N	\N
5423	54	22	EMPTY	\N	\N	\N	\N	\N	\N
5424	54	23	EMPTY	\N	\N	\N	\N	\N	\N
5425	54	24	EMPTY	\N	\N	\N	\N	\N	\N
5426	54	25	NPC	\N	\N	10	\N	Barbarian Camp (Lv 10)	\N
5427	54	26	EMPTY	\N	\N	\N	\N	\N	\N
5428	54	27	EMPTY	\N	\N	\N	\N	\N	\N
5429	54	28	EMPTY	\N	\N	\N	\N	\N	\N
5430	54	29	EMPTY	\N	\N	\N	\N	\N	\N
5431	54	30	EMPTY	\N	\N	\N	\N	\N	\N
5432	54	31	EMPTY	\N	\N	\N	\N	\N	\N
5433	54	32	EMPTY	\N	\N	\N	\N	\N	\N
5434	54	33	VALLEY	\N	\N	\N	\N	Valley (54, 33)	\N
5435	54	34	RESOURCE	stone	5	\N	\N	\N	\N
5436	54	35	EMPTY	\N	\N	\N	\N	\N	\N
5437	54	36	EMPTY	\N	\N	\N	\N	\N	\N
5438	54	37	EMPTY	\N	\N	\N	\N	\N	\N
5439	54	38	EMPTY	\N	\N	\N	\N	\N	\N
5440	54	39	EMPTY	\N	\N	\N	\N	\N	\N
5441	54	40	EMPTY	\N	\N	\N	\N	\N	\N
5442	54	41	VALLEY	\N	\N	\N	\N	Valley (54, 41)	\N
5443	54	42	EMPTY	\N	\N	\N	\N	\N	\N
5444	54	43	EMPTY	\N	\N	\N	\N	\N	\N
5445	54	44	EMPTY	\N	\N	\N	\N	\N	\N
5446	54	45	VALLEY	\N	\N	\N	\N	Valley (54, 45)	\N
5447	54	46	EMPTY	\N	\N	\N	\N	\N	\N
5448	54	47	EMPTY	\N	\N	\N	\N	\N	\N
5449	54	48	EMPTY	\N	\N	\N	\N	\N	\N
5450	54	49	EMPTY	\N	\N	\N	\N	\N	\N
5451	54	50	EMPTY	\N	\N	\N	\N	\N	\N
5452	54	51	EMPTY	\N	\N	\N	\N	\N	\N
5453	54	52	EMPTY	\N	\N	\N	\N	\N	\N
5454	54	53	EMPTY	\N	\N	\N	\N	\N	\N
5455	54	54	EMPTY	\N	\N	\N	\N	\N	\N
5456	54	55	EMPTY	\N	\N	\N	\N	\N	\N
5457	54	56	EMPTY	\N	\N	\N	\N	\N	\N
5458	54	57	RESOURCE	food	3	\N	\N	\N	\N
5459	54	58	EMPTY	\N	\N	\N	\N	\N	\N
5460	54	59	EMPTY	\N	\N	\N	\N	\N	\N
5461	54	60	EMPTY	\N	\N	\N	\N	\N	\N
5462	54	61	EMPTY	\N	\N	\N	\N	\N	\N
5463	54	62	EMPTY	\N	\N	\N	\N	\N	\N
5464	54	63	EMPTY	\N	\N	\N	\N	\N	\N
5465	54	64	EMPTY	\N	\N	\N	\N	\N	\N
5466	54	65	EMPTY	\N	\N	\N	\N	\N	\N
5467	54	66	EMPTY	\N	\N	\N	\N	\N	\N
5468	54	67	EMPTY	\N	\N	\N	\N	\N	\N
5469	54	68	EMPTY	\N	\N	\N	\N	\N	\N
5470	54	69	EMPTY	\N	\N	\N	\N	\N	\N
5471	54	70	EMPTY	\N	\N	\N	\N	\N	\N
5472	54	71	EMPTY	\N	\N	\N	\N	\N	\N
5473	54	72	EMPTY	\N	\N	\N	\N	\N	\N
5474	54	73	EMPTY	\N	\N	\N	\N	\N	\N
5475	54	74	EMPTY	\N	\N	\N	\N	\N	\N
5476	54	75	EMPTY	\N	\N	\N	\N	\N	\N
5477	54	76	VALLEY	\N	\N	\N	\N	Valley (54, 76)	\N
5478	54	77	NPC	\N	\N	9	\N	Barbarian Camp (Lv 9)	\N
5479	54	78	EMPTY	\N	\N	\N	\N	\N	\N
5480	54	79	EMPTY	\N	\N	\N	\N	\N	\N
5481	54	80	EMPTY	\N	\N	\N	\N	\N	\N
5482	54	81	EMPTY	\N	\N	\N	\N	\N	\N
5483	54	82	EMPTY	\N	\N	\N	\N	\N	\N
5484	54	83	EMPTY	\N	\N	\N	\N	\N	\N
5485	54	84	EMPTY	\N	\N	\N	\N	\N	\N
5486	54	85	EMPTY	\N	\N	\N	\N	\N	\N
5487	54	86	NPC	\N	\N	4	\N	Barbarian Camp (Lv 4)	\N
5488	54	87	EMPTY	\N	\N	\N	\N	\N	\N
5489	54	88	RESOURCE	food	1	\N	\N	\N	\N
5490	54	89	EMPTY	\N	\N	\N	\N	\N	\N
5491	54	90	EMPTY	\N	\N	\N	\N	\N	\N
5492	54	91	EMPTY	\N	\N	\N	\N	\N	\N
5493	54	92	EMPTY	\N	\N	\N	\N	\N	\N
5494	54	93	EMPTY	\N	\N	\N	\N	\N	\N
5495	54	94	EMPTY	\N	\N	\N	\N	\N	\N
5496	54	95	EMPTY	\N	\N	\N	\N	\N	\N
5497	54	96	EMPTY	\N	\N	\N	\N	\N	\N
5498	54	97	EMPTY	\N	\N	\N	\N	\N	\N
5499	54	98	RESOURCE	food	4	\N	\N	\N	\N
5500	54	99	EMPTY	\N	\N	\N	\N	\N	\N
5501	55	0	EMPTY	\N	\N	\N	\N	\N	\N
5502	55	1	EMPTY	\N	\N	\N	\N	\N	\N
5503	55	2	EMPTY	\N	\N	\N	\N	\N	\N
5504	55	3	EMPTY	\N	\N	\N	\N	\N	\N
5505	55	4	EMPTY	\N	\N	\N	\N	\N	\N
5506	55	5	EMPTY	\N	\N	\N	\N	\N	\N
5507	55	6	EMPTY	\N	\N	\N	\N	\N	\N
5508	55	7	EMPTY	\N	\N	\N	\N	\N	\N
5509	55	8	EMPTY	\N	\N	\N	\N	\N	\N
5510	55	9	EMPTY	\N	\N	\N	\N	\N	\N
5511	55	10	EMPTY	\N	\N	\N	\N	\N	\N
5512	55	11	RESOURCE	wood	2	\N	\N	\N	\N
5513	55	12	NPC	\N	\N	7	\N	Barbarian Camp (Lv 7)	\N
5514	55	13	EMPTY	\N	\N	\N	\N	\N	\N
5515	55	14	EMPTY	\N	\N	\N	\N	\N	\N
5516	55	15	EMPTY	\N	\N	\N	\N	\N	\N
5517	55	16	EMPTY	\N	\N	\N	\N	\N	\N
5518	55	17	RESOURCE	iron	5	\N	\N	\N	\N
5519	55	18	EMPTY	\N	\N	\N	\N	\N	\N
5520	55	19	EMPTY	\N	\N	\N	\N	\N	\N
5521	55	20	EMPTY	\N	\N	\N	\N	\N	\N
5522	55	21	EMPTY	\N	\N	\N	\N	\N	\N
5523	55	22	EMPTY	\N	\N	\N	\N	\N	\N
5524	55	23	EMPTY	\N	\N	\N	\N	\N	\N
5525	55	24	EMPTY	\N	\N	\N	\N	\N	\N
5526	55	25	EMPTY	\N	\N	\N	\N	\N	\N
5527	55	26	VALLEY	\N	\N	\N	\N	Valley (55, 26)	\N
5528	55	27	RESOURCE	iron	3	\N	\N	\N	\N
5529	55	28	VALLEY	\N	\N	\N	\N	Valley (55, 28)	\N
5530	55	29	EMPTY	\N	\N	\N	\N	\N	\N
5531	55	30	EMPTY	\N	\N	\N	\N	\N	\N
5532	55	31	EMPTY	\N	\N	\N	\N	\N	\N
5533	55	32	EMPTY	\N	\N	\N	\N	\N	\N
5534	55	33	VALLEY	\N	\N	\N	\N	Valley (55, 33)	\N
5535	55	34	EMPTY	\N	\N	\N	\N	\N	\N
5536	55	35	EMPTY	\N	\N	\N	\N	\N	\N
5537	55	36	EMPTY	\N	\N	\N	\N	\N	\N
5538	55	37	EMPTY	\N	\N	\N	\N	\N	\N
5539	55	38	EMPTY	\N	\N	\N	\N	\N	\N
5540	55	39	EMPTY	\N	\N	\N	\N	\N	\N
5541	55	40	VALLEY	\N	\N	\N	\N	Valley (55, 40)	\N
5542	55	41	EMPTY	\N	\N	\N	\N	\N	\N
5543	55	42	EMPTY	\N	\N	\N	\N	\N	\N
5544	55	43	EMPTY	\N	\N	\N	\N	\N	\N
5545	55	44	RESOURCE	iron	5	\N	\N	\N	\N
5546	55	45	RESOURCE	iron	2	\N	\N	\N	\N
5547	55	46	EMPTY	\N	\N	\N	\N	\N	\N
5548	55	47	EMPTY	\N	\N	\N	\N	\N	\N
5549	55	48	NPC	\N	\N	4	\N	Barbarian Camp (Lv 4)	\N
5550	55	49	EMPTY	\N	\N	\N	\N	\N	\N
5551	55	50	EMPTY	\N	\N	\N	\N	\N	\N
5552	55	51	EMPTY	\N	\N	\N	\N	\N	\N
5553	55	52	EMPTY	\N	\N	\N	\N	\N	\N
5554	55	53	EMPTY	\N	\N	\N	\N	\N	\N
5555	55	54	EMPTY	\N	\N	\N	\N	\N	\N
5556	55	55	EMPTY	\N	\N	\N	\N	\N	\N
5557	55	56	EMPTY	\N	\N	\N	\N	\N	\N
5558	55	57	EMPTY	\N	\N	\N	\N	\N	\N
5559	55	58	EMPTY	\N	\N	\N	\N	\N	\N
5560	55	59	EMPTY	\N	\N	\N	\N	\N	\N
5561	55	60	EMPTY	\N	\N	\N	\N	\N	\N
5562	55	61	EMPTY	\N	\N	\N	\N	\N	\N
5563	55	62	EMPTY	\N	\N	\N	\N	\N	\N
5564	55	63	RESOURCE	iron	3	\N	\N	\N	\N
5565	55	64	EMPTY	\N	\N	\N	\N	\N	\N
5566	55	65	EMPTY	\N	\N	\N	\N	\N	\N
5567	55	66	EMPTY	\N	\N	\N	\N	\N	\N
5568	55	67	EMPTY	\N	\N	\N	\N	\N	\N
5569	55	68	EMPTY	\N	\N	\N	\N	\N	\N
5570	55	69	EMPTY	\N	\N	\N	\N	\N	\N
5571	55	70	EMPTY	\N	\N	\N	\N	\N	\N
5572	55	71	RESOURCE	iron	2	\N	\N	\N	\N
5573	55	72	EMPTY	\N	\N	\N	\N	\N	\N
5574	55	73	NPC	\N	\N	6	\N	Barbarian Camp (Lv 6)	\N
5575	55	74	EMPTY	\N	\N	\N	\N	\N	\N
5576	55	75	EMPTY	\N	\N	\N	\N	\N	\N
5577	55	76	EMPTY	\N	\N	\N	\N	\N	\N
5578	55	77	EMPTY	\N	\N	\N	\N	\N	\N
5579	55	78	EMPTY	\N	\N	\N	\N	\N	\N
5580	55	79	EMPTY	\N	\N	\N	\N	\N	\N
5581	55	80	EMPTY	\N	\N	\N	\N	\N	\N
5582	55	81	EMPTY	\N	\N	\N	\N	\N	\N
5583	55	82	EMPTY	\N	\N	\N	\N	\N	\N
5584	55	83	RESOURCE	food	4	\N	\N	\N	\N
5585	55	84	EMPTY	\N	\N	\N	\N	\N	\N
5586	55	85	EMPTY	\N	\N	\N	\N	\N	\N
5587	55	86	NPC	\N	\N	8	\N	Barbarian Camp (Lv 8)	\N
5588	55	87	EMPTY	\N	\N	\N	\N	\N	\N
5589	55	88	NPC	\N	\N	8	\N	Barbarian Camp (Lv 8)	\N
5590	55	89	RESOURCE	stone	4	\N	\N	\N	\N
5591	55	90	EMPTY	\N	\N	\N	\N	\N	\N
5592	55	91	EMPTY	\N	\N	\N	\N	\N	\N
5593	55	92	EMPTY	\N	\N	\N	\N	\N	\N
5594	55	93	EMPTY	\N	\N	\N	\N	\N	\N
5595	55	94	EMPTY	\N	\N	\N	\N	\N	\N
5596	55	95	EMPTY	\N	\N	\N	\N	\N	\N
5597	55	96	EMPTY	\N	\N	\N	\N	\N	\N
5598	55	97	EMPTY	\N	\N	\N	\N	\N	\N
5599	55	98	EMPTY	\N	\N	\N	\N	\N	\N
5600	55	99	EMPTY	\N	\N	\N	\N	\N	\N
5601	56	0	EMPTY	\N	\N	\N	\N	\N	\N
5602	56	1	EMPTY	\N	\N	\N	\N	\N	\N
5603	56	2	EMPTY	\N	\N	\N	\N	\N	\N
5604	56	3	EMPTY	\N	\N	\N	\N	\N	\N
5605	56	4	EMPTY	\N	\N	\N	\N	\N	\N
5606	56	5	EMPTY	\N	\N	\N	\N	\N	\N
5607	56	6	EMPTY	\N	\N	\N	\N	\N	\N
5608	56	7	EMPTY	\N	\N	\N	\N	\N	\N
5609	56	8	EMPTY	\N	\N	\N	\N	\N	\N
5610	56	9	EMPTY	\N	\N	\N	\N	\N	\N
5611	56	10	EMPTY	\N	\N	\N	\N	\N	\N
5612	56	11	VALLEY	\N	\N	\N	\N	Valley (56, 11)	\N
5613	56	12	EMPTY	\N	\N	\N	\N	\N	\N
5614	56	13	EMPTY	\N	\N	\N	\N	\N	\N
5615	56	14	VALLEY	\N	\N	\N	\N	Valley (56, 14)	\N
5616	56	15	EMPTY	\N	\N	\N	\N	\N	\N
5617	56	16	EMPTY	\N	\N	\N	\N	\N	\N
5618	56	17	EMPTY	\N	\N	\N	\N	\N	\N
5619	56	18	EMPTY	\N	\N	\N	\N	\N	\N
5620	56	19	EMPTY	\N	\N	\N	\N	\N	\N
5621	56	20	EMPTY	\N	\N	\N	\N	\N	\N
5622	56	21	EMPTY	\N	\N	\N	\N	\N	\N
5623	56	22	RESOURCE	wood	2	\N	\N	\N	\N
5624	56	23	EMPTY	\N	\N	\N	\N	\N	\N
5625	56	24	EMPTY	\N	\N	\N	\N	\N	\N
5626	56	25	NPC	\N	\N	9	\N	Barbarian Camp (Lv 9)	\N
5627	56	26	EMPTY	\N	\N	\N	\N	\N	\N
5628	56	27	EMPTY	\N	\N	\N	\N	\N	\N
5629	56	28	EMPTY	\N	\N	\N	\N	\N	\N
5630	56	29	EMPTY	\N	\N	\N	\N	\N	\N
5631	56	30	EMPTY	\N	\N	\N	\N	\N	\N
5632	56	31	EMPTY	\N	\N	\N	\N	\N	\N
5633	56	32	EMPTY	\N	\N	\N	\N	\N	\N
5634	56	33	EMPTY	\N	\N	\N	\N	\N	\N
5635	56	34	EMPTY	\N	\N	\N	\N	\N	\N
5636	56	35	EMPTY	\N	\N	\N	\N	\N	\N
5637	56	36	EMPTY	\N	\N	\N	\N	\N	\N
5638	56	37	EMPTY	\N	\N	\N	\N	\N	\N
5639	56	38	EMPTY	\N	\N	\N	\N	\N	\N
5640	56	39	RESOURCE	food	1	\N	\N	\N	\N
5641	56	40	EMPTY	\N	\N	\N	\N	\N	\N
5642	56	41	EMPTY	\N	\N	\N	\N	\N	\N
5643	56	42	RESOURCE	iron	2	\N	\N	\N	\N
5644	56	43	EMPTY	\N	\N	\N	\N	\N	\N
5645	56	44	NPC	\N	\N	6	\N	Barbarian Camp (Lv 6)	\N
5646	56	45	EMPTY	\N	\N	\N	\N	\N	\N
5647	56	46	EMPTY	\N	\N	\N	\N	\N	\N
5648	56	47	EMPTY	\N	\N	\N	\N	\N	\N
5649	56	48	EMPTY	\N	\N	\N	\N	\N	\N
5650	56	49	EMPTY	\N	\N	\N	\N	\N	\N
5651	56	50	EMPTY	\N	\N	\N	\N	\N	\N
5652	56	51	EMPTY	\N	\N	\N	\N	\N	\N
5653	56	52	EMPTY	\N	\N	\N	\N	\N	\N
5654	56	53	EMPTY	\N	\N	\N	\N	\N	\N
5655	56	54	EMPTY	\N	\N	\N	\N	\N	\N
5656	56	55	EMPTY	\N	\N	\N	\N	\N	\N
5657	56	56	EMPTY	\N	\N	\N	\N	\N	\N
5658	56	57	EMPTY	\N	\N	\N	\N	\N	\N
5659	56	58	EMPTY	\N	\N	\N	\N	\N	\N
5660	56	59	EMPTY	\N	\N	\N	\N	\N	\N
5661	56	60	EMPTY	\N	\N	\N	\N	\N	\N
5662	56	61	EMPTY	\N	\N	\N	\N	\N	\N
5663	56	62	VALLEY	\N	\N	\N	\N	Valley (56, 62)	\N
5664	56	63	EMPTY	\N	\N	\N	\N	\N	\N
5665	56	64	EMPTY	\N	\N	\N	\N	\N	\N
5666	56	65	EMPTY	\N	\N	\N	\N	\N	\N
5667	56	66	EMPTY	\N	\N	\N	\N	\N	\N
5668	56	67	EMPTY	\N	\N	\N	\N	\N	\N
5669	56	68	EMPTY	\N	\N	\N	\N	\N	\N
5670	56	69	RESOURCE	food	4	\N	\N	\N	\N
5671	56	70	EMPTY	\N	\N	\N	\N	\N	\N
5672	56	71	EMPTY	\N	\N	\N	\N	\N	\N
5673	56	72	EMPTY	\N	\N	\N	\N	\N	\N
5674	56	73	EMPTY	\N	\N	\N	\N	\N	\N
5675	56	74	EMPTY	\N	\N	\N	\N	\N	\N
5676	56	75	EMPTY	\N	\N	\N	\N	\N	\N
5677	56	76	EMPTY	\N	\N	\N	\N	\N	\N
5678	56	77	EMPTY	\N	\N	\N	\N	\N	\N
5679	56	78	NPC	\N	\N	8	\N	Barbarian Camp (Lv 8)	\N
5680	56	79	EMPTY	\N	\N	\N	\N	\N	\N
5681	56	80	EMPTY	\N	\N	\N	\N	\N	\N
5682	56	81	EMPTY	\N	\N	\N	\N	\N	\N
5683	56	82	EMPTY	\N	\N	\N	\N	\N	\N
5684	56	83	EMPTY	\N	\N	\N	\N	\N	\N
5685	56	84	RESOURCE	food	1	\N	\N	\N	\N
5686	56	85	EMPTY	\N	\N	\N	\N	\N	\N
5687	56	86	EMPTY	\N	\N	\N	\N	\N	\N
5688	56	87	EMPTY	\N	\N	\N	\N	\N	\N
5689	56	88	EMPTY	\N	\N	\N	\N	\N	\N
5690	56	89	VALLEY	\N	\N	\N	\N	Valley (56, 89)	\N
5691	56	90	EMPTY	\N	\N	\N	\N	\N	\N
5692	56	91	EMPTY	\N	\N	\N	\N	\N	\N
5693	56	92	EMPTY	\N	\N	\N	\N	\N	\N
5694	56	93	RESOURCE	iron	2	\N	\N	\N	\N
5695	56	94	EMPTY	\N	\N	\N	\N	\N	\N
5696	56	95	NPC	\N	\N	7	\N	Barbarian Camp (Lv 7)	\N
5697	56	96	EMPTY	\N	\N	\N	\N	\N	\N
5698	56	97	EMPTY	\N	\N	\N	\N	\N	\N
5699	56	98	EMPTY	\N	\N	\N	\N	\N	\N
5700	56	99	EMPTY	\N	\N	\N	\N	\N	\N
5701	57	0	EMPTY	\N	\N	\N	\N	\N	\N
5702	57	1	EMPTY	\N	\N	\N	\N	\N	\N
5703	57	2	EMPTY	\N	\N	\N	\N	\N	\N
5704	57	3	EMPTY	\N	\N	\N	\N	\N	\N
5705	57	4	VALLEY	\N	\N	\N	\N	Valley (57, 4)	\N
5706	57	5	EMPTY	\N	\N	\N	\N	\N	\N
5707	57	6	EMPTY	\N	\N	\N	\N	\N	\N
5708	57	7	EMPTY	\N	\N	\N	\N	\N	\N
5709	57	8	EMPTY	\N	\N	\N	\N	\N	\N
5710	57	9	EMPTY	\N	\N	\N	\N	\N	\N
5711	57	10	EMPTY	\N	\N	\N	\N	\N	\N
5712	57	11	EMPTY	\N	\N	\N	\N	\N	\N
5713	57	12	EMPTY	\N	\N	\N	\N	\N	\N
5714	57	13	EMPTY	\N	\N	\N	\N	\N	\N
5715	57	14	EMPTY	\N	\N	\N	\N	\N	\N
5716	57	15	EMPTY	\N	\N	\N	\N	\N	\N
5717	57	16	EMPTY	\N	\N	\N	\N	\N	\N
5718	57	17	NPC	\N	\N	6	\N	Barbarian Camp (Lv 6)	\N
5719	57	18	EMPTY	\N	\N	\N	\N	\N	\N
5720	57	19	EMPTY	\N	\N	\N	\N	\N	\N
5721	57	20	EMPTY	\N	\N	\N	\N	\N	\N
5722	57	21	EMPTY	\N	\N	\N	\N	\N	\N
5723	57	22	EMPTY	\N	\N	\N	\N	\N	\N
5724	57	23	EMPTY	\N	\N	\N	\N	\N	\N
5725	57	24	EMPTY	\N	\N	\N	\N	\N	\N
5726	57	25	EMPTY	\N	\N	\N	\N	\N	\N
5727	57	26	EMPTY	\N	\N	\N	\N	\N	\N
5728	57	27	EMPTY	\N	\N	\N	\N	\N	\N
5729	57	28	EMPTY	\N	\N	\N	\N	\N	\N
5730	57	29	EMPTY	\N	\N	\N	\N	\N	\N
5731	57	30	EMPTY	\N	\N	\N	\N	\N	\N
5732	57	31	NPC	\N	\N	2	\N	Barbarian Camp (Lv 2)	\N
5733	57	32	EMPTY	\N	\N	\N	\N	\N	\N
5734	57	33	EMPTY	\N	\N	\N	\N	\N	\N
5735	57	34	RESOURCE	food	4	\N	\N	\N	\N
5736	57	35	EMPTY	\N	\N	\N	\N	\N	\N
5737	57	36	RESOURCE	wood	2	\N	\N	\N	\N
5738	57	37	EMPTY	\N	\N	\N	\N	\N	\N
5739	57	38	EMPTY	\N	\N	\N	\N	\N	\N
5740	57	39	EMPTY	\N	\N	\N	\N	\N	\N
5741	57	40	EMPTY	\N	\N	\N	\N	\N	\N
5742	57	41	EMPTY	\N	\N	\N	\N	\N	\N
5743	57	42	EMPTY	\N	\N	\N	\N	\N	\N
5744	57	43	EMPTY	\N	\N	\N	\N	\N	\N
5745	57	44	EMPTY	\N	\N	\N	\N	\N	\N
5746	57	45	EMPTY	\N	\N	\N	\N	\N	\N
5747	57	46	EMPTY	\N	\N	\N	\N	\N	\N
5748	57	47	RESOURCE	food	1	\N	\N	\N	\N
5749	57	48	EMPTY	\N	\N	\N	\N	\N	\N
5750	57	49	EMPTY	\N	\N	\N	\N	\N	\N
5751	57	50	EMPTY	\N	\N	\N	\N	\N	\N
5752	57	51	EMPTY	\N	\N	\N	\N	\N	\N
5753	57	52	RESOURCE	wood	4	\N	\N	\N	\N
5754	57	53	NPC	\N	\N	8	\N	Barbarian Camp (Lv 8)	\N
5755	57	54	EMPTY	\N	\N	\N	\N	\N	\N
5756	57	55	EMPTY	\N	\N	\N	\N	\N	\N
5757	57	56	EMPTY	\N	\N	\N	\N	\N	\N
5758	57	57	EMPTY	\N	\N	\N	\N	\N	\N
5759	57	58	EMPTY	\N	\N	\N	\N	\N	\N
5760	57	59	EMPTY	\N	\N	\N	\N	\N	\N
5761	57	60	EMPTY	\N	\N	\N	\N	\N	\N
5762	57	61	EMPTY	\N	\N	\N	\N	\N	\N
5763	57	62	EMPTY	\N	\N	\N	\N	\N	\N
5764	57	63	EMPTY	\N	\N	\N	\N	\N	\N
5765	57	64	NPC	\N	\N	2	\N	Barbarian Camp (Lv 2)	\N
5766	57	65	EMPTY	\N	\N	\N	\N	\N	\N
5767	57	66	NPC	\N	\N	2	\N	Barbarian Camp (Lv 2)	\N
5768	57	67	EMPTY	\N	\N	\N	\N	\N	\N
5769	57	68	EMPTY	\N	\N	\N	\N	\N	\N
5770	57	69	EMPTY	\N	\N	\N	\N	\N	\N
5771	57	70	EMPTY	\N	\N	\N	\N	\N	\N
5772	57	71	EMPTY	\N	\N	\N	\N	\N	\N
5773	57	72	EMPTY	\N	\N	\N	\N	\N	\N
5774	57	73	EMPTY	\N	\N	\N	\N	\N	\N
5775	57	74	EMPTY	\N	\N	\N	\N	\N	\N
5776	57	75	EMPTY	\N	\N	\N	\N	\N	\N
5777	57	76	EMPTY	\N	\N	\N	\N	\N	\N
5778	57	77	EMPTY	\N	\N	\N	\N	\N	\N
5779	57	78	EMPTY	\N	\N	\N	\N	\N	\N
5780	57	79	EMPTY	\N	\N	\N	\N	\N	\N
5781	57	80	RESOURCE	food	2	\N	\N	\N	\N
5782	57	81	EMPTY	\N	\N	\N	\N	\N	\N
5783	57	82	EMPTY	\N	\N	\N	\N	\N	\N
5784	57	83	EMPTY	\N	\N	\N	\N	\N	\N
5785	57	84	EMPTY	\N	\N	\N	\N	\N	\N
5786	57	85	EMPTY	\N	\N	\N	\N	\N	\N
5787	57	86	EMPTY	\N	\N	\N	\N	\N	\N
5788	57	87	EMPTY	\N	\N	\N	\N	\N	\N
5789	57	88	RESOURCE	iron	1	\N	\N	\N	\N
5790	57	89	EMPTY	\N	\N	\N	\N	\N	\N
5791	57	90	EMPTY	\N	\N	\N	\N	\N	\N
5792	57	91	EMPTY	\N	\N	\N	\N	\N	\N
5793	57	92	EMPTY	\N	\N	\N	\N	\N	\N
5794	57	93	EMPTY	\N	\N	\N	\N	\N	\N
5795	57	94	EMPTY	\N	\N	\N	\N	\N	\N
5796	57	95	EMPTY	\N	\N	\N	\N	\N	\N
5797	57	96	EMPTY	\N	\N	\N	\N	\N	\N
5798	57	97	EMPTY	\N	\N	\N	\N	\N	\N
5799	57	98	RESOURCE	iron	3	\N	\N	\N	\N
5800	57	99	EMPTY	\N	\N	\N	\N	\N	\N
5801	58	0	EMPTY	\N	\N	\N	\N	\N	\N
5802	58	1	EMPTY	\N	\N	\N	\N	\N	\N
5803	58	2	EMPTY	\N	\N	\N	\N	\N	\N
5804	58	3	VALLEY	\N	\N	\N	\N	Valley (58, 3)	\N
5805	58	4	EMPTY	\N	\N	\N	\N	\N	\N
5806	58	5	EMPTY	\N	\N	\N	\N	\N	\N
5807	58	6	RESOURCE	food	1	\N	\N	\N	\N
5808	58	7	EMPTY	\N	\N	\N	\N	\N	\N
5809	58	8	VALLEY	\N	\N	\N	\N	Valley (58, 8)	\N
5810	58	9	VALLEY	\N	\N	\N	\N	Valley (58, 9)	\N
5811	58	10	EMPTY	\N	\N	\N	\N	\N	\N
5812	58	11	EMPTY	\N	\N	\N	\N	\N	\N
5813	58	12	RESOURCE	food	1	\N	\N	\N	\N
5814	58	13	EMPTY	\N	\N	\N	\N	\N	\N
5815	58	14	RESOURCE	stone	2	\N	\N	\N	\N
5816	58	15	EMPTY	\N	\N	\N	\N	\N	\N
5817	58	16	EMPTY	\N	\N	\N	\N	\N	\N
5818	58	17	EMPTY	\N	\N	\N	\N	\N	\N
5819	58	18	EMPTY	\N	\N	\N	\N	\N	\N
5820	58	19	EMPTY	\N	\N	\N	\N	\N	\N
5821	58	20	EMPTY	\N	\N	\N	\N	\N	\N
5822	58	21	EMPTY	\N	\N	\N	\N	\N	\N
5823	58	22	EMPTY	\N	\N	\N	\N	\N	\N
5824	58	23	EMPTY	\N	\N	\N	\N	\N	\N
5825	58	24	EMPTY	\N	\N	\N	\N	\N	\N
5826	58	25	EMPTY	\N	\N	\N	\N	\N	\N
5827	58	26	EMPTY	\N	\N	\N	\N	\N	\N
5828	58	27	EMPTY	\N	\N	\N	\N	\N	\N
5829	58	28	EMPTY	\N	\N	\N	\N	\N	\N
5830	58	29	EMPTY	\N	\N	\N	\N	\N	\N
5831	58	30	NPC	\N	\N	10	\N	Barbarian Camp (Lv 10)	\N
5832	58	31	EMPTY	\N	\N	\N	\N	\N	\N
5833	58	32	NPC	\N	\N	5	\N	Barbarian Camp (Lv 5)	\N
5834	58	33	RESOURCE	iron	2	\N	\N	\N	\N
5835	58	34	EMPTY	\N	\N	\N	\N	\N	\N
5836	58	35	EMPTY	\N	\N	\N	\N	\N	\N
5837	58	36	EMPTY	\N	\N	\N	\N	\N	\N
5838	58	37	EMPTY	\N	\N	\N	\N	\N	\N
5839	58	38	EMPTY	\N	\N	\N	\N	\N	\N
5840	58	39	EMPTY	\N	\N	\N	\N	\N	\N
5841	58	40	EMPTY	\N	\N	\N	\N	\N	\N
5842	58	41	EMPTY	\N	\N	\N	\N	\N	\N
5843	58	42	EMPTY	\N	\N	\N	\N	\N	\N
5844	58	43	EMPTY	\N	\N	\N	\N	\N	\N
5845	58	44	NPC	\N	\N	4	\N	Barbarian Camp (Lv 4)	\N
5846	58	45	RESOURCE	stone	4	\N	\N	\N	\N
5847	58	46	RESOURCE	wood	4	\N	\N	\N	\N
5848	58	47	EMPTY	\N	\N	\N	\N	\N	\N
5849	58	48	EMPTY	\N	\N	\N	\N	\N	\N
5850	58	49	EMPTY	\N	\N	\N	\N	\N	\N
5851	58	50	EMPTY	\N	\N	\N	\N	\N	\N
5852	58	51	EMPTY	\N	\N	\N	\N	\N	\N
5853	58	52	EMPTY	\N	\N	\N	\N	\N	\N
5854	58	53	EMPTY	\N	\N	\N	\N	\N	\N
5855	58	54	RESOURCE	wood	2	\N	\N	\N	\N
5856	58	55	NPC	\N	\N	8	\N	Barbarian Camp (Lv 8)	\N
5857	58	56	EMPTY	\N	\N	\N	\N	\N	\N
5858	58	57	EMPTY	\N	\N	\N	\N	\N	\N
5859	58	58	EMPTY	\N	\N	\N	\N	\N	\N
5860	58	59	RESOURCE	iron	3	\N	\N	\N	\N
5861	58	60	RESOURCE	stone	3	\N	\N	\N	\N
5862	58	61	EMPTY	\N	\N	\N	\N	\N	\N
5863	58	62	EMPTY	\N	\N	\N	\N	\N	\N
5864	58	63	RESOURCE	wood	4	\N	\N	\N	\N
5865	58	64	EMPTY	\N	\N	\N	\N	\N	\N
5866	58	65	NPC	\N	\N	6	\N	Barbarian Camp (Lv 6)	\N
5867	58	66	EMPTY	\N	\N	\N	\N	\N	\N
5868	58	67	EMPTY	\N	\N	\N	\N	\N	\N
5869	58	68	EMPTY	\N	\N	\N	\N	\N	\N
5870	58	69	NPC	\N	\N	6	\N	Barbarian Camp (Lv 6)	\N
5871	58	70	EMPTY	\N	\N	\N	\N	\N	\N
5872	58	71	EMPTY	\N	\N	\N	\N	\N	\N
5873	58	72	RESOURCE	wood	3	\N	\N	\N	\N
5874	58	73	RESOURCE	iron	5	\N	\N	\N	\N
5875	58	74	EMPTY	\N	\N	\N	\N	\N	\N
5876	58	75	EMPTY	\N	\N	\N	\N	\N	\N
5877	58	76	EMPTY	\N	\N	\N	\N	\N	\N
5878	58	77	EMPTY	\N	\N	\N	\N	\N	\N
5879	58	78	EMPTY	\N	\N	\N	\N	\N	\N
5880	58	79	EMPTY	\N	\N	\N	\N	\N	\N
5881	58	80	EMPTY	\N	\N	\N	\N	\N	\N
5882	58	81	EMPTY	\N	\N	\N	\N	\N	\N
5883	58	82	RESOURCE	iron	4	\N	\N	\N	\N
5884	58	83	EMPTY	\N	\N	\N	\N	\N	\N
5885	58	84	EMPTY	\N	\N	\N	\N	\N	\N
5886	58	85	EMPTY	\N	\N	\N	\N	\N	\N
5887	58	86	EMPTY	\N	\N	\N	\N	\N	\N
5888	58	87	EMPTY	\N	\N	\N	\N	\N	\N
5889	58	88	EMPTY	\N	\N	\N	\N	\N	\N
5890	58	89	EMPTY	\N	\N	\N	\N	\N	\N
5891	58	90	NPC	\N	\N	6	\N	Barbarian Camp (Lv 6)	\N
5892	58	91	EMPTY	\N	\N	\N	\N	\N	\N
5893	58	92	EMPTY	\N	\N	\N	\N	\N	\N
5894	58	93	EMPTY	\N	\N	\N	\N	\N	\N
5895	58	94	EMPTY	\N	\N	\N	\N	\N	\N
5896	58	95	EMPTY	\N	\N	\N	\N	\N	\N
5897	58	96	NPC	\N	\N	7	\N	Barbarian Camp (Lv 7)	\N
5898	58	97	EMPTY	\N	\N	\N	\N	\N	\N
5899	58	98	EMPTY	\N	\N	\N	\N	\N	\N
5900	58	99	EMPTY	\N	\N	\N	\N	\N	\N
5901	59	0	EMPTY	\N	\N	\N	\N	\N	\N
5902	59	1	RESOURCE	iron	1	\N	\N	\N	\N
5903	59	2	EMPTY	\N	\N	\N	\N	\N	\N
5904	59	3	EMPTY	\N	\N	\N	\N	\N	\N
5905	59	4	EMPTY	\N	\N	\N	\N	\N	\N
5906	59	5	EMPTY	\N	\N	\N	\N	\N	\N
5907	59	6	EMPTY	\N	\N	\N	\N	\N	\N
5908	59	7	EMPTY	\N	\N	\N	\N	\N	\N
5909	59	8	EMPTY	\N	\N	\N	\N	\N	\N
5910	59	9	VALLEY	\N	\N	\N	\N	Valley (59, 9)	\N
5911	59	10	EMPTY	\N	\N	\N	\N	\N	\N
5912	59	11	NPC	\N	\N	4	\N	Barbarian Camp (Lv 4)	\N
5913	59	12	EMPTY	\N	\N	\N	\N	\N	\N
5914	59	13	EMPTY	\N	\N	\N	\N	\N	\N
5915	59	14	NPC	\N	\N	4	\N	Barbarian Camp (Lv 4)	\N
5916	59	15	EMPTY	\N	\N	\N	\N	\N	\N
5917	59	16	RESOURCE	wood	4	\N	\N	\N	\N
5918	59	17	EMPTY	\N	\N	\N	\N	\N	\N
5919	59	18	EMPTY	\N	\N	\N	\N	\N	\N
5920	59	19	EMPTY	\N	\N	\N	\N	\N	\N
5921	59	20	EMPTY	\N	\N	\N	\N	\N	\N
5922	59	21	NPC	\N	\N	2	\N	Barbarian Camp (Lv 2)	\N
5923	59	22	EMPTY	\N	\N	\N	\N	\N	\N
5924	59	23	EMPTY	\N	\N	\N	\N	\N	\N
5925	59	24	EMPTY	\N	\N	\N	\N	\N	\N
5926	59	25	EMPTY	\N	\N	\N	\N	\N	\N
5927	59	26	EMPTY	\N	\N	\N	\N	\N	\N
5928	59	27	EMPTY	\N	\N	\N	\N	\N	\N
5929	59	28	EMPTY	\N	\N	\N	\N	\N	\N
5930	59	29	RESOURCE	wood	3	\N	\N	\N	\N
5931	59	30	EMPTY	\N	\N	\N	\N	\N	\N
5932	59	31	EMPTY	\N	\N	\N	\N	\N	\N
5933	59	32	EMPTY	\N	\N	\N	\N	\N	\N
5934	59	33	EMPTY	\N	\N	\N	\N	\N	\N
5935	59	34	EMPTY	\N	\N	\N	\N	\N	\N
5936	59	35	EMPTY	\N	\N	\N	\N	\N	\N
5937	59	36	EMPTY	\N	\N	\N	\N	\N	\N
5938	59	37	EMPTY	\N	\N	\N	\N	\N	\N
5939	59	38	NPC	\N	\N	8	\N	Barbarian Camp (Lv 8)	\N
5940	59	39	EMPTY	\N	\N	\N	\N	\N	\N
5941	59	40	NPC	\N	\N	7	\N	Barbarian Camp (Lv 7)	\N
5942	59	41	RESOURCE	food	4	\N	\N	\N	\N
5943	59	42	EMPTY	\N	\N	\N	\N	\N	\N
5944	59	43	EMPTY	\N	\N	\N	\N	\N	\N
5945	59	44	EMPTY	\N	\N	\N	\N	\N	\N
5946	59	45	RESOURCE	food	3	\N	\N	\N	\N
5947	59	46	EMPTY	\N	\N	\N	\N	\N	\N
5948	59	47	EMPTY	\N	\N	\N	\N	\N	\N
5949	59	48	EMPTY	\N	\N	\N	\N	\N	\N
5950	59	49	EMPTY	\N	\N	\N	\N	\N	\N
5951	59	50	EMPTY	\N	\N	\N	\N	\N	\N
5952	59	51	EMPTY	\N	\N	\N	\N	\N	\N
5953	59	52	EMPTY	\N	\N	\N	\N	\N	\N
5954	59	53	EMPTY	\N	\N	\N	\N	\N	\N
5955	59	54	EMPTY	\N	\N	\N	\N	\N	\N
5956	59	55	EMPTY	\N	\N	\N	\N	\N	\N
5957	59	56	EMPTY	\N	\N	\N	\N	\N	\N
5958	59	57	EMPTY	\N	\N	\N	\N	\N	\N
5959	59	58	EMPTY	\N	\N	\N	\N	\N	\N
5960	59	59	EMPTY	\N	\N	\N	\N	\N	\N
5961	59	60	NPC	\N	\N	3	\N	Barbarian Camp (Lv 3)	\N
5962	59	61	EMPTY	\N	\N	\N	\N	\N	\N
5963	59	62	EMPTY	\N	\N	\N	\N	\N	\N
5964	59	63	EMPTY	\N	\N	\N	\N	\N	\N
5965	59	64	EMPTY	\N	\N	\N	\N	\N	\N
5966	59	65	VALLEY	\N	\N	\N	\N	Valley (59, 65)	\N
5967	59	66	EMPTY	\N	\N	\N	\N	\N	\N
5968	59	67	EMPTY	\N	\N	\N	\N	\N	\N
5969	59	68	NPC	\N	\N	10	\N	Barbarian Camp (Lv 10)	\N
5970	59	69	EMPTY	\N	\N	\N	\N	\N	\N
5971	59	70	EMPTY	\N	\N	\N	\N	\N	\N
5972	59	71	RESOURCE	wood	3	\N	\N	\N	\N
5973	59	72	EMPTY	\N	\N	\N	\N	\N	\N
5974	59	73	EMPTY	\N	\N	\N	\N	\N	\N
5975	59	74	EMPTY	\N	\N	\N	\N	\N	\N
5976	59	75	EMPTY	\N	\N	\N	\N	\N	\N
5977	59	76	RESOURCE	stone	1	\N	\N	\N	\N
5978	59	77	EMPTY	\N	\N	\N	\N	\N	\N
5979	59	78	EMPTY	\N	\N	\N	\N	\N	\N
5980	59	79	EMPTY	\N	\N	\N	\N	\N	\N
5981	59	80	EMPTY	\N	\N	\N	\N	\N	\N
5982	59	81	EMPTY	\N	\N	\N	\N	\N	\N
5983	59	82	EMPTY	\N	\N	\N	\N	\N	\N
5984	59	83	EMPTY	\N	\N	\N	\N	\N	\N
5985	59	84	EMPTY	\N	\N	\N	\N	\N	\N
5986	59	85	EMPTY	\N	\N	\N	\N	\N	\N
5987	59	86	NPC	\N	\N	3	\N	Barbarian Camp (Lv 3)	\N
5988	59	87	EMPTY	\N	\N	\N	\N	\N	\N
5989	59	88	EMPTY	\N	\N	\N	\N	\N	\N
5990	59	89	EMPTY	\N	\N	\N	\N	\N	\N
5991	59	90	EMPTY	\N	\N	\N	\N	\N	\N
5992	59	91	EMPTY	\N	\N	\N	\N	\N	\N
5993	59	92	RESOURCE	wood	3	\N	\N	\N	\N
5994	59	93	EMPTY	\N	\N	\N	\N	\N	\N
5995	59	94	EMPTY	\N	\N	\N	\N	\N	\N
5996	59	95	RESOURCE	iron	2	\N	\N	\N	\N
5997	59	96	NPC	\N	\N	9	\N	Barbarian Camp (Lv 9)	\N
5998	59	97	EMPTY	\N	\N	\N	\N	\N	\N
5999	59	98	EMPTY	\N	\N	\N	\N	\N	\N
6000	59	99	EMPTY	\N	\N	\N	\N	\N	\N
6001	60	0	EMPTY	\N	\N	\N	\N	\N	\N
6003	60	2	NPC	\N	\N	5	\N	Barbarian Camp (Lv 5)	\N
6004	60	3	VALLEY	\N	\N	\N	\N	Valley (60, 3)	\N
6005	60	4	EMPTY	\N	\N	\N	\N	\N	\N
6006	60	5	EMPTY	\N	\N	\N	\N	\N	\N
6007	60	6	EMPTY	\N	\N	\N	\N	\N	\N
6008	60	7	RESOURCE	food	5	\N	\N	\N	\N
6009	60	8	EMPTY	\N	\N	\N	\N	\N	\N
6010	60	9	EMPTY	\N	\N	\N	\N	\N	\N
6011	60	10	EMPTY	\N	\N	\N	\N	\N	\N
6012	60	11	EMPTY	\N	\N	\N	\N	\N	\N
6013	60	12	EMPTY	\N	\N	\N	\N	\N	\N
6014	60	13	EMPTY	\N	\N	\N	\N	\N	\N
6015	60	14	EMPTY	\N	\N	\N	\N	\N	\N
6016	60	15	EMPTY	\N	\N	\N	\N	\N	\N
6017	60	16	VALLEY	\N	\N	\N	\N	Valley (60, 16)	\N
6018	60	17	EMPTY	\N	\N	\N	\N	\N	\N
6019	60	18	EMPTY	\N	\N	\N	\N	\N	\N
6020	60	19	NPC	\N	\N	8	\N	Barbarian Camp (Lv 8)	\N
6021	60	20	EMPTY	\N	\N	\N	\N	\N	\N
6022	60	21	EMPTY	\N	\N	\N	\N	\N	\N
6023	60	22	EMPTY	\N	\N	\N	\N	\N	\N
6024	60	23	EMPTY	\N	\N	\N	\N	\N	\N
6025	60	24	NPC	\N	\N	4	\N	Barbarian Camp (Lv 4)	\N
6026	60	25	EMPTY	\N	\N	\N	\N	\N	\N
6027	60	26	NPC	\N	\N	7	\N	Barbarian Camp (Lv 7)	\N
6028	60	27	EMPTY	\N	\N	\N	\N	\N	\N
6029	60	28	EMPTY	\N	\N	\N	\N	\N	\N
6030	60	29	EMPTY	\N	\N	\N	\N	\N	\N
6031	60	30	EMPTY	\N	\N	\N	\N	\N	\N
6032	60	31	EMPTY	\N	\N	\N	\N	\N	\N
6033	60	32	EMPTY	\N	\N	\N	\N	\N	\N
6034	60	33	EMPTY	\N	\N	\N	\N	\N	\N
6035	60	34	EMPTY	\N	\N	\N	\N	\N	\N
6036	60	35	RESOURCE	food	1	\N	\N	\N	\N
6037	60	36	EMPTY	\N	\N	\N	\N	\N	\N
6038	60	37	EMPTY	\N	\N	\N	\N	\N	\N
6039	60	38	RESOURCE	wood	1	\N	\N	\N	\N
6040	60	39	EMPTY	\N	\N	\N	\N	\N	\N
6041	60	40	EMPTY	\N	\N	\N	\N	\N	\N
6042	60	41	EMPTY	\N	\N	\N	\N	\N	\N
6043	60	42	EMPTY	\N	\N	\N	\N	\N	\N
6044	60	43	EMPTY	\N	\N	\N	\N	\N	\N
6045	60	44	EMPTY	\N	\N	\N	\N	\N	\N
6046	60	45	EMPTY	\N	\N	\N	\N	\N	\N
6047	60	46	EMPTY	\N	\N	\N	\N	\N	\N
6048	60	47	EMPTY	\N	\N	\N	\N	\N	\N
6049	60	48	EMPTY	\N	\N	\N	\N	\N	\N
6050	60	49	EMPTY	\N	\N	\N	\N	\N	\N
6051	60	50	EMPTY	\N	\N	\N	\N	\N	\N
6052	60	51	EMPTY	\N	\N	\N	\N	\N	\N
6053	60	52	EMPTY	\N	\N	\N	\N	\N	\N
6054	60	53	EMPTY	\N	\N	\N	\N	\N	\N
6055	60	54	EMPTY	\N	\N	\N	\N	\N	\N
6056	60	55	EMPTY	\N	\N	\N	\N	\N	\N
6057	60	56	EMPTY	\N	\N	\N	\N	\N	\N
6058	60	57	EMPTY	\N	\N	\N	\N	\N	\N
6059	60	58	EMPTY	\N	\N	\N	\N	\N	\N
6060	60	59	EMPTY	\N	\N	\N	\N	\N	\N
6061	60	60	VALLEY	\N	\N	\N	\N	Valley (60, 60)	\N
6062	60	61	EMPTY	\N	\N	\N	\N	\N	\N
6063	60	62	EMPTY	\N	\N	\N	\N	\N	\N
6064	60	63	EMPTY	\N	\N	\N	\N	\N	\N
6065	60	64	EMPTY	\N	\N	\N	\N	\N	\N
6066	60	65	EMPTY	\N	\N	\N	\N	\N	\N
6067	60	66	EMPTY	\N	\N	\N	\N	\N	\N
6068	60	67	VALLEY	\N	\N	\N	\N	Valley (60, 67)	\N
6069	60	68	EMPTY	\N	\N	\N	\N	\N	\N
6070	60	69	EMPTY	\N	\N	\N	\N	\N	\N
6071	60	70	NPC	\N	\N	8	\N	Barbarian Camp (Lv 8)	\N
6072	60	71	EMPTY	\N	\N	\N	\N	\N	\N
6073	60	72	EMPTY	\N	\N	\N	\N	\N	\N
6074	60	73	RESOURCE	wood	5	\N	\N	\N	\N
6075	60	74	EMPTY	\N	\N	\N	\N	\N	\N
6076	60	75	EMPTY	\N	\N	\N	\N	\N	\N
6077	60	76	EMPTY	\N	\N	\N	\N	\N	\N
6078	60	77	EMPTY	\N	\N	\N	\N	\N	\N
6079	60	78	EMPTY	\N	\N	\N	\N	\N	\N
6080	60	79	EMPTY	\N	\N	\N	\N	\N	\N
6081	60	80	EMPTY	\N	\N	\N	\N	\N	\N
6082	60	81	EMPTY	\N	\N	\N	\N	\N	\N
6083	60	82	EMPTY	\N	\N	\N	\N	\N	\N
6084	60	83	EMPTY	\N	\N	\N	\N	\N	\N
6085	60	84	EMPTY	\N	\N	\N	\N	\N	\N
6086	60	85	EMPTY	\N	\N	\N	\N	\N	\N
6087	60	86	EMPTY	\N	\N	\N	\N	\N	\N
6088	60	87	EMPTY	\N	\N	\N	\N	\N	\N
6089	60	88	EMPTY	\N	\N	\N	\N	\N	\N
6090	60	89	EMPTY	\N	\N	\N	\N	\N	\N
6091	60	90	EMPTY	\N	\N	\N	\N	\N	\N
6092	60	91	EMPTY	\N	\N	\N	\N	\N	\N
6093	60	92	EMPTY	\N	\N	\N	\N	\N	\N
6094	60	93	EMPTY	\N	\N	\N	\N	\N	\N
6095	60	94	EMPTY	\N	\N	\N	\N	\N	\N
6096	60	95	EMPTY	\N	\N	\N	\N	\N	\N
6097	60	96	EMPTY	\N	\N	\N	\N	\N	\N
6098	60	97	NPC	\N	\N	6	\N	Barbarian Camp (Lv 6)	\N
6099	60	98	EMPTY	\N	\N	\N	\N	\N	\N
6100	60	99	EMPTY	\N	\N	\N	\N	\N	\N
6101	61	0	EMPTY	\N	\N	\N	\N	\N	\N
6102	61	1	EMPTY	\N	\N	\N	\N	\N	\N
6103	61	2	EMPTY	\N	\N	\N	\N	\N	\N
6104	61	3	EMPTY	\N	\N	\N	\N	\N	\N
6105	61	4	EMPTY	\N	\N	\N	\N	\N	\N
6106	61	5	EMPTY	\N	\N	\N	\N	\N	\N
6107	61	6	RESOURCE	stone	2	\N	\N	\N	\N
6108	61	7	EMPTY	\N	\N	\N	\N	\N	\N
6109	61	8	EMPTY	\N	\N	\N	\N	\N	\N
6110	61	9	RESOURCE	stone	2	\N	\N	\N	\N
6111	61	10	EMPTY	\N	\N	\N	\N	\N	\N
6112	61	11	EMPTY	\N	\N	\N	\N	\N	\N
6113	61	12	EMPTY	\N	\N	\N	\N	\N	\N
6114	61	13	EMPTY	\N	\N	\N	\N	\N	\N
6115	61	14	EMPTY	\N	\N	\N	\N	\N	\N
6116	61	15	RESOURCE	stone	3	\N	\N	\N	\N
6117	61	16	EMPTY	\N	\N	\N	\N	\N	\N
6118	61	17	EMPTY	\N	\N	\N	\N	\N	\N
6119	61	18	EMPTY	\N	\N	\N	\N	\N	\N
6120	61	19	EMPTY	\N	\N	\N	\N	\N	\N
6121	61	20	EMPTY	\N	\N	\N	\N	\N	\N
6122	61	21	EMPTY	\N	\N	\N	\N	\N	\N
6123	61	22	EMPTY	\N	\N	\N	\N	\N	\N
6124	61	23	EMPTY	\N	\N	\N	\N	\N	\N
6125	61	24	NPC	\N	\N	4	\N	Barbarian Camp (Lv 4)	\N
6126	61	25	EMPTY	\N	\N	\N	\N	\N	\N
6127	61	26	EMPTY	\N	\N	\N	\N	\N	\N
6128	61	27	EMPTY	\N	\N	\N	\N	\N	\N
6129	61	28	EMPTY	\N	\N	\N	\N	\N	\N
6130	61	29	EMPTY	\N	\N	\N	\N	\N	\N
6131	61	30	NPC	\N	\N	7	\N	Barbarian Camp (Lv 7)	\N
6132	61	31	EMPTY	\N	\N	\N	\N	\N	\N
6133	61	32	EMPTY	\N	\N	\N	\N	\N	\N
6134	61	33	EMPTY	\N	\N	\N	\N	\N	\N
6135	61	34	EMPTY	\N	\N	\N	\N	\N	\N
6136	61	35	EMPTY	\N	\N	\N	\N	\N	\N
6137	61	36	EMPTY	\N	\N	\N	\N	\N	\N
6138	61	37	EMPTY	\N	\N	\N	\N	\N	\N
6139	61	38	EMPTY	\N	\N	\N	\N	\N	\N
6140	61	39	EMPTY	\N	\N	\N	\N	\N	\N
6141	61	40	EMPTY	\N	\N	\N	\N	\N	\N
6142	61	41	EMPTY	\N	\N	\N	\N	\N	\N
6143	61	42	NPC	\N	\N	10	\N	Barbarian Camp (Lv 10)	\N
6144	61	43	RESOURCE	stone	3	\N	\N	\N	\N
6145	61	44	EMPTY	\N	\N	\N	\N	\N	\N
6146	61	45	RESOURCE	wood	3	\N	\N	\N	\N
6147	61	46	EMPTY	\N	\N	\N	\N	\N	\N
6148	61	47	EMPTY	\N	\N	\N	\N	\N	\N
6149	61	48	EMPTY	\N	\N	\N	\N	\N	\N
6150	61	49	EMPTY	\N	\N	\N	\N	\N	\N
6151	61	50	EMPTY	\N	\N	\N	\N	\N	\N
6152	61	51	NPC	\N	\N	10	\N	Barbarian Camp (Lv 10)	\N
6153	61	52	EMPTY	\N	\N	\N	\N	\N	\N
6154	61	53	EMPTY	\N	\N	\N	\N	\N	\N
6155	61	54	EMPTY	\N	\N	\N	\N	\N	\N
6156	61	55	EMPTY	\N	\N	\N	\N	\N	\N
6157	61	56	EMPTY	\N	\N	\N	\N	\N	\N
6158	61	57	NPC	\N	\N	8	\N	Barbarian Camp (Lv 8)	\N
6159	61	58	EMPTY	\N	\N	\N	\N	\N	\N
6160	61	59	EMPTY	\N	\N	\N	\N	\N	\N
6161	61	60	EMPTY	\N	\N	\N	\N	\N	\N
6162	61	61	EMPTY	\N	\N	\N	\N	\N	\N
6163	61	62	EMPTY	\N	\N	\N	\N	\N	\N
6164	61	63	EMPTY	\N	\N	\N	\N	\N	\N
6165	61	64	EMPTY	\N	\N	\N	\N	\N	\N
6166	61	65	RESOURCE	food	1	\N	\N	\N	\N
6167	61	66	EMPTY	\N	\N	\N	\N	\N	\N
6168	61	67	EMPTY	\N	\N	\N	\N	\N	\N
6169	61	68	EMPTY	\N	\N	\N	\N	\N	\N
6170	61	69	EMPTY	\N	\N	\N	\N	\N	\N
6171	61	70	EMPTY	\N	\N	\N	\N	\N	\N
6172	61	71	EMPTY	\N	\N	\N	\N	\N	\N
6173	61	72	EMPTY	\N	\N	\N	\N	\N	\N
6174	61	73	EMPTY	\N	\N	\N	\N	\N	\N
6175	61	74	RESOURCE	iron	2	\N	\N	\N	\N
6176	61	75	EMPTY	\N	\N	\N	\N	\N	\N
6177	61	76	EMPTY	\N	\N	\N	\N	\N	\N
6178	61	77	NPC	\N	\N	5	\N	Barbarian Camp (Lv 5)	\N
6179	61	78	NPC	\N	\N	3	\N	Barbarian Camp (Lv 3)	\N
6180	61	79	EMPTY	\N	\N	\N	\N	\N	\N
6181	61	80	EMPTY	\N	\N	\N	\N	\N	\N
6182	61	81	EMPTY	\N	\N	\N	\N	\N	\N
6183	61	82	EMPTY	\N	\N	\N	\N	\N	\N
6184	61	83	EMPTY	\N	\N	\N	\N	\N	\N
6185	61	84	EMPTY	\N	\N	\N	\N	\N	\N
6186	61	85	EMPTY	\N	\N	\N	\N	\N	\N
6187	61	86	EMPTY	\N	\N	\N	\N	\N	\N
6188	61	87	EMPTY	\N	\N	\N	\N	\N	\N
6189	61	88	EMPTY	\N	\N	\N	\N	\N	\N
6190	61	89	EMPTY	\N	\N	\N	\N	\N	\N
6191	61	90	EMPTY	\N	\N	\N	\N	\N	\N
6192	61	91	EMPTY	\N	\N	\N	\N	\N	\N
6193	61	92	EMPTY	\N	\N	\N	\N	\N	\N
6194	61	93	EMPTY	\N	\N	\N	\N	\N	\N
6195	61	94	EMPTY	\N	\N	\N	\N	\N	\N
6196	61	95	EMPTY	\N	\N	\N	\N	\N	\N
6197	61	96	EMPTY	\N	\N	\N	\N	\N	\N
6198	61	97	EMPTY	\N	\N	\N	\N	\N	\N
6199	61	98	EMPTY	\N	\N	\N	\N	\N	\N
6200	61	99	EMPTY	\N	\N	\N	\N	\N	\N
6201	62	0	EMPTY	\N	\N	\N	\N	\N	\N
6202	62	1	EMPTY	\N	\N	\N	\N	\N	\N
6203	62	2	EMPTY	\N	\N	\N	\N	\N	\N
6204	62	3	EMPTY	\N	\N	\N	\N	\N	\N
6205	62	4	EMPTY	\N	\N	\N	\N	\N	\N
6206	62	5	EMPTY	\N	\N	\N	\N	\N	\N
6207	62	6	EMPTY	\N	\N	\N	\N	\N	\N
6208	62	7	EMPTY	\N	\N	\N	\N	\N	\N
6209	62	8	RESOURCE	stone	1	\N	\N	\N	\N
6210	62	9	RESOURCE	stone	4	\N	\N	\N	\N
6211	62	10	EMPTY	\N	\N	\N	\N	\N	\N
6212	62	11	EMPTY	\N	\N	\N	\N	\N	\N
6213	62	12	EMPTY	\N	\N	\N	\N	\N	\N
6214	62	13	EMPTY	\N	\N	\N	\N	\N	\N
6215	62	14	EMPTY	\N	\N	\N	\N	\N	\N
6216	62	15	EMPTY	\N	\N	\N	\N	\N	\N
6217	62	16	EMPTY	\N	\N	\N	\N	\N	\N
6218	62	17	EMPTY	\N	\N	\N	\N	\N	\N
6219	62	18	EMPTY	\N	\N	\N	\N	\N	\N
6220	62	19	EMPTY	\N	\N	\N	\N	\N	\N
6221	62	20	RESOURCE	stone	1	\N	\N	\N	\N
6222	62	21	EMPTY	\N	\N	\N	\N	\N	\N
6223	62	22	EMPTY	\N	\N	\N	\N	\N	\N
6224	62	23	EMPTY	\N	\N	\N	\N	\N	\N
6225	62	24	EMPTY	\N	\N	\N	\N	\N	\N
6226	62	25	EMPTY	\N	\N	\N	\N	\N	\N
6227	62	26	EMPTY	\N	\N	\N	\N	\N	\N
6228	62	27	NPC	\N	\N	2	\N	Barbarian Camp (Lv 2)	\N
6229	62	28	EMPTY	\N	\N	\N	\N	\N	\N
6230	62	29	EMPTY	\N	\N	\N	\N	\N	\N
6231	62	30	EMPTY	\N	\N	\N	\N	\N	\N
6232	62	31	EMPTY	\N	\N	\N	\N	\N	\N
6233	62	32	EMPTY	\N	\N	\N	\N	\N	\N
6234	62	33	EMPTY	\N	\N	\N	\N	\N	\N
6235	62	34	EMPTY	\N	\N	\N	\N	\N	\N
6236	62	35	EMPTY	\N	\N	\N	\N	\N	\N
6237	62	36	NPC	\N	\N	2	\N	Barbarian Camp (Lv 2)	\N
6238	62	37	EMPTY	\N	\N	\N	\N	\N	\N
6239	62	38	EMPTY	\N	\N	\N	\N	\N	\N
6240	62	39	EMPTY	\N	\N	\N	\N	\N	\N
6241	62	40	EMPTY	\N	\N	\N	\N	\N	\N
6242	62	41	EMPTY	\N	\N	\N	\N	\N	\N
6243	62	42	EMPTY	\N	\N	\N	\N	\N	\N
6244	62	43	RESOURCE	wood	3	\N	\N	\N	\N
6245	62	44	NPC	\N	\N	5	\N	Barbarian Camp (Lv 5)	\N
6246	62	45	EMPTY	\N	\N	\N	\N	\N	\N
6247	62	46	EMPTY	\N	\N	\N	\N	\N	\N
6248	62	47	EMPTY	\N	\N	\N	\N	\N	\N
6249	62	48	EMPTY	\N	\N	\N	\N	\N	\N
6250	62	49	EMPTY	\N	\N	\N	\N	\N	\N
6251	62	50	RESOURCE	iron	1	\N	\N	\N	\N
6252	62	51	EMPTY	\N	\N	\N	\N	\N	\N
6253	62	52	EMPTY	\N	\N	\N	\N	\N	\N
6254	62	53	EMPTY	\N	\N	\N	\N	\N	\N
6255	62	54	EMPTY	\N	\N	\N	\N	\N	\N
6256	62	55	EMPTY	\N	\N	\N	\N	\N	\N
6257	62	56	EMPTY	\N	\N	\N	\N	\N	\N
6258	62	57	EMPTY	\N	\N	\N	\N	\N	\N
6259	62	58	EMPTY	\N	\N	\N	\N	\N	\N
6260	62	59	EMPTY	\N	\N	\N	\N	\N	\N
6261	62	60	EMPTY	\N	\N	\N	\N	\N	\N
6262	62	61	EMPTY	\N	\N	\N	\N	\N	\N
6263	62	62	EMPTY	\N	\N	\N	\N	\N	\N
6264	62	63	EMPTY	\N	\N	\N	\N	\N	\N
6265	62	64	EMPTY	\N	\N	\N	\N	\N	\N
6266	62	65	EMPTY	\N	\N	\N	\N	\N	\N
6267	62	66	EMPTY	\N	\N	\N	\N	\N	\N
6268	62	67	EMPTY	\N	\N	\N	\N	\N	\N
6269	62	68	EMPTY	\N	\N	\N	\N	\N	\N
6270	62	69	EMPTY	\N	\N	\N	\N	\N	\N
6271	62	70	EMPTY	\N	\N	\N	\N	\N	\N
6272	62	71	EMPTY	\N	\N	\N	\N	\N	\N
6273	62	72	EMPTY	\N	\N	\N	\N	\N	\N
6274	62	73	EMPTY	\N	\N	\N	\N	\N	\N
6275	62	74	EMPTY	\N	\N	\N	\N	\N	\N
6276	62	75	EMPTY	\N	\N	\N	\N	\N	\N
6277	62	76	EMPTY	\N	\N	\N	\N	\N	\N
6278	62	77	NPC	\N	\N	6	\N	Barbarian Camp (Lv 6)	\N
6279	62	78	NPC	\N	\N	7	\N	Barbarian Camp (Lv 7)	\N
6280	62	79	EMPTY	\N	\N	\N	\N	\N	\N
6281	62	80	EMPTY	\N	\N	\N	\N	\N	\N
6282	62	81	EMPTY	\N	\N	\N	\N	\N	\N
6283	62	82	EMPTY	\N	\N	\N	\N	\N	\N
6284	62	83	EMPTY	\N	\N	\N	\N	\N	\N
6285	62	84	EMPTY	\N	\N	\N	\N	\N	\N
6286	62	85	EMPTY	\N	\N	\N	\N	\N	\N
6287	62	86	EMPTY	\N	\N	\N	\N	\N	\N
6288	62	87	EMPTY	\N	\N	\N	\N	\N	\N
6289	62	88	EMPTY	\N	\N	\N	\N	\N	\N
6290	62	89	EMPTY	\N	\N	\N	\N	\N	\N
6291	62	90	EMPTY	\N	\N	\N	\N	\N	\N
6292	62	91	EMPTY	\N	\N	\N	\N	\N	\N
6293	62	92	RESOURCE	food	4	\N	\N	\N	\N
6294	62	93	EMPTY	\N	\N	\N	\N	\N	\N
6295	62	94	EMPTY	\N	\N	\N	\N	\N	\N
6296	62	95	EMPTY	\N	\N	\N	\N	\N	\N
6297	62	96	EMPTY	\N	\N	\N	\N	\N	\N
6298	62	97	EMPTY	\N	\N	\N	\N	\N	\N
6299	62	98	EMPTY	\N	\N	\N	\N	\N	\N
6300	62	99	EMPTY	\N	\N	\N	\N	\N	\N
6301	63	0	EMPTY	\N	\N	\N	\N	\N	\N
6302	63	1	EMPTY	\N	\N	\N	\N	\N	\N
6303	63	2	EMPTY	\N	\N	\N	\N	\N	\N
6304	63	3	EMPTY	\N	\N	\N	\N	\N	\N
6305	63	4	EMPTY	\N	\N	\N	\N	\N	\N
6306	63	5	EMPTY	\N	\N	\N	\N	\N	\N
6307	63	6	EMPTY	\N	\N	\N	\N	\N	\N
6308	63	7	EMPTY	\N	\N	\N	\N	\N	\N
6309	63	8	EMPTY	\N	\N	\N	\N	\N	\N
6310	63	9	EMPTY	\N	\N	\N	\N	\N	\N
6311	63	10	NPC	\N	\N	4	\N	Barbarian Camp (Lv 4)	\N
6312	63	11	EMPTY	\N	\N	\N	\N	\N	\N
6313	63	12	RESOURCE	wood	5	\N	\N	\N	\N
6314	63	13	EMPTY	\N	\N	\N	\N	\N	\N
6315	63	14	EMPTY	\N	\N	\N	\N	\N	\N
6316	63	15	RESOURCE	iron	5	\N	\N	\N	\N
6317	63	16	EMPTY	\N	\N	\N	\N	\N	\N
6318	63	17	EMPTY	\N	\N	\N	\N	\N	\N
6319	63	18	EMPTY	\N	\N	\N	\N	\N	\N
6320	63	19	EMPTY	\N	\N	\N	\N	\N	\N
6321	63	20	EMPTY	\N	\N	\N	\N	\N	\N
6322	63	21	RESOURCE	wood	3	\N	\N	\N	\N
6323	63	22	EMPTY	\N	\N	\N	\N	\N	\N
6324	63	23	EMPTY	\N	\N	\N	\N	\N	\N
6325	63	24	EMPTY	\N	\N	\N	\N	\N	\N
6326	63	25	EMPTY	\N	\N	\N	\N	\N	\N
6327	63	26	EMPTY	\N	\N	\N	\N	\N	\N
6328	63	27	EMPTY	\N	\N	\N	\N	\N	\N
6329	63	28	EMPTY	\N	\N	\N	\N	\N	\N
6330	63	29	EMPTY	\N	\N	\N	\N	\N	\N
6331	63	30	RESOURCE	iron	5	\N	\N	\N	\N
6332	63	31	EMPTY	\N	\N	\N	\N	\N	\N
6333	63	32	EMPTY	\N	\N	\N	\N	\N	\N
6334	63	33	NPC	\N	\N	8	\N	Barbarian Camp (Lv 8)	\N
6335	63	34	EMPTY	\N	\N	\N	\N	\N	\N
6336	63	35	EMPTY	\N	\N	\N	\N	\N	\N
6337	63	36	EMPTY	\N	\N	\N	\N	\N	\N
6338	63	37	EMPTY	\N	\N	\N	\N	\N	\N
6339	63	38	EMPTY	\N	\N	\N	\N	\N	\N
6340	63	39	EMPTY	\N	\N	\N	\N	\N	\N
6341	63	40	RESOURCE	wood	4	\N	\N	\N	\N
6342	63	41	EMPTY	\N	\N	\N	\N	\N	\N
6343	63	42	EMPTY	\N	\N	\N	\N	\N	\N
6344	63	43	EMPTY	\N	\N	\N	\N	\N	\N
6345	63	44	RESOURCE	iron	4	\N	\N	\N	\N
6346	63	45	EMPTY	\N	\N	\N	\N	\N	\N
6347	63	46	NPC	\N	\N	1	\N	Barbarian Camp (Lv 1)	\N
6348	63	47	EMPTY	\N	\N	\N	\N	\N	\N
6349	63	48	EMPTY	\N	\N	\N	\N	\N	\N
6350	63	49	EMPTY	\N	\N	\N	\N	\N	\N
6351	63	50	RESOURCE	stone	1	\N	\N	\N	\N
6352	63	51	EMPTY	\N	\N	\N	\N	\N	\N
6353	63	52	EMPTY	\N	\N	\N	\N	\N	\N
6354	63	53	RESOURCE	stone	5	\N	\N	\N	\N
6355	63	54	EMPTY	\N	\N	\N	\N	\N	\N
6356	63	55	EMPTY	\N	\N	\N	\N	\N	\N
6357	63	56	EMPTY	\N	\N	\N	\N	\N	\N
6358	63	57	EMPTY	\N	\N	\N	\N	\N	\N
6359	63	58	VALLEY	\N	\N	\N	\N	Valley (63, 58)	\N
6360	63	59	EMPTY	\N	\N	\N	\N	\N	\N
6361	63	60	EMPTY	\N	\N	\N	\N	\N	\N
6362	63	61	EMPTY	\N	\N	\N	\N	\N	\N
6363	63	62	EMPTY	\N	\N	\N	\N	\N	\N
6364	63	63	EMPTY	\N	\N	\N	\N	\N	\N
6365	63	64	EMPTY	\N	\N	\N	\N	\N	\N
6366	63	65	EMPTY	\N	\N	\N	\N	\N	\N
6367	63	66	RESOURCE	iron	3	\N	\N	\N	\N
6368	63	67	EMPTY	\N	\N	\N	\N	\N	\N
6369	63	68	RESOURCE	wood	2	\N	\N	\N	\N
6370	63	69	EMPTY	\N	\N	\N	\N	\N	\N
6371	63	70	EMPTY	\N	\N	\N	\N	\N	\N
6372	63	71	EMPTY	\N	\N	\N	\N	\N	\N
6373	63	72	EMPTY	\N	\N	\N	\N	\N	\N
6374	63	73	EMPTY	\N	\N	\N	\N	\N	\N
6375	63	74	EMPTY	\N	\N	\N	\N	\N	\N
6376	63	75	EMPTY	\N	\N	\N	\N	\N	\N
6377	63	76	NPC	\N	\N	7	\N	Barbarian Camp (Lv 7)	\N
6378	63	77	EMPTY	\N	\N	\N	\N	\N	\N
6379	63	78	EMPTY	\N	\N	\N	\N	\N	\N
6380	63	79	EMPTY	\N	\N	\N	\N	\N	\N
6381	63	80	EMPTY	\N	\N	\N	\N	\N	\N
6382	63	81	EMPTY	\N	\N	\N	\N	\N	\N
6383	63	82	EMPTY	\N	\N	\N	\N	\N	\N
6384	63	83	EMPTY	\N	\N	\N	\N	\N	\N
6385	63	84	EMPTY	\N	\N	\N	\N	\N	\N
6386	63	85	EMPTY	\N	\N	\N	\N	\N	\N
6387	63	86	EMPTY	\N	\N	\N	\N	\N	\N
6388	63	87	EMPTY	\N	\N	\N	\N	\N	\N
6389	63	88	EMPTY	\N	\N	\N	\N	\N	\N
6390	63	89	EMPTY	\N	\N	\N	\N	\N	\N
6391	63	90	EMPTY	\N	\N	\N	\N	\N	\N
6392	63	91	EMPTY	\N	\N	\N	\N	\N	\N
6393	63	92	EMPTY	\N	\N	\N	\N	\N	\N
6394	63	93	EMPTY	\N	\N	\N	\N	\N	\N
6395	63	94	EMPTY	\N	\N	\N	\N	\N	\N
6396	63	95	EMPTY	\N	\N	\N	\N	\N	\N
6397	63	96	EMPTY	\N	\N	\N	\N	\N	\N
6398	63	97	EMPTY	\N	\N	\N	\N	\N	\N
6399	63	98	EMPTY	\N	\N	\N	\N	\N	\N
6400	63	99	EMPTY	\N	\N	\N	\N	\N	\N
6401	64	0	EMPTY	\N	\N	\N	\N	\N	\N
6402	64	1	EMPTY	\N	\N	\N	\N	\N	\N
6403	64	2	EMPTY	\N	\N	\N	\N	\N	\N
6404	64	3	EMPTY	\N	\N	\N	\N	\N	\N
6405	64	4	EMPTY	\N	\N	\N	\N	\N	\N
6406	64	5	EMPTY	\N	\N	\N	\N	\N	\N
6407	64	6	EMPTY	\N	\N	\N	\N	\N	\N
6408	64	7	EMPTY	\N	\N	\N	\N	\N	\N
6409	64	8	NPC	\N	\N	1	\N	Barbarian Camp (Lv 1)	\N
6410	64	9	EMPTY	\N	\N	\N	\N	\N	\N
6411	64	10	NPC	\N	\N	2	\N	Barbarian Camp (Lv 2)	\N
6412	64	11	EMPTY	\N	\N	\N	\N	\N	\N
6413	64	12	EMPTY	\N	\N	\N	\N	\N	\N
6414	64	13	EMPTY	\N	\N	\N	\N	\N	\N
6415	64	14	EMPTY	\N	\N	\N	\N	\N	\N
6416	64	15	EMPTY	\N	\N	\N	\N	\N	\N
6417	64	16	EMPTY	\N	\N	\N	\N	\N	\N
6418	64	17	EMPTY	\N	\N	\N	\N	\N	\N
6419	64	18	EMPTY	\N	\N	\N	\N	\N	\N
6420	64	19	EMPTY	\N	\N	\N	\N	\N	\N
6421	64	20	EMPTY	\N	\N	\N	\N	\N	\N
6422	64	21	EMPTY	\N	\N	\N	\N	\N	\N
6423	64	22	EMPTY	\N	\N	\N	\N	\N	\N
6424	64	23	EMPTY	\N	\N	\N	\N	\N	\N
6425	64	24	EMPTY	\N	\N	\N	\N	\N	\N
6426	64	25	NPC	\N	\N	9	\N	Barbarian Camp (Lv 9)	\N
6427	64	26	EMPTY	\N	\N	\N	\N	\N	\N
6428	64	27	EMPTY	\N	\N	\N	\N	\N	\N
6429	64	28	RESOURCE	food	4	\N	\N	\N	\N
6430	64	29	EMPTY	\N	\N	\N	\N	\N	\N
6431	64	30	EMPTY	\N	\N	\N	\N	\N	\N
6432	64	31	RESOURCE	iron	4	\N	\N	\N	\N
6433	64	32	EMPTY	\N	\N	\N	\N	\N	\N
6434	64	33	NPC	\N	\N	1	\N	Barbarian Camp (Lv 1)	\N
6435	64	34	EMPTY	\N	\N	\N	\N	\N	\N
6436	64	35	EMPTY	\N	\N	\N	\N	\N	\N
6437	64	36	EMPTY	\N	\N	\N	\N	\N	\N
6438	64	37	EMPTY	\N	\N	\N	\N	\N	\N
6439	64	38	EMPTY	\N	\N	\N	\N	\N	\N
6440	64	39	EMPTY	\N	\N	\N	\N	\N	\N
6441	64	40	EMPTY	\N	\N	\N	\N	\N	\N
6442	64	41	RESOURCE	food	4	\N	\N	\N	\N
6443	64	42	EMPTY	\N	\N	\N	\N	\N	\N
6444	64	43	EMPTY	\N	\N	\N	\N	\N	\N
6445	64	44	EMPTY	\N	\N	\N	\N	\N	\N
6446	64	45	EMPTY	\N	\N	\N	\N	\N	\N
6447	64	46	EMPTY	\N	\N	\N	\N	\N	\N
6448	64	47	EMPTY	\N	\N	\N	\N	\N	\N
6449	64	48	EMPTY	\N	\N	\N	\N	\N	\N
6450	64	49	EMPTY	\N	\N	\N	\N	\N	\N
6451	64	50	EMPTY	\N	\N	\N	\N	\N	\N
6452	64	51	EMPTY	\N	\N	\N	\N	\N	\N
6453	64	52	EMPTY	\N	\N	\N	\N	\N	\N
6454	64	53	EMPTY	\N	\N	\N	\N	\N	\N
6455	64	54	EMPTY	\N	\N	\N	\N	\N	\N
6456	64	55	EMPTY	\N	\N	\N	\N	\N	\N
6457	64	56	EMPTY	\N	\N	\N	\N	\N	\N
6459	64	58	EMPTY	\N	\N	\N	\N	\N	\N
6460	64	59	EMPTY	\N	\N	\N	\N	\N	\N
6461	64	60	RESOURCE	food	2	\N	\N	\N	\N
6462	64	61	RESOURCE	iron	3	\N	\N	\N	\N
6463	64	62	EMPTY	\N	\N	\N	\N	\N	\N
6464	64	63	EMPTY	\N	\N	\N	\N	\N	\N
6465	64	64	EMPTY	\N	\N	\N	\N	\N	\N
6466	64	65	NPC	\N	\N	3	\N	Barbarian Camp (Lv 3)	\N
6467	64	66	VALLEY	\N	\N	\N	\N	Valley (64, 66)	\N
6468	64	67	EMPTY	\N	\N	\N	\N	\N	\N
6469	64	68	EMPTY	\N	\N	\N	\N	\N	\N
6470	64	69	EMPTY	\N	\N	\N	\N	\N	\N
6471	64	70	VALLEY	\N	\N	\N	\N	Valley (64, 70)	\N
6472	64	71	EMPTY	\N	\N	\N	\N	\N	\N
6473	64	72	EMPTY	\N	\N	\N	\N	\N	\N
6474	64	73	NPC	\N	\N	10	\N	Barbarian Camp (Lv 10)	\N
6475	64	74	EMPTY	\N	\N	\N	\N	\N	\N
6476	64	75	EMPTY	\N	\N	\N	\N	\N	\N
6477	64	76	EMPTY	\N	\N	\N	\N	\N	\N
6478	64	77	EMPTY	\N	\N	\N	\N	\N	\N
6479	64	78	EMPTY	\N	\N	\N	\N	\N	\N
6480	64	79	RESOURCE	wood	4	\N	\N	\N	\N
6481	64	80	EMPTY	\N	\N	\N	\N	\N	\N
6482	64	81	EMPTY	\N	\N	\N	\N	\N	\N
6483	64	82	RESOURCE	food	3	\N	\N	\N	\N
6484	64	83	EMPTY	\N	\N	\N	\N	\N	\N
6485	64	84	EMPTY	\N	\N	\N	\N	\N	\N
6486	64	85	NPC	\N	\N	8	\N	Barbarian Camp (Lv 8)	\N
6487	64	86	RESOURCE	stone	3	\N	\N	\N	\N
6488	64	87	EMPTY	\N	\N	\N	\N	\N	\N
6489	64	88	EMPTY	\N	\N	\N	\N	\N	\N
6490	64	89	EMPTY	\N	\N	\N	\N	\N	\N
6491	64	90	EMPTY	\N	\N	\N	\N	\N	\N
6492	64	91	NPC	\N	\N	1	\N	Barbarian Camp (Lv 1)	\N
6493	64	92	EMPTY	\N	\N	\N	\N	\N	\N
6494	64	93	NPC	\N	\N	3	\N	Barbarian Camp (Lv 3)	\N
6495	64	94	EMPTY	\N	\N	\N	\N	\N	\N
6496	64	95	NPC	\N	\N	9	\N	Barbarian Camp (Lv 9)	\N
6497	64	96	EMPTY	\N	\N	\N	\N	\N	\N
6498	64	97	EMPTY	\N	\N	\N	\N	\N	\N
6499	64	98	EMPTY	\N	\N	\N	\N	\N	\N
6500	64	99	EMPTY	\N	\N	\N	\N	\N	\N
6501	65	0	RESOURCE	food	3	\N	\N	\N	\N
6502	65	1	EMPTY	\N	\N	\N	\N	\N	\N
6503	65	2	EMPTY	\N	\N	\N	\N	\N	\N
6504	65	3	EMPTY	\N	\N	\N	\N	\N	\N
6505	65	4	EMPTY	\N	\N	\N	\N	\N	\N
6506	65	5	EMPTY	\N	\N	\N	\N	\N	\N
6507	65	6	EMPTY	\N	\N	\N	\N	\N	\N
6508	65	7	EMPTY	\N	\N	\N	\N	\N	\N
6509	65	8	EMPTY	\N	\N	\N	\N	\N	\N
6510	65	9	VALLEY	\N	\N	\N	\N	Valley (65, 9)	\N
6511	65	10	EMPTY	\N	\N	\N	\N	\N	\N
6512	65	11	EMPTY	\N	\N	\N	\N	\N	\N
6513	65	12	EMPTY	\N	\N	\N	\N	\N	\N
6514	65	13	EMPTY	\N	\N	\N	\N	\N	\N
6515	65	14	EMPTY	\N	\N	\N	\N	\N	\N
6516	65	15	EMPTY	\N	\N	\N	\N	\N	\N
6517	65	16	EMPTY	\N	\N	\N	\N	\N	\N
6518	65	17	EMPTY	\N	\N	\N	\N	\N	\N
6519	65	18	EMPTY	\N	\N	\N	\N	\N	\N
6520	65	19	EMPTY	\N	\N	\N	\N	\N	\N
6521	65	20	EMPTY	\N	\N	\N	\N	\N	\N
6522	65	21	EMPTY	\N	\N	\N	\N	\N	\N
6523	65	22	EMPTY	\N	\N	\N	\N	\N	\N
6524	65	23	EMPTY	\N	\N	\N	\N	\N	\N
6525	65	24	RESOURCE	wood	1	\N	\N	\N	\N
6526	65	25	EMPTY	\N	\N	\N	\N	\N	\N
6527	65	26	EMPTY	\N	\N	\N	\N	\N	\N
6528	65	27	EMPTY	\N	\N	\N	\N	\N	\N
6529	65	28	EMPTY	\N	\N	\N	\N	\N	\N
6530	65	29	EMPTY	\N	\N	\N	\N	\N	\N
6531	65	30	EMPTY	\N	\N	\N	\N	\N	\N
6532	65	31	EMPTY	\N	\N	\N	\N	\N	\N
6533	65	32	EMPTY	\N	\N	\N	\N	\N	\N
6534	65	33	EMPTY	\N	\N	\N	\N	\N	\N
6535	65	34	EMPTY	\N	\N	\N	\N	\N	\N
6536	65	35	RESOURCE	stone	1	\N	\N	\N	\N
6537	65	36	EMPTY	\N	\N	\N	\N	\N	\N
6538	65	37	EMPTY	\N	\N	\N	\N	\N	\N
6539	65	38	RESOURCE	wood	1	\N	\N	\N	\N
6540	65	39	EMPTY	\N	\N	\N	\N	\N	\N
6541	65	40	NPC	\N	\N	1	\N	Barbarian Camp (Lv 1)	\N
6542	65	41	EMPTY	\N	\N	\N	\N	\N	\N
6543	65	42	EMPTY	\N	\N	\N	\N	\N	\N
6544	65	43	EMPTY	\N	\N	\N	\N	\N	\N
6545	65	44	EMPTY	\N	\N	\N	\N	\N	\N
6546	65	45	NPC	\N	\N	4	\N	Barbarian Camp (Lv 4)	\N
6547	65	46	EMPTY	\N	\N	\N	\N	\N	\N
6548	65	47	EMPTY	\N	\N	\N	\N	\N	\N
6549	65	48	EMPTY	\N	\N	\N	\N	\N	\N
6550	65	49	EMPTY	\N	\N	\N	\N	\N	\N
6551	65	50	EMPTY	\N	\N	\N	\N	\N	\N
6552	65	51	EMPTY	\N	\N	\N	\N	\N	\N
6553	65	52	EMPTY	\N	\N	\N	\N	\N	\N
6554	65	53	RESOURCE	wood	4	\N	\N	\N	\N
6555	65	54	EMPTY	\N	\N	\N	\N	\N	\N
6556	65	55	EMPTY	\N	\N	\N	\N	\N	\N
6557	65	56	EMPTY	\N	\N	\N	\N	\N	\N
6558	65	57	EMPTY	\N	\N	\N	\N	\N	\N
6559	65	58	EMPTY	\N	\N	\N	\N	\N	\N
6560	65	59	EMPTY	\N	\N	\N	\N	\N	\N
6561	65	60	EMPTY	\N	\N	\N	\N	\N	\N
6562	65	61	EMPTY	\N	\N	\N	\N	\N	\N
6563	65	62	EMPTY	\N	\N	\N	\N	\N	\N
6564	65	63	EMPTY	\N	\N	\N	\N	\N	\N
6565	65	64	EMPTY	\N	\N	\N	\N	\N	\N
6566	65	65	RESOURCE	iron	1	\N	\N	\N	\N
6567	65	66	EMPTY	\N	\N	\N	\N	\N	\N
6568	65	67	EMPTY	\N	\N	\N	\N	\N	\N
6569	65	68	EMPTY	\N	\N	\N	\N	\N	\N
6570	65	69	NPC	\N	\N	3	\N	Barbarian Camp (Lv 3)	\N
6571	65	70	EMPTY	\N	\N	\N	\N	\N	\N
6572	65	71	EMPTY	\N	\N	\N	\N	\N	\N
6573	65	72	RESOURCE	wood	5	\N	\N	\N	\N
6574	65	73	EMPTY	\N	\N	\N	\N	\N	\N
6575	65	74	EMPTY	\N	\N	\N	\N	\N	\N
6576	65	75	RESOURCE	food	2	\N	\N	\N	\N
6577	65	76	EMPTY	\N	\N	\N	\N	\N	\N
6578	65	77	EMPTY	\N	\N	\N	\N	\N	\N
6579	65	78	EMPTY	\N	\N	\N	\N	\N	\N
6580	65	79	EMPTY	\N	\N	\N	\N	\N	\N
6581	65	80	EMPTY	\N	\N	\N	\N	\N	\N
6582	65	81	EMPTY	\N	\N	\N	\N	\N	\N
6583	65	82	EMPTY	\N	\N	\N	\N	\N	\N
6584	65	83	EMPTY	\N	\N	\N	\N	\N	\N
6585	65	84	EMPTY	\N	\N	\N	\N	\N	\N
6586	65	85	EMPTY	\N	\N	\N	\N	\N	\N
6587	65	86	EMPTY	\N	\N	\N	\N	\N	\N
6588	65	87	EMPTY	\N	\N	\N	\N	\N	\N
6589	65	88	EMPTY	\N	\N	\N	\N	\N	\N
6590	65	89	EMPTY	\N	\N	\N	\N	\N	\N
6591	65	90	NPC	\N	\N	10	\N	Barbarian Camp (Lv 10)	\N
6592	65	91	EMPTY	\N	\N	\N	\N	\N	\N
6593	65	92	EMPTY	\N	\N	\N	\N	\N	\N
6594	65	93	EMPTY	\N	\N	\N	\N	\N	\N
6595	65	94	EMPTY	\N	\N	\N	\N	\N	\N
6596	65	95	EMPTY	\N	\N	\N	\N	\N	\N
6597	65	96	EMPTY	\N	\N	\N	\N	\N	\N
6598	65	97	EMPTY	\N	\N	\N	\N	\N	\N
6599	65	98	EMPTY	\N	\N	\N	\N	\N	\N
6600	65	99	EMPTY	\N	\N	\N	\N	\N	\N
6601	66	0	EMPTY	\N	\N	\N	\N	\N	\N
6602	66	1	EMPTY	\N	\N	\N	\N	\N	\N
6603	66	2	RESOURCE	wood	5	\N	\N	\N	\N
6604	66	3	EMPTY	\N	\N	\N	\N	\N	\N
6605	66	4	EMPTY	\N	\N	\N	\N	\N	\N
6606	66	5	EMPTY	\N	\N	\N	\N	\N	\N
6607	66	6	RESOURCE	iron	4	\N	\N	\N	\N
6608	66	7	EMPTY	\N	\N	\N	\N	\N	\N
6609	66	8	EMPTY	\N	\N	\N	\N	\N	\N
6610	66	9	EMPTY	\N	\N	\N	\N	\N	\N
6611	66	10	EMPTY	\N	\N	\N	\N	\N	\N
6612	66	11	EMPTY	\N	\N	\N	\N	\N	\N
6613	66	12	EMPTY	\N	\N	\N	\N	\N	\N
6614	66	13	NPC	\N	\N	6	\N	Barbarian Camp (Lv 6)	\N
6615	66	14	EMPTY	\N	\N	\N	\N	\N	\N
6616	66	15	EMPTY	\N	\N	\N	\N	\N	\N
6617	66	16	RESOURCE	food	3	\N	\N	\N	\N
6618	66	17	RESOURCE	food	1	\N	\N	\N	\N
6619	66	18	EMPTY	\N	\N	\N	\N	\N	\N
6620	66	19	EMPTY	\N	\N	\N	\N	\N	\N
6621	66	20	RESOURCE	iron	4	\N	\N	\N	\N
6622	66	21	EMPTY	\N	\N	\N	\N	\N	\N
6623	66	22	EMPTY	\N	\N	\N	\N	\N	\N
6624	66	23	EMPTY	\N	\N	\N	\N	\N	\N
6625	66	24	EMPTY	\N	\N	\N	\N	\N	\N
6626	66	25	EMPTY	\N	\N	\N	\N	\N	\N
6627	66	26	EMPTY	\N	\N	\N	\N	\N	\N
6628	66	27	EMPTY	\N	\N	\N	\N	\N	\N
6629	66	28	EMPTY	\N	\N	\N	\N	\N	\N
6630	66	29	EMPTY	\N	\N	\N	\N	\N	\N
6631	66	30	RESOURCE	iron	3	\N	\N	\N	\N
6632	66	31	EMPTY	\N	\N	\N	\N	\N	\N
6633	66	32	EMPTY	\N	\N	\N	\N	\N	\N
6634	66	33	NPC	\N	\N	1	\N	Barbarian Camp (Lv 1)	\N
6635	66	34	EMPTY	\N	\N	\N	\N	\N	\N
6636	66	35	EMPTY	\N	\N	\N	\N	\N	\N
6637	66	36	EMPTY	\N	\N	\N	\N	\N	\N
6638	66	37	EMPTY	\N	\N	\N	\N	\N	\N
6639	66	38	EMPTY	\N	\N	\N	\N	\N	\N
6640	66	39	VALLEY	\N	\N	\N	\N	Valley (66, 39)	\N
6641	66	40	EMPTY	\N	\N	\N	\N	\N	\N
6642	66	41	EMPTY	\N	\N	\N	\N	\N	\N
6643	66	42	EMPTY	\N	\N	\N	\N	\N	\N
6644	66	43	EMPTY	\N	\N	\N	\N	\N	\N
6645	66	44	EMPTY	\N	\N	\N	\N	\N	\N
6646	66	45	EMPTY	\N	\N	\N	\N	\N	\N
6647	66	46	EMPTY	\N	\N	\N	\N	\N	\N
6648	66	47	EMPTY	\N	\N	\N	\N	\N	\N
6649	66	48	EMPTY	\N	\N	\N	\N	\N	\N
6650	66	49	EMPTY	\N	\N	\N	\N	\N	\N
6651	66	50	EMPTY	\N	\N	\N	\N	\N	\N
6652	66	51	EMPTY	\N	\N	\N	\N	\N	\N
6653	66	52	EMPTY	\N	\N	\N	\N	\N	\N
6654	66	53	EMPTY	\N	\N	\N	\N	\N	\N
6655	66	54	EMPTY	\N	\N	\N	\N	\N	\N
6656	66	55	EMPTY	\N	\N	\N	\N	\N	\N
6657	66	56	EMPTY	\N	\N	\N	\N	\N	\N
6658	66	57	EMPTY	\N	\N	\N	\N	\N	\N
6659	66	58	EMPTY	\N	\N	\N	\N	\N	\N
6660	66	59	EMPTY	\N	\N	\N	\N	\N	\N
6661	66	60	EMPTY	\N	\N	\N	\N	\N	\N
6662	66	61	EMPTY	\N	\N	\N	\N	\N	\N
6663	66	62	EMPTY	\N	\N	\N	\N	\N	\N
6664	66	63	EMPTY	\N	\N	\N	\N	\N	\N
6665	66	64	EMPTY	\N	\N	\N	\N	\N	\N
6666	66	65	EMPTY	\N	\N	\N	\N	\N	\N
6667	66	66	EMPTY	\N	\N	\N	\N	\N	\N
6668	66	67	VALLEY	\N	\N	\N	\N	Valley (66, 67)	\N
6669	66	68	RESOURCE	stone	1	\N	\N	\N	\N
6670	66	69	EMPTY	\N	\N	\N	\N	\N	\N
6671	66	70	NPC	\N	\N	3	\N	Barbarian Camp (Lv 3)	\N
6672	66	71	EMPTY	\N	\N	\N	\N	\N	\N
6673	66	72	EMPTY	\N	\N	\N	\N	\N	\N
6674	66	73	EMPTY	\N	\N	\N	\N	\N	\N
6675	66	74	EMPTY	\N	\N	\N	\N	\N	\N
6676	66	75	EMPTY	\N	\N	\N	\N	\N	\N
6677	66	76	EMPTY	\N	\N	\N	\N	\N	\N
6678	66	77	EMPTY	\N	\N	\N	\N	\N	\N
6679	66	78	EMPTY	\N	\N	\N	\N	\N	\N
6680	66	79	EMPTY	\N	\N	\N	\N	\N	\N
6681	66	80	NPC	\N	\N	2	\N	Barbarian Camp (Lv 2)	\N
6682	66	81	EMPTY	\N	\N	\N	\N	\N	\N
6683	66	82	EMPTY	\N	\N	\N	\N	\N	\N
6684	66	83	EMPTY	\N	\N	\N	\N	\N	\N
6685	66	84	EMPTY	\N	\N	\N	\N	\N	\N
6686	66	85	EMPTY	\N	\N	\N	\N	\N	\N
6687	66	86	VALLEY	\N	\N	\N	\N	Valley (66, 86)	\N
6688	66	87	RESOURCE	stone	3	\N	\N	\N	\N
6689	66	88	EMPTY	\N	\N	\N	\N	\N	\N
6690	66	89	EMPTY	\N	\N	\N	\N	\N	\N
6691	66	90	EMPTY	\N	\N	\N	\N	\N	\N
6692	66	91	EMPTY	\N	\N	\N	\N	\N	\N
6693	66	92	EMPTY	\N	\N	\N	\N	\N	\N
6694	66	93	EMPTY	\N	\N	\N	\N	\N	\N
6695	66	94	EMPTY	\N	\N	\N	\N	\N	\N
6696	66	95	EMPTY	\N	\N	\N	\N	\N	\N
6697	66	96	EMPTY	\N	\N	\N	\N	\N	\N
6698	66	97	EMPTY	\N	\N	\N	\N	\N	\N
6699	66	98	EMPTY	\N	\N	\N	\N	\N	\N
6700	66	99	EMPTY	\N	\N	\N	\N	\N	\N
6701	67	0	EMPTY	\N	\N	\N	\N	\N	\N
6702	67	1	EMPTY	\N	\N	\N	\N	\N	\N
6703	67	2	EMPTY	\N	\N	\N	\N	\N	\N
6704	67	3	EMPTY	\N	\N	\N	\N	\N	\N
6705	67	4	EMPTY	\N	\N	\N	\N	\N	\N
6706	67	5	EMPTY	\N	\N	\N	\N	\N	\N
6707	67	6	VALLEY	\N	\N	\N	\N	Valley (67, 6)	\N
6708	67	7	EMPTY	\N	\N	\N	\N	\N	\N
6709	67	8	EMPTY	\N	\N	\N	\N	\N	\N
6710	67	9	EMPTY	\N	\N	\N	\N	\N	\N
6711	67	10	EMPTY	\N	\N	\N	\N	\N	\N
6712	67	11	EMPTY	\N	\N	\N	\N	\N	\N
6713	67	12	EMPTY	\N	\N	\N	\N	\N	\N
6714	67	13	NPC	\N	\N	3	\N	Barbarian Camp (Lv 3)	\N
6715	67	14	EMPTY	\N	\N	\N	\N	\N	\N
6716	67	15	EMPTY	\N	\N	\N	\N	\N	\N
6717	67	16	EMPTY	\N	\N	\N	\N	\N	\N
6718	67	17	EMPTY	\N	\N	\N	\N	\N	\N
6719	67	18	EMPTY	\N	\N	\N	\N	\N	\N
6720	67	19	EMPTY	\N	\N	\N	\N	\N	\N
6721	67	20	VALLEY	\N	\N	\N	\N	Valley (67, 20)	\N
6722	67	21	EMPTY	\N	\N	\N	\N	\N	\N
6723	67	22	EMPTY	\N	\N	\N	\N	\N	\N
6724	67	23	EMPTY	\N	\N	\N	\N	\N	\N
6725	67	24	EMPTY	\N	\N	\N	\N	\N	\N
6726	67	25	EMPTY	\N	\N	\N	\N	\N	\N
6727	67	26	RESOURCE	iron	5	\N	\N	\N	\N
6728	67	27	EMPTY	\N	\N	\N	\N	\N	\N
6729	67	28	EMPTY	\N	\N	\N	\N	\N	\N
6730	67	29	EMPTY	\N	\N	\N	\N	\N	\N
6731	67	30	EMPTY	\N	\N	\N	\N	\N	\N
6732	67	31	EMPTY	\N	\N	\N	\N	\N	\N
6733	67	32	EMPTY	\N	\N	\N	\N	\N	\N
6734	67	33	EMPTY	\N	\N	\N	\N	\N	\N
6735	67	34	EMPTY	\N	\N	\N	\N	\N	\N
6736	67	35	EMPTY	\N	\N	\N	\N	\N	\N
6737	67	36	EMPTY	\N	\N	\N	\N	\N	\N
6738	67	37	EMPTY	\N	\N	\N	\N	\N	\N
6739	67	38	EMPTY	\N	\N	\N	\N	\N	\N
6740	67	39	EMPTY	\N	\N	\N	\N	\N	\N
6741	67	40	EMPTY	\N	\N	\N	\N	\N	\N
6742	67	41	EMPTY	\N	\N	\N	\N	\N	\N
6743	67	42	EMPTY	\N	\N	\N	\N	\N	\N
6744	67	43	EMPTY	\N	\N	\N	\N	\N	\N
6745	67	44	EMPTY	\N	\N	\N	\N	\N	\N
6746	67	45	EMPTY	\N	\N	\N	\N	\N	\N
6747	67	46	EMPTY	\N	\N	\N	\N	\N	\N
6748	67	47	EMPTY	\N	\N	\N	\N	\N	\N
6749	67	48	VALLEY	\N	\N	\N	\N	Valley (67, 48)	\N
6750	67	49	EMPTY	\N	\N	\N	\N	\N	\N
6751	67	50	EMPTY	\N	\N	\N	\N	\N	\N
6752	67	51	EMPTY	\N	\N	\N	\N	\N	\N
6753	67	52	EMPTY	\N	\N	\N	\N	\N	\N
6754	67	53	EMPTY	\N	\N	\N	\N	\N	\N
6755	67	54	EMPTY	\N	\N	\N	\N	\N	\N
6756	67	55	EMPTY	\N	\N	\N	\N	\N	\N
6757	67	56	EMPTY	\N	\N	\N	\N	\N	\N
6758	67	57	EMPTY	\N	\N	\N	\N	\N	\N
6759	67	58	EMPTY	\N	\N	\N	\N	\N	\N
6760	67	59	EMPTY	\N	\N	\N	\N	\N	\N
6761	67	60	EMPTY	\N	\N	\N	\N	\N	\N
6762	67	61	EMPTY	\N	\N	\N	\N	\N	\N
6763	67	62	EMPTY	\N	\N	\N	\N	\N	\N
6764	67	63	EMPTY	\N	\N	\N	\N	\N	\N
6765	67	64	EMPTY	\N	\N	\N	\N	\N	\N
6766	67	65	EMPTY	\N	\N	\N	\N	\N	\N
6767	67	66	EMPTY	\N	\N	\N	\N	\N	\N
6768	67	67	RESOURCE	wood	2	\N	\N	\N	\N
6769	67	68	EMPTY	\N	\N	\N	\N	\N	\N
6770	67	69	EMPTY	\N	\N	\N	\N	\N	\N
6771	67	70	VALLEY	\N	\N	\N	\N	Valley (67, 70)	\N
6772	67	71	EMPTY	\N	\N	\N	\N	\N	\N
6773	67	72	EMPTY	\N	\N	\N	\N	\N	\N
6774	67	73	EMPTY	\N	\N	\N	\N	\N	\N
6775	67	74	EMPTY	\N	\N	\N	\N	\N	\N
6776	67	75	EMPTY	\N	\N	\N	\N	\N	\N
6777	67	76	EMPTY	\N	\N	\N	\N	\N	\N
6778	67	77	EMPTY	\N	\N	\N	\N	\N	\N
6779	67	78	EMPTY	\N	\N	\N	\N	\N	\N
6780	67	79	EMPTY	\N	\N	\N	\N	\N	\N
6781	67	80	EMPTY	\N	\N	\N	\N	\N	\N
6782	67	81	EMPTY	\N	\N	\N	\N	\N	\N
6783	67	82	VALLEY	\N	\N	\N	\N	Valley (67, 82)	\N
6784	67	83	EMPTY	\N	\N	\N	\N	\N	\N
6785	67	84	EMPTY	\N	\N	\N	\N	\N	\N
6786	67	85	EMPTY	\N	\N	\N	\N	\N	\N
6787	67	86	NPC	\N	\N	8	\N	Barbarian Camp (Lv 8)	\N
6788	67	87	EMPTY	\N	\N	\N	\N	\N	\N
6789	67	88	EMPTY	\N	\N	\N	\N	\N	\N
6790	67	89	EMPTY	\N	\N	\N	\N	\N	\N
6791	67	90	EMPTY	\N	\N	\N	\N	\N	\N
6792	67	91	EMPTY	\N	\N	\N	\N	\N	\N
6793	67	92	NPC	\N	\N	8	\N	Barbarian Camp (Lv 8)	\N
6794	67	93	EMPTY	\N	\N	\N	\N	\N	\N
6795	67	94	EMPTY	\N	\N	\N	\N	\N	\N
6796	67	95	RESOURCE	iron	1	\N	\N	\N	\N
6797	67	96	EMPTY	\N	\N	\N	\N	\N	\N
6798	67	97	EMPTY	\N	\N	\N	\N	\N	\N
6799	67	98	EMPTY	\N	\N	\N	\N	\N	\N
6800	67	99	EMPTY	\N	\N	\N	\N	\N	\N
6801	68	0	VALLEY	\N	\N	\N	\N	Valley (68, 0)	\N
6802	68	1	EMPTY	\N	\N	\N	\N	\N	\N
6803	68	2	EMPTY	\N	\N	\N	\N	\N	\N
6804	68	3	EMPTY	\N	\N	\N	\N	\N	\N
6805	68	4	EMPTY	\N	\N	\N	\N	\N	\N
6806	68	5	EMPTY	\N	\N	\N	\N	\N	\N
6807	68	6	EMPTY	\N	\N	\N	\N	\N	\N
6808	68	7	RESOURCE	iron	2	\N	\N	\N	\N
6809	68	8	EMPTY	\N	\N	\N	\N	\N	\N
6810	68	9	EMPTY	\N	\N	\N	\N	\N	\N
6811	68	10	EMPTY	\N	\N	\N	\N	\N	\N
6812	68	11	EMPTY	\N	\N	\N	\N	\N	\N
6813	68	12	EMPTY	\N	\N	\N	\N	\N	\N
6814	68	13	EMPTY	\N	\N	\N	\N	\N	\N
6815	68	14	EMPTY	\N	\N	\N	\N	\N	\N
6816	68	15	EMPTY	\N	\N	\N	\N	\N	\N
6817	68	16	EMPTY	\N	\N	\N	\N	\N	\N
6818	68	17	EMPTY	\N	\N	\N	\N	\N	\N
6819	68	18	EMPTY	\N	\N	\N	\N	\N	\N
6820	68	19	EMPTY	\N	\N	\N	\N	\N	\N
6821	68	20	NPC	\N	\N	6	\N	Barbarian Camp (Lv 6)	\N
6822	68	21	EMPTY	\N	\N	\N	\N	\N	\N
6823	68	22	EMPTY	\N	\N	\N	\N	\N	\N
6824	68	23	RESOURCE	wood	5	\N	\N	\N	\N
6825	68	24	EMPTY	\N	\N	\N	\N	\N	\N
6826	68	25	EMPTY	\N	\N	\N	\N	\N	\N
6827	68	26	EMPTY	\N	\N	\N	\N	\N	\N
6828	68	27	EMPTY	\N	\N	\N	\N	\N	\N
6829	68	28	EMPTY	\N	\N	\N	\N	\N	\N
6830	68	29	EMPTY	\N	\N	\N	\N	\N	\N
6831	68	30	EMPTY	\N	\N	\N	\N	\N	\N
6832	68	31	EMPTY	\N	\N	\N	\N	\N	\N
6833	68	32	EMPTY	\N	\N	\N	\N	\N	\N
6834	68	33	EMPTY	\N	\N	\N	\N	\N	\N
6835	68	34	EMPTY	\N	\N	\N	\N	\N	\N
6836	68	35	EMPTY	\N	\N	\N	\N	\N	\N
6837	68	36	NPC	\N	\N	2	\N	Barbarian Camp (Lv 2)	\N
6838	68	37	EMPTY	\N	\N	\N	\N	\N	\N
6839	68	38	NPC	\N	\N	7	\N	Barbarian Camp (Lv 7)	\N
6840	68	39	EMPTY	\N	\N	\N	\N	\N	\N
6841	68	40	EMPTY	\N	\N	\N	\N	\N	\N
6842	68	41	EMPTY	\N	\N	\N	\N	\N	\N
6843	68	42	EMPTY	\N	\N	\N	\N	\N	\N
6844	68	43	EMPTY	\N	\N	\N	\N	\N	\N
6845	68	44	EMPTY	\N	\N	\N	\N	\N	\N
6846	68	45	RESOURCE	wood	4	\N	\N	\N	\N
6847	68	46	RESOURCE	iron	2	\N	\N	\N	\N
6848	68	47	EMPTY	\N	\N	\N	\N	\N	\N
6849	68	48	EMPTY	\N	\N	\N	\N	\N	\N
6850	68	49	EMPTY	\N	\N	\N	\N	\N	\N
6851	68	50	EMPTY	\N	\N	\N	\N	\N	\N
6852	68	51	EMPTY	\N	\N	\N	\N	\N	\N
6853	68	52	EMPTY	\N	\N	\N	\N	\N	\N
6854	68	53	EMPTY	\N	\N	\N	\N	\N	\N
6855	68	54	EMPTY	\N	\N	\N	\N	\N	\N
6856	68	55	RESOURCE	iron	2	\N	\N	\N	\N
6857	68	56	RESOURCE	stone	4	\N	\N	\N	\N
6858	68	57	EMPTY	\N	\N	\N	\N	\N	\N
6859	68	58	EMPTY	\N	\N	\N	\N	\N	\N
6860	68	59	EMPTY	\N	\N	\N	\N	\N	\N
6861	68	60	EMPTY	\N	\N	\N	\N	\N	\N
6862	68	61	EMPTY	\N	\N	\N	\N	\N	\N
6863	68	62	EMPTY	\N	\N	\N	\N	\N	\N
6864	68	63	EMPTY	\N	\N	\N	\N	\N	\N
6865	68	64	EMPTY	\N	\N	\N	\N	\N	\N
6866	68	65	EMPTY	\N	\N	\N	\N	\N	\N
6867	68	66	EMPTY	\N	\N	\N	\N	\N	\N
6868	68	67	EMPTY	\N	\N	\N	\N	\N	\N
6869	68	68	EMPTY	\N	\N	\N	\N	\N	\N
6870	68	69	EMPTY	\N	\N	\N	\N	\N	\N
6871	68	70	EMPTY	\N	\N	\N	\N	\N	\N
6872	68	71	EMPTY	\N	\N	\N	\N	\N	\N
6873	68	72	EMPTY	\N	\N	\N	\N	\N	\N
6874	68	73	EMPTY	\N	\N	\N	\N	\N	\N
6875	68	74	EMPTY	\N	\N	\N	\N	\N	\N
6876	68	75	EMPTY	\N	\N	\N	\N	\N	\N
6877	68	76	EMPTY	\N	\N	\N	\N	\N	\N
6878	68	77	EMPTY	\N	\N	\N	\N	\N	\N
6879	68	78	RESOURCE	iron	3	\N	\N	\N	\N
6880	68	79	EMPTY	\N	\N	\N	\N	\N	\N
6881	68	80	EMPTY	\N	\N	\N	\N	\N	\N
6882	68	81	EMPTY	\N	\N	\N	\N	\N	\N
6883	68	82	EMPTY	\N	\N	\N	\N	\N	\N
6884	68	83	EMPTY	\N	\N	\N	\N	\N	\N
6885	68	84	EMPTY	\N	\N	\N	\N	\N	\N
6886	68	85	EMPTY	\N	\N	\N	\N	\N	\N
6887	68	86	EMPTY	\N	\N	\N	\N	\N	\N
6888	68	87	EMPTY	\N	\N	\N	\N	\N	\N
6889	68	88	EMPTY	\N	\N	\N	\N	\N	\N
6890	68	89	EMPTY	\N	\N	\N	\N	\N	\N
6891	68	90	EMPTY	\N	\N	\N	\N	\N	\N
6892	68	91	EMPTY	\N	\N	\N	\N	\N	\N
6893	68	92	EMPTY	\N	\N	\N	\N	\N	\N
6894	68	93	EMPTY	\N	\N	\N	\N	\N	\N
6895	68	94	EMPTY	\N	\N	\N	\N	\N	\N
6896	68	95	EMPTY	\N	\N	\N	\N	\N	\N
6897	68	96	RESOURCE	food	4	\N	\N	\N	\N
6898	68	97	EMPTY	\N	\N	\N	\N	\N	\N
6899	68	98	EMPTY	\N	\N	\N	\N	\N	\N
6900	68	99	EMPTY	\N	\N	\N	\N	\N	\N
6901	69	0	EMPTY	\N	\N	\N	\N	\N	\N
6902	69	1	EMPTY	\N	\N	\N	\N	\N	\N
6903	69	2	EMPTY	\N	\N	\N	\N	\N	\N
6904	69	3	EMPTY	\N	\N	\N	\N	\N	\N
6905	69	4	EMPTY	\N	\N	\N	\N	\N	\N
6906	69	5	EMPTY	\N	\N	\N	\N	\N	\N
6907	69	6	EMPTY	\N	\N	\N	\N	\N	\N
6908	69	7	EMPTY	\N	\N	\N	\N	\N	\N
6909	69	8	EMPTY	\N	\N	\N	\N	\N	\N
6910	69	9	EMPTY	\N	\N	\N	\N	\N	\N
6911	69	10	NPC	\N	\N	9	\N	Barbarian Camp (Lv 9)	\N
6912	69	11	EMPTY	\N	\N	\N	\N	\N	\N
6913	69	12	EMPTY	\N	\N	\N	\N	\N	\N
6914	69	13	EMPTY	\N	\N	\N	\N	\N	\N
6915	69	14	EMPTY	\N	\N	\N	\N	\N	\N
6916	69	15	RESOURCE	stone	2	\N	\N	\N	\N
6917	69	16	EMPTY	\N	\N	\N	\N	\N	\N
6918	69	17	EMPTY	\N	\N	\N	\N	\N	\N
6919	69	18	RESOURCE	food	2	\N	\N	\N	\N
6920	69	19	EMPTY	\N	\N	\N	\N	\N	\N
6921	69	20	EMPTY	\N	\N	\N	\N	\N	\N
6922	69	21	EMPTY	\N	\N	\N	\N	\N	\N
6923	69	22	NPC	\N	\N	8	\N	Barbarian Camp (Lv 8)	\N
6924	69	23	EMPTY	\N	\N	\N	\N	\N	\N
6925	69	24	EMPTY	\N	\N	\N	\N	\N	\N
6926	69	25	EMPTY	\N	\N	\N	\N	\N	\N
6927	69	26	RESOURCE	food	4	\N	\N	\N	\N
6928	69	27	EMPTY	\N	\N	\N	\N	\N	\N
6929	69	28	EMPTY	\N	\N	\N	\N	\N	\N
6930	69	29	EMPTY	\N	\N	\N	\N	\N	\N
6931	69	30	EMPTY	\N	\N	\N	\N	\N	\N
6932	69	31	EMPTY	\N	\N	\N	\N	\N	\N
6933	69	32	EMPTY	\N	\N	\N	\N	\N	\N
6934	69	33	EMPTY	\N	\N	\N	\N	\N	\N
6935	69	34	VALLEY	\N	\N	\N	\N	Valley (69, 34)	\N
6936	69	35	EMPTY	\N	\N	\N	\N	\N	\N
6937	69	36	EMPTY	\N	\N	\N	\N	\N	\N
6938	69	37	EMPTY	\N	\N	\N	\N	\N	\N
6939	69	38	EMPTY	\N	\N	\N	\N	\N	\N
6940	69	39	EMPTY	\N	\N	\N	\N	\N	\N
6941	69	40	EMPTY	\N	\N	\N	\N	\N	\N
6942	69	41	EMPTY	\N	\N	\N	\N	\N	\N
6943	69	42	EMPTY	\N	\N	\N	\N	\N	\N
6944	69	43	EMPTY	\N	\N	\N	\N	\N	\N
6945	69	44	EMPTY	\N	\N	\N	\N	\N	\N
6946	69	45	NPC	\N	\N	8	\N	Barbarian Camp (Lv 8)	\N
6947	69	46	EMPTY	\N	\N	\N	\N	\N	\N
6948	69	47	EMPTY	\N	\N	\N	\N	\N	\N
6949	69	48	EMPTY	\N	\N	\N	\N	\N	\N
6950	69	49	RESOURCE	food	4	\N	\N	\N	\N
6951	69	50	NPC	\N	\N	1	\N	Barbarian Camp (Lv 1)	\N
6952	69	51	EMPTY	\N	\N	\N	\N	\N	\N
6953	69	52	EMPTY	\N	\N	\N	\N	\N	\N
6954	69	53	EMPTY	\N	\N	\N	\N	\N	\N
6955	69	54	EMPTY	\N	\N	\N	\N	\N	\N
6956	69	55	EMPTY	\N	\N	\N	\N	\N	\N
6957	69	56	EMPTY	\N	\N	\N	\N	\N	\N
6958	69	57	EMPTY	\N	\N	\N	\N	\N	\N
6959	69	58	EMPTY	\N	\N	\N	\N	\N	\N
6960	69	59	EMPTY	\N	\N	\N	\N	\N	\N
6961	69	60	EMPTY	\N	\N	\N	\N	\N	\N
6962	69	61	EMPTY	\N	\N	\N	\N	\N	\N
6963	69	62	EMPTY	\N	\N	\N	\N	\N	\N
6964	69	63	EMPTY	\N	\N	\N	\N	\N	\N
6965	69	64	EMPTY	\N	\N	\N	\N	\N	\N
6966	69	65	EMPTY	\N	\N	\N	\N	\N	\N
6967	69	66	EMPTY	\N	\N	\N	\N	\N	\N
6968	69	67	EMPTY	\N	\N	\N	\N	\N	\N
6969	69	68	EMPTY	\N	\N	\N	\N	\N	\N
6970	69	69	EMPTY	\N	\N	\N	\N	\N	\N
6971	69	70	EMPTY	\N	\N	\N	\N	\N	\N
6972	69	71	NPC	\N	\N	7	\N	Barbarian Camp (Lv 7)	\N
6973	69	72	RESOURCE	iron	5	\N	\N	\N	\N
6974	69	73	EMPTY	\N	\N	\N	\N	\N	\N
6975	69	74	EMPTY	\N	\N	\N	\N	\N	\N
6976	69	75	EMPTY	\N	\N	\N	\N	\N	\N
6977	69	76	EMPTY	\N	\N	\N	\N	\N	\N
6978	69	77	EMPTY	\N	\N	\N	\N	\N	\N
6979	69	78	EMPTY	\N	\N	\N	\N	\N	\N
6980	69	79	RESOURCE	wood	5	\N	\N	\N	\N
6981	69	80	EMPTY	\N	\N	\N	\N	\N	\N
6982	69	81	RESOURCE	wood	2	\N	\N	\N	\N
6983	69	82	EMPTY	\N	\N	\N	\N	\N	\N
6984	69	83	EMPTY	\N	\N	\N	\N	\N	\N
6985	69	84	EMPTY	\N	\N	\N	\N	\N	\N
6986	69	85	EMPTY	\N	\N	\N	\N	\N	\N
6987	69	86	EMPTY	\N	\N	\N	\N	\N	\N
6988	69	87	EMPTY	\N	\N	\N	\N	\N	\N
6989	69	88	EMPTY	\N	\N	\N	\N	\N	\N
6990	69	89	RESOURCE	stone	3	\N	\N	\N	\N
6991	69	90	RESOURCE	iron	3	\N	\N	\N	\N
6992	69	91	EMPTY	\N	\N	\N	\N	\N	\N
6993	69	92	NPC	\N	\N	10	\N	Barbarian Camp (Lv 10)	\N
6994	69	93	EMPTY	\N	\N	\N	\N	\N	\N
6995	69	94	EMPTY	\N	\N	\N	\N	\N	\N
6996	69	95	EMPTY	\N	\N	\N	\N	\N	\N
6997	69	96	EMPTY	\N	\N	\N	\N	\N	\N
6998	69	97	EMPTY	\N	\N	\N	\N	\N	\N
6999	69	98	EMPTY	\N	\N	\N	\N	\N	\N
7000	69	99	NPC	\N	\N	3	\N	Barbarian Camp (Lv 3)	\N
7001	70	0	EMPTY	\N	\N	\N	\N	\N	\N
7002	70	1	VALLEY	\N	\N	\N	\N	Valley (70, 1)	\N
7003	70	2	EMPTY	\N	\N	\N	\N	\N	\N
7004	70	3	EMPTY	\N	\N	\N	\N	\N	\N
7005	70	4	EMPTY	\N	\N	\N	\N	\N	\N
7006	70	5	EMPTY	\N	\N	\N	\N	\N	\N
7007	70	6	EMPTY	\N	\N	\N	\N	\N	\N
7008	70	7	RESOURCE	wood	1	\N	\N	\N	\N
7009	70	8	EMPTY	\N	\N	\N	\N	\N	\N
7010	70	9	EMPTY	\N	\N	\N	\N	\N	\N
7011	70	10	RESOURCE	food	1	\N	\N	\N	\N
7012	70	11	EMPTY	\N	\N	\N	\N	\N	\N
7013	70	12	EMPTY	\N	\N	\N	\N	\N	\N
7014	70	13	EMPTY	\N	\N	\N	\N	\N	\N
7015	70	14	NPC	\N	\N	7	\N	Barbarian Camp (Lv 7)	\N
7016	70	15	EMPTY	\N	\N	\N	\N	\N	\N
7017	70	16	RESOURCE	stone	3	\N	\N	\N	\N
7018	70	17	EMPTY	\N	\N	\N	\N	\N	\N
7019	70	18	EMPTY	\N	\N	\N	\N	\N	\N
7020	70	19	EMPTY	\N	\N	\N	\N	\N	\N
7021	70	20	EMPTY	\N	\N	\N	\N	\N	\N
7022	70	21	EMPTY	\N	\N	\N	\N	\N	\N
7023	70	22	EMPTY	\N	\N	\N	\N	\N	\N
7024	70	23	EMPTY	\N	\N	\N	\N	\N	\N
7025	70	24	EMPTY	\N	\N	\N	\N	\N	\N
7026	70	25	EMPTY	\N	\N	\N	\N	\N	\N
7027	70	26	EMPTY	\N	\N	\N	\N	\N	\N
7028	70	27	EMPTY	\N	\N	\N	\N	\N	\N
7029	70	28	EMPTY	\N	\N	\N	\N	\N	\N
7030	70	29	NPC	\N	\N	1	\N	Barbarian Camp (Lv 1)	\N
7031	70	30	EMPTY	\N	\N	\N	\N	\N	\N
7032	70	31	EMPTY	\N	\N	\N	\N	\N	\N
7033	70	32	EMPTY	\N	\N	\N	\N	\N	\N
7034	70	33	EMPTY	\N	\N	\N	\N	\N	\N
7035	70	34	EMPTY	\N	\N	\N	\N	\N	\N
7036	70	35	RESOURCE	iron	1	\N	\N	\N	\N
7037	70	36	EMPTY	\N	\N	\N	\N	\N	\N
7038	70	37	EMPTY	\N	\N	\N	\N	\N	\N
7039	70	38	EMPTY	\N	\N	\N	\N	\N	\N
7040	70	39	EMPTY	\N	\N	\N	\N	\N	\N
7041	70	40	EMPTY	\N	\N	\N	\N	\N	\N
7042	70	41	EMPTY	\N	\N	\N	\N	\N	\N
7043	70	42	EMPTY	\N	\N	\N	\N	\N	\N
7044	70	43	EMPTY	\N	\N	\N	\N	\N	\N
7045	70	44	EMPTY	\N	\N	\N	\N	\N	\N
7046	70	45	EMPTY	\N	\N	\N	\N	\N	\N
7047	70	46	EMPTY	\N	\N	\N	\N	\N	\N
7048	70	47	RESOURCE	food	4	\N	\N	\N	\N
7049	70	48	EMPTY	\N	\N	\N	\N	\N	\N
7050	70	49	EMPTY	\N	\N	\N	\N	\N	\N
7051	70	50	EMPTY	\N	\N	\N	\N	\N	\N
7052	70	51	EMPTY	\N	\N	\N	\N	\N	\N
7053	70	52	EMPTY	\N	\N	\N	\N	\N	\N
7054	70	53	EMPTY	\N	\N	\N	\N	\N	\N
7055	70	54	EMPTY	\N	\N	\N	\N	\N	\N
7056	70	55	EMPTY	\N	\N	\N	\N	\N	\N
7057	70	56	EMPTY	\N	\N	\N	\N	\N	\N
7058	70	57	EMPTY	\N	\N	\N	\N	\N	\N
7059	70	58	EMPTY	\N	\N	\N	\N	\N	\N
7060	70	59	EMPTY	\N	\N	\N	\N	\N	\N
7061	70	60	EMPTY	\N	\N	\N	\N	\N	\N
7062	70	61	EMPTY	\N	\N	\N	\N	\N	\N
7063	70	62	EMPTY	\N	\N	\N	\N	\N	\N
7064	70	63	RESOURCE	food	3	\N	\N	\N	\N
7065	70	64	EMPTY	\N	\N	\N	\N	\N	\N
7066	70	65	EMPTY	\N	\N	\N	\N	\N	\N
7067	70	66	EMPTY	\N	\N	\N	\N	\N	\N
7068	70	67	EMPTY	\N	\N	\N	\N	\N	\N
7069	70	68	EMPTY	\N	\N	\N	\N	\N	\N
7070	70	69	EMPTY	\N	\N	\N	\N	\N	\N
7071	70	70	EMPTY	\N	\N	\N	\N	\N	\N
7072	70	71	RESOURCE	wood	2	\N	\N	\N	\N
7073	70	72	EMPTY	\N	\N	\N	\N	\N	\N
7074	70	73	EMPTY	\N	\N	\N	\N	\N	\N
7075	70	74	EMPTY	\N	\N	\N	\N	\N	\N
7076	70	75	EMPTY	\N	\N	\N	\N	\N	\N
7077	70	76	EMPTY	\N	\N	\N	\N	\N	\N
7078	70	77	EMPTY	\N	\N	\N	\N	\N	\N
7079	70	78	RESOURCE	stone	2	\N	\N	\N	\N
7080	70	79	EMPTY	\N	\N	\N	\N	\N	\N
7081	70	80	EMPTY	\N	\N	\N	\N	\N	\N
7082	70	81	EMPTY	\N	\N	\N	\N	\N	\N
7083	70	82	RESOURCE	food	3	\N	\N	\N	\N
7084	70	83	EMPTY	\N	\N	\N	\N	\N	\N
7085	70	84	RESOURCE	stone	2	\N	\N	\N	\N
7086	70	85	EMPTY	\N	\N	\N	\N	\N	\N
7087	70	86	EMPTY	\N	\N	\N	\N	\N	\N
7088	70	87	EMPTY	\N	\N	\N	\N	\N	\N
7089	70	88	EMPTY	\N	\N	\N	\N	\N	\N
7090	70	89	EMPTY	\N	\N	\N	\N	\N	\N
7091	70	90	EMPTY	\N	\N	\N	\N	\N	\N
7092	70	91	EMPTY	\N	\N	\N	\N	\N	\N
7093	70	92	EMPTY	\N	\N	\N	\N	\N	\N
7094	70	93	EMPTY	\N	\N	\N	\N	\N	\N
7095	70	94	EMPTY	\N	\N	\N	\N	\N	\N
7096	70	95	EMPTY	\N	\N	\N	\N	\N	\N
7097	70	96	EMPTY	\N	\N	\N	\N	\N	\N
7098	70	97	RESOURCE	iron	3	\N	\N	\N	\N
7099	70	98	EMPTY	\N	\N	\N	\N	\N	\N
7100	70	99	EMPTY	\N	\N	\N	\N	\N	\N
7101	71	0	NPC	\N	\N	7	\N	Barbarian Camp (Lv 7)	\N
7102	71	1	EMPTY	\N	\N	\N	\N	\N	\N
7103	71	2	EMPTY	\N	\N	\N	\N	\N	\N
7104	71	3	EMPTY	\N	\N	\N	\N	\N	\N
7105	71	4	EMPTY	\N	\N	\N	\N	\N	\N
7106	71	5	EMPTY	\N	\N	\N	\N	\N	\N
7107	71	6	EMPTY	\N	\N	\N	\N	\N	\N
7108	71	7	EMPTY	\N	\N	\N	\N	\N	\N
7109	71	8	EMPTY	\N	\N	\N	\N	\N	\N
7110	71	9	VALLEY	\N	\N	\N	\N	Valley (71, 9)	\N
7111	71	10	EMPTY	\N	\N	\N	\N	\N	\N
7112	71	11	EMPTY	\N	\N	\N	\N	\N	\N
7113	71	12	EMPTY	\N	\N	\N	\N	\N	\N
7114	71	13	EMPTY	\N	\N	\N	\N	\N	\N
7115	71	14	EMPTY	\N	\N	\N	\N	\N	\N
7116	71	15	EMPTY	\N	\N	\N	\N	\N	\N
7117	71	16	EMPTY	\N	\N	\N	\N	\N	\N
7118	71	17	EMPTY	\N	\N	\N	\N	\N	\N
7119	71	18	EMPTY	\N	\N	\N	\N	\N	\N
7120	71	19	EMPTY	\N	\N	\N	\N	\N	\N
7121	71	20	RESOURCE	stone	1	\N	\N	\N	\N
7122	71	21	EMPTY	\N	\N	\N	\N	\N	\N
7123	71	22	EMPTY	\N	\N	\N	\N	\N	\N
7124	71	23	EMPTY	\N	\N	\N	\N	\N	\N
7125	71	24	EMPTY	\N	\N	\N	\N	\N	\N
7126	71	25	EMPTY	\N	\N	\N	\N	\N	\N
7127	71	26	EMPTY	\N	\N	\N	\N	\N	\N
7128	71	27	EMPTY	\N	\N	\N	\N	\N	\N
7129	71	28	EMPTY	\N	\N	\N	\N	\N	\N
7130	71	29	EMPTY	\N	\N	\N	\N	\N	\N
7131	71	30	EMPTY	\N	\N	\N	\N	\N	\N
7132	71	31	EMPTY	\N	\N	\N	\N	\N	\N
7133	71	32	EMPTY	\N	\N	\N	\N	\N	\N
7134	71	33	EMPTY	\N	\N	\N	\N	\N	\N
7135	71	34	RESOURCE	iron	2	\N	\N	\N	\N
7136	71	35	EMPTY	\N	\N	\N	\N	\N	\N
7137	71	36	EMPTY	\N	\N	\N	\N	\N	\N
7138	71	37	RESOURCE	stone	3	\N	\N	\N	\N
7139	71	38	EMPTY	\N	\N	\N	\N	\N	\N
7140	71	39	EMPTY	\N	\N	\N	\N	\N	\N
7141	71	40	EMPTY	\N	\N	\N	\N	\N	\N
7142	71	41	EMPTY	\N	\N	\N	\N	\N	\N
7143	71	42	EMPTY	\N	\N	\N	\N	\N	\N
7144	71	43	EMPTY	\N	\N	\N	\N	\N	\N
7145	71	44	EMPTY	\N	\N	\N	\N	\N	\N
7146	71	45	EMPTY	\N	\N	\N	\N	\N	\N
7147	71	46	EMPTY	\N	\N	\N	\N	\N	\N
7148	71	47	RESOURCE	wood	4	\N	\N	\N	\N
7149	71	48	EMPTY	\N	\N	\N	\N	\N	\N
7150	71	49	EMPTY	\N	\N	\N	\N	\N	\N
7151	71	50	EMPTY	\N	\N	\N	\N	\N	\N
7152	71	51	EMPTY	\N	\N	\N	\N	\N	\N
7153	71	52	EMPTY	\N	\N	\N	\N	\N	\N
7154	71	53	EMPTY	\N	\N	\N	\N	\N	\N
7155	71	54	EMPTY	\N	\N	\N	\N	\N	\N
7156	71	55	EMPTY	\N	\N	\N	\N	\N	\N
7157	71	56	EMPTY	\N	\N	\N	\N	\N	\N
7158	71	57	EMPTY	\N	\N	\N	\N	\N	\N
7159	71	58	RESOURCE	iron	2	\N	\N	\N	\N
7160	71	59	EMPTY	\N	\N	\N	\N	\N	\N
7161	71	60	NPC	\N	\N	4	\N	Barbarian Camp (Lv 4)	\N
7162	71	61	EMPTY	\N	\N	\N	\N	\N	\N
7163	71	62	EMPTY	\N	\N	\N	\N	\N	\N
7164	71	63	EMPTY	\N	\N	\N	\N	\N	\N
7165	71	64	EMPTY	\N	\N	\N	\N	\N	\N
7166	71	65	EMPTY	\N	\N	\N	\N	\N	\N
7167	71	66	RESOURCE	food	2	\N	\N	\N	\N
7168	71	67	EMPTY	\N	\N	\N	\N	\N	\N
7169	71	68	EMPTY	\N	\N	\N	\N	\N	\N
7170	71	69	EMPTY	\N	\N	\N	\N	\N	\N
7171	71	70	EMPTY	\N	\N	\N	\N	\N	\N
7172	71	71	EMPTY	\N	\N	\N	\N	\N	\N
7173	71	72	EMPTY	\N	\N	\N	\N	\N	\N
7174	71	73	EMPTY	\N	\N	\N	\N	\N	\N
7175	71	74	EMPTY	\N	\N	\N	\N	\N	\N
7176	71	75	EMPTY	\N	\N	\N	\N	\N	\N
7177	71	76	RESOURCE	stone	4	\N	\N	\N	\N
7178	71	77	EMPTY	\N	\N	\N	\N	\N	\N
7179	71	78	EMPTY	\N	\N	\N	\N	\N	\N
7180	71	79	EMPTY	\N	\N	\N	\N	\N	\N
7181	71	80	RESOURCE	iron	2	\N	\N	\N	\N
7182	71	81	EMPTY	\N	\N	\N	\N	\N	\N
7183	71	82	EMPTY	\N	\N	\N	\N	\N	\N
7184	71	83	EMPTY	\N	\N	\N	\N	\N	\N
7185	71	84	EMPTY	\N	\N	\N	\N	\N	\N
7186	71	85	VALLEY	\N	\N	\N	\N	Valley (71, 85)	\N
7187	71	86	EMPTY	\N	\N	\N	\N	\N	\N
7188	71	87	EMPTY	\N	\N	\N	\N	\N	\N
7189	71	88	EMPTY	\N	\N	\N	\N	\N	\N
7190	71	89	EMPTY	\N	\N	\N	\N	\N	\N
7191	71	90	RESOURCE	wood	2	\N	\N	\N	\N
7192	71	91	NPC	\N	\N	1	\N	Barbarian Camp (Lv 1)	\N
7193	71	92	EMPTY	\N	\N	\N	\N	\N	\N
7194	71	93	EMPTY	\N	\N	\N	\N	\N	\N
7195	71	94	EMPTY	\N	\N	\N	\N	\N	\N
7196	71	95	EMPTY	\N	\N	\N	\N	\N	\N
7197	71	96	EMPTY	\N	\N	\N	\N	\N	\N
7198	71	97	EMPTY	\N	\N	\N	\N	\N	\N
7199	71	98	EMPTY	\N	\N	\N	\N	\N	\N
7200	71	99	EMPTY	\N	\N	\N	\N	\N	\N
7201	72	0	EMPTY	\N	\N	\N	\N	\N	\N
7202	72	1	EMPTY	\N	\N	\N	\N	\N	\N
7203	72	2	EMPTY	\N	\N	\N	\N	\N	\N
7204	72	3	EMPTY	\N	\N	\N	\N	\N	\N
7205	72	4	EMPTY	\N	\N	\N	\N	\N	\N
7206	72	5	EMPTY	\N	\N	\N	\N	\N	\N
7207	72	6	EMPTY	\N	\N	\N	\N	\N	\N
7208	72	7	EMPTY	\N	\N	\N	\N	\N	\N
7209	72	8	EMPTY	\N	\N	\N	\N	\N	\N
7210	72	9	EMPTY	\N	\N	\N	\N	\N	\N
7211	72	10	EMPTY	\N	\N	\N	\N	\N	\N
7212	72	11	EMPTY	\N	\N	\N	\N	\N	\N
7213	72	12	EMPTY	\N	\N	\N	\N	\N	\N
7214	72	13	EMPTY	\N	\N	\N	\N	\N	\N
7215	72	14	NPC	\N	\N	4	\N	Barbarian Camp (Lv 4)	\N
7216	72	15	EMPTY	\N	\N	\N	\N	\N	\N
7217	72	16	EMPTY	\N	\N	\N	\N	\N	\N
7218	72	17	EMPTY	\N	\N	\N	\N	\N	\N
7219	72	18	EMPTY	\N	\N	\N	\N	\N	\N
7220	72	19	EMPTY	\N	\N	\N	\N	\N	\N
7221	72	20	EMPTY	\N	\N	\N	\N	\N	\N
7222	72	21	VALLEY	\N	\N	\N	\N	Valley (72, 21)	\N
7223	72	22	EMPTY	\N	\N	\N	\N	\N	\N
7224	72	23	EMPTY	\N	\N	\N	\N	\N	\N
7225	72	24	EMPTY	\N	\N	\N	\N	\N	\N
7226	72	25	EMPTY	\N	\N	\N	\N	\N	\N
7227	72	26	EMPTY	\N	\N	\N	\N	\N	\N
7228	72	27	EMPTY	\N	\N	\N	\N	\N	\N
7229	72	28	EMPTY	\N	\N	\N	\N	\N	\N
7230	72	29	EMPTY	\N	\N	\N	\N	\N	\N
7231	72	30	EMPTY	\N	\N	\N	\N	\N	\N
7232	72	31	EMPTY	\N	\N	\N	\N	\N	\N
7233	72	32	EMPTY	\N	\N	\N	\N	\N	\N
7234	72	33	EMPTY	\N	\N	\N	\N	\N	\N
7235	72	34	EMPTY	\N	\N	\N	\N	\N	\N
7236	72	35	EMPTY	\N	\N	\N	\N	\N	\N
7237	72	36	EMPTY	\N	\N	\N	\N	\N	\N
7238	72	37	EMPTY	\N	\N	\N	\N	\N	\N
7239	72	38	EMPTY	\N	\N	\N	\N	\N	\N
7240	72	39	EMPTY	\N	\N	\N	\N	\N	\N
7241	72	40	EMPTY	\N	\N	\N	\N	\N	\N
7242	72	41	NPC	\N	\N	7	\N	Barbarian Camp (Lv 7)	\N
7243	72	42	NPC	\N	\N	5	\N	Barbarian Camp (Lv 5)	\N
7244	72	43	NPC	\N	\N	7	\N	Barbarian Camp (Lv 7)	\N
7245	72	44	EMPTY	\N	\N	\N	\N	\N	\N
7246	72	45	EMPTY	\N	\N	\N	\N	\N	\N
7247	72	46	EMPTY	\N	\N	\N	\N	\N	\N
7248	72	47	EMPTY	\N	\N	\N	\N	\N	\N
7249	72	48	EMPTY	\N	\N	\N	\N	\N	\N
7250	72	49	EMPTY	\N	\N	\N	\N	\N	\N
7251	72	50	EMPTY	\N	\N	\N	\N	\N	\N
7252	72	51	EMPTY	\N	\N	\N	\N	\N	\N
7253	72	52	EMPTY	\N	\N	\N	\N	\N	\N
7254	72	53	EMPTY	\N	\N	\N	\N	\N	\N
7255	72	54	EMPTY	\N	\N	\N	\N	\N	\N
7256	72	55	EMPTY	\N	\N	\N	\N	\N	\N
7257	72	56	EMPTY	\N	\N	\N	\N	\N	\N
7258	72	57	EMPTY	\N	\N	\N	\N	\N	\N
7259	72	58	EMPTY	\N	\N	\N	\N	\N	\N
7260	72	59	EMPTY	\N	\N	\N	\N	\N	\N
7261	72	60	EMPTY	\N	\N	\N	\N	\N	\N
7262	72	61	EMPTY	\N	\N	\N	\N	\N	\N
7263	72	62	EMPTY	\N	\N	\N	\N	\N	\N
7264	72	63	EMPTY	\N	\N	\N	\N	\N	\N
7265	72	64	EMPTY	\N	\N	\N	\N	\N	\N
7266	72	65	EMPTY	\N	\N	\N	\N	\N	\N
7267	72	66	EMPTY	\N	\N	\N	\N	\N	\N
7268	72	67	EMPTY	\N	\N	\N	\N	\N	\N
7269	72	68	EMPTY	\N	\N	\N	\N	\N	\N
7270	72	69	EMPTY	\N	\N	\N	\N	\N	\N
7271	72	70	EMPTY	\N	\N	\N	\N	\N	\N
7272	72	71	EMPTY	\N	\N	\N	\N	\N	\N
7273	72	72	EMPTY	\N	\N	\N	\N	\N	\N
7274	72	73	EMPTY	\N	\N	\N	\N	\N	\N
7275	72	74	EMPTY	\N	\N	\N	\N	\N	\N
7276	72	75	EMPTY	\N	\N	\N	\N	\N	\N
7277	72	76	EMPTY	\N	\N	\N	\N	\N	\N
7278	72	77	EMPTY	\N	\N	\N	\N	\N	\N
7279	72	78	EMPTY	\N	\N	\N	\N	\N	\N
7280	72	79	RESOURCE	iron	5	\N	\N	\N	\N
7281	72	80	EMPTY	\N	\N	\N	\N	\N	\N
7282	72	81	EMPTY	\N	\N	\N	\N	\N	\N
7283	72	82	EMPTY	\N	\N	\N	\N	\N	\N
7284	72	83	EMPTY	\N	\N	\N	\N	\N	\N
7285	72	84	EMPTY	\N	\N	\N	\N	\N	\N
7286	72	85	NPC	\N	\N	2	\N	Barbarian Camp (Lv 2)	\N
7287	72	86	EMPTY	\N	\N	\N	\N	\N	\N
7288	72	87	EMPTY	\N	\N	\N	\N	\N	\N
7289	72	88	NPC	\N	\N	4	\N	Barbarian Camp (Lv 4)	\N
7290	72	89	EMPTY	\N	\N	\N	\N	\N	\N
7291	72	90	EMPTY	\N	\N	\N	\N	\N	\N
7292	72	91	EMPTY	\N	\N	\N	\N	\N	\N
7293	72	92	EMPTY	\N	\N	\N	\N	\N	\N
7294	72	93	RESOURCE	food	2	\N	\N	\N	\N
7295	72	94	NPC	\N	\N	8	\N	Barbarian Camp (Lv 8)	\N
7296	72	95	EMPTY	\N	\N	\N	\N	\N	\N
7297	72	96	EMPTY	\N	\N	\N	\N	\N	\N
7298	72	97	NPC	\N	\N	10	\N	Barbarian Camp (Lv 10)	\N
7299	72	98	EMPTY	\N	\N	\N	\N	\N	\N
7300	72	99	EMPTY	\N	\N	\N	\N	\N	\N
7301	73	0	EMPTY	\N	\N	\N	\N	\N	\N
7302	73	1	EMPTY	\N	\N	\N	\N	\N	\N
7303	73	2	EMPTY	\N	\N	\N	\N	\N	\N
7304	73	3	NPC	\N	\N	7	\N	Barbarian Camp (Lv 7)	\N
7305	73	4	NPC	\N	\N	5	\N	Barbarian Camp (Lv 5)	\N
7306	73	5	EMPTY	\N	\N	\N	\N	\N	\N
7307	73	6	EMPTY	\N	\N	\N	\N	\N	\N
7308	73	7	EMPTY	\N	\N	\N	\N	\N	\N
7309	73	8	EMPTY	\N	\N	\N	\N	\N	\N
7310	73	9	EMPTY	\N	\N	\N	\N	\N	\N
7311	73	10	EMPTY	\N	\N	\N	\N	\N	\N
7312	73	11	EMPTY	\N	\N	\N	\N	\N	\N
7313	73	12	EMPTY	\N	\N	\N	\N	\N	\N
7314	73	13	RESOURCE	food	5	\N	\N	\N	\N
7315	73	14	EMPTY	\N	\N	\N	\N	\N	\N
7316	73	15	EMPTY	\N	\N	\N	\N	\N	\N
7317	73	16	EMPTY	\N	\N	\N	\N	\N	\N
7318	73	17	EMPTY	\N	\N	\N	\N	\N	\N
7319	73	18	EMPTY	\N	\N	\N	\N	\N	\N
7320	73	19	EMPTY	\N	\N	\N	\N	\N	\N
7321	73	20	EMPTY	\N	\N	\N	\N	\N	\N
7322	73	21	NPC	\N	\N	9	\N	Barbarian Camp (Lv 9)	\N
7323	73	22	EMPTY	\N	\N	\N	\N	\N	\N
7324	73	23	EMPTY	\N	\N	\N	\N	\N	\N
7325	73	24	RESOURCE	stone	1	\N	\N	\N	\N
7326	73	25	EMPTY	\N	\N	\N	\N	\N	\N
7327	73	26	RESOURCE	stone	4	\N	\N	\N	\N
7328	73	27	EMPTY	\N	\N	\N	\N	\N	\N
7329	73	28	NPC	\N	\N	5	\N	Barbarian Camp (Lv 5)	\N
7330	73	29	EMPTY	\N	\N	\N	\N	\N	\N
7331	73	30	EMPTY	\N	\N	\N	\N	\N	\N
7332	73	31	EMPTY	\N	\N	\N	\N	\N	\N
7333	73	32	EMPTY	\N	\N	\N	\N	\N	\N
7334	73	33	EMPTY	\N	\N	\N	\N	\N	\N
7335	73	34	EMPTY	\N	\N	\N	\N	\N	\N
7336	73	35	EMPTY	\N	\N	\N	\N	\N	\N
7337	73	36	EMPTY	\N	\N	\N	\N	\N	\N
7338	73	37	EMPTY	\N	\N	\N	\N	\N	\N
7339	73	38	EMPTY	\N	\N	\N	\N	\N	\N
7340	73	39	EMPTY	\N	\N	\N	\N	\N	\N
7341	73	40	EMPTY	\N	\N	\N	\N	\N	\N
7342	73	41	EMPTY	\N	\N	\N	\N	\N	\N
7343	73	42	EMPTY	\N	\N	\N	\N	\N	\N
7344	73	43	EMPTY	\N	\N	\N	\N	\N	\N
7345	73	44	EMPTY	\N	\N	\N	\N	\N	\N
7346	73	45	EMPTY	\N	\N	\N	\N	\N	\N
7347	73	46	EMPTY	\N	\N	\N	\N	\N	\N
7348	73	47	EMPTY	\N	\N	\N	\N	\N	\N
7349	73	48	EMPTY	\N	\N	\N	\N	\N	\N
7350	73	49	EMPTY	\N	\N	\N	\N	\N	\N
7351	73	50	RESOURCE	iron	4	\N	\N	\N	\N
7352	73	51	EMPTY	\N	\N	\N	\N	\N	\N
7353	73	52	EMPTY	\N	\N	\N	\N	\N	\N
7354	73	53	EMPTY	\N	\N	\N	\N	\N	\N
7355	73	54	EMPTY	\N	\N	\N	\N	\N	\N
7356	73	55	EMPTY	\N	\N	\N	\N	\N	\N
7357	73	56	EMPTY	\N	\N	\N	\N	\N	\N
7358	73	57	EMPTY	\N	\N	\N	\N	\N	\N
7359	73	58	EMPTY	\N	\N	\N	\N	\N	\N
7360	73	59	EMPTY	\N	\N	\N	\N	\N	\N
7361	73	60	RESOURCE	wood	2	\N	\N	\N	\N
7362	73	61	EMPTY	\N	\N	\N	\N	\N	\N
7363	73	62	EMPTY	\N	\N	\N	\N	\N	\N
7364	73	63	EMPTY	\N	\N	\N	\N	\N	\N
7365	73	64	EMPTY	\N	\N	\N	\N	\N	\N
7366	73	65	EMPTY	\N	\N	\N	\N	\N	\N
7367	73	66	NPC	\N	\N	8	\N	Barbarian Camp (Lv 8)	\N
7368	73	67	EMPTY	\N	\N	\N	\N	\N	\N
7369	73	68	EMPTY	\N	\N	\N	\N	\N	\N
7370	73	69	EMPTY	\N	\N	\N	\N	\N	\N
7371	73	70	EMPTY	\N	\N	\N	\N	\N	\N
7372	73	71	EMPTY	\N	\N	\N	\N	\N	\N
7373	73	72	EMPTY	\N	\N	\N	\N	\N	\N
7374	73	73	RESOURCE	stone	3	\N	\N	\N	\N
7375	73	74	EMPTY	\N	\N	\N	\N	\N	\N
7376	73	75	EMPTY	\N	\N	\N	\N	\N	\N
7377	73	76	NPC	\N	\N	8	\N	Barbarian Camp (Lv 8)	\N
7378	73	77	EMPTY	\N	\N	\N	\N	\N	\N
7379	73	78	EMPTY	\N	\N	\N	\N	\N	\N
7380	73	79	EMPTY	\N	\N	\N	\N	\N	\N
7381	73	80	EMPTY	\N	\N	\N	\N	\N	\N
7382	73	81	EMPTY	\N	\N	\N	\N	\N	\N
7383	73	82	EMPTY	\N	\N	\N	\N	\N	\N
7384	73	83	EMPTY	\N	\N	\N	\N	\N	\N
7385	73	84	EMPTY	\N	\N	\N	\N	\N	\N
7386	73	85	RESOURCE	stone	1	\N	\N	\N	\N
7387	73	86	RESOURCE	iron	2	\N	\N	\N	\N
7388	73	87	EMPTY	\N	\N	\N	\N	\N	\N
7389	73	88	NPC	\N	\N	4	\N	Barbarian Camp (Lv 4)	\N
7390	73	89	EMPTY	\N	\N	\N	\N	\N	\N
7391	73	90	EMPTY	\N	\N	\N	\N	\N	\N
7392	73	91	EMPTY	\N	\N	\N	\N	\N	\N
7393	73	92	EMPTY	\N	\N	\N	\N	\N	\N
7394	73	93	EMPTY	\N	\N	\N	\N	\N	\N
7395	73	94	EMPTY	\N	\N	\N	\N	\N	\N
7396	73	95	EMPTY	\N	\N	\N	\N	\N	\N
7397	73	96	EMPTY	\N	\N	\N	\N	\N	\N
7398	73	97	EMPTY	\N	\N	\N	\N	\N	\N
7399	73	98	EMPTY	\N	\N	\N	\N	\N	\N
7400	73	99	EMPTY	\N	\N	\N	\N	\N	\N
7401	74	0	EMPTY	\N	\N	\N	\N	\N	\N
7402	74	1	EMPTY	\N	\N	\N	\N	\N	\N
7403	74	2	EMPTY	\N	\N	\N	\N	\N	\N
7404	74	3	EMPTY	\N	\N	\N	\N	\N	\N
7405	74	4	EMPTY	\N	\N	\N	\N	\N	\N
7406	74	5	EMPTY	\N	\N	\N	\N	\N	\N
7407	74	6	EMPTY	\N	\N	\N	\N	\N	\N
7408	74	7	EMPTY	\N	\N	\N	\N	\N	\N
7409	74	8	NPC	\N	\N	7	\N	Barbarian Camp (Lv 7)	\N
7410	74	9	EMPTY	\N	\N	\N	\N	\N	\N
7411	74	10	EMPTY	\N	\N	\N	\N	\N	\N
7412	74	11	EMPTY	\N	\N	\N	\N	\N	\N
7413	74	12	EMPTY	\N	\N	\N	\N	\N	\N
7414	74	13	EMPTY	\N	\N	\N	\N	\N	\N
7415	74	14	RESOURCE	iron	1	\N	\N	\N	\N
7416	74	15	EMPTY	\N	\N	\N	\N	\N	\N
7417	74	16	EMPTY	\N	\N	\N	\N	\N	\N
7418	74	17	EMPTY	\N	\N	\N	\N	\N	\N
7419	74	18	EMPTY	\N	\N	\N	\N	\N	\N
7420	74	19	EMPTY	\N	\N	\N	\N	\N	\N
7421	74	20	EMPTY	\N	\N	\N	\N	\N	\N
7422	74	21	EMPTY	\N	\N	\N	\N	\N	\N
7423	74	22	EMPTY	\N	\N	\N	\N	\N	\N
7424	74	23	EMPTY	\N	\N	\N	\N	\N	\N
7425	74	24	EMPTY	\N	\N	\N	\N	\N	\N
7426	74	25	EMPTY	\N	\N	\N	\N	\N	\N
7427	74	26	EMPTY	\N	\N	\N	\N	\N	\N
7428	74	27	EMPTY	\N	\N	\N	\N	\N	\N
7429	74	28	EMPTY	\N	\N	\N	\N	\N	\N
7430	74	29	EMPTY	\N	\N	\N	\N	\N	\N
7431	74	30	EMPTY	\N	\N	\N	\N	\N	\N
7432	74	31	EMPTY	\N	\N	\N	\N	\N	\N
7433	74	32	RESOURCE	iron	2	\N	\N	\N	\N
7434	74	33	EMPTY	\N	\N	\N	\N	\N	\N
7435	74	34	EMPTY	\N	\N	\N	\N	\N	\N
7436	74	35	EMPTY	\N	\N	\N	\N	\N	\N
7437	74	36	EMPTY	\N	\N	\N	\N	\N	\N
7438	74	37	EMPTY	\N	\N	\N	\N	\N	\N
7439	74	38	EMPTY	\N	\N	\N	\N	\N	\N
7440	74	39	EMPTY	\N	\N	\N	\N	\N	\N
7441	74	40	EMPTY	\N	\N	\N	\N	\N	\N
7442	74	41	EMPTY	\N	\N	\N	\N	\N	\N
7443	74	42	EMPTY	\N	\N	\N	\N	\N	\N
7444	74	43	EMPTY	\N	\N	\N	\N	\N	\N
7445	74	44	EMPTY	\N	\N	\N	\N	\N	\N
7446	74	45	EMPTY	\N	\N	\N	\N	\N	\N
7447	74	46	EMPTY	\N	\N	\N	\N	\N	\N
7448	74	47	EMPTY	\N	\N	\N	\N	\N	\N
7449	74	48	EMPTY	\N	\N	\N	\N	\N	\N
7450	74	49	EMPTY	\N	\N	\N	\N	\N	\N
7451	74	50	EMPTY	\N	\N	\N	\N	\N	\N
7452	74	51	EMPTY	\N	\N	\N	\N	\N	\N
7453	74	52	EMPTY	\N	\N	\N	\N	\N	\N
7454	74	53	NPC	\N	\N	6	\N	Barbarian Camp (Lv 6)	\N
7455	74	54	EMPTY	\N	\N	\N	\N	\N	\N
7456	74	55	EMPTY	\N	\N	\N	\N	\N	\N
7457	74	56	EMPTY	\N	\N	\N	\N	\N	\N
7458	74	57	EMPTY	\N	\N	\N	\N	\N	\N
7459	74	58	EMPTY	\N	\N	\N	\N	\N	\N
7460	74	59	EMPTY	\N	\N	\N	\N	\N	\N
7461	74	60	EMPTY	\N	\N	\N	\N	\N	\N
7462	74	61	EMPTY	\N	\N	\N	\N	\N	\N
7463	74	62	EMPTY	\N	\N	\N	\N	\N	\N
7464	74	63	EMPTY	\N	\N	\N	\N	\N	\N
7465	74	64	EMPTY	\N	\N	\N	\N	\N	\N
7466	74	65	VALLEY	\N	\N	\N	\N	Valley (74, 65)	\N
7467	74	66	EMPTY	\N	\N	\N	\N	\N	\N
7468	74	67	EMPTY	\N	\N	\N	\N	\N	\N
7469	74	68	EMPTY	\N	\N	\N	\N	\N	\N
7470	74	69	EMPTY	\N	\N	\N	\N	\N	\N
7471	74	70	EMPTY	\N	\N	\N	\N	\N	\N
7472	74	71	EMPTY	\N	\N	\N	\N	\N	\N
7473	74	72	EMPTY	\N	\N	\N	\N	\N	\N
7474	74	73	EMPTY	\N	\N	\N	\N	\N	\N
7475	74	74	EMPTY	\N	\N	\N	\N	\N	\N
7476	74	75	RESOURCE	wood	2	\N	\N	\N	\N
7477	74	76	EMPTY	\N	\N	\N	\N	\N	\N
7478	74	77	EMPTY	\N	\N	\N	\N	\N	\N
7479	74	78	EMPTY	\N	\N	\N	\N	\N	\N
7480	74	79	EMPTY	\N	\N	\N	\N	\N	\N
7481	74	80	EMPTY	\N	\N	\N	\N	\N	\N
7482	74	81	EMPTY	\N	\N	\N	\N	\N	\N
7483	74	82	EMPTY	\N	\N	\N	\N	\N	\N
7484	74	83	EMPTY	\N	\N	\N	\N	\N	\N
7485	74	84	EMPTY	\N	\N	\N	\N	\N	\N
7486	74	85	EMPTY	\N	\N	\N	\N	\N	\N
7487	74	86	EMPTY	\N	\N	\N	\N	\N	\N
7488	74	87	EMPTY	\N	\N	\N	\N	\N	\N
7489	74	88	EMPTY	\N	\N	\N	\N	\N	\N
7490	74	89	EMPTY	\N	\N	\N	\N	\N	\N
7491	74	90	EMPTY	\N	\N	\N	\N	\N	\N
7492	74	91	EMPTY	\N	\N	\N	\N	\N	\N
7493	74	92	EMPTY	\N	\N	\N	\N	\N	\N
7494	74	93	EMPTY	\N	\N	\N	\N	\N	\N
7495	74	94	EMPTY	\N	\N	\N	\N	\N	\N
7496	74	95	EMPTY	\N	\N	\N	\N	\N	\N
7497	74	96	EMPTY	\N	\N	\N	\N	\N	\N
7498	74	97	RESOURCE	stone	3	\N	\N	\N	\N
7499	74	98	NPC	\N	\N	9	\N	Barbarian Camp (Lv 9)	\N
7500	74	99	EMPTY	\N	\N	\N	\N	\N	\N
7501	75	0	RESOURCE	stone	4	\N	\N	\N	\N
7502	75	1	EMPTY	\N	\N	\N	\N	\N	\N
7503	75	2	NPC	\N	\N	9	\N	Barbarian Camp (Lv 9)	\N
7504	75	3	EMPTY	\N	\N	\N	\N	\N	\N
7505	75	4	EMPTY	\N	\N	\N	\N	\N	\N
7506	75	5	EMPTY	\N	\N	\N	\N	\N	\N
7507	75	6	EMPTY	\N	\N	\N	\N	\N	\N
7508	75	7	EMPTY	\N	\N	\N	\N	\N	\N
7509	75	8	EMPTY	\N	\N	\N	\N	\N	\N
7510	75	9	RESOURCE	stone	4	\N	\N	\N	\N
7511	75	10	RESOURCE	food	2	\N	\N	\N	\N
7512	75	11	EMPTY	\N	\N	\N	\N	\N	\N
7513	75	12	EMPTY	\N	\N	\N	\N	\N	\N
7514	75	13	EMPTY	\N	\N	\N	\N	\N	\N
7515	75	14	EMPTY	\N	\N	\N	\N	\N	\N
7516	75	15	EMPTY	\N	\N	\N	\N	\N	\N
7517	75	16	EMPTY	\N	\N	\N	\N	\N	\N
7518	75	17	EMPTY	\N	\N	\N	\N	\N	\N
7519	75	18	EMPTY	\N	\N	\N	\N	\N	\N
7520	75	19	EMPTY	\N	\N	\N	\N	\N	\N
7521	75	20	EMPTY	\N	\N	\N	\N	\N	\N
7522	75	21	EMPTY	\N	\N	\N	\N	\N	\N
7523	75	22	RESOURCE	iron	2	\N	\N	\N	\N
7524	75	23	EMPTY	\N	\N	\N	\N	\N	\N
7525	75	24	EMPTY	\N	\N	\N	\N	\N	\N
7526	75	25	EMPTY	\N	\N	\N	\N	\N	\N
7527	75	26	EMPTY	\N	\N	\N	\N	\N	\N
7528	75	27	EMPTY	\N	\N	\N	\N	\N	\N
7529	75	28	EMPTY	\N	\N	\N	\N	\N	\N
7530	75	29	EMPTY	\N	\N	\N	\N	\N	\N
7531	75	30	EMPTY	\N	\N	\N	\N	\N	\N
7532	75	31	EMPTY	\N	\N	\N	\N	\N	\N
7533	75	32	RESOURCE	iron	5	\N	\N	\N	\N
7534	75	33	EMPTY	\N	\N	\N	\N	\N	\N
7535	75	34	EMPTY	\N	\N	\N	\N	\N	\N
7536	75	35	EMPTY	\N	\N	\N	\N	\N	\N
7537	75	36	EMPTY	\N	\N	\N	\N	\N	\N
7538	75	37	EMPTY	\N	\N	\N	\N	\N	\N
7539	75	38	EMPTY	\N	\N	\N	\N	\N	\N
7540	75	39	EMPTY	\N	\N	\N	\N	\N	\N
7541	75	40	EMPTY	\N	\N	\N	\N	\N	\N
7542	75	41	EMPTY	\N	\N	\N	\N	\N	\N
7543	75	42	EMPTY	\N	\N	\N	\N	\N	\N
7544	75	43	EMPTY	\N	\N	\N	\N	\N	\N
7545	75	44	NPC	\N	\N	1	\N	Barbarian Camp (Lv 1)	\N
7546	75	45	EMPTY	\N	\N	\N	\N	\N	\N
7547	75	46	RESOURCE	iron	1	\N	\N	\N	\N
7548	75	47	EMPTY	\N	\N	\N	\N	\N	\N
7549	75	48	EMPTY	\N	\N	\N	\N	\N	\N
7550	75	49	EMPTY	\N	\N	\N	\N	\N	\N
7551	75	50	EMPTY	\N	\N	\N	\N	\N	\N
7552	75	51	EMPTY	\N	\N	\N	\N	\N	\N
7553	75	52	EMPTY	\N	\N	\N	\N	\N	\N
7554	75	53	EMPTY	\N	\N	\N	\N	\N	\N
7555	75	54	EMPTY	\N	\N	\N	\N	\N	\N
7556	75	55	EMPTY	\N	\N	\N	\N	\N	\N
7557	75	56	NPC	\N	\N	1	\N	Barbarian Camp (Lv 1)	\N
7558	75	57	EMPTY	\N	\N	\N	\N	\N	\N
7559	75	58	EMPTY	\N	\N	\N	\N	\N	\N
7560	75	59	EMPTY	\N	\N	\N	\N	\N	\N
7561	75	60	EMPTY	\N	\N	\N	\N	\N	\N
7562	75	61	EMPTY	\N	\N	\N	\N	\N	\N
7563	75	62	EMPTY	\N	\N	\N	\N	\N	\N
7564	75	63	EMPTY	\N	\N	\N	\N	\N	\N
7565	75	64	EMPTY	\N	\N	\N	\N	\N	\N
7566	75	65	EMPTY	\N	\N	\N	\N	\N	\N
7567	75	66	EMPTY	\N	\N	\N	\N	\N	\N
7568	75	67	EMPTY	\N	\N	\N	\N	\N	\N
7569	75	68	EMPTY	\N	\N	\N	\N	\N	\N
7570	75	69	EMPTY	\N	\N	\N	\N	\N	\N
7571	75	70	EMPTY	\N	\N	\N	\N	\N	\N
7572	75	71	EMPTY	\N	\N	\N	\N	\N	\N
7573	75	72	RESOURCE	iron	4	\N	\N	\N	\N
7574	75	73	EMPTY	\N	\N	\N	\N	\N	\N
7575	75	74	EMPTY	\N	\N	\N	\N	\N	\N
7576	75	75	EMPTY	\N	\N	\N	\N	\N	\N
7577	75	76	EMPTY	\N	\N	\N	\N	\N	\N
7578	75	77	RESOURCE	stone	4	\N	\N	\N	\N
7579	75	78	EMPTY	\N	\N	\N	\N	\N	\N
7580	75	79	EMPTY	\N	\N	\N	\N	\N	\N
7581	75	80	EMPTY	\N	\N	\N	\N	\N	\N
7582	75	81	NPC	\N	\N	10	\N	Barbarian Camp (Lv 10)	\N
7583	75	82	EMPTY	\N	\N	\N	\N	\N	\N
7584	75	83	EMPTY	\N	\N	\N	\N	\N	\N
7585	75	84	EMPTY	\N	\N	\N	\N	\N	\N
7586	75	85	EMPTY	\N	\N	\N	\N	\N	\N
7587	75	86	EMPTY	\N	\N	\N	\N	\N	\N
7588	75	87	EMPTY	\N	\N	\N	\N	\N	\N
7589	75	88	EMPTY	\N	\N	\N	\N	\N	\N
7590	75	89	EMPTY	\N	\N	\N	\N	\N	\N
7591	75	90	EMPTY	\N	\N	\N	\N	\N	\N
7592	75	91	EMPTY	\N	\N	\N	\N	\N	\N
7593	75	92	EMPTY	\N	\N	\N	\N	\N	\N
7594	75	93	EMPTY	\N	\N	\N	\N	\N	\N
7595	75	94	EMPTY	\N	\N	\N	\N	\N	\N
7596	75	95	EMPTY	\N	\N	\N	\N	\N	\N
7597	75	96	RESOURCE	food	3	\N	\N	\N	\N
7598	75	97	EMPTY	\N	\N	\N	\N	\N	\N
7599	75	98	EMPTY	\N	\N	\N	\N	\N	\N
7600	75	99	EMPTY	\N	\N	\N	\N	\N	\N
7601	76	0	EMPTY	\N	\N	\N	\N	\N	\N
7602	76	1	EMPTY	\N	\N	\N	\N	\N	\N
7603	76	2	EMPTY	\N	\N	\N	\N	\N	\N
7604	76	3	RESOURCE	wood	5	\N	\N	\N	\N
7605	76	4	EMPTY	\N	\N	\N	\N	\N	\N
7606	76	5	EMPTY	\N	\N	\N	\N	\N	\N
7607	76	6	EMPTY	\N	\N	\N	\N	\N	\N
7608	76	7	EMPTY	\N	\N	\N	\N	\N	\N
7609	76	8	EMPTY	\N	\N	\N	\N	\N	\N
7610	76	9	VALLEY	\N	\N	\N	\N	Valley (76, 9)	\N
7611	76	10	EMPTY	\N	\N	\N	\N	\N	\N
7612	76	11	EMPTY	\N	\N	\N	\N	\N	\N
7613	76	12	EMPTY	\N	\N	\N	\N	\N	\N
7614	76	13	EMPTY	\N	\N	\N	\N	\N	\N
7615	76	14	EMPTY	\N	\N	\N	\N	\N	\N
7616	76	15	NPC	\N	\N	2	\N	Barbarian Camp (Lv 2)	\N
7617	76	16	EMPTY	\N	\N	\N	\N	\N	\N
7618	76	17	VALLEY	\N	\N	\N	\N	Valley (76, 17)	\N
7619	76	18	EMPTY	\N	\N	\N	\N	\N	\N
7620	76	19	EMPTY	\N	\N	\N	\N	\N	\N
7621	76	20	EMPTY	\N	\N	\N	\N	\N	\N
7622	76	21	EMPTY	\N	\N	\N	\N	\N	\N
7623	76	22	EMPTY	\N	\N	\N	\N	\N	\N
7624	76	23	NPC	\N	\N	10	\N	Barbarian Camp (Lv 10)	\N
7625	76	24	EMPTY	\N	\N	\N	\N	\N	\N
7626	76	25	EMPTY	\N	\N	\N	\N	\N	\N
7627	76	26	EMPTY	\N	\N	\N	\N	\N	\N
7628	76	27	EMPTY	\N	\N	\N	\N	\N	\N
7629	76	28	EMPTY	\N	\N	\N	\N	\N	\N
7630	76	29	EMPTY	\N	\N	\N	\N	\N	\N
7631	76	30	NPC	\N	\N	9	\N	Barbarian Camp (Lv 9)	\N
7632	76	31	EMPTY	\N	\N	\N	\N	\N	\N
7633	76	32	RESOURCE	iron	4	\N	\N	\N	\N
7634	76	33	EMPTY	\N	\N	\N	\N	\N	\N
7635	76	34	EMPTY	\N	\N	\N	\N	\N	\N
7636	76	35	VALLEY	\N	\N	\N	\N	Valley (76, 35)	\N
7637	76	36	EMPTY	\N	\N	\N	\N	\N	\N
7638	76	37	NPC	\N	\N	1	\N	Barbarian Camp (Lv 1)	\N
7639	76	38	EMPTY	\N	\N	\N	\N	\N	\N
7640	76	39	NPC	\N	\N	7	\N	Barbarian Camp (Lv 7)	\N
7641	76	40	EMPTY	\N	\N	\N	\N	\N	\N
7642	76	41	RESOURCE	iron	2	\N	\N	\N	\N
7643	76	42	EMPTY	\N	\N	\N	\N	\N	\N
7644	76	43	EMPTY	\N	\N	\N	\N	\N	\N
7645	76	44	EMPTY	\N	\N	\N	\N	\N	\N
7646	76	45	EMPTY	\N	\N	\N	\N	\N	\N
7647	76	46	EMPTY	\N	\N	\N	\N	\N	\N
7648	76	47	EMPTY	\N	\N	\N	\N	\N	\N
7649	76	48	EMPTY	\N	\N	\N	\N	\N	\N
7650	76	49	EMPTY	\N	\N	\N	\N	\N	\N
7651	76	50	EMPTY	\N	\N	\N	\N	\N	\N
7652	76	51	EMPTY	\N	\N	\N	\N	\N	\N
7653	76	52	EMPTY	\N	\N	\N	\N	\N	\N
7654	76	53	RESOURCE	wood	1	\N	\N	\N	\N
7655	76	54	EMPTY	\N	\N	\N	\N	\N	\N
7656	76	55	NPC	\N	\N	4	\N	Barbarian Camp (Lv 4)	\N
7657	76	56	EMPTY	\N	\N	\N	\N	\N	\N
7658	76	57	VALLEY	\N	\N	\N	\N	Valley (76, 57)	\N
7659	76	58	EMPTY	\N	\N	\N	\N	\N	\N
7660	76	59	EMPTY	\N	\N	\N	\N	\N	\N
7661	76	60	EMPTY	\N	\N	\N	\N	\N	\N
7662	76	61	VALLEY	\N	\N	\N	\N	Valley (76, 61)	\N
7663	76	62	EMPTY	\N	\N	\N	\N	\N	\N
7664	76	63	EMPTY	\N	\N	\N	\N	\N	\N
7665	76	64	EMPTY	\N	\N	\N	\N	\N	\N
7666	76	65	EMPTY	\N	\N	\N	\N	\N	\N
7667	76	66	EMPTY	\N	\N	\N	\N	\N	\N
7668	76	67	EMPTY	\N	\N	\N	\N	\N	\N
7669	76	68	EMPTY	\N	\N	\N	\N	\N	\N
7670	76	69	EMPTY	\N	\N	\N	\N	\N	\N
7671	76	70	RESOURCE	food	4	\N	\N	\N	\N
7672	76	71	EMPTY	\N	\N	\N	\N	\N	\N
7673	76	72	RESOURCE	food	3	\N	\N	\N	\N
7674	76	73	EMPTY	\N	\N	\N	\N	\N	\N
7675	76	74	EMPTY	\N	\N	\N	\N	\N	\N
7676	76	75	EMPTY	\N	\N	\N	\N	\N	\N
7677	76	76	EMPTY	\N	\N	\N	\N	\N	\N
7678	76	77	EMPTY	\N	\N	\N	\N	\N	\N
7679	76	78	EMPTY	\N	\N	\N	\N	\N	\N
7680	76	79	RESOURCE	wood	5	\N	\N	\N	\N
7681	76	80	EMPTY	\N	\N	\N	\N	\N	\N
7682	76	81	EMPTY	\N	\N	\N	\N	\N	\N
7683	76	82	EMPTY	\N	\N	\N	\N	\N	\N
7684	76	83	EMPTY	\N	\N	\N	\N	\N	\N
7685	76	84	EMPTY	\N	\N	\N	\N	\N	\N
7686	76	85	EMPTY	\N	\N	\N	\N	\N	\N
7687	76	86	EMPTY	\N	\N	\N	\N	\N	\N
7688	76	87	EMPTY	\N	\N	\N	\N	\N	\N
7689	76	88	EMPTY	\N	\N	\N	\N	\N	\N
7690	76	89	EMPTY	\N	\N	\N	\N	\N	\N
7691	76	90	EMPTY	\N	\N	\N	\N	\N	\N
7692	76	91	EMPTY	\N	\N	\N	\N	\N	\N
7693	76	92	EMPTY	\N	\N	\N	\N	\N	\N
7694	76	93	EMPTY	\N	\N	\N	\N	\N	\N
7695	76	94	EMPTY	\N	\N	\N	\N	\N	\N
7696	76	95	EMPTY	\N	\N	\N	\N	\N	\N
7697	76	96	EMPTY	\N	\N	\N	\N	\N	\N
7698	76	97	RESOURCE	stone	4	\N	\N	\N	\N
7699	76	98	EMPTY	\N	\N	\N	\N	\N	\N
7700	76	99	EMPTY	\N	\N	\N	\N	\N	\N
7701	77	0	EMPTY	\N	\N	\N	\N	\N	\N
7702	77	1	EMPTY	\N	\N	\N	\N	\N	\N
7703	77	2	NPC	\N	\N	7	\N	Barbarian Camp (Lv 7)	\N
7704	77	3	EMPTY	\N	\N	\N	\N	\N	\N
7705	77	4	EMPTY	\N	\N	\N	\N	\N	\N
7706	77	5	EMPTY	\N	\N	\N	\N	\N	\N
7707	77	6	EMPTY	\N	\N	\N	\N	\N	\N
7708	77	7	EMPTY	\N	\N	\N	\N	\N	\N
7709	77	8	EMPTY	\N	\N	\N	\N	\N	\N
7710	77	9	EMPTY	\N	\N	\N	\N	\N	\N
7711	77	10	EMPTY	\N	\N	\N	\N	\N	\N
7712	77	11	EMPTY	\N	\N	\N	\N	\N	\N
7713	77	12	EMPTY	\N	\N	\N	\N	\N	\N
7714	77	13	EMPTY	\N	\N	\N	\N	\N	\N
7715	77	14	EMPTY	\N	\N	\N	\N	\N	\N
7716	77	15	EMPTY	\N	\N	\N	\N	\N	\N
7717	77	16	EMPTY	\N	\N	\N	\N	\N	\N
7718	77	17	EMPTY	\N	\N	\N	\N	\N	\N
7719	77	18	EMPTY	\N	\N	\N	\N	\N	\N
7720	77	19	EMPTY	\N	\N	\N	\N	\N	\N
7721	77	20	RESOURCE	iron	4	\N	\N	\N	\N
7722	77	21	EMPTY	\N	\N	\N	\N	\N	\N
7723	77	22	EMPTY	\N	\N	\N	\N	\N	\N
7724	77	23	EMPTY	\N	\N	\N	\N	\N	\N
7725	77	24	EMPTY	\N	\N	\N	\N	\N	\N
7726	77	25	EMPTY	\N	\N	\N	\N	\N	\N
7727	77	26	EMPTY	\N	\N	\N	\N	\N	\N
7728	77	27	EMPTY	\N	\N	\N	\N	\N	\N
7729	77	28	EMPTY	\N	\N	\N	\N	\N	\N
7730	77	29	EMPTY	\N	\N	\N	\N	\N	\N
7731	77	30	EMPTY	\N	\N	\N	\N	\N	\N
7732	77	31	EMPTY	\N	\N	\N	\N	\N	\N
7733	77	32	EMPTY	\N	\N	\N	\N	\N	\N
7734	77	33	EMPTY	\N	\N	\N	\N	\N	\N
7735	77	34	EMPTY	\N	\N	\N	\N	\N	\N
7736	77	35	EMPTY	\N	\N	\N	\N	\N	\N
7737	77	36	EMPTY	\N	\N	\N	\N	\N	\N
7738	77	37	EMPTY	\N	\N	\N	\N	\N	\N
7739	77	38	EMPTY	\N	\N	\N	\N	\N	\N
7740	77	39	EMPTY	\N	\N	\N	\N	\N	\N
7741	77	40	EMPTY	\N	\N	\N	\N	\N	\N
7742	77	41	EMPTY	\N	\N	\N	\N	\N	\N
7743	77	42	EMPTY	\N	\N	\N	\N	\N	\N
7744	77	43	EMPTY	\N	\N	\N	\N	\N	\N
7745	77	44	EMPTY	\N	\N	\N	\N	\N	\N
7746	77	45	EMPTY	\N	\N	\N	\N	\N	\N
7747	77	46	EMPTY	\N	\N	\N	\N	\N	\N
7748	77	47	EMPTY	\N	\N	\N	\N	\N	\N
7749	77	48	EMPTY	\N	\N	\N	\N	\N	\N
7750	77	49	EMPTY	\N	\N	\N	\N	\N	\N
7751	77	50	EMPTY	\N	\N	\N	\N	\N	\N
7752	77	51	EMPTY	\N	\N	\N	\N	\N	\N
7753	77	52	EMPTY	\N	\N	\N	\N	\N	\N
7754	77	53	EMPTY	\N	\N	\N	\N	\N	\N
7755	77	54	EMPTY	\N	\N	\N	\N	\N	\N
7756	77	55	EMPTY	\N	\N	\N	\N	\N	\N
7757	77	56	EMPTY	\N	\N	\N	\N	\N	\N
7758	77	57	EMPTY	\N	\N	\N	\N	\N	\N
7759	77	58	EMPTY	\N	\N	\N	\N	\N	\N
7760	77	59	EMPTY	\N	\N	\N	\N	\N	\N
7761	77	60	EMPTY	\N	\N	\N	\N	\N	\N
7762	77	61	EMPTY	\N	\N	\N	\N	\N	\N
7763	77	62	EMPTY	\N	\N	\N	\N	\N	\N
7764	77	63	EMPTY	\N	\N	\N	\N	\N	\N
7765	77	64	EMPTY	\N	\N	\N	\N	\N	\N
7766	77	65	EMPTY	\N	\N	\N	\N	\N	\N
7767	77	66	EMPTY	\N	\N	\N	\N	\N	\N
7768	77	67	EMPTY	\N	\N	\N	\N	\N	\N
7769	77	68	EMPTY	\N	\N	\N	\N	\N	\N
7770	77	69	EMPTY	\N	\N	\N	\N	\N	\N
7771	77	70	EMPTY	\N	\N	\N	\N	\N	\N
7772	77	71	EMPTY	\N	\N	\N	\N	\N	\N
7773	77	72	EMPTY	\N	\N	\N	\N	\N	\N
7774	77	73	EMPTY	\N	\N	\N	\N	\N	\N
7775	77	74	EMPTY	\N	\N	\N	\N	\N	\N
7776	77	75	EMPTY	\N	\N	\N	\N	\N	\N
7777	77	76	EMPTY	\N	\N	\N	\N	\N	\N
7778	77	77	EMPTY	\N	\N	\N	\N	\N	\N
7779	77	78	EMPTY	\N	\N	\N	\N	\N	\N
7780	77	79	NPC	\N	\N	3	\N	Barbarian Camp (Lv 3)	\N
7781	77	80	EMPTY	\N	\N	\N	\N	\N	\N
7782	77	81	EMPTY	\N	\N	\N	\N	\N	\N
7783	77	82	EMPTY	\N	\N	\N	\N	\N	\N
7784	77	83	EMPTY	\N	\N	\N	\N	\N	\N
7785	77	84	EMPTY	\N	\N	\N	\N	\N	\N
7786	77	85	EMPTY	\N	\N	\N	\N	\N	\N
7787	77	86	EMPTY	\N	\N	\N	\N	\N	\N
7788	77	87	EMPTY	\N	\N	\N	\N	\N	\N
7789	77	88	EMPTY	\N	\N	\N	\N	\N	\N
7790	77	89	RESOURCE	stone	1	\N	\N	\N	\N
7791	77	90	EMPTY	\N	\N	\N	\N	\N	\N
7792	77	91	EMPTY	\N	\N	\N	\N	\N	\N
7793	77	92	EMPTY	\N	\N	\N	\N	\N	\N
7794	77	93	EMPTY	\N	\N	\N	\N	\N	\N
7795	77	94	EMPTY	\N	\N	\N	\N	\N	\N
7796	77	95	EMPTY	\N	\N	\N	\N	\N	\N
7797	77	96	EMPTY	\N	\N	\N	\N	\N	\N
7798	77	97	EMPTY	\N	\N	\N	\N	\N	\N
7799	77	98	EMPTY	\N	\N	\N	\N	\N	\N
7800	77	99	EMPTY	\N	\N	\N	\N	\N	\N
7801	78	0	EMPTY	\N	\N	\N	\N	\N	\N
7802	78	1	EMPTY	\N	\N	\N	\N	\N	\N
7803	78	2	RESOURCE	food	4	\N	\N	\N	\N
7804	78	3	EMPTY	\N	\N	\N	\N	\N	\N
7805	78	4	EMPTY	\N	\N	\N	\N	\N	\N
7806	78	5	NPC	\N	\N	10	\N	Barbarian Camp (Lv 10)	\N
7807	78	6	EMPTY	\N	\N	\N	\N	\N	\N
7808	78	7	EMPTY	\N	\N	\N	\N	\N	\N
7809	78	8	EMPTY	\N	\N	\N	\N	\N	\N
7810	78	9	EMPTY	\N	\N	\N	\N	\N	\N
7811	78	10	EMPTY	\N	\N	\N	\N	\N	\N
7812	78	11	EMPTY	\N	\N	\N	\N	\N	\N
7813	78	12	EMPTY	\N	\N	\N	\N	\N	\N
7814	78	13	EMPTY	\N	\N	\N	\N	\N	\N
7815	78	14	EMPTY	\N	\N	\N	\N	\N	\N
7816	78	15	EMPTY	\N	\N	\N	\N	\N	\N
7817	78	16	EMPTY	\N	\N	\N	\N	\N	\N
7818	78	17	EMPTY	\N	\N	\N	\N	\N	\N
7819	78	18	NPC	\N	\N	8	\N	Barbarian Camp (Lv 8)	\N
7820	78	19	EMPTY	\N	\N	\N	\N	\N	\N
7821	78	20	EMPTY	\N	\N	\N	\N	\N	\N
7822	78	21	RESOURCE	food	4	\N	\N	\N	\N
7823	78	22	EMPTY	\N	\N	\N	\N	\N	\N
7824	78	23	EMPTY	\N	\N	\N	\N	\N	\N
7825	78	24	EMPTY	\N	\N	\N	\N	\N	\N
7826	78	25	VALLEY	\N	\N	\N	\N	Valley (78, 25)	\N
7827	78	26	EMPTY	\N	\N	\N	\N	\N	\N
7828	78	27	EMPTY	\N	\N	\N	\N	\N	\N
7829	78	28	EMPTY	\N	\N	\N	\N	\N	\N
7830	78	29	EMPTY	\N	\N	\N	\N	\N	\N
7831	78	30	EMPTY	\N	\N	\N	\N	\N	\N
7832	78	31	EMPTY	\N	\N	\N	\N	\N	\N
7833	78	32	EMPTY	\N	\N	\N	\N	\N	\N
7834	78	33	VALLEY	\N	\N	\N	\N	Valley (78, 33)	\N
7835	78	34	EMPTY	\N	\N	\N	\N	\N	\N
7836	78	35	EMPTY	\N	\N	\N	\N	\N	\N
7837	78	36	EMPTY	\N	\N	\N	\N	\N	\N
7838	78	37	RESOURCE	stone	2	\N	\N	\N	\N
7839	78	38	NPC	\N	\N	3	\N	Barbarian Camp (Lv 3)	\N
7840	78	39	RESOURCE	food	5	\N	\N	\N	\N
7841	78	40	EMPTY	\N	\N	\N	\N	\N	\N
7842	78	41	EMPTY	\N	\N	\N	\N	\N	\N
7843	78	42	RESOURCE	wood	4	\N	\N	\N	\N
7844	78	43	VALLEY	\N	\N	\N	\N	Valley (78, 43)	\N
7845	78	44	RESOURCE	stone	2	\N	\N	\N	\N
7846	78	45	EMPTY	\N	\N	\N	\N	\N	\N
7847	78	46	EMPTY	\N	\N	\N	\N	\N	\N
7848	78	47	EMPTY	\N	\N	\N	\N	\N	\N
7849	78	48	RESOURCE	wood	2	\N	\N	\N	\N
7850	78	49	EMPTY	\N	\N	\N	\N	\N	\N
7851	78	50	EMPTY	\N	\N	\N	\N	\N	\N
7852	78	51	EMPTY	\N	\N	\N	\N	\N	\N
7853	78	52	EMPTY	\N	\N	\N	\N	\N	\N
7854	78	53	EMPTY	\N	\N	\N	\N	\N	\N
7855	78	54	EMPTY	\N	\N	\N	\N	\N	\N
7856	78	55	EMPTY	\N	\N	\N	\N	\N	\N
7857	78	56	EMPTY	\N	\N	\N	\N	\N	\N
7858	78	57	EMPTY	\N	\N	\N	\N	\N	\N
7859	78	58	EMPTY	\N	\N	\N	\N	\N	\N
7860	78	59	EMPTY	\N	\N	\N	\N	\N	\N
7861	78	60	EMPTY	\N	\N	\N	\N	\N	\N
7862	78	61	RESOURCE	food	4	\N	\N	\N	\N
7863	78	62	EMPTY	\N	\N	\N	\N	\N	\N
7864	78	63	EMPTY	\N	\N	\N	\N	\N	\N
7865	78	64	VALLEY	\N	\N	\N	\N	Valley (78, 64)	\N
7866	78	65	EMPTY	\N	\N	\N	\N	\N	\N
7867	78	66	EMPTY	\N	\N	\N	\N	\N	\N
7868	78	67	EMPTY	\N	\N	\N	\N	\N	\N
7869	78	68	EMPTY	\N	\N	\N	\N	\N	\N
7870	78	69	EMPTY	\N	\N	\N	\N	\N	\N
7871	78	70	EMPTY	\N	\N	\N	\N	\N	\N
7872	78	71	EMPTY	\N	\N	\N	\N	\N	\N
7873	78	72	EMPTY	\N	\N	\N	\N	\N	\N
7874	78	73	EMPTY	\N	\N	\N	\N	\N	\N
7875	78	74	EMPTY	\N	\N	\N	\N	\N	\N
7876	78	75	EMPTY	\N	\N	\N	\N	\N	\N
7877	78	76	EMPTY	\N	\N	\N	\N	\N	\N
7878	78	77	EMPTY	\N	\N	\N	\N	\N	\N
7879	78	78	EMPTY	\N	\N	\N	\N	\N	\N
7880	78	79	NPC	\N	\N	5	\N	Barbarian Camp (Lv 5)	\N
7881	78	80	EMPTY	\N	\N	\N	\N	\N	\N
7882	78	81	EMPTY	\N	\N	\N	\N	\N	\N
7883	78	82	EMPTY	\N	\N	\N	\N	\N	\N
7884	78	83	RESOURCE	wood	2	\N	\N	\N	\N
7885	78	84	EMPTY	\N	\N	\N	\N	\N	\N
7886	78	85	NPC	\N	\N	9	\N	Barbarian Camp (Lv 9)	\N
7887	78	86	EMPTY	\N	\N	\N	\N	\N	\N
7888	78	87	EMPTY	\N	\N	\N	\N	\N	\N
7889	78	88	EMPTY	\N	\N	\N	\N	\N	\N
7890	78	89	EMPTY	\N	\N	\N	\N	\N	\N
7891	78	90	EMPTY	\N	\N	\N	\N	\N	\N
7892	78	91	RESOURCE	food	2	\N	\N	\N	\N
7893	78	92	EMPTY	\N	\N	\N	\N	\N	\N
7894	78	93	EMPTY	\N	\N	\N	\N	\N	\N
7895	78	94	EMPTY	\N	\N	\N	\N	\N	\N
7896	78	95	EMPTY	\N	\N	\N	\N	\N	\N
7897	78	96	EMPTY	\N	\N	\N	\N	\N	\N
7898	78	97	EMPTY	\N	\N	\N	\N	\N	\N
7899	78	98	NPC	\N	\N	5	\N	Barbarian Camp (Lv 5)	\N
7900	78	99	EMPTY	\N	\N	\N	\N	\N	\N
7901	79	0	EMPTY	\N	\N	\N	\N	\N	\N
7902	79	1	EMPTY	\N	\N	\N	\N	\N	\N
7903	79	2	EMPTY	\N	\N	\N	\N	\N	\N
7904	79	3	EMPTY	\N	\N	\N	\N	\N	\N
7905	79	4	RESOURCE	wood	3	\N	\N	\N	\N
7906	79	5	EMPTY	\N	\N	\N	\N	\N	\N
7907	79	6	EMPTY	\N	\N	\N	\N	\N	\N
7908	79	7	EMPTY	\N	\N	\N	\N	\N	\N
7909	79	8	EMPTY	\N	\N	\N	\N	\N	\N
7910	79	9	EMPTY	\N	\N	\N	\N	\N	\N
7911	79	10	EMPTY	\N	\N	\N	\N	\N	\N
7912	79	11	EMPTY	\N	\N	\N	\N	\N	\N
7913	79	12	EMPTY	\N	\N	\N	\N	\N	\N
7914	79	13	EMPTY	\N	\N	\N	\N	\N	\N
7915	79	14	RESOURCE	food	4	\N	\N	\N	\N
7916	79	15	RESOURCE	iron	1	\N	\N	\N	\N
7917	79	16	EMPTY	\N	\N	\N	\N	\N	\N
7918	79	17	EMPTY	\N	\N	\N	\N	\N	\N
7919	79	18	EMPTY	\N	\N	\N	\N	\N	\N
7920	79	19	EMPTY	\N	\N	\N	\N	\N	\N
7921	79	20	EMPTY	\N	\N	\N	\N	\N	\N
7922	79	21	EMPTY	\N	\N	\N	\N	\N	\N
7923	79	22	RESOURCE	stone	2	\N	\N	\N	\N
7924	79	23	EMPTY	\N	\N	\N	\N	\N	\N
7925	79	24	RESOURCE	food	1	\N	\N	\N	\N
7926	79	25	EMPTY	\N	\N	\N	\N	\N	\N
7927	79	26	EMPTY	\N	\N	\N	\N	\N	\N
7928	79	27	EMPTY	\N	\N	\N	\N	\N	\N
7929	79	28	EMPTY	\N	\N	\N	\N	\N	\N
7930	79	29	NPC	\N	\N	8	\N	Barbarian Camp (Lv 8)	\N
7931	79	30	RESOURCE	food	1	\N	\N	\N	\N
7932	79	31	EMPTY	\N	\N	\N	\N	\N	\N
7933	79	32	EMPTY	\N	\N	\N	\N	\N	\N
7934	79	33	EMPTY	\N	\N	\N	\N	\N	\N
7935	79	34	EMPTY	\N	\N	\N	\N	\N	\N
7936	79	35	EMPTY	\N	\N	\N	\N	\N	\N
7937	79	36	EMPTY	\N	\N	\N	\N	\N	\N
7938	79	37	EMPTY	\N	\N	\N	\N	\N	\N
7939	79	38	EMPTY	\N	\N	\N	\N	\N	\N
7940	79	39	EMPTY	\N	\N	\N	\N	\N	\N
7941	79	40	EMPTY	\N	\N	\N	\N	\N	\N
7942	79	41	RESOURCE	stone	1	\N	\N	\N	\N
7943	79	42	VALLEY	\N	\N	\N	\N	Valley (79, 42)	\N
7944	79	43	EMPTY	\N	\N	\N	\N	\N	\N
7945	79	44	EMPTY	\N	\N	\N	\N	\N	\N
7946	79	45	EMPTY	\N	\N	\N	\N	\N	\N
7947	79	46	EMPTY	\N	\N	\N	\N	\N	\N
7948	79	47	EMPTY	\N	\N	\N	\N	\N	\N
7949	79	48	EMPTY	\N	\N	\N	\N	\N	\N
7950	79	49	EMPTY	\N	\N	\N	\N	\N	\N
7951	79	50	EMPTY	\N	\N	\N	\N	\N	\N
7952	79	51	NPC	\N	\N	6	\N	Barbarian Camp (Lv 6)	\N
7953	79	52	NPC	\N	\N	4	\N	Barbarian Camp (Lv 4)	\N
7954	79	53	EMPTY	\N	\N	\N	\N	\N	\N
7955	79	54	EMPTY	\N	\N	\N	\N	\N	\N
7956	79	55	EMPTY	\N	\N	\N	\N	\N	\N
7957	79	56	EMPTY	\N	\N	\N	\N	\N	\N
7958	79	57	EMPTY	\N	\N	\N	\N	\N	\N
7959	79	58	EMPTY	\N	\N	\N	\N	\N	\N
7960	79	59	EMPTY	\N	\N	\N	\N	\N	\N
7961	79	60	EMPTY	\N	\N	\N	\N	\N	\N
7962	79	61	EMPTY	\N	\N	\N	\N	\N	\N
7963	79	62	EMPTY	\N	\N	\N	\N	\N	\N
7964	79	63	EMPTY	\N	\N	\N	\N	\N	\N
7965	79	64	EMPTY	\N	\N	\N	\N	\N	\N
7966	79	65	EMPTY	\N	\N	\N	\N	\N	\N
7967	79	66	EMPTY	\N	\N	\N	\N	\N	\N
7968	79	67	EMPTY	\N	\N	\N	\N	\N	\N
7969	79	68	EMPTY	\N	\N	\N	\N	\N	\N
7970	79	69	EMPTY	\N	\N	\N	\N	\N	\N
7971	79	70	EMPTY	\N	\N	\N	\N	\N	\N
7972	79	71	EMPTY	\N	\N	\N	\N	\N	\N
7973	79	72	EMPTY	\N	\N	\N	\N	\N	\N
7974	79	73	EMPTY	\N	\N	\N	\N	\N	\N
7975	79	74	EMPTY	\N	\N	\N	\N	\N	\N
7976	79	75	EMPTY	\N	\N	\N	\N	\N	\N
7977	79	76	EMPTY	\N	\N	\N	\N	\N	\N
7978	79	77	EMPTY	\N	\N	\N	\N	\N	\N
7979	79	78	EMPTY	\N	\N	\N	\N	\N	\N
7980	79	79	EMPTY	\N	\N	\N	\N	\N	\N
7981	79	80	EMPTY	\N	\N	\N	\N	\N	\N
7982	79	81	EMPTY	\N	\N	\N	\N	\N	\N
7983	79	82	EMPTY	\N	\N	\N	\N	\N	\N
7984	79	83	RESOURCE	iron	5	\N	\N	\N	\N
7985	79	84	EMPTY	\N	\N	\N	\N	\N	\N
7986	79	85	VALLEY	\N	\N	\N	\N	Valley (79, 85)	\N
7987	79	86	RESOURCE	iron	4	\N	\N	\N	\N
7988	79	87	NPC	\N	\N	9	\N	Barbarian Camp (Lv 9)	\N
7989	79	88	RESOURCE	iron	4	\N	\N	\N	\N
7990	79	89	EMPTY	\N	\N	\N	\N	\N	\N
7991	79	90	EMPTY	\N	\N	\N	\N	\N	\N
7992	79	91	EMPTY	\N	\N	\N	\N	\N	\N
7993	79	92	EMPTY	\N	\N	\N	\N	\N	\N
7994	79	93	EMPTY	\N	\N	\N	\N	\N	\N
7995	79	94	VALLEY	\N	\N	\N	\N	Valley (79, 94)	\N
7996	79	95	EMPTY	\N	\N	\N	\N	\N	\N
7997	79	96	EMPTY	\N	\N	\N	\N	\N	\N
7998	79	97	EMPTY	\N	\N	\N	\N	\N	\N
7999	79	98	EMPTY	\N	\N	\N	\N	\N	\N
8000	79	99	EMPTY	\N	\N	\N	\N	\N	\N
8001	80	0	EMPTY	\N	\N	\N	\N	\N	\N
8002	80	1	EMPTY	\N	\N	\N	\N	\N	\N
8003	80	2	EMPTY	\N	\N	\N	\N	\N	\N
8004	80	3	EMPTY	\N	\N	\N	\N	\N	\N
8005	80	4	VALLEY	\N	\N	\N	\N	Valley (80, 4)	\N
8006	80	5	VALLEY	\N	\N	\N	\N	Valley (80, 5)	\N
8007	80	6	NPC	\N	\N	8	\N	Barbarian Camp (Lv 8)	\N
8008	80	7	EMPTY	\N	\N	\N	\N	\N	\N
8009	80	8	EMPTY	\N	\N	\N	\N	\N	\N
8010	80	9	EMPTY	\N	\N	\N	\N	\N	\N
8011	80	10	RESOURCE	iron	1	\N	\N	\N	\N
8012	80	11	EMPTY	\N	\N	\N	\N	\N	\N
8013	80	12	RESOURCE	stone	1	\N	\N	\N	\N
8014	80	13	EMPTY	\N	\N	\N	\N	\N	\N
8015	80	14	EMPTY	\N	\N	\N	\N	\N	\N
8016	80	15	EMPTY	\N	\N	\N	\N	\N	\N
8017	80	16	EMPTY	\N	\N	\N	\N	\N	\N
8018	80	17	EMPTY	\N	\N	\N	\N	\N	\N
8019	80	18	EMPTY	\N	\N	\N	\N	\N	\N
8020	80	19	EMPTY	\N	\N	\N	\N	\N	\N
8021	80	20	EMPTY	\N	\N	\N	\N	\N	\N
8022	80	21	EMPTY	\N	\N	\N	\N	\N	\N
8023	80	22	EMPTY	\N	\N	\N	\N	\N	\N
8024	80	23	EMPTY	\N	\N	\N	\N	\N	\N
8025	80	24	EMPTY	\N	\N	\N	\N	\N	\N
8026	80	25	EMPTY	\N	\N	\N	\N	\N	\N
8027	80	26	EMPTY	\N	\N	\N	\N	\N	\N
8028	80	27	NPC	\N	\N	4	\N	Barbarian Camp (Lv 4)	\N
8029	80	28	EMPTY	\N	\N	\N	\N	\N	\N
8030	80	29	EMPTY	\N	\N	\N	\N	\N	\N
8031	80	30	EMPTY	\N	\N	\N	\N	\N	\N
8032	80	31	EMPTY	\N	\N	\N	\N	\N	\N
8033	80	32	EMPTY	\N	\N	\N	\N	\N	\N
8034	80	33	EMPTY	\N	\N	\N	\N	\N	\N
8035	80	34	EMPTY	\N	\N	\N	\N	\N	\N
8036	80	35	EMPTY	\N	\N	\N	\N	\N	\N
8037	80	36	EMPTY	\N	\N	\N	\N	\N	\N
8038	80	37	EMPTY	\N	\N	\N	\N	\N	\N
8039	80	38	NPC	\N	\N	7	\N	Barbarian Camp (Lv 7)	\N
8040	80	39	EMPTY	\N	\N	\N	\N	\N	\N
8041	80	40	EMPTY	\N	\N	\N	\N	\N	\N
8042	80	41	EMPTY	\N	\N	\N	\N	\N	\N
8043	80	42	EMPTY	\N	\N	\N	\N	\N	\N
8044	80	43	EMPTY	\N	\N	\N	\N	\N	\N
8045	80	44	EMPTY	\N	\N	\N	\N	\N	\N
8046	80	45	EMPTY	\N	\N	\N	\N	\N	\N
8047	80	46	EMPTY	\N	\N	\N	\N	\N	\N
8048	80	47	EMPTY	\N	\N	\N	\N	\N	\N
8049	80	48	EMPTY	\N	\N	\N	\N	\N	\N
8050	80	49	EMPTY	\N	\N	\N	\N	\N	\N
8051	80	50	EMPTY	\N	\N	\N	\N	\N	\N
8052	80	51	EMPTY	\N	\N	\N	\N	\N	\N
8053	80	52	EMPTY	\N	\N	\N	\N	\N	\N
8054	80	53	EMPTY	\N	\N	\N	\N	\N	\N
8055	80	54	EMPTY	\N	\N	\N	\N	\N	\N
8056	80	55	EMPTY	\N	\N	\N	\N	\N	\N
8057	80	56	RESOURCE	iron	4	\N	\N	\N	\N
8058	80	57	EMPTY	\N	\N	\N	\N	\N	\N
8059	80	58	EMPTY	\N	\N	\N	\N	\N	\N
8060	80	59	EMPTY	\N	\N	\N	\N	\N	\N
8061	80	60	VALLEY	\N	\N	\N	\N	Valley (80, 60)	\N
8062	80	61	EMPTY	\N	\N	\N	\N	\N	\N
8063	80	62	EMPTY	\N	\N	\N	\N	\N	\N
8064	80	63	EMPTY	\N	\N	\N	\N	\N	\N
8065	80	64	NPC	\N	\N	9	\N	Barbarian Camp (Lv 9)	\N
8066	80	65	VALLEY	\N	\N	\N	\N	Valley (80, 65)	\N
8067	80	66	EMPTY	\N	\N	\N	\N	\N	\N
8068	80	67	EMPTY	\N	\N	\N	\N	\N	\N
8069	80	68	RESOURCE	iron	5	\N	\N	\N	\N
8070	80	69	EMPTY	\N	\N	\N	\N	\N	\N
8071	80	70	EMPTY	\N	\N	\N	\N	\N	\N
8072	80	71	EMPTY	\N	\N	\N	\N	\N	\N
8073	80	72	RESOURCE	wood	4	\N	\N	\N	\N
8074	80	73	EMPTY	\N	\N	\N	\N	\N	\N
8075	80	74	EMPTY	\N	\N	\N	\N	\N	\N
8076	80	75	EMPTY	\N	\N	\N	\N	\N	\N
8077	80	76	EMPTY	\N	\N	\N	\N	\N	\N
8078	80	77	EMPTY	\N	\N	\N	\N	\N	\N
8079	80	78	EMPTY	\N	\N	\N	\N	\N	\N
8080	80	79	VALLEY	\N	\N	\N	\N	Valley (80, 79)	\N
8081	80	80	EMPTY	\N	\N	\N	\N	\N	\N
8082	80	81	EMPTY	\N	\N	\N	\N	\N	\N
8083	80	82	NPC	\N	\N	3	\N	Barbarian Camp (Lv 3)	\N
8084	80	83	EMPTY	\N	\N	\N	\N	\N	\N
8085	80	84	NPC	\N	\N	3	\N	Barbarian Camp (Lv 3)	\N
8086	80	85	EMPTY	\N	\N	\N	\N	\N	\N
8087	80	86	EMPTY	\N	\N	\N	\N	\N	\N
8088	80	87	EMPTY	\N	\N	\N	\N	\N	\N
8089	80	88	EMPTY	\N	\N	\N	\N	\N	\N
8090	80	89	EMPTY	\N	\N	\N	\N	\N	\N
8091	80	90	NPC	\N	\N	6	\N	Barbarian Camp (Lv 6)	\N
8092	80	91	VALLEY	\N	\N	\N	\N	Valley (80, 91)	\N
8093	80	92	EMPTY	\N	\N	\N	\N	\N	\N
8094	80	93	EMPTY	\N	\N	\N	\N	\N	\N
8095	80	94	EMPTY	\N	\N	\N	\N	\N	\N
8096	80	95	EMPTY	\N	\N	\N	\N	\N	\N
8097	80	96	EMPTY	\N	\N	\N	\N	\N	\N
8098	80	97	RESOURCE	iron	2	\N	\N	\N	\N
8099	80	98	EMPTY	\N	\N	\N	\N	\N	\N
8100	80	99	EMPTY	\N	\N	\N	\N	\N	\N
8101	81	0	EMPTY	\N	\N	\N	\N	\N	\N
8102	81	1	EMPTY	\N	\N	\N	\N	\N	\N
8103	81	2	RESOURCE	wood	4	\N	\N	\N	\N
8104	81	3	EMPTY	\N	\N	\N	\N	\N	\N
8105	81	4	EMPTY	\N	\N	\N	\N	\N	\N
8106	81	5	EMPTY	\N	\N	\N	\N	\N	\N
8107	81	6	EMPTY	\N	\N	\N	\N	\N	\N
8108	81	7	EMPTY	\N	\N	\N	\N	\N	\N
8109	81	8	EMPTY	\N	\N	\N	\N	\N	\N
8110	81	9	EMPTY	\N	\N	\N	\N	\N	\N
8111	81	10	NPC	\N	\N	3	\N	Barbarian Camp (Lv 3)	\N
8112	81	11	EMPTY	\N	\N	\N	\N	\N	\N
8113	81	12	EMPTY	\N	\N	\N	\N	\N	\N
8114	81	13	EMPTY	\N	\N	\N	\N	\N	\N
8115	81	14	RESOURCE	wood	3	\N	\N	\N	\N
8116	81	15	EMPTY	\N	\N	\N	\N	\N	\N
8117	81	16	EMPTY	\N	\N	\N	\N	\N	\N
8118	81	17	EMPTY	\N	\N	\N	\N	\N	\N
8119	81	18	RESOURCE	stone	1	\N	\N	\N	\N
8120	81	19	EMPTY	\N	\N	\N	\N	\N	\N
8121	81	20	EMPTY	\N	\N	\N	\N	\N	\N
8122	81	21	EMPTY	\N	\N	\N	\N	\N	\N
8123	81	22	EMPTY	\N	\N	\N	\N	\N	\N
8124	81	23	EMPTY	\N	\N	\N	\N	\N	\N
8125	81	24	EMPTY	\N	\N	\N	\N	\N	\N
8126	81	25	EMPTY	\N	\N	\N	\N	\N	\N
8127	81	26	EMPTY	\N	\N	\N	\N	\N	\N
8128	81	27	EMPTY	\N	\N	\N	\N	\N	\N
8129	81	28	EMPTY	\N	\N	\N	\N	\N	\N
8130	81	29	EMPTY	\N	\N	\N	\N	\N	\N
8131	81	30	RESOURCE	wood	3	\N	\N	\N	\N
8132	81	31	EMPTY	\N	\N	\N	\N	\N	\N
8133	81	32	RESOURCE	food	4	\N	\N	\N	\N
8134	81	33	EMPTY	\N	\N	\N	\N	\N	\N
8135	81	34	EMPTY	\N	\N	\N	\N	\N	\N
8136	81	35	EMPTY	\N	\N	\N	\N	\N	\N
8137	81	36	EMPTY	\N	\N	\N	\N	\N	\N
8138	81	37	EMPTY	\N	\N	\N	\N	\N	\N
8139	81	38	EMPTY	\N	\N	\N	\N	\N	\N
8140	81	39	EMPTY	\N	\N	\N	\N	\N	\N
8141	81	40	EMPTY	\N	\N	\N	\N	\N	\N
8142	81	41	EMPTY	\N	\N	\N	\N	\N	\N
8143	81	42	EMPTY	\N	\N	\N	\N	\N	\N
8144	81	43	EMPTY	\N	\N	\N	\N	\N	\N
8145	81	44	EMPTY	\N	\N	\N	\N	\N	\N
8146	81	45	EMPTY	\N	\N	\N	\N	\N	\N
8147	81	46	EMPTY	\N	\N	\N	\N	\N	\N
8148	81	47	VALLEY	\N	\N	\N	\N	Valley (81, 47)	\N
8149	81	48	EMPTY	\N	\N	\N	\N	\N	\N
8150	81	49	EMPTY	\N	\N	\N	\N	\N	\N
8151	81	50	EMPTY	\N	\N	\N	\N	\N	\N
8152	81	51	EMPTY	\N	\N	\N	\N	\N	\N
8153	81	52	RESOURCE	food	2	\N	\N	\N	\N
8154	81	53	NPC	\N	\N	8	\N	Barbarian Camp (Lv 8)	\N
8155	81	54	EMPTY	\N	\N	\N	\N	\N	\N
8156	81	55	VALLEY	\N	\N	\N	\N	Valley (81, 55)	\N
8157	81	56	EMPTY	\N	\N	\N	\N	\N	\N
8158	81	57	EMPTY	\N	\N	\N	\N	\N	\N
8159	81	58	EMPTY	\N	\N	\N	\N	\N	\N
8160	81	59	EMPTY	\N	\N	\N	\N	\N	\N
8161	81	60	NPC	\N	\N	5	\N	Barbarian Camp (Lv 5)	\N
8162	81	61	RESOURCE	iron	3	\N	\N	\N	\N
8163	81	62	EMPTY	\N	\N	\N	\N	\N	\N
8164	81	63	EMPTY	\N	\N	\N	\N	\N	\N
8165	81	64	EMPTY	\N	\N	\N	\N	\N	\N
8166	81	65	EMPTY	\N	\N	\N	\N	\N	\N
8167	81	66	EMPTY	\N	\N	\N	\N	\N	\N
8168	81	67	EMPTY	\N	\N	\N	\N	\N	\N
8169	81	68	EMPTY	\N	\N	\N	\N	\N	\N
8170	81	69	EMPTY	\N	\N	\N	\N	\N	\N
8171	81	70	RESOURCE	iron	5	\N	\N	\N	\N
8172	81	71	EMPTY	\N	\N	\N	\N	\N	\N
8173	81	72	EMPTY	\N	\N	\N	\N	\N	\N
8174	81	73	EMPTY	\N	\N	\N	\N	\N	\N
8175	81	74	EMPTY	\N	\N	\N	\N	\N	\N
8176	81	75	EMPTY	\N	\N	\N	\N	\N	\N
8177	81	76	EMPTY	\N	\N	\N	\N	\N	\N
8178	81	77	EMPTY	\N	\N	\N	\N	\N	\N
8179	81	78	EMPTY	\N	\N	\N	\N	\N	\N
8180	81	79	RESOURCE	iron	4	\N	\N	\N	\N
8181	81	80	EMPTY	\N	\N	\N	\N	\N	\N
8182	81	81	EMPTY	\N	\N	\N	\N	\N	\N
8183	81	82	NPC	\N	\N	5	\N	Barbarian Camp (Lv 5)	\N
8184	81	83	EMPTY	\N	\N	\N	\N	\N	\N
8185	81	84	EMPTY	\N	\N	\N	\N	\N	\N
8186	81	85	RESOURCE	iron	4	\N	\N	\N	\N
8187	81	86	NPC	\N	\N	1	\N	Barbarian Camp (Lv 1)	\N
8188	81	87	NPC	\N	\N	5	\N	Barbarian Camp (Lv 5)	\N
8189	81	88	RESOURCE	wood	3	\N	\N	\N	\N
8190	81	89	EMPTY	\N	\N	\N	\N	\N	\N
8191	81	90	EMPTY	\N	\N	\N	\N	\N	\N
8192	81	91	EMPTY	\N	\N	\N	\N	\N	\N
8193	81	92	EMPTY	\N	\N	\N	\N	\N	\N
8194	81	93	EMPTY	\N	\N	\N	\N	\N	\N
8195	81	94	NPC	\N	\N	1	\N	Barbarian Camp (Lv 1)	\N
8196	81	95	EMPTY	\N	\N	\N	\N	\N	\N
8197	81	96	EMPTY	\N	\N	\N	\N	\N	\N
8198	81	97	EMPTY	\N	\N	\N	\N	\N	\N
8199	81	98	EMPTY	\N	\N	\N	\N	\N	\N
8200	81	99	RESOURCE	wood	4	\N	\N	\N	\N
8201	82	0	EMPTY	\N	\N	\N	\N	\N	\N
8202	82	1	EMPTY	\N	\N	\N	\N	\N	\N
8203	82	2	EMPTY	\N	\N	\N	\N	\N	\N
8204	82	3	EMPTY	\N	\N	\N	\N	\N	\N
8205	82	4	RESOURCE	stone	5	\N	\N	\N	\N
8206	82	5	EMPTY	\N	\N	\N	\N	\N	\N
8207	82	6	NPC	\N	\N	10	\N	Barbarian Camp (Lv 10)	\N
8208	82	7	EMPTY	\N	\N	\N	\N	\N	\N
8209	82	8	EMPTY	\N	\N	\N	\N	\N	\N
8210	82	9	EMPTY	\N	\N	\N	\N	\N	\N
8211	82	10	NPC	\N	\N	3	\N	Barbarian Camp (Lv 3)	\N
8212	82	11	EMPTY	\N	\N	\N	\N	\N	\N
8213	82	12	EMPTY	\N	\N	\N	\N	\N	\N
8214	82	13	EMPTY	\N	\N	\N	\N	\N	\N
8215	82	14	EMPTY	\N	\N	\N	\N	\N	\N
8216	82	15	EMPTY	\N	\N	\N	\N	\N	\N
8217	82	16	EMPTY	\N	\N	\N	\N	\N	\N
8218	82	17	NPC	\N	\N	5	\N	Barbarian Camp (Lv 5)	\N
8219	82	18	EMPTY	\N	\N	\N	\N	\N	\N
8220	82	19	EMPTY	\N	\N	\N	\N	\N	\N
8221	82	20	EMPTY	\N	\N	\N	\N	\N	\N
8222	82	21	EMPTY	\N	\N	\N	\N	\N	\N
8223	82	22	EMPTY	\N	\N	\N	\N	\N	\N
8224	82	23	EMPTY	\N	\N	\N	\N	\N	\N
8225	82	24	EMPTY	\N	\N	\N	\N	\N	\N
8226	82	25	EMPTY	\N	\N	\N	\N	\N	\N
8227	82	26	RESOURCE	stone	3	\N	\N	\N	\N
8228	82	27	NPC	\N	\N	5	\N	Barbarian Camp (Lv 5)	\N
8229	82	28	EMPTY	\N	\N	\N	\N	\N	\N
8230	82	29	EMPTY	\N	\N	\N	\N	\N	\N
8231	82	30	EMPTY	\N	\N	\N	\N	\N	\N
8232	82	31	EMPTY	\N	\N	\N	\N	\N	\N
8233	82	32	EMPTY	\N	\N	\N	\N	\N	\N
8234	82	33	EMPTY	\N	\N	\N	\N	\N	\N
8235	82	34	EMPTY	\N	\N	\N	\N	\N	\N
8236	82	35	EMPTY	\N	\N	\N	\N	\N	\N
8237	82	36	EMPTY	\N	\N	\N	\N	\N	\N
8238	82	37	EMPTY	\N	\N	\N	\N	\N	\N
8239	82	38	EMPTY	\N	\N	\N	\N	\N	\N
8240	82	39	EMPTY	\N	\N	\N	\N	\N	\N
8241	82	40	EMPTY	\N	\N	\N	\N	\N	\N
8242	82	41	EMPTY	\N	\N	\N	\N	\N	\N
8243	82	42	EMPTY	\N	\N	\N	\N	\N	\N
8244	82	43	EMPTY	\N	\N	\N	\N	\N	\N
8245	82	44	EMPTY	\N	\N	\N	\N	\N	\N
8246	82	45	EMPTY	\N	\N	\N	\N	\N	\N
8247	82	46	EMPTY	\N	\N	\N	\N	\N	\N
8248	82	47	EMPTY	\N	\N	\N	\N	\N	\N
8249	82	48	EMPTY	\N	\N	\N	\N	\N	\N
8250	82	49	EMPTY	\N	\N	\N	\N	\N	\N
8251	82	50	EMPTY	\N	\N	\N	\N	\N	\N
8252	82	51	RESOURCE	iron	4	\N	\N	\N	\N
8253	82	52	EMPTY	\N	\N	\N	\N	\N	\N
8254	82	53	EMPTY	\N	\N	\N	\N	\N	\N
8255	82	54	EMPTY	\N	\N	\N	\N	\N	\N
8256	82	55	EMPTY	\N	\N	\N	\N	\N	\N
8257	82	56	EMPTY	\N	\N	\N	\N	\N	\N
8258	82	57	EMPTY	\N	\N	\N	\N	\N	\N
8259	82	58	EMPTY	\N	\N	\N	\N	\N	\N
8260	82	59	EMPTY	\N	\N	\N	\N	\N	\N
8261	82	60	EMPTY	\N	\N	\N	\N	\N	\N
8262	82	61	EMPTY	\N	\N	\N	\N	\N	\N
8263	82	62	EMPTY	\N	\N	\N	\N	\N	\N
8264	82	63	EMPTY	\N	\N	\N	\N	\N	\N
8265	82	64	EMPTY	\N	\N	\N	\N	\N	\N
8266	82	65	EMPTY	\N	\N	\N	\N	\N	\N
8267	82	66	EMPTY	\N	\N	\N	\N	\N	\N
8268	82	67	EMPTY	\N	\N	\N	\N	\N	\N
8269	82	68	EMPTY	\N	\N	\N	\N	\N	\N
8270	82	69	EMPTY	\N	\N	\N	\N	\N	\N
8271	82	70	VALLEY	\N	\N	\N	\N	Valley (82, 70)	\N
8272	82	71	EMPTY	\N	\N	\N	\N	\N	\N
8273	82	72	EMPTY	\N	\N	\N	\N	\N	\N
8274	82	73	EMPTY	\N	\N	\N	\N	\N	\N
8275	82	74	EMPTY	\N	\N	\N	\N	\N	\N
8276	82	75	EMPTY	\N	\N	\N	\N	\N	\N
8277	82	76	EMPTY	\N	\N	\N	\N	\N	\N
8278	82	77	EMPTY	\N	\N	\N	\N	\N	\N
8279	82	78	EMPTY	\N	\N	\N	\N	\N	\N
8281	82	80	EMPTY	\N	\N	\N	\N	\N	\N
8282	82	81	NPC	\N	\N	5	\N	Barbarian Camp (Lv 5)	\N
8283	82	82	EMPTY	\N	\N	\N	\N	\N	\N
8284	82	83	EMPTY	\N	\N	\N	\N	\N	\N
8285	82	84	EMPTY	\N	\N	\N	\N	\N	\N
8286	82	85	EMPTY	\N	\N	\N	\N	\N	\N
8287	82	86	EMPTY	\N	\N	\N	\N	\N	\N
8288	82	87	NPC	\N	\N	5	\N	Barbarian Camp (Lv 5)	\N
8289	82	88	EMPTY	\N	\N	\N	\N	\N	\N
8290	82	89	EMPTY	\N	\N	\N	\N	\N	\N
8291	82	90	RESOURCE	wood	3	\N	\N	\N	\N
8292	82	91	EMPTY	\N	\N	\N	\N	\N	\N
8293	82	92	EMPTY	\N	\N	\N	\N	\N	\N
8294	82	93	EMPTY	\N	\N	\N	\N	\N	\N
8295	82	94	EMPTY	\N	\N	\N	\N	\N	\N
8296	82	95	EMPTY	\N	\N	\N	\N	\N	\N
8297	82	96	EMPTY	\N	\N	\N	\N	\N	\N
8298	82	97	NPC	\N	\N	5	\N	Barbarian Camp (Lv 5)	\N
8299	82	98	EMPTY	\N	\N	\N	\N	\N	\N
8300	82	99	EMPTY	\N	\N	\N	\N	\N	\N
8301	83	0	EMPTY	\N	\N	\N	\N	\N	\N
8302	83	1	EMPTY	\N	\N	\N	\N	\N	\N
8303	83	2	EMPTY	\N	\N	\N	\N	\N	\N
8304	83	3	EMPTY	\N	\N	\N	\N	\N	\N
8305	83	4	EMPTY	\N	\N	\N	\N	\N	\N
8306	83	5	EMPTY	\N	\N	\N	\N	\N	\N
8307	83	6	EMPTY	\N	\N	\N	\N	\N	\N
8308	83	7	EMPTY	\N	\N	\N	\N	\N	\N
8309	83	8	EMPTY	\N	\N	\N	\N	\N	\N
8310	83	9	EMPTY	\N	\N	\N	\N	\N	\N
8311	83	10	EMPTY	\N	\N	\N	\N	\N	\N
8312	83	11	EMPTY	\N	\N	\N	\N	\N	\N
8313	83	12	EMPTY	\N	\N	\N	\N	\N	\N
8314	83	13	EMPTY	\N	\N	\N	\N	\N	\N
8315	83	14	EMPTY	\N	\N	\N	\N	\N	\N
8316	83	15	NPC	\N	\N	8	\N	Barbarian Camp (Lv 8)	\N
8317	83	16	EMPTY	\N	\N	\N	\N	\N	\N
8318	83	17	EMPTY	\N	\N	\N	\N	\N	\N
8319	83	18	NPC	\N	\N	8	\N	Barbarian Camp (Lv 8)	\N
8320	83	19	RESOURCE	food	2	\N	\N	\N	\N
8321	83	20	EMPTY	\N	\N	\N	\N	\N	\N
8322	83	21	RESOURCE	food	4	\N	\N	\N	\N
8323	83	22	EMPTY	\N	\N	\N	\N	\N	\N
8324	83	23	EMPTY	\N	\N	\N	\N	\N	\N
8325	83	24	EMPTY	\N	\N	\N	\N	\N	\N
8326	83	25	EMPTY	\N	\N	\N	\N	\N	\N
8327	83	26	EMPTY	\N	\N	\N	\N	\N	\N
8328	83	27	EMPTY	\N	\N	\N	\N	\N	\N
8329	83	28	EMPTY	\N	\N	\N	\N	\N	\N
8330	83	29	EMPTY	\N	\N	\N	\N	\N	\N
8331	83	30	EMPTY	\N	\N	\N	\N	\N	\N
8332	83	31	EMPTY	\N	\N	\N	\N	\N	\N
8333	83	32	EMPTY	\N	\N	\N	\N	\N	\N
8334	83	33	EMPTY	\N	\N	\N	\N	\N	\N
8335	83	34	EMPTY	\N	\N	\N	\N	\N	\N
8336	83	35	EMPTY	\N	\N	\N	\N	\N	\N
8337	83	36	EMPTY	\N	\N	\N	\N	\N	\N
8338	83	37	EMPTY	\N	\N	\N	\N	\N	\N
8339	83	38	EMPTY	\N	\N	\N	\N	\N	\N
8340	83	39	EMPTY	\N	\N	\N	\N	\N	\N
8341	83	40	EMPTY	\N	\N	\N	\N	\N	\N
8342	83	41	EMPTY	\N	\N	\N	\N	\N	\N
8343	83	42	EMPTY	\N	\N	\N	\N	\N	\N
8344	83	43	EMPTY	\N	\N	\N	\N	\N	\N
8345	83	44	VALLEY	\N	\N	\N	\N	Valley (83, 44)	\N
8346	83	45	EMPTY	\N	\N	\N	\N	\N	\N
8347	83	46	EMPTY	\N	\N	\N	\N	\N	\N
8348	83	47	EMPTY	\N	\N	\N	\N	\N	\N
8349	83	48	EMPTY	\N	\N	\N	\N	\N	\N
8350	83	49	EMPTY	\N	\N	\N	\N	\N	\N
8351	83	50	EMPTY	\N	\N	\N	\N	\N	\N
8352	83	51	EMPTY	\N	\N	\N	\N	\N	\N
8353	83	52	NPC	\N	\N	5	\N	Barbarian Camp (Lv 5)	\N
8354	83	53	EMPTY	\N	\N	\N	\N	\N	\N
8355	83	54	EMPTY	\N	\N	\N	\N	\N	\N
8356	83	55	EMPTY	\N	\N	\N	\N	\N	\N
8357	83	56	EMPTY	\N	\N	\N	\N	\N	\N
8358	83	57	EMPTY	\N	\N	\N	\N	\N	\N
8359	83	58	EMPTY	\N	\N	\N	\N	\N	\N
8360	83	59	RESOURCE	iron	2	\N	\N	\N	\N
8361	83	60	EMPTY	\N	\N	\N	\N	\N	\N
8362	83	61	EMPTY	\N	\N	\N	\N	\N	\N
8363	83	62	EMPTY	\N	\N	\N	\N	\N	\N
8364	83	63	EMPTY	\N	\N	\N	\N	\N	\N
8365	83	64	EMPTY	\N	\N	\N	\N	\N	\N
8366	83	65	EMPTY	\N	\N	\N	\N	\N	\N
8367	83	66	EMPTY	\N	\N	\N	\N	\N	\N
8368	83	67	EMPTY	\N	\N	\N	\N	\N	\N
8369	83	68	EMPTY	\N	\N	\N	\N	\N	\N
8370	83	69	EMPTY	\N	\N	\N	\N	\N	\N
8371	83	70	EMPTY	\N	\N	\N	\N	\N	\N
8372	83	71	EMPTY	\N	\N	\N	\N	\N	\N
8373	83	72	EMPTY	\N	\N	\N	\N	\N	\N
8374	83	73	EMPTY	\N	\N	\N	\N	\N	\N
8375	83	74	EMPTY	\N	\N	\N	\N	\N	\N
8376	83	75	EMPTY	\N	\N	\N	\N	\N	\N
8377	83	76	EMPTY	\N	\N	\N	\N	\N	\N
8378	83	77	EMPTY	\N	\N	\N	\N	\N	\N
8379	83	78	EMPTY	\N	\N	\N	\N	\N	\N
8380	83	79	RESOURCE	iron	2	\N	\N	\N	\N
8381	83	80	EMPTY	\N	\N	\N	\N	\N	\N
8382	83	81	EMPTY	\N	\N	\N	\N	\N	\N
8383	83	82	RESOURCE	iron	5	\N	\N	\N	\N
8384	83	83	EMPTY	\N	\N	\N	\N	\N	\N
8385	83	84	EMPTY	\N	\N	\N	\N	\N	\N
8386	83	85	EMPTY	\N	\N	\N	\N	\N	\N
8387	83	86	EMPTY	\N	\N	\N	\N	\N	\N
8388	83	87	EMPTY	\N	\N	\N	\N	\N	\N
8389	83	88	EMPTY	\N	\N	\N	\N	\N	\N
8390	83	89	EMPTY	\N	\N	\N	\N	\N	\N
8391	83	90	EMPTY	\N	\N	\N	\N	\N	\N
8392	83	91	EMPTY	\N	\N	\N	\N	\N	\N
8393	83	92	EMPTY	\N	\N	\N	\N	\N	\N
8394	83	93	EMPTY	\N	\N	\N	\N	\N	\N
8395	83	94	EMPTY	\N	\N	\N	\N	\N	\N
8396	83	95	RESOURCE	food	3	\N	\N	\N	\N
8397	83	96	EMPTY	\N	\N	\N	\N	\N	\N
8398	83	97	EMPTY	\N	\N	\N	\N	\N	\N
8399	83	98	EMPTY	\N	\N	\N	\N	\N	\N
8400	83	99	EMPTY	\N	\N	\N	\N	\N	\N
8401	84	0	EMPTY	\N	\N	\N	\N	\N	\N
8402	84	1	EMPTY	\N	\N	\N	\N	\N	\N
8403	84	2	EMPTY	\N	\N	\N	\N	\N	\N
8404	84	3	EMPTY	\N	\N	\N	\N	\N	\N
8405	84	4	EMPTY	\N	\N	\N	\N	\N	\N
8406	84	5	EMPTY	\N	\N	\N	\N	\N	\N
8407	84	6	EMPTY	\N	\N	\N	\N	\N	\N
8408	84	7	EMPTY	\N	\N	\N	\N	\N	\N
8409	84	8	EMPTY	\N	\N	\N	\N	\N	\N
8410	84	9	EMPTY	\N	\N	\N	\N	\N	\N
8411	84	10	RESOURCE	food	3	\N	\N	\N	\N
8412	84	11	EMPTY	\N	\N	\N	\N	\N	\N
8413	84	12	EMPTY	\N	\N	\N	\N	\N	\N
8414	84	13	EMPTY	\N	\N	\N	\N	\N	\N
8415	84	14	EMPTY	\N	\N	\N	\N	\N	\N
8416	84	15	EMPTY	\N	\N	\N	\N	\N	\N
8417	84	16	EMPTY	\N	\N	\N	\N	\N	\N
8418	84	17	EMPTY	\N	\N	\N	\N	\N	\N
8419	84	18	EMPTY	\N	\N	\N	\N	\N	\N
8420	84	19	RESOURCE	food	3	\N	\N	\N	\N
8421	84	20	RESOURCE	food	1	\N	\N	\N	\N
8422	84	21	EMPTY	\N	\N	\N	\N	\N	\N
8423	84	22	NPC	\N	\N	3	\N	Barbarian Camp (Lv 3)	\N
8424	84	23	EMPTY	\N	\N	\N	\N	\N	\N
8425	84	24	EMPTY	\N	\N	\N	\N	\N	\N
8426	84	25	EMPTY	\N	\N	\N	\N	\N	\N
8427	84	26	EMPTY	\N	\N	\N	\N	\N	\N
8428	84	27	EMPTY	\N	\N	\N	\N	\N	\N
8429	84	28	EMPTY	\N	\N	\N	\N	\N	\N
8430	84	29	EMPTY	\N	\N	\N	\N	\N	\N
8431	84	30	EMPTY	\N	\N	\N	\N	\N	\N
8432	84	31	EMPTY	\N	\N	\N	\N	\N	\N
8433	84	32	EMPTY	\N	\N	\N	\N	\N	\N
8434	84	33	VALLEY	\N	\N	\N	\N	Valley (84, 33)	\N
8435	84	34	EMPTY	\N	\N	\N	\N	\N	\N
8436	84	35	RESOURCE	wood	5	\N	\N	\N	\N
8437	84	36	RESOURCE	food	3	\N	\N	\N	\N
8438	84	37	EMPTY	\N	\N	\N	\N	\N	\N
8439	84	38	EMPTY	\N	\N	\N	\N	\N	\N
8440	84	39	EMPTY	\N	\N	\N	\N	\N	\N
8441	84	40	EMPTY	\N	\N	\N	\N	\N	\N
8442	84	41	EMPTY	\N	\N	\N	\N	\N	\N
8443	84	42	EMPTY	\N	\N	\N	\N	\N	\N
8444	84	43	EMPTY	\N	\N	\N	\N	\N	\N
8445	84	44	NPC	\N	\N	4	\N	Barbarian Camp (Lv 4)	\N
8446	84	45	EMPTY	\N	\N	\N	\N	\N	\N
8447	84	46	EMPTY	\N	\N	\N	\N	\N	\N
8448	84	47	EMPTY	\N	\N	\N	\N	\N	\N
8449	84	48	EMPTY	\N	\N	\N	\N	\N	\N
8450	84	49	EMPTY	\N	\N	\N	\N	\N	\N
8451	84	50	EMPTY	\N	\N	\N	\N	\N	\N
8452	84	51	EMPTY	\N	\N	\N	\N	\N	\N
8453	84	52	RESOURCE	stone	3	\N	\N	\N	\N
8454	84	53	EMPTY	\N	\N	\N	\N	\N	\N
8455	84	54	RESOURCE	iron	2	\N	\N	\N	\N
8456	84	55	EMPTY	\N	\N	\N	\N	\N	\N
8457	84	56	EMPTY	\N	\N	\N	\N	\N	\N
8458	84	57	EMPTY	\N	\N	\N	\N	\N	\N
8459	84	58	EMPTY	\N	\N	\N	\N	\N	\N
8460	84	59	EMPTY	\N	\N	\N	\N	\N	\N
8461	84	60	EMPTY	\N	\N	\N	\N	\N	\N
8462	84	61	EMPTY	\N	\N	\N	\N	\N	\N
8463	84	62	RESOURCE	iron	3	\N	\N	\N	\N
8464	84	63	NPC	\N	\N	1	\N	Barbarian Camp (Lv 1)	\N
8465	84	64	EMPTY	\N	\N	\N	\N	\N	\N
8466	84	65	EMPTY	\N	\N	\N	\N	\N	\N
8467	84	66	EMPTY	\N	\N	\N	\N	\N	\N
8468	84	67	EMPTY	\N	\N	\N	\N	\N	\N
8469	84	68	RESOURCE	food	5	\N	\N	\N	\N
8470	84	69	EMPTY	\N	\N	\N	\N	\N	\N
8471	84	70	RESOURCE	stone	5	\N	\N	\N	\N
8472	84	71	EMPTY	\N	\N	\N	\N	\N	\N
8473	84	72	RESOURCE	iron	4	\N	\N	\N	\N
8474	84	73	EMPTY	\N	\N	\N	\N	\N	\N
8475	84	74	EMPTY	\N	\N	\N	\N	\N	\N
8476	84	75	EMPTY	\N	\N	\N	\N	\N	\N
8477	84	76	EMPTY	\N	\N	\N	\N	\N	\N
8478	84	77	EMPTY	\N	\N	\N	\N	\N	\N
8479	84	78	EMPTY	\N	\N	\N	\N	\N	\N
8480	84	79	EMPTY	\N	\N	\N	\N	\N	\N
8481	84	80	EMPTY	\N	\N	\N	\N	\N	\N
8482	84	81	EMPTY	\N	\N	\N	\N	\N	\N
8483	84	82	EMPTY	\N	\N	\N	\N	\N	\N
8484	84	83	EMPTY	\N	\N	\N	\N	\N	\N
8485	84	84	RESOURCE	iron	3	\N	\N	\N	\N
8486	84	85	EMPTY	\N	\N	\N	\N	\N	\N
8487	84	86	EMPTY	\N	\N	\N	\N	\N	\N
8488	84	87	EMPTY	\N	\N	\N	\N	\N	\N
8489	84	88	EMPTY	\N	\N	\N	\N	\N	\N
8490	84	89	EMPTY	\N	\N	\N	\N	\N	\N
8491	84	90	EMPTY	\N	\N	\N	\N	\N	\N
8492	84	91	EMPTY	\N	\N	\N	\N	\N	\N
8493	84	92	EMPTY	\N	\N	\N	\N	\N	\N
8494	84	93	EMPTY	\N	\N	\N	\N	\N	\N
8495	84	94	EMPTY	\N	\N	\N	\N	\N	\N
8496	84	95	EMPTY	\N	\N	\N	\N	\N	\N
8497	84	96	EMPTY	\N	\N	\N	\N	\N	\N
8498	84	97	NPC	\N	\N	10	\N	Barbarian Camp (Lv 10)	\N
8499	84	98	EMPTY	\N	\N	\N	\N	\N	\N
8500	84	99	EMPTY	\N	\N	\N	\N	\N	\N
8501	85	0	EMPTY	\N	\N	\N	\N	\N	\N
8502	85	1	EMPTY	\N	\N	\N	\N	\N	\N
8503	85	2	EMPTY	\N	\N	\N	\N	\N	\N
8504	85	3	EMPTY	\N	\N	\N	\N	\N	\N
8505	85	4	VALLEY	\N	\N	\N	\N	Valley (85, 4)	\N
8506	85	5	EMPTY	\N	\N	\N	\N	\N	\N
8507	85	6	EMPTY	\N	\N	\N	\N	\N	\N
8508	85	7	EMPTY	\N	\N	\N	\N	\N	\N
8509	85	8	EMPTY	\N	\N	\N	\N	\N	\N
8510	85	9	EMPTY	\N	\N	\N	\N	\N	\N
8511	85	10	EMPTY	\N	\N	\N	\N	\N	\N
8512	85	11	EMPTY	\N	\N	\N	\N	\N	\N
8513	85	12	RESOURCE	stone	4	\N	\N	\N	\N
8514	85	13	EMPTY	\N	\N	\N	\N	\N	\N
8515	85	14	EMPTY	\N	\N	\N	\N	\N	\N
8516	85	15	EMPTY	\N	\N	\N	\N	\N	\N
8517	85	16	RESOURCE	wood	3	\N	\N	\N	\N
8518	85	17	EMPTY	\N	\N	\N	\N	\N	\N
8519	85	18	NPC	\N	\N	5	\N	Barbarian Camp (Lv 5)	\N
8520	85	19	EMPTY	\N	\N	\N	\N	\N	\N
8521	85	20	RESOURCE	stone	2	\N	\N	\N	\N
8522	85	21	EMPTY	\N	\N	\N	\N	\N	\N
8523	85	22	EMPTY	\N	\N	\N	\N	\N	\N
8524	85	23	NPC	\N	\N	8	\N	Barbarian Camp (Lv 8)	\N
8525	85	24	EMPTY	\N	\N	\N	\N	\N	\N
8526	85	25	EMPTY	\N	\N	\N	\N	\N	\N
8527	85	26	EMPTY	\N	\N	\N	\N	\N	\N
8528	85	27	EMPTY	\N	\N	\N	\N	\N	\N
8529	85	28	EMPTY	\N	\N	\N	\N	\N	\N
8530	85	29	VALLEY	\N	\N	\N	\N	Valley (85, 29)	\N
8531	85	30	EMPTY	\N	\N	\N	\N	\N	\N
8532	85	31	RESOURCE	food	3	\N	\N	\N	\N
8533	85	32	EMPTY	\N	\N	\N	\N	\N	\N
8534	85	33	EMPTY	\N	\N	\N	\N	\N	\N
8535	85	34	EMPTY	\N	\N	\N	\N	\N	\N
8536	85	35	EMPTY	\N	\N	\N	\N	\N	\N
8537	85	36	EMPTY	\N	\N	\N	\N	\N	\N
8538	85	37	NPC	\N	\N	4	\N	Barbarian Camp (Lv 4)	\N
8539	85	38	EMPTY	\N	\N	\N	\N	\N	\N
8540	85	39	EMPTY	\N	\N	\N	\N	\N	\N
8541	85	40	EMPTY	\N	\N	\N	\N	\N	\N
8542	85	41	EMPTY	\N	\N	\N	\N	\N	\N
8543	85	42	EMPTY	\N	\N	\N	\N	\N	\N
8544	85	43	EMPTY	\N	\N	\N	\N	\N	\N
8545	85	44	EMPTY	\N	\N	\N	\N	\N	\N
8546	85	45	EMPTY	\N	\N	\N	\N	\N	\N
8547	85	46	EMPTY	\N	\N	\N	\N	\N	\N
8548	85	47	EMPTY	\N	\N	\N	\N	\N	\N
8549	85	48	EMPTY	\N	\N	\N	\N	\N	\N
8550	85	49	EMPTY	\N	\N	\N	\N	\N	\N
8551	85	50	EMPTY	\N	\N	\N	\N	\N	\N
8552	85	51	EMPTY	\N	\N	\N	\N	\N	\N
8553	85	52	EMPTY	\N	\N	\N	\N	\N	\N
8554	85	53	EMPTY	\N	\N	\N	\N	\N	\N
8555	85	54	EMPTY	\N	\N	\N	\N	\N	\N
8556	85	55	EMPTY	\N	\N	\N	\N	\N	\N
8557	85	56	EMPTY	\N	\N	\N	\N	\N	\N
8558	85	57	EMPTY	\N	\N	\N	\N	\N	\N
8559	85	58	EMPTY	\N	\N	\N	\N	\N	\N
8560	85	59	EMPTY	\N	\N	\N	\N	\N	\N
8561	85	60	RESOURCE	food	3	\N	\N	\N	\N
8562	85	61	EMPTY	\N	\N	\N	\N	\N	\N
8563	85	62	EMPTY	\N	\N	\N	\N	\N	\N
8564	85	63	EMPTY	\N	\N	\N	\N	\N	\N
8565	85	64	EMPTY	\N	\N	\N	\N	\N	\N
8566	85	65	EMPTY	\N	\N	\N	\N	\N	\N
8567	85	66	EMPTY	\N	\N	\N	\N	\N	\N
8568	85	67	EMPTY	\N	\N	\N	\N	\N	\N
8569	85	68	EMPTY	\N	\N	\N	\N	\N	\N
8570	85	69	EMPTY	\N	\N	\N	\N	\N	\N
8571	85	70	NPC	\N	\N	7	\N	Barbarian Camp (Lv 7)	\N
8572	85	71	EMPTY	\N	\N	\N	\N	\N	\N
8573	85	72	NPC	\N	\N	1	\N	Barbarian Camp (Lv 1)	\N
8574	85	73	EMPTY	\N	\N	\N	\N	\N	\N
8575	85	74	EMPTY	\N	\N	\N	\N	\N	\N
8576	85	75	EMPTY	\N	\N	\N	\N	\N	\N
8577	85	76	EMPTY	\N	\N	\N	\N	\N	\N
8578	85	77	EMPTY	\N	\N	\N	\N	\N	\N
8579	85	78	EMPTY	\N	\N	\N	\N	\N	\N
8580	85	79	EMPTY	\N	\N	\N	\N	\N	\N
8581	85	80	EMPTY	\N	\N	\N	\N	\N	\N
8582	85	81	EMPTY	\N	\N	\N	\N	\N	\N
8583	85	82	EMPTY	\N	\N	\N	\N	\N	\N
8584	85	83	EMPTY	\N	\N	\N	\N	\N	\N
8585	85	84	RESOURCE	stone	2	\N	\N	\N	\N
8586	85	85	EMPTY	\N	\N	\N	\N	\N	\N
8587	85	86	EMPTY	\N	\N	\N	\N	\N	\N
8588	85	87	EMPTY	\N	\N	\N	\N	\N	\N
8589	85	88	EMPTY	\N	\N	\N	\N	\N	\N
8590	85	89	EMPTY	\N	\N	\N	\N	\N	\N
8591	85	90	EMPTY	\N	\N	\N	\N	\N	\N
8592	85	91	EMPTY	\N	\N	\N	\N	\N	\N
8593	85	92	EMPTY	\N	\N	\N	\N	\N	\N
8594	85	93	EMPTY	\N	\N	\N	\N	\N	\N
8595	85	94	EMPTY	\N	\N	\N	\N	\N	\N
8596	85	95	VALLEY	\N	\N	\N	\N	Valley (85, 95)	\N
8597	85	96	EMPTY	\N	\N	\N	\N	\N	\N
8598	85	97	NPC	\N	\N	6	\N	Barbarian Camp (Lv 6)	\N
8599	85	98	EMPTY	\N	\N	\N	\N	\N	\N
8600	85	99	EMPTY	\N	\N	\N	\N	\N	\N
8601	86	0	RESOURCE	food	2	\N	\N	\N	\N
8602	86	1	EMPTY	\N	\N	\N	\N	\N	\N
8603	86	2	RESOURCE	food	3	\N	\N	\N	\N
8604	86	3	EMPTY	\N	\N	\N	\N	\N	\N
8605	86	4	EMPTY	\N	\N	\N	\N	\N	\N
8606	86	5	EMPTY	\N	\N	\N	\N	\N	\N
8607	86	6	EMPTY	\N	\N	\N	\N	\N	\N
8608	86	7	EMPTY	\N	\N	\N	\N	\N	\N
8609	86	8	RESOURCE	wood	4	\N	\N	\N	\N
8610	86	9	EMPTY	\N	\N	\N	\N	\N	\N
8611	86	10	EMPTY	\N	\N	\N	\N	\N	\N
8612	86	11	EMPTY	\N	\N	\N	\N	\N	\N
8613	86	12	EMPTY	\N	\N	\N	\N	\N	\N
8614	86	13	EMPTY	\N	\N	\N	\N	\N	\N
8615	86	14	EMPTY	\N	\N	\N	\N	\N	\N
8616	86	15	EMPTY	\N	\N	\N	\N	\N	\N
8617	86	16	EMPTY	\N	\N	\N	\N	\N	\N
8618	86	17	NPC	\N	\N	4	\N	Barbarian Camp (Lv 4)	\N
8619	86	18	EMPTY	\N	\N	\N	\N	\N	\N
8620	86	19	EMPTY	\N	\N	\N	\N	\N	\N
8621	86	20	EMPTY	\N	\N	\N	\N	\N	\N
8622	86	21	EMPTY	\N	\N	\N	\N	\N	\N
8623	86	22	NPC	\N	\N	10	\N	Barbarian Camp (Lv 10)	\N
8624	86	23	EMPTY	\N	\N	\N	\N	\N	\N
8625	86	24	EMPTY	\N	\N	\N	\N	\N	\N
8626	86	25	EMPTY	\N	\N	\N	\N	\N	\N
8627	86	26	EMPTY	\N	\N	\N	\N	\N	\N
8628	86	27	EMPTY	\N	\N	\N	\N	\N	\N
8629	86	28	EMPTY	\N	\N	\N	\N	\N	\N
8630	86	29	EMPTY	\N	\N	\N	\N	\N	\N
8631	86	30	EMPTY	\N	\N	\N	\N	\N	\N
8632	86	31	EMPTY	\N	\N	\N	\N	\N	\N
8633	86	32	EMPTY	\N	\N	\N	\N	\N	\N
8634	86	33	EMPTY	\N	\N	\N	\N	\N	\N
8635	86	34	EMPTY	\N	\N	\N	\N	\N	\N
8636	86	35	NPC	\N	\N	3	\N	Barbarian Camp (Lv 3)	\N
8637	86	36	EMPTY	\N	\N	\N	\N	\N	\N
8638	86	37	EMPTY	\N	\N	\N	\N	\N	\N
8639	86	38	EMPTY	\N	\N	\N	\N	\N	\N
8640	86	39	EMPTY	\N	\N	\N	\N	\N	\N
8641	86	40	EMPTY	\N	\N	\N	\N	\N	\N
8642	86	41	EMPTY	\N	\N	\N	\N	\N	\N
8643	86	42	NPC	\N	\N	9	\N	Barbarian Camp (Lv 9)	\N
8644	86	43	EMPTY	\N	\N	\N	\N	\N	\N
8645	86	44	EMPTY	\N	\N	\N	\N	\N	\N
8646	86	45	EMPTY	\N	\N	\N	\N	\N	\N
8647	86	46	EMPTY	\N	\N	\N	\N	\N	\N
8648	86	47	EMPTY	\N	\N	\N	\N	\N	\N
8649	86	48	EMPTY	\N	\N	\N	\N	\N	\N
8650	86	49	EMPTY	\N	\N	\N	\N	\N	\N
8651	86	50	EMPTY	\N	\N	\N	\N	\N	\N
8652	86	51	EMPTY	\N	\N	\N	\N	\N	\N
8653	86	52	EMPTY	\N	\N	\N	\N	\N	\N
8654	86	53	EMPTY	\N	\N	\N	\N	\N	\N
8655	86	54	EMPTY	\N	\N	\N	\N	\N	\N
8656	86	55	EMPTY	\N	\N	\N	\N	\N	\N
8657	86	56	EMPTY	\N	\N	\N	\N	\N	\N
8658	86	57	EMPTY	\N	\N	\N	\N	\N	\N
8659	86	58	EMPTY	\N	\N	\N	\N	\N	\N
8660	86	59	EMPTY	\N	\N	\N	\N	\N	\N
8661	86	60	EMPTY	\N	\N	\N	\N	\N	\N
8662	86	61	EMPTY	\N	\N	\N	\N	\N	\N
8663	86	62	EMPTY	\N	\N	\N	\N	\N	\N
8664	86	63	EMPTY	\N	\N	\N	\N	\N	\N
8665	86	64	EMPTY	\N	\N	\N	\N	\N	\N
8666	86	65	EMPTY	\N	\N	\N	\N	\N	\N
8667	86	66	EMPTY	\N	\N	\N	\N	\N	\N
8668	86	67	EMPTY	\N	\N	\N	\N	\N	\N
8669	86	68	EMPTY	\N	\N	\N	\N	\N	\N
8670	86	69	EMPTY	\N	\N	\N	\N	\N	\N
8671	86	70	EMPTY	\N	\N	\N	\N	\N	\N
8672	86	71	EMPTY	\N	\N	\N	\N	\N	\N
8673	86	72	RESOURCE	wood	3	\N	\N	\N	\N
8674	86	73	RESOURCE	wood	1	\N	\N	\N	\N
8675	86	74	EMPTY	\N	\N	\N	\N	\N	\N
8676	86	75	NPC	\N	\N	4	\N	Barbarian Camp (Lv 4)	\N
8677	86	76	EMPTY	\N	\N	\N	\N	\N	\N
8678	86	77	EMPTY	\N	\N	\N	\N	\N	\N
8679	86	78	EMPTY	\N	\N	\N	\N	\N	\N
8680	86	79	EMPTY	\N	\N	\N	\N	\N	\N
8681	86	80	EMPTY	\N	\N	\N	\N	\N	\N
8682	86	81	EMPTY	\N	\N	\N	\N	\N	\N
8683	86	82	RESOURCE	food	4	\N	\N	\N	\N
8684	86	83	RESOURCE	food	1	\N	\N	\N	\N
8685	86	84	EMPTY	\N	\N	\N	\N	\N	\N
8686	86	85	EMPTY	\N	\N	\N	\N	\N	\N
8687	86	86	VALLEY	\N	\N	\N	\N	Valley (86, 86)	\N
8688	86	87	EMPTY	\N	\N	\N	\N	\N	\N
8689	86	88	NPC	\N	\N	9	\N	Barbarian Camp (Lv 9)	\N
8690	86	89	EMPTY	\N	\N	\N	\N	\N	\N
8691	86	90	EMPTY	\N	\N	\N	\N	\N	\N
8692	86	91	EMPTY	\N	\N	\N	\N	\N	\N
8693	86	92	EMPTY	\N	\N	\N	\N	\N	\N
8694	86	93	NPC	\N	\N	4	\N	Barbarian Camp (Lv 4)	\N
8695	86	94	RESOURCE	stone	1	\N	\N	\N	\N
8696	86	95	EMPTY	\N	\N	\N	\N	\N	\N
8697	86	96	EMPTY	\N	\N	\N	\N	\N	\N
8698	86	97	RESOURCE	food	1	\N	\N	\N	\N
8699	86	98	EMPTY	\N	\N	\N	\N	\N	\N
8700	86	99	EMPTY	\N	\N	\N	\N	\N	\N
8701	87	0	EMPTY	\N	\N	\N	\N	\N	\N
8702	87	1	EMPTY	\N	\N	\N	\N	\N	\N
8703	87	2	EMPTY	\N	\N	\N	\N	\N	\N
8704	87	3	EMPTY	\N	\N	\N	\N	\N	\N
8705	87	4	EMPTY	\N	\N	\N	\N	\N	\N
8706	87	5	EMPTY	\N	\N	\N	\N	\N	\N
8707	87	6	EMPTY	\N	\N	\N	\N	\N	\N
8708	87	7	EMPTY	\N	\N	\N	\N	\N	\N
8709	87	8	EMPTY	\N	\N	\N	\N	\N	\N
8710	87	9	EMPTY	\N	\N	\N	\N	\N	\N
8711	87	10	EMPTY	\N	\N	\N	\N	\N	\N
8712	87	11	EMPTY	\N	\N	\N	\N	\N	\N
8713	87	12	EMPTY	\N	\N	\N	\N	\N	\N
8714	87	13	EMPTY	\N	\N	\N	\N	\N	\N
8715	87	14	EMPTY	\N	\N	\N	\N	\N	\N
8716	87	15	EMPTY	\N	\N	\N	\N	\N	\N
8717	87	16	EMPTY	\N	\N	\N	\N	\N	\N
8718	87	17	EMPTY	\N	\N	\N	\N	\N	\N
8719	87	18	EMPTY	\N	\N	\N	\N	\N	\N
8720	87	19	EMPTY	\N	\N	\N	\N	\N	\N
8721	87	20	EMPTY	\N	\N	\N	\N	\N	\N
8722	87	21	EMPTY	\N	\N	\N	\N	\N	\N
8723	87	22	EMPTY	\N	\N	\N	\N	\N	\N
8724	87	23	EMPTY	\N	\N	\N	\N	\N	\N
8725	87	24	EMPTY	\N	\N	\N	\N	\N	\N
8726	87	25	EMPTY	\N	\N	\N	\N	\N	\N
8727	87	26	EMPTY	\N	\N	\N	\N	\N	\N
8728	87	27	EMPTY	\N	\N	\N	\N	\N	\N
8729	87	28	EMPTY	\N	\N	\N	\N	\N	\N
8730	87	29	RESOURCE	wood	5	\N	\N	\N	\N
8731	87	30	EMPTY	\N	\N	\N	\N	\N	\N
8732	87	31	RESOURCE	wood	4	\N	\N	\N	\N
8733	87	32	EMPTY	\N	\N	\N	\N	\N	\N
8734	87	33	EMPTY	\N	\N	\N	\N	\N	\N
8735	87	34	RESOURCE	wood	3	\N	\N	\N	\N
8736	87	35	EMPTY	\N	\N	\N	\N	\N	\N
8737	87	36	EMPTY	\N	\N	\N	\N	\N	\N
8738	87	37	EMPTY	\N	\N	\N	\N	\N	\N
8739	87	38	EMPTY	\N	\N	\N	\N	\N	\N
8740	87	39	EMPTY	\N	\N	\N	\N	\N	\N
8741	87	40	EMPTY	\N	\N	\N	\N	\N	\N
8742	87	41	EMPTY	\N	\N	\N	\N	\N	\N
8743	87	42	EMPTY	\N	\N	\N	\N	\N	\N
8744	87	43	EMPTY	\N	\N	\N	\N	\N	\N
8745	87	44	EMPTY	\N	\N	\N	\N	\N	\N
8746	87	45	EMPTY	\N	\N	\N	\N	\N	\N
8747	87	46	EMPTY	\N	\N	\N	\N	\N	\N
8748	87	47	EMPTY	\N	\N	\N	\N	\N	\N
8749	87	48	EMPTY	\N	\N	\N	\N	\N	\N
8750	87	49	EMPTY	\N	\N	\N	\N	\N	\N
8751	87	50	NPC	\N	\N	3	\N	Barbarian Camp (Lv 3)	\N
8752	87	51	EMPTY	\N	\N	\N	\N	\N	\N
8753	87	52	EMPTY	\N	\N	\N	\N	\N	\N
8754	87	53	NPC	\N	\N	8	\N	Barbarian Camp (Lv 8)	\N
8755	87	54	EMPTY	\N	\N	\N	\N	\N	\N
8756	87	55	RESOURCE	food	4	\N	\N	\N	\N
8757	87	56	RESOURCE	food	3	\N	\N	\N	\N
8758	87	57	EMPTY	\N	\N	\N	\N	\N	\N
8759	87	58	EMPTY	\N	\N	\N	\N	\N	\N
8760	87	59	EMPTY	\N	\N	\N	\N	\N	\N
8761	87	60	EMPTY	\N	\N	\N	\N	\N	\N
8762	87	61	EMPTY	\N	\N	\N	\N	\N	\N
8763	87	62	EMPTY	\N	\N	\N	\N	\N	\N
8764	87	63	EMPTY	\N	\N	\N	\N	\N	\N
8765	87	64	EMPTY	\N	\N	\N	\N	\N	\N
8766	87	65	EMPTY	\N	\N	\N	\N	\N	\N
8767	87	66	EMPTY	\N	\N	\N	\N	\N	\N
8768	87	67	EMPTY	\N	\N	\N	\N	\N	\N
8769	87	68	EMPTY	\N	\N	\N	\N	\N	\N
8770	87	69	EMPTY	\N	\N	\N	\N	\N	\N
8771	87	70	EMPTY	\N	\N	\N	\N	\N	\N
8772	87	71	EMPTY	\N	\N	\N	\N	\N	\N
8773	87	72	EMPTY	\N	\N	\N	\N	\N	\N
8774	87	73	EMPTY	\N	\N	\N	\N	\N	\N
8775	87	74	EMPTY	\N	\N	\N	\N	\N	\N
8776	87	75	EMPTY	\N	\N	\N	\N	\N	\N
8777	87	76	EMPTY	\N	\N	\N	\N	\N	\N
8778	87	77	EMPTY	\N	\N	\N	\N	\N	\N
8779	87	78	EMPTY	\N	\N	\N	\N	\N	\N
8780	87	79	EMPTY	\N	\N	\N	\N	\N	\N
8781	87	80	RESOURCE	stone	1	\N	\N	\N	\N
8782	87	81	EMPTY	\N	\N	\N	\N	\N	\N
8783	87	82	RESOURCE	food	3	\N	\N	\N	\N
8784	87	83	EMPTY	\N	\N	\N	\N	\N	\N
8785	87	84	EMPTY	\N	\N	\N	\N	\N	\N
8786	87	85	EMPTY	\N	\N	\N	\N	\N	\N
8787	87	86	EMPTY	\N	\N	\N	\N	\N	\N
8788	87	87	EMPTY	\N	\N	\N	\N	\N	\N
8789	87	88	EMPTY	\N	\N	\N	\N	\N	\N
8790	87	89	EMPTY	\N	\N	\N	\N	\N	\N
8791	87	90	EMPTY	\N	\N	\N	\N	\N	\N
8792	87	91	RESOURCE	stone	5	\N	\N	\N	\N
8793	87	92	EMPTY	\N	\N	\N	\N	\N	\N
8794	87	93	EMPTY	\N	\N	\N	\N	\N	\N
8795	87	94	EMPTY	\N	\N	\N	\N	\N	\N
8796	87	95	EMPTY	\N	\N	\N	\N	\N	\N
8797	87	96	EMPTY	\N	\N	\N	\N	\N	\N
8798	87	97	EMPTY	\N	\N	\N	\N	\N	\N
8799	87	98	EMPTY	\N	\N	\N	\N	\N	\N
8800	87	99	EMPTY	\N	\N	\N	\N	\N	\N
8801	88	0	EMPTY	\N	\N	\N	\N	\N	\N
8802	88	1	RESOURCE	wood	4	\N	\N	\N	\N
8803	88	2	EMPTY	\N	\N	\N	\N	\N	\N
8804	88	3	EMPTY	\N	\N	\N	\N	\N	\N
8805	88	4	EMPTY	\N	\N	\N	\N	\N	\N
8806	88	5	EMPTY	\N	\N	\N	\N	\N	\N
8807	88	6	EMPTY	\N	\N	\N	\N	\N	\N
8808	88	7	RESOURCE	food	3	\N	\N	\N	\N
8809	88	8	EMPTY	\N	\N	\N	\N	\N	\N
8810	88	9	EMPTY	\N	\N	\N	\N	\N	\N
8811	88	10	RESOURCE	food	4	\N	\N	\N	\N
8812	88	11	RESOURCE	stone	2	\N	\N	\N	\N
8813	88	12	EMPTY	\N	\N	\N	\N	\N	\N
8814	88	13	EMPTY	\N	\N	\N	\N	\N	\N
8815	88	14	EMPTY	\N	\N	\N	\N	\N	\N
8816	88	15	NPC	\N	\N	8	\N	Barbarian Camp (Lv 8)	\N
8817	88	16	EMPTY	\N	\N	\N	\N	\N	\N
8818	88	17	EMPTY	\N	\N	\N	\N	\N	\N
8819	88	18	EMPTY	\N	\N	\N	\N	\N	\N
8820	88	19	RESOURCE	food	1	\N	\N	\N	\N
8821	88	20	EMPTY	\N	\N	\N	\N	\N	\N
8822	88	21	RESOURCE	wood	3	\N	\N	\N	\N
8823	88	22	EMPTY	\N	\N	\N	\N	\N	\N
8824	88	23	EMPTY	\N	\N	\N	\N	\N	\N
8825	88	24	EMPTY	\N	\N	\N	\N	\N	\N
8826	88	25	EMPTY	\N	\N	\N	\N	\N	\N
8827	88	26	EMPTY	\N	\N	\N	\N	\N	\N
8828	88	27	EMPTY	\N	\N	\N	\N	\N	\N
8829	88	28	EMPTY	\N	\N	\N	\N	\N	\N
8830	88	29	EMPTY	\N	\N	\N	\N	\N	\N
8831	88	30	EMPTY	\N	\N	\N	\N	\N	\N
8832	88	31	EMPTY	\N	\N	\N	\N	\N	\N
8833	88	32	EMPTY	\N	\N	\N	\N	\N	\N
8834	88	33	EMPTY	\N	\N	\N	\N	\N	\N
8835	88	34	EMPTY	\N	\N	\N	\N	\N	\N
8836	88	35	EMPTY	\N	\N	\N	\N	\N	\N
8837	88	36	EMPTY	\N	\N	\N	\N	\N	\N
8838	88	37	EMPTY	\N	\N	\N	\N	\N	\N
8839	88	38	EMPTY	\N	\N	\N	\N	\N	\N
8840	88	39	EMPTY	\N	\N	\N	\N	\N	\N
8841	88	40	EMPTY	\N	\N	\N	\N	\N	\N
8842	88	41	EMPTY	\N	\N	\N	\N	\N	\N
8843	88	42	EMPTY	\N	\N	\N	\N	\N	\N
8844	88	43	EMPTY	\N	\N	\N	\N	\N	\N
8845	88	44	EMPTY	\N	\N	\N	\N	\N	\N
8846	88	45	EMPTY	\N	\N	\N	\N	\N	\N
8847	88	46	EMPTY	\N	\N	\N	\N	\N	\N
8848	88	47	NPC	\N	\N	5	\N	Barbarian Camp (Lv 5)	\N
8849	88	48	EMPTY	\N	\N	\N	\N	\N	\N
8850	88	49	VALLEY	\N	\N	\N	\N	Valley (88, 49)	\N
8851	88	50	NPC	\N	\N	10	\N	Barbarian Camp (Lv 10)	\N
8852	88	51	EMPTY	\N	\N	\N	\N	\N	\N
8853	88	52	EMPTY	\N	\N	\N	\N	\N	\N
8854	88	53	EMPTY	\N	\N	\N	\N	\N	\N
8855	88	54	EMPTY	\N	\N	\N	\N	\N	\N
8856	88	55	EMPTY	\N	\N	\N	\N	\N	\N
8857	88	56	EMPTY	\N	\N	\N	\N	\N	\N
8858	88	57	EMPTY	\N	\N	\N	\N	\N	\N
8859	88	58	EMPTY	\N	\N	\N	\N	\N	\N
8860	88	59	RESOURCE	food	5	\N	\N	\N	\N
8861	88	60	EMPTY	\N	\N	\N	\N	\N	\N
8862	88	61	EMPTY	\N	\N	\N	\N	\N	\N
8863	88	62	RESOURCE	stone	5	\N	\N	\N	\N
8864	88	63	EMPTY	\N	\N	\N	\N	\N	\N
8865	88	64	EMPTY	\N	\N	\N	\N	\N	\N
8866	88	65	EMPTY	\N	\N	\N	\N	\N	\N
8867	88	66	NPC	\N	\N	2	\N	Barbarian Camp (Lv 2)	\N
8868	88	67	EMPTY	\N	\N	\N	\N	\N	\N
8869	88	68	EMPTY	\N	\N	\N	\N	\N	\N
8870	88	69	EMPTY	\N	\N	\N	\N	\N	\N
8871	88	70	EMPTY	\N	\N	\N	\N	\N	\N
8872	88	71	EMPTY	\N	\N	\N	\N	\N	\N
8873	88	72	EMPTY	\N	\N	\N	\N	\N	\N
8874	88	73	EMPTY	\N	\N	\N	\N	\N	\N
8875	88	74	EMPTY	\N	\N	\N	\N	\N	\N
8876	88	75	EMPTY	\N	\N	\N	\N	\N	\N
8877	88	76	EMPTY	\N	\N	\N	\N	\N	\N
8878	88	77	EMPTY	\N	\N	\N	\N	\N	\N
8879	88	78	RESOURCE	food	4	\N	\N	\N	\N
8880	88	79	EMPTY	\N	\N	\N	\N	\N	\N
8881	88	80	RESOURCE	iron	3	\N	\N	\N	\N
8882	88	81	EMPTY	\N	\N	\N	\N	\N	\N
8883	88	82	EMPTY	\N	\N	\N	\N	\N	\N
8884	88	83	NPC	\N	\N	4	\N	Barbarian Camp (Lv 4)	\N
8885	88	84	EMPTY	\N	\N	\N	\N	\N	\N
8886	88	85	EMPTY	\N	\N	\N	\N	\N	\N
8887	88	86	EMPTY	\N	\N	\N	\N	\N	\N
8888	88	87	RESOURCE	iron	4	\N	\N	\N	\N
8889	88	88	EMPTY	\N	\N	\N	\N	\N	\N
8890	88	89	EMPTY	\N	\N	\N	\N	\N	\N
8891	88	90	EMPTY	\N	\N	\N	\N	\N	\N
8892	88	91	EMPTY	\N	\N	\N	\N	\N	\N
8893	88	92	EMPTY	\N	\N	\N	\N	\N	\N
8894	88	93	EMPTY	\N	\N	\N	\N	\N	\N
8895	88	94	EMPTY	\N	\N	\N	\N	\N	\N
8896	88	95	EMPTY	\N	\N	\N	\N	\N	\N
8897	88	96	EMPTY	\N	\N	\N	\N	\N	\N
8898	88	97	EMPTY	\N	\N	\N	\N	\N	\N
8899	88	98	EMPTY	\N	\N	\N	\N	\N	\N
8900	88	99	EMPTY	\N	\N	\N	\N	\N	\N
8901	89	0	NPC	\N	\N	3	\N	Barbarian Camp (Lv 3)	\N
8902	89	1	EMPTY	\N	\N	\N	\N	\N	\N
8903	89	2	EMPTY	\N	\N	\N	\N	\N	\N
8904	89	3	RESOURCE	food	4	\N	\N	\N	\N
8905	89	4	EMPTY	\N	\N	\N	\N	\N	\N
8906	89	5	EMPTY	\N	\N	\N	\N	\N	\N
8907	89	6	RESOURCE	wood	3	\N	\N	\N	\N
8908	89	7	NPC	\N	\N	1	\N	Barbarian Camp (Lv 1)	\N
8909	89	8	EMPTY	\N	\N	\N	\N	\N	\N
8910	89	9	EMPTY	\N	\N	\N	\N	\N	\N
8911	89	10	EMPTY	\N	\N	\N	\N	\N	\N
8912	89	11	EMPTY	\N	\N	\N	\N	\N	\N
8913	89	12	EMPTY	\N	\N	\N	\N	\N	\N
8914	89	13	EMPTY	\N	\N	\N	\N	\N	\N
8915	89	14	EMPTY	\N	\N	\N	\N	\N	\N
8916	89	15	EMPTY	\N	\N	\N	\N	\N	\N
8917	89	16	EMPTY	\N	\N	\N	\N	\N	\N
8918	89	17	EMPTY	\N	\N	\N	\N	\N	\N
8919	89	18	EMPTY	\N	\N	\N	\N	\N	\N
8920	89	19	RESOURCE	food	1	\N	\N	\N	\N
8921	89	20	EMPTY	\N	\N	\N	\N	\N	\N
8922	89	21	EMPTY	\N	\N	\N	\N	\N	\N
8923	89	22	EMPTY	\N	\N	\N	\N	\N	\N
8924	89	23	EMPTY	\N	\N	\N	\N	\N	\N
8925	89	24	EMPTY	\N	\N	\N	\N	\N	\N
8926	89	25	EMPTY	\N	\N	\N	\N	\N	\N
8927	89	26	EMPTY	\N	\N	\N	\N	\N	\N
8928	89	27	EMPTY	\N	\N	\N	\N	\N	\N
8929	89	28	NPC	\N	\N	2	\N	Barbarian Camp (Lv 2)	\N
8930	89	29	EMPTY	\N	\N	\N	\N	\N	\N
8931	89	30	EMPTY	\N	\N	\N	\N	\N	\N
8932	89	31	EMPTY	\N	\N	\N	\N	\N	\N
8933	89	32	EMPTY	\N	\N	\N	\N	\N	\N
8934	89	33	EMPTY	\N	\N	\N	\N	\N	\N
8935	89	34	EMPTY	\N	\N	\N	\N	\N	\N
8936	89	35	EMPTY	\N	\N	\N	\N	\N	\N
8937	89	36	EMPTY	\N	\N	\N	\N	\N	\N
8938	89	37	EMPTY	\N	\N	\N	\N	\N	\N
8939	89	38	NPC	\N	\N	6	\N	Barbarian Camp (Lv 6)	\N
8940	89	39	EMPTY	\N	\N	\N	\N	\N	\N
8941	89	40	EMPTY	\N	\N	\N	\N	\N	\N
8942	89	41	EMPTY	\N	\N	\N	\N	\N	\N
8943	89	42	EMPTY	\N	\N	\N	\N	\N	\N
8944	89	43	EMPTY	\N	\N	\N	\N	\N	\N
8945	89	44	EMPTY	\N	\N	\N	\N	\N	\N
8946	89	45	VALLEY	\N	\N	\N	\N	Valley (89, 45)	\N
8947	89	46	RESOURCE	iron	5	\N	\N	\N	\N
8948	89	47	EMPTY	\N	\N	\N	\N	\N	\N
8949	89	48	NPC	\N	\N	2	\N	Barbarian Camp (Lv 2)	\N
8950	89	49	EMPTY	\N	\N	\N	\N	\N	\N
8951	89	50	EMPTY	\N	\N	\N	\N	\N	\N
8952	89	51	VALLEY	\N	\N	\N	\N	Valley (89, 51)	\N
8953	89	52	EMPTY	\N	\N	\N	\N	\N	\N
8954	89	53	EMPTY	\N	\N	\N	\N	\N	\N
8955	89	54	EMPTY	\N	\N	\N	\N	\N	\N
8956	89	55	EMPTY	\N	\N	\N	\N	\N	\N
8957	89	56	EMPTY	\N	\N	\N	\N	\N	\N
8958	89	57	EMPTY	\N	\N	\N	\N	\N	\N
8959	89	58	RESOURCE	iron	5	\N	\N	\N	\N
8960	89	59	EMPTY	\N	\N	\N	\N	\N	\N
8961	89	60	EMPTY	\N	\N	\N	\N	\N	\N
8962	89	61	EMPTY	\N	\N	\N	\N	\N	\N
8963	89	62	EMPTY	\N	\N	\N	\N	\N	\N
8964	89	63	EMPTY	\N	\N	\N	\N	\N	\N
8965	89	64	EMPTY	\N	\N	\N	\N	\N	\N
8966	89	65	EMPTY	\N	\N	\N	\N	\N	\N
8967	89	66	EMPTY	\N	\N	\N	\N	\N	\N
8968	89	67	EMPTY	\N	\N	\N	\N	\N	\N
8969	89	68	EMPTY	\N	\N	\N	\N	\N	\N
8970	89	69	EMPTY	\N	\N	\N	\N	\N	\N
8971	89	70	EMPTY	\N	\N	\N	\N	\N	\N
8972	89	71	EMPTY	\N	\N	\N	\N	\N	\N
8973	89	72	EMPTY	\N	\N	\N	\N	\N	\N
8974	89	73	EMPTY	\N	\N	\N	\N	\N	\N
8975	89	74	EMPTY	\N	\N	\N	\N	\N	\N
8976	89	75	VALLEY	\N	\N	\N	\N	Valley (89, 75)	\N
8977	89	76	EMPTY	\N	\N	\N	\N	\N	\N
8978	89	77	EMPTY	\N	\N	\N	\N	\N	\N
8979	89	78	EMPTY	\N	\N	\N	\N	\N	\N
8980	89	79	EMPTY	\N	\N	\N	\N	\N	\N
8981	89	80	RESOURCE	stone	2	\N	\N	\N	\N
8982	89	81	EMPTY	\N	\N	\N	\N	\N	\N
8983	89	82	EMPTY	\N	\N	\N	\N	\N	\N
8984	89	83	RESOURCE	food	2	\N	\N	\N	\N
8985	89	84	EMPTY	\N	\N	\N	\N	\N	\N
8986	89	85	EMPTY	\N	\N	\N	\N	\N	\N
8987	89	86	EMPTY	\N	\N	\N	\N	\N	\N
8988	89	87	RESOURCE	wood	5	\N	\N	\N	\N
8989	89	88	EMPTY	\N	\N	\N	\N	\N	\N
8990	89	89	EMPTY	\N	\N	\N	\N	\N	\N
8991	89	90	RESOURCE	wood	5	\N	\N	\N	\N
8992	89	91	EMPTY	\N	\N	\N	\N	\N	\N
8993	89	92	EMPTY	\N	\N	\N	\N	\N	\N
8994	89	93	EMPTY	\N	\N	\N	\N	\N	\N
8995	89	94	RESOURCE	iron	4	\N	\N	\N	\N
8996	89	95	EMPTY	\N	\N	\N	\N	\N	\N
8997	89	96	EMPTY	\N	\N	\N	\N	\N	\N
8998	89	97	EMPTY	\N	\N	\N	\N	\N	\N
8999	89	98	EMPTY	\N	\N	\N	\N	\N	\N
9000	89	99	EMPTY	\N	\N	\N	\N	\N	\N
9001	90	0	EMPTY	\N	\N	\N	\N	\N	\N
9002	90	1	EMPTY	\N	\N	\N	\N	\N	\N
9003	90	2	EMPTY	\N	\N	\N	\N	\N	\N
9004	90	3	EMPTY	\N	\N	\N	\N	\N	\N
9005	90	4	EMPTY	\N	\N	\N	\N	\N	\N
9006	90	5	EMPTY	\N	\N	\N	\N	\N	\N
9007	90	6	EMPTY	\N	\N	\N	\N	\N	\N
9008	90	7	NPC	\N	\N	2	\N	Barbarian Camp (Lv 2)	\N
9009	90	8	EMPTY	\N	\N	\N	\N	\N	\N
9010	90	9	EMPTY	\N	\N	\N	\N	\N	\N
9011	90	10	NPC	\N	\N	10	\N	Barbarian Camp (Lv 10)	\N
9012	90	11	EMPTY	\N	\N	\N	\N	\N	\N
9013	90	12	EMPTY	\N	\N	\N	\N	\N	\N
9014	90	13	EMPTY	\N	\N	\N	\N	\N	\N
9015	90	14	NPC	\N	\N	2	\N	Barbarian Camp (Lv 2)	\N
9016	90	15	VALLEY	\N	\N	\N	\N	Valley (90, 15)	\N
9017	90	16	EMPTY	\N	\N	\N	\N	\N	\N
9018	90	17	EMPTY	\N	\N	\N	\N	\N	\N
9019	90	18	RESOURCE	wood	3	\N	\N	\N	\N
9020	90	19	RESOURCE	iron	1	\N	\N	\N	\N
9021	90	20	RESOURCE	stone	1	\N	\N	\N	\N
9022	90	21	EMPTY	\N	\N	\N	\N	\N	\N
9023	90	22	EMPTY	\N	\N	\N	\N	\N	\N
9024	90	23	EMPTY	\N	\N	\N	\N	\N	\N
9025	90	24	EMPTY	\N	\N	\N	\N	\N	\N
9026	90	25	EMPTY	\N	\N	\N	\N	\N	\N
9027	90	26	EMPTY	\N	\N	\N	\N	\N	\N
9028	90	27	RESOURCE	wood	2	\N	\N	\N	\N
9029	90	28	EMPTY	\N	\N	\N	\N	\N	\N
9030	90	29	EMPTY	\N	\N	\N	\N	\N	\N
9031	90	30	RESOURCE	food	5	\N	\N	\N	\N
9032	90	31	EMPTY	\N	\N	\N	\N	\N	\N
9033	90	32	EMPTY	\N	\N	\N	\N	\N	\N
9034	90	33	EMPTY	\N	\N	\N	\N	\N	\N
9035	90	34	NPC	\N	\N	9	\N	Barbarian Camp (Lv 9)	\N
9036	90	35	EMPTY	\N	\N	\N	\N	\N	\N
9037	90	36	EMPTY	\N	\N	\N	\N	\N	\N
9038	90	37	EMPTY	\N	\N	\N	\N	\N	\N
9039	90	38	EMPTY	\N	\N	\N	\N	\N	\N
9040	90	39	EMPTY	\N	\N	\N	\N	\N	\N
9041	90	40	RESOURCE	wood	3	\N	\N	\N	\N
9042	90	41	EMPTY	\N	\N	\N	\N	\N	\N
9043	90	42	RESOURCE	stone	4	\N	\N	\N	\N
9044	90	43	EMPTY	\N	\N	\N	\N	\N	\N
9045	90	44	EMPTY	\N	\N	\N	\N	\N	\N
9046	90	45	EMPTY	\N	\N	\N	\N	\N	\N
9047	90	46	EMPTY	\N	\N	\N	\N	\N	\N
9048	90	47	EMPTY	\N	\N	\N	\N	\N	\N
9049	90	48	EMPTY	\N	\N	\N	\N	\N	\N
9050	90	49	EMPTY	\N	\N	\N	\N	\N	\N
9051	90	50	EMPTY	\N	\N	\N	\N	\N	\N
9052	90	51	EMPTY	\N	\N	\N	\N	\N	\N
9053	90	52	EMPTY	\N	\N	\N	\N	\N	\N
9054	90	53	EMPTY	\N	\N	\N	\N	\N	\N
9055	90	54	EMPTY	\N	\N	\N	\N	\N	\N
9056	90	55	EMPTY	\N	\N	\N	\N	\N	\N
9057	90	56	EMPTY	\N	\N	\N	\N	\N	\N
9058	90	57	EMPTY	\N	\N	\N	\N	\N	\N
9059	90	58	EMPTY	\N	\N	\N	\N	\N	\N
9060	90	59	EMPTY	\N	\N	\N	\N	\N	\N
9061	90	60	EMPTY	\N	\N	\N	\N	\N	\N
9062	90	61	EMPTY	\N	\N	\N	\N	\N	\N
9063	90	62	EMPTY	\N	\N	\N	\N	\N	\N
9064	90	63	EMPTY	\N	\N	\N	\N	\N	\N
9065	90	64	RESOURCE	iron	1	\N	\N	\N	\N
9066	90	65	EMPTY	\N	\N	\N	\N	\N	\N
9067	90	66	NPC	\N	\N	1	\N	Barbarian Camp (Lv 1)	\N
9068	90	67	EMPTY	\N	\N	\N	\N	\N	\N
9069	90	68	EMPTY	\N	\N	\N	\N	\N	\N
9070	90	69	EMPTY	\N	\N	\N	\N	\N	\N
9071	90	70	RESOURCE	iron	5	\N	\N	\N	\N
9072	90	71	EMPTY	\N	\N	\N	\N	\N	\N
9073	90	72	EMPTY	\N	\N	\N	\N	\N	\N
9074	90	73	EMPTY	\N	\N	\N	\N	\N	\N
9075	90	74	EMPTY	\N	\N	\N	\N	\N	\N
9076	90	75	EMPTY	\N	\N	\N	\N	\N	\N
9077	90	76	EMPTY	\N	\N	\N	\N	\N	\N
9078	90	77	EMPTY	\N	\N	\N	\N	\N	\N
9079	90	78	VALLEY	\N	\N	\N	\N	Valley (90, 78)	\N
9080	90	79	EMPTY	\N	\N	\N	\N	\N	\N
9081	90	80	EMPTY	\N	\N	\N	\N	\N	\N
9082	90	81	RESOURCE	wood	2	\N	\N	\N	\N
9083	90	82	EMPTY	\N	\N	\N	\N	\N	\N
9084	90	83	EMPTY	\N	\N	\N	\N	\N	\N
9085	90	84	EMPTY	\N	\N	\N	\N	\N	\N
9086	90	85	EMPTY	\N	\N	\N	\N	\N	\N
9087	90	86	EMPTY	\N	\N	\N	\N	\N	\N
9088	90	87	NPC	\N	\N	3	\N	Barbarian Camp (Lv 3)	\N
9089	90	88	VALLEY	\N	\N	\N	\N	Valley (90, 88)	\N
9090	90	89	EMPTY	\N	\N	\N	\N	\N	\N
9091	90	90	EMPTY	\N	\N	\N	\N	\N	\N
9092	90	91	EMPTY	\N	\N	\N	\N	\N	\N
9093	90	92	RESOURCE	food	2	\N	\N	\N	\N
9094	90	93	EMPTY	\N	\N	\N	\N	\N	\N
9095	90	94	EMPTY	\N	\N	\N	\N	\N	\N
9096	90	95	EMPTY	\N	\N	\N	\N	\N	\N
9097	90	96	EMPTY	\N	\N	\N	\N	\N	\N
9098	90	97	EMPTY	\N	\N	\N	\N	\N	\N
9099	90	98	RESOURCE	food	4	\N	\N	\N	\N
9100	90	99	EMPTY	\N	\N	\N	\N	\N	\N
9101	91	0	RESOURCE	stone	4	\N	\N	\N	\N
9102	91	1	EMPTY	\N	\N	\N	\N	\N	\N
9103	91	2	EMPTY	\N	\N	\N	\N	\N	\N
9104	91	3	EMPTY	\N	\N	\N	\N	\N	\N
9105	91	4	EMPTY	\N	\N	\N	\N	\N	\N
9106	91	5	EMPTY	\N	\N	\N	\N	\N	\N
9107	91	6	EMPTY	\N	\N	\N	\N	\N	\N
9108	91	7	EMPTY	\N	\N	\N	\N	\N	\N
9109	91	8	EMPTY	\N	\N	\N	\N	\N	\N
9110	91	9	NPC	\N	\N	7	\N	Barbarian Camp (Lv 7)	\N
9111	91	10	NPC	\N	\N	8	\N	Barbarian Camp (Lv 8)	\N
9112	91	11	EMPTY	\N	\N	\N	\N	\N	\N
9113	91	12	EMPTY	\N	\N	\N	\N	\N	\N
9114	91	13	EMPTY	\N	\N	\N	\N	\N	\N
9115	91	14	NPC	\N	\N	5	\N	Barbarian Camp (Lv 5)	\N
9116	91	15	EMPTY	\N	\N	\N	\N	\N	\N
9117	91	16	EMPTY	\N	\N	\N	\N	\N	\N
9118	91	17	EMPTY	\N	\N	\N	\N	\N	\N
9119	91	18	EMPTY	\N	\N	\N	\N	\N	\N
9120	91	19	EMPTY	\N	\N	\N	\N	\N	\N
9121	91	20	EMPTY	\N	\N	\N	\N	\N	\N
9122	91	21	EMPTY	\N	\N	\N	\N	\N	\N
9123	91	22	VALLEY	\N	\N	\N	\N	Valley (91, 22)	\N
9124	91	23	RESOURCE	food	5	\N	\N	\N	\N
9125	91	24	EMPTY	\N	\N	\N	\N	\N	\N
9126	91	25	EMPTY	\N	\N	\N	\N	\N	\N
9127	91	26	EMPTY	\N	\N	\N	\N	\N	\N
9128	91	27	EMPTY	\N	\N	\N	\N	\N	\N
9129	91	28	EMPTY	\N	\N	\N	\N	\N	\N
9130	91	29	EMPTY	\N	\N	\N	\N	\N	\N
9131	91	30	EMPTY	\N	\N	\N	\N	\N	\N
9132	91	31	EMPTY	\N	\N	\N	\N	\N	\N
9133	91	32	EMPTY	\N	\N	\N	\N	\N	\N
9134	91	33	EMPTY	\N	\N	\N	\N	\N	\N
9135	91	34	EMPTY	\N	\N	\N	\N	\N	\N
9136	91	35	NPC	\N	\N	3	\N	Barbarian Camp (Lv 3)	\N
9137	91	36	EMPTY	\N	\N	\N	\N	\N	\N
9138	91	37	EMPTY	\N	\N	\N	\N	\N	\N
9139	91	38	EMPTY	\N	\N	\N	\N	\N	\N
9140	91	39	EMPTY	\N	\N	\N	\N	\N	\N
9141	91	40	EMPTY	\N	\N	\N	\N	\N	\N
9142	91	41	RESOURCE	food	3	\N	\N	\N	\N
9143	91	42	EMPTY	\N	\N	\N	\N	\N	\N
9144	91	43	EMPTY	\N	\N	\N	\N	\N	\N
9145	91	44	NPC	\N	\N	1	\N	Barbarian Camp (Lv 1)	\N
9146	91	45	EMPTY	\N	\N	\N	\N	\N	\N
9147	91	46	EMPTY	\N	\N	\N	\N	\N	\N
9148	91	47	RESOURCE	iron	1	\N	\N	\N	\N
9149	91	48	EMPTY	\N	\N	\N	\N	\N	\N
9150	91	49	EMPTY	\N	\N	\N	\N	\N	\N
9151	91	50	EMPTY	\N	\N	\N	\N	\N	\N
9152	91	51	RESOURCE	stone	2	\N	\N	\N	\N
9153	91	52	EMPTY	\N	\N	\N	\N	\N	\N
9154	91	53	EMPTY	\N	\N	\N	\N	\N	\N
9155	91	54	EMPTY	\N	\N	\N	\N	\N	\N
9156	91	55	EMPTY	\N	\N	\N	\N	\N	\N
9157	91	56	EMPTY	\N	\N	\N	\N	\N	\N
9158	91	57	EMPTY	\N	\N	\N	\N	\N	\N
9159	91	58	NPC	\N	\N	10	\N	Barbarian Camp (Lv 10)	\N
9160	91	59	EMPTY	\N	\N	\N	\N	\N	\N
9161	91	60	EMPTY	\N	\N	\N	\N	\N	\N
9162	91	61	RESOURCE	wood	2	\N	\N	\N	\N
9163	91	62	EMPTY	\N	\N	\N	\N	\N	\N
9164	91	63	EMPTY	\N	\N	\N	\N	\N	\N
9165	91	64	RESOURCE	food	4	\N	\N	\N	\N
9166	91	65	EMPTY	\N	\N	\N	\N	\N	\N
9167	91	66	EMPTY	\N	\N	\N	\N	\N	\N
9168	91	67	EMPTY	\N	\N	\N	\N	\N	\N
9169	91	68	EMPTY	\N	\N	\N	\N	\N	\N
9170	91	69	EMPTY	\N	\N	\N	\N	\N	\N
9171	91	70	EMPTY	\N	\N	\N	\N	\N	\N
9172	91	71	EMPTY	\N	\N	\N	\N	\N	\N
9173	91	72	VALLEY	\N	\N	\N	\N	Valley (91, 72)	\N
9174	91	73	EMPTY	\N	\N	\N	\N	\N	\N
9175	91	74	EMPTY	\N	\N	\N	\N	\N	\N
9176	91	75	EMPTY	\N	\N	\N	\N	\N	\N
9177	91	76	EMPTY	\N	\N	\N	\N	\N	\N
9178	91	77	EMPTY	\N	\N	\N	\N	\N	\N
9179	91	78	EMPTY	\N	\N	\N	\N	\N	\N
9180	91	79	EMPTY	\N	\N	\N	\N	\N	\N
9181	91	80	EMPTY	\N	\N	\N	\N	\N	\N
9182	91	81	EMPTY	\N	\N	\N	\N	\N	\N
9183	91	82	EMPTY	\N	\N	\N	\N	\N	\N
9184	91	83	EMPTY	\N	\N	\N	\N	\N	\N
9185	91	84	EMPTY	\N	\N	\N	\N	\N	\N
9186	91	85	EMPTY	\N	\N	\N	\N	\N	\N
9187	91	86	EMPTY	\N	\N	\N	\N	\N	\N
9188	91	87	EMPTY	\N	\N	\N	\N	\N	\N
9189	91	88	EMPTY	\N	\N	\N	\N	\N	\N
9190	91	89	EMPTY	\N	\N	\N	\N	\N	\N
9191	91	90	EMPTY	\N	\N	\N	\N	\N	\N
9192	91	91	EMPTY	\N	\N	\N	\N	\N	\N
9193	91	92	EMPTY	\N	\N	\N	\N	\N	\N
9194	91	93	EMPTY	\N	\N	\N	\N	\N	\N
9195	91	94	EMPTY	\N	\N	\N	\N	\N	\N
9196	91	95	RESOURCE	iron	3	\N	\N	\N	\N
9197	91	96	EMPTY	\N	\N	\N	\N	\N	\N
9198	91	97	EMPTY	\N	\N	\N	\N	\N	\N
9199	91	98	EMPTY	\N	\N	\N	\N	\N	\N
9200	91	99	EMPTY	\N	\N	\N	\N	\N	\N
9201	92	0	EMPTY	\N	\N	\N	\N	\N	\N
9202	92	1	EMPTY	\N	\N	\N	\N	\N	\N
9203	92	2	EMPTY	\N	\N	\N	\N	\N	\N
9204	92	3	RESOURCE	wood	4	\N	\N	\N	\N
9205	92	4	EMPTY	\N	\N	\N	\N	\N	\N
9206	92	5	RESOURCE	food	1	\N	\N	\N	\N
9207	92	6	EMPTY	\N	\N	\N	\N	\N	\N
9208	92	7	EMPTY	\N	\N	\N	\N	\N	\N
9209	92	8	EMPTY	\N	\N	\N	\N	\N	\N
9210	92	9	EMPTY	\N	\N	\N	\N	\N	\N
9211	92	10	EMPTY	\N	\N	\N	\N	\N	\N
9212	92	11	EMPTY	\N	\N	\N	\N	\N	\N
9213	92	12	RESOURCE	food	3	\N	\N	\N	\N
9214	92	13	EMPTY	\N	\N	\N	\N	\N	\N
9215	92	14	EMPTY	\N	\N	\N	\N	\N	\N
9216	92	15	NPC	\N	\N	3	\N	Barbarian Camp (Lv 3)	\N
9217	92	16	EMPTY	\N	\N	\N	\N	\N	\N
9218	92	17	EMPTY	\N	\N	\N	\N	\N	\N
9219	92	18	EMPTY	\N	\N	\N	\N	\N	\N
9220	92	19	EMPTY	\N	\N	\N	\N	\N	\N
9221	92	20	EMPTY	\N	\N	\N	\N	\N	\N
9222	92	21	EMPTY	\N	\N	\N	\N	\N	\N
9223	92	22	EMPTY	\N	\N	\N	\N	\N	\N
9224	92	23	EMPTY	\N	\N	\N	\N	\N	\N
9225	92	24	EMPTY	\N	\N	\N	\N	\N	\N
9226	92	25	EMPTY	\N	\N	\N	\N	\N	\N
9227	92	26	EMPTY	\N	\N	\N	\N	\N	\N
9228	92	27	EMPTY	\N	\N	\N	\N	\N	\N
9229	92	28	EMPTY	\N	\N	\N	\N	\N	\N
9230	92	29	EMPTY	\N	\N	\N	\N	\N	\N
9231	92	30	EMPTY	\N	\N	\N	\N	\N	\N
9232	92	31	RESOURCE	stone	4	\N	\N	\N	\N
9233	92	32	EMPTY	\N	\N	\N	\N	\N	\N
9234	92	33	NPC	\N	\N	5	\N	Barbarian Camp (Lv 5)	\N
9235	92	34	EMPTY	\N	\N	\N	\N	\N	\N
9236	92	35	EMPTY	\N	\N	\N	\N	\N	\N
9237	92	36	EMPTY	\N	\N	\N	\N	\N	\N
9238	92	37	VALLEY	\N	\N	\N	\N	Valley (92, 37)	\N
9239	92	38	EMPTY	\N	\N	\N	\N	\N	\N
9240	92	39	EMPTY	\N	\N	\N	\N	\N	\N
9241	92	40	NPC	\N	\N	6	\N	Barbarian Camp (Lv 6)	\N
9242	92	41	EMPTY	\N	\N	\N	\N	\N	\N
9243	92	42	EMPTY	\N	\N	\N	\N	\N	\N
9244	92	43	EMPTY	\N	\N	\N	\N	\N	\N
9245	92	44	EMPTY	\N	\N	\N	\N	\N	\N
9246	92	45	EMPTY	\N	\N	\N	\N	\N	\N
9247	92	46	RESOURCE	stone	5	\N	\N	\N	\N
9248	92	47	EMPTY	\N	\N	\N	\N	\N	\N
9249	92	48	EMPTY	\N	\N	\N	\N	\N	\N
9250	92	49	NPC	\N	\N	1	\N	Barbarian Camp (Lv 1)	\N
9251	92	50	EMPTY	\N	\N	\N	\N	\N	\N
9252	92	51	EMPTY	\N	\N	\N	\N	\N	\N
9253	92	52	EMPTY	\N	\N	\N	\N	\N	\N
9254	92	53	EMPTY	\N	\N	\N	\N	\N	\N
9255	92	54	EMPTY	\N	\N	\N	\N	\N	\N
9256	92	55	EMPTY	\N	\N	\N	\N	\N	\N
9257	92	56	EMPTY	\N	\N	\N	\N	\N	\N
9258	92	57	EMPTY	\N	\N	\N	\N	\N	\N
9259	92	58	EMPTY	\N	\N	\N	\N	\N	\N
9260	92	59	EMPTY	\N	\N	\N	\N	\N	\N
9261	92	60	EMPTY	\N	\N	\N	\N	\N	\N
9262	92	61	EMPTY	\N	\N	\N	\N	\N	\N
9263	92	62	EMPTY	\N	\N	\N	\N	\N	\N
9264	92	63	EMPTY	\N	\N	\N	\N	\N	\N
9265	92	64	EMPTY	\N	\N	\N	\N	\N	\N
9266	92	65	EMPTY	\N	\N	\N	\N	\N	\N
9267	92	66	EMPTY	\N	\N	\N	\N	\N	\N
9268	92	67	EMPTY	\N	\N	\N	\N	\N	\N
9269	92	68	EMPTY	\N	\N	\N	\N	\N	\N
9270	92	69	EMPTY	\N	\N	\N	\N	\N	\N
9271	92	70	EMPTY	\N	\N	\N	\N	\N	\N
9272	92	71	EMPTY	\N	\N	\N	\N	\N	\N
9273	92	72	EMPTY	\N	\N	\N	\N	\N	\N
9274	92	73	EMPTY	\N	\N	\N	\N	\N	\N
9275	92	74	EMPTY	\N	\N	\N	\N	\N	\N
9276	92	75	EMPTY	\N	\N	\N	\N	\N	\N
9277	92	76	NPC	\N	\N	9	\N	Barbarian Camp (Lv 9)	\N
9278	92	77	EMPTY	\N	\N	\N	\N	\N	\N
9279	92	78	VALLEY	\N	\N	\N	\N	Valley (92, 78)	\N
9280	92	79	EMPTY	\N	\N	\N	\N	\N	\N
9281	92	80	EMPTY	\N	\N	\N	\N	\N	\N
9282	92	81	NPC	\N	\N	3	\N	Barbarian Camp (Lv 3)	\N
9283	92	82	EMPTY	\N	\N	\N	\N	\N	\N
9284	92	83	EMPTY	\N	\N	\N	\N	\N	\N
9285	92	84	EMPTY	\N	\N	\N	\N	\N	\N
9286	92	85	EMPTY	\N	\N	\N	\N	\N	\N
9287	92	86	EMPTY	\N	\N	\N	\N	\N	\N
9288	92	87	EMPTY	\N	\N	\N	\N	\N	\N
9289	92	88	EMPTY	\N	\N	\N	\N	\N	\N
9290	92	89	EMPTY	\N	\N	\N	\N	\N	\N
9291	92	90	EMPTY	\N	\N	\N	\N	\N	\N
9292	92	91	EMPTY	\N	\N	\N	\N	\N	\N
9293	92	92	EMPTY	\N	\N	\N	\N	\N	\N
9294	92	93	EMPTY	\N	\N	\N	\N	\N	\N
9295	92	94	EMPTY	\N	\N	\N	\N	\N	\N
9296	92	95	RESOURCE	stone	1	\N	\N	\N	\N
9297	92	96	EMPTY	\N	\N	\N	\N	\N	\N
9298	92	97	EMPTY	\N	\N	\N	\N	\N	\N
9299	92	98	EMPTY	\N	\N	\N	\N	\N	\N
9300	92	99	EMPTY	\N	\N	\N	\N	\N	\N
9301	93	0	EMPTY	\N	\N	\N	\N	\N	\N
9302	93	1	EMPTY	\N	\N	\N	\N	\N	\N
9303	93	2	VALLEY	\N	\N	\N	\N	Valley (93, 2)	\N
9304	93	3	EMPTY	\N	\N	\N	\N	\N	\N
9305	93	4	EMPTY	\N	\N	\N	\N	\N	\N
9306	93	5	NPC	\N	\N	3	\N	Barbarian Camp (Lv 3)	\N
9307	93	6	EMPTY	\N	\N	\N	\N	\N	\N
9308	93	7	EMPTY	\N	\N	\N	\N	\N	\N
9309	93	8	EMPTY	\N	\N	\N	\N	\N	\N
9310	93	9	EMPTY	\N	\N	\N	\N	\N	\N
9311	93	10	EMPTY	\N	\N	\N	\N	\N	\N
9312	93	11	EMPTY	\N	\N	\N	\N	\N	\N
9313	93	12	NPC	\N	\N	5	\N	Barbarian Camp (Lv 5)	\N
9314	93	13	RESOURCE	food	5	\N	\N	\N	\N
9315	93	14	EMPTY	\N	\N	\N	\N	\N	\N
9316	93	15	EMPTY	\N	\N	\N	\N	\N	\N
9317	93	16	EMPTY	\N	\N	\N	\N	\N	\N
9318	93	17	EMPTY	\N	\N	\N	\N	\N	\N
9319	93	18	EMPTY	\N	\N	\N	\N	\N	\N
9320	93	19	EMPTY	\N	\N	\N	\N	\N	\N
9321	93	20	EMPTY	\N	\N	\N	\N	\N	\N
9322	93	21	EMPTY	\N	\N	\N	\N	\N	\N
9323	93	22	EMPTY	\N	\N	\N	\N	\N	\N
9324	93	23	EMPTY	\N	\N	\N	\N	\N	\N
9325	93	24	EMPTY	\N	\N	\N	\N	\N	\N
9326	93	25	EMPTY	\N	\N	\N	\N	\N	\N
9327	93	26	EMPTY	\N	\N	\N	\N	\N	\N
9328	93	27	EMPTY	\N	\N	\N	\N	\N	\N
9329	93	28	EMPTY	\N	\N	\N	\N	\N	\N
9330	93	29	EMPTY	\N	\N	\N	\N	\N	\N
9331	93	30	EMPTY	\N	\N	\N	\N	\N	\N
9332	93	31	EMPTY	\N	\N	\N	\N	\N	\N
9333	93	32	EMPTY	\N	\N	\N	\N	\N	\N
9334	93	33	EMPTY	\N	\N	\N	\N	\N	\N
9335	93	34	EMPTY	\N	\N	\N	\N	\N	\N
9336	93	35	EMPTY	\N	\N	\N	\N	\N	\N
9337	93	36	EMPTY	\N	\N	\N	\N	\N	\N
9338	93	37	RESOURCE	food	3	\N	\N	\N	\N
9339	93	38	EMPTY	\N	\N	\N	\N	\N	\N
9340	93	39	EMPTY	\N	\N	\N	\N	\N	\N
9341	93	40	EMPTY	\N	\N	\N	\N	\N	\N
9342	93	41	RESOURCE	food	3	\N	\N	\N	\N
9343	93	42	EMPTY	\N	\N	\N	\N	\N	\N
9344	93	43	EMPTY	\N	\N	\N	\N	\N	\N
9345	93	44	EMPTY	\N	\N	\N	\N	\N	\N
9346	93	45	EMPTY	\N	\N	\N	\N	\N	\N
9347	93	46	EMPTY	\N	\N	\N	\N	\N	\N
9348	93	47	EMPTY	\N	\N	\N	\N	\N	\N
9349	93	48	EMPTY	\N	\N	\N	\N	\N	\N
9350	93	49	NPC	\N	\N	9	\N	Barbarian Camp (Lv 9)	\N
9351	93	50	VALLEY	\N	\N	\N	\N	Valley (93, 50)	\N
9352	93	51	EMPTY	\N	\N	\N	\N	\N	\N
9353	93	52	EMPTY	\N	\N	\N	\N	\N	\N
9354	93	53	EMPTY	\N	\N	\N	\N	\N	\N
9355	93	54	EMPTY	\N	\N	\N	\N	\N	\N
9356	93	55	EMPTY	\N	\N	\N	\N	\N	\N
9357	93	56	EMPTY	\N	\N	\N	\N	\N	\N
9358	93	57	EMPTY	\N	\N	\N	\N	\N	\N
9359	93	58	EMPTY	\N	\N	\N	\N	\N	\N
9360	93	59	EMPTY	\N	\N	\N	\N	\N	\N
9361	93	60	EMPTY	\N	\N	\N	\N	\N	\N
9362	93	61	NPC	\N	\N	9	\N	Barbarian Camp (Lv 9)	\N
9363	93	62	EMPTY	\N	\N	\N	\N	\N	\N
9364	93	63	EMPTY	\N	\N	\N	\N	\N	\N
9365	93	64	EMPTY	\N	\N	\N	\N	\N	\N
9366	93	65	EMPTY	\N	\N	\N	\N	\N	\N
9367	93	66	EMPTY	\N	\N	\N	\N	\N	\N
9368	93	67	EMPTY	\N	\N	\N	\N	\N	\N
9369	93	68	EMPTY	\N	\N	\N	\N	\N	\N
9370	93	69	EMPTY	\N	\N	\N	\N	\N	\N
9371	93	70	EMPTY	\N	\N	\N	\N	\N	\N
9372	93	71	EMPTY	\N	\N	\N	\N	\N	\N
9373	93	72	RESOURCE	food	1	\N	\N	\N	\N
9374	93	73	EMPTY	\N	\N	\N	\N	\N	\N
9375	93	74	EMPTY	\N	\N	\N	\N	\N	\N
9376	93	75	EMPTY	\N	\N	\N	\N	\N	\N
9377	93	76	EMPTY	\N	\N	\N	\N	\N	\N
9378	93	77	EMPTY	\N	\N	\N	\N	\N	\N
9379	93	78	EMPTY	\N	\N	\N	\N	\N	\N
9380	93	79	EMPTY	\N	\N	\N	\N	\N	\N
9381	93	80	EMPTY	\N	\N	\N	\N	\N	\N
9382	93	81	NPC	\N	\N	10	\N	Barbarian Camp (Lv 10)	\N
9383	93	82	EMPTY	\N	\N	\N	\N	\N	\N
9384	93	83	EMPTY	\N	\N	\N	\N	\N	\N
9385	93	84	EMPTY	\N	\N	\N	\N	\N	\N
9386	93	85	EMPTY	\N	\N	\N	\N	\N	\N
9387	93	86	EMPTY	\N	\N	\N	\N	\N	\N
9388	93	87	EMPTY	\N	\N	\N	\N	\N	\N
9389	93	88	NPC	\N	\N	5	\N	Barbarian Camp (Lv 5)	\N
9390	93	89	EMPTY	\N	\N	\N	\N	\N	\N
9391	93	90	EMPTY	\N	\N	\N	\N	\N	\N
9392	93	91	EMPTY	\N	\N	\N	\N	\N	\N
9393	93	92	EMPTY	\N	\N	\N	\N	\N	\N
9394	93	93	EMPTY	\N	\N	\N	\N	\N	\N
9395	93	94	EMPTY	\N	\N	\N	\N	\N	\N
9396	93	95	EMPTY	\N	\N	\N	\N	\N	\N
9397	93	96	EMPTY	\N	\N	\N	\N	\N	\N
9398	93	97	EMPTY	\N	\N	\N	\N	\N	\N
9399	93	98	EMPTY	\N	\N	\N	\N	\N	\N
9400	93	99	EMPTY	\N	\N	\N	\N	\N	\N
9401	94	0	EMPTY	\N	\N	\N	\N	\N	\N
9402	94	1	VALLEY	\N	\N	\N	\N	Valley (94, 1)	\N
9403	94	2	EMPTY	\N	\N	\N	\N	\N	\N
9404	94	3	EMPTY	\N	\N	\N	\N	\N	\N
9405	94	4	RESOURCE	food	2	\N	\N	\N	\N
9407	94	6	EMPTY	\N	\N	\N	\N	\N	\N
9408	94	7	EMPTY	\N	\N	\N	\N	\N	\N
9409	94	8	EMPTY	\N	\N	\N	\N	\N	\N
9410	94	9	EMPTY	\N	\N	\N	\N	\N	\N
9411	94	10	EMPTY	\N	\N	\N	\N	\N	\N
9412	94	11	EMPTY	\N	\N	\N	\N	\N	\N
9413	94	12	EMPTY	\N	\N	\N	\N	\N	\N
9414	94	13	EMPTY	\N	\N	\N	\N	\N	\N
9415	94	14	EMPTY	\N	\N	\N	\N	\N	\N
9416	94	15	EMPTY	\N	\N	\N	\N	\N	\N
9417	94	16	EMPTY	\N	\N	\N	\N	\N	\N
9418	94	17	EMPTY	\N	\N	\N	\N	\N	\N
9419	94	18	EMPTY	\N	\N	\N	\N	\N	\N
9420	94	19	EMPTY	\N	\N	\N	\N	\N	\N
9421	94	20	EMPTY	\N	\N	\N	\N	\N	\N
9422	94	21	EMPTY	\N	\N	\N	\N	\N	\N
9423	94	22	EMPTY	\N	\N	\N	\N	\N	\N
9424	94	23	EMPTY	\N	\N	\N	\N	\N	\N
9425	94	24	EMPTY	\N	\N	\N	\N	\N	\N
9426	94	25	EMPTY	\N	\N	\N	\N	\N	\N
9427	94	26	EMPTY	\N	\N	\N	\N	\N	\N
9428	94	27	EMPTY	\N	\N	\N	\N	\N	\N
9429	94	28	EMPTY	\N	\N	\N	\N	\N	\N
9430	94	29	EMPTY	\N	\N	\N	\N	\N	\N
9431	94	30	EMPTY	\N	\N	\N	\N	\N	\N
9432	94	31	EMPTY	\N	\N	\N	\N	\N	\N
9433	94	32	VALLEY	\N	\N	\N	\N	Valley (94, 32)	\N
9434	94	33	EMPTY	\N	\N	\N	\N	\N	\N
9435	94	34	EMPTY	\N	\N	\N	\N	\N	\N
9436	94	35	EMPTY	\N	\N	\N	\N	\N	\N
9437	94	36	EMPTY	\N	\N	\N	\N	\N	\N
9438	94	37	EMPTY	\N	\N	\N	\N	\N	\N
9439	94	38	EMPTY	\N	\N	\N	\N	\N	\N
9440	94	39	EMPTY	\N	\N	\N	\N	\N	\N
9441	94	40	EMPTY	\N	\N	\N	\N	\N	\N
9442	94	41	NPC	\N	\N	6	\N	Barbarian Camp (Lv 6)	\N
9443	94	42	EMPTY	\N	\N	\N	\N	\N	\N
9444	94	43	EMPTY	\N	\N	\N	\N	\N	\N
9445	94	44	EMPTY	\N	\N	\N	\N	\N	\N
9446	94	45	EMPTY	\N	\N	\N	\N	\N	\N
9447	94	46	EMPTY	\N	\N	\N	\N	\N	\N
9448	94	47	EMPTY	\N	\N	\N	\N	\N	\N
9449	94	48	EMPTY	\N	\N	\N	\N	\N	\N
9450	94	49	EMPTY	\N	\N	\N	\N	\N	\N
9451	94	50	EMPTY	\N	\N	\N	\N	\N	\N
9452	94	51	EMPTY	\N	\N	\N	\N	\N	\N
9453	94	52	EMPTY	\N	\N	\N	\N	\N	\N
9454	94	53	EMPTY	\N	\N	\N	\N	\N	\N
9455	94	54	NPC	\N	\N	8	\N	Barbarian Camp (Lv 8)	\N
9456	94	55	EMPTY	\N	\N	\N	\N	\N	\N
9457	94	56	EMPTY	\N	\N	\N	\N	\N	\N
9458	94	57	EMPTY	\N	\N	\N	\N	\N	\N
9459	94	58	EMPTY	\N	\N	\N	\N	\N	\N
9460	94	59	EMPTY	\N	\N	\N	\N	\N	\N
9461	94	60	EMPTY	\N	\N	\N	\N	\N	\N
9462	94	61	EMPTY	\N	\N	\N	\N	\N	\N
9463	94	62	EMPTY	\N	\N	\N	\N	\N	\N
9464	94	63	EMPTY	\N	\N	\N	\N	\N	\N
9465	94	64	EMPTY	\N	\N	\N	\N	\N	\N
9466	94	65	EMPTY	\N	\N	\N	\N	\N	\N
9467	94	66	EMPTY	\N	\N	\N	\N	\N	\N
9468	94	67	EMPTY	\N	\N	\N	\N	\N	\N
9469	94	68	EMPTY	\N	\N	\N	\N	\N	\N
9470	94	69	RESOURCE	wood	5	\N	\N	\N	\N
9471	94	70	EMPTY	\N	\N	\N	\N	\N	\N
9472	94	71	EMPTY	\N	\N	\N	\N	\N	\N
9473	94	72	EMPTY	\N	\N	\N	\N	\N	\N
9474	94	73	EMPTY	\N	\N	\N	\N	\N	\N
9475	94	74	EMPTY	\N	\N	\N	\N	\N	\N
9476	94	75	EMPTY	\N	\N	\N	\N	\N	\N
9477	94	76	EMPTY	\N	\N	\N	\N	\N	\N
9478	94	77	VALLEY	\N	\N	\N	\N	Valley (94, 77)	\N
9479	94	78	EMPTY	\N	\N	\N	\N	\N	\N
9480	94	79	EMPTY	\N	\N	\N	\N	\N	\N
9481	94	80	EMPTY	\N	\N	\N	\N	\N	\N
9482	94	81	EMPTY	\N	\N	\N	\N	\N	\N
9483	94	82	EMPTY	\N	\N	\N	\N	\N	\N
9484	94	83	EMPTY	\N	\N	\N	\N	\N	\N
9485	94	84	EMPTY	\N	\N	\N	\N	\N	\N
9486	94	85	EMPTY	\N	\N	\N	\N	\N	\N
9487	94	86	EMPTY	\N	\N	\N	\N	\N	\N
9488	94	87	EMPTY	\N	\N	\N	\N	\N	\N
9489	94	88	EMPTY	\N	\N	\N	\N	\N	\N
9490	94	89	EMPTY	\N	\N	\N	\N	\N	\N
9491	94	90	EMPTY	\N	\N	\N	\N	\N	\N
9492	94	91	EMPTY	\N	\N	\N	\N	\N	\N
9493	94	92	NPC	\N	\N	4	\N	Barbarian Camp (Lv 4)	\N
9494	94	93	EMPTY	\N	\N	\N	\N	\N	\N
9495	94	94	NPC	\N	\N	10	\N	Barbarian Camp (Lv 10)	\N
9496	94	95	EMPTY	\N	\N	\N	\N	\N	\N
9497	94	96	EMPTY	\N	\N	\N	\N	\N	\N
9498	94	97	EMPTY	\N	\N	\N	\N	\N	\N
9499	94	98	EMPTY	\N	\N	\N	\N	\N	\N
9500	94	99	EMPTY	\N	\N	\N	\N	\N	\N
9501	95	0	NPC	\N	\N	5	\N	Barbarian Camp (Lv 5)	\N
9502	95	1	EMPTY	\N	\N	\N	\N	\N	\N
9503	95	2	EMPTY	\N	\N	\N	\N	\N	\N
9504	95	3	EMPTY	\N	\N	\N	\N	\N	\N
9505	95	4	EMPTY	\N	\N	\N	\N	\N	\N
9506	95	5	EMPTY	\N	\N	\N	\N	\N	\N
9507	95	6	EMPTY	\N	\N	\N	\N	\N	\N
9508	95	7	EMPTY	\N	\N	\N	\N	\N	\N
9509	95	8	EMPTY	\N	\N	\N	\N	\N	\N
9510	95	9	RESOURCE	food	1	\N	\N	\N	\N
9511	95	10	EMPTY	\N	\N	\N	\N	\N	\N
9512	95	11	EMPTY	\N	\N	\N	\N	\N	\N
9513	95	12	RESOURCE	iron	5	\N	\N	\N	\N
9514	95	13	EMPTY	\N	\N	\N	\N	\N	\N
9515	95	14	EMPTY	\N	\N	\N	\N	\N	\N
9516	95	15	EMPTY	\N	\N	\N	\N	\N	\N
9517	95	16	EMPTY	\N	\N	\N	\N	\N	\N
9518	95	17	EMPTY	\N	\N	\N	\N	\N	\N
9519	95	18	EMPTY	\N	\N	\N	\N	\N	\N
9520	95	19	EMPTY	\N	\N	\N	\N	\N	\N
9521	95	20	EMPTY	\N	\N	\N	\N	\N	\N
9522	95	21	EMPTY	\N	\N	\N	\N	\N	\N
9523	95	22	EMPTY	\N	\N	\N	\N	\N	\N
9524	95	23	EMPTY	\N	\N	\N	\N	\N	\N
9525	95	24	EMPTY	\N	\N	\N	\N	\N	\N
9526	95	25	NPC	\N	\N	3	\N	Barbarian Camp (Lv 3)	\N
9527	95	26	EMPTY	\N	\N	\N	\N	\N	\N
9528	95	27	EMPTY	\N	\N	\N	\N	\N	\N
9529	95	28	EMPTY	\N	\N	\N	\N	\N	\N
9530	95	29	EMPTY	\N	\N	\N	\N	\N	\N
9531	95	30	VALLEY	\N	\N	\N	\N	Valley (95, 30)	\N
9532	95	31	EMPTY	\N	\N	\N	\N	\N	\N
9533	95	32	EMPTY	\N	\N	\N	\N	\N	\N
9534	95	33	EMPTY	\N	\N	\N	\N	\N	\N
9535	95	34	EMPTY	\N	\N	\N	\N	\N	\N
9536	95	35	EMPTY	\N	\N	\N	\N	\N	\N
9537	95	36	EMPTY	\N	\N	\N	\N	\N	\N
9538	95	37	RESOURCE	wood	2	\N	\N	\N	\N
9539	95	38	EMPTY	\N	\N	\N	\N	\N	\N
9540	95	39	EMPTY	\N	\N	\N	\N	\N	\N
9541	95	40	EMPTY	\N	\N	\N	\N	\N	\N
9542	95	41	EMPTY	\N	\N	\N	\N	\N	\N
9543	95	42	EMPTY	\N	\N	\N	\N	\N	\N
9544	95	43	EMPTY	\N	\N	\N	\N	\N	\N
9545	95	44	EMPTY	\N	\N	\N	\N	\N	\N
9546	95	45	EMPTY	\N	\N	\N	\N	\N	\N
9547	95	46	EMPTY	\N	\N	\N	\N	\N	\N
9548	95	47	EMPTY	\N	\N	\N	\N	\N	\N
9549	95	48	EMPTY	\N	\N	\N	\N	\N	\N
9550	95	49	EMPTY	\N	\N	\N	\N	\N	\N
9551	95	50	EMPTY	\N	\N	\N	\N	\N	\N
9552	95	51	EMPTY	\N	\N	\N	\N	\N	\N
9553	95	52	RESOURCE	stone	5	\N	\N	\N	\N
9554	95	53	EMPTY	\N	\N	\N	\N	\N	\N
9555	95	54	EMPTY	\N	\N	\N	\N	\N	\N
9556	95	55	EMPTY	\N	\N	\N	\N	\N	\N
9557	95	56	EMPTY	\N	\N	\N	\N	\N	\N
9558	95	57	EMPTY	\N	\N	\N	\N	\N	\N
9559	95	58	RESOURCE	stone	5	\N	\N	\N	\N
9560	95	59	EMPTY	\N	\N	\N	\N	\N	\N
9561	95	60	EMPTY	\N	\N	\N	\N	\N	\N
9562	95	61	EMPTY	\N	\N	\N	\N	\N	\N
9563	95	62	EMPTY	\N	\N	\N	\N	\N	\N
9564	95	63	EMPTY	\N	\N	\N	\N	\N	\N
9565	95	64	RESOURCE	stone	2	\N	\N	\N	\N
9566	95	65	EMPTY	\N	\N	\N	\N	\N	\N
9567	95	66	VALLEY	\N	\N	\N	\N	Valley (95, 66)	\N
9568	95	67	EMPTY	\N	\N	\N	\N	\N	\N
9569	95	68	EMPTY	\N	\N	\N	\N	\N	\N
9570	95	69	EMPTY	\N	\N	\N	\N	\N	\N
9571	95	70	EMPTY	\N	\N	\N	\N	\N	\N
9572	95	71	EMPTY	\N	\N	\N	\N	\N	\N
9573	95	72	EMPTY	\N	\N	\N	\N	\N	\N
9574	95	73	EMPTY	\N	\N	\N	\N	\N	\N
9575	95	74	EMPTY	\N	\N	\N	\N	\N	\N
9576	95	75	EMPTY	\N	\N	\N	\N	\N	\N
9577	95	76	EMPTY	\N	\N	\N	\N	\N	\N
9578	95	77	RESOURCE	food	2	\N	\N	\N	\N
9579	95	78	EMPTY	\N	\N	\N	\N	\N	\N
9580	95	79	EMPTY	\N	\N	\N	\N	\N	\N
9581	95	80	EMPTY	\N	\N	\N	\N	\N	\N
9582	95	81	EMPTY	\N	\N	\N	\N	\N	\N
9583	95	82	EMPTY	\N	\N	\N	\N	\N	\N
9584	95	83	EMPTY	\N	\N	\N	\N	\N	\N
9585	95	84	EMPTY	\N	\N	\N	\N	\N	\N
9586	95	85	EMPTY	\N	\N	\N	\N	\N	\N
9587	95	86	EMPTY	\N	\N	\N	\N	\N	\N
9588	95	87	EMPTY	\N	\N	\N	\N	\N	\N
9589	95	88	EMPTY	\N	\N	\N	\N	\N	\N
9590	95	89	EMPTY	\N	\N	\N	\N	\N	\N
9591	95	90	EMPTY	\N	\N	\N	\N	\N	\N
9592	95	91	EMPTY	\N	\N	\N	\N	\N	\N
9593	95	92	EMPTY	\N	\N	\N	\N	\N	\N
9594	95	93	EMPTY	\N	\N	\N	\N	\N	\N
9595	95	94	RESOURCE	iron	5	\N	\N	\N	\N
9596	95	95	EMPTY	\N	\N	\N	\N	\N	\N
9597	95	96	EMPTY	\N	\N	\N	\N	\N	\N
9598	95	97	EMPTY	\N	\N	\N	\N	\N	\N
9599	95	98	EMPTY	\N	\N	\N	\N	\N	\N
9600	95	99	EMPTY	\N	\N	\N	\N	\N	\N
9601	96	0	RESOURCE	wood	1	\N	\N	\N	\N
9602	96	1	EMPTY	\N	\N	\N	\N	\N	\N
9603	96	2	EMPTY	\N	\N	\N	\N	\N	\N
9604	96	3	EMPTY	\N	\N	\N	\N	\N	\N
9605	96	4	EMPTY	\N	\N	\N	\N	\N	\N
9606	96	5	RESOURCE	stone	2	\N	\N	\N	\N
9607	96	6	EMPTY	\N	\N	\N	\N	\N	\N
9608	96	7	EMPTY	\N	\N	\N	\N	\N	\N
9609	96	8	EMPTY	\N	\N	\N	\N	\N	\N
9610	96	9	NPC	\N	\N	6	\N	Barbarian Camp (Lv 6)	\N
9611	96	10	RESOURCE	wood	4	\N	\N	\N	\N
9612	96	11	RESOURCE	wood	4	\N	\N	\N	\N
9613	96	12	VALLEY	\N	\N	\N	\N	Valley (96, 12)	\N
9614	96	13	EMPTY	\N	\N	\N	\N	\N	\N
9615	96	14	RESOURCE	stone	5	\N	\N	\N	\N
9616	96	15	EMPTY	\N	\N	\N	\N	\N	\N
9617	96	16	EMPTY	\N	\N	\N	\N	\N	\N
9618	96	17	EMPTY	\N	\N	\N	\N	\N	\N
9619	96	18	EMPTY	\N	\N	\N	\N	\N	\N
9620	96	19	EMPTY	\N	\N	\N	\N	\N	\N
9621	96	20	EMPTY	\N	\N	\N	\N	\N	\N
9622	96	21	EMPTY	\N	\N	\N	\N	\N	\N
9623	96	22	EMPTY	\N	\N	\N	\N	\N	\N
9624	96	23	EMPTY	\N	\N	\N	\N	\N	\N
9625	96	24	EMPTY	\N	\N	\N	\N	\N	\N
9626	96	25	EMPTY	\N	\N	\N	\N	\N	\N
9627	96	26	EMPTY	\N	\N	\N	\N	\N	\N
9628	96	27	EMPTY	\N	\N	\N	\N	\N	\N
9629	96	28	EMPTY	\N	\N	\N	\N	\N	\N
9630	96	29	EMPTY	\N	\N	\N	\N	\N	\N
9631	96	30	EMPTY	\N	\N	\N	\N	\N	\N
9632	96	31	EMPTY	\N	\N	\N	\N	\N	\N
9633	96	32	EMPTY	\N	\N	\N	\N	\N	\N
9634	96	33	EMPTY	\N	\N	\N	\N	\N	\N
9635	96	34	EMPTY	\N	\N	\N	\N	\N	\N
9636	96	35	EMPTY	\N	\N	\N	\N	\N	\N
9637	96	36	EMPTY	\N	\N	\N	\N	\N	\N
9638	96	37	EMPTY	\N	\N	\N	\N	\N	\N
9639	96	38	EMPTY	\N	\N	\N	\N	\N	\N
9640	96	39	EMPTY	\N	\N	\N	\N	\N	\N
9641	96	40	VALLEY	\N	\N	\N	\N	Valley (96, 40)	\N
9642	96	41	RESOURCE	wood	3	\N	\N	\N	\N
9643	96	42	EMPTY	\N	\N	\N	\N	\N	\N
9644	96	43	EMPTY	\N	\N	\N	\N	\N	\N
9645	96	44	EMPTY	\N	\N	\N	\N	\N	\N
9646	96	45	EMPTY	\N	\N	\N	\N	\N	\N
9647	96	46	NPC	\N	\N	5	\N	Barbarian Camp (Lv 5)	\N
9648	96	47	RESOURCE	wood	3	\N	\N	\N	\N
9649	96	48	EMPTY	\N	\N	\N	\N	\N	\N
9650	96	49	EMPTY	\N	\N	\N	\N	\N	\N
9651	96	50	EMPTY	\N	\N	\N	\N	\N	\N
9652	96	51	EMPTY	\N	\N	\N	\N	\N	\N
9653	96	52	EMPTY	\N	\N	\N	\N	\N	\N
9654	96	53	EMPTY	\N	\N	\N	\N	\N	\N
9655	96	54	EMPTY	\N	\N	\N	\N	\N	\N
9656	96	55	EMPTY	\N	\N	\N	\N	\N	\N
9657	96	56	EMPTY	\N	\N	\N	\N	\N	\N
9658	96	57	EMPTY	\N	\N	\N	\N	\N	\N
9659	96	58	EMPTY	\N	\N	\N	\N	\N	\N
9660	96	59	EMPTY	\N	\N	\N	\N	\N	\N
9661	96	60	EMPTY	\N	\N	\N	\N	\N	\N
9662	96	61	EMPTY	\N	\N	\N	\N	\N	\N
9663	96	62	EMPTY	\N	\N	\N	\N	\N	\N
9664	96	63	EMPTY	\N	\N	\N	\N	\N	\N
9665	96	64	EMPTY	\N	\N	\N	\N	\N	\N
9666	96	65	EMPTY	\N	\N	\N	\N	\N	\N
9667	96	66	RESOURCE	wood	2	\N	\N	\N	\N
9668	96	67	EMPTY	\N	\N	\N	\N	\N	\N
9669	96	68	EMPTY	\N	\N	\N	\N	\N	\N
9670	96	69	EMPTY	\N	\N	\N	\N	\N	\N
9671	96	70	EMPTY	\N	\N	\N	\N	\N	\N
9672	96	71	EMPTY	\N	\N	\N	\N	\N	\N
9673	96	72	EMPTY	\N	\N	\N	\N	\N	\N
9674	96	73	EMPTY	\N	\N	\N	\N	\N	\N
9675	96	74	EMPTY	\N	\N	\N	\N	\N	\N
9676	96	75	EMPTY	\N	\N	\N	\N	\N	\N
9677	96	76	EMPTY	\N	\N	\N	\N	\N	\N
9678	96	77	RESOURCE	iron	5	\N	\N	\N	\N
9679	96	78	EMPTY	\N	\N	\N	\N	\N	\N
9680	96	79	EMPTY	\N	\N	\N	\N	\N	\N
9681	96	80	EMPTY	\N	\N	\N	\N	\N	\N
9682	96	81	EMPTY	\N	\N	\N	\N	\N	\N
9683	96	82	RESOURCE	stone	5	\N	\N	\N	\N
9684	96	83	EMPTY	\N	\N	\N	\N	\N	\N
9685	96	84	EMPTY	\N	\N	\N	\N	\N	\N
9686	96	85	EMPTY	\N	\N	\N	\N	\N	\N
9687	96	86	EMPTY	\N	\N	\N	\N	\N	\N
9688	96	87	EMPTY	\N	\N	\N	\N	\N	\N
9689	96	88	EMPTY	\N	\N	\N	\N	\N	\N
9690	96	89	EMPTY	\N	\N	\N	\N	\N	\N
9691	96	90	EMPTY	\N	\N	\N	\N	\N	\N
9692	96	91	EMPTY	\N	\N	\N	\N	\N	\N
9693	96	92	EMPTY	\N	\N	\N	\N	\N	\N
9694	96	93	EMPTY	\N	\N	\N	\N	\N	\N
9695	96	94	RESOURCE	food	3	\N	\N	\N	\N
9696	96	95	EMPTY	\N	\N	\N	\N	\N	\N
9697	96	96	RESOURCE	wood	1	\N	\N	\N	\N
9698	96	97	RESOURCE	wood	2	\N	\N	\N	\N
9699	96	98	EMPTY	\N	\N	\N	\N	\N	\N
9700	96	99	EMPTY	\N	\N	\N	\N	\N	\N
9701	97	0	EMPTY	\N	\N	\N	\N	\N	\N
9702	97	1	EMPTY	\N	\N	\N	\N	\N	\N
9703	97	2	EMPTY	\N	\N	\N	\N	\N	\N
9704	97	3	RESOURCE	wood	3	\N	\N	\N	\N
9705	97	4	EMPTY	\N	\N	\N	\N	\N	\N
9706	97	5	NPC	\N	\N	2	\N	Barbarian Camp (Lv 2)	\N
9707	97	6	EMPTY	\N	\N	\N	\N	\N	\N
9708	97	7	EMPTY	\N	\N	\N	\N	\N	\N
9709	97	8	EMPTY	\N	\N	\N	\N	\N	\N
9710	97	9	EMPTY	\N	\N	\N	\N	\N	\N
9711	97	10	EMPTY	\N	\N	\N	\N	\N	\N
9712	97	11	EMPTY	\N	\N	\N	\N	\N	\N
9713	97	12	NPC	\N	\N	5	\N	Barbarian Camp (Lv 5)	\N
9714	97	13	EMPTY	\N	\N	\N	\N	\N	\N
9715	97	14	EMPTY	\N	\N	\N	\N	\N	\N
9716	97	15	EMPTY	\N	\N	\N	\N	\N	\N
9717	97	16	EMPTY	\N	\N	\N	\N	\N	\N
9718	97	17	EMPTY	\N	\N	\N	\N	\N	\N
9719	97	18	EMPTY	\N	\N	\N	\N	\N	\N
9720	97	19	EMPTY	\N	\N	\N	\N	\N	\N
9721	97	20	EMPTY	\N	\N	\N	\N	\N	\N
9722	97	21	EMPTY	\N	\N	\N	\N	\N	\N
9723	97	22	EMPTY	\N	\N	\N	\N	\N	\N
9724	97	23	EMPTY	\N	\N	\N	\N	\N	\N
9725	97	24	EMPTY	\N	\N	\N	\N	\N	\N
9726	97	25	EMPTY	\N	\N	\N	\N	\N	\N
9727	97	26	EMPTY	\N	\N	\N	\N	\N	\N
9728	97	27	EMPTY	\N	\N	\N	\N	\N	\N
9729	97	28	EMPTY	\N	\N	\N	\N	\N	\N
9730	97	29	EMPTY	\N	\N	\N	\N	\N	\N
9731	97	30	EMPTY	\N	\N	\N	\N	\N	\N
9732	97	31	EMPTY	\N	\N	\N	\N	\N	\N
9733	97	32	EMPTY	\N	\N	\N	\N	\N	\N
9734	97	33	EMPTY	\N	\N	\N	\N	\N	\N
9735	97	34	RESOURCE	food	5	\N	\N	\N	\N
9736	97	35	EMPTY	\N	\N	\N	\N	\N	\N
9737	97	36	EMPTY	\N	\N	\N	\N	\N	\N
9738	97	37	EMPTY	\N	\N	\N	\N	\N	\N
9739	97	38	EMPTY	\N	\N	\N	\N	\N	\N
9740	97	39	NPC	\N	\N	8	\N	Barbarian Camp (Lv 8)	\N
9741	97	40	EMPTY	\N	\N	\N	\N	\N	\N
9742	97	41	RESOURCE	stone	5	\N	\N	\N	\N
9743	97	42	EMPTY	\N	\N	\N	\N	\N	\N
9744	97	43	EMPTY	\N	\N	\N	\N	\N	\N
9745	97	44	RESOURCE	iron	5	\N	\N	\N	\N
9746	97	45	EMPTY	\N	\N	\N	\N	\N	\N
9747	97	46	EMPTY	\N	\N	\N	\N	\N	\N
9748	97	47	EMPTY	\N	\N	\N	\N	\N	\N
9749	97	48	EMPTY	\N	\N	\N	\N	\N	\N
9750	97	49	EMPTY	\N	\N	\N	\N	\N	\N
9751	97	50	EMPTY	\N	\N	\N	\N	\N	\N
9752	97	51	EMPTY	\N	\N	\N	\N	\N	\N
9753	97	52	EMPTY	\N	\N	\N	\N	\N	\N
9754	97	53	EMPTY	\N	\N	\N	\N	\N	\N
9755	97	54	EMPTY	\N	\N	\N	\N	\N	\N
9756	97	55	RESOURCE	food	4	\N	\N	\N	\N
9757	97	56	EMPTY	\N	\N	\N	\N	\N	\N
9758	97	57	EMPTY	\N	\N	\N	\N	\N	\N
9759	97	58	VALLEY	\N	\N	\N	\N	Valley (97, 58)	\N
9760	97	59	EMPTY	\N	\N	\N	\N	\N	\N
9761	97	60	VALLEY	\N	\N	\N	\N	Valley (97, 60)	\N
9762	97	61	EMPTY	\N	\N	\N	\N	\N	\N
9763	97	62	EMPTY	\N	\N	\N	\N	\N	\N
9764	97	63	RESOURCE	food	2	\N	\N	\N	\N
9765	97	64	EMPTY	\N	\N	\N	\N	\N	\N
9766	97	65	EMPTY	\N	\N	\N	\N	\N	\N
9767	97	66	EMPTY	\N	\N	\N	\N	\N	\N
9768	97	67	RESOURCE	iron	5	\N	\N	\N	\N
9769	97	68	EMPTY	\N	\N	\N	\N	\N	\N
9770	97	69	EMPTY	\N	\N	\N	\N	\N	\N
9771	97	70	EMPTY	\N	\N	\N	\N	\N	\N
9772	97	71	EMPTY	\N	\N	\N	\N	\N	\N
9773	97	72	EMPTY	\N	\N	\N	\N	\N	\N
9774	97	73	EMPTY	\N	\N	\N	\N	\N	\N
9775	97	74	EMPTY	\N	\N	\N	\N	\N	\N
9776	97	75	RESOURCE	food	5	\N	\N	\N	\N
9777	97	76	EMPTY	\N	\N	\N	\N	\N	\N
9778	97	77	EMPTY	\N	\N	\N	\N	\N	\N
9779	97	78	EMPTY	\N	\N	\N	\N	\N	\N
9780	97	79	VALLEY	\N	\N	\N	\N	Valley (97, 79)	\N
9781	97	80	EMPTY	\N	\N	\N	\N	\N	\N
9782	97	81	EMPTY	\N	\N	\N	\N	\N	\N
9783	97	82	NPC	\N	\N	7	\N	Barbarian Camp (Lv 7)	\N
9784	97	83	EMPTY	\N	\N	\N	\N	\N	\N
9785	97	84	EMPTY	\N	\N	\N	\N	\N	\N
9786	97	85	EMPTY	\N	\N	\N	\N	\N	\N
9787	97	86	EMPTY	\N	\N	\N	\N	\N	\N
9788	97	87	RESOURCE	iron	4	\N	\N	\N	\N
9789	97	88	NPC	\N	\N	6	\N	Barbarian Camp (Lv 6)	\N
9790	97	89	EMPTY	\N	\N	\N	\N	\N	\N
9791	97	90	RESOURCE	iron	1	\N	\N	\N	\N
9792	97	91	EMPTY	\N	\N	\N	\N	\N	\N
9793	97	92	EMPTY	\N	\N	\N	\N	\N	\N
9794	97	93	NPC	\N	\N	10	\N	Barbarian Camp (Lv 10)	\N
9795	97	94	EMPTY	\N	\N	\N	\N	\N	\N
9796	97	95	EMPTY	\N	\N	\N	\N	\N	\N
9797	97	96	EMPTY	\N	\N	\N	\N	\N	\N
9798	97	97	EMPTY	\N	\N	\N	\N	\N	\N
9799	97	98	EMPTY	\N	\N	\N	\N	\N	\N
9800	97	99	EMPTY	\N	\N	\N	\N	\N	\N
9801	98	0	EMPTY	\N	\N	\N	\N	\N	\N
9802	98	1	EMPTY	\N	\N	\N	\N	\N	\N
9803	98	2	EMPTY	\N	\N	\N	\N	\N	\N
9804	98	3	EMPTY	\N	\N	\N	\N	\N	\N
9805	98	4	RESOURCE	food	4	\N	\N	\N	\N
9806	98	5	EMPTY	\N	\N	\N	\N	\N	\N
9807	98	6	EMPTY	\N	\N	\N	\N	\N	\N
9808	98	7	EMPTY	\N	\N	\N	\N	\N	\N
9809	98	8	EMPTY	\N	\N	\N	\N	\N	\N
9810	98	9	EMPTY	\N	\N	\N	\N	\N	\N
9811	98	10	EMPTY	\N	\N	\N	\N	\N	\N
9812	98	11	EMPTY	\N	\N	\N	\N	\N	\N
9813	98	12	EMPTY	\N	\N	\N	\N	\N	\N
9814	98	13	EMPTY	\N	\N	\N	\N	\N	\N
9815	98	14	EMPTY	\N	\N	\N	\N	\N	\N
9816	98	15	EMPTY	\N	\N	\N	\N	\N	\N
9817	98	16	EMPTY	\N	\N	\N	\N	\N	\N
9818	98	17	EMPTY	\N	\N	\N	\N	\N	\N
9819	98	18	EMPTY	\N	\N	\N	\N	\N	\N
9820	98	19	EMPTY	\N	\N	\N	\N	\N	\N
9821	98	20	EMPTY	\N	\N	\N	\N	\N	\N
9822	98	21	EMPTY	\N	\N	\N	\N	\N	\N
9823	98	22	EMPTY	\N	\N	\N	\N	\N	\N
9824	98	23	EMPTY	\N	\N	\N	\N	\N	\N
9825	98	24	RESOURCE	wood	2	\N	\N	\N	\N
9826	98	25	EMPTY	\N	\N	\N	\N	\N	\N
9827	98	26	EMPTY	\N	\N	\N	\N	\N	\N
9828	98	27	EMPTY	\N	\N	\N	\N	\N	\N
9829	98	28	EMPTY	\N	\N	\N	\N	\N	\N
9830	98	29	EMPTY	\N	\N	\N	\N	\N	\N
9831	98	30	EMPTY	\N	\N	\N	\N	\N	\N
9832	98	31	EMPTY	\N	\N	\N	\N	\N	\N
9833	98	32	EMPTY	\N	\N	\N	\N	\N	\N
9834	98	33	EMPTY	\N	\N	\N	\N	\N	\N
9835	98	34	EMPTY	\N	\N	\N	\N	\N	\N
9836	98	35	EMPTY	\N	\N	\N	\N	\N	\N
9837	98	36	EMPTY	\N	\N	\N	\N	\N	\N
9838	98	37	EMPTY	\N	\N	\N	\N	\N	\N
9839	98	38	EMPTY	\N	\N	\N	\N	\N	\N
9840	98	39	EMPTY	\N	\N	\N	\N	\N	\N
9841	98	40	EMPTY	\N	\N	\N	\N	\N	\N
9842	98	41	EMPTY	\N	\N	\N	\N	\N	\N
9843	98	42	RESOURCE	iron	1	\N	\N	\N	\N
9844	98	43	EMPTY	\N	\N	\N	\N	\N	\N
9845	98	44	RESOURCE	stone	1	\N	\N	\N	\N
9846	98	45	RESOURCE	stone	2	\N	\N	\N	\N
9847	98	46	EMPTY	\N	\N	\N	\N	\N	\N
9848	98	47	EMPTY	\N	\N	\N	\N	\N	\N
9849	98	48	NPC	\N	\N	8	\N	Barbarian Camp (Lv 8)	\N
9850	98	49	EMPTY	\N	\N	\N	\N	\N	\N
9851	98	50	EMPTY	\N	\N	\N	\N	\N	\N
9852	98	51	EMPTY	\N	\N	\N	\N	\N	\N
9853	98	52	EMPTY	\N	\N	\N	\N	\N	\N
9854	98	53	EMPTY	\N	\N	\N	\N	\N	\N
9855	98	54	RESOURCE	food	1	\N	\N	\N	\N
9856	98	55	EMPTY	\N	\N	\N	\N	\N	\N
9857	98	56	EMPTY	\N	\N	\N	\N	\N	\N
9858	98	57	EMPTY	\N	\N	\N	\N	\N	\N
9859	98	58	EMPTY	\N	\N	\N	\N	\N	\N
9860	98	59	EMPTY	\N	\N	\N	\N	\N	\N
9861	98	60	EMPTY	\N	\N	\N	\N	\N	\N
9862	98	61	EMPTY	\N	\N	\N	\N	\N	\N
9863	98	62	EMPTY	\N	\N	\N	\N	\N	\N
9864	98	63	EMPTY	\N	\N	\N	\N	\N	\N
9865	98	64	EMPTY	\N	\N	\N	\N	\N	\N
9866	98	65	EMPTY	\N	\N	\N	\N	\N	\N
9867	98	66	EMPTY	\N	\N	\N	\N	\N	\N
9868	98	67	NPC	\N	\N	1	\N	Barbarian Camp (Lv 1)	\N
9869	98	68	EMPTY	\N	\N	\N	\N	\N	\N
9870	98	69	EMPTY	\N	\N	\N	\N	\N	\N
9871	98	70	EMPTY	\N	\N	\N	\N	\N	\N
9872	98	71	EMPTY	\N	\N	\N	\N	\N	\N
9873	98	72	EMPTY	\N	\N	\N	\N	\N	\N
9874	98	73	EMPTY	\N	\N	\N	\N	\N	\N
9875	98	74	EMPTY	\N	\N	\N	\N	\N	\N
9876	98	75	EMPTY	\N	\N	\N	\N	\N	\N
9877	98	76	EMPTY	\N	\N	\N	\N	\N	\N
9878	98	77	RESOURCE	food	2	\N	\N	\N	\N
9879	98	78	EMPTY	\N	\N	\N	\N	\N	\N
9880	98	79	EMPTY	\N	\N	\N	\N	\N	\N
9881	98	80	EMPTY	\N	\N	\N	\N	\N	\N
9882	98	81	EMPTY	\N	\N	\N	\N	\N	\N
9883	98	82	RESOURCE	iron	5	\N	\N	\N	\N
9884	98	83	EMPTY	\N	\N	\N	\N	\N	\N
9885	98	84	EMPTY	\N	\N	\N	\N	\N	\N
9886	98	85	EMPTY	\N	\N	\N	\N	\N	\N
9887	98	86	EMPTY	\N	\N	\N	\N	\N	\N
9888	98	87	EMPTY	\N	\N	\N	\N	\N	\N
9889	98	88	RESOURCE	stone	4	\N	\N	\N	\N
9890	98	89	EMPTY	\N	\N	\N	\N	\N	\N
9891	98	90	RESOURCE	food	4	\N	\N	\N	\N
9892	98	91	EMPTY	\N	\N	\N	\N	\N	\N
9893	98	92	EMPTY	\N	\N	\N	\N	\N	\N
9894	98	93	EMPTY	\N	\N	\N	\N	\N	\N
9895	98	94	EMPTY	\N	\N	\N	\N	\N	\N
9896	98	95	EMPTY	\N	\N	\N	\N	\N	\N
9897	98	96	EMPTY	\N	\N	\N	\N	\N	\N
9898	98	97	EMPTY	\N	\N	\N	\N	\N	\N
9899	98	98	EMPTY	\N	\N	\N	\N	\N	\N
9900	98	99	NPC	\N	\N	9	\N	Barbarian Camp (Lv 9)	\N
9901	99	0	EMPTY	\N	\N	\N	\N	\N	\N
9902	99	1	NPC	\N	\N	7	\N	Barbarian Camp (Lv 7)	\N
9903	99	2	NPC	\N	\N	6	\N	Barbarian Camp (Lv 6)	\N
9904	99	3	EMPTY	\N	\N	\N	\N	\N	\N
9905	99	4	EMPTY	\N	\N	\N	\N	\N	\N
9906	99	5	EMPTY	\N	\N	\N	\N	\N	\N
9907	99	6	EMPTY	\N	\N	\N	\N	\N	\N
9908	99	7	EMPTY	\N	\N	\N	\N	\N	\N
9909	99	8	EMPTY	\N	\N	\N	\N	\N	\N
9910	99	9	RESOURCE	wood	1	\N	\N	\N	\N
9911	99	10	EMPTY	\N	\N	\N	\N	\N	\N
9912	99	11	EMPTY	\N	\N	\N	\N	\N	\N
9913	99	12	EMPTY	\N	\N	\N	\N	\N	\N
9914	99	13	EMPTY	\N	\N	\N	\N	\N	\N
9915	99	14	EMPTY	\N	\N	\N	\N	\N	\N
9916	99	15	EMPTY	\N	\N	\N	\N	\N	\N
9917	99	16	EMPTY	\N	\N	\N	\N	\N	\N
9918	99	17	EMPTY	\N	\N	\N	\N	\N	\N
9919	99	18	EMPTY	\N	\N	\N	\N	\N	\N
9920	99	19	RESOURCE	food	5	\N	\N	\N	\N
9921	99	20	EMPTY	\N	\N	\N	\N	\N	\N
9922	99	21	EMPTY	\N	\N	\N	\N	\N	\N
9923	99	22	EMPTY	\N	\N	\N	\N	\N	\N
9924	99	23	EMPTY	\N	\N	\N	\N	\N	\N
9925	99	24	EMPTY	\N	\N	\N	\N	\N	\N
9926	99	25	EMPTY	\N	\N	\N	\N	\N	\N
9927	99	26	EMPTY	\N	\N	\N	\N	\N	\N
9928	99	27	EMPTY	\N	\N	\N	\N	\N	\N
9929	99	28	EMPTY	\N	\N	\N	\N	\N	\N
9930	99	29	EMPTY	\N	\N	\N	\N	\N	\N
9931	99	30	EMPTY	\N	\N	\N	\N	\N	\N
9932	99	31	EMPTY	\N	\N	\N	\N	\N	\N
9933	99	32	EMPTY	\N	\N	\N	\N	\N	\N
9934	99	33	EMPTY	\N	\N	\N	\N	\N	\N
9935	99	34	EMPTY	\N	\N	\N	\N	\N	\N
9936	99	35	RESOURCE	stone	3	\N	\N	\N	\N
9937	99	36	EMPTY	\N	\N	\N	\N	\N	\N
9938	99	37	EMPTY	\N	\N	\N	\N	\N	\N
9939	99	38	EMPTY	\N	\N	\N	\N	\N	\N
9940	99	39	EMPTY	\N	\N	\N	\N	\N	\N
9941	99	40	EMPTY	\N	\N	\N	\N	\N	\N
9942	99	41	EMPTY	\N	\N	\N	\N	\N	\N
9943	99	42	EMPTY	\N	\N	\N	\N	\N	\N
9944	99	43	EMPTY	\N	\N	\N	\N	\N	\N
9945	99	44	EMPTY	\N	\N	\N	\N	\N	\N
9946	99	45	EMPTY	\N	\N	\N	\N	\N	\N
9947	99	46	EMPTY	\N	\N	\N	\N	\N	\N
9948	99	47	EMPTY	\N	\N	\N	\N	\N	\N
9949	99	48	EMPTY	\N	\N	\N	\N	\N	\N
9950	99	49	EMPTY	\N	\N	\N	\N	\N	\N
9951	99	50	EMPTY	\N	\N	\N	\N	\N	\N
9952	99	51	EMPTY	\N	\N	\N	\N	\N	\N
9953	99	52	EMPTY	\N	\N	\N	\N	\N	\N
9954	99	53	EMPTY	\N	\N	\N	\N	\N	\N
9955	99	54	EMPTY	\N	\N	\N	\N	\N	\N
9956	99	55	EMPTY	\N	\N	\N	\N	\N	\N
9957	99	56	EMPTY	\N	\N	\N	\N	\N	\N
9958	99	57	NPC	\N	\N	4	\N	Barbarian Camp (Lv 4)	\N
9959	99	58	EMPTY	\N	\N	\N	\N	\N	\N
9960	99	59	EMPTY	\N	\N	\N	\N	\N	\N
9961	99	60	EMPTY	\N	\N	\N	\N	\N	\N
9962	99	61	EMPTY	\N	\N	\N	\N	\N	\N
9963	99	62	EMPTY	\N	\N	\N	\N	\N	\N
9964	99	63	EMPTY	\N	\N	\N	\N	\N	\N
9965	99	64	EMPTY	\N	\N	\N	\N	\N	\N
9966	99	65	EMPTY	\N	\N	\N	\N	\N	\N
9967	99	66	EMPTY	\N	\N	\N	\N	\N	\N
9968	99	67	EMPTY	\N	\N	\N	\N	\N	\N
9969	99	68	EMPTY	\N	\N	\N	\N	\N	\N
9970	99	69	EMPTY	\N	\N	\N	\N	\N	\N
9971	99	70	EMPTY	\N	\N	\N	\N	\N	\N
9972	99	71	RESOURCE	stone	4	\N	\N	\N	\N
9973	99	72	EMPTY	\N	\N	\N	\N	\N	\N
9974	99	73	EMPTY	\N	\N	\N	\N	\N	\N
9975	99	74	NPC	\N	\N	1	\N	Barbarian Camp (Lv 1)	\N
9976	99	75	EMPTY	\N	\N	\N	\N	\N	\N
9977	99	76	EMPTY	\N	\N	\N	\N	\N	\N
9978	99	77	EMPTY	\N	\N	\N	\N	\N	\N
9979	99	78	EMPTY	\N	\N	\N	\N	\N	\N
9980	99	79	EMPTY	\N	\N	\N	\N	\N	\N
9981	99	80	EMPTY	\N	\N	\N	\N	\N	\N
9982	99	81	EMPTY	\N	\N	\N	\N	\N	\N
9983	99	82	EMPTY	\N	\N	\N	\N	\N	\N
9984	99	83	NPC	\N	\N	1	\N	Barbarian Camp (Lv 1)	\N
9985	99	84	EMPTY	\N	\N	\N	\N	\N	\N
9986	99	85	EMPTY	\N	\N	\N	\N	\N	\N
9987	99	86	EMPTY	\N	\N	\N	\N	\N	\N
9988	99	87	EMPTY	\N	\N	\N	\N	\N	\N
9989	99	88	EMPTY	\N	\N	\N	\N	\N	\N
9990	99	89	EMPTY	\N	\N	\N	\N	\N	\N
9991	99	90	RESOURCE	stone	4	\N	\N	\N	\N
9992	99	91	EMPTY	\N	\N	\N	\N	\N	\N
9993	99	92	EMPTY	\N	\N	\N	\N	\N	\N
9994	99	93	EMPTY	\N	\N	\N	\N	\N	\N
9995	99	94	EMPTY	\N	\N	\N	\N	\N	\N
9996	99	95	EMPTY	\N	\N	\N	\N	\N	\N
9997	99	96	EMPTY	\N	\N	\N	\N	\N	\N
9998	99	97	EMPTY	\N	\N	\N	\N	\N	\N
9999	99	98	EMPTY	\N	\N	\N	\N	\N	\N
10000	99	99	NPC	\N	\N	3	\N	Barbarian Camp (Lv 3)	\N
9406	94	5	CITY	\N	\N	\N	6	\N	\N
2952	29	51	CITY	\N	\N	\N	7	\N	\N
8280	82	79	CITY	\N	\N	\N	8	\N	\N
279	2	78	CITY	\N	\N	\N	9	\N	\N
6002	60	1	CITY	\N	\N	\N	10	\N	\N
6458	64	57	CITY	\N	\N	\N	11	\N	\N
\.


--
-- Data for Name: npc_cities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.npc_cities (id, x, y, level, warrior, pikeman, swordsman, archer, cavalry, traps, abatis, archer_tower, rolling_log, defensive_trebuchet, food, lumber, stone, iron, gold, wall_level, loyalty, last_regen_tick_at) FROM stdin;
1	0	2	5	750	1000	350	250	200	3750	1875	1250	750	0	3000000	180000	180000	180000	450000	5	90	2026-09-18 04:07:24.115309
2	0	3	8	15000	6750	4000	3000	2000	7200	3600	2400	1440	900	8000000	800000	800000	800000	1000000	8	90	2026-09-18 04:07:24.118334
3	0	43	10	400000	0	0	0	0	11000	5500	3666	2200	1375	19000000	600000	600000	600000	1500000	10	90	2026-09-18 04:07:24.120595
4	0	76	1	50	40	35	15	8	1000	0	0	0	0	100000	20000	20000	20000	55000	1	90	2026-09-18 04:07:24.123227
5	0	78	7	12000	3000	750	800	750	5600	2800	1850	1100	700	4500000	500000	500000	500000	800000	7	90	2026-09-18 04:07:24.125074
6	1	4	8	15000	6750	4000	3000	2000	7200	3600	2400	1440	900	8000000	800000	800000	800000	1000000	8	90	2026-09-18 04:07:24.127231
7	1	23	4	400	400	100	100	150	4500	1875	550	0	0	1600000	120000	120000	120000	300000	4	90	2026-09-18 04:07:24.129289
8	1	74	8	15000	6750	4000	3000	2000	7200	3600	2400	1440	900	8000000	800000	800000	800000	1000000	8	90	2026-09-18 04:07:24.131319
9	1	76	8	15000	6750	4000	3000	2000	7200	3600	2400	1440	900	8000000	800000	800000	800000	1000000	8	90	2026-09-18 04:07:24.133546
10	1	97	9	60000	18000	2000	6750	2500	9000	4500	3000	1800	1150	14000000	550000	550000	550000	1200000	9	90	2026-09-18 04:07:24.135791
11	2	23	5	750	1000	350	250	200	3750	1875	1250	750	0	3000000	180000	180000	180000	450000	5	90	2026-09-18 04:07:24.138369
12	2	39	5	750	1000	350	250	200	3750	1875	1250	750	0	3000000	180000	180000	180000	450000	5	90	2026-09-18 04:07:24.140829
13	2	45	8	15000	6750	4000	3000	2000	7200	3600	2400	1440	900	8000000	800000	800000	800000	1000000	8	90	2026-09-18 04:07:24.143582
14	2	69	1	50	40	35	15	8	1000	0	0	0	0	100000	20000	20000	20000	55000	1	90	2026-09-18 04:07:24.146067
15	2	94	1	50	40	35	15	8	1000	0	0	0	0	100000	20000	20000	20000	55000	1	90	2026-09-18 04:07:24.148377
16	3	3	4	400	400	100	100	150	4500	1875	550	0	0	1600000	120000	120000	120000	300000	4	90	2026-09-18 04:07:24.150836
17	3	34	2	50	45	40	30	25	1850	550	0	0	0	200000	30000	30000	30000	65000	2	90	2026-09-18 04:07:24.152946
18	3	41	7	12000	3000	750	800	750	5600	2800	1850	1100	700	4500000	500000	500000	500000	800000	7	90	2026-09-18 04:07:24.155482
19	3	65	3	200	160	65	40	60	2000	1000	650	0	0	900000	75000	75000	75000	75000	3	90	2026-09-18 04:07:24.157683
20	3	81	4	400	400	100	100	150	4500	1875	550	0	0	1600000	120000	120000	120000	300000	4	90	2026-09-18 04:07:24.159966
21	3	96	3	200	160	65	40	60	2000	1000	650	0	0	900000	75000	75000	75000	75000	3	90	2026-09-18 04:07:24.162263
22	4	5	8	15000	6750	4000	3000	2000	7200	3600	2400	1440	900	8000000	800000	800000	800000	1000000	8	90	2026-09-18 04:07:24.164493
23	4	32	1	50	40	35	15	8	1000	0	0	0	0	100000	20000	20000	20000	55000	1	90	2026-09-18 04:07:24.166861
24	4	46	9	60000	18000	2000	6750	2500	9000	4500	3000	1800	1150	14000000	550000	550000	550000	1200000	9	90	2026-09-18 04:07:24.169216
25	4	49	7	12000	3000	750	800	750	5600	2800	1850	1100	700	4500000	500000	500000	500000	800000	7	90	2026-09-18 04:07:24.171901
26	5	9	7	12000	3000	750	800	750	5600	2800	1850	1100	700	4500000	500000	500000	500000	800000	7	90	2026-09-18 04:07:24.174068
27	5	36	4	400	400	100	100	150	4500	1875	550	0	0	1600000	120000	120000	120000	300000	4	90	2026-09-18 04:07:24.176924
28	5	59	9	60000	18000	2000	6750	2500	9000	4500	3000	1800	1150	14000000	550000	550000	550000	1200000	9	90	2026-09-18 04:07:24.179297
29	5	84	3	200	160	65	40	60	2000	1000	650	0	0	900000	75000	75000	75000	75000	3	90	2026-09-18 04:07:24.181858
30	6	7	6	4000	750	550	500	450	4250	1500	1500	950	400	4000000	200000	200000	200000	600000	6	90	2026-09-18 04:07:24.184373
31	6	22	9	60000	18000	2000	6750	2500	9000	4500	3000	1800	1150	14000000	550000	550000	550000	1200000	9	90	2026-09-18 04:07:24.186896
32	6	32	5	750	1000	350	250	200	3750	1875	1250	750	0	3000000	180000	180000	180000	450000	5	90	2026-09-18 04:07:24.189239
33	6	49	3	200	160	65	40	60	2000	1000	650	0	0	900000	75000	75000	75000	75000	3	90	2026-09-18 04:07:24.191741
34	6	59	3	200	160	65	40	60	2000	1000	650	0	0	900000	75000	75000	75000	75000	3	90	2026-09-18 04:07:24.194373
35	6	60	8	15000	6750	4000	3000	2000	7200	3600	2400	1440	900	8000000	800000	800000	800000	1000000	8	90	2026-09-18 04:07:24.196783
36	6	77	7	12000	3000	750	800	750	5600	2800	1850	1100	700	4500000	500000	500000	500000	800000	7	90	2026-09-18 04:07:24.199052
37	6	85	6	4000	750	550	500	450	4250	1500	1500	950	400	4000000	200000	200000	200000	600000	6	90	2026-09-18 04:07:24.201313
38	7	24	5	750	1000	350	250	200	3750	1875	1250	750	0	3000000	180000	180000	180000	450000	5	90	2026-09-18 04:07:24.203573
39	7	51	1	50	40	35	15	8	1000	0	0	0	0	100000	20000	20000	20000	55000	1	90	2026-09-18 04:07:24.205581
40	7	80	10	400000	0	0	0	0	11000	5500	3666	2200	1375	19000000	600000	600000	600000	1500000	10	90	2026-09-18 04:07:24.207926
41	7	87	9	60000	18000	2000	6750	2500	9000	4500	3000	1800	1150	14000000	550000	550000	550000	1200000	9	90	2026-09-18 04:07:24.210431
42	7	96	9	60000	18000	2000	6750	2500	9000	4500	3000	1800	1150	14000000	550000	550000	550000	1200000	9	90	2026-09-18 04:07:24.212896
43	8	1	9	60000	18000	2000	6750	2500	9000	4500	3000	1800	1150	14000000	550000	550000	550000	1200000	9	90	2026-09-18 04:07:24.215185
44	8	25	9	60000	18000	2000	6750	2500	9000	4500	3000	1800	1150	14000000	550000	550000	550000	1200000	9	90	2026-09-18 04:07:24.217429
45	8	46	10	400000	0	0	0	0	11000	5500	3666	2200	1375	19000000	600000	600000	600000	1500000	10	90	2026-09-18 04:07:24.219676
46	8	62	8	15000	6750	4000	3000	2000	7200	3600	2400	1440	900	8000000	800000	800000	800000	1000000	8	90	2026-09-18 04:07:24.22225
47	8	71	8	15000	6750	4000	3000	2000	7200	3600	2400	1440	900	8000000	800000	800000	800000	1000000	8	90	2026-09-18 04:07:24.224675
48	9	47	8	15000	6750	4000	3000	2000	7200	3600	2400	1440	900	8000000	800000	800000	800000	1000000	8	90	2026-09-18 04:07:24.227018
49	9	69	2	50	45	40	30	25	1850	550	0	0	0	200000	30000	30000	30000	65000	2	90	2026-09-18 04:07:24.229333
50	9	73	3	200	160	65	40	60	2000	1000	650	0	0	900000	75000	75000	75000	75000	3	90	2026-09-18 04:07:24.231693
51	9	79	4	400	400	100	100	150	4500	1875	550	0	0	1600000	120000	120000	120000	300000	4	90	2026-09-18 04:07:24.234401
52	10	59	2	50	45	40	30	25	1850	550	0	0	0	200000	30000	30000	30000	65000	2	90	2026-09-18 04:07:24.236878
53	10	72	2	50	45	40	30	25	1850	550	0	0	0	200000	30000	30000	30000	65000	2	90	2026-09-18 04:07:24.239169
54	10	97	3	200	160	65	40	60	2000	1000	650	0	0	900000	75000	75000	75000	75000	3	90	2026-09-18 04:07:24.241591
55	11	6	9	60000	18000	2000	6750	2500	9000	4500	3000	1800	1150	14000000	550000	550000	550000	1200000	9	90	2026-09-18 04:07:24.244068
56	11	12	8	15000	6750	4000	3000	2000	7200	3600	2400	1440	900	8000000	800000	800000	800000	1000000	8	90	2026-09-18 04:07:24.246151
57	11	31	1	50	40	35	15	8	1000	0	0	0	0	100000	20000	20000	20000	55000	1	90	2026-09-18 04:07:24.248573
58	11	45	3	200	160	65	40	60	2000	1000	650	0	0	900000	75000	75000	75000	75000	3	90	2026-09-18 04:07:24.250978
59	11	84	2	50	45	40	30	25	1850	550	0	0	0	200000	30000	30000	30000	65000	2	90	2026-09-18 04:07:24.253526
60	11	87	7	12000	3000	750	800	750	5600	2800	1850	1100	700	4500000	500000	500000	500000	800000	7	90	2026-09-18 04:07:24.256501
61	12	4	6	4000	750	550	500	450	4250	1500	1500	950	400	4000000	200000	200000	200000	600000	6	90	2026-09-18 04:07:24.258938
62	12	23	1	50	40	35	15	8	1000	0	0	0	0	100000	20000	20000	20000	55000	1	90	2026-09-18 04:07:24.26136
63	12	33	4	400	400	100	100	150	4500	1875	550	0	0	1600000	120000	120000	120000	300000	4	90	2026-09-18 04:07:24.26375
64	12	51	9	60000	18000	2000	6750	2500	9000	4500	3000	1800	1150	14000000	550000	550000	550000	1200000	9	90	2026-09-18 04:07:24.266186
65	12	65	3	200	160	65	40	60	2000	1000	650	0	0	900000	75000	75000	75000	75000	3	90	2026-09-18 04:07:24.268658
66	12	81	8	15000	6750	4000	3000	2000	7200	3600	2400	1440	900	8000000	800000	800000	800000	1000000	8	90	2026-09-18 04:07:24.271843
67	12	82	3	200	160	65	40	60	2000	1000	650	0	0	900000	75000	75000	75000	75000	3	90	2026-09-18 04:07:24.274204
68	12	91	8	15000	6750	4000	3000	2000	7200	3600	2400	1440	900	8000000	800000	800000	800000	1000000	8	90	2026-09-18 04:07:24.276591
69	12	98	9	60000	18000	2000	6750	2500	9000	4500	3000	1800	1150	14000000	550000	550000	550000	1200000	9	90	2026-09-18 04:07:24.279026
70	14	2	4	400	400	100	100	150	4500	1875	550	0	0	1600000	120000	120000	120000	300000	4	90	2026-09-18 04:07:24.28117
71	14	3	5	750	1000	350	250	200	3750	1875	1250	750	0	3000000	180000	180000	180000	450000	5	90	2026-09-18 04:07:24.283579
72	14	40	6	4000	750	550	500	450	4250	1500	1500	950	400	4000000	200000	200000	200000	600000	6	90	2026-09-18 04:07:24.285826
73	14	63	2	50	45	40	30	25	1850	550	0	0	0	200000	30000	30000	30000	65000	2	90	2026-09-18 04:07:24.288769
74	15	2	4	400	400	100	100	150	4500	1875	550	0	0	1600000	120000	120000	120000	300000	4	90	2026-09-18 04:07:24.291038
75	15	6	6	4000	750	550	500	450	4250	1500	1500	950	400	4000000	200000	200000	200000	600000	6	90	2026-09-18 04:07:24.293408
76	15	13	3	200	160	65	40	60	2000	1000	650	0	0	900000	75000	75000	75000	75000	3	90	2026-09-18 04:07:24.295726
77	15	14	4	400	400	100	100	150	4500	1875	550	0	0	1600000	120000	120000	120000	300000	4	90	2026-09-18 04:07:24.297974
78	15	17	2	50	45	40	30	25	1850	550	0	0	0	200000	30000	30000	30000	65000	2	90	2026-09-18 04:07:24.300049
79	15	57	9	60000	18000	2000	6750	2500	9000	4500	3000	1800	1150	14000000	550000	550000	550000	1200000	9	90	2026-09-18 04:07:24.302289
80	15	73	1	50	40	35	15	8	1000	0	0	0	0	100000	20000	20000	20000	55000	1	90	2026-09-18 04:07:24.30521
81	16	10	1	50	40	35	15	8	1000	0	0	0	0	100000	20000	20000	20000	55000	1	90	2026-09-18 04:07:24.307605
82	16	17	4	400	400	100	100	150	4500	1875	550	0	0	1600000	120000	120000	120000	300000	4	90	2026-09-18 04:07:24.310094
83	16	30	10	400000	0	0	0	0	11000	5500	3666	2200	1375	19000000	600000	600000	600000	1500000	10	90	2026-09-18 04:07:24.312489
84	16	38	6	4000	750	550	500	450	4250	1500	1500	950	400	4000000	200000	200000	200000	600000	6	90	2026-09-18 04:07:24.314932
85	16	47	5	750	1000	350	250	200	3750	1875	1250	750	0	3000000	180000	180000	180000	450000	5	90	2026-09-18 04:07:24.317153
86	16	58	6	4000	750	550	500	450	4250	1500	1500	950	400	4000000	200000	200000	200000	600000	6	90	2026-09-18 04:07:24.319462
87	16	68	8	15000	6750	4000	3000	2000	7200	3600	2400	1440	900	8000000	800000	800000	800000	1000000	8	90	2026-09-18 04:07:24.322175
88	16	77	10	400000	0	0	0	0	11000	5500	3666	2200	1375	19000000	600000	600000	600000	1500000	10	90	2026-09-18 04:07:24.324546
89	16	97	7	12000	3000	750	800	750	5600	2800	1850	1100	700	4500000	500000	500000	500000	800000	7	90	2026-09-18 04:07:24.326963
90	17	17	3	200	160	65	40	60	2000	1000	650	0	0	900000	75000	75000	75000	75000	3	90	2026-09-18 04:07:24.329499
91	17	26	10	400000	0	0	0	0	11000	5500	3666	2200	1375	19000000	600000	600000	600000	1500000	10	90	2026-09-18 04:07:24.331981
92	17	68	7	12000	3000	750	800	750	5600	2800	1850	1100	700	4500000	500000	500000	500000	800000	7	90	2026-09-18 04:07:24.334598
93	17	76	10	400000	0	0	0	0	11000	5500	3666	2200	1375	19000000	600000	600000	600000	1500000	10	90	2026-09-18 04:07:24.33688
94	18	24	9	60000	18000	2000	6750	2500	9000	4500	3000	1800	1150	14000000	550000	550000	550000	1200000	9	90	2026-09-18 04:07:24.339615
95	18	50	4	400	400	100	100	150	4500	1875	550	0	0	1600000	120000	120000	120000	300000	4	90	2026-09-18 04:07:24.341923
96	18	54	1	50	40	35	15	8	1000	0	0	0	0	100000	20000	20000	20000	55000	1	90	2026-09-18 04:07:24.344135
97	18	62	2	50	45	40	30	25	1850	550	0	0	0	200000	30000	30000	30000	65000	2	90	2026-09-18 04:07:24.346185
98	18	63	9	60000	18000	2000	6750	2500	9000	4500	3000	1800	1150	14000000	550000	550000	550000	1200000	9	90	2026-09-18 04:07:24.348335
99	18	79	8	15000	6750	4000	3000	2000	7200	3600	2400	1440	900	8000000	800000	800000	800000	1000000	8	90	2026-09-18 04:07:24.350577
100	18	83	5	750	1000	350	250	200	3750	1875	1250	750	0	3000000	180000	180000	180000	450000	5	90	2026-09-18 04:07:24.352665
101	18	84	4	400	400	100	100	150	4500	1875	550	0	0	1600000	120000	120000	120000	300000	4	90	2026-09-18 04:07:24.355171
102	18	99	9	60000	18000	2000	6750	2500	9000	4500	3000	1800	1150	14000000	550000	550000	550000	1200000	9	90	2026-09-18 04:07:24.357246
103	19	25	4	400	400	100	100	150	4500	1875	550	0	0	1600000	120000	120000	120000	300000	4	90	2026-09-18 04:07:24.35933
104	19	30	6	4000	750	550	500	450	4250	1500	1500	950	400	4000000	200000	200000	200000	600000	6	90	2026-09-18 04:07:24.361748
105	19	68	7	12000	3000	750	800	750	5600	2800	1850	1100	700	4500000	500000	500000	500000	800000	7	90	2026-09-18 04:07:24.363696
106	19	74	7	12000	3000	750	800	750	5600	2800	1850	1100	700	4500000	500000	500000	500000	800000	7	90	2026-09-18 04:07:24.365748
107	20	0	7	12000	3000	750	800	750	5600	2800	1850	1100	700	4500000	500000	500000	500000	800000	7	90	2026-09-18 04:07:24.36796
108	20	12	8	15000	6750	4000	3000	2000	7200	3600	2400	1440	900	8000000	800000	800000	800000	1000000	8	90	2026-09-18 04:07:24.37031
109	20	66	1	50	40	35	15	8	1000	0	0	0	0	100000	20000	20000	20000	55000	1	90	2026-09-18 04:07:24.373166
110	20	83	8	15000	6750	4000	3000	2000	7200	3600	2400	1440	900	8000000	800000	800000	800000	1000000	8	90	2026-09-18 04:07:24.375456
111	20	89	5	750	1000	350	250	200	3750	1875	1250	750	0	3000000	180000	180000	180000	450000	5	90	2026-09-18 04:07:24.377664
112	21	3	8	15000	6750	4000	3000	2000	7200	3600	2400	1440	900	8000000	800000	800000	800000	1000000	8	90	2026-09-18 04:07:24.379774
113	21	8	8	15000	6750	4000	3000	2000	7200	3600	2400	1440	900	8000000	800000	800000	800000	1000000	8	90	2026-09-18 04:07:24.381991
114	21	23	2	50	45	40	30	25	1850	550	0	0	0	200000	30000	30000	30000	65000	2	90	2026-09-18 04:07:24.38449
115	21	37	1	50	40	35	15	8	1000	0	0	0	0	100000	20000	20000	20000	55000	1	90	2026-09-18 04:07:24.386663
116	21	45	10	400000	0	0	0	0	11000	5500	3666	2200	1375	19000000	600000	600000	600000	1500000	10	90	2026-09-18 04:07:24.388786
117	21	70	5	750	1000	350	250	200	3750	1875	1250	750	0	3000000	180000	180000	180000	450000	5	90	2026-09-18 04:07:24.390971
118	21	76	9	60000	18000	2000	6750	2500	9000	4500	3000	1800	1150	14000000	550000	550000	550000	1200000	9	90	2026-09-18 04:07:24.393297
119	21	88	8	15000	6750	4000	3000	2000	7200	3600	2400	1440	900	8000000	800000	800000	800000	1000000	8	90	2026-09-18 04:07:24.395754
120	21	99	6	4000	750	550	500	450	4250	1500	1500	950	400	4000000	200000	200000	200000	600000	6	90	2026-09-18 04:07:24.397928
121	22	14	5	750	1000	350	250	200	3750	1875	1250	750	0	3000000	180000	180000	180000	450000	5	90	2026-09-18 04:07:24.400214
122	22	73	6	4000	750	550	500	450	4250	1500	1500	950	400	4000000	200000	200000	200000	600000	6	90	2026-09-18 04:07:24.40245
123	23	38	4	400	400	100	100	150	4500	1875	550	0	0	1600000	120000	120000	120000	300000	4	90	2026-09-18 04:07:24.405164
124	23	42	10	400000	0	0	0	0	11000	5500	3666	2200	1375	19000000	600000	600000	600000	1500000	10	90	2026-09-18 04:07:24.407684
125	23	59	7	12000	3000	750	800	750	5600	2800	1850	1100	700	4500000	500000	500000	500000	800000	7	90	2026-09-18 04:07:24.410136
126	23	76	5	750	1000	350	250	200	3750	1875	1250	750	0	3000000	180000	180000	180000	450000	5	90	2026-09-18 04:07:24.412664
127	23	80	6	4000	750	550	500	450	4250	1500	1500	950	400	4000000	200000	200000	200000	600000	6	90	2026-09-18 04:07:24.414849
128	24	59	10	400000	0	0	0	0	11000	5500	3666	2200	1375	19000000	600000	600000	600000	1500000	10	90	2026-09-18 04:07:24.416723
129	24	64	5	750	1000	350	250	200	3750	1875	1250	750	0	3000000	180000	180000	180000	450000	5	90	2026-09-18 04:07:24.419153
130	24	66	1	50	40	35	15	8	1000	0	0	0	0	100000	20000	20000	20000	55000	1	90	2026-09-18 04:07:24.421939
131	24	84	7	12000	3000	750	800	750	5600	2800	1850	1100	700	4500000	500000	500000	500000	800000	7	90	2026-09-18 04:07:24.424166
132	24	93	10	400000	0	0	0	0	11000	5500	3666	2200	1375	19000000	600000	600000	600000	1500000	10	90	2026-09-18 04:07:24.426275
133	25	1	5	750	1000	350	250	200	3750	1875	1250	750	0	3000000	180000	180000	180000	450000	5	90	2026-09-18 04:07:24.428558
134	25	18	4	400	400	100	100	150	4500	1875	550	0	0	1600000	120000	120000	120000	300000	4	90	2026-09-18 04:07:24.430726
135	25	19	4	400	400	100	100	150	4500	1875	550	0	0	1600000	120000	120000	120000	300000	4	90	2026-09-18 04:07:24.432847
136	25	25	2	50	45	40	30	25	1850	550	0	0	0	200000	30000	30000	30000	65000	2	90	2026-09-18 04:07:24.438366
137	25	36	8	15000	6750	4000	3000	2000	7200	3600	2400	1440	900	8000000	800000	800000	800000	1000000	8	90	2026-09-18 04:07:24.440794
138	25	47	1	50	40	35	15	8	1000	0	0	0	0	100000	20000	20000	20000	55000	1	90	2026-09-18 04:07:24.443082
139	25	66	2	50	45	40	30	25	1850	550	0	0	0	200000	30000	30000	30000	65000	2	90	2026-09-18 04:07:24.44579
140	26	15	2	50	45	40	30	25	1850	550	0	0	0	200000	30000	30000	30000	65000	2	90	2026-09-18 04:07:24.448057
141	26	50	6	4000	750	550	500	450	4250	1500	1500	950	400	4000000	200000	200000	200000	600000	6	90	2026-09-18 04:07:24.45061
142	26	52	10	400000	0	0	0	0	11000	5500	3666	2200	1375	19000000	600000	600000	600000	1500000	10	90	2026-09-18 04:07:24.452829
143	26	95	8	15000	6750	4000	3000	2000	7200	3600	2400	1440	900	8000000	800000	800000	800000	1000000	8	90	2026-09-18 04:07:24.455349
144	27	53	7	12000	3000	750	800	750	5600	2800	1850	1100	700	4500000	500000	500000	500000	800000	7	90	2026-09-18 04:07:24.457654
145	27	96	8	15000	6750	4000	3000	2000	7200	3600	2400	1440	900	8000000	800000	800000	800000	1000000	8	90	2026-09-18 04:07:24.460221
146	28	41	2	50	45	40	30	25	1850	550	0	0	0	200000	30000	30000	30000	65000	2	90	2026-09-18 04:07:24.462685
147	28	57	7	12000	3000	750	800	750	5600	2800	1850	1100	700	4500000	500000	500000	500000	800000	7	90	2026-09-18 04:07:24.465376
148	28	84	7	12000	3000	750	800	750	5600	2800	1850	1100	700	4500000	500000	500000	500000	800000	7	90	2026-09-18 04:07:24.467753
149	29	17	5	750	1000	350	250	200	3750	1875	1250	750	0	3000000	180000	180000	180000	450000	5	90	2026-09-18 04:07:24.470207
150	29	38	3	200	160	65	40	60	2000	1000	650	0	0	900000	75000	75000	75000	75000	3	90	2026-09-18 04:07:24.472985
151	29	42	2	50	45	40	30	25	1850	550	0	0	0	200000	30000	30000	30000	65000	2	90	2026-09-18 04:07:24.475199
152	29	48	9	60000	18000	2000	6750	2500	9000	4500	3000	1800	1150	14000000	550000	550000	550000	1200000	9	90	2026-09-18 04:07:24.47756
153	29	58	3	200	160	65	40	60	2000	1000	650	0	0	900000	75000	75000	75000	75000	3	90	2026-09-18 04:07:24.480181
154	29	61	9	60000	18000	2000	6750	2500	9000	4500	3000	1800	1150	14000000	550000	550000	550000	1200000	9	90	2026-09-18 04:07:24.482518
155	29	68	9	60000	18000	2000	6750	2500	9000	4500	3000	1800	1150	14000000	550000	550000	550000	1200000	9	90	2026-09-18 04:07:24.484965
156	29	72	9	60000	18000	2000	6750	2500	9000	4500	3000	1800	1150	14000000	550000	550000	550000	1200000	9	90	2026-09-18 04:07:24.487337
157	30	29	1	50	40	35	15	8	1000	0	0	0	0	100000	20000	20000	20000	55000	1	90	2026-09-18 04:07:24.490527
158	30	52	2	50	45	40	30	25	1850	550	0	0	0	200000	30000	30000	30000	65000	2	90	2026-09-18 04:07:24.492978
159	30	58	7	12000	3000	750	800	750	5600	2800	1850	1100	700	4500000	500000	500000	500000	800000	7	90	2026-09-18 04:07:24.495287
160	30	62	8	15000	6750	4000	3000	2000	7200	3600	2400	1440	900	8000000	800000	800000	800000	1000000	8	90	2026-09-18 04:07:24.497751
161	30	66	1	50	40	35	15	8	1000	0	0	0	0	100000	20000	20000	20000	55000	1	90	2026-09-18 04:07:24.500123
162	31	25	7	12000	3000	750	800	750	5600	2800	1850	1100	700	4500000	500000	500000	500000	800000	7	90	2026-09-18 04:07:24.502925
163	31	41	8	15000	6750	4000	3000	2000	7200	3600	2400	1440	900	8000000	800000	800000	800000	1000000	8	90	2026-09-18 04:07:24.505341
164	31	53	2	50	45	40	30	25	1850	550	0	0	0	200000	30000	30000	30000	65000	2	90	2026-09-18 04:07:24.50765
165	31	90	9	60000	18000	2000	6750	2500	9000	4500	3000	1800	1150	14000000	550000	550000	550000	1200000	9	90	2026-09-18 04:07:24.510179
166	32	4	10	400000	0	0	0	0	11000	5500	3666	2200	1375	19000000	600000	600000	600000	1500000	10	90	2026-09-18 04:07:24.512499
167	32	29	7	12000	3000	750	800	750	5600	2800	1850	1100	700	4500000	500000	500000	500000	800000	7	90	2026-09-18 04:07:24.515007
168	32	52	8	15000	6750	4000	3000	2000	7200	3600	2400	1440	900	8000000	800000	800000	800000	1000000	8	90	2026-09-18 04:07:24.517536
169	32	86	1	50	40	35	15	8	1000	0	0	0	0	100000	20000	20000	20000	55000	1	90	2026-09-18 04:07:24.520169
170	33	6	8	15000	6750	4000	3000	2000	7200	3600	2400	1440	900	8000000	800000	800000	800000	1000000	8	90	2026-09-18 04:07:24.522832
171	33	25	8	15000	6750	4000	3000	2000	7200	3600	2400	1440	900	8000000	800000	800000	800000	1000000	8	90	2026-09-18 04:07:24.52524
172	33	32	2	50	45	40	30	25	1850	550	0	0	0	200000	30000	30000	30000	65000	2	90	2026-09-18 04:07:24.527613
173	33	94	3	200	160	65	40	60	2000	1000	650	0	0	900000	75000	75000	75000	75000	3	90	2026-09-18 04:07:24.530409
174	34	40	5	750	1000	350	250	200	3750	1875	1250	750	0	3000000	180000	180000	180000	450000	5	90	2026-09-18 04:07:24.53288
175	34	44	10	400000	0	0	0	0	11000	5500	3666	2200	1375	19000000	600000	600000	600000	1500000	10	90	2026-09-18 04:07:24.535365
176	34	51	1	50	40	35	15	8	1000	0	0	0	0	100000	20000	20000	20000	55000	1	90	2026-09-18 04:07:24.538389
177	34	64	10	400000	0	0	0	0	11000	5500	3666	2200	1375	19000000	600000	600000	600000	1500000	10	90	2026-09-18 04:07:24.540965
178	35	19	10	400000	0	0	0	0	11000	5500	3666	2200	1375	19000000	600000	600000	600000	1500000	10	90	2026-09-18 04:07:24.54352
179	35	46	2	50	45	40	30	25	1850	550	0	0	0	200000	30000	30000	30000	65000	2	90	2026-09-18 04:07:24.546077
180	35	64	8	15000	6750	4000	3000	2000	7200	3600	2400	1440	900	8000000	800000	800000	800000	1000000	8	90	2026-09-18 04:07:24.548438
181	36	11	3	200	160	65	40	60	2000	1000	650	0	0	900000	75000	75000	75000	75000	3	90	2026-09-18 04:07:24.550922
182	36	17	3	200	160	65	40	60	2000	1000	650	0	0	900000	75000	75000	75000	75000	3	90	2026-09-18 04:07:24.553282
183	36	46	7	12000	3000	750	800	750	5600	2800	1850	1100	700	4500000	500000	500000	500000	800000	7	90	2026-09-18 04:07:24.555562
184	36	77	5	750	1000	350	250	200	3750	1875	1250	750	0	3000000	180000	180000	180000	450000	5	90	2026-09-18 04:07:24.558066
185	36	98	7	12000	3000	750	800	750	5600	2800	1850	1100	700	4500000	500000	500000	500000	800000	7	90	2026-09-18 04:07:24.560741
186	37	17	5	750	1000	350	250	200	3750	1875	1250	750	0	3000000	180000	180000	180000	450000	5	90	2026-09-18 04:07:24.563274
187	37	40	1	50	40	35	15	8	1000	0	0	0	0	100000	20000	20000	20000	55000	1	90	2026-09-18 04:07:24.565707
188	37	48	1	50	40	35	15	8	1000	0	0	0	0	100000	20000	20000	20000	55000	1	90	2026-09-18 04:07:24.568419
189	37	51	9	60000	18000	2000	6750	2500	9000	4500	3000	1800	1150	14000000	550000	550000	550000	1200000	9	90	2026-09-18 04:07:24.571358
190	37	80	4	400	400	100	100	150	4500	1875	550	0	0	1600000	120000	120000	120000	300000	4	90	2026-09-18 04:07:24.573552
191	38	1	9	60000	18000	2000	6750	2500	9000	4500	3000	1800	1150	14000000	550000	550000	550000	1200000	9	90	2026-09-18 04:07:24.575764
192	38	3	6	4000	750	550	500	450	4250	1500	1500	950	400	4000000	200000	200000	200000	600000	6	90	2026-09-18 04:07:24.577941
193	38	20	2	50	45	40	30	25	1850	550	0	0	0	200000	30000	30000	30000	65000	2	90	2026-09-18 04:07:24.580453
194	38	88	2	50	45	40	30	25	1850	550	0	0	0	200000	30000	30000	30000	65000	2	90	2026-09-18 04:07:24.582779
195	39	5	10	400000	0	0	0	0	11000	5500	3666	2200	1375	19000000	600000	600000	600000	1500000	10	90	2026-09-18 04:07:24.585233
196	39	15	5	750	1000	350	250	200	3750	1875	1250	750	0	3000000	180000	180000	180000	450000	5	90	2026-09-18 04:07:24.588211
197	39	74	10	400000	0	0	0	0	11000	5500	3666	2200	1375	19000000	600000	600000	600000	1500000	10	90	2026-09-18 04:07:24.590582
198	40	27	4	400	400	100	100	150	4500	1875	550	0	0	1600000	120000	120000	120000	300000	4	90	2026-09-18 04:07:24.595956
199	40	40	4	400	400	100	100	150	4500	1875	550	0	0	1600000	120000	120000	120000	300000	4	90	2026-09-18 04:07:24.598528
200	40	53	5	750	1000	350	250	200	3750	1875	1250	750	0	3000000	180000	180000	180000	450000	5	90	2026-09-18 04:07:24.601025
201	40	68	9	60000	18000	2000	6750	2500	9000	4500	3000	1800	1150	14000000	550000	550000	550000	1200000	9	90	2026-09-18 04:07:24.603255
202	40	88	5	750	1000	350	250	200	3750	1875	1250	750	0	3000000	180000	180000	180000	450000	5	90	2026-09-18 04:07:24.606085
203	41	12	5	750	1000	350	250	200	3750	1875	1250	750	0	3000000	180000	180000	180000	450000	5	90	2026-09-18 04:07:24.608347
204	41	24	6	4000	750	550	500	450	4250	1500	1500	950	400	4000000	200000	200000	200000	600000	6	90	2026-09-18 04:07:24.610764
205	41	31	4	400	400	100	100	150	4500	1875	550	0	0	1600000	120000	120000	120000	300000	4	90	2026-09-18 04:07:24.61312
206	41	39	3	200	160	65	40	60	2000	1000	650	0	0	900000	75000	75000	75000	75000	3	90	2026-09-18 04:07:24.615598
207	41	43	3	200	160	65	40	60	2000	1000	650	0	0	900000	75000	75000	75000	75000	3	90	2026-09-18 04:07:24.61823
208	41	58	3	200	160	65	40	60	2000	1000	650	0	0	900000	75000	75000	75000	75000	3	90	2026-09-18 04:07:24.620602
209	41	65	3	200	160	65	40	60	2000	1000	650	0	0	900000	75000	75000	75000	75000	3	90	2026-09-18 04:07:24.623393
210	41	67	2	50	45	40	30	25	1850	550	0	0	0	200000	30000	30000	30000	65000	2	90	2026-09-18 04:07:24.625968
211	41	71	3	200	160	65	40	60	2000	1000	650	0	0	900000	75000	75000	75000	75000	3	90	2026-09-18 04:07:24.628348
212	41	91	1	50	40	35	15	8	1000	0	0	0	0	100000	20000	20000	20000	55000	1	90	2026-09-18 04:07:24.630633
213	42	0	2	50	45	40	30	25	1850	550	0	0	0	200000	30000	30000	30000	65000	2	90	2026-09-18 04:07:24.632874
214	42	9	6	4000	750	550	500	450	4250	1500	1500	950	400	4000000	200000	200000	200000	600000	6	90	2026-09-18 04:07:24.635064
215	42	31	10	400000	0	0	0	0	11000	5500	3666	2200	1375	19000000	600000	600000	600000	1500000	10	90	2026-09-18 04:07:24.637117
216	42	70	2	50	45	40	30	25	1850	550	0	0	0	200000	30000	30000	30000	65000	2	90	2026-09-18 04:07:24.639574
217	42	90	5	750	1000	350	250	200	3750	1875	1250	750	0	3000000	180000	180000	180000	450000	5	90	2026-09-18 04:07:24.641837
218	43	5	5	750	1000	350	250	200	3750	1875	1250	750	0	3000000	180000	180000	180000	450000	5	90	2026-09-18 04:07:24.6439
219	43	6	9	60000	18000	2000	6750	2500	9000	4500	3000	1800	1150	14000000	550000	550000	550000	1200000	9	90	2026-09-18 04:07:24.646094
220	43	49	10	400000	0	0	0	0	11000	5500	3666	2200	1375	19000000	600000	600000	600000	1500000	10	90	2026-09-18 04:07:24.648128
221	44	0	5	750	1000	350	250	200	3750	1875	1250	750	0	3000000	180000	180000	180000	450000	5	90	2026-09-18 04:07:24.650271
222	44	37	4	400	400	100	100	150	4500	1875	550	0	0	1600000	120000	120000	120000	300000	4	90	2026-09-18 04:07:24.65246
223	44	66	5	750	1000	350	250	200	3750	1875	1250	750	0	3000000	180000	180000	180000	450000	5	90	2026-09-18 04:07:24.655121
224	44	70	4	400	400	100	100	150	4500	1875	550	0	0	1600000	120000	120000	120000	300000	4	90	2026-09-18 04:07:24.657398
225	44	78	4	400	400	100	100	150	4500	1875	550	0	0	1600000	120000	120000	120000	300000	4	90	2026-09-18 04:07:24.659422
226	44	87	2	50	45	40	30	25	1850	550	0	0	0	200000	30000	30000	30000	65000	2	90	2026-09-18 04:07:24.661621
227	45	19	6	4000	750	550	500	450	4250	1500	1500	950	400	4000000	200000	200000	200000	600000	6	90	2026-09-18 04:07:24.663862
228	45	52	6	4000	750	550	500	450	4250	1500	1500	950	400	4000000	200000	200000	200000	600000	6	90	2026-09-18 04:07:24.666064
229	46	20	2	50	45	40	30	25	1850	550	0	0	0	200000	30000	30000	30000	65000	2	90	2026-09-18 04:07:24.668279
230	46	25	6	4000	750	550	500	450	4250	1500	1500	950	400	4000000	200000	200000	200000	600000	6	90	2026-09-18 04:07:24.672234
231	46	52	7	12000	3000	750	800	750	5600	2800	1850	1100	700	4500000	500000	500000	500000	800000	7	90	2026-09-18 04:07:24.674404
232	46	61	3	200	160	65	40	60	2000	1000	650	0	0	900000	75000	75000	75000	75000	3	90	2026-09-18 04:07:24.67664
233	46	82	2	50	45	40	30	25	1850	550	0	0	0	200000	30000	30000	30000	65000	2	90	2026-09-18 04:07:24.678689
234	47	29	8	15000	6750	4000	3000	2000	7200	3600	2400	1440	900	8000000	800000	800000	800000	1000000	8	90	2026-09-18 04:07:24.680747
235	47	35	4	400	400	100	100	150	4500	1875	550	0	0	1600000	120000	120000	120000	300000	4	90	2026-09-18 04:07:24.682869
236	47	39	10	400000	0	0	0	0	11000	5500	3666	2200	1375	19000000	600000	600000	600000	1500000	10	90	2026-09-18 04:07:24.685122
237	47	49	1	50	40	35	15	8	1000	0	0	0	0	100000	20000	20000	20000	55000	1	90	2026-09-18 04:07:24.687225
238	47	65	8	15000	6750	4000	3000	2000	7200	3600	2400	1440	900	8000000	800000	800000	800000	1000000	8	90	2026-09-18 04:07:24.689434
239	47	68	6	4000	750	550	500	450	4250	1500	1500	950	400	4000000	200000	200000	200000	600000	6	90	2026-09-18 04:07:24.691557
240	48	34	10	400000	0	0	0	0	11000	5500	3666	2200	1375	19000000	600000	600000	600000	1500000	10	90	2026-09-18 04:07:24.693429
241	48	36	4	400	400	100	100	150	4500	1875	550	0	0	1600000	120000	120000	120000	300000	4	90	2026-09-18 04:07:24.695564
242	48	39	1	50	40	35	15	8	1000	0	0	0	0	100000	20000	20000	20000	55000	1	90	2026-09-18 04:07:24.697779
243	48	40	10	400000	0	0	0	0	11000	5500	3666	2200	1375	19000000	600000	600000	600000	1500000	10	90	2026-09-18 04:07:24.699968
244	48	41	7	12000	3000	750	800	750	5600	2800	1850	1100	700	4500000	500000	500000	500000	800000	7	90	2026-09-18 04:07:24.702025
245	48	44	5	750	1000	350	250	200	3750	1875	1250	750	0	3000000	180000	180000	180000	450000	5	90	2026-09-18 04:07:24.703839
246	48	63	8	15000	6750	4000	3000	2000	7200	3600	2400	1440	900	8000000	800000	800000	800000	1000000	8	90	2026-09-18 04:07:24.706308
247	48	77	4	400	400	100	100	150	4500	1875	550	0	0	1600000	120000	120000	120000	300000	4	90	2026-09-18 04:07:24.708567
248	48	88	9	60000	18000	2000	6750	2500	9000	4500	3000	1800	1150	14000000	550000	550000	550000	1200000	9	90	2026-09-18 04:07:24.71056
249	49	3	7	12000	3000	750	800	750	5600	2800	1850	1100	700	4500000	500000	500000	500000	800000	7	90	2026-09-18 04:07:24.712949
250	49	18	10	400000	0	0	0	0	11000	5500	3666	2200	1375	19000000	600000	600000	600000	1500000	10	90	2026-09-18 04:07:24.715089
251	49	25	3	200	160	65	40	60	2000	1000	650	0	0	900000	75000	75000	75000	75000	3	90	2026-09-18 04:07:24.717304
252	49	48	5	750	1000	350	250	200	3750	1875	1250	750	0	3000000	180000	180000	180000	450000	5	90	2026-09-18 04:07:24.71928
253	49	55	4	400	400	100	100	150	4500	1875	550	0	0	1600000	120000	120000	120000	300000	4	90	2026-09-18 04:07:24.721535
254	49	67	6	4000	750	550	500	450	4250	1500	1500	950	400	4000000	200000	200000	200000	600000	6	90	2026-09-18 04:07:24.723766
255	49	70	7	12000	3000	750	800	750	5600	2800	1850	1100	700	4500000	500000	500000	500000	800000	7	90	2026-09-18 04:07:24.7261
256	49	89	2	50	45	40	30	25	1850	550	0	0	0	200000	30000	30000	30000	65000	2	90	2026-09-18 04:07:24.728132
257	50	42	4	400	400	100	100	150	4500	1875	550	0	0	1600000	120000	120000	120000	300000	4	90	2026-09-18 04:07:24.730258
258	50	45	10	400000	0	0	0	0	11000	5500	3666	2200	1375	19000000	600000	600000	600000	1500000	10	90	2026-09-18 04:07:24.732473
259	50	63	4	400	400	100	100	150	4500	1875	550	0	0	1600000	120000	120000	120000	300000	4	90	2026-09-18 04:07:24.734522
260	50	68	4	400	400	100	100	150	4500	1875	550	0	0	1600000	120000	120000	120000	300000	4	90	2026-09-18 04:07:24.736667
261	50	74	6	4000	750	550	500	450	4250	1500	1500	950	400	4000000	200000	200000	200000	600000	6	90	2026-09-18 04:07:24.739197
262	50	95	10	400000	0	0	0	0	11000	5500	3666	2200	1375	19000000	600000	600000	600000	1500000	10	90	2026-09-18 04:07:24.741441
263	51	22	2	50	45	40	30	25	1850	550	0	0	0	200000	30000	30000	30000	65000	2	90	2026-09-18 04:07:24.74363
264	51	40	5	750	1000	350	250	200	3750	1875	1250	750	0	3000000	180000	180000	180000	450000	5	90	2026-09-18 04:07:24.74569
265	51	47	1	50	40	35	15	8	1000	0	0	0	0	100000	20000	20000	20000	55000	1	90	2026-09-18 04:07:24.747898
266	51	63	3	200	160	65	40	60	2000	1000	650	0	0	900000	75000	75000	75000	75000	3	90	2026-09-18 04:07:24.749953
267	51	70	1	50	40	35	15	8	1000	0	0	0	0	100000	20000	20000	20000	55000	1	90	2026-09-18 04:07:24.752258
268	51	84	10	400000	0	0	0	0	11000	5500	3666	2200	1375	19000000	600000	600000	600000	1500000	10	90	2026-09-18 04:07:24.754871
269	51	86	5	750	1000	350	250	200	3750	1875	1250	750	0	3000000	180000	180000	180000	450000	5	90	2026-09-18 04:07:24.757135
270	52	6	6	4000	750	550	500	450	4250	1500	1500	950	400	4000000	200000	200000	200000	600000	6	90	2026-09-18 04:07:24.759345
271	52	42	2	50	45	40	30	25	1850	550	0	0	0	200000	30000	30000	30000	65000	2	90	2026-09-18 04:07:24.761766
272	52	54	5	750	1000	350	250	200	3750	1875	1250	750	0	3000000	180000	180000	180000	450000	5	90	2026-09-18 04:07:24.764208
273	52	70	9	60000	18000	2000	6750	2500	9000	4500	3000	1800	1150	14000000	550000	550000	550000	1200000	9	90	2026-09-18 04:07:24.766593
274	53	6	7	12000	3000	750	800	750	5600	2800	1850	1100	700	4500000	500000	500000	500000	800000	7	90	2026-09-18 04:07:24.769537
275	53	49	6	4000	750	550	500	450	4250	1500	1500	950	400	4000000	200000	200000	200000	600000	6	90	2026-09-18 04:07:24.772766
276	54	25	10	400000	0	0	0	0	11000	5500	3666	2200	1375	19000000	600000	600000	600000	1500000	10	90	2026-09-18 04:07:24.775348
277	54	77	9	60000	18000	2000	6750	2500	9000	4500	3000	1800	1150	14000000	550000	550000	550000	1200000	9	90	2026-09-18 04:07:24.777627
278	54	86	4	400	400	100	100	150	4500	1875	550	0	0	1600000	120000	120000	120000	300000	4	90	2026-09-18 04:07:24.779688
279	55	12	7	12000	3000	750	800	750	5600	2800	1850	1100	700	4500000	500000	500000	500000	800000	7	90	2026-09-18 04:07:24.781597
280	55	48	4	400	400	100	100	150	4500	1875	550	0	0	1600000	120000	120000	120000	300000	4	90	2026-09-18 04:07:24.784009
281	55	73	6	4000	750	550	500	450	4250	1500	1500	950	400	4000000	200000	200000	200000	600000	6	90	2026-09-18 04:07:24.786438
282	55	86	8	15000	6750	4000	3000	2000	7200	3600	2400	1440	900	8000000	800000	800000	800000	1000000	8	90	2026-09-18 04:07:24.789762
283	55	88	8	15000	6750	4000	3000	2000	7200	3600	2400	1440	900	8000000	800000	800000	800000	1000000	8	90	2026-09-18 04:07:24.792297
284	56	25	9	60000	18000	2000	6750	2500	9000	4500	3000	1800	1150	14000000	550000	550000	550000	1200000	9	90	2026-09-18 04:07:24.794767
285	56	44	6	4000	750	550	500	450	4250	1500	1500	950	400	4000000	200000	200000	200000	600000	6	90	2026-09-18 04:07:24.797242
286	56	78	8	15000	6750	4000	3000	2000	7200	3600	2400	1440	900	8000000	800000	800000	800000	1000000	8	90	2026-09-18 04:07:24.799554
287	56	95	7	12000	3000	750	800	750	5600	2800	1850	1100	700	4500000	500000	500000	500000	800000	7	90	2026-09-18 04:07:24.802093
288	57	17	6	4000	750	550	500	450	4250	1500	1500	950	400	4000000	200000	200000	200000	600000	6	90	2026-09-18 04:07:24.804874
289	57	31	2	50	45	40	30	25	1850	550	0	0	0	200000	30000	30000	30000	65000	2	90	2026-09-18 04:07:24.807307
290	57	53	8	15000	6750	4000	3000	2000	7200	3600	2400	1440	900	8000000	800000	800000	800000	1000000	8	90	2026-09-18 04:07:24.809861
291	57	64	2	50	45	40	30	25	1850	550	0	0	0	200000	30000	30000	30000	65000	2	90	2026-09-18 04:07:24.812414
292	57	66	2	50	45	40	30	25	1850	550	0	0	0	200000	30000	30000	30000	65000	2	90	2026-09-18 04:07:24.814877
293	58	30	10	400000	0	0	0	0	11000	5500	3666	2200	1375	19000000	600000	600000	600000	1500000	10	90	2026-09-18 04:07:24.817318
294	58	32	5	750	1000	350	250	200	3750	1875	1250	750	0	3000000	180000	180000	180000	450000	5	90	2026-09-18 04:07:24.819754
295	58	44	4	400	400	100	100	150	4500	1875	550	0	0	1600000	120000	120000	120000	300000	4	90	2026-09-18 04:07:24.822556
296	58	55	8	15000	6750	4000	3000	2000	7200	3600	2400	1440	900	8000000	800000	800000	800000	1000000	8	90	2026-09-18 04:07:24.824731
297	58	65	6	4000	750	550	500	450	4250	1500	1500	950	400	4000000	200000	200000	200000	600000	6	90	2026-09-18 04:07:24.82703
298	58	69	6	4000	750	550	500	450	4250	1500	1500	950	400	4000000	200000	200000	200000	600000	6	90	2026-09-18 04:07:24.829246
299	58	90	6	4000	750	550	500	450	4250	1500	1500	950	400	4000000	200000	200000	200000	600000	6	90	2026-09-18 04:07:24.831363
300	58	96	7	12000	3000	750	800	750	5600	2800	1850	1100	700	4500000	500000	500000	500000	800000	7	90	2026-09-18 04:07:24.833737
301	59	11	4	400	400	100	100	150	4500	1875	550	0	0	1600000	120000	120000	120000	300000	4	90	2026-09-18 04:07:24.836152
302	59	14	4	400	400	100	100	150	4500	1875	550	0	0	1600000	120000	120000	120000	300000	4	90	2026-09-18 04:07:24.838267
303	59	21	2	50	45	40	30	25	1850	550	0	0	0	200000	30000	30000	30000	65000	2	90	2026-09-18 04:07:24.840695
304	59	38	8	15000	6750	4000	3000	2000	7200	3600	2400	1440	900	8000000	800000	800000	800000	1000000	8	90	2026-09-18 04:07:24.843166
305	59	40	7	12000	3000	750	800	750	5600	2800	1850	1100	700	4500000	500000	500000	500000	800000	7	90	2026-09-18 04:07:24.845326
306	59	60	3	200	160	65	40	60	2000	1000	650	0	0	900000	75000	75000	75000	75000	3	90	2026-09-18 04:07:24.847535
307	59	68	10	400000	0	0	0	0	11000	5500	3666	2200	1375	19000000	600000	600000	600000	1500000	10	90	2026-09-18 04:07:24.849619
308	59	86	3	200	160	65	40	60	2000	1000	650	0	0	900000	75000	75000	75000	75000	3	90	2026-09-18 04:07:24.852051
309	59	96	9	60000	18000	2000	6750	2500	9000	4500	3000	1800	1150	14000000	550000	550000	550000	1200000	9	90	2026-09-18 04:07:24.854735
310	60	2	5	750	1000	350	250	200	3750	1875	1250	750	0	3000000	180000	180000	180000	450000	5	90	2026-09-18 04:07:24.856943
311	60	19	8	15000	6750	4000	3000	2000	7200	3600	2400	1440	900	8000000	800000	800000	800000	1000000	8	90	2026-09-18 04:07:24.859069
312	60	24	4	400	400	100	100	150	4500	1875	550	0	0	1600000	120000	120000	120000	300000	4	90	2026-09-18 04:07:24.861437
313	60	26	7	12000	3000	750	800	750	5600	2800	1850	1100	700	4500000	500000	500000	500000	800000	7	90	2026-09-18 04:07:24.863434
314	60	70	8	15000	6750	4000	3000	2000	7200	3600	2400	1440	900	8000000	800000	800000	800000	1000000	8	90	2026-09-18 04:07:24.865625
315	60	97	6	4000	750	550	500	450	4250	1500	1500	950	400	4000000	200000	200000	200000	600000	6	90	2026-09-18 04:07:24.868025
316	61	24	4	400	400	100	100	150	4500	1875	550	0	0	1600000	120000	120000	120000	300000	4	90	2026-09-18 04:07:24.870345
317	61	30	7	12000	3000	750	800	750	5600	2800	1850	1100	700	4500000	500000	500000	500000	800000	7	90	2026-09-18 04:07:24.87296
318	61	42	10	400000	0	0	0	0	11000	5500	3666	2200	1375	19000000	600000	600000	600000	1500000	10	90	2026-09-18 04:07:24.87527
319	61	51	10	400000	0	0	0	0	11000	5500	3666	2200	1375	19000000	600000	600000	600000	1500000	10	90	2026-09-18 04:07:24.877677
320	61	57	8	15000	6750	4000	3000	2000	7200	3600	2400	1440	900	8000000	800000	800000	800000	1000000	8	90	2026-09-18 04:07:24.879763
321	61	77	5	750	1000	350	250	200	3750	1875	1250	750	0	3000000	180000	180000	180000	450000	5	90	2026-09-18 04:07:24.882271
322	61	78	3	200	160	65	40	60	2000	1000	650	0	0	900000	75000	75000	75000	75000	3	90	2026-09-18 04:07:24.884485
323	62	27	2	50	45	40	30	25	1850	550	0	0	0	200000	30000	30000	30000	65000	2	90	2026-09-18 04:07:24.886763
324	62	36	2	50	45	40	30	25	1850	550	0	0	0	200000	30000	30000	30000	65000	2	90	2026-09-18 04:07:24.889525
325	62	44	5	750	1000	350	250	200	3750	1875	1250	750	0	3000000	180000	180000	180000	450000	5	90	2026-09-18 04:07:24.891754
326	62	77	6	4000	750	550	500	450	4250	1500	1500	950	400	4000000	200000	200000	200000	600000	6	90	2026-09-18 04:07:24.894116
327	62	78	7	12000	3000	750	800	750	5600	2800	1850	1100	700	4500000	500000	500000	500000	800000	7	90	2026-09-18 04:07:24.896201
328	63	10	4	400	400	100	100	150	4500	1875	550	0	0	1600000	120000	120000	120000	300000	4	90	2026-09-18 04:07:24.898624
329	63	33	8	15000	6750	4000	3000	2000	7200	3600	2400	1440	900	8000000	800000	800000	800000	1000000	8	90	2026-09-18 04:07:24.900844
331	63	76	7	12000	3000	750	800	750	5600	2800	1850	1100	700	4500000	500000	500000	500000	800000	7	90	2026-09-18 04:07:24.905952
332	64	8	1	50	40	35	15	8	1000	0	0	0	0	100000	20000	20000	20000	55000	1	90	2026-09-18 04:07:24.90853
333	64	10	2	50	45	40	30	25	1850	550	0	0	0	200000	30000	30000	30000	65000	2	90	2026-09-18 04:07:24.910918
334	64	25	9	60000	18000	2000	6750	2500	9000	4500	3000	1800	1150	14000000	550000	550000	550000	1200000	9	90	2026-09-18 04:07:24.91326
335	64	33	1	50	40	35	15	8	1000	0	0	0	0	100000	20000	20000	20000	55000	1	90	2026-09-18 04:07:24.915496
336	64	65	3	200	160	65	40	60	2000	1000	650	0	0	900000	75000	75000	75000	75000	3	90	2026-09-18 04:07:24.917992
337	64	73	10	400000	0	0	0	0	11000	5500	3666	2200	1375	19000000	600000	600000	600000	1500000	10	90	2026-09-18 04:07:24.920183
338	64	85	8	15000	6750	4000	3000	2000	7200	3600	2400	1440	900	8000000	800000	800000	800000	1000000	8	90	2026-09-18 04:07:24.922681
339	64	91	1	50	40	35	15	8	1000	0	0	0	0	100000	20000	20000	20000	55000	1	90	2026-09-18 04:07:24.924796
340	64	93	3	200	160	65	40	60	2000	1000	650	0	0	900000	75000	75000	75000	75000	3	90	2026-09-18 04:07:24.929977
341	64	95	9	60000	18000	2000	6750	2500	9000	4500	3000	1800	1150	14000000	550000	550000	550000	1200000	9	90	2026-09-18 04:07:24.932338
342	65	40	1	50	40	35	15	8	1000	0	0	0	0	100000	20000	20000	20000	55000	1	90	2026-09-18 04:07:24.934781
343	65	45	4	400	400	100	100	150	4500	1875	550	0	0	1600000	120000	120000	120000	300000	4	90	2026-09-18 04:07:24.937698
344	65	69	3	200	160	65	40	60	2000	1000	650	0	0	900000	75000	75000	75000	75000	3	90	2026-09-18 04:07:24.939901
345	65	90	10	400000	0	0	0	0	11000	5500	3666	2200	1375	19000000	600000	600000	600000	1500000	10	90	2026-09-18 04:07:24.941963
346	66	13	6	4000	750	550	500	450	4250	1500	1500	950	400	4000000	200000	200000	200000	600000	6	90	2026-09-18 04:07:24.944046
347	66	33	1	50	40	35	15	8	1000	0	0	0	0	100000	20000	20000	20000	55000	1	90	2026-09-18 04:07:24.946265
348	66	70	3	200	160	65	40	60	2000	1000	650	0	0	900000	75000	75000	75000	75000	3	90	2026-09-18 04:07:24.948373
349	66	80	2	50	45	40	30	25	1850	550	0	0	0	200000	30000	30000	30000	65000	2	90	2026-09-18 04:07:24.950397
350	67	13	3	200	160	65	40	60	2000	1000	650	0	0	900000	75000	75000	75000	75000	3	90	2026-09-18 04:07:24.952653
351	67	86	8	15000	6750	4000	3000	2000	7200	3600	2400	1440	900	8000000	800000	800000	800000	1000000	8	90	2026-09-18 04:07:24.954865
352	67	92	8	15000	6750	4000	3000	2000	7200	3600	2400	1440	900	8000000	800000	800000	800000	1000000	8	90	2026-09-18 04:07:24.957047
353	68	20	6	4000	750	550	500	450	4250	1500	1500	950	400	4000000	200000	200000	200000	600000	6	90	2026-09-18 04:07:24.959385
354	68	36	2	50	45	40	30	25	1850	550	0	0	0	200000	30000	30000	30000	65000	2	90	2026-09-18 04:07:24.96184
355	68	38	7	12000	3000	750	800	750	5600	2800	1850	1100	700	4500000	500000	500000	500000	800000	7	90	2026-09-18 04:07:24.963873
356	69	10	9	60000	18000	2000	6750	2500	9000	4500	3000	1800	1150	14000000	550000	550000	550000	1200000	9	90	2026-09-18 04:07:24.966201
357	69	22	8	15000	6750	4000	3000	2000	7200	3600	2400	1440	900	8000000	800000	800000	800000	1000000	8	90	2026-09-18 04:07:24.9686
358	69	45	8	15000	6750	4000	3000	2000	7200	3600	2400	1440	900	8000000	800000	800000	800000	1000000	8	90	2026-09-18 04:07:24.971303
360	69	71	7	12000	3000	750	800	750	5600	2800	1850	1100	700	4500000	500000	500000	500000	800000	7	90	2026-09-18 04:07:24.975647
361	69	92	10	400000	0	0	0	0	11000	5500	3666	2200	1375	19000000	600000	600000	600000	1500000	10	90	2026-09-18 04:07:24.978092
362	69	99	3	200	160	65	40	60	2000	1000	650	0	0	900000	75000	75000	75000	75000	3	90	2026-09-18 04:07:24.980444
363	70	14	7	12000	3000	750	800	750	5600	2800	1850	1100	700	4500000	500000	500000	500000	800000	7	90	2026-09-18 04:07:24.982826
364	70	29	1	50	40	35	15	8	1000	0	0	0	0	100000	20000	20000	20000	55000	1	90	2026-09-18 04:07:24.985393
365	71	0	7	12000	3000	750	800	750	5600	2800	1850	1100	700	4500000	500000	500000	500000	800000	7	90	2026-09-18 04:07:24.988211
367	71	91	1	50	40	35	15	8	1000	0	0	0	0	100000	20000	20000	20000	55000	1	90	2026-09-18 04:07:24.993092
368	72	14	4	400	400	100	100	150	4500	1875	550	0	0	1600000	120000	120000	120000	300000	4	90	2026-09-18 04:07:24.995551
369	72	41	7	12000	3000	750	800	750	5600	2800	1850	1100	700	4500000	500000	500000	500000	800000	7	90	2026-09-18 04:07:24.997679
370	72	42	5	750	1000	350	250	200	3750	1875	1250	750	0	3000000	180000	180000	180000	450000	5	90	2026-09-18 04:07:24.999873
371	72	43	7	12000	3000	750	800	750	5600	2800	1850	1100	700	4500000	500000	500000	500000	800000	7	90	2026-09-18 04:07:25.002066
372	72	85	2	50	45	40	30	25	1850	550	0	0	0	200000	30000	30000	30000	65000	2	90	2026-09-18 04:07:25.005045
373	72	88	4	400	400	100	100	150	4500	1875	550	0	0	1600000	120000	120000	120000	300000	4	90	2026-09-18 04:07:25.007791
374	72	94	8	15000	6750	4000	3000	2000	7200	3600	2400	1440	900	8000000	800000	800000	800000	1000000	8	90	2026-09-18 04:07:25.010629
375	72	97	10	400000	0	0	0	0	11000	5500	3666	2200	1375	19000000	600000	600000	600000	1500000	10	90	2026-09-18 04:07:25.013123
376	73	3	7	12000	3000	750	800	750	5600	2800	1850	1100	700	4500000	500000	500000	500000	800000	7	90	2026-09-18 04:07:25.015821
377	73	4	5	750	1000	350	250	200	3750	1875	1250	750	0	3000000	180000	180000	180000	450000	5	90	2026-09-18 04:07:25.018334
378	73	21	9	60000	18000	2000	6750	2500	9000	4500	3000	1800	1150	14000000	550000	550000	550000	1200000	9	90	2026-09-18 04:07:25.021264
379	73	28	5	750	1000	350	250	200	3750	1875	1250	750	0	3000000	180000	180000	180000	450000	5	90	2026-09-18 04:07:25.022959
380	73	66	8	15000	6750	4000	3000	2000	7200	3600	2400	1440	900	8000000	800000	800000	800000	1000000	8	90	2026-09-18 04:07:25.024845
381	73	76	8	15000	6750	4000	3000	2000	7200	3600	2400	1440	900	8000000	800000	800000	800000	1000000	8	90	2026-09-18 04:07:25.026728
382	73	88	4	400	400	100	100	150	4500	1875	550	0	0	1600000	120000	120000	120000	300000	4	90	2026-09-18 04:07:25.02887
383	74	8	7	12000	3000	750	800	750	5600	2800	1850	1100	700	4500000	500000	500000	500000	800000	7	90	2026-09-18 04:07:25.03097
385	74	98	9	60000	18000	2000	6750	2500	9000	4500	3000	1800	1150	14000000	550000	550000	550000	1200000	9	90	2026-09-18 04:07:25.035454
386	75	2	9	60000	18000	2000	6750	2500	9000	4500	3000	1800	1150	14000000	550000	550000	550000	1200000	9	90	2026-09-18 04:07:25.038248
387	75	44	1	50	40	35	15	8	1000	0	0	0	0	100000	20000	20000	20000	55000	1	90	2026-09-18 04:07:25.040616
389	75	81	10	400000	0	0	0	0	11000	5500	3666	2200	1375	19000000	600000	600000	600000	1500000	10	90	2026-09-18 04:07:25.045026
390	76	15	2	50	45	40	30	25	1850	550	0	0	0	200000	30000	30000	30000	65000	2	90	2026-09-18 04:07:25.047134
391	76	23	10	400000	0	0	0	0	11000	5500	3666	2200	1375	19000000	600000	600000	600000	1500000	10	90	2026-09-18 04:07:25.049205
392	76	30	9	60000	18000	2000	6750	2500	9000	4500	3000	1800	1150	14000000	550000	550000	550000	1200000	9	90	2026-09-18 04:07:25.051503
393	76	37	1	50	40	35	15	8	1000	0	0	0	0	100000	20000	20000	20000	55000	1	90	2026-09-18 04:07:25.054209
394	76	39	7	12000	3000	750	800	750	5600	2800	1850	1100	700	4500000	500000	500000	500000	800000	7	90	2026-09-18 04:07:25.056608
395	76	55	4	400	400	100	100	150	4500	1875	550	0	0	1600000	120000	120000	120000	300000	4	90	2026-09-18 04:07:25.059013
396	77	2	7	12000	3000	750	800	750	5600	2800	1850	1100	700	4500000	500000	500000	500000	800000	7	90	2026-09-18 04:07:25.061362
397	77	79	3	200	160	65	40	60	2000	1000	650	0	0	900000	75000	75000	75000	75000	3	90	2026-09-18 04:07:25.06354
398	78	5	10	400000	0	0	0	0	11000	5500	3666	2200	1375	19000000	600000	600000	600000	1500000	10	90	2026-09-18 04:07:25.066047
399	78	18	8	15000	6750	4000	3000	2000	7200	3600	2400	1440	900	8000000	800000	800000	800000	1000000	8	90	2026-09-18 04:07:25.068144
400	78	38	3	200	160	65	40	60	2000	1000	650	0	0	900000	75000	75000	75000	75000	3	90	2026-09-18 04:07:25.070911
401	78	79	5	750	1000	350	250	200	3750	1875	1250	750	0	3000000	180000	180000	180000	450000	5	90	2026-09-18 04:07:25.073078
402	78	85	9	60000	18000	2000	6750	2500	9000	4500	3000	1800	1150	14000000	550000	550000	550000	1200000	9	90	2026-09-18 04:07:25.075605
403	78	98	5	750	1000	350	250	200	3750	1875	1250	750	0	3000000	180000	180000	180000	450000	5	90	2026-09-18 04:07:25.077852
404	79	29	8	15000	6750	4000	3000	2000	7200	3600	2400	1440	900	8000000	800000	800000	800000	1000000	8	90	2026-09-18 04:07:25.080058
405	79	51	6	4000	750	550	500	450	4250	1500	1500	950	400	4000000	200000	200000	200000	600000	6	90	2026-09-18 04:07:25.082254
406	79	52	4	400	400	100	100	150	4500	1875	550	0	0	1600000	120000	120000	120000	300000	4	90	2026-09-18 04:07:25.084444
359	69	50	1	15	12	11	5	3	1000	0	0	0	0	99800	19960	19960	19960	54890	1	100	2026-09-18 19:54:39.792471
388	75	56	1	50	40	35	15	8	1000	0	0	0	0	100000	20000	20000	20000	55000	1	100	2026-09-19 10:31:31.385517
407	79	87	9	60000	18000	2000	6750	2500	9000	4500	3000	1800	1150	14000000	550000	550000	550000	1200000	9	90	2026-09-18 04:07:25.086771
408	80	6	8	15000	6750	4000	3000	2000	7200	3600	2400	1440	900	8000000	800000	800000	800000	1000000	8	90	2026-09-18 04:07:25.08959
409	80	27	4	400	400	100	100	150	4500	1875	550	0	0	1600000	120000	120000	120000	300000	4	90	2026-09-18 04:07:25.09256
410	80	38	7	12000	3000	750	800	750	5600	2800	1850	1100	700	4500000	500000	500000	500000	800000	7	90	2026-09-18 04:07:25.094785
411	80	64	9	60000	18000	2000	6750	2500	9000	4500	3000	1800	1150	14000000	550000	550000	550000	1200000	9	90	2026-09-18 04:07:25.097238
412	80	82	3	200	160	65	40	60	2000	1000	650	0	0	900000	75000	75000	75000	75000	3	90	2026-09-18 04:07:25.09944
413	80	84	3	200	160	65	40	60	2000	1000	650	0	0	900000	75000	75000	75000	75000	3	90	2026-09-18 04:07:25.101826
414	80	90	6	4000	750	550	500	450	4250	1500	1500	950	400	4000000	200000	200000	200000	600000	6	90	2026-09-18 04:07:25.104617
415	81	10	3	200	160	65	40	60	2000	1000	650	0	0	900000	75000	75000	75000	75000	3	90	2026-09-18 04:07:25.107257
416	81	53	8	15000	6750	4000	3000	2000	7200	3600	2400	1440	900	8000000	800000	800000	800000	1000000	8	90	2026-09-18 04:07:25.109574
417	81	60	5	750	1000	350	250	200	3750	1875	1250	750	0	3000000	180000	180000	180000	450000	5	90	2026-09-18 04:07:25.111973
418	81	82	5	750	1000	350	250	200	3750	1875	1250	750	0	3000000	180000	180000	180000	450000	5	90	2026-09-18 04:07:25.114393
419	81	86	1	50	40	35	15	8	1000	0	0	0	0	100000	20000	20000	20000	55000	1	90	2026-09-18 04:07:25.117019
420	81	87	5	750	1000	350	250	200	3750	1875	1250	750	0	3000000	180000	180000	180000	450000	5	90	2026-09-18 04:07:25.119553
421	81	94	1	50	40	35	15	8	1000	0	0	0	0	100000	20000	20000	20000	55000	1	90	2026-09-18 04:07:25.122549
422	82	6	10	400000	0	0	0	0	11000	5500	3666	2200	1375	19000000	600000	600000	600000	1500000	10	90	2026-09-18 04:07:25.124678
423	82	10	3	200	160	65	40	60	2000	1000	650	0	0	900000	75000	75000	75000	75000	3	90	2026-09-18 04:07:25.127212
424	82	17	5	750	1000	350	250	200	3750	1875	1250	750	0	3000000	180000	180000	180000	450000	5	90	2026-09-18 04:07:25.129603
425	82	27	5	750	1000	350	250	200	3750	1875	1250	750	0	3000000	180000	180000	180000	450000	5	90	2026-09-18 04:07:25.131757
426	82	81	5	750	1000	350	250	200	3750	1875	1250	750	0	3000000	180000	180000	180000	450000	5	90	2026-09-18 04:07:25.133881
427	82	87	5	750	1000	350	250	200	3750	1875	1250	750	0	3000000	180000	180000	180000	450000	5	90	2026-09-18 04:07:25.136007
428	82	97	5	750	1000	350	250	200	3750	1875	1250	750	0	3000000	180000	180000	180000	450000	5	90	2026-09-18 04:07:25.138935
429	83	15	8	15000	6750	4000	3000	2000	7200	3600	2400	1440	900	8000000	800000	800000	800000	1000000	8	90	2026-09-18 04:07:25.14122
430	83	18	8	15000	6750	4000	3000	2000	7200	3600	2400	1440	900	8000000	800000	800000	800000	1000000	8	90	2026-09-18 04:07:25.143687
431	83	52	5	750	1000	350	250	200	3750	1875	1250	750	0	3000000	180000	180000	180000	450000	5	90	2026-09-18 04:07:25.145824
432	84	22	3	200	160	65	40	60	2000	1000	650	0	0	900000	75000	75000	75000	75000	3	90	2026-09-18 04:07:25.148028
433	84	44	4	400	400	100	100	150	4500	1875	550	0	0	1600000	120000	120000	120000	300000	4	90	2026-09-18 04:07:25.150164
434	84	63	1	50	40	35	15	8	1000	0	0	0	0	100000	20000	20000	20000	55000	1	90	2026-09-18 04:07:25.152248
435	84	97	10	400000	0	0	0	0	11000	5500	3666	2200	1375	19000000	600000	600000	600000	1500000	10	90	2026-09-18 04:07:25.154893
436	85	18	5	750	1000	350	250	200	3750	1875	1250	750	0	3000000	180000	180000	180000	450000	5	90	2026-09-18 04:07:25.157558
437	85	23	8	15000	6750	4000	3000	2000	7200	3600	2400	1440	900	8000000	800000	800000	800000	1000000	8	90	2026-09-18 04:07:25.159861
438	85	37	4	400	400	100	100	150	4500	1875	550	0	0	1600000	120000	120000	120000	300000	4	90	2026-09-18 04:07:25.162248
439	85	70	7	12000	3000	750	800	750	5600	2800	1850	1100	700	4500000	500000	500000	500000	800000	7	90	2026-09-18 04:07:25.164583
440	85	72	1	50	40	35	15	8	1000	0	0	0	0	100000	20000	20000	20000	55000	1	90	2026-09-18 04:07:25.166856
441	85	97	6	4000	750	550	500	450	4250	1500	1500	950	400	4000000	200000	200000	200000	600000	6	90	2026-09-18 04:07:25.16931
442	86	17	4	400	400	100	100	150	4500	1875	550	0	0	1600000	120000	120000	120000	300000	4	90	2026-09-18 04:07:25.172213
443	86	22	10	400000	0	0	0	0	11000	5500	3666	2200	1375	19000000	600000	600000	600000	1500000	10	90	2026-09-18 04:07:25.174329
444	86	35	3	200	160	65	40	60	2000	1000	650	0	0	900000	75000	75000	75000	75000	3	90	2026-09-18 04:07:25.176671
445	86	42	9	60000	18000	2000	6750	2500	9000	4500	3000	1800	1150	14000000	550000	550000	550000	1200000	9	90	2026-09-18 04:07:25.178879
446	86	75	4	400	400	100	100	150	4500	1875	550	0	0	1600000	120000	120000	120000	300000	4	90	2026-09-18 04:07:25.181138
447	86	88	9	60000	18000	2000	6750	2500	9000	4500	3000	1800	1150	14000000	550000	550000	550000	1200000	9	90	2026-09-18 04:07:25.183718
448	86	93	4	400	400	100	100	150	4500	1875	550	0	0	1600000	120000	120000	120000	300000	4	90	2026-09-18 04:07:25.186011
449	87	50	3	200	160	65	40	60	2000	1000	650	0	0	900000	75000	75000	75000	75000	3	90	2026-09-18 04:07:25.188774
450	87	53	8	15000	6750	4000	3000	2000	7200	3600	2400	1440	900	8000000	800000	800000	800000	1000000	8	90	2026-09-18 04:07:25.191106
451	88	15	8	15000	6750	4000	3000	2000	7200	3600	2400	1440	900	8000000	800000	800000	800000	1000000	8	90	2026-09-18 04:07:25.193474
452	88	47	5	750	1000	350	250	200	3750	1875	1250	750	0	3000000	180000	180000	180000	450000	5	90	2026-09-18 04:07:25.19568
453	88	50	10	400000	0	0	0	0	11000	5500	3666	2200	1375	19000000	600000	600000	600000	1500000	10	90	2026-09-18 04:07:25.197753
454	88	66	2	50	45	40	30	25	1850	550	0	0	0	200000	30000	30000	30000	65000	2	90	2026-09-18 04:07:25.19996
455	88	83	4	400	400	100	100	150	4500	1875	550	0	0	1600000	120000	120000	120000	300000	4	90	2026-09-18 04:07:25.202303
456	89	0	3	200	160	65	40	60	2000	1000	650	0	0	900000	75000	75000	75000	75000	3	90	2026-09-18 04:07:25.204636
457	89	7	1	50	40	35	15	8	1000	0	0	0	0	100000	20000	20000	20000	55000	1	90	2026-09-18 04:07:25.206987
458	89	28	2	50	45	40	30	25	1850	550	0	0	0	200000	30000	30000	30000	65000	2	90	2026-09-18 04:07:25.209382
459	89	38	6	4000	750	550	500	450	4250	1500	1500	950	400	4000000	200000	200000	200000	600000	6	90	2026-09-18 04:07:25.211707
460	89	48	2	50	45	40	30	25	1850	550	0	0	0	200000	30000	30000	30000	65000	2	90	2026-09-18 04:07:25.214797
461	90	7	2	50	45	40	30	25	1850	550	0	0	0	200000	30000	30000	30000	65000	2	90	2026-09-18 04:07:25.216972
462	90	10	10	400000	0	0	0	0	11000	5500	3666	2200	1375	19000000	600000	600000	600000	1500000	10	90	2026-09-18 04:07:25.219028
463	90	14	2	50	45	40	30	25	1850	550	0	0	0	200000	30000	30000	30000	65000	2	90	2026-09-18 04:07:25.221093
464	90	34	9	60000	18000	2000	6750	2500	9000	4500	3000	1800	1150	14000000	550000	550000	550000	1200000	9	90	2026-09-18 04:07:25.223216
465	90	66	1	50	40	35	15	8	1000	0	0	0	0	100000	20000	20000	20000	55000	1	90	2026-09-18 04:07:25.225334
466	90	87	3	200	160	65	40	60	2000	1000	650	0	0	900000	75000	75000	75000	75000	3	90	2026-09-18 04:07:25.227389
467	91	9	7	12000	3000	750	800	750	5600	2800	1850	1100	700	4500000	500000	500000	500000	800000	7	90	2026-09-18 04:07:25.229618
468	91	10	8	15000	6750	4000	3000	2000	7200	3600	2400	1440	900	8000000	800000	800000	800000	1000000	8	90	2026-09-18 04:07:25.231814
469	91	14	5	750	1000	350	250	200	3750	1875	1250	750	0	3000000	180000	180000	180000	450000	5	90	2026-09-18 04:07:25.233776
470	91	35	3	200	160	65	40	60	2000	1000	650	0	0	900000	75000	75000	75000	75000	3	90	2026-09-18 04:07:25.235544
471	91	44	1	50	40	35	15	8	1000	0	0	0	0	100000	20000	20000	20000	55000	1	90	2026-09-18 04:07:25.237751
472	91	58	10	400000	0	0	0	0	11000	5500	3666	2200	1375	19000000	600000	600000	600000	1500000	10	90	2026-09-18 04:07:25.24011
473	92	15	3	200	160	65	40	60	2000	1000	650	0	0	900000	75000	75000	75000	75000	3	90	2026-09-18 04:07:25.242112
474	92	33	5	750	1000	350	250	200	3750	1875	1250	750	0	3000000	180000	180000	180000	450000	5	90	2026-09-18 04:07:25.244158
475	92	40	6	4000	750	550	500	450	4250	1500	1500	950	400	4000000	200000	200000	200000	600000	6	90	2026-09-18 04:07:25.245869
476	92	49	1	50	40	35	15	8	1000	0	0	0	0	100000	20000	20000	20000	55000	1	90	2026-09-18 04:07:25.247644
477	92	76	9	60000	18000	2000	6750	2500	9000	4500	3000	1800	1150	14000000	550000	550000	550000	1200000	9	90	2026-09-18 04:07:25.249503
478	92	81	3	200	160	65	40	60	2000	1000	650	0	0	900000	75000	75000	75000	75000	3	90	2026-09-18 04:07:25.251467
479	93	5	3	200	160	65	40	60	2000	1000	650	0	0	900000	75000	75000	75000	75000	3	90	2026-09-18 04:07:25.253727
480	93	12	5	750	1000	350	250	200	3750	1875	1250	750	0	3000000	180000	180000	180000	450000	5	90	2026-09-18 04:07:25.255503
481	93	49	9	60000	18000	2000	6750	2500	9000	4500	3000	1800	1150	14000000	550000	550000	550000	1200000	9	90	2026-09-18 04:07:25.257218
482	93	61	9	60000	18000	2000	6750	2500	9000	4500	3000	1800	1150	14000000	550000	550000	550000	1200000	9	90	2026-09-18 04:07:25.259185
483	93	81	10	400000	0	0	0	0	11000	5500	3666	2200	1375	19000000	600000	600000	600000	1500000	10	90	2026-09-18 04:07:25.261374
484	93	88	5	750	1000	350	250	200	3750	1875	1250	750	0	3000000	180000	180000	180000	450000	5	90	2026-09-18 04:07:25.263136
485	94	41	6	4000	750	550	500	450	4250	1500	1500	950	400	4000000	200000	200000	200000	600000	6	90	2026-09-18 04:07:25.265075
486	94	54	8	15000	6750	4000	3000	2000	7200	3600	2400	1440	900	8000000	800000	800000	800000	1000000	8	90	2026-09-18 04:07:25.266981
487	94	92	4	400	400	100	100	150	4500	1875	550	0	0	1600000	120000	120000	120000	300000	4	90	2026-09-18 04:07:25.268793
488	94	94	10	400000	0	0	0	0	11000	5500	3666	2200	1375	19000000	600000	600000	600000	1500000	10	90	2026-09-18 04:07:25.271193
489	95	0	5	750	1000	350	250	200	3750	1875	1250	750	0	3000000	180000	180000	180000	450000	5	90	2026-09-18 04:07:25.272962
490	95	25	3	200	160	65	40	60	2000	1000	650	0	0	900000	75000	75000	75000	75000	3	90	2026-09-18 04:07:25.274955
491	96	9	6	4000	750	550	500	450	4250	1500	1500	950	400	4000000	200000	200000	200000	600000	6	90	2026-09-18 04:07:25.276716
492	96	46	5	750	1000	350	250	200	3750	1875	1250	750	0	3000000	180000	180000	180000	450000	5	90	2026-09-18 04:07:25.278733
493	97	5	2	50	45	40	30	25	1850	550	0	0	0	200000	30000	30000	30000	65000	2	90	2026-09-18 04:07:25.281043
494	97	12	5	750	1000	350	250	200	3750	1875	1250	750	0	3000000	180000	180000	180000	450000	5	90	2026-09-18 04:07:25.283395
495	97	39	8	15000	6750	4000	3000	2000	7200	3600	2400	1440	900	8000000	800000	800000	800000	1000000	8	90	2026-09-18 04:07:25.285609
496	97	82	7	12000	3000	750	800	750	5600	2800	1850	1100	700	4500000	500000	500000	500000	800000	7	90	2026-09-18 04:07:25.287749
497	97	88	6	4000	750	550	500	450	4250	1500	1500	950	400	4000000	200000	200000	200000	600000	6	90	2026-09-18 04:07:25.289751
498	97	93	10	400000	0	0	0	0	11000	5500	3666	2200	1375	19000000	600000	600000	600000	1500000	10	90	2026-09-18 04:07:25.291858
499	98	48	8	15000	6750	4000	3000	2000	7200	3600	2400	1440	900	8000000	800000	800000	800000	1000000	8	90	2026-09-18 04:07:25.294164
500	98	67	1	50	40	35	15	8	1000	0	0	0	0	100000	20000	20000	20000	55000	1	90	2026-09-18 04:07:25.296431
501	98	99	9	60000	18000	2000	6750	2500	9000	4500	3000	1800	1150	14000000	550000	550000	550000	1200000	9	90	2026-09-18 04:07:25.299012
502	99	1	7	12000	3000	750	800	750	5600	2800	1850	1100	700	4500000	500000	500000	500000	800000	7	90	2026-09-18 04:07:25.30157
503	99	2	6	4000	750	550	500	450	4250	1500	1500	950	400	4000000	200000	200000	200000	600000	6	90	2026-09-18 04:07:25.304232
504	99	57	4	400	400	100	100	150	4500	1875	550	0	0	1600000	120000	120000	120000	300000	4	90	2026-09-18 04:07:25.306483
505	99	74	1	50	40	35	15	8	1000	0	0	0	0	100000	20000	20000	20000	55000	1	90	2026-09-18 04:07:25.308927
506	99	83	1	50	40	35	15	8	1000	0	0	0	0	100000	20000	20000	20000	55000	1	90	2026-09-18 04:07:25.311163
507	99	99	3	200	160	65	40	60	2000	1000	650	0	0	900000	75000	75000	75000	75000	3	90	2026-09-18 04:07:25.313343
366	71	60	4	400	400	100	100	150	4500	1875	550	0	0	1600000	120000	120000	120000	300000	4	93	2026-09-18 04:15:25.462682
330	63	46	1	50	40	35	15	8	1000	0	0	0	0	100000	20000	20000	20000	55000	1	100	2026-09-18 19:40:33.524021
384	74	53	6	4000	750	550	500	450	4250	1500	1500	950	400	4000000	200000	200000	200000	600000	6	100	2026-09-19 10:31:41.747521
\.


--
-- Data for Name: player_bonus_totals; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.player_bonus_totals (id, player_id, bonus_type, total_value) FROM stdin;
5	12	INFORMATICS_EFFECTIVENESS	0.00
1	12	FARM_EFFECTIVENESS	6.00
3	12	SAWMILL_EFFECTIVENESS	2.00
18	12	CASUALTY_SAVE_RATE	1.00
12	12	POLITICS	20.00
7	12	COMPASS_EFFECTIVENESS	40.00
46	12	QUARRY_EFFECTIVENESS	6.00
6	12	POPULATION_EFFECTIVENESS	19.00
28	12	IRON_MINE_EFFECTIVENESS	6.00
11	12	INTELLIGENCE	77.00
4	12	CRAFTSMANSHIP_SPEED	81.00
25	12	ATTACK	102.00
19	12	CONSTRUCTION_SPEED	89.00
10	12	TAX_EFFICIENCY	45.20
\.


--
-- Data for Name: player_completed_research_nodes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.player_completed_research_nodes (player_id, research_node_id, completed_at) FROM stdin;
12	10	2026-09-04 20:38:54.524656
12	99	2026-09-05 12:11:47.80604
12	46	2026-09-05 12:47:43.006778
12	128	2026-09-05 12:51:03.048842
12	54	2026-09-06 13:21:30.579337
12	50	2026-09-06 13:47:13.307096
12	66	2026-09-06 13:57:44.586596
12	334	2026-09-06 14:09:21.041362
12	14	2026-09-06 19:02:51.772882
12	34	2026-09-07 19:47:53.470625
12	158	2026-09-07 19:50:38.550423
12	98	2026-09-07 19:54:19.135578
12	118	2026-09-07 19:55:44.140054
12	108	2026-09-07 20:00:39.279763
12	332	2026-09-09 06:30:50.569514
12	333	2026-09-09 07:14:31.211301
12	219	2026-09-10 11:34:30.374617
12	417	2026-09-12 10:26:14.046795
12	30	2026-09-12 15:27:27.941671
12	298	2026-09-12 21:59:21.456499
12	93	2026-09-13 04:37:12.430339
12	88	2026-09-13 12:42:15.161198
12	129	2026-09-13 15:43:10.553148
12	138	2026-09-13 15:52:35.858438
12	168	2026-09-13 16:01:01.348512
12	148	2026-09-13 16:04:21.608476
12	679	2026-09-13 16:15:07.631078
12	384	2026-09-13 23:20:01.654548
12	416	2026-09-13 23:22:06.438178
12	270	2026-09-13 23:24:41.679984
12	269	2026-09-14 00:42:22.070241
12	415	2026-09-14 00:46:37.535381
12	1	2026-09-14 03:31:38.232248
12	625	2026-09-14 13:09:43.670295
12	680	2026-09-14 14:16:12.518718
12	170	2026-09-14 14:19:57.792025
12	47	2026-09-14 14:25:02.350739
12	296	2026-09-14 16:11:23.665122
12	4	2026-09-14 16:15:30.252721
12	3	2026-09-14 16:27:12.513657
12	2	2026-09-14 16:32:23.481801
12	268	2026-09-14 17:16:31.540777
12	535	2026-09-14 17:22:32.616663
12	385	2026-09-14 17:28:29.033866
12	386	2026-09-14 17:31:34.772568
12	505	2026-09-14 21:07:41.533607
12	387	2026-09-14 21:10:06.645663
12	388	2026-09-15 18:17:40.505724
12	389	2026-09-15 18:55:14.099251
12	100	2026-09-15 19:44:03.331317
12	119	2026-09-15 20:55:56.138831
12	537	2026-09-17 01:38:48.817323
12	169	2026-09-17 15:32:59.745015
12	120	2026-09-18 13:47:16.566357
12	159	2026-09-18 13:58:29.547502
12	62	2026-09-18 14:02:30.584564
12	160	2026-09-18 14:47:23.697157
12	392	2026-09-18 15:01:08.876719
12	18	2026-09-19 10:47:24.438287
12	139	2026-09-19 10:51:44.487542
\.


--
-- Data for Name: player_researches; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.player_researches (id, player_id, research_node_id, progress, started_at, completed_at) FROM stdin;
\.


--
-- Data for Name: players; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.players (id, username, password_hash, title, prestige, honor, alliance, created_at, last_login) FROM stdin;
6	testuser5	$2b$10$NsDlK916sdFyGQ8TDEyW.Omgywl/0W1NloRgXYRLB8Pq.Se8xjOwC	Squire	0	0	\N	2026-08-29 15:26:15.900901	\N
7	final_test	$2b$10$ACwipLrm8ZU/f2yQYZygFe8espX8gYxXfRoH4KBuI4SFiGMfWJW/W	Squire	0	0	\N	2026-08-29 15:31:49.347263	\N
8	testuser6	$2b$10$0sQp56evKbUVCIqOSUAequbK3xpH0Buzjia1JWas9ZmT7.pka2sPq	Squire	0	0	\N	2026-08-29 15:36:19.351189	\N
9	lord1	$2b$10$FmZhhX3LDRavH9u7JkXJxuBZbV69Ao5j.x0TtAT.JpyBN7U5bfcku	Squire	0	0	\N	2026-08-29 16:04:12.648237	\N
10	admin	$2b$10$4pALGP9bqtk0YRmC0tuuIuglDq9AZiAysuy2F2rPMA1NiRw5Sx1Ka	Squire	0	0	\N	2026-08-29 17:26:30.207005	\N
12	steve	$2b$10$zYke1PR8vxwr505t9rlPPeIk5pLiZweiwFVzqwVdVkmIOleIfsGxS	Squire	0	0	\N	2026-08-29 18:50:59.97493	\N
\.


--
-- Data for Name: recruitment_queue; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.recruitment_queue (id, city_id, unit_type_id, quantity, started_at, finish_at, building_id) FROM stdin;
41	11	10	100	2026-09-19 10:48:02.892	2026-09-19 14:08:02.892	213
\.


--
-- Data for Name: research_node_prerequisites; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.research_node_prerequisites (research_node_id, prerequisite_node_id, id, requirement_type, required_academy_level, required_building_type_id, required_building_level) FROM stdin;
2	1	1	RESEARCH	\N	\N	\N
3	1	2	RESEARCH	\N	\N	\N
4	1	3	RESEARCH	\N	\N	\N
39	38	1213	RESEARCH	\N	\N	\N
40	39	1214	RESEARCH	\N	\N	\N
41	40	1215	RESEARCH	\N	\N	\N
5	1	7	RESEARCH	\N	\N	\N
195	27	8	RESEARCH	\N	\N	\N
43	42	1216	RESEARCH	\N	\N	\N
44	43	1217	RESEARCH	\N	\N	\N
45	44	1218	RESEARCH	\N	\N	\N
187	5	12	RESEARCH	\N	\N	\N
190	187	13	RESEARCH	\N	\N	\N
189	187	14	RESEARCH	\N	\N	\N
188	187	15	RESEARCH	\N	\N	\N
27	187	16	RESEARCH	\N	\N	\N
28	195	17	RESEARCH	\N	\N	\N
198	195	18	RESEARCH	\N	\N	\N
197	195	19	RESEARCH	\N	\N	\N
196	195	20	RESEARCH	\N	\N	\N
203	28	21	RESEARCH	\N	\N	\N
47	46	1219	RESEARCH	\N	\N	\N
48	47	1220	RESEARCH	\N	\N	\N
49	48	1221	RESEARCH	\N	\N	\N
29	203	25	RESEARCH	\N	\N	\N
206	203	26	RESEARCH	\N	\N	\N
205	203	27	RESEARCH	\N	\N	\N
204	203	28	RESEARCH	\N	\N	\N
51	50	1222	RESEARCH	\N	\N	\N
52	51	1223	RESEARCH	\N	\N	\N
53	52	1224	RESEARCH	\N	\N	\N
67	66	1225	RESEARCH	\N	\N	\N
68	67	1226	RESEARCH	\N	\N	\N
69	68	1227	RESEARCH	\N	\N	\N
99	98	1228	RESEARCH	\N	\N	\N
100	99	1229	RESEARCH	\N	\N	\N
149	148	1230	RESEARCH	\N	\N	\N
10	\N	38	ACADEMY	1	\N	\N
18	\N	46	ACADEMY	3	\N	\N
19	\N	47	ACADEMY	5	\N	\N
20	\N	48	ACADEMY	7	\N	\N
21	\N	49	ACADEMY	9	\N	\N
175	174	1231	RESEARCH	\N	\N	\N
176	175	1232	RESEARCH	\N	\N	\N
177	176	1233	RESEARCH	\N	\N	\N
129	128	1234	RESEARCH	\N	\N	\N
34	\N	58	ACADEMY	1	\N	\N
35	\N	59	ACADEMY	3	\N	\N
36	\N	60	ACADEMY	5	\N	\N
37	\N	61	ACADEMY	7	\N	\N
38	\N	62	ACADEMY	4	\N	\N
39	\N	63	ACADEMY	6	\N	\N
40	\N	64	ACADEMY	8	\N	\N
41	\N	65	ACADEMY	10	\N	\N
42	\N	66	ACADEMY	5	\N	\N
43	\N	67	ACADEMY	6	\N	\N
44	\N	68	ACADEMY	7	\N	\N
45	\N	69	ACADEMY	8	\N	\N
46	\N	70	ACADEMY	1	\N	\N
47	\N	71	ACADEMY	3	\N	\N
48	\N	72	ACADEMY	5	\N	\N
49	\N	73	ACADEMY	7	\N	\N
50	\N	74	ACADEMY	2	\N	\N
51	\N	75	ACADEMY	4	\N	\N
52	\N	76	ACADEMY	6	\N	\N
53	\N	77	ACADEMY	8	\N	\N
54	\N	78	ACADEMY	2	\N	\N
55	\N	79	ACADEMY	3	\N	\N
56	\N	80	ACADEMY	4	\N	\N
1	\N	81	ACADEMY	3	\N	\N
2	\N	82	ACADEMY	3	\N	\N
3	\N	83	ACADEMY	3	\N	\N
4	\N	84	ACADEMY	3	\N	\N
27	\N	85	ACADEMY	6	\N	\N
57	\N	86	ACADEMY	5	\N	\N
58	\N	87	ACADEMY	6	\N	\N
59	\N	88	ACADEMY	7	\N	\N
60	\N	89	ACADEMY	8	\N	\N
61	\N	90	ACADEMY	9	\N	\N
62	\N	91	ACADEMY	3	\N	\N
63	\N	92	ACADEMY	5	\N	\N
64	\N	93	ACADEMY	7	\N	\N
65	\N	94	ACADEMY	9	\N	\N
66	\N	95	ACADEMY	2	\N	\N
67	\N	96	ACADEMY	4	\N	\N
68	\N	97	ACADEMY	6	\N	\N
69	\N	98	ACADEMY	8	\N	\N
70	\N	99	ACADEMY	4	\N	\N
71	\N	100	ACADEMY	6	\N	\N
72	\N	101	ACADEMY	8	\N	\N
73	\N	102	ACADEMY	10	\N	\N
74	\N	103	ACADEMY	5	\N	\N
75	\N	104	ACADEMY	6	\N	\N
76	\N	105	ACADEMY	7	\N	\N
77	\N	106	ACADEMY	8	\N	\N
130	129	1235	RESEARCH	\N	\N	\N
131	130	1236	RESEARCH	\N	\N	\N
132	131	1237	RESEARCH	\N	\N	\N
133	132	1238	RESEARCH	\N	\N	\N
134	133	1239	RESEARCH	\N	\N	\N
135	134	1240	RESEARCH	\N	\N	\N
136	135	1241	RESEARCH	\N	\N	\N
88	\N	117	ACADEMY	1	\N	\N
89	\N	118	ACADEMY	3	\N	\N
90	\N	119	ACADEMY	5	\N	\N
91	\N	120	ACADEMY	7	\N	\N
92	\N	121	ACADEMY	9	\N	\N
93	\N	122	ACADEMY	2	\N	\N
94	\N	123	ACADEMY	4	\N	\N
95	\N	124	ACADEMY	6	\N	\N
96	\N	125	ACADEMY	8	\N	\N
97	\N	126	ACADEMY	10	\N	\N
98	\N	127	ACADEMY	1	\N	\N
99	\N	128	ACADEMY	2	\N	\N
100	\N	129	ACADEMY	3	\N	\N
101	\N	130	ACADEMY	4	\N	\N
102	\N	131	ACADEMY	5	\N	\N
103	\N	132	ACADEMY	6	\N	\N
104	\N	133	ACADEMY	7	\N	\N
105	\N	134	ACADEMY	8	\N	\N
106	\N	135	ACADEMY	9	\N	\N
107	\N	136	ACADEMY	10	\N	\N
112	\N	141	ACADEMY	5	\N	\N
113	\N	142	ACADEMY	6	\N	\N
114	\N	143	ACADEMY	7	\N	\N
115	\N	144	ACADEMY	8	\N	\N
116	\N	145	ACADEMY	9	\N	\N
117	\N	146	ACADEMY	10	\N	\N
118	\N	147	ACADEMY	1	\N	\N
119	\N	148	ACADEMY	2	\N	\N
120	\N	149	ACADEMY	3	\N	\N
121	\N	150	ACADEMY	4	\N	\N
122	\N	151	ACADEMY	5	\N	\N
123	\N	152	ACADEMY	6	\N	\N
124	\N	153	ACADEMY	7	\N	\N
125	\N	154	ACADEMY	8	\N	\N
126	\N	155	ACADEMY	9	\N	\N
127	\N	156	ACADEMY	10	\N	\N
128	\N	157	ACADEMY	1	\N	\N
129	\N	158	ACADEMY	2	\N	\N
130	\N	159	ACADEMY	3	\N	\N
131	\N	160	ACADEMY	4	\N	\N
132	\N	161	ACADEMY	5	\N	\N
133	\N	162	ACADEMY	6	\N	\N
14	\N	42	ACADEMY	2	\N	\N
15	\N	43	ACADEMY	4	\N	\N
16	\N	44	ACADEMY	6	\N	\N
17	\N	45	ACADEMY	8	\N	\N
30	\N	54	ACADEMY	2	\N	\N
31	\N	55	ACADEMY	4	\N	\N
32	\N	56	ACADEMY	6	\N	\N
33	\N	57	ACADEMY	8	\N	\N
11	\N	39	ACADEMY	2	\N	\N
12	\N	40	ACADEMY	3	\N	\N
13	\N	41	ACADEMY	4	\N	\N
108	\N	137	ACADEMY	4	\N	\N
109	\N	138	ACADEMY	4	\N	\N
110	\N	139	ACADEMY	4	\N	\N
134	\N	163	ACADEMY	7	\N	\N
135	\N	164	ACADEMY	8	\N	\N
136	\N	165	ACADEMY	9	\N	\N
137	\N	166	ACADEMY	10	\N	\N
138	\N	167	ACADEMY	1	\N	\N
139	\N	168	ACADEMY	2	\N	\N
140	\N	169	ACADEMY	3	\N	\N
141	\N	170	ACADEMY	4	\N	\N
142	\N	171	ACADEMY	5	\N	\N
143	\N	172	ACADEMY	6	\N	\N
144	\N	173	ACADEMY	7	\N	\N
145	\N	174	ACADEMY	8	\N	\N
146	\N	175	ACADEMY	9	\N	\N
147	\N	176	ACADEMY	10	\N	\N
148	\N	177	ACADEMY	1	\N	\N
149	\N	178	ACADEMY	2	\N	\N
150	\N	179	ACADEMY	3	\N	\N
151	\N	180	ACADEMY	4	\N	\N
152	\N	181	ACADEMY	5	\N	\N
153	\N	182	ACADEMY	6	\N	\N
154	\N	183	ACADEMY	7	\N	\N
155	\N	184	ACADEMY	8	\N	\N
156	\N	185	ACADEMY	9	\N	\N
157	\N	186	ACADEMY	10	\N	\N
158	\N	187	ACADEMY	1	\N	\N
159	\N	188	ACADEMY	2	\N	\N
160	\N	189	ACADEMY	3	\N	\N
161	\N	190	ACADEMY	4	\N	\N
162	\N	191	ACADEMY	5	\N	\N
163	\N	192	ACADEMY	6	\N	\N
164	\N	193	ACADEMY	7	\N	\N
165	\N	194	ACADEMY	8	\N	\N
166	\N	195	ACADEMY	9	\N	\N
167	\N	196	ACADEMY	10	\N	\N
168	\N	197	ACADEMY	1	\N	\N
169	\N	198	ACADEMY	2	\N	\N
170	\N	199	ACADEMY	3	\N	\N
171	\N	200	ACADEMY	4	\N	\N
172	\N	201	ACADEMY	5	\N	\N
173	\N	202	ACADEMY	6	\N	\N
174	\N	203	ACADEMY	7	\N	\N
175	\N	204	ACADEMY	8	\N	\N
176	\N	205	ACADEMY	9	\N	\N
177	\N	206	ACADEMY	10	\N	\N
5	\N	207	ACADEMY	4	\N	\N
137	136	1242	RESEARCH	\N	\N	\N
11	10	1243	RESEARCH	\N	\N	\N
12	11	1244	RESEARCH	\N	\N	\N
187	\N	211	ACADEMY	5	\N	\N
188	\N	212	ACADEMY	5	\N	\N
189	\N	213	ACADEMY	5	\N	\N
190	\N	214	ACADEMY	5	\N	\N
13	12	1245	RESEARCH	\N	\N	\N
326	13	1246	RESEARCH	\N	\N	\N
327	326	1247	RESEARCH	\N	\N	\N
195	\N	218	ACADEMY	7	\N	\N
196	\N	219	ACADEMY	7	\N	\N
197	\N	220	ACADEMY	7	\N	\N
198	\N	221	ACADEMY	7	\N	\N
28	\N	222	ACADEMY	8	\N	\N
328	327	1248	RESEARCH	\N	\N	\N
329	328	1249	RESEARCH	\N	\N	\N
330	329	1250	RESEARCH	\N	\N	\N
203	\N	226	ACADEMY	9	\N	\N
204	\N	227	ACADEMY	9	\N	\N
205	\N	228	ACADEMY	9	\N	\N
206	\N	229	ACADEMY	9	\N	\N
29	\N	230	ACADEMY	10	\N	\N
331	330	1251	RESEARCH	\N	\N	\N
101	100	1252	RESEARCH	\N	\N	\N
102	101	1253	RESEARCH	\N	\N	\N
103	102	1254	RESEARCH	\N	\N	\N
104	103	1255	RESEARCH	\N	\N	\N
105	104	1256	RESEARCH	\N	\N	\N
106	105	1257	RESEARCH	\N	\N	\N
107	106	1258	RESEARCH	\N	\N	\N
150	149	1259	RESEARCH	\N	\N	\N
151	150	1260	RESEARCH	\N	\N	\N
217	\N	242	ACADEMY	2	\N	\N
218	\N	243	ACADEMY	2	\N	\N
219	\N	244	ACADEMY	2	\N	\N
220	\N	245	ACADEMY	3	\N	\N
221	\N	246	ACADEMY	3	\N	\N
222	\N	247	ACADEMY	3	\N	\N
223	\N	248	ACADEMY	4	\N	\N
224	\N	249	ACADEMY	4	\N	\N
225	\N	250	ACADEMY	4	\N	\N
226	\N	251	ACADEMY	5	\N	\N
227	\N	252	ACADEMY	5	\N	\N
228	\N	253	ACADEMY	5	\N	\N
229	\N	254	ACADEMY	6	\N	\N
230	\N	255	ACADEMY	6	\N	\N
231	\N	256	ACADEMY	6	\N	\N
232	\N	257	ACADEMY	7	\N	\N
233	\N	258	ACADEMY	7	\N	\N
234	\N	259	ACADEMY	7	\N	\N
235	\N	260	ACADEMY	8	\N	\N
236	\N	261	ACADEMY	8	\N	\N
237	\N	262	ACADEMY	8	\N	\N
238	\N	263	ACADEMY	9	\N	\N
239	\N	264	ACADEMY	9	\N	\N
240	\N	265	ACADEMY	9	\N	\N
241	\N	266	ACADEMY	10	\N	\N
242	\N	267	ACADEMY	10	\N	\N
243	\N	268	ACADEMY	10	\N	\N
244	\N	269	ACADEMY	10	\N	\N
222	14	270	RESEARCH	\N	\N	\N
221	14	271	RESEARCH	\N	\N	\N
220	14	272	RESEARCH	\N	\N	\N
219	14	273	RESEARCH	\N	\N	\N
218	14	274	RESEARCH	\N	\N	\N
217	14	275	RESEARCH	\N	\N	\N
228	15	276	RESEARCH	\N	\N	\N
227	15	277	RESEARCH	\N	\N	\N
226	15	278	RESEARCH	\N	\N	\N
225	15	279	RESEARCH	\N	\N	\N
224	15	280	RESEARCH	\N	\N	\N
223	15	281	RESEARCH	\N	\N	\N
234	16	282	RESEARCH	\N	\N	\N
233	16	283	RESEARCH	\N	\N	\N
232	16	284	RESEARCH	\N	\N	\N
231	16	285	RESEARCH	\N	\N	\N
230	16	286	RESEARCH	\N	\N	\N
229	16	287	RESEARCH	\N	\N	\N
244	17	288	RESEARCH	\N	\N	\N
243	17	289	RESEARCH	\N	\N	\N
242	17	290	RESEARCH	\N	\N	\N
241	17	291	RESEARCH	\N	\N	\N
240	17	292	RESEARCH	\N	\N	\N
239	17	293	RESEARCH	\N	\N	\N
238	17	294	RESEARCH	\N	\N	\N
237	17	295	RESEARCH	\N	\N	\N
236	17	296	RESEARCH	\N	\N	\N
235	17	297	RESEARCH	\N	\N	\N
268	\N	298	ACADEMY	2	\N	\N
269	\N	299	ACADEMY	2	\N	\N
270	\N	300	ACADEMY	2	\N	\N
271	\N	301	ACADEMY	3	\N	\N
272	\N	302	ACADEMY	3	\N	\N
273	\N	303	ACADEMY	3	\N	\N
274	\N	304	ACADEMY	4	\N	\N
275	\N	305	ACADEMY	4	\N	\N
276	\N	306	ACADEMY	4	\N	\N
277	\N	307	ACADEMY	5	\N	\N
278	\N	308	ACADEMY	5	\N	\N
279	\N	309	ACADEMY	5	\N	\N
280	\N	310	ACADEMY	6	\N	\N
281	\N	311	ACADEMY	6	\N	\N
282	\N	312	ACADEMY	6	\N	\N
283	\N	313	ACADEMY	7	\N	\N
284	\N	314	ACADEMY	7	\N	\N
285	\N	315	ACADEMY	7	\N	\N
286	\N	316	ACADEMY	8	\N	\N
287	\N	317	ACADEMY	8	\N	\N
288	\N	318	ACADEMY	8	\N	\N
289	\N	319	ACADEMY	9	\N	\N
290	\N	320	ACADEMY	9	\N	\N
291	\N	321	ACADEMY	9	\N	\N
292	\N	322	ACADEMY	10	\N	\N
293	\N	323	ACADEMY	10	\N	\N
294	\N	324	ACADEMY	10	\N	\N
295	\N	325	ACADEMY	10	\N	\N
273	30	326	RESEARCH	\N	\N	\N
272	30	327	RESEARCH	\N	\N	\N
271	30	328	RESEARCH	\N	\N	\N
270	30	329	RESEARCH	\N	\N	\N
269	30	330	RESEARCH	\N	\N	\N
268	30	331	RESEARCH	\N	\N	\N
279	31	332	RESEARCH	\N	\N	\N
278	31	333	RESEARCH	\N	\N	\N
277	31	334	RESEARCH	\N	\N	\N
276	31	335	RESEARCH	\N	\N	\N
275	31	336	RESEARCH	\N	\N	\N
274	31	337	RESEARCH	\N	\N	\N
285	32	338	RESEARCH	\N	\N	\N
284	32	339	RESEARCH	\N	\N	\N
283	32	340	RESEARCH	\N	\N	\N
282	32	341	RESEARCH	\N	\N	\N
281	32	342	RESEARCH	\N	\N	\N
280	32	343	RESEARCH	\N	\N	\N
295	33	344	RESEARCH	\N	\N	\N
294	33	345	RESEARCH	\N	\N	\N
293	33	346	RESEARCH	\N	\N	\N
292	33	347	RESEARCH	\N	\N	\N
291	33	348	RESEARCH	\N	\N	\N
290	33	349	RESEARCH	\N	\N	\N
289	33	350	RESEARCH	\N	\N	\N
288	33	351	RESEARCH	\N	\N	\N
287	33	352	RESEARCH	\N	\N	\N
286	33	353	RESEARCH	\N	\N	\N
296	\N	354	ACADEMY	1	\N	\N
297	\N	355	ACADEMY	1	\N	\N
298	\N	356	ACADEMY	1	\N	\N
299	\N	357	ACADEMY	2	\N	\N
300	\N	358	ACADEMY	2	\N	\N
301	\N	359	ACADEMY	2	\N	\N
302	\N	360	ACADEMY	3	\N	\N
303	\N	361	ACADEMY	3	\N	\N
304	\N	362	ACADEMY	3	\N	\N
305	\N	363	ACADEMY	4	\N	\N
306	\N	364	ACADEMY	4	\N	\N
307	\N	365	ACADEMY	4	\N	\N
308	\N	366	ACADEMY	5	\N	\N
309	\N	367	ACADEMY	5	\N	\N
310	\N	368	ACADEMY	5	\N	\N
311	\N	369	ACADEMY	6	\N	\N
312	\N	370	ACADEMY	6	\N	\N
313	\N	371	ACADEMY	6	\N	\N
314	\N	372	ACADEMY	7	\N	\N
315	\N	373	ACADEMY	7	\N	\N
316	\N	374	ACADEMY	7	\N	\N
317	\N	375	ACADEMY	8	\N	\N
318	\N	376	ACADEMY	8	\N	\N
319	\N	377	ACADEMY	8	\N	\N
320	\N	378	ACADEMY	9	\N	\N
321	\N	379	ACADEMY	9	\N	\N
322	\N	380	ACADEMY	9	\N	\N
323	\N	381	ACADEMY	10	\N	\N
324	\N	382	ACADEMY	10	\N	\N
325	\N	383	ACADEMY	10	\N	\N
296	128	384	RESEARCH	\N	\N	\N
297	128	385	RESEARCH	\N	\N	\N
298	128	386	RESEARCH	\N	\N	\N
299	129	387	RESEARCH	\N	\N	\N
300	129	388	RESEARCH	\N	\N	\N
301	129	389	RESEARCH	\N	\N	\N
302	130	390	RESEARCH	\N	\N	\N
303	130	391	RESEARCH	\N	\N	\N
304	130	392	RESEARCH	\N	\N	\N
305	131	393	RESEARCH	\N	\N	\N
306	131	394	RESEARCH	\N	\N	\N
307	131	395	RESEARCH	\N	\N	\N
308	132	396	RESEARCH	\N	\N	\N
309	132	397	RESEARCH	\N	\N	\N
310	132	398	RESEARCH	\N	\N	\N
311	133	399	RESEARCH	\N	\N	\N
312	133	400	RESEARCH	\N	\N	\N
313	133	401	RESEARCH	\N	\N	\N
314	134	402	RESEARCH	\N	\N	\N
315	134	403	RESEARCH	\N	\N	\N
316	134	404	RESEARCH	\N	\N	\N
317	135	405	RESEARCH	\N	\N	\N
318	135	406	RESEARCH	\N	\N	\N
319	135	407	RESEARCH	\N	\N	\N
320	136	408	RESEARCH	\N	\N	\N
321	136	409	RESEARCH	\N	\N	\N
322	136	410	RESEARCH	\N	\N	\N
323	137	411	RESEARCH	\N	\N	\N
324	137	412	RESEARCH	\N	\N	\N
325	137	413	RESEARCH	\N	\N	\N
326	\N	414	ACADEMY	5	\N	\N
327	\N	415	ACADEMY	6	\N	\N
328	\N	416	ACADEMY	7	\N	\N
329	\N	417	ACADEMY	8	\N	\N
330	\N	418	ACADEMY	9	\N	\N
331	\N	419	ACADEMY	10	\N	\N
332	\N	420	ACADEMY	1	\N	\N
333	\N	421	ACADEMY	1	\N	\N
334	\N	422	ACADEMY	1	\N	\N
335	\N	423	ACADEMY	2	\N	\N
336	\N	424	ACADEMY	2	\N	\N
337	\N	425	ACADEMY	2	\N	\N
338	\N	426	ACADEMY	3	\N	\N
339	\N	427	ACADEMY	3	\N	\N
340	\N	428	ACADEMY	3	\N	\N
341	\N	429	ACADEMY	4	\N	\N
342	\N	430	ACADEMY	4	\N	\N
343	\N	431	ACADEMY	4	\N	\N
344	\N	432	ACADEMY	5	\N	\N
345	\N	433	ACADEMY	5	\N	\N
346	\N	434	ACADEMY	5	\N	\N
347	\N	435	ACADEMY	6	\N	\N
348	\N	436	ACADEMY	6	\N	\N
349	\N	437	ACADEMY	6	\N	\N
350	\N	438	ACADEMY	7	\N	\N
351	\N	439	ACADEMY	7	\N	\N
352	\N	440	ACADEMY	7	\N	\N
353	\N	441	ACADEMY	8	\N	\N
354	\N	442	ACADEMY	8	\N	\N
355	\N	443	ACADEMY	8	\N	\N
356	\N	444	ACADEMY	9	\N	\N
357	\N	445	ACADEMY	9	\N	\N
358	\N	446	ACADEMY	9	\N	\N
359	\N	447	ACADEMY	10	\N	\N
360	\N	448	ACADEMY	10	\N	\N
361	\N	449	ACADEMY	10	\N	\N
332	10	450	RESEARCH	\N	\N	\N
333	10	451	RESEARCH	\N	\N	\N
334	10	452	RESEARCH	\N	\N	\N
335	11	453	RESEARCH	\N	\N	\N
336	11	454	RESEARCH	\N	\N	\N
337	11	455	RESEARCH	\N	\N	\N
338	12	456	RESEARCH	\N	\N	\N
339	12	457	RESEARCH	\N	\N	\N
340	12	458	RESEARCH	\N	\N	\N
341	13	459	RESEARCH	\N	\N	\N
342	13	460	RESEARCH	\N	\N	\N
343	13	461	RESEARCH	\N	\N	\N
344	326	462	RESEARCH	\N	\N	\N
345	326	463	RESEARCH	\N	\N	\N
346	326	464	RESEARCH	\N	\N	\N
347	327	465	RESEARCH	\N	\N	\N
348	327	466	RESEARCH	\N	\N	\N
349	327	467	RESEARCH	\N	\N	\N
350	328	468	RESEARCH	\N	\N	\N
351	328	469	RESEARCH	\N	\N	\N
352	328	470	RESEARCH	\N	\N	\N
353	329	471	RESEARCH	\N	\N	\N
354	329	472	RESEARCH	\N	\N	\N
355	329	473	RESEARCH	\N	\N	\N
356	330	474	RESEARCH	\N	\N	\N
357	330	475	RESEARCH	\N	\N	\N
358	330	476	RESEARCH	\N	\N	\N
359	331	477	RESEARCH	\N	\N	\N
360	331	478	RESEARCH	\N	\N	\N
361	331	479	RESEARCH	\N	\N	\N
362	\N	480	ACADEMY	6	\N	\N
363	\N	481	ACADEMY	3	\N	\N
364	\N	482	ACADEMY	3	\N	\N
365	\N	483	ACADEMY	3	\N	\N
366	\N	484	ACADEMY	3	\N	\N
367	\N	485	ACADEMY	3	\N	\N
368	\N	486	ACADEMY	5	\N	\N
369	\N	487	ACADEMY	5	\N	\N
370	\N	488	ACADEMY	5	\N	\N
371	\N	489	ACADEMY	5	\N	\N
372	\N	490	ACADEMY	5	\N	\N
373	\N	491	ACADEMY	6	\N	\N
374	\N	492	ACADEMY	6	\N	\N
375	\N	493	ACADEMY	6	\N	\N
376	\N	494	ACADEMY	6	\N	\N
377	\N	495	ACADEMY	7	\N	\N
378	\N	496	ACADEMY	7	\N	\N
379	\N	497	ACADEMY	7	\N	\N
380	\N	498	ACADEMY	7	\N	\N
381	\N	499	ACADEMY	9	\N	\N
382	\N	500	ACADEMY	9	\N	\N
383	\N	501	ACADEMY	9	\N	\N
62	46	502	RESEARCH	\N	\N	\N
362	47	503	RESEARCH	\N	\N	\N
63	47	504	RESEARCH	\N	\N	\N
64	48	505	RESEARCH	\N	\N	\N
65	49	506	RESEARCH	\N	\N	\N
62	50	507	RESEARCH	\N	\N	\N
63	51	508	RESEARCH	\N	\N	\N
64	52	509	RESEARCH	\N	\N	\N
65	53	510	RESEARCH	\N	\N	\N
62	54	511	RESEARCH	\N	\N	\N
362	56	512	RESEARCH	\N	\N	\N
63	56	513	RESEARCH	\N	\N	\N
62	14	514	RESEARCH	\N	\N	\N
362	57	515	RESEARCH	\N	\N	\N
64	58	516	RESEARCH	\N	\N	\N
65	60	517	RESEARCH	\N	\N	\N
362	94	518	RESEARCH	\N	\N	\N
63	119	519	RESEARCH	\N	\N	\N
64	120	520	RESEARCH	\N	\N	\N
65	121	521	RESEARCH	\N	\N	\N
362	161	522	RESEARCH	\N	\N	\N
64	\N	523	BUILDING	\N	15	7
65	\N	524	BUILDING	\N	15	9
362	\N	525	BUILDING	\N	15	6
363	62	526	RESEARCH	\N	\N	\N
364	62	527	RESEARCH	\N	\N	\N
365	62	528	RESEARCH	\N	\N	\N
366	62	529	RESEARCH	\N	\N	\N
367	62	530	RESEARCH	\N	\N	\N
368	63	531	RESEARCH	\N	\N	\N
369	63	532	RESEARCH	\N	\N	\N
370	63	533	RESEARCH	\N	\N	\N
371	63	534	RESEARCH	\N	\N	\N
372	63	535	RESEARCH	\N	\N	\N
377	64	536	RESEARCH	\N	\N	\N
378	64	537	RESEARCH	\N	\N	\N
379	64	538	RESEARCH	\N	\N	\N
380	64	539	RESEARCH	\N	\N	\N
381	65	540	RESEARCH	\N	\N	\N
382	65	541	RESEARCH	\N	\N	\N
383	65	542	RESEARCH	\N	\N	\N
373	362	543	RESEARCH	\N	\N	\N
374	362	544	RESEARCH	\N	\N	\N
375	362	545	RESEARCH	\N	\N	\N
376	362	546	RESEARCH	\N	\N	\N
384	\N	547	ACADEMY	1	\N	\N
385	\N	548	ACADEMY	1	\N	\N
386	\N	549	ACADEMY	1	\N	\N
387	\N	550	ACADEMY	2	\N	\N
388	\N	551	ACADEMY	2	\N	\N
389	\N	552	ACADEMY	2	\N	\N
390	\N	553	ACADEMY	3	\N	\N
391	\N	554	ACADEMY	3	\N	\N
392	\N	555	ACADEMY	3	\N	\N
393	\N	556	ACADEMY	4	\N	\N
394	\N	557	ACADEMY	4	\N	\N
395	\N	558	ACADEMY	4	\N	\N
396	\N	559	ACADEMY	5	\N	\N
397	\N	560	ACADEMY	5	\N	\N
398	\N	561	ACADEMY	5	\N	\N
399	\N	562	ACADEMY	6	\N	\N
400	\N	563	ACADEMY	6	\N	\N
401	\N	564	ACADEMY	6	\N	\N
402	\N	565	ACADEMY	7	\N	\N
403	\N	566	ACADEMY	7	\N	\N
404	\N	567	ACADEMY	7	\N	\N
405	\N	568	ACADEMY	8	\N	\N
406	\N	569	ACADEMY	8	\N	\N
407	\N	570	ACADEMY	8	\N	\N
408	\N	571	ACADEMY	9	\N	\N
409	\N	572	ACADEMY	9	\N	\N
410	\N	573	ACADEMY	9	\N	\N
411	\N	574	ACADEMY	10	\N	\N
412	\N	575	ACADEMY	10	\N	\N
413	\N	576	ACADEMY	10	\N	\N
384	98	577	RESEARCH	\N	\N	\N
385	98	578	RESEARCH	\N	\N	\N
386	98	579	RESEARCH	\N	\N	\N
387	99	580	RESEARCH	\N	\N	\N
388	99	581	RESEARCH	\N	\N	\N
389	99	582	RESEARCH	\N	\N	\N
390	100	583	RESEARCH	\N	\N	\N
391	100	584	RESEARCH	\N	\N	\N
392	100	585	RESEARCH	\N	\N	\N
393	101	586	RESEARCH	\N	\N	\N
394	101	587	RESEARCH	\N	\N	\N
395	101	588	RESEARCH	\N	\N	\N
396	102	589	RESEARCH	\N	\N	\N
397	102	590	RESEARCH	\N	\N	\N
398	102	591	RESEARCH	\N	\N	\N
399	103	592	RESEARCH	\N	\N	\N
400	103	593	RESEARCH	\N	\N	\N
401	103	594	RESEARCH	\N	\N	\N
402	104	595	RESEARCH	\N	\N	\N
403	104	596	RESEARCH	\N	\N	\N
404	104	597	RESEARCH	\N	\N	\N
405	105	598	RESEARCH	\N	\N	\N
406	105	599	RESEARCH	\N	\N	\N
407	105	600	RESEARCH	\N	\N	\N
408	106	601	RESEARCH	\N	\N	\N
409	106	602	RESEARCH	\N	\N	\N
410	106	603	RESEARCH	\N	\N	\N
411	107	604	RESEARCH	\N	\N	\N
412	107	605	RESEARCH	\N	\N	\N
413	107	606	RESEARCH	\N	\N	\N
152	151	1261	RESEARCH	\N	\N	\N
415	\N	608	ACADEMY	1	\N	\N
416	\N	609	ACADEMY	1	\N	\N
417	\N	610	ACADEMY	1	\N	\N
418	\N	611	ACADEMY	2	\N	\N
419	\N	612	ACADEMY	2	\N	\N
420	\N	613	ACADEMY	2	\N	\N
421	\N	614	ACADEMY	3	\N	\N
422	\N	615	ACADEMY	3	\N	\N
423	\N	616	ACADEMY	3	\N	\N
424	\N	617	ACADEMY	4	\N	\N
425	\N	618	ACADEMY	4	\N	\N
426	\N	619	ACADEMY	4	\N	\N
427	\N	620	ACADEMY	5	\N	\N
428	\N	621	ACADEMY	5	\N	\N
429	\N	622	ACADEMY	5	\N	\N
430	\N	623	ACADEMY	6	\N	\N
431	\N	624	ACADEMY	6	\N	\N
432	\N	625	ACADEMY	6	\N	\N
433	\N	626	ACADEMY	7	\N	\N
434	\N	627	ACADEMY	7	\N	\N
435	\N	628	ACADEMY	7	\N	\N
436	\N	629	ACADEMY	8	\N	\N
437	\N	630	ACADEMY	8	\N	\N
438	\N	631	ACADEMY	8	\N	\N
439	\N	632	ACADEMY	9	\N	\N
440	\N	633	ACADEMY	9	\N	\N
441	\N	634	ACADEMY	9	\N	\N
442	\N	635	ACADEMY	10	\N	\N
443	\N	636	ACADEMY	10	\N	\N
444	\N	637	ACADEMY	10	\N	\N
415	118	638	RESEARCH	\N	\N	\N
416	118	639	RESEARCH	\N	\N	\N
417	118	640	RESEARCH	\N	\N	\N
418	119	641	RESEARCH	\N	\N	\N
419	119	642	RESEARCH	\N	\N	\N
420	119	643	RESEARCH	\N	\N	\N
421	120	644	RESEARCH	\N	\N	\N
422	120	645	RESEARCH	\N	\N	\N
423	120	646	RESEARCH	\N	\N	\N
424	121	647	RESEARCH	\N	\N	\N
425	121	648	RESEARCH	\N	\N	\N
426	121	649	RESEARCH	\N	\N	\N
427	122	650	RESEARCH	\N	\N	\N
428	122	651	RESEARCH	\N	\N	\N
429	122	652	RESEARCH	\N	\N	\N
430	123	653	RESEARCH	\N	\N	\N
431	123	654	RESEARCH	\N	\N	\N
432	123	655	RESEARCH	\N	\N	\N
433	124	656	RESEARCH	\N	\N	\N
434	124	657	RESEARCH	\N	\N	\N
435	124	658	RESEARCH	\N	\N	\N
436	125	659	RESEARCH	\N	\N	\N
437	125	660	RESEARCH	\N	\N	\N
438	125	661	RESEARCH	\N	\N	\N
439	126	662	RESEARCH	\N	\N	\N
440	126	663	RESEARCH	\N	\N	\N
441	126	664	RESEARCH	\N	\N	\N
442	127	665	RESEARCH	\N	\N	\N
443	127	666	RESEARCH	\N	\N	\N
444	127	667	RESEARCH	\N	\N	\N
445	\N	668	ACADEMY	1	\N	\N
446	\N	669	ACADEMY	1	\N	\N
447	\N	670	ACADEMY	1	\N	\N
448	\N	671	ACADEMY	2	\N	\N
449	\N	672	ACADEMY	2	\N	\N
450	\N	673	ACADEMY	2	\N	\N
451	\N	674	ACADEMY	3	\N	\N
452	\N	675	ACADEMY	3	\N	\N
453	\N	676	ACADEMY	3	\N	\N
454	\N	677	ACADEMY	4	\N	\N
455	\N	678	ACADEMY	4	\N	\N
456	\N	679	ACADEMY	4	\N	\N
457	\N	680	ACADEMY	5	\N	\N
458	\N	681	ACADEMY	5	\N	\N
459	\N	682	ACADEMY	5	\N	\N
460	\N	683	ACADEMY	6	\N	\N
461	\N	684	ACADEMY	6	\N	\N
462	\N	685	ACADEMY	6	\N	\N
463	\N	686	ACADEMY	7	\N	\N
464	\N	687	ACADEMY	7	\N	\N
465	\N	688	ACADEMY	7	\N	\N
466	\N	689	ACADEMY	8	\N	\N
467	\N	690	ACADEMY	8	\N	\N
468	\N	691	ACADEMY	8	\N	\N
469	\N	692	ACADEMY	9	\N	\N
470	\N	693	ACADEMY	9	\N	\N
471	\N	694	ACADEMY	9	\N	\N
472	\N	695	ACADEMY	10	\N	\N
473	\N	696	ACADEMY	10	\N	\N
474	\N	697	ACADEMY	10	\N	\N
445	148	698	RESEARCH	\N	\N	\N
446	148	699	RESEARCH	\N	\N	\N
447	148	700	RESEARCH	\N	\N	\N
448	149	701	RESEARCH	\N	\N	\N
449	149	702	RESEARCH	\N	\N	\N
450	149	703	RESEARCH	\N	\N	\N
451	150	704	RESEARCH	\N	\N	\N
452	150	705	RESEARCH	\N	\N	\N
453	150	706	RESEARCH	\N	\N	\N
454	151	707	RESEARCH	\N	\N	\N
455	151	708	RESEARCH	\N	\N	\N
456	151	709	RESEARCH	\N	\N	\N
457	152	710	RESEARCH	\N	\N	\N
458	152	711	RESEARCH	\N	\N	\N
459	152	712	RESEARCH	\N	\N	\N
460	153	713	RESEARCH	\N	\N	\N
461	153	714	RESEARCH	\N	\N	\N
462	153	715	RESEARCH	\N	\N	\N
463	154	716	RESEARCH	\N	\N	\N
464	154	717	RESEARCH	\N	\N	\N
465	154	718	RESEARCH	\N	\N	\N
466	155	719	RESEARCH	\N	\N	\N
467	155	720	RESEARCH	\N	\N	\N
468	155	721	RESEARCH	\N	\N	\N
469	156	722	RESEARCH	\N	\N	\N
470	156	723	RESEARCH	\N	\N	\N
471	156	724	RESEARCH	\N	\N	\N
472	157	725	RESEARCH	\N	\N	\N
473	157	726	RESEARCH	\N	\N	\N
474	157	727	RESEARCH	\N	\N	\N
475	\N	728	ACADEMY	1	\N	\N
476	\N	729	ACADEMY	1	\N	\N
477	\N	730	ACADEMY	1	\N	\N
478	\N	731	ACADEMY	2	\N	\N
479	\N	732	ACADEMY	2	\N	\N
480	\N	733	ACADEMY	2	\N	\N
481	\N	734	ACADEMY	3	\N	\N
482	\N	735	ACADEMY	3	\N	\N
483	\N	736	ACADEMY	3	\N	\N
484	\N	737	ACADEMY	4	\N	\N
485	\N	738	ACADEMY	4	\N	\N
486	\N	739	ACADEMY	4	\N	\N
487	\N	740	ACADEMY	5	\N	\N
488	\N	741	ACADEMY	5	\N	\N
489	\N	742	ACADEMY	5	\N	\N
490	\N	743	ACADEMY	6	\N	\N
491	\N	744	ACADEMY	6	\N	\N
492	\N	745	ACADEMY	6	\N	\N
493	\N	746	ACADEMY	7	\N	\N
494	\N	747	ACADEMY	7	\N	\N
495	\N	748	ACADEMY	7	\N	\N
496	\N	749	ACADEMY	8	\N	\N
497	\N	750	ACADEMY	8	\N	\N
498	\N	751	ACADEMY	8	\N	\N
499	\N	752	ACADEMY	9	\N	\N
500	\N	753	ACADEMY	9	\N	\N
501	\N	754	ACADEMY	9	\N	\N
502	\N	755	ACADEMY	10	\N	\N
503	\N	756	ACADEMY	10	\N	\N
504	\N	757	ACADEMY	10	\N	\N
475	158	758	RESEARCH	\N	\N	\N
476	158	759	RESEARCH	\N	\N	\N
477	158	760	RESEARCH	\N	\N	\N
478	159	761	RESEARCH	\N	\N	\N
479	159	762	RESEARCH	\N	\N	\N
480	159	763	RESEARCH	\N	\N	\N
481	160	764	RESEARCH	\N	\N	\N
482	160	765	RESEARCH	\N	\N	\N
483	160	766	RESEARCH	\N	\N	\N
484	161	767	RESEARCH	\N	\N	\N
485	161	768	RESEARCH	\N	\N	\N
486	161	769	RESEARCH	\N	\N	\N
487	162	770	RESEARCH	\N	\N	\N
488	162	771	RESEARCH	\N	\N	\N
489	162	772	RESEARCH	\N	\N	\N
490	163	773	RESEARCH	\N	\N	\N
491	163	774	RESEARCH	\N	\N	\N
492	163	775	RESEARCH	\N	\N	\N
493	164	776	RESEARCH	\N	\N	\N
494	164	777	RESEARCH	\N	\N	\N
495	164	778	RESEARCH	\N	\N	\N
496	165	779	RESEARCH	\N	\N	\N
497	165	780	RESEARCH	\N	\N	\N
498	165	781	RESEARCH	\N	\N	\N
499	166	782	RESEARCH	\N	\N	\N
500	166	783	RESEARCH	\N	\N	\N
501	166	784	RESEARCH	\N	\N	\N
502	167	785	RESEARCH	\N	\N	\N
503	167	786	RESEARCH	\N	\N	\N
504	167	787	RESEARCH	\N	\N	\N
505	\N	788	ACADEMY	1	\N	\N
506	\N	789	ACADEMY	1	\N	\N
507	\N	790	ACADEMY	1	\N	\N
508	\N	791	ACADEMY	2	\N	\N
509	\N	792	ACADEMY	2	\N	\N
510	\N	793	ACADEMY	2	\N	\N
511	\N	794	ACADEMY	3	\N	\N
512	\N	795	ACADEMY	3	\N	\N
513	\N	796	ACADEMY	3	\N	\N
514	\N	797	ACADEMY	4	\N	\N
515	\N	798	ACADEMY	4	\N	\N
516	\N	799	ACADEMY	4	\N	\N
517	\N	800	ACADEMY	5	\N	\N
518	\N	801	ACADEMY	5	\N	\N
519	\N	802	ACADEMY	5	\N	\N
520	\N	803	ACADEMY	6	\N	\N
521	\N	804	ACADEMY	6	\N	\N
522	\N	805	ACADEMY	6	\N	\N
523	\N	806	ACADEMY	7	\N	\N
524	\N	807	ACADEMY	7	\N	\N
525	\N	808	ACADEMY	7	\N	\N
526	\N	809	ACADEMY	8	\N	\N
527	\N	810	ACADEMY	8	\N	\N
528	\N	811	ACADEMY	8	\N	\N
529	\N	812	ACADEMY	9	\N	\N
530	\N	813	ACADEMY	9	\N	\N
531	\N	814	ACADEMY	9	\N	\N
532	\N	815	ACADEMY	10	\N	\N
533	\N	816	ACADEMY	10	\N	\N
534	\N	817	ACADEMY	10	\N	\N
505	168	818	RESEARCH	\N	\N	\N
506	168	819	RESEARCH	\N	\N	\N
507	168	820	RESEARCH	\N	\N	\N
508	169	821	RESEARCH	\N	\N	\N
509	169	822	RESEARCH	\N	\N	\N
510	169	823	RESEARCH	\N	\N	\N
511	170	824	RESEARCH	\N	\N	\N
512	170	825	RESEARCH	\N	\N	\N
513	170	826	RESEARCH	\N	\N	\N
514	171	827	RESEARCH	\N	\N	\N
515	171	828	RESEARCH	\N	\N	\N
516	171	829	RESEARCH	\N	\N	\N
517	172	830	RESEARCH	\N	\N	\N
518	172	831	RESEARCH	\N	\N	\N
519	172	832	RESEARCH	\N	\N	\N
520	173	833	RESEARCH	\N	\N	\N
521	173	834	RESEARCH	\N	\N	\N
522	173	835	RESEARCH	\N	\N	\N
523	174	836	RESEARCH	\N	\N	\N
524	174	837	RESEARCH	\N	\N	\N
525	174	838	RESEARCH	\N	\N	\N
526	175	839	RESEARCH	\N	\N	\N
527	175	840	RESEARCH	\N	\N	\N
528	175	841	RESEARCH	\N	\N	\N
529	176	842	RESEARCH	\N	\N	\N
530	176	843	RESEARCH	\N	\N	\N
531	176	844	RESEARCH	\N	\N	\N
532	177	845	RESEARCH	\N	\N	\N
533	177	846	RESEARCH	\N	\N	\N
534	177	847	RESEARCH	\N	\N	\N
535	\N	848	ACADEMY	1	\N	\N
536	\N	849	ACADEMY	1	\N	\N
537	\N	850	ACADEMY	1	\N	\N
538	\N	851	ACADEMY	2	\N	\N
539	\N	852	ACADEMY	2	\N	\N
540	\N	853	ACADEMY	2	\N	\N
541	\N	854	ACADEMY	3	\N	\N
542	\N	855	ACADEMY	3	\N	\N
543	\N	856	ACADEMY	3	\N	\N
544	\N	857	ACADEMY	4	\N	\N
545	\N	858	ACADEMY	4	\N	\N
546	\N	859	ACADEMY	4	\N	\N
547	\N	860	ACADEMY	5	\N	\N
548	\N	861	ACADEMY	5	\N	\N
549	\N	862	ACADEMY	5	\N	\N
550	\N	863	ACADEMY	6	\N	\N
551	\N	864	ACADEMY	6	\N	\N
552	\N	865	ACADEMY	6	\N	\N
553	\N	866	ACADEMY	7	\N	\N
554	\N	867	ACADEMY	7	\N	\N
555	\N	868	ACADEMY	7	\N	\N
556	\N	869	ACADEMY	8	\N	\N
557	\N	870	ACADEMY	8	\N	\N
558	\N	871	ACADEMY	8	\N	\N
559	\N	872	ACADEMY	9	\N	\N
560	\N	873	ACADEMY	9	\N	\N
561	\N	874	ACADEMY	9	\N	\N
562	\N	875	ACADEMY	10	\N	\N
563	\N	876	ACADEMY	10	\N	\N
564	\N	877	ACADEMY	10	\N	\N
535	138	878	RESEARCH	\N	\N	\N
536	138	879	RESEARCH	\N	\N	\N
537	138	880	RESEARCH	\N	\N	\N
538	139	881	RESEARCH	\N	\N	\N
539	139	882	RESEARCH	\N	\N	\N
540	139	883	RESEARCH	\N	\N	\N
541	140	884	RESEARCH	\N	\N	\N
542	140	885	RESEARCH	\N	\N	\N
543	140	886	RESEARCH	\N	\N	\N
544	141	887	RESEARCH	\N	\N	\N
545	141	888	RESEARCH	\N	\N	\N
546	141	889	RESEARCH	\N	\N	\N
547	142	890	RESEARCH	\N	\N	\N
548	142	891	RESEARCH	\N	\N	\N
549	142	892	RESEARCH	\N	\N	\N
550	143	893	RESEARCH	\N	\N	\N
551	143	894	RESEARCH	\N	\N	\N
552	143	895	RESEARCH	\N	\N	\N
553	144	896	RESEARCH	\N	\N	\N
554	144	897	RESEARCH	\N	\N	\N
555	144	898	RESEARCH	\N	\N	\N
556	145	899	RESEARCH	\N	\N	\N
557	145	900	RESEARCH	\N	\N	\N
558	145	901	RESEARCH	\N	\N	\N
559	146	902	RESEARCH	\N	\N	\N
560	146	903	RESEARCH	\N	\N	\N
561	146	904	RESEARCH	\N	\N	\N
562	147	905	RESEARCH	\N	\N	\N
563	147	906	RESEARCH	\N	\N	\N
564	147	907	RESEARCH	\N	\N	\N
153	152	1262	RESEARCH	\N	\N	\N
154	153	1263	RESEARCH	\N	\N	\N
155	154	1264	RESEARCH	\N	\N	\N
156	155	1265	RESEARCH	\N	\N	\N
157	156	1266	RESEARCH	\N	\N	\N
159	158	1267	RESEARCH	\N	\N	\N
160	159	1268	RESEARCH	\N	\N	\N
161	160	1269	RESEARCH	\N	\N	\N
162	161	1270	RESEARCH	\N	\N	\N
163	162	1271	RESEARCH	\N	\N	\N
164	163	1272	RESEARCH	\N	\N	\N
165	164	1273	RESEARCH	\N	\N	\N
166	165	1274	RESEARCH	\N	\N	\N
167	166	1275	RESEARCH	\N	\N	\N
169	168	1276	RESEARCH	\N	\N	\N
170	169	1277	RESEARCH	\N	\N	\N
171	170	1278	RESEARCH	\N	\N	\N
172	171	1279	RESEARCH	\N	\N	\N
173	172	1280	RESEARCH	\N	\N	\N
174	173	1281	RESEARCH	\N	\N	\N
139	138	1282	RESEARCH	\N	\N	\N
140	139	1283	RESEARCH	\N	\N	\N
141	140	1284	RESEARCH	\N	\N	\N
142	141	1285	RESEARCH	\N	\N	\N
143	142	1286	RESEARCH	\N	\N	\N
144	143	1287	RESEARCH	\N	\N	\N
145	144	1288	RESEARCH	\N	\N	\N
146	145	1289	RESEARCH	\N	\N	\N
147	146	1290	RESEARCH	\N	\N	\N
595	\N	968	ACADEMY	1	\N	\N
596	\N	969	ACADEMY	1	\N	\N
597	\N	970	ACADEMY	1	\N	\N
598	\N	971	ACADEMY	2	\N	\N
599	\N	972	ACADEMY	2	\N	\N
600	\N	973	ACADEMY	2	\N	\N
601	\N	974	ACADEMY	3	\N	\N
602	\N	975	ACADEMY	3	\N	\N
603	\N	976	ACADEMY	3	\N	\N
604	\N	977	ACADEMY	4	\N	\N
605	\N	978	ACADEMY	4	\N	\N
606	\N	979	ACADEMY	4	\N	\N
607	\N	980	ACADEMY	5	\N	\N
608	\N	981	ACADEMY	5	\N	\N
609	\N	982	ACADEMY	5	\N	\N
610	\N	983	ACADEMY	6	\N	\N
611	\N	984	ACADEMY	6	\N	\N
612	\N	985	ACADEMY	6	\N	\N
613	\N	986	ACADEMY	7	\N	\N
614	\N	987	ACADEMY	7	\N	\N
615	\N	988	ACADEMY	7	\N	\N
616	\N	989	ACADEMY	8	\N	\N
617	\N	990	ACADEMY	8	\N	\N
618	\N	991	ACADEMY	8	\N	\N
619	\N	992	ACADEMY	9	\N	\N
620	\N	993	ACADEMY	9	\N	\N
621	\N	994	ACADEMY	9	\N	\N
622	\N	995	ACADEMY	10	\N	\N
623	\N	996	ACADEMY	10	\N	\N
624	\N	997	ACADEMY	10	\N	\N
595	88	998	RESEARCH	\N	\N	\N
596	88	999	RESEARCH	\N	\N	\N
597	88	1000	RESEARCH	\N	\N	\N
598	93	1001	RESEARCH	\N	\N	\N
599	93	1002	RESEARCH	\N	\N	\N
600	93	1003	RESEARCH	\N	\N	\N
601	89	1004	RESEARCH	\N	\N	\N
602	89	1005	RESEARCH	\N	\N	\N
603	89	1006	RESEARCH	\N	\N	\N
604	94	1007	RESEARCH	\N	\N	\N
605	94	1008	RESEARCH	\N	\N	\N
606	94	1009	RESEARCH	\N	\N	\N
607	90	1010	RESEARCH	\N	\N	\N
608	90	1011	RESEARCH	\N	\N	\N
609	90	1012	RESEARCH	\N	\N	\N
610	95	1013	RESEARCH	\N	\N	\N
611	95	1014	RESEARCH	\N	\N	\N
612	95	1015	RESEARCH	\N	\N	\N
613	91	1016	RESEARCH	\N	\N	\N
614	91	1017	RESEARCH	\N	\N	\N
615	91	1018	RESEARCH	\N	\N	\N
616	96	1019	RESEARCH	\N	\N	\N
617	96	1020	RESEARCH	\N	\N	\N
618	96	1021	RESEARCH	\N	\N	\N
619	92	1022	RESEARCH	\N	\N	\N
620	92	1023	RESEARCH	\N	\N	\N
621	92	1024	RESEARCH	\N	\N	\N
622	97	1025	RESEARCH	\N	\N	\N
623	97	1026	RESEARCH	\N	\N	\N
624	97	1027	RESEARCH	\N	\N	\N
625	\N	1028	ACADEMY	2	\N	\N
626	\N	1029	ACADEMY	2	\N	\N
627	\N	1030	ACADEMY	2	\N	\N
628	\N	1031	ACADEMY	3	\N	\N
629	\N	1032	ACADEMY	3	\N	\N
630	\N	1033	ACADEMY	3	\N	\N
631	\N	1034	ACADEMY	4	\N	\N
632	\N	1035	ACADEMY	4	\N	\N
633	\N	1036	ACADEMY	4	\N	\N
634	\N	1037	ACADEMY	5	\N	\N
635	\N	1038	ACADEMY	5	\N	\N
636	\N	1039	ACADEMY	5	\N	\N
637	\N	1040	ACADEMY	6	\N	\N
638	\N	1041	ACADEMY	6	\N	\N
639	\N	1042	ACADEMY	6	\N	\N
640	\N	1043	ACADEMY	7	\N	\N
641	\N	1044	ACADEMY	7	\N	\N
642	\N	1045	ACADEMY	7	\N	\N
643	\N	1046	ACADEMY	8	\N	\N
644	\N	1047	ACADEMY	8	\N	\N
645	\N	1048	ACADEMY	8	\N	\N
646	\N	1049	ACADEMY	9	\N	\N
647	\N	1050	ACADEMY	9	\N	\N
648	\N	1051	ACADEMY	9	\N	\N
625	54	1052	RESEARCH	\N	\N	\N
626	54	1053	RESEARCH	\N	\N	\N
627	54	1054	RESEARCH	\N	\N	\N
628	55	1055	RESEARCH	\N	\N	\N
629	55	1056	RESEARCH	\N	\N	\N
630	55	1057	RESEARCH	\N	\N	\N
631	56	1058	RESEARCH	\N	\N	\N
632	56	1059	RESEARCH	\N	\N	\N
633	56	1060	RESEARCH	\N	\N	\N
634	57	1061	RESEARCH	\N	\N	\N
635	57	1062	RESEARCH	\N	\N	\N
636	57	1063	RESEARCH	\N	\N	\N
637	58	1064	RESEARCH	\N	\N	\N
638	58	1065	RESEARCH	\N	\N	\N
639	58	1066	RESEARCH	\N	\N	\N
640	59	1067	RESEARCH	\N	\N	\N
641	59	1068	RESEARCH	\N	\N	\N
642	59	1069	RESEARCH	\N	\N	\N
643	60	1070	RESEARCH	\N	\N	\N
644	60	1071	RESEARCH	\N	\N	\N
645	60	1072	RESEARCH	\N	\N	\N
646	61	1073	RESEARCH	\N	\N	\N
647	61	1074	RESEARCH	\N	\N	\N
648	61	1075	RESEARCH	\N	\N	\N
111	\N	140	ACADEMY	4	\N	\N
109	108	1076	RESEARCH	\N	\N	\N
110	109	1077	RESEARCH	\N	\N	\N
111	110	1078	RESEARCH	\N	\N	\N
112	111	1079	RESEARCH	\N	\N	\N
113	112	1080	RESEARCH	\N	\N	\N
114	113	1081	RESEARCH	\N	\N	\N
115	114	1082	RESEARCH	\N	\N	\N
116	115	1083	RESEARCH	\N	\N	\N
117	116	1084	RESEARCH	\N	\N	\N
649	\N	1085	ACADEMY	4	\N	\N
650	\N	1086	ACADEMY	4	\N	\N
651	\N	1087	ACADEMY	4	\N	\N
652	\N	1088	ACADEMY	4	\N	\N
653	\N	1089	ACADEMY	4	\N	\N
654	\N	1090	ACADEMY	4	\N	\N
655	\N	1091	ACADEMY	4	\N	\N
656	\N	1092	ACADEMY	4	\N	\N
657	\N	1093	ACADEMY	4	\N	\N
658	\N	1094	ACADEMY	4	\N	\N
659	\N	1095	ACADEMY	4	\N	\N
660	\N	1096	ACADEMY	4	\N	\N
661	\N	1097	ACADEMY	5	\N	\N
662	\N	1098	ACADEMY	5	\N	\N
663	\N	1099	ACADEMY	5	\N	\N
664	\N	1100	ACADEMY	6	\N	\N
665	\N	1101	ACADEMY	6	\N	\N
666	\N	1102	ACADEMY	6	\N	\N
667	\N	1103	ACADEMY	7	\N	\N
668	\N	1104	ACADEMY	7	\N	\N
669	\N	1105	ACADEMY	7	\N	\N
670	\N	1106	ACADEMY	8	\N	\N
671	\N	1107	ACADEMY	8	\N	\N
672	\N	1108	ACADEMY	8	\N	\N
673	\N	1109	ACADEMY	9	\N	\N
674	\N	1110	ACADEMY	9	\N	\N
675	\N	1111	ACADEMY	9	\N	\N
676	\N	1112	ACADEMY	10	\N	\N
677	\N	1113	ACADEMY	10	\N	\N
678	\N	1114	ACADEMY	10	\N	\N
649	108	1115	RESEARCH	\N	\N	\N
650	108	1116	RESEARCH	\N	\N	\N
651	108	1117	RESEARCH	\N	\N	\N
652	109	1118	RESEARCH	\N	\N	\N
653	109	1119	RESEARCH	\N	\N	\N
654	109	1120	RESEARCH	\N	\N	\N
655	110	1121	RESEARCH	\N	\N	\N
656	110	1122	RESEARCH	\N	\N	\N
657	110	1123	RESEARCH	\N	\N	\N
658	111	1124	RESEARCH	\N	\N	\N
659	111	1125	RESEARCH	\N	\N	\N
660	111	1126	RESEARCH	\N	\N	\N
661	112	1127	RESEARCH	\N	\N	\N
662	112	1128	RESEARCH	\N	\N	\N
663	112	1129	RESEARCH	\N	\N	\N
664	113	1130	RESEARCH	\N	\N	\N
665	113	1131	RESEARCH	\N	\N	\N
666	113	1132	RESEARCH	\N	\N	\N
667	114	1133	RESEARCH	\N	\N	\N
668	114	1134	RESEARCH	\N	\N	\N
669	114	1135	RESEARCH	\N	\N	\N
670	115	1136	RESEARCH	\N	\N	\N
671	115	1137	RESEARCH	\N	\N	\N
672	115	1138	RESEARCH	\N	\N	\N
673	116	1139	RESEARCH	\N	\N	\N
674	116	1140	RESEARCH	\N	\N	\N
675	116	1141	RESEARCH	\N	\N	\N
676	117	1142	RESEARCH	\N	\N	\N
677	117	1143	RESEARCH	\N	\N	\N
678	117	1144	RESEARCH	\N	\N	\N
679	\N	1145	ACADEMY	1	\N	\N
680	\N	1146	ACADEMY	2	\N	\N
681	\N	1147	ACADEMY	3	\N	\N
682	\N	1148	ACADEMY	4	\N	\N
683	\N	1149	ACADEMY	5	\N	\N
684	\N	1150	ACADEMY	6	\N	\N
685	\N	1151	ACADEMY	7	\N	\N
686	\N	1152	ACADEMY	8	\N	\N
687	\N	1153	ACADEMY	9	\N	\N
688	\N	1154	ACADEMY	10	\N	\N
680	679	1163	RESEARCH	\N	\N	\N
681	680	1164	RESEARCH	\N	\N	\N
682	681	1165	RESEARCH	\N	\N	\N
683	682	1166	RESEARCH	\N	\N	\N
684	683	1167	RESEARCH	\N	\N	\N
685	684	1168	RESEARCH	\N	\N	\N
686	685	1169	RESEARCH	\N	\N	\N
687	686	1170	RESEARCH	\N	\N	\N
688	687	1171	RESEARCH	\N	\N	\N
5	119	1172	RESEARCH	\N	\N	\N
34	119	1173	RESEARCH	\N	\N	\N
54	119	1174	RESEARCH	\N	\N	\N
18	120	1175	RESEARCH	\N	\N	\N
62	120	1176	RESEARCH	\N	\N	\N
55	120	1177	RESEARCH	\N	\N	\N
27	121	1178	RESEARCH	\N	\N	\N
35	121	1179	RESEARCH	\N	\N	\N
70	121	1180	RESEARCH	\N	\N	\N
57	121	1181	RESEARCH	\N	\N	\N
74	122	1182	RESEARCH	\N	\N	\N
19	122	1183	RESEARCH	\N	\N	\N
63	122	1184	RESEARCH	\N	\N	\N
633	122	1185	RESEARCH	\N	\N	\N
28	123	1186	RESEARCH	\N	\N	\N
36	123	1187	RESEARCH	\N	\N	\N
58	123	1188	RESEARCH	\N	\N	\N
71	123	1189	RESEARCH	\N	\N	\N
75	124	1190	RESEARCH	\N	\N	\N
20	124	1191	RESEARCH	\N	\N	\N
362	124	1192	RESEARCH	\N	\N	\N
639	124	1193	RESEARCH	\N	\N	\N
29	125	1194	RESEARCH	\N	\N	\N
37	125	1195	RESEARCH	\N	\N	\N
60	125	1196	RESEARCH	\N	\N	\N
72	125	1197	RESEARCH	\N	\N	\N
76	126	1198	RESEARCH	\N	\N	\N
21	126	1199	RESEARCH	\N	\N	\N
64	126	1200	RESEARCH	\N	\N	\N
645	126	1201	RESEARCH	\N	\N	\N
73	127	1202	RESEARCH	\N	\N	\N
77	127	1203	RESEARCH	\N	\N	\N
119	118	1204	RESEARCH	\N	\N	\N
120	119	1205	RESEARCH	\N	\N	\N
121	120	1206	RESEARCH	\N	\N	\N
122	121	1207	RESEARCH	\N	\N	\N
123	122	1208	RESEARCH	\N	\N	\N
124	123	1209	RESEARCH	\N	\N	\N
125	124	1210	RESEARCH	\N	\N	\N
126	125	1211	RESEARCH	\N	\N	\N
127	126	1212	RESEARCH	\N	\N	\N
\.


--
-- Data for Name: research_nodes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.research_nodes (id, name, description, research_seconds, gold_cost, food_cost, discipline, branch_code, branch_name, level, step, effect_type, requires_academy_level, linked_building_id, is_gateway, quarry_bonus_pct, requires_quarry_level, bonus_pct, bonus_type, bonus_value) FROM stdin;
27	Masonry 2	\N	360	600	600	RESOURCE	MASONRY	Masonry	2	0	BONUS	6	\N	t	0.00	6	\N	\N	\N
58	Superior Armory Systems	Unlocks bonus research to increase Military Equipment effectiveness	360	600	600	MILITARY	IRON_WORKING	Iron Working	3	0	BONUS	6	\N	t	0.00	0	35.00	ATTACK	35.00
60	Armory Management	Unlocks bonus research to increase Military Equipment effectiveness	480	800	800	MILITARY	IRON_WORKING	Iron Working	4	0	BONUS	8	\N	t	0.00	0	40.00	ATTACK	40.00
54	Forging Basics	Unlocks bonus research to increase Military Equipment effectiveness	120	200	200	MILITARY	IRON_WORKING	Iron Working	1	0	BONUS	2	\N	t	0.00	0	25.00	ATTACK	25.00
56	Forging Mastery	Unlocks bonus research to increase Military Equipment effectiveness	240	400	400	MILITARY	IRON_WORKING	Iron Working	2	0	BONUS	4	\N	t	0.00	0	30.00	ATTACK	30.00
57	Advanced Smithing	Unlocks bonus research to increase Military Equipment effectiveness	300	500	500	MILITARY	IRON_WORKING	Iron Working	2	0	BONUS	5	\N	t	0.00	0	30.00	ATTACK	2.00
59	Forging Strategy	Unlocks bonus research to increase Military Equipment effectiveness	420	700	700	MILITARY	IRON_WORKING	Iron Working	3	0	BONUS	7	\N	t	0.00	0	35.00	ATTACK	2.00
61	Forging Optimization	Unlocks bonus research to increase Military Equipment effectiveness	540	900	900	MILITARY	IRON_WORKING	Iron Working	4	0	BONUS	9	\N	t	0.00	0	40.00	ATTACK	2.00
1	Stone Production 1	Unlocks bonus research to increase Quarry effectiveness	180	300	300	RESOURCE	MASONRY_STONE	Stone Production	1	0	BONUS	3	7	t	0.00	3	\N	QUARRY_EFFECTIVENESS	\N
55	Metal Purification	Unlocks bonus research to increase Military Equipment effectiveness	180	300	300	MILITARY	IRON_WORKING	Iron Working	1	0	BONUS	3	\N	t	0.00	0	25.00	ATTACK	2.00
627	Metal Tempering	+2% Attack	120	200	200	MILITARY	IRON_WORKING	Iron Working	1	0	BONUS	2	\N	f	0.00	0	\N	DEFENSE	25.00
633	Steelwork Basics	+2% Attack	240	400	400	MILITARY	IRON_WORKING	Iron Working	2	0	BONUS	4	\N	f	0.00	0	\N	DEFENSE	30.00
639	High-Heat Forging	+2% Attack	360	600	600	MILITARY	IRON_WORKING	Iron Working	3	0	BONUS	6	\N	f	0.00	0	\N	DEFENSE	35.00
645	Alloy Crafting	+2% Attack	480	800	800	MILITARY	IRON_WORKING	Iron Working	4	0	BONUS	8	\N	f	0.00	0	\N	DEFENSE	40.00
18	Woodworking 1	\N	180	300	300	RESOURCE	LUMBERING_WOODWORKING	Lumbering (Woodworking)	1	0	BONUS	3	\N	f	0.00	0	\N	\N	\N
19	Woodworking 2	\N	300	500	500	RESOURCE	LUMBERING_WOODWORKING	Lumbering (Woodworking)	2	0	BONUS	5	\N	f	0.00	0	\N	\N	\N
20	Woodworking 3	\N	420	700	700	RESOURCE	LUMBERING_WOODWORKING	Lumbering (Woodworking)	3	0	BONUS	7	\N	f	0.00	0	\N	\N	\N
21	Woodworking 4	\N	540	900	900	RESOURCE	LUMBERING_WOODWORKING	Lumbering (Woodworking)	4	0	BONUS	9	\N	f	0.00	0	\N	\N	\N
34	Blacksmithing 1	\N	60	100	100	RESOURCE	METAL_CASTING	Metal Casting	1	0	BONUS	1	\N	f	0.00	0	\N	\N	\N
35	Blacksmithing 2	\N	180	300	300	RESOURCE	METAL_CASTING	Metal Casting	2	0	BONUS	3	\N	f	0.00	0	\N	\N	\N
36	Blacksmithing 3	\N	300	500	500	RESOURCE	METAL_CASTING	Metal Casting	3	0	BONUS	5	\N	f	0.00	0	\N	\N	\N
37	Blacksmithing 4	\N	420	700	700	RESOURCE	METAL_CASTING	Metal Casting	4	0	BONUS	7	\N	f	0.00	0	\N	\N	\N
38	Storage 1	\N	240	400	400	RESOURCE	STOCKPILE	Stockpile	1	0	BONUS	4	\N	f	0.00	0	\N	\N	\N
39	Storage 2	\N	360	600	600	RESOURCE	STOCKPILE	Stockpile	2	0	BONUS	6	\N	f	0.00	0	\N	\N	\N
40	Storage 3	\N	480	800	800	RESOURCE	STOCKPILE	Stockpile	3	0	BONUS	8	\N	f	0.00	0	\N	\N	\N
41	Storage 4	\N	600	1000	1000	RESOURCE	STOCKPILE	Stockpile	4	0	BONUS	10	\N	f	0.00	0	\N	\N	\N
42	Carry Capacity 1	\N	300	500	500	RESOURCE	LOGISTICS	Logistics	1	0	BONUS	5	\N	f	0.00	0	\N	\N	\N
43	Carry Capacity 2	\N	360	600	600	RESOURCE	LOGISTICS	Logistics	2	0	BONUS	6	\N	f	0.00	0	\N	\N	\N
44	Carry Capacity 3	\N	420	700	700	RESOURCE	LOGISTICS	Logistics	3	0	BONUS	7	\N	f	0.00	0	\N	\N	\N
45	Carry Capacity 4	\N	480	800	800	RESOURCE	LOGISTICS	Logistics	4	0	BONUS	8	\N	f	0.00	0	\N	\N	\N
46	Troop 1 (footmen)	\N	60	100	100	MILITARY	MILITARY_SCIENCE	Military Science	1	0	BONUS	1	\N	f	0.00	0	\N	\N	\N
47	Troop 2 (archers)	\N	180	300	300	MILITARY	MILITARY_SCIENCE	Military Science	2	0	BONUS	3	\N	f	0.00	0	\N	\N	\N
48	Troop 3 (calvary)	\N	300	500	500	MILITARY	MILITARY_SCIENCE	Military Science	3	0	BONUS	5	\N	f	0.00	0	\N	\N	\N
49	Troop 4 (Siege)	\N	420	700	700	MILITARY	MILITARY_SCIENCE	Military Science	4	0	BONUS	7	\N	f	0.00	0	\N	\N	\N
50	troop improvement 1	\N	120	200	200	MILITARY	MILITARY_TRADITION	Military Tradition	1	0	BONUS	2	\N	f	0.00	0	\N	\N	\N
51	troop improvement 2	\N	240	400	400	MILITARY	MILITARY_TRADITION	Military Tradition	2	0	BONUS	4	\N	f	0.00	0	\N	\N	\N
52	troop improvement 3	\N	360	600	600	MILITARY	MILITARY_TRADITION	Military Tradition	3	0	BONUS	6	\N	f	0.00	0	\N	\N	\N
53	troop improvement 4	\N	480	800	800	MILITARY	MILITARY_TRADITION	Military Tradition	4	0	BONUS	8	\N	f	0.00	0	\N	\N	\N
66	horse husbandry 1	\N	120	200	200	MILITARY	HORSEBACK_RIDING	Horseback Riding	1	0	BONUS	2	\N	f	0.00	0	\N	\N	\N
67	horse husbandry 2	\N	240	400	400	MILITARY	HORSEBACK_RIDING	Horseback Riding	2	0	BONUS	4	\N	f	0.00	0	\N	\N	\N
68	horse husbandry 3	\N	360	600	600	MILITARY	HORSEBACK_RIDING	Horseback Riding	3	0	BONUS	6	\N	f	0.00	0	\N	\N	\N
69	horse husbandry 4	\N	480	800	800	MILITARY	HORSEBACK_RIDING	Horseback Riding	4	0	BONUS	8	\N	f	0.00	0	\N	\N	\N
70	Engineering 1	\N	240	400	400	MILITARY	ENGINEERING	Engineering	1	0	BONUS	4	\N	f	0.00	0	\N	\N	\N
71	Engineering 2	\N	360	600	600	MILITARY	ENGINEERING	Engineering	2	0	BONUS	6	\N	f	0.00	0	\N	\N	\N
72	Engineering 3	\N	480	800	800	MILITARY	ENGINEERING	Engineering	3	0	BONUS	8	\N	f	0.00	0	\N	\N	\N
73	Engineering 4	\N	600	1000	1000	MILITARY	ENGINEERING	Engineering	4	0	BONUS	10	\N	f	0.00	0	\N	\N	\N
74	Mechanisms 1	\N	300	500	500	MILITARY	MACHINERY	Machinery	1	0	BONUS	5	\N	f	0.00	0	\N	\N	\N
75	Mechanisms 2	\N	360	600	600	MILITARY	MACHINERY	Machinery	2	0	BONUS	6	\N	f	0.00	0	\N	\N	\N
76	Mechanisms 3	\N	420	700	700	MILITARY	MACHINERY	Machinery	3	0	BONUS	7	\N	f	0.00	0	\N	\N	\N
77	Mechanisms 4	\N	480	800	800	MILITARY	MACHINERY	Machinery	4	0	BONUS	8	\N	f	0.00	0	\N	\N	\N
98	Material Planning	Unlocks bonus research to increase Construction effectiveness	60	100	100	DEVELOPMENT	CONSTRUCTION	Construction	1	0	BONUS	1	\N	t	0.00	0	20.00	CONSTRUCTION_SPEED	20.00
99	Building Standards	Unlocks bonus research to increase Construction effectiveness	120	200	200	DEVELOPMENT	CONSTRUCTION	Construction	2	0	BONUS	2	\N	t	0.00	0	25.00	CONSTRUCTION_SPEED	25.00
118	Village Work Codes	Unlocks bonus research to increase Craftsmanship effectiveness	60	100	100	DEVELOPMENT	CRAFTSMANSHIP	Craftsmanship	1	0	BONUS	1	\N	t	0.00	0	20.00	CRAFTSMANSHIP_SPEED	20.00
119	Guildhouse Organization	Unlocks bonus research to increase Craftsmanship effectiveness	120	200	200	DEVELOPMENT	CRAFTSMANSHIP	Craftsmanship	2	0	BONUS	2	\N	t	0.00	0	25.00	CRAFTSMANSHIP_SPEED	25.00
484	Cavalry Tactics	+2% Attack	240	400	400	DIPLOMACY	ATTACK	Attack Leadership	4	0	BONUS	4	\N	f	0.00	0	\N	ATTACK	2.00
485	Command Presence	+2% Attack	240	400	400	DIPLOMACY	ATTACK	Attack Leadership	4	0	BONUS	4	\N	f	0.00	0	\N	ATTACK	2.00
486	Siege Engineering	+2% Attack	240	400	400	DIPLOMACY	ATTACK	Attack Leadership	4	0	BONUS	4	\N	f	0.00	0	\N	ATTACK	2.00
487	Elite Infantry	+2% Attack	300	500	500	DIPLOMACY	ATTACK	Attack Leadership	5	0	BONUS	5	\N	f	0.00	0	\N	ATTACK	2.00
488	Officer Command	+2% Attack	300	500	500	DIPLOMACY	ATTACK	Attack Leadership	5	0	BONUS	5	\N	f	0.00	0	\N	ATTACK	2.00
489	Siege Mastery	+2% Attack	300	500	500	DIPLOMACY	ATTACK	Attack Leadership	5	0	BONUS	5	\N	f	0.00	0	\N	ATTACK	2.00
5	Masonry 1	Unlocks bonus research to increase Quarry effectiveness	240	400	400	RESOURCE	MASONRY	Masonry	1	0	BONUS	4	7	t	0.00	4	\N	\N	\N
595	Cartography Basics	+2% Map Efficiency	60	100	100	KNOWLEDGE	COMPASS	Compass	1	0	BONUS	1	\N	f	0.00	0	\N	MAP_EFFICIENCY	2.00
596	Land Surveying	+2% Map Efficiency	60	100	100	KNOWLEDGE	COMPASS	Compass	1	0	BONUS	1	\N	f	0.00	0	\N	MAP_EFFICIENCY	2.00
597	Terrain Reading	+2% Map Efficiency	60	100	100	KNOWLEDGE	COMPASS	Compass	1	0	BONUS	1	\N	f	0.00	0	\N	MAP_EFFICIENCY	2.00
601	Advanced Cartography	+2% Map Efficiency	180	300	300	KNOWLEDGE	COMPASS	Compass	2	0	BONUS	3	\N	f	0.00	0	\N	MAP_EFFICIENCY	2.00
602	Topography Study	+2% Map Efficiency	180	300	300	KNOWLEDGE	COMPASS	Compass	2	0	BONUS	3	\N	f	0.00	0	\N	MAP_EFFICIENCY	2.00
613	Elite Cartography	+2% Map Efficiency	420	700	700	KNOWLEDGE	COMPASS	Compass	4	0	BONUS	7	\N	f	0.00	0	\N	MAP_EFFICIENCY	2.00
614	Advanced Surveying	+2% Map Efficiency	420	700	700	KNOWLEDGE	COMPASS	Compass	4	0	BONUS	7	\N	f	0.00	0	\N	MAP_EFFICIENCY	2.00
615	Geographic Innovation	+2% Map Efficiency	420	700	700	KNOWLEDGE	COMPASS	Compass	4	0	BONUS	7	\N	f	0.00	0	\N	MAP_EFFICIENCY	2.00
619	Master Cartography	+2% Map Efficiency	540	900	900	KNOWLEDGE	COMPASS	Compass	5	0	BONUS	9	\N	f	0.00	0	\N	MAP_EFFICIENCY	2.00
620	Survey Supremacy	+2% Map Efficiency	540	900	900	KNOWLEDGE	COMPASS	Compass	5	0	BONUS	9	\N	f	0.00	0	\N	MAP_EFFICIENCY	2.00
621	Geographic Supremacy	+2% Map Efficiency	540	900	900	KNOWLEDGE	COMPASS	Compass	5	0	BONUS	9	\N	f	0.00	0	\N	MAP_EFFICIENCY	2.00
598	Travel Speed 1	+2% Movement Speed	120	200	200	KNOWLEDGE	COMPASS	Compass	1	0	BONUS	2	\N	f	0.00	0	\N	MOVEMENT_SPEED	2.00
599	Route Planning	+2% Movement Speed	120	200	200	KNOWLEDGE	COMPASS	Compass	1	0	BONUS	2	\N	f	0.00	0	\N	MOVEMENT_SPEED	2.00
600	Path Optimization	+2% Movement Speed	120	200	200	KNOWLEDGE	COMPASS	Compass	1	0	BONUS	2	\N	f	0.00	0	\N	MOVEMENT_SPEED	2.00
604	Travel Speed 2	+2% Movement Speed	240	400	400	KNOWLEDGE	COMPASS	Compass	2	0	BONUS	4	\N	f	0.00	0	\N	MOVEMENT_SPEED	2.00
605	Route Efficiency	+2% Movement Speed	240	400	400	KNOWLEDGE	COMPASS	Compass	2	0	BONUS	4	\N	f	0.00	0	\N	MOVEMENT_SPEED	2.00
606	March Coordination	+2% Movement Speed	240	400	400	KNOWLEDGE	COMPASS	Compass	2	0	BONUS	4	\N	f	0.00	0	\N	MOVEMENT_SPEED	2.00
610	Travel Speed 3	+2% Movement Speed	360	600	600	KNOWLEDGE	COMPASS	Compass	3	0	BONUS	6	\N	f	0.00	0	\N	MOVEMENT_SPEED	2.00
611	Route Optimization	+2% Movement Speed	360	600	600	KNOWLEDGE	COMPASS	Compass	3	0	BONUS	6	\N	f	0.00	0	\N	MOVEMENT_SPEED	2.00
612	March Logistics	+2% Movement Speed	360	600	600	KNOWLEDGE	COMPASS	Compass	3	0	BONUS	6	\N	f	0.00	0	\N	MOVEMENT_SPEED	2.00
616	Travel Speed 4	+2% Movement Speed	480	800	800	KNOWLEDGE	COMPASS	Compass	4	0	BONUS	8	\N	f	0.00	0	\N	MOVEMENT_SPEED	2.00
617	Route Innovation	+2% Movement Speed	480	800	800	KNOWLEDGE	COMPASS	Compass	4	0	BONUS	8	\N	f	0.00	0	\N	MOVEMENT_SPEED	2.00
618	March Enhancement	+2% Movement Speed	480	800	800	KNOWLEDGE	COMPASS	Compass	4	0	BONUS	8	\N	f	0.00	0	\N	MOVEMENT_SPEED	2.00
622	Travel Speed 5	+2% Movement Speed	600	1000	1000	KNOWLEDGE	COMPASS	Compass	5	0	BONUS	10	\N	f	0.00	0	\N	MOVEMENT_SPEED	2.00
623	Route Supremacy	+2% Movement Speed	600	1000	1000	KNOWLEDGE	COMPASS	Compass	5	0	BONUS	10	\N	f	0.00	0	\N	MOVEMENT_SPEED	2.00
624	March Supremacy	+2% Movement Speed	600	1000	1000	KNOWLEDGE	COMPASS	Compass	5	0	BONUS	10	\N	f	0.00	0	\N	MOVEMENT_SPEED	2.00
88	Navigation Fundamentals	Unlocks bonus research to increase Map effectiveness	60	100	100	KNOWLEDGE	COMPASS	Compass	1	0	BONUS	1	\N	t	0.00	0	20.00	COMPASS_EFFECTIVENESS	20.00
93	Travel Coordination	Unlocks bonus research to increase Movement effectiveness	120	200	200	KNOWLEDGE	COMPASS	Compass	1	0	BONUS	2	\N	t	0.00	0	20.00	COMPASS_EFFECTIVENESS	20.00
187	Stone Production 2	\N	300	500	500	RESOURCE	MASONRY_STONE	Stone Production	2	0	BONUS	5	\N	t	0.00	5	\N	QUARRY_EFFECTIVENESS	\N
188	Block Shaping	\N	300	500	500	RESOURCE	MASONRY_STONE	Stone Production	2	0	BONUS	5	\N	f	0.02	5	\N	QUARRY_EFFECTIVENESS	2.00
189	Skilled Masons	\N	300	500	500	RESOURCE	MASONRY_STONE	Stone Production	2	0	BONUS	5	\N	f	0.02	5	\N	QUARRY_EFFECTIVENESS	2.00
190	Stone Grading	\N	300	500	500	RESOURCE	MASONRY_STONE	Stone Production	2	0	BONUS	5	\N	f	0.02	5	\N	QUARRY_EFFECTIVENESS	2.00
148	Civic Order	Unlocks bonus research to increase Politics effectiveness	60	100	100	DIPLOMACY	POLITICS	Politics	1	0	BONUS	1	\N	t	0.00	0	20.00	POLITICS	20.00
493	Elite Cavalry	+2% Attack	420	700	700	DIPLOMACY	ATTACK	Attack Leadership	7	0	BONUS	7	\N	f	0.00	0	\N	ATTACK	2.00
494	High Command	+2% Attack	420	700	700	DIPLOMACY	ATTACK	Attack Leadership	7	0	BONUS	7	\N	f	0.00	0	\N	ATTACK	2.00
495	Siege Logistics	+2% Attack	420	700	700	DIPLOMACY	ATTACK	Attack Leadership	7	0	BONUS	7	\N	f	0.00	0	\N	ATTACK	2.00
496	Warrior Mastery	+2% Attack	480	800	800	DIPLOMACY	ATTACK	Attack Leadership	8	0	BONUS	8	\N	f	0.00	0	\N	ATTACK	2.00
497	Generalship	+2% Attack	480	800	800	DIPLOMACY	ATTACK	Attack Leadership	8	0	BONUS	8	\N	f	0.00	0	\N	ATTACK	2.00
498	Siege Innovation	+2% Attack	480	800	800	DIPLOMACY	ATTACK	Attack Leadership	8	0	BONUS	8	\N	f	0.00	0	\N	ATTACK	2.00
499	Army Integration	+2% Attack	540	900	900	DIPLOMACY	ATTACK	Attack Leadership	9	0	BONUS	9	\N	f	0.00	0	\N	ATTACK	2.00
89	Map Refinement	Unlocks bonus research to increase Map effectiveness	180	300	300	KNOWLEDGE	COMPASS	Compass	2	0	BONUS	3	\N	t	0.00	0	25.00	COMPASS_EFFECTIVENESS	25.00
94	Travel Strategy	Unlocks bonus research to increase Movement effectiveness	240	400	400	KNOWLEDGE	COMPASS	Compass	2	0	BONUS	4	\N	t	0.00	0	25.00	COMPASS_EFFECTIVENESS	25.00
90	Mapping Strategy	Unlocks bonus research to increase Map effectiveness	300	500	500	KNOWLEDGE	COMPASS	Compass	3	0	BONUS	5	\N	t	0.00	0	30.00	COMPASS_EFFECTIVENESS	30.00
95	Travel Doctrine	Unlocks bonus research to increase Movement effectiveness	360	600	600	KNOWLEDGE	COMPASS	Compass	3	0	BONUS	6	\N	t	0.00	0	30.00	COMPASS_EFFECTIVENESS	30.00
91	Mapping Optimization	Unlocks bonus research to increase Map effectiveness	420	700	700	KNOWLEDGE	COMPASS	Compass	4	0	BONUS	7	\N	t	0.00	0	35.00	COMPASS_EFFECTIVENESS	35.00
96	Travel Governance	Unlocks bonus research to increase Movement effectiveness	480	800	800	KNOWLEDGE	COMPASS	Compass	4	0	BONUS	8	\N	t	0.00	0	35.00	COMPASS_EFFECTIVENESS	35.00
92	Mapping Supremacy	Unlocks bonus research to increase Map effectiveness	540	900	900	KNOWLEDGE	COMPASS	Compass	5	0	BONUS	9	\N	t	0.00	0	40.00	COMPASS_EFFECTIVENESS	40.00
97	Travel Supremacy	Unlocks bonus research to increase Movement effectiveness	600	1000	1000	KNOWLEDGE	COMPASS	Compass	5	0	BONUS	10	\N	t	0.00	0	40.00	COMPASS_EFFECTIVENESS	40.00
625	Weapons Improvement 1	+2% Attack	120	200	200	MILITARY	IRON_WORKING	Iron Working	1	0	BONUS	2	\N	f	0.00	0	\N	ATTACK	2.00
626	Weapon Craft Basics	+2% Attack	120	200	200	MILITARY	IRON_WORKING	Iron Working	1	0	BONUS	2	\N	f	0.00	0	\N	ATTACK	2.00
631	Weapons Improvement 2	+2% Attack	240	400	400	MILITARY	IRON_WORKING	Iron Working	2	0	BONUS	4	\N	f	0.00	0	\N	ATTACK	2.00
632	Weapon Sharpening	+2% Attack	240	400	400	MILITARY	IRON_WORKING	Iron Working	2	0	BONUS	4	\N	f	0.00	0	\N	ATTACK	2.00
637	Weapons Improvement 3	+2% Attack	360	600	600	MILITARY	IRON_WORKING	Iron Working	3	0	BONUS	6	\N	f	0.00	0	\N	ATTACK	2.00
638	Weapon Precision	+2% Attack	360	600	600	MILITARY	IRON_WORKING	Iron Working	3	0	BONUS	6	\N	f	0.00	0	\N	ATTACK	2.00
643	Weapons Improvement 4	+2% Attack	480	800	800	MILITARY	IRON_WORKING	Iron Working	4	0	BONUS	8	\N	f	0.00	0	\N	ATTACK	2.00
644	Weapon Enhancement	+2% Attack	480	800	800	MILITARY	IRON_WORKING	Iron Working	4	0	BONUS	8	\N	f	0.00	0	\N	ATTACK	2.00
628	Armor Reinforcement 1	+2% Defense	180	300	300	MILITARY	IRON_WORKING	Iron Working	1	0	BONUS	3	\N	f	0.00	0	\N	DEFENSE	2.00
629	Shield Craft Basics	+2% Defense	180	300	300	MILITARY	IRON_WORKING	Iron Working	1	0	BONUS	3	\N	f	0.00	0	\N	DEFENSE	2.00
630	Smelting Techniques	+2% Defense	180	300	300	MILITARY	IRON_WORKING	Iron Working	1	0	BONUS	3	\N	f	0.00	0	\N	DEFENSE	2.00
634	Armor Reinforcement 2	+2% Defense	300	500	500	MILITARY	IRON_WORKING	Iron Working	2	0	BONUS	5	\N	f	0.00	0	\N	DEFENSE	2.00
635	Shield Strengthening	+2% Defense	300	500	500	MILITARY	IRON_WORKING	Iron Working	2	0	BONUS	5	\N	f	0.00	0	\N	DEFENSE	2.00
636	Advanced Smelting	+2% Defense	300	500	500	MILITARY	IRON_WORKING	Iron Working	2	0	BONUS	5	\N	f	0.00	0	\N	DEFENSE	2.00
640	Armor Reinforcement 3	+2% Defense	420	700	700	MILITARY	IRON_WORKING	Iron Working	3	0	BONUS	7	\N	f	0.00	0	\N	DEFENSE	2.00
641	Shield Optimization	+2% Defense	420	700	700	MILITARY	IRON_WORKING	Iron Working	3	0	BONUS	7	\N	f	0.00	0	\N	DEFENSE	2.00
642	Metalwork Innovation	+2% Defense	420	700	700	MILITARY	IRON_WORKING	Iron Working	3	0	BONUS	7	\N	f	0.00	0	\N	DEFENSE	2.00
646	Armor Reinforcement 4	+2% Defense	540	900	900	MILITARY	IRON_WORKING	Iron Working	4	0	BONUS	9	\N	f	0.00	0	\N	DEFENSE	2.00
647	Shield Mastery	+2% Defense	540	900	900	MILITARY	IRON_WORKING	Iron Working	4	0	BONUS	9	\N	f	0.00	0	\N	DEFENSE	2.00
648	Metalwork Optimization	+2% Defense	540	900	900	MILITARY	IRON_WORKING	Iron Working	4	0	BONUS	9	\N	f	0.00	0	\N	DEFENSE	2.00
65	Crossbow Tier	Unlocks bonus research to increase Archer effectiveness	540	900	900	MILITARY	ARCHERY	Archery	5	0	BONUS	9	\N	t	0.00	0	\N	ARCHER_EFFECTIVENESS	\N
362	Longbow Tier	Unlocks bonus research to increase Archer effectiveness	360	600	600	MILITARY	ARCHERY	Archery	3	0	BONUS	6	\N	t	0.00	0	\N	ARCHER_EFFECTIVENESS	\N
108	First Aid 1	Increases Casualty Save Rate by 1%	60	100	100	DEVELOPMENT	MEDICINE	Medicine	1	0	BONUS	4	\N	t	0.00	0	1.00	CASUALTY_SAVE_RATE	1.00
109	First Aid 2	Increases Casualty Save Rate by 1%	120	200	200	DEVELOPMENT	MEDICINE	Medicine	2	0	BONUS	4	\N	t	0.00	0	1.00	CASUALTY_SAVE_RATE	1.00
110	First Aid 3	Increases Casualty Save Rate by 1%	180	300	300	DEVELOPMENT	MEDICINE	Medicine	3	0	BONUS	4	\N	t	0.00	0	1.00	CASUALTY_SAVE_RATE	1.00
111	First Aid 4	Increases Casualty Save Rate by 1%	240	400	400	DEVELOPMENT	MEDICINE	Medicine	4	0	BONUS	4	\N	t	0.00	0	1.00	CASUALTY_SAVE_RATE	1.00
112	First Aid 5	Increases Casualty Save Rate by 1%	300	500	500	DEVELOPMENT	MEDICINE	Medicine	5	0	BONUS	5	\N	t	0.00	0	1.00	CASUALTY_SAVE_RATE	1.00
113	First Aid 6	Increases Casualty Save Rate by 1%	360	600	600	DEVELOPMENT	MEDICINE	Medicine	6	0	BONUS	6	\N	t	0.00	0	1.00	CASUALTY_SAVE_RATE	1.00
114	First Aid 7	Increases Casualty Save Rate by 1%	420	700	700	DEVELOPMENT	MEDICINE	Medicine	7	0	BONUS	7	\N	t	0.00	0	1.00	CASUALTY_SAVE_RATE	1.00
115	First Aid 8	Increases Casualty Save Rate by 1%	480	800	800	DEVELOPMENT	MEDICINE	Medicine	8	0	BONUS	8	\N	t	0.00	0	1.00	CASUALTY_SAVE_RATE	1.00
116	First Aid 9	Increases Casualty Save Rate by 1%	540	900	900	DEVELOPMENT	MEDICINE	Medicine	9	0	BONUS	9	\N	t	0.00	0	1.00	CASUALTY_SAVE_RATE	1.00
117	First Aid 10	Increases Casualty Save Rate by 1%	600	1000	1000	DEVELOPMENT	MEDICINE	Medicine	10	0	BONUS	10	\N	t	0.00	0	1.00	CASUALTY_SAVE_RATE	1.00
649	Herbal Remedies	+2% Healing reduction in cost	240	400	400	DEVELOPMENT	MEDICINE	Medicine	1	0	BONUS	4	\N	f	0.00	0	\N	HEALING_COST_REDUCTION	2.00
650	Basic First Aid	+2% Healing reduction in cost	240	400	400	DEVELOPMENT	MEDICINE	Medicine	1	0	BONUS	4	\N	f	0.00	0	\N	HEALING_COST_REDUCTION	2.00
651	Village Healers	+2% Healing reduction in cost	240	400	400	DEVELOPMENT	MEDICINE	Medicine	1	0	BONUS	4	\N	f	0.00	0	\N	HEALING_COST_REDUCTION	2.00
652	Medical Training	+2% Healing reduction in cost	240	400	400	DEVELOPMENT	MEDICINE	Medicine	2	0	BONUS	4	\N	f	0.00	0	\N	HEALING_COST_REDUCTION	2.00
653	Public Baths	+2% Healing reduction in cost	240	400	400	DEVELOPMENT	MEDICINE	Medicine	2	0	BONUS	4	\N	f	0.00	0	\N	HEALING_COST_REDUCTION	2.00
654	Wound Care	+2% Healing reduction in cost	240	400	400	DEVELOPMENT	MEDICINE	Medicine	2	0	BONUS	4	\N	f	0.00	0	\N	HEALING_COST_REDUCTION	2.00
655	Healing Centers	+2% Healing reduction in cost	240	400	400	DEVELOPMENT	MEDICINE	Medicine	3	0	BONUS	4	\N	f	0.00	0	\N	HEALING_COST_REDUCTION	2.00
656	Medical Records	+2% Healing reduction in cost	240	400	400	DEVELOPMENT	MEDICINE	Medicine	3	0	BONUS	4	\N	f	0.00	0	\N	HEALING_COST_REDUCTION	2.00
657	Disease Recognition	+2% Healing reduction in cost	240	400	400	DEVELOPMENT	MEDICINE	Medicine	3	0	BONUS	4	\N	f	0.00	0	\N	HEALING_COST_REDUCTION	2.00
658	Skilled Physicians	+2% Healing reduction in cost	240	400	400	DEVELOPMENT	MEDICINE	Medicine	4	0	BONUS	4	\N	f	0.00	0	\N	HEALING_COST_REDUCTION	2.00
659	Surgical Methods	+2% Healing reduction in cost	240	400	400	DEVELOPMENT	MEDICINE	Medicine	4	0	BONUS	4	\N	f	0.00	0	\N	HEALING_COST_REDUCTION	2.00
660	Hospital Foundations	+2% Healing reduction in cost	240	400	400	DEVELOPMENT	MEDICINE	Medicine	4	0	BONUS	4	\N	f	0.00	0	\N	HEALING_COST_REDUCTION	2.00
661	Public Clinics	+2% Healing reduction in cost	300	500	500	DEVELOPMENT	MEDICINE	Medicine	5	0	BONUS	5	\N	f	0.00	0	\N	HEALING_COST_REDUCTION	2.00
662	Advanced Treatment	+2% Healing reduction in cost	300	500	500	DEVELOPMENT	MEDICINE	Medicine	5	0	BONUS	5	\N	f	0.00	0	\N	HEALING_COST_REDUCTION	2.00
663	Preventive Medicine	+2% Healing reduction in cost	300	500	500	DEVELOPMENT	MEDICINE	Medicine	5	0	BONUS	5	\N	f	0.00	0	\N	HEALING_COST_REDUCTION	2.00
664	Medical Research	+2% Healing reduction in cost	360	600	600	DEVELOPMENT	MEDICINE	Medicine	6	0	BONUS	6	\N	f	0.00	0	\N	HEALING_COST_REDUCTION	2.00
665	Regional Hospitals	+2% Healing reduction in cost	360	600	600	DEVELOPMENT	MEDICINE	Medicine	6	0	BONUS	6	\N	f	0.00	0	\N	HEALING_COST_REDUCTION	2.00
666	Health Standards	+2% Healing reduction in cost	360	600	600	DEVELOPMENT	MEDICINE	Medicine	6	0	BONUS	6	\N	f	0.00	0	\N	HEALING_COST_REDUCTION	2.00
667	Advanced Surgery	+2% Healing reduction in cost	420	700	700	DEVELOPMENT	MEDICINE	Medicine	7	0	BONUS	7	\N	f	0.00	0	\N	HEALING_COST_REDUCTION	2.00
668	Disease Prevention	+2% Healing reduction in cost	420	700	700	DEVELOPMENT	MEDICINE	Medicine	7	0	BONUS	7	\N	f	0.00	0	\N	HEALING_COST_REDUCTION	2.00
669	National Healthcare	+2% Healing reduction in cost	420	700	700	DEVELOPMENT	MEDICINE	Medicine	7	0	BONUS	7	\N	f	0.00	0	\N	HEALING_COST_REDUCTION	2.00
670	Research Institutes	+2% Healing reduction in cost	480	800	800	DEVELOPMENT	MEDICINE	Medicine	8	0	BONUS	8	\N	f	0.00	0	\N	HEALING_COST_REDUCTION	2.00
671	Modern Medicine	+2% Healing reduction in cost	480	800	800	DEVELOPMENT	MEDICINE	Medicine	8	0	BONUS	8	\N	f	0.00	0	\N	HEALING_COST_REDUCTION	2.00
672	Public Health Systems	+2% Healing reduction in cost	480	800	800	DEVELOPMENT	MEDICINE	Medicine	8	0	BONUS	8	\N	f	0.00	0	\N	HEALING_COST_REDUCTION	2.00
673	Disease Eradication	+2% Healing reduction in cost	540	900	900	DEVELOPMENT	MEDICINE	Medicine	9	0	BONUS	9	\N	f	0.00	0	\N	HEALING_COST_REDUCTION	2.00
674	Advanced Recovery	+2% Healing reduction in cost	540	900	900	DEVELOPMENT	MEDICINE	Medicine	9	0	BONUS	9	\N	f	0.00	0	\N	HEALING_COST_REDUCTION	2.00
675	Medical Innovation	+2% Healing reduction in cost	540	900	900	DEVELOPMENT	MEDICINE	Medicine	9	0	BONUS	9	\N	f	0.00	0	\N	HEALING_COST_REDUCTION	2.00
676	Health Mastery	+2% Healing reduction in cost	600	1000	1000	DEVELOPMENT	MEDICINE	Medicine	10	0	BONUS	10	\N	f	0.00	0	\N	HEALING_COST_REDUCTION	2.00
677	Medical Supremacy	+2% Healing reduction in cost	600	1000	1000	DEVELOPMENT	MEDICINE	Medicine	10	0	BONUS	10	\N	f	0.00	0	\N	HEALING_COST_REDUCTION	2.00
678	National Wellness	+2% Healing reduction in cost	600	1000	1000	DEVELOPMENT	MEDICINE	Medicine	10	0	BONUS	10	\N	f	0.00	0	\N	HEALING_COST_REDUCTION	2.00
679	Informatics 1	Determines intelligence depth for Scout reports (Delta Informatics)	60	100	100	KNOWLEDGE	INFORMATICS	Informatics	1	0	BONUS	1	\N	f	0.00	0	\N	\N	\N
680	Informatics 2	Determines intelligence depth for Scout reports (Delta Informatics)	120	200	200	KNOWLEDGE	INFORMATICS	Informatics	2	0	BONUS	2	\N	f	0.00	0	\N	\N	\N
681	Informatics 3	Determines intelligence depth for Scout reports (Delta Informatics)	180	300	300	KNOWLEDGE	INFORMATICS	Informatics	3	0	BONUS	3	\N	f	0.00	0	\N	\N	\N
682	Informatics 4	Determines intelligence depth for Scout reports (Delta Informatics)	240	400	400	KNOWLEDGE	INFORMATICS	Informatics	4	0	BONUS	4	\N	f	0.00	0	\N	\N	\N
683	Informatics 5	Determines intelligence depth for Scout reports (Delta Informatics)	300	500	500	KNOWLEDGE	INFORMATICS	Informatics	5	0	BONUS	5	\N	f	0.00	0	\N	\N	\N
684	Informatics 6	Determines intelligence depth for Scout reports (Delta Informatics)	360	600	600	KNOWLEDGE	INFORMATICS	Informatics	6	0	BONUS	6	\N	f	0.00	0	\N	\N	\N
685	Informatics 7	Determines intelligence depth for Scout reports (Delta Informatics)	420	700	700	KNOWLEDGE	INFORMATICS	Informatics	7	0	BONUS	7	\N	f	0.00	0	\N	\N	\N
686	Informatics 8	Determines intelligence depth for Scout reports (Delta Informatics)	480	800	800	KNOWLEDGE	INFORMATICS	Informatics	8	0	BONUS	8	\N	f	0.00	0	\N	\N	\N
687	Informatics 9	Determines intelligence depth for Scout reports (Delta Informatics)	540	900	900	KNOWLEDGE	INFORMATICS	Informatics	9	0	BONUS	9	\N	f	0.00	0	\N	\N	\N
688	Informatics 10	Determines intelligence depth for Scout reports (Delta Informatics)	600	1000	1000	KNOWLEDGE	INFORMATICS	Informatics	10	0	BONUS	10	\N	f	0.00	0	\N	\N	\N
363	Stone Arrowhead Chipping	+2% Archer damage	300	300	300	MILITARY	ARCHERY	Archery	1	0	BONUS	3	\N	f	0.00	0	\N	ARCHER_DAMAGE	2.00
365	Shaft Shaping	+2% Archer damage	300	300	300	MILITARY	ARCHERY	Archery	1	0	BONUS	3	\N	f	0.00	0	\N	ARCHER_DAMAGE	2.00
366	Primitive Archer Drills	+2% Archer damage	300	300	300	MILITARY	ARCHERY	Archery	1	0	BONUS	3	\N	f	0.00	0	\N	ARCHER_DAMAGE	2.00
368	Flint Knapping	+2% Archer damage	500	500	500	MILITARY	ARCHERY	Archery	2	0	BONUS	5	\N	f	0.00	0	\N	ARCHER_DAMAGE	2.00
371	Flint Archer Practice	+2% Archer damage	500	500	500	MILITARY	ARCHERY	Archery	2	0	BONUS	5	\N	f	0.00	0	\N	ARCHER_DAMAGE	2.00
374	Iron Shaft Fittings	+2% Archer damage	600	600	600	MILITARY	ARCHERY	Archery	3	0	BONUS	6	\N	f	0.00	0	\N	ARCHER_DAMAGE	2.00
375	Longbow Discipline	+2% Archer damage	600	600	600	MILITARY	ARCHERY	Archery	3	0	BONUS	6	\N	f	0.00	0	\N	ARCHER_DAMAGE	2.00
377	Composite Bow Lamination	+2% Archer damage	700	700	700	MILITARY	ARCHERY	Archery	4	0	BONUS	7	\N	f	0.00	0	\N	ARCHER_DAMAGE	2.00
379	Composite Bow Handling	+2% Archer damage	700	700	700	MILITARY	ARCHERY	Archery	4	0	BONUS	7	\N	f	0.00	0	\N	ARCHER_DAMAGE	2.00
381	Steel Bolt Forging	+2% Archer damage	900	900	900	MILITARY	ARCHERY	Archery	5	0	BONUS	9	\N	f	0.00	0	\N	ARCHER_DAMAGE	2.00
382	Crossbow Trigger Plates	+2% Archer damage	900	900	900	MILITARY	ARCHERY	Archery	5	0	BONUS	9	\N	f	0.00	0	\N	ARCHER_DAMAGE	2.00
364	Primitive Bow Staves	+2% Archer distance	300	300	300	MILITARY	ARCHERY	Archery	1	0	BONUS	3	\N	f	0.00	0	\N	ARCHER_DISTANCE	2.00
367	Shortbow Crafting	+2% Archer distance	300	300	300	MILITARY	ARCHERY	Archery	1	0	BONUS	3	\N	f	0.00	0	\N	ARCHER_DISTANCE	2.00
369	Fletching Improvements	+2% Archer distance	500	500	500	MILITARY	ARCHERY	Archery	2	0	BONUS	5	\N	f	0.00	0	\N	ARCHER_DISTANCE	2.00
370	Straight Shaft Production	+2% Archer distance	500	500	500	MILITARY	ARCHERY	Archery	2	0	BONUS	5	\N	f	0.00	0	\N	ARCHER_DISTANCE	2.00
372	Shaft Straightening	+2% Archer distance	500	500	500	MILITARY	ARCHERY	Archery	2	0	BONUS	5	\N	f	0.00	0	\N	ARCHER_DISTANCE	2.00
373	Longbow Limbs Reinforcement	+2% Archer distance	600	600	600	MILITARY	ARCHERY	Archery	3	0	BONUS	6	\N	f	0.00	0	\N	ARCHER_DISTANCE	2.00
376	Longbow Craftsmanship	+2% Archer distance	600	600	600	MILITARY	ARCHERY	Archery	3	0	BONUS	6	\N	f	0.00	0	\N	ARCHER_DISTANCE	2.00
378	Composite Bow Reinforcement	+2% Archer distance	700	700	700	MILITARY	ARCHERY	Archery	4	0	BONUS	7	\N	f	0.00	0	\N	ARCHER_DISTANCE	2.00
380	Composite Bow Construction	+2% Archer distance	700	700	700	MILITARY	ARCHERY	Archery	4	0	BONUS	7	\N	f	0.00	0	\N	ARCHER_DISTANCE	2.00
62	Bowery & Fletching 1	Unlocks bonus research to increase Archer effectiveness	180	300	300	MILITARY	ARCHERY	Archery	1	0	BONUS	3	\N	t	0.00	0	\N	ARCHER_EFFECTIVENESS	\N
63	Bowery & Fletching 2	Unlocks bonus research to increase Archer effectiveness	300	500	500	MILITARY	ARCHERY	Archery	2	0	BONUS	5	\N	t	0.00	0	\N	ARCHER_EFFECTIVENESS	\N
64	Composite Bow Tier	Unlocks bonus research to increase Archer effectiveness	420	700	700	MILITARY	ARCHERY	Archery	4	0	BONUS	7	\N	t	0.00	0	\N	ARCHER_EFFECTIVENESS	\N
383	Heavy Bow Limbs	+2% Archer distance	900	900	900	MILITARY	ARCHERY	Archery	5	0	BONUS	9	\N	f	0.00	0	\N	ARCHER_DISTANCE	2.00
174	Knowledge Charter	Unlocks bonus research to increase Intelligence effectiveness	420	700	700	DIPLOMACY	INTELLIGENCE	Research Speed	7	0	BONUS	7	\N	t	0.00	0	50.00	INTELLIGENCE	50.00
175	Research Management	Unlocks bonus research to increase Intelligence effectiveness	480	800	800	DIPLOMACY	INTELLIGENCE	Research Speed	8	0	BONUS	8	\N	t	0.00	0	55.00	INTELLIGENCE	55.00
176	Knowledge Optimization	Unlocks bonus research to increase Intelligence effectiveness	540	900	900	DIPLOMACY	INTELLIGENCE	Research Speed	9	0	BONUS	9	\N	t	0.00	0	60.00	INTELLIGENCE	60.00
177	Research Dominion	Unlocks bonus research to increase Intelligence effectiveness	600	1000	1000	DIPLOMACY	INTELLIGENCE	Research Speed	10	0	BONUS	10	\N	t	0.00	0	65.00	INTELLIGENCE	65.00
535	Coin Counting	+0.1% Tax Efficiency	60	100	100	RESOURCE	TAX	Tax	1	0	BONUS	1	\N	f	0.00	0	\N	TAX_EFFICIENCY	0.10
536	Market Collections	+0.1% Tax Efficiency	60	100	100	RESOURCE	TAX	Tax	1	0	BONUS	1	\N	f	0.00	0	\N	TAX_EFFICIENCY	0.10
537	Local Levies	+0.1% Tax Efficiency	60	100	100	RESOURCE	TAX	Tax	1	0	BONUS	1	\N	f	0.00	0	\N	TAX_EFFICIENCY	0.10
538	Trade Tariffs	+0.1% Tax Efficiency	120	200	200	RESOURCE	TAX	Tax	2	0	BONUS	2	\N	f	0.00	0	\N	TAX_EFFICIENCY	0.10
539	Town Collections	+0.1% Tax Efficiency	120	200	200	RESOURCE	TAX	Tax	2	0	BONUS	2	\N	f	0.00	0	\N	TAX_EFFICIENCY	0.10
540	Revenue Tracking	+0.1% Tax Efficiency	120	200	200	RESOURCE	TAX	Tax	2	0	BONUS	2	\N	f	0.00	0	\N	TAX_EFFICIENCY	0.10
541	Merchant Duties	+0.1% Tax Efficiency	180	300	300	RESOURCE	TAX	Tax	3	0	BONUS	3	\N	f	0.00	0	\N	TAX_EFFICIENCY	0.10
603	Geographic Analysis	+2% Map Efficiency	180	300	300	KNOWLEDGE	COMPASS	Compass	2	0	BONUS	3	\N	f	0.00	0	\N	MAP_EFFICIENCY	2.00
607	Cartography Mastery	+2% Map Efficiency	300	500	500	KNOWLEDGE	COMPASS	Compass	3	0	BONUS	5	\N	f	0.00	0	\N	MAP_EFFICIENCY	2.00
608	Survey Precision	+2% Map Efficiency	300	500	500	KNOWLEDGE	COMPASS	Compass	3	0	BONUS	5	\N	f	0.00	0	\N	MAP_EFFICIENCY	2.00
609	Geographic Modeling	+2% Map Efficiency	300	500	500	KNOWLEDGE	COMPASS	Compass	3	0	BONUS	5	\N	f	0.00	0	\N	MAP_EFFICIENCY	2.00
28	Masonry 3	\N	480	800	800	RESOURCE	MASONRY	Masonry	3	0	BONUS	8	\N	t	0.00	8	\N	\N	\N
29	Masonry 4	\N	600	1000	1000	RESOURCE	MASONRY	Masonry	4	0	BONUS	10	\N	t	0.00	10	\N	\N	\N
2	Surface Collection	+2% Quarry effectiveness	180	300	300	RESOURCE	MASONRY_STONE	Stone Production	1	0	BONUS	3	7	f	0.02	3	\N	QUARRY_EFFECTIVENESS	2.00
3	Stone Hammers	+2% Quarry effectiveness	180	300	300	RESOURCE	MASONRY_STONE	Stone Production	1	0	BONUS	3	7	f	0.02	3	\N	QUARRY_EFFECTIVENESS	2.00
4	Work Crews	+2% Quarry effectiveness	180	300	300	RESOURCE	MASONRY_STONE	Stone Production	1	0	BONUS	3	7	f	0.02	3	\N	QUARRY_EFFECTIVENESS	2.00
195	Stone Production 3	\N	420	700	700	RESOURCE	MASONRY_STONE	Stone Production	3	0	BONUS	7	\N	t	0.00	7	\N	QUARRY_EFFECTIVENESS	\N
196	Iron Chisels	\N	420	700	700	RESOURCE	MASONRY_STONE	Stone Production	3	0	BONUS	7	\N	f	0.02	7	\N	QUARRY_EFFECTIVENESS	2.00
197	Improved Blasting	\N	420	700	700	RESOURCE	MASONRY_STONE	Stone Production	3	0	BONUS	7	\N	f	0.02	7	\N	QUARRY_EFFECTIVENESS	2.00
198	Loading Equipment	\N	420	700	700	RESOURCE	MASONRY_STONE	Stone Production	3	0	BONUS	7	\N	f	0.02	7	\N	QUARRY_EFFECTIVENESS	2.00
203	Stone Production 4	\N	540	900	900	RESOURCE	MASONRY_STONE	Stone Production	4	0	BONUS	9	\N	t	0.00	9	\N	QUARRY_EFFECTIVENESS	\N
204	Geological Surveys	\N	540	900	900	RESOURCE	MASONRY_STONE	Stone Production	4	0	BONUS	9	\N	f	0.02	9	\N	QUARRY_EFFECTIVENESS	2.00
205	Vein Mapping	\N	540	900	900	RESOURCE	MASONRY_STONE	Stone Production	4	0	BONUS	9	\N	f	0.02	9	\N	QUARRY_EFFECTIVENESS	2.00
206	Structural Analysis	\N	540	900	900	RESOURCE	MASONRY_STONE	Stone Production	4	0	BONUS	9	\N	f	0.02	9	\N	QUARRY_EFFECTIVENESS	2.00
14	Sawmill Production 1	Unlocks bonus research to increase Sawmill effectiveness	120	200	200	RESOURCE	LUMBERING_SAWMILL	Lumbering (Sawmill)	1	0	BONUS	2	6	t	0.00	0	\N	SAWMILL_EFFECTIVENESS	\N
15	Sawmill Production 2	Unlocks bonus research to increase Sawmill effectiveness	240	400	400	RESOURCE	LUMBERING_SAWMILL	Lumbering (Sawmill)	3	0	BONUS	4	6	t	0.00	0	\N	SAWMILL_EFFECTIVENESS	\N
16	Sawmill Production 3	Unlocks bonus research to increase Sawmill effectiveness	360	600	600	RESOURCE	LUMBERING_SAWMILL	Lumbering (Sawmill)	5	0	BONUS	6	6	t	0.00	0	\N	SAWMILL_EFFECTIVENESS	\N
17	Sawmill Production 4	Unlocks bonus research to increase Sawmill effectiveness	480	800	800	RESOURCE	LUMBERING_SAWMILL	Lumbering (Sawmill)	7	0	BONUS	8	6	t	0.00	0	\N	SAWMILL_EFFECTIVENESS	\N
217	Stone Axes	+2% Sawmill effectiveness	120	200	200	RESOURCE	LUMBERING_SAWMILL	Lumbering (Sawmill)	1	0	BONUS	2	6	f	0.00	0	\N	SAWMILL_EFFECTIVENESS	2.00
218	Tree Selection	+2% Sawmill effectiveness	120	200	200	RESOURCE	LUMBERING_SAWMILL	Lumbering (Sawmill)	1	0	BONUS	2	6	f	0.00	0	\N	SAWMILL_EFFECTIVENESS	2.00
219	Logging Crews	+2% Sawmill effectiveness	120	200	200	RESOURCE	LUMBERING_SAWMILL	Lumbering (Sawmill)	1	0	BONUS	2	6	f	0.00	0	\N	SAWMILL_EFFECTIVENESS	2.00
220	Iron Axes	+2% Sawmill effectiveness	180	300	300	RESOURCE	LUMBERING_SAWMILL	Lumbering (Sawmill)	2	0	BONUS	3	6	f	0.00	0	\N	SAWMILL_EFFECTIVENESS	2.00
221	Forest Paths	+2% Sawmill effectiveness	180	300	300	RESOURCE	LUMBERING_SAWMILL	Lumbering (Sawmill)	2	0	BONUS	3	6	f	0.00	0	\N	SAWMILL_EFFECTIVENESS	2.00
222	Timber Transport	+2% Sawmill effectiveness	180	300	300	RESOURCE	LUMBERING_SAWMILL	Lumbering (Sawmill)	2	0	BONUS	3	6	f	0.00	0	\N	SAWMILL_EFFECTIVENESS	2.00
223	Saw Pits	+2% Sawmill effectiveness	240	400	400	RESOURCE	LUMBERING_SAWMILL	Lumbering (Sawmill)	3	0	BONUS	4	6	f	0.00	0	\N	SAWMILL_EFFECTIVENESS	2.00
224	Timber Sorting	+2% Sawmill effectiveness	240	400	400	RESOURCE	LUMBERING_SAWMILL	Lumbering (Sawmill)	3	0	BONUS	4	6	f	0.00	0	\N	SAWMILL_EFFECTIVENESS	2.00
225	Drying Racks	+2% Sawmill effectiveness	240	400	400	RESOURCE	LUMBERING_SAWMILL	Lumbering (Sawmill)	3	0	BONUS	4	6	f	0.00	0	\N	SAWMILL_EFFECTIVENESS	2.00
226	Water-Powered Saws	+2% Sawmill effectiveness	300	500	500	RESOURCE	LUMBERING_SAWMILL	Lumbering (Sawmill)	4	0	BONUS	5	6	f	0.00	0	\N	SAWMILL_EFFECTIVENESS	2.00
227	Forest Management	+2% Sawmill effectiveness	300	500	500	RESOURCE	LUMBERING_SAWMILL	Lumbering (Sawmill)	4	0	BONUS	5	6	f	0.00	0	\N	SAWMILL_EFFECTIVENESS	2.00
228	Logging Training	+2% Sawmill effectiveness	300	500	500	RESOURCE	LUMBERING_SAWMILL	Lumbering (Sawmill)	4	0	BONUS	5	6	f	0.00	0	\N	SAWMILL_EFFECTIVENESS	2.00
229	Crosscut Saws	+2% Sawmill effectiveness	360	600	600	RESOURCE	LUMBERING_SAWMILL	Lumbering (Sawmill)	5	0	BONUS	6	6	f	0.00	0	\N	SAWMILL_EFFECTIVENESS	2.00
230	Standard Lumber Sizes	+2% Sawmill effectiveness	360	600	600	RESOURCE	LUMBERING_SAWMILL	Lumbering (Sawmill)	5	0	BONUS	6	6	f	0.00	0	\N	SAWMILL_EFFECTIVENESS	2.00
231	Improved Transport	+2% Sawmill effectiveness	360	600	600	RESOURCE	LUMBERING_SAWMILL	Lumbering (Sawmill)	5	0	BONUS	6	6	f	0.00	0	\N	SAWMILL_EFFECTIVENESS	2.00
232	Hardwood Cultivation	+2% Sawmill effectiveness	420	700	700	RESOURCE	LUMBERING_SAWMILL	Lumbering (Sawmill)	6	0	BONUS	7	6	f	0.00	0	\N	SAWMILL_EFFECTIVENESS	2.00
233	Industrial Lumber Mills	+2% Sawmill effectiveness	420	700	700	RESOURCE	LUMBERING_SAWMILL	Lumbering (Sawmill)	6	0	BONUS	7	6	f	0.00	0	\N	SAWMILL_EFFECTIVENESS	2.00
234	Timber Contracts	+2% Sawmill effectiveness	420	700	700	RESOURCE	LUMBERING_SAWMILL	Lumbering (Sawmill)	6	0	BONUS	7	6	f	0.00	0	\N	SAWMILL_EFFECTIVENESS	2.00
235	Reforestation	+2% Sawmill effectiveness	480	800	800	RESOURCE	LUMBERING_SAWMILL	Lumbering (Sawmill)	7	0	BONUS	8	6	f	0.00	0	\N	SAWMILL_EFFECTIVENESS	2.00
236	Selective Harvesting	+2% Sawmill effectiveness	480	800	800	RESOURCE	LUMBERING_SAWMILL	Lumbering (Sawmill)	7	0	BONUS	8	6	f	0.00	0	\N	SAWMILL_EFFECTIVENESS	2.00
237	Tree Breeding	+2% Sawmill effectiveness	480	800	800	RESOURCE	LUMBERING_SAWMILL	Lumbering (Sawmill)	7	0	BONUS	8	6	f	0.00	0	\N	SAWMILL_EFFECTIVENESS	2.00
238	Steam-Powered Mills	+2% Sawmill effectiveness	540	900	900	RESOURCE	LUMBERING_SAWMILL	Lumbering (Sawmill)	8	0	BONUS	9	6	f	0.00	0	\N	SAWMILL_EFFECTIVENESS	2.00
239	Automated Cutting	+2% Sawmill effectiveness	540	900	900	RESOURCE	LUMBERING_SAWMILL	Lumbering (Sawmill)	8	0	BONUS	9	6	f	0.00	0	\N	SAWMILL_EFFECTIVENESS	2.00
240	Timber Processing	+2% Sawmill effectiveness	540	900	900	RESOURCE	LUMBERING_SAWMILL	Lumbering (Sawmill)	8	0	BONUS	9	6	f	0.00	0	\N	SAWMILL_EFFECTIVENESS	2.00
241	Precision Harvesting	+2% Sawmill effectiveness	600	1000	1000	RESOURCE	LUMBERING_SAWMILL	Lumbering (Sawmill)	9	0	BONUS	10	6	f	0.00	0	\N	SAWMILL_EFFECTIVENESS	2.00
242	Engineered Lumber	+2% Sawmill effectiveness	600	1000	1000	RESOURCE	LUMBERING_SAWMILL	Lumbering (Sawmill)	9	0	BONUS	10	6	f	0.00	0	\N	SAWMILL_EFFECTIVENESS	2.00
243	Sustainable Forestry	+2% Sawmill effectiveness	600	1000	1000	RESOURCE	LUMBERING_SAWMILL	Lumbering (Sawmill)	9	0	BONUS	10	6	f	0.00	0	\N	SAWMILL_EFFECTIVENESS	2.00
244	Smart Forestry	+2% Sawmill effectiveness	600	1000	1000	RESOURCE	LUMBERING_SAWMILL	Lumbering (Sawmill)	9	0	BONUS	10	6	f	0.00	0	\N	SAWMILL_EFFECTIVENESS	2.00
30	Ore Production 1	Unlocks bonus research to increase Iron Mine effectiveness	120	200	200	RESOURCE	MINING	Mining	1	0	BONUS	2	8	t	0.00	0	\N	IRON_MINE_EFFECTIVENESS	\N
31	Ore Production 2	Unlocks bonus research to increase Iron Mine effectiveness	240	400	400	RESOURCE	MINING	Mining	3	0	BONUS	4	8	t	0.00	0	\N	IRON_MINE_EFFECTIVENESS	\N
32	Ore Production 3	Unlocks bonus research to increase Iron Mine effectiveness	360	600	600	RESOURCE	MINING	Mining	5	0	BONUS	6	8	t	0.00	0	\N	IRON_MINE_EFFECTIVENESS	\N
33	Ore Production 4	Unlocks bonus research to increase Iron Mine effectiveness	480	800	800	RESOURCE	MINING	Mining	7	0	BONUS	8	8	t	0.00	0	\N	IRON_MINE_EFFECTIVENESS	\N
268	Ore Identification	+2% Iron Mine effectiveness	120	200	200	RESOURCE	MINING	Mining	1	0	BONUS	2	8	f	0.00	0	\N	IRON_MINE_EFFECTIVENESS	2.00
269	Stone Picks	+2% Iron Mine effectiveness	120	200	200	RESOURCE	MINING	Mining	1	0	BONUS	2	8	f	0.00	0	\N	IRON_MINE_EFFECTIVENESS	2.00
270	Collection Teams	+2% Iron Mine effectiveness	120	200	200	RESOURCE	MINING	Mining	1	0	BONUS	2	8	f	0.00	0	\N	IRON_MINE_EFFECTIVENESS	2.00
271	Mine Shafts	+2% Iron Mine effectiveness	180	300	300	RESOURCE	MINING	Mining	2	0	BONUS	3	8	f	0.00	0	\N	IRON_MINE_EFFECTIVENESS	2.00
272	Tunnel Supports	+2% Iron Mine effectiveness	180	300	300	RESOURCE	MINING	Mining	2	0	BONUS	3	8	f	0.00	0	\N	IRON_MINE_EFFECTIVENESS	2.00
273	Ore Transport	+2% Iron Mine effectiveness	180	300	300	RESOURCE	MINING	Mining	2	0	BONUS	3	8	f	0.00	0	\N	IRON_MINE_EFFECTIVENESS	2.00
274	Charcoal Production	+2% Iron Mine effectiveness	240	400	400	RESOURCE	MINING	Mining	3	0	BONUS	4	8	f	0.00	0	\N	IRON_MINE_EFFECTIVENESS	2.00
275	Primitive Furnaces	+2% Iron Mine effectiveness	240	400	400	RESOURCE	MINING	Mining	3	0	BONUS	4	8	f	0.00	0	\N	IRON_MINE_EFFECTIVENESS	2.00
276	Metal Refinement	+2% Iron Mine effectiveness	240	400	400	RESOURCE	MINING	Mining	3	0	BONUS	4	8	f	0.00	0	\N	IRON_MINE_EFFECTIVENESS	2.00
277	Deep Mining	+2% Iron Mine effectiveness	300	500	500	RESOURCE	MINING	Mining	4	0	BONUS	5	8	f	0.00	0	\N	IRON_MINE_EFFECTIVENESS	2.00
278	Drainage Systems	+2% Iron Mine effectiveness	300	500	500	RESOURCE	MINING	Mining	4	0	BONUS	5	8	f	0.00	0	\N	IRON_MINE_EFFECTIVENESS	2.00
279	Mining Management	+2% Iron Mine effectiveness	300	500	500	RESOURCE	MINING	Mining	4	0	BONUS	5	8	f	0.00	0	\N	IRON_MINE_EFFECTIVENESS	2.00
280	Steel Tools	+2% Iron Mine effectiveness	360	600	600	RESOURCE	MINING	Mining	5	0	BONUS	6	8	f	0.00	0	\N	IRON_MINE_EFFECTIVENESS	2.00
281	Reinforced Tunnels	+2% Iron Mine effectiveness	360	600	600	RESOURCE	MINING	Mining	5	0	BONUS	6	8	f	0.00	0	\N	IRON_MINE_EFFECTIVENESS	2.00
282	Ore Sorting	+2% Iron Mine effectiveness	360	600	600	RESOURCE	MINING	Mining	5	0	BONUS	6	8	f	0.00	0	\N	IRON_MINE_EFFECTIVENESS	2.00
283	Mining Machinery	+2% Iron Mine effectiveness	420	700	700	RESOURCE	MINING	Mining	6	0	BONUS	7	8	f	0.00	0	\N	IRON_MINE_EFFECTIVENESS	2.00
284	Blast Furnaces	+2% Iron Mine effectiveness	420	700	700	RESOURCE	MINING	Mining	6	0	BONUS	7	8	f	0.00	0	\N	IRON_MINE_EFFECTIVENESS	2.00
285	Metal Trade	+2% Iron Mine effectiveness	420	700	700	RESOURCE	MINING	Mining	6	0	BONUS	7	8	f	0.00	0	\N	IRON_MINE_EFFECTIVENESS	2.00
286	Alloy Research	+2% Iron Mine effectiveness	480	800	800	RESOURCE	MINING	Mining	7	0	BONUS	8	8	f	0.00	0	\N	IRON_MINE_EFFECTIVENESS	2.00
287	Steel Production	+2% Iron Mine effectiveness	480	800	800	RESOURCE	MINING	Mining	7	0	BONUS	8	8	f	0.00	0	\N	IRON_MINE_EFFECTIVENESS	2.00
288	Material Testing	+2% Iron Mine effectiveness	480	800	800	RESOURCE	MINING	Mining	7	0	BONUS	8	8	f	0.00	0	\N	IRON_MINE_EFFECTIVENESS	2.00
289	Automated Ore Extraction	+2% Iron Mine effectiveness	540	900	900	RESOURCE	MINING	Mining	8	0	BONUS	9	8	f	0.00	0	\N	IRON_MINE_EFFECTIVENESS	2.00
290	Large Foundries	+2% Iron Mine effectiveness	540	900	900	RESOURCE	MINING	Mining	8	0	BONUS	9	8	f	0.00	0	\N	IRON_MINE_EFFECTIVENESS	2.00
291	Mass Production	+2% Iron Mine effectiveness	540	900	900	RESOURCE	MINING	Mining	8	0	BONUS	9	8	f	0.00	0	\N	IRON_MINE_EFFECTIVENESS	2.00
292	High Strength Steel	+2% Iron Mine effectiveness	600	1000	1000	RESOURCE	MINING	Mining	9	0	BONUS	10	8	f	0.00	0	\N	IRON_MINE_EFFECTIVENESS	2.00
293	Precision Casting	+2% Iron Mine effectiveness	600	1000	1000	RESOURCE	MINING	Mining	9	0	BONUS	10	8	f	0.00	0	\N	IRON_MINE_EFFECTIVENESS	2.00
294	Rare Metal Recovery	+2% Iron Mine effectiveness	600	1000	1000	RESOURCE	MINING	Mining	9	0	BONUS	10	8	f	0.00	0	\N	IRON_MINE_EFFECTIVENESS	2.00
295	Smart Mining	+2% Iron Mine effectiveness	600	1000	1000	RESOURCE	MINING	Mining	9	0	BONUS	10	8	f	0.00	0	\N	IRON_MINE_EFFECTIVENESS	2.00
296	Settlement Growth	+2% Population effectiveness	60	100	100	RESOURCE	HAPPINESS	Happiness	1	0	BONUS	1	\N	f	0.00	0	\N	POPULATION_EFFECTIVENESS	2.00
297	Family Housing	+2% Population effectiveness	60	100	100	RESOURCE	HAPPINESS	Happiness	1	0	BONUS	1	\N	f	0.00	0	\N	POPULATION_EFFECTIVENESS	2.00
298	Food Security	+2% Population effectiveness	60	100	100	RESOURCE	HAPPINESS	Happiness	1	0	BONUS	1	\N	f	0.00	0	\N	POPULATION_EFFECTIVENESS	2.00
299	Community Support	+2% Population effectiveness	120	200	200	RESOURCE	HAPPINESS	Happiness	2	0	BONUS	2	\N	f	0.00	0	\N	POPULATION_EFFECTIVENESS	2.00
300	Population Records	+2% Population effectiveness	120	200	200	RESOURCE	HAPPINESS	Happiness	2	0	BONUS	2	\N	f	0.00	0	\N	POPULATION_EFFECTIVENESS	2.00
301	Child Development	+2% Population effectiveness	120	200	200	RESOURCE	HAPPINESS	Happiness	2	0	BONUS	2	\N	f	0.00	0	\N	POPULATION_EFFECTIVENESS	2.00
302	Residential Districts	+2% Population effectiveness	180	300	300	RESOURCE	HAPPINESS	Happiness	3	0	BONUS	3	\N	f	0.00	0	\N	POPULATION_EFFECTIVENESS	2.00
303	Immigration Policy	+2% Population effectiveness	180	300	300	RESOURCE	HAPPINESS	Happiness	3	0	BONUS	3	\N	f	0.00	0	\N	POPULATION_EFFECTIVENESS	2.00
304	Population Surveys	+2% Population effectiveness	180	300	300	RESOURCE	HAPPINESS	Happiness	3	0	BONUS	3	\N	f	0.00	0	\N	POPULATION_EFFECTIVENESS	2.00
305	Urban Expansion	+2% Population effectiveness	240	400	400	RESOURCE	HAPPINESS	Happiness	4	0	BONUS	4	\N	f	0.00	0	\N	POPULATION_EFFECTIVENESS	2.00
306	Labor Availability	+2% Population effectiveness	240	400	400	RESOURCE	HAPPINESS	Happiness	4	0	BONUS	4	\N	f	0.00	0	\N	POPULATION_EFFECTIVENESS	2.00
307	Population Management	+2% Population effectiveness	240	400	400	RESOURCE	HAPPINESS	Happiness	4	0	BONUS	4	\N	f	0.00	0	\N	POPULATION_EFFECTIVENESS	2.00
308	Regional Growth	+2% Population effectiveness	300	500	500	RESOURCE	HAPPINESS	Happiness	5	0	BONUS	5	\N	f	0.00	0	\N	POPULATION_EFFECTIVENESS	2.00
309	Settlement Programs	+2% Population effectiveness	300	500	500	RESOURCE	HAPPINESS	Happiness	5	0	BONUS	5	\N	f	0.00	0	\N	POPULATION_EFFECTIVENESS	2.00
310	Workforce Expansion	+2% Population effectiveness	300	500	500	RESOURCE	HAPPINESS	Happiness	5	0	BONUS	5	\N	f	0.00	0	\N	POPULATION_EFFECTIVENESS	2.00
311	National Census	+2% Population effectiveness	360	600	600	RESOURCE	HAPPINESS	Happiness	6	0	BONUS	6	\N	f	0.00	0	\N	POPULATION_EFFECTIVENESS	2.00
312	Population Forecasting	+2% Population effectiveness	360	600	600	RESOURCE	HAPPINESS	Happiness	6	0	BONUS	6	\N	f	0.00	0	\N	POPULATION_EFFECTIVENESS	2.00
313	Skilled Migration	+2% Population effectiveness	360	600	600	RESOURCE	HAPPINESS	Happiness	6	0	BONUS	6	\N	f	0.00	0	\N	POPULATION_EFFECTIVENESS	2.00
314	Metropolitan Development	+2% Population effectiveness	420	700	700	RESOURCE	HAPPINESS	Happiness	7	0	BONUS	7	\N	f	0.00	0	\N	POPULATION_EFFECTIVENESS	2.00
315	Population Distribution	+2% Population effectiveness	420	700	700	RESOURCE	HAPPINESS	Happiness	7	0	BONUS	7	\N	f	0.00	0	\N	POPULATION_EFFECTIVENESS	2.00
316	Urban Integration	+2% Population effectiveness	420	700	700	RESOURCE	HAPPINESS	Happiness	7	0	BONUS	7	\N	f	0.00	0	\N	POPULATION_EFFECTIVENESS	2.00
317	National Expansion	+2% Population effectiveness	480	800	800	RESOURCE	HAPPINESS	Happiness	8	0	BONUS	8	\N	f	0.00	0	\N	POPULATION_EFFECTIVENESS	2.00
318	Demographic Analysis	+2% Population effectiveness	480	800	800	RESOURCE	HAPPINESS	Happiness	8	0	BONUS	8	\N	f	0.00	0	\N	POPULATION_EFFECTIVENESS	2.00
319	Population Networks	+2% Population effectiveness	480	800	800	RESOURCE	HAPPINESS	Happiness	8	0	BONUS	8	\N	f	0.00	0	\N	POPULATION_EFFECTIVENESS	2.00
320	Strategic Settlement	+2% Population effectiveness	540	900	900	RESOURCE	HAPPINESS	Happiness	9	0	BONUS	9	\N	f	0.00	0	\N	POPULATION_EFFECTIVENESS	2.00
321	Population Coordination	+2% Population effectiveness	540	900	900	RESOURCE	HAPPINESS	Happiness	9	0	BONUS	9	\N	f	0.00	0	\N	POPULATION_EFFECTIVENESS	2.00
322	National Workforce	+2% Population effectiveness	540	900	900	RESOURCE	HAPPINESS	Happiness	9	0	BONUS	9	\N	f	0.00	0	\N	POPULATION_EFFECTIVENESS	2.00
323	Population Supremacy	+2% Population effectiveness	600	1000	1000	RESOURCE	HAPPINESS	Happiness	10	0	BONUS	10	\N	f	0.00	0	\N	POPULATION_EFFECTIVENESS	2.00
324	Thriving Cities	+2% Population effectiveness	600	1000	1000	RESOURCE	HAPPINESS	Happiness	10	0	BONUS	10	\N	f	0.00	0	\N	POPULATION_EFFECTIVENESS	2.00
325	Workforce Excellence	+2% Population effectiveness	600	1000	1000	RESOURCE	HAPPINESS	Happiness	10	0	BONUS	10	\N	f	0.00	0	\N	POPULATION_EFFECTIVENESS	2.00
128	Population Control 1	Unlocks bonus research to increase Population effectiveness	60	100	100	DEVELOPMENT	HAPPINESS	Happiness	1	0	BONUS	1	\N	t	0.00	0	5.00	POPULATION_EFFECTIVENESS	5.00
129	Population Control 2	Unlocks bonus research to increase Population effectiveness	120	200	200	DEVELOPMENT	HAPPINESS	Happiness	2	0	BONUS	2	\N	t	0.00	0	10.00	POPULATION_EFFECTIVENESS	10.00
130	Population Control 3	Unlocks bonus research to increase Population effectiveness	180	300	300	DEVELOPMENT	HAPPINESS	Happiness	3	0	BONUS	3	\N	t	0.00	0	15.00	POPULATION_EFFECTIVENESS	15.00
131	Population Control 4	Unlocks bonus research to increase Population effectiveness	240	400	400	DEVELOPMENT	HAPPINESS	Happiness	4	0	BONUS	4	\N	t	0.00	0	20.00	POPULATION_EFFECTIVENESS	20.00
132	Population Control 5	Unlocks bonus research to increase Population effectiveness	300	500	500	DEVELOPMENT	HAPPINESS	Happiness	5	0	BONUS	5	\N	t	0.00	0	25.00	POPULATION_EFFECTIVENESS	25.00
133	Population Control 6	Unlocks bonus research to increase Population effectiveness	360	600	600	DEVELOPMENT	HAPPINESS	Happiness	6	0	BONUS	6	\N	t	0.00	0	30.00	POPULATION_EFFECTIVENESS	30.00
134	Population Control 7	Unlocks bonus research to increase Population effectiveness	420	700	700	DEVELOPMENT	HAPPINESS	Happiness	7	0	BONUS	7	\N	t	0.00	0	35.00	POPULATION_EFFECTIVENESS	35.00
135	Population Control 8	Unlocks bonus research to increase Population effectiveness	480	800	800	DEVELOPMENT	HAPPINESS	Happiness	8	0	BONUS	8	\N	t	0.00	0	40.00	POPULATION_EFFECTIVENESS	40.00
136	Population Control 9	Unlocks bonus research to increase Population effectiveness	540	900	900	DEVELOPMENT	HAPPINESS	Happiness	9	0	BONUS	9	\N	t	0.00	0	45.00	POPULATION_EFFECTIVENESS	45.00
137	Population Control 10	Unlocks bonus research to increase Population effectiveness	600	1000	1000	DEVELOPMENT	HAPPINESS	Happiness	10	0	BONUS	10	\N	t	0.00	0	50.00	POPULATION_EFFECTIVENESS	50.00
10	Farm Production 1	Unlocks bonus research to increase Farm effectiveness	60	100	100	RESOURCE	AGRICULTURE	Agriculture	1	0	BONUS	1	\N	t	0.00	0	\N	FARM_EFFECTIVENESS	\N
11	Farm Production 2	Unlocks bonus research to increase Farm effectiveness	120	200	200	RESOURCE	AGRICULTURE	Agriculture	2	0	BONUS	2	\N	t	0.00	0	\N	FARM_EFFECTIVENESS	\N
12	Farm Production 3	Unlocks bonus research to increase Farm effectiveness	180	300	300	RESOURCE	AGRICULTURE	Agriculture	3	0	BONUS	3	\N	t	0.00	0	\N	FARM_EFFECTIVENESS	\N
13	Farm Production 4	Unlocks bonus research to increase Farm effectiveness	240	400	400	RESOURCE	AGRICULTURE	Agriculture	4	0	BONUS	4	\N	t	0.00	0	\N	FARM_EFFECTIVENESS	\N
326	Farm Production 5	Unlocks bonus research to increase Farm effectiveness	300	500	500	RESOURCE	AGRICULTURE	Agriculture	5	0	BONUS	5	\N	t	0.00	0	\N	FARM_EFFECTIVENESS	\N
327	Farm Production 6	Unlocks bonus research to increase Farm effectiveness	360	600	600	RESOURCE	AGRICULTURE	Agriculture	6	0	BONUS	6	\N	t	0.00	0	\N	FARM_EFFECTIVENESS	\N
328	Farm Production 7	Unlocks bonus research to increase Farm effectiveness	420	700	700	RESOURCE	AGRICULTURE	Agriculture	7	0	BONUS	7	\N	t	0.00	0	\N	FARM_EFFECTIVENESS	\N
329	Farm Production 8	Unlocks bonus research to increase Farm effectiveness	480	800	800	RESOURCE	AGRICULTURE	Agriculture	8	0	BONUS	8	\N	t	0.00	0	\N	FARM_EFFECTIVENESS	\N
330	Farm Production 9	Unlocks bonus research to increase Farm effectiveness	540	900	900	RESOURCE	AGRICULTURE	Agriculture	9	0	BONUS	9	\N	t	0.00	0	\N	FARM_EFFECTIVENESS	\N
331	Farm Production 10	Unlocks bonus research to increase Farm effectiveness	600	1000	1000	RESOURCE	AGRICULTURE	Agriculture	10	0	BONUS	10	\N	t	0.00	0	\N	FARM_EFFECTIVENESS	\N
332	Clear Fields	+2% Farm effectiveness	60	100	100	RESOURCE	AGRICULTURE	Agriculture	1	0	BONUS	1	\N	f	0.00	0	\N	FARM_EFFECTIVENESS	2.00
333	Hand Tools	+2% Farm effectiveness	60	100	100	RESOURCE	AGRICULTURE	Agriculture	1	0	BONUS	1	\N	f	0.00	0	\N	FARM_EFFECTIVENESS	2.00
334	Seed Selection	+2% Farm effectiveness	60	100	100	RESOURCE	AGRICULTURE	Agriculture	1	0	BONUS	1	\N	f	0.00	0	\N	FARM_EFFECTIVENESS	2.00
335	Irrigation Ditches	+2% Farm effectiveness	120	200	200	RESOURCE	AGRICULTURE	Agriculture	2	0	BONUS	2	\N	f	0.00	0	\N	FARM_EFFECTIVENESS	2.00
336	Field Rotation	+2% Farm effectiveness	120	200	200	RESOURCE	AGRICULTURE	Agriculture	2	0	BONUS	2	\N	f	0.00	0	\N	FARM_EFFECTIVENESS	2.00
337	Soil Preparation	+2% Farm effectiveness	120	200	200	RESOURCE	AGRICULTURE	Agriculture	2	0	BONUS	2	\N	f	0.00	0	\N	FARM_EFFECTIVENESS	2.00
338	Fertilization	+2% Farm effectiveness	180	300	300	RESOURCE	AGRICULTURE	Agriculture	3	0	BONUS	3	\N	f	0.00	0	\N	FARM_EFFECTIVENESS	2.00
339	Animal Plowing	+2% Farm effectiveness	180	300	300	RESOURCE	AGRICULTURE	Agriculture	3	0	BONUS	3	\N	f	0.00	0	\N	FARM_EFFECTIVENESS	2.00
340	Crop Storage	+2% Farm effectiveness	180	300	300	RESOURCE	AGRICULTURE	Agriculture	3	0	BONUS	3	\N	f	0.00	0	\N	FARM_EFFECTIVENESS	2.00
341	Improved Irrigation	+2% Farm effectiveness	240	400	400	RESOURCE	AGRICULTURE	Agriculture	4	0	BONUS	4	\N	f	0.00	0	\N	FARM_EFFECTIVENESS	2.00
342	Agricultural Training	+2% Farm effectiveness	240	400	400	RESOURCE	AGRICULTURE	Agriculture	4	0	BONUS	4	\N	f	0.00	0	\N	FARM_EFFECTIVENESS	2.00
343	Weather Observation	+2% Farm effectiveness	240	400	400	RESOURCE	AGRICULTURE	Agriculture	4	0	BONUS	4	\N	f	0.00	0	\N	FARM_EFFECTIVENESS	2.00
344	Iron Farming Tools	+2% Farm effectiveness	300	500	500	RESOURCE	AGRICULTURE	Agriculture	5	0	BONUS	5	\N	f	0.00	0	\N	FARM_EFFECTIVENESS	2.00
345	Advanced Crop Rotation	+2% Farm effectiveness	300	500	500	RESOURCE	AGRICULTURE	Agriculture	5	0	BONUS	5	\N	f	0.00	0	\N	FARM_EFFECTIVENESS	2.00
346	Granary Construction	+2% Farm effectiveness	300	500	500	RESOURCE	AGRICULTURE	Agriculture	5	0	BONUS	5	\N	f	0.00	0	\N	FARM_EFFECTIVENESS	2.00
347	Specialized Crops	+2% Farm effectiveness	360	600	600	RESOURCE	AGRICULTURE	Agriculture	6	0	BONUS	6	\N	f	0.00	0	\N	FARM_EFFECTIVENESS	2.00
348	Seed Preservation	+2% Farm effectiveness	360	600	600	RESOURCE	AGRICULTURE	Agriculture	6	0	BONUS	6	\N	f	0.00	0	\N	FARM_EFFECTIVENESS	2.00
349	Distribution Networks	+2% Farm effectiveness	360	600	600	RESOURCE	AGRICULTURE	Agriculture	6	0	BONUS	6	\N	f	0.00	0	\N	FARM_EFFECTIVENESS	2.00
350	Soil Analysis	+2% Farm effectiveness	420	700	700	RESOURCE	AGRICULTURE	Agriculture	7	0	BONUS	7	\N	f	0.00	0	\N	FARM_EFFECTIVENESS	2.00
351	Crop Breeding	+2% Farm effectiveness	420	700	700	RESOURCE	AGRICULTURE	Agriculture	7	0	BONUS	7	\N	f	0.00	0	\N	FARM_EFFECTIVENESS	2.00
352	Water Management	+2% Farm effectiveness	420	700	700	RESOURCE	AGRICULTURE	Agriculture	7	0	BONUS	7	\N	f	0.00	0	\N	FARM_EFFECTIVENESS	2.00
353	Mechanical Harvesting	+2% Farm effectiveness	480	800	800	RESOURCE	AGRICULTURE	Agriculture	8	0	BONUS	8	\N	f	0.00	0	\N	FARM_EFFECTIVENESS	2.00
354	Fertilizer Production	+2% Farm effectiveness	480	800	800	RESOURCE	AGRICULTURE	Agriculture	8	0	BONUS	8	\N	f	0.00	0	\N	FARM_EFFECTIVENESS	2.00
355	Greenhouse Cultivation	+2% Farm effectiveness	480	800	800	RESOURCE	AGRICULTURE	Agriculture	8	0	BONUS	8	\N	f	0.00	0	\N	FARM_EFFECTIVENESS	2.00
356	Precision Farming	+2% Farm effectiveness	540	900	900	RESOURCE	AGRICULTURE	Agriculture	9	0	BONUS	9	\N	f	0.00	0	\N	FARM_EFFECTIVENESS	2.00
357	Climate Adaptation	+2% Farm effectiveness	540	900	900	RESOURCE	AGRICULTURE	Agriculture	9	0	BONUS	9	\N	f	0.00	0	\N	FARM_EFFECTIVENESS	2.00
358	High Yield Crops	+2% Farm effectiveness	540	900	900	RESOURCE	AGRICULTURE	Agriculture	9	0	BONUS	9	\N	f	0.00	0	\N	FARM_EFFECTIVENESS	2.00
359	Automated Farms	+2% Farm effectiveness	600	1000	1000	RESOURCE	AGRICULTURE	Agriculture	10	0	BONUS	10	\N	f	0.00	0	\N	FARM_EFFECTIVENESS	2.00
360	Genetic Cultivation	+2% Farm effectiveness	600	1000	1000	RESOURCE	AGRICULTURE	Agriculture	10	0	BONUS	10	\N	f	0.00	0	\N	FARM_EFFECTIVENESS	2.00
361	Sustainable Ecosystems	+2% Farm effectiveness	600	1000	1000	RESOURCE	AGRICULTURE	Agriculture	10	0	BONUS	10	\N	f	0.00	0	\N	FARM_EFFECTIVENESS	2.00
384	Basic Foundations	+2% Construction Speed	60	100	100	DEVELOPMENT	CONSTRUCTION	Construction	1	0	BONUS	1	\N	f	0.00	0	\N	CONSTRUCTION_SPEED	2.00
385	Construction Tools	+2% Construction Speed	60	100	100	DEVELOPMENT	CONSTRUCTION	Construction	1	0	BONUS	1	\N	f	0.00	0	\N	CONSTRUCTION_SPEED	2.00
386	Worksite Safety	+2% Construction Speed	60	100	100	DEVELOPMENT	CONSTRUCTION	Construction	1	0	BONUS	1	\N	f	0.00	0	\N	CONSTRUCTION_SPEED	2.00
387	Structural Supports	+2% Construction Speed	120	200	200	DEVELOPMENT	CONSTRUCTION	Construction	2	0	BONUS	2	\N	f	0.00	0	\N	CONSTRUCTION_SPEED	2.00
388	Road Construction	+2% Construction Speed	120	200	200	DEVELOPMENT	CONSTRUCTION	Construction	2	0	BONUS	2	\N	f	0.00	0	\N	CONSTRUCTION_SPEED	2.00
389	Municipal Drainage Systems	+2% Construction Speed	120	200	200	DEVELOPMENT	CONSTRUCTION	Construction	2	0	BONUS	2	\N	f	0.00	0	\N	CONSTRUCTION_SPEED	2.00
390	Masonry Techniques	+2% Construction Speed	180	300	300	DEVELOPMENT	CONSTRUCTION	Construction	3	0	BONUS	3	\N	f	0.00	0	\N	CONSTRUCTION_SPEED	2.00
391	Timber Framing	+2% Construction Speed	180	300	300	DEVELOPMENT	CONSTRUCTION	Construction	3	0	BONUS	3	\N	f	0.00	0	\N	CONSTRUCTION_SPEED	2.00
392	Site Surveys	+2% Construction Speed	180	300	300	DEVELOPMENT	CONSTRUCTION	Construction	3	0	BONUS	3	\N	f	0.00	0	\N	CONSTRUCTION_SPEED	2.00
393	Bridge Building	+2% Construction Speed	240	400	400	DEVELOPMENT	CONSTRUCTION	Construction	4	0	BONUS	4	\N	f	0.00	0	\N	CONSTRUCTION_SPEED	2.00
394	Public Works	+2% Construction Speed	240	400	400	DEVELOPMENT	CONSTRUCTION	Construction	4	0	BONUS	4	\N	f	0.00	0	\N	CONSTRUCTION_SPEED	2.00
395	Infrastructure Design	+2% Construction Speed	240	400	400	DEVELOPMENT	CONSTRUCTION	Construction	4	0	BONUS	4	\N	f	0.00	0	\N	CONSTRUCTION_SPEED	2.00
396	Reinforced Structures	+2% Construction Speed	300	500	500	DEVELOPMENT	CONSTRUCTION	Construction	5	0	BONUS	5	\N	f	0.00	0	\N	CONSTRUCTION_SPEED	2.00
397	Advanced Masonry	+2% Construction Speed	300	500	500	DEVELOPMENT	CONSTRUCTION	Construction	5	0	BONUS	5	\N	f	0.00	0	\N	CONSTRUCTION_SPEED	2.00
398	Engineering Corps	+2% Construction Speed	300	500	500	DEVELOPMENT	CONSTRUCTION	Construction	5	0	BONUS	5	\N	f	0.00	0	\N	CONSTRUCTION_SPEED	2.00
399	Large Projects	+2% Construction Speed	360	600	600	DEVELOPMENT	CONSTRUCTION	Construction	6	0	BONUS	6	\N	f	0.00	0	\N	CONSTRUCTION_SPEED	2.00
400	Aqueduct Systems	+2% Construction Speed	360	600	600	DEVELOPMENT	CONSTRUCTION	Construction	6	0	BONUS	6	\N	f	0.00	0	\N	CONSTRUCTION_SPEED	2.00
401	Complex Structures	+2% Construction Speed	360	600	600	DEVELOPMENT	CONSTRUCTION	Construction	6	0	BONUS	6	\N	f	0.00	0	\N	CONSTRUCTION_SPEED	2.00
402	Industrial Construction	+2% Construction Speed	420	700	700	DEVELOPMENT	CONSTRUCTION	Construction	7	0	BONUS	7	\N	f	0.00	0	\N	CONSTRUCTION_SPEED	2.00
403	Heavy Equipment	+2% Construction Speed	420	700	700	DEVELOPMENT	CONSTRUCTION	Construction	7	0	BONUS	7	\N	f	0.00	0	\N	CONSTRUCTION_SPEED	2.00
404	Infrastructure Networks	+2% Construction Speed	420	700	700	DEVELOPMENT	CONSTRUCTION	Construction	7	0	BONUS	7	\N	f	0.00	0	\N	CONSTRUCTION_SPEED	2.00
405	Urban Engineering	+2% Construction Speed	480	800	800	DEVELOPMENT	CONSTRUCTION	Construction	8	0	BONUS	8	\N	f	0.00	0	\N	CONSTRUCTION_SPEED	2.00
406	Mega Projects	+2% Construction Speed	480	800	800	DEVELOPMENT	CONSTRUCTION	Construction	8	0	BONUS	8	\N	f	0.00	0	\N	CONSTRUCTION_SPEED	2.00
407	Advanced Materials	+2% Construction Speed	480	800	800	DEVELOPMENT	CONSTRUCTION	Construction	8	0	BONUS	8	\N	f	0.00	0	\N	CONSTRUCTION_SPEED	2.00
408	National Infrastructure	+2% Construction Speed	540	900	900	DEVELOPMENT	CONSTRUCTION	Construction	9	0	BONUS	9	\N	f	0.00	0	\N	CONSTRUCTION_SPEED	2.00
409	Landmark Construction	+2% Construction Speed	540	900	900	DEVELOPMENT	CONSTRUCTION	Construction	9	0	BONUS	9	\N	f	0.00	0	\N	CONSTRUCTION_SPEED	2.00
410	Engineering Innovation	+2% Construction Speed	540	900	900	DEVELOPMENT	CONSTRUCTION	Construction	9	0	BONUS	9	\N	f	0.00	0	\N	CONSTRUCTION_SPEED	2.00
411	Master Builders	+2% Construction Speed	600	1000	1000	DEVELOPMENT	CONSTRUCTION	Construction	10	0	BONUS	10	\N	f	0.00	0	\N	CONSTRUCTION_SPEED	2.00
412	Structural Mastery	+2% Construction Speed	600	1000	1000	DEVELOPMENT	CONSTRUCTION	Construction	10	0	BONUS	10	\N	f	0.00	0	\N	CONSTRUCTION_SPEED	2.00
413	Infrastructure Supremacy	+2% Construction Speed	600	1000	1000	DEVELOPMENT	CONSTRUCTION	Construction	10	0	BONUS	10	\N	f	0.00	0	\N	CONSTRUCTION_SPEED	2.00
100	Construction Planning	Unlocks bonus research to increase Construction effectiveness	180	300	300	DEVELOPMENT	CONSTRUCTION	Construction	3	0	BONUS	3	\N	t	0.00	0	30.00	CONSTRUCTION_SPEED	30.00
101	Urban Development	Unlocks bonus research to increase Construction effectiveness	240	400	400	DEVELOPMENT	CONSTRUCTION	Construction	4	0	BONUS	4	\N	t	0.00	0	35.00	CONSTRUCTION_SPEED	35.00
102	Construction Efficiency	Unlocks bonus research to increase Construction effectiveness	300	500	500	DEVELOPMENT	CONSTRUCTION	Construction	5	0	BONUS	5	\N	t	0.00	0	40.00	CONSTRUCTION_SPEED	40.00
103	Technical Drawings	Unlocks bonus research to increase Construction effectiveness	360	600	600	DEVELOPMENT	CONSTRUCTION	Construction	6	0	BONUS	6	\N	t	0.00	0	45.00	CONSTRUCTION_SPEED	45.00
104	Structural Integrity Analysis	Unlocks bonus research to increase Construction effectiveness	420	700	700	DEVELOPMENT	CONSTRUCTION	Construction	7	0	BONUS	7	\N	t	0.00	0	50.00	CONSTRUCTION_SPEED	50.00
105	Construction Automation	Unlocks bonus research to increase Construction effectiveness	480	800	800	DEVELOPMENT	CONSTRUCTION	Construction	8	0	BONUS	8	\N	t	0.00	0	55.00	CONSTRUCTION_SPEED	55.00
106	Project Mastery	Unlocks bonus research to increase Construction effectiveness	540	900	900	DEVELOPMENT	CONSTRUCTION	Construction	9	0	BONUS	9	\N	t	0.00	0	60.00	CONSTRUCTION_SPEED	60.00
107	Engineering Supremacy	Unlocks bonus research to increase Construction effectiveness	600	1000	1000	DEVELOPMENT	CONSTRUCTION	Construction	10	0	BONUS	10	\N	t	0.00	0	65.00	CONSTRUCTION_SPEED	65.00
415	Foundational Craftwork	+2% Craftsmanship Speed	60	100	100	DEVELOPMENT	CRAFTSMANSHIP	Craftsmanship	1	0	BONUS	1	\N	f	0.00	0	\N	CRAFTSMANSHIP_SPEED	2.00
416	Tools & Implements	+2% Craftsmanship Speed	60	100	100	DEVELOPMENT	CRAFTSMANSHIP	Craftsmanship	1	0	BONUS	1	\N	f	0.00	0	\N	CRAFTSMANSHIP_SPEED	2.00
417	Basic Labor Practices	+2% Craftsmanship Speed	60	100	100	DEVELOPMENT	CRAFTSMANSHIP	Craftsmanship	1	0	BONUS	1	\N	f	0.00	0	\N	CRAFTSMANSHIP_SPEED	2.00
418	Apprentice Instruction	+2% Craftsmanship Speed	120	200	200	DEVELOPMENT	CRAFTSMANSHIP	Craftsmanship	2	0	BONUS	2	\N	f	0.00	0	\N	CRAFTSMANSHIP_SPEED	2.00
419	Trade Familiarization	+2% Craftsmanship Speed	120	200	200	DEVELOPMENT	CRAFTSMANSHIP	Craftsmanship	2	0	BONUS	2	\N	f	0.00	0	\N	CRAFTSMANSHIP_SPEED	2.00
420	Workshop Rotation	+2% Craftsmanship Speed	120	200	200	DEVELOPMENT	CRAFTSMANSHIP	Craftsmanship	2	0	BONUS	2	\N	f	0.00	0	\N	CRAFTSMANSHIP_SPEED	2.00
421	Craft Records & Ledgers	+2% Craftsmanship Speed	180	300	300	DEVELOPMENT	CRAFTSMANSHIP	Craftsmanship	3	0	BONUS	3	\N	f	0.00	0	\N	CRAFTSMANSHIP_SPEED	2.00
422	Trade Branching	+2% Craftsmanship Speed	180	300	300	DEVELOPMENT	CRAFTSMANSHIP	Craftsmanship	3	0	BONUS	3	\N	f	0.00	0	\N	CRAFTSMANSHIP_SPEED	2.00
423	Journeyman Advancement	+2% Craftsmanship Speed	180	300	300	DEVELOPMENT	CRAFTSMANSHIP	Craftsmanship	3	0	BONUS	3	\N	f	0.00	0	\N	CRAFTSMANSHIP_SPEED	2.00
424	Skilled Labor Techniques	+2% Craftsmanship Speed	240	400	400	DEVELOPMENT	CRAFTSMANSHIP	Craftsmanship	4	0	BONUS	4	\N	f	0.00	0	\N	CRAFTSMANSHIP_SPEED	2.00
425	Guild Recognition	+2% Craftsmanship Speed	240	400	400	DEVELOPMENT	CRAFTSMANSHIP	Craftsmanship	4	0	BONUS	4	\N	f	0.00	0	\N	CRAFTSMANSHIP_SPEED	2.00
426	Worksite Oversight	+2% Craftsmanship Speed	240	400	400	DEVELOPMENT	CRAFTSMANSHIP	Craftsmanship	4	0	BONUS	4	\N	f	0.00	0	\N	CRAFTSMANSHIP_SPEED	2.00
427	Expert Craft Methods	+2% Craftsmanship Speed	300	500	500	DEVELOPMENT	CRAFTSMANSHIP	Craftsmanship	5	0	BONUS	5	\N	f	0.00	0	\N	CRAFTSMANSHIP_SPEED	2.00
428	Cooperative Crafting	+2% Craftsmanship Speed	300	500	500	DEVELOPMENT	CRAFTSMANSHIP	Craftsmanship	5	0	BONUS	5	\N	f	0.00	0	\N	CRAFTSMANSHIP_SPEED	2.00
429	Material Stewardship	+2% Craftsmanship Speed	300	500	500	DEVELOPMENT	CRAFTSMANSHIP	Craftsmanship	5	0	BONUS	5	\N	f	0.00	0	\N	CRAFTSMANSHIP_SPEED	2.00
430	Advanced Craft Techniques	+2% Craftsmanship Speed	360	600	600	DEVELOPMENT	CRAFTSMANSHIP	Craftsmanship	6	0	BONUS	6	\N	f	0.00	0	\N	CRAFTSMANSHIP_SPEED	2.00
431	Efficiency Practices	+2% Craftsmanship Speed	360	600	600	DEVELOPMENT	CRAFTSMANSHIP	Craftsmanship	6	0	BONUS	6	\N	f	0.00	0	\N	CRAFTSMANSHIP_SPEED	2.00
432	Cross-Trade Mobility	+2% Craftsmanship Speed	360	600	600	DEVELOPMENT	CRAFTSMANSHIP	Craftsmanship	6	0	BONUS	6	\N	f	0.00	0	\N	CRAFTSMANSHIP_SPEED	2.00
433	Specialist Instruction	+2% Craftsmanship Speed	420	700	700	DEVELOPMENT	CRAFTSMANSHIP	Craftsmanship	7	0	BONUS	7	\N	f	0.00	0	\N	CRAFTSMANSHIP_SPEED	2.00
434	Industrial Craftwork	+2% Craftsmanship Speed	420	700	700	DEVELOPMENT	CRAFTSMANSHIP	Craftsmanship	7	0	BONUS	7	\N	f	0.00	0	\N	CRAFTSMANSHIP_SPEED	2.00
435	Mass Labor Training	+2% Craftsmanship Speed	420	700	700	DEVELOPMENT	CRAFTSMANSHIP	Craftsmanship	7	0	BONUS	7	\N	f	0.00	0	\N	CRAFTSMANSHIP_SPEED	2.00
436	Professional Craft Standards	+2% Craftsmanship Speed	480	800	800	DEVELOPMENT	CRAFTSMANSHIP	Craftsmanship	8	0	BONUS	8	\N	f	0.00	0	\N	CRAFTSMANSHIP_SPEED	2.00
437	Trade Certification	+2% Craftsmanship Speed	480	800	800	DEVELOPMENT	CRAFTSMANSHIP	Craftsmanship	8	0	BONUS	8	\N	f	0.00	0	\N	CRAFTSMANSHIP_SPEED	2.00
438	Safety & Hazard Doctrine	+2% Craftsmanship Speed	480	800	800	DEVELOPMENT	CRAFTSMANSHIP	Craftsmanship	8	0	BONUS	8	\N	f	0.00	0	\N	CRAFTSMANSHIP_SPEED	2.00
439	Integrated Craft Systems	+2% Craftsmanship Speed	540	900	900	DEVELOPMENT	CRAFTSMANSHIP	Craftsmanship	9	0	BONUS	9	\N	f	0.00	0	\N	CRAFTSMANSHIP_SPEED	2.00
440	Royal Education Mandate	+2% Craftsmanship Speed	540	900	900	DEVELOPMENT	CRAFTSMANSHIP	Craftsmanship	9	0	BONUS	9	\N	f	0.00	0	\N	CRAFTSMANSHIP_SPEED	2.00
441	Elite Recruitment	+2% Craftsmanship Speed	540	900	900	DEVELOPMENT	CRAFTSMANSHIP	Craftsmanship	9	0	BONUS	9	\N	f	0.00	0	\N	CRAFTSMANSHIP_SPEED	2.00
552	Advanced Auditing	+0.1% Tax Efficiency	360	600	600	RESOURCE	TAX	Tax	6	0	BONUS	6	\N	f	0.00	0	\N	TAX_EFFICIENCY	0.10
442	Masterwork Techniques	+2% Craftsmanship Speed	600	1000	1000	DEVELOPMENT	CRAFTSMANSHIP	Craftsmanship	10	0	BONUS	10	\N	f	0.00	0	\N	CRAFTSMANSHIP_SPEED	2.00
443	Elite Craft Corps	+2% Craftsmanship Speed	600	1000	1000	DEVELOPMENT	CRAFTSMANSHIP	Craftsmanship	10	0	BONUS	10	\N	f	0.00	0	\N	CRAFTSMANSHIP_SPEED	2.00
444	Excellence Tradition	+2% Craftsmanship Speed	600	1000	1000	DEVELOPMENT	CRAFTSMANSHIP	Craftsmanship	10	0	BONUS	10	\N	f	0.00	0	\N	CRAFTSMANSHIP_SPEED	2.00
120	Productivity Audits	Unlocks bonus research to increase Craftsmanship effectiveness	180	300	300	DEVELOPMENT	CRAFTSMANSHIP	Craftsmanship	3	0	BONUS	3	\N	t	0.00	0	30.00	CRAFTSMANSHIP_SPEED	30.00
121	Performance Measures	Unlocks bonus research to increase Craftsmanship effectiveness	240	400	400	DEVELOPMENT	CRAFTSMANSHIP	Craftsmanship	4	0	BONUS	4	\N	t	0.00	0	35.00	CRAFTSMANSHIP_SPEED	35.00
122	Workforce Expansion Doctrine	Unlocks bonus research to increase Craftsmanship effectiveness	300	500	500	DEVELOPMENT	CRAFTSMANSHIP	Craftsmanship	5	0	BONUS	5	\N	t	0.00	0	40.00	CRAFTSMANSHIP_SPEED	40.00
123	Superior Supervision	Unlocks bonus research to increase Craftsmanship effectiveness	360	600	600	DEVELOPMENT	CRAFTSMANSHIP	Craftsmanship	6	0	BONUS	6	\N	t	0.00	0	45.00	CRAFTSMANSHIP_SPEED	45.00
124	Workforce Planning Charter	Unlocks bonus research to increase Craftsmanship effectiveness	420	700	700	DEVELOPMENT	CRAFTSMANSHIP	Craftsmanship	7	0	BONUS	7	\N	t	0.00	0	50.00	CRAFTSMANSHIP_SPEED	50.00
125	Labor Management Principles	Unlocks bonus research to increase Craftsmanship effectiveness	480	800	800	DEVELOPMENT	CRAFTSMANSHIP	Craftsmanship	8	0	BONUS	8	\N	t	0.00	0	55.00	CRAFTSMANSHIP_SPEED	55.00
126	Labor Optimization Doctrine	Unlocks bonus research to increase Craftsmanship effectiveness	540	900	900	DEVELOPMENT	CRAFTSMANSHIP	Craftsmanship	9	0	BONUS	9	\N	t	0.00	0	60.00	CRAFTSMANSHIP_SPEED	60.00
127	Supreme Labor Authority	Unlocks bonus research to increase Craftsmanship effectiveness	600	1000	1000	DEVELOPMENT	CRAFTSMANSHIP	Craftsmanship	10	0	BONUS	10	\N	t	0.00	0	65.00	CRAFTSMANSHIP_SPEED	65.00
445	Local Negotiation	+2% Politics	60	100	100	DIPLOMACY	POLITICS	Politics	1	0	BONUS	1	\N	f	0.00	0	\N	POLITICS	2.00
446	Village Relations	+2% Politics	60	100	100	DIPLOMACY	POLITICS	Politics	1	0	BONUS	1	\N	f	0.00	0	\N	POLITICS	2.00
447	Settlement Management	+2% Politics	60	100	100	DIPLOMACY	POLITICS	Politics	1	0	BONUS	1	\N	f	0.00	0	\N	POLITICS	2.00
448	Trade Bargaining	+2% Politics	120	200	200	DIPLOMACY	POLITICS	Politics	2	0	BONUS	2	\N	f	0.00	0	\N	POLITICS	2.00
449	Community Leadership	+2% Politics	120	200	200	DIPLOMACY	POLITICS	Politics	2	0	BONUS	2	\N	f	0.00	0	\N	POLITICS	2.00
450	Construction Oversight	+2% Politics	120	200	200	DIPLOMACY	POLITICS	Politics	2	0	BONUS	2	\N	f	0.00	0	\N	POLITICS	2.00
451	Regional Negotiation	+2% Politics	180	300	300	DIPLOMACY	POLITICS	Politics	3	0	BONUS	3	\N	f	0.00	0	\N	POLITICS	2.00
452	Population Stewardship	+2% Politics	180	300	300	DIPLOMACY	POLITICS	Politics	3	0	BONUS	3	\N	f	0.00	0	\N	POLITICS	2.00
453	Infrastructure Planning	+2% Politics	180	300	300	DIPLOMACY	POLITICS	Politics	3	0	BONUS	3	\N	f	0.00	0	\N	POLITICS	2.00
454	Diplomatic Etiquette	+2% Politics	240	400	400	DIPLOMACY	POLITICS	Politics	4	0	BONUS	4	\N	f	0.00	0	\N	POLITICS	2.00
455	Public Affairs	+2% Politics	240	400	400	DIPLOMACY	POLITICS	Politics	4	0	BONUS	4	\N	f	0.00	0	\N	POLITICS	2.00
456	Urban Coordination	+2% Politics	240	400	400	DIPLOMACY	POLITICS	Politics	4	0	BONUS	4	\N	f	0.00	0	\N	POLITICS	2.00
457	High-Court Negotiation	+2% Politics	300	500	500	DIPLOMACY	POLITICS	Politics	5	0	BONUS	5	\N	f	0.00	0	\N	POLITICS	2.00
458	Population Directives	+2% Politics	300	500	500	DIPLOMACY	POLITICS	Politics	5	0	BONUS	5	\N	f	0.00	0	\N	POLITICS	2.00
459	Master Builder Planning	+2% Politics	300	500	500	DIPLOMACY	POLITICS	Politics	5	0	BONUS	5	\N	f	0.00	0	\N	POLITICS	2.00
460	Alliance Diplomacy	+2% Politics	360	600	600	DIPLOMACY	POLITICS	Politics	6	0	BONUS	6	\N	f	0.00	0	\N	POLITICS	2.00
461	Urban Leadership	+2% Politics	360	600	600	DIPLOMACY	POLITICS	Politics	6	0	BONUS	6	\N	f	0.00	0	\N	POLITICS	2.00
462	Architectural Oversight	+2% Politics	360	600	600	DIPLOMACY	POLITICS	Politics	6	0	BONUS	6	\N	f	0.00	0	\N	POLITICS	2.00
463	Realm Negotiation	+2% Politics	420	700	700	DIPLOMACY	POLITICS	Politics	7	0	BONUS	7	\N	f	0.00	0	\N	POLITICS	2.00
464	Population Expansion	+2% Politics	420	700	700	DIPLOMACY	POLITICS	Politics	7	0	BONUS	7	\N	f	0.00	0	\N	POLITICS	2.00
465	Grand Construction	+2% Politics	420	700	700	DIPLOMACY	POLITICS	Politics	7	0	BONUS	7	\N	f	0.00	0	\N	POLITICS	2.00
466	High Diplomacy	+2% Politics	480	800	800	DIPLOMACY	POLITICS	Politics	8	0	BONUS	8	\N	f	0.00	0	\N	POLITICS	2.00
467	National Leadership	+2% Politics	480	800	800	DIPLOMACY	POLITICS	Politics	8	0	BONUS	8	\N	f	0.00	0	\N	POLITICS	2.00
468	Master Architect Planning	+2% Politics	480	800	800	DIPLOMACY	POLITICS	Politics	8	0	BONUS	8	\N	f	0.00	0	\N	POLITICS	2.00
469	Continental Negotiation	+2% Politics	540	900	900	DIPLOMACY	POLITICS	Politics	9	0	BONUS	9	\N	f	0.00	0	\N	POLITICS	2.00
470	Population Mastery	+2% Politics	540	900	900	DIPLOMACY	POLITICS	Politics	9	0	BONUS	9	\N	f	0.00	0	\N	POLITICS	2.00
471	Empire Construction	+2% Politics	540	900	900	DIPLOMACY	POLITICS	Politics	9	0	BONUS	9	\N	f	0.00	0	\N	POLITICS	2.00
472	Grand Diplomacy	+2% Politics	600	1000	1000	DIPLOMACY	POLITICS	Politics	10	0	BONUS	10	\N	f	0.00	0	\N	POLITICS	2.00
473	People's Mandate	+2% Politics	600	1000	1000	DIPLOMACY	POLITICS	Politics	10	0	BONUS	10	\N	f	0.00	0	\N	POLITICS	2.00
474	Master Builder Authority	+2% Politics	600	1000	1000	DIPLOMACY	POLITICS	Politics	10	0	BONUS	10	\N	f	0.00	0	\N	POLITICS	2.00
149	Town Governance	Unlocks bonus research to increase Politics effectiveness	120	200	200	DIPLOMACY	POLITICS	Politics	2	0	BONUS	2	\N	t	0.00	0	25.00	POLITICS	25.00
150	Administrative Strategy	Unlocks bonus research to increase Politics effectiveness	180	300	300	DIPLOMACY	POLITICS	Politics	3	0	BONUS	3	\N	t	0.00	0	30.00	POLITICS	30.00
151	Civic Development	Unlocks bonus research to increase Politics effectiveness	240	400	400	DIPLOMACY	POLITICS	Politics	4	0	BONUS	4	\N	t	0.00	0	35.00	POLITICS	35.00
152	Royal Administration	Unlocks bonus research to increase Politics effectiveness	300	500	500	DIPLOMACY	POLITICS	Politics	5	0	BONUS	5	\N	t	0.00	0	40.00	POLITICS	40.00
153	Council Strategy	Unlocks bonus research to increase Politics effectiveness	360	600	600	DIPLOMACY	POLITICS	Politics	6	0	BONUS	6	\N	t	0.00	0	45.00	POLITICS	45.00
154	Provincial Governance	Unlocks bonus research to increase Politics effectiveness	420	700	700	DIPLOMACY	POLITICS	Politics	7	0	BONUS	7	\N	t	0.00	0	50.00	POLITICS	50.00
155	Statecraft Doctrine	Unlocks bonus research to increase Politics effectiveness	480	800	800	DIPLOMACY	POLITICS	Politics	8	0	BONUS	8	\N	t	0.00	0	55.00	POLITICS	55.00
156	Imperial Governance	Unlocks bonus research to increase Politics effectiveness	540	900	900	DIPLOMACY	POLITICS	Politics	9	0	BONUS	9	\N	t	0.00	0	60.00	POLITICS	60.00
157	Mayor's Supremacy	Unlocks bonus research to increase Politics effectiveness	600	1000	1000	DIPLOMACY	POLITICS	Politics	10	0	BONUS	10	\N	t	0.00	0	65.00	POLITICS	65.00
475	Militia Drills	+2% Attack	60	100	100	DIPLOMACY	ATTACK	Attack Leadership	1	0	BONUS	1	\N	f	0.00	0	\N	ATTACK	2.00
476	Weapon Familiarity	+2% Attack	60	100	100	DIPLOMACY	ATTACK	Attack Leadership	1	0	BONUS	1	\N	f	0.00	0	\N	ATTACK	2.00
477	Field Discipline	+2% Attack	60	100	100	DIPLOMACY	ATTACK	Attack Leadership	1	0	BONUS	1	\N	f	0.00	0	\N	ATTACK	2.00
478	Infantry Tactics	+2% Attack	120	200	200	DIPLOMACY	ATTACK	Attack Leadership	2	0	BONUS	2	\N	f	0.00	0	\N	ATTACK	2.00
479	Command Basics	+2% Attack	120	200	200	DIPLOMACY	ATTACK	Attack Leadership	2	0	BONUS	2	\N	f	0.00	0	\N	ATTACK	2.00
480	Formation Training	+2% Attack	120	200	200	DIPLOMACY	ATTACK	Attack Leadership	2	0	BONUS	2	\N	f	0.00	0	\N	ATTACK	2.00
481	Advanced Infantry	+2% Attack	180	300	300	DIPLOMACY	ATTACK	Attack Leadership	3	0	BONUS	3	\N	f	0.00	0	\N	ATTACK	2.00
482	Officer Training	+2% Attack	180	300	300	DIPLOMACY	ATTACK	Attack Leadership	3	0	BONUS	3	\N	f	0.00	0	\N	ATTACK	2.00
483	Siege Preparation	+2% Attack	180	300	300	DIPLOMACY	ATTACK	Attack Leadership	3	0	BONUS	3	\N	f	0.00	0	\N	ATTACK	2.00
490	Heavy Cavalry	+2% Attack	360	600	600	DIPLOMACY	ATTACK	Attack Leadership	6	0	BONUS	6	\N	f	0.00	0	\N	ATTACK	2.00
491	Strategic Command	+2% Attack	360	600	600	DIPLOMACY	ATTACK	Attack Leadership	6	0	BONUS	6	\N	f	0.00	0	\N	ATTACK	2.00
492	Fortification Assault	+2% Attack	360	600	600	DIPLOMACY	ATTACK	Attack Leadership	6	0	BONUS	6	\N	f	0.00	0	\N	ATTACK	2.00
500	High Generalship	+2% Attack	540	900	900	DIPLOMACY	ATTACK	Attack Leadership	9	0	BONUS	9	\N	f	0.00	0	\N	ATTACK	2.00
501	Siege Supremacy	+2% Attack	540	900	900	DIPLOMACY	ATTACK	Attack Leadership	9	0	BONUS	9	\N	f	0.00	0	\N	ATTACK	2.00
502	Master Warfare	+2% Attack	600	1000	1000	DIPLOMACY	ATTACK	Attack Leadership	10	0	BONUS	10	\N	f	0.00	0	\N	ATTACK	2.00
503	General's Authority	+2% Attack	600	1000	1000	DIPLOMACY	ATTACK	Attack Leadership	10	0	BONUS	10	\N	f	0.00	0	\N	ATTACK	2.00
504	Battlefield Supremacy	+2% Attack	600	1000	1000	DIPLOMACY	ATTACK	Attack Leadership	10	0	BONUS	10	\N	f	0.00	0	\N	ATTACK	2.00
158	Battle Readiness	Unlocks bonus research to increase Attack effectiveness	60	100	100	DIPLOMACY	ATTACK	Attack Leadership	1	0	BONUS	1	\N	t	0.00	0	20.00	ATTACK	20.00
159	Warfield Coordination	Unlocks bonus research to increase Attack effectiveness	120	200	200	DIPLOMACY	ATTACK	Attack Leadership	2	0	BONUS	2	\N	t	0.00	0	25.00	ATTACK	25.00
160	Battle Strategy	Unlocks bonus research to increase Attack effectiveness	180	300	300	DIPLOMACY	ATTACK	Attack Leadership	3	0	BONUS	3	\N	t	0.00	0	30.00	ATTACK	30.00
161	War Planning	Unlocks bonus research to increase Attack effectiveness	240	400	400	DIPLOMACY	ATTACK	Attack Leadership	4	0	BONUS	4	\N	t	0.00	0	35.00	ATTACK	35.00
162	Battle Efficiency	Unlocks bonus research to increase Attack effectiveness	300	500	500	DIPLOMACY	ATTACK	Attack Leadership	5	0	BONUS	5	\N	t	0.00	0	40.00	ATTACK	40.00
163	War Doctrine	Unlocks bonus research to increase Attack effectiveness	360	600	600	DIPLOMACY	ATTACK	Attack Leadership	6	0	BONUS	6	\N	t	0.00	0	45.00	ATTACK	45.00
164	Battlefield Planning	Unlocks bonus research to increase Attack effectiveness	420	700	700	DIPLOMACY	ATTACK	Attack Leadership	7	0	BONUS	7	\N	t	0.00	0	50.00	ATTACK	50.00
165	Military Governance	Unlocks bonus research to increase Attack effectiveness	480	800	800	DIPLOMACY	ATTACK	Attack Leadership	8	0	BONUS	8	\N	t	0.00	0	55.00	ATTACK	55.00
166	Warfield Optimization	Unlocks bonus research to increase Attack effectiveness	540	900	900	DIPLOMACY	ATTACK	Attack Leadership	9	0	BONUS	9	\N	t	0.00	0	60.00	ATTACK	60.00
167	General's Dominion	Unlocks bonus research to increase Attack effectiveness	600	1000	1000	DIPLOMACY	ATTACK	Attack Leadership	10	0	BONUS	10	\N	t	0.00	0	65.00	ATTACK	65.00
168	Inquiry Methods	Unlocks bonus research to increase Intelligence effectiveness	60	100	100	DIPLOMACY	INTELLIGENCE	Research Speed	1	0	BONUS	1	\N	t	0.00	0	20.00	INTELLIGENCE	20.00
169	Research Organization	Unlocks bonus research to increase Intelligence effectiveness	120	200	200	DIPLOMACY	INTELLIGENCE	Research Speed	2	0	BONUS	2	\N	t	0.00	0	25.00	INTELLIGENCE	25.00
170	Knowledge Planning	Unlocks bonus research to increase Intelligence effectiveness	180	300	300	DIPLOMACY	INTELLIGENCE	Research Speed	3	0	BONUS	3	\N	t	0.00	0	30.00	INTELLIGENCE	30.00
171	Academic Development	Unlocks bonus research to increase Intelligence effectiveness	240	400	400	DIPLOMACY	INTELLIGENCE	Research Speed	4	0	BONUS	4	\N	t	0.00	0	35.00	INTELLIGENCE	35.00
172	Research Efficiency	Unlocks bonus research to increase Intelligence effectiveness	300	500	500	DIPLOMACY	INTELLIGENCE	Research Speed	5	0	BONUS	5	\N	t	0.00	0	40.00	INTELLIGENCE	40.00
505	Scholarly Basics	+2% Intelligence	60	100	100	DIPLOMACY	INTELLIGENCE	Research Speed	1	0	BONUS	1	\N	f	0.00	0	\N	INTELLIGENCE	2.00
506	Record Keeping	+2% Intelligence	60	100	100	DIPLOMACY	INTELLIGENCE	Research Speed	1	0	BONUS	1	\N	f	0.00	0	\N	INTELLIGENCE	2.00
507	Local Studies	+2% Intelligence	60	100	100	DIPLOMACY	INTELLIGENCE	Research Speed	1	0	BONUS	1	\N	f	0.00	0	\N	INTELLIGENCE	2.00
508	Scriptorium Work	+2% Intelligence	120	200	200	DIPLOMACY	INTELLIGENCE	Research Speed	2	0	BONUS	2	\N	f	0.00	0	\N	INTELLIGENCE	2.00
509	Historical Study	+2% Intelligence	120	200	200	DIPLOMACY	INTELLIGENCE	Research Speed	2	0	BONUS	2	\N	f	0.00	0	\N	INTELLIGENCE	2.00
510	Field Observation	+2% Intelligence	120	200	200	DIPLOMACY	INTELLIGENCE	Research Speed	2	0	BONUS	2	\N	f	0.00	0	\N	INTELLIGENCE	2.00
511	Advanced Study	+2% Intelligence	180	300	300	DIPLOMACY	INTELLIGENCE	Research Speed	3	0	BONUS	3	\N	f	0.00	0	\N	INTELLIGENCE	2.00
512	Scholarly Analysis	+2% Intelligence	180	300	300	DIPLOMACY	INTELLIGENCE	Research Speed	3	0	BONUS	3	\N	f	0.00	0	\N	INTELLIGENCE	2.00
513	Survey Techniques	+2% Intelligence	180	300	300	DIPLOMACY	INTELLIGENCE	Research Speed	3	0	BONUS	3	\N	f	0.00	0	\N	INTELLIGENCE	2.00
514	Scientific Inquiry	+2% Intelligence	240	400	400	DIPLOMACY	INTELLIGENCE	Research Speed	4	0	BONUS	4	\N	f	0.00	0	\N	INTELLIGENCE	2.00
515	Library Sciences	+2% Intelligence	240	400	400	DIPLOMACY	INTELLIGENCE	Research Speed	4	0	BONUS	4	\N	f	0.00	0	\N	INTELLIGENCE	2.00
516	Exploration Methods	+2% Intelligence	240	400	400	DIPLOMACY	INTELLIGENCE	Research Speed	4	0	BONUS	4	\N	f	0.00	0	\N	INTELLIGENCE	2.00
517	Expert Research	+2% Intelligence	300	500	500	DIPLOMACY	INTELLIGENCE	Research Speed	5	0	BONUS	5	\N	f	0.00	0	\N	INTELLIGENCE	2.00
518	Scholarly Collaboration	+2% Intelligence	300	500	500	DIPLOMACY	INTELLIGENCE	Research Speed	5	0	BONUS	5	\N	f	0.00	0	\N	INTELLIGENCE	2.00
519	Knowledge Stewardship	+2% Intelligence	300	500	500	DIPLOMACY	INTELLIGENCE	Research Speed	5	0	BONUS	5	\N	f	0.00	0	\N	INTELLIGENCE	2.00
520	Advanced Research	+2% Intelligence	360	600	600	DIPLOMACY	INTELLIGENCE	Research Speed	6	0	BONUS	6	\N	f	0.00	0	\N	INTELLIGENCE	2.00
521	Analytical Practices	+2% Intelligence	360	600	600	DIPLOMACY	INTELLIGENCE	Research Speed	6	0	BONUS	6	\N	f	0.00	0	\N	INTELLIGENCE	2.00
522	Exploration Mapping	+2% Intelligence	360	600	600	DIPLOMACY	INTELLIGENCE	Research Speed	6	0	BONUS	6	\N	f	0.00	0	\N	INTELLIGENCE	2.00
523	Specialized Study	+2% Intelligence	420	700	700	DIPLOMACY	INTELLIGENCE	Research Speed	7	0	BONUS	7	\N	f	0.00	0	\N	INTELLIGENCE	2.00
524	Scientific Method	+2% Intelligence	420	700	700	DIPLOMACY	INTELLIGENCE	Research Speed	7	0	BONUS	7	\N	f	0.00	0	\N	INTELLIGENCE	2.00
525	Expedition Planning	+2% Intelligence	420	700	700	DIPLOMACY	INTELLIGENCE	Research Speed	7	0	BONUS	7	\N	f	0.00	0	\N	INTELLIGENCE	2.00
526	Professional Research	+2% Intelligence	480	800	800	DIPLOMACY	INTELLIGENCE	Research Speed	8	0	BONUS	8	\N	f	0.00	0	\N	INTELLIGENCE	2.00
527	Scholarly Certification	+2% Intelligence	480	800	800	DIPLOMACY	INTELLIGENCE	Research Speed	8	0	BONUS	8	\N	f	0.00	0	\N	INTELLIGENCE	2.00
528	Discovery Doctrine	+2% Intelligence	480	800	800	DIPLOMACY	INTELLIGENCE	Research Speed	8	0	BONUS	8	\N	f	0.00	0	\N	INTELLIGENCE	2.00
529	Integrated Research	+2% Intelligence	540	900	900	DIPLOMACY	INTELLIGENCE	Research Speed	9	0	BONUS	9	\N	f	0.00	0	\N	INTELLIGENCE	2.00
530	National Scholarship	+2% Intelligence	540	900	900	DIPLOMACY	INTELLIGENCE	Research Speed	9	0	BONUS	9	\N	f	0.00	0	\N	INTELLIGENCE	2.00
531	Elite Inquiry	+2% Intelligence	540	900	900	DIPLOMACY	INTELLIGENCE	Research Speed	9	0	BONUS	9	\N	f	0.00	0	\N	INTELLIGENCE	2.00
532	Master Scholarship	+2% Intelligence	600	1000	1000	DIPLOMACY	INTELLIGENCE	Research Speed	10	0	BONUS	10	\N	f	0.00	0	\N	INTELLIGENCE	2.00
533	Elite Research Corps	+2% Intelligence	600	1000	1000	DIPLOMACY	INTELLIGENCE	Research Speed	10	0	BONUS	10	\N	f	0.00	0	\N	INTELLIGENCE	2.00
534	Scholarly Supremacy	+2% Intelligence	600	1000	1000	DIPLOMACY	INTELLIGENCE	Research Speed	10	0	BONUS	10	\N	f	0.00	0	\N	INTELLIGENCE	2.00
173	Superior Scholarship	Unlocks bonus research to increase Intelligence effectiveness	360	600	600	DIPLOMACY	INTELLIGENCE	Research Speed	6	0	BONUS	6	\N	t	0.00	0	45.00	INTELLIGENCE	45.00
138	Village Tax Codes	Unlocks bonus research to increase Tax effectiveness	60	100	100	DEVELOPMENT	TAX	Tax	1	0	BONUS	1	\N	t	0.00	0	20.00	TAX_EFFICIENCY	20.00
139	Town Treasury Law	Unlocks bonus research to increase Tax effectiveness	120	200	200	DEVELOPMENT	TAX	Tax	2	0	BONUS	2	\N	t	0.00	0	25.00	TAX_EFFICIENCY	25.00
140	Fiscal Planning	Unlocks bonus research to increase Tax effectiveness	180	300	300	DEVELOPMENT	TAX	Tax	3	0	BONUS	3	\N	t	0.00	0	30.00	TAX_EFFICIENCY	30.00
141	Treasury Development	Unlocks bonus research to increase Tax effectiveness	240	400	400	DEVELOPMENT	TAX	Tax	4	0	BONUS	4	\N	t	0.00	0	35.00	TAX_EFFICIENCY	35.00
142	Royal Treasury Management	Unlocks bonus research to increase Tax effectiveness	300	500	500	DEVELOPMENT	TAX	Tax	5	0	BONUS	5	\N	t	0.00	0	40.00	TAX_EFFICIENCY	40.00
143	Treasury Doctrine	Unlocks bonus research to increase Tax effectiveness	360	600	600	DEVELOPMENT	TAX	Tax	6	0	BONUS	6	\N	t	0.00	0	45.00	TAX_EFFICIENCY	45.00
144	Provincial Treasury Law	Unlocks bonus research to increase Tax effectiveness	420	700	700	DEVELOPMENT	TAX	Tax	7	0	BONUS	7	\N	t	0.00	0	50.00	TAX_EFFICIENCY	50.00
145	State Treasury Management	Unlocks bonus research to increase Tax effectiveness	480	800	800	DEVELOPMENT	TAX	Tax	8	0	BONUS	8	\N	t	0.00	0	55.00	TAX_EFFICIENCY	55.00
146	Imperial Treasury Doctrine	Unlocks bonus research to increase Tax effectiveness	540	900	900	DEVELOPMENT	TAX	Tax	9	0	BONUS	9	\N	t	0.00	0	60.00	TAX_EFFICIENCY	60.00
542	Regional Assessments	+0.1% Tax Efficiency	180	300	300	RESOURCE	TAX	Tax	3	0	BONUS	3	\N	f	0.00	0	\N	TAX_EFFICIENCY	0.10
543	Revenue Audits	+0.1% Tax Efficiency	180	300	300	RESOURCE	TAX	Tax	3	0	BONUS	3	\N	f	0.00	0	\N	TAX_EFFICIENCY	0.10
544	Trade Route Taxation	+0.1% Tax Efficiency	240	400	400	RESOURCE	TAX	Tax	4	0	BONUS	4	\N	f	0.00	0	\N	TAX_EFFICIENCY	0.10
545	Urban Collections	+0.1% Tax Efficiency	240	400	400	RESOURCE	TAX	Tax	4	0	BONUS	4	\N	f	0.00	0	\N	TAX_EFFICIENCY	0.10
546	Revenue Enforcement	+0.1% Tax Efficiency	240	400	400	RESOURCE	TAX	Tax	4	0	BONUS	4	\N	f	0.00	0	\N	TAX_EFFICIENCY	0.10
547	Merchant Guild Taxation	+0.1% Tax Efficiency	300	500	500	RESOURCE	TAX	Tax	5	0	BONUS	5	\N	f	0.00	0	\N	TAX_EFFICIENCY	0.10
548	Population Revenue	+0.1% Tax Efficiency	300	500	500	RESOURCE	TAX	Tax	5	0	BONUS	5	\N	f	0.00	0	\N	TAX_EFFICIENCY	0.10
549	Fiscal Oversight	+0.1% Tax Efficiency	300	500	500	RESOURCE	TAX	Tax	5	0	BONUS	5	\N	f	0.00	0	\N	TAX_EFFICIENCY	0.10
550	Trade Network Duties	+0.1% Tax Efficiency	360	600	600	RESOURCE	TAX	Tax	6	0	BONUS	6	\N	f	0.00	0	\N	TAX_EFFICIENCY	0.10
551	Urban Revenue Systems	+0.1% Tax Efficiency	360	600	600	RESOURCE	TAX	Tax	6	0	BONUS	6	\N	f	0.00	0	\N	TAX_EFFICIENCY	0.10
553	Realm Taxation	+0.1% Tax Efficiency	420	700	700	RESOURCE	TAX	Tax	7	0	BONUS	7	\N	f	0.00	0	\N	TAX_EFFICIENCY	0.10
554	Population Expansion Revenue	+0.1% Tax Efficiency	420	700	700	RESOURCE	TAX	Tax	7	0	BONUS	7	\N	f	0.00	0	\N	TAX_EFFICIENCY	0.10
555	Grand Fiscal Planning	+0.1% Tax Efficiency	420	700	700	RESOURCE	TAX	Tax	7	0	BONUS	7	\N	f	0.00	0	\N	TAX_EFFICIENCY	0.10
556	High Trade Duties	+0.1% Tax Efficiency	480	800	800	RESOURCE	TAX	Tax	8	0	BONUS	8	\N	f	0.00	0	\N	TAX_EFFICIENCY	0.10
557	National Revenue Systems	+0.1% Tax Efficiency	480	800	800	RESOURCE	TAX	Tax	8	0	BONUS	8	\N	f	0.00	0	\N	TAX_EFFICIENCY	0.10
558	Advanced Fiscal Doctrine	+0.1% Tax Efficiency	480	800	800	RESOURCE	TAX	Tax	8	0	BONUS	8	\N	f	0.00	0	\N	TAX_EFFICIENCY	0.10
559	Continental Trade Taxation	+0.1% Tax Efficiency	540	900	900	RESOURCE	TAX	Tax	9	0	BONUS	9	\N	f	0.00	0	\N	TAX_EFFICIENCY	0.10
560	Empire Revenue	+0.1% Tax Efficiency	540	900	900	RESOURCE	TAX	Tax	9	0	BONUS	9	\N	f	0.00	0	\N	TAX_EFFICIENCY	0.10
561	Elite Fiscal Oversight	+0.1% Tax Efficiency	540	900	900	RESOURCE	TAX	Tax	9	0	BONUS	9	\N	f	0.00	0	\N	TAX_EFFICIENCY	0.10
562	Master Taxation	+0.1% Tax Efficiency	600	1000	1000	RESOURCE	TAX	Tax	10	0	BONUS	10	\N	f	0.00	0	\N	TAX_EFFICIENCY	0.10
563	Elite Revenue Corps	+0.1% Tax Efficiency	600	1000	1000	RESOURCE	TAX	Tax	10	0	BONUS	10	\N	f	0.00	0	\N	TAX_EFFICIENCY	0.10
564	Treasury Supremacy	+0.1% Tax Efficiency	600	1000	1000	RESOURCE	TAX	Tax	10	0	BONUS	10	\N	f	0.00	0	\N	TAX_EFFICIENCY	0.10
147	Royal Fiscal Authority	Unlocks bonus research to increase Tax effectiveness	600	1000	1000	DEVELOPMENT	TAX	Tax	10	0	BONUS	10	\N	t	0.00	0	65.00	TAX_EFFICIENCY	65.00
\.


--
-- Data for Name: research_queue; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.research_queue (id, player_id, city_id, research_node_id, started_at, finish_at, status) FROM stdin;
1	12	11	10	2026-09-04 20:35:20.179	2026-09-04 20:38:54.179	COMPLETED
2	12	11	99	2026-09-05 12:10:18.889	2026-09-05 12:11:44.889	COMPLETED
3	12	11	139	2026-09-05 12:18:42.137	2026-09-05 12:20:08.137	CANCELLED
4	12	11	139	2026-09-05 12:20:12.295	2026-09-05 12:21:38.295	CANCELLED
5	12	11	46	2026-09-05 12:46:56.081	2026-09-05 12:47:39.081	COMPLETED
6	12	11	128	2026-09-05 12:50:19.834	2026-09-05 12:51:02.834	COMPLETED
7	12	11	54	2026-09-06 13:19:59.792	2026-09-06 13:21:25.792	COMPLETED
8	12	11	50	2026-09-06 13:45:44.526	2026-09-06 13:47:10.526	COMPLETED
9	12	11	66	2026-09-06 13:56:15.396	2026-09-06 13:57:41.396	COMPLETED
10	12	11	334	2026-09-06 14:08:33.949	2026-09-06 14:09:16.949	COMPLETED
11	12	11	14	2026-09-06 19:01:24.812	2026-09-06 19:02:50.812	COMPLETED
12	12	11	34	2026-09-07 19:47:07.32	2026-09-07 19:47:50.32	COMPLETED
13	12	11	158	2026-09-07 19:49:51.576	2026-09-07 19:50:34.576	COMPLETED
14	12	11	98	2026-09-07 19:53:40.57	2026-09-07 19:54:17.57	COMPLETED
15	12	11	118	2026-09-07 19:55:04.962	2026-09-07 19:55:41.962	COMPLETED
16	12	11	108	2026-09-07 19:59:57.593	2026-09-07 20:00:34.593	COMPLETED
17	12	11	332	2026-09-09 06:30:09.634	2026-09-09 06:30:46.634	COMPLETED
18	12	11	333	2026-09-09 07:13:53.644	2026-09-09 07:14:30.644	COMPLETED
19	12	11	219	2026-09-10 11:33:16.664	2026-09-10 11:34:29.664	COMPLETED
20	12	11	417	2026-09-12 10:25:32.927	2026-09-12 10:26:09.927	COMPLETED
49	12	11	505	2026-09-14 21:07:04.19	2026-09-14 21:07:39.19	COMPLETED
22	12	11	30	2026-09-12 15:26:12.973	2026-09-12 15:27:25.973	COMPLETED
23	12	11	298	2026-09-12 21:58:43.969	2026-09-12 21:59:20.969	COMPLETED
24	12	11	93	2026-09-13 04:35:55.39	2026-09-13 04:37:08.39	COMPLETED
25	12	11	88	2026-09-13 12:41:37.364	2026-09-13 12:42:14.364	COMPLETED
26	12	11	129	2026-09-13 15:41:57.128	2026-09-13 15:43:10.128	COMPLETED
27	12	11	138	2026-09-13 15:51:56.427	2026-09-13 15:52:33.427	COMPLETED
28	12	11	168	2026-09-13 16:00:24.239	2026-09-13 16:01:01.239	COMPLETED
29	12	11	148	2026-09-13 16:03:40.978	2026-09-13 16:04:17.978	COMPLETED
30	12	11	679	2026-09-13 16:14:27.168	2026-09-13 16:15:04.168	COMPLETED
31	12	11	384	2026-09-13 23:19:23.227	2026-09-13 23:20:00.227	COMPLETED
32	12	11	416	2026-09-13 23:21:29.159	2026-09-13 23:22:06.159	COMPLETED
33	12	11	270	2026-09-13 23:23:25.239	2026-09-13 23:24:38.239	COMPLETED
34	12	11	269	2026-09-14 00:41:07.616	2026-09-14 00:42:20.616	COMPLETED
35	12	11	415	2026-09-14 00:45:57.916	2026-09-14 00:46:34.916	COMPLETED
36	12	11	1	2026-09-14 03:29:53.483	2026-09-14 03:31:37.483	COMPLETED
37	12	11	625	2026-09-14 13:08:32.251	2026-09-14 13:09:41.251	COMPLETED
38	12	11	680	2026-09-14 14:15:01.592	2026-09-14 14:16:10.592	COMPLETED
39	12	11	170	2026-09-14 14:18:13.537	2026-09-14 14:19:57.537	COMPLETED
40	12	11	47	2026-09-14 14:23:15.556	2026-09-14 14:24:59.556	COMPLETED
41	12	11	296	2026-09-14 16:10:46.736	2026-09-14 16:11:21.736	COMPLETED
42	12	11	4	2026-09-14 16:13:43.958	2026-09-14 16:15:27.958	COMPLETED
43	12	11	3	2026-09-14 16:25:28.337	2026-09-14 16:27:12.337	COMPLETED
44	12	11	2	2026-09-14 16:30:38.535	2026-09-14 16:32:22.535	COMPLETED
45	12	11	268	2026-09-14 17:15:18.638	2026-09-14 17:16:27.638	COMPLETED
46	12	11	535	2026-09-14 17:21:57.429	2026-09-14 17:22:32.429	COMPLETED
47	12	11	385	2026-09-14 17:27:53.347	2026-09-14 17:28:28.347	COMPLETED
48	12	11	386	2026-09-14 17:30:55.378	2026-09-14 17:31:30.378	COMPLETED
50	12	11	387	2026-09-14 21:08:55.781	2026-09-14 21:10:04.781	COMPLETED
51	12	11	388	2026-09-15 18:16:18.705	2026-09-15 18:17:39.705	COMPLETED
52	12	11	389	2026-09-15 18:53:52.786	2026-09-15 18:55:13.786	COMPLETED
53	12	11	100	2026-09-15 19:42:01.482	2026-09-15 19:44:02.482	COMPLETED
54	12	11	119	2026-09-15 20:54:46.157	2026-09-15 20:55:55.157	COMPLETED
55	12	11	537	2026-09-17 01:38:14.338	2026-09-17 01:38:48.338	COMPLETED
56	12	11	169	2026-09-17 15:31:47.673	2026-09-17 15:32:56.673	COMPLETED
57	12	11	120	2026-09-18 13:45:32.624	2026-09-18 13:47:15.624	COMPLETED
58	12	11	159	2026-09-18 13:57:23.551	2026-09-18 13:58:26.551	COMPLETED
59	12	11	62	2026-09-18 14:00:56.342	2026-09-18 14:02:30.342	COMPLETED
60	12	11	160	2026-09-18 14:45:46.737	2026-09-18 14:47:20.737	COMPLETED
61	12	11	392	2026-09-18 14:59:33.379	2026-09-18 15:01:07.379	COMPLETED
62	12	11	18	2026-09-19 10:45:45.732	2026-09-19 10:47:19.732	COMPLETED
63	12	11	139	2026-09-19 10:50:41.224	2026-09-19 10:51:44.224	COMPLETED
\.


--
-- Data for Name: system_effects; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.system_effects (id, branch_system, step_bonus_pct) FROM stdin;
1	RES-AGRI	2.00
2	RES-SAW	2.00
3	RES-STONE	2.00
4	RES-MINE	2.00
5	QUARRY	2
\.


--
-- Data for Name: tax_happiness_bands; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tax_happiness_bands (tax_rate_pct, base_happiness_penalty) FROM stdin;
15.00	5
20.00	10
25.00	15
30.00	20
35.00	25
40.00	30
45.00	35
50.00	40
\.


--
-- Data for Name: unit_research_requirements; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.unit_research_requirements (id, unit_type_id, research_id, requires_building_id, requires_building_level) FROM stdin;
1	12	\N	13	6
2	12	\N	6	6
3	12	63	\N	\N
4	12	162	\N	\N
5	12	58	\N	\N
6	12	52	\N	\N
7	12	47	\N	\N
8	16	\N	13	8
9	16	\N	6	8
10	16	64	\N	\N
11	16	164	\N	\N
12	16	60	\N	\N
13	16	53	\N	\N
14	16	47	\N	\N
15	6	\N	13	1
16	6	\N	10	1
17	6	\N	5	1
18	7	\N	8	1
19	7	\N	18	1
20	7	158	\N	\N
21	7	118	\N	\N
22	7	46	\N	\N
23	8	\N	8	2
24	8	\N	13	2
25	8	30	\N	\N
26	8	54	\N	\N
27	8	34	\N	\N
28	9	\N	13	2
29	9	\N	17	2
30	9	\N	18	2
31	9	93	\N	\N
32	9	66	\N	\N
33	10	\N	13	3
34	10	\N	6	3
35	10	62	\N	\N
36	10	159	\N	\N
37	10	54	\N	\N
38	10	50	\N	\N
39	10	47	\N	\N
40	11	\N	13	4
41	11	\N	14	4
42	11	161	\N	\N
43	11	94	\N	\N
44	11	66	\N	\N
45	11	56	\N	\N
46	13	\N	15	5
47	13	\N	14	5
48	13	74	\N	\N
49	13	67	\N	\N
50	13	57	\N	\N
51	14	\N	13	6
52	14	\N	14	6
53	14	\N	15	6
54	14	327	\N	\N
55	14	163	\N	\N
56	14	95	\N	\N
57	14	68	\N	\N
58	15	\N	13	7
59	15	\N	6	7
60	15	\N	15	7
61	15	75	\N	\N
62	15	71	\N	\N
63	15	49	\N	\N
64	15	20	\N	\N
65	17	\N	13	9
66	17	\N	6	9
67	17	\N	15	9
68	17	76	\N	\N
69	17	72	\N	\N
70	17	60	\N	\N
71	17	49	\N	\N
72	18	\N	13	10
73	18	\N	6	10
74	18	\N	15	10
75	18	77	\N	\N
76	18	73	\N	\N
77	18	60	\N	\N
78	18	49	\N	\N
79	13	122	\N	\N
80	17	126	\N	\N
81	18	127	\N	\N
\.


--
-- Data for Name: unit_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.unit_types (id, code, name, category, attack, defense, range_yards, population_cost, food_cost, wood_cost, stone_cost, iron_cost, gold_cost, base_training_seconds, req_building_code, req_building_level, min_barracks_level, required_workshop_level, required_stable_level, is_npc_only, upkeep, base_hp, load_capacity) FROM stdin;
2	abatis	Abatis	fortification	1000	0	0	2	100	1000	200	100	0	60	\N	\N	1	\N	\N	f	0	1	0
3	archer_tower	Archer's Tower	fortification	300	360	0	3	300	1500	800	300	0	60	\N	\N	1	\N	\N	f	0	2000	0
5	defensive_trebuchet	Defensive Trebuchet	fortification	2500	0	0	5	1000	5000	3000	2000	0	60	\N	\N	1	\N	\N	f	0	1	0
4	rolling_log	Rolling Log	fortification	500	0	0	4	500	3000	1500	500	0	60	\N	\N	1	\N	\N	f	0	1	0
1	trap	Trap	fortification	500	0	0	1	50	500	100	50	0	60	\N	\N	1	\N	\N	f	0	1	0
6	WARRIOR	Warrior	troop	50	50	0	1	100	50	0	0	0	30	FARM	1	1	\N	\N	f	0	200	20
9	SCOUT	Scout	troop	20	20	0	1	100	100	0	50	0	50	BEACON_TOWER	2	2	\N	\N	f	0	100	5
7	PIKEMAN	Pikeman	troop	150	150	0	1	100	150	0	50	0	60	IRON_MINE	1	1	\N	\N	f	0	300	40
8	SWORDSMAN	Swordsmen	troop	100	250	0	1	150	100	0	100	0	90	IRON_MINE	2	2	\N	\N	f	0	350	30
10	ARCHER	Archer	troop	120	50	0	1	200	100	0	100	0	120	SAWMILL	3	3	\N	\N	f	0	250	25
12	LONG_BOWMEN	Long Bowmen	troop	180	100	0	1	350	250	0	150	0	160	SAWMILL	6	6	\N	\N	f	0	120	35
16	CROSS_BOWMEN	Cross Bowmen	troop	120	80	0	1	500	400	0	300	0	200	SAWMILL	8	8	\N	\N	f	0	100	40
11	CAVALRY	Light Cavalry	troop	250	180	0	1	400	300	0	100	0	180	\N	\N	4	\N	4	f	0	500	100
14	CATAPHRACT	Cataphract	troop	350	350	0	1	2500	1000	0	1000	0	240	\N	\N	6	6	6	f	0	1000	80
13	TRANSPORTER	Transporter	troop	10	60	0	1	200	100	0	100	0	150	\N	\N	1	5	5	f	0	700	5000
18	BALLISTA	Ballista	troop	450	160	0	1	2000	1000	1000	0	0	300	SAWMILL	10	10	10	\N	f	0	320	35
15	BATTERING_RAM	Battering Ram	troop	250	160	0	1	2500	1000	1000	0	0	300	SAWMILL	7	7	7	\N	f	0	5000	45
17	CATAPULT	Catapult	troop	600	200	0	1	8000	5000	10000	3000	0	600	SAWMILL	9	9	9	\N	f	0	480	75
\.


--
-- Data for Name: wall_fortification_capacity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wall_fortification_capacity (id, city_id, current_capacity, max_capacity, updated_at) FROM stdin;
42	11	10000	10000	2026-08-31 14:38:54.667842
\.


--
-- Data for Name: world_resource_fields; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.world_resource_fields (id, resource_type, x, y, resource_level, warrior, pikeman, swordsman, archer, owner_city_id, occupied_at, recall_at, last_harvested_at) FROM stdin;
2	wood	0	1	5	38	50	18	13	\N	\N	\N	\N
3	food	0	8	5	38	50	18	13	\N	\N	\N	\N
4	stone	0	12	1	3	2	2	1	\N	\N	\N	\N
5	iron	0	24	4	20	20	5	5	\N	\N	\N	\N
6	stone	0	41	3	10	8	3	2	\N	\N	\N	\N
7	food	0	48	5	38	50	18	13	\N	\N	\N	\N
8	food	0	49	5	38	50	18	13	\N	\N	\N	\N
9	iron	0	83	2	3	2	2	2	\N	\N	\N	\N
10	stone	1	13	3	10	8	3	2	\N	\N	\N	\N
11	iron	1	62	4	20	20	5	5	\N	\N	\N	\N
12	food	1	64	3	10	8	3	2	\N	\N	\N	\N
13	stone	1	84	1	3	2	2	1	\N	\N	\N	\N
14	stone	1	85	2	3	2	2	2	\N	\N	\N	\N
15	stone	2	1	3	10	8	3	2	\N	\N	\N	\N
16	wood	2	13	4	20	20	5	5	\N	\N	\N	\N
17	food	2	17	1	3	2	2	1	\N	\N	\N	\N
18	food	2	21	1	3	2	2	1	\N	\N	\N	\N
19	stone	2	38	2	3	2	2	2	\N	\N	\N	\N
20	stone	2	41	5	38	50	18	13	\N	\N	\N	\N
21	stone	2	42	3	10	8	3	2	\N	\N	\N	\N
22	iron	2	56	4	20	20	5	5	\N	\N	\N	\N
23	food	2	61	2	3	2	2	2	\N	\N	\N	\N
24	food	2	71	5	38	50	18	13	\N	\N	\N	\N
25	wood	2	84	4	20	20	5	5	\N	\N	\N	\N
26	stone	2	85	5	38	50	18	13	\N	\N	\N	\N
27	stone	3	14	1	3	2	2	1	\N	\N	\N	\N
28	wood	3	24	2	3	2	2	2	\N	\N	\N	\N
29	wood	3	45	2	3	2	2	2	\N	\N	\N	\N
30	stone	3	46	2	3	2	2	2	\N	\N	\N	\N
31	iron	3	64	5	38	50	18	13	\N	\N	\N	\N
32	stone	3	78	3	10	8	3	2	\N	\N	\N	\N
33	wood	3	93	4	20	20	5	5	\N	\N	\N	\N
34	food	3	97	3	10	8	3	2	\N	\N	\N	\N
35	food	4	43	1	3	2	2	1	\N	\N	\N	\N
36	wood	4	45	2	3	2	2	2	\N	\N	\N	\N
37	stone	4	60	5	38	50	18	13	\N	\N	\N	\N
38	food	4	61	1	3	2	2	1	\N	\N	\N	\N
39	wood	5	4	5	38	50	18	13	\N	\N	\N	\N
40	iron	5	32	5	38	50	18	13	\N	\N	\N	\N
41	wood	5	41	5	38	50	18	13	\N	\N	\N	\N
42	iron	5	51	5	38	50	18	13	\N	\N	\N	\N
43	stone	5	61	3	10	8	3	2	\N	\N	\N	\N
44	stone	6	14	1	3	2	2	1	\N	\N	\N	\N
45	stone	6	15	3	10	8	3	2	\N	\N	\N	\N
46	wood	6	25	5	38	50	18	13	\N	\N	\N	\N
47	wood	6	45	1	3	2	2	1	\N	\N	\N	\N
48	food	6	46	4	20	20	5	5	\N	\N	\N	\N
49	food	6	53	5	38	50	18	13	\N	\N	\N	\N
50	iron	6	81	5	38	50	18	13	\N	\N	\N	\N
51	food	7	35	2	3	2	2	2	\N	\N	\N	\N
52	wood	7	45	1	3	2	2	1	\N	\N	\N	\N
53	stone	7	76	2	3	2	2	2	\N	\N	\N	\N
54	stone	7	82	5	38	50	18	13	\N	\N	\N	\N
55	stone	7	86	4	20	20	5	5	\N	\N	\N	\N
56	food	7	89	3	10	8	3	2	\N	\N	\N	\N
57	wood	7	97	1	3	2	2	1	\N	\N	\N	\N
58	wood	8	5	3	10	8	3	2	\N	\N	\N	\N
59	iron	8	7	1	3	2	2	1	\N	\N	\N	\N
60	wood	8	10	2	3	2	2	2	\N	\N	\N	\N
61	food	8	15	3	10	8	3	2	\N	\N	\N	\N
62	wood	8	37	5	38	50	18	13	\N	\N	\N	\N
63	wood	8	41	5	38	50	18	13	\N	\N	\N	\N
64	wood	8	52	3	10	8	3	2	\N	\N	\N	\N
65	stone	8	57	3	10	8	3	2	\N	\N	\N	\N
66	stone	8	70	4	20	20	5	5	\N	\N	\N	\N
67	stone	8	81	4	20	20	5	5	\N	\N	\N	\N
68	iron	8	88	2	3	2	2	2	\N	\N	\N	\N
69	iron	8	91	1	3	2	2	1	\N	\N	\N	\N
70	food	8	95	2	3	2	2	2	\N	\N	\N	\N
71	food	8	97	5	38	50	18	13	\N	\N	\N	\N
72	food	8	99	1	3	2	2	1	\N	\N	\N	\N
73	stone	9	6	3	10	8	3	2	\N	\N	\N	\N
74	iron	9	11	2	3	2	2	2	\N	\N	\N	\N
75	stone	9	32	2	3	2	2	2	\N	\N	\N	\N
76	iron	9	46	5	38	50	18	13	\N	\N	\N	\N
77	iron	9	80	3	10	8	3	2	\N	\N	\N	\N
78	stone	10	0	1	3	2	2	1	\N	\N	\N	\N
79	iron	10	14	4	20	20	5	5	\N	\N	\N	\N
80	food	10	25	3	10	8	3	2	\N	\N	\N	\N
81	food	10	49	2	3	2	2	2	\N	\N	\N	\N
82	food	10	80	4	20	20	5	5	\N	\N	\N	\N
83	food	11	0	5	38	50	18	13	\N	\N	\N	\N
84	stone	11	11	1	3	2	2	1	\N	\N	\N	\N
85	food	11	55	4	20	20	5	5	\N	\N	\N	\N
86	stone	11	64	2	3	2	2	2	\N	\N	\N	\N
87	stone	11	69	3	10	8	3	2	\N	\N	\N	\N
88	stone	11	81	5	38	50	18	13	\N	\N	\N	\N
89	iron	11	94	5	38	50	18	13	\N	\N	\N	\N
90	wood	11	97	4	20	20	5	5	\N	\N	\N	\N
91	stone	11	98	1	3	2	2	1	\N	\N	\N	\N
92	stone	12	14	2	3	2	2	2	\N	\N	\N	\N
93	iron	12	41	2	3	2	2	2	\N	\N	\N	\N
94	iron	12	79	5	38	50	18	13	\N	\N	\N	\N
95	iron	13	3	2	3	2	2	2	\N	\N	\N	\N
96	wood	13	23	5	38	50	18	13	\N	\N	\N	\N
97	food	13	41	1	3	2	2	1	\N	\N	\N	\N
98	food	13	48	5	38	50	18	13	\N	\N	\N	\N
99	stone	13	53	1	3	2	2	1	\N	\N	\N	\N
100	food	13	66	2	3	2	2	2	\N	\N	\N	\N
101	stone	13	78	2	3	2	2	2	\N	\N	\N	\N
102	wood	13	82	2	3	2	2	2	\N	\N	\N	\N
103	iron	13	89	4	20	20	5	5	\N	\N	\N	\N
104	food	13	95	5	38	50	18	13	\N	\N	\N	\N
105	food	14	1	5	38	50	18	13	\N	\N	\N	\N
106	iron	14	7	3	10	8	3	2	\N	\N	\N	\N
107	wood	14	8	1	3	2	2	1	\N	\N	\N	\N
108	food	14	11	4	20	20	5	5	\N	\N	\N	\N
109	food	14	12	5	38	50	18	13	\N	\N	\N	\N
110	food	14	14	3	10	8	3	2	\N	\N	\N	\N
111	food	14	20	3	10	8	3	2	\N	\N	\N	\N
112	wood	14	37	5	38	50	18	13	\N	\N	\N	\N
113	wood	14	43	4	20	20	5	5	\N	\N	\N	\N
114	iron	14	52	2	3	2	2	2	\N	\N	\N	\N
115	wood	14	81	3	10	8	3	2	\N	\N	\N	\N
116	iron	15	0	3	10	8	3	2	\N	\N	\N	\N
117	wood	15	3	3	10	8	3	2	\N	\N	\N	\N
118	iron	15	12	4	20	20	5	5	\N	\N	\N	\N
119	iron	15	23	2	3	2	2	2	\N	\N	\N	\N
120	stone	15	27	2	3	2	2	2	\N	\N	\N	\N
121	wood	15	28	1	3	2	2	1	\N	\N	\N	\N
122	stone	15	31	2	3	2	2	2	\N	\N	\N	\N
123	wood	15	33	5	38	50	18	13	\N	\N	\N	\N
124	stone	15	74	3	10	8	3	2	\N	\N	\N	\N
125	iron	15	78	1	3	2	2	1	\N	\N	\N	\N
126	stone	15	84	2	3	2	2	2	\N	\N	\N	\N
127	food	15	88	3	10	8	3	2	\N	\N	\N	\N
128	iron	16	2	2	3	2	2	2	\N	\N	\N	\N
129	iron	16	5	4	20	20	5	5	\N	\N	\N	\N
130	iron	16	6	4	20	20	5	5	\N	\N	\N	\N
131	iron	16	19	3	10	8	3	2	\N	\N	\N	\N
132	food	16	65	5	38	50	18	13	\N	\N	\N	\N
133	iron	16	66	4	20	20	5	5	\N	\N	\N	\N
134	iron	16	90	2	3	2	2	2	\N	\N	\N	\N
135	stone	16	96	4	20	20	5	5	\N	\N	\N	\N
136	wood	16	98	1	3	2	2	1	\N	\N	\N	\N
137	iron	17	6	3	10	8	3	2	\N	\N	\N	\N
138	iron	17	10	3	10	8	3	2	\N	\N	\N	\N
139	stone	17	19	2	3	2	2	2	\N	\N	\N	\N
140	food	17	21	5	38	50	18	13	\N	\N	\N	\N
141	food	17	24	5	38	50	18	13	\N	\N	\N	\N
142	stone	17	39	5	38	50	18	13	\N	\N	\N	\N
143	iron	17	40	3	10	8	3	2	\N	\N	\N	\N
144	iron	17	48	2	3	2	2	2	\N	\N	\N	\N
145	stone	17	66	5	38	50	18	13	\N	\N	\N	\N
146	food	17	70	3	10	8	3	2	\N	\N	\N	\N
147	wood	17	81	1	3	2	2	1	\N	\N	\N	\N
148	iron	18	2	3	10	8	3	2	\N	\N	\N	\N
149	food	18	16	4	20	20	5	5	\N	\N	\N	\N
150	iron	18	29	5	38	50	18	13	\N	\N	\N	\N
151	wood	18	40	2	3	2	2	2	\N	\N	\N	\N
152	iron	18	57	1	3	2	2	1	\N	\N	\N	\N
153	wood	18	69	5	38	50	18	13	\N	\N	\N	\N
154	stone	18	94	1	3	2	2	1	\N	\N	\N	\N
155	food	18	98	2	3	2	2	2	\N	\N	\N	\N
156	wood	19	6	2	3	2	2	2	\N	\N	\N	\N
157	stone	19	42	1	3	2	2	1	\N	\N	\N	\N
158	stone	19	93	3	10	8	3	2	\N	\N	\N	\N
159	iron	19	95	3	10	8	3	2	\N	\N	\N	\N
160	wood	20	3	3	10	8	3	2	\N	\N	\N	\N
161	food	20	4	4	20	20	5	5	\N	\N	\N	\N
162	iron	20	10	5	38	50	18	13	\N	\N	\N	\N
163	food	20	18	4	20	20	5	5	\N	\N	\N	\N
164	wood	20	22	4	20	20	5	5	\N	\N	\N	\N
165	wood	20	29	2	3	2	2	2	\N	\N	\N	\N
166	wood	20	43	5	38	50	18	13	\N	\N	\N	\N
167	iron	20	45	4	20	20	5	5	\N	\N	\N	\N
168	wood	20	52	4	20	20	5	5	\N	\N	\N	\N
169	food	20	57	3	10	8	3	2	\N	\N	\N	\N
170	iron	20	67	4	20	20	5	5	\N	\N	\N	\N
171	stone	20	91	4	20	20	5	5	\N	\N	\N	\N
172	wood	21	4	1	3	2	2	1	\N	\N	\N	\N
173	stone	21	21	2	3	2	2	2	\N	\N	\N	\N
174	wood	21	28	3	10	8	3	2	\N	\N	\N	\N
175	food	21	34	1	3	2	2	1	\N	\N	\N	\N
176	iron	21	56	3	10	8	3	2	\N	\N	\N	\N
177	iron	21	57	3	10	8	3	2	\N	\N	\N	\N
178	stone	21	64	3	10	8	3	2	\N	\N	\N	\N
179	food	21	71	4	20	20	5	5	\N	\N	\N	\N
180	wood	21	72	2	3	2	2	2	\N	\N	\N	\N
181	food	21	81	1	3	2	2	1	\N	\N	\N	\N
182	wood	21	87	1	3	2	2	1	\N	\N	\N	\N
183	wood	21	89	3	10	8	3	2	\N	\N	\N	\N
184	wood	21	90	5	38	50	18	13	\N	\N	\N	\N
185	stone	22	9	3	10	8	3	2	\N	\N	\N	\N
186	wood	22	12	3	10	8	3	2	\N	\N	\N	\N
187	wood	22	21	4	20	20	5	5	\N	\N	\N	\N
188	stone	22	35	1	3	2	2	1	\N	\N	\N	\N
189	food	22	41	2	3	2	2	2	\N	\N	\N	\N
190	food	22	54	1	3	2	2	1	\N	\N	\N	\N
191	iron	22	63	1	3	2	2	1	\N	\N	\N	\N
192	food	22	65	3	10	8	3	2	\N	\N	\N	\N
193	food	22	66	5	38	50	18	13	\N	\N	\N	\N
194	stone	22	78	3	10	8	3	2	\N	\N	\N	\N
195	iron	22	91	4	20	20	5	5	\N	\N	\N	\N
196	stone	22	94	5	38	50	18	13	\N	\N	\N	\N
197	wood	23	5	5	38	50	18	13	\N	\N	\N	\N
198	food	23	23	5	38	50	18	13	\N	\N	\N	\N
199	iron	23	32	3	10	8	3	2	\N	\N	\N	\N
200	stone	23	35	2	3	2	2	2	\N	\N	\N	\N
201	wood	23	39	5	38	50	18	13	\N	\N	\N	\N
202	wood	23	89	2	3	2	2	2	\N	\N	\N	\N
203	food	23	92	5	38	50	18	13	\N	\N	\N	\N
204	wood	24	3	5	38	50	18	13	\N	\N	\N	\N
205	wood	24	39	5	38	50	18	13	\N	\N	\N	\N
206	food	24	48	3	10	8	3	2	\N	\N	\N	\N
207	wood	24	60	4	20	20	5	5	\N	\N	\N	\N
208	stone	24	61	2	3	2	2	2	\N	\N	\N	\N
209	food	24	67	1	3	2	2	1	\N	\N	\N	\N
210	stone	24	71	2	3	2	2	2	\N	\N	\N	\N
211	iron	24	73	2	3	2	2	2	\N	\N	\N	\N
212	wood	24	74	3	10	8	3	2	\N	\N	\N	\N
213	stone	24	87	5	38	50	18	13	\N	\N	\N	\N
214	stone	24	94	2	3	2	2	2	\N	\N	\N	\N
215	iron	25	2	5	38	50	18	13	\N	\N	\N	\N
216	iron	25	4	2	3	2	2	2	\N	\N	\N	\N
217	iron	25	64	4	20	20	5	5	\N	\N	\N	\N
218	stone	25	68	2	3	2	2	2	\N	\N	\N	\N
219	food	25	83	2	3	2	2	2	\N	\N	\N	\N
220	food	25	99	3	10	8	3	2	\N	\N	\N	\N
221	food	26	1	3	10	8	3	2	\N	\N	\N	\N
222	food	26	2	5	38	50	18	13	\N	\N	\N	\N
223	wood	26	6	3	10	8	3	2	\N	\N	\N	\N
224	wood	26	8	5	38	50	18	13	\N	\N	\N	\N
225	food	26	29	3	10	8	3	2	\N	\N	\N	\N
226	wood	26	40	4	20	20	5	5	\N	\N	\N	\N
227	stone	26	41	1	3	2	2	1	\N	\N	\N	\N
228	wood	26	82	2	3	2	2	2	\N	\N	\N	\N
229	food	27	1	2	3	2	2	2	\N	\N	\N	\N
230	wood	27	5	5	38	50	18	13	\N	\N	\N	\N
231	wood	27	18	2	3	2	2	2	\N	\N	\N	\N
232	food	27	36	5	38	50	18	13	\N	\N	\N	\N
233	food	27	37	4	20	20	5	5	\N	\N	\N	\N
234	stone	27	64	3	10	8	3	2	\N	\N	\N	\N
235	food	28	10	3	10	8	3	2	\N	\N	\N	\N
236	wood	28	24	3	10	8	3	2	\N	\N	\N	\N
237	wood	28	35	5	38	50	18	13	\N	\N	\N	\N
238	stone	28	75	2	3	2	2	2	\N	\N	\N	\N
239	wood	28	94	4	20	20	5	5	\N	\N	\N	\N
240	food	28	99	3	10	8	3	2	\N	\N	\N	\N
241	stone	29	5	4	20	20	5	5	\N	\N	\N	\N
242	iron	29	7	4	20	20	5	5	\N	\N	\N	\N
243	wood	29	10	3	10	8	3	2	\N	\N	\N	\N
244	stone	29	24	3	10	8	3	2	\N	\N	\N	\N
245	iron	29	25	3	10	8	3	2	\N	\N	\N	\N
246	iron	29	31	2	3	2	2	2	\N	\N	\N	\N
247	food	29	66	1	3	2	2	1	\N	\N	\N	\N
248	wood	29	71	5	38	50	18	13	\N	\N	\N	\N
249	food	29	97	4	20	20	5	5	\N	\N	\N	\N
250	iron	29	98	5	38	50	18	13	\N	\N	\N	\N
251	stone	30	0	3	10	8	3	2	\N	\N	\N	\N
252	iron	30	2	4	20	20	5	5	\N	\N	\N	\N
253	food	30	7	3	10	8	3	2	\N	\N	\N	\N
254	food	30	9	3	10	8	3	2	\N	\N	\N	\N
255	stone	30	14	4	20	20	5	5	\N	\N	\N	\N
256	wood	30	17	5	38	50	18	13	\N	\N	\N	\N
257	wood	30	35	5	38	50	18	13	\N	\N	\N	\N
258	wood	30	51	3	10	8	3	2	\N	\N	\N	\N
259	stone	30	70	4	20	20	5	5	\N	\N	\N	\N
260	food	31	7	4	20	20	5	5	\N	\N	\N	\N
261	iron	31	55	4	20	20	5	5	\N	\N	\N	\N
262	wood	31	85	1	3	2	2	1	\N	\N	\N	\N
263	food	32	48	4	20	20	5	5	\N	\N	\N	\N
264	wood	32	51	5	38	50	18	13	\N	\N	\N	\N
265	iron	32	60	5	38	50	18	13	\N	\N	\N	\N
266	iron	32	83	5	38	50	18	13	\N	\N	\N	\N
267	food	32	92	3	10	8	3	2	\N	\N	\N	\N
268	food	32	94	5	38	50	18	13	\N	\N	\N	\N
269	iron	33	15	2	3	2	2	2	\N	\N	\N	\N
270	wood	33	22	1	3	2	2	1	\N	\N	\N	\N
271	iron	33	47	1	3	2	2	1	\N	\N	\N	\N
272	food	33	52	3	10	8	3	2	\N	\N	\N	\N
273	food	33	63	5	38	50	18	13	\N	\N	\N	\N
274	food	33	68	5	38	50	18	13	\N	\N	\N	\N
275	iron	33	93	5	38	50	18	13	\N	\N	\N	\N
276	wood	34	3	5	38	50	18	13	\N	\N	\N	\N
277	stone	34	4	1	3	2	2	1	\N	\N	\N	\N
278	stone	34	35	5	38	50	18	13	\N	\N	\N	\N
279	food	34	36	3	10	8	3	2	\N	\N	\N	\N
280	wood	34	38	5	38	50	18	13	\N	\N	\N	\N
281	food	34	47	5	38	50	18	13	\N	\N	\N	\N
282	iron	34	50	3	10	8	3	2	\N	\N	\N	\N
283	food	34	52	1	3	2	2	1	\N	\N	\N	\N
284	iron	34	60	3	10	8	3	2	\N	\N	\N	\N
285	stone	34	68	1	3	2	2	1	\N	\N	\N	\N
286	stone	34	82	3	10	8	3	2	\N	\N	\N	\N
287	stone	34	93	5	38	50	18	13	\N	\N	\N	\N
288	food	34	94	5	38	50	18	13	\N	\N	\N	\N
289	stone	34	95	4	20	20	5	5	\N	\N	\N	\N
290	iron	35	4	4	20	20	5	5	\N	\N	\N	\N
291	wood	35	10	5	38	50	18	13	\N	\N	\N	\N
292	food	35	17	1	3	2	2	1	\N	\N	\N	\N
293	wood	35	22	1	3	2	2	1	\N	\N	\N	\N
294	food	35	56	5	38	50	18	13	\N	\N	\N	\N
295	iron	35	62	4	20	20	5	5	\N	\N	\N	\N
296	iron	35	80	2	3	2	2	2	\N	\N	\N	\N
297	iron	35	88	4	20	20	5	5	\N	\N	\N	\N
298	stone	36	2	2	3	2	2	2	\N	\N	\N	\N
299	iron	36	13	2	3	2	2	2	\N	\N	\N	\N
300	food	36	29	3	10	8	3	2	\N	\N	\N	\N
301	food	36	47	3	10	8	3	2	\N	\N	\N	\N
302	iron	36	53	2	3	2	2	2	\N	\N	\N	\N
303	food	36	71	3	10	8	3	2	\N	\N	\N	\N
304	stone	36	75	5	38	50	18	13	\N	\N	\N	\N
305	stone	37	22	5	38	50	18	13	\N	\N	\N	\N
306	wood	37	25	2	3	2	2	2	\N	\N	\N	\N
307	stone	37	66	5	38	50	18	13	\N	\N	\N	\N
308	wood	37	84	1	3	2	2	1	\N	\N	\N	\N
309	wood	38	8	1	3	2	2	1	\N	\N	\N	\N
310	food	38	17	5	38	50	18	13	\N	\N	\N	\N
311	wood	38	18	1	3	2	2	1	\N	\N	\N	\N
312	stone	38	19	4	20	20	5	5	\N	\N	\N	\N
313	iron	38	23	5	38	50	18	13	\N	\N	\N	\N
314	iron	38	45	2	3	2	2	2	\N	\N	\N	\N
315	stone	38	63	1	3	2	2	1	\N	\N	\N	\N
316	iron	38	79	1	3	2	2	1	\N	\N	\N	\N
317	wood	38	98	1	3	2	2	1	\N	\N	\N	\N
318	wood	39	8	3	10	8	3	2	\N	\N	\N	\N
319	food	39	49	1	3	2	2	1	\N	\N	\N	\N
320	wood	39	52	2	3	2	2	2	\N	\N	\N	\N
321	stone	39	63	2	3	2	2	2	\N	\N	\N	\N
322	wood	39	69	2	3	2	2	2	\N	\N	\N	\N
323	wood	39	76	1	3	2	2	1	\N	\N	\N	\N
324	stone	39	82	4	20	20	5	5	\N	\N	\N	\N
325	wood	39	98	2	3	2	2	2	\N	\N	\N	\N
326	wood	40	12	3	10	8	3	2	\N	\N	\N	\N
327	food	40	25	2	3	2	2	2	\N	\N	\N	\N
328	food	40	47	5	38	50	18	13	\N	\N	\N	\N
329	stone	40	56	2	3	2	2	2	\N	\N	\N	\N
330	wood	40	58	3	10	8	3	2	\N	\N	\N	\N
331	food	40	69	1	3	2	2	1	\N	\N	\N	\N
332	stone	40	72	4	20	20	5	5	\N	\N	\N	\N
333	food	40	82	2	3	2	2	2	\N	\N	\N	\N
334	iron	41	19	3	10	8	3	2	\N	\N	\N	\N
335	stone	41	26	2	3	2	2	2	\N	\N	\N	\N
336	iron	41	27	2	3	2	2	2	\N	\N	\N	\N
337	wood	41	29	5	38	50	18	13	\N	\N	\N	\N
338	stone	41	64	3	10	8	3	2	\N	\N	\N	\N
339	wood	41	70	2	3	2	2	2	\N	\N	\N	\N
340	wood	41	74	4	20	20	5	5	\N	\N	\N	\N
341	wood	41	82	4	20	20	5	5	\N	\N	\N	\N
342	iron	41	87	1	3	2	2	1	\N	\N	\N	\N
343	stone	41	92	3	10	8	3	2	\N	\N	\N	\N
344	stone	41	94	1	3	2	2	1	\N	\N	\N	\N
345	food	41	96	3	10	8	3	2	\N	\N	\N	\N
346	food	42	13	5	38	50	18	13	\N	\N	\N	\N
347	iron	42	23	5	38	50	18	13	\N	\N	\N	\N
348	iron	42	30	1	3	2	2	1	\N	\N	\N	\N
349	wood	42	32	5	38	50	18	13	\N	\N	\N	\N
350	wood	42	34	4	20	20	5	5	\N	\N	\N	\N
351	food	42	52	5	38	50	18	13	\N	\N	\N	\N
352	wood	42	56	4	20	20	5	5	\N	\N	\N	\N
353	wood	42	58	5	38	50	18	13	\N	\N	\N	\N
354	stone	42	63	2	3	2	2	2	\N	\N	\N	\N
355	food	42	79	4	20	20	5	5	\N	\N	\N	\N
356	wood	42	89	4	20	20	5	5	\N	\N	\N	\N
357	stone	42	96	3	10	8	3	2	\N	\N	\N	\N
358	iron	43	13	2	3	2	2	2	\N	\N	\N	\N
359	food	43	25	2	3	2	2	2	\N	\N	\N	\N
360	iron	43	29	3	10	8	3	2	\N	\N	\N	\N
361	stone	43	30	1	3	2	2	1	\N	\N	\N	\N
362	stone	43	38	5	38	50	18	13	\N	\N	\N	\N
363	food	43	57	4	20	20	5	5	\N	\N	\N	\N
364	food	43	58	3	10	8	3	2	\N	\N	\N	\N
365	food	43	63	5	38	50	18	13	\N	\N	\N	\N
366	food	43	69	3	10	8	3	2	\N	\N	\N	\N
367	food	43	74	2	3	2	2	2	\N	\N	\N	\N
368	wood	43	81	1	3	2	2	1	\N	\N	\N	\N
369	wood	43	91	2	3	2	2	2	\N	\N	\N	\N
370	iron	44	3	1	3	2	2	1	\N	\N	\N	\N
371	wood	44	7	5	38	50	18	13	\N	\N	\N	\N
372	food	44	12	4	20	20	5	5	\N	\N	\N	\N
373	iron	44	30	1	3	2	2	1	\N	\N	\N	\N
374	food	44	35	3	10	8	3	2	\N	\N	\N	\N
375	wood	44	77	1	3	2	2	1	\N	\N	\N	\N
376	iron	45	12	1	3	2	2	1	\N	\N	\N	\N
377	wood	45	15	4	20	20	5	5	\N	\N	\N	\N
378	wood	45	24	3	10	8	3	2	\N	\N	\N	\N
379	wood	45	75	1	3	2	2	1	\N	\N	\N	\N
380	stone	45	84	1	3	2	2	1	\N	\N	\N	\N
381	iron	45	91	1	3	2	2	1	\N	\N	\N	\N
382	iron	45	95	2	3	2	2	2	\N	\N	\N	\N
383	stone	46	9	4	20	20	5	5	\N	\N	\N	\N
384	iron	46	46	3	10	8	3	2	\N	\N	\N	\N
385	food	46	50	1	3	2	2	1	\N	\N	\N	\N
386	food	46	65	1	3	2	2	1	\N	\N	\N	\N
387	stone	46	74	5	38	50	18	13	\N	\N	\N	\N
388	stone	46	77	2	3	2	2	2	\N	\N	\N	\N
389	wood	46	79	5	38	50	18	13	\N	\N	\N	\N
390	wood	46	85	2	3	2	2	2	\N	\N	\N	\N
391	iron	47	0	5	38	50	18	13	\N	\N	\N	\N
392	wood	47	23	5	38	50	18	13	\N	\N	\N	\N
393	stone	47	33	3	10	8	3	2	\N	\N	\N	\N
394	iron	47	36	1	3	2	2	1	\N	\N	\N	\N
395	wood	47	51	4	20	20	5	5	\N	\N	\N	\N
396	stone	47	82	1	3	2	2	1	\N	\N	\N	\N
397	stone	47	85	4	20	20	5	5	\N	\N	\N	\N
398	iron	48	3	5	38	50	18	13	\N	\N	\N	\N
399	wood	48	60	1	3	2	2	1	\N	\N	\N	\N
400	food	48	82	5	38	50	18	13	\N	\N	\N	\N
401	iron	48	87	5	38	50	18	13	\N	\N	\N	\N
402	food	48	91	4	20	20	5	5	\N	\N	\N	\N
403	iron	49	7	3	10	8	3	2	\N	\N	\N	\N
404	wood	49	12	4	20	20	5	5	\N	\N	\N	\N
405	stone	49	13	1	3	2	2	1	\N	\N	\N	\N
406	stone	49	14	4	20	20	5	5	\N	\N	\N	\N
407	iron	49	31	1	3	2	2	1	\N	\N	\N	\N
408	stone	49	33	2	3	2	2	2	\N	\N	\N	\N
409	food	49	61	5	38	50	18	13	\N	\N	\N	\N
410	iron	49	64	4	20	20	5	5	\N	\N	\N	\N
411	iron	49	73	5	38	50	18	13	\N	\N	\N	\N
412	food	49	76	4	20	20	5	5	\N	\N	\N	\N
413	iron	49	78	1	3	2	2	1	\N	\N	\N	\N
414	food	49	88	2	3	2	2	2	\N	\N	\N	\N
415	wood	50	4	2	3	2	2	2	\N	\N	\N	\N
416	wood	50	16	1	3	2	2	1	\N	\N	\N	\N
417	stone	50	21	4	20	20	5	5	\N	\N	\N	\N
418	iron	50	25	1	3	2	2	1	\N	\N	\N	\N
419	iron	50	33	2	3	2	2	2	\N	\N	\N	\N
420	food	50	40	2	3	2	2	2	\N	\N	\N	\N
421	wood	50	54	2	3	2	2	2	\N	\N	\N	\N
422	iron	51	1	1	3	2	2	1	\N	\N	\N	\N
423	stone	51	7	3	10	8	3	2	\N	\N	\N	\N
424	stone	51	8	4	20	20	5	5	\N	\N	\N	\N
425	wood	51	33	2	3	2	2	2	\N	\N	\N	\N
426	wood	51	34	4	20	20	5	5	\N	\N	\N	\N
427	iron	51	35	5	38	50	18	13	\N	\N	\N	\N
428	stone	51	37	4	20	20	5	5	\N	\N	\N	\N
429	food	51	44	2	3	2	2	2	\N	\N	\N	\N
430	wood	51	57	1	3	2	2	1	\N	\N	\N	\N
431	food	51	67	4	20	20	5	5	\N	\N	\N	\N
432	food	51	95	5	38	50	18	13	\N	\N	\N	\N
433	food	52	4	5	38	50	18	13	\N	\N	\N	\N
434	wood	52	18	1	3	2	2	1	\N	\N	\N	\N
435	food	52	23	1	3	2	2	1	\N	\N	\N	\N
436	wood	52	40	1	3	2	2	1	\N	\N	\N	\N
437	iron	52	83	4	20	20	5	5	\N	\N	\N	\N
438	food	53	18	1	3	2	2	1	\N	\N	\N	\N
439	iron	53	20	4	20	20	5	5	\N	\N	\N	\N
440	iron	53	28	5	38	50	18	13	\N	\N	\N	\N
441	iron	53	35	3	10	8	3	2	\N	\N	\N	\N
442	wood	53	65	4	20	20	5	5	\N	\N	\N	\N
443	food	53	75	3	10	8	3	2	\N	\N	\N	\N
444	stone	53	89	3	10	8	3	2	\N	\N	\N	\N
445	stone	54	34	5	38	50	18	13	\N	\N	\N	\N
446	food	54	57	3	10	8	3	2	\N	\N	\N	\N
447	food	54	88	1	3	2	2	1	\N	\N	\N	\N
448	food	54	98	4	20	20	5	5	\N	\N	\N	\N
449	wood	55	11	2	3	2	2	2	\N	\N	\N	\N
450	iron	55	17	5	38	50	18	13	\N	\N	\N	\N
451	iron	55	27	3	10	8	3	2	\N	\N	\N	\N
452	iron	55	44	5	38	50	18	13	\N	\N	\N	\N
453	iron	55	45	2	3	2	2	2	\N	\N	\N	\N
454	iron	55	63	3	10	8	3	2	\N	\N	\N	\N
455	iron	55	71	2	3	2	2	2	\N	\N	\N	\N
456	food	55	83	4	20	20	5	5	\N	\N	\N	\N
457	stone	55	89	4	20	20	5	5	\N	\N	\N	\N
458	wood	56	22	2	3	2	2	2	\N	\N	\N	\N
459	food	56	39	1	3	2	2	1	\N	\N	\N	\N
460	iron	56	42	2	3	2	2	2	\N	\N	\N	\N
461	food	56	69	4	20	20	5	5	\N	\N	\N	\N
462	food	56	84	1	3	2	2	1	\N	\N	\N	\N
463	iron	56	93	2	3	2	2	2	\N	\N	\N	\N
464	food	57	34	4	20	20	5	5	\N	\N	\N	\N
465	wood	57	36	2	3	2	2	2	\N	\N	\N	\N
466	food	57	47	1	3	2	2	1	\N	\N	\N	\N
467	wood	57	52	4	20	20	5	5	\N	\N	\N	\N
468	food	57	80	2	3	2	2	2	\N	\N	\N	\N
469	iron	57	88	1	3	2	2	1	\N	\N	\N	\N
470	iron	57	98	3	10	8	3	2	\N	\N	\N	\N
471	food	58	6	1	3	2	2	1	\N	\N	\N	\N
472	food	58	12	1	3	2	2	1	\N	\N	\N	\N
473	stone	58	14	2	3	2	2	2	\N	\N	\N	\N
474	iron	58	33	2	3	2	2	2	\N	\N	\N	\N
475	stone	58	45	4	20	20	5	5	\N	\N	\N	\N
476	wood	58	46	4	20	20	5	5	\N	\N	\N	\N
477	wood	58	54	2	3	2	2	2	\N	\N	\N	\N
478	iron	58	59	3	10	8	3	2	\N	\N	\N	\N
479	stone	58	60	3	10	8	3	2	\N	\N	\N	\N
480	wood	58	63	4	20	20	5	5	\N	\N	\N	\N
481	wood	58	72	3	10	8	3	2	\N	\N	\N	\N
482	iron	58	73	5	38	50	18	13	\N	\N	\N	\N
483	iron	58	82	4	20	20	5	5	\N	\N	\N	\N
484	iron	59	1	1	3	2	2	1	\N	\N	\N	\N
485	wood	59	16	4	20	20	5	5	\N	\N	\N	\N
486	wood	59	29	3	10	8	3	2	\N	\N	\N	\N
487	food	59	41	4	20	20	5	5	\N	\N	\N	\N
488	food	59	45	3	10	8	3	2	\N	\N	\N	\N
489	wood	59	71	3	10	8	3	2	\N	\N	\N	\N
490	stone	59	76	1	3	2	2	1	\N	\N	\N	\N
491	wood	59	92	3	10	8	3	2	\N	\N	\N	\N
492	iron	59	95	2	3	2	2	2	\N	\N	\N	\N
493	food	60	7	5	38	50	18	13	\N	\N	\N	\N
494	food	60	35	1	3	2	2	1	\N	\N	\N	\N
495	wood	60	38	1	3	2	2	1	\N	\N	\N	\N
496	wood	60	73	5	38	50	18	13	\N	\N	\N	\N
497	stone	61	6	2	3	2	2	2	\N	\N	\N	\N
498	stone	61	9	2	3	2	2	2	\N	\N	\N	\N
499	stone	61	15	3	10	8	3	2	\N	\N	\N	\N
500	stone	61	43	3	10	8	3	2	\N	\N	\N	\N
501	wood	61	45	3	10	8	3	2	\N	\N	\N	\N
502	food	61	65	1	3	2	2	1	\N	\N	\N	\N
503	iron	61	74	2	3	2	2	2	\N	\N	\N	\N
504	stone	62	8	1	3	2	2	1	\N	\N	\N	\N
505	stone	62	9	4	20	20	5	5	\N	\N	\N	\N
506	stone	62	20	1	3	2	2	1	\N	\N	\N	\N
507	wood	62	43	3	10	8	3	2	\N	\N	\N	\N
509	food	62	92	4	20	20	5	5	\N	\N	\N	\N
510	wood	63	12	5	38	50	18	13	\N	\N	\N	\N
511	iron	63	15	5	38	50	18	13	\N	\N	\N	\N
512	wood	63	21	3	10	8	3	2	\N	\N	\N	\N
513	iron	63	30	5	38	50	18	13	\N	\N	\N	\N
514	wood	63	40	4	20	20	5	5	\N	\N	\N	\N
515	iron	63	44	4	20	20	5	5	\N	\N	\N	\N
517	stone	63	53	5	38	50	18	13	\N	\N	\N	\N
518	iron	63	66	3	10	8	3	2	\N	\N	\N	\N
519	wood	63	68	2	3	2	2	2	\N	\N	\N	\N
520	food	64	28	4	20	20	5	5	\N	\N	\N	\N
521	iron	64	31	4	20	20	5	5	\N	\N	\N	\N
522	food	64	41	4	20	20	5	5	\N	\N	\N	\N
523	food	64	60	2	3	2	2	2	\N	\N	\N	\N
524	iron	64	61	3	10	8	3	2	\N	\N	\N	\N
525	wood	64	79	4	20	20	5	5	\N	\N	\N	\N
526	food	64	82	3	10	8	3	2	\N	\N	\N	\N
527	stone	64	86	3	10	8	3	2	\N	\N	\N	\N
528	food	65	0	3	10	8	3	2	\N	\N	\N	\N
529	wood	65	24	1	3	2	2	1	\N	\N	\N	\N
530	stone	65	35	1	3	2	2	1	\N	\N	\N	\N
531	wood	65	38	1	3	2	2	1	\N	\N	\N	\N
532	wood	65	53	4	20	20	5	5	\N	\N	\N	\N
533	iron	65	65	1	3	2	2	1	\N	\N	\N	\N
534	wood	65	72	5	38	50	18	13	\N	\N	\N	\N
535	food	65	75	2	3	2	2	2	\N	\N	\N	\N
536	wood	66	2	5	38	50	18	13	\N	\N	\N	\N
537	iron	66	6	4	20	20	5	5	\N	\N	\N	\N
538	food	66	16	3	10	8	3	2	\N	\N	\N	\N
539	food	66	17	1	3	2	2	1	\N	\N	\N	\N
540	iron	66	20	4	20	20	5	5	\N	\N	\N	\N
541	iron	66	30	3	10	8	3	2	\N	\N	\N	\N
542	stone	66	68	1	3	2	2	1	\N	\N	\N	\N
543	stone	66	87	3	10	8	3	2	\N	\N	\N	\N
544	iron	67	26	5	38	50	18	13	\N	\N	\N	\N
545	wood	67	67	2	3	2	2	2	\N	\N	\N	\N
546	iron	67	95	1	3	2	2	1	\N	\N	\N	\N
547	iron	68	7	2	3	2	2	2	\N	\N	\N	\N
548	wood	68	23	5	38	50	18	13	\N	\N	\N	\N
549	wood	68	45	4	20	20	5	5	\N	\N	\N	\N
550	iron	68	46	2	3	2	2	2	\N	\N	\N	\N
553	iron	68	78	3	10	8	3	2	\N	\N	\N	\N
554	food	68	96	4	20	20	5	5	\N	\N	\N	\N
555	stone	69	15	2	3	2	2	2	\N	\N	\N	\N
556	food	69	18	2	3	2	2	2	\N	\N	\N	\N
557	food	69	26	4	20	20	5	5	\N	\N	\N	\N
558	food	69	49	4	20	20	5	5	\N	\N	\N	\N
559	iron	69	72	5	38	50	18	13	\N	\N	\N	\N
560	wood	69	79	5	38	50	18	13	\N	\N	\N	\N
561	wood	69	81	2	3	2	2	2	\N	\N	\N	\N
562	stone	69	89	3	10	8	3	2	\N	\N	\N	\N
563	iron	69	90	3	10	8	3	2	\N	\N	\N	\N
564	wood	70	7	1	3	2	2	1	\N	\N	\N	\N
565	food	70	10	1	3	2	2	1	\N	\N	\N	\N
566	stone	70	16	3	10	8	3	2	\N	\N	\N	\N
567	iron	70	35	1	3	2	2	1	\N	\N	\N	\N
568	food	70	47	4	20	20	5	5	\N	\N	\N	\N
569	food	70	63	3	10	8	3	2	\N	\N	\N	\N
570	wood	70	71	2	3	2	2	2	\N	\N	\N	\N
571	stone	70	78	2	3	2	2	2	\N	\N	\N	\N
572	food	70	82	3	10	8	3	2	\N	\N	\N	\N
573	stone	70	84	2	3	2	2	2	\N	\N	\N	\N
574	iron	70	97	3	10	8	3	2	\N	\N	\N	\N
575	stone	71	20	1	3	2	2	1	\N	\N	\N	\N
576	iron	71	34	2	3	2	2	2	\N	\N	\N	\N
577	stone	71	37	3	10	8	3	2	\N	\N	\N	\N
578	wood	71	47	4	20	20	5	5	\N	\N	\N	\N
579	iron	71	58	2	3	2	2	2	\N	\N	\N	\N
580	food	71	66	2	3	2	2	2	\N	\N	\N	\N
581	stone	71	76	4	20	20	5	5	\N	\N	\N	\N
582	iron	71	80	2	3	2	2	2	\N	\N	\N	\N
583	wood	71	90	2	3	2	2	2	\N	\N	\N	\N
584	iron	72	79	5	38	50	18	13	\N	\N	\N	\N
585	food	72	93	2	3	2	2	2	\N	\N	\N	\N
586	food	73	13	5	38	50	18	13	\N	\N	\N	\N
587	stone	73	24	1	3	2	2	1	\N	\N	\N	\N
588	stone	73	26	4	20	20	5	5	\N	\N	\N	\N
589	iron	73	50	4	20	20	5	5	\N	\N	\N	\N
590	wood	73	60	2	3	2	2	2	\N	\N	\N	\N
591	stone	73	73	3	10	8	3	2	\N	\N	\N	\N
592	stone	73	85	1	3	2	2	1	\N	\N	\N	\N
593	iron	73	86	2	3	2	2	2	\N	\N	\N	\N
594	iron	74	14	1	3	2	2	1	\N	\N	\N	\N
595	iron	74	32	2	3	2	2	2	\N	\N	\N	\N
596	wood	74	75	2	3	2	2	2	\N	\N	\N	\N
597	stone	74	97	3	10	8	3	2	\N	\N	\N	\N
598	stone	75	0	4	20	20	5	5	\N	\N	\N	\N
599	stone	75	9	4	20	20	5	5	\N	\N	\N	\N
600	food	75	10	2	3	2	2	2	\N	\N	\N	\N
601	iron	75	22	2	3	2	2	2	\N	\N	\N	\N
602	iron	75	32	5	38	50	18	13	\N	\N	\N	\N
603	iron	75	46	1	3	2	2	1	\N	\N	\N	\N
604	iron	75	72	4	20	20	5	5	\N	\N	\N	\N
605	stone	75	77	4	20	20	5	5	\N	\N	\N	\N
606	food	75	96	3	10	8	3	2	\N	\N	\N	\N
607	wood	76	3	5	38	50	18	13	\N	\N	\N	\N
608	iron	76	32	4	20	20	5	5	\N	\N	\N	\N
609	iron	76	41	2	3	2	2	2	\N	\N	\N	\N
610	wood	76	53	1	3	2	2	1	\N	\N	\N	\N
611	food	76	70	4	20	20	5	5	\N	\N	\N	\N
612	food	76	72	3	10	8	3	2	\N	\N	\N	\N
613	wood	76	79	5	38	50	18	13	\N	\N	\N	\N
614	stone	76	97	4	20	20	5	5	\N	\N	\N	\N
615	iron	77	20	4	20	20	5	5	\N	\N	\N	\N
616	stone	77	89	1	3	2	2	1	\N	\N	\N	\N
617	food	78	2	4	20	20	5	5	\N	\N	\N	\N
618	food	78	21	4	20	20	5	5	\N	\N	\N	\N
619	stone	78	37	2	3	2	2	2	\N	\N	\N	\N
620	food	78	39	5	38	50	18	13	\N	\N	\N	\N
621	wood	78	42	4	20	20	5	5	\N	\N	\N	\N
622	stone	78	44	2	3	2	2	2	\N	\N	\N	\N
623	wood	78	48	2	3	2	2	2	\N	\N	\N	\N
624	food	78	61	4	20	20	5	5	\N	\N	\N	\N
625	wood	78	83	2	3	2	2	2	\N	\N	\N	\N
626	food	78	91	2	3	2	2	2	\N	\N	\N	\N
627	wood	79	4	3	10	8	3	2	\N	\N	\N	\N
628	food	79	14	4	20	20	5	5	\N	\N	\N	\N
629	iron	79	15	1	3	2	2	1	\N	\N	\N	\N
630	stone	79	22	2	3	2	2	2	\N	\N	\N	\N
631	food	79	24	1	3	2	2	1	\N	\N	\N	\N
632	food	79	30	1	3	2	2	1	\N	\N	\N	\N
633	stone	79	41	1	3	2	2	1	\N	\N	\N	\N
634	iron	79	83	5	38	50	18	13	\N	\N	\N	\N
635	iron	79	86	4	20	20	5	5	\N	\N	\N	\N
636	iron	79	88	4	20	20	5	5	\N	\N	\N	\N
637	iron	80	10	1	3	2	2	1	\N	\N	\N	\N
638	stone	80	12	1	3	2	2	1	\N	\N	\N	\N
639	iron	80	56	4	20	20	5	5	\N	\N	\N	\N
640	iron	80	68	5	38	50	18	13	\N	\N	\N	\N
641	wood	80	72	4	20	20	5	5	\N	\N	\N	\N
642	iron	80	97	2	3	2	2	2	\N	\N	\N	\N
643	wood	81	2	4	20	20	5	5	\N	\N	\N	\N
551	iron	68	55	2	0	19	19	19	11	2026-09-18 23:51:53.542722	\N	2026-09-18 23:51:53.542722
644	wood	81	14	3	10	8	3	2	\N	\N	\N	\N
645	stone	81	18	1	3	2	2	1	\N	\N	\N	\N
646	wood	81	30	3	10	8	3	2	\N	\N	\N	\N
647	food	81	32	4	20	20	5	5	\N	\N	\N	\N
648	food	81	52	2	3	2	2	2	\N	\N	\N	\N
649	iron	81	61	3	10	8	3	2	\N	\N	\N	\N
650	iron	81	70	5	38	50	18	13	\N	\N	\N	\N
651	iron	81	79	4	20	20	5	5	\N	\N	\N	\N
652	iron	81	85	4	20	20	5	5	\N	\N	\N	\N
653	wood	81	88	3	10	8	3	2	\N	\N	\N	\N
654	wood	81	99	4	20	20	5	5	\N	\N	\N	\N
655	stone	82	4	5	38	50	18	13	\N	\N	\N	\N
656	stone	82	26	3	10	8	3	2	\N	\N	\N	\N
657	iron	82	51	4	20	20	5	5	\N	\N	\N	\N
658	wood	82	90	3	10	8	3	2	\N	\N	\N	\N
659	food	83	19	2	3	2	2	2	\N	\N	\N	\N
660	food	83	21	4	20	20	5	5	\N	\N	\N	\N
661	iron	83	59	2	3	2	2	2	\N	\N	\N	\N
662	iron	83	79	2	3	2	2	2	\N	\N	\N	\N
663	iron	83	82	5	38	50	18	13	\N	\N	\N	\N
664	food	83	95	3	10	8	3	2	\N	\N	\N	\N
665	food	84	10	3	10	8	3	2	\N	\N	\N	\N
666	food	84	19	3	10	8	3	2	\N	\N	\N	\N
667	food	84	20	1	3	2	2	1	\N	\N	\N	\N
668	wood	84	35	5	38	50	18	13	\N	\N	\N	\N
669	food	84	36	3	10	8	3	2	\N	\N	\N	\N
670	stone	84	52	3	10	8	3	2	\N	\N	\N	\N
671	iron	84	54	2	3	2	2	2	\N	\N	\N	\N
672	iron	84	62	3	10	8	3	2	\N	\N	\N	\N
673	food	84	68	5	38	50	18	13	\N	\N	\N	\N
674	stone	84	70	5	38	50	18	13	\N	\N	\N	\N
675	iron	84	72	4	20	20	5	5	\N	\N	\N	\N
676	iron	84	84	3	10	8	3	2	\N	\N	\N	\N
677	stone	85	12	4	20	20	5	5	\N	\N	\N	\N
678	wood	85	16	3	10	8	3	2	\N	\N	\N	\N
679	stone	85	20	2	3	2	2	2	\N	\N	\N	\N
680	food	85	31	3	10	8	3	2	\N	\N	\N	\N
681	food	85	60	3	10	8	3	2	\N	\N	\N	\N
682	stone	85	84	2	3	2	2	2	\N	\N	\N	\N
683	food	86	0	2	3	2	2	2	\N	\N	\N	\N
684	food	86	2	3	10	8	3	2	\N	\N	\N	\N
685	wood	86	8	4	20	20	5	5	\N	\N	\N	\N
686	wood	86	72	3	10	8	3	2	\N	\N	\N	\N
687	wood	86	73	1	3	2	2	1	\N	\N	\N	\N
688	food	86	82	4	20	20	5	5	\N	\N	\N	\N
689	food	86	83	1	3	2	2	1	\N	\N	\N	\N
690	stone	86	94	1	3	2	2	1	\N	\N	\N	\N
691	food	86	97	1	3	2	2	1	\N	\N	\N	\N
692	wood	87	29	5	38	50	18	13	\N	\N	\N	\N
693	wood	87	31	4	20	20	5	5	\N	\N	\N	\N
694	wood	87	34	3	10	8	3	2	\N	\N	\N	\N
695	food	87	55	4	20	20	5	5	\N	\N	\N	\N
696	food	87	56	3	10	8	3	2	\N	\N	\N	\N
697	stone	87	80	1	3	2	2	1	\N	\N	\N	\N
698	food	87	82	3	10	8	3	2	\N	\N	\N	\N
699	stone	87	91	5	38	50	18	13	\N	\N	\N	\N
700	wood	88	1	4	20	20	5	5	\N	\N	\N	\N
701	food	88	7	3	10	8	3	2	\N	\N	\N	\N
702	food	88	10	4	20	20	5	5	\N	\N	\N	\N
703	stone	88	11	2	3	2	2	2	\N	\N	\N	\N
704	food	88	19	1	3	2	2	1	\N	\N	\N	\N
705	wood	88	21	3	10	8	3	2	\N	\N	\N	\N
706	food	88	59	5	38	50	18	13	\N	\N	\N	\N
707	stone	88	62	5	38	50	18	13	\N	\N	\N	\N
708	food	88	78	4	20	20	5	5	\N	\N	\N	\N
709	iron	88	80	3	10	8	3	2	\N	\N	\N	\N
710	iron	88	87	4	20	20	5	5	\N	\N	\N	\N
711	food	89	3	4	20	20	5	5	\N	\N	\N	\N
712	wood	89	6	3	10	8	3	2	\N	\N	\N	\N
713	food	89	19	1	3	2	2	1	\N	\N	\N	\N
714	iron	89	46	5	38	50	18	13	\N	\N	\N	\N
715	iron	89	58	5	38	50	18	13	\N	\N	\N	\N
716	stone	89	80	2	3	2	2	2	\N	\N	\N	\N
717	food	89	83	2	3	2	2	2	\N	\N	\N	\N
718	wood	89	87	5	38	50	18	13	\N	\N	\N	\N
719	wood	89	90	5	38	50	18	13	\N	\N	\N	\N
720	iron	89	94	4	20	20	5	5	\N	\N	\N	\N
721	wood	90	18	3	10	8	3	2	\N	\N	\N	\N
722	iron	90	19	1	3	2	2	1	\N	\N	\N	\N
723	stone	90	20	1	3	2	2	1	\N	\N	\N	\N
724	wood	90	27	2	3	2	2	2	\N	\N	\N	\N
725	food	90	30	5	38	50	18	13	\N	\N	\N	\N
726	wood	90	40	3	10	8	3	2	\N	\N	\N	\N
727	stone	90	42	4	20	20	5	5	\N	\N	\N	\N
728	iron	90	64	1	3	2	2	1	\N	\N	\N	\N
729	iron	90	70	5	38	50	18	13	\N	\N	\N	\N
730	wood	90	81	2	3	2	2	2	\N	\N	\N	\N
731	food	90	92	2	3	2	2	2	\N	\N	\N	\N
732	food	90	98	4	20	20	5	5	\N	\N	\N	\N
733	stone	91	0	4	20	20	5	5	\N	\N	\N	\N
734	food	91	23	5	38	50	18	13	\N	\N	\N	\N
735	food	91	41	3	10	8	3	2	\N	\N	\N	\N
736	iron	91	47	1	3	2	2	1	\N	\N	\N	\N
737	stone	91	51	2	3	2	2	2	\N	\N	\N	\N
738	wood	91	61	2	3	2	2	2	\N	\N	\N	\N
739	food	91	64	4	20	20	5	5	\N	\N	\N	\N
740	iron	91	95	3	10	8	3	2	\N	\N	\N	\N
741	wood	92	3	4	20	20	5	5	\N	\N	\N	\N
742	food	92	5	1	3	2	2	1	\N	\N	\N	\N
743	food	92	12	3	10	8	3	2	\N	\N	\N	\N
744	stone	92	31	4	20	20	5	5	\N	\N	\N	\N
745	stone	92	46	5	38	50	18	13	\N	\N	\N	\N
746	stone	92	95	1	3	2	2	1	\N	\N	\N	\N
747	food	93	13	5	38	50	18	13	\N	\N	\N	\N
748	food	93	37	3	10	8	3	2	\N	\N	\N	\N
749	food	93	41	3	10	8	3	2	\N	\N	\N	\N
750	food	93	72	1	3	2	2	1	\N	\N	\N	\N
751	food	94	4	2	3	2	2	2	\N	\N	\N	\N
752	wood	94	69	5	38	50	18	13	\N	\N	\N	\N
753	food	95	9	1	3	2	2	1	\N	\N	\N	\N
754	iron	95	12	5	38	50	18	13	\N	\N	\N	\N
755	wood	95	37	2	3	2	2	2	\N	\N	\N	\N
756	stone	95	52	5	38	50	18	13	\N	\N	\N	\N
757	stone	95	58	5	38	50	18	13	\N	\N	\N	\N
758	stone	95	64	2	3	2	2	2	\N	\N	\N	\N
759	food	95	77	2	3	2	2	2	\N	\N	\N	\N
760	iron	95	94	5	38	50	18	13	\N	\N	\N	\N
761	wood	96	0	1	3	2	2	1	\N	\N	\N	\N
762	stone	96	5	2	3	2	2	2	\N	\N	\N	\N
763	wood	96	10	4	20	20	5	5	\N	\N	\N	\N
764	wood	96	11	4	20	20	5	5	\N	\N	\N	\N
765	stone	96	14	5	38	50	18	13	\N	\N	\N	\N
766	wood	96	41	3	10	8	3	2	\N	\N	\N	\N
767	wood	96	47	3	10	8	3	2	\N	\N	\N	\N
768	wood	96	66	2	3	2	2	2	\N	\N	\N	\N
769	iron	96	77	5	38	50	18	13	\N	\N	\N	\N
770	stone	96	82	5	38	50	18	13	\N	\N	\N	\N
771	food	96	94	3	10	8	3	2	\N	\N	\N	\N
772	wood	96	96	1	3	2	2	1	\N	\N	\N	\N
773	wood	96	97	2	3	2	2	2	\N	\N	\N	\N
774	wood	97	3	3	10	8	3	2	\N	\N	\N	\N
775	food	97	34	5	38	50	18	13	\N	\N	\N	\N
776	stone	97	41	5	38	50	18	13	\N	\N	\N	\N
777	iron	97	44	5	38	50	18	13	\N	\N	\N	\N
778	food	97	55	4	20	20	5	5	\N	\N	\N	\N
779	food	97	63	2	3	2	2	2	\N	\N	\N	\N
780	iron	97	67	5	38	50	18	13	\N	\N	\N	\N
781	food	97	75	5	38	50	18	13	\N	\N	\N	\N
782	iron	97	87	4	20	20	5	5	\N	\N	\N	\N
783	iron	97	90	1	3	2	2	1	\N	\N	\N	\N
784	food	98	4	4	20	20	5	5	\N	\N	\N	\N
785	wood	98	24	2	3	2	2	2	\N	\N	\N	\N
786	iron	98	42	1	3	2	2	1	\N	\N	\N	\N
787	stone	98	44	1	3	2	2	1	\N	\N	\N	\N
788	stone	98	45	2	3	2	2	2	\N	\N	\N	\N
789	food	98	54	1	3	2	2	1	\N	\N	\N	\N
790	food	98	77	2	3	2	2	2	\N	\N	\N	\N
791	iron	98	82	5	38	50	18	13	\N	\N	\N	\N
792	stone	98	88	4	20	20	5	5	\N	\N	\N	\N
793	food	98	90	4	20	20	5	5	\N	\N	\N	\N
794	wood	99	9	1	3	2	2	1	\N	\N	\N	\N
795	food	99	19	5	38	50	18	13	\N	\N	\N	\N
796	stone	99	35	3	10	8	3	2	\N	\N	\N	\N
797	stone	99	71	4	20	20	5	5	\N	\N	\N	\N
798	stone	99	90	4	20	20	5	5	\N	\N	\N	\N
552	stone	68	56	4	20	20	5	5	\N	\N	\N	\N
508	iron	62	50	1	3	2	2	1	\N	\N	\N	\N
516	stone	63	50	1	0	0	0	0	\N	\N	\N	2026-09-18 19:55:09.48222
\.


--
-- Data for Name: world_valleys; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.world_valleys (id, name, x, y, width, depth, resource_bonus, owner_city_id, occupied_at, recall_at, hero_id, field_type, level, warrior, pikeman, swordsman, archer, cavalry, cataphract, ballista, battering_ram, catapult, scout, transporter) FROM stdin;
1	\N	0	14	\N	\N	1.00	\N	\N	\N	\N	Hill	2	5	5	4	3	3	0	0	0	0	0	0
2	\N	0	20	\N	\N	1.00	\N	\N	\N	\N	Hill	2	5	5	4	3	3	0	0	0	0	0	0
3	\N	0	38	\N	\N	1.00	\N	\N	\N	\N	Lake	1	5	4	4	2	1	0	0	0	0	0	0
4	\N	0	53	\N	\N	1.00	\N	\N	\N	\N	Lake	1	5	4	4	2	1	0	0	0	0	0	0
5	\N	0	90	\N	\N	1.00	\N	\N	\N	\N	Lake	2	5	5	4	3	3	0	0	0	0	0	0
6	\N	0	96	\N	\N	1.00	\N	\N	\N	\N	Lake	7	1200	300	75	80	75	0	0	0	0	0	0
7	\N	1	61	\N	\N	1.00	\N	\N	\N	\N	Lake	5	75	100	35	25	20	0	0	0	0	0	0
8	\N	1	98	\N	\N	1.00	\N	\N	\N	\N	Desert	9	6000	1800	200	675	250	0	0	0	0	0	0
9	\N	2	8	\N	\N	1.00	\N	\N	\N	\N	Forest	7	1200	300	75	80	75	0	0	0	0	0	0
10	\N	2	44	\N	\N	1.00	\N	\N	\N	\N	Desert	3	20	16	7	4	6	0	0	0	0	0	0
11	\N	3	0	\N	\N	1.00	\N	\N	\N	\N	Desert	2	5	5	4	3	3	0	0	0	0	0	0
12	\N	4	44	\N	\N	1.00	\N	\N	\N	\N	Desert	4	40	40	10	10	15	0	0	0	0	0	0
13	\N	4	69	\N	\N	1.00	\N	\N	\N	\N	Forest	6	400	75	55	50	45	0	0	0	0	0	0
14	\N	4	73	\N	\N	1.00	\N	\N	\N	\N	Forest	4	40	40	10	10	15	0	0	0	0	0	0
15	\N	4	96	\N	\N	1.00	\N	\N	\N	\N	Lake	1	5	4	4	2	1	0	0	0	0	0	0
16	\N	5	10	\N	\N	1.00	\N	\N	\N	\N	Forest	1	5	4	4	2	1	0	0	0	0	0	0
17	\N	5	48	\N	\N	1.00	\N	\N	\N	\N	Desert	7	1200	300	75	80	75	0	0	0	0	0	0
18	\N	6	27	\N	\N	1.00	\N	\N	\N	\N	Desert	1	5	4	4	2	1	0	0	0	0	0	0
19	\N	6	96	\N	\N	1.00	\N	\N	\N	\N	Forest	6	400	75	55	50	45	0	0	0	0	0	0
20	\N	7	99	\N	\N	1.00	\N	\N	\N	\N	Desert	8	1500	675	400	300	200	0	0	0	0	0	0
21	\N	8	32	\N	\N	1.00	\N	\N	\N	\N	Lake	9	6000	1800	200	675	250	0	0	0	0	0	0
22	\N	8	96	\N	\N	1.00	\N	\N	\N	\N	Forest	8	1500	675	400	300	200	0	0	0	0	0	0
23	\N	10	65	\N	\N	1.00	\N	\N	\N	\N	Forest	1	5	4	4	2	1	0	0	0	0	0	0
24	\N	10	89	\N	\N	1.00	\N	\N	\N	\N	Hill	5	75	100	35	25	20	0	0	0	0	0	0
25	\N	11	3	\N	\N	1.00	\N	\N	\N	\N	Lake	10	40000	0	0	0	0	0	0	0	0	0	0
26	\N	11	29	\N	\N	1.00	\N	\N	\N	\N	Lake	3	20	16	7	4	6	0	0	0	0	0	0
27	\N	11	46	\N	\N	1.00	\N	\N	\N	\N	Lake	10	40000	0	0	0	0	0	0	0	0	0	0
28	\N	12	44	\N	\N	1.00	\N	\N	\N	\N	Desert	2	5	5	4	3	3	0	0	0	0	0	0
29	\N	12	89	\N	\N	1.00	\N	\N	\N	\N	Forest	10	40000	0	0	0	0	0	0	0	0	0	0
30	\N	12	97	\N	\N	1.00	\N	\N	\N	\N	Hill	1	5	4	4	2	1	0	0	0	0	0	0
31	\N	13	17	\N	\N	1.00	\N	\N	\N	\N	Desert	8	1500	675	400	300	200	0	0	0	0	0	0
32	\N	13	24	\N	\N	1.00	\N	\N	\N	\N	Forest	1	5	4	4	2	1	0	0	0	0	0	0
33	\N	13	36	\N	\N	1.00	\N	\N	\N	\N	Hill	7	1200	300	75	80	75	0	0	0	0	0	0
34	\N	13	51	\N	\N	1.00	\N	\N	\N	\N	Lake	4	40	40	10	10	15	0	0	0	0	0	0
35	\N	14	27	\N	\N	1.00	\N	\N	\N	\N	Lake	9	6000	1800	200	675	250	0	0	0	0	0	0
36	\N	15	46	\N	\N	1.00	\N	\N	\N	\N	Forest	8	1500	675	400	300	200	0	0	0	0	0	0
37	\N	15	66	\N	\N	1.00	\N	\N	\N	\N	Desert	4	40	40	10	10	15	0	0	0	0	0	0
38	\N	16	86	\N	\N	1.00	\N	\N	\N	\N	Forest	3	20	16	7	4	6	0	0	0	0	0	0
39	\N	17	9	\N	\N	1.00	\N	\N	\N	\N	Forest	5	75	100	35	25	20	0	0	0	0	0	0
40	\N	17	11	\N	\N	1.00	\N	\N	\N	\N	Forest	2	5	5	4	3	3	0	0	0	0	0	0
41	\N	17	84	\N	\N	1.00	\N	\N	\N	\N	Desert	6	400	75	55	50	45	0	0	0	0	0	0
42	\N	19	66	\N	\N	1.00	\N	\N	\N	\N	Desert	3	20	16	7	4	6	0	0	0	0	0	0
43	\N	19	94	\N	\N	1.00	\N	\N	\N	\N	Forest	7	1200	300	75	80	75	0	0	0	0	0	0
44	\N	20	49	\N	\N	1.00	\N	\N	\N	\N	Desert	6	400	75	55	50	45	0	0	0	0	0	0
45	\N	20	63	\N	\N	1.00	\N	\N	\N	\N	Hill	10	40000	0	0	0	0	0	0	0	0	0	0
46	\N	20	76	\N	\N	1.00	\N	\N	\N	\N	Lake	7	1200	300	75	80	75	0	0	0	0	0	0
47	\N	21	52	\N	\N	1.00	\N	\N	\N	\N	Desert	2	5	5	4	3	3	0	0	0	0	0	0
48	\N	21	62	\N	\N	1.00	\N	\N	\N	\N	Hill	3	20	16	7	4	6	0	0	0	0	0	0
49	\N	23	10	\N	\N	1.00	\N	\N	\N	\N	Forest	7	1200	300	75	80	75	0	0	0	0	0	0
50	\N	24	56	\N	\N	1.00	\N	\N	\N	\N	Desert	3	20	16	7	4	6	0	0	0	0	0	0
51	\N	24	77	\N	\N	1.00	\N	\N	\N	\N	Lake	5	75	100	35	25	20	0	0	0	0	0	0
52	\N	24	82	\N	\N	1.00	\N	\N	\N	\N	Desert	3	20	16	7	4	6	0	0	0	0	0	0
53	\N	26	5	\N	\N	1.00	\N	\N	\N	\N	Desert	10	40000	0	0	0	0	0	0	0	0	0	0
54	\N	26	99	\N	\N	1.00	\N	\N	\N	\N	Lake	8	1500	675	400	300	200	0	0	0	0	0	0
55	\N	27	58	\N	\N	1.00	\N	\N	\N	\N	Desert	7	1200	300	75	80	75	0	0	0	0	0	0
56	\N	27	93	\N	\N	1.00	\N	\N	\N	\N	Forest	6	400	75	55	50	45	0	0	0	0	0	0
57	\N	27	99	\N	\N	1.00	\N	\N	\N	\N	Hill	5	75	100	35	25	20	0	0	0	0	0	0
58	\N	28	91	\N	\N	1.00	\N	\N	\N	\N	Forest	10	40000	0	0	0	0	0	0	0	0	0	0
59	\N	29	20	\N	\N	1.00	\N	\N	\N	\N	Forest	6	400	75	55	50	45	0	0	0	0	0	0
60	\N	30	18	\N	\N	1.00	\N	\N	\N	\N	Hill	4	40	40	10	10	15	0	0	0	0	0	0
61	\N	30	41	\N	\N	1.00	\N	\N	\N	\N	Lake	1	5	4	4	2	1	0	0	0	0	0	0
62	\N	30	74	\N	\N	1.00	\N	\N	\N	\N	Hill	8	1500	675	400	300	200	0	0	0	0	0	0
63	\N	30	76	\N	\N	1.00	\N	\N	\N	\N	Lake	6	400	75	55	50	45	0	0	0	0	0	0
64	\N	31	61	\N	\N	1.00	\N	\N	\N	\N	Forest	5	75	100	35	25	20	0	0	0	0	0	0
65	\N	31	88	\N	\N	1.00	\N	\N	\N	\N	Forest	3	20	16	7	4	6	0	0	0	0	0	0
66	\N	33	74	\N	\N	1.00	\N	\N	\N	\N	Hill	4	40	40	10	10	15	0	0	0	0	0	0
67	\N	34	61	\N	\N	1.00	\N	\N	\N	\N	Lake	1	5	4	4	2	1	0	0	0	0	0	0
68	\N	34	78	\N	\N	1.00	\N	\N	\N	\N	Desert	3	20	16	7	4	6	0	0	0	0	0	0
69	\N	34	97	\N	\N	1.00	\N	\N	\N	\N	Desert	9	6000	1800	200	675	250	0	0	0	0	0	0
70	\N	35	51	\N	\N	1.00	\N	\N	\N	\N	Lake	6	400	75	55	50	45	0	0	0	0	0	0
71	\N	35	55	\N	\N	1.00	\N	\N	\N	\N	Lake	6	400	75	55	50	45	0	0	0	0	0	0
72	\N	36	22	\N	\N	1.00	\N	\N	\N	\N	Forest	7	1200	300	75	80	75	0	0	0	0	0	0
73	\N	36	86	\N	\N	1.00	\N	\N	\N	\N	Lake	2	5	5	4	3	3	0	0	0	0	0	0
74	\N	36	87	\N	\N	1.00	\N	\N	\N	\N	Lake	4	40	40	10	10	15	0	0	0	0	0	0
75	\N	37	50	\N	\N	1.00	\N	\N	\N	\N	Forest	3	20	16	7	4	6	0	0	0	0	0	0
76	\N	38	77	\N	\N	1.00	\N	\N	\N	\N	Hill	8	1500	675	400	300	200	0	0	0	0	0	0
77	\N	39	31	\N	\N	1.00	\N	\N	\N	\N	Desert	3	20	16	7	4	6	0	0	0	0	0	0
78	\N	39	96	\N	\N	1.00	\N	\N	\N	\N	Desert	8	1500	675	400	300	200	0	0	0	0	0	0
79	\N	40	13	\N	\N	1.00	\N	\N	\N	\N	Desert	7	1200	300	75	80	75	0	0	0	0	0	0
80	\N	40	80	\N	\N	1.00	\N	\N	\N	\N	Hill	2	5	5	4	3	3	0	0	0	0	0	0
81	\N	40	92	\N	\N	1.00	\N	\N	\N	\N	Lake	3	20	16	7	4	6	0	0	0	0	0	0
82	\N	40	98	\N	\N	1.00	\N	\N	\N	\N	Hill	7	1200	300	75	80	75	0	0	0	0	0	0
83	\N	41	18	\N	\N	1.00	\N	\N	\N	\N	Desert	1	5	4	4	2	1	0	0	0	0	0	0
84	\N	41	98	\N	\N	1.00	\N	\N	\N	\N	Forest	2	5	5	4	3	3	0	0	0	0	0	0
85	\N	42	29	\N	\N	1.00	\N	\N	\N	\N	Desert	9	6000	1800	200	675	250	0	0	0	0	0	0
86	\N	42	67	\N	\N	1.00	\N	\N	\N	\N	Hill	10	40000	0	0	0	0	0	0	0	0	0	0
87	\N	42	68	\N	\N	1.00	\N	\N	\N	\N	Forest	2	5	5	4	3	3	0	0	0	0	0	0
88	\N	43	28	\N	\N	1.00	\N	\N	\N	\N	Lake	4	40	40	10	10	15	0	0	0	0	0	0
89	\N	43	98	\N	\N	1.00	\N	\N	\N	\N	Forest	3	20	16	7	4	6	0	0	0	0	0	0
90	\N	44	61	\N	\N	1.00	\N	\N	\N	\N	Forest	9	6000	1800	200	675	250	0	0	0	0	0	0
91	\N	44	80	\N	\N	1.00	\N	\N	\N	\N	Desert	10	40000	0	0	0	0	0	0	0	0	0	0
92	\N	45	26	\N	\N	1.00	\N	\N	\N	\N	Lake	2	5	5	4	3	3	0	0	0	0	0	0
93	\N	45	27	\N	\N	1.00	\N	\N	\N	\N	Hill	10	40000	0	0	0	0	0	0	0	0	0	0
94	\N	45	49	\N	\N	1.00	\N	\N	\N	\N	Forest	2	5	5	4	3	3	0	0	0	0	0	0
95	\N	45	88	\N	\N	1.00	\N	\N	\N	\N	Forest	6	400	75	55	50	45	0	0	0	0	0	0
96	\N	46	70	\N	\N	1.00	\N	\N	\N	\N	Lake	5	75	100	35	25	20	0	0	0	0	0	0
97	\N	47	45	\N	\N	1.00	\N	\N	\N	\N	Forest	1	5	4	4	2	1	0	0	0	0	0	0
98	\N	47	57	\N	\N	1.00	\N	\N	\N	\N	Forest	2	5	5	4	3	3	0	0	0	0	0	0
99	\N	48	42	\N	\N	1.00	\N	\N	\N	\N	Hill	9	6000	1800	200	675	250	0	0	0	0	0	0
100	\N	49	15	\N	\N	1.00	\N	\N	\N	\N	Desert	9	6000	1800	200	675	250	0	0	0	0	0	0
101	\N	49	36	\N	\N	1.00	\N	\N	\N	\N	Hill	2	5	5	4	3	3	0	0	0	0	0	0
102	\N	49	43	\N	\N	1.00	\N	\N	\N	\N	Desert	10	40000	0	0	0	0	0	0	0	0	0	0
103	\N	50	1	\N	\N	1.00	\N	\N	\N	\N	Lake	7	1200	300	75	80	75	0	0	0	0	0	0
104	\N	50	15	\N	\N	1.00	\N	\N	\N	\N	Hill	10	40000	0	0	0	0	0	0	0	0	0	0
105	\N	50	67	\N	\N	1.00	\N	\N	\N	\N	Desert	5	75	100	35	25	20	0	0	0	0	0	0
106	\N	52	69	\N	\N	1.00	\N	\N	\N	\N	Lake	10	40000	0	0	0	0	0	0	0	0	0	0
107	\N	54	6	\N	\N	1.00	\N	\N	\N	\N	Lake	2	5	5	4	3	3	0	0	0	0	0	0
108	\N	54	33	\N	\N	1.00	\N	\N	\N	\N	Hill	3	20	16	7	4	6	0	0	0	0	0	0
109	\N	54	41	\N	\N	1.00	\N	\N	\N	\N	Forest	4	40	40	10	10	15	0	0	0	0	0	0
110	\N	54	45	\N	\N	1.00	\N	\N	\N	\N	Desert	10	40000	0	0	0	0	0	0	0	0	0	0
111	\N	54	76	\N	\N	1.00	\N	\N	\N	\N	Hill	4	40	40	10	10	15	0	0	0	0	0	0
112	\N	55	26	\N	\N	1.00	\N	\N	\N	\N	Hill	4	40	40	10	10	15	0	0	0	0	0	0
113	\N	55	28	\N	\N	1.00	\N	\N	\N	\N	Desert	5	75	100	35	25	20	0	0	0	0	0	0
114	\N	55	33	\N	\N	1.00	\N	\N	\N	\N	Forest	4	40	40	10	10	15	0	0	0	0	0	0
115	\N	55	40	\N	\N	1.00	\N	\N	\N	\N	Lake	2	5	5	4	3	3	0	0	0	0	0	0
116	\N	56	11	\N	\N	1.00	\N	\N	\N	\N	Hill	8	1500	675	400	300	200	0	0	0	0	0	0
117	\N	56	14	\N	\N	1.00	\N	\N	\N	\N	Lake	2	5	5	4	3	3	0	0	0	0	0	0
118	\N	56	62	\N	\N	1.00	\N	\N	\N	\N	Forest	10	40000	0	0	0	0	0	0	0	0	0	0
119	\N	56	89	\N	\N	1.00	\N	\N	\N	\N	Desert	4	40	40	10	10	15	0	0	0	0	0	0
120	\N	57	4	\N	\N	1.00	\N	\N	\N	\N	Lake	2	5	5	4	3	3	0	0	0	0	0	0
121	\N	58	3	\N	\N	1.00	\N	\N	\N	\N	Lake	3	20	16	7	4	6	0	0	0	0	0	0
122	\N	58	8	\N	\N	1.00	\N	\N	\N	\N	Hill	7	1200	300	75	80	75	0	0	0	0	0	0
123	\N	58	9	\N	\N	1.00	\N	\N	\N	\N	Lake	2	5	5	4	3	3	0	0	0	0	0	0
124	\N	59	9	\N	\N	1.00	\N	\N	\N	\N	Desert	3	20	16	7	4	6	0	0	0	0	0	0
125	\N	59	65	\N	\N	1.00	\N	\N	\N	\N	Lake	7	1200	300	75	80	75	0	0	0	0	0	0
126	\N	60	3	\N	\N	1.00	\N	\N	\N	\N	Hill	8	1500	675	400	300	200	0	0	0	0	0	0
127	\N	60	16	\N	\N	1.00	\N	\N	\N	\N	Lake	5	75	100	35	25	20	0	0	0	0	0	0
128	\N	60	60	\N	\N	1.00	\N	\N	\N	\N	Lake	4	40	40	10	10	15	0	0	0	0	0	0
129	\N	60	67	\N	\N	1.00	\N	\N	\N	\N	Forest	8	1500	675	400	300	200	0	0	0	0	0	0
130	\N	63	58	\N	\N	1.00	\N	\N	\N	\N	Lake	2	5	5	4	3	3	0	0	0	0	0	0
131	\N	64	66	\N	\N	1.00	\N	\N	\N	\N	Lake	3	20	16	7	4	6	0	0	0	0	0	0
132	\N	64	70	\N	\N	1.00	\N	\N	\N	\N	Hill	5	75	100	35	25	20	0	0	0	0	0	0
133	\N	65	9	\N	\N	1.00	\N	\N	\N	\N	Desert	2	5	5	4	3	3	0	0	0	0	0	0
134	\N	66	39	\N	\N	1.00	\N	\N	\N	\N	Forest	7	1200	300	75	80	75	0	0	0	0	0	0
135	\N	66	67	\N	\N	1.00	\N	\N	\N	\N	Lake	8	1500	675	400	300	200	0	0	0	0	0	0
136	\N	66	86	\N	\N	1.00	\N	\N	\N	\N	Forest	6	400	75	55	50	45	0	0	0	0	0	0
137	\N	67	6	\N	\N	1.00	\N	\N	\N	\N	Forest	10	40000	0	0	0	0	0	0	0	0	0	0
138	\N	67	20	\N	\N	1.00	\N	\N	\N	\N	Desert	6	400	75	55	50	45	0	0	0	0	0	0
139	\N	67	48	\N	\N	1.00	\N	\N	\N	\N	Forest	9	6000	1800	200	675	250	0	0	0	0	0	0
140	\N	67	70	\N	\N	1.00	\N	\N	\N	\N	Hill	10	40000	0	0	0	0	0	0	0	0	0	0
141	\N	67	82	\N	\N	1.00	\N	\N	\N	\N	Lake	4	40	40	10	10	15	0	0	0	0	0	0
142	\N	68	0	\N	\N	1.00	\N	\N	\N	\N	Lake	5	75	100	35	25	20	0	0	0	0	0	0
143	\N	69	34	\N	\N	1.00	\N	\N	\N	\N	Forest	4	40	40	10	10	15	0	0	0	0	0	0
144	\N	70	1	\N	\N	1.00	\N	\N	\N	\N	Lake	2	5	5	4	3	3	0	0	0	0	0	0
145	\N	71	9	\N	\N	1.00	\N	\N	\N	\N	Lake	3	20	16	7	4	6	0	0	0	0	0	0
146	\N	71	85	\N	\N	1.00	\N	\N	\N	\N	Forest	5	75	100	35	25	20	0	0	0	0	0	0
147	\N	72	21	\N	\N	1.00	\N	\N	\N	\N	Hill	9	6000	1800	200	675	250	0	0	0	0	0	0
148	\N	74	65	\N	\N	1.00	\N	\N	\N	\N	Hill	4	40	40	10	10	15	0	0	0	0	0	0
149	\N	76	9	\N	\N	1.00	\N	\N	\N	\N	Lake	1	5	4	4	2	1	0	0	0	0	0	0
150	\N	76	17	\N	\N	1.00	\N	\N	\N	\N	Lake	5	75	100	35	25	20	0	0	0	0	0	0
151	\N	76	35	\N	\N	1.00	\N	\N	\N	\N	Forest	5	75	100	35	25	20	0	0	0	0	0	0
152	\N	76	57	\N	\N	1.00	\N	\N	\N	\N	Lake	1	5	4	4	2	1	0	0	0	0	0	0
153	\N	76	61	\N	\N	1.00	\N	\N	\N	\N	Hill	9	6000	1800	200	675	250	0	0	0	0	0	0
154	\N	78	25	\N	\N	1.00	\N	\N	\N	\N	Hill	3	20	16	7	4	6	0	0	0	0	0	0
155	\N	78	33	\N	\N	1.00	\N	\N	\N	\N	Desert	10	40000	0	0	0	0	0	0	0	0	0	0
156	\N	78	43	\N	\N	1.00	\N	\N	\N	\N	Hill	10	40000	0	0	0	0	0	0	0	0	0	0
157	\N	78	64	\N	\N	1.00	\N	\N	\N	\N	Hill	3	20	16	7	4	6	0	0	0	0	0	0
158	\N	79	42	\N	\N	1.00	\N	\N	\N	\N	Desert	5	75	100	35	25	20	0	0	0	0	0	0
159	\N	79	85	\N	\N	1.00	\N	\N	\N	\N	Hill	10	40000	0	0	0	0	0	0	0	0	0	0
160	\N	79	94	\N	\N	1.00	\N	\N	\N	\N	Hill	2	5	5	4	3	3	0	0	0	0	0	0
161	\N	80	4	\N	\N	1.00	\N	\N	\N	\N	Hill	3	20	16	7	4	6	0	0	0	0	0	0
162	\N	80	5	\N	\N	1.00	\N	\N	\N	\N	Forest	5	75	100	35	25	20	0	0	0	0	0	0
163	\N	80	60	\N	\N	1.00	\N	\N	\N	\N	Desert	4	40	40	10	10	15	0	0	0	0	0	0
164	\N	80	65	\N	\N	1.00	\N	\N	\N	\N	Forest	8	1500	675	400	300	200	0	0	0	0	0	0
165	\N	80	79	\N	\N	1.00	\N	\N	\N	\N	Lake	7	1200	300	75	80	75	0	0	0	0	0	0
166	\N	80	91	\N	\N	1.00	\N	\N	\N	\N	Hill	4	40	40	10	10	15	0	0	0	0	0	0
167	\N	81	47	\N	\N	1.00	\N	\N	\N	\N	Desert	10	40000	0	0	0	0	0	0	0	0	0	0
168	\N	81	55	\N	\N	1.00	\N	\N	\N	\N	Hill	7	1200	300	75	80	75	0	0	0	0	0	0
169	\N	82	70	\N	\N	1.00	\N	\N	\N	\N	Forest	3	20	16	7	4	6	0	0	0	0	0	0
170	\N	83	44	\N	\N	1.00	\N	\N	\N	\N	Desert	2	5	5	4	3	3	0	0	0	0	0	0
171	\N	84	33	\N	\N	1.00	\N	\N	\N	\N	Hill	1	5	4	4	2	1	0	0	0	0	0	0
172	\N	85	4	\N	\N	1.00	\N	\N	\N	\N	Hill	9	6000	1800	200	675	250	0	0	0	0	0	0
173	\N	85	29	\N	\N	1.00	\N	\N	\N	\N	Desert	7	1200	300	75	80	75	0	0	0	0	0	0
174	\N	85	95	\N	\N	1.00	\N	\N	\N	\N	Lake	9	6000	1800	200	675	250	0	0	0	0	0	0
175	\N	86	86	\N	\N	1.00	\N	\N	\N	\N	Forest	3	20	16	7	4	6	0	0	0	0	0	0
176	\N	88	49	\N	\N	1.00	\N	\N	\N	\N	Desert	7	1200	300	75	80	75	0	0	0	0	0	0
177	\N	89	45	\N	\N	1.00	\N	\N	\N	\N	Hill	1	5	4	4	2	1	0	0	0	0	0	0
178	\N	89	51	\N	\N	1.00	\N	\N	\N	\N	Forest	2	5	5	4	3	3	0	0	0	0	0	0
179	\N	89	75	\N	\N	1.00	\N	\N	\N	\N	Hill	8	1500	675	400	300	200	0	0	0	0	0	0
180	\N	90	15	\N	\N	1.00	\N	\N	\N	\N	Lake	9	6000	1800	200	675	250	0	0	0	0	0	0
181	\N	90	78	\N	\N	1.00	\N	\N	\N	\N	Hill	10	40000	0	0	0	0	0	0	0	0	0	0
182	\N	90	88	\N	\N	1.00	\N	\N	\N	\N	Forest	10	40000	0	0	0	0	0	0	0	0	0	0
183	\N	91	22	\N	\N	1.00	\N	\N	\N	\N	Lake	6	400	75	55	50	45	0	0	0	0	0	0
184	\N	91	72	\N	\N	1.00	\N	\N	\N	\N	Forest	6	400	75	55	50	45	0	0	0	0	0	0
185	\N	92	37	\N	\N	1.00	\N	\N	\N	\N	Hill	8	1500	675	400	300	200	0	0	0	0	0	0
186	\N	92	78	\N	\N	1.00	\N	\N	\N	\N	Lake	1	5	4	4	2	1	0	0	0	0	0	0
187	\N	93	2	\N	\N	1.00	\N	\N	\N	\N	Forest	5	75	100	35	25	20	0	0	0	0	0	0
188	\N	93	50	\N	\N	1.00	\N	\N	\N	\N	Desert	5	75	100	35	25	20	0	0	0	0	0	0
189	\N	94	1	\N	\N	1.00	\N	\N	\N	\N	Lake	4	40	40	10	10	15	0	0	0	0	0	0
190	\N	94	32	\N	\N	1.00	\N	\N	\N	\N	Forest	3	20	16	7	4	6	0	0	0	0	0	0
191	\N	94	77	\N	\N	1.00	\N	\N	\N	\N	Lake	4	40	40	10	10	15	0	0	0	0	0	0
192	\N	95	30	\N	\N	1.00	\N	\N	\N	\N	Lake	1	5	4	4	2	1	0	0	0	0	0	0
193	\N	95	66	\N	\N	1.00	\N	\N	\N	\N	Hill	2	5	5	4	3	3	0	0	0	0	0	0
194	\N	96	12	\N	\N	1.00	\N	\N	\N	\N	Desert	5	75	100	35	25	20	0	0	0	0	0	0
195	\N	96	40	\N	\N	1.00	\N	\N	\N	\N	Lake	10	40000	0	0	0	0	0	0	0	0	0	0
196	\N	97	58	\N	\N	1.00	\N	\N	\N	\N	Lake	3	20	16	7	4	6	0	0	0	0	0	0
197	\N	97	60	\N	\N	1.00	\N	\N	\N	\N	Hill	9	6000	1800	200	675	250	0	0	0	0	0	0
198	\N	97	79	\N	\N	1.00	\N	\N	\N	\N	Desert	6	400	75	55	50	45	0	0	0	0	0	0
\.


--
-- Name: building_levels_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.building_levels_id_seq', 312, true);


--
-- Name: building_prerequisites_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.building_prerequisites_id_seq', 173, true);


--
-- Name: building_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.building_types_id_seq', 26, true);


--
-- Name: cities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cities_id_seq', 11, true);


--
-- Name: city_buildings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.city_buildings_id_seq', 222, true);


--
-- Name: city_wounded_troops_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.city_wounded_troops_id_seq', 15, true);


--
-- Name: construction_queue_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.construction_queue_id_seq', 137, true);


--
-- Name: hero_candidates_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.hero_candidates_id_seq', 27, true);


--
-- Name: hero_hiring_tiers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.hero_hiring_tiers_id_seq', 4, true);


--
-- Name: heroes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.heroes_id_seq', 27, true);


--
-- Name: map_tiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.map_tiles_id_seq', 10000, true);


--
-- Name: npc_cities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.npc_cities_id_seq', 507, true);


--
-- Name: player_bonus_totals_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.player_bonus_totals_id_seq', 65, true);


--
-- Name: player_researches_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.player_researches_id_seq', 1, false);


--
-- Name: players_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.players_id_seq', 14, true);


--
-- Name: recruitment_queue_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.recruitment_queue_id_seq', 41, true);


--
-- Name: research_node_prerequisites_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.research_node_prerequisites_id_seq', 1290, true);


--
-- Name: research_nodes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.research_nodes_id_seq', 688, true);


--
-- Name: research_queue_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.research_queue_id_seq', 63, true);


--
-- Name: system_effects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.system_effects_id_seq', 6, true);


--
-- Name: unit_research_requirements_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.unit_research_requirements_id_seq', 84, true);


--
-- Name: unit_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.unit_types_id_seq', 18, true);


--
-- Name: wall_fortification_capacity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wall_fortification_capacity_id_seq', 42, true);


--
-- Name: world_resource_fields_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.world_resource_fields_id_seq', 798, true);


--
-- Name: world_valleys_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.world_valleys_id_seq', 198, true);


--
-- Name: building_levels building_levels_building_type_id_level_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.building_levels
    ADD CONSTRAINT building_levels_building_type_id_level_key UNIQUE (building_type_id, level);


--
-- Name: building_levels building_levels_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.building_levels
    ADD CONSTRAINT building_levels_pkey PRIMARY KEY (id);


--
-- Name: building_prerequisites building_prerequisites_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.building_prerequisites
    ADD CONSTRAINT building_prerequisites_pkey PRIMARY KEY (id);


--
-- Name: building_types building_types_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.building_types
    ADD CONSTRAINT building_types_name_key UNIQUE (name);


--
-- Name: building_types building_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.building_types
    ADD CONSTRAINT building_types_pkey PRIMARY KEY (id);


--
-- Name: cities cities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_pkey PRIMARY KEY (id);


--
-- Name: city_buildings city_buildings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.city_buildings
    ADD CONSTRAINT city_buildings_pkey PRIMARY KEY (id);


--
-- Name: city_resources city_resources_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.city_resources
    ADD CONSTRAINT city_resources_pkey PRIMARY KEY (city_id);


--
-- Name: city_units city_units_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.city_units
    ADD CONSTRAINT city_units_pkey PRIMARY KEY (city_id, unit_type_id);


--
-- Name: city_wounded_troops city_wounded_troops_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.city_wounded_troops
    ADD CONSTRAINT city_wounded_troops_pkey PRIMARY KEY (id);


--
-- Name: construction_queue construction_queue_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.construction_queue
    ADD CONSTRAINT construction_queue_pkey PRIMARY KEY (id);


--
-- Name: hero_candidates hero_candidates_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hero_candidates
    ADD CONSTRAINT hero_candidates_pkey PRIMARY KEY (id);


--
-- Name: hero_hiring_tiers hero_hiring_tiers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hero_hiring_tiers
    ADD CONSTRAINT hero_hiring_tiers_pkey PRIMARY KEY (id);


--
-- Name: heroes heroes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.heroes
    ADD CONSTRAINT heroes_pkey PRIMARY KEY (id);


--
-- Name: map_tiles map_tiles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.map_tiles
    ADD CONSTRAINT map_tiles_pkey PRIMARY KEY (id);


--
-- Name: map_tiles map_tiles_x_y_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.map_tiles
    ADD CONSTRAINT map_tiles_x_y_key UNIQUE (x, y);


--
-- Name: npc_cities npc_cities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.npc_cities
    ADD CONSTRAINT npc_cities_pkey PRIMARY KEY (id);


--
-- Name: npc_cities npc_cities_x_y_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.npc_cities
    ADD CONSTRAINT npc_cities_x_y_key UNIQUE (x, y);


--
-- Name: player_bonus_totals player_bonus_totals_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player_bonus_totals
    ADD CONSTRAINT player_bonus_totals_pkey PRIMARY KEY (id);


--
-- Name: player_bonus_totals player_bonus_totals_player_id_bonus_type_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player_bonus_totals
    ADD CONSTRAINT player_bonus_totals_player_id_bonus_type_key UNIQUE (player_id, bonus_type);


--
-- Name: player_completed_research_nodes player_completed_research_nodes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player_completed_research_nodes
    ADD CONSTRAINT player_completed_research_nodes_pkey PRIMARY KEY (player_id, research_node_id);


--
-- Name: player_researches player_researches_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player_researches
    ADD CONSTRAINT player_researches_pkey PRIMARY KEY (id);


--
-- Name: players players_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.players
    ADD CONSTRAINT players_pkey PRIMARY KEY (id);


--
-- Name: players players_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.players
    ADD CONSTRAINT players_username_key UNIQUE (username);


--
-- Name: recruitment_queue recruitment_queue_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recruitment_queue
    ADD CONSTRAINT recruitment_queue_pkey PRIMARY KEY (id);


--
-- Name: research_node_prerequisites research_node_prerequisites_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.research_node_prerequisites
    ADD CONSTRAINT research_node_prerequisites_pkey PRIMARY KEY (id);


--
-- Name: research_nodes research_nodes_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.research_nodes
    ADD CONSTRAINT research_nodes_name_key UNIQUE (name);


--
-- Name: research_nodes research_nodes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.research_nodes
    ADD CONSTRAINT research_nodes_pkey PRIMARY KEY (id);


--
-- Name: research_queue research_queue_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.research_queue
    ADD CONSTRAINT research_queue_pkey PRIMARY KEY (id);


--
-- Name: system_effects system_effects_branch_system_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.system_effects
    ADD CONSTRAINT system_effects_branch_system_key UNIQUE (branch_system);


--
-- Name: system_effects system_effects_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.system_effects
    ADD CONSTRAINT system_effects_pkey PRIMARY KEY (id);


--
-- Name: tax_happiness_bands tax_happiness_bands_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tax_happiness_bands
    ADD CONSTRAINT tax_happiness_bands_pkey PRIMARY KEY (tax_rate_pct);


--
-- Name: unit_research_requirements unit_research_requirements_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.unit_research_requirements
    ADD CONSTRAINT unit_research_requirements_pkey PRIMARY KEY (id);


--
-- Name: unit_types unit_types_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.unit_types
    ADD CONSTRAINT unit_types_code_key UNIQUE (code);


--
-- Name: unit_types unit_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.unit_types
    ADD CONSTRAINT unit_types_pkey PRIMARY KEY (id);


--
-- Name: wall_fortification_capacity wall_fortification_capacity_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wall_fortification_capacity
    ADD CONSTRAINT wall_fortification_capacity_pkey PRIMARY KEY (id);


--
-- Name: world_resource_fields world_resource_fields_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.world_resource_fields
    ADD CONSTRAINT world_resource_fields_pkey PRIMARY KEY (id);


--
-- Name: world_resource_fields world_resource_fields_x_y_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.world_resource_fields
    ADD CONSTRAINT world_resource_fields_x_y_key UNIQUE (x, y);


--
-- Name: world_valleys world_valleys_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.world_valleys
    ADD CONSTRAINT world_valleys_pkey PRIMARY KEY (id);


--
-- Name: world_valleys world_valleys_x_y_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.world_valleys
    ADD CONSTRAINT world_valleys_x_y_key UNIQUE (x, y);


--
-- Name: idx_building_prereqs_lookup; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_building_prereqs_lookup ON public.building_prerequisites USING btree (building_type_id, target_level);


--
-- Name: research_node_prerequisites_research_pair_uidx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX research_node_prerequisites_research_pair_uidx ON public.research_node_prerequisites USING btree (research_node_id, prerequisite_node_id) WHERE (requirement_type = 'RESEARCH'::text);


--
-- Name: building_levels building_levels_building_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.building_levels
    ADD CONSTRAINT building_levels_building_type_id_fkey FOREIGN KEY (building_type_id) REFERENCES public.building_types(id) ON DELETE CASCADE;


--
-- Name: building_prerequisites building_prerequisites_building_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.building_prerequisites
    ADD CONSTRAINT building_prerequisites_building_type_id_fkey FOREIGN KEY (building_type_id) REFERENCES public.building_types(id) ON DELETE CASCADE;


--
-- Name: building_prerequisites building_prerequisites_req_building_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.building_prerequisites
    ADD CONSTRAINT building_prerequisites_req_building_type_id_fkey FOREIGN KEY (req_building_type_id) REFERENCES public.building_types(id) ON DELETE CASCADE;


--
-- Name: building_prerequisites building_prerequisites_req_research_node_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.building_prerequisites
    ADD CONSTRAINT building_prerequisites_req_research_node_id_fkey FOREIGN KEY (req_research_node_id) REFERENCES public.research_nodes(id) ON DELETE CASCADE;


--
-- Name: cities cities_owner_city_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_owner_city_id_fkey FOREIGN KEY (owner_city_id) REFERENCES public.cities(id) ON DELETE SET NULL;


--
-- Name: cities cities_owner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES public.players(id) ON DELETE CASCADE;


--
-- Name: city_buildings city_buildings_building_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.city_buildings
    ADD CONSTRAINT city_buildings_building_type_id_fkey FOREIGN KEY (building_type_id) REFERENCES public.building_types(id);


--
-- Name: city_buildings city_buildings_city_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.city_buildings
    ADD CONSTRAINT city_buildings_city_id_fkey FOREIGN KEY (city_id) REFERENCES public.cities(id) ON DELETE CASCADE;


--
-- Name: city_resources city_resources_city_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.city_resources
    ADD CONSTRAINT city_resources_city_id_fkey FOREIGN KEY (city_id) REFERENCES public.cities(id) ON DELETE CASCADE;


--
-- Name: city_units city_units_city_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.city_units
    ADD CONSTRAINT city_units_city_id_fkey FOREIGN KEY (city_id) REFERENCES public.cities(id) ON DELETE CASCADE;


--
-- Name: city_units city_units_unit_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.city_units
    ADD CONSTRAINT city_units_unit_type_id_fkey FOREIGN KEY (unit_type_id) REFERENCES public.unit_types(id) ON DELETE CASCADE;


--
-- Name: city_wounded_troops city_wounded_troops_city_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.city_wounded_troops
    ADD CONSTRAINT city_wounded_troops_city_id_fkey FOREIGN KEY (city_id) REFERENCES public.cities(id) ON DELETE CASCADE;


--
-- Name: city_wounded_troops city_wounded_troops_unit_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.city_wounded_troops
    ADD CONSTRAINT city_wounded_troops_unit_type_id_fkey FOREIGN KEY (unit_type_id) REFERENCES public.unit_types(id);


--
-- Name: construction_queue construction_queue_building_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.construction_queue
    ADD CONSTRAINT construction_queue_building_id_fkey FOREIGN KEY (building_id) REFERENCES public.city_buildings(id) ON DELETE CASCADE;


--
-- Name: construction_queue construction_queue_city_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.construction_queue
    ADD CONSTRAINT construction_queue_city_id_fkey FOREIGN KEY (city_id) REFERENCES public.cities(id) ON DELETE CASCADE;


--
-- Name: hero_candidates hero_candidates_city_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hero_candidates
    ADD CONSTRAINT hero_candidates_city_id_fkey FOREIGN KEY (city_id) REFERENCES public.cities(id) ON DELETE CASCADE;


--
-- Name: hero_candidates hero_candidates_hero_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hero_candidates
    ADD CONSTRAINT hero_candidates_hero_id_fkey FOREIGN KEY (hero_id) REFERENCES public.heroes(id) ON DELETE CASCADE;


--
-- Name: heroes heroes_city_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.heroes
    ADD CONSTRAINT heroes_city_id_fkey FOREIGN KEY (city_id) REFERENCES public.cities(id) ON DELETE SET NULL;


--
-- Name: heroes heroes_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.heroes
    ADD CONSTRAINT heroes_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.players(id) ON DELETE CASCADE;


--
-- Name: map_tiles map_tiles_city_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.map_tiles
    ADD CONSTRAINT map_tiles_city_id_fkey FOREIGN KEY (city_id) REFERENCES public.cities(id);


--
-- Name: map_tiles map_tiles_owner_city_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.map_tiles
    ADD CONSTRAINT map_tiles_owner_city_id_fkey FOREIGN KEY (owner_city_id) REFERENCES public.cities(id) ON DELETE SET NULL;


--
-- Name: player_bonus_totals player_bonus_totals_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player_bonus_totals
    ADD CONSTRAINT player_bonus_totals_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.players(id) ON DELETE CASCADE;


--
-- Name: player_completed_research_nodes player_completed_research_nodes_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player_completed_research_nodes
    ADD CONSTRAINT player_completed_research_nodes_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.players(id) ON DELETE CASCADE;


--
-- Name: player_completed_research_nodes player_completed_research_nodes_research_node_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player_completed_research_nodes
    ADD CONSTRAINT player_completed_research_nodes_research_node_id_fkey FOREIGN KEY (research_node_id) REFERENCES public.research_nodes(id) ON DELETE CASCADE;


--
-- Name: player_researches player_researches_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player_researches
    ADD CONSTRAINT player_researches_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.players(id) ON DELETE CASCADE;


--
-- Name: player_researches player_researches_research_node_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player_researches
    ADD CONSTRAINT player_researches_research_node_id_fkey FOREIGN KEY (research_node_id) REFERENCES public.research_nodes(id) ON DELETE CASCADE;


--
-- Name: recruitment_queue recruitment_queue_building_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recruitment_queue
    ADD CONSTRAINT recruitment_queue_building_id_fkey FOREIGN KEY (building_id) REFERENCES public.city_buildings(id) ON DELETE CASCADE;


--
-- Name: recruitment_queue recruitment_queue_city_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recruitment_queue
    ADD CONSTRAINT recruitment_queue_city_id_fkey FOREIGN KEY (city_id) REFERENCES public.cities(id) ON DELETE CASCADE;


--
-- Name: recruitment_queue recruitment_queue_unit_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recruitment_queue
    ADD CONSTRAINT recruitment_queue_unit_type_id_fkey FOREIGN KEY (unit_type_id) REFERENCES public.unit_types(id) ON DELETE CASCADE;


--
-- Name: research_node_prerequisites research_node_prerequisites_prerequisite_node_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.research_node_prerequisites
    ADD CONSTRAINT research_node_prerequisites_prerequisite_node_id_fkey FOREIGN KEY (prerequisite_node_id) REFERENCES public.research_nodes(id) ON DELETE CASCADE;


--
-- Name: research_node_prerequisites research_node_prerequisites_required_building_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.research_node_prerequisites
    ADD CONSTRAINT research_node_prerequisites_required_building_type_id_fkey FOREIGN KEY (required_building_type_id) REFERENCES public.building_types(id);


--
-- Name: research_node_prerequisites research_node_prerequisites_research_node_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.research_node_prerequisites
    ADD CONSTRAINT research_node_prerequisites_research_node_id_fkey FOREIGN KEY (research_node_id) REFERENCES public.research_nodes(id) ON DELETE CASCADE;


--
-- Name: research_nodes research_nodes_linked_building_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.research_nodes
    ADD CONSTRAINT research_nodes_linked_building_id_fkey FOREIGN KEY (linked_building_id) REFERENCES public.building_types(id);


--
-- Name: research_queue research_queue_city_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.research_queue
    ADD CONSTRAINT research_queue_city_id_fkey FOREIGN KEY (city_id) REFERENCES public.cities(id) ON DELETE CASCADE;


--
-- Name: research_queue research_queue_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.research_queue
    ADD CONSTRAINT research_queue_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.players(id) ON DELETE CASCADE;


--
-- Name: research_queue research_queue_research_node_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.research_queue
    ADD CONSTRAINT research_queue_research_node_id_fkey FOREIGN KEY (research_node_id) REFERENCES public.research_nodes(id) ON DELETE CASCADE;


--
-- Name: unit_research_requirements unit_research_requirements_requires_building_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.unit_research_requirements
    ADD CONSTRAINT unit_research_requirements_requires_building_id_fkey FOREIGN KEY (requires_building_id) REFERENCES public.building_types(id) ON DELETE CASCADE;


--
-- Name: unit_research_requirements unit_research_requirements_research_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.unit_research_requirements
    ADD CONSTRAINT unit_research_requirements_research_id_fkey FOREIGN KEY (research_id) REFERENCES public.research_nodes(id) ON DELETE CASCADE;


--
-- Name: unit_research_requirements unit_research_requirements_unit_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.unit_research_requirements
    ADD CONSTRAINT unit_research_requirements_unit_type_id_fkey FOREIGN KEY (unit_type_id) REFERENCES public.unit_types(id) ON DELETE CASCADE;


--
-- Name: wall_fortification_capacity wall_fortification_capacity_city_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wall_fortification_capacity
    ADD CONSTRAINT wall_fortification_capacity_city_id_fkey FOREIGN KEY (city_id) REFERENCES public.cities(id) ON DELETE CASCADE;


--
-- Name: world_resource_fields world_resource_fields_owner_city_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.world_resource_fields
    ADD CONSTRAINT world_resource_fields_owner_city_id_fkey FOREIGN KEY (owner_city_id) REFERENCES public.cities(id) ON DELETE SET NULL;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

GRANT ALL ON SCHEMA public TO empire;


--
-- Name: TABLE building_levels; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.building_levels TO empire;


--
-- Name: SEQUENCE building_levels_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.building_levels_id_seq TO empire;


--
-- Name: TABLE building_prerequisites; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.building_prerequisites TO empire;


--
-- Name: SEQUENCE building_prerequisites_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.building_prerequisites_id_seq TO empire;


--
-- Name: TABLE building_types; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.building_types TO empire;


--
-- Name: SEQUENCE building_types_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.building_types_id_seq TO empire;


--
-- Name: TABLE cities; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.cities TO empire;


--
-- Name: SEQUENCE cities_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.cities_id_seq TO empire;


--
-- Name: TABLE city_buildings; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.city_buildings TO empire;


--
-- Name: SEQUENCE city_buildings_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.city_buildings_id_seq TO empire;


--
-- Name: TABLE city_resources; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.city_resources TO empire;


--
-- Name: TABLE city_units; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.city_units TO empire;


--
-- Name: TABLE city_wounded_troops; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.city_wounded_troops TO empire;


--
-- Name: SEQUENCE city_wounded_troops_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE public.city_wounded_troops_id_seq TO empire;


--
-- Name: TABLE construction_queue; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.construction_queue TO empire;


--
-- Name: SEQUENCE construction_queue_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.construction_queue_id_seq TO empire;


--
-- Name: TABLE hero_candidates; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.hero_candidates TO empire;


--
-- Name: SEQUENCE hero_candidates_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.hero_candidates_id_seq TO empire;


--
-- Name: TABLE hero_hiring_tiers; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.hero_hiring_tiers TO empire;


--
-- Name: SEQUENCE hero_hiring_tiers_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.hero_hiring_tiers_id_seq TO empire;


--
-- Name: TABLE heroes; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.heroes TO empire;


--
-- Name: SEQUENCE heroes_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.heroes_id_seq TO empire;


--
-- Name: TABLE map_tiles; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.map_tiles TO empire;


--
-- Name: SEQUENCE map_tiles_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.map_tiles_id_seq TO empire;


--
-- Name: TABLE npc_cities; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.npc_cities TO empire;


--
-- Name: SEQUENCE npc_cities_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE public.npc_cities_id_seq TO empire;


--
-- Name: TABLE player_bonus_totals; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.player_bonus_totals TO empire;


--
-- Name: SEQUENCE player_bonus_totals_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE public.player_bonus_totals_id_seq TO empire;


--
-- Name: TABLE player_completed_research_nodes; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.player_completed_research_nodes TO empire;


--
-- Name: TABLE player_researches; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.player_researches TO empire;


--
-- Name: SEQUENCE player_researches_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.player_researches_id_seq TO empire;


--
-- Name: TABLE players; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.players TO empire;


--
-- Name: SEQUENCE players_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.players_id_seq TO empire;


--
-- Name: TABLE recruitment_queue; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.recruitment_queue TO empire;


--
-- Name: SEQUENCE recruitment_queue_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.recruitment_queue_id_seq TO empire;


--
-- Name: TABLE research_node_prerequisites; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.research_node_prerequisites TO empire;


--
-- Name: TABLE research_nodes; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.research_nodes TO empire;


--
-- Name: SEQUENCE research_nodes_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.research_nodes_id_seq TO empire;


--
-- Name: TABLE research_queue; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.research_queue TO empire;


--
-- Name: SEQUENCE research_queue_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.research_queue_id_seq TO empire;


--
-- Name: TABLE system_effects; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.system_effects TO empire;


--
-- Name: SEQUENCE system_effects_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.system_effects_id_seq TO empire;


--
-- Name: TABLE tax_happiness_bands; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.tax_happiness_bands TO empire;


--
-- Name: TABLE unit_research_requirements; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.unit_research_requirements TO empire;


--
-- Name: SEQUENCE unit_research_requirements_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.unit_research_requirements_id_seq TO empire;


--
-- Name: TABLE unit_types; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.unit_types TO empire;


--
-- Name: SEQUENCE unit_types_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.unit_types_id_seq TO empire;


--
-- Name: TABLE wall_fortification_capacity; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.wall_fortification_capacity TO empire;


--
-- Name: SEQUENCE wall_fortification_capacity_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.wall_fortification_capacity_id_seq TO empire;


--
-- Name: TABLE world_resource_fields; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.world_resource_fields TO empire;


--
-- Name: SEQUENCE world_resource_fields_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.world_resource_fields_id_seq TO empire;


--
-- Name: TABLE world_valleys; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.world_valleys TO empire;


--
-- Name: SEQUENCE world_valleys_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.world_valleys_id_seq TO empire;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: -; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT SELECT,USAGE ON SEQUENCES  TO empire;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: -; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON TABLES  TO empire;


--
-- PostgreSQL database dump complete
--

\unrestrict FRRoywX9CHvZ0DFT8Uhmc4zj1dN7KknNkMr8HLJyWm0ipVVrMcXRg7NKx1NA6Jc

