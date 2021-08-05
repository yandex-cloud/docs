---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---
# Подключение к базе данных {{ CH }}

В инфраструктуре {{ yandex-cloud }} разворачивать и поддерживать кластеры серверов [{{ CH }}](https://clickhouse.tech/) позволяет сервис {{ mch-short-name }}.

Чтобы использовать хост кластера {{ mch-short-name }} в качестве источника данных для {{ ml-platform-name }}:

1. [Создайте](../../../managed-clickhouse/operations/cluster-create.md) новый кластер {{ mch-short-name }} c публичным доступом для хоста. Вы можете использовать существующий кластер, содержащий хосты в публичном доступе.
1. [Настройте](../../../managed-clickhouse/operations/connect.md#configuring-security-groups) группы безопасности кластера.

## Перед началом {#before-begin}

Если проект уже открыт, откройте вкладку с ноутбуком.

Если нет, откройте проект:

1. {% include [include](../../../_includes/datasphere/first-step.md) %}
1. Перейдите во вкладку **Проекты**.
1. Выберите проект, который хотите открыть и нажмите значок ![image](../../../_assets/datalens/horizontal-ellipsis.svg).
1. Выберите **Открыть** и дождитесь открытия проекта.

## Подключитесь к хосту {#connect-to-host}

Чтобы подключиться к хостам кластера {{ mch-short-name }}:

1. Получите SSL-сертификат. Для этого введите в ячейке ноутбука команду:

    ```bash
    #!:bash
    mkdir ~/.clickhouse-client
    wget "https://storage.yandexcloud.net/cloud-certs/CA.pem" -O ~/.clickhouse-client/root.crt && \
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
