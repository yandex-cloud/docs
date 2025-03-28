# Getting started with {{ postbox-full-name }}

Use this guide to create your address and send a verification email.

## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials/_tutorials_includes/before-you-begin.md) %}

## Create a service account and keys {#service-account-and-keys}

1. [Create](../iam/operations/sa/create.md) a service account named `postbox-user` and [assign](../iam/operations/sa/assign-role-for-sa.md) it the `postbox.sender` [role](security/index.md#postbox-sender).
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
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_postbox }}**.
    1. Click **{{ ui-key.yacloud.postbox.button_create-identity }}**.
    1. Specify the **{{ ui-key.yacloud.postbox.label_address }}** from which you will be sending emails. The domain can be of any level.
    1. Specify **{{ ui-key.yacloud.postbox.label_selector }}**: `postbox`.

        {% note info %}

        You can specify a selector other than `postbox`. You should only use the specified selector in a single resource record: the one you create at the [Pass domain ownership verification](#verify-domain) step.

        {% endnote %}

    1. Copy the contents of the `privatekey.pem` file you [created earlier](#service-account-and-keys) and paste it into the **{{ ui-key.yacloud.postbox.label_private-key }}** field.
    1. Optionally, [configure logging](operations/logs-write.md).
    1. Click **{{ ui-key.yacloud.postbox.button_create-identity }}**.

{% endlist %}

## Pass domain ownership verification {#verify-domain}

{% include [check-domain](../_includes/postbox/check-domain.md) %}

## Send a verification email {#send-test-email}

You can send a test email using the [AWS CLI](#aws-cli-send) or from your email client over [SMTP](#smtp-send).

### AWS CLI {#aws-cli-send}

{% include [send-email-aws](../_includes/postbox/send-email-aws.md) %}

### SMTP {#smtp-send}

{% include [smtp-send-api](../_includes/postbox/smtp-send-api.md) %}

#### See also {#see-also}

* [{#T}](concepts/notification.md)
* [{#T}](operations/send-email.md)
