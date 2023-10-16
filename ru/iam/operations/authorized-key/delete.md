---
title: "Как удалить авторизованные ключи в {{ iam-full-name }}"
description: "Из статьи вы узнаете, как удалить авторизованные ключи в {{ iam-full-name }} через консоль управления, CLI и API сервиса."
---

# Удаление авторизованного ключа

{% list tabs %}

- Консоль управления

  1. Перейдите в каталог, которому принадлежит сервисный аккаунт.
  1. В верхней части экрана перейдите на вкладку **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}**.
  1. Выберите сервисный аккаунт и нажмите на строку с его именем.
  1. В блоке **{{ ui-key.yacloud.iam.folder.service-account.overview.section_keys }}** напротив ключа, который нужно удалить, нажмите значок ![image](../../../_assets/options.svg) и выберите пункт **{{ ui-key.yacloud.iam.folder.service-account.overview.button_action-delete }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-confirm_button_delete }}**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. Получите список с идентификаторами `ID` авторизованных ключей для конкретного сервисного аккаунта. В параметре `--service-account-name` укажите имя сервисного аккаунта:

     ```bash
     yc iam key list --service-account-name <имя сервисного аккаунта>
     ```

     Результат:

     ```text
     +----------------------+-------------------------------------+-----------+---------------------+
     |          ID          |               SUBJECT               | ALGORITHM |     CREATED AT      |
     +----------------------+-------------------------------------+-----------+---------------------+
     | ajeave7oktutd6kha7lq | serviceAccount:ajeedllrkjmam6jsn9n4 | RSA_2048  | 2022-03-13 20:14:22 |
     | ajeb794igb80sl0fbpvp | serviceAccount:ajeedllrkjmam6jsn9n4 | RSA_2048  | 2022-03-13 20:06:13 |
     +----------------------+-------------------------------------+-----------+---------------------+
     ```

  1. Удалите старый авторизованный ключ. Вместо `<ID>` укажите идентификатор авторизованного ключа:

     ```bash
     yc iam key delete <ID>
     ```

- API

  Чтобы удалить авторизованный ключ, воспользуйтесь методом REST API [delete](../../api-ref/Key/delete.md) для ресурса [Key](../../api-ref/Key/index.md) или вызовом gRPC API [KeyService/Delete](../../api-ref/grpc/key_service.md#Delete).

{% endlist %}