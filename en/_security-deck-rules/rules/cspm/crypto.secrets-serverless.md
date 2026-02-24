### Lockbox secrets are used for Serverless Containers and Cloud Functions {#secrets-serverless}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | medium | crypto.secrets-serverless ||
|#

#### Description

{% note tip "**Automatic verification**" %}

This control automatically checks for the use of Lockbox secrets in serverless functions and containers.

{% endnote %}

When working with Serverless Containers or Cloud Functions, it is often necessary to use a secret (such as a token or password).

If you specify secret information in environment variables, it can be viewed by any cloud user with permissions to view and use a function, which causes information security risks.

We recommend using Serverless integration with Lockbox for that. You can use a specific secret from Yandex Lockbox and a service account with access rights to this secret to use it in a function or container.

Make sure that the secrets are used as described above.

#### Guides and solutions

* Delete secret data from env and use the Lockbox integration functionality:
  * Transmitting Yandex Lockbox secrets to a container: <https://yandex.cloud/en/docs/serverless-containers/operations/lockbox-secret-transmit>
  * Transmitting Yandex Lockbox secrets to a function: <https://yandex.cloud/en/docs/functions/operations/function/lockbox-secret-transmit>
