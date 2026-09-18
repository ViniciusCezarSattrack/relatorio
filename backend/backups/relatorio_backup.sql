--
-- PostgreSQL database dump
--

\restrict 3jnaYqNveKMdcnO5GtjabmprHjPvBh7cVaP74hVIFaqUVsh5sq9SSk7hRD44MsZ

-- Dumped from database version 16.13
-- Dumped by pg_dump version 16.13

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

--
-- Name: user_role; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.user_role AS ENUM (
    'ADMIN',
    'USER'
);


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: agents; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.agents (
    id integer NOT NULL,
    branch_id integer NOT NULL,
    sector_id integer NOT NULL,
    name character varying(255) NOT NULL,
    active boolean DEFAULT true NOT NULL
);


--
-- Name: agents_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.agents_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: agents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.agents_id_seq OWNED BY public.agents.id;


--
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);


--
-- Name: branches; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.branches (
    id integer NOT NULL,
    name character varying(120) NOT NULL,
    active boolean DEFAULT true NOT NULL
);


--
-- Name: branches_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.branches_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: branches_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.branches_id_seq OWNED BY public.branches.id;


--
-- Name: monthly_report_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.monthly_report_items (
    id integer NOT NULL,
    report_id integer NOT NULL,
    agent_id integer NOT NULL,
    tickets_finalizados integer DEFAULT 0 NOT NULL,
    raw_name_from_excel character varying(255),
    baldussi_destino integer DEFAULT 0 NOT NULL,
    baldussi_origem integer DEFAULT 0 NOT NULL,
    blip integer DEFAULT 0 NOT NULL
);


--
-- Name: monthly_report_items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.monthly_report_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: monthly_report_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.monthly_report_items_id_seq OWNED BY public.monthly_report_items.id;


--
-- Name: monthly_reports; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.monthly_reports (
    id integer NOT NULL,
    branch_id integer NOT NULL,
    month integer NOT NULL,
    year integer NOT NULL,
    created_by integer NOT NULL,
    created_at timestamp with time zone NOT NULL
);


--
-- Name: monthly_reports_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.monthly_reports_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: monthly_reports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.monthly_reports_id_seq OWNED BY public.monthly_reports.id;


--
-- Name: pending_import_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pending_import_items (
    id integer NOT NULL,
    report_id integer NOT NULL,
    raw_name_from_excel character varying(255) NOT NULL,
    tickets_finalizados integer DEFAULT 0 NOT NULL,
    resolved boolean DEFAULT false NOT NULL,
    resolved_agent_id integer
);


--
-- Name: pending_import_items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.pending_import_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pending_import_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.pending_import_items_id_seq OWNED BY public.pending_import_items.id;


--
-- Name: sectors; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sectors (
    id integer NOT NULL,
    branch_id integer NOT NULL,
    name character varying(120) NOT NULL,
    color character varying(30),
    active boolean DEFAULT true NOT NULL
);


--
-- Name: sectors_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.sectors_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sectors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.sectors_id_seq OWNED BY public.sectors.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name character varying(120) NOT NULL,
    email character varying(255) NOT NULL,
    password_hash character varying(255) NOT NULL,
    role public.user_role DEFAULT 'USER'::public.user_role NOT NULL,
    active boolean DEFAULT true NOT NULL,
    created_at timestamp with time zone NOT NULL,
    last_seen_at timestamp with time zone
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    AS integer
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
-- Name: agents id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agents ALTER COLUMN id SET DEFAULT nextval('public.agents_id_seq'::regclass);


--
-- Name: branches id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.branches ALTER COLUMN id SET DEFAULT nextval('public.branches_id_seq'::regclass);


--
-- Name: monthly_report_items id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.monthly_report_items ALTER COLUMN id SET DEFAULT nextval('public.monthly_report_items_id_seq'::regclass);


--
-- Name: monthly_reports id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.monthly_reports ALTER COLUMN id SET DEFAULT nextval('public.monthly_reports_id_seq'::regclass);


--
-- Name: pending_import_items id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pending_import_items ALTER COLUMN id SET DEFAULT nextval('public.pending_import_items_id_seq'::regclass);


