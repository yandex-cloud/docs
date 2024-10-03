---
title: Как получить информацию о политике резервного копирования
description: Из статьи вы узнаете, как получить информацию о политике резервного копирования {{ backup-full-name }}.
---

# Получить информацию о политике резервного копирования

Просмотр информации о политиках доступен после [активации](../../concepts/index.md#providers) сервиса {{ backup-name }}.

{% include [default-policies](../../../_includes/backup/default-policies.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [политика резервного копирования](../../../backup/concepts/policy.md).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
  1. На панели слева выберите ![policies](../../../_assets/console-icons/calendar.svg) **{{ ui-key.yacloud.backup.label_policies }}**.
  1. Выберите политику резервного копирования для просмотра.
  1. На странице **Обзор** отобразится подробная информация о политике.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Получите список [политик резервного копирования](../../../backup/concepts/policy.md), размещенных в каталоге по умолчанию:

     ```bash
     yc backup policy list
     ```  

     Результат:

     ```bash
     +----------------------+----------------------+-----------------+---------+---------------------+---------------------+
     |          ID          |      FOLDER ID       |      NAME       | ENABLED |     CREATED AT      |     UPDATED AT      |
     +----------------------+----------------------+-----------------+---------+---------------------+---------------------+
     | cdgp2n2s73lg******** | b1gsm0k26v1l******** | Default daily   | true    | 2023-07-20 13:55:14 | 2024-08-15 08:27:41 |
     | cdguolnopexf******** | b1gsm0k26v1l******** | Default weekly  | true    | 2023-07-20 13:55:14 | 2023-09-05 16:24:05 |
     | cdgklelzc4pi******** | b1gsm0k26v1l******** | Default monthly | true    | 2023-07-20 13:55:15 | 2024-09-02 08:40:18 |
     +----------------------+----------------------+-----------------+---------+---------------------+---------------------+
     ```
  
     Сохраните идентификатор (`ID`) или имя (`NAME`) политики, информацию о который вы хотите получить.

  1. Посмотрите описание команды [CLI](../../../cli/) для получения информации о политике резервного копирования:

     ```bash
     yc backup policy get --help
     ```

  1. Получите информацию о политике резервного копирования, указав ее имя или идентификатор:

     ```bash
     yc backup policy get <идентификатор_политики_резервного_копирования>
     ```

     Результат:

     ```bash
     id: cdgvykqerzzc********
     name: Default weekly
     created_at: "2023-10-09T20:23:46.980915356Z"
     updated_at: "2023-10-09T20:23:46.978341789Z"
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
     ...
     ```

  Подробнее о команде читайте в [справочнике CLI](../../../cli/cli-ref/managed-services/backup/policy/get.md).

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Чтобы получить информацию о [политике резервного копирования](../../concepts/policy.md) с помощью {{ TF }}:

  1. Добавьте в конфигурационный файл {{ TF }} блоки `data` и `output`:

      ```hcl
      data "yandex_backup_policy" "my_policy" {
        policy_id = "<идентификатор_политики>"
      }

      output "my_policy_schedule" {
        value = data.yandex_backup_policy.my_policy.scheduling
      }
      ```

      Где:

      * `data "yandex_backup_policy"` — описание политики резервного копирования в качестве источника данных:
        * `policy_id` — идентификатор политики резервного копирования. Вы также можете использовать параметр `name` — имя политики резервного копирования.
      * `output "my_policy_schedule"` — выходная переменная, которая содержит информацию о расписании политики резервного копирования:
        * `value` — возвращаемое значение.

      Вместо `scheduling` вы можете выбрать любой другой [параметр политики]({{ tf-provider-resources-link }}/backup_policy) для получения информации.

      Более подробно о параметрах источника данных `yandex_backup_policy` см. в [документации провайдера]({{ tf-provider-datasources-link }}/datasource_backup_policy).

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} создаст все требуемые ресурсы и отобразит значения выходных переменных в терминале. Чтобы проверить результат, выполните команду:

      ```bash
      terraform output
      ```

      Результат:

      ```bash
      my_policy_name = toset([
        {
          "backup_sets" = toset([
            {
              "execute_by_interval" = 0
              "execute_by_time" = toset([
                {
                  "include_last_day_of_month" = false
                  "monthdays" = tolist([])
                  "months" = tolist([])
                  "repeat_at" = tolist([
                    "01:45",
      ...
      "enabled" = true
      "max_parallel_backups" = 2
      "random_max_delay" = "30m"
      "scheme" = "ALWAYS_INCREMENTAL"
      "weekly_backup_day" = "MONDAY"
      ...
      ```

- API {#api}

  Чтобы получить подробную информацию о [политике резервного копирования](../../concepts/policy.md), воспользуйтесь методом REST API [get](../../backup/api-ref/Policy/get.md) для ресурса [Policy](../../backup/api-ref/Policy/index.md) или вызовом gRPC API [PolicyService/Get](../../backup/api-ref/grpc/policy_service.md#Get).

{% endlist %}