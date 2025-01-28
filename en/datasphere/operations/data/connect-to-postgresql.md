# Connecting to a {{ PG }} database

{{ mpg-short-name }} enables deploying and maintaining [{{ PG }}](https://www.postgresql.org/) server clusters in the {{ yandex-cloud }} infrastructure.

## Getting started {#before-begin}

1. [Create](../../../managed-postgresql/operations/cluster-create.md) a new {{ mpg-short-name }} cluster with public access to the host. You can also use an existing cluster with publicly accessible hosts.
1. [Configure](../../../managed-postgresql/operations/connect.md#configuring-security-groups) cluster security groups.
1. {% include [before-begin](../../../_includes/datasphere/ui-before-begin.md) %}

## Connecting to a host {#connect-to-host}

{% list tabs group=connection %}

- Connecting via SSL {#with-ssl}

  To connect to {{ mpg-short-name }} cluster hosts:

  1. Get an SSL certificate. To do this, enter this command in a notebook cell:

      ```bash
      #!:bash
      mkdir ~/.postgresql
      wget "{{ crt-web-path }}" -O ~/.postgresql/root.crt && \
      chmod 0600 ~/.postgresql/root.crt
      ```

  1. Establish a database connection. To do this, enter this command in a notebook cell:

      ```python
      %pip install psycopg2-binary
      import psycopg2
      conn = psycopg2.connect("""
          host=<PostgreSQL_host_FQDN>
          port=6432
          sslmode=verify-full
          dbname=<DB_name>
          user=<DB_username>
          password=<DB_user_password>
          target_session_attrs=read-write
      """)
      q = conn.cursor()
      q.execute('SELECT version()')
      print(q.fetchone())
      ```

      If you succeed connecting to the cluster, you will get the {{ PG }} version in response to your test query:

      ```text
      ('PostgreSQL 14.6 (Ubuntu 14.6-201-yandex.52665.7e82983c2c) on x86_64-pc-linux-gnu, compiled by gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0, 64-bit',)
      ```

- Connecting without SSL {#without-ssl}

  Connecting without an SSL certificate is only supported for non-public hosts. If this is the case, internal cloud network traffic will not be encrypted when connecting to a database.

  1. [Configure your project](../../operations/projects/update.md). To do this, add or modify the following fields on the project edit page as appropriate:

     * **{{ ui-key.yc-ui-datasphere.project-page.settings.default-folder }}** hosting the deployed {{ mpg-short-name }} cluster.
     * **{{ ui-key.yc-ui-datasphere.project-page.settings.service-account }}** with the `managed-postgresql.editor` [role](../../../managed-postgresql/security/index.md#required-roles) or higher.
     * **{{ ui-key.yc-ui-datasphere.project-page.settings.subnet }}** the database host belongs to.

       {% note info %}

       To enable internet access, [specify a subnet with a NAT gateway](../../../vpc/operations/create-nat-gateway.md).

       {% endnote %}

  1. Establish a database connection. To do this, enter this command in a notebook cell:

      ```python
      %pip install psycopg2-binary
      import psycopg2

      conn = psycopg2.connect("""
          host=rc1a-<PostgreSQL_cluster_ID>.{{ dns-zone }}
          port=6432
          sslmode=disable
          dbname=<DB_name>
          user=<DB_username>
          password=<DB_user_password>
          target_session_attrs=read-write
      """)

      q = conn.cursor()
      q.execute('SELECT version()')

      print(q.fetchone())

      conn.close()
      ```

      If you succeed connecting to the cluster, you will get the {{ PG }} version in response to your test query:

      ```text
      ('PostgreSQL 14.6 (Ubuntu 14.6-201-yandex.52665.7e82983c2c) on x86_64-pc-linux-gnu, compiled by gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0, 64-bit',)
      ```

{% endlist %}
