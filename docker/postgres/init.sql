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

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA public;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.roles
(
    id          bigint                NOT NULL,
    name        character varying(32) NOT NULL,
    description character varying(255)
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
-- Name: silos; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.silos
(
    id          uuid                                                  NOT NULL,
    name        character varying(64)                                 NOT NULL,
    description text,
    from_dt     timestamp(6) without time zone                        NOT NULL,
    to_dt       timestamp(6) without time zone                        NOT NULL,
    status_id   bigint                                                NOT NULL,
    color       character varying(8),
    lock        boolean                                               NOT NULL,
    created_at  timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at  timestamp(6) without time zone,
    deleted_at  timestamp(6) without time zone,
    CONSTRAINT silos_color_check CHECK (((length((color)::text) = 6) OR (length((color)::text) = 8)))
);


--
-- Name: silos_tasks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.silos_tasks
(
    silo_id uuid NOT NULL,
    task_id uuid NOT NULL
);


--
-- Name: statuses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.statuses
(
    id          bigint                 NOT NULL,
    name        character varying(255) NOT NULL,
    description text,
    color       character varying(8)
);


--
-- Name: statuses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.statuses_id_seq
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

CREATE TABLE public.tasks
(
    id          uuid                                                  NOT NULL,
    name        character varying(64)                                 NOT NULL,
    description text,
    color       character varying(8),
    status_id   bigint                                                NOT NULL,
    created_at  timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at  timestamp(6) without time zone,
    deleted_at  timestamp(6) without time zone,
    CONSTRAINT tasks_color_check CHECK (((length((color)::text) = 6) OR (length((color)::text) = 8)))
);


--
-- Name: teams; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.teams
(
    id          uuid                                                  NOT NULL,
    name        character varying(255)                                NOT NULL,
    description character varying(255),
    color       character varying(255),
    created_at  timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at  timestamp(6) without time zone,
    deleted_at  timestamp(6) without time zone,
    CONSTRAINT teams_color_check CHECK (((length((color)::text) = 6) OR (length((color)::text) = 8)))
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users
(
    id         uuid                                                  NOT NULL,
    name       character varying(64)                                 NOT NULL,
    email      character varying(255)                                NOT NULL,
    password   character varying(255)                                NOT NULL,
    color      character varying(8),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(6) without time zone,
    deleted_at timestamp(6) without time zone
);


--
-- Name: users_roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users_roles
(
    role_id bigint NOT NULL,
    user_id uuid   NOT NULL
);


--
-- Name: users_tasks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users_tasks
(
    task_id uuid NOT NULL,
    user_id uuid NOT NULL
);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles
    ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: statuses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.statuses
    ALTER COLUMN id SET DEFAULT nextval('public.statuses_id_seq'::regclass);


--
-- Name: roles role_name_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT role_name_unique UNIQUE (name);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: silos silos_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.silos
    ADD CONSTRAINT silos_pkey PRIMARY KEY (id);


--
-- Name: silos_tasks silos_tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.silos_tasks
    ADD CONSTRAINT silos_tasks_pkey PRIMARY KEY (silo_id, task_id);


--
-- Name: statuses status_name_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.statuses
    ADD CONSTRAINT status_name_unique UNIQUE (name);


--
-- Name: statuses statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.statuses
    ADD CONSTRAINT statuses_pkey PRIMARY KEY (id);


--
-- Name: tasks tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (id);


--
-- Name: teams team_name_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT team_name_unique UNIQUE (name);


--
-- Name: teams teams_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_pkey PRIMARY KEY (id);


--
-- Name: users users_email_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_unique UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users_roles users_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users_roles
    ADD CONSTRAINT users_roles_pkey PRIMARY KEY (role_id, user_id);


--
-- Name: users_tasks users_tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users_tasks
    ADD CONSTRAINT users_tasks_pkey PRIMARY KEY (task_id, user_id);


--
-- Name: role_name_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX role_name_index ON public.roles USING btree (name);


--
-- Name: status_name_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX status_name_index ON public.statuses USING btree (name);


--
-- Name: task_name_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX task_name_index ON public.tasks USING btree (name);


--
-- Name: team_name_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX team_name_index ON public.teams USING btree (name);


--
-- Name: user_email_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX user_email_index ON public.users USING btree (email);


--
-- Name: user_name_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX user_name_index ON public.users USING btree (name);


--
-- Name: silos silos_status_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.silos
    ADD CONSTRAINT silos_status_id_fk FOREIGN KEY (status_id) REFERENCES public.statuses (id);


--
-- Name: silos_tasks silos_tasks_silo_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.silos_tasks
    ADD CONSTRAINT silos_tasks_silo_id_fk FOREIGN KEY (silo_id) REFERENCES public.silos (id);


--
-- Name: silos_tasks silos_tasks_task_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.silos_tasks
    ADD CONSTRAINT silos_tasks_task_id_fk FOREIGN KEY (task_id) REFERENCES public.tasks (id);


--
-- Name: tasks task_status_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT task_status_id_fk FOREIGN KEY (status_id) REFERENCES public.statuses (id);


--
-- Name: users_roles users_roles_role_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users_roles
    ADD CONSTRAINT users_roles_role_id_fk FOREIGN KEY (role_id) REFERENCES public.roles (id);


--
-- Name: users_roles users_roles_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users_roles
    ADD CONSTRAINT users_roles_user_id_fk FOREIGN KEY (user_id) REFERENCES public.users (id);


--
-- Name: users_tasks users_tasks_task_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users_tasks
    ADD CONSTRAINT users_tasks_task_id_fk FOREIGN KEY (task_id) REFERENCES public.tasks (id);


--
-- Name: users_tasks users_tasks_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users_tasks
    ADD CONSTRAINT users_tasks_user_id_fk FOREIGN KEY (user_id) REFERENCES public.users (id);


--
-- PostgreSQL database dump complete
--