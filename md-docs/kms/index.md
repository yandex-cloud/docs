# Yandex Key Management Service

Yandex Key Management Service — сервис для создания и управления ключами шифрования, которые можно использовать для защиты данных в инфраструктуре Yandex Cloud, а также шифрования и расшифровки любых ваших данных.

Для сервиса действует <a href="https://yandex.ru/legal/cloud_sla">соглашение об уровне обслуживания</a>. Уровень обслуживания сервиса определен в документе <a href="https://yandex.ru/legal/cloud_sla_kms">Уровень обслуживания Yandex Key Management Service</a>.

# Yandex Key Management Service

 - [Начало работы](quickstart/index.md)

## Пошаговые инструкции

 - [Все инструкции](operations/index.md)

### Симметричное шифрование

 - [Ключ](operations/key.md)

 - [Версия ключа](operations/version.md)

 - [Шифрование данных](operations/symmetric-encryption.md)

 - [Права доступа к ключу шифрования](operations/key-access.md)

### Асимметричное шифрование

 - [Ключевая пара шифрования](operations/asymmetric-encryption-key.md)

 - [Шифрование данных](operations/asymmetric-encryption.md)

 - [Права доступа к асимметричной ключевой паре](operations/asymmetric-encryption-key-access.md)

### Электронная подпись

 - [Ключевая пара электронной подписи](operations/asymmetric-signature-key.md)

 - [Права доступа к ключевой паре электронной подписи](operations/asymmetric-signature-key-access.md)

 - [Электронная подпись и проверка подписи](operations/signature-verification.md)

 - [Электронная подпись файлов и артефактов с помощью Cosign](operations/signature-verification-cosign.md)

 - [Посмотреть операции с ресурсами сервиса](operations/operation-logs.md)

## Концепции

 - [Обзор](concepts/index.md)

### Симметричное шифрование

 - [Симметричный ключ](concepts/key.md)

 - [Версия ключа](concepts/version.md)

 - [Симметричное шифрование](concepts/symmetric-encryption.md)

 - [Аппаратный модуль безопасности (HSM)](concepts/hsm.md)

### Асимметричное шифрование

 - [Ключевая пара шифрования](concepts/asymmetric-encryption-key.md)

 - [Асимметричное шифрование](concepts/asymmetric-encryption.md)

### Электронная подпись

 - [Ключевая пара электронной подписи](concepts/asymmetric-signature-key.md)

 - [Электронная подпись](concepts/digital-signature.md)

 - [Шифрование по схеме envelope encryption](concepts/envelope.md)

 - [Консистентность ключей](concepts/consistency.md)

 - [Квоты и лимиты](concepts/limits.md)

## Практические руководства

 - [Все руководства](tutorials/index.md)

### Шифрование данных

 - [Какой способ шифрования выбрать?](tutorials/encrypt/index.md)

 - [Шифрование с помощью CLI и API Yandex Cloud](tutorials/encrypt/cli-api.md)

 - [Шифрование с помощью SDK Yandex Cloud](tutorials/encrypt/sdk.md)

 - [Шифрование с помощью AWS Encryption SDK](tutorials/encrypt/aws-encryption-sdk.md)

 - [Шифрование с помощью Google Tink](tutorials/encrypt/google-tink.md)

 - [Шифрование секретов в Managed Service for Kubernetes](tutorials/kms-k8s.md)

 - [Подпись и проверка Docker-образов в Managed Service for Kubernetes](tutorials/sign-cr-with-cosign.md)

 - [Управление ключами KMS с HashiCorp Terraform](tutorials/terraform-key.md)

 - [Шифрование секретов в HashiCorp Terraform](tutorials/terraform-secret.md)

 - [Auto Unseal в HashiCorp Vault](tutorials/vault-secret.md)

### Безопасная передача пароля в скрипт инициализации

 - [Обзор](tutorials/secure-password-script/index.md)

 - [Консоль управления, CLI, API](tutorials/secure-password-script/console.md)

 - [Terraform](tutorials/secure-password-script/terraform.md)

 - [Шифрование для бакета Object Storage на стороне сервера](tutorials/server-side-encryption.md)

 - [Управление доступом](security/index.md)

 - [Правила тарификации](pricing.md)

