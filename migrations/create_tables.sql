CREATE TABLE
	IF NOT EXISTS "users" (
		"id" serial NOT NULL UNIQUE,
		"created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW (),
		"user_id" bigint NOT NULL UNIQUE,
		"username" varchar(50),
		"language" varchar(10) NOT NULL,
		"role" varchar(30) NOT NULL,
		"is_alive" boolean NOT NULL DEFAULT false,
		"banned" boolean NOT NULL DEFAULT false,
		"selected_book" integer,
		"page_selected_book" integer,
		"enable_wisdom" boolean NOT NULL DEFAULT false,
		"selected_wisdom" integer,
		"page_selected_wisdom" integer,
		"time_send_wisdom" time NOT NULL,
		PRIMARY KEY ("id")
	);

CREATE TABLE
	IF NOT EXISTS "activity" (
		"id" serial NOT NULL UNIQUE,
		"created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW (),
		"user_id" bigint NOT NULL,
		"activity_date" date NOT NULL,
		"actions" integer NOT NULL DEFAULT 1,
		PRIMARY KEY ("id")
	);

CREATE UNIQUE INDEX IF NOT EXISTS idx_activity_user_day ON activity (user_id, activity_date);

CREATE TABLE
	IF NOT EXISTS "books" (
		"id" serial NOT NULL UNIQUE,
		"created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW (),
		"name" varchar(100) NOT NULL,
		"author" varchar(100) NOT NULL,
		"user_id" bigint NOT NULL,
		"access" varchar(10) NOT NULL,
		"wisdom" boolean NOT NULL,
		"path" text NOT NULL,
		"page_size" integer NOT NULL,
		"count_pages" integer NOT NULL,
		PRIMARY KEY ("id")
	);

CREATE TABLE
	IF NOT EXISTS "pages_books" (
		"id" serial NOT NULL UNIQUE,
		"created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW (),
		"book_id" integer NOT NULL,
		"number" integer NOT NULL,
		"photo" text,
		"text" text,
		PRIMARY KEY ("id")
	);

-- activity: удалить все активности пользователя
ALTER TABLE "activity"
DROP CONSTRAINT IF EXISTS "activity_fk2",
ADD CONSTRAINT "activity_fk2" FOREIGN KEY ("user_id") REFERENCES "users" ("user_id") ON DELETE CASCADE;

-- books: при удалении пользователя поле user_id обнуляется
ALTER TABLE "books"
DROP CONSTRAINT IF EXISTS "books_fk4",
ADD CONSTRAINT "books_fk4" FOREIGN KEY ("user_id") REFERENCES "users" ("user_id") ON DELETE SET NULL;

-- pages_books: при удалении книги удаляются все страницы
ALTER TABLE "pages_books"
DROP CONSTRAINT IF EXISTS "pages_books_fk2",
ADD CONSTRAINT "pages_books_fk2" FOREIGN KEY ("book_id") REFERENCES "books" ("id") ON DELETE CASCADE;

CREATE TABLE IF NOT EXISTS public.marks (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    user_id BIGINT NOT NULL,
    book_id INT NOT NULL,
    number_page INT NOT NULL,
    
    CONSTRAINT fk_marks_users FOREIGN KEY (user_id)
        REFERENCES public.users (user_id)
        ON DELETE CASCADE,
        
    CONSTRAINT fk_marks_books FOREIGN KEY (book_id)
        REFERENCES public.books (id)
        ON DELETE CASCADE
);
