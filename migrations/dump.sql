--
-- PostgreSQL database dump
--

\restrict nQxgLbJSwZnuTEwq5syS0sh6Sz8j1nat6eVgQ5dhVAKNsqjxyh9Eo4FROdcxrHM

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.6

-- Started on 2025-08-28 17:14:00 UTC

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 3484 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 220 (class 1259 OID 16401)
-- Name: activity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.activity (
    id integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    user_id bigint NOT NULL,
    activity_date date NOT NULL,
    actions integer DEFAULT 1 NOT NULL
);


ALTER TABLE public.activity OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16400)
-- Name: activity_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.activity_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.activity_id_seq OWNER TO postgres;

--
-- TOC entry 3485 (class 0 OID 0)
-- Dependencies: 219
-- Name: activity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.activity_id_seq OWNED BY public.activity.id;


--
-- TOC entry 222 (class 1259 OID 16411)
-- Name: books; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.books (
    id integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    name character varying(100) NOT NULL,
    author character varying(100) NOT NULL,
    user_id bigint,
    access character varying(10) NOT NULL,
    wisdom boolean NOT NULL,
    path text NOT NULL,
    page_size integer NOT NULL,
    count_pages integer NOT NULL
);


ALTER TABLE public.books OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16410)
-- Name: books_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.books_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.books_id_seq OWNER TO postgres;

--
-- TOC entry 3486 (class 0 OID 0)
-- Dependencies: 221
-- Name: books_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.books_id_seq OWNED BY public.books.id;


--
-- TOC entry 226 (class 1259 OID 16472)
-- Name: marks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.marks (
    id bigint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    user_id bigint NOT NULL,
    book_id integer NOT NULL,
    number_page integer NOT NULL
);


ALTER TABLE public.marks OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16471)
-- Name: marks_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.marks ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.marks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 224 (class 1259 OID 16421)
-- Name: pages_books; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pages_books (
    id integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    book_id integer NOT NULL,
    photo text,
    text text,
    number integer NOT NULL
);


ALTER TABLE public.pages_books OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16420)
-- Name: pages_books_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pages_books_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pages_books_id_seq OWNER TO postgres;

--
-- TOC entry 3487 (class 0 OID 0)
-- Dependencies: 223
-- Name: pages_books_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pages_books_id_seq OWNED BY public.pages_books.id;


--
-- TOC entry 218 (class 1259 OID 16389)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    user_id bigint NOT NULL,
    username character varying(50),
    language character varying(10) NOT NULL,
    role character varying(30) NOT NULL,
    is_alive boolean DEFAULT false NOT NULL,
    banned boolean DEFAULT false NOT NULL,
    selected_book integer,
    page_selected_book integer,
    selected_wisdom integer,
    page_selected_wisdom integer,
    time_send_wisdom time without time zone NOT NULL,
    enable_wisdom boolean DEFAULT false NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16388)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 3488 (class 0 OID 0)
-- Dependencies: 217
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 3296 (class 2604 OID 16404)
-- Name: activity id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activity ALTER COLUMN id SET DEFAULT nextval('public.activity_id_seq'::regclass);


--
-- TOC entry 3299 (class 2604 OID 16414)
-- Name: books id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books ALTER COLUMN id SET DEFAULT nextval('public.books_id_seq'::regclass);


--
-- TOC entry 3301 (class 2604 OID 16424)
-- Name: pages_books id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pages_books ALTER COLUMN id SET DEFAULT nextval('public.pages_books_id_seq'::regclass);


--
-- TOC entry 3291 (class 2604 OID 16392)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 3472 (class 0 OID 16401)
-- Dependencies: 220
-- Data for Name: activity; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.activity (id, created_at, user_id, activity_date, actions) VALUES (19, '2025-08-25 11:31:06.933821+03', 5280741755, '2025-08-25', 7);
INSERT INTO public.activity (id, created_at, user_id, activity_date, actions) VALUES (120, '2025-08-28 15:58:26.501286+03', 574227924, '2025-08-28', 82);
INSERT INTO public.activity (id, created_at, user_id, activity_date, actions) VALUES (8, '2025-08-25 10:50:01.748561+03', 574227924, '2025-08-25', 105);


--
-- TOC entry 3474 (class 0 OID 16411)
-- Dependencies: 222
-- Data for Name: books; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.books (id, created_at, name, author, user_id, access, wisdom, path, page_size, count_pages) VALUES (5, '2025-08-24 17:25:56.562561+03', 'Рождество на пятьдесят долларов', 'Бриджет Колерн', 574227924, 'public', false, './db/books/Рождество на 50 долларов.txt', 700, 8);
INSERT INTO public.books (id, created_at, name, author, user_id, access, wisdom, path, page_size, count_pages) VALUES (6, '2025-08-24 17:25:56.562561+03', 'Марсианские хроники', 'Рэй Брэдбери', 574227924, 'public', false, './db/books/Bredberi_Marsianskie-hroniki.txt', 700, 574);
INSERT INTO public.books (id, created_at, name, author, user_id, access, wisdom, path, page_size, count_pages) VALUES (7, '2025-08-24 17:25:56.562561+03', 'Попутчица', 'Ольга Савельева', 574227924, 'public', false, './db/books/Попунтчица.txt', 700, 8);
INSERT INTO public.books (id, created_at, name, author, user_id, access, wisdom, path, page_size, count_pages) VALUES (9, '2025-08-24 17:47:02.727217+03', 'МАКТУБ', 'Пауло Коэльо', 2015275939, 'public', true, './db/wisdoms/Paulo Coelho Maktub/book.json', 0, 242);
INSERT INTO public.books (id, created_at, name, author, user_id, access, wisdom, path, page_size, count_pages) VALUES (12, '2025-08-28 18:35:17.236101+03', 'Социал-Тутовизм! Сводки о Главном.', 'Тесак Максим Марцинкевич', 2015275939, 'public', false, './db/books/От Тесака.txt', 700, 18);


--
-- TOC entry 3478 (class 0 OID 16472)
-- Dependencies: 226
-- Data for Name: marks; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.marks (id, created_at, user_id, book_id, number_page) OVERRIDING SYSTEM VALUE VALUES (1, '2025-08-25 20:08:55.513489+03', 574227924, 6, 5);
INSERT INTO public.marks (id, created_at, user_id, book_id, number_page) OVERRIDING SYSTEM VALUE VALUES (3, '2025-08-25 21:03:04.367105+03', 574227924, 6, 17);
INSERT INTO public.marks (id, created_at, user_id, book_id, number_page) OVERRIDING SYSTEM VALUE VALUES (4, '2025-08-25 21:03:08.522788+03', 574227924, 6, 19);


--
-- TOC entry 3476 (class 0 OID 16421)
-- Dependencies: 224
-- Data for Name: pages_books; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (27, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture039.jpg', '', 27);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (33, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture045.jpg', '', 33);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (59, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture071.jpg', '', 59);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (107, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture119.jpg', '⠀⠀<strong>Ч</strong>жао Цзи заметил как-то:
⠀⠀– Поистине мудр тот, кто способен изменить положение вещей, когда видит, что вынужден сделать это.', 107);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (65, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture077.jpg', '', 65);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (75, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture087.jpg', '', 75);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (81, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture093.jpg', '', 81);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (85, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture097.jpg', '', 85);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (91, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture103.jpg', '', 91);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (97, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture109.jpg', '', 97);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (109, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture121.jpg', '', 109);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (113, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture125.jpg', '', 113);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (125, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture137.jpg', '', 125);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (145, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture157.jpg', '', 145);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (151, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture163.jpg', '', 151);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (157, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture169.jpg', '', 157);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (175, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture187.jpg', '', 175);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (178, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture190.jpg', '⠀⠀<strong>Н</strong>емецкий философ Фридрих Ницше сказал как-то раз:
⠀⠀– Не стоит всю жизнь отстаивать свою неизменную правоту; условием человеческого существования является возможность время от времени ошибаться.', 178);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (181, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture193.jpg', '', 181);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (187, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture199.jpg', '', 187);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1414, '2025-08-24 23:06:22.571376+03', 6, NULL, 'чтобы еще и Марс отравить. Теперь-то, конечно…
   Они дошли до канала. Он был длинный, прямой, холодный, в его влажном зеркале отражалась ночь.
   - Мне всегда так хотелось увидеть марсианина, - сказал Майкл. - Где же они, папа? Ты ведь обещал.
   - Вот они, смотри, - ответил отец Он посадил Майкла на плечо и указал прямо вниз.
   Марсиане!.. Тимоти охватила дрожь.
   Марсиане. В канале. Отраженные его гладью Тимоти, Майкл, Роберт, и мама, и папа.
   Долго, долго из журчащей воды на них безмолвно смотрели марсиане…

', 574);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (205, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture217.jpg', '', 205);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (211, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture223.jpg', '', 211);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (223, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture235.jpg', '', 223);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (11, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture023.jpg', '⠀⠀<strong>М</strong>актуб – по-арабски значит «нечто написанное».
⠀⠀Но это не самый удачный перевод, уже потому, что хотя все в самом деле давно написано, Бог исполнен милосердия – и тратит свои чернила лишь на то, чтобы помогать нам.', 11);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (229, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture241.jpg', '', 229);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (235, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture247.jpg', '', 235);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (833, '2025-08-24 23:06:22.571376+03', 5, NULL, 'Рождество на пятьдесят долларов

В сентябре я уволилась с работы, уверенная, что меня ждет более интересная должность. Но этот вариант сорвался. До Рождества оставалась всего неделя, а я не могла никуда устроиться. Временно работая то тут, то там, я платила за аренду жилья и покупала продукты, но на большее денег не хватало.

Моя дочь Лесли училась в восьмом классе, поэтому я очень удивилась, когда однажды за завтраком она выдала:

— Мам, я знаю, что у тебя нет работы и с деньгами туго. Можешь не покупать мне подарок на Рождество. Вот устроишься на работу до моего дня рождения, тогда и придумаем что-нибудь особенное.

— Спасибо, милая, отличная идея, — сказала я и обняла ее.', 1);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (834, '2025-08-24 23:06:22.571376+03', 5, NULL, 'Затем я быстро убрала со стола и отвернулась к раковине, чтобы она не увидела моих слез. В конце концов я смогла взять себя в руки и отвезти ее в школу, но стоило ей хлопнуть дверцей машины, как я зашлась в рыданиях.

— Такой хороший ребенок заслуживает прекрасного Рождества! — кричала я. — Боже, будь у меня хоть пятьдесят лишних долларов, я бы купила ей подарки...

В тот вечер мы с Лесли поехали в церковь. Она пошла на встречу своей молодежной группы, а я направилась в часовню, где проходила служба для взрослых. На полпути в фойе я решила, что у меня нет настроения для наставлений вроде «оглянитесь на радость вокруг». Развернувшись,', 2);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (835, '2025-08-24 23:06:22.571376+03', 5, NULL, 'я пошла обратно и столкнулась в дверях со своей подругой Джоди. Она схватила меня за руку:

— Ты куда?

— Домой, — коротко ответила я.

— Почему? — удивилась она.

— Потому что не хочу слушать, как прекрасно Рождество, — объяснила я.

— Понимаю, — кивнула она. — Мне тоже неохота слушать об этом. Но, может, именно поэтому нам обеим и стоит туда пойти? Давай ты останешься и сядешь рядом? Спрячемся на балконе и будем ненавидеть Рождество вместе, пока никто не видит.

Я согласилась. Мы были как две школьницы, задумавшие шалость в воскресной школе. Я взяла Джоди под руку, и мы пошли наверх.

Пока я слушала библейские стихи о рождении нашего Спасителя, мой гнев постепенно утихал. Я думала о том,', 3);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (836, '2025-08-24 23:06:22.571376+03', 5, NULL, 'как много лет назад ангелы возвестили благую весть, и от этого мне становилось спокойно. В конце концов, Рождество всегда полно радости и надежды на будущее, есть под елкой подарки или нет. Я была благодарна Джоди за то, что она уговорила меня остаться.

Когда я потянулась за курткой, Джоди снова взяла меня за руку.

— Возьми, пожалуйста, — сказала она, протянув мне сложенный листок бумаги. — Но не плати по счетам. Потрать их на подарки для дочери.

Это был чек на пятьдесят долларов. Символичность этой суммы поразила меня. Я снова почувствовала, что глаза заволакивает слезами. Я не рассказывала Джоди о своей отчаянной утренней молитве. Бог ответил на нее.', 4);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (837, '2025-08-24 23:06:22.571376+03', 5, NULL, 'Ему было дело до всех глупых желаний моего сердца.

— Но я не знаю, когда смогу вернуть долг, — пробормотала я.

— И не надо его возвращать, — ответила Джоди. — Когда встанешь на ноги, сделай то же самое для кого-нибудь другого, вот и все.

— Сделаю! — воскликнула я и поспешно добавила: — Спасибо тебе огромное.

Мы молча спустились вниз. Я обняла ее, когда мы вышли на улицу, еще раз сказала спасибо, и мы простились. Чудесная служба и своевременная щедрость Джоди сняли с моего сердца тяжкую ношу. Я снова была в радостном предвкушении праздника.

В Сочельник у меня на пороге появилась картонная коробка. Внутри была огромная индейка и множество гарниров для сытного ужина,', 5);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (838, '2025-08-24 23:06:22.571376+03', 5, NULL, 'и еще кое-какая еда на завтрак и обед. Там были даже десерты. Лесли восхищенно ахала, пока мы доставали из коробки все новые и новые лакомства. Когда она опустела, весь наш обеденный стол был заставлен едой.

— Куда же нам все это ставить? — спросила Лесли.

— Мы это не съедим, — согласилась я.

— Индейка даже в холодильник не влезет! — воскликнула Лесли.

Мы посмотрели друг на друга и поняли, что делать. Практически одновременно мы сказали:

— Давай все отдадим!

Мы знали одну большую семью, которая тоже страдала от безработицы и безденежья. Мы снова упаковали коробку, добавили кое-что из своих запасов и положили сверху целый мешок конфет, который нам прислали накануне.

— У меня идея!', 6);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (839, '2025-08-24 23:06:22.571376+03', 5, NULL, '— Лесли побежала в свою комнату и вернулась с парой мягких игрушек, несколькими статуэтками и настольной игрой.

— Для детей, — объяснила она, положив их поверх продуктов.

Мы обмотали коробку пищевой пленкой и прикрепили разноцветные бантики. Потом мы осторожно перенесли ее в машину и отвезли к другому дому.

— Может, отъедешь немного и подождешь меня? — спросила Лесли.

Через несколько минут она, запыхавшись, прыгнула в машину.

— Здорово получилось! Я позвонила в дверь и убежала.

Всю дорогу домой мы хохотали над своим «забегом с коробкой». Когда смех утих, мы приготовили какао и обсудили, как здорово было отдать еду. В конце концов Лесли пошла спать.', 7);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (840, '2025-08-24 23:06:22.571376+03', 5, NULL, 'Я разложила скромную кучку разноцветных подарков под искусственной елкой, которая еще неделю назад казалась совсем унылой. Какой же красивой она стала теперь! Затем я наполнила рождественский носок Лесли «мелочами», полученными от родителей. Моя мама аккуратно запаковала каждую безделушку и отказалась даже намекать мне, что внутри. «Понимаешь, — сказала она, — Рождество должно удивлять даже взрослых!».

Как же это правильно, мама! Как же верно!', 8);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (841, '2025-08-24 23:06:22.571376+03', 6, NULL, '﻿
   «Великое дело - способность удивляться, - сказал философ. - Космические полеты снова сделали всех нас детьми».

   РЭЙ БРЕДБЕРИ ПРЕДОСТЕРЕГАЕТ
   Имя Рэя Бредбери прочно вошло в обиход советских читателей. Ему не пришлось добиваться их признания: первая же его книга «451° по Фаренгейту», переведенная на русский язык, получила в нашей стране широкую известность. Со времени ее первого появления на книжных полках наших магазинов и библиотек прошло уже около 10 лет. Совсем недавно вышло второе издание этой примечательной повести. За эти годы имя Рэя Бредбери множество раз встречалось нашим читателям на страницах периодической печати и многих сборников.', 1);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (842, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Широкая известность автора предлагаемой читателям книги «Марсианские хроники» несколько упрощает задачу предисловия: нет нужды заново представлять автора читателям - открывая книгу, многие из них как бы вновь встречаются со старым знакомым.
   Это обстоятельство в свою очередь дает возможность глубже вникнуть в сущность его книги и привлечь внимание читателей к тому, как Бредбери рассматривает роль литературы в обществе. Ведь Рэй Бредбери относится к тому разряду художников, которые все свое творчество, все свое умение обращают на благо Человека, на его сегодня, а главное на его завтра. Внимательный глаз художника остро улавливает и в окружающем человека мире и внутри его самого те силы,', 2);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (843, '2025-08-24 23:06:22.571376+03', 6, NULL, 'которые внушают тревогу за его будущее. Почти в каждой книге Рэя Бредбери, почти в каждой новелле звучит тревожный сигнал бедствия. Писатель видит свою роль в том, чтобы - пока не поздно - предупредить людей, населяющих Землю, о нависшей над ними опасности, заставить их по мере сил противодействовать акциям, которые неотвратимо привели бы их к гибели нравственной, а чаще всего - и физической.
   Отсюда достигающий порой огромной силы мрачный колорит многих произведений Рэя Бредбери. Некоторые критики утверждают, что Бредбери-художник очень пессимистичен. Такое суждение крайне поверхностно. Силой своего таланта Рэй Бредбери умеет с большой выразительностью сказать то,', 3);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (844, '2025-08-24 23:06:22.571376+03', 6, NULL, 'к чему постоянно и настойчиво возвращается мысль многих наших современников, и в первую очередь соотечественников Бредбери. Весьма своеобразно- по ходу мысли, по форме ее выражения - он предостерегает человечество середины XX века от безумия атомной войны и вместе с тем от всепожирающей погони за наживой во имя мертвечины механизированного комфорта: ради него люди в своем безрассудстве готовы жертвовать человечностью, теплом человеческой любви, богатствами человеческого интеллекта, сокровищами мировой культуры.
   По свидетельствам американской печати, Рэй Бредбери лично с предубеждением относится к изобретениям новейшей техники даже в быту. Во всяком случае,', 4);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (845, '2025-08-24 23:06:22.571376+03', 6, NULL, 'смысл и счастье жизни он видит совсем в ином. Издавна в американской литературе нет-нет да прозвучит тревога за то, что ждет людей в недалеком будущем в случае, если, подчинив свои усилия стремлению к замене самих себя машинами, они забудут при этом обо всем бесценном и неповторимом, что отличает Человека от машины, даже самой хитроумной по конструкции и по выполняемым ею функциям.
   Но вряд ли кто-либо другой в истории фантастической литературы США был наделен такой же силой убежденности, тем многообразием художественных средств, какими так легко, так умело пользуется Рэй Бредбери.
   Доводилось встречать в печати и утверждения, что именно личная неприязнь Бредбери к машинам,', 5);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (846, '2025-08-24 23:06:22.571376+03', 6, NULL, 'к технике движет его писательским пером. Вряд ли можно согласиться и с этим. Бредбери трезв в своих наблюдениях над историей человечества, в своем анализе поведения человека. Развитие технической мысли, совершенствование машин и распространение их как бы выносится писателем за скобки, настолько это представляется ему бесспорным, само собой разумеющимся. Просто он не следует проторенным другими писателями-фантастами путем заглядывания в инженерные кальки будущего. Это - дело людей науки, людей техники. Свою миссию писателя Рэй Бредбери видит совсем в ином.
   Психолог, душевед, аналитик человеческого разума и поведения, как бы говорит всем Своим творчеством Бредбери,', 6);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (847, '2025-08-24 23:06:22.571376+03', 6, NULL, 'писатель дол-жен подсматривать и показывать другим, тем, кому не дано такой способности, те черты Человека, которые рождаются вновь или видоизменяются с развитием цивилизации. Призвать своих современников к бережному обращению со всеми несметными богатствами, созданными разумом человека, убедить их в том, что, лишив себя этих богатств, они утратят счастье жизни, раскрыть им глаза на уродливые стороны поступков, продиктованных слепым стремлением к материальному комфорту,- в этом видит художник Бредбери главную задачу искусства в сегодняшнем мире.
   И эту задачу, актуальную в первую очередь для современной Америки, он выполняет с присущим ему мастерством.', 7);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (848, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Все его творчество- пример счастливого сочетания интеллектуальной убежденности и большого мастерства художника.
   Всякому, кто прочел повесть «451° по Фаренгейту», надолго запомнились великолепные образы пожарника Монтэга, взбунтовавшегося против похода на создание человеческого интеллекта, и обаятельной в своей поэтичности девушки Клариссы, и удивительная концовка повести, где ее герой внезапно для себя перво-открывает огонь, пламя костра как нечто согревающее и притягательное. Для него, человека, приученного к огню только как к средству истребления, это подлинное открытие. С огромной силой звучит в этой повести твердая, неискоренимая вера в победу человеческого разума над мощными,', 8);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (849, '2025-08-24 23:06:22.571376+03', 6, NULL, 'но злыми силами разрушения. Совершенна в своей законченности и сама композиция повести, как бы обрамленной образом огня в двух противоположных его проявлениях на первой и последних ее страницах.
   Советским читателям не довелось еще прочесть одну из последних (1962) повестей Бредбери «Недобрый гость» (Something Wicked This Way Comes), одним из эпиграфов к которой стоит строка из английского поэта Йитса - «Человек влюблен, ему дорого то, что уходит». Казалось бы, и название повести, и эпиграф подчеркивают безысходность судьбы, тоску по прошлому, и только. Однако, закрыв прочитанную повесть, обнаруживаешь, что след, оставленный ею в сознании, необычайно светел, и так же крепка вера в то,', 9);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (850, '2025-08-24 23:06:22.571376+03', 6, NULL, 'что два подростка- герои книги Джим и Уилл, стоящие на пороге юности,- унесут с собой в жизнь твердую готовность противостоять подстерегавшей их на протяжении всей повести угрозе темных и злых сил. Запоминается и облик отца одного из этих мальчишек - библиотекаря Чарльза Уильяма Халлоуэя, преданного хранителя интеллектуальных ценностей, воплощающего в себе силу человеческого духа. И это - несмотря на гнетущую атмосферу ужаса, которую приносят в город на страх мальчишкам безобразные и таинственные маскии монстры бродячего цирка. Тем сильнее ликуешь вместе с героями повести, когда доброе начало одерживает победу над символами Зла.', 10);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (851, '2025-08-24 23:06:22.571376+03', 6, NULL, 'В одном из недавних интервью Рэй Бредбери бросил такие слова: «Если когда-нибудь после моей смерти мою могилу посетит мальчик и скажет: «Здесь лежит рассказчик приключений»,- я буду счастлив». Было бы ошибочно принять это замечание всего лишь за стремление овладеть мастерством рассказчика-развлекателя. В этой выразительной реплике есть и другая сторона - мечта о том, чтобы и в будущем не исчезли на Земле мечтатели, романтики, которым очень нужны те самые рассказы о приключениях, которые уносили бы их в мир, далекий от материальных устремлений, и помогали бы им оставаться людьми и строить светлую человеческую жизнь.', 11);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (852, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Сам Рэй Бредбери вносит заметный вклад в борьбу именно за такого человека, он ни за что не хочет мириться с обесчеловечиванием людского существования, с уничтожением духовных ценностей, со звериными законами современных джунглей. Вспомните переведенную на русский язык прелестную новеллу «Улыбка», пронизанную твердой убежденностью в том, насколько нужна человеку подлинная красота искусства, какой силой она обладает над каждым, кто сохранил в своей душе потребность в ней. Писатель верит, что и после атомной катастрофы, если ей суждено постигнуть Землю, останутся мальчишки, которые, зажимая в кулачок кусок растерзанного озверевшей толпой холста, будут свято хранить такую дорогую им.', 12);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (853, '2025-08-24 23:06:22.571376+03', 6, NULL, 'улыбку Монны-Лизы и украдкой вглядываться в нее при свете луны.
   Совсем не случайно переходят из книги в книгу Рэя Бредбери то юная и прекрасная девушка Кларисса, то 13-летние фантазеры Джим и Уилл, то забитый суровым отцом мальчишка из XXI века, и во сне сохраняющий в душе прекрасную улыбку с картины старого мастера. Эти образы как бы символизируют неистребимость человечности в людях, необходимость того, чтобы люди уже теперь задумались над тем, как бы не утратить ее.

   Предлагаемая вниманию читателей книга «Марсианские хроники» представляет собой серию эпизодов и новелл,', 13);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (854, '2025-08-24 23:06:22.571376+03', 6, NULL, 'написанных Рэем Бредбери на протяжении всего десятилетия 50-х годов и печатавшихся сначала порознь в периодических изданиях. Отсюда - известная разорванность книги, отсутствие той композиционной стройности, которая в большой мере свойственна прозаическим произведениям более крупного плана, вышедшим из-под пера Рэя Бредбери. Впрочем, главная мысль книги предельно ясна, автор неоднократно возвращает читателя к ней, не опасаясь повторов и проявляя убежденность в своей миссии, в ее нужности людям нашего века.
   Уже не раз высказывалась мысль о том, что научная фантастика Бредбери коренным образом отличается от подавляющего большинства произведений научно-фантастического жанра.', 14);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (855, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Скорее это социальная фантастика. Ведь Бредбери всегда использует прием переноса читателя в завтра как эзопов язык и для того, чтобы заклеймить ненавистные ему явления окружающего его современного мира. Сам он полушутя, полусерьезно говорит: «Научная фантастика - это удивительный молот, я намерен и впредь использовать его в меру надобности, ударяя им по некоторым головам, которые никак не хотят оставить в покое себе подобных». Комментируя это высказывание в предисловии к американскому изданию «Марсианских хроник» (1959), известный американский публицист Клифтон Фэдимен пишет: «Если я правильно понимаю его, он говорит нам, хотя и в очень завуалированном виде,', 15);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (856, '2025-08-24 23:06:22.571376+03', 6, NULL, 'окутывая свою мысль мерцающей туманностью искусных фантазий, что место межпланетных путешествий пока только в книгах, ибо люди все еще находятся на той ранней стадии морали и умственного развития, когда им нельзя доверять устрашающие игрушки, которые они в силу какой-то трагической случайности наизобретали». Правда, надо сказать, космические полеты, которые были осуществлены в последние годы, видимо, оказали свое воздействие на ум писателя; как сообщал еженедельник «Тайм» в самом конце 1964 года, Бредбери теперь уже называет ракеты для космических полетов одним из «шансов для человечества обессмертить себя». Впрочем, сам он, дожив до 44 лет,', 16);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (857, '2025-08-24 23:06:22.571376+03', 6, NULL, 'ни разу в жизни не летал даже на реактивном самолете, и явно предпочитает велосипед автомобилю.
   Но все это - соображения второстепенные, если говорить о социальном смысле «Марсианских хроник». Любопытно, что даже 50-е годы, явившиеся преддверием первых космических полетов и первых попыток засылки летательных аппаратов на другие планеты, не пробудили в Рэе Бредбери ни малейшего интереса к научно-техническим перспективам этих проблем. Зато его в высшей степени занимают человеческие взаимоотношения будущего, столкновения и первые встречи интеллектуально развитых существ разных цивилизаций. Перенося читателя в самый конец нынешнего и в начало следующего столетия,', 17);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (858, '2025-08-24 23:06:22.571376+03', 6, NULL, 'он пытается заглянуть в душевный мир марсианина, в его первое восприятие землян, проникших в издавна созданную на Марсе цивилизацию. Он разделяет тревогу Джеффа Спендера из Четвертой экспедиции на Марс (новелла «И по-прежнему лучами серебрит простор луна…») за судьбы древней культуры марсиан после вторжения жителей планеты Земля в этот чужой и непонятный им мир. Пережив гибель культурных ценностей у себя на родине, Спендер не мирится с мыслью о том, что и туда, в этот прекрасный и древний мир, он и его соотечественники занесут вирус истребления. Он принимает отчаянное решение - убить всех своих спутников по экспедиции,', 18);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (859, '2025-08-24 23:06:22.571376+03', 6, NULL, 'истреблять и последующих пришельцев и такой ценой отсрочить - хотя бы на ближайшие 50 лет - эру грубого хозяйничанья землян на Марсе. Его оставшиеся в живых спутники преследуют опасного убийцу. Он гибнет, но перед своей неминуемой смертью он пытается убедить капитана экспедиции в своей правоте. В известной мере это ему удается. В образах Джеффа Спендера и отчасти капитана Уайлдера писатель пытается показать ту часть человечества, которую объединяет забота о сохранении самого дорогого - плодов человеческого разума и искусных человеческих рук. Многое в его воображении принимает очертания неправдоподобные, порою лишенные логики (что, казалось бы,', 19);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (860, '2025-08-24 23:06:22.571376+03', 6, NULL, 'противоречит самим законам фантастического жанра), но благородство его намерений, высокое чувство ответственности искусства, литературы за будущее мира не вызывает сомнений. Этим Бредбери близок нам, за это его не могут не полюбить многие наши читатели.
   Очень сильно в «Марсианских хрониках» критическое начало. Возьмите хотя бы объяснения, которые даются тяге землян к переселению на иные планеты, к тому, чтобы начать жизнь сначала. Разумеется, не одна-единственная причина побуждает людей самых разных профессий, возрастов, склонностей принять это решение. В главе-новелле «Налогоплательщик» ранним утром 2000 года уроженец Огайо является на космодром и требует,', 20);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (861, '2025-08-24 23:06:22.571376+03', 6, NULL, 'чтобы Третья экспедиция взяла его с собой на ракету. «Он и тысячи других, у кого есть голова на плечах, хотят на Марс. Спросите их сами! Подальше от войн и цензуры, от бюрократии и воинской повинности, от правительства, которое шагу не дает шагнуть без разрешения, подмяло под себя и науку и искусство!..» А когда космонавты только смеются над ним и силой вталкивают его в полицейскую машину, он видит: «серебристая ракета взмывает ввысь, оставив его на ничем не примечательной планете Земля в это ничем не примечательное утро заурядного понедельника».
   И чуть дальше - в крохотной главке «Поселенцы»- снова размышления о том, что именно гонит землян на Марс: «Прилетали по-тому,', 21);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (862, '2025-08-24 23:06:22.571376+03', 6, NULL, 'что чего-то боялись и ничего не боялись, потому, что были счастливы и несчастливы, чувствовали себя паломниками и не чувствовали себя паломниками. У каждого была своя причина. Оставляли опостылевших жен, или опостылевшую работу, или опостылевшие города; прилетали, чтобы найти что-то или избавиться от чего-то или добыть что-то, откопать что-то или зарыть что-то, или предать что-то забвению…»
   И снова неутолимое стремление - жить иначе, избавиться от окружающего, обрести новый мир. Так писатель выражает неприятие хваленого образа жизни, обличает легенду об Америке как земле обетованной. Человек изверился в возможность жить так, как ему хочется,', 22);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (863, '2025-08-24 23:06:22.571376+03', 6, NULL, 'и хватается за любой самый ничтожный шанс обрести покой и счастье и вернуть себе утраченную, затоптанную красоту жизни.
   Пожалуй, наиболее законченное выражение этого содержится в великолепной заключительной новелле книги «Каникулы на Марсе» (октябрь 2026 года). После двадцатилетней изнурительной войны, когда во всей Америке уцелело всего несколько семей, одна из них, выбрав подходящий момент, отправилась в космическое путешествие на припрятанной «на всякий случай» семейной ракете. Детям объяснили, что едут на каникулы «поразвлечься». И вот они на Марсе. Тем временем жизнь здесь заглохла, марсиане вымерли. Семья пришельцев - одна на всей планете. Когда, настроив портативный приемник,', 23);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (864, '2025-08-24 23:06:22.571376+03', 6, NULL, 'отец обнаруживает, что последняя радиостанция на Земле умолкла, он взрывает ракету, доставившую их на Марс, и объявляет детям, что они могут выбрать себе любой марсианский город и остаться в нем жить. Символически предавая огню все книги и документы, привезенные с Земли, он говорит: «Я сжигаю образ жизни - тот самый образ жизни, который сейчас выжигают с лица Земли… Я был честным человеком, и меня за это ненавидели. Жизнь на Земле никак не могла устояться, чтобы хоть что-то сделать как следует, основательно. Наука слишком стремительно и слишком далеко вырвалась вперед, и люди заблудились в машинных дебрях…»
   Так семья честного американца переезжает на Марс, «чтобы жить здесь по-своему,', 24);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (865, '2025-08-24 23:06:22.571376+03', 6, NULL, 'создать свой образ жизни…» В ответ на настойчивое желание детей увидеть марсиан отец подводит их к каналу и указывает на их собственные отражения в воде. «Долго, долго из журчащей воды на них безмолвно смотрели марсиане…» Так кончаются «Марсианские хроники» - эта необычная и многозначительная книга одного из наиболее известных современных американских писателей-фантастов Рэя Бредбери.
   Не раз возвращается Бредбери к мысли об удивительной и несносной способности землян разрушать, отравлять, губить все красивое и привлекательное в жизни. На этом построена вся новелла о Четвертой экспедиции, которая упоминалась выше. Многозначителен диалог Джеффа Спендера с капитаном экспедиции:', 25);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (866, '2025-08-24 23:06:22.571376+03', 6, NULL, '«…Мы можем сколько угодно соприкасаться с Марсом - настоящего общения никогда не будет. В конце концов это доведет нас до бешенства, и знаете, что мы сделаем с Марсом? Мы его распотрошим, снимем с него шкуру и перекроим ее по своему вкусу,- говорит Спендер.
   - Мы не разрушим Марс,- сказал капитан.- Он слишком велик и великолепен.
   - Вы уверены? У нас?, землян, есть дар разрушать великое и прекрасное. Если мы не открыли сосисочную в Египте, среди развалин Карнакского храма, то лишь потому, что они лежат на отшибе и там не развернешь коммерции…»
   Горький разговор двух соотечественников, один из которых пытается уверить самого себя, что все должно быть хорошо и будет хорошо. Другой,', 26);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (867, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Джефф Спендер, уже окончательно изверился и решает избавить Марс от угрозы «отравления» землянами: «Средний американец от всего необычного нос воротит,- говорит он.- Если нет чикагского клейма- значит никуда не годится. Подумать только… Вы ведь слышали речи в конгрессе перед нашим вылетом. Мол, если экспедиция удастся, на Марсе разместят три атомные лаборатории и склады атомных бомб. Выходит, Марсу конец - все эти чудеса погибнут…» И потом, с горькой усмешкой: «Ведь я один - один против всей этой подлой, ненасытной шайки там, на Земле».
   «Один против всех…» Эта мысль высказана отнюдь не случайно.', 27);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (868, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Чувством одиночества в чуждом и ненавистном мире зла пронизано далеко не одно художественное произведение современной американской литературы. В этом, с одной стороны, признание того, что окружающее общество чуждо человеческой личности, враждебно благородным и тонким устремлениям ее души, а с другой - неумение, неспособность приложить огромную потенцию своего протеста к живой борьбе за переустройство этого общества во имя Человека и его счастья. Именно в этом заложена та трагичность человеческой судьбы, о которой с такой силой сказали в последние годы и Сэлинджер, и Апдайк, и многие другие писатели Америки в еще не известных советским читателям романах и повестях.
   Отсюда,', 28);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (869, '2025-08-24 23:06:22.571376+03', 6, NULL, 'из этого острого чувства одиночества, и рождаются такие патологические в своей жестокости и бессмысленности формы протеста, как физическое истребление всех по очереди пришельцев с Земли на Марс участником экспедиции Джеффом Спендером. Правда, Джефф Спендер в какой-то мере внутренне преступает порог полной отчужденности от людей, пытаясь силой аргументов склонить на свою сторону капитана Уайлдера, который, как ему кажется, может его понять. «Ну, зачем вам возвращаться на Землю вместе с ними? Чтобы тянуться за Джонсами? Чтобы купить себе точно такой вертолет, как у Смита? Чтобы слушать музыку не душой, а бумажником?» Тот и вправду прислушивается к его словам, задумывается над ними.', 29);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (870, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Однако привычный ход мысли, укоренившиеся представления о долге заставляют капитана завершить уничтожение Спендера, опасного для жизни участников экспедиции, и тем самым как бы занять свое место в том самом обществе, которое чуждо стремлению сохранить прекрасное для Человека будущего.Но после всего сказанного Спендером, после слов, запавших ему глубоко в душу, он уже не может быть таким, как прежде, он уже заражен отрицанием ценностей, которым слепо поклоняются его соотечественники. И в ответ на последнюю просьбу Спендера: «Если вы победите, окажите мне услугу. Постарайтесь, насколько это в ваших силах,', 30);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (871, '2025-08-24 23:06:22.571376+03', 6, NULL, 'оттянуть растерзание этой планеты хотя бы лет на пятьдесят… Обещаете?» - капитан глухо произносит единственное: «Обещаю».
   Здесь, в этой очень значительной сцене, есть уже мысль о преемственности в борьбе, есть еще совсем крохотный, но очень важный зародыш понимания того, что злым силам истребления, бессмысленной жестокости и пренебрежения к прекрасному будет оказано сопротивление и что силы сопротивления медленно, трудно, но все же растут.
   Эта новелла, как и самая первая новелла книги «Илла», говорит о том, что тяга к прекрасному присуща всем цивилизациям. Неясное томление марсианки Иллы, привидевшийся ей во сне черноволосый Землянин с голубыми глазами и белой кожей и песенка,', 31);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (872, '2025-08-24 23:06:22.571376+03', 6, NULL, 'которую она повторяет весь день, покоренная новизной ее обаяния:Глазами тост произнеси,И я отвечу взглядом,-Иль край бокала поцелуй -И мне вина не надо,
   - все это как бы сближает наиболее душевных, тонких к красоте существ из разных цивилизаций.
   Вместе с тем хочется подчеркнуть, как далек Рэй Бредбери от повторения посулов, которыми испокон веку церковь пыталась приглушить стремление человека к протесту против зла, расписывая чудеса загробного мира. В то время как религия пыталась привить человеку покорность судьбе, все, что делает Бредбери, направлено на то, чтобы пробудить в людях чувство протеста, просигналить об ожидающих их бедствиях и сказать: «Действуйте,', 32);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (873, '2025-08-24 23:06:22.571376+03', 6, NULL, 'пока не поздно!»
   Разумеется, было бы крайне наивно толковать это как некую революционную программу, как сознательный призыв к организованному преобразованию общества. Бредбери, по-видимому, очень далек от понимания классовых сил в современном обществе. Его протест носит скорее всего стихийный, интуитивный характер. Интуиция художника нередко подсказывает ему очень точные суждения о многом, что не устраивает человека в окружающем его мире. Она движет его пером при создании проекции в будущее, которая должна предостеречь Человечество от ошибок и просчетов.
   Почти каждая из его фантастических книг и новелл содержит элементы такого предостережения. О том,', 33);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (874, '2025-08-24 23:06:22.571376+03', 6, NULL, 'насколько постоянна и устойчива эта тревога Бредбери за будущее людей, говорят и произведения, написанные им в самое последнее время. Мы имеем в виду, скажем, три одноактные пьесы, поставленные в самом конце 1964 года в одном из театров Лос-Анжелеса. Наиболее выразительна, пожалуй, первая из них - «Вельд».
   Откликнувшись на зазывные клики рекламы, американская супружеская пара приобретает за 30 тысяч долларов полностью автоматизированную детскую комнату для своих малышей - ведь «детям нужно все самое лучшее». Фирма, выпускающая эти комнаты, так и наименовала ее «Все для счастья». Сложная система проекционных аппаратов и всяческих приспособлений (разумеется,', 34);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (875, '2025-08-24 23:06:22.571376+03', 6, NULL, 'по последнему слову техники будущего) по желанию детей может мгновенно превращать детскую в любое место земного шара, приобретать любой вид. Но не сказочные сады влекут воображение детей механизированной эры. Их души ожесточены отсутствием в их жизни человеческой любви и тепла. По их велению комната превращается в сухую, выжженную солнцем тропическую пустошь - в африканский вельд. Они запирают в этой мрачной комнате собственных родителей, и те становятся жертвами разъяренных львов.
   Можно представить себе, какой эффект производит со сцены это леденящее душу зрелище. Смотрите, предостерегает автор, смотрите, в какую бездну жестокости и бездушия вы готовы бросить своих детей, забывая,', 35);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (876, '2025-08-24 23:06:22.571376+03', 6, NULL, 'что им нужно для счастья. При внешней жестокости и беспощадности этой пьесы можно с полной уверенностью сказать,-что она исполнена самого настоящего гуманизма, подлинного и очень обостренного намерения помочь людям понять, куда не следует направлять усилия интеллекта, инженерного искусства, чтобы жизнь человека не становилась в результате все невыносимее, все бессмысленнее, все бессердечнее.
   При этом, однако, нет другого: нет ни ясного понимания, ни даже попытки по-настоящему понять, как же нужно жить сегодня, чтобы не исковеркать человеческого завтра, а,напротив, сделать его светлее. В этом - главная слабость Рэя Бредбери, в этом - очень уязвимая черта его творчества. Самое большее,', 36);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (877, '2025-08-24 23:06:22.571376+03', 6, NULL, 'на что оказывается способен Бредбери в этом плане, это наивная идеализация патриархального прошлого. Перечитайте его книги, и вы увидите, что все светлое, озаренное солнцем или теплым пламенем костра в лесу, уводит человека назад, в давно прошедшую эру создания непреходящих ценностей искусства и интеллекта. Вот и здесь, в этой книге, попадая на иную планету, человек обнаруживает цивилизацию гораздо более древнюю, нежели на Земле, ипотомуболее прекрасную, а марсиан не стремящимися на иные планеты только потому, что они, пользуясь словами Джеффа Спендера, «остановились там, где нам надо было остановиться сто лет назад».
   Впрочем, не закрывая глаза на все эти недостатки,', 37);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (878, '2025-08-24 23:06:22.571376+03', 6, NULL, 'можно с уверенностью сказать, что миссия, которую принял на себя этот честный и одаренный писатель сегодняшней Америки, благородна, и у него есть все данные, чтобы выполнять эту миссию успешно.
   Ел. Романова


   Январь 1999

   Ракетное лето
   Только что была огайская зима: двери заперты, окна закрыты, стекла незрячие от изморози, все крыши оторочены сосульками, дети мчатся с горок на лыжах, женщины в шубах черными медведицами бредут по гололедным улицам.
   И вдруг могучая волна тепла прокатилась по городку, вал горячего воздуха захлестнул его, будто нечаянно оставили открытой дверь пекарни. Зной омывал дома, кусты, детей. Сосульки срывались с крыш, разбивались и таяли.', 38);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (879, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Двери распахнулись. Окна раскрылись. Дети скинули свитера. Мамаши сбросили медвежье обличье. Снег испарился, и на газонах показалась прошлогодняя жухлая трава.
   Ракетное лето.Из уст в уста с ветром из дома в открытый дом - два слова:Ракетное лето.Жаркий, как дыхание пустыни, воздух переиначивал морозные узоры на окнах, слизывал хрупкие кружева. Лыжи и санки вдруг стали не нужны. Снег, падавший на городок с холодного неба, превращался в горячий дождь, не долетев до земли.
   Ракетное лето.Высунувшись с веранд под дробную капель, люди смотрели вверх на алеющее небо.
   Ракета стояла на космодроме, испуская розовые клубы огня и печного жара.', 39);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (880, '2025-08-24 23:06:22.571376+03', 6, NULL, 'В стуже зимнего утра ракета творила лето каждым выдохом своих мощных дюз. Ракета делала погоду, и на короткий миг во всей округе воцарилось лето…
   Февраль 1999

   Илла
   Они жили на планете Марс, в доме с хрустальными колоннами, на берегу высохшего моря, и по утрам можно было видеть, как миссис К ест золотые плоды, растущие из хрустальных стен, или наводит чистоту, рассыпая пригоршнями магнитную пыль, которую горячий ветер уносил вместе с сором. Под вечер, когда древнее море было недвижно и знойно, и винные деревья во дворе стояли в оцепенении, и старинный марсианский городок вдали весь уходил в себя и никто не выходил на улицу, мистера К можно было видеть в его комнате,', 40);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (881, '2025-08-24 23:06:22.571376+03', 6, NULL, 'где он читал металлическую книгу, перебирая пальцами выпуклые иероглифы, точно струны арфы. И книга пела под его рукой, певучий голос древности повествовал о той поре, когда море алым туманом застилало берега и древние шли на битву, вооруженные роями металлических шершней и электрических пауков.
   Мистер и миссис К двадцать лет прожили на берегу мертвого моря, и их отцы и деды тоже жили в этом доме, который поворачивался, подобно цветку, вслед за солнцем, вот уже десять веков.
   Мистер и миссис К были еще совсем не старые. У них была чистая, смуглая кожа настоящих марсиан, глаза желтые, как золотые монеты, тихие мелодичные голоса. Прежде они любили писать картины химическим пламенем,', 41);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (882, '2025-08-24 23:06:22.571376+03', 6, NULL, 'любили плавать в каналах в то время года, когда винные деревья наполняли их зеленой влагой, а потом до рассвета разговаривать под голубыми светящимися портретами в комнате для бесед.
   Теперь они уже не были счастливы.
   В то утро миссис К, словно вылепленная из желтого воска, стояла между колоннами, прислушиваясь к зною бесплодных песков, устремленная куда-то вдаль.
   Что-то должно было произойти.
   Она ждала.
   Она смотрела на голубое марсианское небо так, словно оно могло вот-вот поднатужиться, сжаться и исторгнуть на песок сверкающее чудо.
   Но все оставалось по-прежнему.
   Истомившись ожиданием, она стала бродить между туманными колоннами.', 42);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (883, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Из желобков в капителях заструился тихий дождь, охлаждая раскаленный воздух, гладя ее кожу. В жаркие дни это было все равно что войти в ручей. Прохладные струи посеребрили полы. Слышно было, как муж без устали играет на своей книге; древние напевы не приедалисьего пальцам.
   Она подумала без волнения: он бы мог когда-нибудь подарить и ей, как бывало прежде, столько же времени, обнимая ее, прикасаясь к ней, словно к маленькой арфе, как он прикасается к своим невозможным книгам.
   Увы. Она покачала головой, отрешенно пожала плечами, чуть-чуть. Веки мягко прикрыли золотистые глаза. Брак даже молодых людей делает старыми, давно знакомыми…
   Она опустилась в кресло,', 43);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (884, '2025-08-24 23:06:22.571376+03', 6, NULL, 'которое тотчас само приняло форму ее фигуры. Она крепко, нервно зажмурилась.
   И сон явился. [Картинка: pic_3.png] 
   Смуглые пальцы вздрогнули, метнулись вверх, ловя воздух. Мгновение спустя она испуганно выпрямилась в кресле, прерывисто дыша.
   Она быстро обвела комнату взглядом, точно надеясь кого-то увидеть. Разочарование: между колоннами было пусто.
   В треугольной двери показался ее супруг.
   - Ты звала меня? - раздраженно спросил он.
   - Нет! - почти крикнула она.
   - Мне почудилось, ты кричала.
   - В самом деле? Я задремала и видела сон!
   - Днем? Это с тобой не часто бывает.
   Глаза ее говорили о том, что она ошеломлена сновидением.
   - Странно, очень-очень странно,', 44);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (885, '2025-08-24 23:06:22.571376+03', 6, NULL, '- пробормотала она. - Этот сон…
   - Ну? - Ему явно не терпелось вернуться к книге.
   - Мне снился мужчина.
   - Мужчина?
   - Высокий мужчина, шесть футов один дюйм.
   - Что за нелепость: это же великан, урод.
   - Почему-то, - она медленно подбирала слова, - он не казался уродом. Несмотря на высокий рост. И у него - ах, я знаю, тебе это покажется вздором, - у него былиголубыеглаза!
   - Голубые глаза! - воскликнул мистер К. - О боги!
   Что тебе приснится в следующий раз? Ты еще скажешь -черныеволосы?
   - Как тыугадал?! -воскликнула она.
   - Просто назвал наименее правдоподобный цвет, - сухо ответил он.
   - Да, черные волосы! - крикнула она.', 45);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (886, '2025-08-24 23:06:22.571376+03', 6, NULL, '- И очень белая кожа.Совершеннонеобычайный мужчина! На нем была странная одежда, и он спустился с неба и ласково говорил со мной.
   Она улыбалась.
   - С неба - какая чушь!
   - Он прилетел в металлической машине, которая сверкала на солнце, - вспоминала миссис К. Она закрыла глаза, чтобы воссоздать видение. - Мне снилось небо, и что-то блеснуло, будто подброшенная в воздух монета, потом стало больше, больше и плавно опустилось на землю, - это был длинный серебристый корабль, круглый, чужой корабль. Потом сбоку отворилась дверь и вышел этот высокий мужчина.
   - Работала бы побольше, тебе не снились бы такие дурацкие сны.
   - А мне он понравился, - ответила она, откидываясь в кресле.', 46);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (887, '2025-08-24 23:06:22.571376+03', 6, NULL, '- Никогда не подозревала, что у меня такое воображение. Черные волосы, голубые глаза, белая кожа! Какой странный мужчина - и, однако, очень красивый.
   - Самовнушение.
   - Ты недобрый. Я вовсе не придумала его намеренно, он сам явился мне, когда я задремала. Даже не похоже на сон. Так неожиданно, необычно… Он посмотрел на меня и сказал: «Я прилетел на этом корабле с третьей планеты. Меня зовут Натаниел Йорк…»
   - Нелепое имя, - возразил супруг. - Таких вообще не бывает.
   - Конечно, нелепое, ведь это был сон, - покорно согласилась она. - Еще он сказал: «Это первый полет через космос. Нас всего двое в корабле - я и мой друг Берт».
   - Еще одно нелепое имя.
   - Он сказал:', 47);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (888, '2025-08-24 23:06:22.571376+03', 6, NULL, '«Мы из города на Земле, так называется наша планета», - продолжала миссис К. - Это его слова. Так и сказал - Земля. И говорил он не на нашем языке. Но я каким-то образом понимала его. В уме. Телепатия, очевидно.
   Мистер К отвернулся. Ее голос остановил его.
   - Илл! - тихо позвала она. - Ты никогда не задумывался… ну… есть ли люди на третьей планете?
   - На третьей планете жизнь невозможна, - терпеливо разъяснил супруг. - Наши ученые установили, что в тамошней атмосфере слишком много кислорода.
   - А как было бы чудесно, если бы там жили люди! И умели путешествовать через космос на каких-нибудь особенных кораблях.
   - Вот что, Илла, ты отлично знаешь,', 48);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (889, '2025-08-24 23:06:22.571376+03', 6, NULL, 'я ненавижу эту сентиментальную болтовню. Займемся лучше делом.
   Близился вечер, когда она, ступая между колоннами, источающими дождь, запела. Один и тот же мотив, снова и снова.
   - Что это за песня? - рявкнул в конце концов супруг, проходя к огненному столу.
   - Не знаю.
   Она подняла на него глаза, удивляясь сама себе. Озадаченно поднесла ко рту руку. Солнце садилось, и по мере того, как дневной свет угасал, дом закрывался, будто огромный цветок. Между колоннами подул ветерок, на огненном столе жарко бурлило озерко серебристой лавы. Ветер перебирал кирпичные волосы миссис К, тихонько шепча ей на ухо. Она молча стояла, устремив затуманившийся взор золотистых глаз вдаль,', 49);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (890, '2025-08-24 23:06:22.571376+03', 6, NULL, 'на бледно-желтую гладь морского дна, словно вспоминая что-то.Глазами тост произнеси,И я отвечу взглядом, -
   запела она тихо, медленно, нежно.Иль край бокала поцелуй -И мне вина не надо.
   Миссис К повторила мелодию, уже без слов, закрыв глаза, и руки ее словно порхали по ветру. Наконец она умолкла.
   Мелодия была прекрасна.
   - Впервые слышу эту песню. Ты сама ее сочинила? - строго спросил он, испытующе глядя на нее.
   - Нет. Да. Право, не знаю! - Она была в смятении. - Я даже не понимаю слов, это другой язык!
   - Какой язык?
   Она машинально бросала куски мяса в кипящую лаву.
   - Не знаю. - Через мгновение мясо было готово, она извлекла его из огня и подала мужу на тарелке. - Ах,', 50);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (891, '2025-08-24 23:06:22.571376+03', 6, NULL, 'наверно, я просто придумала весь этот вздор, только и всего. Сама не понимаю почему.
   Он ничего не сказал. Смотрел, как она погружает мясо в шипящую огненную лужицу. Солнце скрылось. Медленно-медленно вошла в комнату ночь, темным вином заполнила ее до потолка, поглотив колонны и их двоих. Лишь отблески серебристой лавы озаряли лица.
   Она снова стала напевать странную песню.
   Он вскочил со стула и гневно прошествовал к двери.
   Позднее он доел ужин один.
   Встав из-за стола, потянулся, поглядел на нее и, зевая, предложил:
   - Съездим на огненных птицах в город, развлечемся?
   - Тысерьезно? -спросила она. - Ты не заболел?
   - А что тут странного?', 51);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (892, '2025-08-24 23:06:22.571376+03', 6, NULL, '- Но мы уже полгода нигде не были!
   - По-моему, неплохая мысль.
   - С чего это вдруг ты так заботлив?
   - Ну, хватит, - брюзгливо бросил он. - Поедешь или нет?
   Она посмотрела на седую пустыню. Две белые луны вышли из-за горизонта. Прохладная вода гладила пальцы ног. Легкая дрожь пробежала по ее телу. Больше всего ей хотелось остаться здесь, сидеть тихо, беззвучно, неподвижно, пока не свершится то, чего она ждала весь день, то, что не должно было произойти и все же могло, могло случиться… Душа встрепенулась от нежного прикосновения песни.
   - Я…
   - Для тебя же лучше, - настаивал он. - Поехали.
   - Я устала, - ответила она. - Как-нибудь в другой раз.
   - Вот твой шарф.', 52);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (893, '2025-08-24 23:06:22.571376+03', 6, NULL, '- Он подал ей флакон. - Мы уже который месяц никуда не выезжали.
   - Если не считать твоих поездок в Кси-Сити два раза в неделю. - Она избегала глядеть на него.
   - Дела, - сказал он.
   - Дела? - прошептала она.
   Из флакона брызнула жидкость, превратилась в голубую мглу и, трепеща, обвилась вокруг ее шеи.

   На ровном прохладном песке, светясь, словно раскаленные угли, ожидали огненные птицы. Надуваемый ночным ветром, в воздухе плескался белый балдахин, множеством зеленых лент привязанный к птицам.
   Илла легла под балдахин, и по приказу ее мужа пылающие птицы взметнулись к темному небу. Ленты натянулись, балдахин взмыл в воздух. Взвизгнув, ушли вниз пески; мимо,', 53);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (894, '2025-08-24 23:06:22.571376+03', 6, NULL, 'мимо потянулись голубые холмы, оттеснив назад их дом, колонны, источающие дождь, цветы в клетках, поющие книги, тихие ручейки на полу. Она не глядела на мужа. Ей было слышно, как он покрикивал на птиц, а те взвивались все выше, летя, словно тысячи каленых искр, словно багрово-желтый фейерверк, все дальше в небо, увлекая за собой сквозь ветер балдахин - трепещущий белый лепесток.
   Она не смотрела на мелькающие внизу древние мертвые города, на дома - словно вырезанные из кости шахматы, не смотрела на древние каналы, наполненные пустотой и грезами. Над высохшими реками и сухими озерами пролетали они, будто лунный блик, будто горящий факел.
   Она глядела только на небо.
   Муж что-то сказал.', 54);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (895, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Она глядела на небо.
   - Ты слышала, что я сказал?
   - Что?
   Он шумно выдохнул.
   - Могла бы быть повнимательнее.
   - Я задумалась.
   - Никогда не знал, что ты такая любительница природы. Сегодня ты просто не отрываешь глаз от неба, - сказал он.
   - Оно очень красиво.
   - Я вот о чем подумал, - медленно продолжал супруг. - Не позвонить ли сегодня Халлу? Договориться, что мы приедем - на недельку, не больше! - к ним в Голубые горы. Чем не идея?…
   - Голубые горы! - Она схватилась одной рукой за край балдахина и резко повернулась к нему.
   - Я ведь только предлагаю.
   - И когда ты думаешь ехать? - нервно спросила она.
   - Да можно отправиться хоть завтра утром,', 55);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (896, '2025-08-24 23:06:22.571376+03', 6, NULL, '- подчеркнуто небрежно бросил он. - Сама знаешь: раньше начнешь, скорее…
   - Но мы еще никогда не уезжали так рано!
   - Ну, в этом году в виде исключения… - Он улыбнулся. - Нам полезно переменить обстановку. Пожить в тиши, в покое. Словом, сама понимаешь. У тебя ведь нет других планов? Поедем, решено?
   Она вздохнула, помедлила, потом ответила:
   - Нет.
   - Что? - Его возглас испугал птиц. Балдахин дернулся.
   - Нет, - твердо сказала она. - Я не поеду.
   Он посмотрел на нее. Разговор был окончен. Она отвернулась.
   Птицы летели дальше - десять тысяч гонимых ветром угольков.

   На рассвете солнце, пронизав лучами хрустальные колонны, растворило туман,', 56);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (897, '2025-08-24 23:06:22.571376+03', 6, NULL, 'на котором покоилась спящая Илла. Всю ночь она парила над полом, как бы плавая на мягком ложе из тумана, который пролился из стен, едва Илла прилегла. Всю ночь она проспала на этой недвижной реке, точно челн среди немого потока. Теперь туман улетучивался,и наконец река спала, оставив Иллу на берегу пробуждения.
   Она открыла глаза.
   Над ней стоял муж. Было похоже, что он стоит тут, наблюдая, уже не один час. Почему-то Илла не могла смотреть ему в глаза.
   - Тебе опять снился этот сон! - сказал он. - Ты разговаривала, не давала мне уснуть. Тебе непременно надо показаться врачу.
   - Ничего со мной не случится.
   - Ты много говорила во сне!
   - Да? - Она поспешно села.', 57);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (898, '2025-08-24 23:06:22.571376+03', 6, NULL, 'В комнате было холодно. Серый утренний свет проявил черты Иллы.
   - Что тебе снилось?
   Она молчала, вспоминая.
   - Корабль. Он снова спустился с неба, и из него вышел высокий человек и заговорил со мной. Он шутил, смеялся, и мне было хорошо.
   Мистер К коснулся рукой колонны. Окутанные паром струйки теплой воды вытеснили холодок из комнаты. Лицо мистера К было бесстрастно.
   - А потом, - продолжала она, - этот мужчина, у которого такое странное имя - Натаниел Йорк, сказал что я прекрасна, и… и поцеловал меня.
   - Ха! - крикнул муж и отвернулся, играя желваками.
   - Но это всего лишь сон. - Ей стало весело.
   - Ну и помалкивай про свои нелепые женские сны.
   - Ты ведешь себя,', 58);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (899, '2025-08-24 23:06:22.571376+03', 6, NULL, 'как ребенок. - Она откинулась на последние клочья химического тумана. Мгновение спустя тихо рассмеялась.
   - Я ещечто-товспомнила, - призналась она.
   - Ну,что,говори, что! - вскричал муж.
   - Илл, ты такой раздражительный!
   - Говори! - потребовал он. - У тебя не должно быть секретов от меня!
   На нее смотрело сверху его мрачное, суровое лицо.
   - Я никогда не видела тебя таким, - ответила Илла, ей было и страшно и забавно. - Ничего такого не было, просто этот Натаниел Йорк сказал… словом, он сказал мне, что увезет меня на своем корабле, увезет на небеса, возьмет меня с собой на свою планету. Конечно, чепуха…
   - Вот именно, чепуха! - Он едва не сорвал голос.', 59);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (900, '2025-08-24 23:06:22.571376+03', 6, NULL, '- Ты бы послушала себя со стороны: заигрывать с ним разговаривать с ним, петь с ним, и так всю ночь напролет, о боги!Послушалабы себя!
   - Илл!
   - Когда он сядет? Где он опустится на своем про клятом корабле?
   - Илл, не повышай голос.
   - К черту мой голос! - он в гневе наклонился на и ней. - В этом твоемсне… -он стиснул ее запястье, - корабль сел в Зеленой долине,да?Отвечай!
   - Ну, в долине…
   - Сел сегодня, под вечер, да? - не унимался он.
   - Да, да, кажется, так. Но это же только сон!
   - Ладно. - Он сердито отбросил ее руку. - Хорошо, что ты не лжешь! Я слышал все, что ты говорила во сне, каждое слово. Ты сама назвала и долину, и время.
   Тяжело дыша,', 60);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (901, '2025-08-24 23:06:22.571376+03', 6, NULL, 'он побрел между колоннами, будто ослепленный молнией. Постепенно его дыхание успокоилось. Она не отрывала от него глаз - уж не сошел ли он с ума!.. Наконец встала и подошла к нему.
   - Илл, - прошептала она.
   - Ничего, ничего…
   - Ты болен.
   - Нет. - Он устало, через силу улыбнулся. - Ребячество, только и всего. Прости меня, дорогая. - Он грубовато погладил ее. - Заработался. Извини. Я, пожалуй, пойду, прилягу…
   - Ты так вспылил.
   - Теперь все прошло. Прошло. - Он перевел дух. - Забудем об этом. Да, я вчера слышал анекдот про Уэла, хотел тебе рассказать. Ты приготовишь завтрак, я расскажу анекдот, а об этом больше не будем говорить, ладно?
   - Это был только сон.
   - Разумеется.', 61);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (902, '2025-08-24 23:06:22.571376+03', 6, NULL, '- Он машинально поцеловал ее в щеку. - Только сон.

   В полдень солнце палило, и очертания гор струились в его лучах.
   - Ты не поедешь в город? - спросила Илла.
   - В город? - Его брови чуть поднялись.
   - Тывсегдауезжаешь в этот день. - Она поправила цветочную клетку на подставке. Цветы зашевелились и раскрыли голодные желтые рты.
   Он захлопнул книгу.
   - Нет. Слишком жарко. И поздно.
   - Вот как. - Она закончила свое дело и пошла к двери. - Я скоро вернусь.
   - Постой! Ты куда?
   Она была уже в дверях.
   - К Пао. Она пригласила меня!
   - Сегодня?
   - Я ее сто лет не видела. Это же недалеко.
   - В Зеленой долине, если не ошибаюсь?
   - Ну да, тут рукой подать,', 62);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (903, '2025-08-24 23:06:22.571376+03', 6, NULL, 'и я решила… - Она очень торопилась.
   - Извини меня, - сказал он, догоняя ее с видом крайней озабоченности. - Я совершенно забыл: я же пригласил к нам сегодня доктора Нлле!
   - Доктора Нлле! - Она подалась к двери.
   Он поймал ее за локоть и решительно втащил в комнату.
   - Да.
   - А как же Пао…
   - Пао подождет, Илла. Мы должны принять Нлле.
   - Я на несколько минут…
   - Нет, Илла.
   - Нет?
   Он отрицательно качнул головой.
   - Нет. К тому же до них очень далеко идти. Через всю Зеленую долину, за большой канал, потом вниз… И сегодня очень, очень жарко, и доктору Нлле будет приятно увидеть тебя. Хорошо?
   Она не ответила. Ей хотелось вырваться и убежать. Хотелось кричать.', 63);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (904, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Но она только сидела в кресле, словно пойманная в западню, и с окаменевшим лицом разглядывала свои пальцы, медленно шевеля ими.
   - Илла, - буркнул он, - ты останешься дома, ясно?
   - Да, - сказала она после долгого молчания. - Останусь.
   - Весь день?
   Ее голос звучал глухо:
   - Весь день.

   Шли часы, а доктор Нлле все не появлялся. Казалось, муж Иллы не очень-то удивлен этим. Уже под вечер он, пробормотав что-то, подошел к стенному шкафу и достал зловещееоружие - длинную желтоватую трубку с гармошкой мехов и спусковым крючком на конце. Он обернулся - на его лице была лишенная всякого выражения маска, вычеканенная изсеребристого металла, маска, которую он всегда надевал,', 64);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (905, '2025-08-24 23:06:22.571376+03', 6, NULL, 'когда хотел скрыть свои чувства; маска, выпуклости и впадины которой в точности отвечали его худым щекам, подбородку, лбу. Поблескивая маской, он держал в руках свое грозное оружие и разглядывал его. Оно непрерывно жужжало - оружие, способное с визгом извергнуть полчища золотых пчел. Страшных золотых пчел, которые жалят, убивают своим ядом и падают замертво, будто семена на песок.
   - Куда ты собрался? - спросила она.
   - Что? - Он прислушивался к мехам, к зловещему жужжанию. - Раз доктор Нлле запаздывает, черта с два стану я его ждать. Пойду, поохочусь. Скоро вернусь.
   А ты останешься здесь, и никуда отсюда, ясно? - Серебристая маска сверкнула.
   - Да.
   - И скажи доктору Нлле,', 65);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (906, '2025-08-24 23:06:22.571376+03', 6, NULL, 'что я приду. Только поохочусь.
   Треугольная дверь затворилась. Его шаги удалились вниз по откосу.
   Она смотрела, как муж уходит в солнечную даль, пока он не исчез. Потом вернулась к своим делам: наводить чистоту магнитной пылью, собирать свежие плоды с хрустальных стен. Она работала усердно и расторопно, но порой ею овладевала какая-то истома, и она ловила себя на том, что напевает эту странную, не идущую из ума песню и поглядывает на небо из-за хрустальных колонн.
   Она затаила дыхание и замерла в ожидании.
   Приближается…
   Вот-вот это произойдет.
   Бывают такие дни, когда слышишь приближение грозы, а кругом напряженная тишина,', 66);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (907, '2025-08-24 23:06:22.571376+03', 6, NULL, 'и вдруг едва ощутимо меняется давление - это дыхание непогоды, летящей над планетой,ее тень, порыв, марево. Воздух давит на уши, и ты натянут как струна в ожидании надвигающейся бури. Тебя охватывает дрожь. Небо в пятнах, небо цветное, тучи сгущаются,горы отливают металлом. Цветы в клетках тихонько вздыхают, предупреждая. Волосы чуть шевелятся на голове. Где-то в доме поют часы: «Время, время, время, время…» Тихотак, нежно, будто капающая на бархат вода.
   И вдруг - гроза! Электрическая вспышка, и сверху непроницаемым заслоном рушатся всепоглощающие волны черного прибоя и громовой черноты.
   Так было и теперь. Близилась буря, хотя небо было ясным. Назревала молния, хотя не было туч.', 67);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (908, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Илла бродила по комнатам притихшего летнего дома. В любой миг с неба может пасть молния, и будет раскат грома, клуб дыма, безмолвие, шаги на дорожке, стук в хрустальную дверь - и онастрелойметнется навстречу…
   «Сумасшедшая Илла! - мысленно усмехнулась она. - Что за мысли будоражат твой праздный ум?» И тут - свершилось.
   Порыв жаркого воздуха, точно мимо пронеслось могучее пламя. Вихревой стремительный звук. В небе блеск, сверкание металла.

   У Иллы вырвался крик.
   Она побежала между колоннами, распахнула дверь. Она уставилась на горы. Но там уже ничего…
   Хотела ринуться вниз по откосу, но спохватилась. Она обязана быть здесь, никуда не уходить.', 68);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (909, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Доктор должен прийти с минуты на минуту, и муж рассердится, если она убежит.
   Она остановилась в дверях, часто дыша, протянув вперед одну руку.
   Попыталась рассмотреть что-нибудь там, где простерлась Зеленая долина, но ничего не увидела.
   «Сумасшедшая! - Она вернулась в комнату. - Это все твоя фантазия.
   Ничего не было. Просто птица, листок, ветер или рыба в канале. Сядь. Приди в себя».
   Она села.
   Выстрел.
   Ясный, отчетливый, зловещий звук.
   Она содрогнулась.
   Выстрел донесся издалека. Один. Далекое жужжание быстрых пчел. Один выстрел. А за ним второй, четкий, холодный, отдаленный.
   Она опять вздрогнула и почему-то вскочила на ноги, крича,', 69);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (910, '2025-08-24 23:06:22.571376+03', 6, NULL, 'крича и не желая оборвать этот крик. Стремительно пробежала по комнатам к двери и снова распахнула ее.
   Эхо стихало, уходя вдаль, вдаль…
   Смолкло.
   Несколько минут она простояла во дворе, бледная.
   Наконец, медленно ступая, опустив голову, она побрела сквозь обрамленные колоннами покои, из одного в другой, руки ее машинально трогали вещи, губы дрожали; в сгущающемся мраке винной комнаты ей захотелось посидеть одной. Она ждала. Потом взяла янтарный бокал и стала тереть его уголком шарфа.
   И вот издалека послышались шаги, хруст мелких камешков под ногами.
   Она поднялась, стала в центре тихой комнаты. Бокал выпал из рук, разбился вдребезги.', 70);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (911, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Шаги нерешительно замедлились перед домом.
   Заговорить? Воскликнуть: «Входи, входи же!»?
   Она подалась вперед.
   Вот шаги уже на крыльце. Рука повернула щеколду.
   Она улыбнулась двери.
   Дверь отворилась. Улыбка сбежала с ее лица.
   Это был ее муж. Серебристая маска тускло поблескивала.
   Он вошел и лишь на мгновение задержал на ней взгляд. Резким движением открыл мехи своего оружия, вытряхнул две мертвые пчелы, услышал, как они шлепнулись о пол, раздавил их ногой и поставил разряженное оружие в угол комнаты, а Илла, наклонившись, безуспешно пыталась собрать осколки разбитого бокала.
   - Что ты делал? - спросила она.
   - Ничего, - ответил он, стоя спиной к ней. Он снял маску.', 71);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (912, '2025-08-24 23:06:22.571376+03', 6, NULL, '- Ружье… я слышала, как ты стрелял. Два раза.
   - Охотился, только и всего. Потянет иногда на охоту… Доктор Нлле пришел?
   - Нет.
   - Постой-ка. - Он противно щелкнул пальцами. - Ну, конечно,теперья вспомнил. Мы же условились с ним назавтра.Я все перепутал.
   Они сели за стол. Она глядела на свою тарелку, но руки ее не прикасались к еде.
   - В чем дело? - спросил он, не поднимая глаз, бросая куски мяса в бурлящую лаву.
   - Не знаю. Не хочется есть, - сказала она.
   - Почему?
   - Не знаю, просто не хочется.
   В небе родился ветер; солнце садилось. Комната вдруг стала маленькой и холодной.
   - Я пытаюсь вспомнить, - произнесла она в тиши комнаты,', 72);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (913, '2025-08-24 23:06:22.571376+03', 6, NULL, 'глянув в золотые глаза своего холодного, безупречно подтянутого мужа.
   - Что вспомнить? - Он потягивал вино.
   - Песню. Эту красивую, чудесную песню. - Она закрыла глаза и стала напевать, но песня не получилась. - Забыла. А мне почему-то не хочется ее забывать. Хочется помнить еевсегда. - Она плавно повела руками, точно ритм движений мог ей помочь. Потом откинулась в кресле. - Не могу вспомнить.
   Она заплакала.
   - Почему ты плачешь? - спросил он.
   - Не знаю, не знаю, я ничего не могу с собой поделать. Мне грустно, и я не знаю почему, плачу - не знаю почему, но плачу.
   Ее ладони стиснули виски, плечи вздрагивали.
   - До завтра все пройдет, - сказал он.
   Она не глядела на него,', 73);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (914, '2025-08-24 23:06:22.571376+03', 6, NULL, 'глядела только на нагую пустыню и на яркие-яркие звезды, которые высыпали на черном небе, а издали доносился крепнущий голос ветра и холодный плеск воды в длинных каналах. Она закрыла глаза, дрожа всем телом.
   - Да, - повторила она, - до завтра все пройдет.
   Август 1999

   Летняя ночь
   Люди стояли кучками в каменных галереях, растворяясь в тени между голубыми холмами. Звезды и лучезарные марсианские луны струили на них мягкий вечерний свет. Позади мраморного амфитеатра, скрытые мраком и далью, раскинулись городки и виллы, серебром отливали недвижные пруды, от горизонта до горизонта блестели каналы. Летний вечер на Марсе, планете безмятежности и умеренности.', 74);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (915, '2025-08-24 23:06:22.571376+03', 6, NULL, 'По зеленой влаге каналов скользили лодки, изящные, как бронзовые цветки. В нескончаемо длинных рядах жилищ, извивающихся по склонам, подобно оцепеневшим змеям, в прохладных ночных постелях лениво перешептывались возлюбленные. Под факелами на аллеях, держа в руках извергающих тончайшую паутину золотых пауков, еще бегали заигравшиеся дети. Тут и там на столах, булькающих серебристой лавой, готовился поздний ужин. В амфитеатрах сотен городов на ночной стороне Марса смуглые марсиане с глазами цвета червонного золота собирались на досуге вокруг эстрад, откуда покорные музыкантам тихие мелодии, подобно аромату цветов, плыли в притихшем воздухе.
   На одной эстраде пела женщина.', 75);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (916, '2025-08-24 23:06:22.571376+03', 6, NULL, 'По рядам слушателей пробежал шелест.
   Пение оборвалось. Певица поднесла руку к горлу.
   Потом кивнула музыкантам, они начали сначала.
   Музыканты заиграли, она снова запела; на этот раз публика ахнула, подалась вперед, кто-то вскочил на ноги - на амфитеатр словно пахнуло зимней стужей. Потому что песня, которую пела женщина, была странная, страшная, необычная. Она пыталась остановить слова, срывающиеся с ее губ, но они продолжали звучать:Идет, блистая красотойТысячезвездной ясной ночиВ соревнованьи света с тьмойИзваяны чело и очи.
   Руки певицы метнулись ко рту. Она оцепенела, растерянная.
   - Что это за слова? - недоумевали музыканты.
   - Что за песня?
   - Чей язык?', 76);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (917, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Когда же они опять принялись дуть в свои золотые трубы, снова родилась эта странная музыка и медленно поплыла над публикой, которая теперь громко разговаривала, поднимаясь со своих мест.
   - Что с тобой? - спрашивали друг друга музыканты.
   - Что за мелодию ты играл?
   - А ты сам что играл?
   Женщина расплакалась и убежала с эстрады. Публика покинула амфитеатр. Повсюду, во всех смятенных марсианских городах, происходило одно и то же. Холод объял их, точно с неба пал белый снег.
   В темных аллеях под факелами дети пели:…Пришла, а шкаф уже пустой,Остался песик с носом!
   - Дети! - раздавались голоса. - Что это за песенка? Где вы ее выучили?
   - Она простопришла намв голову,', 77);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (918, '2025-08-24 23:06:22.571376+03', 6, NULL, 'ни с того ни с сего. Какие-то непонятные слова!
   Захлопали двери. Улицы опустели. Над голубыми холмами взошла зеленая звезда.
   На всей ночной стороне Марса мужчины просыпались от того, что лежавшие рядом возлюбленные напевали во мраке.
   - Что это за мелодия?
   В тысячах жилищ среди ночи женщины просыпались, обливаясь слезами, и приходилось их утешать:
   - Ну, успокойся, успокойся же. Спи. - Ну, что случилось? Дурной сон?
   - Завтра произойдет что-то ужасное.
   - Ничего не может произойти, у нас все в порядке. Судорожное всхлипывание.
   - Я чувствую, это надвигается все ближе, ближе,ближе!..
   - С нами ничего не может случиться. Полно! Спи. Спи…
   Тихо на предутреннем Марсе,', 78);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (919, '2025-08-24 23:06:22.571376+03', 6, NULL, 'тихо, как в черном студеном колодце, и свет звезд на воде каналов, и в каждой комнате дыхание свернувшихся калачиком детей с зажатыми в кулачках золотыми пауками, и возлюбленные спят рука в руке, луны закатились, погашены факелы, и безлюдны каменные амфитеатры.
   И лишь один-единственный звук, перед самым рассветом: где-то в дальнем конце пустынной улицы одиноко шагал во тьме ночной сторож, напевая странную, незнакомую песенку…
   Август 1999

   Земляне
   Вот привязались, стучат и стучат!
   Миссис Ттт сердито распахнула дверь.
   - Ну, в чем дело?
   - Вы говоритепо-английски? -Человек, стоявший у входа, опешил.
   - Говорю, как умею, - ответила она.
   - Чистейший английский язык!', 79);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (920, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Человек был одет в какую-то форму. За ним стояли еще трое; все они были заметно взволнованы - сияющие, измазанные с головы до ног.
   - Что вам угодно? - резко спросила миссис Ттт.
   - Вы -марсианка! -Человек улыбался. - Это слово вам, конечно, незнакомо. Так говорят у нас, на Земле. - Он кивнул на своих спутников. - Мы с Земли. Я - капитан Уильямс. Мы всего час назад сели на Марсе. Вот прибыли.Втораяэкспедиция! До нас была Первая экспедиция, но ее судьба нам не известна. Так или иначе, мы прилетели. И вы - первый житель Марса, которого мы встретили!
   - Марсианка? - Брови ее взметнулись.
   - Я хочу сказать, что вы живете на четвертой от Солнца планете. Точно?', 80);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (921, '2025-08-24 23:06:22.571376+03', 6, NULL, '- Элементарная истина, - фыркнула она, меряя их взглядом.
   - А мы, - он прижал к груди свою пухлую розовую руку, - мы с Земли. Верно, ребята?
   - Так точно, капитан! - откликнулся хор.
   - Это планета Тирр, - сказала она, - если вам угодно знать ее настоящее имя.
   - Тирр, Тирр. - Капитан устало рассмеялся. -Чудесноеназвание! Но скажите же, добрая женщина, как объяснить, что вы так великолепно говорите по-английски?
   - Я не говорю, - ответила она, - я думаю. Телепатия. Всего хорошего!
   И она хлопнула дверью.
   Мгновение спустя этот ужасный человек уже снова стучал.
   Она распахнула дверь.
   - Ну, что еще? - спросила она.
   Он стоял на том же месте и силился улыбнуться,', 81);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (922, '2025-08-24 23:06:22.571376+03', 6, NULL, 'но уже без прежней уверенности. Он протянул к ней руки.
   - Мне кажется, вы не совсемпоняли…
   - Чего? - отрезала она.
   Его глаза округлились от изумления.
   - Мы прилетели сЗемли!
   - Мне некогда, - сказала она. - У меня сегодня куча дел - обед, уборка, шитье, всякая всячина… Вам, вероятно, нужен мистер Ттт, так он наверху, в своем кабинете.
   - Да, да, - озадаченно произнес человек с Земли, моргая. - Ради бога, позовите мистера Ттт.
   - Он занят. - И она снова захлопнула дверь.
   На сей раз стук был уж совсем неприличным.
   - Знаете что! - вскричал человек, едва дверь распахнулась. Он ворвался в прихожую, словно решил взять неожиданностью. - Так не принимают гостей!', 82);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (923, '2025-08-24 23:06:22.571376+03', 6, NULL, '- Мой чистый пол! - возмутилась она. - Грязь! Убирайтесь прочь! Если хотите войти в мой дом, сперва почистите обувь.
   Человек испуганно посмотрел на свои грязные башмаки.
   - Сейчас не время придираться к пустякам, - решительно заявил он. - Такое событие! Его нужно отпраздновать!
   Он упорно глядел на нее, словно это могло заставить ее понять, чего они хотят.
   - Если мои хрустальные булочки перестояли в духовке, - закричала она, - то я вас поленом!..
   И она поспешила к маленькой, пышущей жаром печке. Потом вернулась - раскрасневшаяся, потная. Ярко-желтые глаза, смуглая кожа, худенькая и юркая, как насекомое… Резкий, металлический голос.
   - Обождите здесь. Я пойду посмотрю,', 83);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (924, '2025-08-24 23:06:22.571376+03', 6, NULL, 'может быть, и позволю вам на минутку зайти к мистеру Ттт. Какое там у вас дело к нему?
   Человек выругался так, словно она ударила его молотком по пальцу.
   - Скажите ему, что мы прилетели с Земли, что это впервые!
   - Что впервые? - Она подняла вверх смуглую руку. - Ладно, это неважно. Я сейчас.
   Звуки ее шагов прошелестели по переходам каменного дома.
   А снаружи было невероятно синее, жаркое марсианское небо - недвижное, будто глубокое теплое море. Над марсианской пустыней, словно над огромным кипящим котлом, струилось марево. На вершине пригорка неподалеку стоял, покосившись, небольшой космический корабль. От него к двери каменного дома протянулась цепочка крупных следов.', 84);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (925, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Сверху, со второго этажа, донеслись возбужденные голоса. Люди у двери поглядывали друг на друга, переминались с ноги на ногу, поправляли пояса. Наверху что-то прорычал мужской голос. Женский голос ответил. Через четверть часа земляне от нечего делать стали слоняться взад-вперед по кухне.
   - Закурим? - сказал один из них.
   Другой достал сигареты, они закурили. Они выдыхали неторопливые бледные струйки дыма. Разгладили складки курток, поправили воротнички. Голоса наверху продолжали гудеть и журчать. Командир глянул на свои часы.
   - Двадцать пять минут, - заметил он. - Что у них там происходит?
   Он подошел к окну и выглянул наружу.
   - Жаркий денек, - сказал один из космонавтов.', 85);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (926, '2025-08-24 23:06:22.571376+03', 6, NULL, '- Да уж, - лениво протянул другой, разморенный полуденным зноем.
   Гул голосов наверху сменился глухим бормотанием, потом и вовсе стих. Во всем доме - ни звука. Только собственное дыхание слышно.
   Целый час прошел в безмолвии.
   - Уж не случилось ли из-за нас какой беды? - произнес командир, подходя к двери гостиной и заглядывая туда.
   Мисс Ттт стояла посреди комнаты, поливая цветы.
   - А я все думаю, что я такое забыла… - сказала она, заметив капитана. Она вышла на кухню. - Извините. - Она протянула ему клочок бумаги. - Мистер Ттт слишком занят. - Она повернулась к своим кастрюлям. - Да и все равно вам нужен не он, а мистер Ааа.', 86);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (927, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Пойдите с этой запиской на соседнюю усадьбу возле голубого канала, там мистер Ааа расскажет вам все, что вы хотите знать.
   - Нам ничего не надо узнавать, - возразил командир, надув толстые губы.
   - Мы и так уже знаем.
   - Вы получили записку, что еще вам надо? - резко спросила она. Больше они ничего не могли от нее добиться.
   - Ладно, - сказал командир. Ему все еще не хотелось уходить. Он стоял с таким видом, будто чего-то ждал. Точно ребенок, глядящий на голую рождественскую елку. - Ладно, - повторил он. - Пошли, ребята.
   И все четверо вышли из дома в душное безмолвие летнего дня.

   Полчаса спустя мистер Ааа, который восседал в своей библиотеке,', 87);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (928, '2025-08-24 23:06:22.571376+03', 6, NULL, 'прихлебывая электрическое пламя из металлической чаши, услышал голоса снаружи, на мощеной дорожке.Он высунулся из окна и уставился на четверку одетых в одинаковую форму людей, которые, щурясь, глядели на него.
   - Вы мистер Ааа? - справились они.
   - Я.
   - Нас послал к вам мистер Ттт! - крикнул командир.
   - Что за причина? - спросил мистер Ааа.
   - Он был занят!
   - Ну, знаете, это… - презрительно произнес мистер Ааа. - Уж не думает ли он, что мне больше нечего делать, как развлекать людей, которыми ему некогда заниматься?
   - Сейчас это несущественно, сэр! - крикнул командир.
   - Для меня - существенно. У меня накопилась куча книг, их нужно прочесть.', 88);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (929, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Мистер Ттт совсем не считается с другими. Он не впервые ведет себя так бесцеремонно по отношению ко мне. И прошу не размахивать руками, сударь, дайте мне кончить. Вам следует быть повнимательнее. Я привык к тому, что люди слушают, когда я говорю. И потрудитесьвыслушать меня с должным почтением, иначе я вообще не стану с вами разговаривать.
   Четверо людей внизу растерянно топтались, разинув рты. У капитана на лбу вздулись жилы и даже блеснули слезы на глазах.
   - Ну, так вот, - продолжал поучать мистер Ааа, - как, по-вашему, хорошо ли со стороны мистера Ттт вести себя так неучтиво?
   Четверка недоуменно смотрела на него сквозь дымку знойного дня. Капитан не стерпел:', 89);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (930, '2025-08-24 23:06:22.571376+03', 6, NULL, '- Мы прилетели с Земли!
   - По-моему, он ведет себя просто не по-джентельменски, - брюзжал мистер Ааа.
   - Космический корабль. Мы прилетели на ракете. Вот она!
   - И ведь он не в первый раз позволяет себе такое безобразие.
   - Понимаете - с Земли!
   - Он у меня дождется, я позвоню и отчитаю его, да-да.
   - Мы четверо - я и вот эти трое - экипаж моего корабля.
   - Вот возьму и позвоню сейчас же!
   - Земля. Ракета. Люди. Полет. Космос.
   - Позвоню и всыплю ему как следует! - крикнул мистер Ааа и пропал из окна, точно кукла в театре.
   Было слышно, как по какому-то неведомому аппарату завязалась перебранка. Капитан и его команда стояли во дворе,', 90);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (931, '2025-08-24 23:06:22.571376+03', 6, NULL, 'тоскливо поглядывая на свою красавицу ракету - такую изящную, стройную и родную.
   Мистер Ааа вынырнул в окошке, торжествуя:
   - Я его на дуэль вызвал, клянусь честью! Слышите - дуэль!
   - Мистер Ааа, - терпеливо начал капитан.
   - Застрелю его насмерть, так и знайте!
   - Мистер Ааа, прошу вас, выслушайте меня. Мы пролетели шестьдесят миллионов миль.
   Мистер Ааа впервые обратил внимание на капитана.
   - Постойте, как вы сказали - откуда вы?
   Лицо капитана осветилось белозубой улыбкой. Он шепнул своим: - Наконец-то,теперьвсе в порядке! - И громко мистеру Ааа: - Шестьдесят миллионов миль - с планеты Земля!
   Мистер Ааа зевнул.
   - В это время года - от силы пятьдесят миллионов,', 91);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (932, '2025-08-24 23:06:22.571376+03', 6, NULL, 'не больше. - Он взял в руки какое-то угрожающего вида оружие. - Ну мне пора. Заберите свою дурацкую записку, хотя я не понимаю, какой вам от нее прок, и ступайте через вон тот бугор в городок, он называется Иопр, там изложите все мистеру Иии. Он именно тот человек, который вам нужен. А немистер Ттт, этот кретин, - уж я позабочусь о том, чтобы его прикончить. И не я - это не по моей линии.
   - Линии, линии! - передразнил его командир. - При чем тут линия, когда надо принять людей с Земли?
   - Не говорите глупостей, это всем известно! - Мистер Ааа сбежал по лестнице. - Всего хорошего!
   И он помчался по дорожке, точно взбесившийся кронциркуль.
   Космонавты были совершенно ошарашены.', 92);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (933, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Наконец капитан сказал:
   - Нет, мы все-таки найдем кого-нибудь, кто нас выслушает.
   - Что, если уйти, а потом вернуться, - уныло произнес один из его товарищей. - Взлететь и снова сесть. Чтобы дать им время очухаться и подготовить встречу.
   - Может быть, так и сделаем, - буркнул измученный капитан.

   Городок бурлил. Марсиане входили и выходили из домов, они приветствовали друг друга, на них были маски - золотые, голубые, розовые, ради приятного разнообразия, маски с серебряными губами и бронзовыми бровями, маски улыбающиеся и маски хмурящиеся, сообразно нраву владельца.
   Земляне, все в испарине после долгого перехода, остановились и спросили маленькую девочку,', 93);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (934, '2025-08-24 23:06:22.571376+03', 6, NULL, 'где живет мистер Иии.
   - Вон там, - кивком указала девочка.
   Капитан нетерпеливо, осторожно опустился на одно колено и заглянул в ее милое детское личико.
   - Послушай, девочка, что я тебе расскажу.
   Он посадил ее себе на колено и ласково сжал своими широкими ладонями ее смуглые ручонки, словно приготовился рассказать ей сказку на ночь, сказку, которую складывают в уме не торопясь, с множеством обстоятельных и счастливых подробностей.
   - Понимаешь, малютка, с полгода тому назад на Марс прилетала другая ракета. В ней был человек по имени Йорк со своим помощником. Мы не знаем, что с ними случилось. Быть может, они разбились. Они прилетели на ракете. И мы, мы тоже прилетели на ракете.', 94);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (935, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Вот бы ты на нее посмотрела! Большая-пребольшая ракета! Так что мы -Втораяэкспедиция, а перед нами была Первая. Мы долго летели, с самой Земли…
   Девочка бездумно высвободила одну руку и опустила на лицо золотую маску, выражающую безразличие. Потом достала игрушечного золотого паука и уронила его на землю, а капитан все твердил свое. Игрушечный паук послушно вскарабкался ей на колени, она же безучастно наблюдала за ним сквозь щелочки равнодушной маски: капитан ласково встряхнул ее и продолжал втолковывать ей свою историю.
   - Мы - земляне, - говорил он. - Ты мне веришь?
   - Да. - Девчурка искоса глядела, что чертят в пыли пальчики ее ног.
   - Ну вот и умница.', 95);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (936, '2025-08-24 23:06:22.571376+03', 6, NULL, '- Командир наполовину добродушно, наполовину злобно ущипнул ее за руку, чтобы заставить девочку глядеть на него. - Мы построили себе ракету. Тыверишь?
   Девочка сунула в нос палец.
   - Ага.
   - И… нет-нет, дружок, вынь пальчик из носа… и я, командир космического корабля, и…
   - Еще никогда в истории никто не выходил в космос на такой большой ракете, - продекламировала крошка, зажмурив глазки.
   - Восхитительно! Как ты угадала?
   - Телепатия. - Она небрежно вытерла пальчик о колечку.
   - Ну? Неужели это тебе ничуть не интересно? - вскричал командир. - Разве тынерада?
   - Вы бы лучше пошли поскорее к мистеру Иии. - Она уронила игрушку на землю. - Он охотно поговорит с вами.', 96);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (937, '2025-08-24 23:06:22.571376+03', 6, NULL, 'И она убежала, сопровождаемая по пятам игрушечным пауком.
   Командир сидел на корточках, протянув руку к девочке и глядя ей вслед. Он почувствовал, как на глаза навертываются слезы. Посмотрел на свои пустые руки, беспомощно открыв рот. Товарищи стояли рядом, глядя на собственные тени. Они сплюнули на камни мостовой…

   Мистер Иии сам отворил дверь. Он торопился на лекцию, но готов был уделить им минуту, если они побыстрее войдут и скажут, что им надо…
   - Немного внимания, - сказал капитан, устало поднимая опухшие веки. - Мы - с Земли, у нас тут ракета, нас четверо - три космонавта и командир, мы совершенно вымотались, хотим есть, нам бы найти где поспать.', 97);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (938, '2025-08-24 23:06:22.571376+03', 6, NULL, 'И пусть кто-нибудь вручит нам ключи от города или что-нибудь в этом роде, пусть нам пожмут руки, крикнут «ура», скажут: «Поздравляем, старики!» Вот, пожалуй, и все.
   Мистер Иии был долговязый ипохондрик, желтоватые глаза спрятаны за толстыми синими кристаллами очков. Наклонившись над письменным столом, он задумчиво перелистывал какие-то бумаги, то и дело пронизывая своих гостей пытливым взглядом.
   - Боюсь, у меня нет здесь бланков. - Он перерыл все ящики стола. - Куда я их задевал? - Он нахмурился. - Где-то… где-то здесь… А, вот они! Прошу вас! - Он решительно протянул капитану бумаги. - Вам придется это подписать.
   - Читать всю эту белиберду?', 98);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (939, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Толстые стекла очков воззрились на капитана.
   - Но вы ведь сами сказали, что вы с Земли? В таком случае вам остается только подписать.
   Капитан поставил свою подпись.
   - Команда тоже должна подписаться?
   Мистер Иии поглядел на него, поглядел на трех остальных и разразился издевательским смехом.
   - Имтоже подписаться?! Ха-ха-ха! Это великолепно! Они… они… - У него катились слезы по щекам. Он хлопнул себя рукой по колену и согнулся, давясь смехом, рвущимся из широко разинутого рта. Он уцепился за стол. -Им -подписаться!..
   Космонавты нахмурились.
   - Что тут смешного?
   - Им подписаться! - выдохнул мистер Иии, обессиленный хохотом. - Еще бы не смешно!', 99);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (940, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Я обязательно расскажу об этом мистеру Ыыы! - Он поглядел на подписанные бланки, продолжая смеяться. - Как будто все в порядке. - Он кивнул. - Даже согласие на эвтаназию, если в конечном счете это окажется необходимым. - Он рассыпался мелким смешком.
   - Согласие начто?
   - Ладно, хватит. У меня для вас кое-что есть. Вот. Возьмите этот ключ.
   Капитан вспыхнул.
   - О, это великая честь.
   - Это не от города, болван! - рявкнул мистер Иии. - Ключ от Дома. Ступайте по коридору, отоприте большую дверь, войдите и хорошенько захлопните за собой. Можете там переночевать. А утром я пришлю к вам мистера Ыыы.
   Капитан нерешительно взял ключ. Он стоял понурившись.', 100);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (941, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Его товарищи не двигались с места. Казалось, из них выкачали всю их кровь, всю ракетную лихорадку. Они совершенно выдохлись.
   - Ну, что еще? В чем дело? - спросил мистер Иии. - Чего вы ждете? Чего хотите? - Он подошел вплотную к капитану и, наклонив голову, снизу заглянул ему в лицо. - Выкладывайте!
   - Боюсь, вы даже не в состоянии… - начал капитан. - То есть я хочу сказать… попытаться, подумать о том… - Он замялся. - Мы немало потрудились, такой путь проделали, может быть, стоит, ну, что ли, пожать нам руки и сказать… ну, хотя бы: «Молодцы?» - Он смолк.
   Мистер Иии небрежно сунул ему руку.
   - Поздравляю! - Его губы растянулись в холодной улыбке. - Поздравляю. - Он отвернулся.', 101);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (942, '2025-08-24 23:06:22.571376+03', 6, NULL, '- А теперь мне пора. Не забудьте про ключ.
   И, не обращая на них больше никакого внимания, словно они растаяли, мистер Иии заходил по комнате, набивая какими-то бумагами маленький портфель. Это длилось не меньше пяти минут, и все это время он ни разу больше не обратился к четверке угрюмых людей, которые стояли на подкашивающихся от усталости ногах, понурив головы, с потухшими глазами.
   Выходя, мистер Иии сосредоточенно разглядывал свои ногти…

   В тусклом предвечернем свете они побрели по коридору. Они оказались перед большой блестящей серебристой дверью и отперли ее серебряным ключом. Воняли, захлопнули дверь и осмотрелись кругом.
   Они были в просторном, залитом солнцем зале.', 102);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (943, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Мужчины и женщины сидели за столами, стояли кучками разговаривали. Щелчок замка заставил их обернуться, и все воззрились на четверых людей, одетых в форму.
   Один марсианин подошел к ним и поклонился.
   - Я мистер Ууу, - представился он.
   - А я - капитан Джонатан Уильямс из Нью-Йорка, с Земли, - ответил капитан без всякого энтузиазма.
   Мгновенно зал точно взорвался!
   Потолок задрожал от криков и возгласов. Марсиане, размахивая руками, восторженно крича, опрокидывая столы, толкая друг друга, со всех концов зала кинулись к землянам, стиснули их в объятиях, подняли всю четверку на руки. Шесть раз они пронесли их на плечах вокруг всего зала,', 103);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (944, '2025-08-24 23:06:22.571376+03', 6, NULL, 'шесть раз бегом совершили ликующий круг почета, прыгая, приплясывая, громко распевая.
   Земляне до того опешили, что целую минуту молча ехали верхом на качающихся плечах, прежде чем начали смеяться и кричать друг другу:
   - Вот это да! Совсемдругоедело!
   - Здорово! Сразу бы так! Э-гей! Ух ты! Э-э-э-эх!
   Они торжествующе подмигивали друг другу, они вскинули руки, хлопая в ладоши.
   - Э-гей!!!
   - Ура! - вопила толпа.
   Марсиане поставили землян на стол. Крики смолкли. Капитан чуть не разрыдался.
   - Спасибо вам, большое спасибо. Это замечательно…
   - Расскажите о себе, - предложил мистер Ууу.
   Капитан откашлялся.
   Слушатели восторженно охали и ахали.', 104);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (945, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Капитан представил своих товарищей, каждый из них произнес коротенькую речь, смущенно принимая громовые овации.
   Мистер Ууу похлопал капитана по плечу.
   - Приятно встретить здесь земляка! Я ведь тоже с Земли.
   - То есть как это?
   - А вот так. Нас тут много с Земли.
   - Вы? С Земли? - Капитан вытаращил глаза. - Не может этого быть! Вы что, тоже прилетели на ракете? В каком же веке начались космические полеты? - В его голосе было разочарование. - Да вы откуда, из какой страны?
   - Туиэреол. Я перенесся сюда силой духа, много лет назад.
   - Туиэреол… - медленно выговорил капитан. - Не знаю такой страны. И что это за сила духа…
   - Вот мисс Ррр, она тоже с Земли.Верно,мисс Ррр?', 105);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (946, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Мисс Ррр кивнула и как-то странно усмехнулась.
   - И мистер Ююю, и мистер Щщщ, и мистер Ввв!
   - А я с Юпитера, - представился один мужчина, приосанившись.
   - А я с Сатурна, - ввернул другой, хитро поблескивая глазами.
   - Юпитер, Сатурн… - бормотал капитан, моргая.
   Стало очень тихо. Марсиане толпились вокруг космонавтов, сидели за столами, но столы были пустые, банкетом тут и не пахло. Желтые глаза горели, ниже скул залегли глубокие тени. Только тут капитан заметил, что в зале нет окон, свет словно проникал через стены. И только одна дверь. Капитан нахмурился.
   - Чепуха какая-то. Где находится Туиэреол? Далеко от Америки?
   - Что такое - Америка?', 106);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (947, '2025-08-24 23:06:22.571376+03', 6, NULL, '- Вы не слышали про Америку?! Говорите, что сами с Земли, а не знаете Америки!
   Мистер Ууу сердито вздернул голову.
   - Земля - сплошные моря, одни моря, больше ничего. Там нет суши. Я сам оттуда, уж я-то знаю.
   - Постойте, - капитан отступил на шаг, - да вы же самый настоящий марсианин! Желтые глаза. Смуглая кожа…
   - Земля сплошь покрытаджунглями, -гордо произнесла мисс Ррр. - Я из Орри, страны серебряной культуры!
   Капитан переводил взгляд с одного лица на другое, с мистера Ууу на мистера Ююю, с мистера Ююю на мистера Ззз, с мистера Ззз на мистера Ннн, мистера Ххх, мистера Ббб. Он видел, как расширяются и сужаются зрачки их желтых глаз, как их взгляд становится то пристальным,', 107);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (948, '2025-08-24 23:06:22.571376+03', 6, NULL, 'то туманным. Его охватила дрожь. Наконец он повернулся к своим подчиненным и мрачно сказал:
   - Вы поняли, что это такое?
   - Что, капитан?
   - Это вовсе не торжественная встреча, - устало произнес он. - И не импровизированный прием. И не банкет. И мы здесь не почетные гости. А они не представители марсианских властей. Посмотрите на их глаза. Прислушайтесь к их речам!
   Космонавты затаили дыхание. Поблескивая белками, они медленно обозревали странный зал.
   - Теперь я понимаю, - голос капитана доносился словно издалека. - Понимаю, почему все давали нам новые адреса и отсылали к кому-нибудь другому, пока мы не встретили мистера Иии… Ну, а уж он дал точный адрес и даже ключ,', 108);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (949, '2025-08-24 23:06:22.571376+03', 6, NULL, 'чтобы мы отперли дверь и захлопнули ее. Вот мы и попали…
   - Куда мы попали, командир?
   Плечи капитана поникли.
   - В сумасшедший дом.
   Наступила ночь. Тишина царила в просторном зале, озаренном тусклым сиянием светильников, скрытых в прозрачных стенах. Четверо землян сидели вокруг деревянного стола и перешептывались, сдвинув уныло поникшие головы. На полу вперемежку спали мужчины и женщины. В темных углах что-то копошилось, одинокие фигуры странно взмахивали руками. Каждые полчаса кто-нибудь из космонавтов подходил к серебристой двери и возвращался к столу.
   - Бесполезно, капитан. Мы заперты надежно.
   - Капитан, неужели нас приняли за сумасшедших?
   - Конечно.', 109);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (950, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Вот почему наше появление не вызвало бурных восторгов. Мы для них просто-напросто психически больные, каких здесь много. - Он показал на фигуры спящих. - Это же параноики, все до одного! Но как они нас встретили! Мне даже на минуту показалось, - в его глазах вспыхнул огонек и тут же потух, - что наконец- то мы дождались торжественной встречи. Эти возгласы, пение, речи… Ведь здорово было, а?…
   - Сколько нас продержат здесь, командир?
   - Пока мы не докажем, что мы не психи.
   - Ну, это просто.
   - Надеюсь,что так…
   - Вы, кажется, не очень в этом уверены, капитан?
   - М-да… Поглядите вон в тот угол.
   Во мраке сидел на корточках мужчина. Из его рта вырвалось голубое пламя,', 110);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (951, '2025-08-24 23:06:22.571376+03', 6, NULL, 'которое приняло форму маленькой нагой женщины. Она плавно парила в воздухе, в дымке кобальтового света, что-то шепча и вздыхая.
   Капитан мотнул головой в другую сторону. Там стояла женщина, с которой происходили удивительные превращения. Сперва она оказалась заключенной внутри хрустальной колонны, потом стала золотой статуей, потом - кедровым посохом и наконец обрела свой первоначальный вид.
   Повсюду в полуночном зале мужчины и женщины манипулировали тонкими языками фиолетового пламени, непрерывно превращаясь и изменяясь, ибо ночь - пора тоски и метаморфоз.
   - Колдовство, черная магия, - прошептал один из землян.
   - Нет, галлюцинации. Они передают нам свой бред,', 111);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (952, '2025-08-24 23:06:22.571376+03', 6, NULL, 'так что мы видим их галлюцинации. Телепатия. Самовнушение и телепатия.
   - Это вас и тревожит, капитан?
   - Да. Если галлюцинации кажутся нам - и не только нам всем - такими реальными, если галлюцинации так убедительны и правдоподобны, неудивительно, что нас приняли за психопатов. Тот мужчина может делать маленьких женщин из голубого пламени, а вон эта женщина способна превращаться в статую; вполне естественно для нормального марсианина решить, что ракетный корабль - плоднашейбольной фантазии.
   Из темноты донесся вздох отчаяния.
   Кругом, то вспыхивая, то исчезая, плясали голубые огоньки. Изо рта спящих мужчин вылетали чертики из красного песка. Женщины превращались в лоснящихся змей.', 112);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (953, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Пахло зверьем и рептилиями.
   Когда настало утро, все казались нормальными, веселыми и здоровыми. Никаких бесов, никакого пламени. Капитан со своей командой стоял у серебристой двери в надежде, что она откроется.
   Мистер Ыыы появился часа через четыре. Они подозревали, что он не меньше трех часов простоял за дверью изучая их, прежде чем войти, подозвать их к себе и провести в свой маленький кабинет.
   Это был добродушный улыбающийся мужчина, если верить его маске, на которой была изображена не одна, а три разные улыбки. Впрочем, голос, звучавший из-под маски, явно принадлежал не столь уж улыбчивому психиатру.
   - Ну, что вас беспокоит?
   - Вы считаете нас сумасшедшими, но это не так,', 113);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (954, '2025-08-24 23:06:22.571376+03', 6, NULL, '- сказал капитан.
   - Напротив, я вовсе не считаю всех вас сумасшедшими. - Психиатр направил на капитана маленькую указку. - Только вас, уважаемый. Все остальные - вторичные галлюцинации.
   Капитан хлопнул себя по колену.
   - Так вот в чем дело! Вот почему мистер Иии расхохотался, когда я спросил, надо ли моим товарищам тоже подписать бланки!
   - Да, мистер Иии рассказал мне об этом, - Психиатр хохотнул сквозь извилистую прорезь рта в маске. - Отличная шутка. Так о чем я говорил? Да, вторичные галлюцинации. Ко мне приходят женщины, у которых из ушей лезут змеи. После моего лечения змеи исчезают.
   - Мы с радостью подвергнемся лечению. Приступайте.
   Мистер Ыыы был озадачен.', 114);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (955, '2025-08-24 23:06:22.571376+03', 6, NULL, '- Поразительно. Мало кто соглашается на лечение. Дело в том, что оно весьма радикально.
   - Ничего, валяйте, лечите! Вы сами убедитесь, что мы все здоровы.
   - Разрешите сперва посмотреть ваши бумаги, все ли оформлено для лечения. - Он полистал папку - Так… Видите ли, случаи, подобные вашему, требуют особых методов. У тех, кого вы видели в Доме, более легкая форма… Но когда дело заходит так далеко, как у вас, - с первичными, вторичными, слуховыми, обонятельными и вкусовыми галлюцинациями в сочетании с мнимыми осязательными и оптическими восприятиями, - то, будем говорить начистоту, дело обстоит плохо. Мы вынуждены прибегнуть к эвтаназии.
   Капитан с ревом вскочил на ноги.
   - Ну,', 115);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (956, '2025-08-24 23:06:22.571376+03', 6, NULL, 'вот что, хватит нам голову морочить! Начинайте - обследуйте нас, стучите молотком по колену, выслушайте сердце, заставьте приседать, задавайте вопросы!
   - Говорите на здоровье.
   Капитан говорил с жаром целый час. Психиатр слушал.
   - Невероятно, - задумчиво пробормотал он. - В жизни не слыхал такого детализированного фантастического бреда.
   - Черт возьми, мы покажем вам наш космический корабль! - взревел капитан.
   - С удовольствием посмотрю. Вы можете показать его здесь, в этой комнате?
   - Конечно. Он - в вашей картотеке, на букву «К». Мистер Ыыы внимательно посмотрел картотеку, разочарованно щелкнул языком и неторопливо закрыл ящик.', 116);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (957, '2025-08-24 23:06:22.571376+03', 6, NULL, '- Зачем вам понадобилось сбивать меня с толку? Тут нет никакого космического корабля.
   - Разумеется, нет, кретин! Я пошутил. А теперь скажите: сумасшедшие острят?
   - Иногда встречаются довольно необычные проявления юмора. Ладно, ведите меня к своей ракете. Я хочу посмотреть на нее.

   Был жаркий полдень, когда они пришли к ракете.
   - Та-ак. - Психиатр подошел к кораблю и постучал по корпусу. Звон был мягкий, густой. - Можно войти внутрь? - спросил он с хитрецой.
   - Входите.
   Мистер Ыыы вошел в корабль - и застрял там.
   - Всякое бывало в моей грешной жизни, но такого… - Капитан ждал, жуя сигару. - Больше всего на свете мне хочется улететь домой и сказать там,', 117);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (958, '2025-08-24 23:06:22.571376+03', 6, NULL, 'чтобы больше не связывались с этим Марсом. Более подозрительных пентюхов…
   - Сдается мне, командир, здесь вообще каждый второй - ненормальный. Немудрено, что они такие недоверчивые.
   - Все равно, мне это осточертело!
   Полчаса психиатр копался, щупал, выстукивал, слушал, нюхал, пробовал на вкус, наконец он вышел из корабля.
   - Ну,теперь-товы убедились! - крикнул капитан, словно глухой.
   Психиатр закрыл глаза и почесал нос.
   - Это самый поразительный пример мнимого восприятия и гипнотического внушения, с каким я когда-либо сталкивался. Я осмотрел вашу так называемую «ракету». - Он постучал пальцем по корпусу. - Я ее слышу - слуховая иллюзия. - Он втянул носом воздух.', 118);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (959, '2025-08-24 23:06:22.571376+03', 6, NULL, '- Я ее обоняю. Обонятельная галлюцинация, наведенная телепатической передачей чувств.- Он поцеловал обшивку ракеты. - Я ощущаю ее вкус: вкусовая иллюзия!
   Он пожал руку капитана.
   - Разрешите поздравить вас? Вы психопатический гений! Это-это просто верх совершенства! Ваша способность телепатическим путем проецировать свои психопатические фантазии на сознание других субъектов при полной сохранности силы восприятия поразительна, невероятна. Остальные наши пациенты обычно концентрируются на зрительных галлюцинациях, в лучшем случае в сочетании со слуховыми. Вы же справляетесь со всем комплексом! Ваше безумие совершенно до изумления!
   - Мое безумие… - Капитан побледнел.
   - Да, да,', 119);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (960, '2025-08-24 23:06:22.571376+03', 6, NULL, 'великолепное безумие! Металл, резина, гравиаторы, пища, одежда, горючее, оружие, трапы, гайки, болты, ложки - я проверил множество предметов. В жизни не видел такой сложной картины. Даже тени под койками - подо всем! Такая концентрация воли! И все - все, сколько я ни проверял, можно пощупать, понюхать, послушать, попробовать на вкус! Позвольте мне вас обнять!
   Наконец он оторвался от Капитана.
   - Я напишу об этом монографию; она будет лучшей моей работой! В следующем месяце прочту доклад в Марсианской Академии наук! Одна ваша внешность чего стоит! Вы ухитрились изменить даже цвет глаз - вместо желтого голубой, и кожа у вас не смуглая, а розовая! А этот костюм,', 120);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (961, '2025-08-24 23:06:22.571376+03', 6, NULL, 'и пять пальцев на руках вместо шести! Подумать только, полная биологическая метаморфоза под влиянием отклонений в психике! Да еще ваши три приятеля…
   Он достал маленький пистолет.
   - Вы, конечно, неизлечимы. Несчастный вы, удивительный человек! Только смерть принесет вам избавление. Хотите сказать что-нибудь напоследок?
   - Стойте, бога ради! Не стреляйте!
   - Бедняга! Я исцелю вас от страданий, которые заставили вас вообразить эту ракету и этих троих людей. Захватывающее будет зрелище: я убиваю вас, и мгновенно исчезаюти ваши друзья, и ваша ракета. Ах, какую статеечку я напишу по сегодняшним наблюдениям - «Распад невротических иллюзий»!
   - Я с Земли! Меня зовут Джонатан Уильямс,', 121);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (962, '2025-08-24 23:06:22.571376+03', 6, NULL, 'а эти…
   - Знаю, знаю, - ласково сказал мистер Ыыы и выстрелил.
   Капитан упал с пулей в сердце. Его товарищи закричали.
   Мистер Ыыы вытаращил глаза.
   - Вы продолжаете существовать? Это бесподобно! Галлюцинации с персистенцией во времени и пространстве! - Он направил на них пистолет. - Ничего, я вас заставлю исчезнуть.
   - Нет! - крикнули космонавты.
   - Слуховая иллюзия даже после смерти больного, - деловито отметил мистер Ыыы, убивая одного за другим всех троих.
   Они неподвижно лежали на песке, нисколько не изменившись.
   Он толкнул их ногой. Потом постучал по корпусу ракеты.
   - Онане пропала!Онине исчезли! - Он снова и снова стрелял в безжизненные тела. Потом отступил назад.', 122);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (963, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Маска с застывшей улыбкой упала ему под ноги.
   Выражение лица психиатра медленно изменялось. Нижняя челюсть отвисла. Пистолет выпал из ослабевшей руки. Взгляд его стал пустым, отсутствующим. Он вскинул руки вверх и повернулся кругом, точно слепой. Он щупал мертвые тела, то и дело сглатывая слюну.
   - Галлюцинации, - лихорадочно бормотал он. - Вкус. Зрительные образы. Запах. Звук. Ощущение.
   Он махал руками, выпучив глаза. На губах выступила пена.
   - Сгиньте! - завопил мистер Ыыы, обращаясь к убитым. - Сгинь! - крикнул он ракете.
   Он посмотрел на свои дрожащие руки.
   - Заразился, - прошептал он в отчаянии. - Перешло комне.Телепатия. Гипноз. Теперь и я безумен.', 123);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (964, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Все виды мнимых восприятии. - На секунду он замер, потом стал непослушными пальцами искать пистолет. - Осталось только одно средство. Единственный способ заставить их сгинуть, исчезнуть.
   Раздался выстрел Мистер Ыыы упал.
   Под лучами солнца лежали четыре тела. Тут же рядом лежал мистер Ыыы.
   Ракета стояла, покосившись, на залитом солнцем пригорке, никуда не исчезая.
   Когда на закате горожане нашли ракету, они долго ломали себе голову, что это такое. Никто не отгадал. Ракету продали старьевщику, который увез ее и разобрал на утиль.
   Всю ночь напролет шел дождь. На следующий день было ясно и тепло.
   Март 2000

   Налогоплательщик
   Он хотел улететь с ракетой на Марс.', 124);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (965, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Рано утром он пришел к космодрому и стал кричать через проволочное ограждение людям в мундирах, что хочет на Марс. Он исправно платит налоги, его фамилия Причард, и он имеет полное право лететь на Марс. Разве он родился не здесь, не в Огайо? Разве он плохой гражданин? Так в чем же дело, почему ему нельзя лететь на Марс? Потрясая кулаками, он крикнул им, что не хочет оставаться на Земле: любой здравомыслящий человек мечтает унести ноги с Земли. Не позже чем через два года на Земле разразится атомная мировая война, и он вовсе не намерен дожидаться, когда это произойдет. Он и тысячи других, у кого есть голова на плечах, хотят на Марс. Спросите их сами! Подальше от войн и цензуры,', 125);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (966, '2025-08-24 23:06:22.571376+03', 6, NULL, 'от бюрократии и воинской повинности, от правительства, которое не дает шагу шагнуть без разрешения, подмяло под себя и науку и искусство! Можете оставаться на Земле, если хотите! Он готов отдать свою правую руку, сердце, голову, только бы улететь на Марс! Что надо сделать, где расписаться, с кем знакомство завести, чтобы попасть на ракету?
   Они только смеялись в ответ из-за проволочного забора. И вовсе ему не хочется на Марс, говорили они. Разве он не знает, что Первая и Вторая экспедиции пропали, канулив небытие, что их участники, вернее всего, погибли?
   Но это еще надо доказать, никто не знает этоготочно,кричал он, вцепившись в проволоку. А может быть,', 126);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (967, '2025-08-24 23:06:22.571376+03', 6, NULL, 'там молочные реки и кисельные берега, может быть, капитан Йорк и капитан Уильямс просто не желают возвращаться. Ну так как - откроют ему ворота, пустят в ракету Третьей экспедиции, или ему придется вламываться силой?
   Они посоветовали ему заткнуться.
   Он увидел, как космонавты идут к ракете.
   - Подождите меня! - закричал он - Не оставляйте меня в этом ужасном мире, я хочу улететь отсюда, скоро начнется атомная война! Не оставляйте меня на Земле!
   Они силой оттащили его от ограды. Они захлопнули дверцу полицейской машины и увезли его в этот утренний час, а он прильнул к заднему окошку и за мгновение перед тем,как в облаке сиренного воя машина перемахнула через бугор,', 127);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (968, '2025-08-24 23:06:22.571376+03', 6, NULL, 'увидел багровое пламя, и услышал могучий гул, и ощутил мощное сотрясение - это серебристая ракета взмыла ввысь, оставив его на ничем не примечательной планете Земля в это ничем не примечательное утро заурядного понедельника.
   Апрель 2000

   Третья экспедиция
   Корабль пришел из космоса. Позади остались звезды, умопомрачительные скорости, сверкающее движение и немые космические бездны. Корабль был новый; в нем жило пламя,в его металлических ячейках сидели люди; в строгом беззвучии летел он, дыша теплом, извергая огонь. Семнадцать человек было в его отсеках, включая командира. Толпа на космодроме в Огайо кричала, махала руками, подняв их к солнцу,', 128);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (969, '2025-08-24 23:06:22.571376+03', 6, NULL, 'и ракета расцвела гигантскими лепестками многокрасочного пламени и устремилась в космос - началасьТретья экспедиция на Марс!
   Теперь корабль с железной точностью тормозил в верхних слоях марсианской атмосферы. Он был по-прежнему воплощением красоты и мощи. Сквозь черные пучины космоса онскользил, подобно призрачному морскому чудовищу; он промчался мимо старушки Луны и ринулся в пустоты, пронзая их одну за другой. Людей в его чреве бросало, швыряло, колотило, все они по очереди переболели. Один из них умер, зато теперь оставшиеся шестнадцать, прильнув к толстым стеклам иллюминаторов, расширенными глазами глядели, как внизу под ними стремительно вращается и вырастает Марс.
   - Марс!', 129);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (970, '2025-08-24 23:06:22.571376+03', 6, NULL, '- воскликнул штурман Люстиг.
   - Старина Марс! - сказал Сэмюэль Хинкстон, археолог.
   - Добро, - произнес капитан Джон Блэк.
   Ракета села на зеленой полянке. Чуть поодаль на той же полянке стоял олень, отлитый из чугуна. Еще дальше дремал на солнце высокий коричневый дом в викторианском стиле, с множеством всевозможных завитушек, с голубыми, розовыми, желтыми, зелеными стеклами в окнах. На террасе росла косматая герань и висели на крючках, покачиваясьвзад-вперед, взад-вперед от легкого ветерка, старые качели. Башенка с ромбическими хрустальными стеклами и конической крышей венчала дом. Через широкое окно в первом этаже можно было разглядеть пюпитр с нотами под заглавием:', 130);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (971, '2025-08-24 23:06:22.571376+03', 6, NULL, '« Прекрасный Огайо ».
   Вокруг ракеты на все стороны раскинулся городок, зеленый и недвижный в сиянии марсианской весны. Стояли дома, белые и из красного кирпича, стояли, клонясь от ветра, высокие клены, и могучие вязы, и каштаны. Стояли колокольни с безмолвными золотистыми колоколами.
   Все это космонавты увидели в иллюминаторы. Потом они посмотрели друг на друга. И снова выглянули в иллюминаторы. И каждый ухватился за локоть соседа с таким видом, точно им вдруг стало трудно дышать. Лица их побледнели.
   - Черт меня побери, - прошептал Люстиг, потирая лицо онемевшими пальцами. - Чтоб мне провалиться!
   - Этого просто не может быть, - сказал Самюэль Хинкстон.
   - Господи,', 131);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (972, '2025-08-24 23:06:22.571376+03', 6, NULL, '- произнес командир Джон Блэк.
   Химик доложил из своей рубки:
   - Капитан, атмосфера разреженная. Но кислорода достаточно. Опасности никакой.
   - Значит, выходим? - спросил Люстиг.
   - Отставить, - сказал капитан Джон Блэк - Надо еще разобраться, что это такое.
   - Это? Маленький городок, капитан, воздух хоть и разреженный, но дышать можно.
   - Маленький городок, похожий на земные города, - добавил археолог Хинкстон. - Невообразимо. Этого просто не может быть, и все же вот он, перед нами…
   Капитан Джон Блэк рассеянно глянул на него.
   - Как по-вашему, Хинкстон, может цивилизация на двух различных планетах развиваться одинаковыми темпами и в одном направлении?
   - По-моему,', 132);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (973, '2025-08-24 23:06:22.571376+03', 6, NULL, 'это маловероятно, капитан.
   Капитан Блэк стоял возле иллюминатора.
   - Посмотрите вон на те герани. Совершенно новый вид. Он выведен на Земле всего лет пятьдесят тому назад. А теперь вспомните, сколько тысячелетий требуется для эволюции того или иного растения. И заодно скажите мне, логично ли это, чтобы у марсиан были: во-первых, именно такие оконные рамы, во-вторых, башенки, в- третьих, качели на террасе, в-четвертых, инструмент, который похож на пианино и скорее всего и есть не что иное, как пианино, в-пятых, - поглядите-ка внимательно в телескоп, вот так, - логично ли, чтобы марсианский композитор назвал свое произведение не как-нибудь иначе, а именно «Прекрасный Огайо»?', 133);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (974, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Ведь это может означать только одно: на Марсе есть река Огайо!
   - Капитан Уильямс, ну конечно же! - вскричал Хинкстон.
   - Что?
   - Капитан Уильямс и его тройка! Или Натаниел Йорк со своим напарником. Это все объясняет!
   - Это не объясняет ничего. Насколько нам удалось установить, ракета Йорка взорвалась, едва они сели на Марсе, и оба космонавта погибли. Что до Уильямса и его тройки, то их корабль взорвался на второй день после прибытия. Во всяком случае, именно в это время прекратили работу передатчики. Будь они живы, они попытались бы связатьсяс нами. Не говоря уже о том, что со времени экспедиции Йорка прошел всего один год, а экипаж капитана Уильямса прилетел сюда в августе.', 134);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (975, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Допустим даже, что они живы, - возможно ли, хотя бы с помощью самых искусных марсиан, за такое короткое время выстроить целый город, и чтобы он выглядел такимстарым?Вы посмотрите как следует, ведь этому городу самое малое семьдесят лет. Взгляните на перильные тумбы крыльца, взгляните на деревья - вековые клены! Нет, ни Йорк, ни Уильямс тут ни при чем. Тут что-то другое. Не по душе мне это. И, пока я не узнаю, в чем дело, не выйду из корабля.
   - Да к тому же, - добавил Люстиг, - Уильямс и его люди, и Йорк тоже садились на той стороне Марса. Мы ведь сознательно выбрали эту сторону.
   - Вот именно. На тот случай, если Йорка и Уильямса убило враждебное марсианское племя,', 135);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (976, '2025-08-24 23:06:22.571376+03', 6, NULL, 'нам было приказано сесть в другом полушарии. Чтобы катастрофа не повторилась. Так что мы находимся в краю, которого, насколько нам известно, ни Уильямс, ни Йорк и в глаза не видали.
   - Черт возьми, - сказал Хинкстон, - я все-таки пойду в этот город с вашего разрешения, капитан. Ведь может оказаться, что на всех планетах нашей Солнечной системы мышление и цивилизация развивались сходными путями. Кто знает, возможно, мы стоим на пороге величайшего психологического и философского открытия нашей эпохи!
   - Я предпочел бы обождать немного, - сказал капитан Джон Блэк.
   - Командир, может быть, перед нами явление, которое впервые докажет существование бога!', 136);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (977, '2025-08-24 23:06:22.571376+03', 6, NULL, '- Верующих достаточно и без таких доказательств, мистер Хинкстон…
   - Да, и я отношусь к ним, капитан. Но совершенно ясно - такой город просто не мог появиться без вмешательства божественного провидения. Все эти мелочи, детали… Во мнесейчас такая борьба чувств, не знаю, смеяться мне или плакать.
   - Тогда воздержитесь и от того, и от другого, пока мы не выясним, с чем столкнулись.
   - С чем столкнулись? - вмешался Люстиг. - Да ни с чем. Обыкновенный славный, тихий, зеленый городок, и очень похож на тот стародавний уголок, в котором я родился. Мне он просто нравится.
   - Когда вы родились, Люстиг?
   - В тысяча девятьсот пятидесятом, сэр.
   - А вы, Хинкстон?', 137);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (978, '2025-08-24 23:06:22.571376+03', 6, NULL, '- В тысяча девятьсот пятьдесят пятом, капитан. Гриннелл, штат Айова. Вот гляжу сейчас, и кажется, будто я на родину вернулся.
   - Хинкстон, Люстиг, я мог бы быть вашим отцом, мне ровно восемьдесят. Родился я в тысяча девятьсот двадцатом, в Иллинойсе, но благодаря божьей милости и науке, которая за последние пятьдесят лет научилась делатьнекоторыхстариков молодыми, я прилетел с вами на Марс. Устал я не больше вас, а вот недоверчивости у меня во много раз больше. У этого городка такой мирный, такой приветливый вид - и он так похож на мой Грин-Блафф в Иллинойсе, что мне даже страшно. Онслишкомпохож на Грин-Блафф. - Командир повернулся к радисту. - Свяжитесь с Землей. Передайте,', 138);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (979, '2025-08-24 23:06:22.571376+03', 6, NULL, 'что мы сели. Больше ничего. Скажите, что полный доклад будет передан завтра.
   - Есть, капитан.
   Капитан Блэк выглянул в иллюминатор; глядя на его лицо, никто не дал бы ему восьмидесяти лет - от силы сорок.
   - Теперь слушайте, Люстиг. Вы, я и Хинкстон пойдем и осмотрим город. Остальным ждать в ракете. Если что случится, они успеют унести ноги. Лучше потерять троих, чем погубить весь корабль. В случае несчастья наш экипаж сумеет оповестить следующую ракету. Ее поведет капитан Уайлдер в конце декабря, если не ошибаюсь. Если на Марсе есть какие-то враждебные силы, новая экспедиция должна быть хорошо вооружена.
   - Но ведь и мы вооружены. Целый арсенал с собой.
   - Ладно,', 139);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (980, '2025-08-24 23:06:22.571376+03', 6, NULL, 'передайте людям - привести оружие в готовность. Пошли, Люстиг, пошли, Хинкстон.
   И три космонавта спустились через отсеки корабля вниз.

   Был чудесный весенний день. На цветущей яблоне щебетала неутомимая малиновка. Облака белых лепестков сыпались вниз, когда ветер касался зеленых ветвей, далеко вокруг разносилось нежное благоухание. Где-то в городке кто-то играл на пианино, и музыка плыла в воздухе - громче, тише, громче, тише, нежная, баюкающая. Играли «Прекрасного мечтателя». А в другой стороне граммофон сипло, невнятно гнусавил «Странствие в сумерках» в исполнении Гарри Лодера.
   Трое космонавтов стояли подле ракеты. Они жадно хватали ртом сильно разреженный воздух,', 140);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (981, '2025-08-24 23:06:22.571376+03', 6, NULL, 'потом медленно пошли, сберегая силы.
   Теперь звучала другая пластинка.Мне бы июньскую ночь,Лунную ночь - и тебя…
   У Люстига задрожали колени, у Сэмюэля Хинкстона тоже.
   Небо было прозрачное и спокойное, где-то на дне оврага, под прохладным навесом листвы, журчал ручей. Цокали конские копыта, громыхала, подпрыгивая, телега.
   - Капитан, - сказал Сэмюэль Хинкстон, - как хотите, но похоже - нет,иначепросто бытьне может, -полеты на Марс начались еще до первой мировой войны!
   - Нет.
   - Но как еще объясните вы эти дома, этого чугунного оленя, пианино, музыку? - Хинкстон настойчиво стиснул локоть капитана, посмотрел ему в лицо. - Представьте себе, что были, ну, скажем,', 141);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (982, '2025-08-24 23:06:22.571376+03', 6, NULL, 'в тысяча девятьсот пятом году люди, которые ненавидели войну, и они тайно сговорились с учеными, построили ракету и перебрались сюда, на Марс…
   - Невозможно, Хинкстон.
   - Почему? В тысяча девятьсот пятом году мир был совсем иной, тогда было гораздо легче сохранить это в секрете.
   - Только не такую сложную штуку, как ракета! Нет, нет…
   - Они прилетели сюда насовсем и, естественно, построили такие же дома, как на Земле, ведь они привезли с собой земную культуру.
   - И все эти годы жили здесь? - спросил командир.
   - Вот именно, тихо и мирно жили. Возможно, они еще не раз слетали на Землю, привезли сюда людей, сколько нужно, скажем, чтобы заселить вот такой городок,', 142);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (983, '2025-08-24 23:06:22.571376+03', 6, NULL, 'а потом прекратили полеты, чтобы их не обнаружили. Поэтому и город такой старомодный. Лично мне пока не попался на глаза ни один предмет, сделанный позже тысяча девятьсот двадцатьседьмого года. А вам, капитан? Впрочем, может, космические путешествия вообще начались гораздо раньше, чем мы полагаем? Еще сотни лет назад, в каком-нибудь отдаленном уголке Земли? Что, если люди давно уже прилетели на Марс, и никто об этом не знал? А сами они изредка наведывались на Землю.
   - У вас это звучит почти правдоподобно.
   - Не почти, а вполне! Доказательство перед нами. Остается только найти здесь людей, и наше предположение подтвердится.
   Густая зеленая трава поглощала звуки их шагов.', 143);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (984, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Пахло свежескошенным сеном. Капитан Джон Блэк ощутил, как вопреки его воле им овладевает чувство блаженного покоя. Лет тридцать прошло с тех пор, как он последний раз побывал вот в таком маленьком городке; жужжание весенних пчел умиротворяло и убаюкивало его, а свежесть возрожденной природы исцеляла душу.
   Они ступили на террасу, направляясь к затянутой сеткой двери, и глухое эхо отзывалось из-под половиц на каждый шаг. Сквозь сетку они видели перегородившую коридор бисерную портьеру, хрустальную люстру и картину кисти Максфилда Парриша на стене над глубоким креслом. В доме бесконечно уютно пахло стариной, чердаком, еще чем-то. Слышно было, как тихо звякал лед в кувшине с лимонадом.', 144);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (985, '2025-08-24 23:06:22.571376+03', 6, NULL, 'На кухне в другом конце дома по случаю жаркого дня кто-то готовил холодный ленч. Высокий женский голос тихо и нежно напевал что-то.
   Капитан Джон Блэк потянул за ручку звонка.

   Вдоль коридора прошелестели легкие шаги, и за сеткой появилась женщина лет сорока, с приветливым лицом, одетая так, как, наверно, одевались в году эдак тысяча девятьсот девятом.
   - Чем могу быть полезна? - спросила она.
   - Прошу прощения, - нерешительно начал капитан Блэк, - но мы ищем… то есть, может, вы…
   Он запнулся. Она глядела на него темными недоумевающими глазами.
   - Если вы что-нибудь продаете… - заговорила женщина.
   - Нет, нет, постойте! - вскричал он. - Какой это город?', 145);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (986, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Она смерила его взглядом.
   - Что вы хотите этим сказать: какой город? Как это можно быть в городе и не знать его названия?
   У капитана было такое лицо, словно ему больше всего хотелось пойти и сесть под тенистой яблоней.
   - Мы не здешние. Нам надо знать, как здесь очутился этот город и как вы сюда попали.
   - Вы из бюро переписи населения?
   - Нет.
   - Каждому известно, - продолжала она, - что город построен в тысяча восемьсот шестьдесят восьмом году. Постойте, может быть, вы меня разыгрываете?
   - Что вы, ничего подобного! - поспешно воскликнул капитан. - Мы с Земли.
   - Вы хотите сказать,из-подземли? - удивилась она.
   - Да нет же, мы вылетели с третьей планеты, Земли,', 146);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (987, '2025-08-24 23:06:22.571376+03', 6, NULL, 'на космическом корабле. И прилетели сюда, на четвертую планету, на Марс…
   - Вы находитесь, - объяснила женщина тоном, каким говорят с ребенком, - в Грин-Блафф, штат Иллинойс, на материке, который называется Америка и омывается двумя океанами, Атлантическим и Тихим, в мире, именуемом также Землей. Теперь ступайте. До свидания.
   И она засеменила по коридору, на ходу раздвигая бисерную портьеру.
   Три товарища переглянулись.
   - Высадим дверь, - предложил Люстиг.
   - Нельзя. Частная собственность. О господи!
   Они спустились с крыльца и сели на нижней ступеньке.
   - Вам не приходило в голову, Хинкстон, что мы каким-то образом сбились с пути и просто-напросто прилетели обратно,', 147);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (988, '2025-08-24 23:06:22.571376+03', 6, NULL, 'вернулись на Землю?
   - Это как же так?
   - Не знаю, не знаю. Господи, дайте собраться с мыслями.
   - Ведь мы контролировали каждую милю пути, - продолжал Хинкстон. - Наши хронометры точно отсчитывали, сколько пройдено. Мы миновали Луну, вышли в Большой космос и прилетели сюда. У меня нетни малейшего сомнения,что мы на Марсе.
   Вмешался Люстиг.
   - А может быть, что-то случилось с пространством, с временем? Представьте себе, что мы заблудились в четырех измерениях и вернулись на Землю лет тридцать или сорок тому назад?
   - Да бросьте вы, Люстиг!
   Люстиг подошел к двери, дернул звонок и крикнул в сумрачную прохладу комнат:
   - Какой сейчас год?
   - Тысяча девятьсот двадцать шестой,', 148);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (989, '2025-08-24 23:06:22.571376+03', 6, NULL, 'какой же еще, - ответила женщина, сидя в качалке и потягивая свой лимонад.
   - Ну, слышали? - Люстиг круто обернулся. - Тысяча девятьсот двадцать шестой! Мы улетели впрошлое!Это Земля!

   Люстиг сел. Они уже не сопротивлялись ужасной, ошеломляющей мысли, которая пронизала их. Лежащие на коленях руки судорожно дергались.
   - Разве я за этим летел? - заговорил капитан. - Мне страшно, понимаете, страшно! Неужели такое возможно в действительности? Эйнштейна сюда бы сейчас…
   - Кто в этом городе поверит нам? - отозвался Хинкстон. - Ох, в опасную игру мы ввязались!.. Это же время, четвертое измерение. Не лучше ли нам вернуться на ракету и лететь домой, а?
   - Нет.', 149);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (990, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Сначала заглянем хотя бы еще в один дом.
   Они миновали три дома и остановились перед маленьким белым коттеджем, который приютился под могучим дубом.
   - Я привык во всем добираться до смысла, - сказал командир. - А пока что, сдается мне, мы еще не раскусили орешек. Допустим, Хинкстон, верно ваше предположение, что космические путешествия начались давным-давно. И через много лет прилетевшие сюда земляне стали тосковать по Земле. Сперва эта тоска не выходила за рамки легкого невроза, потом развился настоящий психоз, который грозил перейти в безумие. Что вы как психиатр предложили бы в таком случае?
   Хинкстон подумал.
   - Что ж, наверно,', 150);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (991, '2025-08-24 23:06:22.571376+03', 6, NULL, 'я бы стал понемногу перестраивать марсианскую цивилизацию так, чтобы она с каждым днем все больше напоминала земную. Если бы существовал способ воссоздать земные растения, дороги, озера, даже океан, я бы это сделал. Затем средствами массового гипноза я внушил бы всему населению вот такого городка, будто здесь ив самом делеЗемля,а никакой не Марс.
   - Отлично, Хинкстон. Мне кажется, мы напали на верный след. Женщина, которую мы видели в том доме, просто думает, что живет на Земле, вот и все. Это сохраняет ей рассудок. Она и все прочие жители этого города - объекты величайшего миграционного и гипнотического эксперимента, какой вам когда-либо придется наблюдать.
   - В самую точку, капитан!', 151);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (992, '2025-08-24 23:06:22.571376+03', 6, NULL, '- воскликнул Люстиг.
   - Без промаха! - добавил Хинкстон.
   - Добро. - Капитан вздохнул. - Дело как будто прояснилось, и на душе легче. Хоть какая-то логика появилась. А то от всей этой болтовни о путешествиях взад и вперед во времени меня только мутит. Если же мое предположениеправильно… -Он улыбнулся. - Что же, тогда нас, похоже, ожидает немалая популярность среди местных жителей!
   - Вы уверены? - сказал Люстиг. - Как-никак, эти люди своего рода пилигримы, они намеренно покинули Землю. Может, они вовсе не будут нам рады. Может, даже попытаются изгнать нас, а то и убить.
   - Наше оружие получше. Ну, пошли, зайдем в следующий дом.
   Но не успели они пересечь газон,', 152);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (993, '2025-08-24 23:06:22.571376+03', 6, NULL, 'как Люстиг вдруг замер на месте, устремив взгляд в дальний конец тихой дремлющей улицы.
   - Капитан, - произнес он.
   - В чем дело, Люстиг?
   - Капитан… Нет, вы только… Что явижу!
   По щекам Люстига катились слезы. Растопыренные пальцы поднятых рук дрожали, лицо выражало удивление, радость, сомнение. Казалось, еще немного, и он потеряет разум от счастья. Продолжая глядеть в ту же точку, он вдруг сорвался с места и побежал, споткнулся, упал, поднялся на ноги и опять побежал, крича:
   - Эй, послушайте!
   - Остановите его! - Капитан пустился вдогонку.
   Люстиг бежал изо всех сил, крича на бегу. Достигнув середины тенистой улицы,', 153);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (994, '2025-08-24 23:06:22.571376+03', 6, NULL, 'он свернул во двор и одним прыжком очутился на террасе большого зеленого дома, крышу которого венчал железный петух. Когда Хинкстон и капитан догнали Люстига, он барабанил в дверь, продолжая громко кричать. Все трое дышали тяжело, со свистом, обессиленные бешеной гонкой в разреженной марсианской атмосфере.
   - Бабушка, дедушка! - звал Люстиг.
   Двое стариков появились на пороге.
   - Дэвид! - ахнули старческие голоса. И они бросились к нему и засуетились вокруг него, обнимая, хлопая по спине. - Дэвид, о, Дэвид, сколько лет прошло!.. Как же ты вырос, мальчуган, какой большой стал! Дэвид, мальчик, как ты поживаешь?
   - Бабушка, дедушка! - всхлипывал Дэвид Люстиг. - Вы чудесно,', 154);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (995, '2025-08-24 23:06:22.571376+03', 6, NULL, 'чудесно выглядите!
   Он разглядывал своих стариков, отодвинув от себя, вертел их кругом, целовал, обнимал, плакал и снова разглядывал, смахивая слезы с глаз. Солнце сияло в небе, дул ветерок, зеленела трава, дверь была отворена настежь.
   - Входи же, входи мальчуган. Тебя ждет чай со льда, свежий, пей вволю!
   - Я с друзьями. - Люстиг обернулся и, смеясь, нетерпеливым жестом подозвал капитана и Хинкстона. - Капитан, идите же.
   - Здравствуйте, - приветствовали их старики. - Пожалуйста, входите. Друзья Дэвида - наши друзья. Не стесняйтесь!

   В гостиной старого дома было прохладно; в одном углу размеренно тикали, поблескивая бронзой, высокие дедовские часы.', 155);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (996, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Мягкие подушки на широких кушетках, книги вдоль стен, толстый ковер с пышным цветочным узором, а в руках - запотевшие стаканы ледяного чая, от которого такой приятный холодок на пересохшем языке.
   - Пейте на здоровье. - Бабушкин стакан звякнул о ее фарфоровые зубы.
   - И давно вы здесь живете, бабушка? - спросил Люстиг.
   - С тех пор как умерли, - с ехидцей ответила она.
   - С тех пор как… что? - Капитан Блэк поставил свой стакан.
   - Ну да, - кивнул Люстиг. - Они уже тридцать лет как умерли.
   - А вы сидите как ни в чем не бывало! - воскликнул капитан.
   - Полно, сударь! - Старушка лукаво подмигнула. - Кто вы такой, чтобы судить о таких делах? Мы здесь, и все тут. Что такое жизнь,', 156);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (997, '2025-08-24 23:06:22.571376+03', 6, NULL, 'коли на то пошло? Кому нужны эти «почему» и «зачем»? Мы снова живы, вот и все, что нам известно, и никаких вопросов мы не задаем. Если хотите, это вторая попытка. - Она, ковыляя, подошла к капитану и протянула ему свою тонкую, сухую руку. - Потрогайте.
   Капитан потрогал.
   - Ну как, настоящая?
   Он кивнул.
   - Так чего же вам еще надо? - торжествующе произнесла она. - К чему вопросы?
   - Понимаете, - ответил капитан, - мы просто не представляли себе, что обнаружим на Марсе такое.
   - А теперь обнаружили. Смею думать, на каждой планете найдется немало такого, что покажет вам, сколь неисповедимы пути господни.
   - Так что же, здесь - царство небесное? - спросил Хинкстон.
   - Вздор,', 157);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (998, '2025-08-24 23:06:22.571376+03', 6, NULL, 'ничего подобного. Здесь такой же мир, и нам предоставлена вторая попытка. Почему? Об этом нам никто не сказал. Но ведь и на Земле никто не объяснил нам, почемумы там очутились. На той Земле. С которой прилетели вы. И откуда нам знать, что до нее не былоеще одной?
   - Хороший вопрос, - сказал капитан.
   С лица Люстига не сходила радостная улыбка.
   - Черт возьми, до чего же приятно вас видеть, я так рад!
   Капитан поднялся со стула и небрежно хлопнул себя ладонью по бедру.
   - Ну, нам пора идти. Спасибо за угощение.
   - Но вы ведь еще придете? - всполошились старики. - Мы ждем вас к ужину.
   - Большое спасибо, постараемся прийти. У нас столько дел.', 158);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (999, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Мои люди ждут меня в ракете и…
   Он смолк, ошеломление глядя на открытую дверь. Откуда-то издали, из пронизанного солнцем простора, доносились голоса, крики, дружные приветственные возгласы.
   - Что это? - спросил Хинкстон.
   - Сейчас узнаем. - И капитан Джон Блэк мигом выскочил за дверь и побежал через зеленый газон на улицу марсианского городка.
   Он застыл, глядя на ракету. Все люки были открыты, и экипаж торопливо спускался на землю, приветственно махая руками. Кругом собралась огромная толпа, и космонавты влились в нее, смешались с ней, проталкивались через нее, разговаривая, смеясь, пожимая руки. Толпа приплясывала от радости, возбужденно теснилась вокруг землян.', 159);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1000, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Ракета стояла покинутая, пустая.
   В солнечных лучах взорвался блеском духовой оркестр, из высоко поднятых басов и труб брызнули ликующие звуки. Бухали барабаны, пронзительно свистели флейты. Золотоволосые девочки прыгали от восторга. Мальчуганы кричали: «Ура!» Толстые мужчины угощали знакомых и незнакомых десятицентовыми сигарами. Мэр города произнес речь. А затем всех членов экипажа одного за другим подхватили под руки - мать с одной стороны, отец или сестра с другой - и увлекли вдоль по улице в маленькие коттеджи и в большие особняки.
   - Стой! - закричал капитан Блэк.
   Одна за другое наглухо захлопнулись двери. Зной струился вверх к прозрачному весеннему небу,', 160);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1001, '2025-08-24 23:06:22.571376+03', 6, NULL, 'тишина нависла над городком. Трубы и барабаны исчезли за углом. Покинутая ракета одиноко сверкала и переливалась солнечными бликами.
   - Дезертиры! - воскликнул командир. - Они самовольно оставили корабль! Клянусь, им это так не пройдет! У них был приказ!..
   - Капитан, - сказал Люстиг, - не будьте излишне строги. Когда вас встречают родные и близкие…
   - Это не оправдание!
   - Но вы представьте себе их чувства, когда они увидели возле корабля знакомые лица!
   - У них был приказ, черт возьми!
   - А как бы вы поступили, капитан?
   - Я бы выполнял прика… - Он так и замер с открытым ртом.
   По тротуару в лучах марсианского солнца шел, приближаясь к ним, высокий,', 161);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1002, '2025-08-24 23:06:22.571376+03', 6, NULL, 'улыбающийся молодой человек лет двадцати шести с удивительно яркими голубыми глазами.
   - Джон! - крикнул он и бросился к ним.
   - Что? - Капитан Блэк попятился.
   - Джон, старый плут!
   Подбежав, мужчина стиснул руку капитана и хлопнул его по спине.
   - Ты?… - пролепетал Блэк.
   - Конечно, я,ктоже еще!
   - Эдвард! - Капитан повернулся к Люстигу и Хинкстону, не выпуская руки незнакомца. - Это мой брат, Эдвард. Эд, познакомься с моими товарищами: Люстиг, Хинкстон! Мой брат!
   Они тянули, теребили друг друга за руки, потом обнялись.
   - Эд!
   - Джон, бездельник!
   - Ты великолепно выглядишь, Эд! Но постой, как же так? Ты ничуть не изменился за все эти годы.', 162);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1003, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Ведь тебе… тебе же было двадцать шесть, когда ты умер, а мне девятнадцать. Бог ты мой, столько лет, столько лет - и вдруг ты здесь. Да что ж это такое?
   - Мама ждет, - сказал Эдвард Блэк, улыбаясь.
   - Мама?
   - И отец тоже.
   - Отец? - Капитан пошатнулся, точно от сильного удара, и сделал шаг-другой негнущимися, непослушными ногами. - Мать и отец живы? Где они?
   - В нашем старом доме, на Дубовой улице.
   - В старом доме… - Глаза капитана светились восторгом и изумлением. - Вы слышали, Люстиг, Хинкстон?
   Но Хинкстона уже не было рядом с ними. Он приметил в дальнем конце улицы свой собственный дом и поспешил туда. Люстиг рассмеялся.
   - Теперь вы поняли, капитан,', 163);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1004, '2025-08-24 23:06:22.571376+03', 6, NULL, 'что было с нашими людьми? Их никак нельзя винить.
   - Да… Да… - Капитан зажмурился. - Сейчас я открою глаза, и тебя не будет. - Он моргнул. - Ты здесь! Господи. Эд, тывеликолепновыглядишь!
   - Идем, ленч ждет. Я предупредил маму.
   - Капитан, - сказал Люстиг, - если я понадоблюсь, я - у своих стариков.
   - Что? А, ну конечно, Люстиг. Пока.
   Эдвард потянул брата за руку, увлекая его за собой.
   - Вот и наш дом. Вспоминаешь?
   - Еще бы! Спорим, я первый добегу до крыльца!
   Они побежали взапуски. Шумели деревья над головой капитана Блэка, гудела земля под его ногами. В этом поразительном сне наяву он видел, как его обгоняет Эдвард Блэк, видел,', 164);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1005, '2025-08-24 23:06:22.571376+03', 6, NULL, 'как стремительно приближается его родной дом и широко распахивается дверь.
   - Я - первый! - крикнул Эдвард.
   - Еще бы, - еле выдохнул капитан, - я старик, а ты вон какой молодец. Да ты ведь менявсегдаобгонял! Думаешь, я забыл?
   В дверях была мама - полная, розовая, сияющая.
   За ней, с заметной проседью в волосах, стоял папа, держа в руке свою трубку.
   - Мама, отец!
   Он ринулся к ним вверх по ступенькам, точно ребенок.

   День был чудесный и долгий. После ленча они перешли в гостиную, и он рассказал им все про свою ракету, а они кивали и улыбались ему, и мама была совсем такая, как прежде, и отец откусывал кончик сигары и задумчиво прикуривал ее - совсем как в былые времена.', 165);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1006, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Вечером был обед, умопомрачительная индейка, и время летело незаметно. И когда хрупкие косточки были начисто обсосаны и грудой лежали на тарелках, капитан откинулся на спинку стула и шумно выдохнул воздух в знак своего глубочайшего удовлетворения. Вечер упокоил листву деревьев и окрасил небо, и лампы в милом старом доме засветились ореолами розового света. Из других домов вдоль всей улицы доносиласьмузыка, звуки пианино, хлопанье дверей.
   Мама поставила пластинку на виктролу и закружилась в танце с капитаном Джоном Блэком. От нее пахло теми же духами, он их запомнил еще с того лета, когда она и папа погибли при крушении поезда. Но сейчас они легко скользили в танце,', 166);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1007, '2025-08-24 23:06:22.571376+03', 6, NULL, 'и его руки обнимали реальную, живую маму…
   - Не каждый день человеку предоставляется вторая попытка, - сказала мама.
   - Завтра утром проснусь, - сказал капитан, - и окажется, что я в своей ракете, в космосе, и ничего этого нет.
   - К чему такие мысли! - воскликнула она ласково. - Не допытывайся. Бог милостив к нам. Будем же счастливы.
   - Прости, мама.
   Пластинка кончилась и вертелась, шипя.
   - Ты устал, сынок. - Отец указал мундштуком трубки: - Твоя спальня ждет тебя, и старая кровать с латунными шарами - все как было.
   - Но мне надо собрать моих людей.
   - Зачем?
   - Зачем? Гм… не знаю. Пожалуй, и впрямь незачем. Конечно, незачем. Они ужинают либо уже спят. Пусть выспятся,', 167);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1008, '2025-08-24 23:06:22.571376+03', 6, NULL, 'отдых им не повредит.
   - Доброй ночи, сынок. - Мама поцеловала его в щеку. - Как славно, что ты дома опять.
   - Да,домахорошо…
   Покинув мир сигарного дыма, духов, книг, мягкого света, он поднялся по лестнице и все говорил, говорил с Эдвардом. Эдвард толкнул дверь, и Джон Блэк увидел свою желтую латунную кровать, знакомые вымпелы колледжа и сильно потертую енотовую шубу, которую погладил с затаенной нежностью.
   - Слишком много сразу, - промолвил капитан. - Я обессилел от усталости. Столько событий в один день! Как будто меня двое суток держали под ливнем без зонта и без плаща.Я насквозь,', 168);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1009, '2025-08-24 23:06:22.571376+03', 6, NULL, 'до костей пропитан впечатлениями…
   Широкими взмахами рук Эдвард расстелил большие белоснежные простыни и взбил подушки. Потом растворил окно, впуская в комнату ночное благоухание жасмина. Светила луна, издали доносились звуки танцевальной музыки и тихих голосов.
   - Так вот он какой, Марс, - сказал капитан, раздеваясь.
   - Да, вот такой. - Эдвард раздевался медленно, не торопясь стянул через голову рубаху, обнажая золотистый загар плеч и крепкой, мускулистой шеи.
   Свет погас, и вот они рядом в кровати, как бывало - сколько десятилетий тому назад? Капитан приподнялся на локте, вдыхая напоенный ароматом жасмина воздух, потоки которого раздували в темноте легкие тюлевые занавески.', 169);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1010, '2025-08-24 23:06:22.571376+03', 6, NULL, 'На газоне среди деревьев кто-то завел патефон - он тихо наигрывал «Всегда».
   Блэку вспомнилась Мерилин.
   - Мерилин тоже здесь?
   Брат лежал на спине в квадрате лунного света из окна. Он ответил не сразу.
   - Да. - Помешкал и добавил: - Ее сейчас нет в городе, она будет завтра утром.
   Капитан закрыл глаза.
   - Мне бы очень хотелось увидеть Мерилин.
   В тишине просторной комнаты слышалось только их дыхание.
   - Спокойной ночи, Эд.
   Пауза.
   - Спокойной ночи, Джон.
   Капитан блаженно вытянулся на постели, дав волю мыслям. Только теперь схлынуло с него напряжение этого дня, и он наконец-то мог рассуждать логично. Все - все были сплошные эмоции. Громогласный оркестр,', 170);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1011, '2025-08-24 23:06:22.571376+03', 6, NULL, 'знакомые лица родни… Зато теперь…
   «Каким образом? - дивился он. - Как все это было сделано? И зачем? Для чего? Что это - неизреченная благостность божественного провидения? Неужто бог и впрямь так печется о своих детях? Как, почему, для чего?»
   Он взвесил теории, которые предложили Хинкстон и Люстиг еще днем, под влиянием первых впечатлений. Потом стал перебирать всякие новые предположения, лениво, как камешки в воду, роняя их в глубину своего разума, поворачивая их и так и сяк, и тусклыми проблесками вспыхивало в нем озарение. Мама. Отец. Эдвард. Марс. Земля. Марс. Марсиане.
   А тысячу лет назад кто жил на Марсе? Марсиане? Или всегда было, как сегодня?
   Марсиане.', 171);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1012, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Он медленно повторял про себя это слово. И вдруг чуть не рассмеялся почти вслух. Внезапно пришла в голову совершенно нелепая теория. По спине пробежал холодок. Да нет, вздор, конечно. Слишком невероятно. Ерунда. Выкинуть из головы. Смешно.
   И все-таки… Еслипредположить.Да, только предположить, что на Марсе живут именно марсиане, что они увидели, как приближается наш корабль, и увидели нас внутри этого корабля. И что они нас возненавидели. И еще допустим - просто так, курьеза ради, - что они решили нас уничтожить, как захватчиков, незваных гостей, и притом сделать это хитроумно, ловко, усыпив нашу бдительность. Так вот, какие же средства может марсианин пустить в ход против землян,', 172);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1013, '2025-08-24 23:06:22.571376+03', 6, NULL, 'оснащенных атомным оружием?
   Ответ получался любопытный. Телепатию, гипноз, воспоминания, воображение.
   Предположим, что эти дома вовсе не настоящие, кровать не настоящая, что все это продукты моего собственного воображения, материализованные с помощью марсианской телепатии и гипноза, размышлял капитан Джон Блэк. На самом деле дома совсеминые,построенные на марсианский лад, но марсиане, подлаживаясь под мои мечты и желания, ухитрились сделать так, что я как бы вижу свой родной город, свой дом. Если хочешь усыпить подозрения человека и заманить его в ловушку, можно ли придумать лучшую приманку, чем его родные отец и мать?
   Этот городок, такой старый, все,', 173);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1014, '2025-08-24 23:06:22.571376+03', 6, NULL, 'как в тысяча девятьсот двадцать шестом году, когда никого из моего экипажа еще не было на свете! Когда мне было шесть лет, когдадействительнобыли в моде пластинки с песенками Гарри Лодера иеще виселив домах картины Максфилда Парриша, когда были бисерные портьеры, и песенка «Прекрасный Огайо», и архитектура начала двадцатого века. А что, если марсиане извлекли все представления о городе только измоего сознания?Ведь говорят же, что воспоминания детства самые яркие. И, создав город по моим воспоминаниям, они населили его родными и близкими, живущими в памяти всех членов экипажа ракеты!
   И допустим, что двое спящих в соседней комнате вовсе не мои отец и мать,', 174);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1015, '2025-08-24 23:06:22.571376+03', 6, NULL, 'а марсиане с необычайно высокоразвитым интеллектом, которым ничего не стоит все время держать меня под гипнозом?…
   А этот духовой оркестр? Какой потрясающий, изумительный план! Сперва заморочить голову Люстигу, за ним Хинкстону, потом согнать толпу; а когда космонавты увидели матерей, отцов, теток, невест, умерших десять, двадцать лет назад, - разве удивительно, что они забыли обо всем на свете, забыли про приказ, выскочили из корабля и бросили его? Что может быть естественнее? Какие тут могут быть подозрения? Проще некуда: кто станет допытываться, задавать вопросы, увидев перед собой воскресшую мать, - да тут от счастья вообще онемеешь. И вот вам результат:', 175);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1016, '2025-08-24 23:06:22.571376+03', 6, NULL, 'все мы разошлись по разным домам, лежим в кроватях, и нет у нас оружия, защищаться нечем, и ракета стоит в лунном свете, покинутая. Как ужасающе страшно будет, если окажется, что все это попросту часть дьявольски хитроумного плана, который марсиане задумали, чтобы разделить наси одолеть, перебить всех до одного. Может быть, среди ночи мой брат, что лежит тут, рядом со мной, вдруг преобразится, изменит свой облик, свое существо и станет чем-то другим, жутким, враждебным, - станет марсианином? Ему ничего не стоит повернуться в постели и вонзить мне нож в сердце. И во всех остальных домах еще полтора десяткабратьев или отцов вдруг преобразятся,', 176);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1017, '2025-08-24 23:06:22.571376+03', 6, NULL, 'схватят ножи и проделают то же с ни чего не подозревающими спящими землянами…
   Руки Джона Блэка затряслись под одеялом. Он похолодел. Внезапно это перестало быть теорией. Внезапно им овладел неодолимый страх.
   Он сел и прислушался. Ночь была беззвучна. Музыка смолкла. Ветер стих. Брат лежал рядом с ним, погруженный в сон.
   Он осторожно откинул одеяло, соскользнул на пол и уже тихонько шел к двери, когда раздался голос брата:
   - Ты куда?
   - Что?
   Голос брата стал ледяным.
   - Я спрашиваю, далеко ли ты собрался?
   - За водой.
   - Ты не хочешь пить.
   - Хочу, правда же хочу.
   - Нет, не хочешь.
   Капитан Джон Блэк рванулся и побежал. Он вскрикнул. Он вскрикнул дважды.', 177);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1018, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Он не добежал до двери.

   Наутро духовой оркестр играл заунывный траурный марш. По всей улице из каждого дома выходили, неся длинные ящики, маленькие скорбные процессии; по залитой солнцем мостовой выступали, утирая слезы, бабки, матери, сестры, братья, дядья, отцы. Они направлялись на кладбище, где уже ждали свежевырытые могилы и новенькие надгробные плиты. Шестнадцать могил, шестнадцать надгробных плит.
   Мэр произнес краткую заупокойную речь, и лицо его менялось, не понять - то ли мэр, то ли кто-то другой.
   Мать и отец Джона Блэка пришли на кладбище, и брат Эдвард пришел. Они плакали, убивались, а лица их постепенно преображались, теряя знакомые черты.', 178);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1019, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Дедушка и бабушка Люстига тоже были тут и рыдали, и лица их таяли, точно воск, расплывались, как все расплывается в жаркий день.
   Гробы опустили в могилы. Кто-то пробормотал насчет «внезапной и безвременной кончины шестнадцати отличных людей, которых смерть унесла в одну ночь…»
   Комья земли застучали по гробовым крышкам.
   Духовой оркестр, играя «Колумбия, жемчужина океана», прошагал в такт громыхающей меди в город, и в этот день все отдыхали.
   Июнь 2001

   И по-прежнему лучами серебрит простор луна…
   Когда они вышли из ракеты в ночной мрак, было так холодно, что Спендер сразу принялся собирать марсианский хворост для костра. Насчет того, чтобы отпраздновать прилет на Марс,', 179);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1020, '2025-08-24 23:06:22.571376+03', 6, NULL, 'он и слова не сказал, просто набрал хворосту, подпалил его и стал смотреть, как он горит.
   Потом в зареве, окрасившем разреженный воздух над высохшим марсианским морем, оглянулся через плечо на ракету, которая пронесла их всех - капитана Уайлдера, Чероки, Хетэуэя, Сэма Паркхилла, его самого - через немые черные звездные просторы и доставила в безжизненный, грезящий мир.
   Джефф Спендер ждал, когда начнется содом. Он глядел на своих товарищей и ждал: сейчас запрыгают, закричат… Вот только пройдет оцепенение от потрясающей мысли, что они «первые» люди на Марсе. Никто об этом вслух не говорил, но в глубине души многие, видимо, надеялись,', 180);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1021, '2025-08-24 23:06:22.571376+03', 6, NULL, 'что их предшественники не долетели и пальма первенства будет принадлежать этой, Четвертой экспедиции. Нет, они никому не желали зла, просто им очень хотелось быть первыми и они мечтали о славе и почете, пока их легкие привыкалик разреженной атмосфере Марса, из-за которой голова становилась словно хмельная, если двигаться слишком быстро.
   Гиббс подошел к разгорающемуся костру и спросил:
   - Зачем хворост, ведь в ракете есть химическое горючее?
   - Неважно, - ответил Спендер, не поднимая головы.
   Немыслимо, просто непристойно в первую же ночь на Марсе устраивать шум и гам и тащить из ракеты неуместную здесь штуковину - печку, сверкающую идиотским блеском.', 181);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1022, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Это же будет надругательство какое-то. Еще успеется, еще будет время швырять банки из-под сгущенного молока в гордые марсианские каналы, еще поползут, лениво закувыркаются по седому пустынному дну марсианских морей шуршащие листы «Нью-Йорк таймс», придет время банановой кожуре и замасленной бумаге валяться среди изящно очерченных развалин древних марсианских городов. Все впереди, все будет. Его даже передернуло от этой мысли.
   Спендер подкармливал пламя из рук с таким чувством, словно приносил жертву мертвому исполину. Планета, на которую они сели, - гигантская гробница. Здесь погибла целая цивилизация. Элементарная вежливость требует хотя бы в первую ночь вести себя здесь пристойно.', 182);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1023, '2025-08-24 23:06:22.571376+03', 6, NULL, '- Нет, так не пойдет! Посадку надо отпраздновать! - Гиббс повернулся к капитану Уайлдеру. - Начальник, а неплохо бы вскрыть несколько банок с джином и мясом и малость кутнуть.
   Капитан Уайлдер смотрел на мертвый город, который раскинулся в миле от них.
   - Мы все устали, - произнес он рассеянно, точно целиком ушел в созерцание города и забыл про своих людей. - Лучше завтра вечером. Сегодня хватит с нас того, что мы добрались сюда через эту чертову пустоту, и все живы, и в оболочке нет дыры от метеорита.
   Космонавты топтались вокруг костра. Их было двадцать, кто положил руку на плечо товарища, кто поправлял пояс. Спендер пристально разглядывал их. Они были недовольны.', 183);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1024, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Они рисковали жизнью ради великого дела. Теперь им хотелось напиться до чертиков, горланить песни, поднять такую пальбу, чтобы сразу было видно, какие они лихие парни - пробуравили космос и пригнали ракету на Марс. На Марс!
   Но пока все помалкивали.
   Капитан негромко отдал приказ. Один из космонавтов сбегал в ракету и принес консервы, которые открыли и раздали без особого шума. Мало-помалу люди разговорились. Капитан сел и сделал краткий обзор полета. Они все знали сами, но было приятно слушать и сознавать, что все это уже позади, дело благополучно завершено. Про обратный путь говорить не хотелось. Кто-то было заикнулся об этом, но его заставили замолчать.', 184);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1025, '2025-08-24 23:06:22.571376+03', 6, NULL, 'В двойном лунном свете быстро мелькали ложки; еда казалась очень вкусной, вино - еще вкуснее.
   В небе чиркнуло пламя, и мгновение спустя за их стоянкой села вспомогательная ракета. Спендер смотрел, как открылся маленький люк и оттуда вышел Хетэуэй, врач и геолог, - у каждого участника экспедиции были две специальности, для экономии места в ракете. Хетэуэй, не торопясь, подошел к капитану.
   - Ну, что там? - спросил капитан Уайлдер.
   Хетэуэй глядел на далекие города, мерцающие в звездном свете. Потом проглотил ком в горле и перевел взгляд на Уайлдера:
   - Вон тот город мертв, капитан, мертв уж много тысяч лет. Как и три города в горах. Но пятый город, в двухстах милях отсюда…
   - Ну?', 185);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1026, '2025-08-24 23:06:22.571376+03', 6, NULL, '- Еще на прошлой неделе там жили.
   Спендер встал.
   - Марсиане, - добавил Хетэуэй.
   - А где они теперь?
   - Умерли, - сказал Хетэуэй. - Я зашел в один дом, думал, что он, как и другие дома в остальных городах, заброшен много веков назад. Силы небесные, сколько там трупов! Словно груды осенних листьев! Будто сухие стебли и клочки горелой бумаги - все, что от них осталось. Причем умерлисовсемнедавно, самое большее дней десять назад.
   - А в других городах? Хотьчто-нибудьживое вы видели?
   - Ничего. Я потом еще не один проверил. Из пяти городов четыре заброшены много тысяч лет. Совершенно не представляю себе, куда подевались их обитатели. Зато в каждом пятом городе - одно и то же.', 186);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1027, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Тела. Тысячи тел.
   - От чего они умерли? - Спендер подошел ближе.
   - Вы не поверите.
   - Что их убило?
   - Ветрянка, - коротко ответил Хетэуэй.
   - Не может быть!
   - Точно. Я сделал анализы. Ветряная оспа. Ее действие на марсиан совсем не такое, как на землян. Видимо, все дело в обмене веществ. Они почернели, как головешки, и высохли, превратились в ломкие хлопья. Но это ветрянка, никакого сомнения. Выходит, что и Йорк, и капитан Уильямс, и капитан Блэк - все три экспедиции добрались до Марса. Что с ними стало потом, одному богу известно. Но мы совершенно точно знаем, что они, сами того не ведая,сделалис марсианами.
   - И нигде никаких признаков жизни?
   - Возможно, конечно,', 187);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1028, '2025-08-24 23:06:22.571376+03', 6, NULL, 'что несколько марсиан вовремя сообразили и ушли в горы. Но, даже если так, бьюсь об заклад, что проблемы туземцев здесь нет, их слишком мало. Песенка марсиан спета.
   Спендер повернулся и снова сел у костра, уставившись в огонь. Ветрянка, господи, подумать только, ветрянка! Население планеты миллионы лет развивается, совершенствует свою культуру, строит вот такие города, всячески старается утвердить свои идеалы и представления о красоте и - погибает. Часть умерла еще до нашей эры - пришел их срок, и они скончались тихо, с достоинством встретили смерть. Но остальные! Может быть, остальные марсиане погибли от болезни с изысканным, или грозным, или возвышенным названием? Ничего подобного,', 188);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1029, '2025-08-24 23:06:22.571376+03', 6, NULL, 'черт возьми, их доконала ветрянка, детская болезнь, болезнь, которая на Земле не убиваетдаже детей!Это неправильно, несправедливо. Это все равно что сказать про древних греков, что они погибли от свинки, а гордых римлян на их прекрасных холмах скосил грибок! Хоть бы дали мы марсианам время приготовить свой погребальный убор, принять надлежащую позу и измыслить какую-нибудьинуюпричину смерти. Так нет же - какая-то паршивая, дурацкая ветрянка! Нет, не может быть, это несовместимо с величием их архитектуры, со всем их миром!
   - Ладно, Хетэуэй, теперь перекусите.
   - Спасибо, капитан.
   И все! Уже забыто. Уже говорят совсем о другом.
   Спендер, не отрываясь, следил за своими спутниками.', 189);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1030, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Он не прикоснулся к своей порции, лежавшей в тарелке у него на коленях. Стало еще холоднее. Звезды придвинулись ближе, вспыхнули ярче.
   Если кто-нибудь начинал говорить чересчур громко, капитан отвечал вполголоса, и они невольно понижали голос, стараясь подражать ему.
   Какой здесь чистый, необычный воздух! Спендер долго сидел и просто дышал, наслаждаясь его ароматом. В нем слилась бездна запахов, он не мог угадать каких: цветы, химические вещества, пыль, ветер…
   - Или взять хоть тот раз в Нью-Йорке, когда я подцепил эту блондиночку, - черт, забыл, как ее звали… Гинни! - орал Биггс. - Девчонка была что надо!
   Спендер весь сжался. У него задрожали руки.', 190);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1031, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Глаза беспокойно дергались под тонкими, прозрачными веками.
   - Вот Гинни и говорит мне… - продолжал Биггс.
   Раздался дружный хохот.
   - Ну, я ей и вмазал! - выкрикнул Биггс, не выпуская из рук бутылки.
   Спендер отставил свою тарелку в сторону. Прислушался к шепоту прохладного ветерка. Полюбовался белыми марсианскими зданиями - точно холодные льдины на дне высохшего моря…
   - Какая девчонка, блеск! - Биггс опрокинул бутылку в свою широкую пасть. - Сколько их было - такой не попадалось!
   В воздухе стоял резкий запах потного тела Биггса. Спендер дал костру потухнуть.
   - Эй, Спендер, уснул, что ли, подкинь дров! - крикнул Биггс и снова присосался к бутылке. - Ну, так вот,', 191);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1032, '2025-08-24 23:06:22.571376+03', 6, NULL, 'однажды ночью мы с Гинни…
   Один из космонавтов, по фамилии Шенке, принес свой аккордеон и стал отбивать чечетку, так что пыль столбом поднялась.
   - Э-эх! - вопил он. - Живем!
   - Ого-го! - горланили остальные, отбросив пустые тарелки.
   Трое стали в ряд и задрыгали ногами, наподобие девиц из бурлеска, выкрикивая соленые шуточки. Другие хлопали в ладоши, требуя отколоть что-нибудь еще. Чероки сбросил рубаху и закружился, сверкая потным торсом. Лунное сияние серебрило его ежик и гладко выбритые молодые щеки.
   Ветер гнал легкий туман над дном пересохшего моря, огромные каменные изваяния глядели с гор на серебристую ракету и крохотный костер.
   Шум и гомон становились сильнее,', 192);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1033, '2025-08-24 23:06:22.571376+03', 6, NULL, 'число танцоров росло, кто-то сосал губную гармонику, другой дул в гребешок, обернутый папиросной бумагой. Еще два десятка бутылок откупорено и выпито. Биггс пьяно топтался вокруг и пытался дирижировать пляской, размахивая руками.
   - Командир, присоединяйтесь! - крикнул Чероки капитану и затянул песню.
   Пришлось и капитану плясать. Он делал это без всякой охоты. Лицо его было сумрачно. Спендер смотрел на него и думал: «Бедняга! Что за ночь! Не ведают они, что творят. Им перед вылетом надо бы инструктаж устроить, объяснить, что надо вести себя на Марсе прилично, хотя бы первые дни».
   - Хватит. - Капитан вышел из круга и сел, сославшись на усталость.', 193);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1034, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Спендер взглянул на грудь капитана. Не сказать, чтобы она вздымалась чаще обычного. И лицо ничуть не вспотело.
   Аккордеон, гармоника, вино, крики, пляска, вопли, возня, лязг посуды, хохот.
   Биггс, шатаясь, побрел на берег марсианского канала. Он захватил с собой шесть пустых бутылок и одну за другой стал бросать их в глубокую голубую воду. Погружаясь, они издавали гулкий, задыхающийся звук.
   - Я нарекаю тебя, нарекаю тебя, нарекаю тебя… - заплетающимся языком бормотал Биггс. - Нарекаю тебя именем Биггс, Биггс, канал Биггса…
   Прежде чем кто-нибудь успел шевельнуться, Спендер вскочил на ноги, прыгнул через костер и подбежал к Биггсу. Он ударил Биггса сперва по зубам, потом в ухо.', 194);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1035, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Биггс покачнулся и упал прямо в воду. Всплеск. Спендер молча ждал, когда Биггс выкарабкается обратно. Но к этому времени остальные уже схватили Спендера за руки.
   - Эй, Спендер, что это на тебя нашло? Ты что? - допытывались они.
   Биггс выбрался на берег и встал на ноги, вода струилась с него на каменные плиты. Он сразу приметил, что Спендера держат.
   - Так, - сказал он и шагнул вперед.
   - Прекратить! - рявкнул капитан Уайлдер.
   Спендера выпустили. Биггс замер, глядя на капитана.
   - Ладно, Биггс, переоденьтесь. Вы, ребята, можете продолжать веселиться! Спендер, пойдемте со мной!
   Веселье возобновилось. Уайлдер отошел в сторону и обернулся к Спендеру.
   - Может быть,', 195);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1036, '2025-08-24 23:06:22.571376+03', 6, NULL, 'вы объясните, в чем дело? - сказал он.
   Спендер смотрел на канал.
   - Не знаю. Мне стало стыдно. За Биггса, за всех нас, за этот содом. Господи, какое безобразие!
   - Путешествие было долгое. Надо же им отвести душу.
   - Но где их уважение, командир? Где чувство пристойности?
   - Вы устали, Спендер, и смотрите на вещи иначе, чем они. Уплатите штраф пятьдесят долларов.
   - Слушаюсь, командир. Но уж очень неприятно, когда подумаешь, что Они видят, как мы дураков корчим.
   - Они?
   - Марсиане, будь то живые или мертвые, все равно.
   - Безусловно, мертвые, - ответил капитан. - Вы думаете, они знают, что мы здесь?
   - Разве старое не знает всегда о появлении нового?
   - Пожалуй.', 196);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1037, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Можно подумать, что вы верите в духов.
   - Я верю в вещи, сделанные трудом, а все вокруг показывает, сколько здесь сделано. Здесь есть улицы, и дома, и книги, наверно, есть, и широкие каналы, башни с часами, стойла - ну, пусть не для лошадей, но все-таки для каких-то домашних животных, скажем, даже с двенадцатью ногами, почем мы можем знать? Куда ни глянешь, всюду вещи и сооружения, которыми пользовались. К ним прикасались, их употребляли много столетий. Спросите меня, верю ли я в душу вещей, вложенную в них теми, кто ими пользовался, - я скажу да. А они здесь, вокруг нас, - вещи, у которых было свое назначение. Горы, у которых были свои имена. Пользуясь этими вещами, мы всегда,', 197);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1038, '2025-08-24 23:06:22.571376+03', 6, NULL, 'неизбежно будем чувствовать себя неловко. И названия гор будут звучать для нас как-то не так - мы их окрестим, а старые-то названия никуда не делись, существуют где-то во времени, для кого-то здешние горы, представления о них были связаны именно с теми названиями. Названия, которые мы дадим каналам, городам, вершинам, скатятся с них как с гуся вода. Мы можем сколько угодно соприкасаться с Марсом - настоящего общения никогда не будет. В конце концов это доведет нас до бешенства и знаете, что мы сделаем с Марсом? Мы его распотрошим, снимем с него шкуру и перекроим ее по своему вкусу.
   - Мы не разрушим Марс, - сказал капитан. - Он слишком велик и великолепен.
   - Вы уверены? У нас, землян,', 198);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1039, '2025-08-24 23:06:22.571376+03', 6, NULL, 'есть дар разрушать великое и прекрасное. Если мы не открыли сосисочную в Египте среди развалин Карнакского храма, то лишь потому, что они лежат на отшибе и там не развернешь коммерции. Но Египет всего лишь клочок нашей планеты. А здесь - здесь все древность, все непохожее, и мы где- нибудь тут обоснуемся и начнем опоганивать этот мир. Вот этот канал назовем в честь Рокфеллера, эту гору назовем горой короля Георга, и море будет морем Дюпона, там вон будут города Рузвельт, Линкольн и Кулидж, но это все будет неправильно, потому что у каждого места уже есть свое,собственноеимя.
   - Это уж ваше дело, археологов, раскапывать старые названия, а мы что ж, мы согласны ими пользоваться.', 199);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1040, '2025-08-24 23:06:22.571376+03', 6, NULL, '- Кучка людей вроде нас - против всех дельцов и трестов? - Спендер поглядел на отливающие металлом горы. - Онизнают,что мы сегодня появились здесь, будем пакостить им; они должны нас ненавидеть.
   Капитан покачал головой.
   - Здесь нет ненависти. - Он прислушался к ветру. - Судя по их городам, это были добрые, красивые, мудрые люди. Они принимали свою судьбу как должное. Очевидно, смирились с тем, что им вымирать, и не затеяли с отчаяния никакой опустошительной войны напоследок, не стали уничтожать своих городов. Все города, которые мы до сих пор видели, сохранились в полной неприкосновенности. Сдается мне, мы им мешаем не больше, чем помешали бы дети, играющие на газоне,', 200);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1041, '2025-08-24 23:06:22.571376+03', 6, NULL, '- велик ли спрос с ребенка? И кто знает, быть может, в конечном счете все это изменит нас к лучшему. Вы обратили внимание, Спендер, на необычно тихое поведение наших людей, пока Биггс не навязал им это веселье? Как смирно, даже робко они держались! Еще бы, лицом к лицу со всем этим сразу сообразишь, что мы не так уж сильны. Мы просто дети в коротких штанишках, шумные и непоседливые дети, которые носятся со своими ракетными и атомными игрушками. Но ведь когда-нибудь Земля станет такой, каков Марс теперь. Так что Марс нас отрезвит. Наглядное пособие по истории цивилизации. Полезный урок. А теперь - выше голову! Пойдем играть в веселье. Да, штраф остается в силе.

   Но веселье не ладилось.', 201);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1042, '2025-08-24 23:06:22.571376+03', 6, NULL, 'С мертвого моря упорно дул ветер. Он вился вокруг космонавтов, вокруг капитана и Джеффа Спендера, когда те шли обратно к остальным. Ветер ворошил пыль и обтекал сверкающую ракету, теребил аккордеон, и пыль покрыла исцелованную губную гармонику Она засоряла им глаза, и от ветра в воздухе звучала высокая певучая нота. Вдруг он стих, так же неожиданно, как начался.
   Но и веселье тоже стихло.
   Люди застыли неподвижно под равнодушным черным небом.
   - А ну, ребята, давай! - Биггс, в чистой сухой одежде, выскочил из ракеты, стараясь не глядеть на Спендера. Звук его голоса погас, будто в пустом зале. Будто никого вокруг нет - Давайте все сюда!
   Никто не тронулся с места.
   - Эй, Уайти,', 202);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1043, '2025-08-24 23:06:22.571376+03', 6, NULL, 'что же твоя гармоника?
   Уайти выдул какую-то трель. Она прозвучала фальшиво и нелепо. Уайти вытряхнул из инструмента влагу и убрал его в карман.
   - Вы что,на поминках,что ли? - не унимался Биггс.
   Кто-то сжал в объятиях аккордеон. Он издал звук, похожий на предсмертный стон животного. И все.
   - Ладно, тогда мы с бутылочкой повеселимся вдвоем. - Биггс уселся, прислонившись к ракете, и поднес ко рту карманную фляжку.
   Спендер не сводил с него глаз. Долго стоял неподвижно. Потом его пальцы тихонько, медленно поползли вверх по дрожащему бедру, нащупали пистолет и стали поглаживатькожаную кобуру.
   - Кто хочет, может пойти со мной в город, - объявил капитан.', 203);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1044, '2025-08-24 23:06:22.571376+03', 6, NULL, '- Поставим охрану у ракеты и захватим с собой оружие - на всякий случай.
   Желающие построились и рассчитались по порядку. Их оказалось четырнадцать, включая Биггса, который стал в строй, гогоча и размахивая бутылкой. Шесть человек решили остаться.
   - Ну, потопали! - заорал Биггс.
   Отряд молча зашагал по долине, залитой лунным светом. Они пришли на окраину дремлющего мертвого города, озаренного светом двух догоняющих друг друга лун. Тени, протянувшиеся от их ног, были двойными. Несколько минут космонавты стояли, затаив дыхание. Ждали: вот сейчас что-нибудь шевельнется в этом безжизненном городе, возникнет какой-нибудь туманный силуэт,', 204);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1045, '2025-08-24 23:06:22.571376+03', 6, NULL, 'промчится галопом по бесплодному морскому дну этакий призрак седой старины верхом на закованном в латы древнем коне немыслимых кровей с невиданной родословной.
   Воображение Спендера оживляло пустынные городские улицы. Голубыми светящимися призраками шли люди по проспектам, замощенным камнем, слышалось невнятное бормотание, странные животные стремительно бежали по серовато-красному песку. В каждом окне кто-то стоял и, перегнувшись через подоконник, медленно поводил руками, точно утонувший в водах вечности, махая каким-то силуэтам, движущимся в бездонном пространстве у подножия посеребренных луной башен. Внутренний слух улавливал музыку, - и Спендер попытался представить себе,', 205);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1046, '2025-08-24 23:06:22.571376+03', 6, NULL, 'как могут выглядеть инструменты, которые так звучат… Город был полон видениями.
   - Э-гей! - крикнул Биггс, выпрямившись и сложив ладони рупором. - Эй, кто тут есть в городе, отзовись!
   - Биггс! - сказал капитан.
   Биггс умолк.
   Они ступили на улицу, вымощенную плитами. Теперь они говорили только шепотом, потому что у них было такое чувство, будто они вошли в огромный читальный зал под открытым небом или в усыпальницу, где только ветер да яркие звезды над головой. Капитан заговорил вполголоса. Ему хотелось знать, куда девались жители города, что за люди они были, какие короли ими правили, отчего они умерли. Он тихо вопрошал: как сумели они построить такой долговечный город?', 206);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1047, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Побывали ли они на Земле? Не они ли десятки тысяч лет назад положили начало роду землян? Так же ли любили они и ненавидели, как мы? И были ли их безрассудства такими же, когда они совершали их?
   Они замерли. Луны точно околдовали, заморозили их; тихий ветер овевал их.
   - Лорд Байрон, - сказал Джефф Спендер.
   - Какой лорд? - Капитан повернулся к нему.
   - Лорд Байрон, поэт, жил в девятнадцатом веке. Давным-давно он написал стихотворение. Оно удивительно подходит к этому городу и выражает чувства, которые должны были бы испытывать марсиане. Если только здесь осталось кому чувствовать. Такие стихи мог бы написать последний марсианский поэт.
   Люди стояли неподвижно, и тени их замерли.', 207);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1048, '2025-08-24 23:06:22.571376+03', 6, NULL, '- Что же это за стихотворение? - спросил капитан.
   Спендер переступил с ноги на ногу, поднял руку, вспоминая, на мгновение зажмурился, затем его тихий голос стал неторопливо произносить слова стихотворения, и все слушали его, не отрываясь:Не бродить уж нам ночами,Хоть душа любви полна,И по-прежнему лучамиСеребрит простор луна.
   Город был пепельно-серый, высокий, безмолвный. Лица людей обратились к лунам.Меч сотрет железо ножен,И душа источит грудь,Вечный пламень невозможен,Сердцу нужно отдохнуть.Пусть влюбленными лучамиМесяц тянется к земле,Не бродить уж нам ночамиВ серебристой лунной мгле.
   Земляне молча стояли в центре города. Ночь была ясна и безоблачна.', 208);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1049, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Кроме свиста ветра - ни звука кругом. Перед ними расстилалась площадь, и плиточная мозаика изображала древних животных и людей. Они стояли и смотрели.
   Биггс издал рыгающий звук. Глаза его помутнели. Руки метнулись ко рту, он судорожно глотнул, зажмурился, согнулся пополам. Густая струя наполнила рот и вырвалась, хлынула с плеском прямо на плиты, заливая изображения. Так повторилось дважды. В прохладном воздухе разнесся кислый винный запах. Никто не шевельнулся помочь Биггсу.Его продолжало тошнить.
   Мгновение Спендер смотрел на него, затем повернулся и пошел прочь. В полном одиночестве он шел по озаренным луной улицам города и ни разу не остановился, чтобы оглянуться на своих товарищей.', 209);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1050, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Они легли спать около четырех утра. Вытянувшись на одеялах, закрыли глаза и вдыхали неподвижный воздух. Капитан Уайлдер сидел возле костра, подбрасывая в него сучья.
   Два часа спустя Мак-Клюр открыл глаза.
   - Вы не спите, командир?
   - Жду Спендера. - Капитан слабо улыбнулся.
   Мак-Клюр подумал.
   - Знаете, командир, мне кажется, он не придет. Сам не знаю почему, но у меня такое чувство. Не придет он.
   Мак-Клюр повернулся на другой бок. Огонь рассыпался трескучими искрами и потух.
   Прошла целая неделя, а Спендер не появлялся. Капитан разослал на поиски его несколько отрядов, но они вернулись и доложили, что не понимают, куда он мог деться. Ничего,', 210);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1051, '2025-08-24 23:06:22.571376+03', 6, NULL, 'надоест шляться - сам придет. И вообще он нытик и брюзга. Ушел, и черт с ним!
   Капитан промолчал, но записал все в корабельный журнал…
   Однажды утром - это мог быть понедельник, или вторник, или любой иной марсианский день - Биггс сидел на краю канала, подставив лицо солнечным лучам и болтая ногами в прохладной воде.
   Вдоль канала шел человек. Его тень упала на Биггса. Биггс открыл глаза.
   - Будь я проклят! - воскликнул Биггс.
   - Я последний марсианин, - сказал человек, доставая пистолет.
   - Что ты сказал? - спросил Биггс.
   - Я убью тебя.
   - Брось. Что за глупые шутки, Спендер?
   - Встань, умри, как мужчина.
   - Бога ради, убери пистолет.', 211);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1052, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Спендер нажал курок только один раз. Мгновение Биггс еще сидел на краю канала, потом наклонился вперед и упал в воду. Выстрел был очень тихим - как шелест, как слабоежужжание. Тело медленно, отрешенно погрузилось в неторопливые струи канала, издавая глухой булькающий звук, который вскоре прекратился.
   Спендер убрал пистолет в кобуру и неслышными шагами пошел дальше. Солнце светило сверху на Марс, его лучи припекали кожу рук, жарко гладили непроницаемое лицо Спендера. Он не стал бежать, шел так, будто с прошлого раза ничего не изменилось, если не считать, что теперь был день. Он подошел к ракете, несколько человек уписывали только что приготовленный завтрак под навесом,', 212);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1053, '2025-08-24 23:06:22.571376+03', 6, NULL, 'который оставил кок.
   - А вот и наш Одинокий Волк идет, - сказал кто-то.
   - Пришел, Спендер! Давненько не виделись!
   Четверо за столом пристально смотрели на человека, который молча глядел на них.
   - Дались тебе эти проклятые развалины, - усмехнулся кок, помешивая какое-то черное варево в миске. - Ну, чисто голодный пес, который до костей дорвался.
   - Возможно, - ответил Спендер. - Мне надо было кое-что выяснить. Что вы скажете, если я вам сообщу, что видел здесь по соседству марсианина?
   Четверо космонавтов отложили свои вилки.
   - Марсианина? Где?
   - Это не важно. Позвольте мне задать вам один вопрос. Как бы вы себя чувствовали на месте марсиан,', 213);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1054, '2025-08-24 23:06:22.571376+03', 6, NULL, 'если бы в вашу страну явились люди и стали бы все громить?
   - Я-то знаю, что бы я чувствовал, - сказал Чероки. - В моих жилах есть кровь племени чероков. Мой дед немало мне порассказал из истории Оклахомы. Так что, если тут остались марсиане, я их понимаю.
   - А вы? - осторожно спросил Спендер остальных.
   Никто не ответил, молчание было достаточно красноречиво. Дескать, грабастай, сколько захватишь, что нашел - все твое, если ближний подставил щеку - вдарь покрепче, и так далее в том же духе.
   - Ну, так вот, - сказал Спендер. - Я встретил марсианина.
   Они недоверчиво смотрели на него.
   - Там, в одном из мертвых поселений. Я и не подозревал, что встречу его.', 214);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1055, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Даже не собирался искать. Не знаю, что он там делал. Эту неделю я прожил в маленьком городке, пытался разобрать древние письмена, изучал их старинное искусство. И вот однажды увидел марсианина. Он только на миг появился и тут же пропал. Потом дня два не показывался. Я сидел над письменами, когда он снова пришел. И так несколько раз, с каждым разом все ближе и ближе. В тот день, когда я наконец освоил марсианский язык, - это удивительно просто, и очень помогают пиктограммы - марсианин появился передо мной и сказал: «Дайте мне ваши башмаки». Я отдал ему башмаки, а он говорит: «Дайте мне ваше обмундирование и все, что на вас надето». Я все отдал, он опять: «Дайте пистолет». Подаю пистолет.', 215);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1056, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Тогда он говорит: «А теперь пойдемте со мной и смотрите, что будет». И марсианин пошел в лагерь, и вот он здесь.
   - Не вижу никакого марсианина, - возразил Чероки.
   - Очень жаль.
   Спендер выхватил из кобуры пистолет. Послышалось слабое жужжание. Первая пуля поразила крайнего слева, вторая и третья - крайнего справа и того, что сидел посредине. Кок испуганно обернулся от костра и был сражен четвертой пулей. Он упал плашмя в огонь и остался лежать, его одежда загорелась.
   Ракета стояла, залитая солнцем. Три человека сидели за столом, и руки их неподвижно лежали возле тарелок, на которых остывал завтрак. Один Чероки, невредимый, с тупым недоумением глядел на Спендера.', 216);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1057, '2025-08-24 23:06:22.571376+03', 6, NULL, '- Можешь пойти со мной, - сказал Спендер.
   Чероки не ответил.
   - Слышишь, я принимаю тебя в свою компанию. - Спендер ждал.
   Наконец к Чероки вернулся дар речи.
   - Ты их убил, - произнес он и заставил себя взглянуть на сидящих напротив.
   - Они это заслужили.
   - Ты сошел с ума!
   - Возможно. Но ты можешь пойти со мной.
   - Пойти с тобой - зачем? - вскричал Чероки, мертвенно бледный, со слезами на глазах. - Уходи, убирайся прочь!
   Лицо Спендера окаменело.
   - Я-то думал, хоть ты меня поймешь.
   - Убирайся! - Рука Чероки потянулась за пистолетом.
   Спендер выстрелил в последний раз. Больше Чероки не двигался.
   Зато покачнулся Спендер. Он провел ладонью по потному лицу.', 217);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1058, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Он поглядел на ракету, и вдруг его начала бить дрожь. Он едва не упал, настолько сильна была реакция. Его лицо было лицом человека, который приходит в себя после гипноза, после сновидения. Он сел, чтобы справиться с дрожью.
   - Перестать! Сейчас же! - приказал он своему телу.
   Каждая клеточка судорожно дрожала.
   - Перестань!
   Он сжал тело в тисках воли, пока не выдавил из него всю дрожь, до последнего остатка. Теперь руки лежали спокойно на усмиренных коленях.
   Он встал и с неторопливой тщательностью закрепил на спине ранец с продуктами. На какую-то крохотную долю секунды его руки опять задрожали, но Спендер очень решительно скомандовал: «Нет!», и дрожь прошла.', 218);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1059, '2025-08-24 23:06:22.571376+03', 6, NULL, 'И он побрел прочь на негнущихся ногах и затерялся среди раскаленных красных гор. Один.

   Полыхающее солнце поднялось выше в небе. Час спустя капитан вылез из ракеты позавтракать. Он уже было открыл рот, чтобы поздороваться с космонавтами, сидящими за столом, но осекся, уловив в воздухе легкий запах пистолетного дыма. Он увидел, что кок лежит на земле, накрыв своим телом костер. Четверо сидели перед остывшим завтраком.
   По трапу спустились Паркхилл и еще двое. Капитан стоял, загородив им путь, не в силах отвести глаз от молчаливых людей за столом, от их странных поз.
   - Собрать всех людей! - приказал капитан.
   Паркхилл побежал вдоль канала.
   Капитан тронул рукой Чероки.', 219);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1060, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Чероки медленно согнулся и упал со стула. Солнечные лучи осветили его жесткий ежик и скуластое лицо.
   Экипаж собрался.
   - Кого недостает?
   - Все того же Спендера. Биггса мы нашли в канале.
   - Спендер!
   Капитан посмотрел на устремленные в дневное небо горы. Солнце высветило его зубы, обнаженные гримасой.
   - Черт бы его побрал, - устало произнес капитан. - Почему он не пришел ко мне, я бы поговорил с ним.
   - Нет, вот я бы с ним поговорил! - крикнул Паркхилл, яростно сверкнув глазами. - Я бы раскроил ему башку и выпустил мозги наружу!
   Капитан Уайлдер кивком подозвал двоих.
   - Возьмите лопаты, - сказал он.
   Копать было жарко. С высохшего моря летел теплый ветер,', 220);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1061, '2025-08-24 23:06:22.571376+03', 6, NULL, 'он швырял им пыль в лицо, а капитан листал библию. Но вот он закрыл книгу, и с лопат на завернутые в ткань тела потекли медленные струи песка.
   Они вернулись к ракете, щелкнули затворами своих винтовок, подвесили к поясу сзади связки гранат, проверили, легко ли вынимаются из кобуры пистолеты. Каждому был отведен определенный участок гор. Капитан говорил, куда кому идти, не повышая голоса, руки его вяло висели, он ни разу не шевельнул ими.
   - Пошли, - сказал он.

   Спендер увидел, как в разных концах долины поднимаются облачка пыли, и понял, что преследование началось по всем правилам. Он опустил плоскую серебряную книгу, которую читал, удобно примостившись на большом камне.', 221);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1062, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Страницы книги были из чистейшего тонкого, как папиросная бумага, листового серебра, разрисованные от руки чернью и золотом. Это был философский трактат десятитысячелетней давности, найденный им в одной из вилл небольшого марсианского селения. Спендеру не хотелось отрываться от книги.
   Он даже подумал сперва: «А стоит ли? Буду сидеть и читать, пока не придут и не убьют меня».
   Утром, после того как он застрелил шесть человек, Спендер ощутил тупую опустошенность, потом его тошнило, и наконец им овладел странный покой. Но и это чувство было преходящим, потому что при виде пыли, которая обозначала путь преследователей, он снова ощутил ожесточение.', 222);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1063, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Он глотнул холодной воды из походной фляги. Потом встал, потянулся, зевнул и прислушался к упоительной тишине окружавшей его долины. Эх, если бы он и еще несколько людей оттуда, с Земли, могли вместе поселиться здесь и дожить свою жизнь без шума, без тревог…
   Спендер взял в одну руку книгу, а в другую - пистолет. Рядом протекала быстрая речка с дном из белой гальки и большими камнями на берегах. Он разделся на камнях и вошел в воду ополоснуться. Он не спешил и, лишь поплескавшись вволю, оделся и снова взял пистолет.
   Первые выстрелы раздались около трех часов дня. К этому времени Спендер ушел высоко в горы. Погоня шла следом. Миновали три горных марсианских городка.', 223);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1064, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Над ними были разбросаны виллы марсиан.
   Облюбовав себе зеленый лужок и быстрый ручей, древние марсианские семьи выложили из плиток бассейны, построили библиотеки, разбили сады с журчащими фонтанами. Спендер позволил себе поплавать с полчаса в наполненном дождевой водой бассейне, ожидая, когда приблизится погоня.
   Покидая виллу, он услышал выстрелы. Позади него, в каких-нибудь пяти метрах, взорвался осколками кирпич. Спендер побежал, укрываясь за скальными выступами, обернулся и первым же выстрелом уложил наповал одного из преследователей.
   Спендер знал, что его возьмут в кольцо и он окажется в ловушке. Окружат со всех сторон, и станут сходиться, и прикончат его. Странно даже,', 224);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1065, '2025-08-24 23:06:22.571376+03', 6, NULL, 'что они еще не пустили в ход гранаты. Капитану Уайлдеру достаточно слово сказать…
   «Я слишком тонкое изделие, чтобы превращать меня в крошево, - подумал Спендер. - Вот что сдерживает капитана. Ему хочется, чтобы дело ограничилось одной аккуратной дырочкой. Чудно… Хочется, чтобы я умер благопристойно. Никаких луж крови. Почему? Да потому, что он меня понимает. Вот почему он готов рисковать своими лихими ребятами, лишь бы уложить меня точным выстрелом в голову. Разве не так?»
   Девять-десять выстрелов прогремели один за другим, подбрасывая камни вокруг Спендера. Он методично отстреливался, иногда даже не отрываясь от серебряной книги, которую не выпускал из рук.', 225);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1066, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Капитан выскочил из-за укрытия под жаркие лучи солнца с винтовкой в руках. Спендер проводил его мушкой пистолета, но стрелять не стал. Вместо этого он выбрал другуюцель и сбил пулей верхушку камня, за которым лежал Уайти. Оттуда донесся злобный крик.
   Вдруг капитан выпрямился во весь рост, держа белый платок в поднятой руке. Он что-то сказал своим людям и, отложив винтовку в сторону, пошел вверх по склону. Спендер немного выждал, потом и он поднялся на ноги, с пистолетом наготове.
   Капитан подошел и сел на горячий камень, избегая смотреть на Спендера.
   Рука капитана потянулась к карману куртки. Спендер крепче сжал пистолет.
   - Сигарету? - предложил капитан.
   - Спасибо.', 226);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1067, '2025-08-24 23:06:22.571376+03', 6, NULL, '- Спендер взял одну.
   - Огоньку?
   - Свои есть.
   Они затянулись раз-другой в полной тишине.
   - Жарко, - сказал капитан.
   - Очень.
   - Как вы тут, хорошо устроились?
   - Отлично.
   - И сколько думаете продержаться?
   - Столько, сколько нужно, чтобы уложить дюжину человек.
   - Почему вы не убили всех нас утром, когда была возможность? Вы вполне могли это сделать.
   - Знаю. Духу не хватило. Когда тебе что-нибудь втемяшится в голову, начинаешь лгать самому себе. Говоришь, что все остальные неправы, а ты прав. Но едва я начал убивать этих людей, как сообразил, что они просто глупцы и зря я на них поднял руку. Поздно сообразил. Тогда я не мог заставить себя продолжать,', 227);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1068, '2025-08-24 23:06:22.571376+03', 6, NULL, 'вот и ушел сюда, чтобы еще разсолгать себе и разозлиться, восстановить нужное настроение.
   - Восстановили?
   - Не совсем. Но вполне достаточно.
   Капитан разглядывал свою сигарету.
   - Почему вы так поступили?
   Спендер спокойно положил пистолет у своих ног.
   - Потому что нам можно только мечтать обо всем том, что я увидел у марсиан. Они остановились там, где нам надо было остановиться сто лет назад. Я походил по их городам, узнал этот народ и был бы счастлив назвать их своими предками.
   - Да, там у них чудесный город. - Капитан кивком головы указал на один из городов.
   - Не только в этом дело. Конечно, их города хороши. Марсиане сумели слить искусство со своим бытом.', 228);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1069, '2025-08-24 23:06:22.571376+03', 6, NULL, 'У американцев искусство всегда особая статья, его место - в комнате чудаковатого сына наверху. Остальные принимают его, так сказать, воскресными дозами, кое-кто в смеси с религией. У марсиан есть все - и искусство, и религия, и другое…
   - Думаете, они дознались, что к чему?
   - Уверен.
   - И по этой причине вы стали убивать людей.
   - Когда я был маленьким, родители взяли меня с собой в Мехико-сити. Никогда не забуду, как отец там держался - крикливо, чванно. Что до матери, то ей тамошние люди не понравились тем, что они-де редко умываются и кожа у них темная. Сестра - та вообще избегала с ними разговаривать. Одному мне они пришлись по душе. И я отлично представляю себе, что,', 229);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1070, '2025-08-24 23:06:22.571376+03', 6, NULL, 'попади отец и мать на Марс, они повели бы себя здесь точно так же. Средний американец от всего необычного нос воротит. Если нет чикагского клейма, значит,никуда не годится. Подумать только! Боже мой, только подумать! А война! Вы ведь слышали речи в конгрессе перед нашим вылетом! Мол, если экспедиция удастся, на Марсе разместят три атомные лаборатории и склады атомных бомб. Выходит, Марсу конец; все эти чудеса погибнут. Ну, скажите, что вы почувствовали бы, если бы марсианин облевалполы Белого дома?
   Капитан молчал и слушал.
   Спендер продолжал:
   - А все прочие воротилы? Боссы горной промышленности, бюро путешествий… Помните, что было с Мексикой,', 230);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1071, '2025-08-24 23:06:22.571376+03', 6, NULL, 'когда туда из Испании явился Кортес со своей милой компанией? Какую культуру уничтожили эти алчные праведники-изуверы! История не простит Кортеса.
   - Нельзя сказать, что вы сами сегодня вели себя нравственно, - заметил капитан.
   - А что мне оставалось делать? Спорить с вами? Ведь я один - один против всей этой подлой, ненасытной шайки там, на Земле. Они же сразу примутся сбрасывать здесь свои мерзкие атомные бомбы, драться за базы для новых войн. Мало того, что одну планету разорили, надо и другим все изгадить? Тупые болтуны. Когда я попал сюда, мне показалось, что я избавлен не только от этой их так называемой культуры, но и от их этики, от их обычаев. Решил,', 231);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1072, '2025-08-24 23:06:22.571376+03', 6, NULL, 'что здесь их правила и устои меня больше не касаются. Оставалосьтолько убить всех вас и зажить на свой лад.
   - Но вышло иначе.
   - Да. Когда я убил пятого там, у ракеты, я понял, что не сумел обновиться полностью, не стал настоящим марсианином. Не так-то легко оказалось избавиться от всего того, что к тебе прилипло на Земле. Но теперь мои колебания прошли. Я убью вас, всех до одного. Это задержит отправку следующей экспедиции самое малое лет на пять. Наша ракета единственная, других таких сейчас нет. На Земле будут ждать вестей от нас год, а то и два, и, так как они о нас ничего не узнают, им будет страшно снаряжать новую экспедицию. Ракету будут строить вдвое дольше,', 232);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1073, '2025-08-24 23:06:22.571376+03', 6, NULL, 'сделают лишнюю сотню опытных конструкций, чтобы застраховаться от новых неудач.
   - Расчет верный.
   - Если же вы возвратитесь с хорошими новостями, это ускорит массовое вторжение на Марс. А так, даст бог, доживу до шестидесяти и буду встречать каждую новую экспедицию. За один раз больше одной ракеты не пошлют - и не чаще чем раз в год, - и экипаж не может превышать двадцать человек. Я, конечно, подружусь с ними, расскажу, что наша ракета неожиданно взорвалась, - я взорву ее на этой же неделе, как только управлюсь с вами, - а потом всех их прикончу. На полвека-то удастся отстоять Марс; земляне, вероятно, скоро прекратят попытки. Помните, как люди остыли к строительству цеппелинов,', 233);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1074, '2025-08-24 23:06:22.571376+03', 6, NULL, 'которые все время загорались и падали?
   - Вы все продумали, - признал капитан.
   - Вот именно.
   - Кроме одного: нас слишком много. Через час кольцо сомкнется. Через час вы будете мертвы.
   - Я обнаружил подземные ходы и надежные убежища, которых вам ни за что не найти. Уйду туда, отсижусь несколько недель. Ваша бдительность ослабнет. Тогда я выйду и снова ухлопаю вас одного за другим.
   Капитан кивнул.
   - Расскажите мне про эту вашу здешнюю цивилизацию, - сказал он, показав рукой в сторону горных селений.
   - Они умели жить с природой в согласии, в ладу. Не лезли из кожи вон, чтобы провести грань между человеком и животным. Эту ошибку допустили мы, когда появился Дарвин.', 234);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1075, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Ведь что было у нас: сперва обрадовались, поспешили заключить в свои объятия и его, и Гексли, и Фрейда. Потом вдруг обнаружили, что Дарвин никак не согласуется с нашейрелигией. Во всяком случае, нам так показалось. Но ведь это глупо! Захотели немного потеснить Дарвина, Гексли, Фрейда. Они не очень-то поддавались. Тогда мы принялись сокрушать религию. И отлично преуспели. Лишились веры и стали ломать себе голову над смыслом жизни. Если искусство - всего лишь выражение неудовлетворенных страстей, если религия - самообман, то для чего мы живем? Вера на все находила ответ. Но с приходом Дарвина и Фрейда она вылетела в трубу. Как был род человеческий заблудшим, так и остался.
   - А марсиане,', 235);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1076, '2025-08-24 23:06:22.571376+03', 6, NULL, 'выходит,нашливерный путь? - осведомился капитан.
   - Да. Они сумели сочетать науку и веру так, что те не отрицали одна другую, а взаимно помогали, обогащали.
   - Прямо идеал какой-то!
   - Так оно и было. Мне очень хочется показать вам, как это выглядело на деле.
   - Мои люди ждут меня.
   - Каких-нибудь полчаса. Предупредите их, сэр.
   Капитан помедлил, потом встал и крикнул своему отряду, который залег внизу, чтобы они не двигались с места.
   Спендер повел его в небольшое марсианское селение, сооруженное из безупречного прохладного мрамора. Они увидели большие фризы с изображением великолепных животных, каких-то кошек с белыми лапами и желтые круги - символы солнца,', 236);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1077, '2025-08-24 23:06:22.571376+03', 6, NULL, 'увидели изваяния животных, напоминавших быков, скульптуры мужчин, женщин и огромных собак с благородными мордами.
   - Вот вам ответ, капитан.
   - Не вижу.
   - Марсиане узнали тайну жизни у животных. Животное не допытывается, в чем смысл бытия. Оно живет. Живет ради жизни. Для него ответ заключен в самой жизни, в ней и радость, и наслаждение. Вы посмотрите на эти скульптуры: всюду символические изображения животных.
   - Язычество какое-то.
   - Напротив, это символы бога, символы жизни. На Марсе тоже была пора, когда в Человеке стало слишком много от человека и слишком мало от животного. Но люди Марса поняли: чтобы выжить, надо перестать допытываться, в чем смысл жизни.', 237);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1078, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Жизнь сама по себе есть ответ. Цель жизни в том, чтобы воспроизводить жизнь и возможно лучше ее устроить. Марсиане заметили, что вопрос: «Для чего жить?» - родился у них в разгар периода воин и бедствий, когда ответа не могло быть. Но стоило цивилизации обрести равновесие, устойчивость, стоило прекратиться войнам, как этот вопрос опять оказался бессмысленным, уже совсем по-другому. Когда жизнь хороша, спорить о ней незачем.
   - Послушать вас, так марсиане были довольно наивными.
   - Только там, где наивность себя оправдывала. Они излечились от стремления все разрушать, все развенчивать. Они слили вместе религию, искусство и науку: ведь наука вконечном счете - исследование чуда,', 238);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1079, '2025-08-24 23:06:22.571376+03', 6, NULL, 'коего мы не в силах объяснить, а искусство - толкование этого чуда. Они не позволяли науке сокрушать эстетическое, прекрасное. Это же все вопрос меры. Землянин рассуждает: «В этой картине цвета как такового нет. Наука может доказать, что цвет - это всего-навсего определенное расположение частиц вещества, особым образом отражающих свет. Следовательно, цвет не является действительной принадлежностью предметов, которые попали в поле моего зрения». Марсианин, как более умный, сказал бы так: «Это чудесная картина. Она создана рукой и мозгом вдохновенного человека. Ее идея и краски даны жизнью. Отличная вещь».
   Они помолчали. Сидя в лучах предвечернего солнца,', 239);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1080, '2025-08-24 23:06:22.571376+03', 6, NULL, 'капитан с любопытством разглядывал безмолвный мраморный городок.
   - Я бы с удовольствием здесь поселился, - сказал он.
   - Вам стоит только захотеть.
   - Вы предлагаете этомне?
   - Кто из ваших людей способен по-настоящему понять все это? Они же профессиональные циники, их уже не исправишь. Ну зачем вам возвращаться на Землю вместе с ними? Чтобы тянуться за Джонсами? Чтобы купить себе точно такой вертолет, как у Смита? Чтобы слушать музыку не душой, а бумажником? Здесь, в одном дворике, я нашел запись марсианской музыки, ей не менее пятидесяти тысяч лет. Она все еще звучит. Такой музыки вы в жизни больше нигде не услышите. Оставайтесь и будете слушать. Здесь есть книги.', 240);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1081, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Я уже довольно свободно их читаю. И вы могли бы.
   - Это все довольно заманчиво.
   - И все же вы не останетесь?
   - Нет. Но за предложение все-таки спасибо.
   - И вы, разумеется, не согласны оставить меня в покое. Мне придется всех вас убить.
   - Вы оптимист.
   - Мне есть за что сражаться и ради чего жить, поэтому я лучше вас преуспею в убийстве. У меня теперь появилась, так сказать, своя религия: я заново учусь дышать, лежать на солнышке, загорать, впитывая солнечные лучи, слушать музыку и читать книги. А что мне может предложить ваша цивилизация?
   Капитан переступил с ноги на ногу и покачал головой.
   - Мне очень жаль, что так получается. Обидно за все это…
   - Мне тоже.', 241);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1082, '2025-08-24 23:06:22.571376+03', 6, NULL, 'А теперь, пожалуй, пора отвести вас обратно, чтобы вы могли начать вашу атаку.
   - Пожалуй.
   - Капитан, вас я убивать не стану. Когда все будет кончено, вы останетесь живы.
   - Что?
   - Я с самого начала решил пощадить вас.
   - Вот как…
   - Я спасу вас от тех, остальных. Когда они будут убиты, вы, может быть, передумаете.
   - Нет, - сказал капитан. - В моих жилах слишком много земной крови. Я не смогу дать вам уйти.
   - Даже если у вас будет возможность остаться здесь?
   - Да, как ни странно, даже тогда. Не знаю почему. Никогда не задавался таким вопросом. Ну, вот и пришли.
   Они вернулись на прежнее место.
   - Пойдете со мной добровольно, Спендер? Предлагаю в последний раз.', 242);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1083, '2025-08-24 23:06:22.571376+03', 6, NULL, '- Благодарю. Не пойду. - Спендер вытянул вперед одну руку. - И еще одно, напоследок. Если вы победите, сделайте мне услугу. Постарайтесь, насколько это в ваших силах, оттянуть растерзание этой планеты хотя бы лет на пятьдесят, пусть сперва археологи потрудятся как следует. Обещаете?
   - Обещаю.
   - И еще, если от этого кому-нибудь будет легче, считайте меня безнадежным психопатом, который летним днем окончательно свихнулся, да так и не пришел в себя. Может, вам легче будет…
   - Я подумаю. Прощайте, Спендер. Счастливо.
   - Вы странный человек, - сказал Спендер, когда капитан зашагал вниз по тропе, навстречу теплому ветру.
   Капитан наконец вернулся к своим запыленным людям,', 243);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1084, '2025-08-24 23:06:22.571376+03', 6, NULL, 'которые уже не чаяли его дождаться. Он щурился на солнце и тяжело дышал.
   - Выпить есть у кого? - спросил капитан.
   Он почувствовал, как ему сунули в руку прохладную флягу.
   - Спасибо.
   Он глотнул. Вытер рот.
   - Ну, так, - сказал капитан. - Будьте осторожны. Спешить некуда, времени у нас достаточно. С нашей стороны больше жертв быть не должно. Вам придется убить его. Он отказался пойти со мной добровольно. Постарайтесь уложить его одним выстрелом. Не превращайте в решето. Надо кончать.
   - Я раскрою ему его проклятую башку, - буркнул Сэм Паркхилл.
   - Нет, только в сердце, - сказал капитан. Он отчетливо видел перед собой суровое, полное решимости лицо Спендера.', 244);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1085, '2025-08-24 23:06:22.571376+03', 6, NULL, '- Его проклятую башку, - повторил Паркхилл.
   Капитан швырнул ему флягу.
   - Вы слышали мой приказ? Только в сердце.
   Паркхилл что-то буркнул себе под нос.
   - Пошли, - сказал капитан.

   Они снова рассыпались, перешли с шага на бег, затем опять на шаг, поднимаясь по жарким склонам, то ныряя в холодные, пахнущие мхом пещеры, то выскакивая на ярко освещенные открытые площадки, где пахло раскаленным камнем.
   "Как противно быть ловким и расторопным, - думал капитан, - когда в глубине души не чувствуешь себя ловким ине хочешьим быть. Подбираться тайком, замышлять всякие хитрости и гордиться своим коварством. Ненавижу это чувство правоты, когда в глубине души я не уверен, что прав.', 245);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1086, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Кто мы, если разобраться? Большинство?… Чем не ответ: ведь большинство всегда непогрешимо, разве нет? Всегда - и не может даже на миг ошибиться, разве не так? Не ошибается даже раз в десять миллионов лет?…"
   Он думал: «Что представляет собой это большинство и кто в него входит? О чем они думают, и почему они стали именно такими, и неужели никогда не переменятся, и еще - какого черта меня занесло в это треклятое большинство? Мне не по себе. В чем тут причина: клаустрофобия, боязнь толпы или просто здравый смысл? И может ли один человек быть правым, когда весь мир уверен в своей правоте? Не будем об этом думать. Будем ползать на брюхе, подкрадываться, спускать курок! Вот так!', 246);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1087, '2025-08-24 23:06:22.571376+03', 6, NULL, 'И так!»
   Его люди перебегали, падали, снова перебегали, приседая в тени, и скалили зубы, хватая ртом воздух, потому что атмосфера была разреженная, бегать в ней тяжело; атмосфера была разреженная, и им приходилось по пяти минут отсиживаться, тяжело дыша, - и черные искры перед глазами, - глотать бедный кислородом воздух, которым никак не насытишься, наконец, стиснув зубы, опять вставать на ноги и поднимать винтовки, чтобы раздирать этот разреженный летний воздух огнем и громом.
   Спендер лежал там, где его оставил капитан, изредка стреляя по преследователям.
   - Размажу по камням его проклятые мозги! - завопил Паркхилл и побежал вверх по склону.
   Капитан прицелился в Сэма Паркхилла.', 247);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1088, '2025-08-24 23:06:22.571376+03', 6, NULL, 'И отложил пистолет, с ужасом глядя на него.
   - Что вы затеяли? - спросил он обессилевшую руку и пистолет.
   Он едва не выстрелил в спину Паркхиллу.
   - Господи, что это я!
   Он увидел, как Паркхилл закончил перебежку и упал, найдя укрытие.
   Вокруг Спендера медленно стягивалась редкая движущаяся цепочка людей. Он лежал на вершине, за двумя большими камнями, устало кривя рот от нехватки воздуха, под мышками темными пятнами проступил пот. Капитан отчетливо видел эти камни. Их разделял просвет сантиметров около десяти, оставляя незащищенной грудь Спендера.
   - Эй, ты! - крикнул Паркхилл. - У меня тут пуля припасена для твоего черепа!
   Капитан Уайлдер ждал. «Ну, Спендер, давай же,', 248);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1089, '2025-08-24 23:06:22.571376+03', 6, NULL, '- думал он. - Уходи, как у тебя было задумано. Через несколько минут будет поздно. Уходи, потом опять выйдешь. Ну! Ты же сказал, что уйдешь. Уйди в эти катакомбы, которые ты разыскал, заляг там и живи месяц, год, много лет, читай свои замечательные книги, купайся в своих храмовых бассейнах. Давай же, человече, ну, пока не поздно».
   Спендер не двигался с места.
   «Да что это с ним?» - спросил себя капитан.
   Он взял свой пистолет. Понаблюдал, как перебегают от укрытия к укрытию его люди. Поглядел на башни маленького чистенького марсианского селения - будто резные шахматные фигурки с освещенными солнцем гранями. Перевел взгляд на камни и промежуток между ними, открывающий грудь Спендера.', 249);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1090, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Паркхилл ринулся вперед, рыча от ярости.
   - Нет, Паркхилл, - сказал капитан. - Я не могу допустить, чтобы это сделали вы. Или кто-либо еще. Нет, никто из вас. Я сам.
   Он поднял пистолет и прицелился.
   «Будет ли у меня после этого чистая совесть? - спросил себя капитан. - Верно ли я поступаю, что беру это на себя? Да, верно. Я знаю, что и почему делаю, и все правильно, ведь я уверен, что это надлежит сделать мне. Я надеюсь и верю, что всей жизнью оправдаю свое решение».
   Он кивнул головой Спендеру.
   - Уходи! - крикнул он шепотом, которого никто, кроме него, не слышал. - Даю тебе еще тридцать секунд. Тридцать секунд!
   Часы тикали на его запястье. Капитан смотрел,', 250);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1091, '2025-08-24 23:06:22.571376+03', 6, NULL, 'как бежит стрелка. Его люди бегом продвигались вперед. Спендер не двигался с места. Часы тикали очень долго и очень громко, прямо в ухо капитану.
   - Уходи, Спендер, уходи живей!
   Тридцать секунд истекли.
   Пистолет был наведен на цель. Капитан глубоко вздохнул.
   - Спендер, - сказал он, выдыхая.
   Он спустил курок.
   Крохотное облачко каменной пыли заклубилось в солнечных лучах - вот и все, что произошло. Раскатилось и заглохло эхо выстрела.

   Капитан встал и крикнул своим людям:
   - Он мертв.
   Они не поверили. С их позиций не было видно просвета между камнями. Они увидели, как капитан один взбегает вверх по склону, и решили, что он либо очень храбрый, либо сумасшедший.', 251);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1092, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Прошло несколько минут, прежде чем они последовали за ним.
   Они собрались вокруг тела, и кто-то спросил:
   - В грудь?
   Капитан опустил взгляд.
   - В грудь, - сказал он. Он заметил, как изменился цвет камней под телом Спендера. - Хотел бы я знать, почему он ждал. Хотел бы я знать, почему он не ушел, как задумал. Хотел бы я знать, почему он дожидался, пока его убьют.
   - Кто ведает? - произнес кто-то.
   А Спендер лежал перед ними, и одна его рука сжимала пистолет, а другая - серебряную книгу, которая ярко блестела на солнце. [Картинка: pic_4.png] 
   «Может, все это из-за меня? - думал капитан. - Потому что я отказался присоединиться к нему? Может быть,', 252);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1093, '2025-08-24 23:06:22.571376+03', 6, NULL, 'у Спендера не поднялась рука убить меня? Возможно, я чем-нибудь отличаюсь от них? Может, в этом все дело? Он, наверно, считал, что на меня можно положиться. Или есть другой ответ?»
   Другого ответа не было. Он присел на корточки возле безжизненного тела.
   «Я должен оправдать это своей жизнью, - думал он, - Теперь я не могу его обмануть. Если он считал, что я в чем-то схож с ним и потому не убил меня, то я обязан многое свершить! Да-да, конечно, так и есть. Я - тот же Спендер, он остался жить во мне, только я думаю, прежде чем стрелять. Я вообще не стреляю, не убиваю. Я направляю людей. Он потому не мог меня убить, что видел во мне самого себя, только в иных условиях».', 253);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1094, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Капитан почувствовал, как солнце припекает его затылок. Он услышал собственный голос:
   - Эх, если бы он поговорил со мной, прежде чем стрелять, - мы бы что-нибудь придумали.
   - Что придумали? - буркнул Паркхилл. - Что общего у насс такими,как он?
   Равнина, скалы, голубое небо дышало зноем, от которого звенело в ушах.
   - Пожалуй, вы правы, - сказал капитан. - Мы никогда не смогли бы поладить. Спендер и я - еще куда ни шло. Но Спендер и вы и вам подобные - нет, никогда. Для него лучше так, как вышло. Дайте-ка глотнуть из фляги.
   Предложение схоронить Спендера в пустом саркофаге исходило от капитана. Саркофаг был на древнем марсианском кладбище, которое они обнаружили.', 254);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1095, '2025-08-24 23:06:22.571376+03', 6, NULL, 'И Спендера положилив серебряную гробницу, скрестив ему руки на груди, и туда же положили свечи и вина, изготовленные десять тысяч лет назад. И последним, что они увидели, закрывая саркофаг, было его умиротворенное лицо.
   Они постояли в древнем склепе.
   - Думаю, вам полезно будет время от времени вспоминать Спендера, - сказал капитан.
   Они вышли из склепа и плотно затворили мраморную дверь.
   На следующий день Паркхилл затеял стрельбу по мишеням в одном из мертвых городов - он стрелял по хрустальным окнам и сшибал макушки изящных башен. Капитан поймал Паркхилла и выбил ему зубы.
   Август 2001

   Поселенцы
   Земляне прилетали на Марс.
   Прилетали,', 255);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1096, '2025-08-24 23:06:22.571376+03', 6, NULL, 'потому что чего-то боялись и ничего не боялись, потому что были счастливы и несчастливы, чувствовали себя паломниками и не чувствовали себя паломниками.У каждого была своя причина. Оставляли опостылевших жен, или опостылевшую работу, или опостылевшие города; прилетали, чтобы найти что-то, или избавиться от чего-то, или добыть что-то, откопать что-то или зарыть что-то, или предать что-то забвению. Прилетали с большими ожиданиями, с маленькими ожиданиями, совсем без ожиданий. Но вомножестве городов на четырехцветных плакатах повелительно указывал начальственный палец: ДЛЯ ТЕБЯ ЕСТЬ РАБОТА НА НЕБЕ - ПОБЫВАЙ НА МАРСЕ!
   И люди собирались в путь; правда, сперва их было немного,', 256);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1097, '2025-08-24 23:06:22.571376+03', 6, NULL, 'какие-нибудь десятки - большинству еще до того, как ракета выстреливала в космос, становилось худо. Болезнь называлась Одиночество. Потому что стоило только представить себе, как твой родной город уменьшается там, внизу - сначала он с кулак размером, затем - с лимон, с булавочную головку, наконец, вовсе пропал в пламенной реактивной струе - и у тебя такое чувство, словно ты никогда не рождался на свет, и города никакого нет, и ты нигде, лишь космос кругом, ничего знакомого, только чужие люди. А когда твой штат - Иллинойс или Айова, Миссури или Монтана - тонул в пелене облаков, да что там, все Соединенные Штаты сжимались в мглистый островок,', 257);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1098, '2025-08-24 23:06:22.571376+03', 6, NULL, 'вся планета Земля превращалась в грязновато-серый мячик, летящий куда-то прочь, - тогда уж ты оказывался совсем один, одинокий скиталец в просторах космоса, и невозможно представить себе, что тебя ждет.
   Ничего удивительного, что первых было совсем немного. Число переселенцев росло пропорционально количеству землян, которые уже перебрались на Марс: одному страшно, а на людях - не так. Но первым, Одиноким, приходилось полагаться только на себя…
   Декабрь 2001

   Зеленое утро
   Когда солнце зашло, он присел возле тропы и приготовил нехитрый ужин; потом, отправляя в рот кусок за куском и задумчиво жуя, слушал, как потрескивает огонь. Миновалеще день, похожий на тридцать других:', 258);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1099, '2025-08-24 23:06:22.571376+03', 6, NULL, 'с утра пораньше вырыть много аккуратных ямок, потом посадить в них семена, натаскать воды из прозрачных каналов. Сейчас, скованный свинцовой усталостью, он лежал, глядя на небо, в котором один оттенок темноты сменялся другим.
   Его звали Бенджамен Дрисколл, ему был тридцать один год. Он хотел одного - чтобы весь Марс зазеленел, покрылся высокими деревьями с густой листвой, рождающей воздух, больше воздуха; пусть растут во все времена года, освежают города в душное лето, не пускают зимние ветры. Дерево, чего-чего только оно не может… Оно дарит краски природе, простирает тень, усыпает землю плодами. Или становится царством детских игр - целый поднебесный мир, где можно лазить, играть,', 259);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1100, '2025-08-24 23:06:22.571376+03', 6, NULL, 'висеть на руках… Великолепное сооружение, несущее пищу и радость, - вот что такое дерево. Но прежде всего деревья - это источник живительного прохладного воздуха для легких и ласкового шелеста, который нежит твои слух и убаюкивает тебя ночью, когда ты лежишь в снежно-белой постели.
   Он лежал и слушал, как темная почва собирается с силами, ожидая солнца, ожидая дождей, которых все нет и нет… Приложив ухо к земле, он слышал поступь грядущих годов и видел - видел, как посаженные сегодня семена прорываются зелеными побегами и тянутся ввысь, к небу, раскидывая ветку за веткой, и весь Марс превращается в солнечный лес, светлый сад.
   Рано утром,', 260);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1101, '2025-08-24 23:06:22.571376+03', 6, NULL, 'едва маленькое бледное солнце всплывет над складками холмов, он встанет, живо проглотит завтрак с дымком, затопчет головешки, нагрузит на себя рюкзак - и снова выбирать места, копать, сажать семена или саженцы, осторожно уминать землю, поливать и шагать дальше, насвистывая и поглядывая в ясное небо, а оно к полудню все ярче и жарче…
   - Тебе нужен воздух, - сказал он своему костру. Костер - живой румяный товарищ, который шутливо кусает тебе пальцы, а в прохладные ночи, теплый, дремлет рядом, щуря сонные розовые глаза… - Нам всем нужен воздух. Здесь, на Марсе, воздух разреженный. Чуть что, и устал. Все равно, что в Андах, в Южной Америке. Вдохнул и не чувствуешь. Никак не надышишься.', 261);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1102, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Он тронул грудную клетку. Как она расширилась за тридцать дней! Да, здесь им нужно развивать легкие, чтобы вдохнуть побольше воздуха. Или сажать побольше деревьев.
   - Понял, зачем я здесь? - сказал он. Огонь стрельнул. - В школе нам рассказывали про Джонни Яблочное Семечко. Как он шел по Америке и сажал яблони. А мое дело поважнее. Ясажаю дубы, вязы, и клены, и всякие другие деревья - осины, каштаны и кедры. Я делаю не просто плоды для желудка, а воздух для легких. Только подумать: когда все эти деревья наконец вырастут, сколько от них будет кислорода!
   Вспомнился день прилета на Марс. Подобно тысяче других, он всматривался тогда в тихое марсианское утро и думал:', 262);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1103, '2025-08-24 23:06:22.571376+03', 6, NULL, '«Как-то я здесь освоюсь? Что буду делать? Найдется лиработа по мне?»
   И потерял сознание.
   Кто-то сунул ему под нос пузырек с нашатырным спиртом, он закашлялся и пришел в себя.
   - Ничего, оправитесь, - сказал врач.
   - А что со мной было?
   - Здесь очень разреженная атмосфера. Некоторые ее не переносят. Вам, вероятно, придется возвратиться на Землю.
   - Нет! - Он сел, но в тот же миг в глазах у него потемнело, и Марс сделал под ним не меньше двух оборотов. Ноздри расширились, он принудил легкие жадно пить ничто. - Я свыкнусь. Я останусь здесь!
   Его оставили в покое: он лежал, дыша, словно рыба на песке, и думал: «Воздух, воздух, воздух.', 263);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1104, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Они хотят меня отправить отсюда из-за воздуха». И он повернул голову, чтобы поглядеть на холмы и равнины Марса. Присмотрелся и первое, что увидел: куда ни глянь, сколько ни смотри - ни одного дерева, ни единого. Этот край словно сам себя покарал, черный перегной стлался во все стороны, а на нем - ничего, ни одной травинки. «Воздух, - думал он, шумно вдыхая бесцветное нечто. - Воздух, воздух…» И на верхушках холмов, на тенистых склонах, даже возле ручья - тоже ни деревца, ни травинки.
   Ну конечно! Ответ родился не в сознании, а в горле, в легких. И эта мысль, словно глоток чистого кислорода, сразу взбодрила. Деревья и трава. Он поглядел на свои руки иповернул их ладонями вверх.', 264);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1105, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Он будет сажать траву и деревья. Вот его работа: бороться против того самого, что может ему помешать остаться здесь. Он объявит Марсу войну - особую, агробиологическую войну. Древняя марсианская почва… Ее собственные растения прожили столько миллионов тысячелетий, что вконец одряхлели и выродились.А если посадить новые виды? Земные деревья - ветвистые мимозы, плакучие ивы, магнолии, величественные эвкалипты. Что тогда? Можно только гадать, какие минеральные богатства таятся в здешней почве - нетронутые, потому что древние папоротники, цветы, кусты, деревья погибли от изнеможения.
   - Я должен встать! - крикнул он. - Мне надо видеть Координатора!', 265);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1106, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Полдня он и Координатор проговорили о том, что растет в зеленом уборе. Пройдут месяцы, если не годы, прежде чем можно будет начать планомерные посадки. Пока что продовольствие доставляют с Земли замороженным, в летающих сосульках; лишь несколько любителей вырастили сады гидропонным способом.
   - Так что пока, - сказал Координатор, - действуйте сами. Добудем семян сколько можно, кое-какое снаряжение. Сейчас в ракетах мало места. Боюсь, поскольку первые поселения связаны с рудниками, ваш проект зеленых посадок не будет пользоваться успехом…
   - Но вы мне разрешите?
   Ему разрешили. Выдали мотоцикл, он наполнил багажник семенами и саженцами, выезжал в пустынные долины,', 266);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1107, '2025-08-24 23:06:22.571376+03', 6, NULL, 'оставлял машину и шел пешком, работая.
   Это началось тридцать дней назад, и с той поры он ни разу не оглянулся. Оглянуться - значит пасть духом: стояла необычайно сухая погода, и вряд ли хоть одно семечко проросло. Может быть, битва проиграна? Четыре недели труда - впустую? И он смотрел только вперед, шел вперед по широкой солнечной долине, все дальше от Первого Города, и ждал - ждал, когда же пойдет дождь.
   …Он натянул одеяло на плечи; над сухими холмами пухли тучи. Марс непостоянен, как время. Пропеченные солнцем холмы прихватывал ночной заморозок, а он думал о богатой черной почве - такой черной и блестящей, что она чуть ли не шевелилась в горсти, о жирной почве,', 267);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1108, '2025-08-24 23:06:22.571376+03', 6, NULL, 'из которой могли бы расти могучие, исполинские стебли фасоли, и спелые стручки роняли бы огромные, невообразимые зерна, сотрясающие землю.
   Сонный костер подернулся пеплом. Воздух дрогнул: вдали прокатилась телега. Гром. Неожиданный запах влаги. «Сегодня ночью, - подумал он и вытянул руку проверить, идет ли дождь. - Сегодня ночью».
   Что-то тронуло его бровь, и он проснулся.
   По носу на губу скатилась влага. Вторая капля ударила в глаз и на миг его затуманила. Третья разбилась о щеку.
   Дождь.
   Прохладный, ласковый, легкий, он моросил с высокого неба - волшебный эликсир, пахнущий чарами, звездами, воздухом; он нес с собой черную, как перец, пыль, оставляя на языке то же ощущение,', 268);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1109, '2025-08-24 23:06:22.571376+03', 6, NULL, 'что выдержанный старый херес.
   Дождь.
   Он сел. Одеяло съехало, и по голубой рубашке забегали темные пятна; капли становились крупнее и крупнее. Костер выглядел так, будто по нему, топча огонь, плясал невидимый зверь; и вот остался только сердитый дым. Пошел дождь. Огромный черный небосвод вдруг раскололся на шесть аспидно-голубых осколков и обрушился вниз. Он увидел десятки миллиардов дождевых кристаллов, они замерли в своем падении ровно на столько времени, сколько нужно было, чтобы их запечатлел электрический фотограф. И снова мрак и вода, вода…
   Он промок до костей, но сидел и смеялся, подняв лицо, и капли стучали по векам. Он хлопнул в ладоши,', 269);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1110, '2025-08-24 23:06:22.571376+03', 6, NULL, 'вскочил на ноги и прошелся вокруг своего маленького лагеря; был час ночи.
   Дождь лил непрерывно два часа, потом прекратился. Высыпали чисто вымытые звезды, яркие, как никогда.
   Бенджамен Дрисколл достал из пластиковой сумки сухую одежду, переоделся, лег и, счастливый, уснул.

   Солнце медленно взошло между холмами. Лучи вырвались из-за преграды, тихо скользнули по земле и разбудили Дрисколла.
   Он чуть помешкал, прежде чем встать. Целый месяц, долгий жаркий месяц он работал, работал и ждал… Но сегодня, поднявшись, он впервые повернулся в ту сторону, откуда пришел.
   Утро было зеленое.
   Насколько хватало глаз, к небу поднимались деревья. Не одно, не два, не десяток, а все те тысячи,', 270);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1111, '2025-08-24 23:06:22.571376+03', 6, NULL, 'что он посадил, семенами или саженцами. И не мелочь какая- нибудь, нет,не поросль, не хрупкие деревца, а мощные стволы, могучие деревья высотой с дом, зеленые-зеленые, огромные, округлые, пышные деревья с отливающей серебром листвой, шелестящие на ветру, длинные ряды деревьев на склонах холмов, лимонные деревья и липы, секвойи и мимозы, дубы и вязы, осины, вишни, клены, ясени, яблони, апельсиновые деревья, эвкалипты - подстегнутые буйным дождем, вскормленные чужой волшебной почвой. На его глазах продолжали тянуться вверх новые ветви, лопались новые почки.
   - Невероятно! - воскликнул Бенджамен Дрисколл.
   Но долина и утро были зеленые.
   А воздух!
   Отовсюду, словно живой поток,', 271);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1112, '2025-08-24 23:06:22.571376+03', 6, NULL, 'словно горная река, струился свежий воздух, кислород, источаемый зелеными деревьями. Присмотрись и увидишь, как он переливается в небе хрустальными волнами. Кислород - свежий, чистый, зеленый, прохладный кислород превратил долину в дельту реки. Еще мгновение, и в городе распахнутся двери, люди выбегут навстречу чуду, будут его глотать, вдыхать полной грудью, щеки порозовеют, носы озябнут, легкие заново оживут, сердце забьется чаще, и усталые тела полетят в танце.
   Бенджамен Дрисколл глубоко-глубоко вдохнул влажный зеленый воздух и потерял сознание.
   Прежде чем он очнулся, навстречу желтому солнцу поднялось еще пять тысяч деревьев.
   Февраль 2002

   Саранча
   Ракеты жгли сухие луга,', 272);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1113, '2025-08-24 23:06:22.571376+03', 6, NULL, 'обращали камень в лаву, дерево - в уголь, воду - в пар, сплавляли песок и кварц в зеленое стекло; оно лежало везде, словно разбитые зеркала, отражающие в себе ракетное нашествие. Ракеты, ракеты, ракеты, как барабанная дробь в ночи. Ракеты роями саранчи садились в клубах розового дыма. Из ракет высыпали люди смолотками: перековать на привычный лад чужой мир, стесать все необычное, рот ощетинен гвоздями, словно стальнозубая пасть хищника, сплевывает гвозди в мелькающие руки, и те сколачивают каркасные дома, кроют крыши дранкой - чтобы спрятаться от чужих, пугающих звезд, вешают зеленые шторы - чтобы укрыться от ночи. Затем плотники спешили дальше, и являлись женщины с цветочными горшками,', 273);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1114, '2025-08-24 23:06:22.571376+03', 6, NULL, 'пестрыми ситцами, кастрюлями и поднимали кухонный шум, чтобы заглушить тишину Марса, притаившуюся у дверей,у занавешенных окон.
   За шесть месяцев на голой планете был заложен десяток городков с великим числом трескучих неоновых трубок и желтых электрических лампочек. Девяносто с лишним тысяч человек прибыло на Марс, а на Земле уже укладывали чемоданы другие…
   Август 2002

   Ночная встреча
   Прежде чем ехать дальше в голубые горы, Томас Гомес остановился возле уединенной бензоколонки.
   - Не одиноко тебе здесь, папаша? - спросил Томас.
   Старик протер тряпкой ветровое стекло небольшого грузовика.
   - Ничего.
   - А как тебе Марс нравится, старина?
   - Здорово.', 274);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1115, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Всегда что-нибудь новое. Когда я в прошлом году попал сюда, то первым делом сказал себе: вперед не заглядывай, ничего не требуй, ничему не удивляйся. Землю нам надо забыть, все, что было, забыть. Теперь следует приглядеться, освоиться и понять, что здесьвсене так, все по-другому. Да тут одна только погода - это же настоящий цирк. Этомарсианскаяпогода. Днем жарища адская, ночью адский холод. А необычные цветы, необычный дождь - неожиданности на каждом шагу! Я сюда приехал на покой, задумал дожить жизнь в таком месте, где все иначе. Это очень важно старому человеку - переменить обстановку. Молодежи с ним говорить недосуг, другие старики ему осточертели. Вот я и смекнул,', 275);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1116, '2025-08-24 23:06:22.571376+03', 6, NULL, 'что самое подходящее для меня - найти такое необычное местечко, что только не ленись смотреть, кругом развлечения. Вот, подрядился на эту бензоколонку. Станет чересчурхлопотно, снимусь отсюда и переберусь на какое-нибудь старое шоссе, не такое оживленное; мне бы только заработать на пропитание, да чтобы еще оставалось время примечать, до чего же здесь все не так.
   - Неплохо ты сообразил, папаша, - сказал Томас; его смуглые руки лежали, отдыхая, на баранке. У него было отличное настроение. Десять дней кряду он работал в одном из новых поселений, теперь получил два выходных и ехал на праздник.
   - Уж я больше ничему не удивляюсь, - продолжал старик. - Гляжу, и только. Можно сказать,', 276);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1117, '2025-08-24 23:06:22.571376+03', 6, NULL, 'набираюсь впечатлений. Если тебе Марс, каков он есть, не по вкусу, отправляйся лучше обратно на Землю. Здесь все шиворот-навыворот: почва, воздух, каналы, туземцы (правда, я еще ни одного не видел, но, говорят, они тут где-то бродят), часы. Мои часы - и те чудят. Здесь дажевремяшиворот-навыворот. Иной раз мне сдается, что я один-одинешенек, на всей этой проклятой планете больше ни души. Пусто. А иногда покажется, что я - восьмилетний мальчишка, сам махонький, а все кругом здоровенное! Видит бог, тут самое подходящее место для старого человека. Тут не задремлешь, я просто счастливый стал. Знаешь, что такоеМарс? Он смахивает на вещицу,', 277);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1118, '2025-08-24 23:06:22.571376+03', 6, NULL, 'которую мне подарили на рождество семьдесят лет назад - не знаю, держал ли ты в руках такую штуку: их калейдоскопами называют, внутри осколки хрусталя, лоскутки, бусинки, всякая мишура… А поглядишь сквозь нее на солнце - дух захватывает! Сколько узоров! Так вот, это и есть Марс. Наслаждайся им и не требуй от него, чтобы он был другим. Господи, да знаешь ли ты, что вот это самое шоссе проложено марсианами шестнадцать веков назад, а в полном порядке! Гони доллар и пятьдесят центов, спасибо и спокойной ночи.
   Томас покатил по древнему шоссе, тихонько посмеиваясь.
   Это был долгий путь через горы, сквозь тьму, и он держал руль, иногда опуская руку в корзинку с едой и доставая оттуда леденец.', 278);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1119, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Прошло уже больше часа непрерывной езды, и ни одной встречной машины, ни одного огонька, только лента дороги, гул и рокот мотора, и Марс кругом, тихий, безмолвный. Марс - всегда тихий, в эту ночь был тише, чем когда-либо. Мимо Томаса скользили пустыни, и высохшие моря, и вершины среди звезд.
   Нынче ночью в воздухе пахло Временем. Он улыбнулся, мысленно оценивая свою выдумку. Неплохая мысль. А в самом деле: чем пахнет Время? Пылью, часами, человеком. А если задуматься, какое оно - Время то есть - на слух? Оно вроде воды, струящейся в темной пещере, вроде зовущих голосов, вроде шороха земли, что сыплется на крышку пустого ящика, вроде дождя. Пойдем еще дальше, спросим, как выглядит Время?', 279);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1120, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Оно точно снег, бесшумно летящий в черный колодец, или старинный немой фильм, в котором сто миллиардов лиц, как новогодние шары, падают вниз, падают в ничто. Вот чем пахнет Время и вот какое оно на вид и на слух. А нынче ночью - Томас высунул руку в боковое окошко, - нынче так и кажется, что его можно дажепощупать.
   Он вел грузовик в горах Времени. Что-то кольнуло шею, и Томас выпрямился, внимательно глядя вперед.
   Он въехал в маленький мертвый марсианский городок, выключил мотор и окунулся в окружающее его безмолвие. Затаив дыхание, он смотрел из кабины на залитые луной белые здания, в которых уже много веков никто не жил. Великолепные, безупречные здания, пусть разрушенные,', 280);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1121, '2025-08-24 23:06:22.571376+03', 6, NULL, 'но все равно великолепные.
   Включив мотор, Томас проехал еще милю-другую, потом снова остановился, вылез, захватив свою корзинку, и прошел на бугор, откуда можно было окинуть взглядом занесенный пылью город. Открыл термос и налил себе чашку кофе. Мимо пролетела ночная птица. На душе у него было удивительно хорошо, спокойно.
   Минут пять спустя Томас услышал какой-то звук. Вверху, там, где древнее шоссе терялось за поворотом, он приметил какое-то движение, тусклый свет, затем донесся слабый рокот. Томас повернулся, держа чашку в руке. С гор спускалось нечто необычайное.
   Это была машина, похожая на желто-зеленое насекомое, на богомола, она плавно рассекала холодный воздух,', 281);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1122, '2025-08-24 23:06:22.571376+03', 6, NULL, 'мерцая бесчисленными зелеными бриллиантами, сверкая фасеточными рубиновыми глазами. Шесть ног машины ступали по древнему шоссе с легкостью моросящего дождя, а со спины машины на Томаса глазами цвета расплавленного золота глядел марсианин, глядел будто в колодец.
   Томас поднял руку и мысленно уже крикнул: «Привет!», но губы его не шевельнулись. Потому что это былмарсианин.Но Томас плавал на Земле в голубых реках, вдоль которых шли незнакомые люди, вместе с чужими людьми ел в чужих домах, и всегда его лучшим оружием была улыбка. Он не носил с собой пистолета. И сейчас Томас не чувствовал в нем нужды, хотя где-то под сердцем притаился страх.
   У марсианина тоже ничего не было в руках.', 282);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1123, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Секунду они смотрели друг на друга сквозь прохладный воздух. [Картинка: pic_5.png] 
   Первым решился Томас
   - Привет! - сказал он
   - Привет! - сказал марсианин на своем языке.
   Они не поняли друг друга.
   - Вы сказали «здравствуйте»? - спросили оба одновременно.
   - Что вы сказали? - продолжали они, каждый на своем языке.
   Оба нахмурились.
   - Вы кто? - спросил Томас по-английски.
   - Что вы здесь делаете? - произнесли губы чужака по-марсиански.
   - Куда вы едете? - спросили оба с озадаченным видом.
   - Меня зовут Томас Гомес.
   - Меня зовут Мью Ка.
   Ни один из них не понял другого, но каждый постучал пальцем по своей груди, и смысл стал обоим ясен.', 283);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1124, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Вдруг марсианин рассмеялся.
   - Подождите!
   Томас ощутил, как что-то коснулось его головы, хотя никто его не трогал.
   - Вот так! - сказал марсианин по-английски. - Теперь дело пойдет лучше!
   - Вы так быстро выучили мой язык?
   - Ну что вы!
   Оба, не зная, что говорить, посмотрели на чашку с горячим кофе в руке Томаса.
   - Что-нибудь новое? - спросил марсианин, разглядывая его и чашку и подразумевая, по-видимому, и то и другое.
   - Выпьете чашечку? - предложил Томас.
   - Большое спасибо.
   Марсианин соскользнул со своей машины.
   Вторая чашка наполнилась горячим кофе. Томас подал ее марсианину.
   Их руки встретились и, точно сквозь туман, прошли одна сквозь другую.', 284);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1125, '2025-08-24 23:06:22.571376+03', 6, NULL, '- Господи Иисусе! - воскликнул Томас и выронил чашку.
   - Силы небесные! - сказал марсианин на своем языке.
   - Видели, что произошло? - прошептали они.
   Оба похолодели от испуга.
   Марсианин нагнулся за чашкой, но никак не мог ее взять.
   - Господи! - ахнул Томас.
   - Ну и ну! - Марсианин пытался снова и снова ухватить чашку, ничего не получалось. Он выпрямился, подумал, затем отстегнул от пояса нож.
   - Эй! - крикнул Томас.
   - Вы не поняли, ловите! - сказал марсианин и бросил нож.
   Томас подставил сложенные вместе ладони. Нож упал сквозь руки на землю. Томас хотел его поднять, но не мог ухватить и, вздрогнув, отпрянул.
   Он глядел на марсианина, стоящего на фоне неба.', 285);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1126, '2025-08-24 23:06:22.571376+03', 6, NULL, '- Звезды! - сказал Томас.
   - Звезды! - отозвался марсианин, глядя на Томаса.
   Сквозь тело марсианина, яркие, белые, светили звезды, его плоть была расшита ими словно тонкая, переливающаяся искрами оболочка студенистой медузы. Звезды мерцали,точно фиолетовые глаза, в груди и в животе марсианина, блистали драгоценностями на его запястьях.
   - Я вижу сквозь вас! - сказал Томас.
   - И я сквозь вас! - отвечал марсианин, отступая на шаг.
   Томас пощупал себя, ощутил живое тепло собственного тела и успокоился. «Все в порядке, - подумал он, - я существую».
   Марсианин коснулся рукой своего носа, губ.
   - Я не бесплотный, - негромко сказал он. -Живой!
   Томас озадаченно глядел на него.', 286);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1127, '2025-08-24 23:06:22.571376+03', 6, NULL, '- Но если я существую, значит,вы -мертвый.
   - Нет, вы!
   - Привидение!
   - Призрак!
   Они показывали пальцем друг на друга, и звездный свет в их конечностях сверкал и переливался, как острие кинжала, как ледяные сосульки, как светлячки. Они снова проверили свои ощущения, и каждый убедился, что он жив-здоров и охвачен волнением, трепетом, жаром, недоумением, а вот тот, другой - ну, конечно же, тот нереален, тот призрачная призма, ловящая и излучающая свет далеких миров…
   «Я пьян, - сказал себе Томас. - Завтра никому не расскажу про это, ни слова!»
   Они стояли на древнем шоссе, и оба не шевелились.
   - Откуда вы? - спросил наконец марсианин.
   - С Земли.
   - Что это такое?', 287);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1128, '2025-08-24 23:06:22.571376+03', 6, NULL, '- Там. - Томас кивком указал на небо.
   - Давно?
   - Мы прилетели с год назад, вы разве не помните?
   - Нет.
   - А вы все к тому времени вымерли, почти все. Вас очень мало осталось - разве вы этогоне знаете?
   - Это неправда.
   - Я вам говорю, вымерли. Я сам видел трупы. Почерневшие тела в комнатах, во всех домах, и все мертвые. Тысячи тел.
   - Что за вздор,мы живы!
   - Мистер, всех ваших скосила эпидемия. Странно, что вам это неизвестно. Вы каким-то образом спаслись.
   - Я не спасся, не от чего мне было спасаться. О чем это вы говорите? Я еду на праздник у канала возле Эниальских Гор. И прошлую ночь был там. Вы разве не видите город? - Марсианин вытянул руку, показывая.', 288);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1129, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Томас посмотрел и увидел развалины.
   - Но ведь этот город мертв уже много тысяч лет!
   Марсианин рассмеялся.
   - Мертв? Я ночевал там вчера!
   - А я его проезжал на той неделе, и на позапрошлой неделе, и вот только что, там одни развалины! Видите разбитые колонны?
   - Разбитые? Я их отлично вижу в свете луны. Прямые, стройные колонны.
   - На улицах ничего, кроме пыли, - сказал Томас.
   - Улицы чистые!
   - Каналы давно высохли, они пусты.
   - Каналы полны лавандового вина!
   - Город мертв.
   - Город жив! - возразил марсианин, смеясь еще громче. - Вы решительно ошибаетесь. Видите, сколько там карнавальных огней? Там прекрасные челны, изящные, как женщины,', 289);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1130, '2025-08-24 23:06:22.571376+03', 6, NULL, 'там прекрасные женщины, изящные, как челны, женщины с кожей песочного цвета, женщины с огненными цветками в руках. Я их вижу, вижу, как они бегают вон там, по улицам, такие маленькие отсюда. И я туда еду, на праздник, мы будем всю ночь кататься по каналу, будем петь, пить, любить. Неужели выне видите?
   - Мистер, этот город мертв, как сушеная ящерица. Спросите любого из наших. Что до меня, то я еду в Грин-Сити - новое поселение на Иллинойском шоссе, мы его совсем недавно заложили. А вы что-то напутали. Мы доставили сюда миллион квадратных футов досок лучшего орегонского леса, несколько десятков тонн добрых стальных гвоздей и отгрохали два поселка - глаз не оторвешь.', 290);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1131, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Как раз сегодня спрыскиваем один из них. С Земли прилетают две ракеты с нашими женами и невестами. Будут народные танцы, виски…
   Марсианин встрепенулся.
   - Вы говорите - втойстороне?
   - Да, там, где ракеты. - Томас подвел его к краю бугра и показал вниз. - Видите?
   - Нет.
   - Да вон же,вон,черт возьми! Такие длинные, серебристые штуки.
   - Не вижу.
   Теперь рассмеялся Томас.
   - Да вы ослепли!
   - У меня отличное зрение. Это вы не видите.
   - Ну хорошо, а новыйпоселоквы видите? Или тоже нет?
   - Ничего не вижу, кроме океана - и как раз сейчас отлив.
   - Уважаемый, этот океан испарился сорок веков тому назад.
   - Ну, знаете, это уж чересчур.
   - Но это правда, уверяю вас!', 291);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1132, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Лицо марсианина стало очень серьезным.
   - Постойте. Вы в самом деле не видите города, как я его вам описал? Белые-белые колонны, изящные лодки, праздничные огни - я их так отчетливо вижу! Вслушайтесь! Я даже слышу, как там поют. Не такое уж большое расстояние.
   Томас прислушался и покачал головой.
   - Нет.
   - А я, - продолжал марсианин, - не вижу того, что описываете вы. Как же так?…
   Они снова зябко вздрогнули, точно их плоть пронизало ледяными иглами.
   - А может быть?…
   - Что?
   - Вы сказали «с неба»?
   - С Земли.
   - Земля - название, пустой звук… - произнес марсианин. - Но… час назад, когда я ехал через перевал… - Он коснулся своей шеи сзади. - Я ощутил.
   - Холод?', 292);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1133, '2025-08-24 23:06:22.571376+03', 6, NULL, '- Да.
   - И теперь тоже?
   - Да, снова холод. Что-то было со светом, с горами, с дорогой - что-то необычное. И свет, и дорога словно не те, и у меня на мгновение появилось такое чувство, будто я последний из живущих во вселенной…
   - И со мной так было! - воскликнул Томас взволнованно; он как будто беседовал с добрым старым другом, доверяя ему что-то сокровенное.
   Марсианин закрыл глаза и снова открыл их.
   - Тут может быть только одно объяснение. Все дело во Времени. Да-да. Вы - создание Прошлого!
   - Нет, это вы из Прошлого, - сказал землянин, поразмыслив.
   - Как вы уверены! Вы можете доказать, кто из Прошлого, а кто из Будущего? Какой сейчас год?
   - Две тысячи второй!', 293);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1134, '2025-08-24 23:06:22.571376+03', 6, NULL, '- Что это говорит мне?
   Томас подумал и пожал плечами.
   - Ничего.
   - Все равно, что я бы вам сказал, что сейчас 4 462 853 год по нашему летосчислению. Слова - ничто, меньше, чем ничто! Где часы, по которым мы бы определили положение звезд?
   - Но развалины - доказательство! Они доказывают, что я - Будущее.Яжив, авымертвы!
   - Все мое существо отвергает такую возможность. Мое сердце бьется, желудок требует пищи, рот жаждет воды. Нет, никто из нас ни жив, ни мертв. Впрочем, скорее жив, чем мертв. А еще вернее, мы как бы посередине. Вот: два странника, которые встретились ночью в пути. Два незнакомца, у каждого своя дорога. Вы говорите, развалины?
   - Да. Вам страшно?', 294);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1135, '2025-08-24 23:06:22.571376+03', 6, NULL, '- Комухочется увидеть Будущее? И кто его когда-либо увидит? Человек может лицезреть Прошлое, но чтобы… Вы говорите, колонны рухнули? И море высохло, каналы пусты, девушки умерли, цветы завяли? - Марсианин смолк, но затем снова посмотрел на город. - Но вон же они! Я ихвижу,и мне этого достаточно. Они ждут меня, что бы вы ни говорили.
   Точно так же вдали ждали Томаса ракеты, и поселок, и женщины с Земли.
   - Мы никогда не согласимся друг с другом, - сказал он.
   - Согласимся не соглашаться, - предложил марсианин. - Прошлое, Будущее - не все ли равно, лишь бы мы оба жили, ведь то, что придет вслед за нами, все равно придет - завтраили через десять тысяч лет. Откуда вы знаете,', 295);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1136, '2025-08-24 23:06:22.571376+03', 6, NULL, 'что эти храмы - не обломки вашей цивилизации через сто веков? Не знаете. Ну так и не спрашивайте. Однако ночь коротка. Вон рассыпался в небе праздничный фейерверк, взлетели птицы.
   Томас протянул руку. Марсианин повторил его жест. Их руки не соприкоснулись - они растворились одна в другой.
   - Мы еще встретимся?
   - Кто знает? Возможно, когда-нибудь.
   - Хотелось бы мне побывать с вами на вашем празднике.
   - А мне - попасть в ваш новый поселок, увидеть корабль, о котором вы говорили, увидеть людей, услышать обо всем, что случилось.
   - До свидания, - сказал Томас.
   - Доброй ночи.
   Марсианин бесшумно укатил в горы на своем зеленом металлическом экипаже,', 296);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1137, '2025-08-24 23:06:22.571376+03', 6, NULL, 'землянин развернул свой грузовик и молча повел его в противоположную сторону.
   - Господи, что за сон, - вздохнул Томас, держа руки на баранке и думая о ракетах, о женщинах, о крепком виски, о вирджинских плясках, о предстоящем веселье.
   «Какое странное видение», - мысленно произнес марсианин, прибавляя скорость и думая о празднике, каналах, лодках, золотоглазых женщинах, песнях…
   Ночь была темна. Луны зашли. Лишь звезды мерцали над пустым шоссе. Ни звука, ни машины, ни единого живого существа, ничего. И так было до конца этой прохладной темной ночи.
   Октябрь 2002

   Берег
   Марс был словно дальний берег океана, люди волнами растекались по нему. Каждая волна непохожа на предыдущую,', 297);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1138, '2025-08-24 23:06:22.571376+03', 6, NULL, 'одна мощнее другой. Первая принесла людей, привычных к просторам, холодам, одиночеству, худых, сухощавых старателей и пастухов, лица у них иссушены годами и непогодами, глаза, как шляпки гвоздей, руки задубевшие, как старые перчатки, готовы взяться за что угодно. Марс был им нипочем, они выросли на равнинах и прериях, таких же безбрежных, как марсианские поля. Они обживали голое место,так что другим было уже легче решиться. Остекляли пустые рамы, зажигали в домах огни.
   Они были первыми мужчинами на Марсе.
   Каковы будут первые женщины - знали все.
   Со второй волной надо было бы доставить людей иных стран, со своей речью, своими идеями. Но ракеты были американские,', 298);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1139, '2025-08-24 23:06:22.571376+03', 6, NULL, 'и прилетели на них американцы, а Европа и Азия, Южная Америка, Австралия и Океания только смотрели, как исчезают в выси римские свечи. Мир был поглощен войной или мыслями о войне.
   Так что вторыми тоже были американцы. Покинув мир многоярусных клетушек и вагонов подземки, они отдыхали душой и телом в обществе скупых на слова мужчин из степныхштатов, знающих цену молчанию, которое помогало обрести душевный покой после долгих лет толкотни в каморках, коробках, туннелях Нью-Йорка.
   И были среди вторых такие, которым, судя по их глазам, чудилось, будто они возносятся к господу богу.', 299);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1140, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Февраль 2003

   Интермедия
   Они привезли с собой пятнадцать тысяч погонных футов орегонской сосны для строительства Десятого города и семьдесят девять тысяч футов калифорнийской секвойи и отгрохали чистенький, аккуратный городок возле каменных каналов. Воскресными вечерами красно-зелено-голубые матовые стекла церковных окон вспыхивали светом и слышались голоса, поющие нумерованные церковные гимны. «А теперь споем 79. А теперь споем 94». В некоторых домах усердно стучали пишущие машинки - это работали писатели; или скрипели перья - там творили поэты; или царила тишина - там жили бывшие бродяги. Все это и многое другое создавало впечатление,', 300);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1141, '2025-08-24 23:06:22.571376+03', 6, NULL, 'будто могучее землетрясение расшатало фундаменты и подвалы провинциального американского городка, а затем смерч сказочной мощи мгновенно перенес весь городок на Марс и осторожно поставил его здесь, даже не тряхнув…
   Апрель 2003

   Музыканты
   В какие только уголки Марса не забирались мальчишки. Они прихватывали с собой из дома вкусно пахнущие пакеты и по пути время от времени засовывали в них носы - вдохнуть сытный дух ветчины и пикулей с майонезом, прислушаться к влажному бульканью апельсиновой воды в теплых бутылках. Размахивая сумками с сочным, прозрачно-зеленым луком, пахучей ливерной колбасой, красным кетчупом и белым хлебом,', 301);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1142, '2025-08-24 23:06:22.571376+03', 6, NULL, 'они подбивали друг друга переступить запреты строгих родительниц. Они бегали взапуски:
   - Кто первый добежит, дает остальным щелчка!
   Они ходили в дальние прогулки летом, осенью, зимой. Осенью - лучше всего: можно вообразить, будто ты, как на Земле, бегаешь по опавшей листве.
   Горстью звучных камешков высыпали мальчишки - кирпичные щеки, голубые бусины глаз - на мраморные набережные каналов и, запыхавшись, подбадривали друг друга возгласами, благоухающими луком. Потому что здесь, у стен запретного мертвого города, никто уже не кричал: «Последний будет девчонкой!» или «Первый будет Музыкантом!» Вот он, безжизненный город и все двери открыты… И кажется, будто что-то шуршит в домах,', 302);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1143, '2025-08-24 23:06:22.571376+03', 6, NULL, 'как осенние листья. Они крадутся дальше, все вместе, плечом к плечу, и в руках стиснуты палки, а в голове - родительский наказ: «Только не туда! В старые города ни в коем случае! Если посмеешь - отец всыплет так, что век будешь помнить!.. Мы по ботинкам узнаем!»
   И вот они в мертвом городе, мальчишья стая, половина дорожной снеди уже проглочена, и они подзадоривают друг друга свистящим шепотом:
   - Ну давай!
   Внезапно один срывается с места, вбегает в ближайший дом, летит через столовую в спальню, и ну скакать без оглядки, приплясывать, и взлетают в воздух черные листья, тонкие, хрупкие, будто плоть полуночного неба. За первым вбегают еще двое, трое, все шестеро,', 303);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1144, '2025-08-24 23:06:22.571376+03', 6, NULL, 'но Музыкантом будет первый, только он будет играть на белом ксилофоне костей, обтянутых черными хлопьями. Снежным комом выкатывается огромный череп, мальчишки кричат! Ребра - паучьи ноги, ребра - гулкие струны арфы, и черной вьюгой кружатся смертные хлопья, а мальчишки затеяли возню, прыгают, толкают друг друга, падают прямо на эти листья, на чуму, обратившую мертвых в хлопья и прах, в игрушку для мальчишек, в животах которых булькала апельсиновая вода. [Картинка: pic_6.png] 
   Отсюда - в следующий дом и еще в семнадцать домов; надо спешить - ведь из города в город, начисто выжигая все ужасы, идут Пожарники, дезинфекторы с лопатами и корзинами, сгребают,', 304);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1145, '2025-08-24 23:06:22.571376+03', 6, NULL, 'выгребают эбеновые лохмотья и белые палочки-кости, медленно, но верно отделяя страшное от обыденного… Играйте, мальчишки, не мешкайте, скоро придут Пожарные!
   И вот, светясь капельками пота, впиваются зубами в последний бутерброд. Затем - еще раз наподдать ногой напоследок, еще раз выбить дробь из маримбофона, по- осеннемунырнуть в кучу листьев и - в путь, домой.
   Матери проверяли ботинки, нет ли черных чешуек. Найдут - получай: обжигающую ванну и отеческое внушение ремнем.
   К концу года Пожарники выгребли все осенние листья и белые ксилофоны, потехе пришел конец.
   Июнь 2003

   …Высоко в небеса
   - Слыхал?
   - Что?
   - Негры-то, черномазые!
   - Что такое?
   - Уезжают,', 305);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1146, '2025-08-24 23:06:22.571376+03', 6, NULL, 'сматываются, драпают - неужели не слыхал?
   - То есть, как это сматываются? Да как они могут!
   - Могут. Уже…
   - Какая-нибудь парочка?
   - Все до одного! Все негры южных штатов!
   - Не-е…
   - Точно!
   - Не поверю, пока сам не увижу. И куда же они? В Африку?
   Пауза.
   - На Марс.
   - То есть - напланетуМарс?
   - Именно.
   Они стояли под раскаленным навесом на веранде скобяной лавки. Один бросил раскуривать трубку. Другой сплюнул в горячую полуденную пыль.
   - Не могут они уехать, ни в жизнь.
   - А вот уже уезжают.
   - Да откуда ты взял?
   - Везде говорят, и по радио только что передавали.
   Они зашевелились - казалось, оживают запыленные статуи. Сэмюэль Тис,', 306);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1147, '2025-08-24 23:06:22.571376+03', 6, NULL, 'хозяин скобяной лавки, натянуто рассмеялся.
   - А я-то не возьму в толк, что стряслось с Силли. Час назад дал ему свой велосипед и послал к миссис Бордмен. До сих пор не вернулся. Уж не махнул ли прямиком на Марс, дурень черномазый?
   Мужчины фыркнули.
   - А только пусть лучше вернет велосипед, вот что. Клянусь, воровства я не потерплю ни от кого.
   - Слушайте!
   Они повернулись, раздраженно толкая друг друга. В дальнем конце улицы словно прорвалась плотина. Жаркие черные струи хлынули, затопляя город. Между ослепительно белыми берегами городских лавок, среди безмолвных деревьев, нарастал черный прилив. Будто черная патока ползла, набухая, по светло- коричневой пыли дороги. Медленно,', 307);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1148, '2025-08-24 23:06:22.571376+03', 6, NULL, 'медленно нарастала лавина - мужчины и женщины, лошади и лающие псы, и дети, мальчики и девочки. А речь людей - частиц могучего потока - звучала, как шум реки, которая летним днем куда-то несет свои воды, рокочущая, неотвратимая. В этом медленном темном потоке, рассекшем ослепительное сияние дня, блестками живой белизны сверкали глаза. Они смотрели вперед, влево, вправо, а река, длинная, нескончаемая река, уже прокладывала себе новое русло. Бесчисленные притоки, речушки, ручейки, слились в единыйматеринский поток, объединили свое движение, свои краски и устремились дальше. Окаймляя вздувшуюся стремнину, плыли голосистые дедовские будильники, гулко тикающие стенные часы,', 308);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1149, '2025-08-24 23:06:22.571376+03', 6, NULL, 'кудахчущие куры в клетках, плачущие малютки; беспорядочное течение увлекало за собой мулов, кошек, тут и там всплывали вдруг матрасные пружины, растрепанная волосяная набивка, коробки, корзинки, портреты темнокожих предков в дубовых рамах. Река катилась и катилась, а люди на террасе скобяной лавки сидели подобно ощетинившимся псам и не знали, что предпринять: чинить плотину было поздно.
   Сэмюэль Тис все еще не мог поверить.
   - Да кто им даст транспорт, черт возьми? Как они думаютпопастьна Марс?
   - Ракеты, - сказал дед Квортэрмэйн.
   - У этих болванов и остолопов? Откуда они их взяли, ракеты-то?
   - Скопили денег и построили.
   - Первый раз слышу.
   - Видно,', 309);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1150, '2025-08-24 23:06:22.571376+03', 6, NULL, 'черномазые держали все в секрете. Построили ракеты сами, а где - не знаю. Может, в Африке.
   - Как же так? - не унимался Сэмюэль Тис, мечась по веранде. - А законы на что?
   - Они как будто войны никому не объявляли, - мирно ответил дед.
   - Откуда же они полетят, черт бы их побрал со всеми их секретами и заговорами? - крикнул Тис.
   - По расписанию все негры этого города собираются возле Лун-Лейк. В час туда прилетят ракеты и заберут их на Марс.
   - Надо звонить губернатору, вызвать полицию! - бесновался Тис. - Они обязаны были предупредить заранее!
   - Твоя благоверная идет, Тис.
   Мужчины повернулись.
   По раскаленной улице в слепящем безветрии шли белые женщины. Одна, вторая,', 310);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1151, '2025-08-24 23:06:22.571376+03', 6, NULL, 'еще и еще, и у всех ошеломленные лица, и все порывисто шуршат юбками. Одни плакали, другие хмурились Они шли за своими мужьями. Они исчезали за вращающимися дверьми баров. Они входили в тихие бакалейные лавки. Заходили в аптеки и гаражи. Одна из них, миссисКлара Тис, остановилась в пыли возле скобяной лавки, щурясь на своего разгневанного, надутого супруга, а за ее спиной набухал черный поток.
   - Отец, пошли домой, я никак не могу уломать Люсинду!
   - Чтобы я шел домой из-за какой-то черномазой дряни?!
   - Она уходит. Что я буду делать без нее?
   - Попробуй сама управляться. Я на коленях перед ней ползать не буду.
   - Но она все равно что член семьи, - причитала миссис Тис.', 311);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1152, '2025-08-24 23:06:22.571376+03', 6, NULL, '- Не вопи! Не хватало еще, чтобы ты у всех на глазах хныкала из-за всякой…
   Всхлипывания жены остановили его. Она утирала глаза.
   - Я ей говорю: "Люсинда, останься, - говорю, - я прибавлю тебе жалованье, будешь свободнадвавечера в неделю, если хочешь", - а она словно каменная. Никогда ее такой не видела. «Неужто ты меня не любишь, - говорю, - Люсинда?» «Люблю, - говорит, - и все равно должна уйти, так уж получилось». Убрала всюду, навела порядок, поставила на стол завтрак и… и пошла. Дошла до дверей, а там уже два узла приготовлены. Стала, у каждой ноги по узлу, пожала мне руку и говорит: «Прощайте, миссис Тис». И ушла. Завтрак на столе, а нам кусок в горло не лезет.', 312);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1153, '2025-08-24 23:06:22.571376+03', 6, NULL, 'И сейчас там стоит, наверно, совсем остыл, как я уходила…
   Тис едва не ударил ее.
   - К черту, слышишь, марш домой! Нашла место представление устраивать!
   - Но, отец…
   Сэмюэль исчез в душной тьме лавки. Несколько секунд спустя он появился снова, с серебряным пистолетом в руке.
   Его жены уже не было.
   Черная река текла между строениями, скрипя, шурша и шаркая. Поток был спокойный, полный великой решимости; ни смеха, ни бесчинств, только ровное, целеустремленное, нескончаемое течение.
   Тис сидел на самом краешке своего тяжелого дубового кресла.
   - Клянусь богом, если кто-нибудь из них хотя бы улыбнется, я его прикончу.
   Мужчины ждали.', 313);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1154, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Река мирно катила мимо сквозь дремотный полдень.
   - Что, Сэм, - усмехнулся дед Квортэрмэйн, - видать, придется тебе самому черную работу делать.
   - Я и по белому не промахнусь. - Тис не глядел на деда.
   Дед отвернулся и замолчал.
   - Эй, ты, постой-ка! - Сэмюэль Тис спрыгнул с веранды, протиснулся и схватил под уздцы лошадь, на которой сидел высокий негр. - Все, Белтер, слезай, приехали!
   - Да, сэр. - Белтер соскользнул на землю.
   Тис смерил его взглядом.
   - Ну, как же это называется?
   - Понимаете, мистер Тис…
   - В путь собрался, да? Как в той песне… сейчас вспомню… «Высоко в небеса» - так, что ли?
   - Да, сэр.
   Негр ждал, что последует дальше.
   - А ты не забыл,', 314);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1155, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Белтер, что должен мне пятьдесят долларов?
   - Нет, сэр.
   - И задумал с ними улизнуть? А хлыста отведать не хочешь?
   - Сэр, тут такой переполох, я совсем запамятовал.
   - Он запамятовал… - Тис злобно подмигнул своим зрителям на веранде. - Черт возьми, мистер, ты знаешь, что ты будешь делать?
   - Нет, сэр.
   - Ты останешься здесь и отработаешь мне эти пятьдесят зелененьких, не будь я Сэмюэль В. Тис.
   Он повернулся и торжествующе улыбнулся мужчинам под навесом.
   Белтер смотрел на поток, до краев заполняющий улицу, на черный поток, неудержимо струящийся между лавками, черный поток на колесах, верхом, в пыльных башмаках, черный поток, из которого его так внезапно вырвали.', 315);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1156, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Он задрожал.
   - Отпустите меня, мистер Тис. Я пришлю оттуда ваши деньги, честное слово!
   - Послушай-ка, Белтер. - Тис ухватил негра за подтяжки, потягивая то одну, то другую, словно струны арфы, посмотрел на небо и, пренебрежительно фыркнув, прицелился костистым пальцем в самого господа бога. - А ты знаешь, Белтер, что тебя там ждет?
   - Знаю то, что мне рассказывали.
   - Ему рассказывали! Иисусе Христе! Нет, вы слышали? Ему рассказывали! - Он небрежно так, словно играя, мотал Белтера за подтяжки и тыкал пальцем ему в лицо. - Помяни моеслово, Белтер, вы взлетите вверх, как шутиха в день четвертого июля, и - бам! Готово, один пепел от вас, да и тот разнесет по всему космосу.', 316);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1157, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Эти болваны ученые не смыслят ни черта, они вас всех укокошат!
   - Мне все равно.
   - И очень хорошо! Потому что там, на этом вашем Марсе, знаешь, что вас поджидает? Чудовища кровожадные, глазища - во! Как мухоморы! Небось, видал картинки в журналах про будущее, в закусочной у нас продают по десяти центов штука? Ну так вот, как налетят они на вас - весь мозг из костей высосут!
   - Мне все равно, все равно, все равно. - Белтер, не отрываясь, смотрел на скользящий мимо поток. На темном лбу выступил пот. Казалось, он вот-вот потеряет сознание.
   - А холодина там! И воздуха нет, упадешь там и задрыгаешься, как рыба. Разинешь пасть и помрешь. Покорчишься, задохнешься и помрешь!', 317);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1158, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Как это - по душе тебе?
   - Мало ли что мне не по душе, сэр… Пожалуйста, сэр, отпустите меня. Я опоздаю.
   - Отпущу,когдазахочу. Мы будем мило толковать с тобой здесь, пока я не позволю тебе уйти, и ты это отлично знаешь. Значит, путешествовать собрался? Ну, так вот что, мистер «Высоко в небеса», возвращайся домой, черт дери, и отрабатывай пятьдесят зелененьких! Срок тебе - два месяца.
   - Но, сэр, если я останусь отрабатывать, я опоздаю на ракету!
   - Ах, горе-то какое! - Тис попытался изобразить печаль.
   - Возьмите мою лошадь, сэр.
   - Лошадь не может быть признана законным платежным средством. Ты не двинешься с места, пока я не получу своих денег.
   Тис ликовал.', 318);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1159, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Настроение у него было чудесное. У лавки собралась небольшая толпа темнокожих людей. Они стояли и слушали. Белтер дрожал всем телом, понурив голову.
   Вдруг от толпы отделился старик.
   - Мистер?
   Тис глянул на него.
   - Ну?
   - Сколько должен вам этот человек, мистер?
   - Не твое собачье дело!
   Старик повернулся к Белтеру.
   - Сколько, сынок?
   - Пятьдесят долларов.
   Старик протянул черные руки к окружавшим его людям.
   - Нас двадцать пять. Каждый дает по два доллара, и быстрее, сейчас не время спорить.
   - Это еще что такое? - крикнул Тис, величественно выпрямляясь во весь рост.
   Появились деньги. Старик собрал их в шляпу и подал ее Белтеру.
   - Сынок, - сказал он,', 319);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1160, '2025-08-24 23:06:22.571376+03', 6, NULL, '- ты не опоздаешь на ракету.
   Белтер взглянул в шляпу и улыбнулся.
   - Не опоздаю, сэр, теперь не опоздаю!
   Тис заорал:
   - Сейчас же верни им деньги!
   Белтер почтительно поклонился и протянул ему долг, но Тис не взял денег; тогда негр положил их на пыльную землю у его ног.
   - Вот ваши деньги, сэр, - сказал он. - Большое спасибо.
   Улыбаясь, Белтер вскочил в седло и хлестнул лошадь. Он благодарил старика: они ехали рядом и вместе скрылись из виду.
   - Сукин сын! - шептал Тис, глядя на солнце невидящими глазами. - Сукин сын…
   - Подними деньги, Сэмюэль, - сказал кто-то с веранды.
   То же самое происходило вдоль всего пути. Примчались босоногие белые мальчишки и затараторили:', 320);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1161, '2025-08-24 23:06:22.571376+03', 6, NULL, '- У кого есть, помогают тем, у кого нет! И все получают свободу! Один богач дал бедняку двести зелененьких, чтобы тот рассчитался! Еще один дал другому десять зелененьких, пять, шестнадцать - и так повсюду, все так делают!
   Белые сидели с кислыми минами. Они щурились и жмурились, словно в лицо им хлестали обжигающий ветер и пыль.
   Ярость душила Сэмюэля Тиса. Взбежав на веранду, он сверлил глазами катившие мимо толпы. Он размахивал своим пистолетом. Его распирало, злоба искала выхода, и он стал орать, обращаясь ко всем, к любому негру, который оглядывался на него.
   - Бам! Еще ракета взлетела! - вопил он во всю глотку. - Бам! Боже мой!
   Черные головы смотрели вперед,', 321);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1162, '2025-08-24 23:06:22.571376+03', 6, NULL, 'никто не показывал вида, что слушает, только белки скользнут по нему и снова спрячутся.
   - Тр-р-рах! Все ракеты вдребезги! Крики, ужас, смерть! Бам! Боже милосердный! Мне-то что, я остаюсь здесь, на матушке-земле. Старушка не подведет! Ха-ха!
   Постукивали копыта, взбивая пыль. Дребезжали фургоны на разбитых рессорах.
   - Бам! - Голос Тиса одиноко звучал в жарком воздухе, силясь нагнать страх на пыль и ослепительное небо. - Бах! Черномазых раскидало по всему космосу! Как даст метеоромпо ракете и разметало вас, точно малявок! В космосе полно метеоров! А вы не знали? Точно! Как картечь, даже гуще! И посыпятся ваши жестяные ракеты, как рябчики, как глиняные трубки! Ржавые банки,', 322);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1163, '2025-08-24 23:06:22.571376+03', 6, NULL, 'набитые черной треской! Пошли хлопать, как хлопушки: бам! бам! бам! Десять тысяч убитых, еще десять тысяч. Летают вокруг земли в космосе, вечно летают, холодненькие, окоченевшие, высоко- высоко, владыка небесный! Слышите, эй, вы там! Слышите?!
   Молчание. Широко, нескончаемо течет река. Начисто вылизав все лачуги, смыв их содержимое, она несет часы и стиральные доски, шелковые отрезы и гардинные карнизы, несет куда-то в далекое черное море.
   Два часа дня. Прилив схлынул, поток мелеет. А затем река и вовсе высохла, в городе воцарилась тишина, пыль мягким ковром легла на строения, на сидящих мужчин, на высокие, изнывающие от духоты деревья.
   Тишина.
   Мужчины на веранде прислушались.', 323);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1164, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Ничего. Тогда их воображение, их мысли полетели дальше, в окрестные луга. Спозаранку весь край оглашало привычное сочетание звуков. Верные заведенному порядку, тути там пели голоса; под мимозами смеялись влюбленные; где-то журчал смех негритят, плескавшихся в ручье; на полях мелькали спины и руки: из лачуг оплетенных зеленью плюща, доносились шутки и радостные возгласы.
   Сейчас над краем будто пронесся ураган и смел все звуки. Ничего. Гробовая тишина. На кожаных петлях повисли грубо сколоченные двери. В безмолвном воздухе застыли брошенные качели из старых покрышек. Опустели плоские камни на берегу - излюбленное место прачек. На заброшенных бахчах одиноко дозревают арбузы,', 324);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1165, '2025-08-24 23:06:22.571376+03', 6, NULL, 'тая под толстой коркой освежающий сок. Пауки плетут новую паутину в покинутых хижинах; сквозь дырявые крыши вместе с золотистыми лучами солнца проникает пыль. Кое-где теплится забытый в спешке костер, и пламя, внезапно набравшись сил, принимается пожирать сухой остов соломенной лачуги. И тогда тишину нарушает довольное урчание изголодавшегося огня.
   Мужчины, словно окаменев, сидели на веранде скобяной лавки.
   - Не возьму в толк, с чего это им вдруг загорелось уезжать именно сейчас. Вроде, все шло на лад. Что ни день, новые права получали. Чего им еще надо? Избирательный налог отменили, один штат за другим принимает законы, чтобы не линчевать, кругом равноправие! Мало им этого?', 325);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1166, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Зарабатывают почти что не хуже любого белого - и вот тебе на, сорвались с места.
   В дальнем конце опустевшей улицы показался велосипедист.
   - Разрази меня гром, Тис, это твой Силли едет.
   Велосипед остановился возле крыльца, на нем сидел цветной, парнишка лет семнадцати, угловатый, нескладный - длинные руки и ноги, круглая, как арбуз, голова. Он взглянул на Сэмюэля Тиса и улыбнулся.
   - Что, совесть заговорила, вернулся, - сказал Тис.
   - Нет, хозяин, я просто привез велосипед.
   - Это почему же - в ракету не влазит?
   - Да нет, хозяин, не в том дело…
   - Можешь не объяснять в чем дело! Слазь, я не позволю тебе красть мое имущество! - Он толкнул парня. Велосипед упал.', 326);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1167, '2025-08-24 23:06:22.571376+03', 6, NULL, '- Пошел в лавку, медяшки чистить.
   - Что вы сказали, хозяин? - Глаза парня расширились.
   - То, что слышал! Надо ружья распаковать и ящик вскрыть - гвозди пришли из Натчеза…
   - Мистер Тис…
   - Наладить ларь для молотков…
   - Мистер Тис, хозяин!
   - Ты еще стоишь здесь?! - Тис свирепо сверкнул глазами.
   - Мистер Тис, можно я сегодня возьму выходной? - спросил парень извиняющимся голосом.
   - И завтра тоже, и послезавтра, и после-послезавтра? - сказал Тис.
   - Боюсь, что так, хозяин.
   - Бояться тебе надо, это верно. Пойди-ка сюда. - Он потащил парня в лавку и достал из конторки бумагу.
   - Помнишь эту штуку?
   - Что это, хозяин?
   - Твой трудовой контракт. Ты подписал его,', 327);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1168, '2025-08-24 23:06:22.571376+03', 6, NULL, 'вот твой крестик, видишь? Отвечай.
   - Я не подписывал, мистер Тис. - Парень весь трясся. - Кто угодно может поставить крестик.
   - Слушай, Силли. Контракт: «Я обязуюсь работать на мистера Сэмюэля Тиса два года, начиная с 15 июля 2001 года, а если захочу уволиться, то заявлю об этом за четыре недели и буду продолжать работать, пока не будет подыскана замена». Вот, - Тис стукнул ладонью по бумаге, его глаза блестели. - А будешь артачиться, пойдем в суд.
   - Я не могу! - вскричал парень; по его щекам покатились слезы. - Если я не уеду сегодня, я не уеду никогда.
   - Я отлично тебя понимаю, Силли, да-да, и сочувствую тебе. Но ничего, мы будем хорошо обращаться с тобой, парень,', 328);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1169, '2025-08-24 23:06:22.571376+03', 6, NULL, 'хорошо кормить. А теперь ступай и берись за работу, и выкинь из головы всю эту блажь, понял? Вот так, Силли. - Тис мрачно ухмыльнулся и потрепал его по плечу.
   Парень повернулся к старикам, сидящим на веранде. Слезы застилали ему глаза.
   - Может… может, кто из этих джентльменов…
   Мужчины под навесом, истомленные зноем, подняли головы, посмотрели на Силли, потом на Тиса.
   - Это как же понимать: ты хочешь, чтобы твое место занялбелый? -холодно спросил Тис.
   Дед Квортэрмэйн поднял с колен красные руки. Он задумчиво поглядел в даль и сказал:
   - Слышь, Тис, а как насчет меня?
   - Что?
   - Я берусь работать вместо Силли.
   Остальные притихли.
   Тис покачивался на носках.', 329);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1170, '2025-08-24 23:06:22.571376+03', 6, NULL, '- Дед… - произнес он предостерегающе.
   - Отпусти парня, я почищу, что надо.
   - Вы… в самом деле, взаправду? - Силли подбежал к деду. Он смеялся и плакал одновременно, не веря своим ушам.
   - Конечно.
   - Дед, - сказал Тис, - не суй свой паршивый нос в это дело.
   - Не держи мальца, Тис.
   Тис подошел к Силли и схватил его за руку.
   - Он мой. Я запру его в задней комнате до ночи.
   - Не надо, мистер Тис!
   Парень зарыдал. Горький плач громко отдавался под навесом. Темные веки Силли набухли. На дороге вдали появился старенький, дребезжащий «форд», увозивший последнихцветных.
   - Это мой, мистер Тис. О, пожалуйста, прошу вас, ради бога!
   - Тис, - сказал один из мужчин,', 330);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1171, '2025-08-24 23:06:22.571376+03', 6, NULL, 'вставая, - пусть уходит.
   Второй поднялся.
   - Я тоже за это.
   - И я, - вступил третий.
   - К чему это? - Теперь заговорили все. - Кончай, Тис.
   - Отпусти его.
   Тис нащупал в кармане пистолет. Он увидел лица мужчин. Он вынул руку из кармана и сказал:
   - Вот, значит, как?
   - Да, вот так, - отозвался кто-то.
   Тис отпустил парня.
   - Ладно. Катись. - Он ткнул рукой в сторону лавки. - Надеюсь, ты не собираешься оставлять свое грязное барахло?
   - Нет хозяин!
   - Убери все до последней тряпки из своего закутка и сожги!
   Силли покачал головой.
   - Я возьму с собой.
   - Так они и позволят тебе тащить в ракету всякую дрянь!
   - Я возьму с собой, - мягко настаивал парнишка.', 331);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1172, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Он побежал через лавку в пристройку. Слышно было, как он подметает и наводит чистоту. Миг, и Силли появился снова, неся волчки, шарики, старых воздушных змеев и другое барахло, скопленное за несколько лет. Как раз в этот миг подъехал «форд»; Силли сел в машину, хлопнула дверца.
   Тис стоял на веранде, горько улыбаясь.
   - И что же ты собираешься делать там?
   - Откроюсвоедело, - ответил Силли. - Хочу завести скобяную лавку.
   - Ах ты дрянь, так вот ты зачем ко мне нанимался, задумал набить руку, а потом улизнуть и использовать науку!
   - Нет, хозяин, я никогда не думал, что так получится. А оно получилось. Разве я виноват, что научился, мистер Тис?', 332);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1173, '2025-08-24 23:06:22.571376+03', 6, NULL, '- Вы небось придумали имена вашим ракетам?
   Цветные смотрели на свои единственные часы - на приборной доске «форда».
   - Да, хозяин.
   - Небось «Илия» и «Колесница», «Большое колесо» и «Малое колесо», «Вера», «Надежда», «Милосердие»?
   - Мы придумали имена для кораблей, мистер Тис.
   - «Бог-сын» и «Святой дух», да? Скажи, малый, а одну ракету назвали в честь баптистской церкви?
   - Нам пора ехать, мистер Тис.
   Тис хохотал.
   - Неужели ни одну не назвали «Летай пониже» или «Благолепная колесница»?
   Машина тронулась.
   - Прощайте, мистер Тис.
   - А есть у вас ракета «Рассыпьтесь, мои косточки»?
   - Прощайте, мистер!
   - А «Через Иордань»? Ха! Ладно, парень, катись,', 333);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1174, '2025-08-24 23:06:22.571376+03', 6, NULL, 'отваливай на своей ракете, давай лети, пусть взрывается, я плакать не буду!
   Машина покатила прочь в облаке пыли. Силли привстал, приставил ладони ко рту и крикнул напоследок Тису:
   - Мистер Тис, мистер Тис, а что вы теперь будете делатьпо ночам?Что будете делатьночью,хозяин?
   Тишина. Машина растаяла вдали. Дорога опустела.
   - Что он хотел сказать, черт возьми? - недоумевал Тис. - Что я буду делать по ночам?…
   Он смотрел, как оседает пыль, и вдруг до него дошло. Он вспомнил ночи, когда возле его дома останавливались автомашины, а в них - темные силуэты, торчат колени, еще выше торчат дула ружей, будто полный кузов журавлей под черной листвой спящих деревьев. И злые глаза… Гудок,', 334);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1175, '2025-08-24 23:06:22.571376+03', 6, NULL, 'еще гудок, он хлопает дверцей, сжимая в руке ружье, посмеиваясь про себя, и сердце колотится, как у мальчишки, и бешеная гонка по ночной летней дороге, круг толстой веревки на полу машины, коробки новеньких патронов оттопыривают карманы пальто. Сколько было таких ночей за все годы - встречный ветер, треплющий космы волос над недобрыми глазами, торжествующие вопли при виде хорошего дерева, надежного, крепкого дерева, и стук в дверь лачуги!
   - Так вот он про что, сукин сын! - Тис выскочил из тени на дорогу. - Назад, ублюдок! Что я буду делать ночами?! Ах ты гад, подлюга…
   Вопрос Силли попал в самую точку. Тис почувствовал себя больным, опустошенным. "В самом деле.', 335);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1176, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Что мы будем делатьпо ночам? -думал он. - Теперь, когдавсеуехали…" На душе было пусто, мысли оцепенели.
   Он выхватил из кармана пистолет, пересчитал патроны.
   - Ты что это задумал, Сэм? - спросил кто-то.
   - Убью эту сволочь.
   - Не распаляйся так, - сказал дед.
   Но Сэмюэль Тис уже исчез за лавкой. Секундой позже он выехал в своей открытой машине.
   - Кто со мной?
   - Я прокачусь, пожалуй, - отозвался дед, вставая.
   - Еще кто?
   Молчание.
   Дед сел в машину и захлопнул дверцу. Сэмюэль Тис, вздымая пыль, вырулил на дорогу, и они рванулись вперед под ослепительным небом. Оба молчали. Над сухими нивами по сторонам струилось жаркое марево.
   Развилок. Стоп.
   - Куда они поехали,', 336);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1177, '2025-08-24 23:06:22.571376+03', 6, NULL, 'дед?
   Дед Квортэрмэйн прищурился.
   - Прямо, сдается мне.
   Они продолжали путь. Одиноко ворчал мотор под летними деревьями. Дорога была пуста, но вот они стали примечать что-то необычное. Наконец Тис сбавил ход и перегнулсячерез дверцу, свирепо сверкая желтыми глазами.
   - Черт подери, дед! Ты видишь, что придумали эти ублюдки?
   - Что? - спросил дед, присматриваясь.
   Вдоль дороги непрерывной цепочкой, аккуратными кучками лежали старые роликовые коньки, пестрые узелки с безделушками, рваные башмаки, колеса от телеги, поношенные брюки и пальто, драные шляпы, побрякушки из хрусталя, когда-то нежно звеневшие на ветру, жестяные банки с розовой геранью, восковые фрукты,', 337);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1178, '2025-08-24 23:06:22.571376+03', 6, NULL, 'коробки с деньгами времен конфедерации, тазы, стиральные доски, веревки для белья, мыло, чей-то трехколесный велосипед, чьи-то садовые ножницы, кукольная коляска, чертик в коробочке, пестроеокно из негритянской баптистской церкви, набор тормозных прокладок, автомобильные камеры, матрасы, кушетки, качалки, баночки с кремом, зеркала. И все это не было брошено кое-как, наспех, а положено бережно, с чувством, со вкусом вдоль пыльных обочин, словно целый город шел здесь, нагруженный до отказа, и вдруг раздался великий трубный глас, люди сложили свои пожитки в пыль и вознеслись прямиком на голубые небеса.
   - «Не хотим жечь», как же! - злобно крикнул Тис. - Я им говорю сожгите, так нет,', 338);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1179, '2025-08-24 23:06:22.571376+03', 6, NULL, 'тащили всю дорогу и сложили здесь - напоследок еще раз посмотреть на свое барахло, вот оно, полюбуйтесь! Эти черномазые невесть что о себе воображают.
   Он гнал машину дальше, километр за километром, наезжая на кучи, кроша шкатулки и зеркала, ломая стулья, рассыпая бумаги.
   - Так! Черт дери… Еще! Так!
   Передняя шина жалобно запищала. Машина вильнула и врезалась в канаву, Тис стукнулся лбом о ветровое стекло.
   - А, сукины дети! - Сэмюэль Тис стряхнул с себя пыль и вышел из машины, чуть не плача от ярости. Он посмотрел на пустынную безмолвную дорогу.
   - Теперь мы уж их никогда не догоним, никогда.
   Насколько хватал глаз, он видел только аккуратно сложенные узлы и кучи, и еще узлы,', 339);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1180, '2025-08-24 23:06:22.571376+03', 6, NULL, 'словно покинутые святыни, под жарким ветром, в свете угасающего дня. [Картинка: pic_7.png] 
   Час спустя Тис и дед, усталые, подошли к скобяной лавке. Мужчины все еще сидели там, прислушиваясь и глядя на небо. В тот самый миг, когда Тис присел и стал снимать тесные ботинки, кто-то воскликнул:
   - Смотрите!
   - К черту! - прорычал Тис.
   Но остальные смотрели, привстав. И они увидели далеко-далеко уходящие ввысь золотые веретена. Оставляя за собой хвосты пламени, они исчезли.
   На хлопковых полях ветер лениво трепал белоснежные комочки. На бахчах лежали нетронутые арбузы, полосатые, как тигровые кошки, греющиеся на солнце.
   Мужчины на веранде сели, поглядели друг на друга,', 340);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1181, '2025-08-24 23:06:22.571376+03', 6, NULL, 'поглядели на желтые веревки, аккуратно сложенные на полках, на сверкающие гильзы патронов в коробках, на серебряные пистолеты и длинные вороненые стволы винтовок, мирно висящих в тени под потолком. Кто-то сунул в рот травинку. Кто-то начертил в пыли человечка.
   Сэмюэль Тис торжествующе поднял ботинок, перевернул его, заглянул внутрь и сказал:
   - А вы заметили? Он до самого конца говорил мне «хозяин», ей-богу!
   2004 - 2005

   Новые имена
   Они пришли и заняли удивительные голубые земли и всему дали свои имена. Появились ручей Хинкстон-Крик и поляна Люстиг-Корнерс, река Блэк-Ривер и лес Дрисколл-Форест, гора Перегрин-Маунтин и город Уайлдертаун - все в честь людей и того,', 341);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1182, '2025-08-24 23:06:22.571376+03', 6, NULL, 'что совершили люди. Там, где марсиане убили первых землян, появился Редтаун - название, связанное с кровью. А вот здесь погибла Вторая экспедиция - отсюда название: Вторая Попытка; и всюду, где космонавты при посадке опалили землю своими огненными снарядами, остались имена - словно кучи шлака; не обошлось, разумеется, без горы Спендер-Хилл и города с длинным названием Натаниел-Йорк…
   Старые марсианские названия были названия воды, воздуха, гор. Названия снегов, которые, тая на юге, стекали в каменные русла каналов, питающих высохшие моря. Имена чародеев, чей прах покоился в склепах, названия башен и обелисков. И ракеты, подобно молотам, обрушились на эти имена, разбивая вдребезги мрамор,', 342);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1183, '2025-08-24 23:06:22.571376+03', 6, NULL, 'кроша фаянсовые тумбы с названиями старых городов, и над грудами обломков выросли огромные пилоны с новыми указателями: АЙРОНТАУН, СТИЛТАУН, АЛЮМИНИУМ-СИТИ, ЭЛЕКТРИК-ВИЛЛЕДЖ, КОРН-ТАУН,ГРЭЙН-ВИЛЛА, ДЕТРОЙТ II - знакомые механические, металлические названия с Земли.
   А когда построили и окрестили города, появились кладбища, они тоже получили имена: Зеленый Уголок, Белые Мхи, Тихий Пригорок, Отдохни Малость - и первые покойники легли в свои могилы…
   Когда же все было наколото на булавочки, чинно, аккуратно разложено по полочкам, когда все стало на свои места, города прочно утвердились и уединение стало почти невозможным - тогда-то с Земли стали прибывать искушенные и всезнающие.', 343);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1184, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Они приезжали в гости и в отпуск, приезжали купить сувениры и сфотографироваться - «подышать марсианским воздухом»; они приезжали вести исследования и проводить в жизнь социологические законы; они привозили с собой свои звезды, кокарды, правила и уставы, не забыли прихватить и семена бюрократии, которая въедливым сорняком оплела Землю, и насадили их на Марсе всюду, где они только могли укорениться. Они стали законодателями быта и нравов; принялись направлять, наставлять и подталкивать на путь истинный тех самых людей, кто перебрался на Марс, чтобы избавиться от наставлений и назиданий.
   И нет ничего удивительного в том,', 344);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1185, '2025-08-24 23:06:22.571376+03', 6, NULL, 'что кое-кто из подталкиваемых стал отбиваться…
   Апрель 2005

   Эшер II
   «Весь этот день - тусклый, темный, беззвучный осенний день - я ехал верхом в полном одиночестве по необычайно пустынной местности, над которой низко нависали свинцовые тучи, и наконец, когда вечерние тени легли на землю, очутился перед унылой усадьбой Эшера…»
   Мистер Уильям Стендаль перестал читать. Вот она перед ним, на невысоком черном пригорке - Усадьба, и на угловом камне начертано: 2005 год.
   Мистер Бигелоу, архитектор, сказал:
   - Дом готов. Примите ключ, мистер Стендаль.
   Они помолчали, стоя рядом, в тишине осеннего дня. На черной как вороново крыло траве у их ног шуршали чертежи.
   - Дом Эшеров,', 345);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1186, '2025-08-24 23:06:22.571376+03', 6, NULL, '- удовлетворенно произнес мистер Стендаль. - Спроектирован, выстроен, куплен, оплачен. Думаю, мистер По был быв восторге!
   Мистер Бигелоу прищурился.
   - Все отвечает вашим пожеланиям, сэр?
   - Да!
   - Колорит такой, какой нужен? Картинатоскливаяиужасная?
   - Чрезвычайноужасная,чрезвычайнотоскливая!
   - Стены -угрюмые?
   - Поразительно!
   - Пруд достаточно «черный и мрачный»?
   - Невообразимо черный и мрачный.
   - А осока - она окрашена, как вам известно, - в меру чахлая и седая?
   - До отвращения!
   Мистер Бигелоу сверился с архитектурным проектом. Он процитировал задание:
   - Весь ансамбль внушает «леденящую, ноющую, сосущую боль сердца, безотрадную пустоту в мыслях»? Дом,', 346);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1187, '2025-08-24 23:06:22.571376+03', 6, NULL, 'пруд, усадьба?…
   - Вы поработали на славу, мистер Бигелоу! Клянусь, это изумительно!
   - Благодарю. Я ведь совершенно не понимал, что от меня требуется. Слава богу, что у вас есть свои ракеты, иначе нам никогда не позволили бы перебросить сюда необходимое оборудование. Обратите внимание, здесь постоянные сумерки, в этом уголке всегда октябрь, всегда пустынно, безжизненно, мертво. Это стоило нам немалых трудов. Десять тысяч тонн ДДТ. Мы все убили. Ни змеи, ни лягушки, ни одной марсианской мухи не осталось! Вечные сумерки, мистер Стендаль, это моя гордость. Скрытые машины глушат солнечный свет. Здесь всегда «безотрадно».
   Стендаль упивался безотрадностью, свинцовой тяжестью,', 347);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1188, '2025-08-24 23:06:22.571376+03', 6, NULL, 'удушливыми испарениями, всей «атмосферой», задуманной и созданной с таким искусством. А сам Дом! Угрюмая обветшалость, зловещий пруд, плесень, призраки всеобщего тления! Синтетические материалы или еще что-нибудь? Поди угадай.
   Он взглянул на осеннее небо. Где-то вверху, вдали, далеко-далеко - солнце. Где- то на планете - марсианский апрель, золотой апрель, голубое небо. Где-то вверху прожигают себе путь ракеты, призванные цивилизовать прекрасную, безжизненную планету. Визг и вой их стремительного полета глохнул в этом тусклом звуконепроницаемом мире, вэтом мире дремучей осени.
   - Теперь, когда задание выполнено, - смущенно заговорил мистер Бигелоу, - могу я спросить,', 348);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1189, '2025-08-24 23:06:22.571376+03', 6, NULL, 'что вы собираетесь делать со всем этим?
   - С усадьбой Эшер? Вы не догадались?
   - Нет.
   - Название «Эшер» вам ничего не говорит?
   - Ничего.
   - Ну атакоеимя: Эдгар Алан По?
   Мистер Бигелоу отрицательно покачал головой.
   - Разумеется. - Стендаль сдержанно фыркнул, выражая печаль и презрение. - Откуда вам знать блаженной памяти мистера По? Он умер очень давно, раньше Линкольна. Все его книги были сожжены на Великом Костре. Тридцать лет назад, в 1975.
   - А, - понимающе кивнул мистер Бигелоу. - Один изэтих!
   - Вот именно, Бигелоу, один из этих. Его и Лавкрафта, Хоторна и Амброза Бирса, все повести об ужасах и страхах, все фантазии, да что там, все повести о будущем сожгли.', 349);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1190, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Безжалостно. Закон провели. Началось с малого, с песчинки, еще в пятидесятых и шестидесятых годах. Сперва ограничили выпуск книжек с карикатурами, потом детективных романов, фильмов, разумеется. Кидались то в одну крайность, то в другую, брали верх различные группы, разные клики, политические предубеждения, религиозные предрассудки. Всегда было меньшинство, которое чего- то боялось, и подавляющее большинство, которое боялось непонятного, будущего, прошлого, настоящего, боялось самого себя и собственной тени.
   - Понятно.
   - Устрашаемые словом «политика» (которое в конце концов в наиболее реакционных кругах стало синонимом «коммунизма», да-да,', 350);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1191, '2025-08-24 23:06:22.571376+03', 6, NULL, 'и за одно только употребление этого слова можно было поплатиться жизнью!), понукаемые со всех сторон - здесь подтянут гайку, там закрутят болт, оттуда ткнут, отсюда пырнут, - искусство и литература вскоре стали похожи на огромную тянучку, которую выкручивали, жали, мяли, завязывали в узел, швыряли туда-сюда до тех пор, пока она не утратила всякую упругость и всякий вкус. А потом осеклись кинокамеры, погрузились в мрак театры, и могучая Ниагара печатной продукции превратилась в выхолощенную струйку «чистого» материала. Поверьте мне, понятие «уход от действительности» тоже попало в разряд крамольных!
   - Неужели?
   - Да-да! Всякий человек, говорили они,', 351);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1192, '2025-08-24 23:06:22.571376+03', 6, NULL, 'обязан смотреть в лицо действительности. Видеть только сиюминутное! Все, чтонепопадало в эту категорию, - прочь. Прекрасные литературные вымыслы, полет фантазии - бей влет. И вот воскресным утром, тридцать лет назад, в 1975 году их поставили к библиотечной стенке: Санта-Клауса и Всадника без головы, Белоснежку, и Домового, и Матушку-Гусыню - все в голос рыдали! - и расстреляли их, потом сожгли бумажные замки и царевен- лягушек, старых королей и всех, кто «с тех пор зажил счастливо» (в самом деле, окомможно сказать, что он с тех пор зажил счастливо!), и Некогда превратилось в Никогда! И они развеяли по ветру прах Заколдованного Рикши вместе с черепками Страны Оз,', 352);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1193, '2025-08-24 23:06:22.571376+03', 6, NULL, 'изрубили Глинду Добрую и Озму, разложили Многоцветку в спектроскопе, а Джека Тыквенную Голову подали к столу на Балу Биологов! Гороховый Стручок зачах в бюрократических зарослях! Спящая Красавица была разбужена поцелуем научного работника и испустила дух, когда он вонзил в нее медицинский шприц. Алису они заставили выпить из бутылки нечто такое, от чего она стала такой крохотной, что уже не могла больше кричать: «Чем дальше, тем любопытственнее!» Волшебное Зеркало они одним ударом молота разбили вдребезги, и пропали все Красные Короли и Устрицы!
   Он сжал кулаки. Господи, как все это близко, точно случилось вот сейчас! Лицо его побагровело, он задыхался.', 353);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1194, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Столь бурное извержение ошеломило мистера Бигелоу. Он моргнул раз-другой и наконец сказал:
   - Извините. Не понимаю, о чем вы. Эти имена ничего мне не говорят. Судя по тому, что вы сейчас говорили, костер был только на пользу.
   - Вон отсюда! - вскричал Стендаль. - Ваша работа завершена, теперь убирайтесь, болван!
   Мистер Бигелоу кликнул своих плотников и ушел.
   Мистер Стендаль остался один перед Домом.
   - Слушайте, вы! - обратился он к незримым ракетам. - Я перебрался на Марс, спасаясь от вас, Чистые Души, а вас, что ни день, все больше и больше здесь, вы слетаетесь, словно мухи на падаль. Так я вам тут кое-что покажу. Я проучу вас за то, что вы сделали на Земле с мистером По.', 354);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1195, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Отныне берегитесь! Дом Эшера начинает свою деятельность!
   Он погрозил небу кулаком.

   Ракета села. Из нее важно вышел человек. Он посмотрел на Дом, и серые глаза его выразили неудовольствие и досаду. Он перешагнул ров, за которым его ждал щуплый мужчина.
   - Ваша фамилия Стендаль?
   - Да.
   - Гаррет, инспектор из управления Нравственного Климата.
   - Ага, вы таки добрались до Марса, блюстители Нравственного Климата? Я уже прикидывал, когда же вы тут появитесь…
   - Мы прибыли на прошлой неделе. Скоро здесь будет полный порядок, как на Земле. - Он раздраженно помахал своим удостоверением в сторону Дома. - Расскажите-ка мне, что это такое, Стендаль?
   - Это замок с привидениями,', 355);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1196, '2025-08-24 23:06:22.571376+03', 6, NULL, 'если вам угодно.
   - Не угодно, Стендаль,никакне угодно. «С привидениями» - не годится.
   - Очень просто. В нынешнем, две тысячи пятом году господа бога нашего я построил механическое святилище. В нем медные летучие мыши летают вдоль электронных лучей, латунные крысы снуют в пластмассовых подвалах, пляшут автоматические скелеты, здесь обитают автоматические вампиры, шуты, волки и белые призраки, порождение химии иизобретательности.
   - Именно этого я опасался, - сказал Гаррет с улыбочкой. - Боюсь, придется снести ваш домик.
   - Я знал, что вы явитесь, едва проведаете.
   - Я бы раньше прилетел, но мы хотели удостовериться в ваших намерениях, прежде чем вмешиваться.', 356);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1197, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Демонтажники и Огневая Команда могут прибыть к вечеру. К полуночи все будет разрушено до основания, мистер Стендаль. По моему разумению, сэр. Вы, я бы сказал, сглупили. Выбрасывать на ветер деньги, заработанные упорным трудом. Да вам это миллиона три стало…
   - Четыре миллиона! Но учтите, мистер Гаррет, я был еще совсем молод, когда получил наследство, - двадцать пять миллионов. Могу позволить себе быть мотом. А вообще-то это досадно: только закончил строительство, как вы уже здесь со своими Демонтажниками. Может, позволите мне потешиться моей Игрушкой, ну, хотя бы двадцать четыре часа?
   - Вам известен Закон Как положено: никаких книг, никаких домов, ничего,', 357);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1198, '2025-08-24 23:06:22.571376+03', 6, NULL, 'что было бы сопряжено с привидениями, вампирами, феями или иными творениями фантазии.
   - Вы скоро начнете жечь мистеров Бэббитов!
   - Вы уже причинили нам достаточно хлопот, мистер Стендаль. Сохранились протоколы. Двадцать лет назад. На Земле. Вы и ваша библиотека.
   - О да, я и моя библиотека. И еще несколько таких же, как я. Конечно, По был уже давно забыт тогда, забыты Оз и другие создания. Но я устроил небольшой тайник. У нас были свои библиотеки - у меня и еще у нескольких частных лиц, - пока вы не прислали своих людей с факелами и мусоросжигателями. Изорвали в клочья мои пятьдесят тысяч книг исожгли их. Вы так же расправились и со всеми чудотворцами;', 358);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1199, '2025-08-24 23:06:22.571376+03', 6, NULL, 'и вы еще приказали вашим кинопродюсерам, если они вообще хотят что-нибудь делать, пусть снимают и переснимают Эрнеста Хемингуэя. Боже мой, сколько раз я видел «По ком звонит колокол»! Тридцать различных постановок. Все реалистичные. О реализм! Ох, уж этот реализм! Чтоб его!..
   - Рекомендовал бы воздержаться от сарказма!
   - Мистер Гаррет, вы ведь обязаны представить полный отчет?
   - Да.
   - В таком случае, любопытства ради, вошли бы, посмотрели. Всего одну минуту.
   - Хорошо. Показывайте. И никаких фокусов. У меня есть пистолет.
   Дверь Дома Эшеров со скрипом распахнулась. Повеяло сыростью. Послышались могучие вздохи и стоны, точно в заброшенных катакомбах дышали незримые мехи.', 359);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1200, '2025-08-24 23:06:22.571376+03', 6, NULL, 'По каменному полу метнулась крыса. Гаррет гикнул и наподдал ее ногой. Крыса перекувырнулась, и из ее нейлонового меха высыпали полчища металлических блох.
   - Поразительно! - Гаррет нагнулся, чтобы лучше видеть.
   В нише, тряся восковыми руками над оранжево-голубыми картами, сидела старая ведьма. Она вздернула голову и зашипела беззубым ртом на Гаррета, постукивая пальцем позасаленным картам.
   - Смерть! - крикнула она.
   - Вот именнотакиевещи я и подразумевал… - сказал Гаррет. - Весьма предосудительно!
   - Я разрешу вам лично сжечь ее.
   - В самом деле? - Гаррет просиял. Но тут же нахмурился. - Вы так легко об этом говорите.
   - Для меня достаточно было устроить все это.', 360);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1201, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Чтобы я мог сказать, что добился своего. В современном скептическом мире воссоздал средневековую атмосферу.
   - Я и сам, сэр, так сказать, невольно восхищен вашим гением.
   Гаррет смотрел - мимо него проплывало в воздухе, шелестя и шепча, легкое облачко, которое приняло облик прекрасной призрачной женщины. В дальнем конце сырого коридора гудела какая-то машина. Как сахарная вата из центрифуги, оттуда ползла и расплывалась по безмолвным залам бормочущая мгла.
   Невесть откуда возникла обезьяна.
   - Брысь! - крикнул Гаррет.
   - Не бойтесь. - Стендаль похлопал животное по черной груди. - Это робот. Медный скелет и так далее, как и ведьма. Вот!
   Он взъерошил мех обезьяны,', 361);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1202, '2025-08-24 23:06:22.571376+03', 6, NULL, 'блеснул металлический корпус.
   - Вижу. - Гаррет протянул робкую руку, потрепал робота. - Но к чему это, мистер Стендаль, в чем смысл всегоэтого?Что вас довело?…
   - Бюрократия, мистер Гаррет. Но мне некогда объяснять. Властям и без того скоро все будет ясно. - Он кивнул обезьяне. - Пора.Давай.
   Обезьяна убила мистера Гаррета.

   - Почти готово, Пайкс?
   Пайкс оторвал взгляд от стола.
   - Да, сэр.
   - Отличная работа.
   - Даром хлеб не едим, мистер Стендаль, - тихо ответил Пайкс; приподняв упругое веко робота, он вставил стеклянное глазное яблоко и ловко прикрепил к нему каучуковые мышцы. - Так…
   - Вылитый мистер Гаррет.
   - А с ним что делать, сэр?', 362);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1203, '2025-08-24 23:06:22.571376+03', 6, NULL, '- Пайкс кивком головы указал на каменную плиту, где лежал настоящий мертвый Гаррет.
   - Лучше всего сжечь. Пайкс. На что нам два мистера Гаррета, верно?
   Пайкс подтащил Гаррета к кирпичному мусоросжигателю.
   - Всего хорошего.
   Он втолкнул мистера Гаррета внутрь и захлопнул дверку.
   Стендаль обратился к роботу Гаррету.
   - Вам ясно ваше задание, Гаррет?
   - Да, сэр. - Робот приподнялся и сел. - Я должен вернуться в управление Нравственного Климата. Представить дополнительный доклад. Оттянуть операцию самое малое на сорок восемь часов. Сказать, что мне нужно провести более обстоятельное расследование.
   - Правильно, Гаррет. Желаю успеха.
   Робот поспешно прошел к ракете Гаррета,', 363);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1204, '2025-08-24 23:06:22.571376+03', 6, NULL, 'поднялся в нее и улетел.
   Стендаль повернулся.
   - Ну, Пайкс, теперь разошлем оставшиеся приглашения на сегодняшний вечер. Полагаю, будет весело. Как вы думаете?
   - Учитывая, что мы ждали двадцать лет, - даже очень весело!
   Они подмигнули друг другу.
   Ровно семь. Стендаль взглянул на часы. Теперь уж недолго. Он сидел в кресле и вертел в руке рюмку с хересом. Над ним, меж дубовых балок попискивали, сверкая глазками, летучие мыши, тонкие медные скелетики, обтянутые резиновой плотью. Он поднял рюмку, приветствуя их.
   - За наш успех.
   Откинулся назад, сомкнул веки и мысленно проверил все сначала.', 364);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1205, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Уж отведет он душу на старости лет… Отомстит этому антисептическому правительству за расправу с литературой, за костры. Годами копился гнев, копилась ненависть… И в оцепенелой душе исподволь, медленно зрел замысел. Так было до того дня три года назад, когда он встретил Пайкса.
   Именно, Пайкса. Пайкса, ожесточенная душа которого была как обугленный черный колодец, наполненный едкой кислотой. Кто такой Пайкс? Величайший из них всех, только ивсего! Пайкс - человек с тысячами личин, фурия, дым, голубой туман, седой дождь, летучая мышь, горгона, чудовище, вот кто Пайкс! «Лучше, чем Лон Чени, патриарх?» - спросил себя Стендаль. Чени, которого он смотрел в древних фильмах,', 365);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1206, '2025-08-24 23:06:22.571376+03', 6, NULL, 'много вечеров подряд смотрел… Да, лучше чем Чени. Лучше того, другого старинного актера - как его, Карлофф, кажется? Гораздо лучше! А Люгоси? Никакого сравнения! Пайкс - единственный, неподражаемый. И что же, его ограбили, отняли право на выдумку, и некуда податься, не перед кем лицедействовать. Запретили играть даже перед зеркалом для самого себя!
   Бедняга Пайкс - невероятный, обезоруженный Пайкс! Что ты чувствовал в тот вечер, когда они конфисковали твои фильмы, вырывали, вытягивали, подобно внутренностям, кольца пленки из кинокамеры, из твоего чрева, хватали, комкали, бросали в печь, сжигали! Было ли это так же больно, как потерять, ничего не получив взамен, пятьдесят тысяч книг? Да.', 366);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1207, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Да. Стендаль почувствовал, как руки его холодеют от каменной ярости И вот однажды - что может быть естественнее - они встретились и заговорили, и разговоры их растянулись на бессчетные ночи, как не было счета и чашкам кофе, и из потока слов и горького настоя родился - Дом Эшера.
   Гулкий звон церковного колокола. Начался съезд гостей.
   Улыбаясь, он пошел встретить их.

   Роботы ждали - взрослые без воспоминаний детства. Ждали роботы в зеленых шелках цвета лесных озер, в шелках цвета лягушки и папоротника. Ждали роботы с желтыми волосами цвета песка и солнца. Роботы лежали, смазанные, с трубчатыми костями из бронзы в желатине. В гробах для не живых и не мертвых,', 367);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1208, '2025-08-24 23:06:22.571376+03', 6, NULL, 'в дощатых ящиках маятники ждали, когда их толкнут. Стоял запах смазки и латунной стружки. Стояла гробовая тишина. Роботы - обоего пола, но бесполые. С лицами, не безликие, заимствовавшие у человека все, кроме человечности, роботы смотрели в упор на прошитые гвоздями крышки ящиков с надписью «Франкоборт», пребывая в небытии, которого смертью не назовешь, потому что ему не предшествовала жизнь… Но вот громко взвизгнули гвозди. Одна за другой поднимаются крышки. По ящикам мечутся тени, стиснутая рукой масленка брызжет машинным маслом. Тихонько затикал один механизм, пушенный в ход. Еще один, еще, и вот уже застрекотало все кругом, как в огромном часовом магазине.', 368);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1209, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Каменные глаза раздвинули резиновые веки. Затрепетали ноздри. Встали на ноги роботы, покрытые обезьяньей шерстью и мехом белого кролика. Близнецы Твидлдам и Твидлди, Телячья Голова, Соня, бледные утопленники - соль и зыбкие водоросли вместо плоти, посиневшие висельники с закатившимися глазами цвета устриц, создания из льда и сверкающей мишуры, глиняные карлики и коричневые эльфы. Тик-так, Страшила, Санта-Клаус в облаке искусственной метели. Синяя Борода - бакенбарды словно пламя ацетиленовой горелки. Поплыли клубы серного дыма с языками зеленого огня, и будто изваянный из глыбы чешуйчатого змеевика, дракон с пылающей жаровней в брюхе протиснулся через дверь: вой, стук, рев, тишина, рывок,', 369);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1210, '2025-08-24 23:06:22.571376+03', 6, NULL, 'поворот. Тысячи крышек снова захлопнулись. Часовой магазин двинулся на Дом Эшера. Ночь колдовства началась.

   На усадьбу повеяло теплом. Прожигая небо, превращая осень в весну, прибывали ракеты гостей.
   Из ракет выходили мужчины в вечерних костюмах, за ними следовали женщины с замысловатейшими прическами.
   - Вот онкакой,Эшер!
   - А где же дверь?
   И тут появился Стендаль. Женщины смеялись и болтали. Мистер Стендаль поднял руку, прося тишины. Потом повернулся, обратил взгляд к окну высоко в стене замка и крикнул:Рапунцель. Рапунцель, проснись,Спусти свои косоньки вниз.
   Прекрасная девушка выглянула в окно навстречу ночному ветерку и спустила вниз золотые косы. И косы, сплетаясь,', 370);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1211, '2025-08-24 23:06:22.571376+03', 6, NULL, 'развеваясь, стали лестницей, по которой смеющиеся гости могли подняться в Дом.
   Самые видные социологи! Самые проницательные психологи! Самые что ни на есть выдающиеся политики бактериологи, психоневрологи! Вот они все тут, между серых стен.
   - Добро пожаловать!
   Мистер Трайон, мистер Оуэн, мистер Данн, мистер Лэнг, мистер Стеффенс, мистер Флетчер и еще две дюжины знаменитостей.
   - Входите, входите!
   Мисс Гиббс, мисс Поуп, мисс Черчилль, мисс Блат, мисс Драммонд и еще два десятка блестящих женщин.
   Все без исключения видные виднейшие лица, члены Общества Борьбы с фантазиями, поборники запрета старых праздников - «всех святых» и Гая Фокса, убийцы летучих мышей, истребители книг,', 371);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1212, '2025-08-24 23:06:22.571376+03', 6, NULL, 'факельщики, все без исключения добропорядочные незапятнанные граждане, которые предоставили людям попроще, погрубее первыми прилететь на Марс,похоронить марсиан, очистить от заразы поселения, построить города, отремонтировать дороги и вообще устранить всякие непорядки. А уж потом, когда прочно утвердилась Безопасность, эти Душители Радости, эти субъекты с формалином вместо крови и с глазами цвета йодной настойки явились насаждать свой Нравственный Климат и милостиво наделять всех добродетелями. И все они - его друзья! Да-да, в прошлом году на Земле он неназойливо, осторожно с каждым из них познакомился, каждому выказал свое расположение.
   - Добро пожаловать в безбрежные покои Смерти!', 372);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1213, '2025-08-24 23:06:22.571376+03', 6, NULL, '- крикнул он.
   - Послушайте, Стендаль, что все этозначит?
   - Увидите. Всем раздеться! Вон там есть кабины. Наденьте костюмы, которые там приготовлены. Мужчины - в эту сторону, женщины - в ту.
   Гости стояли в некотором замешательстве.
   - Не знаю, прилично ли нам оставаться, - сказала мисс Поуп. - Не нравится мне здесь. Это… это похоже на кощунство.
   - Чепуха,костюмированныйбал!
   - Боюсь, это все противозаконно. - Мистер Стеффенс настороженно шмыгал носом.
   - Полно! - рассмеялся Стендаль. - Повеселитесь хоть раз. Завтра тут будут одни развалины. По кабинам!
   Дом сверкал жизнью и красками, шуты звенели бубенчиками, белые мыши танцевали миниатюрную кадриль под музыку карликов,', 373);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1214, '2025-08-24 23:06:22.571376+03', 6, NULL, 'которые щекотали крохотные скрипки крошечными смычками, флажки трепетали под закоптелыми балками, и стаи летучих мышей кружили у разверстых пастей горгулий, извергавших холодное, хмельное, пенное вино. Через все семь залов костюмированного бала бежал ручеек. Гости приложились к нему и обнаружили, что это херес! Гости высыпали из кабин, сбросив годы с плеч, скрывшись подмаскарадными домино, и уже то, что они надели маски, лишало их права осуждать фантазии и ужасы. Кружились смеющиеся женщины в красных одеждах. Мужчины увивались за ними. По стенам скользили тени, отброшенные неведомо кем, тут и там висели зеркала, в которых ничто не отражалось.
   - Да мы все упыри!', 374);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1215, '2025-08-24 23:06:22.571376+03', 6, NULL, '- рассмеялся мистер Флетчер. - Мертвецы!
   Семь залов, каждый иного цвета: один голубой, один пурпурный, один зеленый, один оранжевый, еще один белый, шестой фиолетовый, седьмой затянут черным бархатом. В черном зале эбеновые куранты гулко отбивали часы. Из зала в зал, между фантастическими роботами, между Сонями и Сумасшедшими Шляпниками, Троллями и Великанами, ЧернымиКотами и Белыми Королевами носились опьяневшие гости, и под их пляшущими ногами пол пульсировал тяжело и глухо, точно сокрытое под ним сердце не могло сдержать своего волнения.
   - Мистер Стендаль!
   Шепотом.
   - Мистер Стендаль!
   Рядом с ним стояло чудовище в маске Смерти. Это был Пайкс.', 375);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1216, '2025-08-24 23:06:22.571376+03', 6, NULL, '- Нам нужно поговорить наедине.
   - В чем дело?
   - Вот. - Пайкс протянул ему костлявую руку. В ней была горсть оплавленных, почерневших колесиков, гайки, винты, болты.
   Стендаль долго смотрел на них. Затем увлек Пайкса в коридор.
   - Гаррет? - спросил он шепотом.
   Пайкс кивнул.
   - Он прислал робота вместо себя. Я нашел это только что, когда чистил мусоросжигатель.
   Оба глядели на зловещие винты.
   - Это значит, что в любой момент может нагрянуть полиция, - сказал Пайкс. - Наши планы рухнут.
   - Это еще неизвестно. - Стендаль взглянул на кружащихся желтых, синих, оранжевых людей. Музыка волнами неслась сквозь туманные просторы залов. - Я должен был догадаться,', 376);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1217, '2025-08-24 23:06:22.571376+03', 6, NULL, 'что Гаррет не настолько глуп, чтобы явиться лично. Но погодите-ка!
   - Что случилось?
   - Ничего. Ничего серьезного. Гаррет прислал к нам робота. Но ведь мы ответили тем же. Если он не будет очень уж приглядываться, то просто не заметит подмены.
   - Конечно!
   - Следующий раз он явится сам. Теперь он уверен, что ему ничто не грозит. Ждите его с минуты на минуту,собственнойперсоной! Еще вина, Пайкс?
   Зазвонил большой колокол.
   - Бьюсь об заклад, это он. Идите, впустите мистера Гаррета.
   Рапунцель спустила вниз свои золотые волосы.
   - Мистер Стендаль?
   - Мистер Гаррет,подлинныйГаррет?
   - Он самый. - Гаррет окинул пристальным взглядом сырые стены и кружащихся людей. - Решил,', 377);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1218, '2025-08-24 23:06:22.571376+03', 6, NULL, 'лучше самому посмотреть. На роботов нельзя положиться. Тем более, на чужих роботов. Заодно я предусмотрительно вызвал Демонтажников. Через час они прибудут, чтобы обрушить стены этого мерзостного логова.
   Стендаль поклонился.
   - Спасибо за предупреждение. - Он сделал жест рукой. - А пока приглашаю вас развлечься. Немного вина?
   - Нет-нет, благодарю. Что тут происходит? Где предел падения человека?
   - Убедитесь сами, мистер Гаррет.
   - Разврат, - сказал Гаррет.
   - Самый гнусный, - подтвердил Стендаль.
   Где-то завизжала женщина Подбежала мисс Поуп, бледная, как сыр.
   - Что сейчас случилось, какой ужас! На моих глазах обезьяна задушила мисс Блант и затолкала ее в дымоход!', 378);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1219, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Они заглянули в трубу и увидели свисающие вниз длинные желтые волосы. Гаррет вскрикнул.
   - Ужасно! - причитала мисс Поуп. Вдруг она осеклась. Захлопала глазами и повернулась: - Мисс Блант!
   - Да. - Мисс Блант стояла рядом с ней.
   - Но я только что видела вас в каминной трубе!
   - Нет, - рассмеялась мисс Блант - Это был робот, моя копия. Искусная репродукция!
   - Но, но…
   - Утрите слезы, милочка. Я жива-здорова. Разрешите мне взглянуть на себя. Так вотгдея! Да, в дымоходе, как вы и сказали. Потешно, не правда ли?
   Мисс Блант удалилась, смеясь.
   - Хотите выпить, Гаррет?
   - Пожалуй, выпью. Немного расстроился. Боже мой, что за место. Оновполнезаслуживает разрушения.', 379);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1220, '2025-08-24 23:06:22.571376+03', 6, NULL, 'На мгновение мне… - Гаррет выпил вина.
   Новый крик. Четыре белых кролика несли на спине мистера Стеффенса вниз по лестнице, которая вдруг чудом открылась в полу. Мистера Стеффенса утащили в яму и оставили там, связанного по рукам и ногам, глядеть, как сверху все ниже, ниже, ближе и ближе к его простертому телу опускалось, качаясь, острое как бритва, лезвие огромного маятника.
   - Это я там внизу? - спросил мистер Стеффенс, появившись рядом с Гарретом. Он наклонился над колодцем. - Очень, очень странно наблюдать собственную гибель.
   Маятник качнулся в последний раз.
   - До чего реалистично, - сказал мистер Стеффенс, отворачиваясь.
   - Еще вина, мистер Гаррет?
   - Да, пожалуйста.', 380);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1221, '2025-08-24 23:06:22.571376+03', 6, NULL, '- Теперь уже недолго. Скоро прибудут Демонтажники.
   - Слава богу!
   И опять, в третий раз - крик.
   - Ну что еще? - нервно спросил Гаррет.
   - Теперь моя очередь, - сказала мисс Драммонд. - Глядите.
   Вторую мисс Драммонд, сколько она ни кричала, заколотили в гроб и бросили в сырую землю под полом.
   - Постойте, я же помню это! - ахнул инспектор Нравственного Климата. - Это же из старых, запрещенных книг… «Преждевременное погребение». Да и остальное: колодец, маятник, обезьяна, дымоход… «Убийство на улице Морг». Я сам сжег эту книгу, ну конечно же!
   - Еще вина, Гаррет. Так, держите рюмку крепче.
   - Господи,какоеу вас воображение!
   На их глазах погибли еще пятеро:', 381);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1222, '2025-08-24 23:06:22.571376+03', 6, NULL, 'один в пасти дракона, другие были сброшены в черный пруд, пошли ко дну и сгинули.
   - Хотите взглянуть, что мы приготовили для вас? - спросил Стендаль.
   - Разумеется, - ответил Гаррет. - Какая разница? Все равно мы взорвем эту скверну. Вы отвратительны.
   - Тогда пошли. Сюда.
   И он повел Гаррета вниз, в подполье, по многочисленным переходам, опять вниз по винтовой лестнице под землю, в катакомбы.
   - Что вы хотите мне здесь показать? - спросил Гаррет.
   - Вас, убитого.
   - Моего двойника?
   - Да. И еще кое-что.
   - Что же?
   - Амонтильядо, - сказал Стендаль, шагая впереди с поднятым в руке фонарем.
   Кругом, наполовину высунувшись из гробов, торчали недвижные скелеты.', 382);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1223, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Гаррет прикрыл нос ладонью, лицо его выражало отвращение.
   - Что-что?
   - Вы никогда не слыхали про амонтильядо?
   - Нет!
   - И не узнаете вот это? - Стендаль указал на нишу.
   - Откуда мне знать?
   - Это тоже? - Стендаль, улыбаясь, извлек из складок своего балахона мастерок каменщика.
   - Что это такое?
   - Пошли, - сказал Стендаль.
   Они ступили в нишу. Во тьме Стендаль заковал полупьяного инспектора в кандалы.
   - Боже мой, что вы делаете? - вскричал Гаррет, гремя цепями.
   - Я, так сказать, кую железо, пока горячо. Не перебивайте человека, который кует железо, пока оно горячо, это неучтиво. Вот так!
   - Вы заковали меня в цепи!..
   - Совершенно верно.', 383);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1224, '2025-08-24 23:06:22.571376+03', 6, NULL, '- Что вы собираетесь сделать?
   - Оставить вас здесь.
   - Вы шутите.
   - Весьма удачная шутка.
   - Где мой двойник? Разве мы не увидим, как его убьют?
   - Никакого двойника нет.
   - Но как жеостальные?!
   - Остальные мертвы. Вы видели, как убивали живых людей. А двойники, роботы, стояли рядом и смотрели.
   Гаррет молчал.
   - Теперь вы обязаны воскликнуть: «Ради всего святого, Монтрезор!» - сказал Стендаль. - А я отвечу: «Да, ради всего святого». Ну, что же вы? Давайте.Говорите.
   - Болван!
   - Что, я вас упрашивать должен? Говорите. Говорите: «Ради всего святого, Монтрезор!»
   - Не скажу, идиот. Выпустите меня отсюда. - Он уже протрезвел.
   - Вот. Наденьте.', 384);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1225, '2025-08-24 23:06:22.571376+03', 6, NULL, '- Стендаль сунул ему что-то, позванивающее бубенчиками.
   - Что это?
   - Колпак с бубенчиками. Наденьте его, и я, быть может, выпущу вас.
   - Стендаль!
   - Надевайте, говорят вам!
   Гаррет послушался. Бубенчики тренькали.
   - У вас нет такого чувства, что все это уже когда-то происходило? - справился Стендаль, берясь за лопатку, раствор, кирпичи.
   - Что вы делаете?
   - Замуровываю вас. Один ряд выложен. А вот и второй.
   - Вы сошли с ума!
   - Не стану спорить.
   - Вас привлекут к ответственности за это!
   Стендаль, напевая, постучал по кирпичу и положил его на влажный раствор.
   Из тонущей во мраке ниши неслись стук, лязг, крики.
   Стена росла.
   - Лязгайте как следует,', 385);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1226, '2025-08-24 23:06:22.571376+03', 6, NULL, 'прощу вас, - сказал Стендаль. - Чтобы было сыграно на славу!
   - Выпустите, выпустите меня!
   Осталось уложить один, последний кирпич. Вопли не прекращались.
   - Гаррет? - тихо позвал Стендаль.
   Гаррет смолк.
   - Гаррет, - продолжал Стендаль, - знаете почему я так поступил с вами? Потому что вы сожгли книги мистера По, даже не прочитав их как следует. Положились на слова других людей, что надо их сжечь. Иначе вы сразу, как только мы пришли сюда догадались бы, что я задумал. Неведение пагубно, мистер Гаррет.
   Гаррет молчал.
   - Все должно быть в точности, - сказал Стендаль, поднимая фонарь так, чтобы луч света проник в нишу и упал на поникшую фигуру.', 386);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1227, '2025-08-24 23:06:22.571376+03', 6, NULL, '- Позвоните тихонько бубенчиками.
   Бубенчики звякнули.
   - А теперь, если вы изволите сказать «Ради всего святого, Монтрезор!», я, возможно, освобожу вас.
   В луче света появилось лицо инспектора. Минута колебания, и вот прозвучали нелепые слова.
   - Ради всего святого, Монтрезор.
   Стендаль удовлетворенно вздохнул, закрыв глаза.
   Вложил последний кирпич и плотно заделал его.
   - Requiescat in pace, дорогой друг.
   Он быстро покинул катакомбы.
   В полночь, с первым ударом часов, в семи залах дома все смолкло.
   Появилась Красная Смерть.
   Стендаль на миг задержался в дверях, еще раз все оглядел. Выбежал из Дома и поспешил через ров туда, где ждал вертолет.
   - Готово, Пайкс?', 387);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1228, '2025-08-24 23:06:22.571376+03', 6, NULL, '- Готово.
   Улыбаясь, они смотрели на величавое здание. Дом начал раскалываться посередине, точно от землетрясения, и, любуясь изумительной картиной, Стендаль услышал, как позади него Пайкс тихо и напевно декламирует:
   - «…на моих глазах мощные стены распались и рухнули. Раздался протяжный гул, точно от тысячи водопадов, и глубокий черный пруд безмолвно и угрюмо сомкнулся над развалинами Дома Эшеров».
   Вертолет взлетел над бурлящим озером, взяв курс на запад.
   Август 2005

   Старые люди
   И наконец - как и следовало ожидать - на Марс стали прибывать старые люди; они отправились по следу, проложенному громогласными пионерами, утонченными скептиками,', 388);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1229, '2025-08-24 23:06:22.571376+03', 6, NULL, 'профессиональными скитальцами романтическими проповедниками, искавшими свежей поживы.
   Люди немощные и дряхлые, люди, которые только и делали, что слушали собственное сердце, щупали собственный пульс, беспрестанно глотали микстуру перекошенными ртами, люди, которые прежде в ноябре отправлялись в общем вагоне в Калифорнию, а в апреле на третьеклассном пароходе в Италию, эти живые мощи, эти сморчки тоже наконец появились на Марсе…
   Сентябрь 2005

   Марсианин
   Устремленные вверх голубые пики терялись в завесе дождя, дождь поливал длинные каналы, и старик Лафарж вышел с женой из дома посмотреть.
   - Первый дождь сезона, - заметил Лафарж.
   - Чудесно… - вздохнула жена.
   - Благодать!', 389);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1230, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Они затворили дверь. Вернувшись в комнаты, стали греть руки над углями в камине. Они зябко дрожали. Сквозь окно они видели вдали влажный блеск дождя на корпусе ракеты, которая доставила их сюда с Земли.
   - Вот одно только… - произнес Лафарж, глядя на свои руки.
   - Ты о чем? - спросила жена.
   - Если бы мы могли взять с собой Тома…
   - Лаф, ты опять!
   - Нет, нет, прости меня, я не буду.
   - Мы прилетели сюда, чтобы тихо, без тревог прожить свою старость, а не думать о Томе. Сколько лет прошло, как он умер, надо постараться забыть его и все, что было на Земле.
   - Верно, верно, - сказал он и снова потянулся к теплу. Его глаза смотрели на огонь. - Я больше не заговорю об этом.', 390);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1231, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Просто, ну… очень уж недостает мне наших поездок в Грин-Лон-Парк по воскресеньям, когда мы клали цветы на его могилу. Ведь мы больше никуда не выезжали…
   Голубой дождь ласковыми струями поливал дом. В девять часов они легли спать; молча, рука в руке, лежали они, ему - пятьдесят пять, ей - шестьдесят, во мраке, наполненном шумом дождя.
   - Энн, - тихо позвал он.
   - Да? - откликнулась она.
   - Ты ничего не слышала?
   Они вместе прислушались к шуму ветра и дождя.
   - Ничего, - сказала она.
   - Кто-то свистел, - объяснил он.
   - Нет, я не слышала.
   - Пойду посмотрю на всякий случай.
   Он надел халат и прошел через весь дом к наружной двери. Помедлив в нерешительности,', 391);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1232, '2025-08-24 23:06:22.571376+03', 6, NULL, 'толчком отворил ее, и холодные капли дождя ударили по его лицу. Дул ветер.
   У крыльца стояла маленькая фигура.
   Молния распорола небо, и мазок белого света выхватил из мрака лицо. Оно глядело на стоящего в дверях Лафаржа.
   - Кто там? - крикнул старик, дрожа.
   Молчание.
   - Кто это? Что вам надо?
   По-прежнему ни слова.
   Он почувствовал страшную усталость, слабость, изнеможение.
   - Кто ты такой? - крикнул Лафарж снова.
   Жена подошла к нему сзади и взяла его за руку.
   - Чего ты так кричишь?
   - Какой-то мальчик стоит у крыльца и не хочет мне отвечать, - сказал старик, дрожа. - Он похож на Тома!
   - Пойдем спать, тебе почудилось.
   - Он и сейчас стоит, взгляни сама.', 392);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1233, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Лафарж отворил дверь шире, чтобы жене было видно. Холодный ветер, редкий дождь - и фигурка, глядящая на них задумчивыми глазами. Старая женщина прислонилась к притолоке.
   - Уходи! - сказала она, отмахиваясь рукой. - Уходи!
   - Скажешь, не похож на Тома? - спросил старик.
   Фигурка не двигалась.
   - Мне страшно, - произнесла женщина. - Запри дверь и пойдем спать. Не хочу, не хочу!..
   И она ушла в спальню, причитая себе под нос. Старик стоял на ветру, и руки его стыли от студеной влаги.
   - Том, - тихо сказал он - Том, на тот случай, если это ты, если это каким-то чудом ты, - я не стану запирать дверь. Если ты озяб и захочешь войти погреться, входи и ложись подле камина,', 393);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1234, '2025-08-24 23:06:22.571376+03', 6, NULL, 'там есть меховой коврик.
   И он прикрыл дверь, не заперев ее.
   Жена услышала, как он ложится, и зябко поежилась.
   - Ужасная ночь. Я чувствую себя такой старой. - Она всхлипнула.
   - Ладно, ладно, - ласково успокаивал он ее, обнимая. - Спи.
   Наконец она уснула.
   И тут его настороженный слух тотчас уловил: наружная дверь медленно-медленно отворилась, впуская дождь и ветер, потом затворилась. Лафарж услышал легкие шаги возле камина и слабое дыхание. «Том», - сказал он сам себе.
   Молния полыхнула в небе и расколола мрак на части.

   Утром светило жаркое-жаркое солнце.
   Лафарж распахнул дверь в гостиную и обвел ее быстрым взглядом.
   На коврике никого не было.
   Лафарж вздохнул.', 394);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1235, '2025-08-24 23:06:22.571376+03', 6, NULL, '- Стар становлюсь, - сказал он.
   И он пошел к двери, чтобы спуститься к каналу за ведром прозрачной воды для умывания. На пороге он чуть не сбил с ног юного Тома, который шел уже с полным до краев ведром.
   - Доброе утро, отец!
   - Доброе утро, Том.
   Старик посторонился. Подросток пробежал босиком через комнату, поставил ведро и обернулся, улыбаясь.
   - Чудесный день сегодня!
   - Да, хороший, - настороженно отозвался старик.
   Мальчик держался как ни в чем не бывало. Он стал умываться принесенной водой. Старик шагнул вперед.
   - Том, как ты сюда попал? Ты жив?
   - А почему мне не быть живым? - Мальчик поднял глаза на отца.
   - Но, Том… Грин-Лон-Парк,', 395);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1236, '2025-08-24 23:06:22.571376+03', 6, NULL, 'каждое воскресенье… цветы… и… - Лафарж вынужден был сесть. Сын подошел к нему, остановился и взял его руку. Старик ощутил пальцы - крепкие, теплые.
   - Ты в самом деле здесь, это не сон?
   - Разве выне хотите,чтобы я был здесь? - Мальчик встревожился.
   - Что ты, Том, конечно, хотим!
   - Тогда зачем спрашивать? Пришел, и все тут.
   - Но твоя мать, такая неожиданность…
   - Не беспокойся, все будет хорошо. Ночью я пел вам обоим, это поможет вам принять меня, особенно ей. И знаю, как действует неожиданность. Погоди, она войдет, и убедишься сам.
   И он рассмеялся, тряхнув шапкой кудрявых медно-рыжих волос. У него были очень голубые и ясные глаза.
   - Доброе утро, Лаф и Том.', 396);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1237, '2025-08-24 23:06:22.571376+03', 6, NULL, '- Мать вышла из дверей спальни, собирая волосы в пучок. - Правда, чудесный день?
   Том повернулся к отцу, улыбаясь:
   - Что я говорил?
   Вместе, втроем, они замечательно позавтракали в тени за домом. Миссис Лафарж достала припрятанную впрок старую бутылку подсолнухового вина, и все немножко выпили. Никогда еще Лафарж не видел свою жену такой веселой. Если у нее и было какое-то сомнение насчет Тома, то вслух она его не высказывала. Для нее все было в порядке вещей.И чем дальше, тем больше сам Лафарж проникался этим чувством.
   Пока мать мыла посуду, он наклонился к сыну и тихонько спросил:
   - Сколько же тебе лет теперь, сынок?
   - Разве ты не знаешь, папа? Четырнадцать, конечно.', 397);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1238, '2025-08-24 23:06:22.571376+03', 6, NULL, '- А кто ты такойна самом деле?Ты не можешь быть Томом, нокем-тоты должен быть! Кто ты?
   - Не надо. - Парнишка испуганно прикрыл лицо руками.
   - Мне ты можешь сказать, - настаивал старик, - я пойму. Ты марсианин, наверно? Я тут слыхал разные басни про марсиан, правда, толком никто ничего не знает. Вроде бы их совсем мало осталось, а когда они появляются среди нас, то в облике землян. Вот и ты, если приглядеться: будто бы и Том, и не Том…
   - Зачем, зачем это?! Чем я вам не хорош? - закричал мальчик, спрятав лицо в ладонях. - Пожалуйста ну пожалуйста, не надо сомневаться во мне!
   Он вскочил на ноги и ринулся прочь от стола.
   - Том, вернись!', 398);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1239, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Но мальчик продолжал бежать вдоль канала к городу.
   - Куда это он? - спросила Энн; она пришла за остальными тарелками.
   Она посмотрела в лицо мужу.
   - Ты что-нибудь сказал, напугал его?
   - Энн, - заговорил он, беря ее за руку, - Энн, ты помнишь Грин-Лон-Парк, помнишь ярмарку и как Том заболел воспалением легких?
   - Что тытакоеговоришь? - Она рассмеялась.
   - Так, ничего, - тихо ответил он.
   Вдали, у канала, медленно оседала пыль, поднятая ногами бегущего Тома.

   В пять часов вечера, на закате, Том возвратился. Он настороженно поглядел на отца.
   - Ты опять начнешь меня расспрашивать?
   - Никаких вопросов, - сказал Лафарж.
   Блеснула белозубая улыбка.', 399);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1240, '2025-08-24 23:06:22.571376+03', 6, NULL, '- Вот это здорово.
   - Где ты был?
   - Возле города. Чуть не остался там. Меня чуть… - Он замялся, подбирая нужное слово. - Я чуть не попал в западню.
   - Что ты хочешь этим сказать - «в западню»?
   - Там, возле канала есть маленький железный дом, и когда я шел мимо него, то меня чуть было не заставили… после этого я не смог бы вернуться сюда, к вам. Не знаю, как вам объяснить, нет таких слов, я не умею рассказать, я и сам не понимаю, это так странно, мне не хочется об этом говорить.
   - И не надо. Иди-ка лучше умойся. Ужинать пора. Мальчик побежал умываться.
   А минут через десять на безмятежной глади канала показалась лодка, подгоняемая плавными толчками длинного шеста,', 400);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1241, '2025-08-24 23:06:22.571376+03', 6, NULL, 'который держал в руках долговязый худой человек с черными волосами.
   - Добрый вечер, брат Лафарж, - сказал он, придерживая лодку.
   - Добрый вечер, Саул, что слышно?
   - Всякое. Ты ведь знаешь Номленда - того, что живет в жестяном сарайчике на канале?
   Лафарж оцепенел.
   - Знаю, ну и что?
   - А какой он негодяй был, тоже знаешь?
   - Говорили, будто он потому Землю покинул, что человека убил.
   Саул оперся о влажный шест, внимательно глядя на Лафаржа.
   - А помнишь фамилию человека, которого он убил?
   - Гиллингс, кажется?
   - Точно, Гиллингс. Ну так вот, часа этак два тому назад этот Номленд прибежал в город с криком, что видел Гиллингса - живьем, здесь, на Марсе, сегодня,', 401);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1242, '2025-08-24 23:06:22.571376+03', 6, NULL, 'только что! Просился в тюрьму, чтобы его спрятали туда от Гиллингса. Но в тюрьму его не пустили. Тогда Номленд пошел домой и двадцать минут назад - люди мне рассказали - пустил себе пулю в лоб. Я как раз оттуда.
   - Ну и ну, - сказал Лафарж.
   - Вот какие дела-то бывают! - подхватил Саул. - Ладно, Лафарж, пока, спокойной ночи.
   - Спокойной ночи.
   Лодка заскользила дальше по тихой глади канала.
   - Ужин на столе, - крикнула миссис Лафарж.
   Мистер Лафарж сел на свое место и, взяв нож, поглядел через стол на Тома.
   - Том, - сказал он, - ты что делал сегодня вечером?
   - Ничего, - ответил Том с полным ртом. - А что?
   - Да нет, я так просто.', 402);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1243, '2025-08-24 23:06:22.571376+03', 6, NULL, '- Старик засунул уголок салфетки за ворот сорочки.

   В семь часов вечера миссис Лафарж собралась в город.
   - Уж который месяц не была там, - сказала она.
   Том отказался идти.
   - Я боюсь города, - объявил он. - Боюсь людей. Мне не хочется.
   - Большой парень - и такие разговоры! - настаивала Энн. - Слушать не хочу. Пойдешь с нами. Я так решила.
   - Но, Энн, если мальчику не хочется… - вступился старик.
   Однако миссис Лафарж была неумолима. Она чуть не силой втащила их в лодку, и все вместе отправились в путь по каналу под вечерними звездами. Том лежал на спине, закрыв глаза, и никто не сказал бы, спит он или нет. Старик пристально глядел на него, размышляя. «Кто же это,', 403);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1244, '2025-08-24 23:06:22.571376+03', 6, NULL, '- думал он, - что за создание, жаждущее любви не меньше нас? Кто он и что он - пришел, спасаясь от одиночества, в круг чуждых ему существ, приняв голос и облик людей, которые жили только в нашей памяти, чтобы остаться среди нас и обрести наконец свое счастье в нашем признании? С какой он горы, из какой пещеры, отпрыск какого народа, еще населявшего этот мир, когда прилетели ракеты с Земли?» Лафарж покачал головой. Этого не узнать. А так, с какой стороны ни посмотри - он Том, и все тут.
   Старик перевел взгляд на приближающийся город и почувствовал неприязнь к нему. Но затем он опять стал думать о Томе и Энн и сказал себе: «Может быть, и неправильно это - оставить у себя Тома,', 404);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1245, '2025-08-24 23:06:22.571376+03', 6, NULL, 'хоть ненадолго, если все равно не выйдет ничего, кроме беды и горя… Но как отказаться от того, о чем мы так мечтали, пусть это всего на один день, и он потом исчезнет, и пустота станет еще невыносимей, темные ночи - еще темней, дождливые ночи - еще сырей… Лишать нас этого - все равно что попытаться вырвать у нас кусок изо рта…»
   И он поглядел на парнишку, который так безмятежно дремал на дне лодки. Тот всхлипнул; верно, что-то приснилось.
   - Люди, - бормотал Том во сне. - Меняюсь и меняюсь… Капкан…
   - Полно, полно, парень. - Лафарж погладил его мягкие кудри, и Том успокоился.

   Лафарж помог жене и сыну выйти из лодки на берег.
   - Ну, вот и приехали! - Энн улыбнулась ярким огням,', 405);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1246, '2025-08-24 23:06:22.571376+03', 6, NULL, 'слушая музыку из таверн, звуки пианино и патефонов, любуясь парочками, которые гуляли под руку по оживленным улицам.
   - Лучше бы я остался дома, - сказал Том.
   - Прежде ты так не говорил, - возразила мать. - Тебе всегда нравилось в субботу вечером поехать в город.
   - Держитесь ко мне поближе, - прошептал Том. - Я не хочу, чтоб меня поймали.
   Энн услышала эти слова.
   - Что ты там болтаешь, пошли!
   Лафарж заметил, что пальцы мальчика льнут к его ладони, и крепко стиснул их.
   - Я с тобой, Томми. - Он поглядел на снующую мимо толпу, и ему тоже стало не по себе. - Мы не будем задерживаться долго.
   - Вздор, - вмешалась Энн. - Мы на весь вечер приехали.
   Переходя улицу,', 406);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1247, '2025-08-24 23:06:22.571376+03', 6, NULL, 'они наткнулись на тройку пьяных. Их затолкали, закрутили, оторвали друг от друга; оглядевшись, Лафарж окаменел.
   Тома не было.
   - Где он? - сердито спросила Энн. - Что за манера - чуть что, куда-то удирать от родителей! Том!!
   Мистер Лафарж бегал кругом, расталкивая прохожих, но Тома нигде не было.
   - Вернется, вот увидишь, будет ждать возле лодки, когда мы поедем домой, - уверенно произнесла Энн, увлекая мужа по направлению к кинотеатру.
   Вдруг в толпе произошло какое-то замешательство, и мимо Лафаржа пробежали двое - мужчина и женщина. Он узнал их: Джо Сполдинг с женой. Они исчезли прежде, чем Лафарж успел заговорить с ними.
   Встревоженно озираясь,', 407);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1248, '2025-08-24 23:06:22.571376+03', 6, NULL, 'он купил билеты и безропотно потащился за женой в постылую темноту кинозала.

   В одиннадцать часов Тома у причала не было.
   - Ничего, мать, - сказал Лафарж, - ты только не волнуйся. Я найду его. Подожди здесь.
   - Поскорее возвращайтесь.
   Ее голос утонул в плеске воды.
   Он шел по ночным улицам, сунув руки в карманы. Один за другим гасли огни. Кое- где из окон еще высовывались люди - ночь была теплая, хотя в небе все еще плыли среди звезд обрывки грозовых туч. Лафарж вспомнил, как мальчик постоянно твердил что-то насчет западни, как он боялся толпы, городов. «Что за нелепость, - устало подумал старик. - Наверно, парень ушел навсегда. А может,', 408);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1249, '2025-08-24 23:06:22.571376+03', 6, NULL, 'его и вовсе не было…» Лафарж свернул в переулок, скользя взглядом по номерам домов.
   - Это ты, Лафарж?
   На крыльце, куря трубку, сидел мужчина.
   - Привет, Майк.
   - Что, повздорил с хозяйкой? Вышел проветриться, нервы успокоить?
   - Да нет, просто гуляю.
   - У тебя такой вид, словно ты что-то ищешь. Да, к слову о находках. Ведь сегодня вечером кое-кто нашелся. Джо Спеллинга знаешь? Помнишь его дочь, Лавинию?
   - Помню, - Лафарж похолодел. Это было как сон, который снится во второй раз. Он в точности знал, что будет сказано дальше.
   - Лавиния вернулась домой сегодня вечером, - сказал Майк, выпуская дым. - Помнишь, она с месяц назад заблудилась на дне мертвого моря?', 409);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1250, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Потом нашли тело, вроде бы ее, да очень уж изуродовано было… С тех пор Спеллинги были словно не в себе. Джо ходил и все твердил, что она жива, не ее это тело. И вот выходит, он был прав. Сегодня Лавиния объявилась.
   - Где? - Лафаржу стало трудно дышать, сердце отчаянно заколотилось.
   - На Главной улице. Спеллинги как раз покупали билеты в кино. Вдруг видят в толпе Лавинию. Вот сцена была, воображаю! Сперва-то она их не узнала. Они квартала три шли за ней, все говорили, говорили. Наконец она вспомнила.
   - И ты ее видел?
   - Нет, но я слышал ее голос. Помнишь, она любила петь «Чудный брег Ломондского озера»? Ну так вот, я только что слышал, как она эту песню отцу пела, вон их дом.', 410);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1251, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Так она пела - заслушаешься! Славная девочка. Я как узнал, что она погибла, - вот ведь беда, подумал, вот несчастье. А теперь вернулась, и так на душе хорошо. Э, да тебе вроде нездоровится. Зайди-ка, глотни виски!
   - Спасибо, Майк, не хочу. - Старик побрел прочь.
   Он слышал, как Майк пожелал ему доброй ночи, но не ответил, а устремил взгляд на двухэтажный дом, высокую хрустальную крышу которого устилали пышные кисти алых марсианских цветов. Над садом навис балкон с витой железной решеткой, в окнах второго этажа горел свет. Было очень поздно, но он все-таки подумал:
   «Что будет с Энн, если я не приведу Тома? Новый удар - снова смерть, - как она это перенесет?', 411);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1252, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Вспомнит первую смерть?… И весь этот сон наяву? И это внезапное исчезновение? Господи, я должен найти Тома, ради Энн! Бедняжка Энн, она ждет его на пристани…»
   Он поднял голову. Где-то наверху голоса желали доброй ночи другим ласковым голосам, хлопали двери, гас свет, и все время слышалась негромкая песня. Мгновение спустяна балкон вышла прехорошенькая девушка лет восемнадцати.
   Лафарж окликнул ее, преодолевая голосом сильный ветер.
   Девушка обернулась, глянула вниз.
   - Кто там? - крикнула она.
   - Это я, - сказал старик и, сообразив, как странно, нелепо ответил ей, осекся, только губы продолжали беззвучно шевелиться.
   Крикнуть: «Том, сынок, это твой отец»? Как заговорить с ней?', 412);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1253, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Она ведь примет его за сумасшедшего и позовет родителей.
   Девушка перегнулась через перила в холодном, неверном свете.
   - Я вас знаю, - мягко ответила она. - Пожалуйста, уходите, вы тут ничего не можете поделать.
   - Ты должен вернуться! - Слова сами вырвались у Лафаржа, прежде чем он смог их удержать.
   Освещенная луной фигурка наверху отступила в тень и пропала, только голос остался.
   - Теперь я больше не твой сын, - сказал голос. - Зачем только мы поехали в город…
   - Энн ждет на пристани!
   - Простите меня, - ответил тихий голос. - Но что я могу поделать? Я счастлива здесь, меня любят - как любили вы. Я то, что я есть, беру то, что дается. Поздно: они взяли меня в плен.', 413);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1254, '2025-08-24 23:06:22.571376+03', 6, NULL, '- Но подумай об Энн, какой это будет удар для нее…
   - Мысли в этом доме чересчур сильны, я словно в заточении. Я не могу перемениться сама.
   - Но ведь ты же Том, это ты была Томом, верно? Или ты издеваешься над стариком - может быть, на самом деле ты Лавиния Сполдинг?
   - Я ни то, ни другое, я только я. Но везде, куда я попадаю, я еще и нечто другое, и сейчас вы не в силах изменить этого нечто.
   - Тебе опасно оставаться в городе. У нас на канале лучше, там никто тебя не обидит, - умолял старик.
   - Верно… - Голос звучал нерешительно. - Но теперь я обязана считаться с этими людьми. Что будет с ними, если утром окажется, что я снова исчезла - уже навсегда? Правда, мама-то знает,', 414);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1255, '2025-08-24 23:06:22.571376+03', 6, NULL, 'кто я, - догадалась, как и вы. Мне кажется, они все догадались, только не хотят спрашивать. Провидению не задают вопросов. Если действительность недоступна, чем плоха тогда мечта? Пусть я не та, которую они потеряли, для них я даже нечто лучшее - идеал, созданный их мечтой. Передо мной теперь стоит выбор: либо причинитьболь им, либо вашей жене.
   - У них большая семья, их пятеро. Им легче перенести утрату!
   - Прошу вас, - голос дрогнул, - я устала.
   Голос старика стал тверже
   - Ты должен пойти со мной. Я не могу снова подвергать Энн такому испытанию. Ты наш сын. Ты мой сын, ты принадлежишь нам.
   - Не надо, пожалуйста! - Тень на балконе трепетала.', 415);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1256, '2025-08-24 23:06:22.571376+03', 6, NULL, '- Тебя ничто не связывает с этим домом и его обитателями!
   - О, что вы делаете со мной!
   - Том, Том, сынок, послушай меня. Вернись к нам скорей, ну, спустись по этим лианам. Пошли, Энн ждет, у тебя будет настоящий дом, все, чего ты захочешь.
   Лафарж не отрывал пристального взгляда от балкона, желая, желая, чтобы свершилось…
   Тени колыхались, шелестели лианы.
   Наконец тихий голос произнес:
   - Хорошо, отец.
   - Том!
   В свете луны вниз по лианам скользнула юркая мальчишеская фигурка. Лафарж поднял руки - принять ее. В окнах вверху вспыхнуло электричество. Чей-то голос вырвался из-за узорной решетки.
   - Кто там?
   - Живей, парень!
   Еще свет, еще голоса.
   - Стой,', 416);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1257, '2025-08-24 23:06:22.571376+03', 6, NULL, 'я буду стрелять! Винни, ты цела?
   Топот спешащих ног…
   Старик и мальчик пустились бежать через сад. Раздался выстрел. Пуля ударила в стену возле самой калитки.
   - Том, ты - в ту сторону! Я побегу сюда, запутаю их. Беги к каналу, через десять минут встретимся там! Давай!
   Они побежали в разные стороны.
   Луна скрылась за тучей. Старик бежал в полной темноте.
   - Энн, я здесь!
   Она, дрожа, помогла ему спуститься в лодку.
   - Где Том?
   - Сейчас прибежит.
   Они смотрели на тесные улочки и спящий город. Еще появлялись запоздалые прохожие: полицейский, ночной сторож, пилот ракеты, одинокие мужчины, идущие домой после ночного свидания, четверо мужчин и женщин, которые, смеясь,', 417);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1258, '2025-08-24 23:06:22.571376+03', 6, NULL, 'вышли из бара… Где-то приглушенно звучала музыка.
   - Почему его нет? - спросила мать.
   - Сейчас, сейчас.
   Но Лафарж уже не был уверен. Что, если парнишку опять перехватили - где-то, каким-то образом - пока он спешил к пристани, бежал полуночными улицами между темных домов?Конечно, бежать было далеко, даже для мальчика, но все-таки Том должен был поспеть раньше его…
   Вдруг вдали, на залитой лунным светом улице, показалась бегущая фигурка.
   Лафарж вскрикнул, но тотчас заставил себя замолчать: оттуда же, издали, доносились другие голоса, топот других ног. В окнах, словно по цепочке, вспыхнули огни. Одинокая фигурка вырвалась на широкую площадь перед причалом. Это был не Том,', 418);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1259, '2025-08-24 23:06:22.571376+03', 6, NULL, 'а просто бегущее существо с серебристым лицом, которое блестело, переливалось, освещенное многочисленными шарами фонарей. Но чем ближе подбегало оно, тем все более знакомым становилось, и когда фигурка достигла причала, это был уже Том! Энн всплеснула руками, Лафарж поспешно отчалил. Но было уже поздно.
   Потому что из улицы на безмолвную площадь выбежал мужчина… еще один… женщина, еще двое мужчин, мистер Спеллинг. Они остановились в замешательстве. Они озирались по сторонам, и им хотелось вернуться домой: ведь это… это был явный кошмар, безумие какое-то, ну конечно! И, однако же, они продолжали погоню, поминутно останавливаясь в нерешительности и вновь припускаясь бежать.
   Да,', 419);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1260, '2025-08-24 23:06:22.571376+03', 6, NULL, 'было уже поздно. Пришел конец этому необычайному вечеру, необычайному событию. Лафарж крутил в руках чалку. Ему было очень холодно и одиноко. В лунном свете быловидно, как бежали, спешили люди, выпучив глаза, торопливо вскидывая ноги, и вот уже все они, вся десятка, стоят у причала. Они яростно уставились на лодку. Они кричали.
   - Ни с места, Лафарж! - Спеллинг держал в руке пистолет.
   Теперь было ясно, что произошло… Том один, обгоняя прохожих, мчится по освещенным луной улицам. Полицейский замечает промелькнувшую фигуру. Круто обернувшись, всматривается в лицо, кричит какое-то имя, бросается вдогонку. «Эй, стой!» Он увидел известного преступника. И так всю дорогу,', 420);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1261, '2025-08-24 23:06:22.571376+03', 6, NULL, 'кто бы ни встретился. Мужчина ли, женщина, ночной сторож или пилот ракеты - для каждого бегущая фигура была кем угодно. В ней воплощались для них любой знакомый, любой образ, любое имя… Сколько разных имен было произнесено за последние пять минут!.. Сколько лиц угадано в лице Тома - и все ложно!
   Вдоль всего пути - преследуемый и преследователи, мечта и мечтатели, дичь и - псы. Вдоль всего пути: нежданное открытие, блеск знакомых глаз, выкрик полузабытого имени, воспоминания о давних временах - и растет, растет толпа, бегущая по его следам. Каждый срывался с места и спешил вдогонку, едва проносилось мимо - словно лик, отраженный десятком тысяч зеркал, десятком тысяч глаз,', 421);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1262, '2025-08-24 23:06:22.571376+03', 6, NULL, '- бегущее видение, лицо, одно для тех, кто впереди, иное для тех, кто позади, и другое, новое, для тех, кто еще попадется ему на пути, кто еще не видел. [Картинка: pic_8.png] 
   И вот они все здесь, у лодки, и каждый хочет один завладеть мечтой, - как мы хотим, чтобы это был только Том, ни Лавиния, ни Роджер, ни кто-либо еще, подумал Лафарж. Но теперь этому не бывать. Слишком далеко все зашло.
   - Выходите из лодки, ну! - скомандовал Сполдинг.
   Том поднялся на пристань. Сполдинг схватил его за руку.
   - Ты пойдешь к нам домой. Я все знаю.
   - Стой, - вмешался полицейский, - он арестован!
   Его фамилия Декстер, разыскивается за убийство.
   - Нет, нет! - всхлипнула женщина.', 422);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1263, '2025-08-24 23:06:22.571376+03', 6, NULL, '- Это мой муж! Что уж, я своего мужа не знаю?!
   Другие голоса твердили свое. Толпа напирала. Миссис Лафарж заслонила собой Тома.
   - Это мой сын, у вас нет никакого права обвинять его в чем-либо! Нам надо ехать домой!
   А Тома безостановочно била дрожь. Он выглядел тяжелобольным. Толпа все напирала, протягивая нетерпеливые руки, ловя его, хватая.
   Том закричал.
   Он менялся на глазах у всех. Это был Том, и Джеймс, и человек по фамилии Свичмен, и другой, по фамилии Баттерфилд; это был мэр города, и девушка по имени Юдифь, и муж Уильям, и жена Кларисса. Он был словно мягкий воск, послушный их воображению. Они орали, наступали, взывали к нему. Он тоже кричал, простирая к ним руки,', 423);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1264, '2025-08-24 23:06:22.571376+03', 6, NULL, 'и каждый призыв заставлял его лицо преображаться.
   - Том! - звал Лафарж.
   - Алиса! - звучал новый зов.
   - Уильям!
   Они хватали его за руки, тянули к себе, пока он не упал, испустив последний крик ужаса.
   Он лежал на камнях - застывал расплавленный воск, и его лицо было как все лица, один глаз голубой, другой золотистый, волосы каштановые, рыжие, русые, черные, одна бровь косматая, другая тонкая, одна рука большая, другая маленькая.
   Они стояли над ним, прижав палец к губам. Они наклонились.
   - Он умер, - сказал кто-то наконец.
   Пошел дождь.
   Капли падали на людей, и люди посмотрели на небо.
   Они отвернулись и сперва медленно, потом все быстрее пошли прочь,', 424);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1265, '2025-08-24 23:06:22.571376+03', 6, NULL, 'а потом бросились бежать в разные стороны. Только мистер и миссис Лафарж, объятые ужасом, стояли на месте, держась за руки, и глядели на него.
   Дождь поливал обращенное вверх лицо, в котором не осталось ни одной знакомой черты. Энн молча начала плакать.
   - Поехали домой, Энн, тут уж ничего не поделаешь, - сказал старик.
   Они спустились в лодку и заскользили в мраке по каналу. Они вошли в свой дом, и развели огонь в камине, и согрели над ним руки. Они пошли спать и лежали вместе, продрогшие, изможденные, слушая, как снова стучит по крыше дождь.
   - Тсс, - вдруг произнес Лафарж среди ночи. - Ты ничего не слышала?
   - Нет, ничего…
   - Я все-таки погляжу.', 425);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1266, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Он пересек на ощупь темную комнату и долго стоял возле наружной двери, прежде чем отворить.
   Наконец распахнул ее настежь и выглянул наружу.
   Дождь с черного неба поливал пустой двор, поливал канал, поливал склоны синих гор.
   Он подождал минут пять, потом мокрыми руками медленно затворил дверь и задвинул засов.
   Ноябрь 2005

   «Дорожные товары»
   Уж очень далекой она показалась, эта новость, которую владелец магазина дорожных товаров услышал вечером по радио, когда модулированный световой луч принес последние известия с Земли. Просто непостижимо.
   На Земле назревала война.
   Он вышел и посмотрел на небо.
   Вот она. Земля, на вечернем небосводе,', 426);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1267, '2025-08-24 23:06:22.571376+03', 6, NULL, 'догоняет закатившееся за горы солнце. Эта зеленая звезда и есть то, о чем говорило радио.
   - Не могу поверить, - сказал лавочник.
   - Это потому, что вы не там, - заметил отец Перегрин, он подошел поздороваться.
   - Как это понять, святой отец?
   - Вот так же было, когда я был мальчишкой, - сказал отец Перегрин. - Мы слышали о войнах в Китае. Но нам не верилось. Это было слишком далеко. И слишком много людей там погибало. Невозможно себе представить. Даже когда мы смотрели фильмы оттуда, нам не верилось. Так и теперь. Земля - тот же Китай. Слишком далеко, вот и не верится. Это нездесь, не у нас. Не то что пощупать, даже разглядеть нельзя. Зеленый огонек - вот все, что мы видим.', 427);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1268, '2025-08-24 23:06:22.571376+03', 6, NULL, 'И на этом зеленом огоньке живет два миллиарда людей? Невероятно! Война? Но мы не слышим взрывов.
   - Услышим, - сказал лавочник. - Я вот все думаю о тех людях, которые должны прилететь сюда на этой неделе. Как там передавали про них? В течение ближайшего месяца на Марс прибудет около ста тысяч человек - так, кажется. Что с ними будет, если начнется война?
   - Повернут назад, наверно.
   - Н-да, - сказал лавочник. - Ладно, пойду-ка я сотру пыль с чемоданов. Того и гляди покупатели нагрянут.
   - Думаете, если этотаБольшая война, которой мы ждали много лет, все захотят вернуться на Землю?
   - Вот именно, святой отец: как это ни странно, я думаю, мы все захотим вернуться. Конечно,', 428);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1269, '2025-08-24 23:06:22.571376+03', 6, NULL, 'мы прилетели сюда, спасаясь от политики, от атомной бомбы, войны, влиятельныхклик, предрассудков, законов. Все это мне известно. Но родина-то все-таки там. Вот увидите. Как только на Америку упадет первая бомба, здешний народ призадумается. Слишком мало они тут прожили - каких-нибудь два года. Если бы лет сорок, тогда другое дело, а сейчас ведь у них на Земле родня, города, в которых они выросли. Я-то, можно сказать, в Землю даже не верю, для меня она как бы и не существует. Но я старик, от меня все равно никакого проку. Я могу и тут остаться.
   - Вряд ли.
   - Пожалуй, что вы правы.
   Они стояли на террасе, глядя на звезды.', 429);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1270, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Потом отец Перегрин достал из кармана деньги и подал их хозяину магазина.
   - Кстати, подберите-ка мне чемодан. А то мой старый очень уж истрепался…
   Ноябрь 2005

   Мертвый сезон
   Сэм Паркхилл лихо махал метлой, выметая голубой марсианский песок.
   - Вот и все! - сказал он. - Прошу, сэр, полюбуйтесь! - Он показал рукой. - Взгляните на вывеску - «ГОРЯЧИЕ СОСИСКИ СЭМА»! Красота - правда, Эльма?
   - Правда, Сэм, - подтвердила его супруга.
   - Во, куда я махнул! Увидели бы меня теперь ребята из Четвертой экспедиции. Слава богу, свое дело завел, а они все еще солдатскую лямку тянут. Мы будем тысячи загребать, Эльма, тысячи!
   Жена смотрела на него и молчала.', 430);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1271, '2025-08-24 23:06:22.571376+03', 6, NULL, '- Куда девался капитан Уайлдер? - спросила она наконец. - Твой начальник, который убил этого типа, ну, что задумал всех землян перебить - как его фамилия?…
   - Этого психа-то? Спендер. Чистоплюй проклятый. Да, насчет капитана Уайлдера… На Юпитер полетел, говорят. С повышением, так сказать. Сдается мне, Марс и ему тоже в голову ударил. Раздражительный больно стал, не дай бог. Лет через двадцать вернется с Юпитера и Плутона, если повезет. Будет знать, как трепать языком. Вот так-то - он там от мороза сдыхает, а я тут, смотри, что наворочал! Местечко-то какое!
   Два заброшенных шоссе встречались здесь и вновь расходились, исчезая во мраке.', 431);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1272, '2025-08-24 23:06:22.571376+03', 6, NULL, 'У самого перекрестка Сэм Паркхилл воздвиг из вздувшегося заклепками алюминия сооружение, залитое ослепительным белым светом и дрожащее от рева автомата-радиолы.
   Он нагнулся, чтобы поправить окаймляющий дорожку бордюр из битого стекла. Стекло он выломал в старинных марсианских зданиях в горах.
   - Лучшие горячие сосиски на двух планетах! Первый торговец сосисками на Марсе! Лук, перец, горчица - все лучшего качества! Что-что, а растяпой меня не назовешь! Вот вам две магистрали, вон мертвый город, а вон там рудники. Грузовики из 101 Сеттльмента будут идти мимо нас двадцать четыре часа в сутки. Скажешь, плохое я место выбрал?
   Жена разглядывала свои ногти.
   - Ты думаешь,', 432);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1273, '2025-08-24 23:06:22.571376+03', 6, NULL, 'эти десять тысяч новых ракет с рабочими прилетят на Марс? - сказала она наконец.
   - Не пройдет и месяца, - уверенно ответил он. - Чего ты кривишься?
   - Не очень-то я полагаюсь на эту публику, там, на Земле, - ответила она. - Вот когда сама увижу десять тысяч ракет и сто тысяч мексиканцев и китайцев, тогда и поверю.
   - Покупателей, - он посмаковал это слово. - Сто тысяч голодных клиентов!
   - Только бы не было атомной войны, - медленно произнесла жена, глядя на небо. - Эти атомные бомбы мне покою не дают. Их уже столько накопилось на Земле, всякое может случиться.
   Сэм только фыркнул в ответ и продолжал подметать. Уголком глаза он уловил голубое мерцание.', 433);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1274, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Что-то бесшумно парило в воздухе за его спиной. Он услышал голос жены:
   - Сэм, тут к тебе приятель явился.
   Сэм повернулся и увидел качающуюся на ветру маску.
   - Опять пришел! - Сэм взял метлу наперевес.
   Маска кивнула. Она была сделана из голубоватого стекла и венчала тонкую шею, ниже которой развевалось одеяние из тончайшего желтого шелка. Из шелка торчали две серебряные руки, прозрачные, как сетка. На месте рта у маски была узкая прорезь, из нее вырывались мелодичные звуки, а руки, маска, одежда то всплывали вверх, то опускались.
   - Мистер Паркхилл, я опять пришел поговорить с вами, - произнес голос из-под маски.
   - Тебе же сказано, чтобы духу твоего здесь не было!', 434);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1275, '2025-08-24 23:06:22.571376+03', 6, NULL, '- гаркнул Сэм. - Убирайся, не то Болезнь напущу!
   - У меня уже была Болезнь, - ответил голос. - Я один из немногих, кто выжил. Я очень долго болел.
   - Убирайся в свои горы и сиди там, где тебе положено. Чего ты сюда ходишь, пристаешь ко мне. Ни с того ни с сего. Да еще по два раза на день.
   - Мы не причиним вам зла.
   - Зато я вам причиню! - сказал Сэм, пятясь. - Я иностранцев не люблю. И марсиан не люблю. До сих пор ни одного не видел. Вообще чертовщина какая-то! Столько лет сидели где-то, прятались, и вдруг, на тебе, я им понадобился. Оставьте меня в покое.
   - У нас к вам важное дело, - сказала голубая маска.
   - Если это насчет участка, то он мой.', 435);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1276, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Я построил сосисочную собственными руками.
   - В известном смыследа,по поводу участка.
   - Ну вот что, послушай-ка меня, - ответил Сэм. - Я сам из Нью-Йорка. Это огромный город; там еще десять миллионов таких, как я. А вас, марсиан, всего дюжина-другая осталась. Городов у вас нет, бродите по горам, ни властей, ни законов, и ты еще начинаешь мне про участок толковать. Заруби себе на носу: старое должно уступать место новому. Лучше разойдемся полюбовно. При мне пистолет, вот он. Нынче утром, как ты ушел, я сразу его достал и зарядил.
   - Мы, марсиане - телепаты, - сказала бесстрастная голубая маска. - У нас есть связь с одним из ваших городов по ту сторону мертвого моря.', 436);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1277, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Вы сегодня слушали радио?
   - Мой приемник скис.
   - Значит, вам ничего неизвестно. Очень важные новости. Это касается Земли.
   Серебряная рука сделала движение, и в ней появилась бронзовая трубка.
   - Позвольте показать вам вот это.
   - Пистолет! - вскричал Сэм Паркхилл.
   Выхватив из кобуры свой пистолет, он открыл огонь по туманному силуэту, по одеждам, по голубой маске.
   Маска на миг застыла в воздухе. Потом шелк зашуршал и мягко, складка за складкой, опал, будто крохотный цирковой шатер, у которого выбили стойки, серебряные руки тренькнули о мощеную дорожку, и маска накрыла безгласную маленькую кучку белых костей и ткани.
   У Сэма перехватило дыхание.
   Его жена, пошатываясь,', 437);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1278, '2025-08-24 23:06:22.571376+03', 6, NULL, 'стояла над останками марсианина.
   - Это не оружие, - сказала она, нагибаясь и поднимая бронзовую трубку. - Это, видно, письмо. Он его хотел показать тебе. Оно написано какой-то змеиной азбукой, видишь - все одни голубые змеи. Не умею читать эти знаки. А ты?
   - Нет. Что в них проку-то было, в этих марсианских пиктограммах? Брось ее! - Он воровато оглянулся по сторонам. - Ну, как другие еще нагрянут! Надо убрать его с глаз долой Неси-ка лопату!
   - Что ты собираешься делать?
   - Закопать его, что же еще?
   - Не надо было убивать его.
   - Ну, ошибся, подумаешь. Пошевеливайся!
   Она молча принесла ему лопату.', 438);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1279, '2025-08-24 23:06:22.571376+03', 6, NULL, 'К восьми часам Сэм Паркхилл вернулся и принялся виновато мести площадку перед сосисочной. Жена стояла в залитых светом дверях, сложив руки на груди.
   - Жаль, конечно, что так получилось, - сказал он. Поглядел на жену, отвел глаза в сторону. - Сама видела, это случайно вышло, стечение обстоятельств.
   - Да, - сказала жена.
   - Меня такое зло взяло, когда он достал оружие.
   - Какое оружие?
   - Ну, мне показалось, что оружие! Я сожалею, сожалею! Сколько раз еще надо повторять!
   - Tcc, - произнесла Эльма, поднося палец к губам. - Тсс.
   - А мне наплевать, - сказал он. - Я не один - вся компания «Сеттльменты землян, инкорпорейтед» вступится, если что! - Он презрительно фыркнул.', 439);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1280, '2025-08-24 23:06:22.571376+03', 6, NULL, '- Да эти марсиане и не посмеют…
   - Смотри, - перебила его Эльма.
   Сэм поглядел в сторону сухого моря. Он выронил из рук метлу, потом поднял ее; рот его был разинут, и крохотная капелька слюны сорвалась с губы и улетела по ветру. Его вдруг кинуло в дрожь.
   - Эльма, Эльма, Эльма! - вырвалось у него.
   - Вот они и пришли, - сказала Эльма.
   По дну древнего моря, словно голубые призраки, голубые дымки, скользили десять- двенадцать высоких марсианских песчаных кораблей под голубыми парусами.
   - Песчаные корабли! Но ведь их уже нет, Эльма, их не осталось.
   - И все-таки это, похоже, их корабли, - сказала она.
   - Как же так? Власти же их конфисковали! И все разломали,', 440);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1281, '2025-08-24 23:06:22.571376+03', 6, NULL, 'только несколько штук продали с аукциона! Во всей нашей округе я один купил эту посудину и знаю, как ее водить!
   - Не осталось… - повторила она, кивая в сторону моря.
   - Живо, нам надо убраться отсюда!
   - Почему? - протяжно спросила она, завороженно глядя на марсианские корабли.
   - Они убьют меня! В машину, скорей!
   Эльма не двигалась с места.
   Ему пришлось силой увести ее за сосисочную. Здесь стояли две машины: грузовик, на котором он постоянно разъезжал до недавнего времени, и старый марсианский песчаный корабль, который он потехи ради выторговал на аукционе. Последние три недели он возил на нем всякие грузы из-за моря, по гладкому дну. Только взглянув на грузовик,', 441);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1282, '2025-08-24 23:06:22.571376+03', 6, NULL, 'он вспомнил. Мотор лежал на земле - он уже два дня возился с его ремонтом.
   - Грузовик вроде не на ходу, - заметила Эльма.
   - Песчаный корабль! Садись скорей!
   - Чтобы ты вез меня на этом корабле? О, нет.
   - Садись! Я умею!
   Он втолкнул ее, вскочил следом и дернул руль, подставляя кобальтовый парус вечернему бризу.
   Под яркими звездами голубые марсианские корабли стремительно скользили по шуршащим пескам. Корабль Сэма не двигался с места, пока он не вспомнил про якорь и не рванул его.
   - Есть!
   И сильный ветер помчал песчаный корабль по дну мертвого моря, над поглощенными песком глыбами хрусталя, мимо поваленных колонн, мимо заброшенных пристаней из мрамора и меди,', 442);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1283, '2025-08-24 23:06:22.571376+03', 6, NULL, 'мимо белых шахматных фигурок мертвых городов, мимо пурпурных предгорий и дальше, дальше… Очертания марсианских кораблей становились все меньше, пока они не помчались за Сэмом.
   - Лихо я им нос утер! - крикнул Сэм. - А сейчас я заявлю в «Ракетную компанию», и мне дадут охрану. Скажи, что у меня не варит котелок!
   - Они могли задержать тебя, если бы захотели, - устало ответила Эльма. - Просто им это не очень нужно.
   Он засмеялся.
   - Брось! С чего это им отпускать меня? Не догнали, вот и все!
   - Не догнали? - Эльма кивком головы указала за его спину.
   Сэм не обернулся. Его обдало холодом. Он боялся оглянуться. Он ощутил нечто там, на сиденье, за своей спиной, нечто эфемерное,', 443);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1284, '2025-08-24 23:06:22.571376+03', 6, NULL, 'как дыхание человека студеным утром, и голубое, словно плывущий в сумерках дым над горячими чурками гикори, нечто подобное старинным белым кружевам и летучему снегу, напоминающее иней на хрупком камыше.
   Послышался звук, будто разбилось тонкое стекло: смех. И снова молчание. Он обернулся.
   На корме, близ руля, спокойно сидела молодая женщина. Кисти рук тонкие, как сосульки, глаза яркие и большие, как луны, светлые, спокойные. Ветер овевал ее, и она колыхалась, совсем как отражение на воде, к складки шелка, как струи голубого дождя, порхали вокруг ее хрупкого тела.
   - Поверните назад, - сказала она.
   - Нет. - Сэма трясло мелкой трусливой дрожью, он дрожал, словно шершень,', 444);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1285, '2025-08-24 23:06:22.571376+03', 6, NULL, 'висящий в воздухе, он колебался на грани между страхом и злобой. - Прочь с моего корабля!
   - Это не ваш корабль, - ответило видение. - Он такой же древний, как наш мир. Он ходил по пескам еще десять тысяч лет назад, когда моря улетучились и пристани опустели, а вы, пришельцы, похитили его, забрали себе. Но поверните же и возвратитесь к перекрестку. Нам нужно поговорить с вами. Произошло нечто очень важное.
   - Прочь с моего корабля! - сказал Сэм. Кожаная кобура скрипнула, когда он вытащил пистолет. Он тщательно прицелился. - Прыгай, считаю до трех…
   - Не надо! - вскричала девушка. - Я вам ничего дурного не сделаю. И другие тоже. Мы пришли с миром!
   - Раз, - молвил Сэм.
   - Сэм,', 445);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1286, '2025-08-24 23:06:22.571376+03', 6, NULL, '- сказала Эльма.
   - Выслушайте меня, - просила девушка.
   - Два, - жестко произнес Сэм, взводя курок.
   - Сэм! - крикнула Эльма.
   - Три, - сказал Сэм.
   - Мы только… - начала девушка.
   Пистолет выстрелил.
   В лучах солнца тает снег, кристаллики превращаются в пар, в ничто. В пламени очага пляшут и пропадают химеры. В кратере вулкана распадается, исчезает все хрупкое и непрочное. От выстрела, от огня, от удара девушка спалась, как легкий газовый шарф, растаяла, будто ледяная статуэтка. А все, что от нее осталось - льдинки, снежинки, дым, - унесло ветром. Кормовое сиденье опустело.
   Сэм убрал пистолет в кобуру, избегая глядеть на жену.', 446);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1287, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Целую минуту слышен был лишь шелестящий бег корабля по песчаному морю, залитому лунным сиянием.
   - Сэм, - сказала она наконец, - останови корабль.
   Он обратил к ней бледное лицо.
   - Нет, не бывать этому. После стольких лет ты меня не бросишь.
   Она посмотрела на его руку, лежащую на рукоятке пистолета.
   - Что ж, я верю, ты способен, - сказала она. - От тебя этого можно ждать.
   Он замотал головой, сжимая пальцами руль.
   - Эльма, не дури. Сейчас мы приедем в город и будем в безопасности!
   - Да-да, - ответила его жена, безучастно откинувшись на спину.
   - Эльма, выслушай меня.
   - Тебе нечего сказать, Сэм.
   - Эльма!
   Они проносились мимо белого шахматного городка, и,', 447);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1288, '2025-08-24 23:06:22.571376+03', 6, NULL, 'одержимый бессильной яростью, Сэм выпустил одну за другой шесть пуль по хрустальным башням. Под грохот выстрелов город рассыпался ливнем старинного стекла и обломков кварца. Разбился вдребезги, растворился, будто он был вырезан из мыла. Города не стало. Сэм рассмеялся и выстрелил еще раз. Последняя башня, последняя шахматная фигурка загорелась, вспыхнула и взлетела голубыми черепками к звездам.
   - Я им покажу! Я всем покажу!
   - Давай, давай, Сэм, показывай. - Глухая тень скрывала ее лицо.
   - А вот еще город! - Сэм снова зарядил пистолет. - Погляди, как я с ним расправлюсь!
   А сзади стремительно надвигались, неумолимо вырастали контуры голубых кораблей- призраков.', 448);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1289, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Сначала он даже не увидел их, только услышал свист и завывающую высокуюноту, будто сталь скрипела по песку: это бритвенно-острые носы песчаных кораблей резали поверхность морского дна. На голубых кораблях под красными и голубыми вымпелами стояли синие фигуры, люди в масках, люди с серебристыми лицами, с голубыми звездами вместо глаз, с лепными ушами из золота, отливающими металлом щеками и рубиновыми губами.
   Они стояли, скрестив руки на груди. Это были марсиане, и они преследовали его.
   Раз, два, три… Сэм считал. Марсианские корабли подошли вплотную к нему.
   - Эльма, Эльма, я не отобьюсь от всех!
   Эльма не ответила, даже не пошевелилась.
   Сэм выстрелил восемь раз.', 449);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1290, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Один песчаный корабль развалился на части, распались паруса, изумрудный корпус, его бронзовая оковка, лунно-белый руль и остальные образы. Люди в масках, все до одного, упали с корабля, зарылись в песок, и над каждым из них вспыхнуло пламя, сначала оранжевое, потом подернутое копотью.
   Но остальные корабли продолжали приближаться.
   - Их слишком много, Эльма! - вскричал он. - Они меня убьют!
   Он выбросил якорь. Без толку. Парус порхнул вниз, ложась в складки, вздыхая. Корабль, ветер, движение - все остановилось. Казалось, весь Марс замер, когда величественные суда марсиан, окружив Сэма, вздыбились над ним.
   - Землянин, - воззвал голос откуда-то с высоты.', 450);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1291, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Одна из серебристых масок шевелилась, рубиновые губы поблескивали в такт словам.
   - Я ничего не сделал! - Сэм смотрел на окружавшие его лица - их было не меньше ста.
   На Марсе осталось очень мало марсиан - всего не больше ста - ста пятидесяти. И почти все они были здесь, на дне мертвого моря, на своих воскрешенных кораблях, возле вымерших шахматных городов, один из которых только что рассыпался осколками, как хрупкая ваза, пораженная камнем. Сверкали серебряные маски.
   - Все это недоразумение, - взмолился он, привстав над бортом; жена его по- прежнему лежала замертво, свернувшись комочком, на дне корабля. - Я прилетел на Марс как честный предприимчивый бизнесмен, таких здесь много.', 451);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1292, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Выстроил себе ларек из обломков разбившейся ракеты, ларек, сами видели, загляденье, на самом перекрестке, вы это местечко знаете. Сработано чисто, правда ведь? - Сэм захихикал, переводя взгляд с одного лица на другое. - А тут, значит, появляется этот марсианин, я знаю - он ваш приятель. Я его нечаянно убил, уверяю вас, это несчастный случай. Мне ничего не надо, я только хотел завести сосисочную, первую, единственную на Марсе, центральную, можно сказать. Понимаете? Подавать лучшие на всей планете горячие сосиски, черт возьми, с перцем и луком, и апельсиновый сок.
   Серебряные маски неподвижно блестели в лунном свете. Светились устремленные на Сэма желтые глаза. Желудок его сжался в комок,', 452);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1293, '2025-08-24 23:06:22.571376+03', 6, NULL, 'в камень. Он швырнул пистолет на песок.
   - Сдаюсь.
   - Поднимите свой пистолет, - хором сказали марсиане.
   - Что?
   - Ваш пистолет. - Над носом голубого корабля взлетела ажурная рука. - Возьмите его. Уберите.
   Он, все еще не веря, подобрал пистолет.
   - А теперь, - продолжал голос, - разверните корабль и возвращайтесь к своему ларьку.
   - Сейчас же?
   - Сейчас же, - сказал голос. - Мы вам ничего дурного не сделаем. Вы обратились в бегство, прежде чем мы успели вам объяснить. Следуйте за нами.

   Огромные корабли развернулись легко, как лунные пушинки. Крылья-паруса тихо заплескались в воздухе, будто кто-то бил в ладони. Маски сверкали, поворачиваясь,', 453);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1294, '2025-08-24 23:06:22.571376+03', 6, NULL, 'холодным пламенем выжигали тени.
   - Эльма! - Сэм неуклюже взобрался на корабль. - Поднимайся, Эльма. Мы возвращаемся. - Он был так потрясен нежданным избавлением, что лепета его почти нельзя было понять. - Они мне ничего не сделают, не убьют меня, Эльма. Поднимайся, голубушка, вставай.
   - Что. Что? - Эльма растерянно озиралась, и, пока их корабль разворачивался под ветер, она медленно, будто во сне, поднялась и тяжело, словно мешок с камнями, опустилась на сиденье, не сказав больше ни слова.
   Песок под кораблем убегал назад. Через полчаса они снова были у перекрестка, корабли ошвартовались и все сошли с кораблей.
   Перед Сэмом и Эльмой остановился Глава марсиан:', 454);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1295, '2025-08-24 23:06:22.571376+03', 6, NULL, 'маска вычеканена из полированной бронзы, глаза - бездонные черно-синие провалы, рот - прорезь, из которой плыли по ветру слова.
   - Снаряжайте вашу лавку, - сказал голос. В воздухе мелькнула рука в алмазной перчатке. - Готовьте яства, готовьте угощение, готовьте чужеземные вина, ибо нынешняя ночь - поистине великая ночь!
   - Стало быть, - заговорил Сэм, - вы разрешите мне остаться здесь?
   - Да.
   - Вы на меня не сердитесь?
   Маска была сурова и жестка, бесстрастна и слепа.
   - Готовьте свое кормилище, - тихо сказал голос. - И возьмите вот это.
   - Что это?
   Сэм уставился на врученный ему свиток из тонкого серебряного листа, по поверхности которого извивались змейки иероглифов.', 455);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1296, '2025-08-24 23:06:22.571376+03', 6, NULL, '- Это дарственная на все земли от серебряных гор до голубых холмов, от мертвого моря до далеких долин, где лунный камень и изумруды, - сказал Глава.
   - Все м-мое? - пробормотал Сэм, не веря своим ушам.
   - Ваше.
   - Сто тысяч квадратных миль?
   - Ваши.
   - Ты слышала, Эльма?
   Эльма сидела на земле, прислонившись спиной к алюминиевой стене сосисочной; глаза ее были закрыты.
   - Но почему, с какой стати вы мне дарите все это? - спросил Сэм, пытаясь заглянуть в металлические прорези глаз.
   - Это не все. Вот.
   Еще шесть свитков. Вслух перечисляются названия, обозначения других земель.
   - Но это же половина Марса! Я хозяин половины Марса! - Сэм стиснул гремучие свитки,', 456);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1297, '2025-08-24 23:06:22.571376+03', 6, NULL, 'тряс ими перед Эльмой, захлебываясь безумным смехом. - Эльма, ты слышала?
   - Слышала, - ответила Эльма, глядя на небо.
   Казалось, она что-то разыскивает. Апатия мало-помалу оставляла ее.
   - Спасибо, большое спасибо, - сказал Сэм бронзовой маске.
   - Это произойдет сегодня ночью, - ответила маска. - Приготовьтесь.
   - Ладно. А что это будет - неожиданность какая-нибудь? Ракеты с Земли прилетят раньше объявленного, за месяц до срока? Все десять тысяч ракет с поселенцами, с рудокопами, с рабочими и их женами, сто тысяч человек, как говорили? Вот здорово было бы, правда, Эльма? Видишь, я тебе говорил, говорил, что в этом поселке одной тысячей жителей дело не ограничится.', 457);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1298, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Сюда прилетят еще пятьдесят тысяч, через месяц - еще сто тысяч, а всего к концу года - пять миллионов с Земли! И на самой оживленной магистрали, на пути к рудникам - единственная сосисочная, моя сосисочная!
   Маска парила на ветру.
   - Мы покидаем вас. Приготовьтесь. Весь этот край остается вам.
   В летучем лунном свете древние корабли - металлические лепестки ископаемого цветка, голубые султаны, огромные и бесшумные кобальтовые бабочки - повернули и заскользили по зыбким пескам, и маски все лучились и сияли, пока последний отсвет, последний голубой блик не затерялся среди холмов.
   - Эльма, почему они так поступили? Почему не убили меня? Неужто они ничего не знают?', 458);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1299, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Что с ними стряслось? Эльма, ты что-нибудь понимаешь? - Он потряс ее за плечо. - Половина Марса - моя!
   Она глядела на небо и ожидала чего-то.
   - Пошли, - сказал он. - Надо все приготовить. Кипятить сосиски, подогревать булочки, перечный соус варить, чистить и резать лук, приправы расставить, салфетки разложить в кольцах, и чтобы чистота была - ни единого пятнышка! Эге- гей! - Он отбил коленце какого-то необузданного танца, высоко вскидывая пятки. - Я счастлив, парень, счастлив, сэр, - запел он, фальшивя. - Сегодня мой счастливый день!
   Он работал, как одержимый: бросил в кипяток сосиски, разрезал булки вдоль, накрошил лук.
   - Ты слышала, что сказал тот марсианин - неожиданность,', 459);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1300, '2025-08-24 23:06:22.571376+03', 6, NULL, 'говорит! Тут только одно может быть, Эльма. Эти сто тысяч человек прилетают раньше срока, сегодня ночью прилетают! Представляешь, какой у нас будет наплыв! До поздней ночи будем работать, каждый день, а там ведь еще туристы нахлынут, Эльма! Деньги-то, деньги какие!
   Он вышел наружу и посмотрел на небо. Ничего не увидел.
   - С минуты на минуту, - произнес он, радостно вдохнув прохладный воздух, потянулся, ударил себя в грудь. - А-ах!
   Эльма молчала. Она чистила картофель для жарки и не сводила глаз с неба.
   Прошло полчаса.
   - Сэм, - сказала она. - Вон она. Гляди.
   Он поглядел и увидел.
   Земля.
   Яркая, зеленая, будто камень лучшей огранки, над холмами взошла Земля.', 460);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1301, '2025-08-24 23:06:22.571376+03', 6, NULL, '- Старушка Земля, - с нежностью прошептал он. - Дорогая старушка Земля. Шли сюда, ко мне, своих голодных и изнуренных. Э-э… как там в стихе говорится? Шли ко мне своих голодных. Земля-старушка. Сэм Паркхилл тут как тут, горячие сосиски готовы, соус варится, все блестит. Давай, Земля, присылай ракеты!
   Он отошел в сторонку полюбоваться своим детищем. Вот она, сосисочная, как свеженькое яичко на дне мертвого моря, единственный на сотни миль бесплодной пустыни очагсвета и тепла. Точно сердце, одиноко бьющееся в исполинском черном теле.
   Он даже растрогался, и глаза увлажнились от гордости.
   - Тут поневоле смирением проникнешься, - произнес он, вдыхая запах кипящих сосисок,', 461);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1302, '2025-08-24 23:06:22.571376+03', 6, NULL, 'горячих булочек, сливочного масла. - Подходите, - обратился он к звездам, - покупайте. Кто первый?
   - Сэм, - сказала Эльма.
   Земля в черном небе вдруг преобразилась.
   Она воспламенилась.
   Часть ее диска вдруг распалась на миллионы частиц - будто рассыпалась огромная мозаика. С минуту Земля пылала жутким рваным пламенем, увеличившись в размерах раза в три, потом съежилась.
   - Что это было? - Сэм глядел на зеленый огонь в небесах.
   - Земля, - ответила Эльма, прижав руки к груди.
   - Какая же это Земля, это не может быть Земля! Нет-нет, не Земля! Не может быть.
   - Ты хочешь сказать: не могла быть? - сказала Эльма, смотря на него. - Теперь это уже не Земля, да,', 462);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1303, '2025-08-24 23:06:22.571376+03', 6, NULL, 'это больше не Земля - ты это хотел сказать?
   - Не Земля, нет-нет, это была не она, - выл он.
   Он стоял неподвижно, руки повисли как плети, рот открыт, тупо вытаращены глаза.
   - Сэм, - позвала она. Впервые за много дней ее глаза оживились. - Сэм!
   Он смотрел вверх, на небо.
   - Что ж, - сказала она. С минуту молча переводила взгляд с одного предмета на другой, потом решительно перекинула через руку влажное полотенце. - Включай свет, больше света, заводи радиолу, раскрывай двери настежь! Жди новую партию посетителей - примерно через миллион лет. Да-да, сэр, чтобы все было готово.
   Сэм не двигался.
   - Ах, какое бесподобное место для сосисочной!', 463);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1304, '2025-08-24 23:06:22.571376+03', 6, NULL, '- Она достала из стакана зубочистку и воткнула себе между передними зубами. - Скажу тебе по секрету, Сэм, - прошептала она, наклоняясь к нему: - Похоже, начинается мертвый сезон…
   Ноябрь 2005

   Наблюдатели
   В тот вечер все вышли из своих домов и уставились на небо. Бросили ужин, посуду, сборы в кино, вышли на свои, теперь уже не такие новешенькие веранды и стали смотреть в упор на зеленую звезду Земли. Это было совсем непроизвольно; они поступили так, пытаясь осмыслить новость, которую только что принесло радио. Вон она - Земля, где назревает война, и там сотни тысяч матерей, бабушек, отцов, братьев, тетушек, дядюшек, двоюродных сестер.', 464);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1305, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Они стояли на верандах и заставляли себя поверить в существование Земли; это было почти так же трудно, как некогда поверить в существование Марса: прямо противоположная задача. В общем-то Земля была для них все равно что мертвой. Они расстались с ней три или четыре года назад. Расстояние обезболивало душу, семьдесят миллионов миль глушили чувства, усыпляли память, делали Землю безлюдной, стирали прошлое и позволяли этим людям трудиться здесь, ни о чем не думая. Но сегодня вечером умершие восстали. Земля вновь стала обитаемой, память пробудилась и они называли множество имен. Что делает сейчас такой-то, такая-то? Как там имярек? Люди стояли на своих верандах и поглядывали друг на друга.', 465);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1306, '2025-08-24 23:06:22.571376+03', 6, NULL, 'В девять часов Земля как будто взорвалась и вспыхнула.
   Люди на верандах вскинули вверх руки, точно хотели загасить пламя.
   Они ждали.
   К полуночи пожар потух. Земля осталась на своем месте. И по верандам осенним ветерком пронесся вздох.
   - Давненько мы ничего не слышали от Гарри.
   - А что ему делается.
   - Надо бы послать весточку маме.
   - Она жива-здорова.
   - Ты уверен?
   - Ладно, ты только не тревожься.
   - Думаешь, с ней ничего не приключилось?
   - Конечно же, пошли-ка спать.
   Но никто не уходил. На ночные газоны вынесли остывший ужин, накрыли складные столы, и люди вяло ковыряли пищу вилками до двух часов ночи, когда с Земли долетело послание светового радио.', 466);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1307, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Словно далекие светлячки, мерцали мощные вспышки морзянки, и они читали:

   АВСТРАЛИЙСКИЙ МАТЕРИК ОБРАЩЕН В
   ПЫЛЬ НЕПРЕДВИДЕННЫМ ВЗРЫВОМ АТОМНОГО СКЛАДА.
   ЛОС АНДЖЕЛЕС, ЛОНДОН ПОДВЕРГНУТЫ БОМБАРДИРОВКЕ.
   ВОЙНА. ВОЗВРАЩАЙТЕСЬ ДОМОЙ. ДОМОЙ. ДОМОЙ

   Они поднялись из-за столов.

   ВОЗВРАЩАЙТЕСЬ ДОМОЙ. ДОМОЙ, ДОМОЙ

   - Ты в этом году получал что-нибудь от своего брата Теда?
   - Будто не знаешь: послать письмо на Землю стоит пять монет. Не очень-то распишешься.

   ВОЗВРАЩАЙТЕСЬ ДОМОЙ

   - Меня что-то Джейн беспокоит - помнишь Джейн, мою младшую сестричку?

   ДОМОЙ

   В три часа, когда занималось зябкое утро, владелец магазина «Дорожные товары» вскинул голову.', 467);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1308, '2025-08-24 23:06:22.571376+03', 6, NULL, 'По улице шла целая толпа людей.
   - А я умышленно не закрывал. Что возьмете, мистер?
   К рассвету все полки магазина опустели.
   Декабрь 2005

   Безмолвные города
   На краю мертвого марсианского моря раскинулся безмолвный белый городок. Он был пуст. Ни малейшего движения на улицах. Днем и ночью в универмагах одиноко горели огни. Двери лавок открыты настежь, точно люди обратились в бегство, позабыв о ключах. На проволочных рейках у входов в немые закусочные нечитанные, порыжевшие от солнца, шелестели журналы, доставленные месяц назад серебристой ракетой с Земли.
   Городок был мертв. Постели в нем пусты и холодны. Единственный звук - жужжание тока в электропроводах и динамо-машинах,', 468);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1309, '2025-08-24 23:06:22.571376+03', 6, NULL, 'которые все еще жили сами по себе. Вода переполняла забытые ванны, текла в жилые комнаты, на веранды, в маленькие сады, питая заброшенные цветы. В темных зрительных залах затвердела прилепленная снизу к многочисленным сиденьям жевательная резинка, еще хранящая отпечатки зубов.
   За городом был космодром. Едкий паленый запах до сих пор стоял там, откуда взлетела курсом на Землю последняя ракета. Если опустить монетку в телескоп и навести егона Землю, можно, пожалуй, увидеть бушующую там большую войну. Увидеть, скажем, как взрывается Нью-Йорк. А то и рассмотреть Лондон, окутанный туманом нового рода. И, может быть, тогда станет понятным, почему покинут этот марсианский городок.', 469);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1310, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Быстро ли проходила эвакуация? Войдите в любой магазин, нажмите на клавиши кассы. И ящичек выскочит, сверкая и бренча монетами. Да, должно быть, плохо дело на Земле…
   По пустынным улицам городка, негромко посвистывая, сосредоточенно гоня перед собой ногами пустую банку, шел высокий худой человек. Угрюмый, спокойный взгляд его глаз отражал всю степень его одиночества Он сунул костистые руки в карманы, где бренчали новенькие монеты. Нечаянно уронил монетку на асфальт, усмехнулся и пошел дальше, кропя улицы блестящими монетами…
   Его звали Уолтер Грипп. У него был золотой прииск и уединенная лачуга далеко в голубых марсианских горах,', 470);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1311, '2025-08-24 23:06:22.571376+03', 6, NULL, 'и раз в две недели он отправлялся в город поискать себе в жены спокойную, разумную женщину. Так было не первый год, и всякий раз он возвращался в свою лачугу разочарованный и по-прежнему одинокий. А неделю назад, придя в город, застал вот такую картину!
   Он был настолько ошеломлен в тот день, что заскочил в первую попавшуюся закусочную и заказал себе тройной сэндвич с мясом.
   - Будет сделано! - крикнул он.
   Он расставил на стойке закуски и испеченный накануне хлеб, смахнул пыль со стола, предложил самому себе сесть и ел, пока не ощутил потребность отыскать сатуратор и заказать содовой. Владелец, некто Уолтер Грипп, оказался на диво учтивым и мигом налил ему шипучий напиток!', 471);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1312, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Он набил карманы джинсов деньгами, какие только ему подворачивались. Нагрузил тележку десятидолларовыми бумажками и побежал, обуреваемый вожделениями, по городу.Уже на окраине он внезапно уразумел, до чего постыдно и глупо себя ведет. На что ему деньги! Он отвез десятидолларовые бумажки туда, где взял их, вынул из собственного бумажника один доллар, опустил его в кассу закусочной за сэндвичи и добавил четвертак на чай.

   Вечером он насладился жаркой турецкой баней, сочным филе и изысканным грибным соусом, импортным сухим хересом и клубникой в вине. Подобрал себе новый синий фланелевый костюм и роскошную серую шляпу, которая потешно болталась на макушке его длинной головы.', 472);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1313, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Он сунул монетку в автомат-радиолу, которая заиграла «Нашу старую шайку». Насовал пятаков в двадцать автоматов по всему городу. Печальные звуки «Нашей старой шайки» заполнили ночь и пустынные улицы, а он шел все дальше, высокий, худой, одинокий, мягко ступая новыми ботинками, грея в карманах озябшие руки.
   С тех пор прошла неделя. Он спал в отличном доме на Марс-Авеню, утром вставал в девять, принимал ванну и лениво брел в город позавтракать яйцами с ветчиной. Что ни утро, он заряжал очередной холодильник тонной мяса, овощей, пирогов с лимонным кремом, запасая себе продукты лет на десять, пока не вернутся с Земли Ракеты. Если они вообще вернутся.', 473);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1314, '2025-08-24 23:06:22.571376+03', 6, NULL, 'А сегодня вечером он слонялся взад-вперед, рассматривая восковых женщин в красочных витринах - розовых, красивых. И впервые ощутил, до чего же мертв город. Выпил кружку пива и тихонько заскулил.
   - Черт возьми, - сказал он. - Я же совсемодин.
   Он зашел в кинотеатр «Элит», хотел показать себе фильм, чтобы отвлечься от мыслей об одиночестве. В зале было пусто и глухо, как в склепе, по огромному экрану ползли серые и черные призраки. Его бросило в дрожь, и он ринулся прочь из этого логова нечистой силы.
   Решив вернуться домой, он быстро шел, почти бежал по мостовой тихого переулка, когда услышал телефонный звонок.
   Он прислушался.
   «Где-то звонит телефон».', 474);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1315, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Он продолжал идти вперед.
   «Сейчас кто-нибудь возьмет трубку», - лениво подумалось ему.
   Он сел на край тротуара и принялся не спеша вытряхивать камешек из ботинка.
   И вдруг крикнул, вскакивая на ноги:
   - Кто-нибудь! Силы небесные, да что это я!
   Он лихорадочно озирался. В каком доме? Вон в том! Ринулся через газон, вверх по ступенькам, в дом, в темный холл.
   Сорвал с рычага трубку.
   - Алло! - крикнул он.
   Ззззззззззззз.
   - Алло, алло!
   Уже повесили.
   - Алло! - заорал он и стукнул по аппарату. - Идиот проклятый! - выругал он себя. - Рассиживал себе на тротуаре, дубина! Чертов болван, тупица! - Он стиснул руками телефонный аппарат - Ну, позвони еще раз.Ну же!', 475);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1316, '2025-08-24 23:06:22.571376+03', 6, NULL, 'До сих пор ему и в голову не приходило, что на Mapсе мог остаться кто-то еще, кроме него. За всю прошедшую неделю он не видел ни одного человека. Он решил, что все остальные города так же безлюдны, как этот.
   Теперь он, дрожа от волнения, глядел на несносный черный ящичек. Автоматическая телефонная сеть соединяет между собой все города Марса. Их тридцать - из которого звонили?
   Он не знал.
   Он ждал. Прошел на чужую кухню, оттаял замороженную клубнику, уныло съел ее.
   - Да там никого и не было, - пробурчал он. - Наверно, ветер где-то повалил телефонный столб и нечаянно получился контакт.
   Но ведь он слышал щелчок, точно кто-то на том конце повесил трубку?', 476);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1317, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Всю ночь Уолтер Грипп провел в холле.
   - И вовсе не из-за телефона, - уверял он себя. - Просто мне больше нечего делать.
   Он прислушался к тиканью своих часов.
   - Она не позвонит больше, - сказал он. - Ни за что не станет снова набирать номер, который не ответил. Наверно, в эту самую минуту обзванивает другие дома в городе! А я сижу здесь… Постой! - он усмехнулся. - Почему я говорю «она»?
   Он растерянно заморгал.
   - С таким же успехом это мог быть и «он», верно?
   Сердце угомонилось. Холодно и пусто, очень пусто. Ему так хотелось, чтобы это была «она». Он вышел из дому и остановился посреди улицы, лежавшей в тусклом свете раннего утра.
   Прислушался. Ни звука. Ни одной птицы.', 477);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1318, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Ни одной автомашины. Только сердца стук. Толчок - перерыв - толчок. Мышцы лица свело от напряжения. А ветер, такой нежный, такой ласковый, тихонько трепал полы его пиджака.
   - Тсс, - прошептал он. -Слушай!
   Он медленно поворачивался, переводя взгляд с одного безмолвного дома на другой.
   Она будет набирать номер за номером, думал он. Это должна быть женщина. Почему? Только женщина станет перебирать все номера. Мужчина не станет. Мужчина самостоятельнее. Разве я звонил кому-нибудь? Нет! Даже в голову не приходило. Это должна быть женщина.Непременнодолжна, видит бог!
   Слушай.
   Вдалеке, где-то под звездами, зазвонил телефон.
   Он побежал. Остановился послушать. Тихий звон.', 478);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1319, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Еще несколько шагов. Громче. Он свернул и помчался вдоль аллеи. Еще громче! Миновал шесть домов, еще шесть! Совсем громко! Вот этот? Дверь была заперта.
   Внутри звонил телефон.
   - А, черт! - Он дергал дверную ручку.
   Телефон надрывался.
   Он схватил на веранде кресло, обрушил его на окно гостиной и прыгнул в пролом.
   Прежде чем он успел взяться за трубку, телефон смолк.
   Он пошел из комнаты в комнату, бил зеркала, срывал портьеры, сшиб ногой кухонную плиту.
   Вконец обессилев, он подобрал с пола тонкую телефонную книгу, в которой значились все абоненты на Марсе. Пятьдесят тысяч фамилий.
   Начал с первой фамилии.
   Амелия Амз Нью-Чикаго, за сто миль,', 479);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1320, '2025-08-24 23:06:22.571376+03', 6, NULL, 'по ту сторону мертвого моря. Он набрал ее номер.
   Нет ответа.
   Второй абонент жил в Нью-Йорке, за голубыми горами, пять тысяч миль.
   Нет ответа.
   Третий, четвертый, пятый, шестой, седьмой, восьмой: дрожащие пальцы с трудом удерживали трубку.
   Женский голос ответил:
   - Алло?
   Уолтер закричал в ответ:
   - Алло, господи, алло!
   - Это запись, - декламировал женский голос. - Мисс Элен Аразумян нет дома. Скажите, что вам нужно будет записано на проволоку, чтобы она могла позвонить вам, когда вернется. Алло? Это запись. Мисс Аразумян нет дома. Скажите, что вам нужно…
   Он повесил трубку.
   Его губы дергались.
   Подумав, он набрал номер снова.', 480);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1321, '2025-08-24 23:06:22.571376+03', 6, NULL, '- Когда мисс Элен Аразумян вернется домой, - сказал он, - передайте ей, чтобы катилась к черту.

   Он позвонил на центральный коммутатор Марса, на телефонные станции Нью-Бостона, Аркадии и Рузвельт Сити, рассудив, что там скорее всего можно застать людей, пытающихся куда-нибудь дозвониться, потом вызвал ратуши и другие официальные учреждения в каждом городе. Обзвонил лучшие отели. Какая женщина устоит против искушения пожить в роскоши!
   Вдруг он громко хлопнул в ладоши и рассмеялся. Ну, конечно же! Сверился с телефонной книгой и набрал через междугородную номер крупнейшего косметического салона в Нью-Тексас-Сити. Где же еще искать женщину, если не в обитом бархатом,', 481);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1322, '2025-08-24 23:06:22.571376+03', 6, NULL, 'роскошном косметическом салоне, где она может метаться от зеркала к зеркалу, лепить на лицо всякие мази, сидеть под электросушилкой!
   Долгий гудок. Кто-то на том конце провода взял трубку.
   Женский голос сказал:
   - Алло!
   - Если это запись, - отчеканил Уолтер Грипп, - я приеду и взорву к чертям ваше заведение.
   - Это не запись, - ответил женский голос - Алло! Алло, неужели тут есть живой человек! Где вы?
   Она радостно взвизгнула.
   Уолтер чуть не упал со стула.
   - Алло!.. - Он вскочил на ноги, сверкая глазами. - Боже мой, какое счастье, как вас звать?
   - Женевьева Селзор! - Она плакала в трубку. - О, господи, я так рада, что слышу ваш голос, кто бы вы ни были!', 482);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1323, '2025-08-24 23:06:22.571376+03', 6, NULL, '- Я Уолтер Грипп!
   - Уолтер, здравствуйте, Уолтер!
   - Здравствуйте, Женевьева!
   - Уолтер. Какое чудесное имя. Уолтер, Уолтер!
   - Спасибо.
   - Ногде жевы, Уолтер?
   Какой милый, ласковый, нежный голос… Он прижал трубку поплотнее к уху, чтобы она могла шептать ласковые слова. У него подкашивались ноги Горели щеки.
   - Я в Мерлин-Вилледж, - сказал он - Я…
   Зззз.
   - Алло? оторопел он.
   Зззз.
   Он постучал по рычагу. Ничего.
   Где-то ветер свалил столб. Женевьева Селзор пропала так же внезапно, как появилась.
   Он набрал номер, но аппарат был нем.
   - Ничего, теперь я знаю, где она.
   Он выбежал из дома.', 483);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1324, '2025-08-24 23:06:22.571376+03', 6, NULL, 'В лучах восходящего солнца он задним ходом вывел из чужого гаража спортивную машину, загрузил заднее сиденье взятыми в доме продуктами и со скоростью восьмидесяти миль в час помчался по шоссе в Нью-Тексас-Сити. Тысяча миль, подумал он. Терпи, Женевьева Селзор, я не заставлю тебя долго ждать!
   Выезжая из города, он лихо сигналил на каждом углу.
   На закате, после дня немыслимой гонки, он свернул к обочине, сбросил тесные ботинки, вытянулся на сиденье и надвинул свою роскошную шляпу на утомленные глаза. Его дыхание стало медленным, ровным. В сумраке над ним летел ветер, ласково сияли звезды. Кругом высились древние-древние марсианские горы. Свет звезд мерцал на шпилях марсианского городка,', 484);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1325, '2025-08-24 23:06:22.571376+03', 6, NULL, 'который шахматными фигурками прилепился к голубым склонам.
   Он лежал, витая где-то между сном и явью. Он шептал: Женевьева. Потом тихо запел.«О Женевьева, дорогая, - пускай бежит за годом год. Но, дорогая Женевьева…»На душе было тепло. В ушах звучал ее тихий, нежный, ровный голос:«Алло, о, алло, Уолтер! Это не запись. Где ты, Уолтер, где ты?»
   Он вздохнул, протянул руку навстречу лунному свету - прикоснуться к ней. Ветер развевал длинные черные волосы, чудные волосы. А губы - как красные мятные лепешки. И щеки, как только что срезанные влажные розы. И тело будто легкий светлый туман, а мягкий, ровный, нежный голос напевает ему слова старинной печальной песенки:«О Женевьева,', 485);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1326, '2025-08-24 23:06:22.571376+03', 6, NULL, 'дорогая - пускай бежит за годом год…»
   Он уснул.

   Он добрался до Нью-Тексас-Сити в полночь.
   Остановил машину перед косметическим салоном «Делюкс» и лихо гикнул.
   Вот сейчас она выбежит в облаке духов, вся лучась смехом.
   Ничего подобного не произошло.
   - Уснула. - Он пошел к двери. - Я уже тут! - крикнул он. - Алло, Женевьева!
   Безмолвный город был озарен двоящимся светом лун. Где-то ветер хлопал брезентовым навесом. Он распахнул стеклянную дверь и вошел.
   - Эгей! - Он смущенно рассмеялся. - Не прячься! Я знаю, что ты здесь!
   Он обыскал все кабинки.
   Нашел на полу крохотный платок. Запах был такой дивный, что его зашатало.
   - Женевьева, - произнес он.', 486);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1327, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Он погнал машину по пустым улицам, но никого не увидел.
   - Если ты вздумала подшутить…
   Он сбавил ход.
   - Постой-ка, нас же разъединили. Может, она поехала в Мерлин-Вилледж, пока я ехал сюда?! Свернула, наверно, на древнюю Морскую дорогу, и мы разминулись днем. Откуда ей было знать, что я приеду сюда? Я же ей не сказал. Когда телефон замолчал, она так перепугалась, что бросилась в Мерлин-Вилледж искать меня! А я здесь торчу, силы небесные, какой же я идиот!
   Он нажал клаксон и пулей вылетел из города.
   Он гнал всю ночь. И думал: «Что если я не застану ее в Мерлин-Вилледж?»
   Вон из головы эту мысль. Онадолжнабыть там. Он подбежит к ней и обнимет ее, может быть,', 487);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1328, '2025-08-24 23:06:22.571376+03', 6, NULL, 'даже поцелует - один раз - в губы.
   «Женевьева, дорогая», -насвистывал он, выжимая педалью сто миль в час.

   В Мерлин-Вилледж было по-утреннему тихо. В магазинах еще горели желтые огни; автомат, который играл сто часов без перерыва, наконец щелкнул электрическим контактоми смолк; безмолвие стало полным. Солнце начало согревать улицы и холодное безучастное небо.
   Уолтер свернул на Мейн-стрит, не выключая фар, усиленно гудя клаксоном, по шесть раз на каждом углу. Глаза впивались в вывески магазинов. Лицо было бледное, усталое, руки скользили по мокрой от пота баранке.
   - Женевьева! - взывал он к пустынной улице.
   Отворилась дверь косметического салона.
   - Женевьева!', 488);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1329, '2025-08-24 23:06:22.571376+03', 6, NULL, '- Он остановил машину и побежал через улицу.
   Женевьева Селзор стояла в дверях салона. В руках у нее была раскрытая коробка шоколадных конфет. Коробку стискивали пухлые, белые пальцы. Лицо - он увидел его, войдяв полосу света, - было круглое и толстое, глаза - два огромных яйца, воткнутых в бесформенный ком теста. Ноги - толстые, как колоды, походка тяжелая, шаркающая. Волосы -неопределенного бурого оттенка, тщательно уложенные в виде птичьего гнезда. Губ не было вовсе, их заменял нарисованный через трафарет жирный красный рот, который то восхищенно раскрывался, то испуганно захлопывался. Брови она выщипала, оставив две тонкие ниточки.
   Уолтер замер. Улыбка сошла с его лица.', 489);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1330, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Он стоял и глядел.
   Она уронила конфеты на тротуар.
   - Вы Женевьева Селзор? - У него звенело в ушах.
   - Вы Уолтер Грифф? - спросила она.
   - Грипп.
   - Грипп, - поправилась она.
   - Здравствуйте, - выдавил он из себя.
   - Здравствуйте. - Она пожала его руку.
   Ее пальцы были липкими от шоколада.

   - Ну, - сказал Уолтер Грипп.
   - Что? - спросила Женевьева Селзор.
   - Я только сказал «ну», - объяснил Уолтер.
   - А-а.
   Девять часов вечера. Днем они ездили за город, а на ужин он приготовил филе- миньон, но Женевьева нашла, что оно недожарено, тогда Уолтер решил дожарить его и то ли пережарил, то ли пережег, то ли еще что. Он рассмеялся и сказал:
   - Пошли в кино!', 490);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1331, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Она сказала «ладно» и взяла его под руку липкими, шоколадными пальцами. Но ее запросы ограничились фильмом пятидесятилетней давности с Кларком Гейблом.
   - Вот ведь умора, да? - хихикала она. - Ох,умора!
   Фильм кончился.
   - Крути еще раз, - велела она.
   - Снова? - спросил он.
   - Снова, - ответила она.
   Когда он вернулся, она прижалась к нему и облапила его.
   - Ты не совсем то, что я ожидала, но все же ничего, - призналась она.
   - Спасибо, - сказал он, чуть не подавившись.
   - Ах, этот Гейбл. - Она ущипнула его за ногу.
   - Ой, - сказал он.
   После кино они пошли по безмолвным улицам «за покупками». Она разбила витрину и напялила самое яркое платье,', 491);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1332, '2025-08-24 23:06:22.571376+03', 6, NULL, 'какое только смогла найти. Потом опрокинула на голову флакон духов и стала похожа на мокрую овчарку.
   - Сколько тебе лет? - поинтересовался он.
   - Угадай. - Она вела его по улице, капая на асфальт духами.
   - Около тридцати? - сказал он.
   - Вот еще, - сухо ответила она. - Мне всего двадцать семь, чтоб ты знал! Ой, вот еще кондитерская! Честное слово, с тех пор как началась эта заваруха, я живу, как миллионерша. Никогда не любила свою родню, так, болваны какие-то. Улетели на Землю два месяца назад. Я тоже должна была улететь с последней ракетой, но осталась. Знаешь, почему?
   - Почему?
   - Потому что все меня дразнили. Вот я и осталась здесь - лей на себя духи, сколько хочешь,', 492);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1333, '2025-08-24 23:06:22.571376+03', 6, NULL, 'пей пиво, сколько влезет, ешь конфеты, и некому тебе твердить: «Слишком много калорий!» Потому ятут!
   - Ты тут. - Уолтер зажмурился.
   - Уже поздно, - сказала она, поглядывая на него.
   - Да.
   - Я устала, - сказала она.
   - Странно. У меня ни в одном глазу.
   - О, - сказала она.
   - Могу всю ночь не ложиться, - продолжал он. - Знаешь, в баре Майка есть хорошая пластинка. Пошли, я тебе ее заведу.
   - Я устала. - Она стрельнула в него хитрыми блестящими глазами.
   - А я - как огурчик, - ответил он. - Просто удивительно.
   - Пойдем в косметический салон, - сказала она. - Я тебе кое-что покажу.
   Она втащила его в стеклянную дверь и подвела к огромной белой коробке.', 493);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1334, '2025-08-24 23:06:22.571376+03', 6, NULL, '- Когда я уезжала из Тексас-Сити, - объяснила она, - захватила с собой вот это. - Она развязала розовую ленточку. - Подумала: ведь я единственная дама на Марсе, а он единственный мужчина, так что…
   Она подняла крышку и откинула хрусткие слои шелестящей розовой гофрированной бумаги. Она погладила содержимое коробки.
   - Вот.
   Уолтер Грипп вытаращил глаза.
   - Что это? - спросил он, преодолевая дрожь.
   - Будто не знаешь, дурачок? Гляди-ка, сплошь кружева, и все такое белое, шикарное…
   - Ей-богу, не знаю, что это.
   - Свадебное платье, глупенький!
   - Свадебное? - Он охрип.
   Он закрыл глаза. Ее голос звучал все так же мягко, спокойно, нежно, как тогда в телефоне.', 494);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1335, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Но если открыть глаза и посмотреть на нее…
   Он попятился.
   - Очень красиво, - сказал он.
   - Правда?
   - Женевьева. - Он покосился на дверь.
   - Да?
   - Женевьева, мне нужно тебе кое-что сказать.
   - Да?
   Она подалась к нему, ее круглое белое лицо приторно благоухало духами.
   - Хочу сказать тебе… - продолжал он.
   - Ну?
   - До свидания!
   Прежде чем она успела вскрикнуть, он уже выскочил из салона и вскочил в машину.
   Она выбежала и застыла на краю тротуара, глядя, как он разворачивает машину.
   - Уолтер Грифф, вернись! - прорыдала она, вскинув руки.
   - Грипп, - поправил он.
   - Грипп! - крикнула она.
   Машина умчалась по безмолвной улице,', 495);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1336, '2025-08-24 23:06:22.571376+03', 6, NULL, 'невзирая на ее топот и вопли. Струя выхлопа колыхнула белое платье, которое она мяла в своих пухлых руках, а в небе сияли яркие звезды, и машина канула в пустыню, утонула во мраке.
   Он гнал день и ночь, трое суток подряд. Один раз ему показалось, что сзади едет машина, его бросило в дрожь, прошиб пот, и он свернул на другое шоссе, рассекающее пустынные марсианские просторы, бегущее мимо безлюдных городков. Он гнал и гнал - целую неделю, и еще один день, пока не оказался за десять тысяч миль от Мерлин-Вилледж. Тогда он заехал в поселок под названием Холтвиль-Спрингс, с маленькими лавками, где он мог вечером зажигать свет в витринах, и с ресторанами, где мог посидеть, заказывая блюда.', 496);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1337, '2025-08-24 23:06:22.571376+03', 6, NULL, 'С тех пор он так и живет там; у него две морозильные камеры, набитые продуктами лет на сто, запас сигарет на десять тысяч дней и отличная кровать с мягким матрасом.
   Текут долгие годы, и если в кои-то веки у него зазвонит телефон - он не отвечает.
   Апрель 2026

   Долгие годы
   Так уж повелось: когда с неба налетал ветер, он и его небольшая семья отсиживались в своей каменной лачуге и грели руки над пылающими дровами. Ветер вспахивал гладьканалов, чуть не срывал звезды с неба, а мистер Хетэуэй сидел, наслаждаясь уютом, и говорил что-то жене, и жена отвечала ему, и он рассказывал о былых временах на Земле двум дочерям и сыну, и они вставляли слово к месту.', 497);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1338, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Шел двадцатый год после Большой Войны. Марс представлял собой огромный могильник. А Земля? Что с ней? В долгие марсианские ночи Хетэуэй и его семья часто размышлялиоб этом.
   В эту ночь неистовая марсианская пылевая буря пронеслась над приземистыми могилами марсианских кладбищ, завывая на улицах древних городов и снося совсем еще новые пластиковые стены уходящего в песок, заброшенного американского города.
   Но вот буря утихла, прояснилось, и Хетэуэй вышел посмотреть на Землю - зеленый огонек в ветреных небесах. Он поднял руку вверх, точно хотел получше ввернуть тускло горящую лампочку под потолком сумрачной комнаты. Поглядел вдаль, над дном мертвого моря. «На всей планете ни души,', 498);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1339, '2025-08-24 23:06:22.571376+03', 6, NULL, '- подумал он. - Один я. И они». Он оглянулся на дверь каменной лачуги.
   Что сейчас происходит на Земле? Сколько он ни смотрел в свой тридцатидюймовый телескоп, до сих пор никаких изменений не приметил. «Что ж, если я буду беречь себя, - подумал он, - еще лет двадцать проживу». Глядишь, кто-нибудь явится. Либо из-за мертвых морей, либо из космоса на ракете, привязанной к ниточке красного пламени.
   - Я пойду погуляю, - крикнул он в дверь.
   - Хорошо, - отозвалась жена.
   Он не спеша пошел вниз между рядами развалин.
   - «Сделано в Нью-Йорке», - прочитал он на куске металла. - Древние марсианские города намного переживут все эти предметы с Земли…
   И посмотрел туда,', 499);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1340, '2025-08-24 23:06:22.571376+03', 6, NULL, 'где между голубых гор вот уже пятьдесят веков стояло марсианское селение.
   Он пришел на уединенное марсианское кладбище: небольшие каменные шестигранники выстроились в ряд на бугре, овеваемом пустынными ветрами.
   Склонив голову, он смотрел на четыре могилы, четыре грубых деревянных креста, и на каждом имя. Слез не было в его глазах. Слезы давно высохли.
   - Ты простишь меня за то, что я сделал? - спросил он один из крестов. - Я был очень, очень одинок. Ведь ты понимаешь?
   Он возвратился к каменной лачуге и перед тем, как войти, снова внимательно оглядел небо из-под ладони.
   - Все ждешь и ждешь, и смотришь, - пробормотал он, - и, может быть,', 500);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1341, '2025-08-24 23:06:22.571376+03', 6, NULL, 'однажды ночью… В небе горел красный огонек. Он шагнул в сторону, чтобы не мешал свет из двери.
   - Смотришьеще раз… -прошептал он.
   Красный огонек горел в том же месте.
   - Вчера вечером его не было, - прошептал он. Споткнулся, упал, поднялся на ноги, побежал за лачугу, развернул телескоп и навел его на небо.
   Через минуту - после долгого исступленного взгляда на небо - он появился в низкой двери своего дома. Жена, обе дочери и сын повернулись к нему. Он не сразу смог заговорить.
   - У меня добрые новости, - сказал он. - Я смотрел на небо. Сюда летит ракета, она заберет нас всех домой. Рано утром будет здесь.
   Он положил руки на стол, опустил голову на ладони и тихо заплакал.', 501);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1342, '2025-08-24 23:06:22.571376+03', 6, NULL, 'В три часа утра он сжег все, что осталось от Нью-Нью-Йорка.
   Взял факел, пошел в этот город из пластика и стал трогать пламенем стены повсюду, где проходил. Город расцвел могучими вихрями света и жара. Он превратился в костер размером в квадратную милю - такой можно заметить из космоса. Этот маяк приведет ракету к мистеру Хетэуэю и его семье.
   Он вернулся в дом; сердце билось болезненно и часто.
   - Видите? - Он держал в поднятой руке запыленную бутылку. - Я приберег вино специально для этой ночи. Я знал, что придет срок и кто-нибудь найдет нас! Выпьем же и порадуемся!
   Он наполнил пять бокалов.
   - Да, немало времени прошло… - заговорил он опять,', 502);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1343, '2025-08-24 23:06:22.571376+03', 6, NULL, 'сосредоточенно глядя в свой бокал. - Помните день, когда разразилась война? Двадцать лет и семь месяцев назад. Все ракеты вызвали с Марса домой. А ты, я и дети - мы были в это время в горах, занимались археологией, изучали древнюю хирургию марсиан. Помнишь, как мы чуть до смерти не загнали наших коней? И все равно опоздали на целую неделю. Город был уже покинут. Америка была разрушена, и все до одной ракеты ушли, не дожидаясь отставших, - помнишь, помнишь? А потом оказалось, что отстали-тотолько мы,помнишь? Боже мой, сколько лет минуло. Без вас я бы не выдержал. Без вас я бы покончил с собой. С вами ожидание было не таким тяжким. Выпьем же за нас. - Он поднял бокал.', 503);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1344, '2025-08-24 23:06:22.571376+03', 6, NULL, '- И за наше долгое совместное ожидание.
   Он выпил вино.
   Жена, обе дочери и сын поднесли к губам свои бокалы. И у всех четверых вино побежало струйками по подбородкам.

   К рассвету все, что осталось от города, ветер разметал по морскому дну большими мягкими черными хлопьями. Пожар унялся, но цель была достигнута: красное пятнышко нанебе стало расти.
   Из каменной лачуги струился вкусный запах поджаристого имбирного пряника. Когда Хетэуэй вошел, его жена ставила на стол горячие противни со свежим хлебом. Дочери прилежно мели голый каменный пол жесткими вениками, а сын чистил столовое серебро.
   - Мы приготовим им роскошный завтрак. - Хетэуэй радостно рассмеялся.', 504);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1345, '2025-08-24 23:06:22.571376+03', 6, NULL, '- Надевайте свои лучшие наряды!
   Он торопливо прошел через свой участок к огромному металлическому сараю. Здесь стояли холодильная установка и небольшая электростанция, которые он за эти годы починил и наладил своими искусными, тонкими, нервными пальцами так же умело, как чинил часы, телефоны, магнитофоны в часы своего досуга. В сарае скопилось множество созданных им вещей, в том числе и совершенно непонятных механизмов, назначение которых он теперь сам не мог разгадать.
   Он извлек из морозильника седые от инея коробки с бобами и клубникой двадцатилетней давности. «Вылезай, несчастный», - и достал холодного цыпленка.
   Когда ракета села,', 505);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1346, '2025-08-24 23:06:22.571376+03', 6, NULL, 'воздух был напоен всяческими кулинарными ароматами.
   Словно мальчишка, Хетэуэй побежал вниз по склону. Внезапная острая боль в груди заставила его остановиться. Он посидел на камне, отдышался и побежал дальше, уже безпередышки.
   Он остановился в жарком мареве, источаемом раскаленной ракетой. Открылся люк. Оттуда выглянул человек.
   Хетэуэй долго смотрел из-под ладони, наконец сказал:
   - Капитан Уайлдер!
   - Кто это? - спросил капитан Уайлдер. Он спрыгнул вниз и замер, глядя на старика. Потом протянул руку. - Господи, да это же Хетэуэй!
   - Совершенно верно, это я.
   - Хетэуэй из моего первого экипажа, из Четвертой экспедиции.
   Они внимательно оглядели друг друга.', 506);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1347, '2025-08-24 23:06:22.571376+03', 6, NULL, '- Давненько мы расстались, капитан.
   - Очень давно. Я рад вас видеть.
   - Я постарел, - сказал Хетэуэй без обиняков.
   - Я и сам уже не молод. Двадцать лет мотался: Юпитер, Сатурн, Нептун.
   - Как же, слыхал я, вас повысили, так сказать, чтобы вы не мешали колонизации Марса. - Старик огляделся. - Вы столько путешествовали, наверно, не знаете даже, что произошло…
   - Догадываюсь, - ответил Уайлдер. - Мы дважды обошли вокруг Марса. Кроме вас, нашли еще только одного человека по имени Уолтер Грипп, в десяти тысячах милях отсюда. Хотели захватить его с собой, но он отказался. Когда мы улетали, он сидел на качалке посреди шоссе, курил трубку и махал нам вслед. Марс вымер, начисто вымер,', 507);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1348, '2025-08-24 23:06:22.571376+03', 6, NULL, 'даже марсиан не осталось. А как Земля?
   - Я знаю не больше вас. Изредка удается поймать земное радио, еле-еле слышно. Но всякий раз на каком-нибудь чужом языке. А я из иностранных языков знаю, увы, один латинский. Отдельные слова удается разобрать. Судя по всему, на большей части Земли все перебиты, а война все идет. Вы летите туда, командир?
   - Да. Сами понимаете, хочется своими глазами убедиться. У нас ведь не было радиосвязи, слишком большое расстояние. Что бы там ни было, мы летим на Землю.
   - Вы возьмете нас с собой?
   Капитан на миг опешил.
   - Ах, да, разумеется, у вас тут жена, помню, помню. Мы виделись, кажется, двадцать пять лет назад, верно? Когда построили Первый Город,', 508);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1349, '2025-08-24 23:06:22.571376+03', 6, NULL, 'вы оставили службу и забрали ее с Земли. У вас были и дети…
   - Сын, две дочери…
   - Да-да, припоминаю. Они здесь?
   - В нашей лачуге, вон там на горке. Мы приготовили вам всем отличный завтрак. Придете?
   - Сочтем за честь, мистер Хетэуэй. - Капитан Уайлдер повернулся к ракете. - Оставить корабль!

   Они шли вверх по откосу - Хетэуэй и капитан Уайлдер, за ними еще двадцать человек, экипаж корабля, глубоко вдыхая прохладный разреженный утренний воздух. Показалось солнце, день выдался ясный.
   - Помните Спендера, капитан?
   - Никогда не забывал…
   - Раз в год мне случается проходить мимо его могилы. А ведь в конечном счете вышло вроде, как он хотел. Он был против того,', 509);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1350, '2025-08-24 23:06:22.571376+03', 6, NULL, 'чтобы мы здесь селились. Теперь, наверно, счастлив, что все отсюда убрались.
   - А этот… как его? Паркхилл, Сэм Паркхилл, что с ним стало?
   - Открыл сосисочную.
   - Похожена него.
   - А через неделю - война, и он вернулся на Землю. - Хетэуэй вдруг сел на камень, схватившись за сердце. - Простите. Переволновался. После стольких лет - и вдруг встреча свами. Отдохну немного.
   Он чувствовал, как колотится сердце. Проверил пульс. Скверно…
   - У нас есть врач, - сказал Уайлдер. - Не обижайтесь, Хетэуэй, я знаю, вы сами врач, но все-таки посоветуемся с нашим…
   Позвали доктора.
   - Сейчас пройдет, - твердил Хетэуэй. - Это все ожидание, волнение.
   Он задыхался. Губы посинели.', 510);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1351, '2025-08-24 23:06:22.571376+03', 6, NULL, '- Понимаете, - сказал он, когда врач приставил к его груди стетоскоп, - ведь я все эти годы жил как будто ради сегодняшнего дня. А теперь, когда вы здесь, прилетели забрать меня на Землю, мне вроде ничего больше не надо, и я могу лечь и отдать концы.
   - Вот. - Доктор подал ему желтую таблетку. - Вам бы лучше тут отдохнуть подольше.
   - Ерунда. Еще чуточку посижу, и все. До чего я рад видеть вас всех. Рад слышать новые голоса.
   - Таблетка действует?
   - Отлично. Пошли!
   Они поднялись на горку.
   - Алиса, погляди, кого я привел! - Хетэуэй нахмурился и просунул голову в дверь. - Алиса, ты слышишь?
   Появилась его жена. Следом вышли обе дочери, высокие, стройные,', 511);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1352, '2025-08-24 23:06:22.571376+03', 6, NULL, 'за ними еще более рослый сын.
   - Алиса, помнишь капитана Уайлдера?
   Она замялась, посмотрела на Хетэуэя, точно ожидая указаний, потом улыбнулась.
   - Ну, конечно, капитан Уайлдер!
   - Помнится, миссис Хетэуэй, мы вместе с вами обедали накануне моего вылета на Юпитер.
   Она горячо пожала его руку.
   - Мои дочери, Маргарет и Сьюзен. Мой сын Джон. Дети, вы, конечно, помните капитана?
   Рукопожатия, смех, оживленная речь.
   Капитан Уайлдер потянул носом.
   - Неужелиимбирные пряники?
   - Хотите?
   Все пришли в движение. Мигом были установлены складные столы, извлечены из печей горячие блюда, появились тарелки, столовое серебро, камчатные салфетки.', 512);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1353, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Капитан Уайлдер долго глядел на миссис Хетэуэй, потом перевел взгляд на ее сына и бесшумно двигающихся высоких дочерей. Рассматривал мелькающие лица, ловил каждое движение молодых рук, каждое выражение гладких, без единой морщинки лиц. Он сел на стул, который принес сын миссис Хетэуэй.
   - Сколько вам лет, Джон?
   - Двадцать три, - ответил тот.
   Уайлдер растерянно вертел в руках вилку и нож. Он вдруг побледнел. Сидевший рядом космонавт шепнул ему:
   - Капитан Уайлдер, тут что-то не так.
   Сын пошел за стульями.
   - Что вы хотите сказать, Уильямсон?
   - Мне сорок три года, капитан. Двадцать лет назад я учился вместе с молодым Хетэуэем. Он говорит, что ему теперь всего двадцать три,', 513);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1354, '2025-08-24 23:06:22.571376+03', 6, NULL, 'но это одна видимость. Это все неправильно. Ему должно быть сорок два, самое малое. Что все это значит, сэр?
   - Не знаю.
   - На вас лица нет, сэр.
   - Мне нездоровится. И дочери тоже - я их видел лет двадцать назад, а они не изменились, ни одной морщинки. Можно попросить вас об одолжении, Уильямсон? Я хочу дать вам одно поручение. Объясню, куда пойти и что проверить. К концу завтрака незаметно скройтесь. Вам всего десять минут понадобится. Это недалеко отсюда. Я видел с ракеты, когда мы садились.
   - Прошу! О чем это вы так серьезно разговариваете? - Миссис Хетэуэй проворно налила супу в их миски. - Улыбнитесь же! Мы все вместе опять, путешествие завершено, вы почти дома!
   - Да-да,', 514);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1355, '2025-08-24 23:06:22.571376+03', 6, NULL, 'конечно. - Капитан Уайлдер засмеялся. Вы так чудесно, молодо выглядите, миссис Хетэуэй!
   - Ах, эти мужчины!
   Он смотрел, как она плавной походкой двинулась дальше, внимательно смотрел на ее разрумянившееся лицо, гладкое и свежее, точно наливное яблоко. Она звонко смеяласьшуткам, усердно подкладывала салат на тарелки, не давая себе передышки. Долговязый сын и стройные дочери состязались с отцом в блестящем остроумии, рассказывая про долгие годы своей уединенной жизни, и гордый отец кивал, слушая речь детей.
   Уильямсон сбежал вниз по склону.
   - Куда это он? - спросил Хетэуэй.
   - Проверить ракету, - ответил Уайлдер. - Так вот, Хетэуэй, на Юпитере ничего нет,', 515);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1356, '2025-08-24 23:06:22.571376+03', 6, NULL, 'человеку там делать нечего. На Сатурне и Плутоне - тоже…
   Уайлдер говорил машинально, не слушая собственного голоса; он думал только об одном: сейчас Уильямсон бежит вниз, скоро он вернется, поднимется на горку и принесет ответ…
   - Спасибо.
   Маргарет Хетэуэй налила ему воды в стакан. Движимый внезапным побуждением, капитан коснулся ее плеча. Она отнеслась к этому совершенно спокойно. У нее было теплое, нежное тело.
   Сидевший против капитана Хетэуэй то и дело замолкал и с искаженным болью лицом касался пальцами груди, затем вновь продолжал слушать негромкий разговор и случайные звонкие возгласы, поминутно бросая озабоченные взгляды на Уайлдера,', 516);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1357, '2025-08-24 23:06:22.571376+03', 6, NULL, 'который жевал свой пряник без видимого удовольствия.
   Вернулся Уильямсон. Он молча ковырял вилкой еду, пока капитан не шепнул через плечо:
   - Ну?
   - Я нашел это место, сэр.
   - Ну, ну?
   Уильямсон был бледен, как полотно. Он не сводил глаз с веселой компании. Дочери сдержанно улыбались, сын рассказывал какой-то анекдот.
   Уильямсон сказал:
   - Я прошел на кладбище.
   - Видели четыре креста?
   - Видел четыре креста, сэр. И имена сохранились. Я записал их, чтобы не ошибиться. - Он стал читать по белой бумажке: - Алиса, Маргарет, Сьюзен и Джон Хетэуэй. Умерли от неизвестного вируса. Июль 2007 года.
   - Спасибо, Уильямсон. - Уайлдер закрыл глаза.
   - Девятнадцать лет назад, сэр.', 517);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1358, '2025-08-24 23:06:22.571376+03', 6, NULL, '- Рука Уильямсона дрожала.
   - Да.
   - Но кто жеэти?
   - Не знаю.
   - Что вы собираетесь предпринять?
   - Тоже не знаю.
   - Расскажем остальным?
   - Попозже. Продолжайте есть, как ни в чем не бывало.
   - Мне что-то больше не хочется, сэр.
   Завтрак завершало вино, принесенное с ракеты. Хетэуэй встал.
   - За ваше здоровье. Я так рад снова быть вместе с друзьями. И еще за мою жену и детей - без них, в одиночестве, я бы не выжил здесь. Только благодаря их добрым заботам я находил в себе силы жить и ждать вашего прилета.
   Он повернулся, держа бокал, в сторону своих домочадцев; они ответили ему смущенными взглядами, а когда все стали пить, и совсем опустили глаза.', 518);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1359, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Хетэуэй выпил до дна. Не успев даже крикнуть, он упал ничком на стол и сполз на землю. Несколько человек подбежали и положили его поудобнее. Врач наклонился, послушал сердце. Уайлдер тронул врача за плечо. Тот поднял на него взгляд и покачал головой. Уайлдер опустился на колени и взял руку старика.
   - Уайлдер? - голос у Хетэуэя был едва слышен. - Я испортил вам завтрак.
   - Чепуха.
   - Попрощайтесь за меня с Алисой и детьми.
   - Сейчас я их позову.
   - Нет-нет, не надо! - задыхаясь, прошептал Хетэуэй. - Они не поймут. И я не хочу, чтобы они понимали! Не надо!
   Уайлдер повиновался.
   Хетэуэй умер.
   Уайлдер долго не отходил от него.', 519);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1360, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Наконец поднялся и пошел прочь от потрясенных людей, окруживших Хетэуэя. Он подошел к Алисе Хетэуэй, глянул ей в лицо и сказал:
   - Вы знаете, что случилось?
   - Что-нибудь с моим мужем?
   - Он только что скончался: сердце. - Уайлдер следил за выражением ее лица.
   - Очень жаль, - сказала она.
   - Вам не больно? - спросил он.
   - Он не хотел, чтобы мы огорчались. Он предупредил нас, что это когда-нибудь произойдет, и велел нам не плакать. Знаете, он даже не научил нас плакать, не хотел, чтобы мы умели. Говорил, что хуже всего для человека познать одиночество, познать тоску и плакать. Поэтому мы не должны знать, что такое слезы и печаль.
   Уайлдер поглядел на ее руки, мягкие,', 520);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1361, '2025-08-24 23:06:22.571376+03', 6, NULL, 'теплые руки, на красивые наманикюренные ногти, тонкие запястья. Посмотрел на ее длинную, нежную белую шею и умные глаза. Наконецсказал:
   - Мистер Хетэуэй великолепно сделал вас и детей.
   - Ваши слова обрадовали бы его. Он очень гордился нами. А потом даже забыл, что сам нас сделал. Полюбил нас, принимал за настоящих жену и детей. В известном смысле так оно и есть
   - С вами ему было легче.
   - Да, из года в год мы все сидели и разговаривали. Он любил разговаривать. Любил нашу каменную лачугу и камин. Можно было поселиться в настоящем доме в городе, но ему больше нравилось здесь, где он мог по своему выбору жить то примитивно, то на современный лад.', 521);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1362, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Он рассказывал мне про свою лабораторию и про всякие вещи, что он там делал. Весь этот заброшенный американский город внизу он оплел громкоговорителями. Нажмет кнопку - всюду загораются огни и город начинает шуметь, точно в нем десять тысяч людей. Слышится гул самолетов, автомашин, людской говор. Он, бывало, сидит, курит сигару и разговаривает с нами, а снизу доносится шум города. Иногда звонит телефон, и записанный на пленку голос спрашивает у мистера Хетэуэя совета по разным научным и хирургическим вопросам, и он отвечает. Телефонные звонки, и мы тут, и городской шум, и сигара - и мистер Хетэуэй был вполне счастлив. Только одного он не сумел сделать - чтобы мы старились.', 522);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1363, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Сам старился с каждым днем, а мы оставались все такими же. Но мне кажется, это его не очень-то беспокоило. Полагаю даже, он сам того хотел.
   - Мы похороним его внизу, на кладбище, где стоят четыре креста. Думаю, это отвечает его желанию.
   Она легко коснулась рукой его запястья.
   - Я уверена в этом.
   Капитан распорядился. Маленькая процессия тронулась к подножию холма; семья следовала за ней. Двое несли Хетэуэя на накрытых носилках. Они прошли мимо каменной лачуги, потом мимо сарая, где Хетэуэй много лет назад начал свою работу. Уайлдер помешкал возле двери этой мастерской.
   Каково это, спрашивал он себя, жить на планете с женой и тремя детьми - и вдруг они умирают,', 523);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1364, '2025-08-24 23:06:22.571376+03', 6, NULL, 'оставляя тебя наедине с ветром и безмолвием? Как поступит в таком положении человек? Он похоронит умерших на кладбище, поставит кресты, потом придет в мастерскую и, призвав на помощь силу ума и памяти, сноровку рук и изобретательность, соберет, частица за частицей, то, что стало затем его женой, сыном, дочерьми. Когда под горой есть американский город, где можно найти все необходимое, незаурядный человек, пожалуй, может создать все что угодно.
   Звук их шагов потонул в песке. На кладбище, когда они пришли, два человека уже копали могилу.

   Они вернулись к ракете под вечер.
   Уильямсон кивком указал на каменную лачугу.
   - Что будем делать сними?
   - Не знаю, - сказал капитан.', 524);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1365, '2025-08-24 23:06:22.571376+03', 6, NULL, '- Может, вы их выключите?
   - Выключить? - Капитан несколько удивился. - Мне это не приходило в голову.
   - Но вы же не повезете их с собой?
   - Нет, это ни к чему.
   - Неужели вы хотите оставить их здесь, вот таких, какие они есть?
   Капитан протянул Уильямсону пистолет.
   - Если вы можете что-нибудь сделать, вы сильнее меня.
   Пять минут спустя Уильямсон вернулся от лачуги, весь в испарине.
   - Вот, возьмите свой пистолет. Теперь я вас понимаю. Я вошел к ним с пистолетом в руке. Одна из дочерей улыбнулась мне. И остальные. Жена предложила мне чашку чаю. Божемой, это было бы просто убийство!
   Уайлдер кивнул.
   - Такого совершенства человек больше никогда не создаст.', 525);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1366, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Они созданы для долголетия - десять, пятьдесят, двести лет. Так-то… У них ничуть не меньше прав на… на жизнь, чем у вас, меня, любого из нас. - Он выбил пепел из трубки. - Ладно, поднимайтесь на борт. Полетим дальше. Этот город все равно погиб, нам он не годится.
   День угасал. Подул холодный ветер. Весь экипаж уже был на борту. Капитан медлил. Уильямсон спросил:
   - Уж не собираетесь ли вы сходить э-э… попрощаться с ними?
   Капитан холодно посмотрел на Уильямсона.
   - Не ваше дело.
   Уайлдер зашагал в гору навстречу сумрачному ветру. Космонавты увидели, как его силуэт замер в дверях лачуги. Они увидели силуэт женщины. Они увидели, как их командир пожал ей руку.', 526);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1367, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Спустя минуту он бегом вернулся к ракете.

   По ночам, когда ветер свистит над ложем мертвого моря, над шестигранниками на кладбище, над четырьмя старыми крестами и одним новым, по ночам в низкой каменной лачуге горит свет; ревет ветер, вихрится пыль, сверкают холодные звезды, а в той лачуге четыре фигуры - женщина, две дочери и сын - не дают погаснуть огню в камине, сами не зная зачем, и разговаривают, и смеются.
   Из года в год, из года в год, каждую ночь, сама не зная зачем, женщина выходит из лачуги и, вскинув руки, долго смотрит на небо, на зеленое пламя Земли, не понимая, зачем она это делает; потом возвращается в дом и подкидывает щепку в огонь, а ветер крепчает,', 527);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1368, '2025-08-24 23:06:22.571376+03', 6, NULL, 'и мертвое море продолжает оставаться мертвым.
   Август 2026

   Будет ласковый дождь
   В гостиной говорящие часы настойчиво пели:тик-так, семь часов, семь утра, вставать пора! -словно боясь, что их никто не послушает. Объятый утренней тишиной дом был пуст. Часы продолжали тикать и твердили, твердили свое в пустоту:девять минут восьмого, к завтраку все готово, девять минут восьмого!
   На кухне печь сипло вздохнула и исторгла из своего жаркого чрева восемь безупречно поджаренных тостов, четыре глазуньи, шестнадцать ломтиков бекона, две чашки кофе и два стакана холодного молока.
   - Сегодня в городе Эллендейле, штат Калифорния, четвертое августа две тысячи двадцать шестого года,', 528);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1369, '2025-08-24 23:06:22.571376+03', 6, NULL, '- произнес другой голос, с потолка кухни. Он повторил число трижды, чтобы получше запомнили. - Сегодня день рождения мистера Фезерстоуна. Годовщина свадьбы Тилиты. Подошел срок страхового взноса, пора платить за воду, газ, свет.
   Где то в стенах щелкали реле, перед электрическими глазами скользили ленты памятки.
   Восемь одна, тик-так, восемь одна, в школу пора, на работу пора, живо, живо, восемь одна!Но не хлопали двери, и не слышалось мягкой поступи резиновых каблуков по коврам.
   На улице шел дождь. Метеокоробка на наружной двери тихо пела: «Дождик, дождик целый день, плащ, галоши ты надень…» Дождь гулко барабанил по крыше пустого дома.
   Во дворе зазвонил гараж, поднимая дверь,', 529);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1370, '2025-08-24 23:06:22.571376+03', 6, NULL, 'за которой стояла готовая к выезду автомашина… Минута, другая - дверь опустилась на место.
   В восемь тридцать яичница сморщилась, а тосты стали каменными. Алюминиевая лопаточка сбросила их в раковину, оттуда струя горячей воды увлекла их в металлическую горловину, которая все растворяла и отправляла через канализацию в далекое море. Грязные тарелки нырнули в горячую мойку и вынырнули из нее, сверкая сухим блеском.
   Девять пятнадцать, -пропели часы, -пора уборкой заняться.
   Из нор в стене высыпали крохотные роботы-мыши. Во всех помещениях кишели маленькие суетливые уборщики из металла и резины Они стукались о кресла, вертели своими щетинистыми роликами, ерошили ковровый ворс,', 530);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1371, '2025-08-24 23:06:22.571376+03', 6, NULL, 'тихо высасывая скрытые пылинки. Затем исчезли, словно неведомые пришельцы, юркнули в свои убежища Их розовые электрические глазки потухли. Дом был чист.
   Десять часов.Выглянуло солнце, тесня завесу дождя. Дом стоял одиноко среди развалин и пепла. Во всем городе он один уцелел. Ночами разрушенный город излучал радиоактивное сияние, видное на много миль вокруг.
   Десять пятнадцать.Распылители в саду извергли золотистые фонтаны, наполнив ласковый утренний воздух волнами сверкающих водяных бусинок. Вода струилась по оконным стеклам, стекала по обугленной западной стене, на которой белая краска начисто выгорела. Вся западная стена была черной, кроме пяти небольших клочков.', 531);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1372, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Вот краска обозначила фигуру мужчины, катящего травяную косилку. А вот, точно на фотографии, женщина нагнулась за цветком. Дальше - еще силуэты, выжженные на дереве в одно титаническое мгновение…Мальчишка вскинул вверх руки, над ним застыл контур подброшенного мяча, напротив мальчишки - девочка, ее руки подняты, ловят мяч, который так и не опустился.
   Только пять пятен краски - мужчина, женщина, дети, мяч. Все остальное - тонкий слой древесного угля.
   Тихий дождь из распылителя наполнил сад падающими искрами света…
   Как надежно оберегал дом свой покой вплоть до этого дня! Как бдительно он спрашивал: «Кто там? Пароль?» И,', 532);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1373, '2025-08-24 23:06:22.571376+03', 6, NULL, 'не получая нужного ответа от одиноких лис и жалобно мяукающих котов, затворял окна и опускал шторы с одержимостью старой девы. Самосохранение, граничащее с психозом, - если у механизмов может быть паранойя.
   Этот дом вздрагивал от каждого звука. Стоило воробью задеть окно крылом, как тотчас громко щелкала штора и перепуганная птица летела прочь. Никто - даже воробей - несмел прикасаться к дому!
   Дом был алтарем с десятью тысячами священнослужителей и прислужников, больших и маленьких, они служили и прислуживали, и хором пели славу. Но боги исчезли, и ритуалпродолжался без смысла и без толку.
   Двенадцать.
   У парадного крыльца заскулил продрогнувший пес.', 533);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1374, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Дверь сразу узнала собачий голос и отворилась. Пес, некогда здоровенный, сытый, а теперь кожа да кости, весь в парше, вбежал в дом, печатая грязные следы. За ним суетились сердитые мыши - сердитые, что их потревожили, что надо снова убирать!
   Ведь стоило малейшей пылинке проникнуть внутрь сквозь щель под дверью, как стенные панели мигом приподнимались, и оттуда выскакивали металлические уборщики. Дерзновенный клочок бумаги, пылинка или волосок исчезали в стенах, пойманные крохотными стальными челюстями. Оттуда по трубам мусор спускался в подвал, в гудящее чрево мусоросжигателя, который злобным Ваалом притаился в темном углу.
   Пес побежал наверх, истерически лая перед каждой дверью,', 534);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1375, '2025-08-24 23:06:22.571376+03', 6, NULL, 'пока не понял - как это уже давно понял дом, - что никого нет, есть только мертвая тишина.
   Он принюхался и поскреб кухонную дверь, потом лег возле нее, продолжая нюхать. Там, за дверью, плита пекла блины, от которых по всему дому шел сытный дух и заманчивыйзапах кленовой патоки.
   Собачья пасть наполнилась пеной, в глазах вспыхнуло пламя. Пес вскочил, заметался, кусая себя за хвост, бешено завертелся и сдох. Почти час пролежал он в гостиной.
   Два часа, -пропел голос.
   Учуяв наконец едва приметный запах разложения, из нор с жужжанием выпорхнули полчища мышей, легко и стремительно, словно сухие листья, гонимые электрическим веером.
   Два пятнадцать.
   Пес исчез.', 535);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1376, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Мусорная печь в подвале внезапно засветилась пламенем, и через дымоход вихрем промчался сноп искр.
   Два тридцать пять.
   Из стен внутреннего дворика выскочили карточные столы. Игральные карты, мелькая очками, разлетелись по местам. На дубовом прилавке появились коктейли и сэндвичи сяйцом. Заиграла музыка.
   Но столы хранили молчание, и никто не брал карт.
   В четыре часа столы сложились, словно огромные бабочки, и вновь ушли в стены.

   Половина пятого.
   Стены детской комнаты засветились.
   На них возникли животные: желтые жирафы, голубые львы, розовые антилопы, лиловые пантеры прыгали в хрустальной толще. Стены были стеклянные, восприимчивые к краскам и игре воображения.', 536);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1377, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Скрытые киноленты заскользили по зубцам с бобины на бобину, и стены ожили. Пол детской колыхался, напоминая волнуемое ветром поле, и по нему бегали алюминиевые тараканы и железные сверчки, а в жарком неподвижном воздухе, в остром запахе звериных следов, порхали бабочки из тончайшей розовой ткани! Слышался звук, как от огромного, копошащегося в черной пустоте кузнечных мехов роя пчел: ленивое урчание сытого льва. Слышался цокот копыт окапи и шум освежающего лесного дождя, шуршащего по хрупким стеблям жухлой травы. Вот стены растаяли, растворились в необозримых просторах опаленных солнцем лугов и бездонного жаркого неба. Животныерассеялись по колючим зарослям и водоемам.', 537);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1378, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Время детской передачи.
   Пять часов.Ванна наполнилась прозрачной горячей водой.
   Шесть, семь, восемь часов.Блюда с обедом проделали удивительные фокусы, потом что-то щелкнуло в кабинете, и на металлическом штативе возле камина, в котором разгорелось уютное пламя, вдруг возникла курящаяся сигара с шапочкой мягкого серого пепла.
   Девять часов.Невидимые провода согрели простыни - здесь было холодно по ночам.
   Девять ноль пять.В кабинете с потолка донесся голос:
   - Миссис Маклеллан, какое стихотворение хотели бы вы услышать сегодня?
   Дом молчал.
   Наконец голос сказал:
   - Поскольку вы не выразили никакого желания, я выберу что-нибудь наудачу.', 538);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1379, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Зазвучал тихий музыкальный аккомпанемент.
   - Сара Тисдейл. Ваше любимое, если не ошибаюсь…Будет ласковый дождь, будет запах земли.Щебет юрких стрижей от зари до зари,И ночные рулады лягушек в прудах.И цветение слив в белопенных садах;Огнегрудый комочек слетит на забор,И малиновки трель выткет звонкий узор.И никто, и никто не вспомянет войну.Пережито-забыто, ворошить ни к чему.И ни птица, ни ива слезы не прольет,Если сгинет с Земли человеческий род.И весна… и Весна встретит новый рассвет,Не заметив, что нас уже нет.
   В камине трепетало, угасая, пламя, сигара осыпалась кучкой немого пепла. Между безмолвных стен стояли одно против другого пустые кресла, играла музыка.', 539);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1380, '2025-08-24 23:06:22.571376+03', 6, NULL, 'В десять часов наступила агония.
   Подул ветер. Сломанный сук, падая с дерева, высадил кухонное окно. Бутылка пятновыводителя разбилась вдребезги о плиту. Миг - и вся кухня охвачена огнем!
   - Пожар! - послышался крик. Лампы замигали, с потолков, нагнетаемые насосами, хлынули струи воды. Но горючая жидкость растекалась по линолеуму, она просочилась, нырнула под дверь и уже целый хор подхватил:
   - Пожар! Пожар! Пожар!
   Дом старался выстоять. Двери плотно затворились, но оконные стекла полопались от жара, и ветер раздувал огонь.
   Под натиском огня, десятков миллиардов сердитых искр, которые с яростной бесцеремонностью летели из комнаты в комнату и неслись вверх по лестнице,', 540);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1381, '2025-08-24 23:06:22.571376+03', 6, NULL, 'дом начал отступать.
   Еще из стен, семеня, выбегали суетливые водяные крысы, выпаливали струи воды и возвращались за новым запасом. И стенные распылители извергали каскады механического дождя. Поздно. Где-то с тяжелым вздохом, передернув плечами, замер насос. Прекратился дождь-огнеборец. Иссякла вода в запасном баке, который много- много дней питал ванны и посудомойки.
   Огонь потрескивал, пожирая ступеньку за ступенькой. В верхних комнатах он, словно гурман, смаковал картины Пикассо и Матисса, слизывая маслянистую корочку и бережно скручивая холсты черной стружкой.
   Он добрался до кроватей, вот уже скачет по подоконникам, перекрашивает портьеры!
   Но тут появилось подкрепление.', 541);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1382, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Из чердачных люков вниз уставились незрячие лица роботов, изрыгая ртами- форсунками зеленые химикалии.
   Огонь попятился: даже слон пятится при виде мертвой змеи. А тут по полу хлестало двадцать змей, умерщвляя огонь холодным чистым ядом зеленой пены.
   Но огонь был хитер, он послал языки пламени по наружной стене вверх, на чердак, где стояли насосы. Взрыв! Электронный мозг, управлявший насосами, бронзовой шрапнелью вонзился в балки.
   Потом огонь метнулся назад и обошел все чуланы, щупая висящую там одежду.
   Дом содрогнулся, стуча дубовыми костями, его оголенный скелет корчился от жара, сеть проводов - его нервы - обнажилась, словно некий хирург содрал с него кожу,', 542);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1383, '2025-08-24 23:06:22.571376+03', 6, NULL, 'чтобы красные вены и капилляры трепетали в раскаленном воздухе. Караул, караул! Пожар! Бегите, спасайтесь! Огонь крошил зеркала, как хрупкий зимний лед. А голоса причитали:«Пожар, пожар, бегите, спасайтесь!»Словно печальная детская песенка, которую в двенадцать голосов, кто громче, кто тише, пели умирающие дети, брошенные в глухом лесу. Но голоса умолкали один за другим по мере того, как лопалась, подобно жареным каштанам, изоляция на проводах. Два, три, четыре, пять голосов заглохли.
   В детской комнате пламя объяло джунгли. Рычали голубые львы, скакали пурпурные жирафы. Пантеры метались по кругу, поминутно меняя окраску; десять миллионов животных, спасаясь от огня,', 543);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1384, '2025-08-24 23:06:22.571376+03', 6, NULL, 'бежали к кипящей реке вдали…
   Еще десять голосов умерли. В последний миг сквозь гул огневой лавины можно было различить хор других, сбитых с толку голосов, еще объявлялось время, играла музыка, метались по газону телеуправляемые косилки, обезумевший зонт прыгал взад-вперед через порог наружной двери, которая непрерывно то затворялась, то отворялась, - одновременно происходила тысяча вещей, как в часовой мастерской, когда множество часов вразнобой лихорадочно отбивают время: то был безумный хаос, спаянный в некое единство; песни, крики, и последние мыши-мусорщики храбро выскакивали из нор - расчистить, убрать этот ужасный, отвратительный пепел!', 544);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1385, '2025-08-24 23:06:22.571376+03', 6, NULL, 'А один голос с полнейшим пренебрежением к происходящему декламировал стихи в пылающем кабинете, пока не сгорели все пленки, не расплавились провода, не рассыпались все схемы.
   И наконец, пламя взорвало дом, и он рухнул пластом, разметав каскады дыма и искр.
   На кухне, за мгновение до того, как посыпались головни и горящие балки, плита с сумасшедшей скоростью готовила завтраки: десять десятков яиц, шесть батонов тостов, двести ломтей бекона - и все, все пожирал огонь, понуждая задыхающуюся печь истерически стряпать еще и еще!
   Грохот. Чердак провалился в кухню и в гостиную, гостиная - в цокольный этаж, цокольный этаж - в подвал. Холодильники, кресла, ролики с фильмами, кровати,', 545);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1386, '2025-08-24 23:06:22.571376+03', 6, NULL, 'электрические приборы - все рухнуло вниз обугленными скелетами.
   Дым и тишина. Огромные клубы дыма.
   На востоке медленно занимался рассвет. Только одна стена осталась стоять среди развалин. Из этой стены говорил последний одинокий голос, солнце уже осветило дымящиеся обломки, а он все твердил:
   - Сегодня 5 августа 2026 года, сегодня 5 августа 2026 года, сегодня…
   Октябрь 2026

   Каникулы на Марсе
   Эту мысль почему-то высказала мама - а не отправиться ли всей семьей на рыбалку? На самом деле слова были не мамины, Тимоти отлично это знал. Слова были папины, но почему-то их за него сказала мама.
   Папа, переминаясь с ноги на ногу на шуршащей марсианской гальке, согласился.', 546);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1387, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Тотчас поднялся шум и гам, в мгновение ока лагерь был свернут, все уложено в капсулы и контейнеры, мама надела дорожный комбинезон и куртку, отец, не отрывая глаз от марсианского неба, набил трубку дрожащими руками, и трое мальчиков с радостными воплями кинулись к моторной лодке - из всех троих один Тимоти все время посматривал на папу и маму.
   Отец нажал кнопку. К небу взмыл гудящий звук. Вода за кормой ринулась назад, а лодка помчалась вперед, под дружные крики «ура!».
   Тимоти сидел на корме вместе с отцом, положив свои тонкие пальцы на его волосатую руку. Вот за изгибом канала скрылась изрытая площадка, где они сели на своей маленькой семейной ракете после долгого полета с Земли.', 547);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1388, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Ему вспомнилась ночь накануне вылета, спешка и суматоха, ракета, которую отец каким-то образом где-то раздобыл, разговоры о том, что они летят на Марс отдыхать. Далековато, конечно, для каникулярной поездки, но Тимоти промолчал, потому что тут были младшие братишки. Они благополучно добрались до Марса и вот с места в карьер отправились - во всяком случае, так было сказано - на рыбалку.
   Лодка неслась по каналу… Странные глаза у папы сегодня. Тимоти никак не мог понять, в чем дело. Они ярко светились, и в них было облегчение, что ли. И от этого глубокие морщины смеялись, а не хмурились и не скорбели.
   Новый поворот канала - и вот уже скрылась из глаз остывшая ракета.', 548);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1389, '2025-08-24 23:06:22.571376+03', 6, NULL, '- А мы далеко едем?
   Роберт шлепал рукой по воде - будто маленький краб прыгал по фиолетовой глади.
   Отец вздохнул:
   - За миллион лет.
   - Ух ты! - удивился Роберт.
   - Поглядите, дети. - Мама подняла длинную гибкую руку. - Мертвый город.
   Завороженные, они уставились на вымерший город, а он безжизненно простерся на берегу для них одних и дремал в жарком безмолвии лета, дарованном Марсу искусством марсианских метеорологов.
   У папы было такое лицо, словно он радовался тому, что город мертв.
   Город: хаотическое нагромождение розовых глыб, уснувших на песчаном косогоре, несколько поваленных колонн, заброшенное святилище, а дальше - опять песок, песок,', 549);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1390, '2025-08-24 23:06:22.571376+03', 6, NULL, 'миля за милей… Белая пустыня вокруг канала, голубая пустыня над ним.
   Внезапно с берега взлетела птица. Точно брошенный кем-то камень пронесся над голубым прудом, врезался в толщу воды и исчез.
   Папа даже изменился в лице от испуга.
   - Мне почудилось, что это ракета.
   Тимоти смотрел в пучину неба, пытаясь увидеть Землю, и войну, и разрушенные города, и людей, которые убивали друг друга, сколько он себя помнил. Но ничего не увидел. Война была такой же далекой и абстрактной, как две мухи, сражающиеся насмерть под сводами огромного безмолвного собора. И такой же нелепой.
   Уильям Томас отер пот со лба и взволнованно ощутил на своей руке прикосновение пальцев сына, легких,', 550);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1391, '2025-08-24 23:06:22.571376+03', 6, NULL, 'как паучьи лапки.
   Он улыбнулся сыну:
   - Ну, как оно, Тимми?
   - Отлично, папа.
   Тимоти никак не мог до конца разобраться, что происходит в этом огромном взрослом механизме рядом с ним. В этом человеке с большим, шелушащимся от загара орлиным носом, с ярко-голубыми глазами вроде каменных шариков, которыми он играл летом дома, на Земле, с длинными, могучими, как колонны, ногами в широких бриджах.
   - Что ты так высматриваешь, пап?
   - Я искал земную логику, здравый смысл, разумное правление, мир и ответственность.
   - И как - увидел?
   - Нет. Не нашел. Их больше нет на Земле. И, пожалуй, не будет никогда. Возможно, мы только сами себя обманывали, а их вообще и не было.', 551);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1392, '2025-08-24 23:06:22.571376+03', 6, NULL, '- Это как же?
   - Смотри, смотри, вон рыба, - показал отец.

   Трое мальчиков звонко вскрикнули, и лодка накренилась, так дружно они изогнули свои тонкие шейки, торопясь увидеть. Ух ты, вот это да! Мимо проплыла серебристая рыба-кольцо, извиваясь и мгновенно сжимаясь, точно зрачок, едва только внутрь попадали съедобные крупинки.
   - В точности как война, - глухо произнес отец. - Война плывет, видит пищу, сжимается. Миг - и Земли нет.
   - Уильям, - сказала мама.
   - Извини.
   Они примолкли, а мимо стремительно неслась студеная стеклянная вода канала. Ни звука кругом, только гул мотора, шелест воды, струи распаренного солнцем воздуха.
   - А когда мы увидим марсиан?', 552);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1393, '2025-08-24 23:06:22.571376+03', 6, NULL, '- воскликнул Майкл.
   - Скоро, - заверил его отец. - Может быть, вечером.
   - Но ведь марсиане все вымерли, - сказала мама.
   - Нет, не вымерли, - не сразу ответил папа. - Я покажу вам марсиан, точно.
   Тимоти нахмурился, но ничего не сказал. Все было как-то не так. И каникулы, и рыбалка, и эти взгляды, которыми обменивались взрослые.
   А его братья уже уставились из-под ладошек на двухметровую каменную стенку канала, высматривая марсиан.
   - Какие они? - допытывался Майкл.
   - Узнаешь, когда увидишь. - Отец вроде усмехнулся, и Тимоти приметил, как у него подергивается щека.
   Мама была хрупкая и нежная, золотая коса лежала тиарой на голове, а глаза были такого же цвета,', 553);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1394, '2025-08-24 23:06:22.571376+03', 6, NULL, 'как глубокая студеная вода канала в тени, почти пурпурные, с янтарными крапинками. Можно было видеть, как плавают мысли в ее глазах - словно рыбы, одни светлые, другие темные, одни быстрые, стремительные, другие медленные, неторопливые,а иногда - скажем, если она глядела на небо, туда, где Земля, - в глазах ничего не было, один только цвет… Мама сидела на носу лодки, одну руку она положила на борт, вторую на заглаженную складку своих брюк, и полоска мягкой загорелой шеи обрывалась там, где, подобно белому цветку, открывался воротник.
   Она все время глядела вперед, что-то высматривая, но не могла разглядеть и обернулась к мужу; в его глазах она увидела отражение того, что впереди,', 554);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1395, '2025-08-24 23:06:22.571376+03', 6, NULL, 'а он к этому отражению добавил что-то от самого себя, свою твердую решимость, и напряжение спало с ее лица, она снова повернулась вперед, теперь уже спокойно, зная, чего ей искать.
   Тимоти тоже смотрел. Но он видел лишь прямую черту фиолетового канала посреди широкой ровной долины, обрамленной низкими размытыми холмами. Черта уходила за край неба, и канал тянулся все дальше, дальше, сквозь города, которые - встряхни их - загремели бы, словно жуки в высохшем черепе. Сто, двести городов, видящих летние сны - жаркие днем и прохладные ночью… [Картинка: pic_9.png] 
   Они пролетели миллионы миль ради этого пикника, ради рыбалки. А в ракете было оружие. Называется, поехали на каникулы!', 555);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1396, '2025-08-24 23:06:22.571376+03', 6, NULL, 'А для чего все эти продукты - хватит с лихвой не на один год, - которые они спрятали по соседству с ракетой? Каникулы! Но за этими каникулами скрывалась не радостная улыбка, а что-то жестокое, твердое, даже страшное. Тимоти никак не мог раскусить этот орешек, а братьям не до того, - что может занимать мальчишек в десять и восемь лет?
   - Ну, где же марсиане? Дураки какие-то! - Роберт положил клинышек подбородка на ладони и уставился в канал.
   У папы на запястье было атомное радио, сделанное по старинке: прижми его к голове, возле уха, и радио начнет вибрировать, напевая или говоря что-нибудь. Как раз сейчас папа слушал,', 556);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1397, '2025-08-24 23:06:22.571376+03', 6, NULL, 'и лицо его было похоже на один из этих погибших марсианских городов - угрюмое, изможденное, безжизненное.
   Потом он дал послушать маме. Ее губы раскрылись.
   - Что… - начал Тимоти свой вопрос, но не договорил.
   Потому что в этот миг их встряхнули и ошеломили два громоздящихся друг на друга исполинских взрыва, за которыми последовало несколько толчков послабее.
   Отец вскинул голову и тотчас прибавил ходу. Лодка рванулась и понеслась, прыгая и громко шлепая по воде. Роберт мигом оправился от страха, а Майкл испуганно и восторженно взвизгнул и прижался к маминым ногам, глядя, как мимо самого его носа летят быстрые струи.
   Сбавив скорость, отец круто развернул лодку,', 557);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1398, '2025-08-24 23:06:22.571376+03', 6, NULL, 'и они скользнули в узкий отводной канал, к древнему полуразрушенному каменному причалу, от которого пахло крабами. Лодка ткнулась носом в причал так сильно, что всех швырнуло вперед, но никто не ушибся, а отец уже смотрел, обернувшись, не осталось ли на воде борозды, которая может выдать, где они укрылись. По глади канала разбегались длинные волны; облизав камень, они отступали, перехватывая набегающие сзади, все смешалось в игре солнечных бликов, потом рябь исчезла.
   Папа прислушался. Они все прислушались.
   Дыхание отца гулко отдавалось под навесом, будто удары кулака о холодные, влажные камни причала. Мамины кошачьи глаза глядели в полутьме на папу, допытываясь, что теперь будет.', 558);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1399, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Отец глубоко, с облегчением, вздохнул и рассмеялся сам над собой.
   - Это же наша ракета! Что-то я становлюсь пугливым. Конечно, ракета.
   - А что это было, пап, - спросил Майкл, - что это было?
   - Просто мы взорвали нашу ракету, вот и все. - Тимоти старался говорить буднично. - Что ли не слыхал, как ракеты взрывают? Вот и нашу тоже…
   - А зачем мы нашу ракету взорвали? - не унимался Майкл. - Зачем, пап?
   - Так полагается по игре, дурачок! - ответил Тимоти.
   - По игре?! - Майкл и Роберт очень любили это слово.
   - Папа сделал так, чтобы она взорвалась, и никто не узнал, где мы сели и куда подевались! Если кто захочет нас искать, понятно?
   - Ух ты, тайна!', 559);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1400, '2025-08-24 23:06:22.571376+03', 6, NULL, '- Собственной ракеты испугался, - признался отец маме. - Нервы! Смешно даже подумать, будто здесь могут появиться другие ракеты. Разве что еще одна прилетит: если Эдвардс с женой сумеют добраться.
   Он снова поднес к уху маленький приемник. Через две минуты рука его упала, словно тряпичная.
   - Все, конец, - сказал он маме. - Только что прекратила работу станция на атомном луче. Другие станции Земли давно молчат. В последние годы их всего-то было две-три. Теперь в эфире мертвая тишина. Видно, надолго.
   - На сколько? - спросил Роберт.
   - Может быть… может быть, ваши правнуки снова услышат радио, - ответил отец. Он сидел понурившись, и детям передалось то, что он чувствовал:', 560);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1401, '2025-08-24 23:06:22.571376+03', 6, NULL, 'смирение, отчаяние, покорность.
   Потом он опять вывел лодку на главный канал, и они продолжали путь.
   Вечерело. Солнце уже склонилось к горизонту; впереди простирались чередой мертвые города.
   Отец говорил с сыновьями ласковым, ровным голосом. Прежде он часто бывал сух, замкнут, неприступен, теперь же - они это чувствовали - папа будто гладил их по голове своими словами.
   - Майкл, выбирай город.
   - Что, папа?
   - Выбирай город, сынок. Любой город, какой тут нам подвернется.
   - Ладно, - сказал Майкл. - А как выбирать?
   - Какой тебе больше нравится. И ты, Роберт, и Тим тоже. Выбирайте себе город по вкусу.
   - Я хочу такой город, чтобы в нем были марсиане, - сказал Майкл.', 561);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1402, '2025-08-24 23:06:22.571376+03', 6, NULL, '- Будут марсиане, - ответил отец. - Обещаю. - Его губы обращались к сыновьям, но глаза смотрели на маму.
   За двадцать минут они миновали шесть городов. Отец больше не поминал про взрывы, теперь для него как будто важнее всего на свете было веселить сыновей, чтобы им стало радостно.
   Майклу понравился первый же город, но его отвергли, решив, что поспешные решения - не самые лучшие. Второй город никому не приглянулся. Его построили земляне, и деревянные стены домов уже превратились в труху. Третий город пришелся по душе Тимоти тем, что он был большой. Четвертый и пятый всем показались слишком маленькими, затошестой у всех, даже у мамы, вызвал восторженные крики. «Ух ты!», «Блеск!»,', 562);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1403, '2025-08-24 23:06:22.571376+03', 6, NULL, '«Вот это да!».
   Тут сохранилось в целости около полусотни огромных зданий, улицы были хоть и пыльные, но мощеные. Два-три старинных центробежных фонтана еще пульсировали влагой на площадях, и прерывистые струи, освещенные лучами заходящего солнца, были единственным проявлением жизни во всем городе.
   - Здесь, - дружно сказали все.
   Отец подвел лодку к пристани и выскочил на берег.
   - Что ж, приехали. Все это - наше. Теперь будем жить здесь!
   - Будем жить? - Майкл опешил. Он поднялся на ноги, глядя на город, потом повернулся лицом в ту сторону, где они оставили ракету. - А как же ракета? Как Миннесота?
   - Вот, - сказал папа.', 563);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1404, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Он прижал маленький радиоприемник к русой головенке Майкла. - Слушай. Майкл прислушался.
   - Ничего, - сказал он.
   - Верно. Ничего. Ничего не осталось. Никакого Миннеаполиса, никаких ракет, никакой Земли.
   Майкл поразмыслил немного над этим страшным откровением и тихонько захныкал.
   - Погоди, Майкл, - поспешно сказал папа. - Я дам тебе взамен гораздо больше!
   - Что? - Любопытство задержало слезы, но Майкл был готов сейчас же дать им волю, если дальнейшие откровения отца окажутся такими же печальными, как первое.
   - Я дарю тебе этот город, Майкл. Он твой.
   - Мой?
   - Твой, Роберта и Тимоти, ваш собственный город, на троих.
   Тимоти выпрыгнул из лодки.
   - Глядите, ребята,', 564);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1405, '2025-08-24 23:06:22.571376+03', 6, NULL, 'все наше! Все-все!
   Он играл наравне с отцом, играл великолепно, всю душу вкладывал. После, когда все уляжется и устроится, он, возможно, уйдет куда-нибудь минут на десять и поплачет наедине. Но сейчас идет игра «семья на каникулах», и братишки должны играть.
   Майкл и Роберт выскочили на берег. Они помогли выйти на пристань маме.
   - Берегите сестренку, - сказал папа, лишь много позднее они поняли, что он подразумевал.
   И они быстро-быстро пошли в большой розовокаменный город, разговаривая шепотом - в мертвых городах почему то хочется говорить шепотом, хочется смотреть на закат.
   - Дней через пять, - тихо сказал отец, - я вернусь туда, где была наша ракета, и заберу продукты,', 565);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1406, '2025-08-24 23:06:22.571376+03', 6, NULL, 'которые мы спрятали в развалинах. Заодно поищу Берта Эдвардса с женой идочерьми.
   - Дочерьми? - повторил Тимоти. - Сколько их?
   - Четыре.
   - Как бы потом из-за этого неприятностей не было. - Мама медленно покачала головой.
   - Девчонки. - Майкл скроил рожу, напоминающую каменные физиономии марсианских истуканов. - Девчонки.
   - Они тоже на ракете прилетят?
   - Да. Если им удастся. Семейные ракеты рассчитаны для полета на Луну, не на Марс. Нам просто повезло, что мы добрались
   - А откуда ты взял ракету? - шепотом спросил Тимоти, двое других мальчуганов уже убежали вперед.
   - Я ее прятал. Двадцать лет прятал, Тим. Убрал и надеялся, что никогда не понадобится. Наверное,', 566);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1407, '2025-08-24 23:06:22.571376+03', 6, NULL, 'надо было сдать ее государству, когда началась война, но я все время думал о Марсе…
   - И о пикнике!..
   - Вот-вот! Но это только между нами. Когда я увидел, что Земле приходит конец - я ждал до последней минуты! - то стал собираться в путь. Берт Эдвардс тоже припрятал корабль, но мы решили, что вернее всего стартовать порознь на случай, если кто-нибудь попытается нас сбить.
   - А зачем ты ее взорвал, папа?
   - Чтобы мы не могли вернуться, никогда. И чтобы эти недобрые люди, если они когда-нибудь окажутся на Марсе, не узнали, что мы тут.
   - Ты поэтому все время на небо глядишь?
   - Конечно, глупо. Никто не будет нас преследовать. Не на чем. Я чересчур осторожен, в этом все дело.', 567);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1408, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Прибежал обратно Майкл.
   - Пап, это вправду наш город?
   - Вся планета с ее окрестностями принадлежит нам, ребята. Целиком и полностью.
   Они стояли - Король Холмов и Пригорков, Первейший из Главных, Правитель Всего Обозримого Пространства, Непогрешимые Монархи и Президенты, - пытаясь осмыслить, что это значит, владеть целым миром, и как это много - целый мир!
   В разреженной марсианской атмосфере быстро темнело. Оставив семью на площади возле пульсирующего фонтана, отец сходил к лодке и вернулся, неся в больших руках целую охапку бумаги.
   На заброшенном дворе он сложил книги в кучу и поджег. Они присели на корточки возле костра погреться и смеялись, а Тимоти смотрел,', 568);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1409, '2025-08-24 23:06:22.571376+03', 6, NULL, 'как буковки прыгали, точно испуганные зверьки, когда огонь хватал их и пожирал. Бумага морщилась, словно стариковская кожа, пламя окружало и теснило легионы слов.
   «Государственные облигации; Коммерческая статистика 1999 года; Религиозные предрассудки, эссе; Наука о военном снабжении; Проблемы панамериканского единства; Биржевой вестник за 3 июля 1998 года; Военный сборник…»
   Отец нарочно захватил все эти книги именно для этой цели. И вот, присев у костра, он с наслаждением бросал их в огонь, одну за другой, и объяснял своим детям в чем дело.
   Пора вам кое-что растолковать. Наверно, я был не прав, когда ограждал вас от всего. Не знаю, много ли вы поймете,', 569);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1410, '2025-08-24 23:06:22.571376+03', 6, NULL, 'но я все равно должен высказаться, даже если до вас дойдет только малая часть. Он уронил в огонь лист бумаги.
   - Я сжигаю образ жизни - тот самый образ жизни, который сейчас выжигают с лица Земли. Простите меня, если я говорю как политик, но ведь я бывший губернатор штата. Я былчестным человеком, и меня за это ненавидели. Жизнь на Земле никак не могла устояться, чтобы хоть что-то сделать как следует, основательно. Наука слишком стремительно и слишком далеко вырвалась вперед, и люди заблудились в машинных дебрях, они, словно дети, чрезмерно увлеклись занятными вещицами, хитроумными механизмами, вертолетами, ракетами. Не тем занимались;', 570);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1411, '2025-08-24 23:06:22.571376+03', 6, NULL, 'без конца придумывали все новые и новые машины - вместо того, чтобы учиться управлять ими. Войны становились все более разрушительными и в конце концов погубили Землю. Вот что означает молчание радио. Вот от чего мы бежали. Нам посчастливилось. Больше ракет не осталось. Пора вам узнать, что мы прилетели вовсе не рыбу ловить. Я все откладывал, не говорил… Земля погибла. Пройдет века, прежде чем возобновятся межпланетные сообщения, - если они вообще возобновятся. Тот образ жизни доказал свою непригодность и сам себя задушил. Вы только начинаете жить. Я буду вам повторять все это каждый день, пока вы не усвоите…
   Он остановился, чтобы подбросить в костер еще бумаги.
   - Теперь мы одни.', 571);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1412, '2025-08-24 23:06:22.571376+03', 6, NULL, 'Мы и еще горстка людей, которые прилетят сюда через день-два. Достаточно, чтобы начать сначала. Достаточно, чтобы поставить крест на всем, что было на Земле, и идти по новому пути…
   Пламя вспыхнуло ярче, как бы подчеркивая его слова. Уже все бумаги сгорели, кроме одной. Все законы и верования Земли превратились в крупицы горячего пепла, которыйскоро развеет ветром.
   Тимоти посмотрел на последний лист, что папа бросил в костер. Карта мира… Она корчилась, корежилась от жара, порх - и улетела горячей черной ночной бабочкой. Тимоти отвернулся.
   - А теперь я покажу вам марсиан, - сказал отец. - Пойдем, вставайте. Ты тоже, Алиса.
   Он взял ее за руку.
   Майкл расплакался,', 572);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1413, '2025-08-24 23:06:22.571376+03', 6, NULL, 'папа поднял его и понес. Мимо развалин они пошли вниз к каналу.
   Канал. Сюда завтра или послезавтра приедут на лодке их будущие жены, пока - смешливые девчонки, со своими папой и мамой.
   Ночь окружила их, высыпали звезды. Но Земли Тимоти не мог найти. Уже зашла. Как тут не призадуматься…
   Среди развалин кричала ночная птица. Снова заговорил отец:
   - Мать и я попытаемся быть вашими учителями. Надеюсь, что мы сумеем… Нам довелось немало пережить и узнать. Это путешествие мы задумали много лет назад, когда вас еще не было. Не будь войны, мы, наверно, все равно улетели бы на Марс, чтобы жить здесь, по-своему, создать свой образ жизни. Земной цивилизации понадобилось бы лет сто,', 573);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1415, '2025-08-24 23:06:22.571376+03', 7, NULL, 'Венеция

Я живу с мыслью, что каждую минуту жизнь может измениться к лучшему. Мне так проще жить. Я все время жду хороших новостей, притягиваю их. А если случается плохое, я думаю: так-с, это плохое — ступенька к хорошему. Именно на контрасте с этим «пло- хо» я буду особенно ценить свое наступающее «хорошо», которое уже совсем близко. Очень хочу заразить этой мыслью окружающих.

Вот сейчас забежала в магазин. В очереди передо мной женщина с дочкой. Девочке лет пять.

— Мам, можно я сама выложу продукты на ленту? — спрашивает она. Очень хочет помочь.

Мама нервничает, может, опаздывают куда, может, просто не выспалась.

— Давай, только быстрее... — говорит она дочке рассеянно.', 1);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1416, '2025-08-24 23:06:22.571376+03', 7, NULL, 'Девочка быстро начинает метать продукты из тележки на ленту. Спешит. Мама доверила такое дело, надо оправдать ожидания! И вдруг пакет с пшеном падает на пол и лопается. Пшено почти не высыпалось, но пакет порван. Девочка в ужасе замерла. Что она натворила!

— Ну вот. — Мама вздыхает. — Так и знала! Вот доверь! Ну, руки-крюки! За что ни возьмешься.... Надо теперь взять новый пакет пшена!

Девочка беззвучно плачет. Она больше не хочет ничего перекладывать. Она неумеха. Руки-крюки. Так сказала мама.

— Давайте сюда этот, крупа почти не просыпалась, я вам в целлофан положу и заберете, вы же порвали! — говорит кассир.

— Мы не порвали, мы уронили. Он сам порвался. Мне нужен целый пакет пшена!', 2);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1417, '2025-08-24 23:06:22.571376+03', 7, NULL, '— раздраженно говорит мама.

Она сама переложила оставшиеся продукты на ленту. И, к неудовольствию всей очереди, ушла за новым пакетом пшена.

— Дайте пакет, пожалуйста, — говорю я кассиру, беру целлофановый пакет и прошу девочку, застывшую, как мумия, у кассы, помочь собрать пшено.

Она садится на корточки, и мы с ней вместе собираем пшено в целлофановый пакет, пока вернувшаяся мама девочки рассчитывается за покупки.

— А что теперь с этим пшеном? Которое ваша дочь рассыпала?

Мама приготовилась к скандалу.

— У вас тут всегда заложена в стоимость такая ситуация. Что вы мне рассказываете! Я могу вон весь алкоголь перебить, и то не обязана за него платить. А тут пшено!', 3);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1418, '2025-08-24 23:06:22.571376+03', 7, NULL, '— А кто за него должен платить, я? — заводится кассир.

Так, остановитесь! Зачем нагнетать на пустом месте? Ну вот зачем тиражировать взаимное раздражение?

— Я куплю это пшено, — говорю я. — При условии, что ваша дочь поможет мне переложить продукты на ленту. Она так здорово это делает. А у меня рука болит. Мама девочки врезается в мой убедительный взгляд и, будто опомнившись, говорит:

— Да, Лидочка, помоги тете... У нее рука болит.

Я, чтобы девочка не видела, поднимаю вверх большой палец своей совершенно здоровой руки.

Лидочка будто отмирает: начинает аккуратно перекладывать мои продукты на ленту, старается, поглядывает на маму.

— Какая у вас помощница растет!', 4);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1419, '2025-08-24 23:06:22.571376+03', 7, NULL, '— говорю я маме Лиды громко, чтобы девочка слышала.

— И не говорите! Она и полы у меня умеет мыть, и стирку запускать.

— Ничего себе, настоящая невеста! — подыгрывает нам мужчина, который стоит за нами.

— И пельмени я тебе помогала раскатывать, — напоминает смущенная Лида.

— Ооо, пельмеееени, это просто чудо, а не ребенок! Вот вырастет — отбоя от женихов не будет. Я бы сам прямо сегодня женился на вашей Лиде, да женат уже двадцать четыре года. Вот если б не жена...

Все в очереди смеются. Тем временем мои продукты уже на ленте. Я быстро упаковываю их в пакеты. Мы одновременно с Лидой и ее мамой выходим из магазина.

— Лида, а ты когда-нибудь была в Венеции? — спрашиваю я.

— Где?', 5);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1420, '2025-08-24 23:06:22.571376+03', 7, NULL, '— В Венеции.

— Нет. Я в Крыму была.

— Знаешь, я тоже пока не была. Но читала, что там есть площадь, на которой много-много голубей.

И они почти ручные: садятся людям на плечи и на голову. И люди с ними фотографируются. Представляешь?

— Здорово!

— Хочешь прямо сейчас оказаться в Венеции?

— Здесь? Сейчас? — удивляется Лида.

— Да. — Я достаю целлофановый пакет с пшеном. — Здесь и сейчас.

Мы отходим от магазина, и я говорю:

— Лида, ты очень скучно уронила пшено. Оно даже не рассыпалось. Урони так, чтобы бабах — и все рассыпалось.

Лида оглядывается на маму. Та уже все поняла, улыбается и кивает. Лида берет у меня пакет с пшеном.

— Прямо на землю?

— Прямо на землю!', 6);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1421, '2025-08-24 23:06:22.571376+03', 7, NULL, 'Лида радостно плюхает пшено, оно рассыпается желтым салютом, и небо сразу чернеет: с крыш, с проводов, откуда ни возьмись, огромное полчище голодных голубей стремительно пикирует к ногам визжащей от восторга Лиды.

— Мама, мама! Смотри, как их много, они едят наше пшено! Мы в Венеции!

Мы с ее мамой смеемся.

— Здорово, спасибо вам. Прямо отрезвили. А то у меня сегодня плохой день... — говорит мама Лиды.

— Плохой день каждую минуту может стать хо- рошим. Балашиха каждую минуту может стать Венецией.

— Да, я уже поняла, — смеется мама. — Он уже стал...

Она прижимает к себе скачущую Лиду.

— Я свою дочурку Лиду никому не дам в обиду, — говорит она.

А девочка хлопает в ладоши...

Ну все,', 7);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1422, '2025-08-24 23:06:22.571376+03', 7, NULL, 'здесь я больше не нужна. Фея рассыпанного пшена, голодных голубей и счастливых девочек полетела дальше. Помните: каждую минуту все может измениться к лучшему. Подождите. Или измените сами.', 8);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1428, '2025-08-28 18:35:17.236101+03', 12, NULL, 'Интересное учение, созданное погибшим политзаключенным, политическим активистом и блогером Максимом Марцинкевичем, больше известным как Тесак.
Как я понимаю, на основе идей Эбби Хоффмана, основателя движения яппи, похожего на хиппи, в США 1960-х — см. Эбби Хоффман. Сопри эту книгу!

Социал-тутовизм есть форма жизни сверхчеловека в условиях погибающего общества. Человек, желающий помочь окружающим его людям, должен — ОБЯЗАН — на них паразитировать. Отсюда и название, переводимое, как "общественный паразит".

Первое правило тутовика: он не должен работать.
Второе правило тутовика: он не должен помогать окружающим его людям.
Третье правило тутовика: он должен стремиться жить за счёт творческой,', 1);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1429, '2025-08-28 18:35:17.236101+03', 12, NULL, 'научной или мошеннической деятельности.
Четвертое правило тутовика: он должен спать, когда другие бодрствуют.
Пятое правило тутовика: он должен бодрствовать, когда другие спят.
Шестое правило тутовика: он должен постоянно совершать антиобщественные действия, имея целью показать обществу, как оно несовершенно.
Седьмое правило тутовика: тутовик не должен иметь вредных привычек, так как это сократит срок его жизни, а стало быть помешает его борьбе.
Восьмое правило социал тутовика: он должен быть романтиком, иначе он не сможет думать о всеобщем благе, что приведёт его к предательству идеалов тутовизма.

В "Реструкте" Тесак подробнее раскрывает тему:
Тутовик — это такой гриб,', 2);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1430, '2025-08-28 18:35:17.236101+03', 12, NULL, 'который растет на умирающих деревьях. Он пускает в них корни, пьет из них сок и разрушает начавшую отмирать древесину. Дерево, засыхающее само по себе, может простоять многие годы и не упасть. Оно не освободит жизненное пространство молодым до тех пор, пока его не повалит ураган, не сгниют корни или его не срубит человек. Но вот тутовик помогает «дать дорогу молодым» значительно раньше. Это санитар леса. Суть в том, что споры этого гриба есть в каждом дереве. Только растет он исключительно на ослабевших и умирающих. Наше общество подобно лесу. В котором деревья — это разного рода социальные установки. Одни из них молодые, другие древние. Одни сильные и здоровые, а другие дряхлые и отжившие.', 3);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1431, '2025-08-28 18:35:17.236101+03', 12, NULL, 'Так вот задача тутовиков в том и состоит, чтобы улучшать, обновлять общество путем разрушения отживших установок. 

Например. Есть два понятия: дружба и целомудрие. Звучит и одно и другое слово красиво. Но одно из них живо, а другое так и отдает лицемерием. Дружба — это то, что составляет основу отношений между людьми. А вот целомудрие — это уже давно миф. Девочки в четырнадцать лет стесняются сказать подругам, что они целки. Ищут кто бы их безболезненно дефлорировал. Целомудрие похоже на тряпку, которая пролежала несколько десятилетий в кладовке, стала рваться легче, чем марля, но из нее кто-то сшил платье. Много понятий, которые выглядят так же. Сопереживание.', 4);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1432, '2025-08-28 18:35:17.236101+03', 12, NULL, 'Всем давным-давно насрать на окружающих.

А вот человек, живущий по философии тутовизма — циник. Он не любит притворяться, что испытывает чувства, которых у него нет и в помине. Особенно, когда к этому его пытается принудить какое-либо социальное уложение. Он относится критически ко всему, что ему говорят. Это ему приносит исключительно пользу. Его нелегко обмануть. Он не действует, «как все» и не попадает в глупые ситуации. Его мозг постоянно занят аналитической работой, значит, он развивается, самосовершенствуется. Он во всём стремится разобраться, увидеть суть. «Кому выгодно?» — вот о чем думает тутовик, когда ему пытаются проехать по ушам. Он понимает:', 5);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1433, '2025-08-28 18:35:17.236101+03', 12, NULL, 'мало что в этом мире может произойти случайно. А если вдруг произошло, то кто-нибудь сразу старается извлечь из этого пользу. Поэтому совет «Зри в корень!» социал-тутовик превращает в один из основных своих жизненных принципов.

Социал-тутовик понимает, что нет абсолютного добра и абсолютного зла. Как сказал Шекспир: «Добро и зло — их нет. Есть то, как мы решим назвать их сами». Всё в этом мире относительно. Если для зайца волк — «злодей», то для волка заяц — просто пища. Общество любит играть само с собой в трансцендентные игры, выбирая, что есть что. А затем ненавязчиво меняя понятия местами. Тутовик это видит и ухмыляется. Ему смешно видеть,', 6);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1434, '2025-08-28 18:35:17.236101+03', 12, NULL, 'как одни и те же люди в институте получали «отлично» по «атеизму» и «научному коммунизму», а теперь ратуют за демократию и искренне веруют в бога. Как дружно они презирали барыг и спекулянтов, а теперь завидуют бизнесменам и коммерсантам. Как радовались развалу СССР, а теперь грустят по твердой руке Сталина. 

Социал-тутовик, если он что-то делает, то стремится получить от этого именно моральное удовлетворение, а не материальную выгоду. Быдло не понимает этой мотивировки — зачем тратить силы на то, что потом на хлеб не намазать и в карман не положить? Но социал-тутовику эта повсеместная меркантильность противна — для него лучше на голодный желудок ощутить чувство выполненного долга,', 7);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1435, '2025-08-28 18:35:17.236101+03', 12, NULL, 'чем почувствовать себя сытым биороботом.

По сути, социал-тутовики были всегда. Это и Ницше с его «падающего — подтолкни!» Это значит не то, что если твой друг поскользнулся — пни его ногой. Бывают бараны, которые и так поймут. Это говорит о том, что все отживающее надо добивать. Это и нигилисты, типа Базарова из «Отцов и детей». Они тоже хотели избавиться от ошибок, предрассудков и пережитков старины, держащихся исключительно на авторитете своих приверженцев. Это и ученые эпохи возрождения, бросавшие вызов церкви. Не желавшие мириться с тем, что им пытаются ездить по ушам текстами и заповедями те, кто сам их никогда и не думал придерживаться. А сейчас это люди, которые понимают,', 8);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1436, '2025-08-28 18:35:17.236101+03', 12, NULL, 'что все в мире не так, как им пытаются внушить. Просиживая штаны в офисах, они зря тратят свою жизнь. Многие, например, из офисного планктона, это осознают. Люди получили образование, они оказались достаточно умны для того, чтобы не оказаться на заводе или на стройке. А дальше? Общество дает им возможность хорошо зарабатывать, ничего не производя. Этим надо пользоваться. Но вот правильно ли это?

Из интервью:
Люди ходят на завод, но получают копейки от своей реальной наработки. Но они продолжают просто потому, что не умеют ничего больше, у них нет образования. Я на завод ходить не хочу. Есть менеджеры, у которых мозгов побольше, они могут что-то делать, но не делают ничего,', 9);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1437, '2025-08-28 18:35:17.236101+03', 12, NULL, 'а просиживают штаны. Они паразиты. Это уже лучше. Когда общество поймет, что позволяет на себе паразитировать, оно должно придумать, как с этим бороться. Я не говорю, что против того, чтобы трудиться, чтобы зарабатывать деньги. Я против того, чтобы тупо работать на какого-то урода и деградировать от того, что тупо ходишь на работу.

На мой взгляд, помимо Ницше, есть и общие идеи с "Одномерным человеком" Герберта Маркузе:
Герберт Маркузе последовательно анализирует современные ему «Одномерное общество», «Одномерное мышление» и «Шанс альтернативы». Согласно его идеям, современное общество «усмиряет центробежные силы скорее с помощью техники, чем насилия,', 10);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1438, '2025-08-28 18:35:17.236101+03', 12, NULL, 'опираясь одновременно на сокрушительную эффективность и повышающийся жизненный стандарт»; оно способно сдерживать «качественные социальные перемены». «Критическая теория» общества перестала быть оппозиционной. Осуществляется «успешное удушение тех потребностей, которые настаивают на освобождении … при поддерживании и разнуздывании деструктивной силы и репрессивной функции общества изобилия». Происходит формирование массовых «стандартных», «ложных» потребностей. Современное общество, по мнению автора, тоталитарно в том смысле, что оно осуществляет ненасильственное экономическое координирование своих элементов. В его основании располагается «технологический проект»:', 11);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1439, '2025-08-28 18:35:17.236101+03', 12, NULL, 'стремление людей поработить природу, приспособить её для своих потребностей. Альтернативы такой модели социального поведения не предвидится. Нужен «Великий Отказ» — правда, неэксплицированный автором. При господстве «одномерного мышления» «идеи, побуждения и цели, трансцендирующие по-своему содержанию утвердившийся универсум дискурса и поступка, либо отторгаются, либо приводятся в соответствие с терминами этого универсума, переопределяемые рациональностью данной системы и её количественной мерой». Налицо слияние рациональности и угнетения. Рабы развитой индустриальной цивилизации превратились в сублимированных рабов, оставаясь таковыми,', 12);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1440, '2025-08-28 18:35:17.236101+03', 12, NULL, 'ибо рабство задаётся не мерой покорности и не тяжестью труда, а статусом бытия как простого инструмента и сведением человека к состоянию вещи.

Из Telegram-канала сторонников социал-тутовизма

	Почему тутовик не должен работать?
	Сегодня коснёмся первой заповеди тутовика «Не работай». С одной стороны это паттерн, лежащий в природе любого примата – мы отрастили такие здоровые мозги, чтобы быренько решать возникающие проблемы и снова возвращаться к блаженному безделью. С другой стороны всё дорожает, а жить как-то надо.

В чём кроются основные недостатки стабильной работы, исключающие возможность существования тутовика в подобной парадигме?

График. Человеку, работающему по 40 часов в неделю,', 13);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1441, '2025-08-28 18:35:17.236101+03', 12, NULL, 'приходится выстраивать свой режим в соответствии с определённым графиком. Собственно тем, кто попробовал не нужно рассказывать о том, как падает пассионарность к концу рабочего дня. А если после работы нужно сходить на тренировку, по возвращению домой сил хватает только на то, чтобы принять душ и отужинать. Два дня выходных проходят как правило в аутировании после утомительной рабочей недели. А творческий процесс тем временем не признаёт временных рамок. Так работа нивелирует любую активную и творческую деятельность.

Начальство. Тутовики выступают за усиление иерархии и за меритократию как власть достойных, не признавая всевозможных анархических настроений.', 14);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1442, '2025-08-28 18:35:17.236101+03', 12, NULL, 'Но так уж получается в нашем несовершенном обществе, что начальником как правило оказывается не достойный человек, а какой-нибудь горбатый пидорас. Необходимость считаться со словами всевозможных никчемушных хуесосов есть насилие над собственной личностью и причина зашоренности сознания. Так работа подрывает себялюбие и свободное мышление.

Финансовая стабильность. Звучит данный пункт довольно позитивно, но как говорится, спокойное море никогда не рождало хороших моряков. Финансовая стабильность быстро сажает на жопу, отнимая мотивацию к развитию профессиональных скилов и поиску более перспективных и занимательных вариантов заработка.', 15);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1443, '2025-08-28 18:35:17.236101+03', 12, NULL, 'Творчество и мошенничество – вот основа дохода тутовика. Совершенное ремесло сочетает в себе творчество с мошенничеством. Мошенничество в теории тутовизма есть вид деятельности, доходы от которого значительно превышают доходы от любого другого занятия при равном количестве приложенных усилий.

Монотонный физический труд, чётко алгоритмизированная работа в установленный промежуток времени – есть низведение человека до функции машины. Такой род деятельности не подразумевает какого-либо развития и творческого начала, как потенции создать что-то, чего прежде не существовало в природе. Отсутствие творческого начала в деятельности, которой индивид вынужден заниматься продолжительное время,', 16);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1444, '2025-08-28 18:35:17.236101+03', 12, NULL, 'является главной предпосылкой к деградации интеллекта и сужению горизонтов мыслимого для конкретной личности.
	
	Почему социал-тутовик не должен иметь вредных привычек?
	Как уже было сказано выше — тутовик не должен иметь вредных привычек, так как это сократит срок его жизни, а стало быть помешает его борьбе. Тело тутовика есть инструмент борьбы и пропаганды. О способности систематических интоксикаций преждевременно вывести данный инструмент из строя говорилось неоднократно. Поэтому обратим внимание на другой аспект этой проблемы.

Что в сущности представляет из себя привычка? Привычка есть способ поведения, принимающий характер потребности. С позиции свободы личности,', 17);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1445, '2025-08-28 18:35:17.236101+03', 12, NULL, 'любое увеличение потребностей поверх базовых (естественных) – есть путь к снижению степени свободы. Любая потребность, которую мы не можем удовлетворить самостоятельно, склоняет нас ко всевозможным компромиссам, в определении которых кроется обуздание, ограничение нашей воли.

Рассматривая тутовизм на парадигмальном уровне, как идеологию, отклоняющую всё, что ослабляет, что истощает и утверждающую всё, что усиливает, что накопляет силы, что оправдывает чувство силы, можно провести соответствующий анализ привычек разного рода. Вредные привычки – ослабляют и истощают, в то время как привычки,', 18);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1446, '2025-08-28 18:35:17.236101+03', 12, NULL, 'связанные с физическим и интеллектуальным развитием характеризуют восходящий инстинкт жизни и накопление силы.
	
	Борис Ельцин и Сергей Мавроди — главные социал-тутовики 90-х
	Ещё в юности Борис Николаевич познал всю абсурдность, порочность и исключительную неустойчивость политического аппарата страны, в которой он родился и рос. В то же время, он принял клятву тутовика и гордо нёс иделы тутовизма до конца своей жизни. Основную идею, которую воплощал Борис Николаевич на протяжении всей своей карьеры, можно выразить в лозунге – «Чем хуже, тем лучше». Ельцин последовательно притворял свой план в жизнь, постепенно увеличивая градус насилия.', 19);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1447, '2025-08-28 18:35:17.236101+03', 12, NULL, 'В ход шли и невыполненные обещания и пьяные танцы на телевидении (очевидно постановочные, ведь настоящий тутовик не имеет вредных привычек) и планомерное усугубление общей гротескности бытия для граждан страны, у штурвала которой встал Борис Николаевич. Ельцин подталкивал падающую страну как мог. И она упала. Упала для того, чтобы на руинах старой плохой страны, мы построили новую – хорошую.

Сергей Пантелеевич Мавроди – воплощение образцового тутовика. Сделав мошенничество основным родом своей деятельности и значительно преуспев в нём, Сергей Пантелеевич также никогда не забывал и о таких важных для тутовика направлениях, как саморазвитие и творчество.', 20);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1448, '2025-08-28 18:35:17.236101+03', 12, NULL, 'В институте Мавроди увлекался самбо и очень быстро стал кандидатом в мастера спорта. При весе 60 кг был чемпионом Москвы в абсолютной весовой категории. Также Сергеем Мавроди написано много произведений и в разных жанрах. Есть проза, стихи, поэмы, пьесы, киносценарии.

Но главным делом жизни, полностью раскрывающим тутовистическую сущность героя данного очерка, стало дерзновение наебнуть мировую финансовую систему. Очевидно чтобы на месте старой плохой финансовой системы, построить новую – хорошую. Да, возможно в отличии от ранее описанного члена пантеона славы тутовизма – Бориса Николаевича Ельцина, Сергей Пантелеевич взвалил на себя непосильную задачу.', 21);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1449, '2025-08-28 18:35:17.236101+03', 12, NULL, 'Однако это только подчёркивает романтическую натуру нашего героя. А тутовик, как известно, должен быть романтиком.

Говоря о двух виднейших тутовиках нашей страны, нельзя не вспомнить того факта, что в 1994 Мавроди поздравлял страну году с Новым годом вместо Бориса Николаевича. Ограничилось ли сотрудничество героев только этим случаем или имели место другие – никто точно не знает, но скорее всего не ограничилось.

Ну и стоит наверное по такому случаю объяснить позицию тутовизма по «обманутым» вкладчикам МММ и других подобных организаций. Структуры вроде МММ паразитируют на общественных пороках,', 22);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1450, '2025-08-28 18:35:17.236101+03', 12, NULL, 'конвертируя жадность и жажду лёгкой наживы (не подразумевающую приложения интеллектуальных усилий) в чистую прибыль. Никто не заставлял несчастных вкладывать в пирамиду последнее под дулом автомата. Людей вела жадность, за которую они в скорости расплатились сполна. Пороки изобличены, тутовизм празднует очередную победу.
	
	Первым социал-тутовиком был Иисус
	Первым социал-тутовиком был Иисус. И всё, что вы о нём знаете – неправда и поповские сказки. Сейчас расскажу, как всё было на самом деле.

На самом деле Иисус не был плотником. Все 33 года своей жизни он жил как подобает настоящему тутовику – не работал, не стремился помочь людям, занимался творчеством и мошенничеством, спал днём,', 23);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1451, '2025-08-28 18:35:17.236101+03', 12, NULL, 'бодрствовал ночью, боролся с пороками общества нестандартными, а порой и антисоциальными методами, тонизировался исключительно кофеином и гордо нёс массам светлые идеалы социал-тутовизма. Кроме прочего любил он прокатиться на скейте, подтолкнуть то, что должно упасть и перевернуть то, что плохо закреплено.

Иисус не умирал за наши грехи, Иисус тусовался и весело проводил время за всех работяг, что вкалывали, вкалывают и будут вкалывать с 8 до 5 и с 9 до 6. Это в будни. Чем занимался Иисус в выходные никто не знает, а тот кто догадывается, не говорит об этом вслух.

Кстати крест, есть результат ошибки в изображении. Крест, ассоциируемый с Иисусом, есть буква Т – символ тутовизма.', 24);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1452, '2025-08-28 18:35:17.236101+03', 12, NULL, 'В память о самом великом человеке, мы, адепты тутовизма, раз за разом проходим стопами Иисуса – насмехаясь над трагедиями жизни и сцены, даже когда они касаются нас самих, оставляя за собой руины, на которых однажды воздвигнутся новые, более прочные и совершенные сооружения.
	
Ролики по теме

	Семинар Тесака — "Не верь, не бойся, не работай"
	https://www.youtube.com/watch?v=Bi15mP3OHng

	
	Еще один — "Забыл оплатить" (на тему шоплифтинга)
	https://www.youtube.com/watch?v=wvf-Lo2ECGo

03.10.20 13:40 : Марцинкевич семинар забыл оплатить
	
	Интервью с идейным добровольным безработным
	https://www.youtube.com/watch?v=5bNJJPiSU3I

	
	Диалог из фильма "Беспредел",', 25);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1453, '2025-08-28 18:35:17.236101+03', 12, NULL, 'тоже в тему (блатные "воспитывают" тунеядца Калгана)
	https://www.youtube.com/watch?v=repQWjg2UWY

27.04.14 14:57 : А мы не работаем! хф Беспредел, 1989, фрагмент
	
Предлагаю обсудить.
— Нет в мире справедливости, — простонал Билл, когда цепкие пальцы Смертвича впились в его плечо.', 26);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (1, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture013.jpg', '⠀⠀<strong>С</strong>транник сидит посреди леса и глядит на скромный дом.
⠀⠀Он уже бывал здесь прежде вместе с компанией друзей, но в ту пору заметил только сходство между этим домиком и зданиями, построенными неким испанским архитектором, жившим много-много лет назад и никогда не бывавшим здесь. Дом этот расположен неподалеку от Кабо-Фрио, в Рио-де-Жанейро, и целиком сделан из осколков стекла. Его хозяин – по имени Габриэл – в 1899 году увидел во сне ангела, который сказал ему: «Построй дом из стекла». И Габриэл принялся собирать разбитые тарелки, кувшины, безделушки, изразцы, приговаривая: «Всякий осколочек будет наделен красотой». Первые лет сорок местные жители считали его сумасшедшим, а потом заезжие путешественники увидели этот дом, стали привозить сюда друзей – и Габриэл прославился и прослыл гением. Однако исчезла прелесть новизны – и он вновь погрузился в безвестность. Но строить не перестал и в 93 года приладил на подобающее ему место последний кусочек стекла. И умер.', 1);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (2, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture014.jpg', '⠀⠀<strong>С</strong>транник закуривает. Сегодня он не думает о том, как похож дом Габриэла на творения Гауди. Он глядит на стекла, размышляет о собственной жизни. Она – как и бытие всякого человека – сотворена из кусочков всего, что было и миновало. Но приходит минута, когда эти разрозненные кусочки, внезапно начиная обретать форму, укладываются в нечто цельное и единое.', 2);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (3, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture015.jpg', '⠀⠀<strong>И</strong> странник, поглядывая в разложенные на коленях листки бумаги, вспоминает эпизоды из своего прошлого. И это – кусочки его бытия: ситуации, в которых он оказывался, отрывки из книг, которые некогда читал, наставления учителя, истории, рассказанные друзьями или где-то услышанные. И раздумья о времени, в которое выпало жить, и о мечтах, воодушевлявших его поколение. И точно так же, как этот Габриэл по велению привидевшегося ему во сне ангела строил дом, странник пытается сейчас привести свои записи в некое соответствие – для того чтобы осознать собственное душевное устройство. Он вспоминает, что в детстве прочел книгу Мальба Тахана под названием «Мактуб» и думает: «Может быть, я должен сделать что-то подобное?»', 3);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (4, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture016.jpg', '⠀⠀<strong>Г</strong>оворит наставник:
⠀⠀– Предчувствуя приближение часа перемен, мы в безотчетном побуждении принимаемся прокручивать пленку, где запечатлены все наши житейские неудачи и промахи. И разумеется, чем старше мы становимся, тем длиннее делается их перечень. Но вместе с тем обретенный опыт позволяет нам справляться с этими промахами, одолевать последствия и вновь выходить на дорогу, которая позволит двигаться дальше. В наш воображаемый видеомагнитофон следует ставить и эту кассету. Если будем смотреть только ленту со своими провалами и неудачами, то застынем в душевном столбняке. Если будем смотреть только ленту, где отражен наш многогранный опыт, – покажемся себе в конце концов мудрее, чем мы есть на самом деле. Обязательно надо смотреть обе.', 4);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (5, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture017.jpg', '⠀⠀<strong>П</strong>редставим себе гусеницу.
⠀⠀Представим, как, проводя большую часть своей жизни на земле, она смотрит на птиц, негодует на свою судьбу и возмущается тем, какою уродилась на свет. «Я – самое презренное существо, – думает она. – Я уродлива, я вызываю омерзение и обречена всю жизнь ползать по земле».
⠀⠀Но вот приходит день, когда Природа требует, чтобы гусеница смастерила себе кокон.
⠀⠀Ей страшно – ибо никогда прежде не приходилось делать такого. Ей кажется – она ложится в могильный склеп и заранее прощается с жизнью. И гусеница, хоть и возмущалась той жизнью, что вела прежде, снова сетует на несправедливость Творца: «Едва лишь я успела в конце концов привыкнуть, как Ты забираешь и ту малую малость, что у меня есть!» И в отчаянии затворяется в своем коконе, ожидая гибели. Но через несколько дней превращается в прелестную бабочку. Теперь, вызывая всеобщее восхищение, она порхает в воздухе. И только дивится тому, как мудро все устроил Создатель и как глубок сокровенный смысл жизни.', 5);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (6, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture018.jpg', '⠀⠀<strong>Н</strong>екий чужеземец пришел к настоятелю монастыря в Сцете и сказал ему так:
⠀⠀– Хочу, чтобы жизнь моя была чище, лучше и нравственней. Но не могу отделаться от грешных и низких мыслей.
⠀⠀Настоятель заметил, какой сильный ветер дует за стенами обители, и спросил посетителя:
⠀⠀– Здесь очень жарко. Можешь ли ты собрать немного ветра там, снаружи, и впустить его сюда, чтобы стало попрохладней?
⠀⠀– Нет, конечно, это невозможно!
⠀⠀– Точно так же невозможно и отрешиться от помыслов, оскорбляющих Бога, – ответил настоятель. – Однако если научишься говорить своим искушениям «нет», они не смогут причинить тебе никакого вреда.', 6);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (7, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture019.jpg', '⠀⠀<strong>Г</strong>оворит наставник:
⠀⠀– Если необходимо принять какое-нибудь решение и существует выбор, лучше всего идти вперед, заранее смиряясь с последствиями. Ибо не дано наперед узнать, каковы будут они.
⠀⠀И искусство ясновидения и предсказания заключается не в том, чтобы предвидеть будущее, но в том, чтобы дать человеку нужный ему совет. Все мастера этих искусств – превосходные советники и никуда не годные пророки. В молитве, которой научил нас Иисус, говорится: «Да будет воля Твоя». И когда эта воля ставит перед нами проблему, то кладет рядом и ключ к ее решению.
⠀⠀А если бы предсказатели и гадалки в самом деле могли провидеть грядущее, все они были бы богаты, удачливы и счастливы в браке.', 7);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (8, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture020.jpg', '⠀⠀<strong>У</strong>ченик пришел к учителю и сказал ему так:
⠀⠀– Много лет кряду я отыскиваю просветление. Сейчас чувствую, что почти вплотную приблизился к нему. Хочу знать, каков должен быть мой следующий шаг?
⠀⠀– А чем ты зарабатываешь себе на жизнь? – спросил наставник.
⠀⠀– Пока еще не научился зарабатывать. Меня содержат отец и мать. Ну да, впрочем, это совсем не важно.
⠀⠀– Ты спрашиваешь, каков должен быть твой следующий шаг? Полминуты неотрывно смотри на солнце, – сказал наставник, и ученик так и сделал.
⠀⠀Потом, когда истекли эти полминуты, наставник попросил его описать все, что тот видел вокруг себя.
⠀⠀– Да ничего я не видел! Солнце слепило меня!
⠀⠀– Человек, который ищет только света, а обязанности свои перекладывает на других, никогда не обретет просветления.', 8);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (9, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture021.jpg', '⠀⠀<strong>Ч</strong>еловек, постоянно созерцающий солнце, в конце концов лишится зрения.', 9);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (10, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture022.jpg', '⠀⠀<strong>Н</strong>екий странник шел долиной в Пиренеях и повстречал старого пастуха. Поделился с ним своими припасами, и потом они завели долгую беседу о жизни. Странник сказал, что, если бы веровал в Бога, пришлось бы поверить и в то, что он – несвободен, ибо Бог определял бы каждый его шаг.
⠀⠀Тогда пастух подвел его к ущелью, где каждый звук отдавался необыкновенно отчетливым и громким эхом.
⠀⠀– Жизнь наша подобна стенам этого ущелья, – сказал пастух. – А судьба – крик, который издает каждый из нас. И крик этот будет донесен до самого сердца Его, а потом возвращен нам точно в том же самом виде.
⠀⠀Бог, подобно эху, отзывается на каждый наш поступок.', 10);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (23, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture035.jpg', '⠀⠀<strong>32</strong>-летний пациент обратился к доктору Ричарду Кроули:
⠀⠀– Не могу отделаться от дурной привычки – сосу палец.
⠀⠀– Пусть вас это не тревожит, – сказал Кроули. – Но попробуйте сделать так, чтобы каждому дню недели соответствовал свой палец.
⠀⠀И с этой минуты пациент, поднося палец ко рту, вынужден был инстинктивно вспоминать, какому из десяти пальцев надлежит быть объектом его внимания в этот день. Не прошло и недели, как он излечился от своего пагубного пристрастия.
⠀⠀– Когда зло входит в привычку, с ним очень трудно справляться, – рассказывает Ричард Кроули. – Но когда оно начинает требовать от нас нового к себе отношения, принятия решений, выбора, то мы понимаем, что в сущности оно не заслуживает подобных усилий с нашей стороны.', 23);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (12, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture024.jpg', '⠀⠀<strong>Н</strong>екий приезжий, оказавшись в Нью-Йорке, проснулся довольно поздно и, когда вышел из гостиницы, обнаружил, что его автомобиль эвакуирован полицией.
⠀⠀В результате он опоздал на встречу, на которую направлялся, а деловой обед продлился дольше, чем он предполагал. И штраф, должно быть, составит колоссальную сумму. Внезапно он вспомнил, что накануне подобрал с земли купюру достоинством в один доллар, и осознал какую-то странную связь между нею и утренним происшествием.
⠀⠀«А вдруг я, взяв этот доллар, отнял его тем самым у того, кто по-настоящему нуждался в нем?
⠀⠀А вдруг я вмешался в некие предначертания?»
⠀⠀И он, решив избавиться от купюры, вдруг заметил сидящего на земле нищего. И поспешно сунул доллар ему.
⠀⠀– Минутку, – отозвался нищий. – Я поэт и отплачу вам за вашу доброту стихами.
⠀⠀– Только покороче, пожалуйста, – сказал приезжий. – Я очень спешу.
⠀⠀– Да вы и живы-то еще лишь потому, – ответил нищий, – что не поспели вовремя туда, куда так спешили утром.', 12);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (13, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture025.jpg', '⠀⠀<strong>У</strong>ченик сказал учителю:
⠀⠀– Почти весь сегодняшний день думал я о том, о чем не должен был бы думать, желал того, чего не должен был желать, строил планы, от которых лучше было бы заранее отказаться.
⠀⠀Тогда наставник предложил ему прогуляться в соседнем лесу. По дороге, указав на какое-то растение, он спросил, знает ли ученик, что это такое.
⠀⠀– Белладонна, – отвечал тот. – Его листья нельзя употреблять в пищу, можно отравиться и умереть.
⠀⠀– Но для того, кто просто смотрит на его ядовитые листья, оно совершенно безвредно, – сказал учитель. – Вот так и дурные, низкие помыслы не способны причинить тебе вред, если ты не позволишь себе прельститься ими.', 13);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (14, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture026.jpg', '⠀⠀<strong>М</strong>ежду Францией и Испанией тянется горная гряда. И на одном из отрогов стоит деревушка под названием Аржелес. И там горный склон ведет вниз, в долину. Каждый день пастух спускается и поднимается по склону.
⠀⠀И странник, впервые оказавшийся в Аржелесе, не замечает ничего.
⠀⠀А во второй раз замечает, что пастуха всегда сопровождает какой-то человек. И с каждым новым своим приездом в Аржелес бросаются ему в глаза новые и новые подробности его облика – одежда, шапка, трость, очки. И сегодня, когда он вспоминает эту деревню, неизменно думает про того старичка, который об этом и не подозревает. Лишь однажды довелось путешественнику поговорить с ним, – он тогда спросил его в шутку:
⠀⠀– Быть может, сам Господь обитает в этих дивных горных местах?
⠀⠀– Бог живет в тех местах, – отвечал старичок, – которые допускают Его присутствие.', 14);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (15, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture027.jpg', '', 15);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (20, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture032.jpg', '⠀⠀<strong>Н</strong>екто захотел посетить отшельника, жившего в скиту неподалеку от монастыря Сцета. Он долго брел наугад по пустыне, пока наконец не нашел его.
⠀⠀– Я хочу знать, каков должен быть мой первый шаг на пути духовного постижения.
⠀⠀Отшельник привел его на берег маленького пруда и попросил взглянуть на свое отражение в воде. Тот послушался, но отшельник тотчас принялся швырять в воду камешки, и по воде пошла рябь.
⠀⠀– Пока ты не перестанешь швырять камни, я не смогу увидеть свое отражение!
⠀⠀– Как невозможно увидеть свое лицо в бурных водах, так невозможно и отыскать Бога, если душа омрачена необходимостью поиска и страхом неудачи, – ответил отшельник. – Это и есть самый первый шаг.', 20);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (21, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture033.jpg', '', 21);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (16, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture028.jpg', '⠀⠀<strong>Н</strong>аставник, встретившись как-то под вечер со своими учениками, попросил их разложить костер, чтобы присесть у огня и поговорить.
⠀⠀– Духовный путь подобен этому пламени, – сказал он. – Тот, кто желает развести огонь, должен стерпеть едкий и неприятный дым, от которого першит в горле и слезятся глаза. Так же в точности происходит и обретение веры. Но когда огонь разгорается сильно и ярко, дым исчезает и языки пламени озаряют все вокруг.
⠀⠀– Ну а если кто-то заранее разложит для нас костер? – спросил один из учеников. – И тем самым избавит нас от неприятного дыма?
⠀⠀– Тот, кто сделает это, будет лжеучителем.
⠀⠀Он сможет развести огонь там, где пожелает, руководствуясь лишь собственной волей и вкусом. Он, если захочет, сможет и погасить его в любой момент. А поскольку он никого не научил тому, как разложить костер, то весь мир будет погружен во тьму.', 16);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (43, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture055.jpg', '⠀⠀<strong>Г</strong>оворит наставник:
⠀⠀– Многие из нас боятся быть счастливыми. Для многих понятие «счастье» означает отказ от установившихся привычек и влечет за собой потерю того, что можно назвать «самостью».
⠀⠀Очень часто мы считаем себя недостойными того прекрасного, что происходит с нами. И отвергаем его – ибо если бы приняли, почувствовали бы себя в долгу перед Господом.
⠀⠀Мы думаем: «Лучше даже не пригубливать чашу блаженства, потому что когда она будет опустошена, мы будем страдать – и сильно».
⠀⠀И вот из опасений того, что убудет, мы перестаем прибывать. И, боясь грядущих слез, стараемся не смеяться сейчас.', 43);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (17, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture029.jpg', '⠀⠀<strong>О</strong>дна моя приятельница взяла троих своих детей и решила перебраться на маленькую ферму в канадском захолустье, чтобы без помехи предаваться там только и исключительно духовному созерцанию.
⠀⠀Но не прошло и года, как она влюбилась, снова вышла замуж, овладела техникой медитации, добилась, одолев немалые трудности, открытия школы, обзавелась друзьями и недругами, перестала неукоснительно следить за тем, в каком состоянии у нее зубы, получила абсцесс, в метель ловила попутную машину, научилась сама чинить свой автомобиль, отогревать замерзшие канализационные трубы, жить на пособие по безработице, спать в комнате без центрального отопления, смеяться без причины, плакать от отчаянья. Она выстроила церковь, отремонтировала дом, оклеила новыми обоями стены, проводила занятия по духовному созерцанию.
⠀⠀– И поняла в конце концов, что жизнь в молитве вовсе не означает отъединенности и затворничества, – призналась она. – Господня любовь так неимоверно велика, что ею непременно надо поделиться с другими.', 17);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (18, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture030.jpg', '⠀⠀– <strong>П</strong>ри начале своего пути, – сказал учитель, – увидишь ты дверь, а на ней будут написаны некие слова. Вернись тогда и скажи мне, что это за слова.
⠀⠀И ученик устремил все силы тела и души на поиски заветной двери. И вот однажды нашел ее и вернулся к своему наставнику.
⠀⠀– При начале пути я увидел слова: «Это невозможно».
⠀⠀– Это было написано на стене или на двери? – спросил наставник.
⠀⠀– На двери.
⠀⠀– Тогда возьмись за ручку, поверни ее и войди.
⠀⠀Ученик так и сделал. Надпись была на филенке двери и, стало быть, сдвинулась вместе с нею. А когда дверь открылась полностью, ее стало не видно и ученик смело шагнул вперед.', 18);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (19, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture031.jpg', '⠀⠀<strong>Г</strong>оворит наставник:
⠀⠀– Закрой глаза. А впрочем, это даже и необязательно. Достаточно всего лишь представить себе стаю летящих птиц. Представил? Теперь скажи мне, скольких ты заметил – пять? Одиннадцать? Семнадцать?
⠀⠀Каков бы ни был твой ответ – а точное число птиц определить трудно – одно в этом маленьком эксперименте будет совершенно ясно. Ты смог вообразить себе стаю птиц, но определить их количество тебе оказалось не под силу. А между тем эта картина была точной, ясной, определенной. И где-то существует ответ на этот вопрос. Кто же определил, сколько птиц должно будет появиться перед твоим мысленным взором? Уж во всяком случае, не ты.', 19);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (22, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture034.jpg', '⠀⠀<strong>В</strong> ту пору, когда странник практиковал дзен-буддизм, его наставник как-то раз ушел в угол додзо (место, где собираются ученики) и вернулся с бамбуковой палкой. Кое-кто из тех учеников, которые не сумели сосредоточиться, подняли руку, и наставник, приблизившись, трижды ударил каждого из них по плечу.
⠀⠀В первый день страннику это показалось нелепым пережитком средневековья. Но вслед за тем он понял, что необходимо перевести духовную боль в физическую, чтобы въяве ощутить ее неприятные последствия. Следуя Путем Сантьяго, он научился такому упражнению – всякий раз, как мысли его принимали предосудительный оборот, в мякоть ладони у основания большого пальца он с силой вонзал ноготь указательного. Ужасающие последствия недостойных помыслов обнаруживаются значительно позже, однако, делая так, чтобы они, переведенные в физический план, причиняли боль, мы сознаем весь тот вред, которые они нам причиняют. И постепенно научаемся избегать их.', 22);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (24, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture036.jpg', '⠀⠀<strong>В</strong> Древнем Риме колдуньи-прорицательницы, которых называли Сивиллами, написали девять книг, где предрекли будущность страны.
⠀⠀Книги принесли императору Тиберию.
⠀⠀– Сколько они стоят? – осведомился тот.
⠀⠀– Сто золотых, – отвечали Сивиллы.
⠀⠀Император в гневе прогнал их прочь. Сивиллы сожгли три книги и вернулись, запросив прежнюю цену.
⠀⠀Тиберий расхохотался и отказался: зачем платить за шесть книг столько же, сколько стоили девять?
⠀⠀Тогда Сивиллы предали огню еще три книги, а с тремя оставшимися вновь пришли во дворец:
⠀⠀– Эти три книги стоят сто золотых.
⠀⠀И Тиберий, подстрекаемый любопытством, в конце концов уступил – однако о том, какая судьба ожидает Рим, узнал далеко не все.', 24);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (25, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture037.jpg', '⠀⠀<strong>С</strong>лова Руфуса Джонса:
⠀⠀– Я не собираюсь строить новые Вавилонские башни, обосновывая это желанием непременно добраться до Бога.
⠀⠀Это – отвратительные сооружения: одни возведены из бетона и кирпича, другие – из священных скрижалей. Иные – из древних обрядов, а многие – из новейших научных доказательств бытия Божьего.
⠀⠀И все эти башни, заставляющие нас подниматься по ним от темного и одинокого подножья, могут, пожалуй, дать нам представление о Земле, но не помогают достичь Неба.
⠀⠀И мы не достигнем ничего, кроме все того же древнего смешения языков и эмоций.
⠀⠀Ибо к Богу ведут – вера, любовь, радость и молитва.', 25);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (26, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture038.jpg', '⠀⠀<strong>В</strong> нацистской Германии двое раввинов пытались по мере сил даровать духовное успокоение своим единоверцам.
⠀⠀На протяжении двух лет, умирая со страху, они все же умудрялись обманывать своих гонителей – и отправляли религиозные таинства в нескольких общинах.
⠀⠀Но пришел день, когда обоих все же арестовали. Один в ужасе от того, что грозило ему, молился не переставая. Другой же, напротив, целыми днями спал.
⠀⠀– Почему ты спишь все время? – спросил его первый.
⠀⠀– Силы берегу. Знаю, они мне скоро понадобятся, – отвечал второй.
⠀⠀– Разве тебе не страшно? Или ты не знаешь, что нас ждет?
⠀⠀– Было страшно, пока не схватили. А что толку бояться теперь, когда мы сидим за решеткой и все уже случилось?!
⠀⠀Время страха миновало; пришло время надежды. Ибо к Богу ведут – вера, любовь, радость и молитва.', 26);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (28, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture040.jpg', '⠀⠀<strong>Г</strong>оворит наставник:
⠀⠀– Желание. Вот слово, которое мы должны на какое-то время взять под подозрение.
⠀⠀Чего мы не делаем оттого, что не хотим, а чего – потому, что просто опасаемся и не желаем рисковать?
⠀⠀Так, например, мы путаем наши опасения с нежеланием вступать в разговор с незнакомыми. Будь то простая беседа, душевное излияние или обмен несколькими ничего не значащими словами, мы редко разговариваем с незнакомыми.
⠀⠀И неизменно считаем, что «так оно лучше будет».
⠀⠀И в конце концов получается, что мы не приходим на помощь Жизни, а она не помогает нам.
⠀⠀Наша отчужденность позволяет нам чувствовать себя более важными, более значительными, более уверенными в себе. Но на самом деле мы просто не позволяем себе услышать, как устами незнакомца говорит с нами наш ангел-хранитель.', 28);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (29, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture041.jpg', '⠀⠀<strong>О</strong>дного престарелого отшельника пригласили как-то раз ко двору самого могущественного в ту пору короля.
⠀⠀– Завидую человеку святой жизни, умеющему довольствоваться столь малым, – сказал ему властелин.
⠀⠀– А я завидую вашему величеству, ибо вы довольствуетесь еще меньшим, – отвечал на это пустынник.
⠀⠀– Как понимать твои слова? – удивился и обиделся король. – Ведь вся эта страна принадлежит мне.
⠀⠀– Чистая правда. А мне принадлежат музыка небесных сфер, все, сколько ни есть их на свете, реки и горы, лунный свет и сияние солнца. Ибо у меня в душе – Бог. А у вашего величества нет ничего, кроме этого королевства.', 29);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (218, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture230.jpg', '⠀⠀<strong>Г</strong>оворит наставник:
⠀⠀– Каждый из нас знает, как наилучшим образом сделать свою работу. Лишь тот, кому дано поручение, знает, с какими трудностями столкнется он при выполнении его.', 218);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (30, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture042.jpg', '⠀⠀– <strong>П</strong>оедем-ка на ту гору, где живет Бог, – сказал один всадник своему другу. – Хочу доказать, что Он только и умеет, что требовать от нас молитв, и ничем не желает облегчить нам наше бремя.
⠀⠀– Поедем, – согласился другой. – Покажу тебе, сколь крепка моя вера.
⠀⠀И когда к вечеру они достигли вершины, прозвучал из темноты голос:
⠀⠀– Наберите камней с земли, нагрузите ими своих коней.
⠀⠀– Нет, ты слышал?! – воскликнул в негодовании первый всадник. – Мы и так-то еле добрались сюда, а он хочет навязать нам еще большее бремя! Ни за что не стану взваливать на спину моему коню какие-то булыжники! Нет и нет!
⠀⠀А второй повиновался и сделал то, что повелел Бог. Они завершили спуск уже на рассвете, и когда в первых лучах солнца засверкали камни, которые взял с собой благочестивый всадник, ибо то были бриллианты чистейшей воды.', 30);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (31, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture043.jpg', '⠀⠀<strong>Г</strong>оворит наставник:
⠀⠀– Решения, которые принимает Бог, исполнены тайны, но всегда и неизменно оказываются в нашу пользу.', 31);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (32, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture044.jpg', '⠀⠀<strong>Г</strong>оворит наставник:
⠀⠀– Мой дорогой, я должен поведать тебе такое, чего ты, скорей всего, еще не знаешь. Я хотел смягчить это известие, хотел раскрасить его в яркие цвета, хотел наполнить его обещаниями райского блаженства, видениями Абсолюта, эзотерическими толкованиями, но, хоть все это имеется, в данном случае не годится. Итак, вздохни поглубже и приготовься. Буду предельно откровенен и прям и еще хочу добавить, что совершенно уверен в достоверности того, что собираюсь сообщить тебе. Истина, открывшаяся мне, не оставляет места сомнениям.
⠀⠀А заключается она вот в чем: ты умрешь.
⠀⠀Может быть, это случится завтра, может быть – через пятьдесят лет, но случится всенепременно. Вне зависимости от твоего согласия. Вне зависимости от того, что у тебя могут быть другие планы. Так что подумай хорошенько над тем, что будешь делать сегодня. И завтра. И весь отпущенный тебе срок.', 32);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (34, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture046.jpg', '⠀⠀<strong>Б</strong>елый путешественник, стремясь поскорее добраться до цели в дебрях Африки, заплатил своим носильщикам и проводникам больше, чем обещал, с тем условием, что они поторопятся.
⠀⠀И в течение нескольких дней туземцы шли скорым шагом. Но однажды вечером вдруг скинули кладь, уселись наземь и заявили, что дальше не пойдут. Сколько бы денег им ни предлагали, они отказывались продолжать путь. И когда путешественник стал допытываться до причин такого поведения, то получил следующий ответ:
⠀⠀– Мы шли так быстро, что теперь даже сами не понимаем, что делаем. Надо подождать, когда наши души нас нагонят.', 34);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (35, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture047.jpg', '⠀⠀<strong>О</strong>днажды Пречистая Дева, держа на руках младенца Христа, решила спуститься на землю и посетить некую монашескую обитель.
⠀⠀Исполненные гордости монахи выстроились в ряд: каждый по очереди выходил к Богоматери и показывал в ее честь свое искусство: один читал стихи собственного сочинения, другой демонстрировал глубокие познания Библии, третий перечислил имена всех святых. И так братия в меру сил своих и дарований чествовала Деву и младенца Иисуса.
⠀⠀Последним оказался убогий монашек, который не мог даже затвердить наизусть текстов Священного Писания. Родители его были люди необразованные, выступали в цирке, и сына научили только жонглировать шариками и прочим фокусам Когда дошел черед до него, монахи хотели прекратить церемонию, ибо бедный жонглер ничего не мог сказать Пречистой Деве, а вот опозорить обитель – вполне. Но он всей душой чувствовал настоятельную необходимость передать Деве и Младенцу частицу себя.
⠀⠀И вот, смущаясь под укоризненными взглядами братии, он достал из кармана несколько апельсинов и принялся подбрасывать их и ловить.
⠀⠀И тогда на устах младенца появилась улыбка. Пречистая Дева доверила жонглеру подержать Его на руках.', 35);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (36, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture048.jpg', '⠀⠀<strong>Н</strong>е старайся всегда поступать разумно. Ибо разве не сказал Святой Павел, что «мирская мудрость есть безумие перед Господом»?
⠀⠀Быть разумным – значит всегда носить галстук, да притом – подходящий по тону к носкам. Это значит – завтра иметь те же воззрения, что и сегодня. А как тогда быть с извечной переменчивостью мира?
⠀⠀И если ты никого не осуждаешь, меняй время от времени свои взгляды, вступай в противоречие с самим собой и не стыдись этого.
⠀⠀У тебя есть это право. Не заботься о том, что подумают окружающие. Пусть думают, что хотят.
⠀⠀И потому успокойся. Пусть Вселенная движется вокруг тебя, открой для себя радость поступков, неожиданных для тебя самого. «Бог избрал немудрое мира, чтобы посрамить мудрых», – сказал апостол Павел.', 36);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (37, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture049.jpg', '⠀⠀<strong>Г</strong>оворит наставник:
⠀⠀– В такой день, как сегодня, хорошо сделать что-нибудь из ряда вон выходящее.
⠀⠀Например, возвращаясь домой с работы, пуститься в пляс на улице. Взглянуть в глаза незнакомому человеку и объясниться ему в любви. Подать начальнику идею, которая может показаться смехотворно-нелепой, но в которую мы верим. Купить музыкальный инструмент, на котором тебе всегда хотелось играть, да ты все никак не отваживался. Воины Света позволяют устраивать себе иногда такие дни.
⠀⠀И сегодня можем выплакать кое-какие давние горести, которые комком застряли в горле. Можем позвонить тому, с кем торжественно поклялись никогда больше не знаться. Сегодняшний день пойдет наперекор расписанию, составленному утром.
⠀⠀Сегодня допустима и простительна любая выходка. Сегодня – день веселья и радости жизни.', 37);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (38, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture050.jpg', '⠀⠀<strong>О</strong>днажды ученый Роджер Пенроуз шел в компании друзей, ведя оживленную беседу.
⠀⠀Замолчали они лишь на минутку, пока переходили улицу.
⠀⠀– И в этот миг, – вспоминает Пенроуз, – меня осенила необыкновенная мысль. А когда оказались на противоположном тротуаре и возобновили разговор, я уже не смог вспомнить, о чем думал всего секунду назад.
⠀⠀А в конце дня Пенроуз стал испытывать странное, беспричинное и безотчетное ликование.
⠀⠀– У меня возникло ощущение, будто открылось нечто необычайно важное.
⠀⠀Он по минутам принялся перебирать в памяти весь минувший день и когда дошел до перехода улицы – идея вернулась. На этот раз он сумел записать ее.
⠀⠀Это была гипотеза происхождения «черных пятен», теория, совершившая подлинный переворот в современной физике. И появилась она потому лишь, что ученый сумел вспомнить тишину, наступившую, когда ученый с друзьями переходили дорогу.', 38);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (39, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture051.jpg', '⠀⠀<strong>К</strong> Святому Антонию, жившему в пустыне, пришел некий юноша и сказал так:
⠀⠀– Отче, я распродал все имение свое и роздал деньги бедным. Оставил при себе лишь то немногое, чтобы выжить здесь. Мне хотелось бы, чтобы ты указал мне путь к спасению.
⠀⠀Святой отшельник сказал юноше продать и оставшееся имущество, а на вырученные деньги купить в городе мяса. И чтобы тот, возвращаясь в скит, привязал мясо к своему телу.
⠀⠀Юноша так и сделал, но на обратном пути набросились на него бродячие собаки и хищные птицы, пытавшиеся добыть себе хоть кусочек.
⠀⠀– Я вернулся, – сказал он, указывая на свою в клочья разодранную одежду и израненное тело.
⠀⠀– Знай: тот, кто совершает новый шаг, не избавившись полностью от прежней жизни, непременно будет истерзан своим же собственным прошлым, – таков был ответ святого.', 39);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (40, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture052.jpg', '⠀⠀<strong>Г</strong>оворит наставник:
⠀⠀– Пользуйся всем, что послал тебе сегодня Господь. Благодать его щедрот не надо экономить. Нет на свете такого банка, куда можно положить на счет полученные от Него дары, чтобы потом воспользоваться ими в свое время и по своему усмотрению. Не применишь к делу – потеряешь их навсегда.
⠀⠀Господь знает, что все мы – художники, созидающие собственную жизнь: сегодня – резцом высекая ее из камня, завтра – красками запечатлевая на полотне, послезавтра – чернилами по бумаге описывая ее. Но никому еще не удавалось использовать резец для холстов, перо – для скульптуры.
⠀⠀У каждого дня – свое чудо. Прими дарованную тебе благодать, трудись и создавай ежедневное произведение искусства. Завтра получишь новый дар.', 40);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (41, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture053.jpg', '', 41);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (42, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture054.jpg', '⠀⠀<strong>М</strong>онастырь на берегу Рио-Пьедра окружен пышной и свежей зеленью – настоящий оазис посреди бесплодных полей этой части Испании. Там маленькая речушка превращается в бурный и полноводный поток, образующий десятки водопадов.
⠀⠀Странник проходит по этим местам, слушая музыку вод. И вот внезапно внимание его привлекает пещера под одним из водопадов. И он внимательно оглядывает отшлифованный временем камень – прекрасные скульптуры, терпеливо созидаемые природой. И замечает выбитые на плите слова Рабиндраната Тагора:
⠀⠀«Не молоток и резец придали совершенную форму этим камням, но вода – ее мягкость, ее танец, ее напев. Там, где сила может лишь разрушать, мягкость способна ваять».', 42);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (44, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture056.jpg', '⠀⠀<strong>К</strong>ак-то раз в монастыре Сцета один монах прилюдно, на глазах у всей братии, обидел другого.
⠀⠀Настоятель обители, аббат Сисоис, попросил пострадавшего простить своего обидчика.
⠀⠀– Да ни за что на свете! – отвечал тот. – Он сделал это и он за это заплатит!
⠀⠀И в ту же минуту настоятель воздел руки к небу и принялся молиться:
⠀⠀– Иисусе, мы больше не нуждаемся в Тебе. Отныне нам по силам сполна взыскивать с обидчиков наших. Мы способны взять отмщение в собственные руки и сами теперь отличаем, где Добро, а где Зло. Так что ты, Господи, можешь удалиться от нас подобру-поздорову.
⠀⠀И пристыженный монах тотчас простил оскорбившего его собрата.', 44);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (45, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture057.jpg', '⠀⠀– <strong>В</strong>се наставники внушают нам, что духовное сокровище возможно обрести только в одиночку. Отчего же мы, ученики, всегда держимся вместе?
⠀⠀– Оттого, что лес заведомо сильней одного дерева, – сказал на это учитель. – В лесу можно спасись от изнурительного зноя, лес лучше противостоит урагану, лес помогает почве сохранить плодородие. Дерево сильно корнем, а он у каждого – свой. И корень одного дерева не в силах помочь другому расти.
⠀⠀Вы держитесь вместе, но каждый из вас растет и развивается по-своему. Именно таков путь тех, кто хочет приобщиться к Богу.', 45);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (46, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture058.jpg', '⠀⠀<strong>К</strong>огда страннику было десять лет от роду, мать заставляла его усиленно заниматься физическими упражнениями.
⠀⠀И одно из них заключалось в том, чтобы спрыгнуть с моста в реку. Мальчик умирал от страха. Он стоял в шеренге последним и каждый раз, как кто-нибудь выходил вперед, несказанно мучился, предвидя, что скоро настанет и его черед совершить прыжок. И однажды тренер, заметив его страх, вызвал его первым. Страх был прежним, но зато он кончился так скоро, что превратился в отвагу.', 46);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (47, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture059.jpg', '', 47);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (48, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture060.jpg', '⠀⠀<strong>Ч</strong>асто случается так, что мы должны выжидать и медлить. А часто приходится засучить рукава и решить проблему, не откладывая.
⠀⠀В таких ситуациях промедление губительно.', 48);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (49, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture061.jpg', '⠀⠀<strong>О</strong>днажды утром, когда Будда собрал вокруг себя учеников, к нему приблизился какой-то человек и спросил:
⠀⠀– Бог существует?
⠀⠀– Существует, – ответил Будда.
⠀⠀После обеда подошел другой человек и тоже осведомился:
⠀⠀– Бог существует?
⠀⠀– Нет, – ответил Будда.
⠀⠀И ближе к вечеру третий человек задал ему тот же самый вопрос:
⠀⠀– Бог существует?
⠀⠀– Это тебе решать, – ответил Будда.
⠀⠀– Учитель, что за нелепость! – воскликнул тогда один из его учеников. – Как ты можешь давать на один и тот же вопрос три разных ответа?!
⠀⠀– Так ведь и люди-то все разные, – ответил Будда. – И каждый приходит к Богу своим путем: один – благодаря непреложной убежденности, другой – преодолев неверие, третий – ведомый сомнением.', 49);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (60, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture072.jpg', '⠀⠀<strong>Н</strong>аставник встретился со своим любимым учеником и спросил, как подвигается его духовное совершенствование. Тот ответил, что ему удается теперь посвящать Богу каждую минуту.
⠀⠀– Что ж, тогда тебе остается лишь простить своих врагов, – сказал наставник.
⠀⠀Ученик в глубоком изумлении обернулся к нему:
⠀⠀– Зачем? Я не испытываю к ним гнева!
⠀⠀– Как ты думаешь, гневается ли на тебя Господь?
⠀⠀– Конечно нет!
⠀⠀– Но тем не менее ты ведь просишь: «Господи, прости!» Поступай точно так же и по отношению к своим врагам, даже если не чувствуешь к ним ненависти. Благоуханная влага прощения омывает сердце прощающего.', 60);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (50, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture062.jpg', '⠀⠀<strong>В</strong>се мы озабочены тем, чтобы действовать, принимать решения, предвидеть будущее. Мы вечно пытаемся одно спланировать, другое – завершить, третье – открыть и определить.
⠀⠀Что ж, все правильно: ведь в конце концов именно так мы создаем и изменяем мир. Но непременной частью нашего бытия должно стать Поклонение.
⠀⠀Надо время от времени останавливаться, отрешаться от самих себя, постоять в молчании перед ликом Вселенной.
⠀⠀Преклонить колени – и в буквальном смысле, и в метафизически-фигуральном. Не просить, не думать, даже ни за что не благодарить. А просто постараться воспринять безмолвную любовь, обволакивающую нас. И в такие мгновения могут пролиться несколько нежданных слезинок – не с горя и не с радости.
⠀⠀Не удивляйся им. Это – Божий дар. Они омывают твою душу.', 50);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (70, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture082.jpg', '⠀⠀<strong>Г</strong>оворит наставник:
⠀⠀– Мы всегда озабочены поисками ответов, мы считаем это чем-то очень важным и необходимым для постижения смысла жизни.
⠀⠀Меж тем гораздо важнее просто жить – жить полно и насыщенно, и пусть само время откроет нам тайны нашего бытия. Если будем чрезмерно доискиваться смысла, мы не сумеем дать природе действовать и проявляться, а сами окажемся неспособны прочесть Божьи знаки.', 70);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (51, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture063.jpg', '⠀⠀<strong>Г</strong>оворит наставник:
⠀⠀– Если придется плакать – плачь, как плачут дети.
⠀⠀Ты сам некогда был ребенком и едва ли не прежде всего остального в жизни научился плакать. Слезы – неотъемлемая часть жизни. Никогда не забывай, что ты – свободен, а проявлять свои эмоции не стыдно.
⠀⠀Кричи, рыдай в голос, реви, если захочешь – ибо именно так плачут дети, владеющие секретом быстро избывать в слезах свое горе и успокаиваться.
⠀⠀Ты ведь наверняка видел, как дети прекращают плач?
⠀⠀Они заливаются слезами – и вдруг что-то отвлекает их, а новое житейское приключение приковывает к себе их внимание.
⠀⠀И они мгновенно стихают.
⠀⠀И то же будет с тобою – но только если ты и плакать будешь, как плакал когда-то, когда был ребенком.', 51);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (52, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture064.jpg', '⠀⠀<strong>С</strong>транник обедает со своей приятельницей – она адвокат из Форт-Лодердейл.
⠀⠀За соседним столиком очень пьяный и оттого возбужденный человек навязчиво пытается завязать с ними разговор. Потеряв наконец терпение, дама просит его утихомириться.
⠀⠀– С какой стати? – недоумевает он. – Я говорю о любви так, как ни один трезвый не скажет! Мне весело, я пытаюсь общаться с незнакомыми… Что тут плохого?! Что не так?
⠀⠀– Сейчас не время… – урезонивает его моя приятельница.
⠀⠀– То есть, вы хотите сказать, что для демонстрации счастья должно быть отведено особое время?!
⠀⠀И после этой фразы пьяного приглашают пересесть за тот стол, куда он так стремился.', 52);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (53, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture065.jpg', '⠀⠀<strong>Г</strong>оворит наставник:
⠀⠀– Мы должны заботиться о своем теле – оно есть храм Святого Духа, а потому заслуживает, чтобы его уважали и ублажали.
⠀⠀Мы должны сполна использовать отведенное нам время – нужно бороться за исполнение своей мечты и собрать для этого все силы.
⠀⠀Но не следует и забывать, что жизнь состоит из маленьких радостей. Они присутствуют в ней, чтобы стимулировать нас, помогать нашему поиску, давать нам мгновения передышки в наших ежедневных и повседневных битвах.
⠀⠀И нет никакого греха в том, чтобы испытывать счастье. И ничего неправильного нет в том, чтобы порою преступать установленные нами правила – как питаться, как спать, как быть счастливым.
⠀⠀И не вини себя, если порой потратишь сколько-то времени на всякий вздор. Эти маленькие удовольствия обладают огромным стимулирующим эффектом.', 53);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (61, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture073.jpg', '⠀⠀<strong>В</strong> молодости Наполеон дрожал как осиновый лист во время жестоких бомбардировок Тулона.
⠀⠀Один из солдат, заметив это, сказал другим:
⠀⠀– Смотрите, он ни жив ни мертв со страху!
⠀⠀– Да, это так, – ответил Наполеон. – Но продолжаю сражаться. Если бы тебе было вполовину так страшно, как мне, ты давно бы уж удрал без оглядки.', 61);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (54, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture066.jpg', '⠀⠀<strong>П</strong>окуда наставник странствовал, распространяя слово Божие, дом, где он жил со своими учениками, сгорел.
⠀⠀– Он нам доверил его, а мы не сумели сберечь, – сетовал один из них.
⠀⠀И они немедля принялись восстанавливать все, что уцелело от пламени, но тут вернулся наставник и увидел их работу.
⠀⠀– Ага, – обрадовался он. – Наши дела идут на лад – новый дом!
⠀⠀Пристыженный ученик рассказал ему тогда, как было дело: дом, в котором все они жили, был разрушен огнем.
⠀⠀– Не понимаю, о чем ты толкуешь, – ответил наставник. – Вижу людей, что, исполняясь веры в жизнь, начали новый ее этап. Те, кто потерял единственное свое достояние, находятся в лучшем положении, нежели все остальные: ибо с этой минуты они будут лишь приобретать.', 54);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (55, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture067.jpg', '⠀⠀<strong>П</strong>ианист Артур Рубинштейн опаздывал на званый обед в одном из фешенебельных нью-йоркских ресторанов. Друзья уже начали было беспокоиться – как вдруг он наконец появился об руку с очаровательной блондинкой, которая была примерно втрое моложе знаменитого музыканта.
⠀⠀Маэстро, известный тем, что он был человек весьма прижимистый, в этот день заказывал самые дорогие блюда, самые изысканные и редкие вина. И в конце обеда заплатил по счету с улыбкой.
⠀⠀– Знаю, – сказал он своим сотрапезникам, – знаю, что вы удивлены. Но дело в том, что сегодня я был у нотариуса и оформил свое завещание. Выделил значительную долю дочери, оставил немалую толику прочим родственникам, щедро пожертвовал на благотворительность. И вдруг осознал – себя самого-то я не включил в список наследников! Все теперь принадлежит другим!
⠀⠀И с этой минуты решил относиться к себе более великодушно, чем прежде.', 55);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (56, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture068.jpg', '⠀⠀<strong>Г</strong>оворит наставник:
⠀⠀– Когда следуешь стезей своей мечты, исполняй свои обязательства перед нею. Не оставляй себе лазейки, не отговаривайся тем, что это, мол, не вполне то, что ты хотел.
⠀⠀Эта фраза несет внутри себя семя поражения.
⠀⠀Иди своим путем. Даже если должен будешь сделать неверный шаг, даже если будешь знать, что смог бы сделать то, что делал, лучше. Если ты примешь свои возможности в настоящем, это, без сомнения, пригодится тебе в будущем.
⠀⠀А вот если отвергать свои ограничения, нипочем не сумеешь избавиться от них.
⠀⠀Будь отважен, двигаясь своим путем. Не бойся, что другие будут порицать тебя. И – главное – сумей не впасть в столбняк и оцепенение, порицая себя сам.
⠀⠀Господь пребудет с тобой в твоих бессонных ночах и осушит Своей любовью твои непролитые слезы.
⠀⠀Ибо Господь есть Господь отважных.', 56);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (57, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture069.jpg', '⠀⠀<strong>Н</strong>аставник как-то раз попросил своих учеников раздобыть еды. Они странствовали и питались впроголодь. Ученики разошлись и вернулись к вечеру. Каждый нес то, что подали ему добрые люди: подгнившие плоды, черствый хлеб, скисшее вино.
⠀⠀Но один из них, как ни странно, раздобыл целый мешок спелых яблок.
⠀⠀– Я сделал все возможное, чтобы накормить моего учителя и моих собратьев, – сказал он, оделяя каждого.
⠀⠀– Где же ты раздобыл это? – осведомился наставник.
⠀⠀– Украл, – ответил ученик. – Люди давали мне только всякую дрянь, хоть и знали, что мы распространяем по свету слово Божье.
⠀⠀– Забери свои яблоки, уходи отсюда и никогда больше не возвращайся, – сказал тогда наставник. – Тот, кто ворует ради меня, когда-нибудь обворует и меня.', 57);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (58, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture070.jpg', '⠀⠀<strong>М</strong>ы выходим в мир в поисках наших мечтаний и ради осуществления наших идей. И очень часто помещаем в недоступные места то, что должно быть совсем рядом – только руку протяни. А, осознав свой промах, чувствуем, что теряем время, отыскивая вдали то, что лежит близко. И виним себя за неверный шаг, за поиски, не увенчавшиеся находкой, за причиненные самим себе разочарования.', 58);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (62, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture074.jpg', '⠀⠀<strong>Г</strong>оворит наставник:
⠀⠀– Страх не есть признак трусости.
⠀⠀Но то, что дает нам возможность действовать в сложных ситуациях, на которые так богата жизнь, с отвагой и достоинством. Тот, кто испытывает страх, но, несмотря на это, продолжает идти вперед, не позволяя себе поддаться робости, преодолевая свое малодушие, достоин называться храбрецом. А тот, кто ввязывается в опасное дело, не давая себе отчета в том, какому риску подвергает себя, – всего лишь безответственен.', 62);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (63, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture075.jpg', '⠀⠀<strong>С</strong>транник оказывается на празднике Святого Иоанна – палатки и лотки, балаганы и стрельба в цель, домашняя еда. И вот клоун вдруг начинает передразнивать его, повторяя все его движения. Все вокруг смеются, смеется и странник. А потом приглашает клоуна выпить по чашечке кофе.
⠀⠀– Пользуйся тем, что ты жив, – говорит он. – Если ты жив – прыгай и скачи, размахивай руками, шуми, смейся, разговаривай с людьми, ибо жизнь есть полнейшая противоположность смерти.
⠀⠀Умереть – значит навсегда остаться в одном и том же положении. Если ты тих и неподвижен, то значит, и не живешь.', 63);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (64, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture076.jpg', '⠀⠀<strong>Н</strong>екий могущественный властелин призвал к себе мужа святой жизни, – который, как уверяли люди, обладал даром исцелять недуги и хвори, – чтобы тот избавил его от болей в спине.
⠀⠀– Господь нам поможет, – сказал праведник. – Но сперва давай-ка установим причину этих болей. Признание заставляет человека пристально взглянуть на мучающие его заботы и способно освобождать от многих скорбей.
⠀⠀И он принялся расспрашивать владыку о его жизни, причем требовал всех подробностей – и о том, как обращается он со своими приближенными, и о том, что омрачает его царствование, что томит и тревожит. Царь, раздосадованный тем, что вынужден думать об этом, сказал наконец:
⠀⠀– Я не желаю больше говорить об этом! Будь добр, приведи мне кого-нибудь, кто умеет лечить, не задавая вопросов.
⠀⠀Праведник ушел и через полчаса вернулся с каким-то человеком:
⠀⠀– Вот тот, кто тебе нужен, – сказал он. – Мой друг – ветеринар. Он никогда ни о чем не расспрашивает тех, кого лечит.', 64);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (66, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture078.jpg', '⠀⠀<strong>О</strong>дин ученик спрашивал, что следует, а чего не следует есть, чтобы достичь очищения. Как ни старался наставник объяснить ему, что всякая еда – священна, ученик не желал верить этому.
⠀⠀– Обязательно должна быть еда, которая приводит нас к Богу, – настойчиво твердил он.
⠀⠀– Что ж, быть может, ты и прав. Вот, к примеру, те грибы.
⠀⠀И ученик обрадовался, решив, что грибы даруют ему духовное очищение и воодушевление. Но подойдя поближе, в ужасе отпрянул с криком:
⠀⠀– Они же ядовитые! Если съем хоть кусочек, умру не сходя с места!
⠀⠀– Но это – единственная еда, благодаря которой можно попасть в царствие небесное, – отвечал наставник.', 66);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (67, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture079.jpg', '⠀⠀<strong>В</strong> 1981 году странник прогуливался с женой по улицам Праги и увидел юношу, рисовавшего дома вокруг. Ему понравился один из рисунков, и он решил купить его.
⠀⠀И, протягивая деньги, заметил, что юноша – без перчаток, хотя на улице минус пять.
⠀⠀– Почему ты без перчаток? – спросил он художника.
⠀⠀– Чтобы можно было держать карандаш.
⠀⠀Они разговорились, и юноша предложил сделать портрет жены странника, причем – бесплатно.
⠀⠀Ожидая, когда портрет будет готов, странник вдруг осознал: он почти пять минут разговаривал с юношей, хотя ни слова не знал на его языке.
⠀⠀Они объяснялись жестами, мимикой, улыбками – и желание общения было столь велико, что сумели обойтись без слов.', 67);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (68, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture080.jpg', '⠀⠀<strong>Д</strong>руг подвел Хасана к дверям мечети, где просил милостыню нищий слепец.
⠀⠀– Это самый мудрый человек у нас в стране.
⠀⠀– Давно ли вы не видите? – спросил нищего Хасан.
⠀⠀– Я слеп с рождения, – ответил тот.
⠀⠀– Что же обогатило вас мудростью?
⠀⠀– Не смирившись со своей слепотой, я попытался стать астронавтом. Не имея возможности видеть небо, я должен был воображать звезды, солнце, планеты, галактики. И по мере того, как познавал Божье творение, я приближался к Его мудрости.
⠀⠀
⠀⠀<strong>В</strong> Испании, неподалеку от города Олите есть бар, где висит плакат, написанный его владельцем:
⠀⠀«В тот самый миг, когда я нашел верные ответы, переменились все вопросы».', 68);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (69, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture081.jpg', '', 69);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (168, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture180.jpg', '⠀⠀<strong>Д</strong>омингос Сабино сказал как-то:
⠀⠀– В конце концов все будет хорошо.
⠀⠀А если пока не хорошо – значит, ты просто еще не дошел до конца.', 168);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (169, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture181.jpg', '', 169);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (71, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture083.jpg', '⠀⠀<strong>В</strong> одной австралийской легенде рассказывается об истории колдуна, который прогуливался с тремя своими сестрами, когда к нему подошел самый знаменитый воин тех времен.
⠀⠀– Хочу жениться на одной из этих красавиц, – сказал он.
⠀⠀– Женишься на одной – заставишь страдать двух других. Я ищу такое племя, где мужчине можно иметь сразу трех жен, – отвечал колдун и удалился.
⠀⠀На протяжении многих лет бродил он по всему континенту, но никак не мог найти такое племя.
⠀⠀– По крайней мере, хоть одна из нас могла бы найти свое счастье, – сказала младшая из сестер, когда все они состарились и измучились от бесконечных блужданий.
⠀⠀– Да, я ошибся, – сказал колдун. – Но теперь уже поздно.
⠀⠀И превратил своих сестер в три огромных каменных валуна – чтобы каждый, кто проходил там, понимал: счастье одного вовсе не означает страданий других.', 71);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (72, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture084.jpg', '⠀⠀<strong>Ж</strong>урналист Вагнер Карелли взял интервью у аргентинского писателя Хорхе Луиса Борхеса.
⠀⠀А по окончании беседы заговорили о том языке, что существует помимо слов, и о том, что человек обладает невероятной способностью понимать своего ближнего.
⠀⠀– Я приведу вам пример, – сказал Борхес.
⠀⠀И заговорил на непонятном языке. А потом спросил, что это было.
⠀⠀Прежде чем Карелли успел ответить, фотограф, который сопровождал его, сказал:
⠀⠀– «Отче наш».
⠀⠀– Совершенно верно! – воскликнул Борхес. – Я прочел эту молитву по-фински.', 72);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (73, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture085.jpg', '⠀⠀<strong>Д</strong>рессировщик придумал очень простой трюк, благодаря которому ему удается держать слона в повиновении. Он привязывает маленького слоненка за ногу к крепкому дереву.
⠀⠀Слоненок, как ни старается, высвободиться не может. И вырастает, постепенно привыкая к мысли, что дерево – сильней, чем он.
⠀⠀И достаточно привязать взрослого, обладающего неимоверной силой слона веревкой к колышку, чтобы могучее животное даже не пыталось высвободиться, ибо помнит: многократные попытки ни к чему не привели.
⠀⠀В точности, как у слонов, наши ноги тоже привязаны к чему-то весьма хрупкому. Но поскольку мы с детства приучены, что это – сильнее нас, то и не осмеливаемся что-либо предпринять. И даже не подозреваем, что хватило бы одного-единственного смелого шага, чтобы обрести свободу во всей ее безграничной полноте.', 73);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (74, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture086.jpg', '⠀⠀<strong>С</strong>овершенно зряшное и бессмысленное это дело – слушать рассуждения и объяснения о том, кто такой Бог.
⠀⠀Слова звучат красиво, но, по большей части, впустую. Ведь можно проштудировать целую энциклопедию о любви, но так и не понять, что такое любовь.
⠀⠀
⠀⠀<strong>Г</strong>оворит наставник:
⠀⠀– Никому еще покуда не удалось доказать или опровергнуть факт бытия Божьего. Есть на свете такое, что должно быть проверено, а не объяснено.
⠀⠀Это, например, любовь. Это – Бог, который тоже есть любовь.
⠀⠀Вера – это волшебное чувство, открывающееся детям в том смысле, о котором говорил Иисус, уча нас, что им, детям, принадлежит царствие небесное. И Бог никогда не проникает в них через голову, но, чтобы войти, неизменно использует сердце.', 74);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (76, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture088.jpg', '⠀⠀<strong>А</strong>ббат Пастор любил повторять: аббат Жоан молился столь рьяно и часто, что теперь может уже ни о чем не тревожиться – все его страсти побеждены.
⠀⠀И слова эти достигли наконец ушей одного из мудрецов, обитавших в монастыре Сцета.
⠀⠀После ужина он позвал к себе послушников.
⠀⠀– Вы, – сказал он им, – слышали, наверно, что аббату Жоану более нет надобности одолевать искушения. Но при отсутствии борьбы душа слабеет. Давайте же попросим Господа, чтобы послал Жоану могущественное искушение.
⠀⠀А если он победит его, попросим посылать еще и еще. И когда он вновь начнет бороться с искушениями, помолимся о том, чтобы ему никогда не приходилось говорить: «Господи, избавь меня от этих бесов». Помолимся, чтобы всегда говорил так: «Господи, дай мне силы противостоять злу».', 76);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (77, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture089.jpg', '⠀⠀<strong>Е</strong>сть в сутках такой час, когда трудно различить, что вокруг тебя.
⠀⠀Это час сумерек. В этот час свет встречается с тьмой – и нет тогда ничего непреложного ясного или однозначного темного. Во многих спиритуальных обрядах этот час почитают священным.
⠀⠀Католический канон требует в шесть вечера читать «Аве Марию». В племени кечуа существует такой обычай: если ты повстречал друга под конец дня и пробыл с ним до сумерек, то обязан заново поздороваться с ним, пожелав доброго вечера.
⠀⠀В час сумерек подвергается испытанию равновесие планеты и человека. Бог, смешивая свет и тьму, желает удостовериться, что Земля продолжит вращение.
⠀⠀Если она не испугается тьмы, минет ночь – и заблещет новое солнце.', 77);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (78, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture090.jpg', '⠀⠀<strong>Н</strong>емецкий философ Шопенгауэр (1788–1860) шел как-то раз по улице Дрездена, раздумывая над волновавшими его вопросами. Внезапно он увидел сад и решил провести несколько часов за созерцанием цветов.
⠀⠀Кто-то из прохожих заметил, как странно ведет себя этот человек, и позвал полицейского.
⠀⠀– Кто вы такой? – спросил блюститель порядка.
⠀⠀Шопенгауэр смерил его взглядом и сказал:
⠀⠀– Именно это я и пытался понять, глядя на цветы. Если бы вы смогли найти ответ на мой вопрос, я был бы вам очень благодарен.', 78);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (79, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture091.jpg', '⠀⠀<strong>В</strong> поисках мудрости некий человек вздумал отправиться в горы, ибо слышал, что раз в два года там появляется Бог.
⠀⠀Первый год он питался тем, что предоставляла ему земля. Но вот кончилась еда, и пришлось возвращаться в город.
⠀⠀– Бог несправедлив! – возопил он. – Разве Он не видел, сколько времени провел я здесь, надеясь услышать Его голос?! Теперь я хочу есть и иду домой, так и не услышав его.
⠀⠀И тут появившийся невесть откуда ангел сказал ему:
⠀⠀– Бог очень хотел поговорить с тобой. Целый год Он давал тебе пропитание. И надеялся, что ты позаботишься о запасах на следующий год.
⠀⠀И что же ты посадил и взрастил? Если человек не способен получить плоды там, где живет, он не готов беседовать с Богом.', 79);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (80, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture092.jpg', '⠀⠀<strong>М</strong>ы думаем: «В самом деле, кажется ведь, что свобода человека заключается в том, чтобы выбрать себе рабство. Я работаю по восемь часов в день, а буду, если получу повышение, – по двенадцать. Я женился, и теперь у меня не остается времени на себя самого. Я искал Бога и теперь должен соблюдать посты, ходить к мессе, исполнять обряды и пр.
⠀⠀И все, что есть в этой жизни по-настоящему важное – любовь, работа, вера – в конце концов становится неподъемным бременем».
⠀⠀
⠀⠀<strong>Г</strong>оворит наставник:
⠀⠀– Только любовь поможет нам спастись. Только любовь к тому, что мы делаем на свободе.
⠀⠀Если не можем любить, лучше остановиться немедля. Иисус сказал: «Если же правый глаз твой соблазняет тебя, вырви его и брось от себя, ибо лучше для тебя, чтобы погиб один из членов твоих, а не все тело твое было ввержено в геенну». Звучит жестко и сурово. Но ведь так оно и есть.', 80);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (82, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture094.jpg', '⠀⠀<strong>Н</strong>екий отшельник постился целый год, позволяя себе поесть лишь раз в неделю.
⠀⠀И после таких усилий попросил, чтобы Господь разъяснил ему сокровенный смысл одного стиха в Священном Писании.
⠀⠀И ничего не услышал в ответ.
⠀⠀– Попусту время потратил, – сказал себе монах. – На какие жертвы пошел я во имя Бога, а он мне не отвечает! Пойду-ка лучше отсюда и пусть какой-нибудь законоучитель растолкует мне суть этого отрывка.
⠀⠀И тут появился ангел и сказал:
⠀⠀– Двенадцать месяцев поста привели всего лишь к тому, что ты уверовал, будто лучше прочих, а Господь не склоняет слуха к суетным гордецам. А когда ты смиренно согласился спросить помощи и совета у ближнего своего, Господь отправил к тебе меня.
⠀⠀И ангел объяснил монаху все, что тот хотел знать.', 82);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (189, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture201.jpg', '⠀⠀<strong>О</strong>дно из самых эффективных упражнений по ускорению внутреннего роста заключается в том, чтобы обращать внимание на все те вещи, которые мы делаем машинально – дышим, моргаем или отмечаем, что происходит вокруг.
⠀⠀Делая это, мы как бы даем волю нашему мозгу – и он работает без участия и вмешательства наших желаний. И проблемы, казавшиеся непреодолимыми, вдруг решаются сами собой.
⠀⠀А работа, представлявшаяся каторжной, вдруг выполняется почти без усилий.', 189);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (83, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture095.jpg', '⠀⠀<strong>В</strong> пятницу вечером ты приходишь домой, листаешь газеты, которые не успел просмотреть за неделю, включаешь телевизор, убрав звук, и ставишь диск с любимой музыкой.
⠀⠀Щелкая пультом, переходишь с канала на канал, пробегаешь глазами страницы газет и внимательно слушаешь музыку. В газетах нет ничего нового, все, что показывает телевизор, ты уже видел – и не по одному разу, да и музыку эту знаешь наизусть. Твоя жена занимается детьми, жертвуя лучшими годами своей жизни и не понимая толком, почему она это делает.
⠀⠀И только одно объяснение приходит ей в голову: «Жизнь такая». Но жизнь – совсем не такая. Жизнь исполнена воодушевления. Попытайся вспомнить, где ты растерял его, куда спрятал. Возьми жену и детей, иди вслед за ним, пока не поздно. Любовь никому еще не препятствовала следовать за своими мечтами.', 83);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (84, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture096.jpg', '⠀⠀<strong>В</strong> рождественский сочельник странник с женой подводят баланс истекающего года.
⠀⠀За ужином в единственном ресторанчике пиренейской деревни странник жалуется – что-то, мол, вышло не так, как хотелось и как замышлялось.
⠀⠀Жена пристально рассматривает наряженную рождественскую елку, украшающую маленький зал. Странник, сочтя, что слова его неинтересны ей, начинает говорить о другом.
⠀⠀– Какие лампочки!
⠀⠀– Да, очень красиво, – отвечает жена. – Но если приглядишься повнимательней, увидишь, что среди десятков горящих лампочек есть одна перегоревшая. Мне кажется, что вместо того чтобы воспринимать минувший год, как десятки сияющих благодатей, ты сосредоточился на той единственной лампочке, которая ничего не освещает.', 84);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (86, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture098.jpg', '⠀⠀– <strong>В</strong>идишь на дороге вон того смиренного праведника? – спрашивает один демон другого. – Сейчас я подойду и овладею его душой.
⠀⠀– Он не услышит тебя, – отвечает второй демон. – Ибо обращает внимание только на то, что свято для него.
⠀⠀Но первый, полный самомнения, принял облик архангела Гавриила и явился перед праведником.
⠀⠀– Пришел помочь тебе, – сказал он.
⠀⠀– Ты, наверно, принял меня за кого-то другого, – отвечал праведник. – Ибо я не сделал в своей жизни ничего такого, чтобы заслужить явления архангела.
⠀⠀И пошел своей дорогой, сам того не зная, что избежал подстроенной ему ловушки.', 86);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (87, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture099.jpg', '⠀⠀<strong>А</strong>нжела Понтуал была в театре на Бродвее и в антракте вышла в фойе.
⠀⠀Там было много народу – люди курили, разговаривали, выпивали.
⠀⠀Никто не слушал игравшего на рояле пианиста. Анжела стала пить и слушать музыку. Пианист играл безо всякого воодушевления, словно отбывал скучную повинность и думал: «Поскорее бы дали звонок!»
⠀⠀Выпив третью порцию виски и немного охмелев, Анжела приблизилась к пианисту и гаркнула:
⠀⠀– Почему вы не играете только для себя!?
⠀⠀Пианист поглядел на нее в изумлении, но уже в следующий миг стал играть то, что хотелось слышать ему самому. И уже очень скоро в фойе наступила мертвая тишина.
⠀⠀А когда он кончил, все восторженно зааплодировали ему.', 87);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (88, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture100.jpg', '⠀⠀<strong>С</strong>вятой Франциск Ассизский был еще очень молод, но уже весьма известен, когда решил все бросить и возвести свою постройку.
⠀⠀Святая Клара была в расцвете своей красоты, когда принесла обет целомудрия.
⠀⠀Святой Раймундо Лил водил дружбу с виднейшими интеллектуалами своего времени, когда оставил свет и удалился в пустыню.
⠀⠀Ибо духовный поиск – это, помимо всего прочего, еще и вызов. И тот, кому он нужен для бегства от своих проблем, недалеко уйдет.
⠀⠀И совершенно незачем удаляться от мира тому, кто не сумел обзавестись друзьями. Не имеет смысла давать обет бедности человеку, не способному заработать себе на пропитание. Что проку быть смиренным, если ты робок и малодушен?
⠀⠀Одно дело – чем-то обладать и от этого отказаться. И совсем другое – ничего не иметь, но осуждать имеющих. И нет ничего проще, чем жить в чистоте и целомудрии, если ты лишен мужской силы. Но какой в этом смысл? И в чем тогда ценность твоего отречения?', 88);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (190, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture202.jpg', '⠀⠀<strong>Г</strong>оворит наставник:
⠀⠀– Когда оказываешься в сложном положении и должен всесторонне оценить его, попробуй применить эту технику. Она требует лишь немного самодисциплины, но результаты поистине поразительны.', 190);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (89, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture101.jpg', '⠀⠀<strong>Г</strong>оворит наставник:
⠀⠀– Восславь Божье творение. Став лицом к лицу с миром, сумей победить самого себя.
⠀⠀До чего же легко быть трудным! Достаточно отойти подальше от других, и уже никогда больше не будешь страдать.
⠀⠀Не познаешь больше риска неразделенной любви, не будет ни разочарований, ни несбывшихся мечтаний.
⠀⠀Как легко быть трудным! Можно не обременять себя необходимостью отвечать на телефонные звонки, не морочить себе голову мыслями о тех, кто нуждается в нашей помощи, о добрых делах и о милосердии.
⠀⠀Как легко быть трудным! Достаточно запереться в башне из слоновой кости, чтобы никогда в жизни не пролить больше ни слезинки. Достаточно до конца дней своих жить, играя некую роль.
⠀⠀Как легко быть трудным! Достаточно отрешиться и выбросить из своей жизни все самое лучшее, что есть в ней.', 89);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (90, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture102.jpg', '⠀⠀<strong>К</strong> врачу обратился пациент:
⠀⠀– Доктор, меня мучает и томит страх, он лишает меня радости бытия.
⠀⠀– Здесь, у меня в кабинете, живет мышка, которая грызет мои книги, – отвечал врач. – Если бы я впал от этого в отчаянье, она бы спряталась от меня, а я бы занимался исключительно тем, что ловил бы ее.
⠀⠀Но вместо этого я ставлю самые важные и ценные книги в надежное место и разрешаю мышке грызть все остальные.
⠀⠀И потому мышка остается мышкой и не превращается в монстра. Постарайтесь и вы найти что-то такое, чего будете бояться, и сосредоточьте весь свой страх на этом «что-то», и тогда ко всему остальному сможете относиться без боязни.', 90);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (92, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture104.jpg', '⠀⠀<strong>Г</strong>оворит наставник:
⠀⠀– Часто бывает так, что любить легче, нежели быть любимым.
⠀⠀Нам трудно принимать помощь и поддержку от других. Наши попытки казаться независимыми не позволяют дать ближнему возможность выказать свою любовь.
⠀⠀Многие люди в старости лишают своих детей этой самой возможности – возможности дать ту же самую ласку и заботу, какие те получали от родителей, пока росли.
⠀⠀Многие мужья (и жены), настигнутые ударами судьбы, стыдятся зависеть от другого. И из-за этого волны любви не распространяются.
⠀⠀Надо принимать от ближнего душевное движение, продиктованное любовью.
⠀⠀Надо, чтобы кто-нибудь приходил к нам на помощь, оказывал поддержку, давал силы для того, чтобы двигаться дальше.
⠀⠀Если примем эту любовь смиренно и с чистыми помыслами, то поймем, что суть Любви – не в том, чтобы давать или получать, а в том, чтобы разделять и участвовать.', 92);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (93, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture105.jpg', '⠀⠀<strong>К</strong> Еве, гулявшей по Эдему, приблизился змей и сказал:
⠀⠀– Съешь это яблоко.
⠀⠀Ева, памятуя предупреждения и наставления Бога, отказалась.
⠀⠀– Съешь это яблоко, – настаивал змей, – ибо ты должна быть для своего мужа красивей всех.
⠀⠀– Не должна, – отвечала Ева, – потому что здесь нет женщин, кроме меня.
⠀⠀– Еще как есть! – рассмеялся змей.
⠀⠀Ева не поверила, и тогда змей подвел ее к берегу озерца.
⠀⠀– Она там, внизу. Адам прячет ее от тебя. Ева наклонилась и увидела в спокойной воде озера красивую женщину. И в тот же миг, не раздумывая, съела яблоко, предлагаемое змеем.', 93);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (94, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture106.jpg', '⠀⠀<strong>О</strong>трывки из безымянного сочинения «Письмо к сердцу»:
⠀⠀«Мое сердце, я никогда не стану осуждать тебя или порицать или стыдиться исторгнутых из тебя слов. Знаю, что ты любимое дитя Бога, и Он хранит тебя в средоточии блистающего света любви.
⠀⠀Я доверяю тебе, мое сердце. Я – всегда за тебя и на твоей стороне, я всегда буду поминать тебя в своих молитвах и просить, чтобы ты обрело помощь и поддержку, в которых нуждаешься.
⠀⠀Я верю в твою любовь, мое сердце. И верю, что ты разделишь эту любовь с тем, кто заслуживает ее или в ней нуждается.
⠀⠀Пусть мой путь станет твоим путем, чтобы мы вместе шли к Духу Святому.
⠀⠀И тебя прошу верить мне. Знай, что я люблю тебя и стараюсь дать тебе свободу, нужную для того, чтобы ты продолжало радостно биться у меня в груди. Сделаю все, чтобы ты всегда было рядом и чтобы тебя никогда не смущало и не беспокоило мое присутствие подле тебя».', 94);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (206, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture218.jpg', '⠀⠀<strong>М</strong>истики утверждают, что, когда мы двигаемся своей духовной стезей, нам очень хочется беспрерывно беседовать с Богом – и в конце концов мы не слышим Его слов, обращенных к нам.', 206);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (95, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture107.jpg', '⠀⠀<strong>Г</strong>оворит наставник:
⠀⠀– Когда мы решаемся действовать, совершенно естественно появление нежданных конфликтов. Естественно и то, что они не обходятся без ран.
⠀⠀Но раны затянутся, оставив после себя шрамы, а они – суть благодать. Они останутся с нами по гроб жизни и очень помогут нам. И если в некую минуту от тяги ли к удобной и привольной жизни, или еще по какой-то причине возникнет вдруг неодолимое желание вернуться в прошлое, достаточно лишь взглянуть на них – и желание это пройдет.
⠀⠀Шрамы покажут нам следы от кандалов, напомнят об ужасах тюрьмы – и мы продолжим движение вперед.', 95);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (96, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture108.jpg', '⠀⠀<strong>В</strong> своем Послании к коринфянам апостол Павел говорит нам, что мягкость есть одна из главнейших характеристик любви. Не забудем этого – любовь и нежность.
⠀⠀Ибо душа черствая и суровая неподатлива к длани Божией, пытающейся придать ей форму в соответствии с Божьими намерениями.
⠀⠀
⠀⠀<strong>С</strong>транник шел по неширокой дороге на севере Испании и увидел крестьянина, лежавшего в саду.
⠀⠀– Мнете цветы, – заметил ему прохожий.
⠀⠀– Вовсе нет, – отвечал тот. – Пытаюсь набраться от них нежности и мягкости.', 96);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (98, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture110.jpg', '⠀⠀<strong>Г</strong>оворит наставник:
⠀⠀– Молись ежедневно. Ничего не проси и не произноси никаких слов. Можешь даже сам не сознавать, о чем молишься, но пусть ежедневная молитва войдет в неукоснительную привычку. Если сначала будет трудно, предложи себе: «Буду молиться ежедневно со следующей недели». И каждые семь дней повторяй свое обещание.
⠀⠀И помни – ты не просто создаешь теснейшие узы с духовным миром, но еще и закаляешь волю. И благодаря определенным ритуалам и обрядам сумеешь укрепить ту дисциплину, без которой не обойтись в настоящей, то есть тяжкой житейской борьбе.
⠀⠀Но не пытайся сдвинуть свой «урок» и, не помолившись сегодня, помолиться завтра два раза. Не вздумай молиться семь раз на дню с тем, чтобы всю остальную неделю считать, будто исполнил свое задание.
⠀⠀Ибо есть на свете такое, что должно происходить в размеренном и четком ритме.', 98);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (99, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture111.jpg', '⠀⠀<strong>Н</strong>екий скверный и злой человек, окончив свой земной путь, встретил у врат преисподней ангела. И тот сказал ему:
⠀⠀– Если ты сделал в жизни хоть одно-единственное доброе дело, оно избавит тебя от вечных мук.
⠀⠀– Нет, не числится за мной ни единого доброго дела, – отвечал грешник.
⠀⠀– Подумай хорошенько, – настаивал ангел.
⠀⠀И тогда человек припомнил, что однажды шел по лесу и, заметив на тропинке паука, обошел его, чтобы не раздавить.
⠀⠀Ангел улыбнулся, и в тот же миг с небес спустилась паутинка, и грешник, ухватившись за нее, стал подниматься в райские чертоги. Другие осужденные тоже попытались воспользоваться этим, однако злой человек принялся отталкивать их, боясь, как бы нить не оборвалась. А нить как раз и лопнула, и грешник снова полетел в преисподнюю.
⠀⠀– Как жаль, – услышал он слова ангела. – Твое себялюбие обратило во зло единственное за всю твою жизнь доброе дело.', 99);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (100, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture112.jpg', '⠀⠀<strong>Г</strong>оворит наставник:
⠀⠀– Перекресток – это священное место. Там паломник должен принять решение. Именно потому боги имеют обыкновение есть и спать на перекрестках.
⠀⠀Там, где сходятся дороги, сосредотачиваются две могучие энергии – энергия избранного пути и энергия пути оставленного. Обе дороги сливаются воедино – но на кратчайший срок.
⠀⠀Паломник может отдохнуть, немного поспать и даже спросить совета у богов, живущих на скрещении дорог. Но никому не дано остаться там навсегда: если выбор сделан, надо идти вперед, не думая больше о пути, оставшемся позади.
⠀⠀Иначе перекресток станет проклятием.', 100);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (108, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture120.jpg', '⠀⠀<strong>Н</strong>екоторые магические обряды предписывают посвящать один или два дня в году (скажем, субботу или воскресенье) установлению незримой связи учеников с предметами, находящимися у них дома.
⠀⠀Они прикасаются к каждому и громко спрашивают:
⠀⠀– Мне в самом деле не обойтись без него?
⠀⠀Берут книгу с полки:
⠀⠀– Буду ли я когда-нибудь перечитывать ее?
⠀⠀Рассматривают памятные вещицы:
⠀⠀– Я и вправду считаю важным тот миг, о котором напомнит мне эта безделушка?
⠀⠀Открывают шкафы:
⠀⠀– Сколько времени прошло с тех пор, как я надевал эту вещь в последний раз? Неужели она мне нужна?', 108);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (101, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture113.jpg', '⠀⠀<strong>В</strong>о имя Истины человечество совершало самые страшные преступления.
⠀⠀Людей сжигали на кострах.
⠀⠀Уничтожали целые цивилизации.
⠀⠀Тех, кто совершал плотские грехи, держали на расстоянии. Тех, кто искал свой, особый путь, оттесняли на обочину, превращали в изгоев.
⠀⠀Одного из них во имя все той же истины распяли на кресте.
⠀⠀Но перед смертью Он оставил великое определение Истины.
⠀⠀Это – не то, что дает нам уверенность.
⠀⠀И не то, что сообщает глубину.
⠀⠀И не то, что делает человека лучше других.
⠀⠀И не то, что держит нас в темнице предрассудков.
⠀⠀Истина делает нас свободными.
⠀⠀– Познайте Истину, и Истина освободит нас, – сказал Он.', 101);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (102, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture114.jpg', '⠀⠀<strong>О</strong>дин из монахов обители в Сцете совершил тяжкий проступок. Позвали мудрейшего из отшельников, чтобы разобрать дело. Он долго отказывался, но наконец, после долгих уговоров согласился. Прежде чем начать, он взял ведро и в нескольких местах продырявил его. Потом наполнил песком и направился к монастырю.
⠀⠀Настоятель спросил, что это значит.
⠀⠀– Я пришел судить ближнего своего, – отвечал отшельник. – Мои грехи истекают из меня, как песок из этого дырявого ведра. Но поскольку я не оглядываюсь назад и не замечаю собственных грехов, то и пришел разбирать грехи другого.
⠀⠀И монахи отступились от виновного.
⠀⠀
⠀⠀<strong>Н</strong>а стене маленькой церкви в Пиренеях есть надпись: «Господи, пусть эта свеча, которую я только что зажег, не гаснет и освещает мне путь в минуты трудного выбора.
⠀⠀Да будет ее огонь тем пламенем, которым Ты выжжешь во мне себялюбие, гордыню, нечистые помыслы. Да закалит оно мое сердце и научит меня любить.', 102);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (103, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture115.jpg', '⠀⠀<strong>Я</strong> не могу проводить много времени в Твоем храме, но вместе с этой свечой оставляю здесь навсегда частицу себя. Помоги мне продолжить эту молитву в тяготах и суете повседневья. Аминь.', 103);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (104, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture116.jpg', '⠀⠀<strong>О</strong>дин из друзей странника решил провести несколько недель в Непале, в буддийском монастыре.
⠀⠀И как-то под вечер, в каком-то из многочисленных храмов обители увидел там монаха, с улыбкой восседавшего на алтаре.
⠀⠀– Чему вы улыбаетесь? – спросил он.
⠀⠀– Потому что постиг смысл бананов, – и монах, открыв сумку, извлек оттуда полусгнивший банан. – Вот жизнь, которая миновала и не была использована в нужный миг, а теперь уже слишком поздно.
⠀⠀Затем он достал из сумки зеленый банан. Показал – и снова спрятал.
⠀⠀– А это жизнь, которая еще не произошла.
⠀⠀И надо дождаться благоприятной минуты.
⠀⠀Затем достал спелый банан, очистил от кожуры, дал половину моему другу, сказав так:
⠀⠀– А это – жизнь в настоящем. Сумей прожить ее без страха.', 104);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (105, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture117.jpg', '⠀⠀<strong>Б</strong>эби Консуэло повезла сына в кино, денег у нее с собой было в обрез на билеты.
⠀⠀Мальчик, предвкушая удовольствие, поминутно спрашивал, скоро ли они наконец приедут.
⠀⠀Когда остановились перед светофором, увидели нищего, который сидел на обочине – и ничего не просил.
⠀⠀– Отдай ему все, что у тебя есть с собой, – услышала Бэби некий голос.
⠀⠀Она отвечала, что пообещала сводить сына в кино.
⠀⠀– Все деньги, – настойчиво повторил голос.
⠀⠀– Могу дать половину, мальчик пойдет один, а я подожду у входа, – сказала она.
⠀⠀Однако голос не желал вступать в пререкания:
⠀⠀– Отдай ему все.
⠀⠀Бэби было некогда объяснять сыну, что происходит: она опустила стекло и протянула нищему все деньги, какие были у нее в сумке.
⠀⠀– Бог существует, и вы доказали мне это, – сказал нищий. – Сегодня у меня день рождения. Мне было грустно, я стыдился, что все время прошу милостыню. И решил сегодня обойтись без подаяния, подумав: если Бог есть, он пошлет мне подарок.', 105);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (106, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture118.jpg', '⠀⠀<strong>Н</strong>екто проходил через деревню во время сильной грозы и увидел, что один дом объят пламенем.
⠀⠀Приблизившись, он увидел, что в горящей комнате сидит человек с уже опаленными ресницами.
⠀⠀– Эй, твой дом горит! – крикнул ему путник.
⠀⠀– Знаю, – отвечал тот.
⠀⠀– Отчего же ты не выходишь?
⠀⠀– На улице льет. А мама всегда говорила: выйдешь под дождь – можешь получить воспаление легких.', 106);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (110, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture122.jpg', '⠀⠀<strong>Г</strong>оворит наставник:
⠀⠀– Вещи наделены собственной энергией.
⠀⠀Если не пользоваться ими, они в конце концов превращаются в стоячую воду, рассадник москитов, источник гнили.
⠀⠀Надо быть внимательным и давать энергии возможность свободно циркулировать.
⠀⠀Если будешь хранить старье, то тем самым лишишь новое возможности выразить и проявить себя.
⠀⠀
⠀⠀<strong>С</strong>таринная перуанская легенда рассказывает о некоем городе, где все были счастливы. Жители его делали все, что им заблагорассудится, и прекрасно друг друга понимали.
⠀⠀Все – кроме префекта, который пребывал в печали, оттого что ничем не мог управлять.
⠀⠀Тюрьма пустовала, в суд никто не обращался, нотариальная контора прогорала, ибо слово стоило много дороже бумажки с печатью.', 110);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (111, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture123.jpg', '⠀⠀<strong>И</strong> в один прекрасный день префект привез откуда-то работяг, главную площадь городка окружили забором, из-за которого теперь днем и ночью слышно было, как стучат молотки и визжат пилы.
⠀⠀Через неделю префект пригласил всех жителей на торжественное открытие. Убрали забор, и взорам собравшихся открылась… виселица.
⠀⠀Люди стали спрашивать друг друга, зачем она тут. И обращаться к силе закона по тем делам, которые раньше решали между собой полюбовно. И выстроились очереди в нотариальную контору, чтобы оформить документы, которые раньше заменялись обыкновенным честным словом. И, убоясь закона, вновь стали слушать префекта.
⠀⠀Легенда гласит, что виселица так никогда и не была использована по назначению. Но хватило одного ее присутствия, чтобы все переменить.', 111);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (112, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture124.jpg', '⠀⠀<strong>Н</strong>емецкий психиатр Виктор Франк описал опыт своего пребывания в нацистском концлагере: «…подвергаемый унизительному наказанию узник сказал: „Ах, какое счастье, что нас не видят наши жены, мы умерли бы со стыда!” От этих слов мне вспомнилось лицо моей жены, и меня точно отбросило от этого ада. Вернулось желание жить, и я понял, что человек живет любовью, и только в любви – его спасение.
⠀⠀И вот, пребывая в этих муках, я все же оказался способен постичь Бога – и именно потому что сумел представить себе лицо той, кого любил.
⠀⠀Охранник велел всем остановиться, но я не послушался, ибо в этот миг не был уже в аду.
⠀⠀Хоть даже и не знал, жива моя жена или нет – но это ничего не меняло.
⠀⠀И образ ее вернул мне достоинство и придал сил. Я понял: даже если у человека отнято все, у него всегда остается блаженное право вспомнить лицо любимой, и это может даровать ему спасение».', 112);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (114, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture126.jpg', '⠀⠀<strong>Г</strong>оворит наставник:
⠀⠀– Отныне – и на срок в несколько столетий – человечество будет бойкотировать суеверных.
⠀⠀Энергия Земли нуждается в обновлении. Новые идеи требуют пространства. Плоть и дух – вызовов. Будущее стучится к нам в двери, и все идеи – за исключением тех, что зиждутся на предрассудках – получают шанс проявиться.
⠀⠀Все, что будет важно, останется; все ненужное – отринется. Но пусть каждый думает только о своих победах, ибо кто мы такие, чтобы судить о мечтах ближнего?
⠀⠀И чтобы твердо верить в правильность избранной дороги, вовсе необязательно доказывать, что кто-то иной пошел неверным путем. Тот, кто поступает так, не доверяет собственным шагам.
⠀⠀Жизнь подобна грандиозным велосипедным гонкам, цель которых исполнить Свою Стезю.', 114);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (115, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture127.jpg', '⠀⠀<strong>Н</strong>а старте мы – все вместе, и все охвачены воодушевлением и сплочены чувством товарищества. Но по мере того как продолжается гонка, первоначальная радость уступает место разнообразным и истинным вызовам – усталости, однообразию, неверию в собственные силы. Мы замечаем, что кое-кто отказывается принимать их и продолжает крутить педали – но не потому ли, что просто не могут остановиться посреди шоссе? Их – много, они держатся поблизости к машине сопровождения, переговариваются между собой и просто исполняют некую повинность.
⠀⠀Мы, остальные, в конце концов отрываемся от них и с этой минуты обречены сами справляться с одиночеством, с неожиданными и крутыми поворотами трассы, с поломками.
⠀⠀И мы рано или поздно спросим себя, имеют ли смысл подобные усилия.
⠀⠀Да, имеют. Главное – не сдаваться.', 115);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (116, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture128.jpg', '⠀⠀<strong>Н</strong>аставник и ученик ехали по Аравийской пустыне. Наставник использовал каждую минуту, чтобы наставить ученика в вере.
⠀⠀– Надо все вверить Всевышнему. Он никогда не оставит своих детей.
⠀⠀Когда под вечер остановились на привал, наставник попросил ученика привязать коней к скале, возле которой они оказались. Тот отправился было исполнять поручение, но на полпути вспомнил слова учителя.
⠀⠀«Да он же испытывает крепость моей веры, – подумал он. – Оставлю коней на попечение Господа». И не стал их привязывать.
⠀⠀А утром обнаружилось, что кони исчезли.
⠀⠀В ярости ученик накинулся на своего наставника:
⠀⠀– Ты ничего не понимаешь в том, что такое Бог, – горько сетовал он. – Я поручил Ему сторожить наших коней. А теперь их нет!
⠀⠀– Бог хотел присмотреть за ними, – отвечал наставник. – Но чтобы привязать их, Ему в эту минуту были нужны твои руки.', 116);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (117, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture129.jpg', '⠀⠀– <strong>Б</strong>ыть может, Иисус послал кого-то из своих апостолов в ад, спасать души, – сказал Джон. – И даже если ты оказался в аду, не все еще потеряно.
⠀⠀Эта мысль удивила странника. Джон служит пожарником в Лос-Анджелесе и сегодня у него выходной.
⠀⠀– Почему ты так считаешь? – осведомляется странник.
⠀⠀– Потому что бывал в аду здесь, на этом свете. Входил в объятые огнем здания, видел мечущихся в отчаянии людей, которые пытались выйти, и много раз успевал спасти их, рискуя собственной жизнью. Мне – всего лишь малой частице этой огромной вселенной – приходилось действовать как герою во множестве огненных геенн. И если я, ничтожество, мог поступать так, представь, чего только не сумеет совершить Иисус!
⠀⠀Я совершенно уверен – кое-кто из его апостолов «внедрен» в преисподнюю и занят там спасением грешных душ.', 117);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (118, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture130.jpg', '⠀⠀<strong>Г</strong>оворит наставник:
⠀⠀– Во многих первобытных цивилизациях существовал обычай хоронить покойников в позе зародыша. «Усопший рождается для новой жизни, а потому ему надо придать ту же позу, в которой он пребывал, придя в наш мир» – так рассуждают его соплеменники.
⠀⠀Для них чудо перевоплощения есть повседневная часть бытия, а потому смерть – это всего лишь очередной шаг по нескончаемо-долгой дороге мироздания.
⠀⠀Но постепенно мир утрачивал такое щадящее представление о смерти.
⠀⠀Не имеет значения, что мы думаем, что делаем, во что веруем: все мы рано или поздно умрем.
⠀⠀И лучше поступить по примеру индейцев племени яки, которые обращаются к смерти за советом. Постоянно спрашивают у нее: «Если я все равно умру, скажи, что мне надлежит делать сейчас?»
⠀⠀Ибо жизнь ни о чем не попросишь и советов от нее не получишь. А если нам нужна помощь, лучше всего посмотреть, как решают (или не решают) свои проблемы другие люди.', 118);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (119, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture131.jpg', '⠀⠀<strong>И</strong>бо наш ангел-хранитель неизменно стоит рядом и часто говорит с нами устами нашего ближнего. Но этот ответ приходит лишь в те минуты, когда мы, не ослабляя внимания, не позволяем повседневным заботам и тревогам замутить сияющее чудо жизни.
⠀⠀Пусть наш ангел говорит так, как он привык, и тогда, когда он сочтет это нужным и своевременным.', 119);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (120, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture132.jpg', '⠀⠀<strong>Г</strong>оворит наставник:
⠀⠀– Советы – это теория жизни, а на практике, как правило, все оказывается совсем иначе.', 120);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (121, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture133.jpg', '⠀⠀<strong>Н</strong>екий священник ехал в автобусе по Рио-де-Жанейро, как вдруг услышал голос, приказывавший ему начать проповедь немедля и не сходя с места.
⠀⠀Падре принялся было возражать:
⠀⠀– Здесь совсем не место для того, чтобы нести слово Божие. Меня на смех поднимут.
⠀⠀Голос меж тем продолжал настаивать.
⠀⠀– Я робок и застенчив, пожалуйста, не требуй от меня этого.
⠀⠀Голос не прекращал своих требований.
⠀⠀Тогда священник вспомнил о своем обете – безропотно принимать все предначертания Христа. Поднялся, сгорая со стыда, и заговорил о Священном Писании. Пассажиры внимали ему молча. Он глядел на каждого из них, и мало кто отводил глаза. Сказав все, что хотел, завершил проповедь и сел на свое место.
⠀⠀Он и сегодня не знает, какую задачу выполнял в те минуты.
⠀⠀Но в том, что – выполнил, убежден абсолютно.', 121);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (122, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture134.jpg', '⠀⠀<strong>Ш</strong>аман одного африканского племени увел своего ученика в лес.
⠀⠀Он, хоть и был сильно старше годами, шел легко и проворно, тогда как ученик поминутно спотыкался и падал. Проклинал свою судьбу, ругался, вставал, плевал на подведшую его землю и вновь шел следом за своим наставником.
⠀⠀И вот наконец после долгого пути пришли они к святилищу. И, не останавливаясь, колдун развернулся и двинулся в обратный путь.
⠀⠀– Ты ничему не научил меня сегодня, – пожаловался ученик после очередного падения.
⠀⠀– Я-то учил, да вот ты, похоже, ничего не усвоил, – отвечал колдун. – Я пытался показать тебе, как следует поступать с ошибками.
⠀⠀– И как же?
⠀⠀– Точно так же, как ты должен был бы поступить, упав. Вместо того чтобы проклинать то место, где ты упал, следовало найти то, на чем ты поскользнулся.', 122);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (123, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture135.jpg', '⠀⠀<strong>Н</strong>астоятеля монастыря в Сцете посетил однажды отшельник.
⠀⠀– Мой духовный наставник не знает, куда меня направить, – сказал он. – Должен ли я бросить его?
⠀⠀Аббат ничего ему не ответил, и отшельник вернулся в пустыню.
⠀⠀А через неделю вновь пришел в монастырь:
⠀⠀– Мой духовный наставник не знает, куда меня направить, – сказал он. – Я решил расстаться с ним.
⠀⠀– Вот это – мудрые слова, – сказал ему на это настоятель. – Ибо когда человек сознает, что душа его не удовлетворена, он не просит советов. Он принимает решения, потребные для того, чтобы двигаться в этой жизни прежним путем.', 123);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (124, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture136.jpg', '⠀⠀<strong>К</strong> страннику подошла некая молодая женщина.
⠀⠀– Вот что я хочу рассказать тебе, – молвила она. – Я всегда верила, что обладаю даром врачевания. Но мне не хватало решимости испытать его на ком-нибудь, пока однажды у моего мужа не начались сильные боли в левой ноге, а облегчить его страдания было некому. И вот тогда я, умирая от стыда, наложила руки на больное место и попросила, чтобы боль стихла.
⠀⠀Я действовала, не веря, что сумею помочь мужу, и вдруг услышала, как он молится: «Господи, сделай так, чтобы моя жена смогла стать посланницей Твоего света и Твоей силы». От моей руки стало распространяться тепло, и боли тотчас прекратились.
⠀⠀Потом я спросила, почему он обратился к Богу с такой молитвой. И он ответил: «Чтобы придать тебе уверенности».
⠀⠀И сейчас, благодаря этим словам, я могу исцелять недуги.', 124);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (126, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture138.jpg', '⠀⠀<strong>О</strong>днажды философ, который преуспел в жизни, пресмыкаясь перед сиракузским тираном Дионисием, увидел, как готовит себе чечевицу, и сказал:
⠀⠀«Если бы ты прославлял царя, тебе не пришлось бы питаться чечевицей!» На что Диоген возразил: «Если бы ты научился питаться чечевицей, тебе не пришлось бы прославлять царя!»', 126);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (127, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture139.jpg', '⠀⠀<strong>Г</strong>оворит наставник:
⠀⠀– Да, всему на свете – своя цена, но цена эта – относительна. Когда следуем за нашими мечтами, можем показаться другим убогими, жалкими и несчастными. Но не все ли нам равно, что думают о нас другие? Важно лишь, чтобы сердца наши полнились радостью.', 127);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (128, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture140.jpg', '⠀⠀<strong>Н</strong>екий человек, живший в Турции, прослышал, что в Персии живет великий мудрец. Недолго думая, он продал все свое имущество, распрощался с семьей и отправился на поиски мудрости.
⠀⠀После нескольких лет странствий добрался наконец до той лачуги, где обитал тот, кто был так ему нужен. Трепеща от страха и почтения, приблизился и постучал.
⠀⠀Хозяин отворил.
⠀⠀– Я из Турции, – молвил посетитель. – И проделал столь утомительный путь для того лишь, чтобы задать тебе один-единственный вопрос.
⠀⠀Старец воззрился на него в удивлении:
⠀⠀– Ну хорошо задавай свой вопрос.
⠀⠀– Поскольку я хочу выразиться как можно яснее, скажи, позволено ли мне будет говорить по-турецки?
⠀⠀– Позволено, – отвечал мудрец. – И на твой единственный вопрос я тебе уже ответил. Обо всем прочем из того, что тебя интересует, осведомись у своего сердца – оно скажет.
⠀⠀И закрыл дверь.', 128);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (129, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture141.jpg', '⠀⠀<strong>Г</strong>оворит наставник:
⠀⠀– Слово могущественно. Слово способно преобразовать мир и изменить человека.
⠀⠀Каждому из нас приходилось в свое время слышать: «Об удачах в своей жизни лучше помалкивать, ибо чужая зависть способна уничтожить наше счастье».
⠀⠀Ничего подобного – победители житейского ристалища с гордостью говорят о чудесах, случавшихся в их жизни. Позитивная энергия, распространяемая тобой, притягивает к себе новую – и радует тех, кто по-настоящему желает тебе добра.
⠀⠀Что же касается завистников и побежденных, они способны причинить тебе вред лишь в том случае, если ты им это позволишь.
⠀⠀Так что ничего не бойся. Говори о хорошем в своей жизни со всяким, кто согласится слушать. Душе Мира очень нужна твоя радость.', 129);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (130, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture142.jpg', '⠀⠀<strong>Ж</strong>ил да был некогда в Испании король, который очень гордился знатностью своего рода и был при этом известен своей жестокостью по отношению к слабым.
⠀⠀Как-то раз он в сопровождении свиты прогуливался в окрестностях Арагона, где за несколько лет до этого пал в битве его отец.
⠀⠀И, повстречав праведника, ворошившего огромную кучу костей, король спросил:
⠀⠀– Что ты здесь делаешь?
⠀⠀– Когда я узнал, что ваше величество прибудет сюда, я решил выкопать кости вашего покойного отца и передать их вам. Но, как ни стараюсь, не могу отличить их от скелетов и черепов простых крестьян, бедняков, нищих, невольников.', 130);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (131, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture143.jpg', '', 131);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (132, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture144.jpg', '⠀⠀<strong>А</strong>фроамериканскому поэту Ленгстону Хьюзу принадлежат такие строки:
⠀⠀«Я знаю реки.
⠀⠀Я знаю реки – ровесницы сотворения мира: они древнее тока крови по жилам.
⠀⠀И душа моя так же глубока, как реки.
⠀⠀На заре цивилизации я плавал в Евфрате.
⠀⠀Моя хижина стояла на берегу Конго, и воды ее пели мне колыбельную.
⠀⠀Я видел Нил и возводил пирамиды.
⠀⠀Когда Линкольн путешествовал в Новый Орлеан, я слышал напев Миссисипи и видел, как золотятся они под закатным солнцем.
⠀⠀Душа моя стала так же глубока, как реки».', 132);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (133, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture145.jpg', '⠀⠀– <strong>К</strong>то лучше всех владеет мечом? – спросил воин.
⠀⠀– Выйди в поле возле монастыря, – сказал ему наставник. – Там стоит валун. Оскорби его.
⠀⠀– Зачем это? – удивился воин. – Камень никогда не ответит мне тем же.
⠀⠀– Тогда атакуй его.
⠀⠀– Не стану. Меч мой сломается. А если нападу на него с голыми руками, издеру их в кровь, но ничего не достигну. Да и вообще при чем тут валун? – Я спрашивал тебя, кто лучше всех управляется с мечом?
⠀⠀– Тот, кто подобен каменному валуну, – отвечал на это наставник. – Тот, кто, даже не обнажив меча, может показать, что одолеть его не под силу никому.', 133);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (184, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture196.jpg', '⠀⠀<strong>О</strong>дин знаменитый писатель шел как-то с другом и вдруг увидел, как мальчишка перебегает улицу, не замечая мчащийся на него грузовик.
⠀⠀Писатель в последнюю долю секунды успел вытащить мальчишку буквально из-под колес.
⠀⠀Но прежде чем кто-либо успел поздравить его и восхититься его героическим поступком, он дал мальчишке крепкую затрещину со словами:
⠀⠀– Не прельщайся мнимостями, сын мой.
⠀⠀Я спас тебя исключительно для того, чтобы ты не смог избежать тех проблем, которые будут ждать тебя, когда ты станешь взрослым.', 184);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (134, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture146.jpg', '⠀⠀<strong>С</strong>транник, придя в наваррский городок Сан-Мартин-де-Ункс, отыскал женщину, у которой хранились ключи от красивой старинной церкви в романском стиле.
⠀⠀И она была так любезна, что поднялась по крутым узким улочкам и открыла храм.
⠀⠀Тьма и тишина, царившие там, взволновали странника. Он вступил в беседу со своей провожатой и посетовал, что хотя на дворе полдень, красивейшие фрески на стенах рассмотреть нельзя.
⠀⠀– Они видны только на рассвете, – отвечала та. – Легенда гласит, что строители этого собора хотели этим внушить нам одну истину: Господь, чтобы явиться нам во всей славе своей, всегда избирает для этого определенный час.', 134);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (135, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture147.jpg', '⠀⠀<strong>Г</strong>оворит наставник:
⠀⠀– Существуют два бога. Один – это тот, которому учат нас наши педагоги. Другой – Бог, который сам учит нас. Бог, о котором привыкли толковать люди, и Бог, который говорит с нами. Бог, которого нас учат бояться, и Бог, который говорит с нами о милосердии.
⠀⠀Существуют два бога. Один пребывает где-то на запредельных высотах, другой участвует в нашей повседневной жизни.
⠀⠀Один взыскивает, другой прощает нам долги.
⠀⠀Один грозит вечными загробными муками, другой указывает нам наилучший путь.
⠀⠀Существуют два бога. Один раздавливает нас нашими винами, другой освобождает Своей любовью.', 135);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (136, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture148.jpg', '⠀⠀<strong>М</strong>икеланджело спросили однажды, как удается ему ваять столь прекрасные статуи.
⠀⠀– Это очень просто, – отвечал он. – Глядя на глыбу мрамора, я вижу спрятанную там скульптуру. Мне остается лишь высвободить ее, убрав все лишнее.', 136);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (137, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture149.jpg', '⠀⠀<strong>Г</strong>оворит наставник:
⠀⠀– Существует произведение искусства, которое нам предназначено создать.
⠀⠀Оно есть средоточие нашей жизни, и мы, хоть и пытаемся уверить себя в обратном, однако сознаем, какое значение имеет оно для того, чтобы мы были счастливы. Как правило, оно, творение это, пребывает под спудом, под гнетом годами выношенных страха, вины, нерешительности.
⠀⠀Но если отбросить все это, если уверовать в свое дарование и способность, то мы сумеем осуществить сужденное нам. Ибо это – единственный способ жить достойно и с честью.', 137);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (138, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture150.jpg', '⠀⠀<strong>Н</strong>екий старец, чувствуя приближение смертного часа, подозвал к себе юношу и поведал ему историю о героизме: во время войны он помог одному человеку бежать из плена, дал ему пристанище и пищу.
⠀⠀Когда оба были уже почти в безопасности, человек этот решил предать его и выдать врагам.
⠀⠀– Как же ты спасся? – спросил юноша.
⠀⠀– Мне не надо было спасаться, потому что я и есть этот предатель, – отвечал старик. – Но когда рассказываешь эту историю от первого лица, начинаешь сознавать, что сделал для меня тот человек.', 138);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (139, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture151.jpg', '', 139);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (140, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture152.jpg', '⠀⠀<strong>Г</strong>оворит наставник:
⠀⠀– Каждый из нас нуждается в любви. Любовь – это неотъемлемая часть человеческой природы, такая же естественная потребность, как еда, вода, сон.
⠀⠀И часто бывает, что любуясь в полнейшем одиночестве прекрасным закатом, мы думаем: «Все это не имеет значения, если мне не с кем разделить свое восхищение».
⠀⠀В такую минуту уместно спросить себя: сколько раз у нас просили любви, а мы просто отворачивались? Сколько раз сами не смели приблизиться к кому-то и сказать прямо и открыто, что влюблены в него?
⠀⠀Берегитесь одиночества. Оно отравляет почище самых опасных наркотиков. Если кажется, что закат солнца больше не имеет для вас значения, смиритесь – и отправляйтесь на поиски любви. И помните, что свойство всех сокровищ духа – чем больше мы готовы отдать, тем больше получим в ответ.', 140);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (185, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture197.jpg', '⠀⠀<strong>Г</strong>оворит наставник:
⠀⠀– Порою мы стыдимся делать добрые дела. Присущее нам чувство вины всегда пытается внушить нам, что, поступая великодушно, мы тщимся произвести благоприятное впечатление на других, «угодить» Богу и пр. Кажется очень трудным допустить, что человек по природе своей – исключительно добр. И добрые дела мы стараемся спрятать за иронию и небрежность – как если бы милосердие было синонимом слабости.', 185);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (149, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture161.jpg', '⠀⠀<strong>В</strong> Испании, неподалеку от города Сория, в древнем скиту, врезанном в скалу, живет – уже несколько лет – человек, оставивший все ради того, чтобы всецело посвятить себя созерцанию.
⠀⠀Этой осенью, как-то под вечер, странник навестил его и был принят с необыкновенным радушием. Разделив с ним ломоть хлеба, пустынник попросил сходить к ближайшей речушке, чтобы собрать там на берегу съедобных грибов.
⠀⠀По дороге им встретился юноша.
⠀⠀– Святой отец, – сказал он, – я слышал, что если хочешь достичь просветления, не следует употреблять в пищу мясо. Так ли это?
⠀⠀– Принимай с радостью все, что предлагает тебе жизнь, – отвечал отшельник. – Не греши против духа, но и не совершай кощунства, отвергая щедрые дары земли.', 149);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (141, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture153.jpg', '⠀⠀<strong>Н</strong>екий испанский миссионер повстречал на острове трех ацтекских жрецов.
⠀⠀– Как вы молитесь? – спросил он.
⠀⠀– Молитва у нас всего одна. Мы говорим так: «Господи, ты един в трех лицах, и нас трое, помилуй нас!»
⠀⠀– Хорошая молитва, – сказал падре. – Но это не вполне то, к чему прислушивается Бог.
⠀⠀Я вас научу другой, получше.
⠀⠀И научил троих ацтеков католической молитве, а потом отправился своей дорогой – обращать язычников. Прошли годы, и случилось ему однажды проплывать на испанском корабле мимо этого самого острова. Он заметил с борта троих ацтекских жрецов и помахал им на прощанье.
⠀⠀И тут все трое зашагали к кораблю по воде.
⠀⠀– Падре! Падре! – закричал один из них. – Мы позабыли слова той молитвы, к которой прислушивается Бог. Напомни, пожалуйста.
⠀⠀– Да нет, наверно, не стоит, – отвечал миссионер при виде такого чуда.
⠀⠀И попросил у Бога прощенья за то, что раньше не понял – Бог говорит на всех языках.', 141);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (142, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture154.jpg', '⠀⠀<strong>С</strong>ан-Хуан де ла Крус учит, что, отправляясь в духовное странствие, мы не должны искать видения или прислушиваться к словам тех, кто уже некогда прошел этим путем.
⠀⠀Единственной нашей опорой должна быть вера, ибо вера есть нечто такое, что ни с чем не спутаешь – светлое, прозрачное, рождающееся внутри нас.', 142);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (143, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture155.jpg', '⠀⠀<strong>Н</strong>екий писатель разговаривал со священником и спросил его, случалось ли тому ощущать присутствие Бога.
⠀⠀– Не знаю, – ответил падре. – До сих пор я ощущал только присутствие моей веры в Бога.
⠀⠀И это – самое главное.', 143);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (144, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture156.jpg', '⠀⠀<strong>Г</strong>оворит наставник:
⠀⠀– Прощение – это дорога с двусторонним движением.
⠀⠀Прощая кого-нибудь, мы прощаем в этот миг и самих себя. Если будем терпимы к чужим грехам и ошибкам, то легче будет принимать собственные промахи и просчеты.
⠀⠀И тогда, отрешившись от чувства вины и горечи, мы сможем улучшить наше отношение к жизни.
⠀⠀Когда же – по слабости – мы допускаем, чтобы ненависть, зависть, нетерпимость бурлили вокруг нас, то и сами поневоле в конце концов поддаемся им.', 144);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (146, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture158.jpg', '⠀⠀<strong>П</strong>етр спросил Христа:
⠀⠀– Учитель, ближнего моего следует прощать до семи раз?
⠀⠀И Христос ответил:
⠀⠀– Не до семи, но до семидесяти раз.
⠀⠀Акт прощения очищает наше астральное поле и являет нам истинный свет Божества.', 146);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (147, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture159.jpg', '⠀⠀<strong>Г</strong>оворит наставник:
⠀⠀– В древности наставники создавали «персонажей», чтобы помочь своим ученикам справляться с темными сторонами своей личности. Многие истории, имеющие отношение к сотворению этих персонажей, превратились в знаменитые волшебные сказки.
⠀⠀Процесс прост: достаточно поместить свои тревоги, страхи, разочарования в некое невидимое существо, находящееся слева от тебя. Оно будет действовать, предлагая те самые решения, которые ты в конечном итоге, может быть, и принял бы – пусть и наперекор своей совести, вопреки своим убеждениям. А вот если эти решения прозвучат из уст такого вот [негодяя], тебе станет много проще отказаться от его нашептываний и отвергнуть его лукавые советы. В самом деле, проще некуда. И потому действует безотказно.', 147);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (148, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture160.jpg', '⠀⠀<strong>Н</strong>аставник попросил смастерить стол.
⠀⠀И когда работа была уже почти окончена – оставалось лишь вбить гвозди – подошел к ученику. Тот точными ударами молотка вогнал три гвоздя.
⠀⠀Четвертый, однако, потребовал больших усилий и не трех, а еще одного удара. Но гвоздь ушел чересчур глубоко, и дерево раскололось.
⠀⠀– Твоя рука привыкла наносить по три удара, – сказал наставник. – Когда какое-нибудь действие управляется привычкой, оно теряет смысл и может в конце концов причинить ущерб.
⠀⠀Действие есть действие, и есть лишь один секрет: не допускать, чтобы твоими движениями руководила привычка.', 148);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (150, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture162.jpg', '⠀⠀<strong>Г</strong>оворит наставник:
⠀⠀– Если тебе кажется, что путь слишком труден, постарайся прислушаться к своему сердцу. Постарайся быть предельно честен с самим собой и определить для себя, по той ли дороге идешь ты, расплачиваясь за каждый шаг своими мечтами.
⠀⠀Если и после этого жизнь будет по-прежнему томить и огорчать тебя – можешь пожаловаться. Но делай это, сохраняя почтение, как жалуется сын на отца, прося всего лишь чуть больше внимания и помощи. Господь – и отец твой, и мать, а родители неизменно ожидают самого лучшего от своего сына. Быть может, чересчур затянулось твое ученье, и тогда ты вправе попросить о том, чтобы тебе дали передохнуть и, может быть, приласкали.
⠀⠀Но никогда не преувеличивай. Иов пожаловался, найдя для этого должное время, и все отнятое у него было ему возвращено. Аль-Афид же взял себе за правило жаловаться беспрестанно, и Всевышний перестал слушать его.', 150);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (152, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture164.jpg', '⠀⠀<strong>В</strong> Валенсии существует забавный обычай, возникший в незапамятные времена в гильдии плотников.
⠀⠀В течение целого года художники и мастера строят огромные деревянные статуи. Когда приходит праздничная неделя, они привозят их на главную площадь городка. Люди приходят к ним, рассматривают, обсуждают, дивятся такой выдумке и воображению. А в день Святого Иоанна все статуи – за исключением одной – сжигают на исполинском костре, окруженном тысячной толпой зевак.
⠀⠀– Столько трудов – и все уходит дымом.
⠀⠀Как же так? – спросила одна англичанка, наблюдая, как взвиваются к самому небу языки пламени.
⠀⠀– Ты тоже когда-нибудь умрешь, – отвечала ей женщина из местных. – И представь себе, что в этот миг кто-то из ангелов спросит Создателя: «Столько трудов – и все впустую. Как же так?»', 152);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (153, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture165.jpg', '⠀⠀<strong>О</strong>дин очень благочестивый и набожный человек внезапно лишился всего своего состояния. И зная, что Господь может в любых обстоятельствах прийти к нему на помощь, принялся молиться:
⠀⠀– Сделай так, чтобы я выиграл в лотерею.
⠀⠀Такие молитвы воссылал он год за годом, но оставался бедняком.
⠀⠀Но вот он умер и, как человек праведной жизни, попал прямо к райским вратам.
⠀⠀Но входить отказался. А заявил, что прожил всю свою жизнь, не нарушая заповедей и в полном соответствии с тем, чему его учили, а вот Бог все равно так и не послал ему выигрыш в лотерею.
⠀⠀– И все, что Ты мне обещал, ничего не стоит! – в ярости кричал он.
⠀⠀– Я был готов помочь тебе, – отвечал Господь. – Но ты бы хоть раз купил лотерейный билет!', 153);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (154, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture166.jpg', '⠀⠀<strong>С</strong>тарый китайский мудрец шел по заснеженному полю и увидел плачущую женщину.
⠀⠀– Почему ты плачешь? – спросил он ее.
⠀⠀– Потому что вспомнила прошлое, молодость, былую красоту, ныне поблекшую, мужчин, которых любила. Бог поступил жестоко, даровав людям память. Он, видно, знал, что я буду вспоминать весну моей жизни и плакать.
⠀⠀Мудрец, уставившись неподвижным взглядом в одну точку, созерцал снежную равнину.
⠀⠀А женщина вдруг перестала плакать и спросила:
⠀⠀– Что ты видишь там?
⠀⠀– Вижу цветущие розы, – отвечал мудрец. – Бог был великодушен, даровав мне память. Он, видно, знал, что зимой я всегда смогу вспомнить весну и улыбнуться.', 154);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (155, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture167.jpg', '⠀⠀<strong>Г</strong>оворит наставник:
⠀⠀– Своя Стезя – это не так просто, как кажется. Напротив, она чревата определенными опасностями. Когда мы хотим чего-нибудь, то приводим в действие могущественную энергию, и нам уже не удается скрыть от самих себя истинный смысл нашей жизни.
⠀⠀Путь следом за своей мечтой имеет свою цену. Может быть, придется расстаться с какими-то из укоренившихся привязанностей и привычек, могут возникнуть трудности, могут ждать горчайшие разочарования.
⠀⠀Но как бы высока ни была эта цена, она всегда будет ниже той, которую приходится платить тем, кто не следует Своей Стезей. Ибо они когда-нибудь оглянутся назад, увидят все, что сделали, и услышат голос собственного сердца: «Я прожил жизнь зря».
⠀⠀И поверьте, едва ли есть на свете слова страшнее, чем эти.', 155);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (156, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture168.jpg', '⠀⠀<strong>К</strong>астанеда в одной из своих книг рассказывает, что как-то раз его наставник велел ему надеть ремень от брюк пряжкой в другую сторону – не так, как он застегивал ее обычно.
⠀⠀Кастанеда повиновался, будучи убежден, что учится владеть каким-то могущественным орудием власти и силы.
⠀⠀Спустя несколько месяцев он сообщил, что благодаря этому магическому приему усваивает все необходимое куда скорее, чем раньше.
⠀⠀– Застегивая пряжку ремня не левой рукой, а правой, я трансформирую негативную энергию в позитивную.
⠀⠀Наставник же в ответ на эти слова расхохотался:
⠀⠀– Пряжки и ремни не видоизменяют энергию. Я попросил тебя сделать это для того лишь, чтобы ты всякий раз, как надеваешь штаны, вспоминал, что проходишь обучение. И именно сознание этого, а вовсе не ремень, помогло тебе вырасти.', 156);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (158, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture170.jpg', '⠀⠀<strong>У</strong> одного наставника были сотни учеников. И в определенный час все они молились – все, кроме одного, который неизменно оказывался пьян.
⠀⠀И перед смертью наставник именно ему поведал заветные оккультные тайны.
⠀⠀Остальные же возмутились:
⠀⠀– Стыд и срам! – говорили они. – Какие жертвы принесли мы никуда не годному наставнику, который не сумел заметить наши дарования!
⠀⠀Ответил наставник так:
⠀⠀– Я должен был вверить эти тайны человеку, хорошо мне знакомому. Те, кто прилежен и усерден, обычно скрывают какой-нибудь порок – гордыню, тщеславие, нетерпимость. И потому я вам всем предпочел единственного человека, наделенного явной слабостью – тягой к спиртному.', 158);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (159, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture171.jpg', '⠀⠀<strong>С</strong>вященник Маркос Гарсия утверждает: «Господь иногда лишает человека благодати, дабы тот смог понять Его, не обращаясь с просьбами и не получая милостей.
⠀⠀Господь всегда знает, до каких пределов можно испытывать человеческую душу – и никогда не преступит их.
⠀⠀И, лишившись благодати, не говори: «Господь оставил меня». Это невозможно. Это мы иногда способны оставить Его. Если Господь подвергнет нас испытанию, то неизменно одарит и благодатью, достаточной – я бы даже сказал: более чем достаточной – чтобы испытание это выдержать.
⠀⠀Когда мы порою не чувствуем рядом Его присутствия, не видим Его лика, должно спросить себя: «Сумели мы воспользоваться тем, что Он поставил на нашем пути?»
⠀⠀Порою мы целыми днями или даже неделями не получаем от ближнего никакого знака приязни или ласкового слова.
⠀⠀Когда иссякает человеческое тепло, наступает трудный период и жизнь сводится к изнурительным усилиям выживания.', 159);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (160, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture172.jpg', '⠀⠀<strong>Г</strong>оворит наставник:
⠀⠀– Мы должны изучать наш собственный очаг. Должны подложить побольше дров и попытаться осветить темную комнату – и тогда жизнь преобразится неузнаваемо. Когда мы слышим, как потрескивают поленья в огне, рассказывая о чем-то, к нам возвращается надежда.
⠀⠀Если мы способны любить, то значит, будем способны и быть любимыми. Это всего лишь вопрос времени.', 160);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (161, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture173.jpg', '⠀⠀<strong>З</strong>а ужином один из гостей разбил бокал.
⠀⠀– К счастью, – наперебой заговорили сидевшие за столом. Все знали эту примету.
⠀⠀– А почему, кстати, это считается хорошей приметой? – спросил раввин.
⠀⠀– Не знаю, – сказала жена странника. – Быть может, это старинный способ сделать так, чтобы неловкий гость не смущался.
⠀⠀– Нет, это не объяснение, – заметил раввин. – По иудейской легенде, каждому человеку отпущена некая доля счастья, которую он расходует на протяжении всей своей жизни. Он может растратить ее впустую, а может приумножить – при условии, что будет использовать лишь на то, что ему нужно на самом деле.
⠀⠀Мы, иудеи, тоже говорим «К счастью», когда что-нибудь бьется. Но у нас это значит: как хорошо, что ты не растратил свою удачу, не обратил ее на то, чтобы этот стакан не разбился. Теперь ты можешь использовать ее для чего-то более важного.', 161);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (162, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture174.jpg', '⠀⠀<strong>Н</strong>астоятель монастыря отец Авраам узнал, что неподалеку от обители живет отшельник, пользующийся славой всесветного мудреца.
⠀⠀Он отыскал его и вопросил:
⠀⠀– Если бы сегодня ты увидел у себя в постели красавицу, сумел бы ты подумать, что она – не женщина?
⠀⠀– Нет, – отвечал мудрец, – но сумел бы смирить себя и не дотронуться до нее.
⠀⠀– А если бы увидел в пустыне груду золотых монет, – продолжал допытываться аббат, – сумел бы взглянуть на них, как на обыкновенные камни?
⠀⠀– Нет, но сумел бы обуздать себя и не прикоснуться к ним.
⠀⠀– А если бы тебя разыскивали двое братьев, из которых один ненавидел бы тебя, а другой – любил, сумел бы ты заключить, что оба они одинаковы? – настаивал аббат.
⠀⠀– Мне это было бы мучительно трудно, – отвечал отшельник, – но с одним я вел бы себя точно так же, как и с другим.', 162);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (163, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture175.jpg', '⠀⠀– <strong>Я</strong> объясню вам, кто такой мудрец, – сказал отец Авраам, вернувшись к себе в монастырь. – Это – человек, который не избегает страстей, но умеет обуздывать их.', 163);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (164, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture176.jpg', '⠀⠀<strong>В</strong>сю жизнь у. Фрезер писал о покорении Дикого Запада. Гордясь тем, что в его «послужном списке» числится и сценарий фильма, где главную роль сыграл Гари Купер, он рассказывает, что очень редко сердится или досадует на что-то.
⠀⠀– Я очень многому научился у американских пионеров, – говорит он. – Они сражались с индейцами, пересекали пустыни, добывали себе воду и пропитание.
⠀⠀И все документальные свидетельства показывают любопытную подробность: пионеры писали или говорили только о хорошем. Вместо того чтобы жаловаться, они сочиняли песни или подшучивали над собственными неурядицами и трудностями. И благодаря этому прогоняли уныние и подавленность. И сегодня, когда мне 88 лет, я стараюсь следовать их примеру.', 164);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (165, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture177.jpg', '⠀⠀<strong>О</strong>дин из священных символов христианства – изображение пеликана.
⠀⠀И совершенно понятно почему: при отсутствии еды эта птица клювом вспарывает себе грудь и кормит птенцов собственным мясом.', 165);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (166, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture178.jpg', '⠀⠀<strong>Г</strong>оворит наставник:
⠀⠀– Очень часто бывает так, что мы оказываемся не в состоянии понять ниспосланную нам благодать. Очень часто мы не понимаем, что делает Он ради того, чтобы утолить наш духовный голод.
⠀⠀Есть рассказ про пеликана, который суровой зимой, совершив свое самопожертвование, прожил еще несколько дней, собственным мясом кормя птенцов.
⠀⠀Когда же наконец он умер, один из птенцов сказал другому:
⠀⠀– Может, оно и к лучшему… Сколько же можно есть одно и то же каждый день?!', 166);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (167, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture179.jpg', '⠀⠀<strong>Е</strong>сли ты чем-то недоволен – а под «чем-то» я понимаю нечто хорошее, то, что ты хочешь, да все никак не можешь осуществить – остановись.
⠀⠀Если дела не идут, возможны два объяснения этому. Либо подвергается испытанию твое упорство. Либо тебе следует сменить направление.
⠀⠀Чтобы определить, какой из этих двух противоположных вариантов – твой, используй безмолвие и молитву. И мало-помалу все таинственно начнет обретать ясность – до тех пор, пока ты не сумеешь выбрать.
⠀⠀Но, выбрав один вариант, немедля позабудь другой. И двигайся вперед, потому что Бог помогает храбрым.', 167);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (170, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture182.jpg', '⠀⠀<strong>К</strong>омпозитор Нелсон Мотта, оказавшись в Баии, решил посетить Мать Менинью-до-Гантоис[1].
⠀⠀Он взял такси, но когда они на большой скорости ехали по автостраде, у машины отказали тормоза. По счастью, ни водитель, ни пассажир не пострадали, отделавшись легким испугом.
⠀⠀Разумеется, встретившись с Матерью Мениньей, композитор прежде всего рассказал ей о происшествии.
⠀⠀– Есть на свете такое, что уже предопределено и на роду написано, однако Бог может сделать так, чтобы мы прошли через это безо всякого ущерба для себя. На этом отрезке жизненного пути тебе суждено было попасть в аварию. Но как видишь, случилось все – и ничего не случилось.
⠀⠀
⠀⠀', 170);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (171, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture183.jpg', '⠀⠀– <strong>В</strong> вашем рассказе о Пути Сантьяго кое-чего не хватает, – сказала паломница страннику после его лекции. – Я замечала, что большинство паломников, идут ли они по Пути Сантьяго, или по житейским дорогам, всегда стараются двигаться в общем ритме.
⠀⠀И в начале своего паломничества я старалась держаться поближе к спутникам. Я выбивалась из сил, требовала от моего тела больше, чем оно могло дать, пребывала в постоянном напряжении, а под конец сильно стерла себе левую ногу.
⠀⠀И после этого, оказавшись в вынужденной неподвижности, поняла, что смогу пройти Путь Сантьяго до конца лишь в том случае, если буду повиноваться своему собственному ритму.
⠀⠀Я шла медленней, чем остальные, и шла в одиночестве – но сумела совершить паломничество лишь потому, что соблюдала свой ритм.
⠀⠀И с тех пор я применяю это правило ко всему, что мне приходится совершать в жизни.', 171);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (172, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture184.jpg', '⠀⠀<strong>К</strong>рез, повелитель малоазийского царства Лидии, собрался войною на персов.
⠀⠀Но хоть и был твердо намерен начать боевые действия, решил все же сначала посоветоваться с Дельфийским оракулом.
⠀⠀– Тебе предназначено уничтожить великую империю, – сказал тот.
⠀⠀Крез, довольный таким ответом, объявил персам войну. Уже через двое суток Лидия была занята ими, столица разграблена, а сам Крез оказался в плену. Негодуя, он велел своему послу в Греции вернуться к оракулу и сказать, что тот обманул лидийцев.
⠀⠀– Нет, вы не обмануты, – сказал оракул. – Вы и в самом деле добились гибели великой империи, имя которой – Лидия.', 172);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (173, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture185.jpg', '⠀⠀<strong>Г</strong>оворит наставник:
⠀⠀– Знаки и приметы говорят на своем, внятном нам языке и показывают нам, как действовать наилучшим образом. Мы же тем не менее зачастую пытаемся исказить собственный взгляд на них так, чтобы они согласовывались с тем, что мы намерены сделать во что бы то ни стало.', 173);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (174, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture186.jpg', '⠀⠀<strong>Б</strong>ускалья рассказывает историю четвертого мага, который тоже видел сияние рождественской звезды над Вифлеемом, а потом приходил во все те грады и веси, где бывал Иисус, но неизменно опаздывал, ибо его задерживали бесчисленные встречи на дорогах с нищими, обездоленными, отверженными, просившими у него помощи.
⠀⠀Тридцать лет он следовал за Иисусом по Египту, Галилее и Вифании, а потом пришел в Иерусалим – но опять слишком поздно: в этот день мальчика, давно ставшего взрослым, распяли на кресте. Почти весь купленный для Иисуса жемчуг маг должен был продать, чтобы оказать содействие сирым и убогим, встречавшимся на пути. Осталась всего одна бусина – но Спасителя уже не было на свете. «Я провалил главное дело своей жизни», – подумал маг. И тотчас услышал голос:
⠀⠀– Вопреки тому, что ты думаешь, знай, что в течение всей своей жизни встречал меня. Я был в тех нагих, которых ты одевал. В тех голодных, которых ты кормил. В тех томящихся в тюрьме, которых ты навещал. Я был во всех тех нищих, что попадались тебе на пути. И я благодарен тебе за твои дары – свидетельства любви.', 174);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (183, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture195.jpg', '⠀⠀<strong>В</strong>о время Тайной Вечери Иисус одной и той же фразой и с одинаковой суровостью осудил двоих своих апостолов. Оба совершили преступления, о которых Он знал заранее.
⠀⠀Иуда опомнился, раскаялся и покончил с собой. Петр тоже пришел в себя, но после того как трижды отрекся от всего, во что верил.
⠀⠀Однако в решающий миг он понял истинный смысл слов Иисуса. Он попросил прощения и смиренно пошел впереди.
⠀⠀Хотя тоже мог бы выбрать самоубийство. Вместо этого он смело взглянул в лицо своим сподвижникам и сказал им, должно быть, что-то вроде:
⠀⠀«Окей, пусть о моей ошибке говорят до тех пор, пока существует род человеческий. Но дайте мне возможность исправить ее».
⠀⠀Петр понял, что Любовь прощает. Иуда же не понял ничего.', 183);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (176, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture188.jpg', '⠀⠀<strong>В</strong>одном научно-фантастическом рассказе речь идет о некоем обществе, где люди уже с рождения готовы к определенной профессии и уже на свет появляются техниками, инженерами, механиками. А тех немногих, кто лишен каких бы то ни было навыков, отправляют в сумасшедший дом, считая, вероятно, что только безумцы неспособны приносить обществу практическую пользу.
⠀⠀И вот один из этих безумцев взбунтовался.
⠀⠀В клинике, где его содержат, есть библиотека, и он пытается как можно больше узнать из книг о науке и искусстве. Сочтя, что осведомлен в достаточной степени, он решает бежать. Его ловят и приводят в находящийся за городом Учебный Центр.
⠀⠀– Добро пожаловать, – говорит ему один из сотрудников. – Нас больше всего восхищают именно те люди, которые напряженно отыскивают свой собственный путь. С этой минуты вы можете делать все, что вам заблагорассудится, ибо только благодаря таким, как вы, мир движется вперед.', 176);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (177, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture189.jpg', '⠀⠀<strong>С</strong>обираясь надолго уехать, бизнесмен прощался с женой.
⠀⠀– Ты никогда не преподносил мне подарка, который был бы достоин меня, – сказала она.
⠀⠀– Ах ты, неблагодарная! – отвечал он. – Все, что у тебя есть, я зарабатывал годами упорного труда. Что еще я могу подарить тебе?
⠀⠀– Что-нибудь такое же красивое, как я.
⠀⠀Два года она дожидалась подарка. И вот наконец бизнесмен вернулся.
⠀⠀– Я раздобыл для тебя нечто равное тебе по красоте. Я плакал от твоей неблагодарности, но все же решил исполнить твое желание. Все это время я думал, что же может сравниться с твоей красотой, и наконец нашел.
⠀⠀И с этими словами протянул ей зеркало.', 177);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (179, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture191.jpg', '⠀⠀<strong>Г</strong>оворит наставник:
⠀⠀– Есть люди, которые стараются изо всех сил быть непогрешимо-точными в мелочах и деталях. Мы часто не позволяем себе ошибаться.
⠀⠀Чего мы добьемся этим? – Того лишь, что страх ошибки парализует нас, не давая двигаться дальше.
⠀⠀Он, этот страх, запирает нас в темнице посредственности. Если нам удастся победить его, мы сделаем очень важный шаг навстречу нашей свободе.', 179);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (180, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture192.jpg', '⠀⠀<strong>П</strong>ослушник спросил аббата Нистероса, настоятеля монастыря в Сцете:
⠀⠀– Что я должен сделать, чтобы порадовать Бога?
⠀⠀– Авраам принимал странников, и Бог был доволен. Илия не любил чужеземцев, и Бог был доволен. Давид гордился тем, что делал, и Бог был доволен. Священник перед алтарем стесняется того, что делает, и Бог доволен. Иоанн Креститель отправился в пустыню, и Бог был доволен. Иона же пошел в большой город Ниневию, и Бог был доволен.
⠀⠀Спроси свое сердце, что бы ему хотелось.
⠀⠀Когда сердце в ладу с твоими мечтами, оно сумеет обрадовать Бога.', 180);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (182, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture194.jpg', '⠀⠀<strong>О</strong>дин буддийский наставник путешествовал со своими учениками и услышал однажды, как они спорят, кто из них лучше.
⠀⠀– Я занимаюсь медитацией уже пятнадцать лет, – сказал один.
⠀⠀– Я творю добрые дела с тех пор, как покинул отчий дом, – сказал другой.
⠀⠀– Я неизменно следую наставлениям Будды, – сказал третий.
⠀⠀В полдень они остановились под яблоней передохнуть. Ветви ее, отягощенные спелыми яблоками, склонялись почти до самой земли.
⠀⠀Тогда заговорил наставник:
⠀⠀– Когда дерево щедро плодоносит, ветви его склоняются низко-низко. Истинному мудрецу присуще смирение.
⠀⠀Когда же дерево бесплодно, ветви его вздымаются высокомерно и спесиво. И глупец всегда почитает себя лучше ближнего своего.', 182);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (186, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture198.jpg', '⠀⠀<strong>И</strong>исус оглядывал стол, ища наилучший символ для своего земного странствия. Перед ним лежали гранаты из Галилеи, пряности из южных пустынь, сушеные фрукты из Сирии, финики из Египта.
⠀⠀Он должен был простереть руку, освящая какой-нибудь из этих плодов, но внезапно вспомнил – послание его предназначено всем людям, где бы они ни жили. А финики и гранаты растут, должно быть, не везде.
⠀⠀Он снова огляделся, и в голову Ему пришла еще одна мысль: в гранатах, в финиках, в сушеных плодах чудо Творения проявляется само собой, безо всякого вмешательства человека.
⠀⠀Тогда он взял со стола хлеб, освятил его прикосновением, преломил и роздал своим ученикам со словами:
⠀⠀– Возьмите, ешьте, ибо это есть плоть Моя.
⠀⠀Потому что хлеб существует везде и всюду.
⠀⠀И еще потому, что хлеб в отличие от гранатов, фиников и сушеных плодов из Сирии есть наилучший и самый зримый образ пути к Богу. Хлеб родился на свет от союза земли и человеческого труда.', 186);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (188, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture200.jpg', '⠀⠀<strong>Ж</strong>онглер стал посреди площади, вынул три апельсина и принялся подбрасывать их и ловить. Вокруг собрались люди, любуясь изяществом и точностью его движений.
⠀⠀– Это в известной степени напоминает нашу жизнь, – заметил кто-то, стоявший рядом со странником. – У каждого из нас по апельсину в каждой руке, а еще один – в воздухе, в этом-то и заключается вся разница. Его подбрасывают и ловят умело и ловко, с навыком и сноровкой, но путь у него – свой. В точности как этот жонглер, мы запускаем в этот мир свою мечту и не всегда оказываемся в состоянии контролировать ее.
⠀⠀В такие минуты нужно уметь вверить ее Богу и попросить, чтобы она достойно исполнила предназначенное ей и, исполнившись, упала нам в руки.', 188);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (191, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture203.jpg', '⠀⠀<strong>Н</strong>екто пришел на рынок продавать стаканы. Женщина подошла к прилавку и стала рассматривать выставленный на нем товар. Одни стаканы были просты и безыскусны, другие покрыты затейливой и искусной росписью.
⠀⠀Покупательница спросила, сколько они стоят. И с удивлением услышала, что цена у всех одинакова.
⠀⠀– Как же может расписной стакан стоить столько же, сколько гладкий? – в недоумении воскликнула она. – Почему ты не берешь деньги за работу?
⠀⠀– Я художник, – отвечал продавец. – Могу взять деньги за стакан, который изготовил, но не за красоту. Красота – бесплатно.', 191);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (192, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture204.jpg', '⠀⠀<strong>С</strong>транник, выходя из церкви после мессы, испытал острое чувство одиночества.
⠀⠀Внезапно его окликнул друг:
⠀⠀– Мне очень надо поговорить с тобой.
⠀⠀Странник увидел в этой нежданной встрече знак судьбы и так обрадовался, что начал говорить обо всем, что казалось ему важным. О Божьей благодати, о любви. И добавил, что друга не иначе как Бог послал или привел ангел – ведь еще минуту назад он чувствовал себя одиноким и никому не нужным.
⠀⠀Друг выслушал все это, поблагодарил и пошел прочь.
⠀⠀И странник, только что ликовавший, почувствовал еще большее одиночество. Чуть позже он понял, в чем дело: в своей бурной радости он пропустил мимо ушей просьбу друга выслушать его.
⠀⠀Странник поглядел себе под ноги и увидел собственные слова, валяющиеся на земле: Вселенная в этот час хотела другого.', 192);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (193, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture205.jpg', '', 193);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (194, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture206.jpg', '⠀⠀<strong>Т</strong>ри феи были приглашены на крещение принца.
⠀⠀Первая преподнесла ему в дар умение любить. Другая – деньги, чтобы он мог делать, что захочется. Третья наделила красотой.
⠀⠀Но тут, как и полагается во всякой сказке, явилась злая колдунья. И в ярости от того, что ее не пригласили, бросила проклятье:
⠀⠀– Хоть у тебя уже все есть, я дам тебе еще кое-что. Ты будешь талантлив во всем, за что ни возьмешься.
⠀⠀Принц рос красивым, богатым и влюбчивым. Но исполнить свое предназначение на Земле ему никак не удавалось. Он был превосходный живописец, одаренный скульптор, блистательный математик, замечательный музыкант – но ни в какой области не мог выполнить задачу до конца, потому что, начав одно дело, тут же отвлекался и принимался за другое.', 194);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (195, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture207.jpg', '⠀⠀<strong>Г</strong>оворит наставник:
⠀⠀– Все дороги ведут в одно и то же место. Избери свою и иди по ней до конца, не пытаясь свернуть на другую.', 195);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (196, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture208.jpg', '⠀⠀<strong>В</strong>от анонимный текст XVIII века, где речь идет о некоем русском монахе, искавшем себе духовного поводыря. Как-то ему сказали, что в одной деревне живет отшельник, днем и ночью занятый спасением души. И монах отправился к мужу святой жизни.
⠀⠀– Хочу, чтобы ты вел меня по стезям души, – сказал он ему.
⠀⠀– У души – своя собственная стезя, – отвечал пустынник. – И ведет по ней ангел. Молись непрестанно.
⠀⠀– Я так молиться не умею. Научи меня, как надо.
⠀⠀– Если не умеешь молиться непрестанно, попроси Бога, чтобы научил тебя этому.
⠀⠀– Ты ничему не научил меня, – сказал монах.
⠀⠀Учить никого ничему не надо, ибо Веру нельзя передать, как передают познания в математике. Прими тайну Веры – и мироздание откроется тебе.', 196);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (197, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture209.jpg', '⠀⠀<strong>Г</strong>оворит Антонио Мачадо:
⠀⠀Помни, путник, твоя дорога,
⠀⠀только след за твоей спиной
⠀⠀Путник, нет впереди дороги
⠀⠀ты торишь ее целиной.
⠀⠀Целиной ты торишь дорогу,
⠀⠀тропку тянешь ты за собой.
⠀⠀Оглянись! Никогда еще раз
⠀⠀не пройти тебе той тропой.
⠀⠀Путник, в море дороги нету,
⠀⠀только пенный след за кормой [2].
⠀⠀
⠀⠀', 197);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (207, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture219.jpg', '⠀⠀<strong>Г</strong>оворит наставник:
⠀⠀– Расслабься немного. Это – непросто: мы испытываем природную потребность постоянно делать что-то определенное и считаем, что достигнем цели, если будем работать без передышки.
⠀⠀Очень важно пробовать, падать, подниматься и идти дальше. Но еще важней принимать помощь Бога.
⠀⠀Совершая огромное усилие, полезно вдруг остановиться, посмотреть на себя самого, подождать, когда Господь явит свое присутствие и поведет нас.
⠀⠀Давайте позволим Ему время от времени брать нас на руки.', 207);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (198, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture210.jpg', '⠀⠀<strong>Г</strong>оворит наставник:
⠀⠀– Пиши. Не важно, что это будет – письмо, дневник, какие-то заметки, которые нацарапываешь, пока говоришь по телефону.
⠀⠀Когда пишешь, приближаешься к Богу и к людям.
⠀⠀Если хочешь осознать и прочувствовать свою роль в этом мире, – пиши. Постарайся выразить душу свою в написанных тобой строчках, пусть даже никто и никогда их не прочтет. Или еще того хуже – прочтет то, что ты не желаешь доверять чужим глазам. Сам процесс письма помогает упорядочить мысли и более отчетливо увидеть, что тебя окружает. Бумага и перо творят чудеса – унимают боли, укрепляют мечту, возвращают утраченную было надежду. Слово написанное обладает могуществом.', 198);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (199, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture211.jpg', '', 199);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (200, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture212.jpg', '⠀⠀<strong>М</strong>онахи-пустынники утверждали, что необходимо дать ангелам возможность действовать, и ради этого время от времени совершали нелепые и бессмысленные поступки – разговаривали, например, с цветами или смеялись без причины.
⠀⠀Алхимики следуют «Божьим знакам», которые на первый взгляд бессмысленны, однако в конце концов непременно приводят куда-нибудь.', 200);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (201, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture213.jpg', '⠀⠀<strong>Г</strong>оворит наставник:
⠀⠀– Не бойся, что тебя сочтут безумцем. Делай то, что противоречит привычной тебе логике. Изменяй поведение, которому тебя научили. И эта малость при всей своей кажущейся ничтожности открывает двери для великого приключения – человеческого и духовного.', 201);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (202, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture214.jpg', '⠀⠀<strong>Н</strong>екто ехал на роскошном «Мерседесе», как вдруг у него спустило колесо. Начал менять и обнаружил, что нет домкрата.
⠀⠀– Ладно, – сказал себе водитель, – постучу в дверь первого же дома. Авось помогут.
⠀⠀– Хозяева, увидев такую дорогую машину, наверняка захотят содрать с меня что-нибудь, – продолжал он размышлять вслух, направляясь к дому.
⠀⠀– Да не «что-нибудь», а никак не меньше десяти долларов! Да какие там «десять»! Увидят, кто и для чего просит домкрат – и заломят все пятьдесят! Уж постараются нажиться на моем несчастье – меньше чем за сотню не дадут.
⠀⠀И с каждым следующим шагом цена возрастала.
⠀⠀И когда он подошел и постучал и хозяин отворил ему, автомобилист закричал в бешенстве:
⠀⠀– Это грабеж средь бела дня! Не стоит домкрат таких денег! Подавись своим домкратом!
⠀⠀Кто из нас осмелится сказать, что никогда не вел себя подобным образом?', 202);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (203, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture215.jpg', '⠀⠀<strong>М</strong>ильтон Эриксон – автор новой методики лечения, уже успевшей обрести тысячи поклонников в США.
⠀⠀В двенадцать лет он заболел полиомиелитом. Спустя десять месяцев после этого услышал, как врач сказал его родителям:
⠀⠀– Ваш сын не переживет эту ночь. – А вслед за тем – как заплакала мать.
⠀⠀«Может быть, если я сумею дожить до утра, она не будет так горевать?!» – подумал мальчик.
⠀⠀И решил не засыпать до рассвета. А утром крикнул матери:
⠀⠀– Я жив!
⠀⠀Все так обрадовались, что мальчик, чтобы не огорчать родителей, решил продержаться еще сутки.
⠀⠀…Мильтон скончался в 1990 году, в возрасте 7 5 лет, оставив целую серию книг, посвященных важнейшей теме – невероятным способностям, таящимся в человеке и позволяющим ему преодолевать свои ограничения.', 203);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (204, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture216.jpg', '⠀⠀– <strong>С</strong>вятой отец, – сказал послушник настоятелю монастыря аббату Пастору, – сердце мое преисполнено любви к миру, душа свободна от дьявольских искушений. Каков должен быть мой следующий шаг?
⠀⠀Настоятель попросил, чтобы послушник сопровождал его к умирающему, которого надо было соборовать.
⠀⠀Исполнив таинство и сказав несколько ободряющих слов родственникам, Пастор заметил в углу большой сундук.
⠀⠀– А что там лежит? – поинтересовался он.
⠀⠀– Одежда, которую мой дядюшка никогда не надевал, – ответил племянник усопшего. – Все ждал, когда представится случай нарядиться в то или это, а в результате все так и сгнило в сундуке.
⠀⠀– Помни про это сундук, – молвил аббат, когда они вышли из этого дома. – Если есть у тебя в душе сокровища, используй их без промедления, примени к делу. А не то сгниют и сгинут бесцельно.', 204);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (239, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture251.jpg', '⠀⠀<strong>Б</strong>уддийские монахи, когда собираются медитировать, усаживаются перед скалой и думают:
⠀⠀«Теперь буду ждать, когда эта скала увеличится в размерах».', 239);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (216, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture228.jpg', '⠀⠀<strong>Б</strong>ернард Шоу заметил в доме своего друга, скульптора Дж. Эпстейна огромную каменную глыбу и спросил:
⠀⠀– Что ты собираешься с ней делать?
⠀⠀– Не знаю. Пока не решил, – ответил скульптор.
⠀⠀– Иными словами, ты планируешь свое вдохновение? – удивился Шоу. – Но разве ты не знаешь, что художник должен быть волен в любой момент переменить свое намерение?
⠀⠀– Это хорошо для тех, кому, чтобы переменить решение, достаточно скомкать лист бумаги весом в пять грамм. А тому, кто имеет дело с четырехтонной глыбой, приходится действовать несколько иначе, – сказал Эпстейн.', 216);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (217, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture229.jpg', '', 217);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (208, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture220.jpg', '⠀⠀<strong>Н</strong>астоятеля монастыря в Сцете посетил некий юноша, отыскивавший свой духовный путь.
⠀⠀– В течение года давай по монете всякому, кто оскорбит тебя, – сказал ему аббат.
⠀⠀И целых двенадцать месяцев юноша безропотно давал монету всем, кто обижал его. И через год вновь пришел к аббату узнать, что делать дальше.
⠀⠀– Сходи в город, купи там еды для меня, – велел настоятель.
⠀⠀А сам переоделся нищим и, воспользовавшись короткой дорогой, оказался у городских ворот раньше юноши. Когда же тот появился, начал оскорблять его.
⠀⠀– Слава Богу! – воскликнул юноша. – Целый год я должен быть платить всем, кто оскорблял меня, а теперь могу наконец слушать насмешки и брань бесплатно.
⠀⠀Услышав это, аббат предстал перед ним в своем истинном виде:
⠀⠀– Ты научился смеяться над своими трудностями, а значит, готов совершить следующий шаг.', 208);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (209, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture221.jpg', '⠀⠀<strong>С</strong>транник вместе с двумя приятелями шел по улице в Нью-Йорке.
⠀⠀Внезапно, посреди самого обычного, заурядного разговора приятели заспорили – да так, что едва не набросились друг на друга с кулаками.
⠀⠀Попозже – когда оба немного остыли – они зашли в бар, и один попросил у другого извинения за свою несдержанность, прибавив:
⠀⠀– Я давно заметил, что гораздо проще обидеть близкого тебе человека. Был бы ты посторонним, я, конечно, вел бы себя иначе. А тут – и именно потому, что ты понимаешь меня лучше, чем кто-либо еще – я и разъярился до такой степени. Может быть, это в природе человека.
⠀⠀Может, и в природе.
⠀⠀Но мы будем бороться с этим.', 209);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (210, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture222.jpg', '⠀⠀<strong>С</strong>лучается так, что нам очень хочется помочь тому или иному человеку, но мы ничего не можем сделать. Либо обстоятельства не позволяют нам приблизиться к нему, либо сам человек этот закрыт для любого проявления солидарности и поддержки.', 210);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (212, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture224.jpg', '⠀⠀<strong>Г</strong>оворит наставник:
⠀⠀– Нам остается любовь. Когда все прочее уже бессмысленно и бесполезно, мы все еще можем любить – любить, не ожидая ни благодарности, ни взаимности, ни перемен.
⠀⠀И если удастся действовать таким образом, то энергия любви начнет преобразовывать вселенную вокруг нас.
⠀⠀Когда появляется эта энергия, всегда можно осуществить желаемое.', 212);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (213, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture225.jpg', '⠀⠀<strong>А</strong>нглийский поэт Джон Ките (1795–1821) дал превосходное определение поэзии. При желании его можно отнести и к самой жизни. «Поэзия должна удивлять нас неназойливым избытком, а не тем, что она – иная. Стихи должны трогать нашего ближнего так, словно прочитанные им слова произнес он сам, словно он вдруг припомнил то, что некогда, во тьме времен, уже было начертано в его душе».', 213);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (214, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture226.jpg', '⠀⠀<strong>Г</strong>де-то в середине семидесятых годов, в пору активного отрицания веры, странник вместе с женой и приятельницей находился в Рио-де-Жанейро. Они сидели в баре и выпивали, когда к ним присоединился давний друг странника, неизменный спутник его юношеских безумств.
⠀⠀– Чем ты занят теперь? – спросил его странник.
⠀⠀– Я стал священником, – отвечал тот.
⠀⠀Когда вышли на улицу, странник указал на беспризорного ребенка, ночевавшего на тротуаре.
⠀⠀– Видишь, как Иисус заботится о нашем мире? – спросил он.
⠀⠀– Разумеется, вижу. Он сделал так, чтобы это бездомное дитя попалось тебе на глаза и ты мог что-то сделать для него.', 214);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (215, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture227.jpg', '⠀⠀<strong>Н</strong>есколько еврейских мудрецов решили создать самую лучшую конституцию в мире. Если за то время, что можно простоять, балансируя, на одной ноге, кто-нибудь сумеет сформулировать законы, призванные управлять поведением человека, этот «кто-то» будет признан мудрейшим из мудрых.
⠀⠀– Господь карает преступников, – сказал один.
⠀⠀Ему ответили, что это не закон, а угроза, и вариант был отвергнут.
⠀⠀В этот миг подошел раввин Гиллель и, балансируя на одной ноге, сказал:
⠀⠀– Не делай своему ближнему, чего не хочешь, чтобы делали тебе. Таков Закон. Все прочее – юридические комментарии.
⠀⠀И его признали мудрейшим.', 215);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (219, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture231.jpg', '⠀⠀<strong>А</strong>ббат Жоан Пекено подумал однажды: «Я должен уподобиться ангелам, которые ничего не делают, а только созерцают Господа во славе Его».
⠀⠀И в ту же ночь оставил монастырь в Сцете и удалился в пустыню.
⠀⠀Но через неделю вернулся в обитель. Брат-привратник услышал стук в двери и спросил:
⠀⠀– Кто там?
⠀⠀– Аббат Жоан, – послышалось снаружи. – Я голоден.
⠀⠀– Быть того не может! Брат Жоан находится в пустыне и превращается в ангела. Он больше не знает, что такое голод, и не должен работать ради поддержания своей бренной плоти.
⠀⠀– Прости мне мою гордыню, – сказал тогда Жоан. – Ангелы помогают людям и потому созерцают Господа во славе Его. Я же увижу это, если буду исполнять свою повседневную работу.
⠀⠀И, услышав эти слова, исполненные смирения, привратник отпер дверь.', 219);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (220, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture232.jpg', '⠀⠀<strong>И</strong>зо всех средств уничтожения, изобретенных человеком, самое чудовищное, но при этом еще и самое трусливое – это слово. Холодное оружие, как и огнестрельное оставляют кровавые следы.
⠀⠀Бомбы несут разрушение, превращая дома в руины.
⠀⠀Если человека отравили, в конце концов можно установить, каким ядом.
⠀⠀Слово же способно уничтожать, не оставляя следов. Детей на протяжении нескольких лет воспитывают родители, взрослых подвергают беспощадной критике, женщин систематически терзают замечания и придирки мужей. Верующих не допускают к религии усилия тех, кто счел себя вправе толковать голос Господа.
⠀⠀Постарайся заметить, пользуешься ли этим оружием ты. Постарайся заметить, обращают ли это оружие против тебя. И не допускай ни того ни другого.', 220);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (221, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture233.jpg', '⠀⠀<strong>У</strong>ильямс попытался описать весьма любопытную ситуацию: «Представим себе, что жизнь достигла идеального совершенства. Ты обитаешь в совершенном мире, тебя окружают совершенные люди, у которых есть все, что им надо и хочется, и все в мире происходит в точности так и тогда, как и когда требуется. В этом мире ты обладаешь всем, чего желаешь, и только тем, чего желаешь, и все полностью отвечает твоим мечтам и представлениям. И жить ты будешь столько, сколько пожелаешь.
⠀⠀Так вот, представь, что так проходит лет сто или двести, и ты, присев на незапятнанно-чистую скамью, оглядываешь чудесный пейзаж вокруг и думаешь: «Какая тоска! Никаких эмоций!»
⠀⠀И в этот миг замечаешь перед собой красную кнопку с надписью: «СЮРПРИЗ!»
⠀⠀Обдумав все, что может означать это слово, ты нажмешь кнопку? – Ну разумеется! И тотчас окажешься в черном туннеле, а по выходе из него – в том далеком от совершенства мире, где живешь сейчас».', 221);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (222, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture234.jpg', '⠀⠀<strong>В</strong> одной легенде рассказывается о некоем бедуине, решившем перебраться из одного оазиса в другой. Он грузил на верблюда свои пожитки – ковры, утварь, сундуки с одеждой – и верблюд все выдерживал. Уже перед тем, как тронуться в путь, бедуин вспомнил о красивом синем перышке, что когда-то подарил ему отец. Он вернулся за ним и тоже положил на спину верблюду. Но тот вдруг упал и умер – ноша оказалась чересчур тяжела. «Мой верблюд не снес веса птичьего перышка», – подумал бедуин.', 222);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (224, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture236.jpg', '⠀⠀– <strong>П</strong>орою мы так же поступаем с нашим ближним, не удосуживаясь понять, что очередная шутка может стать той последней каплей, которая переполнит чашу его терпения.
⠀⠀Порою мы так привыкаем к тому, что видели в кино, что забываем в конце концов, как обстояло дело в действительности, – сказал кто-то страннику, осматривавшему порт Майами. – Помните фильм «Десять заповедей»?
⠀⠀– Конечно. Моисей, которого играет Чарльтон Хестон, вздымает свой посох, воды Чермного моря расступаются и народ израильский проходит, «аки посуху», – ответил странник.
⠀⠀– В том-то и дело, что в Священном Писании по-другому. Там Бог приказывает Моисею: «Скажи сынам Израилевым, чтобы они шли…»
⠀⠀И лишь после того, как те двинулись вперед, Моисей поднял свой посох, и воды Красного моря расступились.
⠀⠀Ибо только готовность преодолеть путь позволит этот путь обнаружить.', 224);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (225, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture237.jpg', '⠀⠀<strong>Э</strong>ти слова принадлежат перу виолончелиста Пабло Касальса:
⠀⠀«Я постоянно возрождаюсь. Каждое новое утро – это отправной пункт новой жизни. Вот уже восемьдесят лет я начинаю свой день одинаково, причем это означает не механическую рутину, а нечто совершенно необходимое для того, чтобы я был счастлив.
⠀⠀Я просыпаюсь, иду к роялю, играю две прелюдии и фугу Баха. Эта музыка звучит как благословение моему дому. И одновременно это – способ восстановить связь с тайной бытия, с чудом принадлежности к человеческому роду.
⠀⠀Хотя я занимаюсь этим на протяжении восьмидесяти лет, музыка никогда не остается прежней – она всегда учит меня чему-то новому, фантастическому, невероятному».', 225);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (226, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture238.jpg', '⠀⠀<strong>Г</strong>оворит наставник:
⠀⠀– С одной стороны, мы знаем, как важно искать Бога. С другой – жизнь отдаляет нас от Него: мы чувствуем, что Высшей Силе нет до нас дела, или что она о нас ничего не знает, или мы отвлекаемся на повседневные заботы. От этого возникает чувство вины: мы либо чувствуем, что во имя Бога отрекаемся от жизни, либо – что ради жизни предаем забвению Его.
⠀⠀На самом деле эта двойственность – кажущаяся, потому что Бог – в жизни, а жизнь – в Боге. Достаточно сознавать это, чтобы лучше понимать свою судьбу. Если мы сумеем проникнуть в священную гармонию нашего повседневного бытия, то выйдем на правый путь и исполним свое предназначение.', 226);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (227, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture239.jpg', '⠀⠀<strong>П</strong>абло Пикассо сказал как-то:
⠀⠀Бог – художник. Он придумал жирафа, слона и муравья. И, по правде говоря, Он никогда не стремился следовать определенному стилю, а просто делал все, что ему хотелось делать.', 227);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (228, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture240.jpg', '⠀⠀<strong>Г</strong>оворит наставник:
⠀⠀– Когда мы вступаем на предназначенную нам стезю, нами овладевает сильный страх – мы чувствуем, что непременно должны сделать все «как надо». Но ведь у каждого – своя жизнь, единственная и неповторимая,так откуда же взялось понятие «как надо»? Господь сотворил и жирафа, и слона, и муравья – почему же мы обязаны следовать чьему-то примеру?
⠀⠀Пример служит лишь для того, чтобы показать, как другие определяют свою действительность. Мы можем восхищаться этим, но можем и избежать повторения чужих ошибок.
⠀⠀Но как жить – позвольте решать только и исключительно нам самим, и никому больше.', 228);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (230, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture242.jpg', '⠀⠀<strong>Н</strong>есколько благочестивых иудеев молились в синагоге, как вдруг раздался детский голос:
⠀⠀– А, В, С…
⠀⠀Прихожане старались сосредоточиться на священных текстах, но голос повторил:
⠀⠀– А, В, С…
⠀⠀Постепенно молитва прекратилась, и люди, обернувшись, увидели мальчика, который повторял:
⠀⠀– А, В, С…
⠀⠀Раввин приблизился к нему и спросил:
⠀⠀– Зачем ты это делаешь?
⠀⠀– За тем, что не знаю слов молитвы. И питаю надежду, что Бог, услышав буквы алфавита, сам составит из них правильные слова.
⠀⠀– Спасибо тебе за этот урок, – сказал раввин. – Хотелось бы и мне вверить Богу дни мои на этой земле так же, как ты вверяешь ему эти буквы.', 230);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (231, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture243.jpg', '⠀⠀<strong>Г</strong>оворит наставник:
⠀⠀– Дух Божий, который присутствует в нас, можно уподобить киноэкрану. По нему проходят, чередуясь, разнообразные ситуации – люди любят друг друга, люди расстаются, ищут и не могут найти сокровища, открывают дальние страны.
⠀⠀И не имеет значения, какой фильм показывают – экран всегда остается прежним. Не важно, катятся ли слезы, льется ли кровь – ничто не может запятнать белизну экранного полотна.
⠀⠀И точно так же Бог – вне и превыше всех житейских восторгов и горестей. И когда наш фильм подойдет к концу, мы все увидим это.', 231);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (232, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture244.jpg', '⠀⠀<strong>Н</strong>екий лучник прогуливался в окрестностях индуистского монастыря, известного строгостью устава, и вдруг увидел в саду обители нескольких монахов, которые пили и шумно веселились.
⠀⠀– Какое бесстыдство со стороны тех, кто ищет путь к Богу, – вслух и довольно громко молвил лучник. – Уверяют всех, что важен порядок, а сами втихомолку пьянствуют!
⠀⠀– Если ты выпустишь сто стрел подряд, что станется с твоим луком? – спросил старший из монахов.
⠀⠀– Он сломается.
⠀⠀– Если кто-то превысит предел допустимого, он тоже сломает свою волю, – сказал монах. – Тот, кто не умеет уравновесить труд досугом, вскоре потеряет воодушевление и не сможет пройти далеко.', 232);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (233, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture245.jpg', '⠀⠀<strong>О</strong>дин царь послал в далекую страну гонца, поручив ему отвезти туда мирный договор, который должен был быть подписан тамошним властелином.
⠀⠀Гонец, желая получить выгоду от этого, рассказал о поручении нескольким друзьям, имевшим в той стране свои торговые интересы. Друзья попросили гонца помедлить несколько дней, сами же тем временем в преддверии мирного договора изменили свою стратегию.
⠀⠀Когда же гонец наконец отправился в путь, оказалось, что предложения мира запоздали – грянула война, уничтожив и намерения царя, и планы купцов, задержавших посла.', 233);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (234, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture246.jpg', '⠀⠀<strong>Г</strong>оворит наставник:
⠀⠀– В нашей жизни важно лишь одно – следовать Своей Стезей, исполняя сужденное тебе. А мы все обременяем себя бесполезными занятиями, которые в конце концов разрушают наши мечты.', 234);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (236, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture248.jpg', '⠀⠀<strong>К</strong>огда странник стоял в Сиднейском порту, рассматривая мост, соединяющий две части города, к нему подошел австралиец и попросил его прочесть объявление в газете:
⠀⠀– Шрифт очень мелкий, – объяснил он. – Ничего не могу разобрать, а очки дома оставил.
⠀⠀Но и странник не захватил с собой очки для чтения и сожалением отказал австралийцу.
⠀⠀– В таком случае лучше вообще забыть про это объявление, – сказал тот, помолчав. И, желая продолжить разговор, добавил: – Не только у нас с вами, но и у самого Господа Бога ослабело зрение. И не потому что Он состарился, а потому что сам выбрал для себя это. И вот, когда кто-то из близких Ему совершает дурной поступок, Он, не в силах разглядеть все в подробностях, прощает его, потому что боится проявить несправедливость.
⠀⠀– Ну а добрые дела? – осведомился странник.
⠀⠀– В этом случае Бог никогда не забывает очки дома, – засмеялся австралиец, собираясь уходить.', 236);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (237, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture249.jpg', '⠀⠀– <strong>Е</strong>сть ли на свете что-либо важнее молитвы? – спросил ученик у своего наставника.
⠀⠀А тот попросил его дойти до ближайшего дерева и срезать с него ветку. Ученик повиновался.
⠀⠀– Дерево не погибло? – спросил наставник.
⠀⠀– Живехонько, как и прежде, – ответил ученик.
⠀⠀– В таком случае отправляйся к нему снова и переруби его корень.
⠀⠀– Если я сделаю так, дерево засохнет.
⠀⠀– Молитвы – суть ветви дерева, а корень его – вера, – сказал тогда наставник. – Вера может выжить без молитв, а вот молитвы без веры не бывает.', 237);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (238, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture250.jpg', '⠀⠀<strong>С</strong>вятая Тереза Авильская написала: «Помните – Господь пригласил нас всех, а поскольку Он есть воплощение истины, мы не можем сомневаться в том, что приглашение это – от чистого сердца.
⠀⠀Он сказал: „Придите ко мне страждущие, и я напою вас”.
⠀⠀Если бы призыв этот был направлен не к каждому из нас, Господь сказал бы: „Придите ко мне все, кто хочет, ибо вам нечего больше терять. Но я дам напиться лишь тем, кто уже готов”.
⠀⠀Однако Господь не ставит никаких условий. Достаточно захотеть и прийти и получить Живую Воду его любви».', 238);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (240, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture252.jpg', '⠀⠀<strong>Г</strong>оворит наставник:
⠀⠀– Вокруг нас все постоянно меняется.
⠀⠀И каждое утро солнце освещает новый мир.
⠀⠀А то, что мы называем «рутиной», изобилует новыми возможностями, новыми предложениями. Однако мы не сознаем, что каждый новый день отличается от предыдущего.
⠀⠀Сегодня где-то нас поджидает сокровище. Это может быть мимолетная улыбка, а может – ослепительная победа. Не имеет значения. Жизнь состоит из множества больших и малых чудес. Ничто не может надоесть, ибо изменяется беспрестанно. Скука и уныние заключены не в самом мире, но в том, как мы смотрим на него.', 240);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (241, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture253.jpg', '⠀⠀<strong>П</strong>о слову поэта Т. С. Элиота:
⠀⠀', 241);
INSERT INTO public.pages_books (id, created_at, book_id, photo, text, number) VALUES (242, '2025-08-24 17:59:58.185943+03', 9, './db/wisdoms/Paulo Coelho Maktub/picture254.jpg', '⠀⠀<strong>М</strong>АРИЯ, БЕЗ ПЕРВОРОДНОГО ГРЕХА
⠀⠀ЗАЧАВШАЯ, МОЛИ БОГА О НАС,
⠀⠀К ТЕБЕ ПРИБЕГАЮЩИХ', 242);


--
-- TOC entry 3470 (class 0 OID 16389)
-- Dependencies: 218
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users (id, created_at, user_id, username, language, role, is_alive, banned, selected_book, page_selected_book, selected_wisdom, page_selected_wisdom, time_send_wisdom, enable_wisdom) VALUES (4, '2025-08-25 11:31:06.933821+03', 5280741755, NULL, 'ru', 'user', false, false, 6, NULL, NULL, NULL, '09:00:00', false);
INSERT INTO public.users (id, created_at, user_id, username, language, role, is_alive, banned, selected_book, page_selected_book, selected_wisdom, page_selected_wisdom, time_send_wisdom, enable_wisdom) VALUES (5, '2025-08-28 18:48:31.731043+03', 7014705235, 'zverroyacher', 'ru', 'user', false, false, 1, 1, 9, 31, '09:00:00', true);
INSERT INTO public.users (id, created_at, user_id, username, language, role, is_alive, banned, selected_book, page_selected_book, selected_wisdom, page_selected_wisdom, time_send_wisdom, enable_wisdom) VALUES (6, '2025-08-28 18:48:31.731043+03', 5367209353, 'yahsssl', 'ru', 'user', false, false, 1, 1, 9, NULL, '09:00:00', false);
INSERT INTO public.users (id, created_at, user_id, username, language, role, is_alive, banned, selected_book, page_selected_book, selected_wisdom, page_selected_wisdom, time_send_wisdom, enable_wisdom) VALUES (7, '2025-08-28 18:48:31.731043+03', 1749203311, 'mishaghj777', 'ru', 'user', false, false, 2, 1, 9, 31, '09:00:00', true);
INSERT INTO public.users (id, created_at, user_id, username, language, role, is_alive, banned, selected_book, page_selected_book, selected_wisdom, page_selected_wisdom, time_send_wisdom, enable_wisdom) VALUES (8, '2025-08-28 18:48:31.731043+03', 7431741727, NULL, 'ru', 'user', false, false, 1, 2, 9, 21, '09:00:00', false);
INSERT INTO public.users (id, created_at, user_id, username, language, role, is_alive, banned, selected_book, page_selected_book, selected_wisdom, page_selected_wisdom, time_send_wisdom, enable_wisdom) VALUES (9, '2025-08-28 18:48:31.731043+03', 1083268429, 'VladimirS_L', 'ru', 'user', false, false, 1, 1, 9, 31, '09:00:00', true);
INSERT INTO public.users (id, created_at, user_id, username, language, role, is_alive, banned, selected_book, page_selected_book, selected_wisdom, page_selected_wisdom, time_send_wisdom, enable_wisdom) VALUES (10, '2025-08-28 18:48:31.731043+03', 507682242, 'antokuz', 'ru', 'user', false, false, 1, 9, 9, NULL, '09:00:00', false);
INSERT INTO public.users (id, created_at, user_id, username, language, role, is_alive, banned, selected_book, page_selected_book, selected_wisdom, page_selected_wisdom, time_send_wisdom, enable_wisdom) VALUES (11, '2025-08-28 18:48:31.731043+03', 1895561225, 'ErnestVlasov', 'ru', 'user', false, false, 4, 3, 9, 20, '09:00:00', true);
INSERT INTO public.users (id, created_at, user_id, username, language, role, is_alive, banned, selected_book, page_selected_book, selected_wisdom, page_selected_wisdom, time_send_wisdom, enable_wisdom) VALUES (12, '2025-08-28 18:48:31.731043+03', 5806172904, 'Fczch3434', 'ru', 'user', false, false, 1, 1, 9, NULL, '09:00:00', false);
INSERT INTO public.users (id, created_at, user_id, username, language, role, is_alive, banned, selected_book, page_selected_book, selected_wisdom, page_selected_wisdom, time_send_wisdom, enable_wisdom) VALUES (13, '2025-08-28 18:48:31.731043+03', 6741197747, 'Tankoy_74', 'ru', 'user', false, false, 1, 9, 9, NULL, '09:00:00', false);
INSERT INTO public.users (id, created_at, user_id, username, language, role, is_alive, banned, selected_book, page_selected_book, selected_wisdom, page_selected_wisdom, time_send_wisdom, enable_wisdom) VALUES (14, '2025-08-28 18:48:31.731043+03', 857509540, 'Nikaaaaaa22', 'ru', 'user', false, false, 1, 1, 9, 27, '09:00:00', true);
INSERT INTO public.users (id, created_at, user_id, username, language, role, is_alive, banned, selected_book, page_selected_book, selected_wisdom, page_selected_wisdom, time_send_wisdom, enable_wisdom) VALUES (15, '2025-08-28 18:48:31.731043+03', 7668089951, NULL, 'ru', 'user', false, false, 1, 1, 9, NULL, '09:00:00', false);
INSERT INTO public.users (id, created_at, user_id, username, language, role, is_alive, banned, selected_book, page_selected_book, selected_wisdom, page_selected_wisdom, time_send_wisdom, enable_wisdom) VALUES (16, '2025-08-28 18:48:31.731043+03', 1739942080, 'Siemaj', 'ru', 'user', false, false, 1, 9, 9, 29, '09:00:00', true);
INSERT INTO public.users (id, created_at, user_id, username, language, role, is_alive, banned, selected_book, page_selected_book, selected_wisdom, page_selected_wisdom, time_send_wisdom, enable_wisdom) VALUES (17, '2025-08-28 18:48:31.731043+03', 6311240974, NULL, 'ru', 'user', false, false, 1, 1, 9, NULL, '09:00:00', false);
INSERT INTO public.users (id, created_at, user_id, username, language, role, is_alive, banned, selected_book, page_selected_book, selected_wisdom, page_selected_wisdom, time_send_wisdom, enable_wisdom) VALUES (18, '2025-08-28 18:48:31.731043+03', 1267456687, NULL, 'ru', 'user', false, false, 1, 1, 9, 29, '09:00:00', true);
INSERT INTO public.users (id, created_at, user_id, username, language, role, is_alive, banned, selected_book, page_selected_book, selected_wisdom, page_selected_wisdom, time_send_wisdom, enable_wisdom) VALUES (19, '2025-08-28 18:48:31.731043+03', 478251840, 'MishaSky7', 'ru', 'user', false, false, 3, 1, 9, NULL, '09:00:00', false);
INSERT INTO public.users (id, created_at, user_id, username, language, role, is_alive, banned, selected_book, page_selected_book, selected_wisdom, page_selected_wisdom, time_send_wisdom, enable_wisdom) VALUES (20, '2025-08-28 18:48:31.731043+03', 807674772, 'marshallall', 'ru', 'user', false, false, 1, 1, 9, 28, '09:00:00', true);
INSERT INTO public.users (id, created_at, user_id, username, language, role, is_alive, banned, selected_book, page_selected_book, selected_wisdom, page_selected_wisdom, time_send_wisdom, enable_wisdom) VALUES (21, '2025-08-28 18:48:31.731043+03', 843043689, 'NATAMALOV', 'ru', 'user', false, false, 3, 1, 9, 16, '09:00:00', true);
INSERT INTO public.users (id, created_at, user_id, username, language, role, is_alive, banned, selected_book, page_selected_book, selected_wisdom, page_selected_wisdom, time_send_wisdom, enable_wisdom) VALUES (22, '2025-08-28 18:48:31.731043+03', 433970956, 'copucopucopu', 'ru', 'user', false, false, 1, 1, 9, 2, '09:00:00', false);
INSERT INTO public.users (id, created_at, user_id, username, language, role, is_alive, banned, selected_book, page_selected_book, selected_wisdom, page_selected_wisdom, time_send_wisdom, enable_wisdom) VALUES (23, '2025-08-28 18:48:31.731043+03', 1681352585, NULL, 'ru', 'user', false, false, 1, 1, 9, 13, '09:00:00', true);
INSERT INTO public.users (id, created_at, user_id, username, language, role, is_alive, banned, selected_book, page_selected_book, selected_wisdom, page_selected_wisdom, time_send_wisdom, enable_wisdom) VALUES (1, '2025-08-24 17:47:44.673566+03', 2015275939, 'brusiya', 'ru', 'user', false, false, 1, 4, 9, 30, '09:00:00', true);
INSERT INTO public.users (id, created_at, user_id, username, language, role, is_alive, banned, selected_book, page_selected_book, selected_wisdom, page_selected_wisdom, time_send_wisdom, enable_wisdom) VALUES (2, '2025-08-24 17:47:44.673566+03', 837754073, 'SunatOlimov', 'ru', 'user', false, false, 1, 1, 9, 30, '09:00:00', true);
INSERT INTO public.users (id, created_at, user_id, username, language, role, is_alive, banned, selected_book, page_selected_book, selected_wisdom, page_selected_wisdom, time_send_wisdom, enable_wisdom) VALUES (3, '2025-08-24 17:47:44.673566+03', 574227924, 'Shavkatdjon', 'ru', 'admin', false, false, 12, 1, 9, 3, '09:00:00', true);


--
-- TOC entry 3489 (class 0 OID 0)
-- Dependencies: 219
-- Name: activity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.activity_id_seq', 201, true);


--
-- TOC entry 3490 (class 0 OID 0)
-- Dependencies: 221
-- Name: books_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.books_id_seq', 12, true);


--
-- TOC entry 3491 (class 0 OID 0)
-- Dependencies: 225
-- Name: marks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.marks_id_seq', 5, true);


--
-- TOC entry 3492 (class 0 OID 0)
-- Dependencies: 223
-- Name: pages_books_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pages_books_id_seq', 1453, true);


--
-- TOC entry 3493 (class 0 OID 0)
-- Dependencies: 217
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 23, true);


--
-- TOC entry 3309 (class 2606 OID 16408)
-- Name: activity activity_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activity
    ADD CONSTRAINT activity_pkey PRIMARY KEY (id);


--
-- TOC entry 3312 (class 2606 OID 16449)
-- Name: books books_name_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books
    ADD CONSTRAINT books_name_unique UNIQUE (name);


--
-- TOC entry 3314 (class 2606 OID 16419)
-- Name: books books_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books
    ADD CONSTRAINT books_pkey PRIMARY KEY (id);


--
-- TOC entry 3318 (class 2606 OID 16477)
-- Name: marks marks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.marks
    ADD CONSTRAINT marks_pkey PRIMARY KEY (id);


--
-- TOC entry 3316 (class 2606 OID 16429)
-- Name: pages_books pages_books_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pages_books
    ADD CONSTRAINT pages_books_pkey PRIMARY KEY (id);


--
-- TOC entry 3305 (class 2606 OID 16397)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 3307 (class 2606 OID 16399)
-- Name: users users_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_user_id_key UNIQUE (user_id);


--
-- TOC entry 3310 (class 1259 OID 16409)
-- Name: idx_activity_user_day; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_activity_user_day ON public.activity USING btree (user_id, activity_date);


--
-- TOC entry 3319 (class 2606 OID 16430)
-- Name: activity activity_fk2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activity
    ADD CONSTRAINT activity_fk2 FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- TOC entry 3320 (class 2606 OID 16435)
-- Name: books books_fk4; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books
    ADD CONSTRAINT books_fk4 FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE SET NULL;


--
-- TOC entry 3322 (class 2606 OID 16483)
-- Name: marks fk_marks_books; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.marks
    ADD CONSTRAINT fk_marks_books FOREIGN KEY (book_id) REFERENCES public.books(id) ON DELETE CASCADE;


--
-- TOC entry 3323 (class 2606 OID 16478)
-- Name: marks fk_marks_users; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.marks
    ADD CONSTRAINT fk_marks_users FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- TOC entry 3321 (class 2606 OID 16440)
-- Name: pages_books pages_books_fk2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pages_books
    ADD CONSTRAINT pages_books_fk2 FOREIGN KEY (book_id) REFERENCES public.books(id) ON DELETE CASCADE;


-- Completed on 2025-08-28 17:14:00 UTC

--
-- PostgreSQL database dump complete
--

\unrestrict nQxgLbJSwZnuTEwq5syS0sh6Sz8j1nat6eVgQ5dhVAKNsqjxyh9Eo4FROdcxrHM

