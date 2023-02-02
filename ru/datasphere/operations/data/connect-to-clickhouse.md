# Подключение к базе данных {{ CH }}

В инфраструктуре {{ yandex-cloud }} разворачивать и поддерживать кластеры серверов [{{ CH }}](https://{{ ch-domain }}/) позволяет сервис {{ mch-short-name }}.

## Перед началом {#before-begin}

1. [Создайте](../../../managed-clickhouse/operations/cluster-create.md) новый кластер {{ mch-short-name }} с публичным доступом для хоста. Вы можете использовать существующий кластер, содержащий хосты в публичном доступе.
1. [Настройте](../../../managed-clickhouse/operations/connect.md#configuring-security-groups) группы безопасности кластера.
1. {% include [before-begin](../../../_includes/datasphere/ui-before-begin.md) %}

## Подключитесь к хосту {#connect-to-host}

Чтобы подключиться к хостам кластера {{ mch-short-name }}:

1. Получите SSL-сертификат. Для этого введите в ячейке ноутбука команду:

    ```bash
    #!:bash
    mkdir ~/.clickhouse-client
    wget "{{ crt-web-path }}" -O ~/.clickhouse-client/root.crt && \
    chmod 0600 ~/.clickhouse-client/root.crt
    ```

1. Установите подключение с БД. Для этого введите в ячейке ноутбука команду:

    {% list tabs %}

    - С помощью библиотеки requests

      ```python
      import requests
      url = 'https://{host}:8443/?database={db}&query={query}'.format(
              host='<FQDN хоста ClickHouse>',
              db='<имя БД>',
              query='SELECT version()')
      auth = {
              'X-ClickHouse-User': '<имя пользователя БД>',
              'X-ClickHouse-Key': '<пароль пользователя БД>',
          }
      cacert = '/home/jupyter/.clickhouse-client/root.crt'
      rs = requests.get(url, headers=auth, verify=cacert)
      rs.raise_for_status()
      print(rs.text)
      ```

      В случае успешного подключения к кластеру и выполнения тестового запроса будет выведена версия {{ CH }}:

      ```
      21.3.13.9
      ```
    
    - С помощью библиотеки clickhouse-driver

      ```python
      from clickhouse_driver import Client
      client = Client(host='<FQDN хоста ClickHouse>',
                      user='<имя пользователя БД>',
                      password='<пароль пользователя БД>',
                      database='<имя БД>',
                      secure=True)
      client.execute('SELECT version()')
      ```

      В случае успешного подключения к кластеру и выполнения тестового запроса будет выведена версия {{ CH }}:

      ```
      [('21.3.13.9',)]
      ```

    {% endlist %}