--
-- Name: sectors id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sectors ALTER COLUMN id SET DEFAULT nextval('public.sectors_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: agents; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.agents (id, branch_id, sector_id, name, active) FROM stdin;
98	7	48	Larissa Soares - Vendas (CWB)	t
99	7	48	Karol Schamne - Vendas (CWB)	t
6	9	19	Natalia Caroline - Vendas	t
7	9	19	Natalya Nagyla - Vendas	t
8	9	19	Michele Rocha - Vendas	t
9	9	18	Raphaelle Nayara - Financeiro	t
10	9	18	Ana Clara Costa - Financeiro	t
11	9	25	Jerlane Correa - SAC	t
12	9	18	Giovanna Gomes - Financeiro	t
14	9	16	Beatriz Alves - Suporte	t
15	9	23	Yasmin Dandara - Agendamento	t
18	9	20	Nathalia Franco - Pós-Vendas	t
19	9	23	Amanda Miné - Agendamento	t
20	9	20	Caroline Paola - Pós-Vendas	t
21	9	19	Amanda Alves - Vendas	t
22	9	20	Fernanda Teixeira - Pós-Vendas	t
23	9	19	Jordana Mafra - Vendas	t
24	9	20	Julia Andrade - Pós-Vendas	t
25	9	24	Ludiane Araujo - Guincho	t
26	9	21	Mariany Matos - Pré-Jurídico	t
27	9	19	Patrícia Correa - Vendas	t
28	9	19	Rafaela Bononi - Vendas	t
29	9	19	Ricardo Silva	t
30	9	25	Bruna Basso - SAC	t
31	9	20	Emanuelle Vidal - Pós-Vendas	t
32	9	25	Janiele - SAC	t
33	9	24	Lais Teixeira	t
34	9	18	Lorrayne de Morais - Financeiro	t
35	9	19	Priscilla Martins - Vendas	t
36	9	20	Vanessa Montini - Pós-Vendas	t
37	9	16	Isabela Pereira - Suporte	t
38	9	25	Isabella Bueno - SAC	t
39	9	16	Julia Camille - Suporte	t
40	9	22	Evelyn Nogueira - Plus	t
41	9	25	Percia Ledo - SAC	t
42	9	22	Sumaya Larissa - Plus	t
43	9	22	Tainá Oliveira - Plus	t
44	9	16	Vitor Hugo - Suporte/Frota	t
45	9	18	Isabela Igarashi - Financeiro	t
46	9	18	Isabelle Duszeiko - Financeiro	t
48	9	21	anacarolinaoliveira.sattrack@gmail.com	t
49	9	19	allanjorge.sattrack@gmail.com	t
50	9	18	Fernanda Santos	t
51	9	18	Fatima Galbero - Gestora Financeira	t
13	9	17	Emanuelle Vitória - Financeiro	t
17	9	17	Maria Fernanda - Financeiro	t
16	9	17	Nicoly Barbosa - Financeiro	t
52	9	22	Luiza - Supervisora	t
53	9	23	Gabrielle Maciel - Agendamento	t
54	9	23	Evelin Milan - Agendamento	t
55	9	23	Taine - Agendamento	t
56	9	23	Gabriela Mesquini - Agendamento	t
57	9	23	Luana Fernandes - Agendamento	t
58	8	31	Emanuelle Vidal - Pós-Vendas	t
59	8	37	Erica da Costa - Vendas (MGA)	t
60	8	27	Micaelly - Agendamento (MGA)	t
61	8	36	Vitor Hugo - Suporte/Frota	t
62	8	37	Amanda Saunite - Vendas (MGA)	t
63	8	37	Rayane Zavatini - Vendas (MGA)	t
64	8	30	Geovana Mendes - Plus (MGA)	t
65	8	32	anacarolinaoliveira.sattrack@gmail.com	t
66	8	36	Julia Camille - Suporte	t
67	8	31	Rafaeli Pereira - Pós-Vendas (MGA)	t
68	8	32	Mariany Matos - Pré-Jurídico	t
69	8	36	Isabela Pereira - Suporte	t
70	8	27	Tatiane Regina - Agendamento (MGA)	t
71	8	28	Lorrayne de Morais - Financeiro	t
72	8	28	Fernanda Santos	t
73	8	37	Raissa Zavatini - Vendas (MGA)	t
74	8	36	Beatriz Alves - Suporte	t
75	8	35	Nicoly Barbosa - Financeiro	t
76	8	31	Amanda Pereira - Pós-Vendas	t
77	8	28	Isabela Igarashi - Financeiro	t
78	8	28	Fatima Galbero - Gestora Financeira	t
79	8	33	Camila Dionisio - Recepção (MGA)	t
80	8	35	Maria Fernanda - Financeiro	t
81	8	28	Janaina Torres - Financeiro	t
82	8	35	Emanuelle Vitória - Financeiro	t
83	8	28	Isabelle Duszeiko - Financeiro	t
84	7	43	anacarolinaoliveira.sattrack@gmail.com	t
85	7	47	Vitor Hugo - Suporte/Frota	t
86	7	48	Natalya Nagyla - Vendas	t
87	7	38	Daniele Campanholi - Agendamento (CWB)	t
88	7	43	Mariany Matos - Pré-Jurídico	t
89	7	41	Giovana Ferreira - Plus (CWB)	t
90	7	42	Vanessa Montini - Pós-Vendas	t
91	7	39	Lorrayne de Morais - Financeiro	t
92	7	42	Nathalia Franco - Pós-Vendas	t
93	7	47	Julia Camille - Suporte	t
94	7	47	Isabela Pereira - Suporte	t
95	7	47	Beatriz Alves - Suporte	t
96	7	39	Fernanda Santos	t
97	7	42	Caroline Paola - Pós-Vendas	t
100	7	42	Emanuelle Vidal - Pós-Vendas	t
102	7	42	Fernanda Teixeira - Pós-Vendas	t
103	7	48	Nathalia Covas - Vendas (CWT)	t
104	7	39	Fatima Galbero - Gestora Financeira	t
105	7	48	Ana Luiza Montenegro - Vendas (CWB)	t
107	7	44	Recepção - Curitiba	t
108	7	39	Isabela Igarashi - Financeiro	t
109	7	39	Isabelle Duszeiko - Financeiro	t
110	7	39	Janaina Torres - Financeiro	t
112	7	42	rafaeliferreira.sattrack@gmail.com	t
113	7	48	Jaqueline Gomes	t
106	7	46	Emanuelle Vitória - Financeiro	t
111	7	46	Maria Fernanda - Financeiro	t
101	7	46	Nicoly Barbosa - Financeiro	t
114	10	52	Tainá Oliveira - Plus	t
115	10	53	Nathalia Franco - Pós-Vendas	t
116	10	59	Luana Santos - Vendas (PG)	t
117	10	56	Isabella Bueno - SAC	t
118	10	52	Evelyn Nogueira - Plus	t
119	10	53	Vanessa Montini - Pós-Vendas	t
121	10	52	Sumaya Larissa - Plus	t
122	10	55	Nayani Oliveira - Recepção	t
123	10	50	Lorrayne de Morais - Financeiro	t
124	10	58	Isabela Pereira - Suporte	t
126	10	53	Caroline Paola - Pós-Vendas	t
128	10	51	Lais Teixeira	t
129	10	58	Julia Camille - Suporte	t
130	10	53	Emanuelle Vidal - Pós-Vendas	t
131	10	50	Fatima Galbero - Gestora Financeira	t
139	10	50	Isabela Igarashi - Financeiro	t
141	10	55	Kauane Oliveira - Recepção (PG)	t
142	10	59	Carolina de Paula - Vendas (PG)	t
120	10	58	Vitor Hugo - Suporte/Frota	t
125	10	50	Fernanda Santos	t
127	10	58	Beatriz Alves - Suporte	t
132	10	53	Fernanda Teixeira - Pós-Vendas	t
133	10	57	Nicoly Barbosa - Financeiro	t
134	10	51	Ludiane Araujo - Guincho	t
135	10	53	Julia Andrade - Pós-Vendas	t
136	10	57	Maria Fernanda - Financeiro	t
137	10	59	Beatriz Loures - Vendas (PG)	t
138	10	50	Janaina Torres - Financeiro	t
140	10	57	Emanuelle Vitória - Financeiro	t
143	10	50	Isabelle Duszeiko - Financeiro	t
144	9	26	Debora - Recepção	t
145	9	17	Ysabella Matos	t
146	9	21	Maria Garrido	t
147	9	20	Aliane Rezende - Gestora Pós-Vendas	t
148	9	16	Sattrack Rastreamento	t
149	9	19	Nathalia Covas - Vendas (CWT)	t
150	9	22	Luiza Leticia - Plus	t
151	9	22	Luiza Leticia - Supervisora	t
152	9	16	DBG_1772826747_9017816_1	t
153	9	16	DBG_1772826747_9017816_2	t
154	9	16	DBG_1772826747_9017816_3	t
155	9	16	DBG_1772826747_9017816_4	t
156	8	32	Maria Garrido	t
157	8	35	Ysabella Matos	t
158	8	37	Larissa Pereira - Vendas	t
159	8	30	Giovana - Plus	t
160	7	46	Ysabella Matos	t
161	7	43	Maria Garrido	t
162	7	48	Nathalia De Paula - Vendas	t
163	10	57	Ysabella Matos	t
164	10	59	Luana Santos - Vendas	t
165	9	19	Ana Paula Alves - Vendas	t
166	9	24	Thayrini Dantas - Guincho	t
167	9	18	raphaelle.sattrack@gmail.com	t
168	9	18	Nicolly Rocha	t
169	9	22	Carla - Plus	t
170	9	23	Taine Dias - Agendamento	t
171	9	23	Marcela - Agendamento	t
172	9	23	Luana - Agendamento	t
173	8	37	viniciuslessa.sattrack@gmail.com	t
174	8	31	Caroline Paola - Pós-Vendas	t
175	8	31	Nathalia Franco - Pós-Vendas	t
176	8	31	Vanessa Montini - Pós-Vendas	t
177	8	31	Fernanda Teixeira - Pós-Vendas	t
178	8	31	Julia Andrade - Pós-Vendas	t
179	7	48	Franciele Martins - Vendas (CWB)	t
180	6	11	Nathalia Franco - Pós-Vendas	t
181	6	9	Isabelle Duszeiko - Financeiro	t
182	6	9	Janaina Torres - Financeiro	t
183	6	10	Isabelle Simionatto - Vendas (CAS)	t
184	6	10	Rosenice Andrade - Vendas (CAS)	t
185	6	10	Alana Dinkel - Vendas (CAS)	t
186	6	15	Bruna Basso - SAC	t
187	6	60	Maria Cavalheiro - Recepção (CAS)	t
188	6	60	Nayani Oliveira - Recepção	t
189	9	17	Emanuella Paiva - Serasa	t
190	9	22	Nathalia Nunes - Plus	t
191	9	22	Nicoly Barbosa - Plus	t
192	9	18	Ana Neves - Financeiro	t
193	6	10	Alana - Vendas (CAS)	t
194	6	10	Jessica - Vendas (CAS)	t
195	8	37	Erica Marlene - Vendas (MGA)	t
196	8	37	Larissa Pereira - Vendas (MGA)	t
197	8	28	Geovana Cavalaro - Financeiro (MGA)	t
198	7	48	Nathalia de Paula - Vendas (CWB)	t
199	7	41	Giovana Lima - Plus (CWB)	t
201	9	18	Janaina Torres - Financeiro	t
202	9	61	Kattellyn Dantas - Locadora	t
200	9	18	Ana Julia Neves	t
203	6	9	Emanuelle Vitória - Financeiro	t
204	6	9	Maria Fernanda - Financeiro	t
205	6	14	Ludiane Araujo - Guincho	t
206	6	15	Janiele - SAC	t
207	6	13	Sumaya Larissa - Plus	t
208	6	14	Thayrini Dantas - Guincho	t
209	7	39	Ana Julia Neves	t
210	7	39	Emanuella Paiva	t
211	8	28	Emanuella Paiva	t
212	8	28	Ana Julia Neves	t
213	8	62	Kattellyn Dantas - Locadora	t
214	10	51	Thayrini Dantas - Guincho	t
215	10	50	Emanuella Paiva	t
216	10	50	Ana Julia Neves	t
217	9	18	Nicolly Rocha - Financeiro	t
218	9	26	Débora Araujo - Recepção	t
220	9	23	Yasmim Dandara	t
221	9	20	Fernanda Silva Teixeira - Vendas	t
222	9	23	Evelin Klem - Agendamento	t
223	9	22	Carla Cristina - Plus	t
224	9	19	natalya.sattrack@gmail.com	t
225	9	21	Beatriz Amaly De Mello Ribeirete	t
226	9	22	Nathália Nunes - Plus	t
227	9	20	Danielle Siqueira - Pós-Vendas (MGA)	t
228	9	21	Rafaela Oliveira - Adm	t
229	8	31	Danielle Siqueira - Pós-Vendas (MGA)	t
230	8	31	Juliana Aparecida - Pós-Vendas (MGA)	t
231	8	32	Beatriz Amaly De Mello Ribeirete	t
232	7	42	Fernanda Silva Teixeira - Vendas	t
233	7	42	Melany - Pós-Vendas (CWB)	t
234	7	48	Ingrid Hampf - Vendas (CWB)	t
235	7	48	natalya.sattrack@gmail.com	t
236	7	43	Beatriz Amaly De Mello Ribeirete	t
237	10	52	Carla Cristina - Plus	t
238	10	56	Bruna Basso - SAC	t
239	10	52	Nathália Nunes - Plus	t
240	10	53	Fernanda Silva Teixeira - Vendas	t
241	6	11	Julia Andrade - Pós-Vendas	t
242	6	10	Ana Julia Neves	t
243	6	10	Jessica Eliete - Vendas (CAS)	t
47	9	26	Recepção	t
244	9	19	Natalia Conde - Vendas	t
245	9	16	Vitor Hugo - Suporte	t
246	9	21	Karina - Pré-Juridico	t
247	8	33	Recepção	t
248	8	37	Erica - Vendas	t
249	7	41	Giovana Lima - Plus	t
250	9	26	Nayani Oliveira - Recepção	t
251	8	36	Isabela Dos Santos Pereira	t
252	8	28	Raphaelle Nayara - Financeiro	t
253	8	28	Nicolly Rocha - Financeiro	t
254	8	28	Giovanna Gomes - Financeiro	t
255	8	37	palomagabrielle.sattrack@gmail.com	t
256	7	41	Sumaya Larissa - Plus	t
257	7	39	Nicolly Rocha - Financeiro	t
258	7	39	Giovanna Gomes - Financeiro	t
259	7	39	Raphaelle Nayara - Financeiro	t
260	7	42	Fernanda Silva Teixeira - Pós-Vendas	t
261	7	47	Isabela Dos Santos Pereira	t
262	7	41	Carla Cristina - Plus	t
263	10	59	Taciane Kolodo - Vendas (PG)	t
264	10	50	Nicolly Rocha - Financeiro	t
265	10	50	Giovanna Gomes - Financeiro	t
266	10	58	Isabela Dos Santos Pereira	t
267	10	50	Raphaelle Nayara - Financeiro	t
268	10	56	Jerlane Correa - SAC	t
269	10	53	Fernanda Silva Teixeira - Pós-Vendas	t
270	6	8	Beatriz Alves - Suporte	t
271	6	7	Emanuella Paiva	t
272	9	19	Natalia Conde	t
273	9	23	Marcela	t
274	9	23	Gabriela Mesquini	t
275	9	23	Gabrielle Maciel	t
219	9	17	Emanuella Paiva	t
276	9	16	Vitor Hugo	t
277	9	16	Leonardo	t
278	9	22	Luiza	t
279	9	22	Nicoly Barbosa	t
280	9	21	Karina	t
281	8	27	Tatiane Regina	t
282	7	42	Melany	t
283	9	61	lorena caroline	t
284	9	20	Larissa Tatiane - Pós-Vendas	t
285	9	20	Fernanda Silva Teixeira - Pós-Vendas	t
286	9	18	Adriele Gasperi	t
288	8	28	Debora Correa	t
289	8	28	Adriele Gasperi	t
290	8	27	Julia Clemes - Agendamento (MGA)	t
291	7	39	Adriele Gasperi	t
292	7	41	Evelyn Nogueira - Plus	t
293	7	39	Debora Correa	t
294	10	50	Adriele Gasperi	t
295	10	50	Debora Correa	t
296	6	11	Caroline Paola - Pós-Vendas	t
297	6	9	Adriele Gasperi	t
298	6	10	Jessica - Vendas	t
299	9	26	Julia - Recepção	t
300	9	25	Larissa Azevedo	t
301	9	18	Michele Silva	t
302	9	18	Janaina	t
303	9	18	Ana Neves	t
304	9	18	Isabelle Duszeiko	t
287	9	21	Debora Correa	t
305	8	28	Geovana Cavalaro	t
306	7	38	Daniele Gonçalves	t
\.


--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.alembic_version (version_num) FROM stdin;
20260307_0003
\.


--
-- Data for Name: branches; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.branches (id, name, active) FROM stdin;
7	Curitiba	t
8	Maringa	t
9	Londrina	t
10	Ponta Grossa	t
6	Cascavel	t
\.


--
-- Data for Name: monthly_report_items; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.monthly_report_items (id, report_id, agent_id, tickets_finalizados, raw_name_from_excel, baldussi_destino, baldussi_origem, blip) FROM stdin;
1	1	9	1710	Raphaelle Nayara - Financeiro	278	96	1336
2	1	10	1618	Ana Clara Costa - Financeiro	379	152	1087
3	1	13	970	Emanuelle Vitória - Financeiro	38	4	928
4	1	12	1200	Giovanna Gomes - Financeiro	223	63	914
5	1	17	984	Maria Fernanda - Financeiro	87	10	887
7	1	16	329	Nicoly Barbosa - Financeiro	20	5	304
8	1	14	597	Beatriz Alves - Suporte	227	99	271
9	1	24	370	Julia Andrade - Pós-Vendas	77	37	256
10	1	39	619	Julia Camille - Suporte	291	103	225
11	1	37	482	Isabela Pereira - Suporte	177	84	221
12	1	22	331	Fernanda Teixeira - Pós-Vendas	106	42	183
13	1	31	338	Emanuelle Vidal - Pós-Vendas	85	91	162
14	1	23	194	Jordana Mafra - Vendas	33	10	151
42	1	48	15	anacarolinaoliveira.sattrack@gmail.com	2	0	13
16	1	25	392	Ludiane Araujo - Guincho	258	25	109
274	6	44	108	Vitor Hugo - Suporte/Frota	32	25	51
18	1	7	252	Natalya Nagyla - Vendas	97	58	97
19	1	6	150	Natalia Caroline - Vendas	37	23	90
20	1	8	155	Michele Rocha - Vendas	63	6	86
21	1	38	572	Isabella Bueno - SAC	1	493	78
22	1	18	209	Nathalia Franco - Pós-Vendas	77	56	76
23	1	20	135	Caroline Paola - Pós-Vendas	50	10	75
24	1	28	146	Rafaela Bononi - Vendas	37	46	63
25	1	11	145	Jerlane Correa - SAC	8	78	59
26	1	42	221	Sumaya Larissa - Plus	140	22	59
27	1	36	175	Vanessa Montini - Pós-Vendas	74	42	59
28	1	35	64	Priscilla Martins - Vendas	17	12	35
29	1	32	134	Janiele - SAC	7	93	34
30	1	34	39	Lorrayne de Morais - Financeiro	2	4	33
31	1	33	238	Lais Teixeira	201	6	31
32	1	41	27	Percia Ledo - SAC	0	0	27
33	1	44	72	Vitor Hugo - Suporte/Frota	37	9	26
34	1	21	139	Amanda Alves - Vendas	93	23	23
35	1	27	44	Patrícia Correa - Vendas	17	7	20
36	1	43	163	Tainá Oliveira - Plus	117	26	20
37	1	26	52	Mariany Matos - Pré-Jurídico	17	23	12
38	1	40	205	Evelyn Nogueira - Plus	170	25	10
39	1	45	239	Isabela Igarashi - Financeiro	102	132	5
40	1	46	257	Isabelle Duszeiko - Financeiro	137	61	59
41	1	47	2786	Nayani Oliveira - Recepção	980	813	993
6	1	30	642	Bruna Basso - SAC	0	309	333
43	1	49	67	allanjorge.sattrack@gmail.com	0	0	67
44	1	50	422	Fernanda Santos	0	0	422
45	1	51	397	Fatima Galbero - Gestora Financeira	1	29	367
53	1	29	0	Ricardo Silva	0	0	0
15	1	15	133	Yasmin Dandara - Agendamento	0	13	120
17	1	19	137	Amanda Miné - Agendamento	2	32	103
47	1	54	72	Evelin Milan - Agendamento	63	9	0
446	10	73	18	Raissa Zavatini - Vendas (MGA)	6	0	12
275	6	33	359	Lais Teixeira	290	31	38
356	8	162	6	Nathalia De Paula - Vendas	2	4	0
291	6	40	303	Evelyn Nogueira - Plus	291	12	0
293	6	52	50	Luiza - Supervisora	35	15	0
326	7	157	97	Ysabella Matos	0	0	97
448	10	63	47	Rayane Zavatini - Vendas (MGA)	39	0	8
420	2	166	266	Thayrini Dantas - Guincho	247	13	6
421	2	167	1737	raphaelle.sattrack@gmail.com	323	140	1274
441	10	62	88	Amanda Saunite - Vendas (MGA)	54	1	33
445	10	64	25	Geovana Mendes - Plus (MGA)	9	0	16
427	2	56	155	Gabriela Mesquini - Agendamento	107	48	0
428	2	53	101	Gabrielle Maciel - Agendamento	53	48	0
430	10	81	669	Janaina Torres - Financeiro	0	0	669
431	10	83	390	Isabelle Duszeiko - Financeiro	0	0	390
432	10	77	379	Isabela Igarashi - Financeiro	0	0	379
434	10	80	157	Maria Fernanda - Financeiro	0	0	157
435	10	82	153	Emanuelle Vitória - Financeiro	0	0	153
436	10	75	92	Nicoly Barbosa - Financeiro	0	0	92
437	10	78	66	Fatima Galbero - Gestora Financeira	0	0	66
438	10	74	39	Beatriz Alves - Suporte	0	0	39
439	10	68	38	Mariany Matos - Pré-Jurídico	0	0	38
442	10	69	21	Isabela Pereira - Suporte	0	0	21
443	10	58	19	Emanuelle Vidal - Pós-Vendas	0	0	19
444	10	66	17	Julia Camille - Suporte	0	0	17
48	1	56	138	Gabriela Mesquini - Agendamento	110	28	0
49	1	53	79	Gabrielle Maciel - Agendamento	37	42	0
50	1	57	39	Luana Fernandes - Agendamento	29	10	0
51	1	55	158	Taine - Agendamento	133	25	0
52	1	52	35	Luiza - Supervisora	17	18	0
191	1	144	1363	Debora - Recepção	571	792	0
447	10	60	8	Micaelly - Agendamento (MGA)	0	0	8
433	10	79	672	Camila Dionisio - Recepção (MGA)	443	4	225
440	10	70	115	Tatiane Regina - Agendamento (MGA)	78	2	35
390	2	39	872	Julia Camille - Suporte	455	173	244
350	8	89	46	Giovana Ferreira - Plus (CWB)	35	8	3
358	9	142	124	Carolina de Paula - Vendas (PG)	9	65	50
347	8	87	98	Daniele Campanholi - Agendamento (CWB)	43	49	6
385	2	13	699	Emanuelle Vitória - Financeiro	47	4	648
333	8	107	483	Recepção - Curitiba	292	49	142
357	9	136	81	Maria Fernanda - Financeiro	0	0	81
359	9	138	49	Janaina Torres - Financeiro	0	0	49
361	9	125	21	Fernanda Santos	0	0	21
362	9	133	8	Nicoly Barbosa - Financeiro	0	0	8
363	9	121	5	Sumaya Larissa - Plus	0	0	5
364	9	127	4	Beatriz Alves - Suporte	0	0	4
365	9	135	4	Julia Andrade - Pós-Vendas	0	0	4
366	9	129	3	Julia Camille - Suporte	0	0	3
107	3	60	4	Micaelly - Agendamento (MGA)	0	0	4
126	3	79	595	Camila Dionisio - Recepção (MGA)	401	2	192
120	3	73	38	Raissa Zavatini - Vendas (MGA)	3	0	35
109	3	62	43	Amanda Saunite - Vendas (MGA)	34	2	7
110	3	63	33	Rayane Zavatini - Vendas (MGA)	26	0	7
106	3	59	36	Erica da Costa - Vendas (MGA)	33	0	3
119	3	72	28	Fernanda Santos	0	0	28
134	4	87	109	Daniele Campanholi - Agendamento (CWB)	42	60	7
123	3	76	117	Amanda Pereira - Pós-Vendas	0	0	117
136	4	89	43	Giovana Ferreira - Plus (CWB)	31	3	9
128	3	81	231	Janaina Torres - Financeiro	0	0	231
154	4	107	485	Recepção - Curitiba	286	51	148
329	8	110	495	Janaina Torres - Financeiro	0	0	495
330	8	111	476	Maria Fernanda - Financeiro	0	0	476
331	8	96	265	Fernanda Santos	0	0	265
332	8	101	163	Nicoly Barbosa - Financeiro	0	0	163
334	8	100	59	Emanuelle Vidal - Pós-Vendas	0	0	59
335	8	102	53	Fernanda Teixeira - Pós-Vendas	0	0	53
146	4	99	50	Karol Schamne - Vendas (CWB)	10	4	36
145	4	98	48	Larissa Soares - Vendas (CWB)	12	1	35
143	4	96	22	Fernanda Santos	0	0	22
160	4	113	131	Jaqueline Gomes	75	14	42
152	4	105	158	Ana Luiza Montenegro - Vendas (CWB)	67	9	82
150	4	103	85	Nathalia Covas - Vendas (CWT)	7	9	69
337	8	97	49	Caroline Paola - Pós-Vendas	0	0	49
163	5	116	7	Luana Santos - Vendas (PG)	2	4	1
340	8	92	30	Nathalia Franco - Pós-Vendas	0	0	30
157	4	110	193	Janaina Torres - Financeiro	0	0	193
159	4	112	3	rafaeliferreira.sattrack@gmail.com	0	0	3
342	8	106	23	Emanuelle Vitória - Financeiro	0	0	23
344	8	95	18	Beatriz Alves - Suporte	0	0	18
345	8	93	17	Julia Camille - Suporte	0	0	17
346	8	94	8	Isabela Pereira - Suporte	0	0	8
348	8	88	5	Mariany Matos - Pré-Jurídico	0	0	5
169	5	122	2	Nayani Oliveira - Recepção	0	0	2
349	8	85	4	Vitor Hugo - Suporte/Frota	0	0	4
172	5	125	2	Fernanda Santos	0	0	2
351	8	86	3	Natalya Nagyla - Vendas	0	0	3
352	8	90	3	Vanessa Montini - Pós-Vendas	0	0	3
353	8	84	2	anacarolinaoliveira.sattrack@gmail.com	0	0	2
367	9	128	3	Lais Teixeira	0	0	3
339	8	105	84	Ana Luiza Montenegro - Vendas (CWB)	40	10	34
368	9	126	3	Caroline Paola - Pós-Vendas	0	0	3
336	8	113	166	Jaqueline Gomes	73	41	52
369	9	132	3	Fernanda Teixeira - Pós-Vendas	0	0	3
343	8	99	91	Karol Schamne - Vendas (CWB)	39	29	23
117	3	70	76	Tatiane Regina - Agendamento (MGA)	56	0	20
111	3	64	9	Geovana Mendes - Plus (MGA)	1	0	8
114	3	67	38	Rafaeli Pereira - Pós-Vendas (MGA)	27	0	11
341	8	98	56	Larissa Soares - Vendas (CWB)	18	10	28
371	9	124	2	Isabela Pereira - Suporte	0	0	2
338	8	103	109	Nathalia Covas - Vendas (CWT)	4	65	40
372	9	134	2	Ludiane Araujo - Guincho	0	0	2
373	9	122	2	Nayani Oliveira - Recepção	0	0	2
374	9	115	1	Nathalia Franco - Pós-Vendas	0	0	1
375	9	120	1	Vitor Hugo - Suporte/Frota	0	0	1
376	9	130	1	Emanuelle Vidal - Pós-Vendas	0	0	1
377	9	114	1	Tainá Oliveira - Plus	0	0	1
378	9	163	4	Ysabella Matos	0	0	4
370	9	137	47	Beatriz Loures - Vendas (PG)	15	30	2
381	2	47	3849	Nayani Oliveira - Recepção	1512	1205	1132
360	9	141	53	Kauane Oliveira - Recepção (PG)	9	6	38
383	2	12	1424	Giovanna Gomes - Financeiro	285	121	1018
388	2	30	624	Bruna Basso - SAC	8	354	262
389	2	24	400	Julia Andrade - Pós-Vendas	112	43	245
386	2	17	690	Maria Fernanda - Financeiro	101	7	582
384	2	16	1000	Nicoly Barbosa - Financeiro	76	43	881
382	2	10	1690	Ana Clara Costa - Financeiro	431	166	1093
387	2	37	751	Isabela Pereira - Suporte	304	153	294
185	5	138	25	Janaina Torres - Financeiro	0	0	25
184	5	137	195	Beatriz Loures - Vendas (PG)	7	167	21
303	6	56	111	Gabriela Mesquini - Agendamento	83	28	0
286	6	145	344	Ysabella Matos	141	31	172
183	5	136	18	Maria Fernanda - Financeiro	0	0	18
276	6	23	38	Jordana Mafra - Vendas	4	0	34
187	5	140	34	Emanuelle Vitória - Financeiro	0	0	34
190	5	143	93	Isabelle Duszeiko - Financeiro	0	0	93
280	6	21	106	Amanda Alves - Vendas	65	26	15
283	6	26	14	Mariany Matos - Pré-Jurídico	7	0	7
304	6	57	207	Luana Fernandes - Agendamento	141	66	0
282	6	48	91	anacarolinaoliveira.sattrack@gmail.com	6	72	13
404	2	42	336	Sumaya Larissa - Plus	220	37	79
281	6	36	46	Vanessa Montini - Pós-Vendas	24	8	14
278	6	38	132	Isabella Bueno - SAC	4	108	20
306	7	81	680	Janaina Torres - Financeiro	0	0	680
279	6	42	181	Sumaya Larissa - Plus	163	0	18
307	7	80	567	Maria Fernanda - Financeiro	0	0	567
277	6	43	281	Tainá Oliveira - Plus	222	33	26
284	6	34	16	Lorrayne de Morais - Financeiro	9	0	7
380	9	116	11	Luana Santos - Vendas (PG)	2	9	0
308	7	72	306	Fernanda Santos	0	0	306
297	6	54	122	Evelin Milan - Agendamento	103	19	0
309	7	75	259	Nicoly Barbosa - Financeiro	0	0	259
302	6	53	63	Gabrielle Maciel - Agendamento	62	1	0
311	7	82	42	Emanuelle Vitória - Financeiro	0	0	42
313	7	74	22	Beatriz Alves - Suporte	0	0	22
314	7	66	20	Julia Camille - Suporte	0	0	20
316	7	69	13	Isabela Pereira - Suporte	0	0	13
317	7	68	9	Mariany Matos - Pré-Jurídico	0	0	9
318	7	65	8	anacarolinaoliveira.sattrack@gmail.com	0	0	8
285	6	49	1	allanjorge.sattrack@gmail.com	0	0	1
321	7	61	7	Vitor Hugo - Suporte/Frota	0	0	7
287	6	146	17	Maria Garrido	0	0	17
288	6	147	1	Aliane Rezende - Gestora Pós-Vendas	0	0	1
290	6	149	54	Nathalia Covas - Vendas (CWT)	0	0	54
325	7	156	5	Maria Garrido	0	0	5
310	7	62	111	Amanda Saunite - Vendas (MGA)	58	1	52
319	7	59	80	Erica da Costa - Vendas (MGA)	73	0	7
312	7	73	89	Raissa Zavatini - Vendas (MGA)	45	2	42
320	7	63	29	Rayane Zavatini - Vendas (MGA)	21	1	7
327	7	158	40	Larissa Pereira - Vendas	40	0	0
322	7	70	141	Tatiane Regina - Agendamento (MGA)	134	0	7
323	7	76	55	Amanda Pereira - Pós-Vendas	51	0	4
409	2	27	50	Patrícia Correa - Vendas	0	0	50
415	2	33	13	Lais Teixeira	0	0	13
416	2	43	11	Tainá Oliveira - Plus	0	0	11
418	2	41	4	Percia Ledo - SAC	0	0	4
412	2	35	103	Priscilla Martins - Vendas	52	15	36
399	2	8	222	Michele Rocha - Vendas	91	17	114
396	2	25	563	Ludiane Araujo - Guincho	401	37	125
414	2	34	21	Lorrayne de Morais - Financeiro	6	1	14
403	2	7	203	Natalya Nagyla - Vendas	99	21	83
391	2	14	386	Beatriz Alves - Suporte	95	66	225
422	2	168	343	Nicolly Rocha	49	43	251
397	2	19	164	Amanda Miné - Agendamento	2	46	116
400	2	15	153	Yasmin Dandara - Agendamento	3	37	113
394	2	20	318	Caroline Paola - Pós-Vendas	116	46	156
393	2	22	369	Fernanda Teixeira - Pós-Vendas	128	58	183
411	2	26	69	Mariany Matos - Pré-Jurídico	19	6	44
324	7	67	33	Rafaeli Pereira - Pós-Vendas (MGA)	31	0	2
315	7	79	484	Camila Dionisio - Recepção (MGA)	464	5	15
354	8	160	65	Ysabella Matos	0	0	65
424	2	144	1983	Debora - Recepção	793	1190	0
392	2	31	368	Emanuelle Vidal - Pós-Vendas	127	58	183
429	2	172	2	Luana - Agendamento	2	0	0
452	10	173	2	viniciuslessa.sattrack@gmail.com	0	0	2
410	2	11	129	Jerlane Correa - SAC	8	76	45
417	2	32	267	Janiele - SAC	2	261	4
401	2	18	293	Nathalia Franco - Pós-Vendas	119	62	112
402	2	36	207	Vanessa Montini - Pós-Vendas	90	33	84
453	10	174	12	Caroline Paola - Pós-Vendas	0	0	12
405	2	38	465	Isabella Bueno - SAC	0	390	75
406	2	21	270	Amanda Alves - Vendas	123	74	73
408	2	6	144	Natalia Caroline - Vendas	78	13	53
407	2	28	188	Rafaela Bononi - Vendas	62	63	63
398	2	23	153	Jordana Mafra - Vendas	34	5	114
419	2	165	72	Ana Paula Alves - Vendas	58	0	14
413	2	40	368	Evelyn Nogueira - Plus	325	20	23
395	2	51	168	Fatima Galbero - Gestora Financeira	2	17	149
425	2	170	334	Taine Dias - Agendamento	230	104	0
426	2	171	118	Marcela - Agendamento	108	10	0
449	10	71	6	Lorrayne de Morais - Financeiro	0	0	6
450	10	76	2	Amanda Pereira - Pós-Vendas	0	0	2
454	10	175	14	Nathalia Franco - Pós-Vendas	0	0	14
455	10	176	15	Vanessa Montini - Pós-Vendas	0	0	15
456	10	177	18	Fernanda Teixeira - Pós-Vendas	0	0	18
457	10	178	19	Julia Andrade - Pós-Vendas	0	0	19
451	10	59	44	Erica da Costa - Vendas (MGA)	43	0	1
458	11	110	423	Janaina Torres - Financeiro	0	0	423
459	11	109	403	Isabelle Duszeiko - Financeiro	0	0	403
137	4	90	10	Vanessa Montini - Pós-Vendas	0	0	10
161	5	114	1	Tainá Oliveira - Plus	0	0	1
124	3	77	172	Isabela Igarashi - Financeiro	0	0	172
168	5	121	2	Sumaya Larissa - Plus	0	0	2
125	3	78	186	Fatima Galbero - Gestora Financeira	0	0	186
165	5	118	1	Evelyn Nogueira - Plus	0	0	1
130	3	83	526	Isabelle Duszeiko - Financeiro	0	0	526
139	4	92	15	Nathalia Franco - Pós-Vendas	0	0	15
118	3	71	21	Lorrayne de Morais - Financeiro	0	0	21
167	5	120	2	Vitor Hugo - Suporte/Frota	0	0	2
105	3	58	1	Emanuelle Vidal - Pós-Vendas	0	0	1
176	5	129	3	Julia Camille - Suporte	0	0	3
115	3	68	12	Mariany Matos - Pré-Jurídico	0	0	12
112	3	65	8	anacarolinaoliveira.sattrack@gmail.com	0	0	8
171	5	124	2	Isabela Pereira - Suporte	0	0	2
129	3	82	262	Emanuelle Vitória - Financeiro	0	0	262
174	5	127	2	Beatriz Alves - Suporte	0	0	2
127	3	80	215	Maria Fernanda - Financeiro	0	0	215
149	4	102	60	Fernanda Teixeira - Pós-Vendas	0	0	60
122	3	75	59	Nicoly Barbosa - Financeiro	0	0	59
175	5	128	3	Lais Teixeira	0	0	3
180	5	133	6	Nicoly Barbosa - Financeiro	0	0	6
181	5	134	6	Ludiane Araujo - Guincho	0	0	6
164	5	117	1	Isabella Bueno - SAC	0	0	1
108	3	61	4	Vitor Hugo - Suporte/Frota	0	0	4
113	3	66	9	Julia Camille - Suporte	0	0	9
116	3	69	18	Isabela Pereira - Suporte	0	0	18
121	3	74	53	Beatriz Alves - Suporte	0	0	53
147	4	100	37	Emanuelle Vidal - Pós-Vendas	0	0	37
170	5	123	2	Lorrayne de Morais - Financeiro	0	0	2
144	4	97	28	Caroline Paola - Pós-Vendas	0	0	28
186	5	139	26	Isabela Igarashi - Financeiro	0	0	26
269	6	19	112	Amanda Miné - Agendamento	0	23	89
178	5	131	5	Fatima Galbero - Gestora Financeira	0	0	5
166	5	119	2	Vanessa Montini - Pós-Vendas	0	0	2
162	5	115	1	Nathalia Franco - Pós-Vendas	0	0	1
182	5	135	7	Julia Andrade - Pós-Vendas	0	0	7
179	5	132	6	Fernanda Teixeira - Pós-Vendas	0	0	6
177	5	130	4	Emanuelle Vidal - Pós-Vendas	0	0	4
173	5	126	2	Caroline Paola - Pós-Vendas	0	0	2
135	4	88	7	Mariany Matos - Pré-Jurídico	0	0	7
131	4	84	1	anacarolinaoliveira.sattrack@gmail.com	0	0	1
252	6	14	790	Beatriz Alves - Suporte	269	220	301
260	6	37	445	Isabela Pereira - Suporte	202	86	157
151	4	104	81	Fatima Galbero - Gestora Financeira	0	0	81
188	5	141	67	Kauane Oliveira - Recepção (PG)	16	13	38
155	4	108	175	Isabela Igarashi - Financeiro	0	0	175
148	4	101	56	Nicoly Barbosa - Financeiro	0	0	56
156	4	109	476	Isabelle Duszeiko - Financeiro	0	0	476
158	4	111	128	Maria Fernanda - Financeiro	0	0	128
138	4	91	10	Lorrayne de Morais - Financeiro	0	0	10
256	6	39	804	Julia Camille - Suporte	347	211	246
189	5	142	113	Carolina de Paula - Vendas (PG)	14	49	50
153	4	106	139	Emanuelle Vitória - Financeiro	0	0	139
142	4	95	20	Beatriz Alves - Suporte	0	0	20
249	6	50	861	Fernanda Santos	0	0	861
132	4	85	2	Vitor Hugo - Suporte/Frota	0	0	2
140	4	93	15	Julia Camille - Suporte	0	0	15
141	4	94	16	Isabela Pereira - Suporte	0	0	16
133	4	86	2	Natalya Nagyla - Vendas	0	0	2
263	6	17	136	Maria Fernanda - Financeiro	0	0	136
254	6	13	337	Emanuelle Vitória - Financeiro	42	1	294
248	6	16	924	Nicoly Barbosa - Financeiro	54	7	863
272	6	28	159	Rafaela Bononi - Vendas	60	37	62
267	6	35	150	Priscilla Martins - Vendas	33	18	99
273	6	27	156	Patrícia Correa - Vendas	88	7	61
264	6	7	231	Natalya Nagyla - Vendas	70	51	110
271	6	6	173	Natalia Caroline - Vendas	68	31	74
268	6	8	176	Michele Rocha - Vendas	74	7	95
258	6	20	363	Caroline Paola - Pós-Vendas	113	56	194
257	6	31	458	Emanuelle Vidal - Pós-Vendas	145	86	227
259	6	22	396	Fernanda Teixeira - Pós-Vendas	156	51	189
255	6	24	452	Julia Andrade - Pós-Vendas	120	48	284
266	6	18	238	Nathalia Franco - Pós-Vendas	78	57	103
270	6	25	365	Ludiane Araujo - Guincho	265	23	77
250	6	10	1292	Ana Clara Costa - Financeiro	331	129	832
251	6	12	1083	Giovanna Gomes - Financeiro	192	97	794
247	6	46	1231	Isabelle Duszeiko - Financeiro	178	94	959
245	6	9	1684	Raphaelle Nayara - Financeiro	359	234	1091
265	6	15	117	Yasmin Dandara - Agendamento	1	11	105
262	6	32	469	Janiele - SAC	8	317	144
253	6	30	1062	Bruna Basso - SAC	4	759	299
261	6	11	513	Jerlane Correa - SAC	6	358	149
246	6	47	3675	Nayani Oliveira - Recepção	1593	1084	998
305	6	144	1923	Debora - Recepção	954	969	0
328	7	159	43	Giovana - Plus	43	0	0
355	8	161	2	Maria Garrido	0	0	2
423	2	169	444	Carla - Plus	271	173	0
800	20	247	420	Recepção	419	1	0
461	11	101	94	Nicoly Barbosa - Financeiro	0	0	94
463	11	106	79	Emanuelle Vitória - Financeiro	0	0	79
465	11	111	58	Maria Fernanda - Financeiro	0	0	58
467	11	102	51	Fernanda Teixeira - Pós-Vendas	0	0	51
468	11	100	44	Emanuelle Vidal - Pós-Vendas	0	0	44
469	11	104	43	Fatima Galbero - Gestora Financeira	0	0	43
470	11	97	40	Caroline Paola - Pós-Vendas	0	0	40
472	11	92	22	Nathalia Franco - Pós-Vendas	0	0	22
473	11	95	21	Beatriz Alves - Suporte	0	0	21
474	11	94	14	Isabela Pereira - Suporte	0	0	14
475	11	88	13	Mariany Matos - Pré-Jurídico	0	0	13
476	11	93	12	Julia Camille - Suporte	0	0	12
477	11	108	10	Isabela Igarashi - Financeiro	0	0	10
479	11	90	5	Vanessa Montini - Pós-Vendas	0	0	5
480	11	91	4	Lorrayne de Morais - Financeiro	0	0	4
481	11	86	2	Natalya Nagyla - Vendas	0	0	2
483	11	179	8	Franciele Martins - Vendas (CWB)	0	0	8
511	13	183	4	Isabelle Simionatto - Vendas (CAS)	1	0	3
515	13	187	28	Maria Cavalheiro - Recepção (CAS)	11	13	4
513	13	185	20	Alana Dinkel - Vendas (CAS)	7	7	6
460	11	107	535	Recepção - Curitiba	295	64	176
464	11	105	166	Ana Luiza Montenegro - Vendas (CWB)	86	5	75
471	11	98	43	Larissa Soares - Vendas (CWB)	4	2	37
462	11	99	180	Karol Schamne - Vendas (CWB)	62	30	88
466	11	113	133	Jaqueline Gomes	60	17	56
482	11	103	3	Nathalia Covas - Vendas (CWT)	2	0	1
478	11	87	68	Daniele Campanholi - Agendamento (CWB)	60	1	7
484	12	138	170	Janaina Torres - Financeiro	0	0	170
485	12	143	93	Isabelle Duszeiko - Financeiro	0	0	93
486	12	131	50	Fatima Galbero - Gestora Financeira	0	0	50
489	12	136	30	Maria Fernanda - Financeiro	0	0	30
492	12	133	17	Nicoly Barbosa - Financeiro	0	0	17
493	12	140	15	Emanuelle Vitória - Financeiro	0	0	15
494	12	134	9	Ludiane Araujo - Guincho	0	0	9
495	12	127	7	Beatriz Alves - Suporte	0	0	7
496	12	139	5	Isabela Igarashi - Financeiro	0	0	5
497	12	121	5	Sumaya Larissa - Plus	0	0	5
498	12	124	4	Isabela Pereira - Suporte	0	0	4
499	12	130	4	Emanuelle Vidal - Pós-Vendas	0	0	4
500	12	129	3	Julia Camille - Suporte	0	0	3
501	12	126	2	Caroline Paola - Pós-Vendas	0	0	2
502	12	118	1	Evelyn Nogueira - Plus	0	0	1
503	12	128	1	Lais Teixeira	0	0	1
504	12	132	1	Fernanda Teixeira - Pós-Vendas	0	0	1
505	12	117	1	Isabella Bueno - SAC	0	0	1
506	12	123	1	Lorrayne de Morais - Financeiro	0	0	1
507	12	119	1	Vanessa Montini - Pós-Vendas	0	0	1
487	12	141	73	Kauane Oliveira - Recepção (PG)	26	1	46
491	12	116	56	Luana Santos - Vendas (PG)	8	30	18
490	12	137	300	Beatriz Loures - Vendas (PG)	11	264	25
488	12	142	138	Carolina de Paula - Vendas (PG)	8	86	44
508	13	180	1	Nathalia Franco - Pós-Vendas	0	0	1
509	13	181	1	Isabelle Duszeiko - Financeiro	0	0	1
510	13	182	2	Janaina Torres - Financeiro	0	0	2
514	13	186	11	Bruna Basso - SAC	0	0	11
516	13	188	1	Nayani Oliveira - Recepção	0	0	1
519	14	47	3491	Nayani Oliveira - Recepção	1461	1083	947
512	13	184	20	Rosenice Andrade - Vendas (CAS)	14	0	6
527	14	30	921	Bruna Basso - SAC	77	616	228
531	14	16	143	Nicoly Barbosa - Financeiro	0	0	143
539	14	23	84	Jordana Mafra - Vendas	18	4	62
534	14	8	169	Michele Rocha - Vendas	73	7	89
535	14	7	157	Natalya Nagyla - Vendas	57	17	83
523	14	14	723	Beatriz Alves - Suporte	216	174	333
529	14	37	446	Isabela Pereira - Suporte	179	94	173
528	14	39	538	Julia Camille - Suporte	234	108	196
546	14	11	488	Jerlane Correa - SAC	105	337	46
520	14	17	1005	Maria Fernanda - Financeiro	166	26	813
544	14	38	516	Isabella Bueno - SAC	87	376	53
536	14	41	681	Percia Ledo - SAC	1	602	78
525	14	34	286	Lorrayne de Morais - Financeiro	11	10	265
522	14	10	872	Ana Clara Costa - Financeiro	246	88	538
521	14	12	1158	Giovanna Gomes - Financeiro	248	139	771
518	14	168	1467	Nicolly Rocha	255	147	1065
517	14	9	1786	Raphaelle Nayara - Financeiro	275	206	1305
543	14	46	332	Isabelle Duszeiko - Financeiro	220	58	54
524	14	13	615	Emanuelle Vitória - Financeiro	89	244	282
533	14	20	225	Caroline Paola - Pós-Vendas	72	21	132
532	14	22	282	Fernanda Teixeira - Pós-Vendas	90	52	140
530	14	31	298	Emanuelle Vidal - Pós-Vendas	95	44	159
526	14	24	352	Julia Andrade - Pós-Vendas	81	33	238
541	14	18	208	Nathalia Franco - Pós-Vendas	90	62	56
542	14	36	157	Vanessa Montini - Pós-Vendas	72	30	55
545	14	166	188	Thayrini Dantas - Guincho	129	9	50
547	14	25	199	Ludiane Araujo - Guincho	102	52	45
540	14	42	322	Sumaya Larissa - Plus	241	21	60
538	14	19	82	Amanda Miné - Agendamento	2	16	64
537	14	15	88	Yasmin Dandara - Agendamento	1	9	78
556	15	81	501	Janaina Torres - Financeiro	0	0	501
557	15	83	404	Isabelle Duszeiko - Financeiro	0	0	404
558	15	60	199	Micaelly - Agendamento (MGA)	0	0	199
559	15	80	135	Maria Fernanda - Financeiro	0	0	135
560	15	71	74	Lorrayne de Morais - Financeiro	0	0	74
561	15	82	71	Emanuelle Vitória - Financeiro	0	0	71
563	15	75	34	Nicoly Barbosa - Financeiro	0	0	34
566	15	68	22	Mariany Matos - Pré-Jurídico	0	0	22
567	15	74	20	Beatriz Alves - Suporte	0	0	20
568	15	69	18	Isabela Pereira - Suporte	0	0	18
570	15	66	17	Julia Camille - Suporte	0	0	17
571	15	78	14	Fatima Galbero - Gestora Financeira	0	0	14
574	15	58	4	Emanuelle Vidal - Pós-Vendas	0	0	4
575	15	174	3	Caroline Paola - Pós-Vendas	0	0	3
576	15	178	2	Julia Andrade - Pós-Vendas	0	0	2
577	15	175	2	Nathalia Franco - Pós-Vendas	0	0	2
578	15	177	2	Fernanda Teixeira - Pós-Vendas	0	0	2
579	15	176	1	Vanessa Montini - Pós-Vendas	0	0	1
580	16	110	433	Janaina Torres - Financeiro	0	0	433
581	16	109	319	Isabelle Duszeiko - Financeiro	0	0	319
583	16	111	75	Maria Fernanda - Financeiro	0	0	75
584	16	106	57	Emanuelle Vitória - Financeiro	0	0	57
586	16	100	46	Emanuelle Vidal - Pós-Vendas	0	0	46
587	16	102	43	Fernanda Teixeira - Pós-Vendas	0	0	43
588	16	91	38	Lorrayne de Morais - Financeiro	0	0	38
589	16	97	35	Caroline Paola - Pós-Vendas	0	0	35
590	16	95	30	Beatriz Alves - Suporte	0	0	30
594	16	92	16	Nathalia Franco - Pós-Vendas	0	0	16
595	16	90	16	Vanessa Montini - Pós-Vendas	0	0	16
596	16	179	13	Franciele Martins - Vendas (CWB)	0	0	13
597	16	88	13	Mariany Matos - Pré-Jurídico	0	0	13
598	16	104	13	Fatima Galbero - Gestora Financeira	0	0	13
599	16	101	10	Nicoly Barbosa - Financeiro	0	0	10
600	16	94	7	Isabela Pereira - Suporte	0	0	7
601	16	93	7	Julia Camille - Suporte	0	0	7
603	16	86	1	Natalya Nagyla - Vendas	0	0	1
604	17	182	20	Janaina Torres - Financeiro	0	0	20
606	17	181	7	Isabelle Duszeiko - Financeiro	0	0	7
608	17	188	1	Nayani Oliveira - Recepção	0	0	1
609	18	138	67	Janaina Torres - Financeiro	0	0	67
612	18	143	24	Isabelle Duszeiko - Financeiro	0	0	24
614	18	140	9	Emanuelle Vitória - Financeiro	0	0	9
615	18	136	9	Maria Fernanda - Financeiro	0	0	9
616	18	126	7	Caroline Paola - Pós-Vendas	0	0	7
617	18	132	7	Fernanda Teixeira - Pós-Vendas	0	0	7
618	18	130	6	Emanuelle Vidal - Pós-Vendas	0	0	6
620	18	135	4	Julia Andrade - Pós-Vendas	0	0	4
621	18	123	4	Lorrayne de Morais - Financeiro	0	0	4
622	18	133	3	Nicoly Barbosa - Financeiro	0	0	3
623	18	127	2	Beatriz Alves - Suporte	0	0	2
624	18	124	2	Isabela Pereira - Suporte	0	0	2
625	18	129	2	Julia Camille - Suporte	0	0	2
626	18	134	2	Ludiane Araujo - Guincho	0	0	2
627	18	131	2	Fatima Galbero - Gestora Financeira	0	0	2
628	18	118	1	Evelyn Nogueira - Plus	0	0	1
629	18	121	1	Sumaya Larissa - Plus	0	0	1
630	14	144	1791	Debora - Recepção	777	1014	0
552	14	21	177	Amanda Alves - Vendas	112	37	28
551	14	28	130	Rafaela Bononi - Vendas	33	61	36
550	14	165	105	Ana Paula Alves - Vendas	68	1	36
553	14	35	100	Priscilla Martins - Vendas	73	7	20
549	14	32	472	Janiele - SAC	96	338	38
554	14	26	36	Mariany Matos - Pré-Jurídico	11	10	15
555	14	40	371	Evelyn Nogueira - Plus	350	7	14
634	14	191	11	Nicoly Barbosa - Plus	11	0	0
632	14	169	187	Carla - Plus	172	15	0
631	14	189	823	Emanuella Paiva	118	185	520
635	14	150	51	Luiza Leticia - Plus	41	10	0
562	15	73	63	Raissa Zavatini - Vendas (MGA)	26	0	37
548	14	51	44	Fatima Galbero - Gestora Financeira	1	4	39
636	14	171	164	Marcela - Agendamento	151	13	0
638	14	53	128	Gabrielle Maciel - Agendamento	55	73	0
607	17	187	38	Maria Cavalheiro - Recepção (CAS)	17	15	6
605	17	184	31	Rosenice Andrade - Vendas (CAS)	19	4	8
573	15	79	507	Camila Dionisio - Recepção (MGA)	489	12	6
569	15	63	46	Rayane Zavatini - Vendas (MGA)	28	0	18
564	15	62	84	Amanda Saunite - Vendas (MGA)	52	4	28
565	15	70	91	Tatiane Regina - Agendamento (MGA)	63	0	28
633	14	190	85	Nathália Nunes - Plus	63	14	8
572	15	64	32	Geovana Mendes - Plus (MGA)	26	0	6
582	16	107	534	Recepção - Curitiba	341	51	142
585	16	99	116	Karol Schamne - Vendas (CWB)	33	36	47
592	16	98	45	Larissa Soares - Vendas (CWB)	18	2	25
593	16	105	107	Ana Luiza Montenegro - Vendas (CWB)	70	13	24
591	16	113	79	Jaqueline Gomes	33	18	28
602	16	87	77	Daniele Campanholi - Agendamento (CWB)	34	39	4
610	18	141	61	Kauane Oliveira - Recepção (PG)	11	15	35
613	18	142	164	Carolina de Paula - Vendas (PG)	12	135	17
611	18	137	206	Beatriz Loures - Vendas (PG)	6	172	28
619	18	116	29	Luana Santos - Vendas (PG)	9	15	5
865	25	229	77	Danielle Siqueira - Pós-Vendas (MGA)	25	0	52
637	14	56	120	Gabriela Mesquini - Agendamento	100	20	0
710	20	83	942	Isabelle Duszeiko - Financeiro	0	0	942
711	20	81	715	Janaina Torres - Financeiro	0	0	715
641	17	194	8	Jessica - Vendas (CAS)	6	2	0
640	17	193	14	Alana - Vendas (CAS)	12	2	0
642	15	195	32	Erica Marlene - Vendas (MGA)	32	0	0
643	15	196	31	Larissa Pereira - Vendas (MGA)	31	0	0
712	20	212	510	Ana Julia Neves	0	0	510
644	15	67	15	Rafaeli Pereira - Pós-Vendas (MGA)	13	2	0
645	15	197	1	Geovana Cavalaro - Financeiro (MGA)	1	0	0
646	16	198	3	Nathalia de Paula - Vendas (CWB)	3	0	0
647	16	199	71	Giovana Lima - Plus (CWB)	60	11	0
649	14	201	140	Janaina Torres - Financeiro	0	0	140
650	14	202	4	Kattellyn Dantas - Locadora	0	0	4
651	17	203	3	Emanuelle Vitória - Financeiro	0	0	3
652	17	204	3	Maria Fernanda - Financeiro	0	0	3
653	17	205	2	Ludiane Araujo - Guincho	0	0	2
654	17	206	1	Janiele - SAC	0	0	1
655	17	207	1	Sumaya Larissa - Plus	0	0	1
656	17	208	1	Thayrini Dantas - Guincho	0	0	1
657	16	209	109	Ana Julia Neves	0	0	109
658	16	210	69	Emanuella Paiva	0	0	69
659	15	211	81	Emanuella Paiva	0	0	81
660	15	212	133	Ana Julia Neves	0	0	133
661	15	213	1	Kattellyn Dantas - Locadora	0	0	1
662	18	214	1	Thayrini Dantas - Guincho	0	0	1
663	18	215	6	Emanuella Paiva	0	0	6
664	18	216	10	Ana Julia Neves	0	0	10
639	14	192	124	Ana Neves - Financeiro	40	40	44
714	20	60	214	Micaelly - Agendamento (MGA)	0	0	214
715	20	80	143	Maria Fernanda - Financeiro	0	0	143
716	20	82	85	Emanuelle Vitória - Financeiro	0	0	85
717	20	211	83	Emanuella Paiva	0	0	83
718	20	71	57	Lorrayne de Morais - Financeiro	0	0	57
720	20	74	24	Beatriz Alves - Suporte	0	0	24
721	20	69	24	Isabela Pereira - Suporte	0	0	24
724	20	66	20	Julia Camille - Suporte	0	0	20
726	20	68	4	Mariany Matos - Pré-Jurídico	0	0	4
727	20	67	2	Rafaeli Pereira - Pós-Vendas (MGA)	0	0	2
730	20	231	19	Beatriz Amaly De Mello Ribeirete	0	0	19
731	21	110	470	Janaina Torres - Financeiro	0	0	470
732	21	109	454	Isabelle Duszeiko - Financeiro	0	0	454
665	19	9	2052	Raphaelle Nayara - Financeiro	396	137	1519
719	20	73	66	Raissa Zavatini - Vendas (MGA)	39	0	27
725	20	63	31	Rayane Zavatini - Vendas (MGA)	18	0	13
713	20	62	281	Amanda Saunite - Vendas (MGA)	56	1	224
722	20	70	83	Tatiane Regina - Agendamento (MGA)	59	0	24
728	20	229	165	Danielle Siqueira - Pós-Vendas (MGA)	13	0	152
723	20	64	59	Geovana Mendes - Plus (MGA)	37	0	22
729	20	230	107	Juliana Aparecida - Pós-Vendas (MGA)	6	2	99
733	21	209	316	Ana Julia Neves	0	0	316
735	21	111	114	Maria Fernanda - Financeiro	0	0	114
736	21	210	88	Emanuella Paiva	0	0	88
737	21	106	84	Emanuelle Vitória - Financeiro	0	0	84
738	21	100	54	Emanuelle Vidal - Pós-Vendas	0	0	54
739	21	91	41	Lorrayne de Morais - Financeiro	0	0	41
740	21	97	40	Caroline Paola - Pós-Vendas	0	0	40
741	21	95	24	Beatriz Alves - Suporte	0	0	24
743	21	90	18	Vanessa Montini - Pós-Vendas	0	0	18
744	21	93	17	Julia Camille - Suporte	0	0	17
746	21	92	17	Nathalia Franco - Pós-Vendas	0	0	17
747	21	94	12	Isabela Pereira - Suporte	0	0	12
750	21	88	3	Mariany Matos - Pré-Jurídico	0	0	3
752	21	232	49	Fernanda Silva Teixeira - Vendas	0	0	49
754	21	234	5	Ingrid Hampf - Vendas (CWB)	0	0	5
755	21	235	3	natalya.sattrack@gmail.com	0	0	3
756	21	236	2	Beatriz Amaly De Mello Ribeirete	0	0	2
734	21	107	517	Recepção - Curitiba	266	30	221
745	21	99	114	Karol Schamne - Vendas (CWB)	50	47	17
751	21	98	15	Larissa Soares - Vendas (CWB)	10	3	2
742	21	105	97	Ana Luiza Montenegro - Vendas (CWB)	66	12	19
748	21	113	61	Jaqueline Gomes	32	23	6
749	21	87	81	Daniele Campanholi - Agendamento (CWB)	35	40	6
753	21	233	15	Melany - Pós-Vendas (CWB)	1	0	14
757	22	138	63	Janaina Torres - Financeiro	0	0	63
758	22	143	60	Isabelle Duszeiko - Financeiro	0	0	60
761	22	216	35	Ana Julia Neves	0	0	35
762	22	215	10	Emanuella Paiva	0	0	10
763	22	140	10	Emanuelle Vitória - Financeiro	0	0	10
765	22	136	8	Maria Fernanda - Financeiro	0	0	8
766	22	126	6	Caroline Paola - Pós-Vendas	0	0	6
767	22	135	6	Julia Andrade - Pós-Vendas	0	0	6
768	22	123	5	Lorrayne de Morais - Financeiro	0	0	5
769	22	130	4	Emanuelle Vidal - Pós-Vendas	0	0	4
770	22	124	3	Isabela Pereira - Suporte	0	0	3
771	22	214	3	Thayrini Dantas - Guincho	0	0	3
772	22	127	2	Beatriz Alves - Suporte	0	0	2
773	22	115	2	Nathalia Franco - Pós-Vendas	0	0	2
774	22	118	1	Evelyn Nogueira - Plus	0	0	1
775	22	134	1	Ludiane Araujo - Guincho	0	0	1
776	22	121	1	Sumaya Larissa - Plus	0	0	1
777	22	237	1	Carla Cristina - Plus	0	0	1
778	22	238	1	Bruna Basso - SAC	0	0	1
779	22	239	1	Nathália Nunes - Plus	0	0	1
780	22	240	5	Fernanda Silva Teixeira - Vendas	0	0	5
783	23	186	4	Bruna Basso - SAC	0	0	4
785	23	181	2	Isabelle Duszeiko - Financeiro	0	0	2
786	23	182	1	Janaina Torres - Financeiro	0	0	1
787	23	241	1	Julia Andrade - Pós-Vendas	0	0	1
788	23	242	2	Ana Julia Neves	0	0	2
759	22	137	331	Beatriz Loures - Vendas (PG)	11	280	40
784	23	187	27	Maria Cavalheiro - Recepção (CAS)	12	12	3
781	23	184	20	Rosenice Andrade - Vendas (CAS)	7	0	13
782	23	185	14	Alana Dinkel - Vendas (CAS)	4	3	7
789	23	243	94	Jessica Eliete - Vendas (CAS)	3	91	0
790	19	244	38	Natalia Conde - Vendas	33	5	0
791	19	171	155	Marcela - Agendamento	149	6	0
792	19	56	184	Gabriela Mesquini - Agendamento	143	41	0
677	19	31	335	Emanuelle Vidal - Pós-Vendas	115	92	128
793	19	53	21	Gabrielle Maciel - Agendamento	19	2	0
685	19	42	188	Sumaya Larissa - Plus	115	11	62
699	19	218	4716	Débora Araujo - Recepção	1757	1955	1004
795	19	192	313	Ana Neves - Financeiro	132	181	0
794	19	201	250	Janaina Torres - Financeiro	179	71	0
796	19	46	231	Isabelle Duszeiko - Financeiro	145	86	0
797	19	245	22	Vitor Hugo - Suporte	9	13	0
798	19	191	15	Nicoly Barbosa - Plus	10	5	0
799	19	246	88	Karina - Pré-Juridico	16	72	0
801	20	248	2	Erica - Vendas	2	0	0
804	21	249	53	Giovana Lima - Plus	45	8	0
760	22	141	72	Kauane Oliveira - Recepção (PG)	12	20	40
764	22	142	174	Carolina de Paula - Vendas (PG)	11	154	9
802	20	158	50	Larissa Pereira - Vendas	50	0	0
803	21	162	5	Nathalia De Paula - Vendas	3	2	0
697	19	47	321	Nayani Oliveira - Recepção	253	68	0
702	19	221	260	Fernanda Silva Teixeira - Vendas	100	160	0
705	19	224	114	natalya.sattrack@gmail.com	67	47	0
817	24	218	4123	Débora Araujo - Recepção	1544	1581	998
666	19	12	1747	Giovanna Gomes - Financeiro	244	84	1419
667	19	13	1075	Emanuelle Vitória - Financeiro	55	2	1018
668	19	17	1109	Maria Fernanda - Financeiro	150	19	940
670	19	14	743	Beatriz Alves - Suporte	254	204	285
671	19	30	1079	Bruna Basso - SAC	307	525	247
672	19	39	550	Julia Camille - Suporte	216	114	220
673	19	34	251	Lorrayne de Morais - Financeiro	33	7	211
675	19	24	418	Julia Andrade - Pós-Vendas	96	133	189
676	19	23	164	Jordana Mafra - Vendas	31	0	133
678	19	20	245	Caroline Paola - Pós-Vendas	106	30	109
679	19	18	259	Nathalia Franco - Pós-Vendas	74	87	98
680	19	8	185	Michele Rocha - Vendas	65	30	90
681	19	36	268	Vanessa Montini - Pós-Vendas	80	108	80
682	19	19	105	Amanda Miné - Agendamento	3	29	73
683	19	32	462	Janiele - SAC	267	118	77
684	19	166	161	Thayrini Dantas - Guincho	67	27	67
686	19	25	182	Ludiane Araujo - Guincho	61	63	58
687	19	21	141	Amanda Alves - Vendas	64	22	55
688	19	28	137	Rafaela Bononi - Vendas	51	40	46
689	19	165	118	Ana Paula Alves - Vendas	85	0	33
690	19	35	104	Priscilla Martins - Vendas	50	27	27
691	19	11	223	Jerlane Correa - SAC	76	126	21
692	19	26	164	Mariany Matos - Pré-Jurídico	28	120	16
693	19	40	266	Evelyn Nogueira - Plus	248	4	14
696	19	16	10	Nicoly Barbosa - Financeiro	8	0	2
698	19	217	1818	Nicolly Rocha - Financeiro	260	125	1433
700	19	219	1233	Emanuella Paiva	268	267	698
701	19	220	112	Yasmim Dandara	0	26	86
703	19	222	99	Evelin Klem - Agendamento	32	66	1
704	19	223	266	Carla Cristina - Plus	203	30	33
706	19	225	65	Beatriz Amaly De Mello Ribeirete	2	30	33
707	19	226	143	Nathália Nunes - Plus	94	18	31
808	19	202	327	Kattellyn Dantas - Locadora	0	0	327
809	19	227	33	Danielle Siqueira - Pós-Vendas (MGA)	0	0	33
810	19	38	2	Isabella Bueno - SAC	0	0	2
811	19	41	2	Percia Ledo - SAC	0	0	2
812	19	228	1	Rafaela Oliveira - Adm	0	0	1
813	19	250	1	Nayani Oliveira - Recepção	0	0	1
814	19	22	110	Fernanda Silva Teixeira - Pós-Vendas	0	0	110
674	19	37	513	Isabela Dos Santos Pereira	181	129	203
822	24	30	1124	Bruna Basso - SAC	278	562	284
818	24	12	1390	Giovanna Gomes - Financeiro	302	95	993
816	24	217	1676	Nicolly Rocha - Financeiro	288	182	1206
815	24	9	1894	Raphaelle Nayara - Financeiro	362	156	1376
819	24	17	742	Maria Fernanda - Financeiro	147	13	582
821	24	219	434	Emanuella Paiva	79	54	301
823	24	46	516	Isabelle Duszeiko - Financeiro	123	116	277
820	24	14	803	Beatriz Alves - Suporte	305	158	340
824	24	39	1068	Julia Camille - Suporte	558	253	257
836	24	202	70	Kattellyn Dantas - Locadora	0	0	70
856	25	212	561	Ana Julia Neves	0	0	561
857	25	81	550	Janaina Torres - Financeiro	0	0	550
858	25	83	429	Isabelle Duszeiko - Financeiro	0	0	429
859	25	60	191	Micaelly - Agendamento (MGA)	0	0	191
860	25	80	182	Maria Fernanda - Financeiro	0	0	182
861	25	71	121	Lorrayne de Morais - Financeiro	0	0	121
862	25	67	109	Rafaeli Pereira - Pós-Vendas (MGA)	0	0	109
863	25	211	84	Emanuella Paiva	0	0	84
867	25	82	37	Emanuelle Vitória - Financeiro	0	0	37
868	25	74	35	Beatriz Alves - Suporte	0	0	35
869	25	66	18	Julia Camille - Suporte	0	0	18
871	25	173	18	viniciuslessa.sattrack@gmail.com	0	0	18
874	25	231	3	Beatriz Amaly De Mello Ribeirete	0	0	3
875	25	76	3	Amanda Pereira - Pós-Vendas	0	0	3
876	25	251	25	Isabela Dos Santos Pereira	0	0	25
877	25	252	75	Raphaelle Nayara - Financeiro	0	0	75
878	25	253	102	Nicolly Rocha - Financeiro	0	0	102
879	25	254	118	Giovanna Gomes - Financeiro	0	0	118
880	25	255	2	palomagabrielle.sattrack@gmail.com	0	0	2
881	26	110	502	Janaina Torres - Financeiro	0	0	502
882	26	109	393	Isabelle Duszeiko - Financeiro	0	0	393
883	26	209	313	Ana Julia Neves	0	0	313
885	26	91	131	Lorrayne de Morais - Financeiro	0	0	131
886	26	111	126	Maria Fernanda - Financeiro	0	0	126
887	26	210	63	Emanuella Paiva	0	0	63
889	26	106	42	Emanuelle Vitória - Financeiro	0	0	42
890	26	95	37	Beatriz Alves - Suporte	0	0	37
891	26	100	28	Emanuelle Vidal - Pós-Vendas	0	0	28
893	26	97	17	Caroline Paola - Pós-Vendas	0	0	17
894	26	93	17	Julia Camille - Suporte	0	0	17
896	26	92	7	Nathalia Franco - Pós-Vendas	0	0	7
897	26	90	7	Vanessa Montini - Pós-Vendas	0	0	7
898	26	236	3	Beatriz Amaly De Mello Ribeirete	0	0	3
900	26	86	2	Natalya Nagyla - Vendas	0	0	2
903	26	256	2	Sumaya Larissa - Plus	0	0	2
904	26	257	78	Nicolly Rocha - Financeiro	0	0	78
905	26	258	54	Giovanna Gomes - Financeiro	0	0	54
906	26	259	24	Raphaelle Nayara - Financeiro	0	0	24
907	26	260	22	Fernanda Silva Teixeira - Pós-Vendas	0	0	22
908	26	261	18	Isabela Dos Santos Pereira	0	0	18
909	26	262	2	Carla Cristina - Plus	0	0	2
910	27	138	66	Janaina Torres - Financeiro	0	0	66
911	27	143	60	Isabelle Duszeiko - Financeiro	0	0	60
914	27	216	31	Ana Julia Neves	0	0	31
916	27	123	23	Lorrayne de Morais - Financeiro	0	0	23
917	27	136	8	Maria Fernanda - Financeiro	0	0	8
828	24	23	195	Jordana Mafra - Vendas	40	0	155
849	24	28	145	Rafaela Bononi - Vendas	99	23	23
841	24	19	78	Amanda Miné - Agendamento	0	23	55
846	24	165	125	Ana Paula Alves - Vendas	80	4	41
839	24	35	157	Priscilla Martins - Vendas	60	34	63
830	24	8	236	Michele Rocha - Vendas	84	20	132
832	24	7	222	Natalya Nagyla - Vendas	68	43	111
838	24	20	187	Caroline Paola - Pós-Vendas	85	37	65
834	24	31	302	Emanuelle Vidal - Pós-Vendas	130	72	100
831	24	24	276	Julia Andrade - Pós-Vendas	89	68	119
835	24	18	202	Nathalia Franco - Pós-Vendas	60	61	81
837	24	36	194	Vanessa Montini - Pós-Vendas	74	53	67
840	24	25	175	Ludiane Araujo - Guincho	54	60	61
844	24	166	152	Thayrini Dantas - Guincho	87	14	51
842	24	11	383	Jerlane Correa - SAC	169	162	52
833	24	32	408	Janiele - SAC	212	95	101
843	24	220	74	Yasmim Dandara	0	22	52
870	25	73	51	Raissa Zavatini - Vendas (MGA)	33	0	18
825	24	34	289	Lorrayne de Morais - Financeiro	33	3	253
829	24	13	181	Emanuelle Vitória - Financeiro	29	3	149
826	24	201	465	Janaina Torres - Financeiro	183	67	215
827	24	200	365	Ana Julia Neves	82	81	202
854	24	37	539	Isabela Dos Santos Pereira	183	127	229
847	24	223	283	Carla Cristina - Plus	209	43	31
850	24	40	262	Evelyn Nogueira - Plus	217	24	21
845	24	42	117	Sumaya Larissa - Plus	66	7	44
848	24	226	209	Nathália Nunes - Plus	151	31	27
853	24	26	100	Mariany Matos - Pré-Jurídico	44	44	12
851	24	225	102	Beatriz Amaly De Mello Ribeirete	7	76	19
872	25	59	52	Erica da Costa - Vendas (MGA)	40	0	12
866	25	62	95	Amanda Saunite - Vendas (MGA)	51	1	43
873	25	64	57	Geovana Mendes - Plus (MGA)	48	0	9
864	25	230	90	Juliana Aparecida - Pós-Vendas (MGA)	25	4	61
892	26	233	23	Melany - Pós-Vendas (CWB)	0	3	20
884	26	107	401	Recepção - Curitiba	202	8	191
888	26	99	137	Karol Schamne - Vendas (CWB)	41	48	48
899	26	98	11	Larissa Soares - Vendas (CWB)	8	1	2
895	26	105	76	Ana Luiza Montenegro - Vendas (CWB)	52	16	8
901	26	113	52	Jaqueline Gomes	37	14	1
902	26	87	34	Daniele Campanholi - Agendamento (CWB)	29	4	1
912	27	141	87	Kauane Oliveira - Recepção (PG)	17	24	46
915	27	142	147	Carolina de Paula - Vendas (PG)	16	107	24
913	27	137	268	Beatriz Loures - Vendas (PG)	12	218	38
918	27	134	8	Ludiane Araujo - Guincho	0	0	8
919	27	215	6	Emanuella Paiva	0	0	6
920	27	127	5	Beatriz Alves - Suporte	0	0	5
921	27	214	5	Thayrini Dantas - Guincho	0	0	5
922	27	238	4	Bruna Basso - SAC	0	0	4
923	27	237	4	Carla Cristina - Plus	0	0	4
924	27	126	4	Caroline Paola - Pós-Vendas	0	0	4
925	27	135	4	Julia Andrade - Pós-Vendas	0	0	4
926	27	129	3	Julia Camille - Suporte	0	0	3
927	27	118	2	Evelyn Nogueira - Plus	0	0	2
928	27	130	2	Emanuelle Vidal - Pós-Vendas	0	0	2
929	27	121	2	Sumaya Larissa - Plus	0	0	2
930	27	140	1	Emanuelle Vitória - Financeiro	0	0	1
931	27	239	1	Nathália Nunes - Plus	0	0	1
932	27	115	1	Nathalia Franco - Pós-Vendas	0	0	1
951	28	270	2	Beatriz Alves - Suporte	0	0	2
952	28	271	1	Emanuella Paiva	0	0	1
934	27	264	11	Nicolly Rocha - Financeiro	0	0	11
935	27	265	6	Giovanna Gomes - Financeiro	0	0	6
936	27	266	4	Isabela Dos Santos Pereira	0	0	4
937	27	267	4	Raphaelle Nayara - Financeiro	0	0	4
938	27	268	2	Jerlane Correa - SAC	0	0	2
939	27	269	2	Fernanda Silva Teixeira - Pós-Vendas	0	0	2
953	24	272	52	Natalia Conde	52	0	0
933	27	263	199	Taciane Kolodo - Vendas (PG)	11	144	44
940	28	182	33	Janaina Torres - Financeiro	0	0	33
942	28	181	8	Isabelle Duszeiko - Financeiro	0	0	8
944	28	242	6	Ana Julia Neves	0	0	6
946	28	203	2	Emanuelle Vitória - Financeiro	0	0	2
947	28	204	2	Maria Fernanda - Financeiro	0	0	2
948	28	186	1	Bruna Basso - SAC	0	0	1
950	28	205	1	Ludiane Araujo - Guincho	0	0	1
941	28	187	29	Maria Cavalheiro - Recepção (CAS)	6	10	13
945	28	184	11	Rosenice Andrade - Vendas (CAS)	8	0	3
943	28	185	17	Alana Dinkel - Vendas (CAS)	4	7	6
949	28	243	88	Jessica Eliete - Vendas (CAS)	3	84	1
852	24	21	96	Amanda Alves - Vendas	65	18	13
855	24	22	313	Fernanda Silva Teixeira - Pós-Vendas	116	74	123
955	24	274	171	Gabriela Mesquini	124	47	0
956	24	275	12	Gabrielle Maciel	11	1	0
958	24	277	184	Leonardo	182	2	0
959	24	278	58	Luiza	21	37	0
960	24	279	32	Nicoly Barbosa	6	26	0
962	25	247	326	Recepção	326	0	0
963	25	281	22	Tatiane Regina	22	0	0
954	24	273	180	Marcela	145	35	0
957	24	276	9	Vitor Hugo	8	1	0
961	24	280	24	Karina	19	5	0
967	29	202	1167	Kattellyn Dantas - Locadora	0	0	1167
995	29	51	25	Fatima Galbero - Gestora Financeira	0	0	25
1000	29	222	1	Evelin Klem - Agendamento	0	0	1
1002	29	283	961	lorena caroline	0	0	961
1003	29	284	2	Larissa Tatiane - Pós-Vendas	0	0	2
1007	30	81	465	Janaina Torres - Financeiro	0	0	465
1008	30	83	381	Isabelle Duszeiko - Financeiro	0	0	381
1009	30	212	227	Ana Julia Neves	0	0	227
1011	30	80	71	Maria Fernanda - Financeiro	0	0	71
1012	30	254	58	Giovanna Gomes - Financeiro	0	0	58
1013	30	60	58	Micaelly - Agendamento (MGA)	0	0	58
1014	30	253	56	Nicolly Rocha - Financeiro	0	0	56
1015	30	74	52	Beatriz Alves - Suporte	0	0	52
1018	30	82	42	Emanuelle Vitória - Financeiro	0	0	42
1020	30	252	34	Raphaelle Nayara - Financeiro	0	0	34
1021	30	68	31	Mariany Matos - Pré-Jurídico	0	0	31
1022	30	71	27	Lorrayne de Morais - Financeiro	0	0	27
1023	30	251	26	Isabela Dos Santos Pereira	0	0	26
1024	30	66	26	Julia Camille - Suporte	0	0	26
1029	30	231	2	Beatriz Amaly De Mello Ribeirete	0	0	2
1030	30	211	1	Emanuella Paiva	0	0	1
1031	30	288	3	Debora Correa	0	0	3
1032	30	289	56	Adriele Gasperi	0	0	56
1033	30	290	3	Julia Clemes - Agendamento (MGA)	0	0	3
1034	31	110	337	Janaina Torres - Financeiro	0	0	337
1035	31	109	299	Isabelle Duszeiko - Financeiro	0	0	299
1037	31	209	159	Ana Julia Neves	0	0	159
1039	31	111	64	Maria Fernanda - Financeiro	0	0	64
1040	31	95	61	Beatriz Alves - Suporte	0	0	61
1044	31	106	33	Emanuelle Vitória - Financeiro	0	0	33
1045	31	261	33	Isabela Dos Santos Pereira	0	0	33
1046	31	93	29	Julia Camille - Suporte	0	0	29
1047	31	91	27	Lorrayne de Morais - Financeiro	0	0	27
1048	31	260	22	Fernanda Silva Teixeira - Pós-Vendas	0	0	22
1049	31	100	21	Emanuelle Vidal - Pós-Vendas	0	0	21
1050	31	97	16	Caroline Paola - Pós-Vendas	0	0	16
1051	31	256	16	Sumaya Larissa - Plus	0	0	16
1052	31	262	7	Carla Cristina - Plus	0	0	7
1053	31	92	7	Nathalia Franco - Pós-Vendas	0	0	7
1054	31	90	3	Vanessa Montini - Pós-Vendas	0	0	3
1055	31	88	1	Mariany Matos - Pré-Jurídico	0	0	1
1056	31	236	1	Beatriz Amaly De Mello Ribeirete	0	0	1
1057	31	233	1	Melany - Pós-Vendas (CWB)	0	0	1
1058	31	291	45	Adriele Gasperi	0	0	45
977	29	23	214	Jordana Mafra - Vendas	52	0	162
993	29	28	170	Rafaela Bononi - Vendas	112	26	32
970	29	217	597	Nicolly Rocha - Financeiro	1	0	596
989	29	165	164	Ana Paula Alves - Vendas	95	12	57
980	29	35	170	Priscilla Martins - Vendas	44	17	109
976	29	7	326	Natalya Nagyla - Vendas	112	50	164
985	29	20	231	Caroline Paola - Pós-Vendas	123	24	84
1004	29	285	357	Fernanda Silva Teixeira - Pós-Vendas	132	79	146
975	29	31	407	Emanuelle Vidal - Pós-Vendas	172	55	180
979	29	24	361	Julia Andrade - Pós-Vendas	136	82	143
981	29	18	326	Nathalia Franco - Pós-Vendas	123	106	97
991	29	36	132	Vanessa Montini - Pós-Vendas	64	23	45
984	29	25	242	Ludiane Araujo - Guincho	95	62	85
988	29	166	182	Thayrini Dantas - Guincho	112	9	61
987	29	11	636	Jerlane Correa - SAC	210	351	75
990	29	30	577	Bruna Basso - SAC	116	409	52
992	29	32	393	Janiele - SAC	259	94	40
982	29	19	126	Amanda Miné - Agendamento	1	31	94
986	29	220	103	Yasmim Dandara	4	15	84
973	29	34	381	Lorrayne de Morais - Financeiro	70	10	301
968	29	12	1494	Giovanna Gomes - Financeiro	368	146	980
966	29	9	2032	Raphaelle Nayara - Financeiro	419	203	1410
971	29	17	665	Maria Fernanda - Financeiro	133	10	522
999	29	26	26	Mariany Matos - Pré-Jurídico	16	0	10
1005	29	286	304	Adriele Gasperi	80	8	216
969	29	14	1264	Beatriz Alves - Suporte	433	225	606
1001	29	37	1096	Isabela Dos Santos Pereira	375	154	567
972	29	39	1173	Julia Camille - Suporte	466	305	402
994	29	223	254	Carla Cristina - Plus	193	30	31
983	29	42	245	Sumaya Larissa - Plus	150	9	86
997	29	226	253	Nathália Nunes - Plus	210	32	11
996	29	40	94	Evelyn Nogueira - Plus	70	5	19
1028	30	73	38	Raissa Zavatini - Vendas (MGA)	35	0	3
998	29	225	44	Beatriz Amaly De Mello Ribeirete	23	11	10
1006	29	287	92	Debora Correa	13	54	25
1019	30	59	88	Erica da Costa - Vendas (MGA)	52	0	36
1010	30	62	164	Amanda Saunite - Vendas (MGA)	75	4	85
1027	30	255	35	palomagabrielle.sattrack@gmail.com	30	0	5
1025	30	70	51	Tatiane Regina - Agendamento (MGA)	25	0	26
1026	30	64	26	Geovana Mendes - Plus (MGA)	20	0	6
1017	30	229	64	Danielle Siqueira - Pós-Vendas (MGA)	18	3	43
1016	30	230	72	Juliana Aparecida - Pós-Vendas (MGA)	18	5	49
1036	31	107	366	Recepção - Curitiba	149	10	207
1038	31	105	162	Ana Luiza Montenegro - Vendas (CWB)	59	13	90
1043	31	113	80	Jaqueline Gomes	30	9	41
1042	31	99	83	Karol Schamne - Vendas (CWB)	19	11	53
1059	31	292	5	Evelyn Nogueira - Plus	0	0	5
1061	32	143	32	Isabelle Duszeiko - Financeiro	0	0	32
1062	32	138	32	Janaina Torres - Financeiro	0	0	32
1065	32	216	17	Ana Julia Neves	0	0	17
1067	32	136	9	Maria Fernanda - Financeiro	0	0	9
1068	32	134	8	Ludiane Araujo - Guincho	0	0	8
1069	32	268	6	Jerlane Correa - SAC	0	0	6
1070	32	127	5	Beatriz Alves - Suporte	0	0	5
1071	32	140	5	Emanuelle Vitória - Financeiro	0	0	5
1072	32	269	5	Fernanda Silva Teixeira - Pós-Vendas	0	0	5
1073	32	130	4	Emanuelle Vidal - Pós-Vendas	0	0	4
1074	32	266	4	Isabela Dos Santos Pereira	0	0	4
1075	32	135	4	Julia Andrade - Pós-Vendas	0	0	4
1076	32	123	4	Lorrayne de Morais - Financeiro	0	0	4
1077	32	238	3	Bruna Basso - SAC	0	0	3
1078	32	126	3	Caroline Paola - Pós-Vendas	0	0	3
1079	32	115	3	Nathalia Franco - Pós-Vendas	0	0	3
1080	32	129	2	Julia Camille - Suporte	0	0	2
1081	32	118	1	Evelyn Nogueira - Plus	0	0	1
1082	32	121	1	Sumaya Larissa - Plus	0	0	1
1083	32	214	1	Thayrini Dantas - Guincho	0	0	1
1084	32	119	1	Vanessa Montini - Pós-Vendas	0	0	1
1086	32	295	1	Debora Correa	0	0	1
1096	33	296	1	Caroline Paola - Pós-Vendas	0	0	1
1064	32	141	52	Kauane Oliveira - Recepção (PG)	7	19	26
1063	32	263	247	Taciane Kolodo - Vendas (PG)	22	197	28
1066	32	137	287	Beatriz Loures - Vendas (PG)	13	257	17
1060	31	293	3	Debora Correa	0	0	3
1085	32	294	5	Adriele Gasperi	0	0	5
1088	33	242	13	Ana Julia Neves	0	0	13
1089	33	182	12	Janaina Torres - Financeiro	0	0	12
1090	33	184	9	Rosenice Andrade - Vendas (CAS)	0	0	9
1091	33	181	8	Isabelle Duszeiko - Financeiro	0	0	8
1093	33	204	4	Maria Fernanda - Financeiro	0	0	4
1094	33	270	1	Beatriz Alves - Suporte	0	0	1
1095	33	241	1	Julia Andrade - Pós-Vendas	0	0	1
1097	33	297	4	Adriele Gasperi	0	0	4
1087	33	187	30	Maria Cavalheiro - Recepção (CAS)	11	0	19
1092	33	185	9	Alana Dinkel - Vendas (CAS)	1	2	6
1098	33	298	432	Jessica - Vendas	1	431	0
965	29	218	4271	Débora Araujo - Recepção	1513	1174	1584
1099	29	299	220	Julia - Recepção	210	10	0
978	29	8	280	Michele Rocha - Vendas	103	29	148
1100	29	300	66	Larissa Azevedo	6	60	0
1101	29	273	243	Marcela	145	98	0
1102	29	274	205	Gabriela Mesquini	115	90	0
1103	29	275	121	Gabrielle Maciel	76	45	0
1104	29	301	190	Michele Silva	151	39	0
974	29	13	218	Emanuelle Vitória - Financeiro	16	1	201
1105	29	302	344	Janaina	230	114	0
1106	29	303	138	Ana Neves	91	47	0
1107	29	304	248	Isabelle Duszeiko	207	41	0
1108	29	276	6	Vitor Hugo	5	1	0
1109	29	277	276	Leonardo	275	1	0
1110	29	279	63	Nicoly Barbosa	9	54	0
1111	29	280	13	Karina	9	4	0
1112	30	247	305	Recepção	287	18	0
1113	30	305	2	Geovana Cavalaro	2	0	0
1041	31	98	69	Larissa Soares - Vendas (CWB)	10	0	59
1114	31	306	54	Daniele Gonçalves	37	17	0
\.


--
-- Data for Name: monthly_reports; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.monthly_reports (id, branch_id, month, year, created_by, created_at) FROM stdin;
1	9	2	2026	1	2026-03-03 12:46:20.857361-03
2	9	3	2026	1	2026-03-03 16:29:40.281868-03
3	8	2	2026	1	2026-03-04 09:53:56.593611-03
4	7	2	2026	1	2026-03-04 10:01:12.381978-03
5	10	2	2026	1	2026-03-04 10:11:57.442784-03
6	9	1	2026	6	2026-03-06 12:29:09.048477-03
7	8	1	2026	6	2026-03-06 17:13:19.373839-03
8	7	1	2026	6	2026-03-06 17:32:47.098532-03
9	10	1	2026	6	2026-03-06 17:41:05.064611-03
10	8	3	2026	6	2026-04-13 12:37:04.365042-03
11	7	3	2026	6	2026-04-15 11:21:16.385482-03
12	10	3	2026	6	2026-04-15 11:31:29.652925-03
13	6	3	2026	6	2026-04-15 11:38:47.383662-03
14	9	4	2026	6	2026-05-02 08:29:53.205475-03
15	8	4	2026	6	2026-05-02 08:31:28.207392-03
16	7	4	2026	6	2026-05-02 08:31:47.943504-03
17	6	4	2026	6	2026-05-02 08:31:56.526321-03
18	10	4	2026	6	2026-05-02 08:32:03.883971-03
19	9	5	2026	6	2026-06-01 11:40:12.295307-03
20	8	5	2026	6	2026-06-01 11:48:34.99024-03
21	7	5	2026	6	2026-06-01 11:51:27.454403-03
22	10	5	2026	6	2026-06-01 11:53:38.597945-03
23	6	5	2026	6	2026-06-01 11:57:05.951566-03
24	9	6	2026	6	2026-07-01 08:30:48.358764-03
25	8	6	2026	6	2026-07-01 08:34:10.541762-03
26	7	6	2026	6	2026-07-01 08:37:09.261307-03
27	10	6	2026	6	2026-07-01 08:38:56.930075-03
28	6	6	2026	6	2026-07-01 08:40:36.639288-03
29	9	7	2026	6	2026-08-03 16:52:26.828935-03
30	8	7	2026	6	2026-08-03 16:55:20.87299-03
31	7	7	2026	6	2026-08-03 16:56:48.409348-03
32	10	7	2026	6	2026-08-03 16:58:13.394798-03
33	6	7	2026	6	2026-08-03 16:59:20.042664-03
\.


--
-- Data for Name: pending_import_items; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.pending_import_items (id, report_id, raw_name_from_excel, tickets_finalizados, resolved, resolved_agent_id) FROM stdin;
7	1	Isabela Igarashi - Financeiro	5	t	45
5	1	Isabelle Duszeiko - Financeiro	59	t	46
1	1	Nayani Oliveira - Recepção	993	t	47
6	1	anacarolinaoliveira.sattrack@gmail.com	13	t	48
4	1	allanjorge.sattrack@gmail.com	67	t	49
2	1	Fernanda Santos	422	t	50
3	1	Fatima Galbero - Gestora Financeira	367	t	51
33	3	Emanuelle Vidal - Pós-Vendas	1	t	58
32	3	Erica da Costa - Vendas (MGA)	3	t	59
31	3	Micaelly - Agendamento (MGA)	4	t	60
30	3	Vitor Hugo - Suporte/Frota	4	t	61
29	3	Amanda Saunite - Vendas (MGA)	7	t	62
28	3	Rayane Zavatini - Vendas (MGA)	7	t	63
27	3	Geovana Mendes - Plus (MGA)	8	t	64
26	3	anacarolinaoliveira.sattrack@gmail.com	8	t	65
25	3	Julia Camille - Suporte	9	t	66
24	3	Rafaeli Pereira - Pós-Vendas (MGA)	11	t	67
23	3	Mariany Matos - Pré-Jurídico	12	t	68
22	3	Isabela Pereira - Suporte	18	t	69
21	3	Tatiane Regina - Agendamento (MGA)	20	t	70
20	3	Lorrayne de Morais - Financeiro	21	t	71
19	3	Fernanda Santos	28	t	72
18	3	Raissa Zavatini - Vendas (MGA)	35	t	73
17	3	Beatriz Alves - Suporte	53	t	74
16	3	Nicoly Barbosa - Financeiro	59	t	75
15	3	Amanda Pereira - Pós-Vendas	117	t	76
14	3	Isabela Igarashi - Financeiro	172	t	77
13	3	Fatima Galbero - Gestora Financeira	186	t	78
12	3	Camila Dionisio - Recepção (MGA)	192	t	79
11	3	Maria Fernanda - Financeiro	215	t	80
10	3	Janaina Torres - Financeiro	231	t	81
9	3	Emanuelle Vitória - Financeiro	262	t	82
8	3	Isabelle Duszeiko - Financeiro	526	t	83
63	4	anacarolinaoliveira.sattrack@gmail.com	1	t	84
62	4	Vitor Hugo - Suporte/Frota	2	t	85
61	4	Natalya Nagyla - Vendas	2	t	86
59	4	Daniele Campanholi - Agendamento (CWB)	7	t	87
58	4	Mariany Matos - Pré-Jurídico	7	t	88
57	4	Giovana Ferreira - Plus (CWB)	9	t	89
56	4	Vanessa Montini - Pós-Vendas	10	t	90
55	4	Lorrayne de Morais - Financeiro	10	t	91
54	4	Nathalia Franco - Pós-Vendas	15	t	92
53	4	Julia Camille - Suporte	15	t	93
52	4	Isabela Pereira - Suporte	16	t	94
51	4	Beatriz Alves - Suporte	20	t	95
50	4	Fernanda Santos	22	t	96
49	4	Caroline Paola - Pós-Vendas	28	t	97
48	4	Larissa Soares - Vendas (CWB)	35	t	98
47	4	Karol Schamne - Vendas (CWB)	36	t	99
46	4	Emanuelle Vidal - Pós-Vendas	37	t	100
44	4	Nicoly Barbosa - Financeiro	56	t	101
43	4	Fernanda Teixeira - Pós-Vendas	60	t	102
42	4	Nathalia Covas - Vendas (CWT)	69	t	103
41	4	Fatima Galbero - Gestora Financeira	81	t	104
40	4	Ana Luiza Montenegro - Vendas (CWB)	82	t	105
38	4	Emanuelle Vitória - Financeiro	139	t	106
37	4	Recepção - Curitiba	148	t	107
36	4	Isabela Igarashi - Financeiro	175	t	108
34	4	Isabelle Duszeiko - Financeiro	476	t	109
35	4	Janaina Torres - Financeiro	193	t	110
39	4	Maria Fernanda - Financeiro	128	t	111
60	4	rafaeliferreira.sattrack@gmail.com	3	t	112
45	4	Jaqueline Gomes	42	t	113
93	5	Tainá Oliveira - Plus	1	t	114
92	5	Nathalia Franco - Pós-Vendas	1	t	115
91	5	Luana Santos - Vendas (PG)	1	t	116
90	5	Isabella Bueno - SAC	1	t	117
89	5	Evelyn Nogueira - Plus	1	t	118
88	5	Vanessa Montini - Pós-Vendas	2	t	119
87	5	Vitor Hugo - Suporte/Frota	2	t	120
86	5	Sumaya Larissa - Plus	2	t	121
85	5	Nayani Oliveira - Recepção	2	t	122
84	5	Lorrayne de Morais - Financeiro	2	t	123
83	5	Isabela Pereira - Suporte	2	t	124
82	5	Fernanda Santos	2	t	125
81	5	Caroline Paola - Pós-Vendas	2	t	126
80	5	Beatriz Alves - Suporte	2	t	127
79	5	Lais Teixeira	3	t	128
78	5	Julia Camille - Suporte	3	t	129
77	5	Emanuelle Vidal - Pós-Vendas	4	t	130
76	5	Fatima Galbero - Gestora Financeira	5	t	131
75	5	Fernanda Teixeira - Pós-Vendas	6	t	132
74	5	Nicoly Barbosa - Financeiro	6	t	133
73	5	Ludiane Araujo - Guincho	6	t	134
72	5	Julia Andrade - Pós-Vendas	7	t	135
71	5	Maria Fernanda - Financeiro	18	t	136
70	5	Beatriz Loures - Vendas (PG)	21	t	137
69	5	Janaina Torres - Financeiro	25	t	138
68	5	Isabela Igarashi - Financeiro	26	t	139
67	5	Emanuelle Vitória - Financeiro	34	t	140
66	5	Kauane Oliveira - Recepção (PG)	38	t	141
65	5	Carolina de Paula - Vendas (PG)	50	t	142
64	5	Isabelle Duszeiko - Financeiro	93	t	143
96	6	Maria Garrido	17	t	146
95	6	Nathalia Covas - Vendas (CWT)	54	t	149
94	6	Ysabella Matos	172	t	145
97	6	Aliane Rezende - Gestora Pós-Vendas	1	t	147
98	6	Sattrack Rastreamento	1	t	148
100	7	Maria Garrido	5	t	156
99	7	Ysabella Matos	97	t	157
101	8	Ysabella Matos	65	t	160
102	8	Maria Garrido	2	t	161
103	9	Ysabella Matos	4	t	163
106	2	Ana Paula Alves - Vendas	14	t	165
107	2	Thayrini Dantas - Guincho	6	t	166
104	2	raphaelle.sattrack@gmail.com	1274	t	167
105	2	Nicolly Rocha	251	t	168
113	10	viniciuslessa.sattrack@gmail.com	2	t	173
112	10	Caroline Paola - Pós-Vendas	12	t	174
111	10	Nathalia Franco - Pós-Vendas	14	t	175
110	10	Vanessa Montini - Pós-Vendas	15	t	176
109	10	Fernanda Teixeira - Pós-Vendas	18	t	177
108	10	Julia Andrade - Pós-Vendas	19	t	178
114	11	Franciele Martins - Vendas (CWB)	8	t	179
123	13	Nathalia Franco - Pós-Vendas	1	t	180
121	13	Isabelle Duszeiko - Financeiro	1	t	181
120	13	Janaina Torres - Financeiro	2	t	182
119	13	Isabelle Simionatto - Vendas (CAS)	3	t	183
117	13	Rosenice Andrade - Vendas (CAS)	6	t	184
116	13	Alana Dinkel - Vendas (CAS)	6	t	185
115	13	Bruna Basso - SAC	11	t	186
118	13	Maria Cavalheiro - Recepção (CAS)	4	t	187
122	13	Nayani Oliveira - Recepção	1	t	188
127	14	Nathália Nunes - Plus	8	t	190
124	14	Emanuella Paiva	520	t	189
126	14	Ana Julia Neves	44	t	200
125	14	Janaina Torres - Financeiro	140	t	201
128	14	Kattellyn Dantas - Locadora	4	t	202
134	17	Emanuelle Vitória - Financeiro	3	t	203
135	17	Maria Fernanda - Financeiro	3	t	204
136	17	Ludiane Araujo - Guincho	2	t	205
137	17	Janiele - SAC	1	t	206
138	17	Sumaya Larissa - Plus	1	t	207
139	17	Thayrini Dantas - Guincho	1	t	208
132	16	Ana Julia Neves	109	t	209
133	16	Emanuella Paiva	69	t	210
130	15	Emanuella Paiva	81	t	211
129	15	Ana Julia Neves	133	t	212
131	15	Kattellyn Dantas - Locadora	1	t	213
142	18	Thayrini Dantas - Guincho	1	t	214
141	18	Emanuella Paiva	6	t	215
140	18	Ana Julia Neves	10	t	216
179	25	Isabela Dos Santos Pereira	25	t	251
178	25	Raphaelle Nayara - Financeiro	75	t	252
177	25	Nicolly Rocha - Financeiro	102	t	253
176	25	Giovanna Gomes - Financeiro	118	t	254
180	25	palomagabrielle.sattrack@gmail.com	2	t	255
155	20	Danielle Siqueira - Pós-Vendas (MGA)	152	t	229
156	20	Juliana Aparecida - Pós-Vendas (MGA)	99	t	230
157	20	Beatriz Amaly De Mello Ribeirete	19	t	231
158	21	Fernanda Silva Teixeira - Vendas	49	t	232
159	21	Melany - Pós-Vendas (CWB)	14	t	233
160	21	Ingrid Hampf - Vendas (CWB)	5	t	234
161	21	natalya.sattrack@gmail.com	3	t	235
162	21	Beatriz Amaly De Mello Ribeirete	2	t	236
166	22	Carla Cristina - Plus	1	t	237
165	22	Bruna Basso - SAC	1	t	238
164	22	Nathália Nunes - Plus	1	t	239
163	22	Fernanda Silva Teixeira - Vendas	5	t	240
168	23	Julia Andrade - Pós-Vendas	1	t	241
167	23	Ana Julia Neves	2	t	242
187	26	Sumaya Larissa - Plus	2	t	256
181	26	Nicolly Rocha - Financeiro	78	t	257
173	19	Nayani Oliveira - Recepção	1	t	250
172	19	Fernanda Silva Teixeira - Pós-Vendas	110	t	22
171	19	Isabela Dos Santos Pereira	203	t	37
174	24	Isabela Dos Santos Pereira	229	t	37
175	24	Fernanda Silva Teixeira - Pós-Vendas	123	t	22
182	26	Giovanna Gomes - Financeiro	54	t	258
183	26	Raphaelle Nayara - Financeiro	24	t	259
184	26	Fernanda Silva Teixeira - Pós-Vendas	22	t	260
185	26	Isabela Dos Santos Pereira	18	t	261
186	26	Carla Cristina - Plus	2	t	262
188	27	Taciane Kolodo - Vendas (PG)	44	t	263
189	27	Nicolly Rocha - Financeiro	11	t	264
190	27	Giovanna Gomes - Financeiro	6	t	265
191	27	Isabela Dos Santos Pereira	4	t	266
192	27	Raphaelle Nayara - Financeiro	4	t	267
193	27	Jerlane Correa - SAC	2	t	268
194	27	Fernanda Silva Teixeira - Pós-Vendas	2	t	269
195	28	Beatriz Alves - Suporte	2	t	270
196	28	Emanuella Paiva	1	t	271
198	29	Isabela Dos Santos Pereira	567	t	37
197	29	lorena caroline	961	t	283
202	29	Larissa Tatiane - Pós-Vendas	2	t	284
200	29	Fernanda Silva Teixeira - Pós-Vendas	146	t	285
199	29	Adriele Gasperi	216	t	286
201	29	Debora Correa	25	t	287
204	30	Debora Correa	3	t	288
203	30	Adriele Gasperi	56	t	289
205	30	Julia Clemes - Agendamento (MGA)	3	t	290
206	31	Adriele Gasperi	45	t	291
207	31	Evelyn Nogueira - Plus	5	t	292
208	31	Debora Correa	3	t	293
210	32	Debora Correa	1	t	295
209	32	Adriele Gasperi	5	t	294
212	33	Caroline Paola - Pós-Vendas	1	t	296
211	33	Adriele Gasperi	4	t	297
\.


--
-- Data for Name: sectors; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.sectors (id, branch_id, name, color, active) FROM stdin;
7	6	Serasa	#b2921f	t
8	6	Suporte	#461fb2	t
10	6	Vendas	#26cf5e	t
11	6	Pós-Vendas	#264b32	t
12	6	Pré-Juridico	#9a2d97	t
14	6	Guincho	#9f82d3	t
15	6	SAC	#bae34a	t
16	9	Suporte	#0e7490	t
17	9	Serasa	#c5871b	t
18	9	Financeiro	#d7e236	t
19	9	Vendas	#3aca2f	t
21	9	Pré-Juridico	#2d9ed7	t
23	9	Agendamento	#c84646	t
24	9	Guincho	#c73dc2	t
25	9	SAC	#736f76	t
26	9	Recepção	#1fcedb	t
20	9	Pós-Vendas	#e2ac18	t
27	8	Agendamento	#b02727	t
28	8	Financeiro	#ca3f89	t
29	8	Guincho	#ae3bce	t
31	8	Pós-Vendas	#39363a	t
32	8	Pré-Juridico	#3044d9	t
33	8	Recepção	#30a6d9	t
34	8	SAC	#30d9a1	t
35	8	Serasa	#30d95a	t
36	8	Suporte	#d6d930	t
37	8	Vendas	#d99330	t
38	7	Agendamento	#0e7490	t
39	7	Financeiro	#22c7d3	t
40	7	Guincho	#d35722	t
41	7	Plus	#d3cd22	t
42	7	Pós-Vendas	#25d322	t
44	7	Recepção	#363a36	t
45	7	SAC	#cf3a67	t
46	7	Serasa	#3a44cf	t
47	7	Suporte	#df2ac7	t
48	7	Vendas	#d3df2a	t
49	10	Agendamento	#32a7c8	t
50	10	Financeiro	#c0e637	t
51	10	Guincho	#e63737	t
52	10	Plus	#e637b8	t
53	10	Pós-Vendas	#6c37e6	t
54	10	Pré-Juridico	#d9d5e1	t
55	10	Recepção	#35e953	t
56	10	SAC	#e9da35	t
57	10	Serasa	#e37831	t
58	10	Suporte	#403d3b	t
59	10	Vendas	#2f925a	t
22	9	Plus	#74b4d2	t
30	8	Plus	#e09c3e	t
43	7	Pré-Juridico	#fd0808	t
13	6	Plus	#63ddee	t
60	6	Recepção	#f196f3	t
6	6	Agendamento	#585de4	t
9	6	Financeiro	#d56c6c	t
61	9	Locadora	#795686	t
62	8	Locadora	#b7c8cc	t
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
-- NOTE: password_hash values are redacted in this export (not the real bcrypt hashes).
--

INSERT INTO public.users (id, name, email, password_hash, role, active, created_at, last_seen_at) VALUES ('1', 'Administrador', 'admin@local', 'REDACTED', 'ADMIN', 't', '2026-03-03 11:23:27.47424-03', '2026-09-11 16:30:38.779532-03');
INSERT INTO public.users (id, name, email, password_hash, role, active, created_at, last_seen_at) VALUES ('2', 'Carlos Nunes', 'carlosnunes@sattrack.com', 'REDACTED', 'USER', 't', '2026-03-06 08:59:05.719063-03', '2026-08-10 15:13:47.588821-03');
INSERT INTO public.users (id, name, email, password_hash, role, active, created_at, last_seen_at) VALUES ('6', 'Vinícius Cezar', 'viniciuscezar@sattrack.com', 'REDACTED', 'ADMIN', 't', '2026-03-06 09:24:56.01971-03', '2026-09-18 11:36:59.786227-03');
INSERT INTO public.users (id, name, email, password_hash, role, active, created_at, last_seen_at) VALUES ('7', 'Fernanda Loiola', 'fernanda@sattrack.com', 'REDACTED', 'USER', 't', '2026-03-07 09:23:31.475544-03', '2026-07-27 12:34:18.946681-03');
INSERT INTO public.users (id, name, email, password_hash, role, active, created_at, last_seen_at) VALUES ('8', 'Henrique Turra', 'henrique@sattrack.com', 'REDACTED', 'USER', 't', '2026-05-18 17:38:57.923745-03', '2026-08-10 15:44:04.167759-03');
INSERT INTO public.users (id, name, email, password_hash, role, active, created_at, last_seen_at) VALUES ('10', 'Luiz', 'luiz@sattrack.com', 'REDACTED', 'USER', 't', '2026-08-04 09:09:08.224859-03', '2026-08-06 11:00:19.516458-03');


--
-- Name: agents_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.agents_id_seq', 306, true);


--
-- Name: branches_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.branches_id_seq', 20, true);


--
-- Name: monthly_report_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.monthly_report_items_id_seq', 1114, true);


--
-- Name: monthly_reports_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.monthly_reports_id_seq', 33, true);


--
-- Name: pending_import_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.pending_import_items_id_seq', 212, true);


--
-- Name: sectors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.sectors_id_seq', 62, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.users_id_seq', 10, true);