## Справочник CLI (англ.)

 - [Overview](cli-ref/index.md)

### asymmetric-encryption-crypto

 - [Overview](cli-ref/asymmetric-encryption-crypto/index.md)

 - [decrypt](cli-ref/asymmetric-encryption-crypto/decrypt.md)

 - [get-public-key](cli-ref/asymmetric-encryption-crypto/get-public-key.md)

### asymmetric-encryption-key

 - [Overview](cli-ref/asymmetric-encryption-key/index.md)

 - [add-access-binding](cli-ref/asymmetric-encryption-key/add-access-binding.md)

 - [create](cli-ref/asymmetric-encryption-key/create.md)

 - [delete](cli-ref/asymmetric-encryption-key/delete.md)

 - [get](cli-ref/asymmetric-encryption-key/get.md)

 - [list](cli-ref/asymmetric-encryption-key/list.md)

 - [list-access-bindings](cli-ref/asymmetric-encryption-key/list-access-bindings.md)

 - [list-operations](cli-ref/asymmetric-encryption-key/list-operations.md)

 - [remove-access-binding](cli-ref/asymmetric-encryption-key/remove-access-binding.md)

 - [set-access-bindings](cli-ref/asymmetric-encryption-key/set-access-bindings.md)

 - [update](cli-ref/asymmetric-encryption-key/update.md)

### asymmetric-signature-crypto

 - [Overview](cli-ref/asymmetric-signature-crypto/index.md)

 - [get-public-key](cli-ref/asymmetric-signature-crypto/get-public-key.md)

 - [sign](cli-ref/asymmetric-signature-crypto/sign.md)

 - [sign-hash](cli-ref/asymmetric-signature-crypto/sign-hash.md)

### asymmetric-signature-key

 - [Overview](cli-ref/asymmetric-signature-key/index.md)

 - [add-access-binding](cli-ref/asymmetric-signature-key/add-access-binding.md)

 - [create](cli-ref/asymmetric-signature-key/create.md)

 - [delete](cli-ref/asymmetric-signature-key/delete.md)

 - [get](cli-ref/asymmetric-signature-key/get.md)

 - [list](cli-ref/asymmetric-signature-key/list.md)

 - [list-access-bindings](cli-ref/asymmetric-signature-key/list-access-bindings.md)

 - [list-operations](cli-ref/asymmetric-signature-key/list-operations.md)

 - [remove-access-binding](cli-ref/asymmetric-signature-key/remove-access-binding.md)

 - [set-access-bindings](cli-ref/asymmetric-signature-key/set-access-bindings.md)

 - [update](cli-ref/asymmetric-signature-key/update.md)

### symmetric-crypto

 - [Overview](cli-ref/symmetric-crypto/index.md)

 - [decrypt](cli-ref/symmetric-crypto/decrypt.md)

 - [encrypt](cli-ref/symmetric-crypto/encrypt.md)

 - [generate-data-key](cli-ref/symmetric-crypto/generate-data-key.md)

 - [re-encrypt](cli-ref/symmetric-crypto/re-encrypt.md)

### symmetric-key

 - [Overview](cli-ref/symmetric-key/index.md)

 - [add-access-binding](cli-ref/symmetric-key/add-access-binding.md)

 - [cancel-version-destruction](cli-ref/symmetric-key/cancel-version-destruction.md)

 - [create](cli-ref/symmetric-key/create.md)

 - [delete](cli-ref/symmetric-key/delete.md)

 - [get](cli-ref/symmetric-key/get.md)

 - [list](cli-ref/symmetric-key/list.md)

 - [list-access-bindings](cli-ref/symmetric-key/list-access-bindings.md)

 - [list-operations](cli-ref/symmetric-key/list-operations.md)

 - [list-versions](cli-ref/symmetric-key/list-versions.md)

 - [remove-access-binding](cli-ref/symmetric-key/remove-access-binding.md)

 - [rotate](cli-ref/symmetric-key/rotate.md)

 - [schedule-version-destruction](cli-ref/symmetric-key/schedule-version-destruction.md)

 - [set-access-bindings](cli-ref/symmetric-key/set-access-bindings.md)

 - [set-primary-version](cli-ref/symmetric-key/set-primary-version.md)

 - [update](cli-ref/symmetric-key/update.md)

