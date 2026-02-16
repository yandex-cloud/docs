1. Generate the `privatekey.pem` key to create a DKIM signature by running this command in the terminal:

    ```bash
    openssl genrsa -out privatekey.pem 2048
    ```

    {% note info %}

    `openssl` comes preinstalled in Linux and macOS. If using Windows, you need to install it manually. For more information, visit the [project's website](https://openssl-library.org/).

    {% endnote %}

1. Create a {{ postbox-name }} address:

    {% list tabs group=instructions %}

    - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the folder where you are deploying your infrastructure.
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_postbox }}**.
      1. In the left-hand panel, select ![at](../../../_assets/console-icons/at.svg) **{{ ui-key.yacloud.postbox.label_identities }}** and click **{{ ui-key.yacloud.postbox.button_create-identity }}**.
      1. In the **{{ ui-key.yacloud.postbox.label_address }}** field, specify the domain you will use to send emails. You can use a domain of any level, as long as you own it.
      1. In the **{{ ui-key.yacloud.postbox.label_selector }}** field, specify a selector, e.g., `postbox`. Make sure to only use this selector in the resource record you create when [verifying domain ownership](#domain).
      1. In the **{{ ui-key.yacloud.postbox.label_configuration-set }}** field, select `postbox-events-config` you previously created.
      1. In the **{{ ui-key.yacloud.postbox.label_private-key }}** field, paste the contents of the `privatekey.pem` file from the previous step.
      1. Do not change the other address settings. Click **{{ ui-key.yacloud.postbox.button_create-identity }}**.
      1. Click the newly created address in the list that opens.
      1. Under **{{ ui-key.yacloud.postbox.label_signature-verification }}** on the address info page, copy and save the [TXT record](../../../dns/concepts/resource-record.md#txt) from the **{{ ui-key.yacloud.postbox.label_dns-record-value }}** field.

    {% endlist %}