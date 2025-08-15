# Connecting to a {{ CH }} database

{{ mch-short-name }} enables deploying and maintaining [{{ CH }}](https://{{ ch-domain }}/) server clusters in the {{ yandex-cloud }} infrastructure.

## Getting started {#before-begin}

1. [Create](../../../managed-clickhouse/operations/cluster-create.md) a new {{ mch-short-name }} cluster with public host access. You can also use an existing cluster with publicly accessible hosts.
1. [Configure](../../../managed-clickhouse/operations/connect/index.md#configuring-security-groups) cluster security groups.
1. {% include [before-begin](../../../_includes/datasphere/ui-before-begin.md) %}

## Connecting to a host {#connect-to-host}

To connect to {{ mch-short-name }} cluster hosts:

1. Get an SSL certificate. To do this, enter this command in a notebook cell:

    ```bash
    #!:bash
    mkdir ~/.clickhouse-client
    wget "{{ crt-web-path }}" -O ~/.clickhouse-client/root.crt && \
    chmod 0600 ~/.clickhouse-client/root.crt
    ```

1. Establish a database connection. To do this, enter this command in a notebook cell:

    {% list tabs %}

    - Using the `requests` library:

      ```python
      import requests
      url = 'https://{host}:8443/?database={db}&query={query}'.format(
              host='<{{ CH }}_host_FQDN>',
              db='<DB_name>',
              query='SELECT version()')
      auth = {
              'X-ClickHouse-User': '<DB_username>',
              'X-ClickHouse-Key': '<DB_user_password>',
          }
      cacert = '/home/jupyter/.clickhouse-client/root.crt'
      rs = requests.get(url, headers=auth, verify=cacert)
      rs.raise_for_status()
      print(rs.text)
      ```

      If you succeed connecting to the cluster, you will get the {{ CH }} version in response to your test request:

      ```text
      22.3.17.13
      ```

    - Using the `clickhouse-driver` library:

      ```python
      %pip install clickhouse-driver
      from clickhouse_driver import Client
      client = Client(host='<{{ CH }}_host_FQDN>',
                      user='<DB_username>',
                      password='<DB_user_password>',
                      database='<DB_name>',
                      secure=True)
      client.execute('SELECT version()')
      ```

      If you succeed connecting to the cluster, you will get the {{ CH }} version in response to your test request:

      ```text
      [('22.3.17.13',)]
      ```

    {% endlist %}

{% include [clickhouse-disclaimer](../../../_includes/clickhouse-disclaimer.md) %}
