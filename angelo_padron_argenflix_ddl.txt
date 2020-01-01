--a

CREATE TABLE usuario (
nombre_usuario VARCHAR (50),
nombre_y_apellido VARCHAR (60),
contrasenha VARCHAR (16));

CREATE TABLE pelicula (
id_pelicula INT,
nombre_pelicula VARCHAR (40),
genero VARCHAR (20),
duracion INT,
calificacion INT,
nombre_actor VARCHAR (50),
nombre_director VARCHAR (50));

CREATE TABLE serie (
nombre_serie VARCHAR (30),
anho_serie INT,
genero VARCHAR (20),
temporadas INT,
duracion INT,
calificacion INT,
nombre_actor VARCHAR (50),
nombre_director VARCHAR (50));

CREATE TABLE actor (
nombre VARCHAR (50),
edad INT,
anhos activos));

CREATE TABLE director (
nombre_director VARCHAR (50),
edad INT,
nacionalidad VARCHAR (20));

CREATE TABLE vio_pelicula (
nombre_usuario VARCHAR (35),
id_pelicula INT));

CREATE TABLE vio_serie (
nombre_usuario VARCHAR (35),
nombre_serie VARCHAR (30),
anho_serie INT));

--b

ALTER TABLE director
ADD COLUMN actor_fetiche VARCHAR (50);

-- constraints tablas punto a

ALTER TABLE ONLY public.actor
    ADD CONSTRAINT actor_pkey PRIMARY KEY (nombre);


--
-- Name: director director_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.director
    ADD CONSTRAINT director_pkey PRIMARY KEY (nombre_director);


--
-- Name: actor nombre_actor_irrepetible; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.actor
    ADD CONSTRAINT nombre_actor_irrepetible UNIQUE (nombre);


--
-- Name: director nombre_director_irrepetible; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.director
    ADD CONSTRAINT nombre_director_irrepetible UNIQUE (nombre_director);


--
-- Name: pelicula pelicula_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pelicula
    ADD CONSTRAINT pelicula_pkey PRIMARY KEY (id_pelicula);


--
-- Name: serie serie_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.serie
    ADD CONSTRAINT serie_pkey PRIMARY KEY (nombre_serie, anho_serie);


--
-- Name: usuario usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (nombre_usuario);


--
-- Name: vio_pelicula vio_pelicula_pks; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vio_pelicula
    ADD CONSTRAINT vio_pelicula_pks PRIMARY KEY (nombre_usuario, id_pelicula);


--
-- Name: vio_serie vio_serie_pks; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vio_serie
    ADD CONSTRAINT vio_serie_pks PRIMARY KEY (nombre_usuario, nombre_serie, anho_serie);


--
-- Name: director actor_fetiche_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.director
    ADD CONSTRAINT actor_fetiche_fk FOREIGN KEY (actor_fetiche) REFERENCES public.actor(nombre);


--
-- Name: serie actor_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.serie
    ADD CONSTRAINT actor_fk FOREIGN KEY (nombre_actor) REFERENCES public.actor(nombre);


--
-- Name: pelicula actor_pk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pelicula
    ADD CONSTRAINT actor_pk FOREIGN KEY (nombre_actor) REFERENCES public.actor(nombre);


--
-- Name: serie director_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.serie
    ADD CONSTRAINT director_fk FOREIGN KEY (nombre_director) REFERENCES public.director(nombre_director);


--
-- Name: pelicula director_pk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pelicula
    ADD CONSTRAINT director_pk FOREIGN KEY (nombre_director) REFERENCES public.director(nombre_director);


--
-- Name: vio_pelicula id_pelicula_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vio_pelicula
    ADD CONSTRAINT id_pelicula_fk FOREIGN KEY (id_pelicula) REFERENCES public.pelicula(id_pelicula);


--
-- Name: vio_serie nombre_usuario_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vio_serie
    ADD CONSTRAINT nombre_usuario_fk FOREIGN KEY (nombre_usuario) REFERENCES public.usuario(nombre_usuario) ON DELETE CASCADE;


--
-- Name: vio_pelicula nombre_usuario_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vio_pelicula
    ADD CONSTRAINT nombre_usuario_fk FOREIGN KEY (nombre_usuario) REFERENCES public.usuario(nombre_usuario) ON DELETE CASCADE;


--
-- Name: vio_serie vio_serie_fks; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vio_serie
    ADD CONSTRAINT vio_serie_fks FOREIGN KEY (nombre_serie, anho_serie) REFERENCES public.serie(nombre_serie, anho_serie) ON DELETE CASCADE;


