---
title: "Получение информации о бакете и статистики бакета"
description: "Следуя данной инструкции, вы сможете получить информацию о бакете и статистику бакета."
---

# Получение информации о бакете и статистики бакета

## Получить информацию о бакете {#get-information}

Для просмотра полной информации о [бакете](../../concepts/bucket.md):

{% list tabs %}

- {{ yandex-cloud }} CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения информации о бакете:

     ```bash
     yc storage bucket get --help
     ```

  1. Получите список бакетов в каталоге по умолчанию:

     ```bash
     yc storage bucket list
     ```

     Результат:

       ```text
       +------------------+----------------------+----------+-----------------------+---------------------+
       |       NAME       |      FOLDER ID       | MAX SIZE | DEFAULT    STORAGE CLASS |     CREATED AT   |
       +------------------+----------------------+----------+-----------------------+---------------------+
       | first-bucket     | b1gmit33ngp6******** | 0        | STANDARD              | 2022-12-16 13:58:18 |
       +------------------+----------------------+----------+-----------------------+---------------------+
      ```

  1. Сохраните имя бакета (столбец `NAME`), информацию о котором вы хотите получить.

  1. Получите информацию о бакете:

     ```bash
     yc storage bucket get <имя_бакета> --full
     ```
   
     Результат:

     ```bash
     name: first-bucket
     folder_id: b1gmit33ngp6********
     anonymous_access_flags:
       read: false
       list: false
       config_read: false
     default_storage_class: ICE
     versioning: VERSIONING_ENABLED
     max_size: "5368709120"
     acl:
       grants:
         - permission: PERMISSION_READ
           grant_type: GRANT_TYPE_ACCOUNT
           grantee_id: ajep03tkmqqr********
     created_at: "2023-04-10T19:41:30.266075Z"
     website_settings:
       index: index.html
       error: 404.html
       redirect_all_requests: {}
     ```

{% endlist %}

## Получить статистику бакета {#get-statistics}

Для просмотра статистики по бакету:

{% list tabs %}

- {{ yandex-cloud }} CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения статистики бакета:

     ```bash
     yc storage bucket stats --help
     ```

  1. Получите список бакетов в каталоге по умолчанию:

     ```bash
     yc storage bucket list
     ```

     Результат:

       ```text
       +------------------+----------------------+----------+-----------------------+---------------------+
       |       NAME       |      FOLDER ID       | MAX SIZE | DEFAULT    STORAGE CLASS |     CREATED AT   |
       +------------------+----------------------+----------+-----------------------+---------------------+
       | first-bucket     | b1gmit33ngp6******** | 0        | STANDARD              | 2022-12-16 13:58:18 |
       +------------------+----------------------+----------+-----------------------+---------------------+
      ```

  1. Сохраните имя бакета (столбец `NAME`), статистику которого вы хотите получить.

  1. Получите статистику бакета:

     ```bash
     yc storage bucket stats <имя_бакета>
     ```

     Результат:

     ```bash
     name: first-bucket
     max_size: "5368709120"
     used_size: "621552"
     storage_class_used_sizes:
       - storage_class: STANDARD
         class_size: "607467"
       - storage_class: COLD
         class_size: "14085"
     storage_class_counters:
       - storage_class: STANDARD
         counters:
           simple_object_size: "607467"
           simple_object_count: "41"
       - storage_class: COLD
         counters:
           simple_object_size: "14085"
           simple_object_count: "16"
     default_storage_class: ICE
     anonymous_access_flags:
       read: false
       list: false
       config_read: false
     created_at: "2023-04-10T19:41:30.266075Z"
     updated_at: "2023-08-02T04:05:44.564924Z"
     ```

{% endlist %}