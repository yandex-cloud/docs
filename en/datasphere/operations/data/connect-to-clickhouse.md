# Connecting to a {{ CH }} database

In the {{ yandex-cloud }} infrastructure, [{{ CH }}](https://{{ ch-domain }}/) server clusters are deployed and supported using {{ mch-short-name }}.

## Getting started {#before-begin}

1. [Create](../../../managed-clickhouse/operations/cluster-create.md) a new {{ mch-short-name }} cluster and enable public access to it from the host. You can also use an existing cluster with publicly available hosts.
1. [Configure](../../../managed-clickhouse/operations/connect.md#configuring-security-groups) cluster security groups.
1. {% include [before-begin](../../../_includes/datasphere/ui-before-begin.md) %}

## Connecting to a host {#connect-to-host}

To connect to {{ mch-short-name }} cluster hosts:

1. Get an SSL certificate. To do this, enter the following command in a notebook cell:

   ```bash
   #!:bash
   mkdir ~/.clickhouse-client
   wget "{{ crt-web-path }}" -O ~/.clickhouse-client/root.crt && \
   chmod 0600 ~/.clickhouse-client/root.crt
   ```

1. Establish a connection to the database. To do this, enter the following command in a notebook cell:

   {% list tabs %}

   - Using the requests library

      ```python
      import requests
      url = 'https://{host}:8443/?database={db}&query={query}'.format(
              host='<ClickHouse_host_FQDN>',
              db='<database_name>',
              query='SELECT version()')
      auth = {
              'X-ClickHouse-User': '<DB_user_name>',
              'X-ClickHouse-Key': '<DB_user_password>',
          }
      cacert = '/home/jupyter/.clickhouse-client/root.crt'
      rs = requests.get(url, headers=auth, verify=cacert)
      rs.raise_for_status()
      print(rs.text)
      ```

      If the connection to the cluster is successful, the {{ CH }} version will be output in response to the test query:

      ```text
      22.3.17.13
      ```

   - Using the clickhouse-driver library

      ```python
      %pip install clickhouse-driver
      from clickhouse_driver import Client
      client = Client(host='<ClickHouse_host_FQDN>',
                      user='<DB_user_name>',
                      password='<DB_user_password>',
                      database='<DB_name>',
                      secure=True)
      client.execute('SELECT version()')
      ```

      If the connection to the cluster is successful, the {{ CH }} version will be output in response to the test query:

      ```text
      [('22.3.17.13',)]
      ```

   {% endlist %}
