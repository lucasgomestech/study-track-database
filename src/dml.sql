/* t_country */
INSERT INTO "public"."t_country" ("code", "name") VALUES (1, 'USA');
INSERT INTO "public"."t_country" ("code", "name") VALUES (44, 'UK');
INSERT INTO "public"."t_country" ("code", "name") VALUES (52, 'MEXICO');
INSERT INTO "public"."t_country" ("code", "name") VALUES (55, 'BRAZIL');
INSERT INTO "public"."t_country" ("code", "name") VALUES (91, 'INDIA');

/* t_person */
CALL create_person('Carlos Gael Luan da Cruz', 'MALE', 'carlos@email.com', 1, null, 0);
CALL create_person('André Marcos Castro', 'MALE', 'andre@email.com', 1, null, 0);
CALL create_person('Tânia Rosângela Rezende', 'FEMALE', 'tania@email.com', 1, null, 0);
CALL create_person('Eliane Gabriela Patrícia Silveira', 'ANONYMOUS', 'eliane@email.com', 1, null, 0);