FROM postgres:16

RUN apt update
RUN apt install -y postgresql-server-dev-16 make gcc curl libicu-dev

RUN cd /tmp && \
    curl -L -O https://github.com/pgbigm/pg_bigm/archive/refs/tags/v1.2-20240606.tar.gz && \
    tar zxf v1.2-20240606.tar.gz && \
    cd pg_bigm-1.2-20240606 && \
    make USE_PGXS=1 && \
    make USE_PGXS=1 install && \
    rm -rf /tmp/pg_bigm-1.2-20240606 /tmp/v1.2-20240606.tar.gz

RUN mkdir -p /docker-entrypoint-initdb.d
COPY ./initdb-pg_bigm.sql /docker-entrypoint-initdb.d/10_pg_bigm.sql
# RUN echo shared_preload_libraries='pg_bigm' >> /var/lib/postgresql/data/postgresql.conf
