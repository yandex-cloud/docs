---
title: Как настроить эндпоинт-приемник {{ MG }} в {{ data-transfer-full-name }}
description: Из статьи вы узнаете, как задать настройки при создании или изменении эндпоинта-приемника {{ MG }} в {{ data-transfer-full-name }}.
---
# Передача данных в эндпоинт-приемник {{ MG }}/{{ SD }} (Managed Service for MongoDB)


С помощью сервиса {{ data-transfer-full-name }} вы можете переносить данные в базу {{ MG }}/{{ SD }} (Managed Service for MongoDB) и реализовывать различные сценарии переноса, обработки и трансформации данных. Для реализации трансфера:

1. [Ознакомьтесь с возможными сценариями передачи данных](#scenarios).
1. [Настройте один из поддерживаемых источников данных](#supported-sources).
1. [Подготовьте базу данных {{ MG }}/{{ SD }} (Managed Service for MongoDB)](#prepare) к трансферу.
1. [Настройте эндпоинт-приемник](#endpoint-settings) в {{ data-transfer-full-name }}.
1. [Создайте](../../transfer.md#create) и [запустите](../../transfer.md#activate) трансфер.
1. [Выполняйте необходимые действия по работе с базой](#db-actions) и [контролируйте трансфер](../../monitoring.md).
1. При возникновении проблем, [воспользуйтесь готовыми решениями](#troubleshooting) по их устранению.

## Сценарии передачи данных в {{ MG }}/{{ SD }} (Managed Service for MongoDB) {#scenarios}

1. {% include [migration](../../../../_includes/data-transfer/scenario-captions/migration.md) %}
    
    * [Миграция кластера {{ MG }}](../../../tutorials/storedoc.md);
    * [Миграция кластера {{ SD }} (Managed Service for MongoDB) с версии 4.4 на 6.0](../../../tutorials/storedoc-versions.md).

1. {% include [queue](../../../../_includes/data-transfer/scenario-captions/queue.md) %}
    
    * [Поставка данных из {{ KF }} в {{ SD }} (Managed Service for MongoDB)](../../../tutorials/mkf-to-mmg.md).

Подробное описание возможных сценариев передачи данных в {{ data-transfer-full-name }} см. в разделе [Практические руководства](../../../tutorials/index.md).

## Настройка источника данных {#supported-sources}

Настройте один из поддерживаемых источников данных:

* [{{ MG }}/{{ SD }}](../source/mongodb.md);
* [{{ AB }}](../../../transfer-matrix.md#airbyte);
* [{{ DS }}](../source/data-streams.md);
* [{{ KF }}](../source/kafka.md).

Полный список поддерживаемых источников и приемников в {{ data-transfer-full-name }} см. в разделе [Доступные трансферы](../../../transfer-matrix.md).

## Подготовка базы данных приемника {#prepare}

{% include [prepare db](../../../../_includes/data-transfer/endpoints/targets/mongodb-prepare.md) %}

## Настройка эндпоинта-приемника {{ MG }}/{{ SD }} (Managed Service for MongoDB) {#endpoint-settings}

{% include [MongodDB Version](../../../../_includes/data-transfer/notes/mongodb-version.md) %}

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта вы можете задать:

* Настройки подключения к [кластеру {{ mmg-full-name }}](#managed-service) или [пользовательской инсталляции](#on-premise), в т. ч. на базе виртуальных машин {{ compute-full-name }}. Эти параметры обязательные.
* [Дополнительные параметры](#additional-settings).


### Кластер {{ mmg-name }} (Managed Service for MongoDB) {#managed-service}


{% note warning %}

Для создания или редактирования эндпоинта управляемой базы данных вам потребуется [роль `{{ roles.mmg.viewer }}`](../../../../storedoc/security/index.md#mmg-viewer) или примитивная [роль `viewer`](../../../../iam/roles-reference.md#viewer), выданная на каталог кластера этой управляемой базы данных.

{% endnote %}

Подключение к БД с указанием идентификатора кластера в {{ yandex-cloud }}.

{% list tabs group=instructions %}

- Консоль управления {#console}

    {% include [Managed MongoDB](../../../../_includes/data-transfer/necessary-settings/ui/managed-mongodb.md) %}

- CLI {#cli}

    * Тип эндпоинта — `mongo-target`.

    {% include [Managed MongodDB CLI](../../../../_includes/data-transfer/necessary-settings/cli/managed-mongodb.md) %}

- {{ TF }} {#tf}

    * Тип эндпоинта — `mongo_target`.

    {% include [Managed MongodDB Terraform](../../../../_includes/data-transfer/necessary-settings/terraform/managed-mongodb.md) %}

    Пример структуры конфигурационного файла:

    
    ```hcl
    resource "yandex_datatransfer_endpoint" "<имя_эндпоинта_в_{{ TF }}>" {
      name = "<имя_эндпоинта>"
      settings {
        mongo_target {
          security_groups = ["<список_идентификаторов_групп_безопасности>"]
          subnet_id       = "<идентификатор_подсети>"
          connection {
            connection_options {
              mdb_cluster_id = "<идентификатор_кластера>"
              auth_source    = "<имя_базы_данных>"
              user           = "<имя_пользователя>"
              password {
                raw = "<пароль_пользователя>"
              }
            }
          }
          <дополнительные_настройки_эндпоинта>
        }
      }
    }
    ```


    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-dt-endpoint }}).

- API {#api}

    {% include [Managed MongodDB API](../../../../_includes/data-transfer/necessary-settings/api/managed-mongodb.md) %}

{% endlist %}


### Пользовательская инсталляция {#on-premise}

Подключение к БД с явным указанием сетевых адресов и портов.

{% list tabs group=instructions %}

- Консоль управления {#console}

    {% include [On premise MongoDB](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-mongodb.md) %}

- CLI {#cli}

    * Тип эндпоинта — `mongo-target`.

    {% include [Managed MongoDB CLI](../../../../_includes/data-transfer/necessary-settings/cli/on-premise-mongodb.md) %}

- {{ TF }} {#tf}

    * Тип эндпоинта — `mongo_target`.

    {% include [On premise MongoDB Terraform](../../../../_includes/data-transfer/necessary-settings/terraform/on-premise-mongodb.md) %}

    Пример структуры конфигурационного файла:

    
    ```hcl
    resource "yandex_datatransfer_endpoint" "<имя_эндпоинта_в_{{ TF }}>" {
      name = "<имя_эндпоинта>"
      settings {
        mongo_target {
          security_groups = ["<список_идентификаторов_групп_безопасности>"]
          subnet_id       = "<идентификатор_подсети>"
          connection {
            connection_options {
              on_premise {
                hosts       = [ "список хостов набора реплик" ]
                port        = "<порт_для_подключения>"
                replica_set = "<имя_набора_реплик>"
                tls_mode {
                  enabled {
                    ca_certificate = "<сертификат_в_формате_PEM>"
                  }
                }
              }
              auth_source = "<имя_базы_данных>"
              user        = "<имя_пользователя>"
              password {
                raw = "<пароль_пользователя>"
              }
            }
          }
          <дополнительные_настройки_эндпоинта>
        }
      }
    }
    ```


    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-dt-endpoint }}).

- API {#api}

    {% include [On premise MongoDB API](../../../../_includes/data-transfer/necessary-settings/api/on-premise-mongodb.md) %}

{% endlist %}

### Дополнительные настройки {#additional-settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

    * {% include [database](../../../../_includes/data-transfer/fields/mongodb/ui/database.md) %}

    * {% include [cleanup_policy](../../../../_includes/data-transfer/fields/mongodb/ui/cleanup-policy.md) %}

- CLI {#cli}

    {% include [target-database](../../../../_includes/data-transfer/fields/mongodb/cli/target-database.md) %}

- {{ TF }} {#tf}

    * {% include [database](../../../../_includes/data-transfer/fields/mongodb/terraform/database.md) %}

    * {% include [cleanup_policy](../../../../_includes/data-transfer/fields/mongodb/terraform/cleanup-policy.md) %}

- API {#api}

    * {% include [database](../../../../_includes/data-transfer/fields/mongodb/api/database.md) %}

    * {% include [cleanupPolicy](../../../../_includes/data-transfer/fields/mongodb/api/cleanup-policy.md) %}

{% endlist %}

{% note warning %}

По умолчанию сервис {{ data-transfer-name }} переносит коллекции без шардирования. Если вы переносите данные в шардированный кластер-приемник и хотите, чтобы коллекции шардировались:

1. [Подготовьте кластер-приемник](../../prepare.md#target-mg) для шардирования коллекций.
1. Выберите политику очистки `DISABLED` или `TRUNCATE`.

Выбор политики `DROP` приведет к тому, что при активации трансфера сервис удалит из базы-приемника все данные, в т. ч. шардированные коллекции, и создаст вместо них новые, нешардированные.

{% endnote %}

После настройки источника и приемника данных [создайте и запустите трансфер](../../transfer.md#create).

## Действия с базой данных во время трансфера {#db-actions}

{% include [work with db](../../../../_includes/data-transfer/endpoints/sources/mongo-work-with-db.md) %}

## Решение проблем, возникающих при переносе данных {#troubleshooting}

Известные проблемы, связанные с использованием эндпоинта {{ MG }}:

* [Размер ключа коллекции превышает 5 МБ](#string-size)
* [Размер объекта в коллекции превышает 16 МБ](#object-size)
* [Не удалось найти ни одной таблицы](#no-tables)
* [Ошибка при трансфере шардированного кластера](#sharded)
* [Ошибка при переносе коллекций timeseries](#timeseries)
* [Не распознается IP-адрес или FQDN внешнего кластера](#cluster-config-issue)

См. полный список рекомендаций в разделе [Решение проблем](../../../troubleshooting/index.md).

{% include [string-size](../../../../_includes/data-transfer/troubles/mongodb/string-size.md) %}

{% include [object-size](../../../../_includes/data-transfer/troubles/mongodb/object-size.md) %}

{% include [no-tables](../../../../_includes/data-transfer/troubles/mongodb/no-tables.md) %}

{% include [sharded](../../../../_includes/data-transfer/troubles/mongodb/sharded.md) %}

{% include [timeseries](../../../../_includes/data-transfer/troubles/mongodb/timeseries.md) %}

{% include [cluster configuration](../../../../_includes/data-transfer/troubles/mongodb/cluster-configuration.md) %}

