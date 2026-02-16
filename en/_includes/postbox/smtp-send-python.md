1. Get a password using the previously created static access key of the service account. To do this, run the `generate.py` script. Use Python 3 or higher.
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

1. In the SMTP server settings of your email client, specify the following parameters:

    #|
    || | **Email client supports STARTTLS** | **Email client supports SMTPS instead of STARTTLS** ||
    || **Server name** | `{{ postbox-host }}` {.cell-align-center} | > ||
    || **Port** | `587` | `465` ||
    || **Username** | ID of the previously created static access key {.cell-align-center} | > ||
    || **Password** | Password obtained in the previous step {.cell-align-center} | > ||
    |#

1. Send an email using your email client and make sure the specified recipients receive it.