--
-- PostgreSQL database dump
--

-- Dumped from database version 10.8 (Ubuntu 10.8-0ubuntu0.18.04.1)
-- Dumped by pg_dump version 10.8 (Ubuntu 10.8-0ubuntu0.18.04.1)

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
-- Name: actor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.actor (
    nombre character varying(50) NOT NULL,
    edad integer,
    anhos_activo integer
);


ALTER TABLE public.actor OWNER TO postgres;

--
-- Name: director; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.director (
    nombre_director character varying(50) NOT NULL,
    edad integer,
    nacionalidad character varying(20),
    actor_fetiche character varying(50)
);


ALTER TABLE public.director OWNER TO postgres;

--
-- Name: pelicula; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pelicula (
    id_pelicula integer NOT NULL,
    nombre_pelicula character varying(40),
    genero character varying(20),
    duracion integer,
    calificacion integer,
    nombre_actor character varying(50),
    nombre_director character varying(50)
);


ALTER TABLE public.pelicula OWNER TO postgres;

--
-- Name: vio_pelicula; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vio_pelicula (
    nombre_usuario character varying(50) NOT NULL,
    id_pelicula integer NOT NULL
);


ALTER TABLE public.vio_pelicula OWNER TO postgres;

--
-- Name: otras_mas_vistas; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.otras_mas_vistas AS
 SELECT director.nacionalidad AS origen_pelicula,
    count(vio_pelicula.id_pelicula) AS veces_vista
   FROM ((public.vio_pelicula
     JOIN public.pelicula USING (id_pelicula))
     JOIN public.director USING (nombre_director))
  WHERE (NOT ((pelicula.nombre_pelicula)::text IN ( SELECT pelicula_1.nombre_pelicula
           FROM (public.pelicula pelicula_1
             JOIN public.director director_1 USING (nombre_director))
          WHERE ((director_1.nacionalidad)::text = 'Estadounidense'::text))))
  GROUP BY director.nacionalidad
  ORDER BY (count(vio_pelicula.id_pelicula)) DESC
 LIMIT 3;


ALTER TABLE public.otras_mas_vistas OWNER TO postgres;

--
-- Name: serie; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.serie (
    nombre_serie character varying(30) NOT NULL,
    anho_serie integer NOT NULL,
    genero character varying(20),
    temporadas integer,
    calificacion integer,
    nombre_actor character varying(50),
    nombre_director character varying(50)
);


ALTER TABLE public.serie OWNER TO postgres;

--
-- Name: usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuario (
    nombre_usuario character varying(35) NOT NULL,
    nombre_y_apellido character varying(60),
    contrasenha character varying(16)
);


ALTER TABLE public.usuario OWNER TO postgres;

--
-- Name: vio_serie; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vio_serie (
    nombre_usuario character varying(35) NOT NULL,
    nombre_serie character varying(50) NOT NULL,
    anho_serie integer NOT NULL
);


ALTER TABLE public.vio_serie OWNER TO postgres;

--
-- Data for Name: actor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.actor (nombre, edad, anhos_activo) FROM stdin;
Antonio Gasalla	74	40
Audrey Tatou	38	19
Ben McKenzie	37	8
Bryan Cranston	59	46
Charlize Theron	39	20
Cobie Smulders	33	14
Dakota Blue Richards	9	3
Danny Elfman	60	25
David Masajnik	36	12
Genaro Vasquez	51	14
Gillian Anderson	46	20
Haley Joel Osment	8	2
Hugh Laurie	56	21
Humberto Velez	60	12
Jack Black	45	20
James Arness	88	50
Jennifer Aniston	46	26
Jim Carrey	53	34
Jim Parsons	42	9
Johnny Depp	52	31
Julia Roberts	47	28
Kent McCord	70	45
Kevin Spacey	55	29
Kyle MacLachlan	56	31
Leonardo DiCaprio	45	16
Emile Hirsch	52	23
Matt Damon	56	27
Natalie Portman	54	25
Guy Pearce	53	24
Russell Crowe	55	26
Jake Gyllenhaal	57	28
Bradley Cooper	49	20
Clint Eastwood	49	20
Ashton Kutcher	62	33
Jessica Alba	49	20
Benicio Del Toro	52	23
Ellen Page	43	14
Brad Pitt	62	33
Rose McGowan	52	23
Sylvester Stallone	75	46
Tom Hardy	42	13
Joseph Gordon-Levitt	55	26
Robert Downey Jr.	52	23
John Travolta	64	35
Kurt Russell	49	20
Edward Norton	57	28
Christian Bale	54	25
Lorne Greene	72	40
Mary McDonnell	58	30
Meg Ryan	53	33
Michael Caine	82	53
Naomi Watts	46	20
Rachel McAdams	36	16
Scarlett Johansson	30	21
Sean Bean	56	24
Steve Buscemi	57	30
Tom Hanks	58	30
Tom Selleck	70	45
Ian Ziering	53	40
Steve Guttenberg	66	40
Facundo Alcodoy	65	10
\.


