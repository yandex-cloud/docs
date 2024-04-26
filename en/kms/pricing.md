---
title: "{{ kms-full-name }} pricing policy"
description: "This article describes the {{ kms-name }} pricing policy."
editable: false
---

# {{ kms-name }} pricing

The cost of using {{ kms-name }} is based on:

* Number of active key versions: versions with the `Active` and `Scheduled For Destruction` statuses.

   {% note alert %}

   After a key is deleted, all of its versions continue to be charged for 3 days [pursuant to the deletion procedure](operations/key.md#delete).

   {% endnote %}

* Number of performed cryptographic operations ([encrypt](api-ref/SymmetricCrypto/encrypt), [decrypt](api-ref/SymmetricCrypto/decrypt), [reEncrypt](api-ref/SymmetricCrypto/reEncrypt), [generateDataKey](api-ref/SymmetricCrypto/generateDataKey)).

## Pricing {#prices}






{% include [usd.md](../_pricing/kms/usd.md) %}


