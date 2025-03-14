1. Получите пароль, используя созданный ранее статический ключ доступа сервисного аккаунта. Для этого вызовите скрипт `generate.py`. Используйте Python не ниже версии 3.
    ```
    python generate.py <секретный_ключ_сервисного_аккаунта>
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

  1. {% include [smtp-settings](smtp-settings.md) %}

  1. Отправьте письмо с помощью вашего почтового клиента и убедитесь, что оно пришло на указанные адреса.