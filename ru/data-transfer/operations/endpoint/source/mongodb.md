---
title: Как настроить эндпоинт-источник {{ MG }} в {{ data-transfer-full-name }}
description: Из статьи вы узнаете, как задать настройки при создании или изменении эндпоинта-источника {{ MG }} в {{ data-transfer-full-name }}.
---
# Передача данных из эндпоинта-источника {{ MG }}/{{ SD }} (Managed Service for MongoDB)


С помощью сервиса {{ data-transfer-full-name }} вы можете переносить данные из базы {{ MG }} и реализовывать различные сценарии переноса, обработки и трансформации данных. Для реализации трансфера:

1. [Ознакомьтесь с возможными сценариями передачи данных](#scenarios).
1. [Подготовьте базу данных {{ MG }}](#prepare) к трансферу.
1. [Настройте эндпоинт-источник](#endpoint-settings) в {{ data-transfer-full-name }}.
1. [Настройте один из поддерживаемых приемников данных](#supported-targets).
1. [Создайте](../../transfer.md#create) и [запустите](../../transfer.md#activate) трансфер.
1. [Выполняйте необходимые действия по работе с базой](#db-actions) и [контролируйте трансфер](../../monitoring.md).
1. При возникновении проблем, [воспользуйтесь готовыми решениями](#troubleshooting) по их устранению.

## Сценарии передачи данных из {{ MG }}/{{ SD }} (Managed Service for MongoDB) {#scenarios}

1. {% include [migration](../../../../_includes/data-transfer/scenario-captions/migration.md) %}

    * [Миграция кластера {{ MG }}](../../../tutorials/storedoc.md);
    * [Миграция кластера {{ SD }} (Managed Service for MongoDB) с версии 4.4 на 6.0](../../../tutorials/storedoc-versions.md).

1. {% include [storage](../../../../_includes/data-transfer/scenario-captions/storage.md) %}

Подробное описание возможных сценариев передачи данных в {{ data-transfer-full-name }} см. в разделе [Практические руководства](../../../tutorials/index.md).

## Подготовка базы данных источника {#prepare}

{% include [prepare db](../../../../_includes/data-transfer/endpoints/sources/mongodb-prepare.md) %}

## Настройка эндпоинта-источника {{ MG }}/{{ SD }} (Managed Service for MongoDB) {#endpoint-settings}

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

    * Тип эндпоинта — `mongo-source`.

    {% include [Managed MongoDB CLI](../../../../_includes/data-transfer/necessary-settings/cli/managed-mongodb.md) %}

- {{ TF }} {#tf}

    * Тип эндпоинта — `mongo_source`.

    {% include [Managed MongoDB Terraform](../../../../_includes/data-transfer/necessary-settings/terraform/managed-mongodb.md) %}

    Пример структуры конфигурационного файла:

    
    ```hcl
    resource "yandex_datatransfer_endpoint" "<имя_эндпоинта_в_{{ TF }}>" {
      name = "<имя_эндпоинта>"
      settings {
        mongo_source {
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

    {% include [Managed MongoDB API](../../../../_includes/data-transfer/necessary-settings/api/managed-mongodb.md) %}

{% endlist %}

### Пользовательская инсталляция {#on-premise}

Настройки приведены для случая OnPremise, когда все поля заполняются вручную.

{% list tabs group=instructions %}

- Консоль управления {#console}

    {% include [On premise MongoDB](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-mongodb.md) %}

- CLI {#cli}

    * Тип эндпоинта — `mongo-source`.

    {% include [On premise MongoDB CLI](../../../../_includes/data-transfer/necessary-settings/cli/on-premise-mongodb.md) %}

- {{ TF }} {#tf}

    * Тип эндпоинта — `mongo_source`.

    {% include [On premise MongoDB Terraform](../../../../_includes/data-transfer/necessary-settings/terraform/on-premise-mongodb.md) %}

    Пример структуры конфигурационного файла:

    
    ```hcl
    resource "yandex_datatransfer_endpoint" "<имя_эндпоинта_в_{{ TF }}>" {
      name = "<имя_эндпоинта>"
      settings {
        mongo_source {
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

### Фильтр коллекций {#additional-settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

    * {% include [collections](../../../../_includes/data-transfer/fields/mongodb/ui/collections.md) %}

        {% include [Description for Included collections](../../../../_includes/data-transfer/fields/mongodb/description-included-collections.md) %}

    * {% include [excluded-collections](../../../../_includes/data-transfer/fields/mongodb/ui/excluded-collections.md) %}

    Имена включенных и исключенных коллекций должны соответствовать правилам именования идентификаторов в {{ MG }}. Экранирование двойных кавычек не требуется.

- CLI {#cli}

    * {% include [include-collection](../../../../_includes/data-transfer/fields/mongodb/cli/include-collection.md) %}

        {% include [Description for Included collections](../../../../_includes/data-transfer/fields/mongodb/description-included-collections.md) %}

    * {% include [exclude-collection](../../../../_includes/data-transfer/fields/mongodb/cli/exclude-collection.md) %}

    * {% include [prefer-secondary](../../../../_includes/data-transfer/fields/mongodb/cli/prefer-secondary.md) %}

- {{ TF }} {#tf}

    * {% include [collections](../../../../_includes/data-transfer/fields/mongodb/terraform/collections.md) %}

        {% include [Description for Included collections](../../../../_includes/data-transfer/fields/mongodb/description-included-collections.md) %}

    * {% include [excluded_collections](../../../../_includes/data-transfer/fields/mongodb/terraform/excluded-collections.md) %}

    * {% include [secondary_preferred_mode](../../../../_includes/data-transfer/fields/mongodb/terraform/secondary-preferred-mode.md) %}

- API {#api}

    * {% include [collections](../../../../_includes/data-transfer/fields/mongodb/api/collections.md) %}

        {% include [Description for Included collections](../../../../_includes/data-transfer/fields/mongodb/description-included-collections.md) %}

    * {% include [excludedCollections](../../../../_includes/data-transfer/fields/mongodb/api/excluded-collections.md) %}

    * {% include [secondaryPreferredMode](../../../../_includes/data-transfer/fields/mongodb/api/secondary-preferred-mode.md) %}

{% endlist %}

Если источник испытывает высокую рабочую нагрузку (более 10000 транзакций на запись в секунду), то рекомендуется задать эти настройки так, чтобы в каждом эндпоинте присутствовало не более десяти различных баз. Это позволит избежать ошибок подключения к базам во время работы трансфера.

{% note info %}

* Если вы используете несколько эндпоинтов, то для каждого из них необходимо создать отдельный трансфер.
* Так как трансферы не поддерживают перенос [коллекций timeseries]({{ mg.docs.comd }}/core/timeseries-collections/), такие коллекции необходимо исключить.

{% endnote %}


## Настройка приемника данных {#supported-targets}

Настройте один из поддерживаемых приемников данных:

* [{{ objstorage-full-name }}](../target/object-storage.md).
* [{{ mmg-name }} (Managed Service for MongoDB)](../target/mongodb.md).

Полный список поддерживаемых источников и приемников в {{ data-transfer-full-name }} см. в разделе [Доступные трансферы](../../../transfer-matrix.md).

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
* [Ошибка на стадии копирования](#history-lost)
* [Данные в источнике не подходят для шардирования](#cannot-get-delimiters)
* [Прерывание трансфера с ошибкой cursor.Decode returned error](#invalid-length)

См. полный список рекомендаций в разделе [Решение проблем](../../../troubleshooting/index.md).

{% include [string-size](../../../../_includes/data-transfer/troubles/mongodb/string-size.md) %}

{% include [object-size](../../../../_includes/data-transfer/troubles/mongodb/object-size.md) %}

{% include [no-tables](../../../../_includes/data-transfer/troubles/mongodb/no-tables.md) %}

{% include [sharded](../../../../_includes/data-transfer/troubles/mongodb/sharded.md) %}

{% include [timeseries](../../../../_includes/data-transfer/troubles/mongodb/timeseries.md) %}

{% include [cluster configuration](../../../../_includes/data-transfer/troubles/mongodb/cluster-configuration.md) %}

{% include [history lost](../../../../_includes/data-transfer/troubles/mongodb/history-lost.md) %}

{% include [cannot-get-delimiters](../../../../_includes/data-transfer/troubles/mongodb/cannot-get-delimiters.md) %}

{% include [invalid-length](../../../../_includes/data-transfer/troubles/mongodb/invalid-length.md) %}
