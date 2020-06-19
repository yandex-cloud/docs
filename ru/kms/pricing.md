---
editable: false
---

# Правила тарификации для {{ kms-full-name }}

Расчет стоимости использования {{ kms-name }} складывается из:
* Количество используемых ключей — тарифицируется только фактическое время использование ключа. 

    Цена указывается за один месяц использования, тарификация посекундная.
* Числа выполненных криптографических операций ([encrypt](/api-ref/SymmetricCrypto/encrypt), [decrypt](api-ref/SymmetricCrypto/decrypt), [reEncrypt](api-ref/SymmetricCrypto/reEncrypt), [generateDataKey](api-ref/SymmetricCrypto/generateDataKey)).

## Цены {#prices}

Услуга | Цена вкл. НДС
----- | -----
| Использование одного симметричного ключа в месяц | 1,8 ₽ |
| 10 000 криптографических операций | 1,8 ₽ |
