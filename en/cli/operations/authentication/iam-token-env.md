---
title: Authenticating in the {{ yandex-cloud }} CLI with an IAM token from an environment variable
description: Follow this guide to get authenticated in the {{ yandex-cloud }} CLI using an IAM token stored in an environment variable.
---

# Authenticating in the {{ yandex-cloud }} CLI with an IAM token from an environment variable

An [IAM token](../../../iam/concepts/authorization/iam-token.md) is a unique sequence of characters used for authentication in {{ yandex-cloud }} that verifies the identity of a user or service account. IAM tokens are valid for a maximum of {{ iam-token-lifetime }}.

Authentication with an IAM token from the `YC_IAM_TOKEN` environment variable is a convenient option for scripts, CI/CD workflows, automated tests, containers, and temporary runtime environments where it is impractical to use interactive authentication or store credentials in the CLI profile. For automation, use the IAM token of a [service account](../../../iam/concepts/users/service-accounts.md) that has the required [roles](../../../iam/roles-reference.md). Configure a mechanism to issue a new IAM token before the current token expires.

{% note warning %}

Do not use the IAM token in source code or write it to logs. For CI/CD workflows, store the token in a secure secret vault.

If a token is compromised or no longer required, [revoke it](../../../iam/operations/iam-token/revoke-iam-token.md).

{% endnote %}

## Getting started {#before-you-begin}

1. [Install the {{ yandex-cloud }} CLI](../install-cli.md).
1. Get an IAM token.

    
    * [Yandex account](../../../iam/operations/iam-token/create.md)
    * [Service account](../../../iam/operations/iam-token/create-for-sa.md)
    * [Federated account](../../../iam/operations/iam-token/create-for-federation.md)
    * [Local user account](../../../iam/operations/iam-token/create-for-local.md)


## Authenticate with an IAM token {#authenticate}

1. Add your IAM token to the `YC_IAM_TOKEN` environment variable:

    {% list tabs group=operating_system %}

    - macOS/Linux {#linux-macos}

      ```bash
      export YC_IAM_TOKEN="<IAM_token>"
      ```

    - Windows (PowerShell) {#windows}

      ```powershell
      $env:YC_IAM_TOKEN = "<IAM_token>"
      ```

    {% endlist %}

    The variable will be available in the current shell session and its child processes. 
    
    {% note warning %}
    
    The value from the `YC_IAM_TOKEN` environment variable overrides the authentication credentials specified in the CLI profile.

    {% endnote %}

1. Run a CLI command, e.g., to get a list of VMs within a folder:

    ```bash
    yc compute instance list
    ```

## Delete the IAM token from the environment variable {#delete-token}

To enable the CLI to use the profile credentials again, delete the `YC_IAM_TOKEN` environment variable:

{% list tabs group=operating_system %}

- macOS/Linux {#linux-macos}

  ```bash
  unset YC_IAM_TOKEN
  ```

- Windows (PowerShell) {#windows}

  ```powershell
  Remove-Item Env:YC_IAM_TOKEN
  ```

{% endlist %}

{% note warning %}

Deleting the environment variable does not invalidate the IAM token.

{% endnote %}

#### Useful links {#see-also}


* [{#T}](../../../iam/concepts/authorization/iam-token.md)
* [{#T}](../../../iam/operations/iam-token/create.md)
* [{#T}](../../../iam/operations/iam-token/create-for-sa.md)
* [{#T}](../../../iam/operations/iam-token/create-for-federation.md)
* [{#T}](../../../iam/operations/iam-token/create-for-local.md)
* [{#T}](../../../iam/operations/iam-token/revoke-iam-token.md)


* [{#T}](./user.md)
* [{#T}](./service-account.md)
* [{#T}](./federated-user.md)
* [{#T}](./local-user.md)
* [{#T}](./auth-without-gui.md)
* [{#T}](../../error.md)