### v0

 - [Overview](cli-ref/v0/index.md)

#### asymmetric-encryption-crypto

 - [Overview](cli-ref/v0/asymmetric-encryption-crypto/index.md)

 - [decrypt](cli-ref/v0/asymmetric-encryption-crypto/decrypt.md)

 - [get-public-key](cli-ref/v0/asymmetric-encryption-crypto/get-public-key.md)

#### asymmetric-encryption-key

 - [Overview](cli-ref/v0/asymmetric-encryption-key/index.md)

 - [add-access-binding](cli-ref/v0/asymmetric-encryption-key/add-access-binding.md)

 - [create](cli-ref/v0/asymmetric-encryption-key/create.md)

 - [delete](cli-ref/v0/asymmetric-encryption-key/delete.md)

 - [get](cli-ref/v0/asymmetric-encryption-key/get.md)

 - [list](cli-ref/v0/asymmetric-encryption-key/list.md)

 - [list-access-bindings](cli-ref/v0/asymmetric-encryption-key/list-access-bindings.md)

 - [list-operations](cli-ref/v0/asymmetric-encryption-key/list-operations.md)

 - [remove-access-binding](cli-ref/v0/asymmetric-encryption-key/remove-access-binding.md)

 - [set-access-bindings](cli-ref/v0/asymmetric-encryption-key/set-access-bindings.md)

 - [update](cli-ref/v0/asymmetric-encryption-key/update.md)

#### asymmetric-signature-crypto

 - [Overview](cli-ref/v0/asymmetric-signature-crypto/index.md)

 - [get-public-key](cli-ref/v0/asymmetric-signature-crypto/get-public-key.md)

 - [sign](cli-ref/v0/asymmetric-signature-crypto/sign.md)

 - [sign-hash](cli-ref/v0/asymmetric-signature-crypto/sign-hash.md)

#### asymmetric-signature-key

 - [Overview](cli-ref/v0/asymmetric-signature-key/index.md)

 - [add-access-binding](cli-ref/v0/asymmetric-signature-key/add-access-binding.md)

 - [create](cli-ref/v0/asymmetric-signature-key/create.md)

 - [delete](cli-ref/v0/asymmetric-signature-key/delete.md)

 - [get](cli-ref/v0/asymmetric-signature-key/get.md)

 - [list](cli-ref/v0/asymmetric-signature-key/list.md)

 - [list-access-bindings](cli-ref/v0/asymmetric-signature-key/list-access-bindings.md)

 - [list-operations](cli-ref/v0/asymmetric-signature-key/list-operations.md)

 - [remove-access-binding](cli-ref/v0/asymmetric-signature-key/remove-access-binding.md)

 - [set-access-bindings](cli-ref/v0/asymmetric-signature-key/set-access-bindings.md)

 - [update](cli-ref/v0/asymmetric-signature-key/update.md)

#### symmetric-crypto

 - [Overview](cli-ref/v0/symmetric-crypto/index.md)

 - [decrypt](cli-ref/v0/symmetric-crypto/decrypt.md)

 - [encrypt](cli-ref/v0/symmetric-crypto/encrypt.md)

 - [generate-data-key](cli-ref/v0/symmetric-crypto/generate-data-key.md)

 - [re-encrypt](cli-ref/v0/symmetric-crypto/re-encrypt.md)

#### symmetric-key

 - [Overview](cli-ref/v0/symmetric-key/index.md)

 - [add-access-binding](cli-ref/v0/symmetric-key/add-access-binding.md)

 - [cancel-version-destruction](cli-ref/v0/symmetric-key/cancel-version-destruction.md)

 - [create](cli-ref/v0/symmetric-key/create.md)

 - [delete](cli-ref/v0/symmetric-key/delete.md)

 - [get](cli-ref/v0/symmetric-key/get.md)

 - [list](cli-ref/v0/symmetric-key/list.md)

 - [list-access-bindings](cli-ref/v0/symmetric-key/list-access-bindings.md)

 - [list-operations](cli-ref/v0/symmetric-key/list-operations.md)

 - [list-versions](cli-ref/v0/symmetric-key/list-versions.md)

 - [remove-access-binding](cli-ref/v0/symmetric-key/remove-access-binding.md)

 - [rotate](cli-ref/v0/symmetric-key/rotate.md)

 - [schedule-version-destruction](cli-ref/v0/symmetric-key/schedule-version-destruction.md)

 - [set-access-bindings](cli-ref/v0/symmetric-key/set-access-bindings.md)

 - [set-primary-version](cli-ref/v0/symmetric-key/set-primary-version.md)

 - [update](cli-ref/v0/symmetric-key/update.md)

 - [Справочник Terraform](tf-ref.md)

