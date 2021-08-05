---
editable: false

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---


# Правила тарификации для {{ kms-full-name }}

Расчет стоимости использования {{ kms-name }} складывается из:
* Количества активных версий ключа — версий в статусе `Active` и `Scheduled For Destruction`. 
    
   {% note alert %}
   
   После удаления ключа все его версии продолжают тарифицироваться в течение 3 дней [согласно процедуре удаления](operations/key.md#delete). 
   
   {% endnote %}
   
* Числа выполненных криптографических операций ([encrypt](api-ref/SymmetricCrypto/encrypt), [decrypt](api-ref/SymmetricCrypto/decrypt), [reEncrypt](api-ref/SymmetricCrypto/reEncrypt), [generateDataKey](api-ref/SymmetricCrypto/generateDataKey)).

## Цены {#prices}


{% include [rub.md](../_pricing/kms/rub.md) %}


