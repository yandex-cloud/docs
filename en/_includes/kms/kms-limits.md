#### Quotas {#kms-quotas}

{% note info %}

Each asymmetric [encryption](../../kms/concepts/asymmetric-signature-key.md) or [signature](../../kms/concepts/asymmetric-signature-key.md) key pair counts towards the quota as a single key.

{% endnote %}

| Type of limit | Value |
----- | -----
| Number of keys per cloud | 100 |

#### Limits {#kms-limits}

| Type of limit | Value |
----- | -----
| Number of versions per key | 100 |
| Maximum amount of data to encrypt with the [encrypt](../../kms/api-ref/SymmetricCrypto/encrypt) operation | 32 KB |
