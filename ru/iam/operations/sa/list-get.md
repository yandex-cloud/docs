---
title: Получение списка сервисных аккаунтов каталога
description: С помощью этой инструкции вы научитесь просматривать список сервисных аккаунтов каталога.
---

# Получение списка сервисных аккаунтов каталога

Вы можете получить список всех [сервисных аккаунтов](../../concepts/users/service-accounts.md), имеющихся в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, список сервисных аккаунтов которого вы хотите получить.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. На панели слева выберите ![FaceRobot](../../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}**.
  1. На странице **{{ ui-key.yacloud.iam.folder.service-accounts.label_title }}** отобразится список всех сервисных аккаунтов каталога.

   ![Список сервисных аккаунтов](../../../_assets/iam/sa-list-get.png)

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Получите список сервисных аккаунтов в каталоге по умолчанию:

  ```bash
  yc iam service-account list
  ```

  Результат:

  ```
  +----------------------+--------------+--------+---------------------+-----------------------+
  |          ID          |     NAME     | LABELS |     CREATED AT      | LAST AUTHENTICATED AT |
  +----------------------+--------------+--------+---------------------+-----------------------+
  | ajeg2b2et02f******** | my-robot     |        | 2024-09-08 18:59:45 | 2025-02-18 10:10:00   |
  | ajegtlf2q28a******** | account-name |        | 2023-06-27 16:18:18 | 2025-02-18 10:20:00   |
  +----------------------+--------------+--------+---------------------+-----------------------+
  ```

  Где:

  * `ID` — идентификатор сервисного аккаунта.
  * `NAME` — имя сервисного аккаунта.
  * `LABELS` — описание сервисного аккаунта.
  * `CREATED AT` — дата и время создания сервисного аккаунта.
  * `LAST AUTHENTICATED AT` — дата и время последней аутентификации.

- API {#api}

  1. [Узнайте идентификатор каталога](../../../resource-manager/operations/folder/get-id.md), список сервисных аккаунтов которого вы хотите просмотреть.
  1. Получите список сервисных аккаунтов в каталоге с помощью метода REST API [list](../../api-ref/ServiceAccount/list.md) для ресурса [ServiceAccount](../../api-ref/ServiceAccount/index.md):

      ```bash
      export FOLDER_ID=b1gvmob95yys********
      export IAM_TOKEN=CggaATEVAgA...
      curl \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
        "https://iam.{{ api-host }}/iam/v1/serviceAccounts?folderId=${FOLDER_ID}"
      ```

      Результат:

      ```text
      {
       "serviceAccounts": [
        {
         "id": "ajeg2b2et02f********",
         "folderId": "b1gvmob95yys********",
         "createdAt": "2024-09-08T18:59:45Z",
         "name": "my-robot",
         "lastAuthenticatedAt": "2025-02-18T10:10:00Z"
        },
        {
         "id": "ajegtlf2q28a********",
         "folderId": "b1gvmob95yys********",
         "createdAt": "2023-06-27T16:18:18Z",
         "name": "account-name",
         "lastAuthenticatedAt": "2025-02-18T10:20:00Z"
        }
       ]
      }
      ```

     Список сервисных аккаунтов в каталоге можно также получить с помощью вызова gRPC API [ServiceAccountService/List](../../api-ref/grpc/ServiceAccount/list.md).

{% endlist %}