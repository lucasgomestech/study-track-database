/* ENUMS */
CREATE TYPE "gender_t" AS ENUM (
  'FEMALE',
  'MALE',
  'OTHER',
  'ANONYMOUS'
);

CREATE TYPE "document_t" AS ENUM (
  'RG',
  'CPF',
  'CNPJ',
  'PASSPORT',
  'OTHER'
);

CREATE TYPE "device_t" AS ENUM (
  'MOBILE',
  'TABLET'
);

CREATE TYPE "relationship_t" AS ENUM (
  'ADMIN',
  'STUDENT',
  'EMPLOYEE',
  'MEMBER',
  'MODERATOR',
  'COLABORATOR'
);

/* TABLES */
CREATE TABLE "t_person" (
  "id" SERIAL PRIMARY KEY,
  "name" varchar NOT NULL,
  "birth_date" date,
  "gender" gender_t NOT NULL,
  "email" varchar UNIQUE,
  "country_id" int,
  "modified_at" timestamptz DEFAULT (now()),
  "created_at" timestamptz DEFAULT (now())
);

CREATE TABLE "t_document" (
  "id" SERIAL PRIMARY KEY,
  "owner_id" int,
  "document_id" varchar,
  "document_type" document_t,
  "country_id" int,
  "modified_at" timestamptz DEFAULT (now()),
  "created_at" timestamptz DEFAULT (now())
);

CREATE TABLE "t_company" (
  "id" SERIAL PRIMARY KEY,
  "country_id" int,
  "primary_contact" int,
  "name" varchar NOT NULL,
  "email" varchar UNIQUE,
  "modified_at" timestamptz DEFAULT (now()),
  "created_at" timestamptz DEFAULT (now())
);

CREATE TABLE "t_country" (
  "id" SERIAL PRIMARY KEY,
  "code" int UNIQUE,
  "name" varchar NOT NULL
);

CREATE TABLE "t_group" (
  "id" SERIAL PRIMARY KEY,
  "owner_id" int,
  "name" varchar NOT NULL,
  "goal" varchar NOT NULL,
  "modified_at" timestamptz DEFAULT (now()),
  "created_at" timestamptz DEFAULT (now())
);

CREATE TABLE "t_relationship" (
  "id" SERIAL PRIMARY KEY,
  "target_id" int,
  "source_id" int,
  "relationship_type" relationship_t NOT NULL,
  "code" varchar,
  "modified_at" timestamptz DEFAULT (now()),
  "created_at" timestamptz DEFAULT (now())
);

CREATE TABLE "t_device" (
  "id" SERIAL PRIMARY KEY,
  "person_id" int,
  "number" int,
  "imei" int UNIQUE,
  "os" varchar,
  "device_type" device_t NOT NULL,
  "modified_at" timestamptz DEFAULT (now()),
  "created_at" timestamptz DEFAULT (now())
);

CREATE TABLE "t_study_guide" (
  "id" SERIAL PRIMARY KEY,
  "owner_id" int,
  "title" varchar NOT NULL,
  "description" varchar NOT NULL,
  "goal" varchar NOT NULL,
  "activities" int NOT NULL,
  "duration" int NOT NULL,
  "modules" int NOT NULL,
  "used_by" int NOT NULL,
  "modified_at" timestamptz DEFAULT (now()),
  "created_at" timestamptz DEFAULT (now())
);

/* CONSTRAINTS */
ALTER TABLE "t_person" ADD FOREIGN KEY ("country_id") REFERENCES "t_country" ("id");

ALTER TABLE "t_document" ADD FOREIGN KEY ("owner_id") REFERENCES "t_person" ("id");

ALTER TABLE "t_document" ADD FOREIGN KEY ("owner_id") REFERENCES "t_company" ("id");

ALTER TABLE "t_document" ADD FOREIGN KEY ("country_id") REFERENCES "t_country" ("id");

ALTER TABLE "t_company" ADD FOREIGN KEY ("country_id") REFERENCES "t_country" ("id");

ALTER TABLE "t_company" ADD FOREIGN KEY ("primary_contact") REFERENCES "t_person" ("id");

ALTER TABLE "t_group" ADD FOREIGN KEY ("owner_id") REFERENCES "t_person" ("id");

ALTER TABLE "t_group" ADD FOREIGN KEY ("owner_id") REFERENCES "t_company" ("id");

ALTER TABLE "t_relationship" ADD FOREIGN KEY ("target_id") REFERENCES "t_person" ("id");

ALTER TABLE "t_relationship" ADD FOREIGN KEY ("target_id") REFERENCES "t_company" ("id");

ALTER TABLE "t_relationship" ADD FOREIGN KEY ("source_id") REFERENCES "t_person" ("id");

ALTER TABLE "t_relationship" ADD FOREIGN KEY ("source_id") REFERENCES "t_company" ("id");

ALTER TABLE "t_relationship" ADD FOREIGN KEY ("source_id") REFERENCES "t_group" ("id");

ALTER TABLE "t_device" ADD FOREIGN KEY ("person_id") REFERENCES "t_person" ("id");

ALTER TABLE "t_study_guide" ADD FOREIGN KEY ("owner_id") REFERENCES "t_person" ("id");

CREATE UNIQUE INDEX ON "t_document" ("document_id", "document_type");

CREATE UNIQUE INDEX ON "t_relationship" ("target_id", "source_id");

/* PROCEDURES */
CREATE OR REPLACE PROCEDURE create_person(VARCHAR, "gender_t", VARCHAR, INT, TIMESTAMPTZ, INOUT id INT)
LANGUAGE plpgsql    
AS $$
BEGIN
 
    INSERT INTO "public"."t_person" 
      ("name", "gender", "email", "country_id", "birth_date") 
    VALUES 
      ($1, $2, $3, $4, $5) 
	  RETURNING "public"."t_person"."id" INTO id;
 
    COMMIT;
END;
$$;

/* FUNCTIONS */
CREATE OR REPLACE FUNCTION search_person(person_id integer)
RETURNS SETOF "public"."t_person"
AS $$
BEGIN
    RETURN QUERY SELECT 
		"tp"."id", 
		"tp"."name", 
		"tp"."birth_date", 
		"tp"."gender", 
		"tp"."email", 
		"tp"."country_id", 
		"tp"."modified_at", 
		"tp"."created_at" 
	FROM 
		"public"."t_person" "tp"
	WHERE 
		"tp"."id" = person_id;
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_person_by_email(person_email VARCHAR)
RETURNS SETOF "public"."t_person"
AS $$
BEGIN
    RETURN QUERY SELECT 
		"tp"."id", 
		"tp"."name", 
		"tp"."birth_date", 
		"tp"."gender", 
		"tp"."email", 
		"tp"."country_id", 
		"tp"."modified_at", 
		"tp"."created_at" 
	FROM 
		"public"."t_person" "tp"
	WHERE 
		"tp"."email" = person_email;
END;
$$
LANGUAGE plpgsql;