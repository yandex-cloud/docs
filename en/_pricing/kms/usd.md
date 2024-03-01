{% note warning %}

The prices are in effect as of March 10, 2024.

{% endnote %}

Billing occurs on an hourly basis. The monthly usage cost is provided for reference based on 720 hours per month. The value is rounded.

### Symmetric encryption

| Service | Cost, without VAT |
| ----- | ----- |
| Use of 1 symmetric key [version](../../kms/concepts/version.md) per month | {{ sku|USD|kms.storage.v1.software|month|string }} |
| Use of 1 symmetric key version stored in [hardware security module (HSM)](../../kms/concepts/hsm.md) per month | {{ sku|USD|kms.storage.v1.hsm|month|string }} |
| 10000 cryptographic operations | {{ sku|USD|kms.api.v1.encryptdecrypt|string }} |

### Asymmetric encryption

| Service | Cost, without VAT |
| --- | --- |
| Use of 1 asymmetric key [version](../../kms/concepts/version.md) per month | $0,0230 |
| 10,000 cryptographic operations for the RSA2048 or ECDSA algorithms | $0,0461 |
| 10,000 cryptographic operations for the RSA3072 or RSA4096 algorithms | $0,1152 |
