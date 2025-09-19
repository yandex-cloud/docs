---
title: Sending an email in {{ postbox-full-name }}
description: Follow this guide to send an email in {{ postbox-name }}.
---

# Sending an email

In {{ postbox-name }}, you can send an email:
* Using the [AWS CLI](#aws-cli).
* From a mail client via [SMTP](#smtp).
* Using the [AWS SDK](#aws-sdk).
* Using [cURL](#curl).

{% include [tls](../../_includes/postbox/tls.md) %}

## Getting started {#before-begin}

1. [Create](../../iam/operations/sa/create.md) a service account in the folder as the address. If you create the service account and address in different folders, you will get an error when attempting to send an email.
1. [Assign](../../iam/operations/sa/assign-role-for-sa.md) the `postbox.sender` [role](../security/index.md#postbox-sender) to the service account.
1. Create a key for the service account:

    * [API key](../../iam/operations/authentication/manage-api-keys.md#create-api-key). When creating an API key, set the scope for `yc.postbox.send`. Save the secret key you got in a secure location. You will not be able to view the secret key parameters again after you close the window.

    * [Static access key](../../iam/operations/authentication/manage-access-keys.md#create-access-key). Save the ID and secret key to a secure location. You will not be able to view the secret key parameters again after you close the window.

    * [IAM token](../../iam/operations/iam-token/create-for-sa.md). This authorization method is suitable for sending emails from [functions](../../functions/concepts/function.md) in {{ sf-name }} and [containers](../../serverless-containers/concepts/container.md) in {{ serverless-containers-name }}, as well as for {{ compute-name }} [VMs](../../compute/concepts/vm.md) linked to a service account. Select this method if you do not want to create and store static access keys.

        {% note warning %}

        Note that an IAM token is valid for up to 12 hours. If you need to provide authorization data in the mail client configuration file, use authentication by API key or password.

        {% endnote %}

    Available combinations of authentication and emailing methods:

    ![arrow_right](../../_assets/console-icons/arrow-right.svg)<br>**Emailing method**<br>**Authentication method**<br>![arrow_down](../../_assets/console-icons/arrow-down.svg) | **AWS CLI** | **SMTP** | **AWS SDK** | **cURL**
    :---: | --- | --- | --- | ---
    |**API_key** | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) ||
    **Static access key** | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) ||
    **IAM_token** | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg)

## Sending an email {#send-email}

### AWS CLI {#aws-cli}

{% list tabs %}

- Static access key

    {% include [send-email-aws](../../_includes/postbox/send-email-aws.md) %}

{% endlist %}

### SMTP {#smtp}

{% list tabs group=auth_keys %}

- API key {#api-key}

    {% include [smtp-send-api](../../_includes/postbox/smtp-send-api.md) %}

- Static access key {#static-key}

    {% include [smtp-send-python](../../_includes/postbox/smtp-send-python.md) %}

- IAM token {#iam-token}

    {% include [smtp-send-iam-token](../../_includes/postbox/smtp-send-iam-token.md) %}

{% endlist %}

### AWS SDK {#aws-sdk}

You can send an email using the AWS SDK for .NET Core, Go, JavaScript, and Python. For more details, see these tutorials:

* [{#T}](../../postbox/tutorials/send-emails-aws-sdk-csharp.md)
* [{#T}](../../postbox/tutorials/send-emails-aws-sdk-go.md)
* [{#T}](../../postbox/tutorials/send-emails-aws-sdk-js.md)
* [{#T}](../../postbox/tutorials/send-emails-aws-sdk-python.md)

### cURL {#curl}

To send an email using [cURL](https://curl.se/), run this command:

{% list tabs %}

- Static access key

    ```bash
    curl \
        --request POST \
        --url '{{ postbox-endpoint }}/v2/email/outbound-emails' \
        --header 'Content-Type: application/json' \
        --user "${KEY_ID}:${SECRET_KEY}" \
        --aws-sigv4 "aws:amz:ru-central1:ses" \
        --data-binary '@email.json'
    ```

- IAM token

    ```bash
    curl \
        --request POST \
        --url '{{ postbox-endpoint }}/v2/email/outbound-emails' \
        --header 'Content-Type: application/json' \
        --header 'X-YaCloud-SubjectToken: <IAM_token>' \
        --data '{
            "FromEmailAddress": "<sender>",
            "Destination": {
                "ToAddresses": ["<recipient>"]
            },
            "Content": {
                "Simple": {
                    "Subject": {
                        "Data": "<subject>"
                    },
                    "Body": {
                        "Text": {
                            "Data": "<email text>"
                        }
                    }
                }
            }
        }'
    ```

{% endlist %}

You can provide the [request](../../postbox/aws-compatible-api/api-ref/send-email.md) body in the command line argument or file.

{% cut "File example" %}

```json
{
    "FromEmailAddress": "<sender>",
    "Destination": {
        "ToAddresses": ["<recipient>"]
    },
    "Content": {
        "Simple": {
            "Subject": {
                "Data": "<subject>"
            },
            "Body": {
                "Text": {
                    "Data": "<email text>"
                }
            }
        }
    }
}
```

{% endcut %}

To use [AWS Signature Version 4](https://docs.amazonaws.cn/en_us/IAM/latest/UserGuide/reference_aws-signing.html) to sign a request, specify the `--aws-sigv4` parameter. To learn how to create a signature by yourself, see [{#T}](../../postbox/aws-compatible-api/signing-requests.md).
