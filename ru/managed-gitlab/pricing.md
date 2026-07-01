---
title: Правила тарификации для {{ mgl-full-name }}
description: В статье содержатся правила тарификации сервиса {{ mgl-name }}.
editable: false
---

# Правила тарификации для {{ mgl-full-name }}



::: page-constructor
blocks:
  - type: card-layout-block
    animated: false
    colSizes:
      all: 12
      sm: 4
    children:
      - type: basic-card
        title: Калькулятор цен
        text: Рассчитайте стоимость использования сервиса, исходя из ваших потребностей
        icon: _assets/icons/calculator.svg
        urlTitle: Калькулятор цен
        url: https://yandex.cloud/ru/prices?state=2f44fbe92c5f#calculator
        size: s
        border: shadow
        centered: true
        indent:
          top: '0'
          bottom: '0'
      - type: basic-card
        title: Прайс-лист
        text: Актуальные тарифы на все наши услуги
        icon: _assets/icons/circle-ruble.svg
        urlTitle: Прайс-лист
        url: https://yandex.cloud/ru/price-list?services=dn2g45ennmllm0knk0gi
        size: s
        border: shadow
        centered: true
        indent:
          top: '0'
          bottom: '0'
      - type: basic-card
        title: Акции и free tier
        text: Гранты, специальные условия и программы поддержки
        icon: _assets/icons/flame.svg
        urlTitle: Акции и free tier
        url: https://yandex.cloud/ru/all-offers
        size: s
        border: shadow
        centered: true
        indent:
          top: '0'
          bottom: '0'
:::



{% include [vat](../_includes/vat.md) %}

## Из чего складывается стоимость использования {{ mgl-name }} {#rules}

При работе с {{ mgl-name }} вы оплачиваете:
* Вычислительные ресурсы инстанса (виртуальной машины).
* Объем хранилища (диск) данных инстанса.

Дополнительно оплачиваются следующие потребляемые ресурсы:
* Место, занятое в сервисе {{ objstorage-full-name }}, для хранения резервных копий.
* Объем исходящего трафика из {{ yandex-cloud }} в интернет.

Во всех расчетах 1 ГБ = 2<sup>10</sup> МБ = 2<sup>20</sup> КБ = 2<sup>30</sup> байт.

### Использование вычислительных ресурсов {#rules-hosts-uptime}

Стоимость начисляется за каждый час работы ВМ.

Цена вычислительных ресурсов зависит от выбранной конфигурации [правил ревью кода](concepts/approval-rules.md).

Минимальная единица тарификации — час (например, стоимость 1,5 часа работы ВМ равна стоимости 2 часов).

### Использование дискового пространства {#rules-storage}

Оплачивается:
* Объем хранилища, выделенный для хранения данных инстанса.
* Объем резервных копий, которые хранятся в {{ objstorage-name }}.

Цена указывается за 1 месяц использования. Минимальная единица тарификации — 1 ГБ в час (например, стоимость хранения 1 ГБ в течение 1,5 часа равна стоимости хранения в течение 2 часов).

### Пример расчета стоимости инстанса {#example}

Стоимость использования инстанса со следующими параметрами в течение 30 дней:

* **Тип инстанса**: `s2.micro` (2 vCPU Intel Cascade Lake, 8 ГБ RAM).
* **Хранилище**: 30 ГБ.
* **Резервные копии**: объем каждой копии — 20 ГБ, срок хранения — 7 дней.
* **Правила ревью кода**: отключены.

Расчет стоимости вычислительных ресурсов:


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-managed-gitlab-compute](../_pricing_examples/managed-gitlab/rub-managed-gitlab-compute.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-managed-gitlab-compute](../_pricing_examples/managed-gitlab/kzt-managed-gitlab-compute.md) %}

{% endlist %}



Расчет стоимости хранилища и резервных копий:


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-managed-gitlab-storage](../_pricing_examples/managed-gitlab/rub-managed-gitlab-storage.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-managed-gitlab-storage](../_pricing_examples/managed-gitlab/kzt-managed-gitlab-storage.md) %}

{% endlist %}



Расчет итоговой стоимости инстанса:


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-managed-gitlab-instance](../_pricing_examples/managed-gitlab/rub-managed-gitlab-instance.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-managed-gitlab-instance](../_pricing_examples/managed-gitlab/kzt-managed-gitlab-instance.md) %}

{% endlist %}



## Цены для региона Россия {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

Цена вычислительных ресурсов зависит от выбранной конфигурации [правил ревью кода](concepts/approval-rules.md).


<MDX>
  <PriceList
    serviceIds={['{{ pcs|managed-gitlab }}']}
    installationCode="ru"
    currency="RUB"
  />
</MDX>



{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}

## Лицензии {#license}

По умолчанию {{ mgl-name }} использует Community Edition версию {{ GL }}. Если у вас есть оплаченная [лицензия](https://about.gitlab.com/pricing/) {{ GL }} (`Premium` или `Ultimate`) — обратитесь в [техническую поддержку]({{ link-console-support }}) или к вашему аккаунт-менеджеру, чтобы воспользоваться ею в {{ mgl-name }}.
