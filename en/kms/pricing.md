---
editable: false
---

# Pricing for {{ kms-name }}

The cost of {{ kms-name }} usage is based on:

* The number of active key versions used: versions with the `Active` and `Scheduled For Destruction` statuses.

   {% note alert %}

   After a key is deleted, all of its versions continue to be charged for 3 days [pursuant to the deletion procedure](operations/key.md#delete).

   {% endnote %}

* The number of cryptographic operations performed ([encrypt](api-ref/SymmetricCrypto/encrypt), [decrypt](api-ref/SymmetricCrypto/decrypt), [reEncrypt](api-ref/SymmetricCrypto/reEncrypt), [generateDataKey](api-ref/SymmetricCrypto/generateDataKey)).

## Pricing {#prices}





The service keeps track of consumed resources, but you can use {{ kms-full-name }} resources free of charge.



