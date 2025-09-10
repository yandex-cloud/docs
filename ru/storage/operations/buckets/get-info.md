---
title: Получение информации о бакете и статистики бакета в {{ objstorage-full-name }}
description: Следуя данной инструкции, вы сможете получить информацию о бакете и статистику бакета в {{ objstorage-name }}.
---

# Получение информации о бакете и статистики бакета

## Получить информацию о бакете {#get-information}

Для просмотра полной информации о [бакете](../../concepts/bucket.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) в списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** и перейдите в нужный бакет.
  1. На панели слева выберите нужный раздел с информацией о бакете:
     * ![image](../../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.storage.bucket.switch_files }}** — список объектов, хранящихся в бакете.
     * ![image](../../../_assets/console-icons/wrench.svg) **{{ ui-key.yacloud.storage.bucket.switch_settings }}** — основные параметры бакета, информация о хостинге сайта в бакете, версионировании, логировании, жизненном цикле объектов в бакете.
     * ![image](../../../_assets/console-icons/persons-lock.svg) **{{ ui-key.yacloud.storage.bucket.switch_security }}** — описание прав и политики доступа в бакете, сведения о конфигурации HTTPS и CORS, блокировке и шифровании объектов в бакете.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения информации о бакете:

     ```bash
     yc storage bucket get --help
     ```

  1. {% include [bucket-list-cli](../../../_includes/storage/bucket-list-cli.md) %}
  1. Сохраните имя бакета (столбец `NAME`), информацию о котором вы хотите получить.

  1. Получите информацию о бакете:

     ```bash
     yc storage bucket get <имя_бакета> --full
     ```

     Результат:

     ```text
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

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) в списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** и перейдите в нужный бакет.
  1. На панели слева выберите ![image](../../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.common.monitoring }}**.
  1. На открывшейся странице вы можете посмотреть статистику бакета за определенный период времени:
     
     {% include [storage-monitoring-dashboards](../../_includes_service/storage-monitoring-dashboards.md) %}


- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения статистики бакета:

     ```bash
     yc storage bucket stats --help
     ```

  1. {% include [bucket-list-cli](../../../_includes/storage/bucket-list-cli.md) %}
  1. Сохраните имя бакета (столбец `NAME`), статистику которого вы хотите получить.

  1. Получите статистику бакета:

     ```bash
     yc storage bucket stats <имя_бакета>
     ```

     Результат:

     ```text
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