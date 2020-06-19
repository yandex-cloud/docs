---
editable: false
---
# Pricing for {{ kms-full-name }}

The cost for using {{ kms-name }} is based on:
* The number of keys used: only the actual time the key is used is charged.
  
    Prices are shown for 1 hour of use. Billing occurs per second.
* The number of cryptographic operations performed ([encrypt](/api-ref/SymmetricCrypto/encrypt), [decrypt](api-ref/SymmetricCrypto/decrypt), [reEncrypt](api-ref/SymmetricCrypto/reEncrypt), [generateDataKey](api-ref/SymmetricCrypto/generateDataKey)).

## Pricing {#prices}

{% list tabs %}

- Prices in USD

    | Service | Rate, without VAT |
    | ----- | ----- |
    | Monthly using for 1 symmetric key | $0.023077 |
    | 10,000 cryptographic operations | $0.023077 |

- Prices in roubles

    | Service | Rate, with VAT |
    | ----- | ----- |
    | Monthly storage for 1 symmetric key | ₽1.8 |
    | 10,000 cryptographic operations | ₽1.8 |

{% endlist %}