--
-- Data for Name: director; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.director (nombre_director, edad, nacionalidad, actor_fetiche) FROM stdin;
Alejandro Doria	72	Argentino	\N
Bruno Heller	55	Ingles	\N
Charles Marquis Warren	78	Estadounidense	\N
Chris Weitz	46	Estadounidense	\N
Chuck Lorre	62	Estadounidense	\N
David Crane	57	Estadounidense	\N
David Lynch	69	Estadounidense	\N
Donald Bellisario	50	Estadounidense	\N
Fred Hamilton	57	Estadounidense	\N
Gareth Edwards	50	Ingles	\N
George R R Martin	66	Estadounidense	\N
Glen Larson	80	Estadounidense	\N
Hayao Miyazaki	74	Japones	\N
Jean-Pierre Jeunet	61	Frances	\N
John Lasseter	58	Estadounidense	\N
Joss Whedon	51	Estadounidense	\N
Juan Jose Campanella	55	Argentino	\N
Linwood Boomer	63	Canadiense	\N
M Night Shyamalan	44	Indio	Haley Joel Osment
Matt Groening	61	Estadounidense	\N
Michel Gondry	52	Frances	\N
Peter Farrely	60	Estadounidense	\N
Peter Jackson	53	Neozelandes	\N
Peter Weir	70	Australiano	\N
Sam Mendes	50	Ingles	\N
Shinichiro Watanabe	50	Japones	\N
Tim Burton	56	Estadounidense	Johnny Depp
Vince Gilligan	48	Estadounidense	Bryan Cranston
Woody Allen	79	Estadounidense	Scarlett Johansson
David Fincher	65	Estadounidense	Kevin Spacey
Martin Scorsese	58	Estadounidense	Leonardo DiCaprio
Christopher Nolan	61	Ingles	Michael Caine
Clint Eastwood	57	Estadounidense	\N
Anthony C. Ferrante	65	Estadounidense	Ian Ziering
Mike Mendez	60	Estadounidense	\N
Federico Barroso	40	Argentino	\N
Sean Penn	60	\N	\N
John Dahl	64	\N	\N
James McTeigue	62	\N	\N
Ridley Scott	63	\N	\N
Richard Kelly	65	\N	\N
Gus Van Sant	74	\N	\N
Todd Phillips	57	\N	\N
Eric Bress	70	\N	\N
Robert Rodriguez	57	\N	\N
Guy Ritchie	60	\N	\N
Jason Reitman	51	\N	\N
Ron Howard	63	\N	\N
Martin Brest	70	\N	\N
John G. Avildsen	83	\N	\N
Sylvester Stallone	81	\N	\N
Gavin OConnor	50	\N	\N
Marc Webb	63	\N	\N
Quentin Tarantino	65	\N	\N
\.


