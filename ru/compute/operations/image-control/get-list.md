---
title: "Как получить список образов дисков в {{ compute-full-name }}"
description: "Следуя данной инструкции, вы сможете получить список образов дисков." 
---

# Получить список образов дисков

Чтобы получить список образов дисков:

{% list tabs %}

- Консоль управления
  
  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором размещены образы дисков.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/compute/image-pic.svg) **{{ ui-key.yacloud.compute.switch_images }}**.

- CLI
  
  {% include [cli-install](../../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
  
  1. Посмотрите описание команды CLI для работы с образами дисков:
  
      ```bash
      yc compute image --help
      ```
  
  1. Получите список образов дисков в каталоге по умолчанию:
  
      ```bash
      yc compute image list
      ```

      Результат:

      ```bash
      +----------------------+-------------+--------+-------------+--------+
      |          ID          |    NAME     | FAMILY | PRODUCT IDS | STATUS |
      +----------------------+-------------+--------+-------------+--------+
      | fd8n3spmksqmuraspf4h | first-image |        |             | READY  |
      +----------------------+-------------+--------+-------------+--------+
      ```
  
- API
  
  Воспользуйтесь методом REST API [list](../../api-ref/Image/list.md) для ресурса [Image](../../api-ref/Image/index.md) или вызовом gRPC API [ImageService/List](../../api-ref/grpc/image_service.md#List).
  
{% endlist %}