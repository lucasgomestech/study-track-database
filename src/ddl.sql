/* ENUMS */
CREATE TYPE "gender_t" AS ENUM (
  'FEMALE',
  'MALE',
  'OTHER',
  'ANONYMOUS'
);

CREATE TYPE "person_national_id_t" AS ENUM (
  'RG',
  'CPF'
);

CREATE TYPE "company_national_id_t" AS ENUM (
  'CNPJ'
);

CREATE TYPE "device_t" AS ENUM (
  'MOBILE',
  'TABLET'
);

/* TABLES */
CREATE TABLE "t_person" (
  "id" int PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  "national_id" varchar,
  "national_id_type" "person_national_id_t",
  "name" varchar NOT NULL,
  "birth_date" date,
  "gender" "gender_t" NOT NULL,
  "email" varchar UNIQUE NOT NULL,
  "country_id" int,
  "modified_at" timestamptz DEFAULT (now()),
  "created_at" timestamptz DEFAULT (now())
);

CREATE TABLE "t_company" (
  "id" int PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  "national_id" varchar,
  "national_id_type" "company_national_id_t",
  "country_id" int,
  "primary_contact" int,
  "name" varchar NOT NULL,
  "email" varchar UNIQUE NOT NULL,
  "modified_at" timestamptz DEFAULT (now()),
  "created_at" timestamptz DEFAULT (now())
);

CREATE TABLE "t_country" (
  "id" int PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  "code" int UNIQUE,
  "name" varchar NOT NULL
);

CREATE TABLE "t_student" (
  "id" int PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  "person_id" int,
  "company_id" int,
  "student_code" varchar NOT NULL,
  "modified_at" timestamptz DEFAULT (now()),
  "created_at" timestamptz DEFAULT (now())
);

CREATE TABLE "t_company_employee" (
  "id" int PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  "person_id" int,
  "company_id" int,
  "employee_code" varchar NOT NULL,
  "modified_at" timestamptz DEFAULT (now()),
  "created_at" timestamptz DEFAULT (now())
);

CREATE TABLE "t_device" (
  "id" int PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  "person_id" int,
  "number" int,
  "imei" int UNIQUE,
  "os" varchar,
  "device_type" device_t NOT NULL,
  "modified_at" timestamptz DEFAULT (now()),
  "created_at" timestamptz DEFAULT (now())
);

/* CONSTRAINTS */
ALTER TABLE "t_person" ADD FOREIGN KEY ("country_id") REFERENCES "t_country" ("id");

ALTER TABLE "t_company" ADD FOREIGN KEY ("country_id") REFERENCES "t_country" ("id");

ALTER TABLE "t_company" ADD FOREIGN KEY ("primary_contact") REFERENCES "t_company_employee" ("id");

ALTER TABLE "t_student" ADD FOREIGN KEY ("person_id") REFERENCES "t_person" ("id");

ALTER TABLE "t_student" ADD FOREIGN KEY ("company_id") REFERENCES "t_company" ("id");

ALTER TABLE "t_company_employee" ADD FOREIGN KEY ("person_id") REFERENCES "t_person" ("id");

ALTER TABLE "t_company_employee" ADD FOREIGN KEY ("company_id") REFERENCES "t_company" ("id");

ALTER TABLE "t_device" ADD FOREIGN KEY ("person_id") REFERENCES "t_person" ("id");

CREATE UNIQUE INDEX  
ON "t_person" ("national_id","national_id_type");

CREATE UNIQUE INDEX  
ON "t_company" ("national_id","national_id_type");

CREATE UNIQUE INDEX  
ON "t_student" ("person_id","company_id","student_code");

CREATE UNIQUE INDEX  
ON "t_company_employee" ("person_id","company_id","employee_code");

/* PROCEDURES */
CREATE OR REPLACE PROCEDURE create_person(VARCHAR, "person_national_id_t", VARCHAR, "gender_t", VARCHAR, INT, TIMESTAMPTZ, INOUT id INT)
LANGUAGE plpgsql    
AS $$
BEGIN
 
    INSERT INTO "public"."t_person" 
      ("national_id", "national_id_type", "name", "gender", "email", "country_id", "birth_date") 
    VALUES 
      ($1, $2, $3, $4, $5, $6, $7) 
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
		"tp"."national_id", 
		"tp"."national_id_type", 
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

CREATE OR REPLACE FUNCTION search_person_by_national_id(person_national_id VARCHAR)
RETURNS SETOF "public"."t_person"
AS $$
BEGIN
    RETURN QUERY SELECT 
		"tp"."id", 
		"tp"."national_id", 
		"tp"."national_id_type", 
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
		"tp"."national_id" = person_national_id;
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_person_by_email(person_email VARCHAR)
RETURNS SETOF "public"."t_person"
AS $$
BEGIN
    RETURN QUERY SELECT 
		"tp"."id", 
		"tp"."national_id", 
		"tp"."national_id_type", 
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