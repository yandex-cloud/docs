# Getting started with {{ postbox-full-name }}

Use this guide to create your address and send a verification email.

## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials/_tutorials_includes/before-you-begin.md) %}

## Create a service account and keys {#service-account-and-keys}

1. [Create](../iam/operations/sa/create.md) a service account named `postbox-user` and [assign](../iam/operations/sa/assign-role-for-sa.md) the `postbox.sender` [role](security/index.md#postbox-sender) to it.
1. Create a key for the service account:
   * To send an email using the AWS CLI, [create](../iam/operations/authentication/manage-access-keys.md#create-access-key) a static access key. Save the ID and secret key to a secure location. You will not be able to view the secret key parameters again after you close the window.
   * To send an email via SMTP, [create](../iam/operations/authentication/manage-api-keys.md#create-api-key) an API key. When creating an API key, set the scope for `yc.postbox.send`. Save the secret key you got in a secure location. You will not be able to view the secret key parameters again after you close the window.
1. Generate a key to create a DKIM signature:

    ```
    openssl genrsa -out privatekey.pem 2048
    ```

## Create an address {#create-address}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder where you created the service account. If you create the service account and address in different folders, you will get an error when attempting to send an email.
    1. [Go](../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_postbox }}**.
    1. Click **{{ ui-key.yacloud.postbox.button_create-identity }}**.
    1. Specify the **{{ ui-key.yacloud.postbox.label_address }}** from which you will be sending emails. You can use a domain of any level.
    1. Under **{{ ui-key.yacloud.postbox.section_dkim }}**, select **{{ ui-key.yacloud.postbox.label_signing-type-internal }}**.
    1. Optionally, [configure logging](operations/logs-write.md).
    1. Click **{{ ui-key.yacloud.postbox.button_create-identity }}**.

{% endlist %}

## Pass domain ownership verification {#verify-domain}

{% include [check-domain](../_includes/postbox/check-domain.md) %}

## Send a verification email {#send-test-email}

You can send a test email using the [AWS CLI](#aws-cli-send) or from your email client over [SMTP](#smtp-send).

{% include [tls](../_includes/postbox/tls.md) %}

### AWS CLI {#aws-cli-send}

{% include [send-email-aws](../_includes/postbox/send-email-aws.md) %}

### SMTP {#smtp-send}

{% include [smtp-send-api](../_includes/postbox/smtp-send-api.md) %}

#### See also {#see-also}

* [{#T}](concepts/notification.md)
* [{#T}](operations/send-email.md)
