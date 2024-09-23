# Getting started with {{ postbox-full-name }}

Use this guide to create your address and send a verification email.

## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials/_tutorials_includes/before-you-begin.md) %}

## Create a service account and keys {#service-account-and-keys}

1. [Create](../iam/operations/sa/create.md) a service account named `postbox-user` with the `postbox.sender` role.
1. [Create](../iam/operations/sa/create-access-key.md) static access keys. Save the ID and secret key to a secure location. You will not be able to view the secret key parameters again after you close the window.
1. Generate a key to create a DKIM signature:
    ```
    openssl genrsa -out privatekey.pem 2048
    ```

## Create an address {#create-address}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder where you created the service account.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_postbox }}**.
    1. Click **{{ ui-key.yacloud.postbox.button_create-identity }}**.
    1. Specify the **{{ ui-key.yacloud.postbox.label_address }}** from which you will be sending emails. The domain can be of any level.
    1. Specify **{{ ui-key.yacloud.postbox.label_selector }}**: `postbox`.

        {% note info %}

        You can specify a selector other than `postbox`. You should only use the specified selector in a single resource record: the one you create at [{#T}](#verify-domain).

        {% endnote %}

    1. Copy the contents of the `privatekey.pem` file you [created earlier](#service-account-and-keys) and paste it into the **{{ ui-key.yacloud.postbox.label_private-key }}** field.
    1. Optionally, [configure logging](operations/logs-write.md).
    1. Click **{{ ui-key.yacloud.postbox.button_create-identity }}**.

{% endlist %}

## Pass domain ownership verification {#verify-domain}

{% include [check-domain](../_includes/postbox/check-domain.md) %}

## Send a verification email {#send-test-letter}

You can send a verification email using:
* AWS CLI
* SMTP protocol

### AWS CLI

1. [Install](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) the AWS CLI.
1. Set up the AWS CLI:
    1. Launch the interactive profile setup:
        ```
        aws configure
        ```
    1. Specify the previously obtained key ID of the `postbox-user` service account:
        ```
        AWS Access Key ID [****************ver_]: <service_account_key_ID>
        ```
    1. Specify the previously obtained secret key of the `postbox-user` service account:
        ```
        AWS Secret Access Key [****************w5lb]: <service_account_secret_key>
        ```
    1. Specify the {{ region-id }} default region name:
        ```
        Default region name [{{ region-id }}]: {{ region-id }}
        ```
    1. Specify `JSON` as the default format for output data:
        ```
        Default output format [None]: json
        ```

1. Prepare two JSON files:

    * `destination.json`: File with a list of destination addresses:

        ```json
        {
          "ToAddresses": ["test@example.com"]
        }
        ```

     * `message.json`: File with the subject and content of the email:

        ```json
        {
          "Simple": {
            "Subject": {
              "Data": "Test message",
              "Charset": "UTF-8"
            },
            "Body": {
              "Text": {
                "Data": "Test message. Hello!",
                "Charset": "UTF-8"
              }
            }
          }
        }
        ```

1. Send an email using the AWS CLI:

    ```bash
    aws sesv2 send-email --from-email-address mail@example.com --destination file://destination.json --content file://message.json --endpoint-url {{ postbox-endpoint }}
    ```

1. Check the mailbox specified in `destination.json` for the test email.

### SMTP

1. Get a password by using the secret key of the `postbox-user` service account. To do this, run the `generate.py` script. Use Python 3 or higher.
    ```
    python generate.py <service_account_secret_key>
    ```

    {% cut "generate.py" %}

    ```
    #!/usr/bin/env python3

    import hmac
    import hashlib
    import base64
    import argparse
    import sys

    # These values are required to calculate the signature. Do not change them.
    DATE = "20230926"
    SERVICE = "postbox"
    MESSAGE = "SendRawEmail"
    REGION = "{{ region-id }}"
    TERMINAL = "aws4_request"
    VERSION = 0x04


    def sign(key, msg):
        return hmac.new(key, msg.encode("utf-8"), hashlib.sha256).digest()


    def calculate_key(secret_access_key):
        signature = sign(("AWS4" + secret_access_key).encode("utf-8"), DATE)
        signature = sign(signature, REGION)
        signature = sign(signature, SERVICE)
        signature = sign(signature, TERMINAL)
        signature = sign(signature, MESSAGE)
        signature_and_version = bytes([VERSION]) + signature
        smtp_password = base64.b64encode(signature_and_version)
        return smtp_password.decode("utf-8")


    def main():
        if sys.version_info[0] < 3:
            raise Exception("Must be using Python 3")

        parser = argparse.ArgumentParser(
            description="Convert a Secret Access Key to an SMTP password."
        )
        parser.add_argument("secret", help="The Secret Access Key to convert.")
        args = parser.parse_args()

        print(calculate_key(args.secret))


    if __name__ == "__main__":
        main()
    ```

    {% endcut %}

1. Specify the following parameters in your email client:
    * Server name: `postbox.cloud.yandex.net`.
    * Port: `587`.
    * Username: Static key ID of the `postbox-user` service account.
    * Password you obtained in the previous step.

    {% note info %}

    Your email client must support the [STARTTLS extension](https://en.wikipedia.org/wiki/Opportunistic_TLS) to encrypt emails you send.

    {% endnote %}

1. Send an email using your email client and make sure the specified recipients receive it.

## See also {#see-also}

* [{#T}](concepts/notification.md)
