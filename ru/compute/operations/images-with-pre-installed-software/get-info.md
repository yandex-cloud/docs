---
title: "Как получить информацию о публичном образе в {{ compute-full-name }}"
description: "Следуя данной инструкции, вы сможете получить информацию о публичном образе."
---

# Получить информацию о публичном образе

Вы можете получить идентификатор или другую информацию о публичном образе.

## Получить идентификатор публичного образа {#get-id}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором хотите создать виртуальную машину.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. Справа сверху нажмите кнопку **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}**.
  1. В открывшемся списке выберите **{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** нажмите ![image](../../../_assets/console-icons/circle-info.svg) рядом с нужным [публичным образом](../../concepts/image.md#public).
  1. В блоке **Идентификаторы продукта** отобразится **image_id** — идентификатор публичного образа.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения информации о [публичном образе](../../concepts/image.md#public) диска:

      ```bash
      yc compute image get --help
      ```

  1. Получите идентификатор публичного образа, указав название [семейства](../../concepts/image.md#family) операционных систем:

      ```bash
      yc compute image get-latest-from-family <имя_семейства> --folder-id standard-images
      ```

      Чтобы узнать название семейства образа, [получите](#get-info) список образов в каталоге.

      Результат:

      ```text
      id: fd85u0rct32prepgjlv0
      folder_id: standard-images
      created_at: "2024-03-11T10:57:40Z"
      name: ubuntu-22-04-lts-v20240311
      description: ubuntu 22.04 lts
      family: ubuntu-2204-lts
      storage_size: "7633633280"
      min_disk_size: "8589934592"
      product_ids:
        - f2ef01lju2nsansfdahf
      status: READY
      os:
        type: LINUX
      pooled: true
      ```

      Идентификатор публичного образа отобразится в строке `id`.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Чтобы получить идентификатор [публичного образа](../../concepts/image.md#public) с помощью {{ TF }}:

  1. Добавьте в конфигурационный файл {{ TF }} блоки `data` и `output`:

      ```hcl
      data "yandex_compute_image" "ubuntu_image" {
        family = "<имя_семейства>"
      }

      output "ubuntu_id" {
        value = data.yandex_compute_image.my_image.image_id
      }
      ```

      Где:

      * `data "yandex_compute_image"` — описание публичного образа в качестве источника данных:
        * `family` — название [семейства](../../concepts/image.md#family) операционных систем публичного образа. Чтобы узнать название семейства образа, [получите](#get-info) список образов в каталоге.
      * `output "image"` — выходная переменная, которая содержит идентификатор публичного образа:
        * `value` — возвращаемое значение.

      Более подробно о параметрах источника данных `yandex_compute_image` см. в [документации провайдера]({{ tf-provider-datasources-link }}/datasource_compute_image).

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} создаст все требуемые ресурсы и отобразит значения выходных переменных в терминале. Чтобы проверить результат, выполните команду:

      ```bash
      terraform output
      ```

      Результат:

      ```text
      image = "fd85u0rct32prepgjlv0"
      ```

- API {#api}

  Чтобы получить идентификатор [публичного образа](../../concepts/image.md#public) диска, воспользуйтесь методом REST API [get](../../api-ref/Image/get.md) для ресурса [Image](../../api-ref/Image/index.md), или вызовом gRPC API [ImageService/Get](../../api-ref/grpc/image_service.md#Get).

{% endlist %}

## Получить информацию о публичном образе {#get-info}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором хотите создать виртуальную машину.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. Справа сверху нажмите кнопку **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}**.
  1. В открывшемся списке выберите **{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** нажмите ![image](../../../_assets/console-icons/circle-info.svg) рядом с нужным [публичным образом](../../concepts/image.md#public).
  1. В открывшемся окне отобразится информация о публичном образе.
  1. Если необходимо увидеть все доступные публичные образы, перейдите на вкладку **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** и нажмите **{{ ui-key.yacloud.compute.instances.create.button_show-all-marketplace-products }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения информации о [публичном образе](../../concepts/image.md#public):

      ```bash
      yc compute image get --help
      ```

  1. Получите информацию о публичном образе, указав его идентификатор:

      ```bash
      yc compute image get <идентификатор_образа>
      ```

      Чтобы узнать идентификатор образа, [получите](#get-id) список образов в каталоге.

      Результат:

      ```text
      id: fd89ls0nj4oqmlhhi568
      folder_id: standard-images
      created_at: "2024-04-29T10:58:27Z"
      name: ubuntu-2204-lts-oslogin-v20240429
      description: Ubuntu 22.04 OsLogin
      family: ubuntu-2204-lts-oslogin
      storage_size: "7511998464"
      min_disk_size: "10737418240"
      product_ids:
        - f2e48vn7nr04r2bpg4eg
      status: READY
      os:
        type: LINUX
      pooled: true
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Чтобы получить информацию об [публичном образе](../../concepts/image.md#public) с помощью {{ TF }}:

  1. Добавьте в конфигурационный файл {{ TF }} блоки `data` и `output`:

      ```hcl
      data "yandex_compute_image" "my_image" {
        image_id = "<идентификатор_образа>"
      }
      output "image" {
        value = data.yandex_compute_image.my_image.family
      }
      ```

      Где:

      * `data "yandex_compute_image"` — описание публичного образа в качестве источника данных:
        * `image_id` — идентификатор публичного образа. Чтобы узнать идентификатор образа, [получите](#get-id) список образов в каталоге.
      * `output "image"` — выходная переменная, которая содержит информацию о [семействе](../../concepts/image.md#family) операционных систем:
        * `value` — возвращаемое значение.

      Вместо `family` вы можете выбрать любой другой параметр для получения информации. Более подробно о параметрах источника данных `yandex_compute_image` см. в [документации провайдера]({{ tf-provider-datasources-link }}/datasource_compute_image).

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} создаст все требуемые ресурсы и отобразит значения выходных переменных в терминале. Чтобы проверить результат, выполните команду:

      ```bash
      terraform output
      ```

      Результат:

      ```text
      image = "ubuntu-2204-lts"
      ```

- API {#api}

  Чтобы получить подробную информацию об [публичном образе](../../concepts/image.md#public) диска, воспользуйтесь методом REST API [get](../../api-ref/Image/get.md) для ресурса [Image](../../api-ref/Image/index.md), или вызовом gRPC API [ImageService/Get](../../api-ref/grpc/image_service.md#Get).

{% endlist %}

Посмотреть информацию обо всех доступных публичных образах также можно в [{{ marketplace-name }}]({{ link-cloud-marketplace }}).