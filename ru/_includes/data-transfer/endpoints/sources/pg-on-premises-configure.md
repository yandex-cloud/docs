1. Внесите изменения в конфигурацию и настройки аутентификации кластера-источника. Для этого отредактируйте файлы `postgresql.conf`  и `pg_hba.conf` (на дистрибутивах Debian и Ubuntu они по умолчанию расположены в каталоге `/etc/postgresql/<версия_{{ PG }}>/main/`):

    1. Задайте максимальное количество подключений пользователя. Для этого в файле `postgresql.conf` отредактируйте параметр `max_connections`:

        ```ini
        max_connections = <количество_подключений>
        ```
        
        Где `<количество_подключений>` — максимальное число подключений. Подробнее о том, как настроить этот параметр см. в [Особенности работы с эндпоинтами](../../../../data-transfer/concepts/work-with-endpoints.md#postgresql-connection-limit).

        Текущее количество подключений вы можете посмотреть в системной таблице `pg_stat_activity`:

        ```sql
        SELECT count(*) FROM pg_stat_activity;
        ```

    1. Установите уровень логирования для [Write Ahead Log (WAL)](https://www.postgresql.org/docs/current/static/wal-intro.html). Для этого установите значение `logical` для настройки [wal_level](https://www.postgresql.org/docs/current/runtime-config-wal.html#RUNTIME-CONFIG-WAL-SETTINGS) в `postgresql.conf`:

        ```ini
        wal_level = logical
        ```

    1. (Опционально) Настройте SSL: это поможет не только шифровать данные, но и сжимать их. Чтобы включить использование SSL, задайте нужное значение в файле `postgresql.conf`:

        ```ini
        ssl = on
        ```
    
    1. Разрешите подключение к кластеру. Для этого отредактируйте [параметр](https://www.postgresql.org/docs/current/runtime-config-connection.html#GUC-LISTEN-ADDRESSES) `listen_addresses` в файле `postgresql.conf`. Например, чтобы кластер-источник принимал запросы на подключение со всех IP-адресов:

        ```ini
        listen_addresses = '*'
        ```

    1. Настройте аутентификацию в файле `pg_hba.conf`:

        {% list tabs %}

        - SSL

            ```txt
            hostssl         all            all             <IP-адрес_подключения>      md5
            hostssl         replication    all             <IP-адрес_подключения>      md5
            ```

        - Без SSL

            ```txt
            host         all            all             <IP-адрес_подключения>      md5
            host         replication    all             <IP-адрес_подключения>      md5
            ```

        {% endlist %}

        Где `<IP-адрес_подключения>` может быть как точным IP-адресом, так и диапазоном IP-адресов. Например, чтобы разрешить доступ из сети {{ yandex-cloud }}, вы можете указать [все публичные IP-адреса](../../../../overview/concepts/public-ips.md) {{ yandex-cloud }}.
1. Если в кластере-источнике работает файрвол, разрешите входящие соединения с нужных адресов.

1. Чтобы применить настройки, перезапустите сервис {{ PG }}:

   ```bash
   sudo systemctl restart postgresql
   ```

1. Проверьте статус сервиса {{ PG }} после перезапуска:

   ```bash
   sudo systemctl status postgresql
   ```