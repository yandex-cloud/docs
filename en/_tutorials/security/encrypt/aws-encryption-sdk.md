# Encrypting data using the AWS Encryption SDK

[AWS Encryption SDK](https://docs.aws.amazon.com/encryption-sdk/latest/developer-guide/introduction.html) is a library that simplifies the process of encrypting and decrypting data. Use it if you want to securely encrypt data without going into the details of encryption algorithms.

With the [{{ yandex-cloud }} provider for the AWS Encryption SDK](https://github.com/yandex-cloud/kms-clients-java/tree/master/kms-provider-awsCrypto), you can use the AWS Encryption SDK to encrypt and decrypt data in {{ kms-full-name }} keys. Data is encrypted using [envelope encryption](../../../kms/concepts/envelope.md) (the size of plaintext is not limited). The provider is only supported for Java.

## Adding dependencies {#dependency}

Before you start, you need to add dependencies.

{% list tabs group=programming_language %}

- Java {#java}

    Add dependencies using [Apache Maven](https://maven.apache.org/):

    ```java
    <dependency>
        <groupId>com.yandex.cloud</groupId>
        <artifactId>kms-provider-awscrypto</artifactId>
        <version>2.1</version>
    </dependency>
    ```

{% endlist %}

## Encryption and decryption {#encrypt-decrypt}

Create a {{ yandex-cloud }} provider for the AWS Encryption SDK and use the methods of the [AwsCrypto](https://aws.github.io/aws-encryption-sdk-java/com/amazonaws/encryptionsdk/AwsCrypto.html) class to encrypt and decrypt data.

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

    Where:

    * `endpoint`: `{{ api-host }}:443`.
    * `credentials`: Sets the authentication method. For more information, see [Authentication in the {{ yandex-cloud }} SDK](../../../kms/tutorials/encrypt/sdk.md#auth).
    * `keyId`: ID of the [{{ kms-short-name }}](../../../kms/concepts/key.md) key.
    * `plaintext`: Unencrypted text.
    * `ciphertext`: Ciphertext.
    * `aad`: [AAD context](../../../kms/concepts/symmetric-encryption.md#add-context).

{% endlist %}

#### See also {#see-also}
* [AWS Encryption SDK](https://docs.aws.amazon.com/encryption-sdk/latest/developer-guide/introduction.html)
* [{{ yandex-cloud }} provider for the AWS Encryption SDK](https://github.com/yandex-cloud/kms-clients-java/tree/master/kms-provider-awsCrypto)
* [Examples of using {{ yandex-cloud }} KMS Providers for the AWS Encryption SDK](https://github.com/yandex-cloud/kms-clients-java/tree/master/kms-provider-awsCrypto/src/main/java/com/yandex/cloud/kms/providers/examples)
