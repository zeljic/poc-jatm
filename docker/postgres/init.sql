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
-- Name: SCHEMA "public"; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA "public" IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = "heap";

--
-- Name: roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."roles"
(
    "id"          bigint                 NOT NULL,
    "description" character varying(255),
    "name"        character varying(255) NOT NULL
);


--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."roles_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."roles_id_seq" OWNED BY "public"."roles"."id";


--
-- Name: silo_tasks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."silo_tasks"
(
    "silo_id" bigint NOT NULL,
    "task_id" bigint NOT NULL
);


--
-- Name: silos; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."silos"
(
    "lock"        boolean                        NOT NULL,
    "created_at"  timestamp(6) without time zone NOT NULL,
    "deleted_at"  timestamp(6) without time zone,
    "from_dt"     timestamp(6) without time zone NOT NULL,
    "id"          bigint                         NOT NULL,
    "status_id"   bigint                         NOT NULL,
    "to_dt"       timestamp(6) without time zone NOT NULL,
    "updated_at"  timestamp(6) without time zone,
    "color"       character varying(255),
    "description" "text",
    "name"        character varying(255)         NOT NULL,
    CONSTRAINT "silos_color_check" CHECK ((("length"(("color")::"text") = 6) OR ("length"(("color")::"text") = 8)))
);


--
-- Name: silos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."silos_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: silos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."silos_id_seq" OWNED BY "public"."silos"."id";


--
-- Name: statuses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."statuses"
(
    "color"       character varying(8),
    "id"          bigint                 NOT NULL,
    "description" character varying(255),
    "name"        character varying(255) NOT NULL
);


--
-- Name: statuses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."statuses_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: statuses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."statuses_id_seq" OWNED BY "public"."statuses"."id";


--
-- Name: tasks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."tasks"
(
    "created_at"  timestamp(6) without time zone NOT NULL,
    "deleted_at"  timestamp(6) without time zone,
    "id"          bigint                         NOT NULL,
    "status_id"   bigint                         NOT NULL,
    "updated_at"  timestamp(6) without time zone,
    "color"       character varying(255),
    "description" "text",
    "name"        character varying(255)         NOT NULL,
    CONSTRAINT "tasks_color_check" CHECK ((("length"(("color")::"text") = 6) OR ("length"(("color")::"text") = 8)))
);


--
-- Name: tasks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."tasks_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."tasks_id_seq" OWNED BY "public"."tasks"."id";


