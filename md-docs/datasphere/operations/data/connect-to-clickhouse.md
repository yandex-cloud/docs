[Документация Yandex Cloud](../../../index.md) > [Yandex DataSphere](../../index.md) > [Пошаговые инструкции](../index.md) > Подключение к источникам данных > Подключение к базе данных ClickHouse®

# Подключение к базе данных ClickHouse®

В инфраструктуре Yandex Cloud разворачивать и поддерживать кластеры серверов [ClickHouse®](https://clickhouse.com/) позволяет сервис Managed Service for ClickHouse®.

## Перед началом работы {#before-begin}

1. [Создайте](../../../managed-clickhouse/operations/cluster-create.md) новый кластер Managed Service for ClickHouse® с публичным доступом для хоста. Вы можете использовать существующий кластер, содержащий хосты в публичном доступе.
1. [Настройте](../../../managed-clickhouse/operations/connect/index.md#configuring-security-groups) группы безопасности кластера.
1. Откройте проект DataSphere:
   
   1. Выберите нужный проект в своем сообществе или на [главной странице](https://datasphere.yandex.cloud) DataSphere во вкладке **Недавние проекты**.
   1. Нажмите кнопку **Открыть проект в JupyterLab** и дождитесь окончания загрузки.
   1. Откройте вкладку с ноутбуком.

## Подключиться к хосту {#connect-to-host}

Чтобы подключиться к хостам кластера Managed Service for ClickHouse®:

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
              host='<FQDN_хоста_ClickHouse®>',
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

      Если подключиться к кластеру удалось, в ответ на тестовый запрос будет выведена версия ClickHouse®:

      ```text
      22.3.17.13
      ```

    - С помощью библиотеки clickhouse-driver

      ```python
      %pip install clickhouse-driver
      from clickhouse_driver import Client
      client = Client(host='<FQDN_хоста_ClickHouse®>',
                      user='<имя_пользователя_БД>',
                      password='<пароль_пользователя_БД>',
                      database='<имя_БД>',
                      secure=True)
      client.execute('SELECT version()')
      ```

      Если подключиться к кластеру удалось, в ответ на тестовый запрос будет выведена версия ClickHouse®:

      ```text
      [('22.3.17.13',)]
      ```

    {% endlist %}

_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._