--
-- Data for Name: pelicula; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pelicula (id_pelicula, nombre_pelicula, genero, duracion, calificacion, nombre_actor, nombre_director) FROM stdin;
1	El Caballero de la Noche	Superheroes	152	9	Michael Caine	Christopher Nolan
2	Amelie	Romantica	122	8	Audrey Tatou	Jean-Pierre Jeunet
3	Eterno Resplandor	Drama	108	8	Jim Carrey	Michel Gondry
4	The Truman Show	Drama	103	8	Jim Carrey	Peter Weir
5	Memento	Drama	113	8	Guy Pearce	Christopher Nolan
6	La Comunidad del Anillo	Fantasia	178	7	Sean Bean	Peter Jackson
7	Interstellar	Ciencia Ficcion	169	6	Michael Caine	Christopher Nolan
8	Toy Story	Animacion	81	8	Tom Hanks	John Lasseter
9	Sexto Sentido	Suspenso	107	8	Haley Joel Osment	M Night Shyamalan
10	Tonto y Retonto	Comedia	107	5	Jim Carrey	Peter Farrely
11	El Joven Manos de Tijera	Fantasia	105	6	Johnny Depp	Tim Burton
12	La Brujula Dorada	Fantasia	113	5	Dakota Blue Richards	Chris Weitz
13	La Princesa Mononoke	Animacion	134	9	Gillian Anderson	Hayao Miyazaki
14	El extranho mundo de Jack	Animacion	76	6	Danny Elfman	Tim Burton
15	Scoop	Comedia Dramatica	96	7	Scarlett Johansson	Woody Allen
16	Los Vengadores	Superheroes	143	8	Scarlett Johansson	Joss Whedon
17	El Jinete Sin Cabeza	Terror	105	6	Johnny Depp	Tim Burton
18	Pandillas de Nueva York	Drama	167	8	Leonardo DiCaprio	Martin Scorsese
19	Charlie y la Fabrica de Chocolate	Comedia	115	5	Johnny Depp	Tim Burton
20	Godzilla	Mostruos	123	6	Bryan Cranston	Gareth Edwards
21	La Isla Siniestra	Thriller	138	7	Leonardo DiCaprio	Martin Scorsese
23	Belleza Americana	Drama	122	9	Kevin Spacey	Sam Mendes
24	Stuart Little Un Raton en la Familia	Familia	84	6	Hugh Laurie	M Night Shyamalan
25	El camino de los suenhos	Drama	147	9	Naomi Watts	David Lynch
27	Pecados Capitales	Policial	127	9	Kevin Spacey	David Fincher
93	Inception	Action	\N	\N	Leonardo DiCaprio	Christopher Nolan
94	Into the Wild	Drama	\N	\N	Emile Hirsch	Sean Penn
95	Rounders	Drama	\N	\N	Matt Damon	John Dahl
96	V for Vendetta	Thriller	\N	\N	Natalie Portman	James McTeigue
97	Memento	Crime	\N	\N	Guy Pearce	Christopher Nolan
98	Gladiator	Action	\N	\N	Russell Crowe	Ridley Scott
99	Donnie Darko	Sci-Fi	\N	\N	Jake Gyllenhaal	Richard Kelly
100	Good Will Hunting	Drama	\N	\N	Matt Damon	Gus Van Sant
101	The Hangover	Comedy	\N	\N	Bradley Cooper	Todd Phillips
102	Gran Torino	Drama	\N	\N	Clint Eastwood	Clint Eastwood
103	The Butterfly Effect	Sci-Fi	\N	\N	Ashton Kutcher	Eric Bress
104	Sin City	Thriller	\N	\N	Jessica Alba	Robert Rodriguez
105	Snatch	Crime	\N	\N	Benicio Del Toro	Guy Ritchie
106	Robin Hood	Action	\N	\N	Russell Crowe	Ridley Scott
107	Beautiful Mind	Biography	\N	\N	Russell Crowe	Ron Howard
108	Juno	Romance	\N	\N	Ellen Page	Jason Reitman
109	Cinderella Man	Sport	\N	\N	Russell Crowe	Ron Howard
110	Meet Joe Black	Drama	\N	\N	Brad Pitt	Martin Brest
111	Planet Terror	Sci-Fi	\N	\N	Rose McGowan	Robert Rodriguez
112	Rocky	Sport	\N	\N	Sylvester Stallone	John G. Avildsen
113	Rocky II	Sport	\N	\N	Sylvester Stallone	Sylvester Stallone
114	Rocky III	Sport	\N	\N	Sylvester Stallone	Sylvester Stallone
115	Warrior	Sport	\N	\N	Tom Hardy	Gavin OConnor
116	500 Days of Summer	Romance	\N	\N	Joseph Gordon-Levitt	Marc Webb
117	Sherlock Holmes	Mistery	\N	\N	Robert Downey Jr.	Guy Ritchie
118	Pulp Fiction	Crime	\N	\N	John Travolta	Quentin Tarantino
28	Zodiaco	Policial	157	6	Jake Gyllenhaal	David Fincher
29	Medianoche en Paris	Comedia	100	7	Rachel McAdams	Woody Allen
30	Match Point	Comedia	124	8	Scarlett Johansson	Woody Allen
119	Inglourious Basterds	War	\N	\N	Brad Pitt	Quentin Tarantino
120	Deathproof	Action	\N	\N	Kurt Russell	Quentin Tarantino
121	Fight Club	Thriller	\N	\N	Edward Norton	David Fincher
122	Batman Begins	Action	\N	\N	Christian Bale	Christopher Nolan
123	Shutter Island	Drama	\N	\N	Leonardo DiCaprio	Martin Scorsese
60	Lavalantula	Terror	92	10	Steve Guttenberg	Mike Mendez
59	Sharknado	Terror	90	10	Ian Ziering	Anthony C. Ferrante
61	Básicamente un pozo	Fantastico	60	10	Facundo Alcodoy	Federico Barroso
22	Metegol	Animacion	106	10	David Masajnik	Juan Jose Campanella
26	Esperando la Carroza	Comedia	87	10	Antonio Gasalla	Alejandro Doria
\.


