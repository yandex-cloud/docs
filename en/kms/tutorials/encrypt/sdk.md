# Encrypting data using the {{ yandex-cloud }} SDK

You can use {{ kms-name }} with the {{ yandex-cloud }} SDK. The SDK is available for [Java](https://github.com/yandex-cloud/java-sdk), [Go](https://github.com/yandex-cloud/go-sdk), [Python](https://github.com/yandex-cloud/python-sdk), and [Node.js](https://github.com/yandex-cloud/nodejs-sdk).

The {{ yandex-cloud }} SDK is most convenient for encrypting small amounts of data (the limit on the size of plaintext is 32 KB). To encrypt larger amounts of data, we recommend using the [AWS Encryption SDK](aws-encryption-sdk.md) or [Google Tink](google-tink.md). They encrypt data using [envelope encryption](../../concepts/envelope.md).

## Adding dependencies {#dependency}

Before you start, you need to add dependencies.

{% list tabs %}

- Java

   Add dependencies using [Apache Maven](https://maven.apache.org/):

   ```java
   <dependency>
       <groupId>com.yandex.cloud</groupId>
       <artifactId>java-sdk-services</artifactId>
       <version>2.4.2</version>
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
* [The service account linked to the {{ yandex-cloud }} VM](#vm).
* [Any service account](#sa).
* [A Yandex account](#yandex-acc).

### Authentication using the service account linked to the {{ yandex-cloud }} VM {#vm}

{% list tabs %}

- Java

   Get authenticated using the service account linked to the VM:

   ```java
   CredentialProvider credentialProvider = Auth.computeEngineBuilder().build();
   ```

- Go

   Authenticate using the service account linked to the VM:

   ```Go
   credentials := ycsdk.InstanceServiceAccount()
   ```

{% endlist %}

### Authentication using any service account {#sa}

The `key.json` file must contain an authorized key for the service account. For information about how to create authorized keys, see [{#T}](../../../iam/operations/authorized-key/create.md).

{% list tabs %}

- Java

   Authenticate using any service account:

   ```java
   CredentialProvider credentialProvider = Auth.apiKeyBuilder().fromFile(Paths.get("key.json")).build();

   ```

- Go

   Authenticate using any service account:

   ```Go
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

   ```java
   CredentialProvider credentialProvider = Auth.oauthTokenBuilder().build();
   ```

- Go

   Authenticate using a Yandex account:

   ```Go
   credentials := ycsdk.OAuthToken(token)
   ```

{% endlist %}



## Encrypting and decrypting data {#enc-dec}

Use the `encrypt` and `decrypt` methods to encrypt and decrypt data. The code uses the following variables:
* `endpoint` – `{{ api-host }}:443`.
* `keyId`: ID of the [KMS key](../../concepts/key.md).
* `plaintext`: Unencrypted text (no more than 32 KB).
* `ciphertext`: Encrypted text.
* `aad`: [AAD context](../../concepts/encryption.md#add-context).

{% list tabs %}

- Java

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

- Go

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

#### See also {#see-also}

* [{{ yandex-cloud }} Java SDK](https://github.com/yandex-cloud/java-sdk).
* [Examples of how to use {{ kms-short-name }} with the Java SDK](https://github.com/yandex-cloud/java-sdk/tree/master/java-sdk-examples/src/main/java/yandex/cloud/sdk/examples/kms).
* [{{ yandex-cloud }} Go SDK](https://github.com/yandex-cloud/go-sdk).
