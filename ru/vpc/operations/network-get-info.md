---
title: "Как получить информацию об облачной сети в {{ vpc-full-name }}"
---

# Получить информации об облачной сети

Чтобы получить информацию о сети:

{% list tabs %}

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения информации о сети:

      ```bash
      yc vpc network get --help
      ```
  
  1. Получите информацию о сети, указав ее имя или идентификатор:

      ```bash
      yc vpc network get <имя_сети>
      ```

      Результат:

      ```bash
      id: ne7w0rkfj75j********
      folder_id: f01derqpemb4********
      created_at: "2023-10-25T14:59:46Z"
      name: my-network
      description: Auto-created network
      default_security_group_id: 5ecur17yj09k********
      ```

{% endlist %}

#### См. также {#see-also}

* [{#T}](subnet-get-info.md)