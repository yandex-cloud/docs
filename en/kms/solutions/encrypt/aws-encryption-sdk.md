# Encrypting data using the AWS Encryption SDK

[The AWS Encryption SDK](https://docs.aws.amazon.com/encryption-sdk/latest/developer-guide/introduction.html) is a library that simplifies the process of encrypting and decrypting data. Use it if you want to securely encrypt data without going into the details of encryption algorithms.

[The Yandex.Cloud provider for the AWS Encryption SDK](https://github.com/yandex-cloud/kms-clients-java/tree/master/kms-provider-awsCrypto) lets you use the AWS Encryption SDK to encrypt and decrypt data with Yandex.Cloud {{ kms-short-name }} keys. Data is encrypted using [envelope encryption](../../concepts/envelope.md) (the size of plaintext is not limited). The provider is only supported for Java.

## Adding dependencies {#dependency}

Before you start, you need to add dependencies.

{% list tabs %}

- Java

    Add dependencies using [Apache Maven](https://maven.apache.org/):

    ```java
    <dependency>
        <groupId>com.yandex.cloud</groupId>
        <artifactId>kms-provider-awscrypto</artifactId>
        <version>1.0</version>
    </dependency>
    ```

{% endlist %}

## Encryption and decryption {#encrypt-decrypt}

Create a Yandex.Cloud provider for the AWS Encryption SDK and use the methods of the [AwsCrypto](https://aws.github.io/aws-encryption-sdk-java/javadoc/com/amazonaws/encryptionsdk/AwsCrypto.html) class to encrypt and decrypt data.

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

    Where:
    * `credentials`: Determines the authentication method (for more information, see [Authentication in the Yandex.Cloud SDK](sdk.md#auth)).
    * `keyId`: ID of the [key in {{ kms-short-name }}](../../concepts/key.md).
    * `plaintext`: Unencrypted text.
    * `ciphertext`: Encrypted text.
    * `aad`: [AAD context](../../concepts/encryption.md#add-context).

{% endlist %}

#### See also {#see-also}

* [AWS Encryption SDK](https://docs.aws.amazon.com/encryption-sdk/latest/developer-guide/introduction.html).
* [Yandex.Cloud provider for the AWS Encryption SDK](https://github.com/yandex-cloud/kms-clients-java/tree/master/kms-provider-awsCrypto).
* [Examples of using Yandex.Cloud KMS Providers for the AWS Encryption SDK](https://github.com/yandex-cloud/kms-clients-java/tree/master/kms-provider-awsCrypto/src/main/java/com/yandex/cloud/kms/providers/examples).