--
-- Data for Name: serie; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.serie (nombre_serie, anho_serie, genero, temporadas, calificacion, nombre_actor, nombre_director) FROM stdin;
BattleStar Galactica	1980	Ciencia Ficcion	1	6	Kent McCord	Glen Larson
BattleStar Galactica	2005	Ciencia Ficcion	4	7	Mary McDonnell	Glen Larson
Boardwalk Empire	2010	Mafia	5	7	Steve Buscemi	Martin Scorsese
Bonanza	1959	Western	14	7	Lorne Greene	Fred Hamilton
Breaking Bad	2008	Drama	5	10	Bryan Cranston	Vince Gilligan
Cowboy Bebop	1998	Animacion	1	8	Genaro Vasquez	Shinichiro Watanabe
Doctor House	2004	Drama	8	8	Hugh Laurie	Juan Jose Campanella
Friends	1994	Comedia	10	9	Jennifer Aniston	David Crane
Game of Thrones	2011	Fantasia	5	9	Sean Bean	George R R Martin
Gotham	2014	Policial	2	8	Ben McKenzie	Bruno Heller
Gunsmoke	1955	Western	20	7	James Arness	Charles Marquis Warren
House of Cards	2013	Drama	3	9	Kevin Spacey	David Fincher
Los Simpsons	1989	Animacion	26	6	Humberto Velez	Matt Groening
Magnum PI	1980	Accion	8	7	Tom Selleck	Donald Bellisario
Malcolm en el medio	2000	Comedia	7	8	Bryan Cranston	Linwood Boomer
The Big Bang Theory	2007	Comedia	6	7	Jim Parsons	Chuck Lorre
Twin Peaks	1990	Misterio	2	7	Kyle MacLachlan	David Lynch
\.


