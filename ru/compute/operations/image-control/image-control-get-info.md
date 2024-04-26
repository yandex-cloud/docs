---
title: "Как получить информацию об образе диска в {{ compute-full-name }}"
---

# Получить информацию об образе диска

{% list tabs %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [образ](../../concepts/image.md) диска.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/layers.svg) **{{ ui-key.yacloud.compute.switch_images }}**.
  1. Выберите нужный образ.
  1. На странице **{{ ui-key.yacloud.common.overview }}** отобразится подробная информация об образе.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения информации об [образе](../../concepts/image.md) диска:

      ```bash
      yc compute image get --help
      ```
      
  1. Получите информацию об образе диска, указав его имя или идентификатор:
      
      ```bash
      yc compute image get <имя_образа>
      ```

      Результат:

      ```bash
      id: fd8orln8oii5********
      folder_id: b1g72vbihiut********
      created_at: "2023-05-19T06:46:14Z"
      name: image-ubuntu-20-04
      description: ubuntu-20.04.6-live-server-amd64
      min_disk_size: "1488977920"
      status: READY
      os:
        type: LINUX
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Чтобы получить информацию об [образе](../../concepts/image.md) диска с помощью {{ TF }}:

  1. Добавьте в конфигурационный файл {{ TF }} блоки `data` и `output`:

      ```hcl
      data "yandex_compute_image" "my_image" {
        image_id = "<идентификатор_образа>"
      }
      output "image" {
        value = data.yandex_compute_image.my_image.min_disk_size
      }
      ```

      Где:

      * `data "yandex_compute_image"` — описание образа диска в качестве источника данных:
        * `image_id` — идентификатор образа диска.
      * `output "image"` — выходная переменная, которая содержит информацию о минимальном размере диска:
        * `value` — возвращаемое значение.

      Вместо `min_disk_size` вы можете выбрать любой другой параметр для получения информации. Более подробно о параметрах источника данных `yandex_compute_image` см. в [документации провайдера]({{ tf-provider-datasources-link }}/datasource_compute_image).

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} создаст все требуемые ресурсы и отобразит значения выходных переменных в терминале. Чтобы проверить результат, выполните команду:

      ```bash
      terraform output
      ```

      Результат:

      ```bash
      image = "20"
      ```

- API {#api}

  Чтобы получить подробную информацию об [образе](../../concepts/image.md) диска, воспользуйтесь методом REST API [get](../../api-ref/Image/get.md) для ресурса [Image](../../api-ref/Image/index.md), или вызовом gRPC API [ImageService/Get](../../api-ref/grpc/image_service.md#Get).

{% endlist %}
