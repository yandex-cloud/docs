---
title: Как получить информацию о публичном образе в {{ compute-full-name }}
description: Следуя данной инструкции, вы сможете получить информацию о публичном образе в {{ compute-full-name }}.
---

# Получить информацию о публичном образе

В процессе создания виртуальной машины вам необходимо выбрать [образ](../../concepts/image.md) машины с программным обеспечением, которое вы будете использовать.

## Получить список публичных образов {#get-list}

Чтобы получить список [публичных образов](../../concepts/image.md#public) в {{ compute-full-name }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

  Список доступных публичных образов можно посмотреть при создании виртуальной машины:

  1. В [консоли управления]({{ link-console-main }}) откройте каталог, в котором будет создана виртуальная машина.
  1. [Перейдите]({{ link-console-main }}/link/compute) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}** и нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_show-all-marketplace-products }}**. Отобразится список всех доступных публичных образов.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  Список публичных образов размещен в каталоге **standard-images**.

  * Получите полный список публичных образов.
  
      {% include [standard-images](../../../_includes/standard-images.md) %}

      {% note info %}

      По умолчанию команда выводит лишь первые 1000 образов. Чтобы просмотреть полный список образов, задайте параметр `--limit 0`.

      {% endnote %}

  * {% include [standard-images](../../../_includes/compute/list-image-families-cli.md) %}  
  * Получите список доступных публичных образов определенного семейства:

      ```bash
      yc compute image list \
        --folder-id standard-images \
        | grep <идентификатор_семейства>
      ```

      Где `<идентификатор_семейства>` — идентификатор нужного семейства образов, например: `ubuntu-2204-lts-oslogin`.

      Результат:

      ```text
      ...
      | fd827n44qr0q******** | ubuntu-2204-lts-oslogin-v20240617 | ubuntu-2204-lts-oslogin | f2eofgd2cj0e******** | READY |
      | fd827ukfjohd******** | ubuntu-2204-lts-oslogin-v20240701 | ubuntu-2204-lts-oslogin | f2evubhrcfsh******** | READY |
      | fd82sdt0b96a******** | ubuntu-2204-lts-oslogin-v20240304 | ubuntu-2204-lts-oslogin | f2ecb2d55npl******** | READY |
      ...
      ```

  Подробнее о команде `yc compute image list` читайте в [справочнике CLI](../../../cli/cli-ref/compute/cli-ref/image/list.md).