## Справочник API

 - [Аутентификация в API](api-ref/authentication.md)

### gRPC (англ.)

 - [Overview](api-ref/grpc/index.md)

#### Operation

 - [Overview](api-ref/grpc/Operation/index.md)

 - [Get](api-ref/grpc/Operation/get.md)

 - [Cancel](api-ref/grpc/Operation/cancel.md)

#### SymmetricCrypto

 - [Overview](api-ref/grpc/SymmetricCrypto/index.md)

 - [Encrypt](api-ref/grpc/SymmetricCrypto/encrypt.md)

 - [Decrypt](api-ref/grpc/SymmetricCrypto/decrypt.md)

 - [ReEncrypt](api-ref/grpc/SymmetricCrypto/reEncrypt.md)

 - [GenerateDataKey](api-ref/grpc/SymmetricCrypto/generateDataKey.md)

#### SymmetricKey

 - [Overview](api-ref/grpc/SymmetricKey/index.md)

 - [Create](api-ref/grpc/SymmetricKey/create.md)

 - [Get](api-ref/grpc/SymmetricKey/get.md)

 - [List](api-ref/grpc/SymmetricKey/list.md)

 - [ListVersions](api-ref/grpc/SymmetricKey/listVersions.md)

 - [Update](api-ref/grpc/SymmetricKey/update.md)

 - [Delete](api-ref/grpc/SymmetricKey/delete.md)

 - [SetPrimaryVersion](api-ref/grpc/SymmetricKey/setPrimaryVersion.md)

 - [ScheduleVersionDestruction](api-ref/grpc/SymmetricKey/scheduleVersionDestruction.md)

 - [CancelVersionDestruction](api-ref/grpc/SymmetricKey/cancelVersionDestruction.md)

 - [Rotate](api-ref/grpc/SymmetricKey/rotate.md)

 - [ListOperations](api-ref/grpc/SymmetricKey/listOperations.md)

 - [ListAccessBindings](api-ref/grpc/SymmetricKey/listAccessBindings.md)

 - [SetAccessBindings](api-ref/grpc/SymmetricKey/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/grpc/SymmetricKey/updateAccessBindings.md)

#### Key Management Service API

 - [Overview](asymmetricencryption/api-ref/grpc/index.md)

##### AsymmetricEncryptionCrypto

 - [Overview](asymmetricencryption/api-ref/grpc/AsymmetricEncryptionCrypto/index.md)

 - [Decrypt](asymmetricencryption/api-ref/grpc/AsymmetricEncryptionCrypto/decrypt.md)

 - [GetPublicKey](asymmetricencryption/api-ref/grpc/AsymmetricEncryptionCrypto/getPublicKey.md)

##### AsymmetricEncryptionKey

 - [Overview](asymmetricencryption/api-ref/grpc/AsymmetricEncryptionKey/index.md)

 - [Create](asymmetricencryption/api-ref/grpc/AsymmetricEncryptionKey/create.md)

 - [Get](asymmetricencryption/api-ref/grpc/AsymmetricEncryptionKey/get.md)

 - [List](asymmetricencryption/api-ref/grpc/AsymmetricEncryptionKey/list.md)

 - [Update](asymmetricencryption/api-ref/grpc/AsymmetricEncryptionKey/update.md)

 - [Delete](asymmetricencryption/api-ref/grpc/AsymmetricEncryptionKey/delete.md)

 - [ListOperations](asymmetricencryption/api-ref/grpc/AsymmetricEncryptionKey/listOperations.md)

 - [ListAccessBindings](asymmetricencryption/api-ref/grpc/AsymmetricEncryptionKey/listAccessBindings.md)

 - [SetAccessBindings](asymmetricencryption/api-ref/grpc/AsymmetricEncryptionKey/setAccessBindings.md)

 - [UpdateAccessBindings](asymmetricencryption/api-ref/grpc/AsymmetricEncryptionKey/updateAccessBindings.md)