--
-- Name: agents agents_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agents
    ADD CONSTRAINT agents_pkey PRIMARY KEY (id);


--
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- Name: branches branches_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.branches
    ADD CONSTRAINT branches_name_key UNIQUE (name);


--
-- Name: branches branches_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.branches
    ADD CONSTRAINT branches_pkey PRIMARY KEY (id);


--
-- Name: monthly_report_items monthly_report_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.monthly_report_items
    ADD CONSTRAINT monthly_report_items_pkey PRIMARY KEY (id);


--
-- Name: monthly_reports monthly_reports_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.monthly_reports
    ADD CONSTRAINT monthly_reports_pkey PRIMARY KEY (id);


--
-- Name: pending_import_items pending_import_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pending_import_items
    ADD CONSTRAINT pending_import_items_pkey PRIMARY KEY (id);


--
-- Name: sectors sectors_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sectors
    ADD CONSTRAINT sectors_pkey PRIMARY KEY (id);


--
-- Name: agents uq_agent_branch_name; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agents
    ADD CONSTRAINT uq_agent_branch_name UNIQUE (branch_id, name);


--
-- Name: monthly_reports uq_report_branch_month_year; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.monthly_reports
    ADD CONSTRAINT uq_report_branch_month_year UNIQUE (branch_id, month, year);


