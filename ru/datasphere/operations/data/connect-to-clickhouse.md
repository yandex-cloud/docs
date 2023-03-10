# Подключение к базе данных {{ CH }}

В инфраструктуре {{ yandex-cloud }} разворачивать и поддерживать кластеры серверов [{{ CH }}](https://{{ ch-domain }}/) позволяет сервис {{ mch-short-name }}.

## Перед началом {#before-begin}

1. [Создайте](../../../managed-clickhouse/operations/cluster-create.md) новый кластер {{ mch-short-name }} с публичным доступом для хоста. Вы можете использовать существующий кластер, содержащий хосты в публичном доступе.
1. [Настройте](../../../managed-clickhouse/operations/connect.md#configuring-security-groups) группы безопасности кластера.
1. {% include [before-begin](../../../_includes/datasphere/ui-before-begin.md) %}

## Подключиться к хосту {#connect-to-host}

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
              host='<FQDN_хоста_ClickHouse>',
              db='<имя_БД>',
              query='SELECT version()')
      auth = {
              'X-ClickHouse-User': '<имя_пользователя_БД>',
              'X-ClickHouse-Key': '<пароль_пользователя_БД>',
          }
      cacert = '/home/jupyter/.clickhouse-client/root.crt'
      rs = requests.get(url, headers=auth, verify=cacert)
      rs.raise_for_status()
      print(rs.text)
      ```

      Если подключиться к кластеру удалось, в ответ на тестовый запрос будет выведена версия {{ CH }}:

      ```text
      22.3.17.13
      ```

    - С помощью библиотеки clickhouse-driver

      ```python
      %pip install clickhouse-driver
      from clickhouse_driver import Client
      client = Client(host='<FQDN_хоста_ClickHouse>',
                      user='<имя_пользователя_БД>',
                      password='<пароль_пользователя_БД>',
                      database='<имя_БД>',
                      secure=True)
      client.execute('SELECT version()')
      ```

      Если подключиться к кластеру удалось, в ответ на тестовый запрос будет выведена версия {{ CH }}:

      ```text
      [('22.3.17.13',)]
      ```

    {% endlist %}
