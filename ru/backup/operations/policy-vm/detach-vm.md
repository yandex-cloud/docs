---
title: Как отвязать ВМ или сервер от политики резервного копирования
description: Из статьи вы узнаете, как отвязать виртуальную машину или сервер от политики резервного копирования.
---

# Отвязать защищаемый ресурс от политики резервного копирования


Чтобы отвязать [защищаемый ресурс](../../concepts/index.md#protected-resources) от политики резервного копирования:

{% note info %}

В настоящее время отвязать [внешний](../../concepts/vm-connection/external-resources.md) защищаемый ресурс от политики резервного копирования можно с помощью [{{ yandex-cloud }} CLI](../../../cli/cli-ref/backup/cli-ref/policy/revoke.md), [API](../../backup/api-ref/Policy/revoke.md) или [{{ TF }}]({{ tf-provider-resources-link }}/backup_policy_bindings).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите отвязать защищаемый ресурс от политики.
  1. [Перейдите]({{ link-console-main }}/link/backup) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
  1. Перейдите на вкладку ![policies](../../../_assets/console-icons/calendar.svg) **{{ ui-key.yacloud_billing.backup.label_policies }}**.
  1. Выберите политику, от которой вы хотите отвязать ресурс.
  1. В зависимости от того, какой ресурс вы хотите отвязать от политики резервного копирования, в блоке **{{ ui-key.yacloud.backup.title_linked-recourses }}** выберите вкладку **{{ ui-key.yacloud.backup.value_vm-recourses }}** или **{{ ui-key.yacloud.backup.value_bms-recourses }}**.
  1. В строке с ВМ или сервером, которые нужно отвязать от политики, нажмите ![options](../../../_assets/console-icons/ellipsis.svg) и выберите соответственно **{{ ui-key.yacloud.backup.action_detach-vm-instance }}** или **{{ ui-key.yacloud.backup.action_detach-baremetal-instance }}**.
  1. В открывшемся окне подтвердите это действие.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для удаления [защищаемого ресурса](../../concepts/index.md#protected-resources) из политики: 

      ```bash
      yc backup policy revoke --help
      ```

  1. Узнайте идентификатор политики, от которой вы хотите отвязать ресурс:

      {% include [get-policy-id](../../../_includes/backup/operations/get-policy-id.md) %}

  1. Узнайте идентификатор ресурса, который вы хотите отвязать:

      {% include [get-resource-ids](../../../_includes/backup/operations/get-resource-ids.md) %}

  1. Отвяжите ресурс, указав идентификатор политики:

      ```bash
      yc backup policy revoke <идентификатор_политики> \
        --instance-ids <идентификаторы_защищаемых_ресурсов>
      ```

      Где `--instance-ids` — идентификаторы [виртуальных машин {{ compute-name }}](../../concepts/vm-connection/compute.md), [серверов {{ baremetal-name }}](../../concepts/vm-connection/baremetal.md) или [внешних ресурсов](../../concepts/vm-connection/external-resources.md), которые нужно отвязать от политики резервного копирования. Несколько идентификаторов указываются через запятую.

  Подробнее о команде читайте в [справочнике CLI](../../../cli/cli-ref/backup/cli-ref/policy/revoke.md).

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Чтобы отвязать [защищаемый ресурс](../../concepts/index.md#protected-resources) от политики резервного копирования:

  1. Удалите из конфигурационного файла {{ TF }} секцию с описанием удаляемой привязки защищаемого ресурса к политике:

      ```hcl
      resource "yandex_backup_policy_bindings" "test_backup_binding" {
        instance_id = "<идентификатор_защищаемого_ресурса>"
        policy_id   = "<идентификатор_политики>"
      }
      ```

      Где:

      * `instance_id` — идентификатор защищаемого ресурса, который вы хотите отвязать от политики.
      * `policy_id` — [идентификатор](./get-info.md) политики резервного копирования, от которой вы хотите отвязать защищаемый ресурс.

     Более подробную информацию о параметрах ресурса `yandex_backup_policy_bindings` см. в [документации провайдера]({{ tf-provider-resources-link }}/backup_policy_bindings).
  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

     ```bash
      yc backup policy list-applications
     ```

- API {#api}

  Воспользуйтесь методом REST API [revoke](../../backup/api-ref/Policy/revoke.md) для ресурса [Policy](../../backup/api-ref/Policy/index.md) или вызовом gRPC API [PolicyService/Revoke](../../backup/api-ref/grpc/Policy/revoke.md).

{% endlist %}

#### Полезные ссылки {#see-also}

[{#T}](attach-and-detach-vm.md)