--
-- Name: monthly_report_items uq_report_item_agent; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.monthly_report_items
    ADD CONSTRAINT uq_report_item_agent UNIQUE (report_id, agent_id);


--
-- Name: sectors uq_sector_branch_name; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sectors
    ADD CONSTRAINT uq_sector_branch_name UNIQUE (branch_id, name);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: ix_agents_branch_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_agents_branch_id ON public.agents USING btree (branch_id);


--
-- Name: ix_agents_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_agents_id ON public.agents USING btree (id);


--
-- Name: ix_agents_sector_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_agents_sector_id ON public.agents USING btree (sector_id);


--
-- Name: ix_branches_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_branches_id ON public.branches USING btree (id);


--
-- Name: ix_monthly_report_items_agent_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_monthly_report_items_agent_id ON public.monthly_report_items USING btree (agent_id);


--
-- Name: ix_monthly_report_items_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_monthly_report_items_id ON public.monthly_report_items USING btree (id);


--
-- Name: ix_monthly_report_items_report_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_monthly_report_items_report_id ON public.monthly_report_items USING btree (report_id);


--
-- Name: ix_monthly_reports_branch_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_monthly_reports_branch_id ON public.monthly_reports USING btree (branch_id);


--
-- Name: ix_monthly_reports_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_monthly_reports_id ON public.monthly_reports USING btree (id);


