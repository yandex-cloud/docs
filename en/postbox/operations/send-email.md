---
title: Sending an email in {{ postbox-full-name }}
description: Follow this guide to send an email in {{ postbox-name }}.
---

# Sending an email

In {{ postbox-name }}, you can send an email using the [AWS CLI](#aws-cli-send) or from your email client over [SMTP](#smtp-send).


## Getting started {#before-begin}

1. [Create](../../iam/operations/sa/create.md) a service account in the folder as the address. If you create the service account and address in different folders, you will get an error when attempting to send an email.
1. [Assign](../../iam/operations/sa/assign-role-for-sa.md) the `postbox.sender` [role](../security/index.md#postbox-sender) to the service account.
1. Create a key for the service account:
   * To send an email using the AWS CLI or via SMTP with password authentication, [create](../../iam/operations/authentication/manage-access-keys.md#create-access-key) a static access key. Save the ID and secret key to a secure location. You will not be able to view the secret key parameters again after you close the window.
   * To send an email over SMTP with API key authentication, [create](../../iam/operations/authentication/manage-api-keys.md#create-api-key) an API key. When creating an API key, set the scope for `yc.postbox.send`. Save the secret key you got in a secure location. You will not be able to view the secret key parameters again after you close the window.

## Send an email {#send-email}

### AWS CLI {#aws-cli-send}

{% include [send-email-aws](../../_includes/postbox/send-email-aws.md) %}

### SMTP {#smtp-send}

You can send emails via SMTP with authentication based on a service account's API key or a password generated from a service account's static access key.

{% list tabs %}

- Authentication with an API key

  {% include [smtp-send-api](../../_includes/postbox/smtp-send-api.md) %}

- Password authentication

  {% include [smtp-send-python](../../_includes/postbox/smtp-send-python.md) %}

{% endlist %}
