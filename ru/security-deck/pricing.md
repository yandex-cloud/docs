---
title: Правила тарификации для {{ sd-full-name }}
description: В статье содержатся правила тарификации сервиса {{ sd-name }}.
editable: false
---

# Правила тарификации {{ sd-full-name }}




{% include [vat](../_includes/vat.md) %}

В {{ sd-name }} каждый модуль тарифицируется отдельно. Также доступны пакетные тарифы и подписки.

Тарифицируются следующие модули:

* [Модуль контроля данных ({{ dspm-name }})](concepts/dspm.md)
* [{{ atr-name }}](concepts/access-transparency.md)
* [Модуль контроля {{ k8s }}® ({{ kspm-name }})](concepts/kspm.md)
* [Модуль контроля конфигурации ({{ cspm-name }})](concepts/cspm.md)

Не тарифицируются:

* [Модуль диагностики доступов ({{ ciem-name }})](concepts/ciem.md)
* [Модуль обнаружения угроз ({{ td-name }})](concepts/threat-detector.md)
* [Модуль управления уязвимостями ({{ vuln-man-short-name }})](concepts/vulnerability-management.md)
* [AI-ассистент](concepts/ai-assistant.md)

## Из чего складывается стоимость использования {{ sd-name }} {#rules}

### Пакетные тарифы и подписки {#starter-rules}

#|
|| **Название** | **Описание** | **Условия** ||
|| Security Deck. Стартовый пакетный тариф | Проверка конфигурации на соответствие стандартам в [модуле контроля конфигурации](./concepts/cspm.md) и алерты о подозрительной активности и угрозах в [модуле обнаружения угроз](./concepts/threat-detector.md).</br>Доступны несколько тарифов для разного количества ресурсов в окружении. | Цены за количество ресурсов в месяц фиксированы и не зависят от количества дней в месяце ||
|#

Цены на пакетные тарифы и подписки приведены за 1 календарный месяц.
Календарный месяц определяется как период с 00:00 первого числа месяца до 23:59 последнего числа того же месяца по московскому времени (UTC+3).

### Тарификация модулей {#modules-rules}

{% note tip %}

Чтобы рассчитать потребление ресурсов для вашей организации, проанализируйте [детализацию по всем сервисам](../billing/operations/check-charges.md#services_1) для каждого [платежного аккаунта](../billing/concepts/billing-account.md), привязанного к этой организации.

{% endnote %}

#|
|| **Модуль** | **Единица тарификации** | **Условия** ||
|| {{ atr-name }} | Совокупное потребление ресурсов за предшествующий месяц в организации, для которой подключается модуль | Рассчитывается ежемесячно.</br>Цена рассчитывается в начале календарного месяца и не изменяется до его конца.</br>При использовании модуля с первого числа месяца цена не зависит от продолжительности календарного месяца. При использовании со второго числа месяца и далее тарифицируется только время, оставшееся до конца месяца, по принципу почасовой оплаты.</br>При отмене подписки в [консоли управления]({{ link-console-main }}) оплата перестает начисляться с первого числа следующего календарного месяца. ||
|| Модуль контроля данных ({{ dspm-name }}) | Запросы модуля к файлам в бакетах {{ objstorage-full-name }} и на дисках в {{ yandex-360 }} при [сканировании данных](operations/dspm/create-scan.md) | Запросы тарифицируются по [правилам тарификации](../storage/pricing.md) {{ objstorage-name }}.</br>Использование модуля тарифицируется дополнительно. ||
|| Модуль контроля {{ k8s }} ({{ kspm-name }}) | Рабочие узлы в кластерах [{{ managed-k8s-full-name }}](../managed-kubernetes/), которые подключены к сканированию | Рассчитывается ежемесячно. ||
|| Модуль контроля конфигурации ({{ cspm-name }}) | Количество ресурсов в окружении, которые проходят проверку по включенным стандартам:</br>* виртуальная машина {{ compute-full-name }};</br>* бакет {{ objstorage-full-name }};</br>* кластеры баз данных&nbsp;^1^;</br>* кластер {{ k8s }};</br>* облачная сеть {{ vpc-full-name }} | Рассчитывается ежемесячно.</br>Тарифицируются все стандарты, кроме [базовых правил безопасности облачной платформы {{ yandex-cloud }}](concepts/standard-compliance/yc-security-baseline.md).</br>Каждое окружение тарифицируется отдельно, даже если ресурсы в них пересекаются.</br>Неактивные ресурсы также тарифицируются.</br>Цена не зависит от продолжительности календарного месяца. ||
|#

^1^ В проверку включены кластеры баз данных следующих сервисов:

* {{ mch-full-name }}
* {{ mgp-full-name }}
* {{ mkf-full-name }}
* {{ mmy-full-name }}
* {{ mmg-full-name }}
* {{ mos-full-name }}
* {{ mpg-full-name }}
* {{ mrd-full-name }}

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


<MDX>
  <PriceList
    serviceIds={['{{ pcs|security_deck }}']}
    skuIds={['{{ pc|security_deck.access_transparency.subscription.v1 }}']}
    installationCode="ru"
    currency="RUB"
  />
</MDX>




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


<MDX>
  <PriceList
    serviceIds={['{{ pcs|security_deck }}']}
    skuIds={['{{ pc|security_deck.kspm.nodes }}']}
    installationCode="ru"
    currency="RUB"
  />
</MDX>




### Модуль контроля конфигурации ({{ cspm-name }}) {#cspm-pricing}


<MDX>
  <PriceList
    serviceIds={['{{ pcs|security_deck }}']}
    skuIds={['{{ pc|security_deck.cspm.resources }}']}
    installationCode="ru"
    currency="RUB"
  />
</MDX>




