---
title: "Изменить политику резервного копирования"
description: "Из статьи вы узнаете, как изменить политику резервного копирования в **{{ backup-name }}**."
---

# Изменить политику резервного копирования

## Изменить основные параметры {#update-basic-parameters}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно изменить политику.
  1. В списке сервисов выберите **{{ backup-name }}**.
  1. Перейдите на вкладку ![policies](../../../_assets/backup/policies.svg) **Политики копирования**.
  1. Напротив политики, которую нужно изменить, нажмите ![options](../../../_assets/options.svg) и выберите **Редактировать**.
  1. Измените параметры политики:

        {% include [policy-options](../../../_includes/backup/policy-options.md) %}

  1. Нажмите кнопку **Сохранить**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для изменения политики:

      ```bash
      yc backup policy update --help
      ```

  1. Опишите конфигурацию политики резервного копирования в формате JSON.

      {% cut "Пример файла конфигурации" %}

      {% include [json-example](../../../_includes/backup/operations/json-example.md) %}

      {% endcut %}

      В примере приведена конфигурация политики, которая будет создавать [инкрементальные](../../concepts/backup.md#types) резервные копии ВМ каждый понедельник в 00:05 (UTC+0). При этом храниться будут только десять последних копий.

      См. [полную спецификацию](../../concepts/policy.md#specification) политики резервного копирования.

  1. Узнайте идентификатор политики, которую нужно изменить:

      {% include [get-policy-id](../../../_includes/backup/operations/get-policy-id.md) %}

  1. Измените политику резервного копирования, указав ее идентификатор:

      ```bash
      yc backup policy update <идентификатор_политики> \
        --settings-from-file <путь_к_файлу_конфигурации>
      ```

      Где `--settings-from-file` — путь к файлу с конфигурацией политики резервного копирования в формате JSON.

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

      Подробнее о команде читайте в [справочнике CLI](../../../cli/cli-ref/managed-services/backup/policy/update.md).

- API

  Чтобы изменить основные параметры [политики резервного копирования](../../concepts/policy.md), воспользуйтесь методом REST API [update](../../backup/api-ref/Policy/update.md) для ресурса [Policy](../../backup/api-ref/Policy/index.md) или вызовом gRPC API [PolicyService/Update](../../backup/api-ref/grpc/policy_service.md#Update).

{% endlist %}

## Изменить список виртуальных машин {#update-vm-list}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится политика.
  1. В списке сервисов выберите **{{ backup-name }}**.
  1. Перейдите на вкладку ![policies](../../../_assets/backup/policies.svg) **Политики копирования**.
  1. Выберите политику, в которой нужно изменить список ВМ.
  1. Измените список ВМ:
  
      * Чтобы добавить новую ВМ, в блоке **Виртуальные машины** нажмите кнопку ![image](../../../_assets/plus-sign.svg) **Привязать ВМ**. В открывшемся окне выберите ВМ, которую нужно привязать к политике, и нажмите кнопку **Сохранить**.
      * Чтобы удалить ВМ, в блоке **Виртуальные машины** напротив ВМ, которую нужно отвязать от политики, нажмите ![options](../../../_assets/options.svg) и выберите **Отвязать от политики**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
 
  1. Узнайте идентификатор политики, в которой нужно изменить список ВМ:

      {% include [get-policy-id](../../../_includes/backup/operations/get-policy-id.md) %}

  1. Узнайте идентификаторы ВМ, которые нужно добавить или удалить:

      {% include [get-vm-id](../../../_includes/backup/operations/get-vm-id.md) %}

  1. Измените список ВМ в политике резервного копирования:
  
      * Чтобы привязать ВМ к политике резервного копирования:

        Посмотрите описание команды CLI: 

        ```bash
        yc backup policy apply --help
        ```

        Привяжите ВМ к политике резервного копирования, указав их идентификаторы:

        ```bash
        yc backup policy apply <идентификатор_политики> \
          --instance-ids <идентификаторы_ВМ>
        ```

        Где `--instance-ids` — идентификаторы ВМ, которые нужно привязать к политике резервного копирования. Несколько идентификаторов указываются через запятую.

        Подробнее о команде читайте в [справочнике CLI](../../../cli/cli-ref/managed-services/backup/policy/apply.md).
		
      * Чтобы отвязать ВМ от политики резервного копирования:

        Посмотрите описание команды CLI: 

        ```bash
        yc backup policy revoke --help
        ```

        Отвяжите ВМ от политики резервного копирования, указав их идентификаторы:

        ```bash
        yc backup policy revoke <идентификатор_политики> \
          --instance-ids <идентификаторы_ВМ>
        ```

        Где `--instance-ids` — идентификаторы ВМ, которые нужно отвязать от политики резервного копирования. Несколько идентификаторов указываются через запятую.

        Подробнее о команде читайте в [справочнике CLI](../../../cli/cli-ref/managed-services/backup/policy/revoke.md).

- API

  Чтобы изменить список виртуальных машин, копии которых создаются согласно [политике резервного копирования](../../concepts/policy.md), воспользуйтесь методом REST API [update](../../backup/api-ref/Policy/update.md) для ресурса [Policy](../../backup/api-ref/Policy/index.md) или вызовом gRPC API [PolicyService/Update](../../backup/api-ref/grpc/policy_service.md#Update).

{% endlist %}

#### См. также {#see-also}

* [{#T}](delete.md)
