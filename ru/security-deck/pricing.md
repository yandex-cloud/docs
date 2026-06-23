---
title: Правила тарификации для {{ sd-full-name }}
description: В статье содержатся правила тарификации сервиса {{ sd-name }}.
editable: false
---

# Правила тарификации {{ sd-full-name }}




{% include [vat](../_includes/vat.md) %}

В {{ sd-name }} каждый модуль тарифицируется отдельно. Доступен стартовый пакетный тариф, включающий несколько модулей.

Ниже представлены правила тарификации для следующих модулей и тарифов:

* [Стартовый пакетный тариф](#starter-rules).
* [Модуль контроля данных ({{ dspm-name }})](concepts/dspm.md).
* [{{ atr-name }}](concepts/access-transparency.md).
* [Модуль контроля {{ k8s }}® ({{ kspm-name }})](./concepts/kspm.md).
* [Модуль контроля конфигурации ({{ cspm-name }})](./concepts/cspm.md).

{% note info %}

[Модуль диагностики доступов ({{ ciem-name }})](concepts/ciem.md) и [AI-ассистент](concepts/ai-assistant.md) не тарифицируются.

{% endnote %}


## Из чего складывается стоимость использования {{ sd-name }} {#rules}

### Стартовый пакетный тариф {#starter-rules}

Тариф включает [модуль контроля конфигурации](./concepts/cspm.md) и [модуль обнаружения угроз](./concepts/threat-detector.md).

Цены на тарифы подписки приведены за 1 календарный месяц.
Календарный месяц определяется как период с 00:00 первого числа месяца до 23:59 последнего числа того же месяца по московскому времени (UTC+3).

Цены за количество ресурсов в месяц фиксированы и не зависят от количества дней в месяце.

### {{ atr-name }} {#atr-rules}

Стоимость использования модуля {{ atr-name }} рассчитывается ежемесячно и зависит от совокупного потребления ресурсов за предшествующий месяц в организации, для которой подключается {{ atr-name }}. Чтобы рассчитать потребление ресурсов для вашей организации, проанализируйте [детализацию по всем сервисам](../billing/operations/check-charges.md#services_1) для каждого [платежного аккаунта](../billing/concepts/billing-account.md), привязанного к этой организации.

Цена рассчитывается в начале календарного месяца и не изменяется в течение месяца. Цена также не зависит от продолжительности календарного месяца при использовании {{ atr-name }} с первого числа месяца.

При использовании {{ atr-name }} со второго числа месяца и далее будет тарифицироваться только время, оставшееся до конца месяца по принципу почасовой оплаты.

Если вы отмените подписку {{ atr-name }} в [консоли управления]({{ link-console-main }}), оплата за нее перестанет начисляться с первого числа следующего календарного месяца.

### Модуль контроля данных ({{ dspm-name }}) {#dspm-rules}

При [сканировании данных](operations/dspm/create-scan.md) модуль контроля данных ({{ dspm-name }}) выполняет запросы к файлам в бакетах {{ objstorage-full-name }}. Запросы тарифицируются по [правилам тарификации](../storage/pricing.md) {{ objstorage-name }}. Использование модуля тарифицируется дополнительно.

### Модуль контроля {{ k8s }} ({{ kspm-name }}) {#kspm-rules}

Стоимость использования модуля контроля {{ k8s }} ({{ kspm-name }}) рассчитывается ежемесячно исходя из количества рабочих узлов в кластерах [{{ managed-k8s-full-name }}](../managed-kubernetes/), которые подключены к сканированию.

### Модуль контроля конфигурации ({{ cspm-name }}) {#cspm-rules}

Стоимость использования модуля {{ cspm-name }} рассчитывается ежемесячно и зависит от выбранного в окружении стандарта для проверки инфраструктуры и количества ресурсов, включенных в проверку. Тарифицируются все стандарты, кроме [базовых правил безопасности облачной платформы {{ yandex-cloud }}](concepts/standard-compliance/yc-security-baseline.md).

Каждое окружение тарифицируется отдельно, даже если ресурсы в них пересекаются.

Неактивные ресурсы также тарифицируются.

Цена не зависит от продолжительности календарного месяца.


## Цены для региона Россия {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

### Стартовый пакетный тариф {#starter-pricing}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include notitle [rub.md](../_pricing/security-deck/starter/rub.md) %}

- Цены в тенге {#prices-kzt}

  {% include notitle [kzt.md](../_pricing/security-deck/starter/kzt.md) %}

{% endlist %}



### {{ atr-name }} {#atr-pricing}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include notitle [rub.md](../_pricing/security-deck/access-transparency/rub.md) %}

- Цены в тенге {#prices-kzt}

  {% include notitle [kzt.md](../_pricing/security-deck/access-transparency/kzt.md) %}

{% endlist %}



### Модуль контроля данных ({{ dspm-name }}) {#dspm-pricing}


<MDX>
  <PriceList
    serviceIds={['{{ pcs|security_deck }}']}
    excludeSkuIds={['{{ pc|security_deck.access_transparency.subscription.v1 }}', '{{ pc|security_deck.kspm.nodes }}', '{{ pc|security_deck.cspm.resources }}', '{{ pc|security_deck.dspm.t1_5.subscription.monthly_usage.v1 }}', '{{ pc|security_deck.dspm.t11.subscription.monthly_usage.v1 }}', '{{ pc|security_deck.dspm.t3.subscription.monthly_usage.v1 }}', '{{ pc|security_deck.dspm.t5_5.subscription.monthly_usage.v1 }}']} 
    installationCode="ru"
    currency="RUB"
  />
</MDX>




#### Пример расчета стоимости {#amount-example}

Например, вы настроили сканирование бакета, в котором хранится 50 текстовых файлов общим объемом 5 ГБ. Все файлы были просканированы. Итоговая стоимость одного сканирования составит:


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-scan-by-amount](../_pricing_examples/security-deck/rub-scan-by-amount.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-scan-by-amount](../_pricing_examples/security-deck/kzt-scan-by-amount.md) %}

{% endlist %}



### Модуль контроля {{ k8s }} ({{ kspm-name }}) {#kspm-pricing}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include notitle [rub.md](../_pricing/security-deck/kspm/rub.md) %}

- Цены в тенге {#prices-kzt}

  {% include notitle [kzt.md](../_pricing/security-deck/kspm/kzt.md) %}

{% endlist %}



### Модуль контроля конфигурации ({{ cspm-name }}) {#cspm-pricing}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include notitle [rub.md](../_pricing/security-deck/cspm/rub.md) %}

- Цены в тенге {#prices-kzt}

  {% include notitle [kzt.md](../_pricing/security-deck/cspm/kzt.md) %}

{% endlist %}



