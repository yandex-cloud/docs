# Миграция базы данных из стороннего кластера {{ PG }} в {{ mpg-name }}

Перенести данные из стороннего _кластера-источника_ в _кластер-приемник_ {{ mpg-name }} можно тремя способами:

* [Перенос данных с использованием сервиса {{ data-transfer-full-name }}](#data-transfer).

    Этот способ позволяет:

    * обойтись без создания промежуточной виртуальной машины или разрешения доступа к вашему кластеру-приемнику {{ mpg-name }} из интернета;
    * перенести базу целиком без остановки обслуживания пользователей;
    * мигрировать со старых версий {{ PG }} на более новые, в том числе обновить кластер с версии {{ PG }} 15 до версии 16.

    Чтобы использовать этот способ, разрешите подключение к кластеру-источнику из интернета.

    Подробнее см. в разделе [{#T}](../../data-transfer/concepts/use-cases.md).

* [Перенос данных с помощью логической репликации](#logical-replication).

    [_Логическая репликация_](https://www.postgresql.org/docs/current/logical-replication.html) использует механизм [подписки (subscriptions)](https://www.postgresql.org/docs/current/sql-createsubscription.html). Это позволяет перенести данные в кластер-приемник с минимальным временем простоя.

    Используйте этот способ только в том случае, если перенос данных с помощью {{ data-transfer-full-name }} по каким-либо причинам невозможен.

* [Перенос данных через создание и восстановление логического дампа](#backup).

    _Логический дамп_ — файл с набором команд, последовательное выполнение которых позволяет восстановить состояние базы данных. Он создается с помощью утилиты `pg_dump`. Чтобы обеспечить полноту логического дампа, перед его созданием кластер-источник следует перевести в режим <q>только чтение</q>.

    Используйте этот способ только в том случае, если перенос данных с помощью любого из предыдущих способов по каким-либо причинам невозможен.

## Перенос данных с использованием сервиса {{ data-transfer-full-name }} {#data-transfer}

{% include notitle [PostgreSQL migration with Data Transfer](../../_tutorials/dataplatform/datatransfer/managed-postgresql.md) %}

## Перенос данных с помощью логической репликации {#logical-replication}

Логическая репликация поддерживается {{ PG }} с версии 10. Кроме миграции данных между одинаковыми версиями {{ PG }}, логическая репликация позволяет мигрировать на более новые версии {{ PG }}.

В кластерах {{ mpg-name }} подписки может использовать владелец базы данных (пользователь, созданный одновременно с кластером) и пользователи с ролью `mdb_admin` для этого кластера.

Этапы миграции:

1. [Настройте кластер-источник](#source-setup).
1. [Экспортируйте схему БД в кластере-источнике](#source-schema-export).
1. [Восстановите схему БД в кластере-приемнике](#restore-schema).
1. [Создайте публикацию и подписку {{ PG }}](#create-publication-subscription).
1. [Перенесите {{ PG }}-sequence после репликации](#transfer-sequences).
1. [Отключите репликацию и перенесите нагрузку](#transfer-load).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out-logical).

### Перед началом работы {#before-you-begin-logical}

Создайте необходимые ресурсы:

{% list tabs group=instructions %}

- Вручную {#manual}

    [Создайте кластер-приемник {{ mpg-name }}](../../managed-postgresql/operations/cluster-create.md) любой подходящей конфигурации. При этом:

    * Версия {{ PG }} должна быть не ниже, чем в кластере-источнике. Миграция с понижением версии {{ PG }} невозможна.
    * При создании кластера укажите то же имя базы данных, что и в кластере-источнике.
    * Включите те же [расширения {{ PG }}](../../managed-postgresql/operations/extensions/cluster-extensions.md), что и в кластере-источнике.

- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. Скачайте в ту же рабочую директорию файл конфигурации [data-migration-pgsql-mpg.tf](https://github.com/yandex-cloud-examples/yc-postgresql-data-migration-from-on-premise/blob/main/data-migration-pgsql-mpg.tf).

        В этом файле описаны:

        * [сеть](../../vpc/concepts/network.md#network);
        * [подсеть](../../vpc/concepts/network.md#subnet);
        * [группа безопасности](../../vpc/concepts/security-groups.md) и правило, необходимое для подключения к кластеру;
        * кластер {{ mpg-name }} с публичным доступом из интернета.

    1. Укажите в файле `data-migration-pgsql-mpg.tf`:

        * `source_db_name` — имя базы данных;
        * `pg-extensions` – список [расширений {{ PG }}](../../managed-postgresql/operations/extensions/cluster-extensions.md) в кластере-источнике;
        * параметры кластера-приемника:

            * `target_pgsql_version` — версия {{ PG }}, она должна быть не ниже, чем в кластере-источнике;
            * `target_user` и `target_password` — имя и пароль пользователя-владельца базы данных.

    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Создайте необходимую инфраструктуру:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

### Настройте кластер-источник {#source-setup}

1. Укажите нужные настройки SSL и WAL в файле `postgresql.conf`. В ОС Debian и Ubuntu путь к этому файлу по умолчанию — `/etc/postgresql/<версия_{{ PG }}>/main/postgresql.conf`.
   1. Для миграции данных рекомендуется использовать SSL: это поможет не только шифровать данные, но и сжимать их. Подробнее в разделах документации {{ PG }}, [SSL Support](https://www.postgresql.org/docs/current/libpq-ssl.html) и [Database Connection Control Functions](https://www.postgresql.org/docs/current/libpq-connect.html).

      Чтобы включить использование SSL, задайте нужное значение в конфигурации:

      ```ini
      ssl = on                   # on, off
      ```

   1. Измените уровень логирования для [Write Ahead Log (WAL)](https://www.postgresql.org/docs/current/static/wal-intro.html), чтобы добавить в него информацию, необходимую для логической репликации. Для этого установите значение `logical` для настройки [wal_level](https://www.postgresql.org/docs/current/runtime-config-wal.html#RUNTIME-CONFIG-WAL-SETTINGS).

      Настройку можно изменить в файле `postgresql.conf`. Найдите строку с настройкой `wal_level`, раскомментируйте ее при необходимости и установите значение `logical`:

      ```ini
      wal_level = logical                    # minimal, replica, or logical
      ```

1. Настройте аутентификацию хостов в кластере-источнике. Для этого нужно внести хосты кластера в {{ yandex-cloud }} в файл `pg_hba.conf` (на дистрибутивах Debian и Ubuntu по умолчанию расположен по пути `/etc/postgresql/<версия_{{ PG }}>/main/pg_hba.conf`).

    Добавьте строки для разрешения подключения к базе данных с указанных хостов:

    * Если вы используете SSL:

        ```txt
        hostssl         all            all             <адрес_хоста>      md5
        hostssl         replication    all             <адрес_хоста>      md5
        ```

    * Если вы не используете SSL:

        ```txt
        host         all            all             <адрес_хоста>      md5
        host         replication    all             <адрес_хоста>      md5
        ```

1. Если в кластере-источнике работает файрвол, разрешите входящие соединения с хостов кластера {{ mpg-name }}. Например, для Ubuntu 18:

   ```bash
   sudo ufw allow from <адрес_хоста_кластера-приемника> to any port <порт>
   ```

1. Перезапустите сервис {{ PG }}, чтобы применить все сделанные настройки:

   ```bash
   sudo systemctl restart postgresql
   ```

1. Проверьте статус сервиса {{ PG }} после перезапуска:

   ```bash
   sudo systemctl status postgresql
   ```

### Экспортируйте схему БД в кластере-источнике {#source-schema-export}

С помощью утилиты `pg_dump` создайте файл со схемой БД, которую нужно будет применить в кластере-приемнике.

```bash
pg_dump -h <IP-адрес_или_FQDN_хоста-мастера_кластера-источника> \
        -U <имя_пользователя> \
        -p <порт> \
        --schema-only \
        --no-privileges \
        --no-subscriptions \
        -d <имя_БД> \
        -Fd -f /tmp/db_dump
```

В этой команде при экспорте исключаются все данные, связанные с привилегиями и ролями, чтобы не возникало конфликтов с настройками БД в {{ yandex-cloud }}. Если вашей БД нужны дополнительные пользователи, [создайте их](../../managed-postgresql/operations/cluster-users.md#adduser).

### Восстановите схему БД в кластере-приемнике {#restore-schema}

С помощью утилиты `pg_restore` восстановите схему БД в кластере-приемнике:

```bash
pg_restore -h <IP-адрес_или_FQDN_хоста-мастера_кластера-приемника> \
           -U <имя_пользователя> \
           -p {{ port-mpg }} \
           -Fd -v \
           --single-transaction \
           -s --no-privileges \
           -d <имя_БД> /tmp/db_dump
```

### Создайте публикацию и подписку {#create-publication-subscription}

Для работы логической репликации необходимо создать публикацию (группу логически реплицируемых таблиц) в кластере-источнике и подписку (описание соединения с другой базой) в кластере-приемнике.

1. В кластере-источнике создайте публикацию для всех таблиц базы данных. При переносе нескольких баз для каждой из них нужно создать отдельную публикацию.

   {% note info %}

   Для создания публикации на все таблицы потребуются права суперпользователя, а для переноса выбранных таблиц — нет. Более подробно о создании публикации см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/sql-createpublication.html).

   {% endnote %}

   Запрос:

   ```sql
   CREATE PUBLICATION p_data_migration FOR ALL TABLES;
   ```

1. На хосте кластера {{ mpg-name }} создайте подписку со строкой подключения к публикации. Более подробно о создании подписок см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/sql-createsubscription.html).

   Запрос с включенным SSL:

   ```sql
   CREATE SUBSCRIPTION s_data_migration CONNECTION 'host=<адрес_кластера-источника> port=<порт> user=<имя_пользователя> sslmode=verify-full dbname=<имя_БД>' PUBLICATION p_data_migration;
   ```

   Без SSL:

   ```sql
   CREATE SUBSCRIPTION s_data_migration CONNECTION 'host=<адрес_кластера-источника> port=<порт> user=<имя_пользователя> sslmode=disable dbname=<имя_БД>' PUBLICATION p_data_migration;
   ```

1. Чтобы получить статус репликации, обратитесь к каталогам `pg_subscription_rel`. Общий статус репликации в кластере-приемнике можно получить через `pg_stat_subscription`, в кластере-источнике — через `pg_stat_replication`.

   ```sql
   SELECT * FROM pg_subscription_rel;
   ```

   Прежде всего обратите внимание на поле `srsubstate`. Значение `r` в нем означает, что синхронизация завершилась, и базы готовы к репликации.

### Перенесите {{ PG }}-sequences после репликации {#transfer-sequences}

Чтобы завершить синхронизацию кластера-источника и кластера-приемника:

1. Переведите кластер-источник в режим <q>только чтение</q>.
1. Создайте дамп с {{ PG }}-sequences в кластере-источнике:

   ```bash
   pg_dump -h <IP-адрес_или_FQDN_хоста-мастера_кластера-источника> \
           -U <имя_пользователя> \
           -p <порт> \
           -d <имя_БД> \
           --data-only -t '*.*_seq' > /tmp/seq-data.sql
   ```

   Обратите внимание на используемый паттерн `*.*_seq`. Если в переносимой базе есть не соответствующие ему sequences, то для их выгрузки укажите другой паттерн.

   Подробнее о паттернах см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/app-psql.html#APP-PSQL-PATTERNS).

1. Восстановите дамп с sequences в кластере-приемнике:

   ```bash
   psql -h <IP-адрес_или_FQDN_хоста-мастера_кластера-приемника> \
        -U <имя_пользователя> \
        -p {{ port-mpg }} \
        -d <имя_БД> \
        < /tmp/seq-data.sql
   ```

### Удалите подписку и перенесите нагрузку {#transfer-load}

1. Удалите подписку в кластере-приемнике:

    ```sql
    DROP SUBSCRIPTION s_data_migration;
   ```

1. Перенесите нагрузку на кластер-приемник.

### Удалите созданные ресурсы {#clear-out-logical}

Удалите ресурсы, которые вы больше не будете использовать, чтобы за них не списывалась плата:

{% list tabs group=instructions %}

- Вручную {#manual}

    [Удалите кластер {{ mpg-name }}](../../managed-postgresql/operations/cluster-delete.md).

- {{ TF }} {#tf}

    1. В терминале перейдите в директорию с планом инфраструктуры.
    1. Удалите конфигурационный файл `data-migration-pgsql-mpg.tf`.
    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        Все ресурсы, которые были описаны в конфигурационном файле `data-migration-pgsql-mpg.tf`, будут удалены.

{% endlist %}

## Перенос данных через создание и восстановление логического дампа {#backup}

Создайте дамп нужной базы в кластере-источнике с помощью утилиты `pg_dump`. Для восстановления дампа в кластере-приемнике используйте утилиту `pg_restore`.

{% note info %}

Для использования утилиты `pg_restore` может понадобиться расширение базы данных `pg_repack`.

{% endnote %}

Этапы миграции:

1. [Создайте дамп переносимой базы](#dump).
1. [(Опционально) Создайте виртуальную машину в {{ yandex-cloud }} и загрузите дамп БД на нее](#create-vm).
1. [Восстановите данные из дампа в кластер-приемник](#restore).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out-backup).

### Перед началом работы {#before-you-begin-backup}

Создайте необходимые ресурсы:

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Создайте кластер-приемник {{ mpg-name }}](../../managed-postgresql/operations/cluster-create.md) любой подходящей конфигурации. При этом следующие параметры должны быть такими же, как и в кластере-источнике:

        * Версия {{ PG }}.
        * Имя пользователя.

            {% include [user-name-restore](../../_includes/mdb/mpg/note-user-name-restore.md) %}

        * [Расширения {{ PG }}](../../managed-postgresql/operations/extensions/cluster-extensions.md).

    1. (Опционально) [Создайте виртуальную машину](../../compute/operations/vm-create/create-linux-vm.md) на базе [Ubuntu 20.04 LTS](/marketplace/products/yc/ubuntu-20-04-lts) со следующими параметрами:

        * **{{ ui-key.yacloud.compute.instances.create.section_storages_ru }}** → **{{ ui-key.yacloud.compute.disk-form.field_size }}** — достаточный для хранения распакованного и нераспакованного дампов.

            Рекомендуется использовать объем в два или более раз превышающий суммарный объем дампа и архива с ним.

        * **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

            * **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** — выберите подсеть в той же облачной сети, в которой размещен кластер-приемник.
            * **{{ ui-key.yacloud.component.compute.network-select.field_external }}** — выберите `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}` или один адрес из списка зарезервированных IP-адресов.


    1. Если вы используете группы безопасности для промежуточной виртуальной машины и кластера {{ mpg-name }}, [настройте их](../../managed-postgresql/operations/connect.md#configure-security-groups).


- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. Скачайте в ту же рабочую директорию файл конфигурации [data-restore-pgsql-mpg.tf](https://github.com/yandex-cloud-examples/yc-postgresql-data-migration-from-on-premise/blob/main/data-restore-pgsql-mpg.tf).

        В этом файле описаны:

        * [сеть](../../vpc/concepts/network.md#network);
        * [подсеть](../../vpc/concepts/network.md#subnet);
        * [группа безопасности](../../vpc/concepts/security-groups.md) и правило, необходимое для подключения к кластеру;
        * кластер {{ mpg-name }} с публичным доступом из интернета;
        * (опционально) виртуальная машина с публичным доступом из интернета.

    1. Укажите в файле `data-restore-pgsql-mpg.tf`:

        * `pg-extensions` – список [расширений {{ PG }}](../../managed-postgresql/operations/extensions/cluster-extensions.md) в кластере-источнике;
        * параметры кластера-приемника:

            * `target_pgsql_version` — версия {{ PG }}, она должна быть не ниже чем в кластере-источнике;
            * `target_db_name` — имя базы данных;
            * `target_user` — имя пользователя-владельца базы данных. Должно совпадать с именем пользователя в кластере-источнике;

                {% include [user-name-restore](../../_includes/mdb/mpg/note-user-name-restore.md) %}

            * `target_password` — пароль пользователя-владельца базы данных;
        * (опционально) параметры виртуальной машины:

            * `vm_image_id` — идентификатор публичного [образа](../../compute/operations/images-with-pre-installed-software/get-list) с Ubuntu без [GPU](../../glossary/gpu.md). Например, для [Ubuntu 20.04 LTS](/marketplace/products/yc/ubuntu-20-04-lts);
            * `vm_username` и `vm_public_key` — логин и абсолютный путь к [публичному ключу](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys), которые будут использоваться для доступа к виртуальной машине. По умолчанию в образе [Ubuntu 20.04 LTS](/marketplace/products/yc/ubuntu-20-04-lts) указанный логин игнорируется, вместо него создается пользователь с логином `ubuntu`. Используйте его для подключения к виртуальной машине.

    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Создайте необходимую инфраструктуру:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

### Создайте дамп базы данных {#dump}

1. Переключите базу в режим <q>только чтение</q>.
1. Создайте дамп с помощью утилиты [pg_dump](https://www.postgresql.org/docs/current/app-pgdump.html). Для ускорения процесса запустите ее в многопоточном режиме, передав в аргументе `--jobs` количество доступных ядер процессора:

    ```bash
    pg_dump --host=<IP-адрес_или_FQDN_хоста-мастера_кластера-источника> \
            --port=<порт> \
            --username=<имя_пользователя> \
            --jobs=<количество_ядер_процессора> \
            --format=d \
            --dbname=<имя_БД> \
            --file=db_dump
    ```

### (Опционально) Загрузите дамп на виртуальную машину в {{ yandex-cloud }} {#create-vm}

Переносить данные на промежуточную виртуальную машину в {{ compute-name }} нужно, если:

* К вашему кластеру {{ mpg-name }} нет доступа из интернета.
* Ваше оборудование или соединение с кластером в {{ yandex-cloud }} недостаточно надежны.

Нужное количество оперативной памяти и ядер процессора зависит от объема переносимых данных и требуемой скорости переноса.

Чтобы подготовить виртуальную машину для восстановления дампа:

1. В консоли управления [создайте новую виртуальную машину](../../compute/operations/vm-create/create-linux-vm.md) из образа [Ubuntu 20.04](/marketplace/products/yc/ubuntu-20-04-lts) на **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}**. Параметры виртуальной машины должны зависеть от размера базы, которую вы хотите перенести. Минимальной конфигурации (1 ядро, 2 ГБ RAM, 10 ГБ дискового пространства) должно хватить для переноса базы до 1 ГБ. Чем больше переносимая база, тем больше должно быть оперативной памяти, и тем больше должно быть дискового пространства (как минимум в два раза больше, чем размер базы).


    Виртуальная машина должна находиться в той же сети и зоне доступности, что и кластер {{ PG }}. Кроме того, виртуальной машине должен быть присвоен публичный IP-адрес, чтобы вы могли загрузить дамп извне {{ yandex-cloud }}.

1. Настройте [apt-репозиторий {{ PG }}](https://www.postgresql.org/download/linux/ubuntu/).

1. Установите клиент {{ PG }} и дополнительные утилиты для работы с СУБД:

    ```bash
    sudo apt install postgresql-client-common && \
    sudo apt install postgresql-client-<версия_{{ PG }}>
    ```

1. Упакуйте дамп в архив:

    ```bash
    tar -cvzf db_dump.tar.gz db_dump
    ```

1. Перенесите архив с дампом на виртуальную машину, например, используя утилиту `scp`:

    ```bash
    scp db_dump.tar.gz <имя_пользователя_ВМ>@<публичный_адрес_ВМ>:/db_dump.tar.gz
    ```

1. [Подключитесь к виртуальной машине](../../compute/operations/vm-connect/ssh.md).

1. Распакуйте архив с дампом:

    ```bash
    tar -xzf db_dump.tar.gz
    ```

### Восстановите данные из дампа в кластер-приемник {#restore}

Восстановите дамп базы данных с помощью утилиты [pg_restore](https://www.postgresql.org/docs/current/app-pgrestore.html).

Версия `pg_restore` должна совпадать с версией `pg_dump`, а мажорная версия должна быть не меньше, чем у базы на которую дамп разворачивается.

Таким образом, для восстановления дампа {{ PG }} 10, {{ PG }} 11, {{ PG }} 12, {{ PG }} 13 и {{ PG }} 14 используйте `pg_restore 10`, `pg_restore 11`, `pg_restore 12`, `pg_restore 13`, `pg_restore 14` соответственно.

```bash
pg_restore --host=<IP-адрес_или_FQDN_хоста-мастера_кластера-приемника> \
           --username=<имя_пользователя> \
           --dbname=<имя_БД> \
           --port={{ port-mpg }} \
           --format=d \
           --verbose \
           db_dump \
           --single-transaction \
           --no-privileges
```

Если нужно восстановить только одну схему, добавьте параметр `--schema=<имя_схемы>`. Без него команда сработает только от лица владельца базы данных.

Если восстановление прерывается из-за ошибок отсутствия необходимых прав для создания и изменения расширений, уберите из команды параметр `--single-transaction`. В этом случае ошибки будут проигнорированы:

```text
pg_restore: warning: errors ignored on restore: 3
```

Убедитесь, что ошибки относятся только к расширениям, и проверьте целостность восстановленных данных.

### Удалите созданные ресурсы {#clear-out-backup}

Удалите ресурсы, которые вы больше не будете использовать, чтобы за них не списывалась плата:

{% list tabs group=instructions %}

- Вручную {#manual}

    * [Удалите кластер {{ mpg-full-name }}](../../managed-postgresql/operations/cluster-delete.md).
    * Если вы создавали промежуточную виртуальную машину, [удалите ее](../../compute/operations/vm-control/vm-delete.md).
    * Если вы зарезервировали публичные статические IP-адреса, освободите и [удалите их](../../vpc/operations/address-delete.md).

- {{ TF }} {#tf}

    1. В терминале перейдите в директорию с планом инфраструктуры.
    1. Удалите конфигурационный файл `data-restore-pgsql-mpg.tf`.
    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        Все ресурсы, которые были описаны в конфигурационном файле `data-restore-pgsql-mpg.tf`, будут удалены.

{% endlist %}
