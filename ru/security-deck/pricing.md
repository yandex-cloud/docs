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
* [KSPM](concepts/kspm.md) — см. [Модуль контроля {{ k8s }}® (KSPM)](#kspm-rules) в разделе ниже.
* [{{ cspm-name }}](concepts/cspm.md) — см. [Модуль контроля конфигурации ({{ cspm-name }})](#cspm-rules) в разделе ниже.
* [AI-ассистент](concepts/ai-assistant.md) — не тарифицируется на стадии [Preview](../overview/concepts/launch-stages.md).

## Из чего складывается стоимость использования {{ sd-name }} {#rules}

### {{ atr-name }} {#atr-rules}

Стоимость использования модуля {{ atr-name }} рассчитывается ежемесячно и зависит от совокупного потребления ресурсов за предшествующий месяц в организации, для которой подключается {{ atr-name }}. Чтобы рассчитать потребление ресурсов для вашей организации, проанализируйте [детализацию по всем сервисам](../billing/operations/check-charges.md#services_1) для каждого [платежного аккаунта](../billing/concepts/billing-account.md), привязанного к этой организации.

Цена рассчитывается в начале календарного месяца и не изменяется в течение месяца. Цена также не зависит от продолжительности календарного месяца при использовании {{ atr-name }} с первого числа месяца.

При использовании {{ atr-name }} со второго числа месяца и далее будет тарифицироваться только время, оставшееся до конца месяца по принципу почасовой оплаты.

Если вы отмените подписку {{ atr-name }} в [консоли управления]({{ link-console-main }}), оплата за нее перестанет начисляться с первого числа следующего календарного месяца.

### Модуль контроля данных ({{ dspm-name }}) {#dspm-rules}

При [сканировании данных](operations/dspm/create-scan.md) модуль контроля данных ({{ dspm-name }}) выполняет запросы к файлам в бакетах {{ objstorage-full-name }}. Запросы тарифицируются по [правилам тарификации](../storage/pricing.md) {{ objstorage-name }}. Использование модуля тарифицируется дополнительно.

### Модуль контроля {{ k8s }}® (KSPM) {#kspm-rules}

Стоимость использования модуля контроля {{ k8s }}® (KSPM) рассчитывается ежемесячно исходя из количества рабочих узлов в кластерах [{{ managed-k8s-full-name }}](../managed-kubernetes/), которые подключены к сканированию.

### Модуль контроля конфигурации ({{ cspm-name }}) {#cspm-rules}

{% note info %}

Тарификация модуля начинается со 2 марта 2026 года.

{% endnote %}

Стоимость использования модуля {{ cspm-name }} рассчитывается ежемесячно и зависит от выбранного в окружении стандарта для проверки инфраструктуры и количества ресурсов, включенных в проверку. Тарифицируются все стандарты, кроме [базовых правил безопасности облачной платформы {{ yandex-cloud }}](concepts/standard-compliance/yc-security-baseline.md).

Каждое окружение тарифицируется отдельно, даже если ресурсы в них пересекаются.

Неактивные ресурсы также тарифицируются.

Цена не зависит от продолжительности календарного месяца.

## Цены для региона Россия {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

### {{ atr-name }} {#atr-pricing}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include notitle [rub.md](../_pricing/security-deck/access-transparency/rub.md) %}

- Цены в тенге {#prices-kzt}

  {% include notitle [kzt.md](../_pricing/security-deck/access-transparency/kzt.md) %}

{% endlist %}



Цена за месяц использования формируется из расчета 720 часов в месяц.

### Модуль контроля данных ({{ dspm-name }}) {#dspm-pricing}


<MDX>
  <PriceList
    serviceIds={['{{ pcs|security_deck }}']}
    excludeSkuIds={['{{ pc|security_deck.access_transparency.subscription.v1 }}', '{{ pc|security_deck.kspm.nodes }}']}
    installationCode="ru"
    currency="RUB"
  />
</MDX>



Цена за месяц использования формируется из расчета 720 часов в месяц.


#### Пример расчета стоимости {#amount-example}

Например, вы настроили сканирование бакета, в котором хранится 50 текстовых файлов общим объемом 5 ГБ. Все файлы были просканированы. Итоговая стоимость одного сканирования составит:


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-scan-by-amount](../_pricing_examples/security-deck/rub-scan-by-amount.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-scan-by-amount](../_pricing_examples/security-deck/kzt-scan-by-amount.md) %}

{% endlist %}



### Модуль контроля {{ k8s }}® (KSPM) {#kspm-pricing}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include notitle [rub.md](../_pricing/security-deck/kspm/rub.md) %}

- Цены в тенге {#prices-kzt}

  {% include notitle [kzt.md](../_pricing/security-deck/kspm/kzt.md) %}

{% endlist %}



Цена за месяц использования формируется из расчета 720 часов в месяц.

### Модуль контроля конфигурации ({{ cspm-name }}) {#cspm-pricing}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include notitle [rub.md](../_pricing/security-deck/cspm/rub.md) %}

- Цены в тенге {#prices-kzt}

  {% include notitle [kzt.md](../_pricing/security-deck/cspm/kzt.md) %}

{% endlist %}


