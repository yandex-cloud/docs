---
title: Creating an address
description: Follow this guide to create an address.
---

# Creating an address

1. Generate a key to create a DKIM signature:

    ```bash
    openssl genrsa -out privatekey.pem 2048
    ```

1. Create an [address](../concepts/glossary.md#adress):

    {% list tabs group=instructions %}

    - Management console {#console}

        1. In the [management console]({{ link-console-main }}), select the folder you want to create an address in.
        1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_postbox }}**.
        1. Click **{{ ui-key.yacloud.postbox.button_create-identity }}**.
        1. In the **{{ ui-key.yacloud.postbox.label_address }}** field, specify the domain you will use to send emails. You can use a domain of any level.
        1. In the **{{ ui-key.yacloud.postbox.label_selector }}** field, choose a selector, e.g., `postbox`. Make sure to only use this selector in that single resource record you create at [domain ownership verification](check-domain.md).
        1. Optionally, [link the configuration to an address](bind-configuration.md).
        1. In the **{{ ui-key.yacloud.postbox.label_private-key }}** field, copy the contents of the `privatekey.pem` file.
        1. Optionally, [configure logging](logs-write.md).
        1. Optionally, under **{{ ui-key.yacloud.postbox.section_restrictions }}**, enable **{{ ui-key.yacloud.postbox.label_restrict-senders }}** and specify the addresses allowed to send emails.  
        1. Click **{{ ui-key.yacloud.postbox.button_create-identity }}**.

        To send emails, pass [domain ownership verification](check-domain.md).

    {% endlist %}
