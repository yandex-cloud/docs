# Encrypting data using Google Tink

[Tink](https://github.com/google/tink) is Google's cryptographic library, an alternative to [AWS Encryption](aws-encryption-sdk.md). The library helps you focus on encrypting and decrypting data without the need to choose the correct encryption algorithm and parameters.

It supports [Java](https://github.com/yandex-cloud/kms-clients-java/tree/master/kms-provider-tink) and [Go](https://github.com/yandex-cloud/kms-clients-go) Tink client versions, which provide encryption and decryption of data using {{ kms-short-name }} {{ yandex-cloud }} keys. Data is encrypted using [envelope encryption](../../concepts/envelope.md) (the size of plaintext is not limited).

## Adding dependencies {#dependency}

Before you start, you need to add dependencies.

{% list tabs group=programming_language %}

- Java {#java}

   Add dependencies using [Apache Maven](https://maven.apache.org/):

   ```java
   <dependency>
       <groupId>com.yandex.cloud</groupId>
       <artifactId>kms-provider-tink</artifactId>
       <version>2.6</version>
   </dependency>
   ```

- Go {#go}

   Run this command:

   ```go
   go get github.com/yandex-cloud/kms-clients-go/yckmstink
   ```

{% endlist %}

## Encryption and decryption {#encrypt-decrypt}

The code uses the following variables:

* `endpoint`: `{{ api-host }}:443`
* `credentialProvider` or `credentials`: Determines the authentication method (for more information, see [Authentication in the {{ yandex-cloud }} SDK](sdk.md#auth)).
* `keyId`: ID of the [key in {{ kms-short-name }}](../../concepts/key.md)
* `plaintext`: Unencrypted text
* `ciphertext`: Encrypted text
* `aad`: [AAD context](../../concepts/symmetric-encryption.md#add-context)

{% list tabs group=programming_language %}

- Java {#java}

   Create an [Aead](https://google.github.io/tink/javadoc/tink/1.3.0/index.html?com/google/crypto/tink/Aead.html) object and use the encrypt and decrypt methods for data encryption and decryption:

   ```
   AeadConfig.register();
   KmsClients.add(new YcKmsClient(credentialProvider).withEndpoint(endpoint));

   String keyUri = "yc-kms://" + keyId;
   Aead kmsAead = KmsClients.get(keyUri).getAead(keyUri);
   Aead aead = new KmsEnvelopeAead(AeadKeyTemplates.AES256_GCM, kmsAead);

   ...

   byte[] ciphertext = aead.encrypt(plaintext, aad);

   ...

   byte[] plaintext = aead.decrypt(ciphertext, aad);
   ```

- Go {#go}

   Create an [Aead](https://pkg.go.dev/github.com/google/tink/go/aead?tab=doc) object and use the encrypt and decrypt methods for data encryption and decryption:

   ```
   sdk, err := ycsdk.Build(context, ycsdk.Config{
     Endpoint:    endpoint,
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

#### See also {#see-also}

* [Google Tink](https://github.com/google/tink)
* [Java client for Tink](https://github.com/yandex-cloud/kms-clients-java/tree/master/kms-provider-tink)
* [Examples of using the Java client for Tink](https://github.com/yandex-cloud/kms-clients-java/tree/master/kms-provider-tink/src/main/java/com/yandex/cloud/kms/providers/examples)
* [Go client for Tink](https://github.com/yandex-cloud/kms-clients-go)
* [Examples of using the Go client for Tink](https://github.com/yandex-cloud/kms-clients-go/tree/master/yckmstink/examples)
