# Refresh token

A _refresh token_ is a type of credential that allows an OAuth application to automatically obtain a new IAM token after the user's [IAM token](./iam-token.md) expires. A refresh token is issued for a user and sent to an OAuth application, which then authenticates the user in {{ yandex-cloud }}.

An example of an OAuth application supporting refresh tokens is the [{{ yandex-cloud }} CLI](../../../cli/index.yaml). Refresh tokens can only be issued for [federated](../../../organization/concepts/add-federation.md) users in the [{{ org-full-name }} organization](../../../overview/roles-and-resources.md).

With the {{ yandex-cloud }} CLI and [API](../../api-ref/RefreshToken/index.md), you can [view](../../operations/refresh-token/list.md) the list of refresh tokens issued for a user and [revoke](../../operations/refresh-token/revoke.md) such tokens.

## Refresh token lifetime {#token-lifetime}

A refresh token is valid for 31 days. If used to obtain an IAM token, a refresh token is automatically reissued when there are less than seven days left before its expiration.

If your refresh token has expired, you must obtain a new one. A new refresh token will be created automatically when next obtain an IAM token. In this case, the user will have to re-authenticate in the browser. 

Refresh tokens are automatically deleted seven days after their expiration.

## Enabling the use of refresh tokens in the {{ yandex-cloud }} CLI {#token-enabling}

To use refresh tokens in the {{ yandex-cloud }} CLI, you must enable this option at the {{ org-name }} level. To do this:

{% include [enable-refresh-tokens](../../../_includes/organization/enable-refresh-tokens.md) %}

## Using DPoP to protect refresh tokens in the {{ yandex-cloud }} CLI {#dpop-verification}

The [DPoP](https://datatracker.ietf.org/doc/html/rfc9449) mechanism helps to prove that a request for an IAM token made with a refresh token is legitimate. This verification is based on a special DPoP key created on the user device to confirm the authenticity of both the user making the request and the source device.

If the **Allow DPoP key storage only on YubiKeys** option is [disabled](#token-enabling), to protect your refresh tokens, you can use DPoP keys saved both on a YubiKey and user's local file system (a less secure option).

To enhance the protection of refresh tokens, enable **Allow DPoP key storage only on YubiKeys** to only use DPoP keys stored on a specialized YubiKey device, which ensures the keys are not retrievable.

### Initializing DPoP protection for refresh tokens in the {{ yandex-cloud }} CLI {#enabling-dpop}

The DPoP key used to verify the user and device sending a request for an IAM token must be created on the user device. The mechanism for creating, storing, and using such a DPoP key must be implemented within an OAuth application that uses refresh tokens.

To initialize DPoP protection for a federated user's refresh tokens in the {{ yandex-cloud }} CLI:

1. Make sure the use of refresh tokens is [enabled](#token-enabling) in {{ org-name }} at your organization level.
1. Initialize DPoP protection for refresh tokens on the user device:

    {% list tabs group=instructions %}

    - {{ yandex-cloud }} CLI {#cli}

      1. [Create](../../../cli/operations/authentication/federated-user.md) a CLI profile for the federated user and authenticate as this user in {{ yandex-cloud }}.
      1. Initialize the DPoP protection:

          ```bash
          yc init --dpop
          ```

          The {{ yandex-cloud }} CLI will prompt you to configure the DPoP protection:
          
          ```text
          Welcome! This command will take you through the configuration process.
          Do you want to initialize file system auth keys? [y/N]
          ```
      1. Complete the configuration process. To do this, type `y` and press `ENTER`.

          Follow the configurator tips to generate and save a DPoP key in your local file system or a YubiKey.

    {% endlist %}

Once initialization is complete, a refresh token will be created for the user the next time they request a new IAM token. Later on, the {{ yandex-cloud }} CLI will automatically update IAM tokens for the federated user, requiring no regular authentication in the browser.

If the DPoP key is stored in the file system, the IAM token is reissued immediately. When using a YubiKey, the IAM token can only be reissued after confirming the action on the YubiKey.