---
title: "Как настроить эндпоинт-приемник {{ PG }} в {{ data-transfer-full-name }}"
description: "Из статьи вы узнаете, как задать настройки при создании или изменении эндпоинта-приемника {{ PG }} в {{ data-transfer-full-name }}."
---

# Настройка эндпоинта-приемника {{ PG }}

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта вы можете задать:

* Настройки подключения к [кластеру {{ mpg-full-name }}](#managed-service) или [пользовательской инсталляции](#on-premise), в т. ч. на базе виртуальных машин {{ compute-full-name }}. Эти параметры обязательные.
* [Дополнительные параметры](#additional-settings).

## Кластер {{ mpg-name }} {#managed-service}

Подключение к БД с указанием идентификатора кластера в {{ yandex-cloud }}. Доступно только для кластеров, развернутых в сервисе [{{ mpg-full-name }}](../../../../managed-postgresql/).

{% list tabs %}

- Консоль управления

    {% include [Managed Postgresql](../../../../_includes/data-transfer/necessary-settings/ui/managed-postgresql.md) %}

- CLI

    * Тип эндпоинта — `postgres-target`.

    {% include [Managed PostgreSQL CLI](../../../../_includes/data-transfer/necessary-settings/cli/managed-postgresql.md) %}
    
- {{ TF }}

    * Тип эндпоинта — `postgres_target`.

    {% include [Managed PostgreSQL Terraform](../../../../_includes/data-transfer/necessary-settings/terraform/managed-postgresql.md) %}

    Пример структуры конфигурационного файла:

    
    ```hcl
    resource "yandex_datatransfer_endpoint" "<имя эндпоинта в {{ TF }}>" {
      name = "<имя эндпоинта>"
      settings {
        postgres_target {
          security_groups = [ "список идентификаторов групп безопасности" ]
          connection {
            mdb_cluster_id = "<идентификатор кластера {{ mpg-name }}>"
          }
          database = "<имя переносимой базы данных>"
          user     = "<имя пользователя для подключения>"
          password {
            raw = "<пароль пользователя>"
          }
        }
      }
    }
    ```


    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-dt-endpoint }}).

- API

    {% include [Managed PostgreSQL API](../../../../_includes/data-transfer/necessary-settings/api/managed-postgresql.md) %}

{% endlist %}

## Пользовательская инсталляция {#on-premise}

Для случая OnPremise все поля заполняются вручную.

{% list tabs %}

- Консоль управления

    {% include [On premise Postgresql](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-postgresql.md) %}

- CLI

    * Тип эндпоинта — `postgres-target`.

    {% include [On premise PostgreSQL CLI](../../../../_includes/data-transfer/necessary-settings/cli/on-premise-postgresql.md) %}

- {{ TF }}

    * Тип эндпоинта — `postgres_target`.

    {% include [On premise PostgreSQL Terraform](../../../../_includes/data-transfer/necessary-settings/terraform/on-premise-postgresql.md) %}

    Пример структуры конфигурационного файла:

    
    ```hcl
    resource "yandex_datatransfer_endpoint" "<имя эндпоинта в {{ TF }}>" {
      name = "<имя эндпоинта>"
      settings {
        postgres_target {
          security_groups = [ "список идентификаторов групп безопасности" ]
          connection {
            on_premise {
              hosts = ["<список хостов>"]
              port  = <порт для подключения>
            }
          }
          database = "<имя переносимой базы данных>"
          user     = "<имя пользователя для подключения>"
          password {
            raw = "<пароль пользователя>"
          }
        }
      }
    }
    ```


    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-dt-endpoint }}).

- API

    {% include [On premise PostgreSQL API](../../../../_includes/data-transfer/necessary-settings/api/on-premise-postgresql.md) %}

{% endlist %}

## Дополнительные настройки {#additional-settings}

{% list tabs %}

- Консоль управления

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresTarget.cleanup_policy.title }}** — выберите способ очистки данных в базе-приемнике перед переносом:

      * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DISABLED.title }}` — выберите эту опцию, если будет производиться только репликация без копирования данных.

      * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DROP.title }}` — полное удаление таблиц, участвующих в трансфере (вариант по умолчанию).

          Используйте эту опцию, чтобы при любой активации трансфера в базу-приемник всегда передавалась самая последняя версия схемы таблиц из источника.

      * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.TRUNCATE.title }}` — удалить только данные из таблиц, участвующих в трансфере, но оставить схему.

          Используйте эту опцию, если схема в базе-приемнике отличается от той, которая была бы перенесена из источника при трансфере.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresTargetAdvancedSettings.save_tx_boundaries.title }}** — включите, чтобы сервис записывал данные в базу-приемник только после полного чтения данных транзакции из базы-источника.

          
        {% note warning %}

        Эта функциональность находится на стадии [Preview](../../../../overview/concepts/launch-stages.md).

        {% endnote %}
  

{% endlist %}
