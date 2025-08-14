{% note warning %}

Для выполнения сканирования сервисному аккаунту должна быть [назначена](../../iam/operations/sa/assign-role-for-sa.md) [роль](../../security-deck/security/dspm-roles.md#dspm-worker) `dspm.worker` на все сканируемые бакеты. Если бакеты [зашифрованы](../../storage/concepts/encryption.md), сервисному аккаунту также необходима [роль](../../kms/security/index.md#kms-keys-decrypter) `kms.keys.decrypter` на соответствующие [ключи шифрования](../../kms/concepts/key.md) {{ kms-full-name }}.

{% endnote %}