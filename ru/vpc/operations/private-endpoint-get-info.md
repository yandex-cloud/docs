---
title: "Как получить информацию об сервисном подключении в {{ vpc-full-name }}"
description: "Следуя данной инструкции, вы сможете получить информацию о сервисном подключении (Private Endpoint) в VPC." 
---

# Получить информацию о сервисном подключении

{% include [vpc-pe-preview](../../_includes/vpc/pe-preview.md) %}



{% list tabs group=instructions %}

- CLI {#cli}

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  1. Посмотрите описание команды CLI для получения информации о сервисном подключении (Private Endpoint):

      ```bash
      yc vpc private-endpoint get --help
      ```

  1. Получите информацию о сервисном подключении, указав его имя или идентификатор:

     ```bash
     yc vpc private-endpoint get s3-vpc-link
     ```

     Результат выполнения команды:
     ```text
     id: enpd7***************
     folder_id: b1g23***************
     created_at: "2024-08-31T16:23:33.859574Z"
     name: s3-vpc-link
     description: Private Endpoint to the Object Storage
     network_id: enpgi***************
     status: AVAILABLE
     address:
       subnet_id: e2l8b***************
       address: 10.128.0.10
       address_id: e2ldn***************
     dns_options: {}
     object_storage: {}
     ```

{% endlist %}
