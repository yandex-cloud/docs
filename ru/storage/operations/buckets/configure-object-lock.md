---
title: Управление блокировками версий объектов (object lock) в бакете
description: Следуя данной инструкции, вы сможете управлять блокировкой версий объектов в {{ objstorage-name }}.
---

# Управление блокировками версий объектов (object lock) в бакете

В [версионируемых](versioning.md) бакетах можно настроить механизм _[блокировки версий объектов](../../concepts/object-lock.md)_ (object lock). Когда он включен, вы можете установить на версию объекта блокировку, то есть запрет на удаление или перезапись. Также для бакета можно настроить блокировки по умолчанию: они будут устанавливаться на все новые версии объектов.

{% note info %}

В бакетах с приостановленным версионированием блокировка версий объектов недоступна.

{% endnote %}

## Включить возможность блокировок {#enable}

Включение механизма блокировок не устанавливает блокировки на уже загруженные версии объектов, а только позволяет устанавливать их.

Минимальная необходимая роль — `storage.admin`.

Чтобы включить возможность блокировок:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) в списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** и перейдите в бакет, для которого хотите настроить блокировку.
  1. На панели слева выберите ![image](../../../_assets/console-icons/persons-lock.svg) **{{ ui-key.yacloud.storage.bucket.switch_security }}**.
  1. Выберите вкладку **{{ ui-key.yacloud.storage.bucket.switch_object-lock }}**.
  1. Чтобы включить возможность работать с блокировками, включите опцию **{{ ui-key.yacloud.storage.bucket.object-lock.field_object-lock-enabled }}**.
  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- AWS CLI {#cli}

  Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../tools/aws-cli.md).

  Выполните следующую команду:

  ```bash
  aws s3api put-object-lock-configuration \
    --bucket <имя_бакета> \
    --object-lock-configuration ObjectLockEnabled=Enabled \
    --endpoint-url=https://{{ s3-storage-host }}
  ```

  Где:

  * `--bucket` — имя бакета.
  * `--object-lock-configuration` — настройки блокировок в бакете. Значение `ObjectLockEnabled=Enabled` включает механизм блокировок.
  * `--endpoint-url` — эндпоинт {{ objstorage-name }}.

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Откройте файл конфигурации {{ TF }} и добавьте к описанию бакета блок `object_lock_configuration`:

      ```hcl
      resource "yandex_storage_bucket" "b" {
        ...
        object_lock_configuration {
          object_lock_enabled = "Enabled"
        }
      }
      ```

      Где:

      * `object_lock_configuration` — настройки блокировки версий объектов:
        * `object_lock_enabled` — включает блокировку версий объектов. Требует включенное версионирование бакета. Необязательный параметр.

      Более подробную информацию о параметрах бакета, которые вы можете задать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/storage_bucket).

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  После этого в указанном каталоге будет создана блокировка объектов для бакета. Проверить появление блокировки можно с помощью команды [CLI](../../../cli/quickstart.md):

    ```bash
    yc storage bucket get <имя_бакета>
    ```

    Результат:

    ```text
    name: my-bucket
    folder_id: b1geoelk2fld*********
    ...
    object_lock:
      status: OBJECT_LOCK_STATUS_ENABLED
    ```

