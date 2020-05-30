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
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: features; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.features (
    id integer NOT NULL,
    setting_id integer,
    name character varying NOT NULL,
    value character varying,
    enabled boolean DEFAULT false,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: features_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.features_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: features_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.features_id_seq OWNED BY public.features.id;


--
-- Name: invitations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.invitations (
    id integer NOT NULL,
    email character varying NOT NULL,
    provider character varying NOT NULL,
    invite_token character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: invitations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.invitations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: invitations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.invitations_id_seq OWNED BY public.invitations.id;


--
-- Name: role_permissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.role_permissions (
    id bigint NOT NULL,
    name character varying,
    value character varying DEFAULT ''::character varying,
    enabled boolean DEFAULT false,
    role_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: role_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.role_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: role_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.role_permissions_id_seq OWNED BY public.role_permissions.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- Name: rooms; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.rooms (
    id integer NOT NULL,
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


--
-- Name: rooms_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.rooms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: rooms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.rooms_id_seq OWNED BY public.rooms.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.settings (
    id integer NOT NULL,
    provider character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: settings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.settings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.settings_id_seq OWNED BY public.settings.id;


--
-- Name: shared_accesses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.shared_accesses (
    id bigint NOT NULL,
    room_id bigint,
    user_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: shared_accesses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.shared_accesses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: shared_accesses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.shared_accesses_id_seq OWNED BY public.shared_accesses.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id integer NOT NULL,
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


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: users_roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users_roles (
    user_id integer,
    role_id integer
);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.features ALTER COLUMN id SET DEFAULT nextval('public.features_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.invitations ALTER COLUMN id SET DEFAULT nextval('public.invitations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.role_permissions ALTER COLUMN id SET DEFAULT nextval('public.role_permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rooms ALTER COLUMN id SET DEFAULT nextval('public.rooms_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.settings ALTER COLUMN id SET DEFAULT nextval('public.settings_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shared_accesses ALTER COLUMN id SET DEFAULT nextval('public.shared_accesses_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	production	2020-05-28 23:06:43.888704	2020-05-28 23:06:43.888704
\.


--
-- Data for Name: features; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.features (id, setting_id, name, value, enabled, created_at, updated_at) FROM stdin;
2	1	Legal URL	\N	f	2020-05-29 01:33:09.716241	2020-05-29 01:33:09.716241
3	1	Privacy Policy URL	\N	f	2020-05-29 01:33:09.718879	2020-05-29 01:33:09.718879
4	1	Primary Color	\N	f	2020-05-29 01:33:16.356623	2020-05-29 01:33:16.356623
5	1	Primary Color Lighten	\N	f	2020-05-29 01:33:16.360996	2020-05-29 01:33:16.360996
6	1	Primary Color Darken	\N	f	2020-05-29 01:33:16.364455	2020-05-29 01:33:16.364455
7	1	Registration Method	\N	f	2020-05-29 02:02:20.788258	2020-05-29 02:02:20.788258
8	1	Room Configuration Allow Any Start	\N	f	2020-05-29 02:11:54.133942	2020-05-29 02:11:54.133942
9	1	Shared Access	\N	f	2020-05-29 02:11:54.197835	2020-05-29 02:11:54.197835
10	1	Room Limit	\N	f	2020-05-29 02:11:54.317538	2020-05-29 02:11:54.317538
11	1	Room Configuration Mute On Join	\N	f	2020-05-29 02:11:54.335917	2020-05-29 02:11:54.335917
12	1	Room Configuration Require Moderator	\N	f	2020-05-29 02:11:54.338553	2020-05-29 02:11:54.338553
13	1	Room Configuration All Join Moderator	\N	f	2020-05-29 02:11:54.341212	2020-05-29 02:11:54.341212
14	1	Room Authentication	\N	f	2020-05-29 02:12:12.563264	2020-05-29 02:12:12.563264
15	1	Default Recording Visibility	\N	f	2020-05-29 02:12:12.567341	2020-05-29 02:12:12.567341
1	1	Branding Image	https://koandko.com.mx/images/logo.png	t	2020-05-29 01:33:09.697113	2020-05-29 02:12:38.747817
\.


--
-- Name: features_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.features_id_seq', 15, true);


--
-- Data for Name: invitations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.invitations (id, email, provider, invite_token, created_at, updated_at) FROM stdin;
\.


--
-- Name: invitations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.invitations_id_seq', 1, false);


--
-- Data for Name: role_permissions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.role_permissions (id, name, value, enabled, role_id, created_at, updated_at) FROM stdin;
1	can_create_rooms	true	t	1	2020-05-29 02:10:52.128646	2020-05-29 02:10:52.130288
2	can_create_rooms	true	t	2	2020-05-29 02:10:52.133845	2020-05-29 02:10:52.134906
3	send_promoted_email	true	t	2	2020-05-29 02:10:52.136687	2020-05-29 02:10:52.137629
4	send_demoted_email	true	t	2	2020-05-29 02:10:52.139477	2020-05-29 02:10:52.140406
5	can_edit_site_settings	true	t	2	2020-05-29 02:10:52.142119	2020-05-29 02:10:52.14304
6	can_edit_roles	true	t	2	2020-05-29 02:10:52.144788	2020-05-29 02:10:52.14572
7	can_manage_users	true	t	2	2020-05-29 02:10:52.147452	2020-05-29 02:10:52.148483
8	can_manage_rooms_recordings	true	t	2	2020-05-29 02:10:52.150263	2020-05-29 02:10:52.15128
9	can_create_rooms	true	t	5	2020-05-29 02:10:52.157173	2020-05-29 02:10:52.158274
10	send_promoted_email	true	t	5	2020-05-29 02:10:52.159986	2020-05-29 02:10:52.160739
11	send_demoted_email	true	t	5	2020-05-29 02:10:52.1621	2020-05-29 02:10:52.168989
12	can_edit_site_settings	true	t	5	2020-05-29 02:10:52.170472	2020-05-29 02:10:52.171192
13	can_edit_roles	true	t	5	2020-05-29 02:10:52.172728	2020-05-29 02:10:52.173582
14	can_manage_users	true	t	5	2020-05-29 02:10:52.175134	2020-05-29 02:10:52.175932
15	can_manage_rooms_recordings	true	t	5	2020-05-29 02:10:52.177445	2020-05-29 02:10:52.178307
16	can_appear_in_share_list		f	5	2020-05-29 02:11:54.297541	2020-05-29 02:11:54.297541
17	can_appear_in_share_list		f	4	2020-05-29 02:11:54.301096	2020-05-29 02:11:54.301096
18	can_appear_in_share_list		f	3	2020-05-29 02:11:54.304175	2020-05-29 02:11:54.304175
19	can_appear_in_share_list		f	2	2020-05-29 02:11:54.307221	2020-05-29 02:11:54.307221
20	can_appear_in_share_list		f	1	2020-05-29 02:11:54.310286	2020-05-29 02:11:54.310286
21	can_manage_users		f	1	2020-05-29 05:32:02.96596	2020-05-29 05:32:02.96596
22	can_manage_rooms_recordings		f	1	2020-05-29 05:32:02.969591	2020-05-29 05:32:02.969591
23	can_edit_site_settings		f	1	2020-05-29 05:32:02.972181	2020-05-29 05:32:02.972181
24	can_edit_roles		f	1	2020-05-29 05:32:02.974604	2020-05-29 05:32:02.974604
\.


--
-- Name: role_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.role_permissions_id_seq', 24, true);


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.roles (id, name, priority, can_create_rooms, send_promoted_email, send_demoted_email, can_edit_site_settings, can_edit_roles, can_manage_users, colour, provider, created_at, updated_at) FROM stdin;
1	user	1	f	f	f	f	f	f	#868e96	greenlight	2020-05-29 02:10:52.107472	2020-05-29 02:10:52.107472
2	admin	0	f	f	f	f	f	f	#f1c40f	greenlight	2020-05-29 02:10:52.131726	2020-05-29 02:10:52.131726
3	pending	-1	f	f	f	f	f	f	#17a2b8	greenlight	2020-05-29 02:10:52.152531	2020-05-29 02:10:52.152531
4	denied	-2	f	f	f	f	f	f	#343a40	greenlight	2020-05-29 02:10:52.153792	2020-05-29 02:10:52.153792
5	super_admin	-3	f	f	f	f	f	f	#cd201f	greenlight	2020-05-29 02:10:52.155056	2020-05-29 02:10:52.155056
\.


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.roles_id_seq', 5, true);


--
-- Data for Name: rooms; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.rooms (id, user_id, name, uid, bbb_id, sessions, last_session, created_at, updated_at, room_settings, moderator_pw, attendee_pw, access_code, deleted) FROM stdin;
1	1	Sala principal	ale-5qr-dll	obgzw1kcyr4dhx4bu3colokjuhctfbpqs1luemgq	0	\N	2020-05-29 02:10:52.233135	2020-05-29 02:10:52.233135	{ }	oXscXdWDOXFi	HoKeiRLFlDFa	\N	f
2	2	Sala principal	chr-uwx-u02	dvzkcwiyumjedqfcevxol1ppkc1v067xsvlniega	0	\N	2020-05-29 05:32:02.841237	2020-05-29 05:32:02.841237	{ }	tMzkVCQcbrnh	SDMQSsCSlYsb	\N	f
\.


--
-- Name: rooms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.rooms_id_seq', 2, true);


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.schema_migrations (version) FROM stdin;
20180504131648
20180504131705
20180920193451
20181113174230
20181217142710
20190122210632
20190206210049
20190312003555
20190314152108
20190326144939
20190507190710
20190522193828
20190522194037
20190522194445
20190522195242
20190711192033
20190726153012
20190822134205
20190828153347
20191023172511
20191128212935
20200130144841
20200413150518
\.


--
-- Data for Name: settings; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.settings (id, provider, created_at, updated_at) FROM stdin;
1	greenlight	2020-05-29 01:33:09.360455	2020-05-29 01:33:09.360455
\.


--
-- Name: settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.settings_id_seq', 1, true);


--
-- Data for Name: shared_accesses; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.shared_accesses (id, room_id, user_id, created_at, updated_at) FROM stdin;
\.


--
-- Name: shared_accesses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.shared_accesses_id_seq', 1, false);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.users (id, room_id, provider, uid, name, username, email, social_uid, image, password_digest, accepted_terms, created_at, updated_at, email_verified, language, reset_digest, reset_sent_at, activation_digest, activated_at, deleted, role_id) FROM stdin;
1	1	greenlight	gl-bbsmjeyibzni	Alex	\N	amartinez@koandko.com.mx	\N	\N	$2a$12$uL1gjcr5Me/H7ncApvFVMerdQwl38ttjZB4GVaUuByR7UXqxQjSjy	t	2020-05-29 02:10:52.079422	2020-05-29 02:10:52.299127	t	default	\N	\N	\N	\N	f	2
2	2	greenlight	gl-rprtpzqjouwr	Christian Granillo	\N	cgranillo@koandko.com.mx	\N	\N	$2a$12$xulfwfOG26Qj0W/J.2spnuCKftF3SVBnMCzLgSzhUvcIzV7aJ6iLu	f	2020-05-29 05:32:02.826382	2020-05-29 05:32:02.913011	f	default	\N	\N	\N	\N	f	1
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.users_id_seq', 2, true);


--
-- Data for Name: users_roles; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.users_roles (user_id, role_id) FROM stdin;
\.


--
-- Name: ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: features_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.features
    ADD CONSTRAINT features_pkey PRIMARY KEY (id);


--
-- Name: invitations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.invitations
    ADD CONSTRAINT invitations_pkey PRIMARY KEY (id);


--
-- Name: role_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.role_permissions
    ADD CONSTRAINT role_permissions_pkey PRIMARY KEY (id);


--
-- Name: roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: rooms_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rooms
    ADD CONSTRAINT rooms_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: settings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.settings
    ADD CONSTRAINT settings_pkey PRIMARY KEY (id);


--
-- Name: shared_accesses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shared_accesses
    ADD CONSTRAINT shared_accesses_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_features_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_features_on_name ON public.features USING btree (name);


--
-- Name: index_features_on_setting_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_features_on_setting_id ON public.features USING btree (setting_id);


--
-- Name: index_invitations_on_invite_token; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_invitations_on_invite_token ON public.invitations USING btree (invite_token);


--
-- Name: index_invitations_on_provider; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_invitations_on_provider ON public.invitations USING btree (provider);


--
-- Name: index_role_permissions_on_role_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_role_permissions_on_role_id ON public.role_permissions USING btree (role_id);


--
-- Name: index_roles_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_roles_on_name ON public.roles USING btree (name);


--
-- Name: index_roles_on_name_and_provider; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_roles_on_name_and_provider ON public.roles USING btree (name, provider);


--
-- Name: index_roles_on_priority_and_provider; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_roles_on_priority_and_provider ON public.roles USING btree (priority, provider);


--
-- Name: index_rooms_on_bbb_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_rooms_on_bbb_id ON public.rooms USING btree (bbb_id);


--
-- Name: index_rooms_on_deleted; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_rooms_on_deleted ON public.rooms USING btree (deleted);


--
-- Name: index_rooms_on_last_session; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_rooms_on_last_session ON public.rooms USING btree (last_session);


--
-- Name: index_rooms_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_rooms_on_name ON public.rooms USING btree (name);


--
-- Name: index_rooms_on_sessions; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_rooms_on_sessions ON public.rooms USING btree (sessions);


--
-- Name: index_rooms_on_uid; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_rooms_on_uid ON public.rooms USING btree (uid);


--
-- Name: index_rooms_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_rooms_on_user_id ON public.rooms USING btree (user_id);


--
-- Name: index_settings_on_provider; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_settings_on_provider ON public.settings USING btree (provider);


--
-- Name: index_shared_accesses_on_room_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_shared_accesses_on_room_id ON public.shared_accesses USING btree (room_id);


--
-- Name: index_shared_accesses_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_shared_accesses_on_user_id ON public.shared_accesses USING btree (user_id);


--
-- Name: index_users_on_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_created_at ON public.users USING btree (created_at);


--
-- Name: index_users_on_deleted; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_deleted ON public.users USING btree (deleted);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_password_digest; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_password_digest ON public.users USING btree (password_digest);


--
-- Name: index_users_on_provider; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_provider ON public.users USING btree (provider);


--
-- Name: index_users_on_role_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_role_id ON public.users USING btree (role_id);


--
-- Name: index_users_on_room_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_room_id ON public.users USING btree (room_id);


--
-- Name: index_users_roles_on_role_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_roles_on_role_id ON public.users_roles USING btree (role_id);


--
-- Name: index_users_roles_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_roles_on_user_id ON public.users_roles USING btree (user_id);


--
-- Name: index_users_roles_on_user_id_and_role_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_roles_on_user_id_and_role_id ON public.users_roles USING btree (user_id, role_id);


--
-- Name: fk_rails_60126080bd; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.role_permissions
    ADD CONSTRAINT fk_rails_60126080bd FOREIGN KEY (role_id) REFERENCES public.roles(id);


--
-- Name: fk_rails_9946f3f4cf; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shared_accesses
    ADD CONSTRAINT fk_rails_9946f3f4cf FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: fk_rails_e557734f55; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shared_accesses
    ADD CONSTRAINT fk_rails_e557734f55 FOREIGN KEY (room_id) REFERENCES public.rooms(id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: -
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

