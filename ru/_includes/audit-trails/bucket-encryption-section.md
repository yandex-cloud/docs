## Зашифровать бакет {#bucket-encryption}

Чтобы хранить логи в зашифрованном виде:

1. Создайте [ключ шифрования](../../kms/operations/key.md#create) в сервисе {{ kms-full-name }}.
1. [Включите шифрование бакета](../../storage/operations/buckets/encrypt.md#add), используя созданный ключ.
1. Назначьте сервисному аккаунту, который вы создали ранее, роль [`kms.keys.encrypterDecrypter`](../../kms/security/index.md#service-roles) на ключ:

    ```bash
    yc kms symmetric-key add-access-binding \
        --role kms.keys.encrypterDecrypter \
        --id <идентификатор_ключа> \
        --service-account-id <идентификатор_сервисного_аккаунта>
    ```

    Где:
    * `--role` — назначаемая роль;
    * `--id` — идентификатор ключа шифрования;
    * `--service-account-id` — идентификатор сервисного аккаунта.
