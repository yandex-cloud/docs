# Шифрование данных с помощью SDK {{ yandex-cloud }}

С {{ kms-name }} можно работать с помощью SDK {{ yandex-cloud }}. Реализация SDK есть на [Java](https://github.com/yandex-cloud/java-sdk), [Go](https://github.com/yandex-cloud/go-sdk), [Python](https://github.com/yandex-cloud/python-sdk) и [Node.js](https://github.com/yandex-cloud/nodejs-sdk).

SDK {{ yandex-cloud }} наиболее удобен для шифрования данных небольшого размера (ограничение на размер открытого текста – 32 КБ). Для шифрования данных большего объема рекомендуется использовать [AWS Encryption SDK](aws-encryption-sdk.md) или [Google Tink](google-tink.md). Они шифруют данные [по схеме envelope encryption](../../concepts/envelope.md).

## Добавление зависимостей {#dependency}

Перед началом работы необходимо добавить зависимости.

{% list tabs %}

- Java 
    
    Добавьте зависимости с помощью [Apache Maven](https://maven.apache.org/):
    
    ```java
    <dependency>
        <groupId>com.yandex.cloud</groupId>
        <artifactId>sdk</artifactId>
        <version>1.2.1</version>
    </dependency>
    ```

- Go

    Установите SDK:
    
    ```go
    go get github.com/yandex-cloud/go-sdk
    ```

{% endlist %}

## Аутентификация {#auth}

Аутентифицироваться можно с помощью: 
* [сервисного аккаунта, привязанного к виртуальной машине {{ yandex-cloud }}](#vm);
* [произвольного сервисного аккаунта](#sa);
* [аккаунта на Яндексе](#yandex-acc).

### Аутентификация с сервисным аккаунтом, привязанным к виртуальной машине {{ yandex-cloud }} {#vm}

{% list tabs %}

- Java 
    
    Аутентифицируйтесь с сервисным аккаунтом, привязанным к ВМ:
    
    ```
    Credentials credentials = Auth.fromMetadata();  
    ``` 
- Go

    Аутентифицируйтесь с сервисным аккаунтом, привязанным к ВМ:
    
    ```
    credentials := ycsdk.InstanceServiceAccount()
    ```

{% endlist %}

### Аутентификация с произвольным сервисным аккаунтом {#sa}

В `key.json` должен содержаться авторизованный ключ сервисного аккаунта. Как создать авторизованный ключ читайте в разделе [{#T}](../../../iam/operations/authorized-key/create.md).

{% list tabs %}

- Java 

    Аутентифицируйтесь с произвольным сервисным аккаунтом:
    
    ```
    Credentials credentials = Auth.fromFile(Auth::apiKey, Paths.get("key.json"));
    ``` 
- Go

    Аутентифицируйтесь с произвольным сервисным аккаунтом:
    
    ```
    authorizedKey, err := iamkey.ReadFromJSONFile("key.json")
    if err != nil {...}
    credentials, err := ycsdk.ServiceAccountKey(authorizedKey)
    if err != nil {...}
    ```

{% endlist %}


### Аутентификация с аккаунтом на Яндексе {#yandex-acc}

Переменная `token` — это ваш [OAuth-токен](../../../iam/concepts/authorization/oauth-token.md).

{% list tabs %}

- Java 

    Аутентифицируйтесь с аккаунтом на Яндексе: 
    
    ```
    Credentials credentials = Auth.oauthToken(token);  
    ``` 
- Go

    Аутентифицируйтесь с аккаунтом на Яндексе: 

    ```
    credentials := ycsdk.OAuthToken(token)
    ```

{% endlist %}

## Шифрование и расшифровка данных {#enc-dec}

Используйте методы `encrypt` и `decrypt` для шифрования и расшифровки данных. В коде используются следующие переменные: 
* `keyId` – идентификатор [ключа KMS](../../concepts/key.md).
* `plaintext` – открытый текст (не более 32 КБ).
* `ciphertext` – шифртекст.
* `aad` – [AAD-контекст](../../concepts/encryption.md#add-context).

{% list tabs %}

- Java

    ```
    ServiceFactoryConfig config = ServiceFactoryConfig.builder()
        .credentials(credentials)
        .build();
    SymmetricCryptoServiceBlockingStub symmetricCryptoService = new ServiceFactory(config).create(
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

- Go

    ```
    sdk, err := ycsdk.Build(context, ycsdk.Config{
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

#### См. также {#see-also}

* [Yandex.Cloud Java SDK](https://github.com/yandex-cloud/java-sdk).
* [Примеры работы с {{ kms-short-name }} с помощью Java SDK](https://github.com/yandex-cloud/java-sdk/tree/master/java-sdk-examples/src/main/java/yandex/cloud/sdk/examples/kms).
* [Yandex.Cloud Go SDK](https://github.com/yandex-cloud/go-sdk). 

