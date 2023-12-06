--
-- PostgreSQL database dump
--

-- Dumped from database version 16.1
-- Dumped by pg_dump version 16.1

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
-- Name: silos; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.silos (
                              id integer NOT NULL,
                              name character varying NOT NULL,
                              description text,
                              from_t timestamp without time zone,
                              color character varying(8),
                              lock boolean DEFAULT false NOT NULL,
                              status_id integer NOT NULL,
                              created_at timestamp without time zone DEFAULT now() NOT NULL,
                              updated_at timestamp without time zone
);


--
-- Name: silos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.silos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: silos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.silos_id_seq OWNED BY public.silos.id;


--
-- Name: silos_tasks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.silos_tasks (
                                    silos_id integer NOT NULL,
                                    tasks_id integer NOT NULL
);


--
-- Name: statuses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.statuses (
                                 id integer NOT NULL,
                                 name character varying NOT NULL
);


--
-- Name: statuses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.statuses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: statuses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.statuses_id_seq OWNED BY public.statuses.id;


--
-- Name: tasks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tasks (
                              id integer NOT NULL,
                              name character varying NOT NULL,
                              description text,
                              status_id integer NOT NULL,
                              color character varying(8),
                              created_at timestamp without time zone NOT NULL
);


--
-- Name: tasks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tasks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tasks_id_seq OWNED BY public.tasks.id;


--
-- Name: tasks_users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tasks_users (
                                    tasks_id integer NOT NULL,
                                    users_id integer NOT NULL
);


--
-- Name: user_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_seq
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
                              id bigint NOT NULL,
                              name character varying(16) NOT NULL,
                              code character varying(6) NOT NULL,
                              color character varying(8),
                              created_at timestamp without time zone DEFAULT now() NOT NULL,
                              deleted_at timestamp without time zone,
                              updated_at timestamp(6) without time zone
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
-- Name: users_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_seq
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: silos id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.silos ALTER COLUMN id SET DEFAULT nextval('public.silos_id_seq'::regclass);


--
-- Name: statuses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.statuses ALTER COLUMN id SET DEFAULT nextval('public.statuses_id_seq'::regclass);


--
-- Name: tasks id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tasks ALTER COLUMN id SET DEFAULT nextval('public.tasks_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: silos silos_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.silos
    ADD CONSTRAINT silos_pkey PRIMARY KEY (id);


--
-- Name: statuses statuses_id; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.statuses
    ADD CONSTRAINT statuses_id PRIMARY KEY (id);


--
-- Name: statuses statuses_name; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.statuses
    ADD CONSTRAINT statuses_name UNIQUE (name);


--
-- Name: tasks tasks_id; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_id PRIMARY KEY (id);


--
-- Name: users users_id; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_id PRIMARY KEY (id);


--
-- Name: users users_name; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_name UNIQUE (name);


--
-- Name: silos_name_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX silos_name_index ON public.silos USING btree (name) WITH (deduplicate_items='true');


--
-- Name: tasks_name_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX tasks_name_index ON public.tasks USING btree (name) WITH (deduplicate_items='true');


--
-- Name: users_name_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX users_name_index ON public.users USING btree (name) WITH (deduplicate_items='true');


--
-- Name: silos_tasks silos_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.silos_tasks
    ADD CONSTRAINT silos_id FOREIGN KEY (silos_id) REFERENCES public.silos(id) ON UPDATE CASCADE;


--
-- Name: silos silos_status_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.silos
    ADD CONSTRAINT silos_status_id FOREIGN KEY (status_id) REFERENCES public.statuses(id) ON UPDATE CASCADE;


--
-- Name: silos_tasks tasks_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.silos_tasks
    ADD CONSTRAINT tasks_id FOREIGN KEY (tasks_id) REFERENCES public.tasks(id) ON UPDATE CASCADE;


--
-- Name: tasks_users tasks_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tasks_users
    ADD CONSTRAINT tasks_id FOREIGN KEY (tasks_id) REFERENCES public.tasks(id) ON UPDATE CASCADE;


--
-- Name: tasks tasks_status_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_status_id FOREIGN KEY (status_id) REFERENCES public.statuses(id) ON UPDATE CASCADE;


--
-- Name: tasks_users users_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tasks_users
    ADD CONSTRAINT users_id FOREIGN KEY (users_id) REFERENCES public.users(id) ON UPDATE CASCADE;


--
-- PostgreSQL database dump complete
--

