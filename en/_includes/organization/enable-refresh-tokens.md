{% list tabs group=instructions %}

- {{ cloud-center }} interface {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}) with an administrator or organization owner account.

      [Switch](../../organization/operations/manage-organizations.md#switch-to-another-org) to an organization of your choice as required.
  1. In the left-hand panel, select ![shield](../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud_org.pages.oslogin.title }}**.
  1. Under **Authentication settings**, check **Enable refresh tokens**.
  1. Optionally, to use enhanced refresh token [security](../../iam/concepts/authorization/refresh-token.md#dpop-verification) using DPoP keys with their obligatory storage on a [YubiKey](https://developers.yubico.com/Passkeys/), enable **Allow DPoP key storage only on YubiKeys**.

      With this option disabled, you can use DPoP keys saved both on a YubiKey and the user's local file system to ensure refresh token security.

{% endlist %}

To allow federated users to use refresh tokens in the {{ yandex-cloud }} CLI, each user must [initialize DPoP](../../iam/concepts/authorization/refresh-token.md#enabling-dpop) after you enable this option at the organization level.