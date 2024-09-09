---
title: "Как настроить публичный доступ к операциям с бакетом в {{ objstorage-full-name }}"
description: "Следуя данной инструкции, вы сможете настроить публичный доступ к бакету в {{ objstorage-name }}." 
---

# Настройка публичного доступа к бакету

{% include [full-overview](../../../_includes/storage/security/full-overview.md) %}

По умолчанию [бакеты](../../concepts/bucket.md) создаются с ограниченным [доступом](../../concepts/bucket.md#bucket-access). Вы можете открыть публичный доступ:

{% include [storage-public-operations](../../_includes_service/storage-public-operations.md) %}

## Открыть публичный доступ {#open-public-access}

{% include [public-access-warning](../../../_includes/storage/security/public-access-warning.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. Выберите сервис **{{ objstorage-name }}**.
  1. Нажмите на имя нужного бакета.
  1. Перейдите на вкладку **{{ ui-key.yacloud.storage.bucket.switch_settings }}**.
  1. Включите публичный доступ для нужных типов операций.
  1. Нажмите **{{ ui-key.yacloud.storage.bucket.settings.button_save }}**.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для изменения бакета:

      ```bash
      yc storage bucket update --help
      ```

  1. Получите список бакетов в каталоге по умолчанию:

      ```bash
      yc storage bucket list
      ```

      Результат:

      ```text
      +------------------+----------------------+-------------+-----------------------+---------------------+
      |       NAME       |      FOLDER ID       |  MAX SIZE   | DEFAULT STORAGE CLASS |     CREATED AT      |
      +------------------+----------------------+-------------+-----------------------+---------------------+
      | first-bucket     | b1gmit33ngp6******** | 53687091200 | STANDARD              | 2022-12-16 13:58:18 |
      +------------------+----------------------+-------------+-----------------------+---------------------+
      ```

   1. Сохраните имя бакета (столбец `NAME`), к которому нужно открыть публичный доступ.
   1. Откройте публичный доступ к операциям с бакетом:

      ```bash
      yc storage bucket update \
        --name <имя_бакета> \
        --public-read \
        --public-list \
        --public-config-read
      ```

      Где:
      * `--name` — имя бакета, к которому нужно открыть публичный доступ.
      * `--public-read` — флаг для включения публичного доступа на чтение объектов в бакете.
      * `--public-list` — флаг для включения публичного доступа на просмотр списка объектов в бакете.
      * `--public-config-read` — флаг для включения публичного доступа на чтение настроек в бакете.

      `name` — обязательный параметр. Остальные параметры необязательны. По умолчанию публичный доступ к бакету выключен.

      Результат:

      ```text
      name: first-bucket
      folder_id: b1gmit33ngp6********
      anonymous_access_flags:
        read: true
        list: true
        config_read: true
      default_storage_class: STANDARD
      versioning: VERSIONING_DISABLED
      max_size: "53687091200"
      acl: {}
      created_at: "2022-12-16T13:58:18.933814Z" 
      ```

- {{ TF }} {#tf}

  {% include [terraform-role](../../../_includes/storage/terraform-role.md) %}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  
  {% include [terraform-install](../../../_includes/terraform-install.md) %}


  Чтобы открыть публичный доступ к операциям с бакетом:

  1. Откройте файл конфигурации {{ TF }} и добавьте блок `anonymous_access_flags` во фрагмент с описанием бакета.

     ```hcl
     resource "yandex_storage_bucket" "log_bucket" {
       access_key = "<идентификатор_статического_ключа>"
       secret_key = "<секретный_ключ>"
       bucket     = "<имя_бакета>"

       anonymous_access_flags {
         read        = true
         list        = true
         config_read = true
       }
     }
     ```

     Где:
     * `access_key` — идентификатор [статического ключа доступа](../../../iam/concepts/authorization/access-key.md).
     * `secret_key` — значение секретного ключа доступа.
     * `bucket` — имя бакета, к которому нужно открыть публичный доступ.
     * `anonymous_access_flags` — параметры публичного доступа:
       * `read` — публичный доступ на чтение объектов в бакете.
       * `list` — публичный доступ к списку объектов в бакете.
       * `config_read` — публичный доступ к чтению настроек бакета.

     Более подробную информацию о параметрах ресурса `yandex_storage_bucket` в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/storage_bucket#bucket-anonymous-access-flags).

  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет. 

  1. Разверните облачные ресурсы.

     1. Если в конфигурации нет ошибок, выполните команду:

        ```
        terraform apply
        ```

     1. Подтвердите создание ресурсов: введите в терминал слово `yes` и нажмите **Enter**.

        После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

- API {#api}

  Чтобы открыть публичный доступ к операциям с бакетом, воспользуйтесь методом REST API [update](../../api-ref/Bucket/update.md) для ресурса [Bucket](../../api-ref/Bucket/index.md) или вызовом gRPC API [BucketService/Update](../../api-ref/grpc/bucket_service.md#Update).

{% endlist %}

{% note info %}

Если в бакете созданы политики доступа, то для корректной работы публичного доступа их также нужно [настроить](./policy.md#apply-policy).

{% endnote %}

## Закрыть публичный доступ {#close-public-access}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. Выберите сервис **{{ objstorage-name }}**.
  1. Нажмите на имя нужного бакета.
  1. Перейдите на вкладку **{{ ui-key.yacloud.storage.bucket.switch_settings }}**.
  1. Включите ограниченный доступ для нужных типов операций.
  1. Нажмите **{{ ui-key.yacloud.storage.bucket.settings.button_save }}**.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для изменения бакета:

      ```bash
      yc storage bucket update --help
      ```

  1. Получите список бакетов в каталоге по умолчанию:

      ```bash
      yc storage bucket list
      ```

      Результат:

      ```text
      +------------------+----------------------+-------------+-----------------------+---------------------+
      |       NAME       |      FOLDER ID       |  MAX SIZE   | DEFAULT STORAGE CLASS |     CREATED AT      |
      +------------------+----------------------+-------------+-----------------------+---------------------+
      | first-bucket     | b1gmit33ngp6******** | 53687091200 | STANDARD              | 2022-12-16 13:58:18 |
      +------------------+----------------------+-------------+-----------------------+---------------------+
      ```

   1. Сохраните имя бакета (столбец `NAME`), к которому нужно закрыть публичный доступ.
   1. Закройте публичный доступ к операциям с бакетом:

      ```bash
      yc storage bucket update \
        --name <имя_бакета> \
        --public-read=false \
        --public-list=false \
        --public-config-read=false
      ```

      Где:
      * `--name` — имя бакета, к которому нужно закрыть публичный доступ.
      * `--public-read` — флаг для управления публичным доступом на чтение объектов в бакете. Для выключения публичного доступа задайте значение `false`.
      * `--public-list` — флаг для управления публичным доступом на просмотр списка объектов в бакете. Для выключения публичного доступа задайте значение `false`.
      * `--public-config-read` — флаг для управления публичным доступом на чтение настроек в бакете. Для выключения публичного доступа задайте значение `false`.

      `name` — обязательный параметр. Остальные параметры необязательны. По умолчанию публичный доступ к бакету выключен.

      Результат:

      ```text
      name: first-bucket
      folder_id: b1gmit33ngp6********
      anonymous_access_flags:
        read: false
        list: false
        config_read: false
      default_storage_class: STANDARD
      versioning: VERSIONING_DISABLED
      max_size: "53687091200"
      acl: {}
      created_at: "2022-12-16T13:58:18.933814Z" 
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  
  {% include [terraform-install](../../../_includes/terraform-install.md) %}


  Чтобы закрыть публичный доступ к операциям с бакетом:

  1. Откройте файл конфигурации {{ TF }} и добавьте блок `anonymous_access_flags` во фрагмент с описанием бакета.

     ```hcl
     resource "yandex_storage_bucket" "log_bucket" {
       access_key = "<идентификатор_статического_ключа>"
       secret_key = "<секретный_ключ>"
       bucket     = "<имя_бакета>"

       anonymous_access_flags {
         read        = false
         list        = false
         config_read = false
       }
     }
     ```

     Где:
     * `access_key` — идентификатор [статического ключа доступа](../../../iam/concepts/authorization/access-key.md).
     * `secret_key` — значение секретного ключа доступа.
     * `bucket` — имя бакета, к которому нужно закрыть публичный доступ.
     * `anonymous_access_flags` — параметры публичного доступа:
       * `read` — публичный доступ на чтение объектов в бакете.
       * `list` — публичный доступ к списку объектов в бакете.
       * `config_read` — публичный доступ к чтению настроек бакета.

     Более подробную информацию о параметрах ресурса `yandex_storage_bucket` в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/storage_bucket#bucket-anonymous-access-flags).

  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет. 

  1. Разверните облачные ресурсы.

     1. Если в конфигурации нет ошибок, выполните команду:

        ```
        terraform apply
        ```

     1. Подтвердите создание ресурсов: введите в терминал слово `yes` и нажмите **Enter**.

        После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

- API {#api}

  Чтобы закрыть публичный доступ к операциям с бакетом, воспользуйтесь методом REST API [update](../../api-ref/Bucket/update.md) для ресурса [Bucket](../../api-ref/Bucket/index.md) или вызовом gRPC API [BucketService/Update](../../api-ref/grpc/bucket_service.md#Update).

{% endlist %}

При закрытии публичного доступа к бакету убедитесь, что [публичной группе](../../../iam/concepts/access-control/public-group.md) `All users` не назначены [роли](../../security/index.md#service-roles) `viewer` или `storage.viewer` и выше на каталог или бакет. В противном случае публичный доступ к бакету сохранится.