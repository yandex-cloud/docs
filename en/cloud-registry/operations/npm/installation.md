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
          1. Add the following lines to the previously created `.npmrc` file:

              ```text
              registry=https://{{ cloud-registry }}/npm/<registry_ID>
              //{{ cloud-registry }}/npm/:_auth=${NPM_AUTH}
              always-auth=true
              ```
          1. Create the `NPM_AUTH` environment variable containing the [Base64-encoded](https://www.base64encode.org/) `iam:<IAM_token>` line:

              ```bash
              export NPM_AUTH=$(echo -n 'iam:<IAM_token>' | base64)
              ```

              Where `<IAM_token>` is the IAM token you got earlier.

        - IAM_token

          1. Get an [IAM token](../../../iam/concepts/authorization/iam-token.md) for the [Yandex account](../../../iam/operations/iam-token/create.md) or [service account](../../../iam/operations/iam-token/create-for-sa.md) you are going to use for authentication.
          1. Add the following lines to the previously created `.npmrc` file:

              ```text
              registry=https://{{ cloud-registry }}/npm/<registry_ID>
              //{{ cloud-registry }}/npm/:_authToken=${NPM_AUTH_TOKEN}
              always-auth=true
              ```
          1. Create the `NPM_AUTH_TOKEN` environment variable containing the previously obtained IAM token:

              ```bash
              export NPM_AUTH_TOKEN="<IAM_token>"
              ```

        - OAuth token (Base64)

          1. [Get]({{ link-cloud-oauth }}) an OAuth token for the Yandex account you are going to use for authentication.
          1. Add the following lines to the previously created `.npmrc` file:

              ```text
              registry=https://{{ cloud-registry }}/npm/<registry_ID>
              //{{ cloud-registry }}/npm/:_auth=${NPM_AUTH}
              always-auth=true
              ```
          1. Create the `NPM_AUTH` environment variable containing the [Base64-encoded](https://www.base64encode.org/) `oauth:<OAuth_token>` line:

              ```bash
              export NPM_AUTH=$(echo -n 'oauth:<OAuth token>' | base64)
              ```

              Where `<OAuth_token>` is the [OAuth token](../../../iam/concepts/authorization/oauth-token.md) you got earlier.

        {% endlist %}