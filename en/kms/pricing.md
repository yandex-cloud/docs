---
editable: false
---
# Pricing for {{ kms-full-name }}

The cost for using {{ kms-name }} is based on:
* The number of active key versions used: versions with the `Active` and `Scheduled For Destruction` statuses.

   {% note alert %}
   
   After a key is deleted, all its versions continue to be charged for 3 days [according to the deletion procedure](operations/key.md#delete). 
   
   {% endnote %}
   
* The number of cryptographic operations performed ([encrypt](/api-ref/SymmetricCrypto/encrypt), [decrypt](api-ref/SymmetricCrypto/decrypt), [reEncrypt](api-ref/SymmetricCrypto/reEncrypt), [generateDataKey](api-ref/SymmetricCrypto/generateDataKey)).

## Pricing {#prices}

{% list tabs %}

- Prices in USD

    | Service | Rate, without VAT |
    | ----- | ----- |
    | Use of 1 symmetric key version per month | $0.023077 |
    | 10,000 cryptographic operations | $0.023077 |

- Prices in roubles

    | Service | Rate, with VAT |
    | ----- | ----- |
    | Use of 1 symmetric key version per month | ₽1.8 |
    | 10,000 cryptographic operations | ₽1.8 |

{% endlist %}
