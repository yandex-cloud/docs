В {{ managed-k8s-name }} для постоянных томов поддерживается использование дисков {{ compute-name }}, [зашифрованных](../../compute/concepts/encryption.md) с помощью пользовательских [симметричных ключей](../../kms/concepts/key.md) {{ kms-full-name }}.

{% note info %}

Чтобы использовать зашифрованные диски, у [облачного сервисного аккаунта](../../managed-kubernetes/concepts/index.md#service-accounts), назначенного кластеру {{ managed-k8s-name }}, должна быть [роль](../../kms/security/index.md#kms-keys-encrypterDecrypter) `kms.keys.encrypterDecrypter` на ключ или каталог.

{% endnote %}