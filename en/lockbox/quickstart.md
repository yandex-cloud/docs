---
title: "Getting started with {{ lockbox-full-name }}"
description: "In this tutorial, you'll learn how to create secrets and get their contents using {{ lockbox-full-name }}, a service for storing secrets. A secret is a set of versions that store your data. A version contains sets of keys and values. A key is a non-secret name that identifies a value. The value is your secret data."
---

# Getting started with {{ lockbox-name }}


Create your first secret and get its content.

A secret is a set of versions that store your data. A version contains sets of keys and values:
* A key is a non-secret name that identifies a value.
* The value is your secret data.

Versions can't be changed. Whenever you need to change the number of key-value pairs or their content, you must create a new version.

## Creating secrets {#secret}

{% include [secret-create](../_includes/lockbox/secret-create.md) %}

## Get the content of the secret {#get}

### Roles required to get a secret {#roles}

{% include [lockbox-and-kms-roles](../_includes/lockbox/lockbox-and-kms-roles.md) %}

### Get the content of the secret {#payload}

To get the content of the secret, access it using the API. If you make a request without specifying a version, the content of the current (latest) version is returned.

You can use this logic in scripts, services, and applications where you need to use the content of your secret.

{% list tabs group=instructions %}

- CLI {#cli}

   {% include [cli-install](../_includes/cli-install.md) %}

   {% include [default-catalogue](../_includes/default-catalogue.md) %}

   1. View a description of the CLI command to get the contents of a secret:

      ```bash
      yc lockbox payload get --help
      ```

   1. {% include [get-secret-id](../_includes/lockbox/get-secret-id.md) %}

   1. Run this command:

      ```bash
      yc lockbox payload get \
        --id <secret_ID> \
        --key <secret_key> \
        --version-id <secret_version_ID>
      ```

      Where:

      * `--id`: Secret ID. This is a required parameter.
      * `--key`: Secret contents key required to get the single value. This is an optional parameter.
      * `--version-id`: Secret version. This is an optional parameter. Defaults to the current secret version.

      An example of a command used to get the contents of a secret:

      ```bash
      yc lockbox payload get \
        --id e6qetpqfe8vv******** \
        --version-id e6qqr7k79ecm********
      ```

      In this example, you get the contents of a `e6qqr7k79ecm********` version secret.

      Result:

      ```bash
      version_id: e6qqr7k79ecm********
      entries:
        - key: first_key
          text_value: value_1
        - key: second_key
          text_value: value_2
      ```

- API {#api}

   To get the content of the secret:
   1. [Get an IAM token](../iam/operations/iam-token/create.md) required for authentication and save it to the variable:

      ```
      export IAM_TOKEN=$(yc iam create-token)
      ```

      You can also get an IAM token for your service account from inside the VM the token is linked to. To do this, send a request to the [metadata service](../compute/operations/vm-info/get-info.md#request-examples). An example with the [jq](https://stedolan.github.io/jq/) utility:

      ```
      export IAM_TOKEN=$(curl -H Metadata-Flavor:Google http://169.254.169.254/computeMetadata/v1/instance/service-accounts/default/token | jq -r .access_token)
      ```

   1. Run the following query:

      ```
      curl -X GET -H "Authorization: Bearer ${IAM_TOKEN}" \
      https://{{ api-host-lockbox-payload }}/lockbox/v1/secrets/<secret_ID>/payload
      ```
{% endlist %}
