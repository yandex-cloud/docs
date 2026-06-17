# Шифрование данных с помощью SDK Yandex Cloud

С Yandex Key Management Service можно работать с помощью SDK Yandex Cloud. Реализация SDK есть на [Java](https://github.com/yandex-cloud/java-sdk), [Go](https://github.com/yandex-cloud/go-sdk), [Python](https://github.com/yandex-cloud/python-sdk) и [Node.js](https://github.com/yandex-cloud/nodejs-sdk).

SDK Yandex Cloud наиболее удобен для шифрования данных небольшого размера (ограничение на размер открытого текста – 32 КБ). Для шифрования данных большего объема рекомендуется использовать [AWS Encryption SDK](../../../kms/tutorials/encrypt/aws-encryption-sdk.md) или [Google Tink](../../../kms/tutorials/encrypt/google-tink.md). Они шифруют данные [по схеме envelope encryption](../../../kms/concepts/envelope.md).

## Добавление зависимостей {#dependency}

Перед началом работы необходимо добавить зависимости.

{% list tabs group=programming_language %}

- Java {#java}

    Добавьте зависимости с помощью [Apache Maven](https://maven.apache.org/):

    ```java
    <dependency>
        <groupId>com.yandex.cloud</groupId>
        <artifactId>java-sdk-services</artifactId>
        <version>2.4.2</version>
    </dependency>
    ```

- Go {#go}

    Установите SDK:

    ```go
    go get github.com/yandex-cloud/go-sdk
    ```

{% endlist %}

## Аутентификация {#auth}

Аутентифицироваться можно с помощью:
* [сервисного аккаунта, привязанного к виртуальной машине Yandex Cloud](#vm);
* [произвольного сервисного аккаунта](#sa);
* [пользовательского аккаунта](#yandex-acc).

### Аутентификация с сервисным аккаунтом, привязанным к виртуальной машине Yandex Cloud {#vm}

{% list tabs group=programming_language %}

- Java {#java}

    Аутентифицируйтесь с сервисным аккаунтом, привязанным к [ВМ](../../../glossary/vm.md):

    ```java
    CredentialProvider credentialProvider = Auth.computeEngineBuilder().build();
    ```

- Go {#go}

    Аутентифицируйтесь с сервисным аккаунтом, привязанным к ВМ:

    ```Go
    credentials := ycsdk.InstanceServiceAccount()
    ```

{% endlist %}

### Аутентификация с произвольным сервисным аккаунтом {#sa}

В `key.json` должен содержаться авторизованный ключ сервисного аккаунта. Как создать авторизованный ключ читайте в разделе [Создать авторизованный ключ](../../../iam/operations/authentication/manage-authorized-keys.md#create-authorized-key).

{% list tabs group=programming_language %}

- Java {#java}

    Аутентифицируйтесь с произвольным сервисным аккаунтом:

    ```java
    CredentialProvider credentialProvider = Auth.apiKeyBuilder().fromFile(Paths.get("key.json")).build();

    ```

- Go {#go}

    Аутентифицируйтесь с произвольным сервисным аккаунтом:

    ```Go
    authorizedKey, err := iamkey.ReadFromJSONFile("key.json")
    if err != nil {...}
    credentials, err := ycsdk.ServiceAccountKey(authorizedKey)
    if err != nil {...}
    ```

{% endlist %}


### Аутентификация с пользовательским аккаунтом {#yandex-acc}

Пользовательским аккаунтом считается [аккаунт на Яндексе](../../../iam/concepts/users/accounts.md#passport), [федеративный](../../../iam/concepts/users/accounts.md#saml-federation) и [локальный аккаунт](../../../iam/concepts/users/accounts.md#local).

{% note warning %}

Аутентификация с пользовательским аккаунтом может быть небезопасна. Рекомендуем использовать сервисный аккаунт.

{% endnote %}

Переменная `token` — это ваш [IAM-токен](../../../iam/concepts/authorization/iam-token.md). Подробнее о получении IAM-токена читайте в документации [Yandex Identity and Access Management](../../../iam/operations/iam-token/create.md).

{% list tabs group=programming_language %}

- Java {#java}

    ```java
    CredentialProvider credentialProvider = Auth.iamTokenBuilder()
            .token(token)
            .build();
    ```

- Go {#go}

    ```Go
    credentials := ycsdk.NewIAMTokenCredentials(token)
    ```

{% endlist %}

## Шифрование и расшифрование данных {#enc-dec}

{% note info %}

Изменения, вызванные [eventually consistent операциями](../../../kms/concepts/consistency.md), становятся применимыми для шифрования и расшифрования с задержкой до трех часов.

{% endnote %}

Используйте методы `encrypt` и `decrypt` для шифрования и расшифрования данных. В коде используются следующие переменные: 
* `endpoint` – `api.cloud.yandex.net:443`.
* `keyId` – идентификатор [ключа KMS](../../../kms/concepts/key.md).
* `plaintext` – открытый текст (не более 32 КБ).
* `ciphertext` – шифртекст.
* `aad` – [AAD-контекст](../../../kms/concepts/symmetric-encryption.md#add-context).

{% list tabs group=programming_language %}

- Java {#java}

    ```Java
    SymmetricCryptoServiceBlockingStub symmetricCryptoService = ServiceFactory.builder()
        .endpoint(endpoint)
        .credentialProvider(credentialProvider)
        .build()
        .create(
            SymmetricCryptoServiceBlockingStub.class,
            SymmetricCryptoServiceGrpc::newBlockingStub
        );

    ...

    byte[] ciphertext = symmetricCryptoService.encrypt(SymmetricEncryptRequest.newBuilder()
        .setKeyId(keyId)
        .setPlaintext(ByteString.copyFrom(plaintext))
        .setAadContext(ByteString.copyFrom(aad))
        .build()
    ).getCiphertext().toByteArray();

    ...

    byte[] plaintext = symmetricCryptoService.decrypt(SymmetricDecryptRequest.newBuilder()
        .setKeyId(keyId)
        .setCiphertext(ByteString.copyFrom(ciphertext))
        .setAadContext(ByteString.copyFrom(aad))
        .build()
    ).getPlaintext().toByteArray();

    ```

- Go {#go}

    ```Go
    sdk, err := ycsdk.Build(context, ycsdk.Config{
      Endpoint:    endpoint,
      Credentials: credentials,
    })
    if err != nil {...}
    
    ...
    
    response, err := sdk.KMSCrypto().SymmetricCrypto().Encrypt(context, &kms.SymmetricEncryptRequest{
      KeyId:      keyId,
      Plaintext:  plaintext,
      AadContext: aad,
    })
    if err != nil {...}
    ciphertext := response.Ciphertext
    
    ...
    
    response, err := sdk.KMSCrypto().SymmetricCrypto().Decrypt(context, &kms.SymmetricDecryptRequest{
      KeyId:      keyId,
      Ciphertext: ciphertext,
      AadContext: aad,
    })
    if err != nil {...}
    plaintext := response.Plaintext
    ```

{% endlist %}

#### Полезные ссылки {#see-also}

* [Yandex Cloud Java SDK](https://github.com/yandex-cloud/java-sdk).
* [Примеры работы с KMS с помощью Java SDK](https://github.com/yandex-cloud/java-sdk/tree/master/java-sdk-examples/src/main/java/yandex/cloud/sdk/examples/kms).
* [Yandex Cloud Go SDK](https://github.com/yandex-cloud/go-sdk).