# Шифрование данных с помощью Google Tink

[Tink](https://github.com/google/tink) — это библиотека шифрования от Google, альтернатива [AWS Encryption](aws-encryption-sdk.md). Библиотека помогает сосредоточиться на задаче шифрования и расшифровки данных, не отвлекаясь на выбор правильного алгоритма и параметров шифрования.

Поддерживаются [Java](https://github.com/yandex-cloud/kms-clients-java/tree/master/kms-provider-tink) и [Go](https://github.com/yandex-cloud/kms-clients-go) версии клиентов для Tink, позволяющие шифровать и расшифровывать данные на ключах {{ kms-short-name }} {{ yandex-cloud }}. Данные шифруются [по схеме envelope encryption](../../concepts/envelope.md) (объем открытого текста не ограничен).

## Добавление зависимости {#dependency}

Перед началом работы необходимо добавить зависимости.

{% list tabs %}

- Java
    
    Добавьте зависимости с помощью [Apache Maven](https://maven.apache.org/):
    
    ```java
    <dependency>
        <groupId>com.yandex.cloud</groupId>
        <artifactId>kms-provider-tink</artifactId>
        <version>1.0</version>
    </dependency>
    ```

- Go

    Выполните команду: 
    
    ```go
    go get github.com/yandex-cloud/kms-clients-go/yckmstink
    ```

{% endlist %}

## Шифрование и расшифровка {#encrypt-decrypt}

В коде используются следующие переменные: 
* `credentials` – определяет способ аутентификации, подробнее читайте в разделе [Аутентификация в SDK {{ yandex-cloud }}](sdk.md#auth).
* `keyId` – идентификатор [ключа {{ kms-short-name }}](../../concepts/key.md).
* `plaintext` – открытый текст.
* `ciphertext` – шифртекст.
* `aad` – [AAD-контекст](../../concepts/encryption.md#add-context).

{% list tabs %}

- Java
    
    Создайте [Aead](https://google.github.io/tink/javadoc/tink/1.3.0/index.html?com/google/crypto/tink/Aead.html)-объект и используйте методы encrypt и decrypt для шифрования и расшифровки данных:
    
    ```
    AeadConfig.register(); 
    KmsClients.add(new YcKmsClient(() -> credentials));
    
    String keyUri = "yc-kms://" + keyId;
    Aead kmsAead = KmsClients.get(keyUri).getAead(keyUri);
    Aead aead = new KmsEnvelopeAead(AeadKeyTemplates.AES256_GCM, kmsAead);
    
    ...
    
    byte[] ciphertext = aead.encrypt(plaintext, aad);
    
    ...
    
    byte[] plaintext = aead.decrypt(ciphertext, aad);
    ```

- Go

    Создайте [aead](https://pkg.go.dev/github.com/google/tink/go/aead?tab=doc)-объект и используйте методы encrypt и decrypt для шифрования и расшифровки данных:
    
    ```
    sdk, err := ycsdk.Build(context, ycsdk.Config{
      Credentials: credentials,
    })
    if err != nil {...}
    
    kmsAead := yckmstink.NewYCAEAD(keyId, sdk)
    aead := aead.NewKMSEnvelopeAEAD(*aead.AES256GCMKeyTemplate(), kmsAead)
    
    ...
    
    ciphertext, err := aead.Encrypt(plaintext, aad)
    if err != nil {...}
    
    ...
    
    plaintext, err := aead.Decrypt(ciphertext, aad)
    if err != nil {...}
    ```

{% endlist %}

#### См. также {#see-also}

* [Google Tink](https://github.com/google/tink).
* [Java-клиент для Tink](https://github.com/yandex-cloud/kms-clients-java/tree/master/kms-provider-tink).
* [Примеры использования Java-клиента для Tink](https://github.com/yandex-cloud/kms-clients-java/tree/master/kms-provider-tink/src/main/java/com/yandex/cloud/kms/providers/examples).
* [Go-клиент для Tink](https://github.com/yandex-cloud/kms-clients-go).
* [Примеры использования Go-клиента для Tink](https://github.com/yandex-cloud/kms-clients-go/tree/master/yckmstink/examples).
