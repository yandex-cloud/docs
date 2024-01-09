---
title: "Как привязать или отвязать политику резервного копирования"
description: "Из статьи вы узнаете, как привязать виртуальную машину {{ compute-name }} к политике резервного копирования, и как отвязать ВМ от политики."
---

# Изменить список виртуальных машин в политике резервного копирования

## Привязать ВМ к политике {#attach-vm}

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

  Подробнее о команде читайте в [справочнике CLI](../../../cli/cli-ref/managed-services/backup/policy/apply.md).

- API {#api}

  Воспользуйтесь методом REST API [apply](../../backup/api-ref/Policy/apply.md) для ресурса [Policy](../../backup/api-ref/Policy/index.md) или вызовом gRPC API [PolicyService/Apply](../../backup/api-ref/grpc/policy_service.md#Apply).

{% endlist %}

## Отвязать ВМ от политики {#detach-vm}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите отвязать ВМ от политики.
  1. В списке сервисов выберите **{{ backup-name }}**.
  1. Перейдите на вкладку ![policies](../../../_assets/console-icons/calendar.svg) **Политики копирования**.
  1. Выберите политику, от которой вы хотите отвязать ВМ.
  1. В блоке **Виртуальные машины** напротив ВМ, которую нужно отвязать от политики, нажмите ![options](../../../_assets/console-icons/ellipsis.svg) и выберите **Отвязать от политики**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для удаления ВМ из политики: 

      ```bash
      yc backup policy revoke --help
      ```

  1. Узнайте идентификатор политики, от которой вы хотите отвязать ВМ:

      {% include [get-policy-id](../../../_includes/backup/operations/get-policy-id.md) %}

  1. Узнайте идентификатор ВМ, которую вы хотите отвязать:

      {% include [get-vm-id](../../../_includes/backup/operations/get-vm-id.md) %}

  1. Отвяжите ВМ, указав идентификатор политики:

      ```bash
      yc backup policy revoke <идентификатор_политики> \
        --instance-ids <идентификаторы_ВМ>
      ```

      Где `--instance-ids` — идентификаторы ВМ, которые нужно отвязать от политики резервного копирования. Несколько идентификаторов указываются через запятую.

  Подробнее о команде читайте в [справочнике CLI](../../../cli/cli-ref/managed-services/backup/policy/revoke.md).

- API {#api}

  Воспользуйтесь методом REST API [revoke](../../backup/api-ref/Policy/revoke.md) для ресурса [Policy](../../backup/api-ref/Policy/index.md) или вызовом gRPC API [PolicyService/Revoke](../../backup/api-ref/grpc/policy_service.md#Revoke).

{% endlist %}