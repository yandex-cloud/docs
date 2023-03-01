# Подключение к базе данных {{ PG }}

В инфраструктуре {{ yandex-cloud }} разворачивать и поддерживать кластеры серверов [{{ PG }}](https://www.postgresql.org/) позволяет сервис {{ mpg-short-name }}.

## Перед началом {#before-begin}

1. [Создайте](../../../managed-postgresql/operations/cluster-create.md) новый кластер {{ mpg-short-name }} с публичным доступом для хоста. Вы можете использовать существующий кластер, содержащий хосты в публичном доступе.
1. [Настройте](../../../managed-postgresql/operations/connect.md#configuring-security-groups) группы безопасности кластера.
1. {% include [before-begin](../../../_includes/datasphere/ui-before-begin.md) %}

## Подключиться к хосту {#connect-to-host}

{% list tabs %}

- Подключение с SSL

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
          host=<FQDN_хоста_PostgreSQL>
          port=6432
          sslmode=verify-full
          dbname=<имя_БД>
          user=<имя_пользователя_БД>
          password=<пароль_пользователя_БД>
          target_session_attrs=read-write
      """)
      q = conn.cursor()
      q.execute('SELECT version()')
      print(q.fetchone())
      ```

      Если подключиться к кластеру удалось, в ответ на тестовый запрос будет выведена версия {{ PG }}:

      ```text
      ('PostgreSQL 14.6 (Ubuntu 14.6-201-yandex.52665.7e82983c2c) on x86_64-pc-linux-gnu, compiled by gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0, 64-bit',)
      ```
      
- Подключение без SSL

  Подключение без использования SSL-сертификата поддерживается только для хостов, находящихся не в публичном доступе. В этом случае трафик внутри облачной сети при подключении к БД шифроваться не будет.

  1. [Настройте проект](../../operations/projects/update.md). Для этого на странице редактирования проекта в соответствующих полях добавьте или измените:

     * **Каталог по умолчанию**, в котором развернут кластер {{ mpg-short-name }}.
     * **Сервисный аккаунт** с [ролью](../../../managed-postgresql/security/index.md#required-roles) `managed-postgresql.editor` или выше.
     * **Подсеть**, в которой расположен хост БД.

       {% note info %}

       Чтобы иметь доступ в интернет, [указывайте подсеть с NAT-шлюзом](../../../vpc/operations/create-nat-gateway.md).

       {% endnote %}

  1. Установите подключение с БД. Для этого введите в ячейке ноутбука команду:

      ```python
      %pip install psycopg2-binary
      import psycopg2

      conn = psycopg2.connect("""
          host=rc1a-<идентификатор_кластера_PostgreSQL>.mdb.yandexcloud.net
          port=6432
          sslmode=disable
          dbname=<имя_БД>
          user=<имя_пользователя_БД>
          password=<пароль_пользователя_БД>
          target_session_attrs=read-write
      """)

      q = conn.cursor()
      q.execute('SELECT version()')

      print(q.fetchone())

      conn.close()
      ```

      Если подключиться к кластеру удалось, в ответ на тестовый запрос будет выведена версия {{ PG }}:

      ```text
      ('PostgreSQL 14.6 (Ubuntu 14.6-201-yandex.52665.7e82983c2c) on x86_64-pc-linux-gnu, compiled by gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0, 64-bit',)
      ```

{% endlist %}
