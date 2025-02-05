---
title: Как отвязать ВМ или сервер {{ baremetal-name }} от политики резервного копирования
description: Из статьи вы узнаете, как отвязать виртуальную машину {{ compute-name }} или сервер {{ baremetal-full-name }} от политики резервного копирования.
---

# Отвязать виртуальную машину или сервер {{ baremetal-full-name }} от политики резервного копирования

{% include [baremetal-note](../../../_includes/backup/baremetal-note.md) %}

Чтобы отвязать виртуальную машину или сервер {{ baremetal-name }} от политики резервного копирования:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите отвязать ВМ или сервер {{ baremetal-name }} от политики.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
  1. Перейдите на вкладку ![policies](../../../_assets/console-icons/calendar.svg) **{{ ui-key.yacloud_billing.backup.label_policies }}**.
  1. Выберите политику, от которой вы хотите отвязать ВМ или сервер {{ baremetal-name }}.
  1. В зависимости от того, какой ресурс вы хотите отвязать от политики резервного копирования, в блоке **{{ ui-key.yacloud.backup.title_linked-recourses }}** выберите вкладку **{{ ui-key.yacloud.backup.value_vm-recourses }}** или **{{ ui-key.yacloud.backup.value_bms-recourses }}**.
  1. В строке с ВМ или сервером {{ baremetal-name }}, которые нужно отвязать от политики, нажмите ![options](../../../_assets/console-icons/ellipsis.svg) и выберите соответственно **{{ ui-key.yacloud.backup.action_detach-vm-instance }}** или **{{ ui-key.yacloud.backup.action_detach-baremetal-instance }}**.
  1. В открывшемся окне подтвердите это действие.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для удаления ВМ или сервера {{ baremetal-name }} из политики: 

      ```bash
      yc backup policy revoke --help
      ```

  1. Узнайте идентификатор политики, от которой вы хотите отвязать ВМ или сервер {{ baremetal-name }}:

      {% include [get-policy-id](../../../_includes/backup/operations/get-policy-id.md) %}

  1. Узнайте идентификатор ВМ, которую вы хотите отвязать:

      {% include [get-vm-id](../../../_includes/backup/operations/get-vm-id.md) %}

      {% include [get-bms-ids](../../../_includes/backup/operations/get-bms-ids.md) %}

  1. Отвяжите ВМ или сервер {{ baremetal-name }}, указав идентификатор политики:

      ```bash
      yc backup policy revoke <идентификатор_политики> \
        --instance-ids <идентификаторы_ВМ_или_серверов_{{ baremetal-name }}>
      ```

      Где `--instance-ids` — идентификаторы ВМ или серверов {{ baremetal-name }}, которые нужно отвязать от политики резервного копирования. Несколько идентификаторов указываются через запятую.

  Подробнее о команде читайте в [справочнике CLI](../../../cli/cli-ref/backup/cli-ref/policy/revoke.md).

- API {#api}

  Воспользуйтесь методом REST API [revoke](../../backup/api-ref/Policy/revoke.md) для ресурса [Policy](../../backup/api-ref/Policy/index.md) или вызовом gRPC API [PolicyService/Revoke](../../backup/api-ref/grpc/Policy/revoke.md).

{% endlist %}

#### См. также {#see-also}

* [{#T}](attach-and-detach-vm.md)