- API {#api}

  1. Получите [IAM-токен](../../../iam/concepts/authorization/iam-token.md), используемый для аутентификации в примерах:

      * [Инструкция](../../../iam/operations/iam-token/create.md) для пользователя с аккаунтом на Яндексе.
      * [Инструкция](../../../iam/operations/iam-token/create-for-sa.md) для сервисного аккаунта.
      * [Инструкция](../../../iam/operations/iam-token/create-for-federation.md) для федеративного аккаунта.
      * [Инструкция](../../../iam/operations/iam-token/create-for-local.md) для локального аккаунта.
  1. Чтобы получить список публичных образов от {{ yandex-cloud }}, воспользуйтесь методом REST API [List](../../api-ref/Image/list.md) для ресурса [Image](../../api-ref/Image/index.md) или вызовом gRPC API [ImageService/List](../../api-ref/grpc/Image/list.md). В запросе укажите следующие параметры:

      * В качестве идентификатора каталога укажите `standard-images`.
      * В каталоге много образов, поэтому укажите `pageSize=1000` или используйте полученное значение `nextPageToken`, чтобы получить продолжение списка.
      * Результат запишите в файл, например, в `output.json`.

      **Пример запроса:**

      ```bash
      export IAM_TOKEN=CggaATEVAgA...
      curl \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
        "https://compute.{{ api-host }}/compute/v1/images?folderId=standard-images&pageSize=1000" > output.json
      ```

      {% note info %}

      Чтобы записать в файл только информацию об образах определенного [семейства образов](../../concepts/image.md#family), воспользуйтесь утилитой `grep`.

      {% endnote %}

{% endlist %}

Посмотреть информацию обо всех доступных публичных образах также можно в [{{ marketplace-name }}](/marketplace).

## Получить подробную информацию о публичном образе {#get-info}

  Чтобы получить подробную информацию о [публичном образе](../../concepts/image.md#public), в том числе его идентификатор:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. [Перейдите]({{ link-console-main }}/link/compute) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}** и нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_show-all-marketplace-products }}**.
  
      Отобразится список всех доступных публичных образов.
  1. В открывшемся списке выберите публичный образ, информацию о котором вы хотите получить. При необходимости воспользуйтесь строкой поиска или фильтром.

      В результате откроется окно с подробной информацией о публичном образе. Идентификатор образа отобразится внизу страницы с информацией в блоке **{{ ui-key.yacloud_components.marketplace.label_product-ids }}** в поле **{{ ui-key.yacloud_components.marketplace.related-products_row_vm }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. Посмотрите описание команды CLI для получения информации о [публичном образе](../../concepts/image.md#public):

      ```bash
      yc compute image get --help
      ```
  1. Получите информацию об образе, указав его идентификатор:

      ```bash
      yc compute image get <идентификатор_образа>
      ```

      Результат:

      {% include [standard-images](../../../_includes/compute/image-get-cli-result.md) %}

      Идентификатор публичного образа указан в поле `id`.
  1. {% include [standard-images](../../../_includes/compute/list-image-families-cli.md) %}
  1. Получите подробную информацию о наиболее актуальном публичном образе семейства образов, указав полученный на предыдущем шаге идентификатор семейства:

      ```bash
      yc compute image get-latest-from-family <идентификатор_семейства> \
        --folder-id standard-images
      ```

      Результат:

      {% include [standard-images](../../../_includes/compute/image-get-cli-result.md) %}

      Идентификатор публичного образа указан в поле `id`.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Чтобы получить информацию о публичном образе с помощью {{ TF }}:

  1. Добавьте в конфигурационный файл {{ TF }} блоки `data` и `output`:

      ```hcl
      data "yandex_compute_image" "my_image" {
        family = "<имя_семейства>"
      }

      output "image" {
        value = data.yandex_compute_image.my_image
      }
      ```

      Где:

      * `data "yandex_compute_image"` — описание публичного образа в качестве источника данных:

          * `family` — идентификатор [семейства образов](../../concepts/image.md#family), к которому относится нужный публичный образ.

              Чтобы получить идентификатор семейства образов, воспользуйтесь [командой](../../../cli/cli-ref/compute/cli-ref/image/list.md) {{ yandex-cloud }} CLI `yc compute image list`. Подробнее читайте в разделе [{#T}](#get-list).

      * `output "image"` — выходная переменная, которая содержит информацию о наиболее актуальном публичном образе выбранного семейства:
        * `value` — возвращаемое значение.

      Подробнее о параметрах источника данных `yandex_compute_image` читайте в [документации провайдера]({{ tf-provider-datasources-link }}/compute_image).

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} создаст все требуемые ресурсы и отобразит значения выходных переменных в терминале. Чтобы проверить результат, выполните команду:

      ```bash
      terraform output
      ```

      Результат:

      ```text
      image = {
        "created_at" = "2026-08-10T18:33:51Z"
        "description" = "Ubuntu 24.04 lts with oslogin  v20260807040314"
        "family" = "ubuntu-2404-lts-oslogin"
        "folder_id" = "standard-images"
        "hardware_generation" = tolist([
          {
            "generation2_features" = tolist([])
            "legacy_features" = tolist([
              {
                "pci_topology" = "PCI_TOPOLOGY_V2"
              },
            ])
          },
        ])
        "id" = "fd8udtumfhpr********"
        "image_id" = "fd8udtumfhpr********"
        "kms_key_id" = tostring(null)
        "labels" = tomap({
          "version" = "20260807040314"
          "x-hopper-operation-id" = "d9pm50s8l14n********"
          "x-hopper-source-image-id" = "fd8go5if6b3c********"
        })
        "min_disk_size" = 10
        "name" = "ubuntu-2404-lts-oslogin-v20260810"
        "os_type" = "linux"
        "pooled" = true
        "product_ids" = toset([
          "f2e00cd2gepc********",
        ])
        "size" = 2
        "status" = "ready"
      }
      ```

      Идентификатор публичного образа указан в поле `image_id`.

- API {#api}

  Чтобы получить подробную информацию об образе по его идентификатору, воспользуйтесь методом REST API [Get](../../api-ref/Image/get.md) для ресурса [Image](../../api-ref/Image/index.md) или вызовом gRPC API [ImageService/Get](../../api-ref/grpc/Image/get.md).

  Чтобы получить подробную информацию о наиболее актуальном образе из [семейства образов](../../concepts/image.md#family), воспользуйтесь методом REST API [GetLatestByFamily](../../api-ref/Image/getLatestByFamily.md) для ресурса [Image](../../api-ref/Image/index.md) или вызовом gRPC API [ImageService.GetLatestByFamily](../../api-ref/grpc/Image/getLatestByFamily.md).

{% endlist %}

#### Полезные ссылки {#see-also}

* [{#T}](../../concepts/image.md)
