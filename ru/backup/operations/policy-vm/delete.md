---
title: "Удалить политику резервного копирования"
description: "Из статьи вы узнаете, как удалить политику резервного копирования в **{{ backup-name }}**."
---

# Удалить политику резервного копирования

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно удалить политику.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
  1. Перейдите на вкладку ![policies](../../../_assets/backup/policies.svg) **{{ ui-key.yacloud.backup.label_policies }}**.
  1. Напротив политики, которую нужно удалить, нажмите ![image](../../../_assets/options.svg) и выберите **{{ ui-key.yacloud.common.delete }}**. 
  1. Подтвердите удаление политики.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для удаления политики резервного копирования:

      ```bash
      yc backup policy delete --help
      ```

  1. Узнайте идентификатор политики, которую нужно удалить:

      {% include [get-policy-id](../../../_includes/backup/operations/get-policy-id.md) %}

  1. Удалите политику, указав ее идентификатор:

      ```bash
      yc backup policy delete <идентификатор_политики>
      ```

      Подробнее о команде читайте в [справочнике CLI](../../../cli/cli-ref/managed-services/backup/policy/delete.md).

- API

  Чтобы удалить [политику резервного копирования](../../concepts/policy.md), воспользуйтесь методом REST API [delete](../../backup/api-ref/Policy/delete.md) для ресурса [Policy](../../backup/api-ref/Policy/index.md) или вызовом gRPC API [PolicyService/Delete](../../backup/api-ref/grpc/policy_service.md#Delete).

{% endlist %}
