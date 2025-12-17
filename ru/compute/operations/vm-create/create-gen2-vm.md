---
title: Как создать виртуальную машину с оборудованием поколения Gen 2
description: Следуя данной инструкции, вы сможете создать виртуальную машину, работающую на виртуализированном оборудовании поколения Gen 2.
---

# Создать виртуальную машину с оборудованием поколения Gen 2

[Виртуальная машина](../../concepts/vm.md) работает на оборудовании того [поколения](../../concepts/hardware-generations.md), которое [закреплено](../../concepts/hardware-generations.md#locking-generations) за носителем, на основе которого создана эта ВМ — [образом](../../concepts/image.md), [снимком](../../concepts/snapshot.md) или [диском](../../concepts/disk.md).

Поэтому, чтобы создать виртуальную машину, работающую на оборудовании поколения `Gen 2`, необходимо предварительно создать носитель, за которым закреплено поколение `Gen 2`, а затем с использованием этого носителя [создать](#create-vm) виртуальную машину.

Чтобы создать виртуальную машину, работающую на виртуализированном оборудовании поколения `Gen 2`:

1. Подготовьте носитель одного из следующих типов: [образ](#create-image), [снимок](#create-snapshot) или [диск](#create-disk).
1. [Создайте виртуальную машину на основе подготовленного носителя](#create-vm).

## Создайте образ с закреплением поколения оборудования Gen 2 {#create-image}

Создать образ виртуальной машины с закреплением поколения оборудования `Gen 2` вы можете как из собственного образа, [предварительно загруженного](#upload-own-image) в {{ yandex-cloud }}, так и на основе [уже имеющихся](#create-image-from-existing-source) в {{ yandex-cloud }} образов, снимков и дисков.

### Загрузите свой образ диска в {{ yandex-cloud }} {#upload-own-image}

Вы можете загрузить в {{ compute-name }} свой собственный образ виртуальной машины с поддержкой UEFI и GPT, чтобы на его основе создавать виртуальные машины, работающие на оборудовании поколения `Gen 2`. Создать образ в {{ compute-name }} можно из подготовленного файла образа, загруженного в [{{ objstorage-full-name }}](../../../storage/index.yaml).

#### Подготовьте файл с образом {#prepare-file}

{% include [image-create-requirements](../../../_includes/compute/image-create-requirements.md) %}

{% include [available-image-format](../../../_includes/compute/available-image-format.md) %}

Инструкции по настройке см. в разделе [{#T}](../image-create/custom-image.md).

#### Загрузите файл образа в {{ objstorage-name }} {#upload-file}

{% include [image-file-upload-to-bucket](../../../_includes/compute/image-file-upload-to-bucket.md) %}

#### Создайте в {{ compute-name }} образ с закреплением поколения оборудования Gen 2 {#create-image-from-link}

Чтобы создать новый образ по ссылке, полученной в [{{ objstorage-name }}](../../../storage/index.yaml):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В консоли управления выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы хотите создать образ.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![layers](../../../_assets/console-icons/layers.svg) **{{ ui-key.yacloud.compute.images_e7RdQ }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.images.button_upload }}** и в открывшемся окне:

      1. В поле **{{ ui-key.yacloud.common.name }}** задайте имя образа. Требования к имени:

          {% include [name-format](../../../_includes/name-format.md) %}

      1. (Опционально) В полях **{{ ui-key.yacloud.common.description }}** и **{{ ui-key.yacloud.component.label-set.label_labels }}** добавьте произвольное описание и [метки](../../../resource-manager/concepts/labels.md) создаваемого образа.
      1. В поле **{{ ui-key.yacloud.compute.images.popup-upload_field_url }}** вставьте ссылку на файл с образом, полученную ранее в {{ objstorage-name }}.
      1. В поле **{{ ui-key.yacloud.compute.hardware-generation_1iEpT }}** выберите [поколение оборудования](../../concepts/hardware-generations.md) `{{ ui-key.yacloud.compute.hardware-gen2-title_a2Gfq }}`.
      1. Чтобы включить [оптимизацию](../../concepts/image.md#images-optimized-for-deployment) образа для развертывания, раскройте секцию **{{ ui-key.yacloud.compute.section_additional_7yvYG }}** и включите опцию **{{ ui-key.yacloud.compute.images.popup-upload_field_pooled }}**.
      1. Нажмите кнопку **{{ ui-key.yacloud.common.button_upload }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды {{ yandex-cloud }} CLI для создания образа:

      ```bash
      yc compute image create --help
      ```
  1. Чтобы создать по ссылке новый образ с закреплением за ним поколения оборудования `Gen 2`, выполните команду:

      ```bash
      yc compute image create \
        --name <имя_образа> \
        --source-uri "<URL_образа>" \
        --hardware-generation-id generation2 \
        --pooled
      ```

      Где:
      * `--name` — имя, которое будет присвоено образу. Требования к имени:

          {% include [name-format](../../../_includes/name-format.md) %}
      
      * `--source-uri` — ссылка на образ, полученная в {{ objstorage-name }}.
      * `--pooled` — параметр, позволяющий включить [оптимизацию](../../concepts/image.md#images-optimized-for-deployment) образа для развертывания. Необязательный параметр. По умолчанию оптимизация отключена.

      Результат:

      ```bash
      done (12s)
      id: fd86a13e6ro9********
      folder_id: b1gt6g8ht345********
      created_at: "2025-12-05T16:26:46Z"
      name: my-own-gen2-image
      storage_size: "1891631104"
      min_disk_size: "1891631104"
      status: READY
      os:
        type: LINUX
      hardware_generation:
        generation2_features: {}
      ```

  Подробнее о команде `yc compute image create` читайте в [справочнике CLI](../../../cli/cli-ref/compute/cli-ref/image/create.md).

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Чтобы создать образ:
  1. Опишите в конфигурационном файле параметры ресурса `yandex_compute_image`.

      Пример структуры конфигурационного файла:

      ```hcl
      resource "yandex_compute_image" "image-1" {
        name                 = "<имя_образа>"
        source_url           = "<ссылка_на_образ>"
        pooled               = "true|false"

        hardware_generation {
          generation2_features {}
        }
      }
      ```

      Где:
      * `name` — имя, которое будет присвоено образу. Требования к имени:
      
          {% include [name-format](../../../_includes/name-format.md) %}

      * `source_url` — ссылка на образ в {{ objstorage-name }}.
      * `pooled` — параметр, позволяющий включить [оптимизацию](../../concepts/image.md#images-optimized-for-deployment) образа для развертывания. Возможные значения:
      
          * `true` — оптимизация включена.
          * `false` — оптимизация выключена.
          
          Необязательный параметр. По умолчанию оптимизация выключена.

      Подробную информацию о параметрах ресурса `yandex_compute_image` см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/compute_image).
  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления]({{ link-console-main }}) или с помощью команды CLI:

      ```bash
      yc compute image list
      ```

- API {#api}

  Воспользуйтесь методом REST API [create](../../api-ref/Image/create.md) для ресурса [Image](../../api-ref/Image/index.md) или вызовом gRPC API [ImageService/Create](../../api-ref/grpc/Image/create.md).

  Например, чтобы создать образ с закреплением поколения оборудования `Gen 2` с помощью REST API:

  1. Установите утилиту [cURL](https://curl.haxx.se).
  1. Получите [{{ iam-short-name }}-токен](../../../iam/concepts/authorization/iam-token.md), используемый для аутентификации в API:
      * [Инструкция](../../../iam/operations/iam-token/create.md) для пользователя с аккаунтом на Яндексе.
      * [Инструкция](../../../iam/operations/iam-token/create-for-sa.md) для [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md).
      * [Инструкция](../../../iam/operations/iam-token/create-for-federation.md) для федеративного аккаунта.
      * [Инструкция](../../../iam/operations/iam-token/create-for-local.md) для локального аккаунта.
  1. Для удобства выполнения запроса сохраните полученный IAM-токен в переменную окружения `IAM_TOKEN`:

      ```bash
      export IAM_TOKEN="<содержимое_IAM-токена>"
      ```
  1. Создайте файл с телом запроса на создание образа (например, `body.json`) и добавьте в него следующий код:

      **body.json**

      ```json
      {
        "folderId": "<идентификатор_каталога>",
        "name": "<имя_образа>",
        "uri": "<ссылка_на_загруженный_образ>",
        "pooled": "true|false",
        "hardwareGeneration": {
          "generation2Features": {}
        }
      }
      ```

      Где:

      * `folderId` — [идентификатор](../../../resource-manager/operations/folder/get-id.md) каталога, в котором создается образ.
      * `name` — имя образа. Требования к имени:

          {% include [name-format](../../../_includes/name-format.md) %}

      * `uri` — ссылка на образ в {{ objstorage-name }}.
      * `pooled` — параметр, позволяющий включить [оптимизацию](../../concepts/image.md#images-optimized-for-deployment) образа для развертывания. Возможные значения:
      
          * `true` — оптимизация включена.
          * `false` — оптимизация выключена.

          Необязательный параметр. По умолчанию оптимизация выключена.

  1. Выполните HTTP-запрос:

      ```bash
      curl \
        --request POST \
        --header "Content-Type: application/json" \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
        --data '@body.json' \
        https://compute.{{ api-host }}/compute/v1/images
      ```

      Результат:

      ```text
      {
      "done": false,
      "metadata": {
        "@type": "type.googleapis.com/yandex.cloud.compute.v1.CreateImageMetadata",
        "imageId": "fd8g5p4hllq8********"
      },
      "id": "fd8m1tfm92kr********",
      "description": "Create image",
      "createdAt": "2025-12-05T16:41:54.452564354Z",
      "createdBy": "ajeol2afu1js********",
      "modifiedAt": "2025-12-05T16:41:54.452564354Z"
      }
      ```

{% endlist %}

После создания образа вы можете [удалить](../../../storage/operations/objects/delete.md) исходный файл из бакета.

### Создайте образ диска с закреплением поколения оборудования Gen 2 из другого образа, снимка или диска {#create-image-from-existing-source}

По умолчанию при создании образа за ним закрепляется то [поколение оборудования](../../concepts/hardware-generations.md), которое [закреплено](../../concepts/hardware-generations.md#locking-generations) за исходным образом, снимком или диском, на основе которых создается этот образ. При этом вы можете явно задать для образа поколение оборудования, отличное от поколения, закрепленного за исходными образом, снимком или диском.

За [публичными образами](../../concepts/image.md#public), доступными для установки на ВМ в [{{ marketplace-full-name }}](/marketplace), по умолчанию закреплено поколение оборудования `Gen 1.1` или `Gen 1.2`. В то же время некоторые публичные образы (например, образы с операционной системой Linux [Ubuntu 24.04 LTS](/marketplace/products/yc/ubuntu-24-04-lts)) поддерживают оборудование поколения `Gen 2` с режимом загрузки [UEFI](https://ru.wikipedia.org/wiki/Extensible_Firmware_Interface) и таблицей разделов [GPT](https://ru.wikipedia.org/wiki/Таблица_разделов_GUID), и из таких образов вы можете создать диск или собственный образ с закрепленным поколением оборудования `Gen 2`. Другие публичные образы не поддерживают UEFI-загрузку и поэтому создать на их основе виртуальную машину, работающую на оборудовании поколения `Gen 2`, нельзя.

{% note info %}

Создать новый образ с закреплением поколения оборудования `Gen 2` из [публичного образа](../../concepts/image.md#public) в [{{ marketplace-full-name }}](/marketplace) можно только с помощью [{{ yandex-cloud }} CLI](../../../cli/cli-ref/compute/cli-ref/image/create.md), [{{ TF }}]({{ tf-provider-resources-link }}/compute_image) или [API](../../api-ref/Image/create.md).

{% endnote %}

Чтобы создать образ из существующего [образа](../../concepts/image.md), [снимка](../../concepts/snapshot.md) или [диска](../../concepts/disk.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В консоли управления выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать образ.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. В зависимости от того, из какого источника вы хотите создать новый образ, на панели слева выберите ![archive](../../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.compute.storage_uisyT }}**, ![picture](../../../_assets/console-icons/picture.svg) **{{ ui-key.yacloud.compute.snapshots_81jHX }}** или ![layers](../../../_assets/console-icons/layers.svg) **{{ ui-key.yacloud.compute.images_e7RdQ }}**.
  1. В зависимости от выбранного типа источника в открывшемся списке в строке с нужным образом, снимком или диском нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![layers](../../../_assets/console-icons/layers.svg) **{{ ui-key.yacloud.compute.disks.button_action-image }}**. В открывшемся окне:

      1. В поле **{{ ui-key.yacloud.common.name }}** задайте имя создаваемого образа. Требования к имени:

          {% include [name-format](../../../_includes/name-format.md) %}

      1. (Опционально) В полях **{{ ui-key.yacloud.common.description }}** и **{{ ui-key.yacloud.component.label-set.label_labels }}** добавьте произвольное описание и [метки](../../../resource-manager/concepts/labels.md) образа.
      1. Разверните секцию **{{ ui-key.yacloud.compute.section_additional_7yvYG }}** и в поле **{{ ui-key.yacloud.compute.hardware-generation_1iEpT }}** выберите `{{ ui-key.yacloud.compute.hardware-gen2-title_a2Gfq }}`.

          {% include [gen2-image-source-uefi-support-alert](../../../_includes/compute/gen2-image-source-uefi-support-alert.md) %}

      1. Чтобы включить [оптимизацию](../../concepts/image.md#images-optimized-for-deployment) образа для развертывания, включите опцию **{{ ui-key.yacloud.compute.images.popup-upload_field_pooled }}**.
      1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  {% include [gen2-image-source-uefi-support-alert](../../../_includes/compute/gen2-image-source-uefi-support-alert.md) %}

  1. Посмотрите описание команды {{ yandex-cloud }} CLI для создания образа:

      ```bash
      yc compute image create --help
      ```

  1. Чтобы создать новый образ с закреплением поколения оборудования `Gen 2` из существующего [образа](../../concepts/image.md), [снимка](../../concepts/snapshot.md) или [диска](../../concepts/disk.md), выполните команду:

      ```bash
      yc compute image create \
        --name <имя_образа> \
        --source-image-id <идентификатор_образа-источника> \
        --source-snapshot-id <идентификатор_снимка-источника> \
        --source-disk-id <идентификатор_диска-источника> \
        --hardware-generation-id generation2 \
        --pooled
      ```

      Где:
      * `--name` — имя, которое будет присвоено образу. Требования к имени:

          {% include [name-format](../../../_includes/name-format.md) %}

      * Выбор источника для образа:

          * `--source-image-id` — идентификатор образа-источника. Вместо идентификатора вы можете передать в команду имя образа-источника в параметре `--source-image-name`.
          * `--source-snapshot-id` — идентификатор снимка-источника. Вместо идентификатора вы можете передать в команду имя снимка-источника в параметре `--source-snapshot-name`.
          * `--source-disk-id` — идентификатор диска-источника. Вместо идентификатора вы можете передать в команду имя диска-источника в параметре `--source-disk-name`.

          {% note info %}

          Параметры `--source-image-id`, `--source-image-name`, `--source-snapshot-id`, `--source-snapshot-name`, `--source-disk-id` и `--source-disk-name` — взаимоисключающие. В команде вы можете указать только один из них.

          {% endnote %}

      * `--pooled` — параметр, позволяющий включить [оптимизацию](../../concepts/image.md#images-optimized-for-deployment) образа для развертывания. Необязательный параметр. По умолчанию оптимизация отключена.

      Результат:

      ```text
      done (9s)
      id: fd86kup8c7pa********
      folder_id: b1gt6g8ht345********
      created_at: "2025-12-05T06:57:09Z"
      name: my-sample-gen2-image
      storage_size: "9877585920"
      min_disk_size: "21474836480"
      product_ids:
        - f2ercusam4no********
      status: READY
      os:
        type: LINUX
      hardware_generation:
        generation2_features: {}
      ```

  Подробнее о команде `yc compute image create` читайте в [справочнике CLI](../../../cli/cli-ref/compute/cli-ref/image/create.md).

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле параметры ресурса `yandex_compute_image`.

      Пример структуры конфигурационного файла:

      ```hcl
      resource "yandex_compute_image" "image-1" {
        name                 = "<имя_образа>"
        source_image         = "<идентификатор_образа-источника>"
        source_snapshot      = "<идентификатор_снимка-источника>"
        source_disk          = "<идентификатор_диска-источника>"
        pooled               = "true|false"

        hardware_generation {
          generation2_features {}
        }
      }
      ```

      {% include [gen2-image-source-uefi-support-alert](../../../_includes/compute/gen2-image-source-uefi-support-alert.md) %}

      Где:
      * `name` — имя, которое будет присвоено образу. Требования к имени:
      
          {% include [name-format](../../../_includes/name-format.md) %}

      * Выбор источника для образа:

          * `source_image` — идентификатор образа-источника.
          * `source_snapshot` — идентификатор снимка-источника.
          * `source_disk` — идентификатор диска-источника.

          {% note info %}

          Параметры `source_image`, `source_snapshot` и `source_disk` — взаимоисключающие. В файле конфигурации вы можете указать только один из них.

          {% endnote %}

      * `pooled` — параметр, позволяющий включить [оптимизацию](../../concepts/image.md#images-optimized-for-deployment) образа для развертывания. Возможные значения:
      
          * `true` — оптимизация включена.
          * `false` — оптимизация выключена.
          
          Необязательный параметр. По умолчанию оптимизация выключена.

          Подробную информацию о параметрах ресурса `yandex_compute_image` см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/compute_image).
          
  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления]({{ link-console-main }}) или с помощью команды CLI:

      ```bash
      yc compute image list
      ```

- API {#api}

  Воспользуйтесь методом REST API [create](../../api-ref/Image/create.md) для ресурса [Image](../../api-ref/Image/index.md) или вызовом gRPC API [ImageService/Create](../../api-ref/grpc/Image/create.md).

  Например, чтобы создать образ с закреплением поколения оборудования `Gen 2` с помощью REST API:

  1. Установите утилиту [cURL](https://curl.haxx.se).
  1. Получите [{{ iam-short-name }}-токен](../../../iam/concepts/authorization/iam-token.md), используемый для аутентификации в API:
      * [Инструкция](../../../iam/operations/iam-token/create.md) для пользователя с аккаунтом на Яндексе.
      * [Инструкция](../../../iam/operations/iam-token/create-for-sa.md) для [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md).
      * [Инструкция](../../../iam/operations/iam-token/create-for-federation.md) для федеративного аккаунта.
      * [Инструкция](../../../iam/operations/iam-token/create-for-local.md) для локального аккаунта.
  1. Для удобства выполнения запроса сохраните полученный IAM-токен в переменную окружения `IAM_TOKEN`:

      ```bash
      export IAM_TOKEN="<содержимое_IAM-токена>"
      ```
  1. Создайте файл с телом запроса на создание образа (например, `body.json`) и добавьте в него следующий код:

      **body.json**

      ```json
      {
        "folderId": "<идентификатор_каталога>",
        "name": "<имя_образа>",
        "imageId": "<идентификатор_образа-источника>",
        "snapshotId": "<идентификатор_снимка-источника>",
        "diskId": "<идентификатор_диска-источника>",
        "pooled": "true|false",
        "hardwareGeneration": {
          "generation2Features": {}
        }
      }
      ```

      Где:

      * `folderId` — [идентификатор](../../../resource-manager/operations/folder/get-id.md) каталога, в котором создается образ.
      * `name` — имя образа. Требования к имени:

          {% include [name-format](../../../_includes/name-format.md) %}

      {% include [gen2-image-source-uefi-support-alert](../../../_includes/compute/gen2-image-source-uefi-support-alert.md) %}

      * Выбор источника для образа:

          * `imageId` — идентификатор образа-источника.
          * `snapshotId` — идентификатор снимка-источника.
          * `diskId` — идентификатор диска-источника.

          {% note info %}

          Поля `imageId`, `snapshotId` и `diskId` — взаимоисключающие. В запросе вы можете указать только одно из них.

          {% endnote %}

      * `pooled` — параметр, позволяющий включить [оптимизацию](../../concepts/image.md#images-optimized-for-deployment) образа для развертывания. Возможные значения:
      
          * `true` — оптимизация включена.
          * `false` — оптимизация выключена.

          Необязательный параметр. По умолчанию оптимизация выключена.

  1. Выполните HTTP-запрос:

      ```bash
      curl \
        --request POST \
        --header "Content-Type: application/json" \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
        --data '@body.json' \
        https://compute.{{ api-host }}/compute/v1/images
      ```

      Результат:

      ```text
      {
      "done": false,
      "metadata": {
        "@type": "type.googleapis.com/yandex.cloud.compute.v1.CreateImageMetadata",
        "imageId": "fd8j3jind4ij********"
      },
      "id": "fd8a7eged70b********",
      "description": "Create image",
      "createdAt": "2025-12-05T08:51:44.937021154Z",
      "createdBy": "ajeol2afu1js********",
      "modifiedAt": "2025-12-05T08:51:44.937021154Z"
      }
      ```

{% endlist %}

В результате будет создан образ, к которому привязано [поколение](../../concepts/hardware-generations.md) виртуализированного оборудования `Gen 2`.

## Создайте снимок диска с закреплением поколения оборудования Gen 2 {#create-snapshot}

Вы можете создать снимок загрузочного диска имеющейся виртуальной машины, работающей на виртуализированном оборудовании поколения `Gen 1.1` или `Gen 1.2`, с закреплением за этим снимком поколения оборудования `Gen 2`.

### Подготовьте диск к созданию снимка {#prepare-for-making-snapshot}

{% include [prepare-snapshots](../../../_includes/compute/prepare-snapshots.md) %}

### Создайте снимок {#create-snapshot-operation}

Чтобы создать снимок диска с закреплением поколения оборудования `Gen 2`:

{% note info %}

Закрепить за снимком поколение, отличное от поколения, которое закреплено за исходным диском, можно только с помощью [{{ yandex-cloud }} CLI](../../../cli/cli-ref/compute/cli-ref/snapshot/create.md), [{{ TF }}]({{ tf-provider-resources-link }}/compute_snapshot) и [API](../../api-ref/Snapshot/create.md).

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания снимков:

      ```bash
      yc compute snapshot create --help
      ```

  1. Создайте снимок в каталоге по умолчанию:

      ```bash
      yc compute snapshot create \
        --name <имя_снимка> \
        --disk-id <идентификатор_диска-источника> \
        --hardware-generation-id generation2
      ```

      Где:
      * `--name` — имя создаваемого снимка. Требования к имени:

          {% include [name-format](../../../_includes/name-format.md) %}

      * `--disk-id` — идентификатор диска, для которого вы создаете снимок. Вместо идентификатора вы можете передать в команду имя диска в параметре `--disk-name`.

      Результат:

      ```text
      done (18s)
      id: fd8jnmpan5ff********
      folder_id: b1gt6g8ht345********
      created_at: "2025-12-05T14:10:15Z"
      name: my-gen2-snapshot
      storage_size: "3632267264"
      disk_size: "21474836480"
      product_ids:
        - f2ebiogvi127********
      status: READY
      source_disk_id: epd89t47vnhd********
      hardware_generation:
        generation2_features: {}
      ```

  Подробнее о команде `yc compute snapshot create` читайте в [справочнике CLI](../../../cli/cli-ref/compute/cli-ref/snapshot/create.md).

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле параметры ресурса `yandex_compute_snapshot`.

      Пример структуры конфигурационного файла:
      
      ```hcl
      resource "yandex_compute_snapshot" "snapshot-1" {
        name                 = "<имя_снимка>"
        source_disk_id       = "<идентификатор_диска>"
        hardware_generation {
          generation2_features {}
        }
      }
      ```

      Где:
      * `name` — имя, которое будет присвоено снимку. Требования к имени:
      
          {% include [name-format](../../../_includes/name-format.md) %}

      * `source_disk_id` — идентификатор диска, для которого вы создаете снимок.

      Подробную информацию о параметрах ресурса `yandex_compute_snapshot` см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/compute_snapshot).
          
  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления]({{ link-console-main }}) или с помощью команды CLI:

      ```bash
      yc compute snapshot list
      ```

- API {#api}

  Воспользуйтесь методом REST API [create](../../api-ref/Snapshot/create.md) для ресурса [Snapshot](../../api-ref/Snapshot/index.md) или вызовом gRPC API [SnapshotService/Create](../../api-ref/grpc/Snapshot/create.md).

  Например, чтобы создать снимок с закреплением поколения оборудования `Gen 2` с помощью REST API:

  1. Установите утилиту [cURL](https://curl.haxx.se).
  1. Получите [{{ iam-short-name }}-токен](../../../iam/concepts/authorization/iam-token.md), используемый для аутентификации в API:
      * [Инструкция](../../../iam/operations/iam-token/create.md) для пользователя с аккаунтом на Яндексе.
      * [Инструкция](../../../iam/operations/iam-token/create-for-sa.md) для [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md).
      * [Инструкция](../../../iam/operations/iam-token/create-for-federation.md) для федеративного аккаунта.
      * [Инструкция](../../../iam/operations/iam-token/create-for-local.md) для локального аккаунта.
  1. Для удобства выполнения запроса сохраните полученный IAM-токен в переменную окружения `IAM_TOKEN`:

      ```bash
      export IAM_TOKEN="<содержимое_IAM-токена>"
      ```
  1. Создайте файл с телом запроса на создание снимка (например, `body.json`) и добавьте в него следующий код:

      **body.json**

      ```json
      {
        "folderId": "<идентификатор_каталога>",
        "name": "<имя_снимка>",
        "diskId": "<идентификатор_диска>",
        "hardwareGeneration": {
          "generation2Features": {}
        }
      }
      ```

      Где:

      * `folderId` — [идентификатор](../../../resource-manager/operations/folder/get-id.md) каталога, в котором создается снимок.
      * `name` — имя создаваемого снимка. Требования к имени:

          {% include [name-format](../../../_includes/name-format.md) %}

      * `diskId` — идентификатор [диска](../../concepts/disk.md), для которого делается снимок.

  1. Выполните HTTP-запрос:

      ```bash
      curl \
        --request POST \
        --header "Content-Type: application/json" \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
        --data '@body.json' \
        https://compute.{{ api-host }}/compute/v1/snapshots
      ```

      Результат:

      ```text
      {
      "done": false,
      "metadata": {
        "@type": "type.googleapis.com/yandex.cloud.compute.v1.CreateSnapshotMetadata",
        "snapshotId": "fd8apannhdo9********",
        "diskId": "epd89t47vnhd********"
      },
      "id": "epd473ndlm58********",
      "description": "Create snapshot",
      "createdAt": "2025-12-05T14:43:02.803028670Z",
      "createdBy": "ajeol2afu1js********",
      "modifiedAt": "2025-12-05T14:43:02.803028670Z"
      }
      ```

{% endlist %}

В результате будет создан снимок диска, к которому привязано [поколение](../../concepts/hardware-generations.md) виртуализированного оборудования `Gen 2`.


## Создайте диск с закреплением поколения оборудования Gen 2 {#create-disk}

По умолчанию при создании диска за ним закрепляется то [поколение оборудования](../../concepts/hardware-generations.md), которое [закреплено](../../concepts/hardware-generations.md#locking-generations) за исходным образом или снимком, на основе которых создается этот диск. При этом вы можете явно задать для диска поколение оборудования, отличное от поколения, закрепленного за исходными образом или снимком.

Чтобы создать диск с закреплением поколения оборудования `Gen 2`:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В консоли управления выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать образ.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![archive](../../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.compute.storage_uisyT }}** и нажмите кнопку **{{ ui-key.yacloud.compute.storage.button_create-disk }}**. В открывшемся окне:

      1. В поле **{{ ui-key.yacloud.compute.instances.create-disk.field_name }}** задайте имя диска. Требования к имени:

          {% include [name-format](../../../_includes/name-format.md) %}
      1. В поле **{{ ui-key.yacloud.compute.disk-form.field_zone }}** выберите [зону доступности](../../../overview/concepts/geo-scope.md), в которой вы создаете диск.
      1. В зависимости от источника, на основе которого вы создаете диск, в поле **{{ ui-key.yacloud.compute.instances.create-disk.field_source }}** выберите `{{ ui-key.yacloud.compute.instances.create-disk.value_source-snapshot }}` или `{{ ui-key.yacloud.compute.instances.create-disk.value_source-image }}` и в появившемся списке выберите нужный снимок или образ.
      1. В поле **{{ ui-key.yacloud.compute.disk-form.field_type }}** выберите [тип](../../concepts/disk.md#disks-types) диска. Доступные значения:

          * `{{ ui-key.yacloud.compute.value_disk-type-network-ssd_4Mmub }}` — быстрый сетевой диск, сетевое блочное хранилище на SSD-накопителе.
          * `{{ ui-key.yacloud.compute.value_disk-type-network-hdd_cw9XD }}` — стандартный сетевой диск, сетевое блочное хранилище на HDD-накопителе.
          * `{{ ui-key.yacloud.compute.value_disk-type-network-ssd-io-m3_pPfnG }}` — сетевой диск с повышенной производительностью, обеспечивающий избыточность.
          * `{{ ui-key.yacloud.compute.value_disk-type-network-ssd-nonreplicated_d7W56 }}` — сетевой диск с повышенной производительностью без избыточности.
      1. В поле **{{ ui-key.yacloud.compute.disk-form.field_size }}** задайте нужный размер диска.
      1. Разверните секцию **{{ ui-key.yacloud.compute.section_additional_7yvYG }}** и в поле **{{ ui-key.yacloud.compute.hardware-generation_1iEpT }}** выберите `{{ ui-key.yacloud.compute.hardware-gen2-title_a2Gfq }}`.
      1. Нажмите кнопку **{{ ui-key.yacloud.compute.disks.create.button_create }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды {{ yandex-cloud }} CLI для создания диска:

      ```bash
      yc compute disk create --help
      ```
  1. Создайте диск с закрепленным поколением оборудования `Gen 2` в каталоге по умолчанию:

      ```
      yc compute disk create \
        --name <имя_диска> \
        --zone <зона_доступности> \
        --type <тип_диска> \
        --size <размер_диска> \
        --source-image-id <идентификатор_образа-источника> \
        --source-snapshot-id <идентификатор_снимка-источника> \
        --hardware-generation-id generation2
      ```

      Где:
      * `--name` — имя диска. Требования к имени:

          {% include [name-format](../../../_includes/name-format.md) %}

      * `--zone` — [зона доступности](../../../overview/concepts/geo-scope.md), в которой создается диск.
      * `--type` — [тип](../../concepts/disk.md#disks-types) диска. Доступные значения:

          * `network-ssd` — быстрый сетевой диск, сетевое блочное хранилище на SSD-накопителе.
          * `network-hdd` — стандартный сетевой диск, сетевое блочное хранилище на HDD-накопителе.
          * `network-ssd-nonreplicated` — сетевой диск с повышенной производительностью без избыточности.
          * `network-ssd-io-m3` — сетевой диск с повышенной производительностью, обеспечивающий избыточность.
      * `--size` — размер диска в гигабайтах. Например, чтобы создать диск размером 32 ГБ, укажите `--size 32`.

      * Выбор источника для диска:

          * `--source-image-id` — идентификатор [образа](../../concepts/image.md), на основе которого создается диск. Вместо идентификатора образа вы можете передать его имя в параметре `--source-image-name`.
          * `--source-snapshot-id` — идентификатор [снимка](../../concepts/snapshot.md), на основе которого создается диск. Вместо идентификатора снимка вы можете передать его имя в параметре `--source-snapshot-name`.

          {% note info %}

          Параметры `--source-image-id`, `--source-image-name`, `--source-snapshot-id` и `--source-snapshot-name` — взаимоисключающие. В команде вы можете указать только один из них.

          {% endnote %}

      Результат:

      ```text
      done (9s)
      id: fv45fajiusvq********
      folder_id: b1gt6g8ht345********
      created_at: "2025-12-04T08:15:45Z"
      name: ununtu2404-gen2-disk
      type_id: network-hdd
      zone_id: {{ region-id }}-a
      size: "34359738368"
      block_size: "4096"
      product_ids:
        - f2ebiogvi127********
      status: READY
      source_image_id: fd8bnguet48k********
      disk_placement_policy: {}
      hardware_generation:
        generation2_features: {}
      ```

  Подробнее о команде `yc compute disk create` читайте в [справочнике CLI](../../../cli/cli-ref/compute/cli-ref/disk/create.md).

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле параметры ресурса `yandex_compute_disk`.

      Пример структуры конфигурационного файла:

      ```hcl
      resource "yandex_compute_disk" "my-disk" {
        name            = "<имя_диска>"
        type            = "<тип_диска>"
        zone            = "<зона_доступности>"
        size            = <размер_диска>
        image_id        = "<идентификатор_образа-источника>"
        snapshot_id     = "<идентификатор_снимка-источника>"

        hardware_generation {
          generation2_features {}
        }
      }
      ```

      Где:
      * `name` — имя, которое будет присвоено диску. Требования к имени:
      
          {% include [name-format](../../../_includes/name-format.md) %}

      * `type` — [тип](../../concepts/disk.md#disks-types) диска. Доступные значения:

          * `network-ssd` — быстрый сетевой диск, сетевое блочное хранилище на SSD-накопителе.
          * `network-hdd` — стандартный сетевой диск, сетевое блочное хранилище на HDD-накопителе.
          * `network-ssd-nonreplicated` — сетевой диск с повышенной производительностью без избыточности.
          * `network-ssd-io-m3` — сетевой диск с повышенной производительностью, обеспечивающий избыточность.

      * `zone` — [зона доступности](../../../overview/concepts/geo-scope.md), в которой создается диск.
      * `size` — размер диска в ГБ.
      * Выбор источника для диска:

          * `image_id` — идентификатор [образа](../../concepts/image.md), на основе которого создается диск.
          * `snapshot_id` — идентификатор [снимка](../../concepts/snapshot.md), на основе которого создается диск.

          {% note info %}

          Параметры `image_id` и `snapshot_id` — взаимоисключающие. В файле конфигурации вы можете указать только один из них.

          {% endnote %}

          Подробную информацию о параметрах ресурса `yandex_compute_disk` см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/compute_disk).
          
  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления]({{ link-console-main }}) или с помощью команды CLI:

      ```bash
      yc compute disk list
      ```

- API {#api}

  Воспользуйтесь методом REST API [create](../../api-ref/Disk/create.md) для ресурса [Disk](../../api-ref/Disk/index.md) или вызовом gRPC API [DiskService/Create](../../api-ref/grpc/Disk/create.md).

  Например, чтобы создать диск с закреплением поколения оборудования `Gen 2` с помощью REST API:

  1. Установите утилиту [cURL](https://curl.haxx.se).
  1. Получите [{{ iam-short-name }}-токен](../../../iam/concepts/authorization/iam-token.md), используемый для аутентификации в API:
      * [Инструкция](../../../iam/operations/iam-token/create.md) для пользователя с аккаунтом на Яндексе.
      * [Инструкция](../../../iam/operations/iam-token/create-for-sa.md) для [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md).
      * [Инструкция](../../../iam/operations/iam-token/create-for-federation.md) для федеративного аккаунта.
      * [Инструкция](../../../iam/operations/iam-token/create-for-local.md) для локального аккаунта.
  1. Для удобства выполнения запроса сохраните полученный IAM-токен в переменную окружения `IAM_TOKEN`:

      ```bash
      export IAM_TOKEN="<содержимое_IAM-токена>"
      ```
  1. Создайте файл с телом запроса на создание диска (например, `body.json`) и добавьте в него следующий код:

      **body.json**

      ```json
      {
        "folderId": "<идентификатор_каталога>",
        "name": "<имя_диска>",
        "typeId": "<тип_диска>",
        "zoneId": "<зона_доступности>",
        "size": "<размер_диска_в_байтах>",
        "imageId": "<идентификатор_образа-источника>",
        "snapshotId": "<идентификатор_снимка-источника>",
        "hardwareGeneration": {
          "generation2Features": {}
        }
      }
      ```

      Где:

      * `folderId` — [идентификатор](../../../resource-manager/operations/folder/get-id.md) каталога, в котором создается диск.
      * `name` — имя диска. Требования к имени:

          {% include [name-format](../../../_includes/name-format.md) %}

      * `typeId` — [тип](../../concepts/disk.md#disks-types) диска. Доступные значения:

          * `network-ssd` — быстрый сетевой диск, сетевое блочное хранилище на SSD-накопителе.
          * `network-hdd` — стандартный сетевой диск, сетевое блочное хранилище на HDD-накопителе.
          * `network-ssd-nonreplicated` — сетевой диск с повышенной производительностью без избыточности.
          * `network-ssd-io-m3` — сетевой диск с повышенной производительностью, обеспечивающий избыточность.

      * `zoneId` — [зона доступности](../../../overview/concepts/geo-scope.md), в которой создается диск.
      * `size` — размер диска в байтах.
      * Выбор источника для диска:

          * `imageId` — идентификатор [образа](../../concepts/image.md), на основе которого создается диск.
          * `snapshotId` — идентификатор [снимка](../../concepts/snapshot.md), на основе которого создается диск.

          {% note info %}

          Поля `imageId` и `snapshotId` — взаимоисключающие. В запросе вы можете указать только одно из них.

          {% endnote %}

  1. Выполните HTTP-запрос:

      ```bash
      curl \
        --request POST \
        --header "Content-Type: application/json" \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
        --data '@body.json' \
        https://compute.{{ api-host }}/compute/v1/disks
      ```

      Результат:

      ```text
      {
      "done": false,
      "metadata": {
        "@type": "type.googleapis.com/yandex.cloud.compute.v1.CreateDiskMetadata",
        "diskId": "fv4lmsdol4fi********"
      },
      "id": "fv4pt28gishg********",
      "description": "Create disk",
      "createdAt": "2025-12-04T09:19:00.743099068Z",
      "createdBy": "ajeol2afu1js********",
      "modifiedAt": "2025-12-04T09:19:00.743099068Z"
      }
      ```

{% endlist %}

В результате будет создан диск, к которому привязано [поколение](../../concepts/hardware-generations.md) виртуализированного оборудования `Gen 2`.

## Создайте виртуальную машину, работающую на оборудовании поколения Gen 2 {#create-vm}

{% note info %}

Прежде чем создавать ВМ, [подготовьте](../vm-connect/ssh.md#creating-ssh-keys) пару ключей (открытый и закрытый) для [SSH-доступа](../../../glossary/ssh-keygen.md) на ВМ.

{% endnote %}

Используйте подготовленный ранее [образ](#create-image), [снимок](#create-snapshot) или [диск](#create-disk) с закрепленным поколением оборудования `Gen 2`, чтобы создать виртуальную машину, работающую на оборудовании этого поколения:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создана ВМ.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![server](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}** и нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}** выберите [зону доступности](../../../overview/concepts/geo-scope.md), в которой будет находиться ВМ.

      {% note info %}

      Если вы создаете ВМ, подключая к ней готовый загрузочный диск, убедитесь, что ваш диск находится в той же зоне доступности, в которой вы собираетесь создать ВМ.

      {% endnote %}

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** перейдите на вкладку **{{ ui-key.yacloud.compute.instances.create.image_value_custom_new }}** и нажмите кнопку **{{ ui-key.yacloud.common.select }}**. В открывшемся окне:

      * Чтобы создать ВМ из [подготовленного ранее снимка](#create-snapshot):
      
          1. Убедитесь, что в верхней части экрана выбрана опция `{{ ui-key.yacloud.compute.component.instance-storage-dialog.value_disk-attach-type-create-new }}`, а в поле **{{ ui-key.yacloud.compute.instances.create-disk.field_source }}** выбрана опция `{{ ui-key.yacloud.compute.instances.create-disk.value_source-snapshot }}`.
          1. В списке снимков выберите нужный. При необходимости воспользуйтесь фильтром.
          1. В поле **{{ ui-key.yacloud.compute.instances.create-disk.field_name }}** задайте имя загрузочного диска ВМ. Требования к имени:

              {% include [name-format](../../../_includes/name-format.md) %}
          1. В полях **{{ ui-key.yacloud.compute.disk-form.field_type }}** и **{{ ui-key.yacloud.compute.disk-form.field_size }}** выберите нужные [тип](../../concepts/disk.md#disks-types) и размер создаваемого диска.
          1. (Опционально) В поле **{{ ui-key.yacloud.compute.field_additional_vt356 }}** включите опцию **{{ ui-key.yacloud.compute.field_disk-autodelete_qZn4x }}**, чтобы включить автоудаление создаваемого загрузочного диска вместе с ВМ.
          1. Нажмите кнопку **{{ ui-key.yacloud.compute.component.instance-storage-dialog.button_add-disk }}**.
      * Чтобы создать ВМ из [подготовленного ранее образа](#create-image):
      
          1. Убедитесь, что в верхней части экрана выбрана опция `{{ ui-key.yacloud.compute.component.instance-storage-dialog.value_disk-attach-type-create-new }}`.
          1. В поле **{{ ui-key.yacloud.compute.instances.create-disk.field_source }}** выберите опцию `{{ ui-key.yacloud.compute.instances.create-disk.value_source-image }}`.
          1. В списке образов выберите нужный. При необходимости воспользуйтесь фильтром.
          1. В поле **{{ ui-key.yacloud.compute.instances.create-disk.field_name }}** задайте имя загрузочного диска ВМ. Требования к имени:

              {% include [name-format](../../../_includes/name-format.md) %}
          1. В полях **{{ ui-key.yacloud.compute.disk-form.field_type }}** и **{{ ui-key.yacloud.compute.disk-form.field_size }}** выберите нужные [тип](../../concepts/disk.md#disks-types) и размер создаваемого диска.
          1. (Опционально) В поле **{{ ui-key.yacloud.compute.field_additional_vt356 }}** включите опцию **{{ ui-key.yacloud.compute.field_disk-autodelete_qZn4x }}**, чтобы включить автоудаление создаваемого загрузочного диска вместе с ВМ.
          1. Нажмите кнопку **{{ ui-key.yacloud.compute.component.instance-storage-dialog.button_add-disk }}**.
      * Чтобы создать ВМ из [подготовленного ранее диска](#create-disk):
      
          1. В верхней части экрана выберите опцию `{{ ui-key.yacloud.compute.component.instance-storage-dialog.value_disk-attach-type-attach-existing }}`.
          1. В списке дисков выберите нужный. При необходимости воспользуйтесь фильтром.
          1. (Опционально) В поле **{{ ui-key.yacloud.compute.field_additional_vt356 }}** включите опцию **{{ ui-key.yacloud.compute.field_disk-autodelete_qZn4x }}**, чтобы включить автоудаление создаваемого загрузочного диска вместе с ВМ.
          1. Нажмите кнопку **{{ ui-key.yacloud.compute.component.instance-storage-dialog.button_add-disk }}**.
  1. {% include [section-platform](../../../_includes/compute/create/section-platform.md) %}
  1. {% include [network-settings](../../../_includes/compute/create/section-network.md) %}
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** выберите вариант **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** и укажите данные для доступа к ВМ:
  
      * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя.
  
          {% note alert %}
  
          Не используйте логин `root` или другие имена, зарезервированные ОС. Для выполнения операций, требующих прав суперпользователя, используйте команду `sudo`.
  
          {% endnote %}
  
      * {% include [access-ssh-key](../../../_includes/compute/create/access-ssh-key.md) %}

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}** задайте имя ВМ:

      {% include [name-format](../../../_includes/name-format.md) %}

      {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

- CLI {#cli}

  1. Посмотрите описание команды CLI для создания ВМ:

     ```bash
     yc compute instance create --help
     ```
  1. Создайте ВМ в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию:

      ```bash
      yc compute instance create \
        --name <имя_ВМ> \
        --zone <зона_доступности_ВМ> \
        --network-interface subnet-id=<идентификатор_подсети>,nat-ip-version=ipv4 \
        --create-boot-disk name=<имя_диска>,type=<тип_диска>,size=<размер_диска>,image-id=<идентификатор_образа>,snapshot-id=<идентификатор_снимка>,auto-delete=true \
        --use-boot-disk disk-id=<идентификатор_существующего_диска>,auto-delete=true \
        --ssh-key "<путь_к_публичному_SSH-ключу>"
      ```

      Где:
      * `--name` — имя ВМ. Требования к имени:

          {% include [name-format](../../../_includes/name-format.md) %}

          {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

      * `--zone` — [зона доступности](../../../overview/concepts/geo-scope.md), в которой создается ВМ.
      
          Зона доступности ВМ должна соответствовать зоне доступности используемой подсети.
          
          При создании ВМ с использованием подготовленного заранее загрузочного диска зона доступности ВМ должна соответствовать зоне доступности этого диска.
      * `--network-interface` — настройки [сетевого интерфейса](../../concepts/network.md) ВМ:
          * `subnet-id` — идентификатор [подсети](../../../vpc/concepts/network.md#subnet).
          * `nat-ip-version=ipv4` – [публичный IP-адрес](../../../vpc/concepts/address.md#public-addresses). Чтобы создать ВМ без публичного IP-адреса, исключите параметр.

          {% include [add-several-net-interfaces-notice-cli](../../../_includes/compute/add-several-net-interfaces-notice-cli.md) %}

      * Настройки загрузочного диска виртуальной машины:

          {% note info %}

          Параметры `--create-boot-disk` и `--use-boot-disk` — взаимоисключающие. Вы можете использовать только один из них.

          {% endnote %}

          * `--create-boot-disk` — параметр, позволяющий создать для ВМ новый загрузочный диск на основе образа или снимка:

              * `name` — имя создаваемого диска. Требования к имени:

                  {% include [name-format](../../../_includes/name-format.md) %}
              
              * `type` — [тип](../../concepts/disk.md#disks-types) создаваемого диска. Доступные значения:

                  * `network-ssd` — быстрый сетевой диск, сетевое блочное хранилище на SSD-накопителе.
                  * `network-hdd` — стандартный сетевой диск, сетевое блочное хранилище на HDD-накопителе.
                  * `network-ssd-nonreplicated` — сетевой диск с повышенной производительностью без избыточности.
                  * `network-ssd-io-m3` — сетевой диск с повышенной производительностью, обеспечивающий избыточность.
              * `size` — размер диска в гигабайтах.
              * Выбор источника для создания загрузочного диска:

                  * `image-id` — идентификатор [подготовленного ранее образа](#create-image), на основе которого будет создан загрузочный диск ВМ.
                  * `snapshot-id` — идентификатор [подготовленного ранее снимка](#create-snapshot), на основе которого будет создан загрузочный диск ВМ.

                      {% note info %}

                      Ключи `image-id` и `snapshot-id` — взаимоисключающие. Вы можете использовать только один из них.

                      {% endnote %}

              * `auto-delete` — настройка автоудаления загрузочного диска вместе с ВМ. См. [{#T}](../../concepts/disk.md#autodelete-disks).
          * `--use-boot-disk` — параметр, позволяющий использовать в ВМ существующий загрузочный диск, [подготовленный ранее](#create-disk):

              * `disk-id` — идентификатор существующего загрузочного диска.
              * `auto-delete` — настройка автоудаления загрузочного диска вместе с ВМ. См. [{#T}](../../concepts/disk.md#autodelete-disks).
      * `--ssh-key` — путь к файлу с [публичным SSH-ключом](../vm-connect/ssh.md#creating-ssh-keys). Для этого ключа на ВМ будет автоматически создан пользователь `yc-user`.

      Результат:

      ```text
      done (19s)
      id: fv4l7qqpi4e0********
      folder_id: b1gt6g8ht345********
      created_at: "2025-12-05T18:23:55Z"
      name: my-first-gen2-vm
      zone_id: {{ region-id }}-a
      platform_id: standard-v2
      resources:
        memory: "2147483648"
        cores: "2"
        core_fraction: "100"
      status: RUNNING
      metadata_options:
        gce_http_endpoint: ENABLED
        aws_v1_http_endpoint: ENABLED
        gce_http_token: ENABLED
        aws_v1_http_token: DISABLED
      boot_disk:
        mode: READ_WRITE
        device_name: fv4h89mv71cb********
        auto_delete: true
        disk_id: fv4h89mv71cb********
      network_interfaces:
        - index: "0"
          mac_address: d0:0d:15:3e:b5:99
          subnet_id: fl8dmq91iruu********
          primary_v4_address:
            address: 192.168.3.3
            one_to_one_nat:
              address: 158.160.***.***
              ip_version: IPV4
      serial_port_settings:
        ssh_authorization: OS_LOGIN
      gpu_settings: {}
      fqdn: fv4l7qqpi4e0********.auto.internal
      scheduling_policy: {}
      network_settings:
        type: STANDARD
      placement_policy: {}
      hardware_generation:
        generation2_features: {}
      application: {}
      ```

- {{ TF }} {#tf}

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

      ```hcl
      resource "yandex_compute_disk" "boot-disk" {
        name            = "<имя_диска>"
        type            = "<тип_диска>"
        zone            = "<зона_доступности>"
        size            = "<размер_диска>"
        image_id        = "<идентификатор_образа-источника>"
        snapshot_id     = "<идентификатор_снимка-источника>"
      }

      resource "yandex_compute_instance" "vm-1" {
        name                      = "<имя_вм>"
        platform_id               = "standard-v3"
        zone                      = "<зона_доступности>"

        resources {
          cores  = "<количество_ядер_vCPU>"
          memory = "<объем_RAM_ГБ>"
        }

        boot_disk {
          auto_delete = true|false
          disk_id = yandex_compute_disk.boot-disk.id
        }

        network_interface {
          subnet_id = "<идентификатор_подсети>"
          nat       = true
        }

        metadata = {
          ssh-keys = "<имя_пользователя>:<содержимое_SSH-ключа>"
        }
      }
      ```

      Где:
      * `yandex_compute_disk` — описание загрузочного [диска](../../concepts/disk.md):

          {% note info %}

          Используйте ресурс `yandex_compute_disk`, если для ВМ вы создаете новый загрузочный диск из подготовленных ранее образа или снимка.
          
          Если в новой ВМ вы будете использовать существующий загрузочный диск, [подготовленный ранее](#create-disk), укажите идентификатор этого диска в параметре `boot_disk.disk_id` ресурса `yandex_compute_instance`, не создавая нового ресурса `yandex_compute_disk`.

          {% endnote %}

          * `name` — имя создаваемого диска. Требования к имени:

              {% include [name-format](../../../_includes/name-format.md) %}

          * `type` — [тип](../../concepts/disk.md#disks-types) создаваемого диска. Доступные значения:

              * `network-ssd` — быстрый сетевой диск, сетевое блочное хранилище на SSD-накопителе.
              * `network-hdd` — стандартный сетевой диск, сетевое блочное хранилище на HDD-накопителе.
              * `network-ssd-nonreplicated` — сетевой диск с повышенной производительностью без избыточности.
              * `network-ssd-io-m3` — сетевой диск с повышенной производительностью, обеспечивающий избыточность.
          * `zone` — [зона доступности](../../../overview/concepts/geo-scope.md), в которой будет находиться диск.
          * `size` — размер диска в ГБ.
          * Выбор источника для создания загрузочного диска:

              {% note info %}

              Параметры `image_id` и `snapshot_id` — взаимоисключающие. Вы можете использовать только один из них.

              {% endnote %}

              * `image_id` — идентификатор [подготовленного ранее образа](#create-image), на основе которого будет создан загрузочный диск ВМ.
              * `snapshot_id` — идентификатор [подготовленного ранее снимка](#create-snapshot), на основе которого будет создан загрузочный диск ВМ.

          Подробную информацию о параметрах ресурса `yandex_compute_disk` см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/compute_disk).

      * `yandex_compute_instance` — описание ВМ:
          * `name` — имя ВМ. Требования к имени:

              {% include [name-format](../../../_includes/name-format.md) %}

          * `platform_id` — [платформа](../../concepts/vm-platforms.md).
          * `zone` — [зона доступности](../../../overview/concepts/geo-scope.md), в которой будет находиться ВМ.

              Зона доступности виртуальной машины должна совпадать с зоной доступности используемой подсети, а также с зоной доступности загрузочного диска, если вы создаете ВМ из подготовленного заранее диска.
          * `resources` — количество ядер vCPU и объем RAM, доступные ВМ. Значения должны соответствовать выбранной [платформе](../../concepts/vm-platforms.md).
          * `boot_disk` — настройки загрузочного диска:
          
              * `disk_id` — идентификатор диска. Если в новой ВМ вы будете использовать существующий загрузочный диск, [подготовленный ранее](#create-disk), укажите его идентификатор в этом параметре.
              * `auto_delete` — настройка автоудаления загрузочного диска вместе с ВМ. См. [{#T}](../../concepts/disk.md#autodelete-disks).
          * `network_interface` — настройки [сетевого интерфейса](../../concepts/network.md) ВМ:
          
              * `subnet_id` — идентификатор [подсети](../../../vpc/concepts/network.md#subnet) в той же зоне доступности, в которой создается виртуальная машина.
              * Чтобы автоматически назначить ВМ [публичный IP-адрес](../../../vpc/concepts/address.md#public-addresses), укажите `nat = true`.

              {% include [add-several-net-interfaces-notice-tf](../../../_includes/compute/add-several-net-interfaces-notice-tf.md) %}

          * `metadata` — в метаданных необходимо передать имя пользователя и открытый SSH-ключ для доступа на ВМ. Подробнее в разделе [{#T}](../../concepts/vm-metadata.md).

      Подробную информацию о параметрах ресурса `yandex_compute_instance` см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/compute_instance).
          
  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления]({{ link-console-main }}) или с помощью команды CLI:

      ```bash
      yc compute instance list
      ```

- API {#api}

  Воспользуйтесь методом REST API [create](../../api-ref/Instance/create.md) для ресурса [Instance](../../api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/Create](../../api-ref/grpc/Instance/create.md).

  Например, чтобы создать виртуальную машину с помощью REST API:

  1. Установите утилиту [cURL](https://curl.haxx.se).
  1. Получите [{{ iam-short-name }}-токен](../../../iam/concepts/authorization/iam-token.md), используемый для аутентификации в API:
      * [Инструкция](../../../iam/operations/iam-token/create.md) для пользователя с аккаунтом на Яндексе.
      * [Инструкция](../../../iam/operations/iam-token/create-for-sa.md) для [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md).
      * [Инструкция](../../../iam/operations/iam-token/create-for-federation.md) для федеративного аккаунта.
      * [Инструкция](../../../iam/operations/iam-token/create-for-local.md) для локального аккаунта.
  1. Для удобства выполнения запроса сохраните полученный IAM-токен в переменную окружения `IAM_TOKEN`:

      ```bash
      export IAM_TOKEN="<содержимое_IAM-токена>"
      ```
  1. Создайте файл с телом запроса на создание виртуальной машины (например, `body.json`) и добавьте в него следующий код:

      **body.json**

      ```json
      {
        "folderId": "<идентификатор_каталога>",
        "name": "<имя_ВМ>",
        "zoneId": "<зона_доступности>",
        "platformId": "standard-v3",
        "resourcesSpec": {
          "memory": "<объем_RAM_в_байтах>",
          "cores": "<количество_ядер_vCPU>"
        },
        "metadata": {
          "user-data": "#cloud-config\nusers:\n  - name: user\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh_authorized_keys:\n      - ssh-ed25519 AAAAB3N... user@example.com"
        },
        "bootDiskSpec": {
          "autoDelete": true,
          "diskSpec": {
            "size": "<размер_диска_в_байтах>",
            "imageId": "<идентификатор_образа-источника>",
            "snapshotId": "<идентификатор_снимка-источника>"
          },
          "diskId": "<идентификатор_диска>"
        },
        "networkInterfaceSpecs": [
          {
            "subnetId": "<идентификатор_подсети>",
            "primaryV4AddressSpec": {
              "oneToOneNatSpec": {
                "ipVersion": "IPV4"
              }
            }
          }
        ]
      }
      ```

      Где:

      * `folderId` — [идентификатор](../../../resource-manager/operations/folder/get-id.md) каталога, в котором создается виртуальная машина.
      * `name` — имя ВМ. Требования к имени:

          {% include [name-format](../../../_includes/name-format.md) %}

      * `zoneId` — [зона доступности](../../../overview/concepts/geo-scope.md), в которой будет находиться ВМ.

          Зона доступности виртуальной машины должна совпадать с зоной доступности используемой подсети, а также с зоной доступности загрузочного диска, если вы создаете ВМ из [подготовленного ранее диска](#create-disk).
      * `platformId` — [платформа](../../concepts/vm-platforms.md) виртуальной машины.
      * `resourceSpec` — количество ядер vCPU и объем RAM, доступные ВМ. Значения должны соответствовать выбранной [платформе](../../concepts/vm-platforms.md).
      * `metadata` — в метаданных необходимо передать открытый ключ для SSH-доступа на ВМ. Подробнее в разделе [{#T}](../../concepts/vm-metadata.md).
      * `bootDiskSpec` — настройки загрузочного диска виртуальной машины:

          * `autoDelete` — настройка автоудаления загрузочного диска вместе с ВМ. См. [{#T}](../../concepts/disk.md#autodelete-disks).

          {% note info %}

          Параметры `diskSpec` и `diskId` — взаимоисключающие. Вы можете использовать только один из них.

          {% endnote %}

          * `diskSpec` — настройка нового загрузочного диска в случае его создания из подготовленного ранее образа или снимка:

              * `size` — размер создаваемого диска в байтах.
              * Выбор источника для создания загрузочного диска:

                  {% note info %}

                  Параметры `imageId` и `snapshotId` — взаимоисключающие. Вы можете использовать только один из них.

                  {% endnote %}

                  * `imageId` — идентификатор [подготовленного ранее образа](#create-image), на основе которого будет создан загрузочный диск ВМ.
                  * `snapshotId` — идентификатор [подготовленного ранее снимка](#create-snapshot), на основе которого будет создан загрузочный диск ВМ.
          * `diskId` — идентификатор существующего загрузочного диска, [подготовленного ранее](#create-disk), в случае его использования для создания ВМ.
      * `networkInterfaceSpecs` — настройки [сетевого интерфейса](../../concepts/network.md) ВМ:

          * `subnetId` — идентификатор выбранной [подсети](../../../vpc/concepts/network.md#subnet). Подсеть должна находиться в той же зоне доступности, в которой вы создаете ВМ.
          * `primaryV4AddressSpec` — IP-адрес, который будет присвоен ВМ. Чтобы добавить [публичный IP-адрес](../../../vpc/concepts/address.md#public-addresses) ВМ, укажите:

            ```json
            "primaryV4AddressSpec": {
              "oneToOneNatSpec": {
                "ipVersion": "IPV4"
              }
            }
            ```
          Если вы хотите добавить на ВМ несколько [сетевых интерфейсов](../../concepts/network.md), передайте в `networkInterfaceSpecs` массив с необходимым количеством объектов с настройками сетевых интерфейсов.

  1. Выполните HTTP-запрос:

      ```bash
      curl \
        --request POST \
        --header "Content-Type: application/json" \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
        --data '@body.json' \
        https://compute.{{ api-host }}/compute/v1/instances
      ```

      Результат:

      ```text
      {
      "done": false,
      "metadata": {
        "@type": "type.googleapis.com/yandex.cloud.compute.v1.CreateInstanceMetadata",
        "instanceId": "fv41kcr9qbd8********"
      },
      "id": "fv4tll89q78c********",
      "description": "Create instance",
      "createdAt": "2025-12-05T20:37:44.940310692Z",
      "createdBy": "ajeol2afu1jsk********",
      "modifiedAt": "2025-12-05T20:37:44.940310692Z"
      }
      ```

{% endlist %}

#### См. также {#see-also}

* [{#T}](../../concepts/hardware-generations.md)