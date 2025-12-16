---
title: Как привязать ВМ или сервер {{ baremetal-name }} к политике резервного копирования
description: Из статьи вы узнаете, как привязать виртуальную машину {{ compute-name }} или сервер {{ baremetal-full-name }} к политике резервного копирования.
---

# Привязать виртуальную машину или сервер {{ baremetal-full-name }} к политике резервного копирования


Привязать к политике резервного копирования можно только подключенные к {{ backup-full-name }} виртуальные машины и серверы {{ baremetal-name }}. Подробнее см. в разделах [{#T}](../index.md#connect-vm) и [{#T}](../index.md#connect-baremetal).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите привязать ВМ или сервер {{ baremetal-name }} к политике.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
  1. Перейдите на вкладку ![policies](../../../_assets/console-icons/calendar.svg) **{{ ui-key.yacloud_billing.backup.label_policies }}**.
  1. Выберите политику, к которой вы хотите привязать ВМ или сервер {{ baremetal-name }}.
  1. В блоке **{{ ui-key.yacloud.backup.title_linked-recourses }}** нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.backup.button_attach-instance }}** и в открывшемся окне:

      1. В зависимости от того, какой ресурс вы хотите привязать к политике, выберите вкладку **{{ ui-key.yacloud.backup.value_vm-recourses }}** или **{{ ui-key.yacloud.backup.value_bms-recourses }}** и в списке выберите нужные ВМ или сервер.

          Если ВМ или сервера {{ baremetal-name }}, которые вы хотите привязать к политике, нет в списке, убедитесь, что они подключены к {{ backup-name }}.
      1. Нажмите кнопку **{{ ui-key.yacloud_billing.backup.button_attach-instance-submit }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для привязки ВМ или сервера {{ baremetal-name }} к политике: 

      ```bash
      yc backup policy apply --help
      ```

  1. Узнайте идентификатор политики, к которой вы хотите привязать ВМ или сервер {{ baremetal-name }}:

      {% include [get-policy-id](../../../_includes/backup/operations/get-policy-id.md) %}

  1. Узнайте идентификатор ВМ, которую нужно привязать:

      {% include [get-vm-id](../../../_includes/backup/operations/get-vm-id.md) %}

      {% include [get-bms-ids](../../../_includes/backup/operations/get-bms-ids.md) %}

  1. Привяжите ВМ или сервер {{ baremetal-name }}, указав идентификатор политики:

      ```bash
      yc backup policy apply <идентификатор_политики> \
        --instance-ids <идентификаторы_ВМ_или_серверов_{{ baremetal-name }}>
      ```

      Где `--instance-ids` — идентификаторы подключенных к {{ backup-name }} виртуальных машин и серверов {{ baremetal-name }}, которые нужно привязать к политике резервного копирования. Несколько идентификаторов указываются через запятую.

  Подробнее о команде читайте в [справочнике CLI](../../../cli/cli-ref/backup/cli-ref/policy/apply.md).

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  {% note info %}

  В настоящий момент привязать к [политике резервного копирования](../../../backup/concepts/policy.md) с помощью {{ TF }} можно только [виртуальную машину {{ compute-name }}](../../../compute/concepts/vm.md). Чтобы привязать [сервер {{ baremetal-name }}](../../../baremetal/concepts/servers.md), используйте [консоль управления]({{ link-console-main }}), [{{ yandex-cloud }} CLI](../../../cli/cli-ref/backup/cli-ref/policy/apply.md) или [API](../../backup/api-ref/Policy/apply.md).

  {% endnote %}

  Чтобы привязать виртуальную машину к политике резервного копирования:

  1. Опишите в конфигурационном файле {{ TF }} параметры привязки виртуальной машины к политике:

      ```hcl
      resource "yandex_backup_policy_bindings" "test_backup_binding" {
        instance_id = "<идентификатор_виртуальной_машины>"
        policy_id   = "<идентификатор_политики>"
      }
      ```

      Где:

      * `instance_id` — [идентификатор](../../../compute/operations/vm-info/get-info.md#outside-instance) виртуальной машины, которую вы хотите привязать к политике.
      * `policy_id` — [идентификатор](./get-info.md) политики резервного копирования, к которой вы хотите привязать виртуальную машину.

     Более подробную информацию о параметрах ресурса `yandex_backup_policy_bindings` см. в [документации провайдера]({{ tf-provider-resources-link }}/backup_policy_bindings).
  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

     ```bash
      yc backup policy list-applications
     ```

- API {#api}

  Воспользуйтесь методом REST API [apply](../../backup/api-ref/Policy/apply.md) для ресурса [Policy](../../backup/api-ref/Policy/index.md) или вызовом gRPC API [PolicyService/Apply](../../backup/api-ref/grpc/Policy/apply.md).

{% endlist %}

#### См. также {#see-also}

* [{#T}](../create-vm.md)
* [{#T}](../create-vm-windows.md)
* [{#T}](create.md)
* [{#T}](detach-vm.md)
* [{#T}](../../concepts/vm-connection.md)
* [{#T}](../../concepts/policy.md)