##### Operation

 - [Overview](asymmetricencryption/api-ref/grpc/Operation/index.md)

 - [Get](asymmetricencryption/api-ref/grpc/Operation/get.md)

 - [Cancel](asymmetricencryption/api-ref/grpc/Operation/cancel.md)

#### Key Management Service API

 - [Overview](asymmetricsignature/api-ref/grpc/index.md)

##### AsymmetricSignatureCrypto

 - [Overview](asymmetricsignature/api-ref/grpc/AsymmetricSignatureCrypto/index.md)

 - [Sign](asymmetricsignature/api-ref/grpc/AsymmetricSignatureCrypto/sign.md)

 - [SignHash](asymmetricsignature/api-ref/grpc/AsymmetricSignatureCrypto/signHash.md)

 - [GetPublicKey](asymmetricsignature/api-ref/grpc/AsymmetricSignatureCrypto/getPublicKey.md)

##### AsymmetricSignatureKey

 - [Overview](asymmetricsignature/api-ref/grpc/AsymmetricSignatureKey/index.md)

 - [Create](asymmetricsignature/api-ref/grpc/AsymmetricSignatureKey/create.md)

 - [Get](asymmetricsignature/api-ref/grpc/AsymmetricSignatureKey/get.md)

 - [List](asymmetricsignature/api-ref/grpc/AsymmetricSignatureKey/list.md)

 - [Update](asymmetricsignature/api-ref/grpc/AsymmetricSignatureKey/update.md)

 - [Delete](asymmetricsignature/api-ref/grpc/AsymmetricSignatureKey/delete.md)

 - [ListOperations](asymmetricsignature/api-ref/grpc/AsymmetricSignatureKey/listOperations.md)

 - [ListAccessBindings](asymmetricsignature/api-ref/grpc/AsymmetricSignatureKey/listAccessBindings.md)

 - [SetAccessBindings](asymmetricsignature/api-ref/grpc/AsymmetricSignatureKey/setAccessBindings.md)

 - [UpdateAccessBindings](asymmetricsignature/api-ref/grpc/AsymmetricSignatureKey/updateAccessBindings.md)

##### Operation

 - [Overview](asymmetricsignature/api-ref/grpc/Operation/index.md)

 - [Get](asymmetricsignature/api-ref/grpc/Operation/get.md)

 - [Cancel](asymmetricsignature/api-ref/grpc/Operation/cancel.md)

### REST (англ.)

 - [Overview](api-ref/index.md)

#### Operation

 - [Overview](api-ref/Operation/index.md)

 - [Get](api-ref/Operation/get.md)

 - [Cancel](api-ref/Operation/cancel.md)

#### SymmetricCrypto

 - [Overview](api-ref/SymmetricCrypto/index.md)

 - [Encrypt](api-ref/SymmetricCrypto/encrypt.md)

 - [Decrypt](api-ref/SymmetricCrypto/decrypt.md)

 - [ReEncrypt](api-ref/SymmetricCrypto/reEncrypt.md)

 - [GenerateDataKey](api-ref/SymmetricCrypto/generateDataKey.md)

#### SymmetricKey

 - [Overview](api-ref/SymmetricKey/index.md)

 - [Create](api-ref/SymmetricKey/create.md)

 - [Get](api-ref/SymmetricKey/get.md)

 - [List](api-ref/SymmetricKey/list.md)

 - [ListVersions](api-ref/SymmetricKey/listVersions.md)

 - [Update](api-ref/SymmetricKey/update.md)

 - [Delete](api-ref/SymmetricKey/delete.md)

 - [SetPrimaryVersion](api-ref/SymmetricKey/setPrimaryVersion.md)

 - [ScheduleVersionDestruction](api-ref/SymmetricKey/scheduleVersionDestruction.md)

 - [CancelVersionDestruction](api-ref/SymmetricKey/cancelVersionDestruction.md)

 - [Rotate](api-ref/SymmetricKey/rotate.md)

 - [ListOperations](api-ref/SymmetricKey/listOperations.md)

 - [ListAccessBindings](api-ref/SymmetricKey/listAccessBindings.md)

 - [SetAccessBindings](api-ref/SymmetricKey/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/SymmetricKey/updateAccessBindings.md)

