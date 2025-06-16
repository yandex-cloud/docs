---
title: Как привязать ВМ или сервер {{ baremetal-name }} к политике резервного копирования
description: Из статьи вы узнаете, как привязать виртуальную машину {{ compute-name }} или сервер {{ baremetal-full-name }} к политике резервного копирования.
---

# Привязать виртуальную машину или сервер {{ baremetal-full-name }} к политике резервного копирования

Привязать к политике резервного копирования можно только подключенные к {{ backup-full-name }} виртуальные машины и серверы {{ baremetal-name }}. Подробнее см. в разделах [{#T}](../index.md#connect-vm) и [{#T}](../index.md#connect-baremetal).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите привязать ВМ или сервер {{ baremetal-name }} к политике.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
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
