---
title: "Getting started with Yandex Lockbox"
description: "In this tutorial, you will learn how to create secrets and retrieve their contents using the Yandex Lockbox secret storage service. A secret consists of a set of versions that store your data. A version contains sets of keys and values. A key is an unclassified name for a value. to which you will identify it. The value is the secret. "

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---


# Getting started with {{ lockbox-name }}

Create your first secret and get its content.

## Create a secret {#create}

A secret is a set of versions that store your data. A version contains sets of keys and values:

* A key is a non-secret name that identifies a value.
* The value is your secret data.

Versions can't be changed. Whenever you need to change the number of key-value pairs or their content, you must create a new version.

{% list tabs %}

- Management console

    To create a secret:

    1. In [management console]({{ link-console-main}}), select the folder to create a secret in.

    1. In the list of services, select **{{ lockbox-name }}**.

    1. Click **Create secret**.

    1. In the **Name** field, enter a name for the secret.

    1. (optional) In the **{{ kms-short-name }} key** field, specify an existing key or [create a new key](../kms/operations/key.md#create).

        The specified {{ kms-short-name }} key is used to encrypt your secret. If you omit the key, the secret is encrypted with a special system key.

        {% note tip %}

        By using your own [{{ kms-short-name }} key](../kms/concepts/key.md) you can take full advantage of {{ kms-full-name }}.

        {% endnote %}

    1. Under **Version**:
        * In the **Key** field, enter a non-secret ID.
        * In the **Value** field, enter the confidential data you want to store.
        * Click **Add value**.
        * (optional) Repeat the steps to add more data.

    1. Click **Save**.

{% endlist %}

## Get the content of the secret {#get}

### Roles required to get a secret {#roles}

If you specified your {{ kms-short-name }} key when creating a secret, assign for it the role [kms.keys.encrypterDecrypter](../kms/security/index.md#service): it's needed to encrypt and decrypt the secret.

### Get the content of the secret {#payload}

To get the content of the secret, access it using the API. If you make a request without specifying a version, the content of the current (latest) version is returned.

You can use this logic in scripts, services, and applications where you need to use the content of your secret.

{% list tabs %}

- API

    To get the content of the secret:

    1. [Get an IAM token](../iam/operations/iam-token/create.md) required for authentication and save it to the variable:

        ```
        export IAM_TOKEN=`yc iam create-token`
        ```

        You can also get an IAM token for your service account from inside the VM that the token is linked to. To do this, send a request to the [metadata service](../compute/operations/vm-info/get-info.md#request-examples). An example with the [jq](https://stedolan.github.io/jq/) utility:

        ```
        export IAM_TOKEN=`curl -H Metadata-Flavor:Google http://169.254.169.254/computeMetadata/v1/instance/service-accounts/default/token | jq -r .access_token`
        ```

    1. Run the request:

        ```
        curl -X GET -H "Authorization: Bearer ${IAM_TOKEN}" \
        https://payload.lockbox.api.cloud.yandex.net/lockbox/v1/secrets/<ID of the secret>/payload
        ```

{% endlist %}

