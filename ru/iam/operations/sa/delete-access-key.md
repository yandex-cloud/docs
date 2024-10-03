---
title: Как удалить статические ключи доступа в {{ iam-full-name }}
description: Из статьи вы узнаете, как удалить статические ключи доступа в {{ iam-full-name }} через консоль управления, CLI и API сервиса.
---

# Удаление статических ключей доступа

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в каталог, которому принадлежит сервисный аккаунт.
  1. В верхней части экрана перейдите на вкладку **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}**.
  1. Выберите сервисный аккаунт и нажмите на строку с его именем.
  1. В блоке **{{ ui-key.yacloud.iam.folder.service-account.overview.section_service-account-keys }}** напротив ключа, который нужно удалить, нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.iam.folder.service-account.overview.button_action-delete-api-key }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-confirm_button_delete }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. Получите список с идентификаторами `ID` статических ключей для конкретного сервисного аккаунта. В параметре `--service-account-name` укажите имя сервисного аккаунта:

     ```bash
     yc iam access-key list --service-account-name <имя_сервисного_аккаунта>
     ```

     Результат:

     ```text
     +----------------------+----------------------+----------------------+
     |          ID          |  SERVICE ACCOUNT ID  |        KEY ID        |
     +----------------------+----------------------+----------------------+
     | aje8bdtqec6l******** | ajeedllrkjma******** | R9JK04o1Dfaf******** |
     | ajegqpa91bta******** | ajeedllrkjma******** | cWXGkDoBRho5******** |
     +----------------------+----------------------+----------------------+
     ```

  1. Удалите старый статический ключ. Вместо `<идентификатор>` укажите идентификатор статического ключа:

     ```bash
     yc iam access-key delete <идентификатор>
     ```

- API {#api}

  Чтобы удалить статический ключ, воспользуйтесь методом REST API [delete](../../api-ref/AccessKey/delete.md) для ресурса [AccessKey](../../api-ref/AccessKey/index.md) или вызовом gRPC API [AccessKeyService/Delete](../../api-ref/grpc/access_key_service.md#Delete).

{% endlist %}