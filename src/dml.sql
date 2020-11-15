/* t_country */
INSERT INTO "public"."t_country" ("code", "name") VALUES (1, 'USA');
INSERT INTO "public"."t_country" ("code", "name") VALUES (44, 'UK');
INSERT INTO "public"."t_country" ("code", "name") VALUES (52, 'MEXICO');
INSERT INTO "public"."t_country" ("code", "name") VALUES (55, 'BRAZIL');
INSERT INTO "public"."t_country" ("code", "name") VALUES (91, 'INDIA');

/* t_person */
CALL create_person('308177472', 'RG', 'Carlos Gael Luan da Cruz', 'MALE', 'carlos@email.com', 1, null, 0);
CALL create_person('92445663890', 'CPF', 'André Marcos Castro', 'MALE', 'andre@email.com', 1, null, 0);
CALL create_person('164639123', 'RG', 'Tânia Rosângela Rezende', 'FEMALE', 'tania@email.com', 1, null, 0);
CALL create_person('07415944801', 'CPF', 'Eliane Gabriela Patrícia Silveira', 'ANONYMOUS', 'eliane@email.com', 1, null, 0);