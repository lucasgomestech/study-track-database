FROM library/postgres:12.1

ENV POSTGRES_USER system
ENV POSTGRES_PASSWORD postgres
ENV POSTGRES_DB db_study_track

COPY src/ddl.sql /docker-entrypoint-initdb.d/
COPY src/dml.sql /docker-entrypoint-initdb.d/
