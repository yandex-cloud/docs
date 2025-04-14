---
title: How to revoke a refresh token
description: Follow this guide to revoke refresh tokens.
---

# Revoking a refresh token

To revoke a [refresh token](../../concepts/authorization/refresh-token.md) for a federated user:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. View the description of the refresh token revocation command:

      ```bash
      yc iam refresh-token revoke --help
      ```
  1. To revoke certain refresh tokens, [get](./list.md) their IDs first.
  1. To revoke one or multiple refresh tokens for a user, run this command:

      {% note warning %}

      You can run the `yc iam refresh-token revoke` command without any additional parameters. In this case, it will revoke all refresh tokens for the user currently authenticated in the {{ yandex-cloud }} CLI.

      When revoking all refresh tokens for the current user, the `yc iam refresh-token revoke` command will first prompt you to confirm this action in the terminal.

      {% endnote %}

      ```bash
      yc iam refresh-token revoke \
        --refresh-token <refresh_token_body_in_stdin>
        --refresh-token-id <refresh_token_ID> \
        --subject-id <user_ID> \
        --client-id <OAuth_app_ID> \
        --client-instance-info <OAuth_app_version>
      ```

      Where:

      * `--refresh-token`: Body of the refresh token to revoke. Provide the value in the standard input stream, `stdin`. This is an optional parameter. Example of use:
      
          * To provide the token body in a string: `yc iam refresh-token revoke --refresh-token <<< "<refresh_token_body>"`.
          * To provide the token body in a file: `yc iam refresh-token revoke --refresh-token < <path_to_refresh_token_body_file>`. 
      
          You cannot use any other `yc iam refresh-token revoke` parameters together with `--refresh-token`. 
      * `--refresh-token-id`: ID of the refresh token to revoke. This is an optional parameter.

          You cannot use any other `yc iam refresh-token revoke` parameters together with `--refresh-token-id`.
      * `--subject-id`: [ID](../../../organization/operations/users-get.md) of the federated user whose refresh tokens you want to revoke. This is an optional parameter. If not specified, the system will revoke the refresh tokens for the user currently authenticated in the {{ yandex-cloud }} CLI.

          By default, any [federated user](../../concepts/users/accounts.md#saml-federation) can revoke their refresh tokens. To revoke refresh tokens of other users, a user must have one of the following [roles](../../concepts/access-control/roles.md) for the organization: [organization-manager.federations.userAdmin](../../../organization/security/index.md#organization-manager-federations-userAdmin) or [iam.userAccounts.refreshTokenRevoker](../../security/index.md#iam-userAccounts-refreshTokenRevoker).
      * `--client-id`: ID of the OAuth application you want to revoke refresh tokens for, e.g., `yc.oauth.public-sdk` for the {{ yandex-cloud }} CLI. This is an optional parameter.
      * `--client-instance-info`: Version ID of the OAuth application you want to revoke refresh tokens for, e.g., `yc/0.141.0`. This is an optional parameter.

      Result:

      ```text
      done (3s)
      refresh_token_ids:
        - dda5243b-34b9-415e-a534-fdb8********
        - 07998b66-9f3d-472b-9357-a904********
      ```

- API {#api}

  Use the [revoke](../../api-ref/RefreshToken/revoke.md) REST API method for the [RefreshToken](../../api-ref/RefreshToken/index.md) resource or the [RefreshTokenService/Revoke](../../api-ref/grpc/RefreshToken/revoke.md) gRPC API call.

{% endlist %}