- API {#api}

  Воспользуйтесь методом S3 API [putObjectLockConfiguration](../../s3/api-ref/bucket/putobjectlockconfiguration.md), методом REST API [update](../../api-ref/Bucket/update.md) для ресурса [Bucket](../../api-ref/Bucket/index.md) или вызовом gRPC API [BucketService/Update](../../api-ref/grpc/bucket_service.md#Update).

{% endlist %}

## Настроить блокировки по умолчанию {#default}

Блокировки по умолчанию устанавливаются на все новые версии объектов, загружаемые в бакет. Настройки не влияют на уже загруженные версии.

Минимальная необходимая роль — `storage.admin`.

Чтобы настроить блокировки по умолчанию:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) в списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** и перейдите в бакет, для которого хотите настроить блокировку по умолчанию.
  1. На панели слева выберите ![image](../../../_assets/console-icons/persons-lock.svg) **{{ ui-key.yacloud.storage.bucket.switch_security }}**.
  1. Выберите вкладку **{{ ui-key.yacloud.storage.bucket.switch_object-lock }}**.
  1. Чтобы включить или выключить возможность работать с блокировками, используйте опцию **{{ ui-key.yacloud.storage.bucket.object-lock.field_object-lock-enabled }}**.
  1. Включите опцию **{{ ui-key.yacloud.storage.bucket.object-lock.field_rule-enabled }}**.
  1. Выберите **{{ ui-key.yacloud.storage.bucket.object-lock.field_mode }}**:
     * **{{ ui-key.yacloud.storage.bucket.object-lock.title-mode-governance }}** — пользователь с ролью `storage.admin` может обойти блокировку, изменить ее срок или снять ее.
     * **{{ ui-key.yacloud.storage.bucket.object-lock.title-mode-compliance }}** — пользователь с ролью `storage.admin` может только продлить блокировку. Обойти, сократить или снять блокировку до ее окончания нельзя.
  1. Установите **{{ ui-key.yacloud.storage.bucket.object-lock.field_retention-period }}** в днях или годах. Отсчитывается от момента, когда версия объекта загружена в бакет.
  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- AWS CLI {#cli}

  Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../tools/aws-cli.md).

  1. Опишите конфигурацию блокировок по умолчанию в формате JSON:
 
     ```json
     {
       "ObjectLockEnabled": "Enabled",
       "Rule": {
         "DefaultRetention": {
           "Mode": "<тип_блокировки>",
           "Days": <срок_блокировки_в_днях>,
           "Years": <срок_блокировки_в_годах>
         }
       }
     }
     ```

     Где:

     * `ObjectLockEnabled` — статус механизма блокировок: `Enabled` — механизм включен.
 
       {% note alert %}

       Это обязательное поле. Если не указать его со значением `Enabled`, появится сообщение об ошибке `InvalidRequest`, а механизм блокировок не включится. См. также [Выключить возможность блокировок](#disable).

       {% endnote %}

     * `Mode` — [тип](../../concepts/object-lock.md#types) блокировки:

       * `GOVERNANCE` — временная управляемая блокировка.
       * `COMPLIANCE` — временная строгая блокировка.

     * `Days` — срок блокировки в днях от момента загрузки версии объекта. Должен быть положительным целым числом. Нельзя указывать вместе с `Years`.
     * `Years` — срок блокировки в годах от момента загрузки версии объекта. Должен быть положительным целым числом. Нельзя указывать вместе с `Days`.

     Готовую конфигурацию можно поместить в файл, например, `default-object-lock.json`.

  1. Загрузите конфигурацию в бакет:

     ```bash
     aws s3api put-object-lock-configuration \
       --bucket <имя_бакета> \
       --object-lock-configuration file://default-object-lock.json \
       --endpoint-url=https://{{ s3-storage-host }}
     ```

     Где:

     * `--bucket` — имя бакета.
     * `--object-lock-configuration` — настройки блокировок по умолчанию. В данном случае указаны в файле `default-object-lock.json`.
     * `--endpoint-url` — эндпоинт {{ objstorage-name }}.

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Откройте файл конфигурации {{ TF }} и  добавьте настройки блокировок по умолчанию в блок `object_lock_configuration`:

      ```
      ...
      rule {
        default_retention {
          mode = "GOVERNANCE"
          years = 1
        }
      }
      ...
      ```

      Где:

      * `rule` — правило для блокировки версий объектов. Содержит в себе параметр `default_retention` с настройками хранения:
        * `mode` — тип блокировки. Может принимать значения `GOVERNANCE` или `COMPLIANCE`. Необязательный параметр.
        * `years` или `days` — время, на которое распространяется блокировка объекта. Указывается в виде числа. Необязательный параметр.

  1. Примените изменения:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  Проверить появление блокировки можно с помощью команды [CLI](../../../cli/quickstart.md):

    ```bash
    yc storage bucket get <имя_бакета>
    ```

    Результат:

    ```text
    name: my-bucket
    folder_id: b1geoelk2fld********
    ...
    object_lock:
    status: OBJECT_LOCK_STATUS_ENABLED
    default_retention:
      mode: MODE_GOVERNANCE
      years: "1"
    ```

{% endlist %}

## Выключить возможность блокировок {#disable}

Выключение механизма блокировок не снимает установленные блокировки: они продолжают работать, их нельзя будет снять или изменить.

Минимальная необходимая роль — `storage.admin`.

Чтобы выключить возможность блокировок:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) в списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** и перейдите в бакет, для которого хотите настроить блокировку.
  1. На панели слева выберите ![image](../../../_assets/console-icons/persons-lock.svg) **{{ ui-key.yacloud.storage.bucket.switch_security }}**.
  1. Выберите вкладку **{{ ui-key.yacloud.storage.bucket.switch_object-lock }}**.
  1. Чтобы выключить возможность работать с блокировками, выключите опцию **{{ ui-key.yacloud.storage.bucket.object-lock.field_object-lock-enabled }}**.
  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- AWS CLI {#cli}

  Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../tools/aws-cli.md).

  Выполните следующую команду:

  ```bash
  aws s3api put-object-lock-configuration \
    --bucket <имя_бакета> \
    --object-lock-configuration ObjectLockEnabled="" \
    --endpoint-url=https://{{ s3-storage-host }}
  ```

  Где:

  * `--bucket` — имя бакета.
  * `--object-lock-configuration` — настройки блокировок в бакете. Значение `ObjectLockEnabled=""` отключает механизм блокировок.
  * `--endpoint-url` — эндпоинт {{ objstorage-name }}.

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Откройте файл конфигурации {{ TF }} и удалите блок `object_lock_configuration`:

      {% cut "Пример описания блокировки версий объектов в конфигурации {{ TF }}" %}

        ```
        ...
        object_lock_configuration {
          object_lock_enabled = "Enabled"
          rule {
            default_retention {
              mode = "GOVERNANCE"
              years = 1
            }
          }
        }
        ...
        ```

      {% endcut %}

  1. Примените изменения:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  Проверить удаление блокировки можно с помощью команды [CLI](../../../cli/quickstart.md):

    ```bash
    yc storage bucket get <имя_бакета>
    ```

    Результат:

    ```text
    name: my-bucket
    folder_id: b1geoelk2fld********
    ...
    object_lock:
      status: OBJECT_LOCK_STATUS_DISABLED
    ```

- API {#api}

  Чтобы выключить возможность блокировок версий объектов в бакете, воспользуйтесь методом S3 API [putObjectLockConfiguration](../../s3/api-ref/bucket/putobjectlockconfiguration.md), методом REST API [update](../../api-ref/Bucket/update.md) для ресурса [Bucket](../../api-ref/Bucket/index.md) или вызовом gRPC API [BucketService/Update](../../api-ref/grpc/bucket_service.md#Update).

  В теле запроса передайте параметр блокировки версий объектов с пустым значением:

  * `ObjectLockConfiguration` — для S3 API.
  * `objectLock` — для REST API.
  * `object_lock` — для gRPC API.

  Пример тела HTTP-запроса для S3 API:

  ```xml
  <ObjectLockConfiguration xmlns="http://s3.amazonaws.com/doc/2006-03-01/" />
  ```

{% endlist %}
