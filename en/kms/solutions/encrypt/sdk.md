# Encrypting data using the Yandex.Cloud SDK

You can use {{ kms-name }}with the Yandex.Cloud SDK. The SDK is available for [Java](https://github.com/yandex-cloud/java-sdk), [Go](https://github.com/yandex-cloud/go-sdk), [Python](https://github.com/yandex-cloud/python-sdk), and [Node.js](https://github.com/yandex-cloud/nodejs-sdk).

The Yandex.Cloud SDK is most convenient for encrypting small amounts of data (the limit on the size of plaintext is 32 KB). To encrypt larger amounts of data, we recommend using the [AWS Encryption SDK](aws-encryption-sdk.md) or [Google Tink](google-tink.md). They encrypt data using [envelope encryption](../../concepts/envelope.md).

## Adding dependencies {#dependency}

Before you start, you need to add dependencies.

{% list tabs %}

- Java

    Add dependencies using [Apache Maven](https://maven.apache.org/):

    ```java
    <dependency>
        <groupId>com.yandex.cloud</groupId>
        <artifactId>sdk</artifactId>
        <version>1.2.1</version>
    </dependency>
    ```

- Go

    Install the SDK:

    ```go
    go get github.com/yandex-cloud/go-sdk
    ```

{% endlist %}

## Authentication {#auth}

You can authenticate using:

* [The service account linked to the Yandex.Cloud VM](#vm).
* [Any service account](#sa).
* [A Yandex account](#yandex-acc).

### Authentication using the service account linked to the Yandex.Cloud VM {#vm}

{% list tabs %}

- Java

    Authenticate using the service account linked to the VM:

    ```
    Credentials credentials = Auth.fromMetadata();  
    ```

- Go

    Authenticate using the service account linked to the VM:

    ```
    credentials := ycsdk.InstanceServiceAccount()
    ```

{% endlist %}

### Authentication using any service account {#sa}

The `key.json` file must contain an authorized key for the service account. For information about how to create authorized keys, see [{#T}](../../../iam/operations/authorized-key/create.md).

{% list tabs %}

- Java

    Authenticate using any service account:

    ```
    Credentials credentials = Auth.fromFile(Auth::apiKey, Paths.get("key.json"));
    ```

- Go

    Authenticate using any service account:

    ```
    authorizedKey, err := iamkey.ReadFromJSONFile("key.json")
    if err != nil {...}
    credentials, err := ycsdk.ServiceAccountKey(authorizedKey)
    if err != nil {...}
    ```

{% endlist %}

### Authentication using a Yandex account {#yandex-acc}

The `token` variable is your [OAuth token](../../../iam/concepts/authorization/oauth-token.md).

{% list tabs %}

- Java

    Authenticate using a Yandex account:

    ```
    Credentials credentials = Auth.oauthToken(token);  
    ```

- Go

    Authenticate using a Yandex account:

    ```
    credentials := ycsdk.OAuthToken(token)
    ```

{% endlist %}

## Encrypting and decrypting data {#enc-dec}

Use the `encrypt` and `decrypt` methods to encrypt and decrypt data. The code uses the following variables:

* `keyId`: ID of the [KMS key](../../concepts/key.md).
* `plaintext`: Unencrypted text (no more than 32 KB).
* `ciphertext`: Encrypted text.
* `aad`: [AAD context](../../concepts/encryption.md#add-context).

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

#### See also {#see-also}

* [Yandex.Cloud Java SDK](https://github.com/yandex-cloud/java-sdk).
* [Examples of how to use {{ kms-short-name }} with the Java SDK](https://github.com/yandex-cloud/java-sdk/tree/master/src/main/java/yandex/cloud/sdk/examples/kms).
* [Yandex.Cloud Go SDK](https://github.com/yandex-cloud/go-sdk).