#### Key Management Service API

 - [Overview](asymmetricencryption/api-ref/index.md)

##### AsymmetricEncryptionCrypto

 - [Overview](asymmetricencryption/api-ref/AsymmetricEncryptionCrypto/index.md)

 - [Decrypt](asymmetricencryption/api-ref/AsymmetricEncryptionCrypto/decrypt.md)

 - [GetPublicKey](asymmetricencryption/api-ref/AsymmetricEncryptionCrypto/getPublicKey.md)

##### AsymmetricEncryptionKey

 - [Overview](asymmetricencryption/api-ref/AsymmetricEncryptionKey/index.md)

 - [Create](asymmetricencryption/api-ref/AsymmetricEncryptionKey/create.md)

 - [Get](asymmetricencryption/api-ref/AsymmetricEncryptionKey/get.md)

 - [List](asymmetricencryption/api-ref/AsymmetricEncryptionKey/list.md)

 - [Update](asymmetricencryption/api-ref/AsymmetricEncryptionKey/update.md)

 - [Delete](asymmetricencryption/api-ref/AsymmetricEncryptionKey/delete.md)

 - [ListOperations](asymmetricencryption/api-ref/AsymmetricEncryptionKey/listOperations.md)

 - [ListAccessBindings](asymmetricencryption/api-ref/AsymmetricEncryptionKey/listAccessBindings.md)

 - [SetAccessBindings](asymmetricencryption/api-ref/AsymmetricEncryptionKey/setAccessBindings.md)

 - [UpdateAccessBindings](asymmetricencryption/api-ref/AsymmetricEncryptionKey/updateAccessBindings.md)

##### Operation

 - [Overview](asymmetricencryption/api-ref/Operation/index.md)

 - [Get](asymmetricencryption/api-ref/Operation/get.md)

 - [Cancel](asymmetricencryption/api-ref/Operation/cancel.md)

#### Key Management Service API

 - [Overview](asymmetricsignature/api-ref/index.md)

##### AsymmetricSignatureCrypto

 - [Overview](asymmetricsignature/api-ref/AsymmetricSignatureCrypto/index.md)

 - [Sign](asymmetricsignature/api-ref/AsymmetricSignatureCrypto/sign.md)

 - [SignHash](asymmetricsignature/api-ref/AsymmetricSignatureCrypto/signHash.md)

 - [GetPublicKey](asymmetricsignature/api-ref/AsymmetricSignatureCrypto/getPublicKey.md)

##### AsymmetricSignatureKey

 - [Overview](asymmetricsignature/api-ref/AsymmetricSignatureKey/index.md)

 - [Create](asymmetricsignature/api-ref/AsymmetricSignatureKey/create.md)

 - [Get](asymmetricsignature/api-ref/AsymmetricSignatureKey/get.md)

 - [List](asymmetricsignature/api-ref/AsymmetricSignatureKey/list.md)

 - [Update](asymmetricsignature/api-ref/AsymmetricSignatureKey/update.md)

 - [Delete](asymmetricsignature/api-ref/AsymmetricSignatureKey/delete.md)

 - [ListOperations](asymmetricsignature/api-ref/AsymmetricSignatureKey/listOperations.md)

 - [ListAccessBindings](asymmetricsignature/api-ref/AsymmetricSignatureKey/listAccessBindings.md)

 - [SetAccessBindings](asymmetricsignature/api-ref/AsymmetricSignatureKey/setAccessBindings.md)

 - [UpdateAccessBindings](asymmetricsignature/api-ref/AsymmetricSignatureKey/updateAccessBindings.md)

##### Operation

 - [Overview](asymmetricsignature/api-ref/Operation/index.md)

 - [Get](asymmetricsignature/api-ref/Operation/get.md)

 - [Cancel](asymmetricsignature/api-ref/Operation/cancel.md)

 - [Метрики Monitoring](metrics.md)

 - [Аудитные логи Audit Trails](at-ref.md)

 - [Вопросы и ответы](qa/index.md)

 - [Обучающие курсы](training.md)