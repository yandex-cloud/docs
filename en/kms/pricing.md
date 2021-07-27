---
editable: false

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---

# Pricing for {{ kms-full-name }}

The cost for using {{ kms-name }} is based on:
* The number of active key versions used: versions with the `Active` and `Scheduled For Destruction` statuses.

   {% note alert %}
   
   After a key is deleted, all its versions continue to be charged for 3 days [according to the deletion procedure](operations/key.md#delete). 
   
   {% endnote %}
   
* The number of cryptographic operations performed ([encrypt](api-ref/SymmetricCrypto/encrypt), [decrypt](api-ref/SymmetricCrypto/decrypt), [reEncrypt](api-ref/SymmetricCrypto/reEncrypt), [generateDataKey](api-ref/SymmetricCrypto/generateDataKey)).

## Pricing {#prices}




{% include [usd.md](../_pricing/kms/usd.md) %}