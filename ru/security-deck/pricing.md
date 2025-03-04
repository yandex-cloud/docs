---
editable: false
---

# Правила тарификации {{ sd-full-name }}



Правила тарификации {{ sd-name }} различаются для разных модулей:

* [Модуль диагностики доступов (CIEM)](concepts/ciem.md) — использование модуля не тарифицируется.
* [Модуль контроля данных (DSPM)](concepts/dspm.md) — при [сканировании данных](operations/dspm/create-scan.md) модуль выполняет запросы к файлам в бакетах {{ objstorage-full-name }}. Запросы тарифицируются по [правилам тарификации](../storage/pricing.md) {{ objstorage-name }}. Использование модуля дополнительно не тарифицируется.
* [Access Transparency](concepts/access-transparency.md) — см. [Access Transparency](#atr-rules) в разделе ниже.

## Из чего складывается стоимость использования {{ sd-name }} {#rules}

### Access Transparency {#atr-rules}

Стоимость использования модуля Access Transparency рассчитывается ежемесячно и зависит от совокупного потребления ресурсов за предшествующий месяц в организации, для которой подключается Access Transparency. Чтобы рассчитать потребление ресурсов для вашей организации, проанализируйте [детализацию по всем сервисам](../billing/operations/check-charges.md#services_1) для каждого [платежного аккаунта](../billing/concepts/billing-account.md), привязанного к этой организации.

Цена рассчитывается в начале календарного месяца и не изменяется в течение месяца. Цена также не зависит от продолжительности календарного месяца при использовании Access Transparency с первого числа месяца.

При использовании Access Transparency со второго числа месяца и далее будет тарифицироваться только время, оставшееся до конца месяца по принципу почасовой оплаты.

## Цены для региона Россия {#prices}

### Access Transparency {#atr-pricing}

{% note warning %}

Цены действуют с 13 марта 2025 года.

{% endnote %}



{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include notitle [rub.md](../_pricing/security-deck/access-transparency/rub.md) %}

- Цены в тенге {#prices-kzt}

  {% include notitle [kzt.md](../_pricing/security-deck/access-transparency/kzt.md) %}

{% endlist %}


