--
-- PostgreSQL database dump
--

-- Dumped from database version 13.2
-- Dumped by pg_dump version 13.2

-- Started on 2022-08-25 10:06:40

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 200 (class 1259 OID 41214)
-- Name: docent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.docent (
    card_number character varying(255) NOT NULL,
    id bigint NOT NULL
);


ALTER TABLE public.docent OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 41221)
-- Name: file; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.file (
    id bigint NOT NULL,
    file_name character varying(255) NOT NULL,
    file_path character varying(255) NOT NULL,
    owner character varying(255) NOT NULL,
    type_file character varying(255) NOT NULL,
    update_time timestamp without time zone,
    thesis bigint NOT NULL
);


ALTER TABLE public.file OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 41219)
-- Name: file_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.file_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.file_id_seq OWNER TO postgres;

--
-- TOC entry 3057 (class 0 OID 0)
-- Dependencies: 201
-- Name: file_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.file_id_seq OWNED BY public.file.id;


--
-- TOC entry 203 (class 1259 OID 41230)
-- Name: hibernate_sequences; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hibernate_sequences (
    sequence_name character varying(255) NOT NULL,
    next_val bigint
);


ALTER TABLE public.hibernate_sequences OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 41237)
-- Name: message; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.message (
    id bigint NOT NULL,
    message_time timestamp without time zone NOT NULL,
    read boolean NOT NULL,
    text character varying(255) NOT NULL,
    receiver bigint NOT NULL,
    sender bigint NOT NULL
);


ALTER TABLE public.message OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 41235)
-- Name: message_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.message_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.message_id_seq OWNER TO postgres;

--
-- TOC entry 3058 (class 0 OID 0)
-- Dependencies: 204
-- Name: message_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.message_id_seq OWNED BY public.message.id;


--
-- TOC entry 206 (class 1259 OID 41243)
-- Name: person; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.person (
    id bigint NOT NULL,
    department character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    password character varying(255),
    surname character varying(255) NOT NULL
);


ALTER TABLE public.person OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 41251)
-- Name: student; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.student (
    degree_course character varying(255) NOT NULL,
    registration_number character varying(6) NOT NULL,
    id bigint NOT NULL
);


ALTER TABLE public.student OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 41258)
-- Name: thesis; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.thesis (
    id bigint NOT NULL,
    title character varying(255) NOT NULL,
    type character varying(255) NOT NULL,
    main_supervisor bigint NOT NULL,
    thesis_student bigint
);


ALTER TABLE public.thesis OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 41256)
-- Name: thesis_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.thesis_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.thesis_id_seq OWNER TO postgres;

--
-- TOC entry 3059 (class 0 OID 0)
-- Dependencies: 208
-- Name: thesis_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.thesis_id_seq OWNED BY public.thesis.id;


--
-- TOC entry 210 (class 1259 OID 41267)
-- Name: thesis_supervisors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.thesis_supervisors (
    docent_id bigint NOT NULL,
    thesis_id bigint NOT NULL
);


ALTER TABLE public.thesis_supervisors OWNER TO postgres;

--
-- TOC entry 2885 (class 2604 OID 41224)
-- Name: file id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.file ALTER COLUMN id SET DEFAULT nextval('public.file_id_seq'::regclass);


--
-- TOC entry 2886 (class 2604 OID 41240)
-- Name: message id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.message ALTER COLUMN id SET DEFAULT nextval('public.message_id_seq'::regclass);


--
-- TOC entry 2887 (class 2604 OID 41261)
-- Name: thesis id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.thesis ALTER COLUMN id SET DEFAULT nextval('public.thesis_id_seq'::regclass);


--
-- TOC entry 3041 (class 0 OID 41214)
-- Dependencies: 200
-- Data for Name: docent; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.docent (card_number, id) FROM stdin;
201015	1
\.


--
-- TOC entry 3043 (class 0 OID 41221)
-- Dependencies: 202
-- Data for Name: file; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.file (id, file_name, file_path, owner, type_file, update_time, thesis) FROM stdin;
\.


--
-- TOC entry 3044 (class 0 OID 41230)
-- Dependencies: 203
-- Data for Name: hibernate_sequences; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.hibernate_sequences (sequence_name, next_val) FROM stdin;
default	1
\.


--
-- TOC entry 3046 (class 0 OID 41237)
-- Dependencies: 205
-- Data for Name: message; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.message (id, message_time, read, text, receiver, sender) FROM stdin;
\.


--
-- TOC entry 3047 (class 0 OID 41243)
-- Dependencies: 206
-- Data for Name: person; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.person (id, department, email, name, password, surname) FROM stdin;
1	DIMES	beniamino.morrone@gmail.com	Beniamino	password	Morrone
\.


--
-- TOC entry 3048 (class 0 OID 41251)
-- Dependencies: 207
-- Data for Name: student; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.student (degree_course, registration_number, id) FROM stdin;
\.


