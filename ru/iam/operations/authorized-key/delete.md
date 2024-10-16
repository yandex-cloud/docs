---
title: Как удалить авторизованные ключи в {{ iam-full-name }}
description: Из статьи вы узнаете, как удалить авторизованные ключи в {{ iam-full-name }} через консоль управления, CLI и API сервиса.
---

# Удаление авторизованного ключа

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), которому принадлежит сервисный аккаунт.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. На панели слева выберите ![FaceRobot](../../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}** и выберите нужный сервисный аккаунт.
  1. В блоке **{{ ui-key.yacloud.iam.folder.service-account.overview.section_keys }}** в строке с ключом, который нужно удалить, нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.iam.folder.service-account.overview.button_action-delete }}**.
  1. В открывшемся окне подтвердите удаление.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. Получите список с идентификаторами `ID` авторизованных ключей для конкретного сервисного аккаунта. В параметре `--service-account-name` укажите имя сервисного аккаунта:

     ```bash
     yc iam key list --service-account-name <имя_сервисного_аккаунта>
     ```

     Результат:

     ```text
     +----------------------+-------------------------------------+-----------+---------------------+
     |          ID          |               SUBJECT               | ALGORITHM |     CREATED AT      |
     +----------------------+-------------------------------------+-----------+---------------------+
     | ajeave7oktut******** | serviceAccount:ajeedllrkjma******** | RSA_2048  | 2022-03-13 20:14:22 |
     | ajeb794igb80******** | serviceAccount:ajeedllrkjma******** | RSA_2048  | 2022-03-13 20:06:13 |
     +----------------------+-------------------------------------+-----------+---------------------+
     ```

  1. Удалите старый авторизованный ключ. Вместо `<идентификатор>` укажите идентификатор авторизованного ключа:

     ```bash
     yc iam key delete <идентификатор>
     ```

- API {#api}

  Чтобы удалить авторизованный ключ, воспользуйтесь методом REST API [delete](../../api-ref/Key/delete.md) для ресурса [Key](../../api-ref/Key/index.md) или вызовом gRPC API [KeyService/Delete](../../api-ref/grpc/key_service.md#Delete).

{% endlist %}