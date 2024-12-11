---
title: Как привязать или отвязать политику резервного копирования
description: Из статьи вы узнаете, как привязать виртуальную машину {{ compute-name }} к политике резервного копирования, и как отвязать ВМ от политики.
---

# Привязать виртуальную машину к политике резервного копирования

Привязать к политике резервного копирования можно только ту ВМ, которая подключена к {{ backup-full-name }}. Подробнее см. [Управление виртуальными машинами в {{ backup-name }}](../index.md#connect-vm).

О том, как привязать к политике [сервер {{ baremetal-name }}](../../../baremetal/concepts/servers.md), см. в инструкции [Изменение списка виртуальных машин и серверов {{ baremetal-name }}](./update.md#update-vm-list).

{% include [baremetal-note](../../../_includes/backup/baremetal-note.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите привязать ВМ к политике.
  1. В списке сервисов выберите **{{ backup-name }}**.
  1. Перейдите на вкладку ![policies](../../../_assets/console-icons/calendar.svg) **Политики копирования**.
  1. Выберите политику, к которой вы хотите привязать ВМ.
  1. В блоке **Виртуальные машины** нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **Привязать ВМ**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для привязки ВМ к политике: 

      ```bash
      yc backup policy apply --help
      ```

  1. Узнайте идентификатор политики, к которой вы хотите привязать ВМ:

      {% include [get-policy-id](../../../_includes/backup/operations/get-policy-id.md) %}

  1. Узнайте идентификатор ВМ, которую нужно привязать:

      {% include [get-vm-id](../../../_includes/backup/operations/get-vm-id.md) %}

  1. Привяжите ВМ, указав идентификатор политики:

      ```bash
      yc backup policy apply <идентификатор_политики> \
        --instance-ids <идентификаторы_ВМ>
      ```

      Где `--instance-ids` — идентификаторы ВМ, которые нужно привязать к политике резервного копирования. Несколько идентификаторов указываются через запятую.

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
