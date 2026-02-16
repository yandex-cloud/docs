# Миграция кластера {{ mpg-name }} на другую версию c помощью {{ data-transfer-full-name }}


Вы можете перенести продуктивную нагруженную базу данных, развернутую в кластере {{ mpg-name }}, в кластер со старшей версией. В этом руководстве рассматривается пример переноса с версии 13 сразу на версию 17, без последовательного переноса между несколькими версиями (13 → 14 → 15 → 16 → 17).

Чтобы перенести данные:

1. [Подготовьте кластер-источник](#prepare-source).
1. [Подготовьте кластер-приемник](#prepare-target).
1. [Подготовьте и активируйте трансферы](#prepare-transfer).
1. [Переключитесь на работу с новым кластером](#move-data).
1. [Проверьте перенос данных](#verify).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

* Кластер {{ PG }}: выделенные хостам вычислительные ресурсы, объем хранилища и резервных копий (см. [тарифы {{ PG }}](../../../managed-postgresql/pricing.md)).
* Публичные IP-адреса, если для хостов кластера включен публичный доступ (см. [тарифы {{ vpc-name }}](../../../vpc/pricing.md)).
* Каждый трансфер: использование вычислительных ресурсов и количество переданных строк данных (см. [тарифы {{ data-transfer-name }}](../../../data-transfer/pricing.md)).


## Подготовьте кластер-источник {#prepare-source}

1. Подготовьте базу-источник к миграции в соответствии с [рекомендациями](../../../data-transfer/operations/prepare.md#source-pg).

1. Оцените нагрузку на базу данных. Если она превышает 10 000 операций на запись в секунду, запланируйте несколько трансферов:

    1. Определите список особо нагруженных таблиц.
    1. Распределите таблицы между несколькими трансферами.

## Подготовьте кластер-приемник {#prepare-target}

1. Создайте кластер-приемник {{ mpg-name }}:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        [Создайте кластер-приемник {{ mpg-name }}](../../../managed-postgresql/operations/cluster-create.md) с конфигурацией, идентичной кластеру-источнику, и со следующими настройками:

        * Версия кластера — `17`.
        * Имя базы данных — `db1`.
        * Имя пользователя — `user1`.

        Если вы планируете подключаться к кластеру из интернета, включите публичный доступ к хостам кластера.

    - С помощью {{ TF }} {#tf}

        1. {% include [terraform-install-without-setting](../../../_includes/mdb/terraform/install-without-setting.md) %}
        1. {% include [terraform-authentication](../../../_includes/mdb/terraform/authentication.md) %}
        1. {% include [terraform-setting](../../../_includes/mdb/terraform/setting.md) %}
        1. {% include [terraform-configure-provider](../../../_includes/mdb/terraform/configure-provider.md) %}

        1. В той же рабочей директории разместите файл с расширением `.tf` и содержимым:

            ```hcl
            resource "yandex_mdb_postgresql_cluster" "old" { }
            ```

        1. Запишите идентификатор кластера {{ PG }} версии 13 в переменную окружения:

            ```bash
            export POSTGRESQL_CLUSTER_ID=<идентификатор_кластера>
            ```

            Идентификатор можно запросить вместе со [списком кластеров в каталоге](../../../managed-postgresql/operations/cluster-list.md#list-clusters).

        1. Импортируйте настройки кластера {{ PG }} версии 13 в конфигурацию {{ TF }}:

            ```bash
            terraform import yandex_mdb_postgresql_cluster.old ${POSTGRESQL_CLUSTER_ID}
            ```

        1. Получите импортированную конфигурацию:

            ```bash
            terraform show
            ```

        1. Скопируйте ее из терминала и вставьте в файл с расширением `.tf`.
        1. Расположите файл в новой директории `imported-cluster`.
        1. Измените скопированную конфигурацию так, чтобы из нее можно было создать новый кластер:

            * Укажите новое имя кластера в строке `resource` и параметре `name`.
            * В блоке `config` укажите в параметре `version` версию `17`.
            * Удалите параметры `created_at`, `health`, `id` и `status`.
            * В блоках `host` удалите параметры `fqdn`, `role` и `priority`.
            * Если в блоке `disk_size_autoscaling` указано значение параметра `disk_size_limit = 0`, удалите этот блок.
            * Если в блоке `maintenance_window` указано значение параметра `type = "ANYTIME"`, удалите параметр `hour`.
            * (Опционально) Внесите дополнительные изменения, если вам нужна не идентичная, а кастомизированная копия кластера.

        1. Добавьте в файл ресурс для создания пользователя `user1`:

            ```hcl
            resource "yandex_mdb_postgresql_user" "user1" {
              cluster_id = yandex_mdb_postgresql_cluster.<имя_кластера>.id
              name       = "user1"
              password   = "<пароль_пользователя>"
            }
            ```

            Где `<имя_кластера>` — новое имя кластера, указанное в ресурсе `yandex_mdb_postgresql_cluster`.

        1. Добавьте в файл ресурс для создания базы данных:

            ```hcl
            resource "yandex_mdb_postgresql_database" "db1" {
              cluster_id = yandex_mdb_postgresql_cluster.<имя_кластера>.id
              name       = "db1"
              owner      = yandex_mdb_postgresql_user.user1.name
              depends_on = [yandex_mdb_postgresql_user.user1]
            }
            ```

            Где `<имя_кластера>` — новое имя кластера, указанное в ресурсе `yandex_mdb_postgresql_cluster`.

        1. В директории `imported-cluster` [получите данные для аутентификации](../../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials).

        1. В этой же директории [настройте и инициализируйте провайдер](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).

        1. Поместите конфигурационный файл в директорию `imported-cluster` и [укажите значения параметров](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

        1. Проверьте корректность файлов конфигурации {{ TF }}:

            ```bash
            terraform validate
            ```

            Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

        1. Создайте необходимую инфраструктуру:

            {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

            {% include [explore-resources](../../../_includes/mdb/terraform/explore-resources.md) %}

        {% include [Terraform timeouts](../../../_includes/mdb/mpg/terraform/timeouts.md) %}

    {% endlist %}


1. Если вы используете группы безопасности в кластере, убедитесь, что они [настроены правильно](../../../managed-postgresql/operations/connect.md#configuring-security-groups) и допускают подключение к нему.


1. Подготовьте базу-приемник к миграции в соответствии с [рекомендациями](../../../data-transfer/operations/prepare.md#target-pg).

## Подготовьте и активируйте трансферы {#prepare-transfer}

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Создайте эндпоинт-источник](../../../data-transfer/operations/endpoint/index.md#create) для каждого запланированного трансфера и укажите параметры эндпоинта:

        * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** — `PostgreSQL`.
        * **Тип подключения** — `Ручная настройка`.
        * **Тип инсталляции** — `Кластер Managed Service for PostgreSQL`.
        * **Кластер управляемой БД** — `<имя_кластера-источника>` из выпадающего списка.
        * **База данных** — `<имя_базы_данных_кластера-источника>`.
        * **Пользователь** — `<имя_пользователя>`.
        * **Пароль** — `<пароль>`.
        * **Список включенных таблиц** — для каждого эндпоинта укажите список включенных таблиц в соответствии с планом распределения по трансферам.

        Убедитесь, что в блоке **Перенос схемы** для внешних ключей и индексов установлено значение `После переноса данных`. В этом случае перенос внешних ключей и индексов будет выполняться на этапе деактивации трансферов.

    1. [Создайте эндпоинт-приемник](../../../data-transfer/operations/endpoint/index.md#create) для каждого запланированного трансфера и укажите параметры эндпоинта:

        * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** — `PostgreSQL`.
        * **Тип подключения** — `Ручная настройка`.
        * **Тип инсталляции** — `Кластер Managed Service for PostgreSQL`.
        * **Кластер управляемой БД** — `db1` из выпадающего списка.
        * **Пользователь** — `user1`.
        * **Пароль** — `<пароль>`.

    1. [Создайте трансферы](../../../data-transfer/operations/transfer.md#create) типа **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot_and_increment.title }}_**, использующие созданные эндпоинты.

        Чтобы ускорить копирование больших таблиц (более 100 ГБ), настройте [параллельное копирование](../../../data-transfer/concepts/sharded.md) для трансфера, указав нужное количество воркеров и потоков.

        Таблица разделится на указанное количество частей, которые будут копироваться параллельно.

    1. [Активируйте трансферы](../../../data-transfer/operations/transfer.md#activate).

- С помощью {{ TF }} {#tf}

    1. Откройте в папке `imported-cluster` конфигурационный файл {{ TF }} с планом инфраструктуры.
    1. Добавьте в файл ресурс для создания эндпоинта-источника.

        ```hcl
        resource "yandex_datatransfer_endpoint" "<имя_эндпоинта>" {
          name = "<имя_эндпоинта>"
            settings {
              postgres_source {
                connection {
                  mdb_cluster_id = "<идентификатор_кластера-источника>"
                }
                database = "<имя_базы_данных>"
                user     = "<имя_пользователя>"
                password {
                  raw = "<пароль>"
                }
                include_tables = ["<схема>.<таблица_1>", ... , "<схема>.<таблица_N>"]
                object_transfer_settings {
                  fk_constraint = "AFTER_DATA"
                  index         = "AFTER_DATA"
                }
              }
            }
        }
        ```

        Если вы запланировали несколько трансферов, добавьте отдельный эндпоинт для каждого из них. Для каждого эндпоинта-источника укажите в параметре `include_tables` список включенных таблиц в соответствии с планом распределения по трансферам.

        В блоке `object_transfer_settings` определены параметры переноса схемы. Значение `AFTER_DATA` означает, что внешние ключи и индексы будут переноситься после переноса данных (на этапе деактивации трансферов).

    1. Добавьте в файл ресурс для создания эндпоинта-приемника.

        ```hcl
        resource "yandex_datatransfer_endpoint" "<имя_эндпоинта>" {
          name = "<имя_эндпоинта>"
            settings {
              postgres_target {
                connection {
                  mdb_cluster_id = yandex_mdb_postgresql_cluster.<имя_кластера>.id
                }
                database = "db1"
                user     = "user1"
                password {
                  raw = "<пароль>"
                }
              }
            }
        }
        ```

        Где `<имя_кластера>` — имя кластера, указанное в ресурсе `yandex_mdb_postgresql_cluster`.

        Если вы запланировали несколько трансферов, добавьте отдельный эндпоинт для каждого из них.

    1. Добавьте в файл ресурс для создания трансфера, использующего созданные эндпоинты.

        ```
        resource "yandex_datatransfer_transfer" "<имя_трансфера>" {
          name      = "<имя_трансфера>"
          source_id = yandex_datatransfer_endpoint.<имя_эндпоинта-источника>.id
          target_id = yandex_datatransfer_endpoint.<имя_эндпоинта-приемника>.id
          type      = "SNAPSHOT_AND_INCREMENT"
          runtime {
            yc_runtime {
              upload_shard_params {
                job_count     = <количество_воркеров>
                process_count = <количество_потоков>
              }
            }
          }
        }
        ```

        Где:

        * `source_id` — ссылка на эндпоинт-источник.
        * `target_id` — ссылка на эндпоинт-приемник.
        * `type` — тип трансфера. Значение `SNAPSHOT_AND_INCREMENT` — **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot_and_increment.title }}_**.
        * `runtime.yc_runtime.upload_shard_params` — настройки [параллельного копирования](../../../data-transfer/concepts/sharded.md). Используются, чтобы ускорить копирование больших таблиц (более 100 ГБ).

            * `job_count` — количество воркеров.
            * `process_count` — количество потоков.

        Если вы распределили таблицы между несколькими парами эндпоинтов, создайте отдельный трансфер для каждой из них.

        Трансферы будут запущены автоматически после создания.

{% endlist %}

## Переключитесь на работу с новым кластером {#move-data}

1. Дождитесь перехода трансферов в статус {{ dt-status-repl }}.
1. Снимите пишущую нагрузку с кластера-источника.
1. На странице [мониторинга трансфера](../../../data-transfer/operations/monitoring.md) дождитесь снижения до нуля характеристики **Maximum data transfer delay** для каждого трансфера. Это значит, что в кластер-приемник перенесены все изменения, произошедшие в кластере-источнике после завершения копирования данных.
1. Переключите нагрузку на кластер-приемник.
1. [Деактивируйте](../../../data-transfer/operations/transfer.md#deactivate) трансферы и дождитесь их перехода в статус {{ dt-status-stopped }}.

    Во время деактивации выполняется создание внешних ключей и индексов. Это может занять продолжительное время. Чем больший объем занимает база данных, тем больше времени занимает деактивация.

## Проверьте перенос данных {#verify}

1. [Подключитесь к базе данных](../../../managed-postgresql/operations/connect.md) `db1` в кластере-приемнике {{ mpg-name }}.

1. Убедитесь, что в базе данных `db1` появились таблицы, выполнив запрос:

    ```sql
    SELECT schemaname AS schema, tablename AS table_name
    FROM pg_tables
    WHERE schemaname NOT IN ('pg_catalog', 'information_schema') 
      AND tablename NOT LIKE 'pg\_%'
    ORDER BY schemaname, tablename;
    ```

    Запрос выведет список всех несистемных таблиц.

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Удалите ресурсы, которые вы больше не будете использовать, чтобы не платить за них:

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Удалите трансфер](../../../data-transfer/operations/transfer.md#delete).
    1. [Удалите эндпоинты](../../../data-transfer/operations/endpoint/index.md#delete).
    1. [Удалите кластер {{ mpg-name }}](../../../managed-postgresql/operations/cluster-delete.md) версии `17`.

- С помощью {{ TF }} {#tf}

    {% include [terraform-clear-out](../../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}