--
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuario (nombre_usuario, nombre_y_apellido, contrasenha) FROM stdin;
aaguero	Alejandra Aguero	14563otoba
aaguilera	Adelmo Aguilera	55346salol
aavila	Aurelia Avila	52435v57
abenitez	Angelina Benitez	41511h66
abuitron	Adelaida Buitron	abuitron
acardenas	Alonso Cardenas	35256g42
acarrasco	Adelina Carrasco	44121crimen
ajimenez	Amparo Jimenez	51313mimar
amaldonado	Angeles Maldonado	23263vega
amateus	Almudena Mateus	12345c79
amejia	Alcira Mejia	43465olfato
amontenegro	Amos Montenegro	56545lucio
amora	Agueda Mora	21165arduo
anahuelquin	Anibal Nahuelquin	31312frase
apino	Angelina Pino	gridaso
aquintanilla	Anacleto Quintanilla	42564c13
asaavedra	Anastasio Saavedra	43251solio
atocornal	Alcira Tocornal	51644f49
atoledo	Aron Toledo	atoledo
atoro	Apolo Toro	62561hiena
bmendez	Basilio Mendez	22421n82
bmillachine	Barbara Millachine	31263tegua
bmontt	Bibiana Montt	23636sufra
bmorales	Beltran Morales	36122g52
BreakingThrones	Silvano Rivas	12631m74
caguilera	Carla Aguilera	13411clonar
cartiagoitia	Celia Artiagoitia	34134bache
ccaucaman	Claudio Caucaman	32134viese
cnahuelpani	Clotilde Nahuelpani	44234noxa
DaleBoca	Leonardo Montes De Oca	21265k67
dcruz	Dolores Cruz	45134alzar
dmartin	Dagoberto Martin	36513m62
eaguilera	Elena Aguilera	32253chalet
ejuarez	Eugenia Juarez	52232mayal
elevican	Erico Levican	medroahogar
ElMisterIo	Pio Antipani	51613deudo
ElPistero94	Aurelio Guala	65465p27
emillachine	Eufemia Millachine	64266lilac
emolina	Eugenia Molina	emolina
epincol	Edmundo Pincol	52145coraje
eriveros	Eloy Riveros	33222nariz
esaez	Eufrasio Saez	66114ley
evalverde	Eudosia Valverde	32216breva
evelazquez	Emilia Velazquez	15254p80
farias	Frida Arias	26615cloro
fsalas	Florinda Salas	14155erro
gcalderon	Griselda Calderon	55422usar
gchaura	Genoveva Chaura	63653nona
ggallardo	Guillermo Gallardo	12345finca
gmartin	Gilberto San Martin	61634e52
gpanguilef	Griselda Panguilef	62531pavo
grodriguez	Grisel Rodriguez	41611rama
gvillalba	Gilberto Villalba	53466elfo
hcabrera	Hermelando Cabrera	51233ficha
ichavez	Ivonne Chavez	21546e10
jalvarado	Julio Alvarado	54321abajo
javendanho	Jazmin Avendanho	35123676
jmartin	Jaime Martin	55415860
jnavarro	Jennifer Navarro	35444litar
jreyes	Jonatan Reyes	jreyes
jtoledo	Josefa Toledo	41344sudor
lcarcamo	Leonora Carcamo	31153hoyo
lfernandez	Lorenzo Fernandez	34616oda
lgomez	Leon Gomez	lgomez
lluna	Lydia Luna	44364rozno
lrojas	Lamberto Rojas	52234brete
ltrivinho	Lucas Trivinho	43614cien
mhuenteo	Miriam Huenteo	31554Pablo
MissDanger	Yolanda Tapia	12256f17
mleguizamon	Mariana Leguizamon	14663IBEX
mnavarro	Mateo Navarro	32656h99
nacosta	Nuria Acosta	45244padre
naguilera	Nelida Aguilera	26434s90x90
naguirre	Natan Aguirre	21355Girona
obustamante	Oton Bustamante	11136asear
odavila	Olimpia Davila	43261k35
operez	Orlando Perez	as1234599
ovarela	Ofelia Varela	25264diodo
pcarvajal	Pedro Carvajal	25565causa
pmariman	Paulina Mariman	45413ilota
projas	Panfilo Rojas	26411dorado
pvillalba	Paolo Villalba	32555jibia
rbahamonde	Rufino Bahamonde	25263cafre
rbetancur	Romeo Betancur	52344cortar
rerrazuriz	Rosendo Errazuriz	12345
rmartin	Rosario San Martin	52113OPA
RossGeller85	Albano Jimenez	31311nadie
rraicahuin	Rosa Raicahuin	61263octavo
ShinjiIK	Marcos Bastidas	45125torna
sleguizamon	Sergio Leguizamon	52625sutil
svaldes	Sigfrido Valdes	26524anaco
TheDoctor	Flavio Nunhez	TheDoctor
tlevican	Teresa Levican	44452cebro
tpaillalef	Trinidad Paillalef	53124flecha
tvazquez	Tomas Vazquez	53563acebo
tvera	Teodosio Vera	63332acto
VamosRiver	Piedad Montes De Oca	31524opaco
yvazquez	Yeray Vazquez	62331plaza
zvinueza	Zulema Vinueza	54525cubil
\.


