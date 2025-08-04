---
title: Sending an email in {{ postbox-full-name }}
description: Follow this guide to send an email in {{ postbox-name }}.
---

# Sending an email

In {{ postbox-name }}, you can send an email using the [AWS CLI](#aws-cli-send), [AWS SDK](#aws-sdk-send), or from a mail client over [SMTP](#smtp-send).

{% include [tls](../../_includes/postbox/tls.md) %}

## Getting started {#before-begin}

1. [Create](../../iam/operations/sa/create.md) a service account in the folder as the address. If you create the service account and address in different folders, you will get an error when attempting to send an email.
1. [Assign](../../iam/operations/sa/assign-role-for-sa.md) the `postbox.sender` [role](../security/index.md#postbox-sender) to the service account.
1. Create a key for the service account:
    * To send an email over SMTP with API key authentication, [create](../../iam/operations/authentication/manage-api-keys.md#create-api-key) an API key. When creating an API key, set the scope for `yc.postbox.send`. Save the secret key you got in a secure location. You will not be able to view the secret key parameters again after you close the window.
    * To send an email using the AWS CLI or via SMTP with password authentication, [create](../../iam/operations/authentication/manage-access-keys.md#create-access-key) a static access key. Save the ID and secret key to a secure location. You will not be able to view the secret key parameters again after you close the window.
    * To send an email over SMTP with IAM token authentication, create an [IAM token](../../iam/operations/iam-token/create-for-sa.md).

        This authorization method is suitable for sending emails from [functions](../../functions/concepts/function.md) in {{ sf-name }} and [containers](../../serverless-containers/concepts/container.md) in {{ serverless-containers-name }}, as well as for {{ compute-name }} [VMs](../../compute/concepts/vm.md) linked to a service account. Select this method if you do not want to create and store static access keys.

        {% note warning %}

        Note that an IAM token is valid for up to 12 hours. If you need to provide authorization data in the mail client configuration file, use authentication by API key or password.

        {% endnote %}

## Send an email {#send-email}

### AWS CLI {#aws-cli-send}

{% include [send-email-aws](../../_includes/postbox/send-email-aws.md) %}

### SMTP {#smtp-send}

You can send emails via SMTP with authentication by:
* Service account API key.
* Password generated from the static access key of your service account.
* IAM token of your service account.

{% list tabs %}

- Authentication with an API key

    {% include [smtp-send-api](../../_includes/postbox/smtp-send-api.md) %}

- Password authentication

    {% include [smtp-send-python](../../_includes/postbox/smtp-send-python.md) %}

- IAM token authentication

    {% include [smtp-send-iam-token](../../_includes/postbox/smtp-send-iam-token.md) %}

{% endlist %}

### AWS SDK {#aws-sdk-send}

You can send an email using the AWS SDK for .NET Core, Go, JavaScript, and Python. For more details, see these tutorials:

* [{#T}](../../postbox/tutorials/send-emails-aws-sdk-csharp.md)
* [{#T}](../../postbox/tutorials/send-emails-aws-sdk-go.md)
* [{#T}](../../postbox/tutorials/send-emails-aws-sdk-js.md)
* [{#T}](../../postbox/tutorials/send-emails-aws-sdk-python.md)