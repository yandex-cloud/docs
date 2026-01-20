---
title: Setting up npm
description: Follow this guide to configure npm.
---

# Setting up npm

To do the setting up:

* For all projects: run this command:

    `npm config set registry https://{{ cloud-registry }}/npm/<registry_ID>`

* For one project:

    1. Open the `.npmrc` file in the project root.
    1. Depending on the authentication method:

        {% list tabs %}

        - IAM token (Base64)

          1. Get an [IAM token](../../../iam/concepts/authorization/iam-token.md) for the [Yandex account](../../../iam/operations/iam-token/create.md) or [service account](../../../iam/operations/iam-token/create-for-sa.md) you are going to use for authentication.
          1. Create the `NPM_AUTH` environment variable:

              ```bash
              export NPM_AUTH=$(echo -n 'iam:<IAM_token>' | base64)
              ```

              Where `NPM_AUTH` is the body of the previously obtained IAM token, [Base64](https://www.base64encode.org/)-encoded.

          1. Add the following lines to the previously created `.npmrc` file:

              ```text
              registry=https://{{ cloud-registry }}/npm/<registry_ID>
              //{{ cloud-registry }}/npm/:_auth=${NPM_AUTH}
              always-auth=true
              ```

        - IAM_token

          1. Get an [IAM token](../../../iam/concepts/authorization/iam-token.md) for the [Yandex account](../../../iam/operations/iam-token/create.md) or [service account](../../../iam/operations/iam-token/create-for-sa.md) you are going to use for authentication.
          1. Create the `NPM_AUTH` environment variable:

              ```bash
              export NPM_AUTH="<IAM_token>"
              ```

              Where `NPM_AUTH` is the body of the previously obtained IAM token.

          1. Add the following lines to the previously created `.npmrc` file:

              ```text
              registry=https://{{ cloud-registry }}/npm/<registry_ID>
              //{{ cloud-registry }}/npm/:_authToken=${NPM_AUTH}
              always-auth=true
              ```

        - OAuth token (Base64)

          1. [Get]({{ link-cloud-oauth }}) an OAuth token for the [Yandex account](../../../iam/concepts/users/accounts.md#passport) you are going to use for authentication.
          1. Create the `NPM_AUTH` environment variable:

              ```bash
              export NPM_AUTH=$(echo -n 'oauth:<OAuth_token>' | base64)
              ```

              Where `NPM_AUTH` is the body of the previously obtained [OAuth token](../../../iam/concepts/authorization/oauth-token.md), [Base64](https://www.base64encode.org/)-encoded.

          1. Add the following lines to the previously created `.npmrc` file:

              ```text
              registry=https://{{ cloud-registry }}/npm/<registry_ID>
              //{{ cloud-registry }}/npm/:_auth=${NPM_AUTH}
              always-auth=true
              ```

        - API key (Base64)

          1. [Create](../../../iam/operations/authentication/manage-api-keys.md#create-api-key) an API key for the [service account](../../../iam/concepts/users/service-accounts.md) you are going to use for authentication.
          1. Create the `NPM_AUTH` environment variable:

              ```bash
              export NPM_AUTH=$(echo -n 'api_key:<API_key>' | base64)
              ```

              Where `NPM_AUTH` is the body of the previously created [API key](../../../iam/concepts/authorization/api-key.md), [Base64](https://www.base64encode.org/)-encoded.

          1. Add the following lines to the previously created `.npmrc` file:

              ```text
              registry=https://{{ cloud-registry }}/npm/<registry_ID>
              //{{ cloud-registry }}/npm/:_auth=${NPM_AUTH}
              always-auth=true
              ```

        {% endlist %}