--
-- Name: ix_monthly_reports_month; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_monthly_reports_month ON public.monthly_reports USING btree (month);


--
-- Name: ix_monthly_reports_year; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_monthly_reports_year ON public.monthly_reports USING btree (year);


--
-- Name: ix_pending_import_items_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_pending_import_items_id ON public.pending_import_items USING btree (id);


--
-- Name: ix_pending_import_items_report_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_pending_import_items_report_id ON public.pending_import_items USING btree (report_id);


--
-- Name: ix_sectors_branch_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_sectors_branch_id ON public.sectors USING btree (branch_id);


--
-- Name: ix_sectors_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_sectors_id ON public.sectors USING btree (id);


--
-- Name: ix_users_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX ix_users_email ON public.users USING btree (email);


--
-- Name: ix_users_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_users_id ON public.users USING btree (id);


--
-- Name: agents agents_branch_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agents
    ADD CONSTRAINT agents_branch_id_fkey FOREIGN KEY (branch_id) REFERENCES public.branches(id) ON DELETE CASCADE;


--
-- Name: agents agents_sector_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agents
    ADD CONSTRAINT agents_sector_id_fkey FOREIGN KEY (sector_id) REFERENCES public.sectors(id) ON DELETE RESTRICT;


--
-- Name: monthly_report_items monthly_report_items_agent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.monthly_report_items
    ADD CONSTRAINT monthly_report_items_agent_id_fkey FOREIGN KEY (agent_id) REFERENCES public.agents(id) ON DELETE RESTRICT;