--
-- Data for Name: vio_pelicula; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vio_pelicula (nombre_usuario, id_pelicula) FROM stdin;
aaguero	20
aaguilera	1
aavila	9
aavila	12
abenitez	5
abuitron	2
abuitron	13
abuitron	19
acarrasco	15
acarrasco	22
amaldonado	5
amaldonado	6
amaldonado	9
amaldonado	16
amaldonado	23
amateus	7
amejia	2
amejia	4
amontenegro	4
amontenegro	6
amontenegro	9
amora	1
amora	15
amora	16
anahuelquin	16
apino	9
apino	21
apino	27
aquintanilla	18
aquintanilla	21
asaavedra	11
asaavedra	14
asaavedra	15
atocornal	6
atocornal	8
atocornal	29
atoledo	19
atoledo	20
atoro	4
bmendez	9
bmendez	14
bmendez	26
bmillachine	21
bmontt	2
bmontt	19
bmontt	24
bmorales	10
bmorales	12
bmorales	14
caguilera	6
caguilera	13
caguilera	17
caguilera	28
cartiagoitia	23
cartiagoitia	25
cnahuelpani	2
DaleBoca	2
dcruz	2
dcruz	12
elevican	29
ElMisterIo	13
ElPistero94	18
ElPistero94	22
emillachine	7
emillachine	16
emillachine	21
emillachine	26
emolina	25
epincol	16
epincol	25
eriveros	3
esaez	17
evalverde	4
evalverde	21
evalverde	24
evelazquez	2
evelazquez	11
evelazquez	24
farias	5
farias	6
farias	10
farias	22
farias	24
fsalas	7
fsalas	9
ggallardo	9
ggallardo	13
ggallardo	17
ggallardo	24
gmartin	22
gmartin	24
gmartin	26
grodriguez	12
grodriguez	29
gvillalba	27
hcabrera	14
hcabrera	18
hcabrera	22
hcabrera	28
hcabrera	30
ichavez	1
ichavez	14
jalvarado	4
jalvarado	10
jmartin	6
jmartin	23
jmartin	30
jnavarro	1
jnavarro	5
jreyes	2
jreyes	7
jreyes	22
jreyes	24
jtoledo	26
lcarcamo	6
lcarcamo	13
lcarcamo	22
lcarcamo	23
lfernandez	5
lfernandez	13
lfernandez	15
lgomez	25
lluna	14
lluna	27
lrojas	3
lrojas	8
ltrivinho	12
ltrivinho	14
ltrivinho	24
MissDanger	6
MissDanger	20
MissDanger	25
mnavarro	22
nacosta	26
nacosta	29
naguilera	4
naguilera	5
naguilera	15
naguilera	26
naguilera	28
naguirre	3
naguirre	10
obustamante	3
obustamante	7
obustamante	23
odavila	23
operez	5
operez	14
operez	19
operez	29
ovarela	8
ovarela	12
ovarela	24
ovarela	27
pcarvajal	2
pcarvajal	10
pcarvajal	30
pmariman	30
projas	1
pvillalba	21
rbahamonde	2
rbahamonde	20
rbetancur	9
rbetancur	15
rbetancur	18
rbetancur	21
rbetancur	25
rmartin	5
RossGeller85	14
rraicahuin	9
ShinjiIK	13
svaldes	1
svaldes	5
svaldes	14
svaldes	23
TheDoctor	21
TheDoctor	22
TheDoctor	26
tlevican	20
tpaillalef	16
tvazquez	4
tvazquez	21
tvazquez	25
tvera	1
yvazquez	27
zvinueza	6
zvinueza	20
zvinueza	23
zvinueza	26
\.


--
-- Data for Name: vio_serie; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vio_serie (nombre_usuario, nombre_serie, anho_serie) FROM stdin;
aavila	Breaking Bad	2008
acardenas	Los Simpsons	1989
ajimenez	Los Simpsons	1989
ajimenez	The Big Bang Theory	2007
amateus	BattleStar Galactica	1980
anahuelquin	Game of Thrones	2011
apino	Gunsmoke	1955
asaavedra	BattleStar Galactica	1980
atocornal	House of Cards	2013
bmontt	Cowboy Bebop	1998
BreakingThrones	Game of Thrones	2011
ccaucaman	Cowboy Bebop	1998
dcruz	Gunsmoke	1955
dmartin	BattleStar Galactica	1980
dmartin	Magnum PI	1980
eaguilera	Friends	1994
ejuarez	Los Simpsons	1989
eriveros	Twin Peaks	1990
gcalderon	Doctor House	2004
gchaura	Los Simpsons	1989
gmartin	Gotham	2014
gpanguilef	Breaking Bad	2008
gvillalba	The Big Bang Theory	2007
javendanho	Twin Peaks	1990
lgomez	House of Cards	2013
lrojas	BattleStar Galactica	2005
lrojas	Friends	1994
mhuenteo	Gunsmoke	1955
mleguizamon	Malcolm en el medio	2000
odavila	Magnum PI	1980
pvillalba	Bonanza	1959
rerrazuriz	Game of Thrones	2011
RossGeller85	Friends	1994
rraicahuin	Gotham	2014
ShinjiIK	Cowboy Bebop	1998
sleguizamon	Twin Peaks	1990
TheDoctor	Breaking Bad	2008
VamosRiver	Bonanza	1959
VamosRiver	Gotham	2014
yvazquez	Boardwalk Empire	2010
\.


--
-- Name: actor actor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

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


--
-- PostgreSQL database dump complete
--

