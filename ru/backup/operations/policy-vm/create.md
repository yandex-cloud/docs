---
title: "Создать политику резервного копирования"
description: "Из статьи вы узнаете, как создать политику резервного копирования в **{{ backup-name }}**."
---

# Создать политику резервного копирования

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать политику.
  1. В списке сервисов выберите **{{ backup-name }}**.
  1. Перейдите на вкладку ![policies](../../../_assets/backup/policies.svg) **Политики копирования**.
  1. Нажмите кнопку **Создать политику**.
  1. На странице создания политики:

      {% include [policy-options](../../../_includes/backup/policy-options.md) %}

  1. Нажмите кнопку **Сохранить**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания политики резервного копирования:

      ```bash
      yc backup policy create --help
      ```

  1. Опишите конфигурацию создаваемой политики в виде схемы данных в формате JSON.

      {% cut "Пример файла конфигурации" %}

      {% include [json-example](../../../_includes/backup/operations/json-example.md) %}

      {% endcut %}

      Сохраните готовую конфигурацию в файл c расширением `.json`.
   
      В примере приведена конфигурация политики, которая будет создавать [инкрементальные](../../concepts/backup.md#types) резервные копии ВМ каждый понедельник в 00:05 (UTC+0). При этом храниться будут только десять последних копий.

      См. [полную спецификацию](../../concepts/policy.md#specification) политики резервного копирования.

  1. Создайте политику резервного копирования:

      ```bash
      yc backup policy create \
        --name <имя_политики> \
        --settings-from-file <путь_к_файлу_конфигурации>
      ```

      Где:
	  
      * `--name` — имя создаваемой политики резервного копирования.
      * `--settings-from-file` — путь к файлу с конфигурацией политики резервного копирования в формате JSON.

      Результат:

      ```bash
      id: cbq5rwepukxn********
      name: test2
      created_at: "2023-07-03T08:24:16.735555276Z"
      updated_at: "2023-07-03T08:24:16.746377738Z"
      enabled: true
      settings:
        compression: NORMAL
        format: AUTO
        multi_volume_snapshotting_enabled: true
        preserve_file_security_settings: true
        reattempts:
          enabled: true
          interval:
            type: SECONDS
            count: "30"
          max_attempts: "30"
        silent_mode_enabled: true
        splitting:
          size: "1099511627776"
        vm_snapshot_reattempts:
          enabled: true
          interval:
            type: MINUTES
            count: "5"
          max_attempts: "3"
        vss:
          enabled: true
          provider: TARGET_SYSTEM_DEFINED
        archive:
          name: '''[Machine Name]-[Plan ID]-[Unique ID]A'''
        performance_window: {}
        retention:
          rules:
            - max_count: "10"
          after_backup: true
        scheduling:
          backup_sets:
            - time:
                weekdays:
                  - MONDAY
                repeat_at:
                  - minute: "5"
                type: WEEKLY
          enabled: true
          max_parallel_backups: "2"
          rand_max_delay:
            type: MINUTES
            count: "30"
          scheme: ALWAYS_INCREMENTAL
          weekly_backup_day: MONDAY
        cbt: ENABLE_AND_USE
        fast_backup_enabled: true
        quiesce_snapshotting_enabled: true
      folder_id: d2q792qpemb4********
      ```

      Подробнее о команде читайте в [справочнике CLI](../../../cli/cli-ref/managed-services/backup/policy/create.md).

- API

  Чтобы создать [политику резервного копирования](../../concepts/policy.md), воспользуйтесь методом REST API [create](../../backup/api-ref/Policy/create.md) для ресурса [Policy](../../backup/api-ref/Policy/index.md) или вызовом gRPC API [PolicyService/Create](../../backup/api-ref/grpc/policy_service.md#Create).

{% endlist %}

#### См. также {#see-also}

* [{#T}](update.md)
* [{#T}](delete.md)