--
-- TOC entry 3050 (class 0 OID 41258)
-- Dependencies: 209
-- Data for Name: thesis; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.thesis (id, title, type, main_supervisor, thesis_student) FROM stdin;
\.


--
-- TOC entry 3051 (class 0 OID 41267)
-- Dependencies: 210
-- Data for Name: thesis_supervisors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.thesis_supervisors (docent_id, thesis_id) FROM stdin;
\.


--
-- TOC entry 3060 (class 0 OID 0)
-- Dependencies: 201
-- Name: file_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.file_id_seq', 1, false);


--
-- TOC entry 3061 (class 0 OID 0)
-- Dependencies: 204
-- Name: message_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.message_id_seq', 1, false);


--
-- TOC entry 3062 (class 0 OID 0)
-- Dependencies: 208
-- Name: thesis_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.thesis_id_seq', 1, false);


--
-- TOC entry 2889 (class 2606 OID 41218)
-- Name: docent docent_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.docent
    ADD CONSTRAINT docent_pkey PRIMARY KEY (id);


--
-- TOC entry 2891 (class 2606 OID 41229)
-- Name: file file_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.file
    ADD CONSTRAINT file_pkey PRIMARY KEY (id);


--
-- TOC entry 2893 (class 2606 OID 41234)
-- Name: hibernate_sequences hibernate_sequences_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hibernate_sequences
    ADD CONSTRAINT hibernate_sequences_pkey PRIMARY KEY (sequence_name);


--
-- TOC entry 2895 (class 2606 OID 41242)
-- Name: message message_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.message
    ADD CONSTRAINT message_pkey PRIMARY KEY (id);


--
-- TOC entry 2897 (class 2606 OID 41250)
-- Name: person person_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT person_pkey PRIMARY KEY (id);


--
-- TOC entry 2899 (class 2606 OID 41255)
-- Name: student student_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_pkey PRIMARY KEY (id);


--
-- TOC entry 2901 (class 2606 OID 41266)
-- Name: thesis thesis_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.thesis
    ADD CONSTRAINT thesis_pkey PRIMARY KEY (id);


--
-- TOC entry 2909 (class 2606 OID 41305)
-- Name: thesis_supervisors fk9fedx9gm50k216do521i0h2d4; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.thesis_supervisors
    ADD CONSTRAINT fk9fedx9gm50k216do521i0h2d4 FOREIGN KEY (thesis_id) REFERENCES public.thesis(id);


--
-- TOC entry 2908 (class 2606 OID 41300)
-- Name: thesis fkc44p1bsahnmnux9jxekepdrm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.thesis
    ADD CONSTRAINT fkc44p1bsahnmnux9jxekepdrm FOREIGN KEY (thesis_student) REFERENCES public.student(id);


--
-- TOC entry 2907 (class 2606 OID 41295)
-- Name: thesis fkeo604v28qycwq7q72w38o54ce; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.thesis
    ADD CONSTRAINT fkeo604v28qycwq7q72w38o54ce FOREIGN KEY (main_supervisor) REFERENCES public.docent(id);


--
-- TOC entry 2902 (class 2606 OID 41270)
-- Name: docent fkld2l1acj1epurdy3hu4ehw0py; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.docent
    ADD CONSTRAINT fkld2l1acj1epurdy3hu4ehw0py FOREIGN KEY (id) REFERENCES public.person(id);


--
-- TOC entry 2905 (class 2606 OID 41285)
-- Name: message fklsaqg0sbw4hb7jgc9x1yjp5kw; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.message
    ADD CONSTRAINT fklsaqg0sbw4hb7jgc9x1yjp5kw FOREIGN KEY (sender) REFERENCES public.person(id);


--
-- TOC entry 2903 (class 2606 OID 41275)
-- Name: file fkmgw29rq3v8hbkxraofgy7uyuh; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.file
    ADD CONSTRAINT fkmgw29rq3v8hbkxraofgy7uyuh FOREIGN KEY (thesis) REFERENCES public.thesis(id);


--
-- TOC entry 2904 (class 2606 OID 41280)
-- Name: message fkmyj60ut7jqirgfbsx9kruysyt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.message
    ADD CONSTRAINT fkmyj60ut7jqirgfbsx9kruysyt FOREIGN KEY (receiver) REFERENCES public.person(id);


--
-- TOC entry 2910 (class 2606 OID 41310)
-- Name: thesis_supervisors fksgxxaek0sljw40hd363gpferj; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.thesis_supervisors
    ADD CONSTRAINT fksgxxaek0sljw40hd363gpferj FOREIGN KEY (docent_id) REFERENCES public.docent(id);


--
-- TOC entry 2906 (class 2606 OID 41290)
-- Name: student fkslayvtom01idjdexcxh76k935; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student
    ADD CONSTRAINT fkslayvtom01idjdexcxh76k935 FOREIGN KEY (id) REFERENCES public.person(id);


-- Completed on 2022-08-25 10:06:41

--
-- PostgreSQL database dump complete
--

