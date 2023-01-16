# Подключение к базе данных {{ PG }}

{% include [link-on-new-ui-datasphere-in-old-ui](../../../_includes/datasphere/datasphere-old-note.md) %}

В инфраструктуре {{ yandex-cloud }} разворачивать и поддерживать кластеры серверов [{{ PG }}](https://www.postgresql.org/) позволяет сервис {{ mpg-short-name }}.

## Перед началом {#before-begin}

1. [Создайте](../../../managed-postgresql/operations/cluster-create.md) новый кластер {{ mpg-short-name }} c публичным доступом для хоста. Вы можете использовать существующий кластер, содержащий хосты в публичном доступе.
1. [Настройте](../../../managed-postgresql/operations/connect.md#configuring-security-groups) группы безопасности кластера.
1. Откройте проект {{ ml-platform-name }}:

    {% list tabs %}

    - Консоль управления

      {% include [before-begin](../../../_includes/datasphere/before-begin.md) %}

    {% endlist %}

## Подключитесь к хосту {#connect-to-host}

Чтобы подключиться к хостам кластера {{ mpg-short-name }}:

1. Получите SSL-сертификат. Для этого введите в ячейке ноутбука команду:

    ```bash
    #!:bash
    mkdir ~/.postgresql
    wget "{{ crt-web-path }}" -O ~/.postgresql/root.crt && \
    chmod 0600 ~/.postgresql/root.crt
    ```

1. Установите подключение с БД. Для этого введите в ячейке ноутбука команду:

    ```python
    %pip install psycopg2-binary
    import psycopg2
    conn = psycopg2.connect("""
        host=<FQDN хоста PostgreSQL>
        port=6432
        sslmode=verify-full
        dbname=<имя БД>
        user=<имя пользователя БД>
        password=<пароль пользователя БД>
        target_session_attrs=read-write
    """)
    q = conn.cursor()
    q.execute('SELECT version()')
    print(q.fetchone())
    ```

    В случае успешного подключения к кластеру и выполнения тестового запроса будет выведена версия {{ PG }}:

    ```
    ('PostgreSQL 13.3 (Ubuntu 13.3-201-yandex.50027.438e1ff1be) on x86_64-pc-linux-gnu, compiled by gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0, 64-bit',)
    ```
