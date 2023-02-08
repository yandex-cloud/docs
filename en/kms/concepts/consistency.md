# Key consistency

The [encrypt](../api-ref/SymmetricCrypto/encrypt), [decrypt](../api-ref/SymmetricCrypto/decrypt) and [reEncrypt](../api-ref/SymmetricCrypto/reEncrypt) methods are eventually consistent operations: it takes up to **three hours** for the updates they make to take effect.

[Eventually consistent](https://en.wikipedia.org/wiki/Eventual_consistency) operations require up to **three hours** for the changes to take effect:
* Rotating keys (automatically and manually).
* Changing the primary version of a key.
* Changing the key status to `Inactive`.
* Scheduling a key version for destruction.
* Destroying keys.

[Strongly consistent](https://en.wikipedia.org/wiki/Strong_consistency) operations take effect without delay:
* Creating keys.
* Changing the key status to `Active`.
* Canceling scheduled key version destruction (the version status is `Scheduled For Destruction`).

{% note info %}

To quickly restrict access to a key, revoke the roles that are required to use the key when encrypting and decrypting data. For more information, see [{#T}](../security/index.md).

{% endnote %}