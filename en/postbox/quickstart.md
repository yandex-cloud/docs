# Getting started with {{ postbox-full-name }}

Use this guide to create your address and send a verification email.

## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials/_tutorials_includes/before-you-begin.md) %}

## Create a service account and keys {#service-account-and-keys}

1. [Create](../iam/operations/sa/create.md) a service account named `postbox-user` with the `postbox.editor` role.
1. [Create](../iam/operations/sa/create-access-key.md) static access keys. Save the ID and secret key to a secure location. You will not be able to view the secret key parameters again after you close the window.
1. Generate a key to create a DKIM signature:
   ```
   openssl genrsa -out privatekey.pem 2048
   ```

## Create an address {#create-address}

1. In the [management console]({{ link-console-main }}), select the folder where you want to create an address.
1. In the list of services, select **{{ postbox-name }}**.
1. Click **Create address**.
1. Specify the **Domain** from which you will be sending emails. The domain can be of any level.
1. Specify the **Selector**: `mail`.
1. Copy the contents of the `privatekey.pem` private key file created during the [preparation stage](#service-account-and-keys), into the **Private key** field.
1. Click **Create**.

## Verify domain ownership {#verify-domain}

To send emails, confirm ownership of the domain. After creating a record, the DKIM signature settings will be generated on its page. Specify them as the values of the resource record added to your domain zone. You can add a record with your registrar or in [{{ dns-full-name }}](../dns/) if you have delegated your domain.

Here is an example of creating a resource record in **{{ dns-name }}**:

1. In the [management console]({{ link-console-main }}), select the directory where your domain zone is located.
1. In the list of services, select **{{ dns-name }}**.
1. Select your domain zone.
1. Click **Create record**.
1. In the **Name** field, specify the name generated when creating the address, such as `mail._domainkey.example.com`.
1. In the **Type** list, select `TXT`.
1. To the **Value** field, copy the contents of the **Value** field under **Signature verification**. Note that the record value needs to be broken down into separate lines, for example:

		( "v=DKIM1;h=sha256;k=rsa; "

		"p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAui6NEIfZdLfcbcJV4oqY5lWyYXV1ht1zYdrSHCVCWWBaOZ2mIGVzycDKPicLSDZBlN4I8HO2ajclFfQn3013klP7i6VrDSXMmO9hRGgVU+ZhoFJrsMRdbDK/1SIU1k7xiJIudB+YPcc69Y/jHQJk32q7b"

		"UC617oEwSL/sQHeueS0rMLrmPyOtXELLLHrx9IiHM8ACb6zFY/lWx3AnuOLOv4JXYPAQe+b2zvERpHA+AbaCUHi8dJVm1aY/TceakHkUMlWzh4YeSfuQkaNI1PEnLGA3u0WIGyvtTdA3FWhT3w3BFsVWCTFPIxjORvaY/eZMMcj3WM7GUtORbebAOUyBwIDAQAB" )
1. Click **Create**.

Wait a few minutes. If the record is correct, the verification status on the address page will change to `Success`.

## Send a verification email {#send-test-letter}

You can send a verification email using:
* AWS CLI
* SMTP

### AWS CLI

1. [Install](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) the AWS CLI.
1. Set up the AWS CLI:
   1. Launch the interactive profile setup:
      ```
      aws configure
      ```
   1. Specify the previously obtained ID of the `postbox-user` service account key:
      ```
      AWS Access Key ID [****************ver_]: &amp;lt;service_account_key_ID&amp;gt;
      ```
   1. Specify the previously obtained secret key of the `postbox-user` service account:
      ```
      AWS Secret Access Key [****************w5lb]: &amp;lt;service_account_secret_key&amp;gt;
      ```
   1. Specify ru-central1 as the default region name:
      ```
      Default region name [ru-central1]: ru-central1
      ```
   1. Specify JSON as the default format for output data:
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
   aws sesv2 send-email --from-email-address mail@example.com --destination file://destination.json --content file://message.json --endpoint-url https://postbox.cloud.yandex.net
   ```

1. Check the mailbox specified in `destination.json` for the test email.

### SMTP

1. Get a password by using the secret key of the `postbox-user` service account. To do this, run the `generate.py` script:
   ```
   python generate.py <secret_key_of_service_account>
   ```

   {% cut "generate.py" %}

   ```
   #!/usr/bin/env python3

   import hmac
   import hashlib
   import base64
   import argparse

   # These values are required to calculate the signature. Do not change them.
   DATE = "20230926"
   SERVICE = "postbox"
   MESSAGE = "SendRawEmail"
   REGION = "ru-central1"
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
   * Port: `25`.
   * Username: ID of the `postbox-user` service account key.
   * Password you obtained in the previous step.
1. Send an email using your email client and make sure the specified recipients receive it.
