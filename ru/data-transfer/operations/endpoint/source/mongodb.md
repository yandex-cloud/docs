---
title: "Инструкция по настройке эндпоинта-источника {{ MG }} в {{ data-transfer-full-name }}"
description: "Из статьи вы узнаете, как задать настройки при создании или изменении эндпоинта-источника {{ MG }} в {{ data-transfer-full-name }}."
---

# Настройка эндпоинта-источника {{ MG }}

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта вы можете задать:

* Настройки подключения к [кластеру {{ mmg-full-name }}](#managed-service) или [пользовательской инсталляции](#on-premise), в т. ч. на базе виртуальных машин {{ compute-full-name }}. Эти параметры обязательные.
* [Дополнительные параметры](#additional-settings).


## Кластер {{ mmg-name }} {#managed-service}

Подключение к БД с указанием идентификатора кластера в {{ yandex-cloud }}. Доступно только для кластеров, развернутых в сервисе [{{ mmg-full-name }}](../../../../managed-mongodb/).

{% list tabs %}

- Консоль управления

    {% include [Managed MongoDB](../../../../_includes/data-transfer/necessary-settings/ui/managed-mongodb.md) %}

- CLI

    * Тип эндпоинта — `mongo-source`.

    {% include [Managed MongoDB CLI](../../../../_includes/data-transfer/necessary-settings/cli/managed-mongodb.md) %}

- Terraform

    * Тип эндпоинта — `mongo_source`.

    {% include [Managed MongoDB Terraform](../../../../_includes/data-transfer/necessary-settings/terraform/managed-mongodb.md) %}

    Пример структуры конфигурационного файла:

    
    ```hcl
    resource "yandex_datatransfer_endpoint" "<имя эндпоинта в {{ TF }}>" {
      name = "<имя эндпоинта>"
      settings {
        mongo_source {
          security_groups = [ "список идентификаторов групп безопасности" ]
          subnet_id       = "<идентификатор подсети>"
          connection {
            connection_options {
              mdb_cluster_id = "<идентификатор кластера {{ mmg-name }}>"
              auth_source    = "<имя базы данных>"
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

    {% include [Managed MongoDB API](../../../../_includes/data-transfer/necessary-settings/api/managed-mongodb.md) %}

{% endlist %}


## Пользовательская инсталляция {#on-premise}

Настройки приведены для случая OnPremise, когда все поля заполняются вручную.

{% list tabs %}

- Консоль управления

    {% include [On premise MongoDB](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-mongodb.md) %}

- CLI

    * Тип эндпоинта — `mongo-source`.

    {% include [On premise MongoDB CLI](../../../../_includes/data-transfer/necessary-settings/cli/on-premise-mongodb.md) %}

- Terraform

    * Тип эндпоинта — `mongo_source`.

    {% include [On premise MongoDB Terraform](../../../../_includes/data-transfer/necessary-settings/terraform/on-premise-mongodb.md) %}

    Пример структуры конфигурационного файла:

    
    ```hcl
    resource "yandex_datatransfer_endpoint" "<имя эндпоинта в {{ TF }}>" {
      name = "<имя эндпоинта>"
      settings {
        mongo_source {
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

    * **Список включенных коллекций** — будут передаваться данные только из перечисленных коллекций. По умолчанию передаются все коллекции.

    * **Список исключенных коллекций** — будут передаваться данные из всех коллекций, кроме указанных.

- Terraform

    * `secondary_preferred_mode` – если в кластере есть реплики, они будут использоваться для чтения данных вместо хоста-мастера.

    * `collections` — будут передаваться данные только из перечисленных коллекций. По умолчанию передаются все коллекции.

    * `excluded_collections` — будут передаваться данные из всех коллекций, кроме указанных.

{% endlist %}

Если источник испытывает высокую рабочую нагрузку (более 10000 транзакций на запись в секунду), то рекомендуется задать эти настройки так, чтобы в каждом эндпоинте присутствовало не более десяти различных баз. Это позволит избежать ошибок подключения к базам во время работы трансфера.

{% note info %}

Если вы используете несколько эндпоинтов, то для каждого из них необходимо создать отдельный трансфер.

{% endnote %}
