# Connecting to a {{ PG }} database

{% include [link-on-new-ui-datasphere-in-old-ui](../../../_includes/datasphere/datasphere-old-note.md) %}

In the {{ yandex-cloud }} infrastructure, [{{ PG }}](https://www.postgresql.org/) server clusters are deployed and supported using {{ mpg-short-name }}.

To utilize a {{ mpg-short-name }} cluster host as a data source for {{ ml-platform-name }}:

1. [Create](../../../managed-postgresql/operations/cluster-create.md) a new {{ mpg-short-name }} cluster and enable public access to it from the host. You can also use an existing cluster with publicly available hosts.
1. [Configure](../../../managed-postgresql/operations/connect.md#configuring-security-groups) cluster security groups.

## Before you start {#before-begin}

If a project is already open, open the tab with a notebook.

If not, open the project:

1. {% include [include](../../../_includes/datasphere/first-step.md) %}
1. Go to the **Projects** tab.
1. Select the project you want to open and click ![image](../../../_assets/datalens/horizontal-ellipsis.svg).
1. Choose **Open** and wait for the project to open.

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
