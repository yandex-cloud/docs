---
title: "Как удалить сервисное подключение в {{ vpc-full-name }}"
description: "Следуя данной инструкции, вы сможете удалить сервисное подключение (Private Endpoint) в VPC." 
---

# Удалить сервисное подключение

{% include [vpc-pe-preview](../../_includes/vpc/pe-preview.md) %}



{% list tabs group=instructions %}

- CLI {#cli}

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  1. Посмотрите описание команды CLI для удаления сервисного подключения (Private Endpoint):

      ```bash
      yc vpc private-endpoint delete --help
      ```

  1. Получите список всех сервисных подключений:

     ```bash
     yc vpc private-endpoint list
     ```

     Результат выполнения команды:
     
     ```text
     +----------------------+-------------+--------------------------------+
     |          ID          |    NAME     |          DESCRIPTION           |
     +----------------------+-------------+--------------------------------+
     | enpd7rq************* | s3-vpc-link | Private Endpoint to the Object |
     |                      |             | Storage                        |
     +----------------------+-------------+--------------------------------+
     ``` 

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужного сервисного подключения.
  1. Удалите сервисное подключение:

     ```bash
     yc vpc private-endpoint delete s3-vpc-link
     ```

{% endlist %}
