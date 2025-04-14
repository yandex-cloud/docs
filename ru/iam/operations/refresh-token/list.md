---
title: Как получить список refresh-токенов
description: Следуя данной инструкции, вы сможете получить список и метаданные refresh-токенов пользователя.
---

# Получение списка refresh-токенов

Чтобы получить список [refresh-токенов](../../concepts/authorization/refresh-token.md) федеративного пользователя:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. Посмотрите описание команды просмотра списка refresh-токенов:

      ```bash
      yc iam refresh-token list --help
      ```

  1. Чтобы посмотреть список refresh-токенов, выполните команду:

      {% note info %}

      Команду `yc iam refresh-token list` можно выполнять без указания дополнительных параметров-фильтров. В этом случае она выведет список всех refresh-токенов пользователя, аутентифицированного в текущий момент в {{ yandex-cloud }} CLI.

      {% endnote %}

      ```bash
      yc iam refresh-token list \
        --subject-id <идентификатор_пользователя> \
        --client-id <идентификатор_OAuth-приложения> \
        --client-instance-info <версия_OAuth-приложения> \
        --protection-level <уровень_защиты_DPoP>
      ```

      Где:

      * `--subject-id` — [идентификатор](../../../organization/operations/users-get.md) федеративного пользователя, список refresh-токенов которого вы хотите получить. Необязательный параметр. Если параметр не задан, будет выведен список refresh-токенов пользователя, аутентифицированного в данный момент в {{ yandex-cloud }} CLI.

          По умолчанию любой [федеративный пользователь](../../concepts/users/accounts.md#saml-federation) может просматривать список своих refresh-токенов. Просматривать списки refresh-токенов других пользователей могут пользователи, обладающие одной из следующих [ролей](../../concepts/access-control/roles.md) на организацию: [organization-manager.admin](../../../organization/security/index.md#organization-manager-admin), [organization-manager.viewer](../../../organization/security/index.md#organization-manager-viewer) или [iam.userAccounts.refreshTokenViewer](../../security/index.md#iam-userAccounts-refreshTokenViewer).
      * `--client-id` — идентификатор OAuth-приложения, список refresh-токенов для которого вы хотите получить. Например: идентификатор {{ yandex-cloud }} CLI — `yc.oauth.public-sdk`. Необязательный параметр.
      * `--client-instance-info` — идентификатор версии OAuth-приложения, список refresh-токенов для которого вы хотите получить. Например: `yc/0.141.0`. Необязательный параметр.
      * `--protection-level` — [уровень защиты](../../concepts/authorization/refresh-token.md#dpop-verification) DPoP-ключа refresh-токенов, список которых вы хотите получить. Необязательный параметр. Возможные значения:

          * `INSECURE_KEY_DPOP` — DPoP-ключ хранится в файловой системе компьютера пользователя.
          * `SECURE_KEY_DPOP` — DPoP-ключ хранится на устройстве YubiKey.
          * `NO_PROTECTION` — DPoP-ключ не используется.

      Результат:

      ```text
      Please touch yubikey OK
      +--------------------------------------+----------------------+----------------------+----------------------+---------------------+---------------------+---------------------+------------------+
      |                  ID                  |      SUBJECT ID      |      CLIENT ID       | CLIENT INSTANCE INFO |     CREATED AT      |     EXPIRES AT      |    LAST USED AT     | PROTECTION LEVEL |
      +--------------------------------------+----------------------+----------------------+----------------------+---------------------+---------------------+---------------------+------------------+
      | e2675ad9-f51b-48c7-96f4-90ff******** | bfbud0oddqnn******** | yc.oauth.public-sdk  | yc/0.141.0           | 2025-01-28 14:44:00 | 2025-02-28 14:44:00 | 2025-01-28 14:44:00 | SECURE_KEY_DPOP  |
      | 8799515e-1c2e-4530-985e-ce43******** | bfbud0oddqnn******** | yc.oauth.public-sdk  | yc/0.141.0           | 2025-01-28 14:41:00 | 2025-02-28 14:41:00 | 2025-01-28 14:42:26 | SECURE_KEY_DPOP  |
      | d4c16879-5e64-40b0-9ee3-ed6a******** | bfbud0oddqnn******** | yc.oauth.public-sdk  | yc/0.141.0           | 2024-12-26 08:34:47 | 2025-01-26 08:34:47 | 2024-12-26 08:34:47 | SECURE_KEY_DPOP  |
      +--------------------------------------+----------------------+----------------------+----------------------+---------------------+---------------------+---------------------+------------------+
      ```

- API {#api}

  Воспользуйтесь методом REST API [list](../../api-ref/RefreshToken/list.md) для ресурса [RefreshToken](../../api-ref/RefreshToken/index.md) или вызовом gRPC API [RefreshTokenService/List](../../api-ref/grpc/RefreshToken/list.md).

{% endlist %}