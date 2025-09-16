---
title: Правила тарификации для {{ sd-full-name }}
description: В статье содержатся правила тарификации сервиса {{ sd-name }}.
editable: false
---

# Правила тарификации {{ sd-full-name }}




{% include [vat](../_includes/vat.md) %}

Правила тарификации {{ sd-name }} различаются для разных модулей:

* [Модуль диагностики доступов ({{ ciem-name }})](concepts/ciem.md) — использование модуля не тарифицируется.
* [Модуль контроля данных ({{ dspm-name }})](concepts/dspm.md) — см. [Модуль контроля данных ({{ dspm-name }})](#dspm-rules) в разделе ниже.
* [{{ atr-name }}](concepts/access-transparency.md) — см. [{{ atr-name }}](#atr-rules) в разделе ниже.
* [{{ ycdr-full-name }}](concepts/ycdr.md) — по согласованию с вашим аккаунт-менеджером, от 400 000 ₽.

## Из чего складывается стоимость использования {{ sd-name }} {#rules}

### {{ atr-name }} {#atr-rules}

Стоимость использования модуля {{ atr-name }} рассчитывается ежемесячно и зависит от совокупного потребления ресурсов за предшествующий месяц в организации, для которой подключается {{ atr-name }}. Чтобы рассчитать потребление ресурсов для вашей организации, проанализируйте [детализацию по всем сервисам](../billing/operations/check-charges.md#services_1) для каждого [платежного аккаунта](../billing/concepts/billing-account.md), привязанного к этой организации.

Цена рассчитывается в начале календарного месяца и не изменяется в течение месяца. Цена также не зависит от продолжительности календарного месяца при использовании {{ atr-name }} с первого числа месяца.

При использовании {{ atr-name }} со второго числа месяца и далее будет тарифицироваться только время, оставшееся до конца месяца по принципу почасовой оплаты.

Если вы отмените подписку {{ atr-name }} в [консоли управления]({{ link-console-main }}), оплата за нее перестанет начисляться с первого числа следующего календарного месяца.

### Модуль контроля данных ({{ dspm-name }}) {#dspm-rules}

При [сканировании данных](operations/dspm/create-scan.md) модуль контроля данных ({{ dspm-name }}) выполняет запросы к файлам в бакетах {{ objstorage-full-name }}. Запросы тарифицируются по [правилам тарификации](../storage/pricing.md) {{ objstorage-name }}. Использование модуля тарифицируется дополнительно.

## Цены для региона Россия {#prices}

### {{ atr-name }} {#atr-pricing}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include notitle [rub.md](../_pricing/security-deck/access-transparency/rub.md) %}

- Цены в тенге {#prices-kzt}

  {% include notitle [kzt.md](../_pricing/security-deck/access-transparency/kzt.md) %}

{% endlist %}



### Модуль контроля данных ({{ dspm-name }}) {#dspm-pricing}

#### Сканирование по объему данных {#scan-by-volume}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include notitle [rub.md](../_pricing/security-deck/dspm/rub.md) %}

- Цены в тенге {#prices-kzt}

  {% include notitle [kzt.md](../_pricing/security-deck/dspm/kzt.md) %}

{% endlist %}



#### Сканирование по количеству файлов {#scan-by-amount}

Сканирование изображений тарифицируется отдельно.


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include notitle [rub-scan-by-amount.md](../_pricing/security-deck/dspm/rub-scan-by-amount.md) %}

- Цены в тенге {#prices-kzt}

  {% include notitle [kzt-scan-by-amount.md](../_pricing/security-deck/dspm/kzt-scan-by-amount.md) %}

{% endlist %}



#### Сканирование по количеству изображений {#scan-by-image-amount}

{% note warning %}

Цены действуют с 22 сентября 2025 года.

{% endnote %}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include notitle [rub.md](../_pricing/security-deck/dspm/rub-scan-by-image-amount.md) %}

- Цены в тенге {#prices-kzt}

  {% include notitle [kzt.md](../_pricing/security-deck/dspm/kzt-scan-by-image-amount.md) %}

{% endlist %}



#### Пример расчета стоимости {#amount-example}

Например, вы настроили сканирование бакета, в котором хранится 50 текстовых файлов общим объемом 5 ГБ. Все файлы были просканированы. Итоговая стоимость одного сканирования составит:


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-scan-by-amount](../_pricing_examples/security-deck/rub-scan-by-amount.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-scan-by-amount](../_pricing_examples/security-deck/kzt-scan-by-amount.md) %}

{% endlist %}