--
-- Name: tasks_users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."tasks_users"
(
    "task_id" bigint NOT NULL,
    "user_id" bigint NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."users"
(
    "color"      character varying(8),
    "created_at" timestamp(6) without time zone NOT NULL,
    "deleted_at" timestamp(6) without time zone,
    "id"         bigint                         NOT NULL,
    "updated_at" timestamp(6) without time zone,
    "name"       character varying(16)          NOT NULL,
    "email"      character varying(255)         NOT NULL,
    "password"   character varying(255)         NOT NULL,
    CONSTRAINT "users_color_check" CHECK ((("length"(("color")::"text") = 6) OR ("length"(("color")::"text") = 8)))
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."users_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."users_id_seq" OWNED BY "public"."users"."id";


--
-- Name: users_roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."users_roles"
(
    "role_id" bigint NOT NULL,
    "user_id" bigint NOT NULL
);


--
-- Name: users_tasks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."users_tasks"
(
    "task_id" bigint NOT NULL,
    "user_id" bigint NOT NULL
);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."roles"
    ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."roles_id_seq"'::"regclass");


--
-- Name: silos id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."silos"
    ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."silos_id_seq"'::"regclass");


--
-- Name: statuses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."statuses"
    ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."statuses_id_seq"'::"regclass");


--
-- Name: tasks id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."tasks"
    ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."tasks_id_seq"'::"regclass");


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."users"
    ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."users_id_seq"'::"regclass");


--
-- Name: roles role_name_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."roles"
    ADD CONSTRAINT "role_name_unique" UNIQUE ("name");


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."roles"
    ADD CONSTRAINT "roles_pkey" PRIMARY KEY ("id");


--
-- Name: silo_tasks silo_tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."silo_tasks"
    ADD CONSTRAINT "silo_tasks_pkey" PRIMARY KEY ("silo_id", "task_id");


--
-- Name: silos silos_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."silos"
    ADD CONSTRAINT "silos_pkey" PRIMARY KEY ("id");


--
-- Name: statuses status_name_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."statuses"
    ADD CONSTRAINT "status_name_unique" UNIQUE ("name");


--
-- Name: statuses statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."statuses"
    ADD CONSTRAINT "statuses_pkey" PRIMARY KEY ("id");


--
-- Name: tasks task_name_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."tasks"
    ADD CONSTRAINT "task_name_unique" UNIQUE ("name");


--
-- Name: tasks tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."tasks"
    ADD CONSTRAINT "tasks_pkey" PRIMARY KEY ("id");


--
-- Name: tasks_users tasks_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."tasks_users"
    ADD CONSTRAINT "tasks_users_pkey" PRIMARY KEY ("task_id", "user_id");


--
-- Name: users users_email_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."users"
    ADD CONSTRAINT "users_email_unique" UNIQUE ("email");


--
-- Name: users users_name_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."users"
    ADD CONSTRAINT "users_name_unique" UNIQUE ("name");


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."users"
    ADD CONSTRAINT "users_pkey" PRIMARY KEY ("id");


--
-- Name: users_roles users_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."users_roles"
    ADD CONSTRAINT "users_roles_pkey" PRIMARY KEY ("role_id", "user_id");


--
-- Name: users_tasks users_tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."users_tasks"
    ADD CONSTRAINT "users_tasks_pkey" PRIMARY KEY ("task_id", "user_id");


--
-- Name: role_name_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "role_name_index" ON "public"."roles" USING "btree" ("name");


--
-- Name: status_name_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "status_name_index" ON "public"."statuses" USING "btree" ("name");


--
-- Name: task_name_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "task_name_index" ON "public"."tasks" USING "btree" ("name");


--
-- Name: user_email_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "user_email_index" ON "public"."users" USING "btree" ("email");


--
-- Name: user_name_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "user_name_index" ON "public"."users" USING "btree" ("name");


--
-- Name: silo_tasks silo_task_silo_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."silo_tasks"
    ADD CONSTRAINT "silo_task_silo_id_fk" FOREIGN KEY ("silo_id") REFERENCES "public"."silos" ("id");


--
-- Name: silo_tasks silo_task_task_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."silo_tasks"
    ADD CONSTRAINT "silo_task_task_id_fk" FOREIGN KEY ("task_id") REFERENCES "public"."tasks" ("id");


--
-- Name: silos silos_status_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."silos"
    ADD CONSTRAINT "silos_status_id_fk" FOREIGN KEY ("status_id") REFERENCES "public"."statuses" ("id");


--
-- Name: tasks task_status_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."tasks"
    ADD CONSTRAINT "task_status_id_fk" FOREIGN KEY ("status_id") REFERENCES "public"."statuses" ("id");


--
-- Name: users_roles user_role_role_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."users_roles"
    ADD CONSTRAINT "user_role_role_id_fk" FOREIGN KEY ("role_id") REFERENCES "public"."roles" ("id");


--
-- Name: users_roles user_role_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."users_roles"
    ADD CONSTRAINT "user_role_user_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users" ("id");


--
-- Name: users_tasks user_task_task_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."users_tasks"
    ADD CONSTRAINT "user_task_task_id_fk" FOREIGN KEY ("task_id") REFERENCES "public"."tasks" ("id");


--
-- Name: users_tasks user_task_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."users_tasks"
    ADD CONSTRAINT "user_task_user_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users" ("id");


--
-- PostgreSQL database dump complete
--

