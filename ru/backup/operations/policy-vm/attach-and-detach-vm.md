---
title: Как привязать защищаемый ресурс к политике резервного копирования
description: Из статьи вы узнаете, как привязать виртуальную машину или сервер к политике резервного копирования.
---

# Привязать защищаемый ресурс к политике резервного копирования


Привязать к политике резервного копирования можно только [подключенные](../../concepts/vm-connection/index.md) к {{ backup-full-name }} [защищаемые ресурсы](../../concepts/index.md#protected-resources). Подробнее в разделах [{#T}](../index.md#connect-vm), [{#T}](../index.md#connect-baremetal) и [{#T}](../index.md#connect-external).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите привязать защищаемый ресурс к политике.
  1. [Перейдите]({{ link-console-main }}/link/backup) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
  1. На панели слева выберите ![policies](../../../_assets/console-icons/calendar.svg) **{{ ui-key.yacloud_billing.backup.label_policies }}**.
  1. Выберите политику, к которой вы хотите привязать ВМ или сервер.
  1. В блоке **{{ ui-key.yacloud.backup.title_linked-recourses }}** нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.backup.button_attach-instance }}** и в открывшемся окне:

      1. В зависимости от того, какой ресурс вы хотите привязать к политике, в поле **{{ ui-key.yacloud.backup.field_add-resource_resource-type }}** выберите:

          * `{{ ui-key.yacloud.backup.value_vm-recourses }}` — для виртуальных машин {{ compute-name }}.
          * `{{ ui-key.yacloud.backup.value_bms-recourses }}` — для серверов {{ baremetal-name }}.
          * `{{ ui-key.yacloud.backup.label_external-vm-instances }}` — для внешних виртуальных машин.
          * `{{ ui-key.yacloud.backup.label_external-server-instances }}` — для внешних серверов.
      1. В поле ниже выберите нужный ресурс выбранного ранее типа.

          Если ресурса, который вы хотите привязать к политике, нет в списке, убедитесь, что он подключен к {{ backup-name }}.
      1. Нажмите кнопку **{{ ui-key.yacloud_billing.backup.button_attach-instance-submit }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для привязки [защищаемого ресурса](../../concepts/index.md#protected-resources) к политике: 

      ```bash
      yc backup policy apply --help
      ```

  1. Узнайте идентификатор политики, к которой вы хотите привязать защищаемый ресурс:

      {% include [get-policy-id](../../../_includes/backup/operations/get-policy-id.md) %}

  1. Узнайте идентификатор защищаемого ресурса, который нужно привязать:

      {% include [get-resource-ids.md](../../../_includes/backup/operations/get-resource-ids.md) %}

  1. Привяжите ресурс к политике, указав ее идентификатор:

      ```bash
      yc backup policy apply <идентификатор_политики> \
        --instance-ids <идентификаторы_защищаемых_ресурсов>
      ```

      Где `--instance-ids` — идентификаторы подключенных к {{ backup-name }} [виртуальных машин {{ compute-name }}](../../concepts/vm-connection/compute.md), [серверов {{ baremetal-name }}](../../concepts/vm-connection/baremetal.md) или [внешних ресурсов](../../concepts/vm-connection/external-resources.md), которые нужно привязать к политике резервного копирования. Несколько идентификаторов указываются через запятую.

  Подробнее о команде читайте в [справочнике CLI](../../../cli/cli-ref/backup/cli-ref/policy/apply.md).

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Чтобы привязать [защищаемый ресурс](../../concepts/index.md#protected-resources) к политике резервного копирования:

  1. Опишите в конфигурационном файле {{ TF }} параметры привязки защищаемого ресурса:

      ```hcl
      resource "yandex_backup_policy_bindings" "test_backup_binding" {
        instance_id = "<идентификатор_защищаемого_ресурса>"
        policy_id   = "<идентификатор_политики>"
      }
      ```

      Где:

      * `instance_id` — идентификатор защищаемого ресурса, который вы хотите привязать к политике.

          Получить список идентификаторов, привязанных к {{ backup-name }} ресурсов в каталоге по умолчанию, вы можете с помощью команды {{ yandex-cloud }} CLI `yc backup vm list`.
      * `policy_id` — [идентификатор](./get-info.md) политики резервного копирования, к которой вы хотите привязать ресурс.

     Подробнее о параметрах ресурса `yandex_backup_policy_bindings` в [документации провайдера]({{ tf-provider-resources-link }}/backup_policy_bindings).
  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

     ```bash
      yc backup policy list-applications
     ```

- API {#api}

  Воспользуйтесь методом REST API [apply](../../backup/api-ref/Policy/apply.md) для ресурса [Policy](../../backup/api-ref/Policy/index.md) или вызовом gRPC API [PolicyService/Apply](../../backup/api-ref/grpc/Policy/apply.md).

{% endlist %}

#### Полезные ссылки {#see-also}

* [{#T}](../create-vm.md)
* [{#T}](../create-vm-windows.md)
* [{#T}](create.md)
* [{#T}](detach-vm.md)
* [{#T}](../../concepts/vm-connection/index.md)
* [{#T}](../../concepts/policy.md)
