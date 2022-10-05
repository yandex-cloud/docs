# Настройка эндпоинта-приемника {{ MG }}

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта вы можете задать:

* Настройки подключения к [кластеру {{ mmg-full-name }}](#managed-service) или [пользовательской инсталляции](#on-premise), в т. ч. на базе виртуальных машин {{ compute-full-name }}. Эти параметры обязательные.
* [Дополнительные параметры](#additional-settings).


## Кластер {{ mmg-name }} {#managed-service}

{% list tabs %}

- Консоль управления

    Подключение к БД с указанием идентификатора кластера в {{ yandex-cloud }}. Доступно только для кластеров, развернутых в сервисе [{{ mmg-full-name }}](../../../../managed-mongodb/).

    {% include [Managed MongoDB](../../../../_includes/data-transfer/necessary-settings/ui/managed-mongodb.md) %}

- CLI

    * Тип эндпоинта — `mongo-target`.

    {% include [Managed MongodDB CLI](../../../../_includes/data-transfer/necessary-settings/cli/managed-mongodb.md) %}

- Terraform

    * Тип эндпоинта — `mongo_target`.

    {% include [Managed MongodDB Terraform](../../../../_includes/data-transfer/necessary-settings/terraform/managed-mongodb.md) %}

    Пример структуры конфигурационного файла:

    ```hcl
    resource "yandex_datatransfer_endpoint" "<имя эндпоинта в {{ TF }}>" {
      name = "<имя эндпоинта>"
      settings {
        mongo_target {
          security_groups = [ "список идентификаторов групп безопасности" ]
          subnet_id       = "<идентификатор подсети>"
          connection {
            connection_options {
              mdb_cluster_id = "<идентификатор кластера {{ mmg-name }}>"
              database       = "<имя базы данных>"
              user           = "<имя пользователя>"
              password {
                raw = "<пароль пользователя>"
              }
            }
          }
          <дополнительные настройки эндпоинта>
        }
      }
    }
    ```

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-dt-endpoint }}).

- API

    {% include [Managed MongodDB API](../../../../_includes/data-transfer/necessary-settings/api/managed-mongodb.md) %}

{% endlist %}


## Пользовательская инсталляция {#on-premise}

Подключение к БД с явным указанием сетевых адресов и портов.

{% list tabs %}

- Консоль управления

    {% include [On premise MongoDB](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-mongodb.md) %}

- CLI

    * Тип эндпоинта — `mongo-target`.

    {% include [Managed MongoDB CLI](../../../../_includes/data-transfer/necessary-settings/cli/on-premise-mongodb.md) %}

- Terraform

    * Тип эндпоинта — `mongo_target`.

    {% include [On premise MongoDB Terraform](../../../../_includes/data-transfer/necessary-settings/terraform/on-premise-mongodb.md) %}

    Пример структуры конфигурационного файла:

    ```hcl
    resource "yandex_datatransfer_endpoint" "<имя эндпоинта в {{ TF }}>" {
      name = "<имя эндпоинта>"
      settings {
        mongo_target {
          security_groups = [ "список идентификаторов групп безопасности" ]
          subnet_id       = "<идентификатор подсети>"
          connection {
            connection_options {
              on_premise {
                hosts       = [ "список хостов набора реплик" ]
                port        = "<порт для подключения>"
                replica_set = "<имя набора реплик>"
                tls_mode {
                  enabled {
                    ca_certificate = "<сертификат в формате PEM>"
                  }
                }
              }
              auth_source = "<имя базы данных>"
              user        = "<имя пользователя>"
              password {
                raw = "<пароль пользователя>"
              }
            }
          }
          <дополнительные настройки эндпоинта>
        }
      }
    }
    ```

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-dt-endpoint }}).

- API

    {% include [On premise MongoDB API](../../../../_includes/data-transfer/necessary-settings/api/on-premise-mongodb.md) %}

{% endlist %}

## Дополнительные настройки {#additional-settings}

{% list tabs %}

- Консоль управления

    * **Политика очистки** — выберите способ очистки данных в базе-приемнике перед переносом:

        * `DISABLED` — не очищать.

            Выберите эту опцию, если будет производиться только репликация без копирования данных.

        * `DROP` — полное удаление коллекций, участвующих в трансфере (вариант по умолчанию).

            Используйте эту опцию, чтобы при любой активации трансфера в базу-приемник всегда передавалась самая последняя версия схемы из источника.

        * `TRUNCATE` — удалить только данные из коллекций, участвующих в трансфере, но оставить схему.

            Используйте эту опцию, если схема в базе-приемнике отличается от той, которая была бы перенесена из источника при трансфере.

- Terraform

    * `database` – укажите имя базы данных, если хотите создать коллекции в базе данных с именем, отличным от имени базы-источника.

    * `cleanup_policy` – укажите способ очистки данных в базе-приемнике перед переносом:

        * `DISABLED` — не очищать.

            Выберите эту опцию, если будет производиться только репликация без копирования данных.

        * `DROP` — полное удаление коллекций, участвующих в трансфере (вариант по умолчанию).

            Используйте эту опцию, чтобы при любой активации трансфера в базу-приемник всегда передавалась самая последняя версия коллекции из источника.

        * `TRUNCATE` — удалить только данные из коллекций, участвующих в трансфере, но оставить сами коллекции.

            Используйте эту опцию, если структура коллекций в базе-приемнике отличается от той, которая была бы перенесена из источника при трансфере.

{% endlist %}

{% note warning %}

По умолчанию сервис {{ data-transfer-name }} переносит коллекции без шардирования. Если вы переносите данные в шардированный кластер-приемник и хотите, чтобы коллекции шардировались:

1. [Подготовьте кластер-приемник](../../prepare.md#target-mg) для шардирования коллекций.
1. Выберите политику очистки `DISABLED` или `TRUNCATE`.

Выбор политики `DROP` приведет к тому, что при активации трансфера сервис удалит из базы-приемника все данные, в т. ч. шардированные коллекции, и создаст вместо них новые, нешардированные.

{% endnote %}