--
-- Name: monthly_report_items monthly_report_items_report_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.monthly_report_items
    ADD CONSTRAINT monthly_report_items_report_id_fkey FOREIGN KEY (report_id) REFERENCES public.monthly_reports(id) ON DELETE CASCADE;


--
-- Name: monthly_reports monthly_reports_branch_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.monthly_reports
    ADD CONSTRAINT monthly_reports_branch_id_fkey FOREIGN KEY (branch_id) REFERENCES public.branches(id) ON DELETE CASCADE;


--
-- Name: monthly_reports monthly_reports_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.monthly_reports
    ADD CONSTRAINT monthly_reports_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id) ON DELETE RESTRICT;


--
-- Name: pending_import_items pending_import_items_report_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pending_import_items
    ADD CONSTRAINT pending_import_items_report_id_fkey FOREIGN KEY (report_id) REFERENCES public.monthly_reports(id) ON DELETE CASCADE;


--
-- Name: pending_import_items pending_import_items_resolved_agent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pending_import_items
    ADD CONSTRAINT pending_import_items_resolved_agent_id_fkey FOREIGN KEY (resolved_agent_id) REFERENCES public.agents(id) ON DELETE SET NULL;


--
-- Name: sectors sectors_branch_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sectors
    ADD CONSTRAINT sectors_branch_id_fkey FOREIGN KEY (branch_id) REFERENCES public.branches(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict 3jnaYqNveKMdcnO5GtjabmprHjPvBh7cVaP74hVIFaqUVsh5sq9SSk7hRD44MsZ

