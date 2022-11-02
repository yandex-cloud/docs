# Connecting to a {{ PG }} database

In the {{ yandex-cloud }} infrastructure, [{{ PG }}](https://www.postgresql.org/) server clusters are deployed and supported using {{ mpg-short-name }}.

## Before you start {#before-begin}

1. [Create](../../../managed-postgresql/operations/cluster-create.md) a new {{ mpg-short-name }} cluster and enable public access to it from the host. You can also use an existing cluster with publicly available hosts.
1. [Configure](../../../managed-postgresql/operations/connect.md#configuring-security-groups) cluster security groups.
1. {% include [before-begin](../../../_includes/datasphere/ui-before-begin.md) %}

## Connecting to a {#connect-to-host} host

To connect to {{ mpg-short-name }} cluster hosts:

1. Get an SSL certificate: To do this, enter the following command in a notebook cell:

   ```bash
   #!:bash
   mkdir ~/.postgresql
   wget "https://{{ s3-storage-host }}{{ pem-path }}" -O ~/.postgresql/root.crt && \
   chmod 0600 ~/.postgresql/root.crt
   ```

1. Establish a connection to the database. To do this, enter the following command in a notebook cell:

   ```python
   %pip install psycopg2-binary
   import psycopg2
   conn = psycopg2.connect("""
       host=<FQDN of PostgreSQL host>
       port=6432
       sslmode=verify-full
       dbname=<DB name>
       user=<DB username>
       password=<DB user password>
       target_session_attrs=read-write
   """)
   q = conn.cursor()
   q.execute('SELECT version()')
   print(q.fetchone())
   ```

   A successful cluster connection and test query will display the {{ PG }} version:

   ```
   ('PostgreSQL 13.3 (Ubuntu 13.3-201-yandex.50027.438e1ff1be) on x86_64-pc-linux-gnu, compiled by gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0, 64-bit',)
   ```
