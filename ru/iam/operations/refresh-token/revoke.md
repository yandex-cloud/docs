---
title: Как отозвать refresh-токен
description: Следуя данной инструкции, вы сможете отзывать refresh-токены.
---

# Отзыв refresh-токена

Чтобы отозвать [refresh-токен](../../concepts/authorization/refresh-token.md) федеративного пользователя:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. Посмотрите описание команды отзыва refresh-токена:

      ```bash
      yc iam refresh-token revoke --help
      ```
  1. Если вы хотите отозвать определенные refresh-токены, [получите](./list.md) их идентификаторы.
  1. Чтобы отозвать refresh-токен или несколько refresh-токенов пользователя, выполните команду:

      {% note warning %}

      Команду `yc iam refresh-token revoke` можно выполнять без указания дополнительных параметров. В этом случае она отзовет все refresh-токены пользователя, аутентифицированного в текущий момент в {{ yandex-cloud }} CLI.

      При отзыве всех refresh-токенов текущего пользователя команда `yc iam refresh-token revoke` дополнительно запрашивает подтверждение выполнения этого действия в терминале.

      {% endnote %}

      ```bash
      yc iam refresh-token revoke \
        --refresh-token <тело_refresh-токена_в_stdin>
        --refresh-token-id <идентификатор_refresh-токена> \
        --subject-id <идентификатор_пользователя> \
        --client-id <идентификатор_OAuth-приложения> \
        --client-instance-info <версия_OAuth-приложения>
      ```

      Где:

      * `--refresh-token` — тело refresh-токена, который вы хотите отозвать. Значение должно передаваться через стандартный поток ввода (`stdin`). Необязательный параметр. Примеры использования:
      
          * Передача тела токена в строке — `yc iam refresh-token revoke --refresh-token <<< "<тело_refresh-токена>"`.
          * Передача тела токена в файле — `yc iam refresh-token revoke --refresh-token < <путь_к_файлу_с_телом_refresh-токена>`. 
      
          Использование параметра `--refresh-token` делает невозможным использование любых других параметров команды `yc iam refresh-token revoke`. 
      * `--refresh-token-id` — идентификатор refresh-токена, который вы хотите отозвать. Необязательный параметр.

          Использование параметра `--refresh-token-id` делает невозможным использование любых других параметров команды `yc iam refresh-token revoke`.
      * `--subject-id` — [идентификатор](../../../organization/operations/users-get.md) федеративного пользователя, refresh-токены которого вы хотите отозвать. Необязательный параметр. Если параметр не задан, будут отозваны refresh-токены пользователя, аутентифицированного в данный момент в {{ yandex-cloud }} CLI.

          По умолчанию любой [федеративный пользователь](../../concepts/users/accounts.md#saml-federation) может отзывать свои refresh-токены. Отзывать refresh-токены других пользователей могут пользователи, обладающие одной из следующих [ролей](../../concepts/access-control/roles.md) на организацию: [organization-manager.federations.userAdmin](../../../organization/security/index.md#organization-manager-federations-userAdmin) или [iam.userAccounts.refreshTokenRevoker](../../security/index.md#iam-userAccounts-refreshTokenRevoker).
      * `--client-id` — идентификатор OAuth-приложения, refresh-токены для которого вы хотите отозвать. Например: идентификатор {{ yandex-cloud }} CLI — `yc.oauth.public-sdk`. Необязательный параметр.
      * `--client-instance-info` — идентификатор версии OAuth-приложения, refresh-токены для которого вы хотите отозвать. Например: `yc/0.141.0`. Необязательный параметр.

      Результат:

      ```text
      done (3s)
      refresh_token_ids:
        - dda5243b-34b9-415e-a534-fdb8********
        - 07998b66-9f3d-472b-9357-a904********
      ```

- API {#api}

  Воспользуйтесь методом REST API [revoke](../../api-ref/RefreshToken/revoke.md) для ресурса [RefreshToken](../../api-ref/RefreshToken/index.md) или вызовом gRPC API [RefreshTokenService/Revoke](../../api-ref/grpc/RefreshToken/revoke.md).

{% endlist %}