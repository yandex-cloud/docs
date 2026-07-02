[Документация Yandex Cloud](../../../index.md) > [Практические руководства](../../index.md) > [Безопасность](../index.md) > [Шифрование данных](index.md) > Шифрование с помощью AWS Encryption SDK

# Шифрование данных с помощью AWS Encryption SDK

[AWS Encryption SDK](https://docs.aws.amazon.com/encryption-sdk/latest/developer-guide/introduction.html) — библиотека, упрощающая процесс шифрования и расшифрования данных. Используйте ее, если хотите безопасно зашифровать данные, не углубляясь в тонкости работы алгоритмов шифрования.

[Провайдер Yandex Cloud для AWS Encryption SDK](https://github.com/yandex-cloud/kms-clients-java/tree/master/kms-provider-awsCrypto) позволяет с помощью AWS Encryption SDK шифровать и расшифровывать данные на ключах Yandex Key Management Service. Данные шифруются [по схеме envelope encryption](../../../kms/concepts/envelope.md) (объем открытого текста не ограничен). Поддерживается только провайдер на Java.

## Добавление зависимостей {#dependency}

Перед началом работы необходимо добавить зависимости.

{% list tabs group=programming_language %}

- Java {#java}

    Добавьте зависимости с помощью [Apache Maven](https://maven.apache.org/):

    ```java
    <dependency>
        <groupId>com.yandex.cloud</groupId>
        <artifactId>kms-provider-awscrypto</artifactId>
        <version>2.1</version>
    </dependency>
    ```

{% endlist %}

## Шифрование и расшифрование {#encrypt-decrypt}

Создайте провайдер Yandex Cloud для AWS Encryption SDK и используйте методы класса [AwsCrypto](https://aws.github.io/aws-encryption-sdk-java/com/amazonaws/encryptionsdk/AwsCrypto.html) для шифрования и расшифрования данных.

{% list tabs group=programming_language %}

- Java {#java}

    ```java
    YcKmsMasterKeyProvider provider = new YcKmsMasterKeyProvider()
        .withEndpoint(endpoint)
        .withCredentials(credentialProvider)
        .withKeyId(keyId);
    AwsCrypto awsCrypto = AwsCrypto.standard();

    ...

    byte[] ciphertext = awsCrypto.encryptData(provider, plaintext, aad).getResult();

    ...

    byte[] plaintext = awsCrypto.decryptData(provider, ciphertext).getResult();

    ```

    Где:

    * `endpoint` – `api.cloud.yandex.net:443`.
    * `credentials` – определяет способ аутентификации, подробнее читайте в разделе [Аутентификация в SDK Yandex Cloud](../../../kms/tutorials/encrypt/sdk.md#auth).
    * `keyId` – идентификатор [ключа KMS](../../../kms/concepts/key.md).
    * `plaintext` – открытый текст.
    * `ciphertext` – шифртекст.
    * `aad` – [AAD-контекст](../../../kms/concepts/symmetric-encryption.md#add-context).

{% endlist %}

#### Полезные ссылки {#see-also}
* [AWS Encryption SDK](https://docs.aws.amazon.com/encryption-sdk/latest/developer-guide/introduction.html).
* [Провайдер Yandex Cloud для AWS Encryption SDK](https://github.com/yandex-cloud/kms-clients-java/tree/master/kms-provider-awsCrypto).
* [Примеры использования провайдера Yandex Cloud KMS Providers для AWS Encryption SDK](https://github.com/yandex-cloud/kms-clients-java/tree/master/kms-provider-awsCrypto/src/main/java/com/yandex/cloud/kms/providers/examples).