# Шифрование данных с помощью AWS Encryption SDK

[AWS Encryption SDK](https://docs.aws.amazon.com/encryption-sdk/latest/developer-guide/introduction.html) — библиотека, упрощающая процесс шифрования и расшифровки данных. Используйте ее, если хотите безопасно зашифровать данные, не углубляясь в тонкости работы алгоритмов шифрования.

[Провайдер {{ yandex-cloud }} для AWS Encryption SDK](https://github.com/yandex-cloud/kms-clients-java/tree/master/kms-provider-awsCrypto) позволяет с помощью AWS Encryption SDK шифровать и расшифровывать данные на ключах {{ kms-short-name }} {{ yandex-cloud }}. Данные шифруются [по схеме envelope encryption](../../concepts/envelope.md) (объем открытого текста не ограничен). Поддерживается только провайдер на Java.

## Добавление зависимостей {#dependency}

Перед началом работы необходимо добавить зависимости.

{% list tabs %}

- Java

    Добавьте зависимости с помощью [Apache Maven](https://maven.apache.org/):

    ```java
    <dependency>
        <groupId>com.yandex.cloud</groupId>
        <artifactId>kms-provider-awscrypto</artifactId>
        <version>1.0</version>
    </dependency>
    ```

{% endlist %}

## Шифрование и расшифровка {#encrypt-decrypt}

Создайте провайдер {{ yandex-cloud }} для AWS Encryption SDK и используйте методы класса [AwsCrypto](https://aws.github.io/aws-encryption-sdk-java/javadoc/com/amazonaws/encryptionsdk/AwsCrypto.html) для шифрования и расшифровки данных.

{% list tabs %}

- Java

    ```java
    YcKmsMasterKeyProvider provider = YcKmsMasterKeyProvider.builder()
        .setCredentialsSupplier(() -> credentials)
        .setKeyId(keyId)
        .build();
    AwsCrypto awsCrypto = new AwsCrypto();
    
    ...
    
    byte[] ciphertext = awsCrypto.encryptData(provider, plaintext, aad).getResult();
    
    ...
    
    byte[] plaintext = awsCrypto.decryptData(provider, ciphertext).getResult();
    ```

    Где: 
    
    * `credentials` – определяет способ аутентификации, подробнее читайте в разделе [Аутентификация в SDK {{ yandex-cloud }}](sdk.md#auth).
    * `keyId` – идентификатор [ключа {{ kms-short-name }}](../../concepts/key.md).
    * `plaintext` – открытый текст.
    * `ciphertext` – шифртекст.
    * `aad` – [AAD-контекст](../../concepts/encryption.md#add-context).

{% endlist %}

#### См. также {#see-also}
* [AWS Encryption SDK](https://docs.aws.amazon.com/encryption-sdk/latest/developer-guide/introduction.html).
* [Провайдер {{ yandex-cloud }} для AWS Encryption SDK](https://github.com/yandex-cloud/kms-clients-java/tree/master/kms-provider-awsCrypto).
* [Примеры использования провайдера Yandex.Cloud KMS Providers для AWS Encryption SDK](https://github.com/yandex-cloud/kms-clients-java/tree/master/kms-provider-awsCrypto/src/main/java/com/yandex/cloud/kms/providers/examples).
