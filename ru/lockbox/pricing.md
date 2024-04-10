---
title: "Правила тарификации для {{ lockbox-full-name }}"
description: "В статье содержатся правила тарификации сервиса {{ lockbox-name }}."
editable: false
---

# Правила тарификации для {{ lockbox-name }}


Расчет стоимости использования {{ lockbox-name }} складывается из:

* Количества версий секретов.
* Числа выполненных операций [get](api-ref/Payload/get) с секретом.


## Цена хранения секретов {#secrets}



{% include [rub.md](../_pricing/lockbox/rub-secrets.md) %}





## Цена запросов секретов {#requests}


{% include [rub.md](../_pricing/lockbox/rub-requests.md) %}




