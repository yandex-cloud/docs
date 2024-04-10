---
title: "Как получить информацию о кластере GPU в {{ compute-full-name }}"
---

# Получить информацию о кластере GPU


Чтобы получить информацию о кластере GPU:

{% list tabs %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения информации о кластере GPU:

      ```bash
      yc compute gpu-cluster get --help
      ```
      
  1. Получите информацию о кластере GPU, указав его имя или идентификатор:
      
      ```bash
      yc compute gpu-cluster get <имя_кластера_GPU>
      ```

      Результат:

      ```bash
      ...
      ```

{% endlist %}
