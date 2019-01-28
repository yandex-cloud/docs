## Static access keys compatible with the Amazon AWS API {#access-keys}

_Static access keys_ consist of a private key and a key ID used in services with an AWS-compatible API, such as [!KEYREF objstorage-name].

The user signs a request with the private key and passes in it the key ID from the [AccessKey](/docs/iam/api-ref/AccessKey/) resource. Yandex.Cloud finds the key with the specified ID and uses it to verify the received signature. Since the key is linked to the account, this allows authenticating the user who is performing the operation.

#### See also

- [How to use the API in [!KEYREF objstorage-name]](../../../storage/s3/index.md)
- [[!TITLE]](../../operations/sa/create-access-key.md)

