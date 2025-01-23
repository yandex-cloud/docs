# Getting started with {{ kms-name }}

In this guide, you create your first [key](../concepts/index.md) and encrypt and decrypt text using the {{ kms-short-name }}. 

## Getting started {#before-you-begin}

To get started with {{ kms-name }}:

1. Log in to the [management console]({{ link-console-main }}). If not signed up yet, navigate to the management console and follow the instructions.
1. On the [**{{ ui-key.yacloud.component.navigation-menu.label_billing }}**]({{ link-console-billing }}) page, make sure you have a [billing account](../../billing/concepts/billing-account.md) linked and it is in `ACTIVE` or `TRIAL_ACTIVE` status. If you do not have a billing account yet, [create one](../../billing/quickstart/index.md#create_billing_account).
1. [Assign](../../iam/operations/roles/grant.md) to your {{ yandex-cloud }} account the `owner` or `editor` role or higher for the cloud of your choice.

    {% include [note-managing-roles](../../_includes/mdb/note-managing-roles.md) %}

1. If you do not have the {{ yandex-cloud }} (CLI) command line interface yet, [install and initialize it](../../cli/quickstart.md#install).

## Create a symmetric encryption key {#create-key}

{% list tabs group=instructions %}

- Management console {#console}
    
    Create a symmetric encryption key: 
    1. In the [management console]({{ link-console-main }}), select the folder you want to create a key in.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_kms }}**.
    1. In the left-hand panel, select ![image](../../_assets/console-icons/key.svg) **{{ ui-key.yacloud.kms.switch_symmetric-keys }}**.
    1. Click **{{ ui-key.yacloud.kms.symmetric-keys.button_empty-create }}** and set the key parameters:
       * In the **{{ ui-key.yacloud.common.name }}** field, specify `my-first-key`.
       * In the **{{ ui-key.yacloud.kms.symmetric-key.form.field_algorithm }}** field, specify `AES-256`.
       * In the **{{ ui-key.yacloud.kms.symmetric-key.form.field_rotation }}** field, leave `{{ ui-key.yacloud.kms.symmetric-key.form.value_no-rotation }}`.
       * Click **{{ ui-key.yacloud.common.create }}**.
    1. Click the line with the key name and make sure the **{{ ui-key.yacloud.kms.symmetric-key.overview.label_title-versions }}** section contains the first key version.

{% endlist %}

## Encrypt text using the key {#encrypt}

Come up with a secret text, for example: <q>The launch is scheduled for Marchember 42.</q>. The text size must not exceed 32 KB. To encrypt large volumes of data, use [envelope encryption](../concepts/envelope.md).

{% list tabs group=instructions %}

- CLI {#cli}

    Encrypt the text:
    
    1. Save the secret text to the `plaintext.txt` file.
    1. Copy the ID of the previously created key from the management console.
        1. In the [management console]({{ link-console-main }}), go to the folder the key was created in.
        1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_kms }}**.
        1. In the window that opens, copy the key from the **{{ ui-key.yacloud.common.id }}** field.
    1. Encrypt the text:
    
       ```
       yc kms symmetric-crypto encrypt \
        --id <key_ID> \
        --plaintext-file plaintext.txt \
        --ciphertext-file ciphertext
       ```

    The result is a binary file named `ciphertext` containing ciphertext.

{% endlist %}

## Decrypt the text {#decrypt}

Decrypt the `ciphertext` binary file from the previous step.

{% list tabs group=instructions %}

- CLI {#cli}

    Decrypt the text:
    
    ```
    yc kms symmetric-crypto decrypt \
    --id <key_ID> \
    --ciphertext-file ciphertext \
    --plaintext-file decrypted.txt
    ```
    
    As a result, the `ciphertext` file will be decrypted and the following decrypted text will be written to the `decrypted.txt` file: <q>The launch is scheduled for Marchember 42.</q>.

{% endlist %}

#### See also {#see-also}

* [Updating keys](../operations/key.md#update)
* [Rotating a key](../operations/key.md#rotate)
* [Changing the default key version](../operations/version.md#make-primary)
