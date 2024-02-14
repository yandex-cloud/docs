---
title: "Как получить информацию о подсети в {{ vpc-full-name }}"
---

# Получить информации о подсети

Чтобы получить информацию о подсети:

{% list tabs %}

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения информации о подсети:

      ```bash
      yc vpc subnet get --help
      ```
  
  1. Получите информацию о подсети, указав ее имя или идентификатор:

      ```bash
      yc vpc subnet get <имя_подсети>
      ```

      Результат:

      ```bash
      id: 5ubne7r188b7********
      folder_id: f01derqpemb4********
      created_at: "2023-10-25T14:59:49Z"
      name: my-network-{{ region-id }}-a
      description: Auto-created default subnet for zone {{ region-id }}-a in my-network
      network_id: ne7w0rkfj75j********
      zone_id: {{ region-id }}-a
      v4_cidr_blocks:
        - 10.130.0.0/24
      ```

{% endlist %}

#### См. также {#see-also}

* [{#T}](network-get-info.md)