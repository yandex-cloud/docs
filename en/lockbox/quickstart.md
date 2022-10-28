---
title: "Getting started with {{ lockbox-full-name }}"
description: "In this tutorial, you will learn how to create secrets and retrieve their contents using the {{ lockbox-full-name }} secret storage service. A secret consists of a set of versions that store your data. A version contains sets of keys and values. A key is an unclassified name for a value. to which you will identify it. The value is the secret. "
---

# Getting started with {{ lockbox-name }}

Create your first secret and get its content.

A secret is a set of versions that store your data. A version contains sets of keys and values:
* A key is a non-secret name that identifies a value.
* The value is your secret data.

Versions can't be changed. Whenever you need to change the number of key-value pairs or their content, you must create a new version.

## Creating secrets {#secrets}

{% include [secret-create](../_includes/lockbox/secret-create.md) %}

## Get the content of the secret {#get}

### Roles required to get a secret {#roles}

If you specified your {{ kms-short-name }} key when creating a secret, assign for it the [kms.keys.encrypterDecrypter](../kms/security/index.md#service) role: it's needed to encrypt and decrypt the secret.

### Get the content of the secret {#payload}

To get the content of the secret, access it using the API. If you make a request without specifying a version, the content of the current (latest) version is returned.

You can use this logic in scripts, services, and applications where you need to use the content of your secret.

{% list tabs %}

- API

   To get the content of the secret:
   1. [Get an IAM token]{% if product == "yandex-cloud" %}(../iam/operations/iam-token/create.md){% endif %}{% if product == "cloud-il" %}(../iam/operations/iam-token/create-for-federation.md){% endif %} required for authentication and save it to the variable:

      ```
      export IAM_TOKEN=`yc iam create-token`
      ```

      You can also get an IAM token for your service account from inside the VM that the token is linked to. To do this, send a request to the [metadata service](../compute/operations/vm-info/get-info.md#request-examples). An example with the [jq](https://stedolan.github.io/jq/) utility:

      ```
      export IAM_TOKEN=`curl -H Metadata-Flavor:Google http://169.254.169.254/computeMetadata/v1/instance/service-accounts/default/token | jq -r .access_token`
      ```

   1. Run the query:

      ```
      curl -X GET -H "Authorization: Bearer ${IAM_TOKEN}" \
      https://payload.lockbox.{{ api-host }}/lockbox/v1/secrets/<secret ID>/payload
      ```
{% endlist %}