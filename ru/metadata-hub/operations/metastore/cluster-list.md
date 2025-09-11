---
title: Получение информации о кластерах {{ metastore-full-name }}
description: Следуя данной инструкции, вы сможете запросить подробную информацию об имеющихся кластерах {{ metastore-full-name }}.
---

# Получение информации о кластерах {{ metastore-full-name }}

{% include [Preview](../../../_includes/note-preview.md) %}

## Получение списка кластеров в каталоге {#list-clusters}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/database.svg) **{{ ui-key.yacloud.metastore.label_metastore }}**.


- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Чтобы запросить список кластеров {{ metastore-name }} в каталоге по умолчанию, выполните команду:

  ```bash
  {{ yc-metastore }} cluster list
  ```

  Результат:

  ```bash
  +----------------------+--------------+---------------------+--------+---------+
  |          ID          |     NAME     |     CREATED AT      | HEALTH | STATUS  |
  +----------------------+--------------+---------------------+--------+---------+
  | c9q76od34u8j******** | metastore1   | 2025-08-10 19:15:29 | ALIVE  | RUNNING |
  | c9qipdqpe0dt******** | metastore2   | 2025-05-09 15:03:56 | ALIVE  | RUNNING |
  +----------------------+--------------+---------------------+--------+---------+
  ```

{% endlist %}

## Получение детальной информации о кластере {#get-cluster}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, где находится нужный кластер.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/database.svg) **{{ ui-key.yacloud.metastore.label_metastore }}**.

  1. Нажмите на имя нужного кластера.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Чтобы получить информацию о кластере {{ metastore-name }}, выполните команду:

  ```bash
  {{ yc-metastore }} cluster get <имя_или_идентификатор_кластера>
  ```

  Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](#list-clusters).

{% endlist %}

## Просмотр операций с кластерами {#list-operations}

Все действия с кластерами {{ metastore-name }} сохраняются в виде списка операций. Каждой операции присваивается уникальный идентификатор.

### Получение списка операций {#get-operations}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, где находится нужный кластер.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/database.svg) **{{ ui-key.yacloud.metastore.label_metastore }}**.

  1. Нажмите на имя нужного кластера.
  1. На панели слева выберите ![image](../../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.common.operations-key-value }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
  
  Чтобы получить список операций, выполните команду:

    ```bash
    {{ yc-metastore }} cluster list-operations <имя_или_идентификатор_кластера>
    ```

  Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](#list-clusters).

{% endlist %}

### Получение подробной информации об операции {#get-operations-info}

1. [Получите список операций](#get-operations) для кластера.
1. Скопируйте идентификатор нужной операции.
1. Получите подробную информацию об операции:

    {% list tabs group=instructions %}
    
    - CLI {#cli}
    
      {% include [cli-install](../../../_includes/cli-install.md) %}
    
      {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
    
      Выполните команду:
    
        ```bash
        yc operation get <идентификатор_операции>
        ```
    
      Результат:
    
        ```text
        id: fltpnb1a6llk********
        description: Create Metastore cluster
        created_at: "2025-08-10T19:15:29.794361Z"
        created_by: ajejut7dk2dp********
        modified_at: "2025-08-10T19:23:38.978798Z"
        done: true
        metadata:
          '@type': type.googleapis.com/yandex.cloud.metastore.v1.CreateClusterMetadata
          cluster_id: c9q76od34u8j********
        response:
          '@type': type.googleapis.com/yandex.cloud.metastore.v1.Cluster
          id: c9q76od34u8j********
          folder_id: b1gutjgdvq50********
          created_at: "2025-08-10T19:15:29.794361Z"
          name: metastore2
          ...
        ```
    
    {% endlist %}

