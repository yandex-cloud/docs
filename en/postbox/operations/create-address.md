---
title: Creating an address
description: Follow this guide to create an address.
---

# Creating an address

1. In the [management console]({{ link-console-main }}), select the folder you want to create an [address](../concepts/glossary.md#adress) in.
1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_postbox }}**.
1. Click **{{ ui-key.yacloud.postbox.button_create-identity }}**.
1. In the **{{ ui-key.yacloud.postbox.label_address }}** field, specify the domain you will use to send emails. You can use a domain of any level.
1. (Optional) [Link the configuration to an address](bind-configuration.md).
1. Select the setup method for outgoing email signatures (DKIM):

    {% list tabs group=dkim %}

    - Simple setup {#easy}

        {{ postbox-name }} will prepare keys and DNS records for you to add to your DNS provider. For more information, see [{#T}](../concepts/glossary.md#dkim).

    - Advanced setup {#advanced}

        1. Generate a key to create a DKIM signature. {{ postbox-name }} supports 1,024-bit and 2,048-bit keys. To generate a key, run the following OpenSSL command:

            ```bash
            openssl genrsa -out privatekey.pem 2048
            ```

            {% note info %}
     
            Some DNS providers impose length limitations on TXT records. If you encounter such an issue, use a 1024-bit key.
     
            {% endnote %}
  
        1. In the **{{ ui-key.yacloud.postbox.label_selector }}** field, specify a selector, e.g., `postbox`. This selector should be used in one resource record only: the one you create when you pass the [domain ownership check](check-domain.md).

        1. In the **{{ ui-key.yacloud.postbox.label_private-key }}** field, copy the contents of the `privatekey.pem` file.

    {% endlist %}

1. Optionally, [restrict the list of senders](../../postbox/operations/restrict-senders.md).
1. Optionally, [configure logging](logs-write.md).
1. Click **{{ ui-key.yacloud.postbox.button_create-identity }}**.

To send emails, pass a [domain ownership check](check-domain.md).
