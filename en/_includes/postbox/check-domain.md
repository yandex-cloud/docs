To send emails, confirm ownership of the domain. After creating an address, DKIM signature settings will be generated on its page. Specify them as the values of the resource record you need to add to your domain zone. You can add a record with your registrar or in [{{ dns-full-name }}](../../dns/) if you have delegated your domain.

**Example of creating a resource record in {{ dns-name }}**

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder containing the address and your domain zone.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
    1. Select your domain zone.
    1. Click **{{ ui-key.yacloud.dns.button_record-set-create }}**.
    1. In the **{{ ui-key.yacloud.common.name }}** field, specify the name generated when creating the address in `postbox._domainkey.example.com` format.
    1. In the **{{ ui-key.yacloud.common.type }}** list, select `TXT`.
    1. Copy the contents of the **{{ ui-key.yacloud.postbox.label_dns-record-value }}** field from the **{{ ui-key.yacloud.postbox.label_signature-verification }}** section and paste it into the **{{ ui-key.yacloud.dns.label_records }}** field. Note that the record value needs to be broken down into separate lines, for example:

        ```text
        ( "v=DKIM1;h=sha256;k=rsa; "

        "p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAui6NEIfZdLfcbcJV4oqY5lWyYXV1ht1zYdrSHCVCWWBaOZ2mIGVzycDKPicLSDZBlN4I8HO2ajclFfQn3013klP7i6VrDSXMmO9hRGgVU+ZhoFJrsMRdbDK/1SIU1k7xiJIudB+YPcc69Y/jHQJk32q7b"

        "UC617oEwSL/sQHeueS0rMLrmPyOtXELLLHrx9IiHM8ACb6zFY/lWx3AnuOLOv4JXYPAQe+b2zvERpHA+AbaCUHi8dJVm1aY/TceakHkUMlWzh4YeSfuQkaNI1PEnLGA3u0WIGyvtTdA3FWhT3w3BFsVWCTFPIxjORvaY/eZMMcj3WM7GUtORbebAOUyBwIDAQAB" )
        ```

    1. Click **{{ ui-key.yacloud.common.create }}**.
    1. Go to **{{ ui-key.yacloud.iam.folder.dashboard.label_postbox }}**.
    1. Select the address you created.
    1. Click **{{ ui-key.yacloud.postbox.button_validate }}**. If the record is correct, the verification status on the address page will change to `Success`.

    DNS server responses are cached, so delays may occur when updating a resource record.

{% endlist %}
