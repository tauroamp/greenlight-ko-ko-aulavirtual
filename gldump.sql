--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Drop databases
--

DROP DATABASE greenlight_production;




--
-- Drop roles
--

DROP ROLE postgres;


--
-- Roles
--

CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'md5e888939ba617979fa70a3ff0ab759493';






--
-- Database creation
--

CREATE DATABASE greenlight_production WITH TEMPLATE = template0 OWNER = postgres;
REVOKE ALL ON DATABASE template1 FROM PUBLIC;
REVOKE ALL ON DATABASE template1 FROM postgres;
GRANT ALL ON DATABASE template1 TO postgres;
GRANT CONNECT ON DATABASE template1 TO PUBLIC;


\connect greenlight_production

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.21
-- Dumped by pg_dump version 9.5.21

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.ar_internal_metadata OWNER TO postgres;

--
-- Name: features; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.features (
    id bigint NOT NULL,
    setting_id integer,
    name character varying NOT NULL,
    value character varying,
    enabled boolean DEFAULT false,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.features OWNER TO postgres;

--
-- Name: features_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.features_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.features_id_seq OWNER TO postgres;

--
-- Name: features_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.features_id_seq OWNED BY public.features.id;


--
-- Name: invitations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.invitations (
    id bigint NOT NULL,
    email character varying NOT NULL,
    provider character varying NOT NULL,
    invite_token character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.invitations OWNER TO postgres;

--
-- Name: invitations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.invitations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.invitations_id_seq OWNER TO postgres;

--
-- Name: invitations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.invitations_id_seq OWNED BY public.invitations.id;


--
-- Name: role_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role_permissions (
    id bigint NOT NULL,
    name character varying,
    value character varying DEFAULT ''::character varying,
    enabled boolean DEFAULT false,
    role_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.role_permissions OWNER TO postgres;

--
-- Name: role_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.role_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.role_permissions_id_seq OWNER TO postgres;

--
-- Name: role_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.role_permissions_id_seq OWNED BY public.role_permissions.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id bigint NOT NULL,
    name character varying,
    priority integer DEFAULT 9999,
    can_create_rooms boolean DEFAULT false,
    send_promoted_email boolean DEFAULT false,
    send_demoted_email boolean DEFAULT false,
    can_edit_site_settings boolean DEFAULT false,
    can_edit_roles boolean DEFAULT false,
    can_manage_users boolean DEFAULT false,
    colour character varying,
    provider character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.roles_id_seq OWNER TO postgres;

--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- Name: rooms; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rooms (
    id bigint NOT NULL,
    user_id integer,
    name character varying,
    uid character varying,
    bbb_id character varying,
    sessions integer DEFAULT 0,
    last_session timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    room_settings character varying DEFAULT '{ }'::character varying,
    moderator_pw character varying,
    attendee_pw character varying,
    access_code character varying,
    deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE public.rooms OWNER TO postgres;

--
-- Name: rooms_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rooms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rooms_id_seq OWNER TO postgres;

--
-- Name: rooms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rooms_id_seq OWNED BY public.rooms.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO postgres;

--
-- Name: settings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.settings (
    id bigint NOT NULL,
    provider character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.settings OWNER TO postgres;

--
-- Name: settings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.settings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.settings_id_seq OWNER TO postgres;

--
-- Name: settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.settings_id_seq OWNED BY public.settings.id;


--
-- Name: shared_accesses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shared_accesses (
    id bigint NOT NULL,
    room_id integer,
    user_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.shared_accesses OWNER TO postgres;

--
-- Name: shared_accesses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.shared_accesses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.shared_accesses_id_seq OWNER TO postgres;

--
-- Name: shared_accesses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.shared_accesses_id_seq OWNED BY public.shared_accesses.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    room_id integer,
    provider character varying,
    uid character varying,
    name character varying,
    username character varying,
    email character varying,
    social_uid character varying,
    image character varying,
    password_digest character varying,
    accepted_terms boolean DEFAULT false,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    email_verified boolean DEFAULT false,
    language character varying DEFAULT 'default'::character varying,
    reset_digest character varying,
    reset_sent_at timestamp without time zone,
    activation_digest character varying,
    activated_at timestamp without time zone,
    deleted boolean DEFAULT false NOT NULL,
    role_id bigint
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: users_roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users_roles (
    user_id integer,
    role_id integer
);


ALTER TABLE public.users_roles OWNER TO postgres;

--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.features ALTER COLUMN id SET DEFAULT nextval('public.features_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invitations ALTER COLUMN id SET DEFAULT nextval('public.invitations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_permissions ALTER COLUMN id SET DEFAULT nextval('public.role_permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rooms ALTER COLUMN id SET DEFAULT nextval('public.rooms_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.settings ALTER COLUMN id SET DEFAULT nextval('public.settings_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shared_accesses ALTER COLUMN id SET DEFAULT nextval('public.shared_accesses_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	production	2020-04-30 00:23:42.742414	2020-04-30 00:23:42.742414
\.


--
-- Data for Name: features; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.features (id, setting_id, name, value, enabled, created_at, updated_at) FROM stdin;
2	1	Primary Color	\N	f	2020-04-30 00:24:47.013865	2020-04-30 00:24:47.013865
3	1	Primary Color Lighten	\N	f	2020-04-30 00:24:47.017144	2020-04-30 00:24:47.017144
4	1	Primary Color Darken	\N	f	2020-04-30 00:24:47.019524	2020-04-30 00:24:47.019524
6	1	Room Configuration Allow Any Start	\N	f	2020-05-04 03:04:58.367139	2020-05-04 03:04:58.367139
7	1	Shared Access	\N	f	2020-05-04 03:05:00.995218	2020-05-04 03:05:00.995218
11	1	Room Configuration All Join Moderator	\N	f	2020-05-04 03:05:01.172947	2020-05-04 03:05:01.172947
13	1	Default Recording Visibility	\N	f	2020-05-14 19:27:34.952537	2020-05-14 19:27:34.952537
5	1	Registration Method	2	t	2020-04-30 00:25:42.929936	2020-05-14 19:27:48.961394
12	1	Room Authentication	true	t	2020-05-14 19:27:34.947699	2020-05-14 19:28:06.932291
8	1	Room Limit	5	t	2020-05-04 03:05:01.125584	2020-05-14 19:28:24.999724
1	1	Branding Image	https://koandko.com.mx/images/logo.png	t	2020-04-30 00:24:33.23925	2020-05-14 19:29:04.835753
10	1	Room Configuration Require Moderator	optional	t	2020-05-04 03:05:01.170319	2020-05-14 19:30:21.783973
9	1	Room Configuration Mute On Join	optional	t	2020-05-04 03:05:01.167747	2020-05-14 19:30:24.423209
14	1	Legal URL	\N	f	2020-05-29 01:19:37.330497	2020-05-29 01:19:37.330497
15	1	Privacy Policy URL	\N	f	2020-05-29 01:19:37.339516	2020-05-29 01:19:37.339516
\.


--
-- Name: features_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.features_id_seq', 15, true);


--
-- Data for Name: invitations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.invitations (id, email, provider, invite_token, created_at, updated_at) FROM stdin;
\.


--
-- Name: invitations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.invitations_id_seq', 1, false);


--
-- Data for Name: role_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.role_permissions (id, name, value, enabled, role_id, created_at, updated_at) FROM stdin;
1	can_create_rooms	true	t	1	2020-05-04 03:04:55.301461	2020-05-04 03:04:55.30276
2	can_create_rooms	true	t	2	2020-05-04 03:04:55.306292	2020-05-04 03:04:55.307272
3	send_promoted_email	true	t	2	2020-05-04 03:04:55.308999	2020-05-04 03:04:55.309837
4	send_demoted_email	true	t	2	2020-05-04 03:04:55.31144	2020-05-04 03:04:55.312204
5	can_edit_site_settings	true	t	2	2020-05-04 03:04:55.313887	2020-05-04 03:04:55.314963
6	can_edit_roles	true	t	2	2020-05-04 03:04:55.316627	2020-05-04 03:04:55.317557
7	can_manage_users	true	t	2	2020-05-04 03:04:55.319132	2020-05-04 03:04:55.319965
8	can_manage_rooms_recordings	true	t	2	2020-05-04 03:04:55.321563	2020-05-04 03:04:55.322484
9	can_create_rooms	true	t	5	2020-05-04 03:04:55.327536	2020-05-04 03:04:55.328364
10	send_promoted_email	true	t	5	2020-05-04 03:04:55.329912	2020-05-04 03:04:55.330766
11	send_demoted_email	true	t	5	2020-05-04 03:04:55.332242	2020-05-04 03:04:55.333117
12	can_edit_site_settings	true	t	5	2020-05-04 03:04:55.334549	2020-05-04 03:04:55.33532
13	can_edit_roles	true	t	5	2020-05-04 03:04:55.336798	2020-05-04 03:04:55.337651
14	can_manage_users	true	t	5	2020-05-04 03:04:55.339208	2020-05-04 03:04:55.340043
15	can_manage_rooms_recordings	true	t	5	2020-05-04 03:04:55.341608	2020-05-04 03:04:55.342415
16	can_manage_users		f	1	2020-05-04 03:04:55.739857	2020-05-04 03:04:55.739857
17	can_manage_rooms_recordings		f	1	2020-05-04 03:04:55.743255	2020-05-04 03:04:55.743255
18	can_edit_site_settings		f	1	2020-05-04 03:04:55.746504	2020-05-04 03:04:55.746504
19	can_edit_roles		f	1	2020-05-04 03:04:55.749821	2020-05-04 03:04:55.749821
20	can_appear_in_share_list		f	5	2020-05-04 03:05:01.103585	2020-05-04 03:05:01.103585
21	can_appear_in_share_list		f	4	2020-05-04 03:05:01.106265	2020-05-04 03:05:01.106265
22	can_appear_in_share_list		f	3	2020-05-04 03:05:01.108621	2020-05-04 03:05:01.108621
23	can_appear_in_share_list		f	2	2020-05-04 03:05:01.110957	2020-05-04 03:05:01.110957
24	can_appear_in_share_list		f	1	2020-05-04 03:05:01.113114	2020-05-04 03:05:01.113114
25	send_promoted_email		f	1	2020-05-14 19:30:30.211803	2020-05-14 19:30:30.211803
26	send_demoted_email		f	1	2020-05-14 19:30:30.215367	2020-05-14 19:30:30.215367
27	can_create_rooms	false	t	6	2020-05-27 05:51:01.696887	2020-05-27 05:51:30.332914
34	send_demoted_email	false	t	6	2020-05-27 05:51:01.713918	2020-05-27 05:51:30.338619
30	can_edit_site_settings	false	t	6	2020-05-27 05:51:01.705015	2020-05-27 05:51:30.341357
31	can_edit_roles	false	t	6	2020-05-27 05:51:01.707101	2020-05-27 05:51:30.343962
28	can_manage_users	false	t	6	2020-05-27 05:51:01.699688	2020-05-27 05:51:30.34675
29	can_manage_rooms_recordings	false	t	6	2020-05-27 05:51:01.702455	2020-05-27 05:51:30.349121
32	can_appear_in_share_list	false	t	6	2020-05-27 05:51:01.70939	2020-05-27 05:51:30.351339
33	send_promoted_email	true	t	6	2020-05-27 05:51:01.711588	2020-05-27 06:02:38.49975
\.


--
-- Name: role_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.role_permissions_id_seq', 34, true);


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (id, name, priority, can_create_rooms, send_promoted_email, send_demoted_email, can_edit_site_settings, can_edit_roles, can_manage_users, colour, provider, created_at, updated_at) FROM stdin;
2	admin	0	f	f	f	f	f	f	#f1c40f	greenlight	2020-05-04 03:04:55.30409	2020-05-04 03:04:55.30409
3	pending	-1	f	f	f	f	f	f	#17a2b8	greenlight	2020-05-04 03:04:55.323481	2020-05-04 03:04:55.323481
4	denied	-2	f	f	f	f	f	f	#343a40	greenlight	2020-05-04 03:04:55.324653	2020-05-04 03:04:55.324653
5	super_admin	-3	f	f	f	f	f	f	#cd201f	greenlight	2020-05-04 03:04:55.325682	2020-05-04 03:04:55.325682
1	user	2	f	f	f	f	f	f	#868e96	greenlight	2020-05-04 03:04:55.288256	2020-05-27 05:51:01.657188
6	Estudiante	1	f	f	f	f	f	f	#0CE7A1	greenlight	2020-05-27 05:51:01.651729	2020-05-27 05:51:30.328583
\.


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_seq', 6, true);


--
-- Data for Name: rooms; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rooms (id, user_id, name, uid, bbb_id, sessions, last_session, created_at, updated_at, room_settings, moderator_pw, attendee_pw, access_code, deleted) FROM stdin;
1	1	Home Room	def-kyy-ft7	6745f668a6356bfdbbcd02f6c9912a8a67d386ee	0	\N	2020-05-04 03:04:55.200318	2020-05-04 03:04:55.200318	{ }	dyjEeFiPcHWT	mFRatYiezihf	\N	f
3	3	Sala principal	pep-xyj-3f3	a799a5b055a815b1a1481eb36e26c00085fc7c25	0	\N	2020-05-15 00:27:26.41756	2020-05-15 00:27:26.41756	{ }	eYgxaAEeagJo	OYHYRncblQJp	\N	f
5	4	Sala principal	hec-kge-u96	b7606a3e3e754bec1dc939ba3c17abcfd68296a8	0	\N	2020-05-22 15:19:54.130923	2020-05-22 15:19:54.130923	{ }	BBnrxbQglvie	tPdgBEASptdp	\N	f
8	5	Control Escolar	chr-3jm-ngf	0c53ef274ff718b47228f2af94d0a4a8c79f317c	8	2020-05-27 18:05:35.933062	2020-05-27 03:46:45.060937	2020-05-27 18:05:35.933773	{"muteOnStart":true,"requireModeratorApproval":false,"anyoneCanStart":true,"joinModerator":false}	QnzoizMPttaK	hwmDZBtEIxUu	537958	f
7	6	Sala principal	bra-443-96a	fe0222213ae0f6f6dea11f760f9a86be3f63ce84	0	\N	2020-05-22 15:20:12.27014	2020-05-22 15:20:12.27014	{ }	PHYZxgeAqTQq	KvQFdoNAuIea	\N	f
2	2	Sala de Muestra	ale-xuu-dvq	11bac031c8eb260e795b031d0b51c58020b98124	8	2020-05-25 15:05:19.644478	2020-05-14 19:24:29.413893	2020-05-25 15:05:19.645208	{"muteOnStart":true,"requireModeratorApproval":true,"anyoneCanStart":true,"joinModerator":false}	nyXRDrRZTdyz	DMrfHcdEjQeS	971125	f
10	8	Sala principal	chr-k4h-yrq	9db00c5a3a56838c10453daa4a74a10d11ebe61d	0	\N	2020-05-27 03:58:37.029906	2020-05-27 03:58:37.029906	{ }	iljxkSfENcVq	vEkFAXWPSYaz	\N	f
9	7	Sala principal	ric-kdq-v7t	e4c513a1c9cf4e0efb6c7271d13f995c02f8338a	1	2020-05-27 04:01:01.557209	2020-05-27 03:55:03.801184	2020-05-27 04:01:01.558012	{ }	fRDHDICkYLLk	sYiZYdzONYDG	\N	f
4	2	Otra sala de pruebas!	ale-h49-cte	f2426157f7c3ec8c39b240d59bbf487e697a725c	1	2020-05-27 04:03:43.793764	2020-05-16 22:59:52.993206	2020-05-27 04:03:43.794434	{"muteOnStart":true,"requireModeratorApproval":true,"anyoneCanStart":false,"joinModerator":false}	FLiGoxWBjVWY	KymLKJqUDMrk		f
6	5	Sala principal	chr-vmf-mzk	b912614103a3c9fb5a3e36a62280915b3bd39750	2	2020-05-27 18:06:02.962555	2020-05-22 15:19:58.631431	2020-05-27 18:06:02.96342	{ }	MSlGHBVKtQdU	mWMZpLWTVUci	\N	f
\.


--
-- Name: rooms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rooms_id_seq', 10, true);


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schema_migrations (version) FROM stdin;
20200130144841
20190726153012
20180504131705
20190312003555
20180504131648
20190711192033
20190522195242
20190507190710
20190122210632
20190326144939
20190522193828
20181217142710
20191023172511
20190522194445
20190522194037
20181113174230
20190822134205
20191128212935
20190314152108
20190828153347
20190206210049
20180920193451
20200413150518
\.


--
-- Data for Name: settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.settings (id, provider, created_at, updated_at) FROM stdin;
1	greenlight	2020-04-30 00:24:32.85985	2020-04-30 00:24:32.85985
\.


--
-- Name: settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.settings_id_seq', 1, true);


--
-- Data for Name: shared_accesses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.shared_accesses (id, room_id, user_id, created_at, updated_at) FROM stdin;
\.


--
-- Name: shared_accesses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.shared_accesses_id_seq', 1, false);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, room_id, provider, uid, name, username, email, social_uid, image, password_digest, accepted_terms, created_at, updated_at, email_verified, language, reset_digest, reset_sent_at, activation_digest, activated_at, deleted, role_id) FROM stdin;
1	1	greenlight	gl-jayssoiywsbo	default	\N	wapiti2019@mailinator.com	\N	\N	$2a$12$Fhf8w4lPz7tNV8LfAzU4Ge8Yl.caDSf8wdU.Js8BqR6lmAip5iREi	f	2020-05-04 03:04:55.187062	2020-05-29 01:17:39.494231	f	default	\N	\N	\N	\N	f	4
2	2	greenlight	gl-zqplvkwurljj	Alexandre Martínez Pino	\N	amartinez@koandko.com.mx	\N	https://scontent-qro1-1.xx.fbcdn.net/v/t1.0-9/13102627_10208725353522429_7863338387094008574_n.jpg?_nc_cat=102&_nc_sid=85a577&_nc_eui2=AeFDeFFU27dH5wb66YpAc-fFvzd9ZSGPYe6_N31lIY9h7qEs5H4B4OdjXshDAUhACrY&_nc_ohc=pQ6TXgjBakYAX9kqiAA&_nc_ht=scontent-qro1-1.xx&oh=627cc1ae4f7a07608a824f5b25f50558&oe=5EE44328	$2a$12$z4qaIpz9k659mcUbwJJfoen9P1W20lLG.vX2POspK8L3VBu.mbqBG	f	2020-05-14 19:24:29.368106	2020-05-29 01:17:39.49685	t	default	\N	\N	\N	\N	f	2
3	3	greenlight	gl-dlxrmiakfbcf	pepe grillo	\N	tauroamp@gmail.com	\N	\N	$2a$12$MATH2EU9PnQWDfqhH0kYM.d8fy0V39.SoEz5fMTeespUDF2aevMUu	f	2020-05-15 00:27:26.41587	2020-05-29 01:17:39.498817	f	default	\N	\N	\N	\N	f	1
4	5	greenlight	gl-tstorbhnvuoq	Hector Roldan	\N	hector.roldan.gutierrez@gmail.com	\N	\N	$2a$12$K7TfpVzromOBhMewKZXNo.C1az1grKm7TLzQ4jxp5OeOxwcu.FIbi	f	2020-05-22 15:19:54.129218	2020-05-29 01:17:39.500783	f	default	\N	\N	\N	\N	f	1
6	7	greenlight	gl-azhubhiubnyl	BRANDON	\N	bsan5293@gmail.com	\N	\N	$2a$12$sN4DRok/6f8P2kf3Y72enOCw3/esle.IOUTmXv9NiUg2eQYrJsv/y	f	2020-05-22 15:20:12.268845	2020-05-29 01:17:39.502731	f	default	\N	\N	\N	\N	f	1
5	6	greenlight	gl-jzvmsvrrhjvd	Christian Granillo	\N	cgranillo@koandko.com.mx	\N		$2a$12$3/BRLPDMXEMzCfFJCMM4KeJNh2rYkGLAcb7y8JCCxYsRA6qChpRXG	f	2020-05-22 15:19:58.630152	2020-05-29 01:17:39.504701	f	default	\N	\N	\N	\N	f	2
8	10	greenlight	gl-foqqdbepgrjw	Monitor	\N	chrisrock1@hotmail.com	\N		$2a$12$4T/bRc/tcStVwCk1KHKkC.YemYZZRpSgLtLZnzBolOReE8XanBVhO	f	2020-05-27 03:58:37.028589	2020-05-29 01:17:39.506872	f	es	\N	\N	\N	\N	f	6
7	9	greenlight	gl-ezfmoviapcbs	Ricardo Carpio Sagahón	\N	ssagahon@hotmail.com	\N		$2a$12$sqJTQGP0n4rO1tnJNp9q6OrHvJ/WMyL1FCvUXxaZvzDHePV/Td2Pm	f	2020-05-27 03:55:03.799732	2020-05-29 01:17:39.509728	f	default	\N	\N	\N	\N	f	6
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 8, true);


--
-- Data for Name: users_roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users_roles (user_id, role_id) FROM stdin;
2	1
2	2
3	1
4	1
5	1
6	1
5	2
1	4
8	6
7	6
\.


--
-- Name: ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: features_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.features
    ADD CONSTRAINT features_pkey PRIMARY KEY (id);


--
-- Name: invitations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invitations
    ADD CONSTRAINT invitations_pkey PRIMARY KEY (id);


--
-- Name: role_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_permissions
    ADD CONSTRAINT role_permissions_pkey PRIMARY KEY (id);


--
-- Name: roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: rooms_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rooms
    ADD CONSTRAINT rooms_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: settings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.settings
    ADD CONSTRAINT settings_pkey PRIMARY KEY (id);


--
-- Name: shared_accesses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shared_accesses
    ADD CONSTRAINT shared_accesses_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_features_on_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_features_on_name ON public.features USING btree (name);


--
-- Name: index_features_on_setting_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_features_on_setting_id ON public.features USING btree (setting_id);


--
-- Name: index_invitations_on_invite_token; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_invitations_on_invite_token ON public.invitations USING btree (invite_token);


--
-- Name: index_invitations_on_provider; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_invitations_on_provider ON public.invitations USING btree (provider);


--
-- Name: index_role_permissions_on_role_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_role_permissions_on_role_id ON public.role_permissions USING btree (role_id);


--
-- Name: index_roles_on_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_roles_on_name ON public.roles USING btree (name);


--
-- Name: index_roles_on_name_and_provider; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_roles_on_name_and_provider ON public.roles USING btree (name, provider);


--
-- Name: index_roles_on_priority_and_provider; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_roles_on_priority_and_provider ON public.roles USING btree (priority, provider);


--
-- Name: index_rooms_on_bbb_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_rooms_on_bbb_id ON public.rooms USING btree (bbb_id);


--
-- Name: index_rooms_on_deleted; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_rooms_on_deleted ON public.rooms USING btree (deleted);


--
-- Name: index_rooms_on_last_session; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_rooms_on_last_session ON public.rooms USING btree (last_session);


--
-- Name: index_rooms_on_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_rooms_on_name ON public.rooms USING btree (name);


--
-- Name: index_rooms_on_sessions; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_rooms_on_sessions ON public.rooms USING btree (sessions);


--
-- Name: index_rooms_on_uid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_rooms_on_uid ON public.rooms USING btree (uid);


--
-- Name: index_rooms_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_rooms_on_user_id ON public.rooms USING btree (user_id);


--
-- Name: index_settings_on_provider; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_settings_on_provider ON public.settings USING btree (provider);


--
-- Name: index_shared_accesses_on_room_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_shared_accesses_on_room_id ON public.shared_accesses USING btree (room_id);


--
-- Name: index_shared_accesses_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_shared_accesses_on_user_id ON public.shared_accesses USING btree (user_id);


--
-- Name: index_users_on_created_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_users_on_created_at ON public.users USING btree (created_at);


--
-- Name: index_users_on_deleted; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_users_on_deleted ON public.users USING btree (deleted);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_password_digest; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_users_on_password_digest ON public.users USING btree (password_digest);


--
-- Name: index_users_on_provider; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_users_on_provider ON public.users USING btree (provider);


--
-- Name: index_users_on_role_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_users_on_role_id ON public.users USING btree (role_id);


--
-- Name: index_users_on_room_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_users_on_room_id ON public.users USING btree (room_id);


--
-- Name: index_users_roles_on_role_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_users_roles_on_role_id ON public.users_roles USING btree (role_id);


--
-- Name: index_users_roles_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_users_roles_on_user_id ON public.users_roles USING btree (user_id);


--
-- Name: index_users_roles_on_user_id_and_role_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_users_roles_on_user_id_and_role_id ON public.users_roles USING btree (user_id, role_id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

\connect postgres

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.21
-- Dumped by pg_dump version 9.5.21

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

\connect template1

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.21
-- Dumped by pg_dump version 9.5.21

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DATABASE template1; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE template1 IS 'default template for new databases';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--

