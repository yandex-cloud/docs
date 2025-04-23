---
title: How to get a list of refresh tokens
description: Follow this guide to get a list of user refresh tokens and their metadata.
---

# Getting a list of refresh tokens

To get a list of [refresh tokens](../../concepts/authorization/refresh-token.md) for a federated user:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. View the description of the command to view a list of refresh tokens:

      ```bash
      yc iam refresh-token list --help
      ```

  1. To view the list of refresh tokens, run this command:

      {% note info %}

      You can run the `yc iam refresh-token list` command without specifying any additional filter parameters. In this case, it will return a list of all refresh tokens for the user currently authenticated in the {{ yandex-cloud }} CLI.

      {% endnote %}

      ```bash
      yc iam refresh-token list \
        --subject-id <user_ID> \
        --client-id <OAuth_app_ID> \
        --client-instance-info <OAuth_app_version> \
        --protection-level <DPoP_protection_level>
      ```

      Where:

      * `--subject-id`: [ID](../../../organization/operations/users-get.md) of the federated user to get a list of refresh tokens for. This is an optional parameter. If not specified, the system will display a list of refresh tokens for the user currently authenticated in the {{ yandex-cloud }} CLI.

          By default, any [federated user](../../concepts/users/accounts.md#saml-federation) can view the list of their refresh tokens. To view the lists of other users’ refresh tokens, a user must have one of the following [roles](../../concepts/access-control/roles.md) for the organization: [organization-manager.admin](../../../organization/security/index.md#organization-manager-admin), [organization-manager.viewer](../../../organization/security/index.md#organization-manager-viewer), or [iam.userAccounts.refreshTokenViewer](../../security/index.md#iam-userAccounts-refreshTokenViewer).
      * `--client-id`: ID of the OAuth application you want to get a list of refresh tokens for, e.g., `yc.oauth.public-sdk` for the {{ yandex-cloud }} CLI. This is an optional parameter.
      * `--client-instance-info`: Version ID of the OAuth application you want to get a list of refresh tokens for, e.g., `yc/0.141.0`. This is an optional parameter.
      * `--protection-level`: [Protection level](../../concepts/authorization/refresh-token.md#dpop-verification) of the DPoP key for the refresh tokens you want to get the list of. This is an optional parameter. The possible values are as follows:

          * `INSECURE_KEY_DPOP`: The DPoP key is stored in the user’s local file system.
          * `SECURE_KEY_DPOP`: The DPoP key is stored on a YubiKey.
          * `NO_PROTECTION`: No DPoP key is used.

      Result:

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

  Use the [list](../../api-ref/RefreshToken/list.md) REST API method for the [RefreshToken](../../api-ref/RefreshToken/index.md) resource or the [RefreshTokenService/List](../../api-ref/grpc/RefreshToken/list.md) gRPC API call.

{% endlist %}