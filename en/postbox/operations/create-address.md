# Creating an address

1. Generate a key to create a DKIM signature:

    ```bash
    openssl genrsa -out privatekey.pem 2048
    ```

1. Create an [address](../concepts/glossary.md#adress):

    {% list tabs group=instructions %}

    - Management console {#console}

        1. In the [management console]({{ link-console-main }}), select the folder you want to create an address in.
        1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_postbox }}**.
        1. Click **{{ ui-key.yacloud.postbox.button_create-identity }}**.
        1. In the **{{ ui-key.yacloud.postbox.label_address }}** field, specify the domain from which you will be sending emails. The domain can be of any level.
        1. In the **{{ ui-key.yacloud.postbox.label_selector }}** field, choose a selector, e.g., `postbox`. You should use the specified selector only in one resource record: the one you create at [domain ownership verification](check-domain.md).
        1. (Optional) [Link the configuration to an address](bind-configuration.md).
        1. In the **{{ ui-key.yacloud.postbox.label_private-key }}** field, copy the contents of the `privatekey.pem` file.
        1. (Optional) [Configure logging](logs-write.md).
        1. Click **{{ ui-key.yacloud.postbox.button_create-identity }}**.

        To send emails, pass [domain ownership verification](check-domain.md).

    {% endlist %}
