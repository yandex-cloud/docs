# Getting started with {{ postbox-full-name }}

Use this guide to create your address and send a verification email.

## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials/_tutorials_includes/before-you-begin.md) %}

## Create a service account and keys {#service-account-and-keys}

To send emails, you will need a service account, a static key to use it in AWS CLI, and a public key for creating a DKIM signature.

1. [Create](../iam/operations/sa/create.md) a service account with the `postbox.sender` role.
1. [Create a static key](../iam/operations/sa/create-access-key.md) for your service account.
1. [Install and set up the AWS CLI](https://aws.amazon.com/ru/cli/), specifying the ID, secret key, and the `ru-central1` region.
1. Generate a private key: `openssl genrsa -out privatekey.pem 2048`.

## Create an address {#create-address}

1. In the [management console]({{ link-console-main }}), select the folder where you want to create the address.
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

Send a verification email using the AWS CLI. Prepare two JSON files:

`destination.json`: File with a list of destination addresses:

```json
{
  "ToAddresses": ["test@example.com"]
}
```

`message.json`: File with the subject and content of the email:

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

Send an email using the AWS CLI:

```bash
aws sesv2 send-email --from-email-address mail@example.com --destination file://destination.json --content file://message.json --endpoint-url https://postbox.cloud.yandex.net
```

Check the mailbox specified in `destination.json` for the test email.
