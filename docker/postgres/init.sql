--
-- PostgreSQL database dump
--

-- Dumped from database version 16.1
-- Dumped by pg_dump version 16.1

SET
    statement_timeout = 0;
SET
    lock_timeout = 0;
SET
    idle_in_transaction_session_timeout = 0;
SET
    client_encoding = 'UTF8';
SET
    standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET
    check_function_bodies = false;
SET
    xmloption = content;
SET
    client_min_messages = warning;
SET
    row_security = off;

SET
    default_tablespace = '';

SET
    default_table_access_method = heap;

--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users
(
    id         bigint                         NOT NULL,
    name       character varying(16)          NOT NULL,
    email      character varying(255)         NOT NULL,
    password   character varying(255)         NOT NULL,
    color      character varying(8)           NOT NULL,
    created_at timestamp(6) without time zone NOT NULL DEFAULT now(),
    updated_at timestamp(6) without time zone,
    deleted_at timestamp(6) without time zone
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

