---
title: Правила тарификации для {{ postbox-full-name }}
description: В статье содержатся правила тарификации сервиса {{ postbox-name }}.
editable: false
---

# Правила тарификации для {{ postbox-name }}

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
        icon: ../_assets/console-icons/calculator.svg
        urlTitle: Калькулятор цен
        url: https://yandex.cloud/ru/prices?state=8a559a0ad698#calculator
        size: s
        border: shadow
        centered: true
        indent:
          top: '0'
          bottom: '0'
      - type: basic-card
        title: Прайс-лист
        text: Актуальные тарифы на все наши услуги
        icon: ../_assets/console-icons/circle-ruble.svg
        urlTitle: Прайс-лист
        url: https://yandex.cloud/ru/price-list?services=dn2h92g8s9qofi6iu1gp
        size: s
        border: shadow
        centered: true
        indent:
          top: '0'
          bottom: '0'
      - type: basic-card
        title: Акции и free tier
        text: Гранты, специальные условия и программы поддержки
        icon: ../_assets/console-icons/flame.svg
        urlTitle: Акции и free tier
        url: https://yandex.cloud/ru/all-offers
        size: s
        border: shadow
        centered: true
        indent:
          top: '0'
          bottom: '0'
:::


::: page-constructor
blocks:
  - type: card-layout-block
    animated: false
    colSizes:
      all: 6
    children: []
:::




Стоимость использования сервиса {{ postbox-name }} зависит от количества отправленных писем в месяц. Тарифицируются все письма, принятые для отправления, независимо от того, будут они фактически доставлены или нет. Если одно письмо отправляется нескольким получателям, количество исходящих писем считается по количеству получателей.

{% note info %}

По умолчанию в сервисе действуют квоты (например, на количество отправляемых писем), которые можно увеличить по запросу в техническую поддержку. Подробнее в [{#T}](concepts/limits.md).

{% endnote %}


{% include [vat](../_includes/vat.md) %}

{% include [not-charged-postbox.md](../_includes/pricing/price-formula/not-charged-postbox.md) %}

{% include [free-tier.md](../_includes/pricing/price-formula/free-tier.md) %}

## Пример расчета стоимости {#price-example}

Расчет стоимости 65 500 писем в месяц:


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub](../_pricing_examples/postbox/rub.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt](../_pricing_examples/postbox/kzt.md) %}

{% endlist %}



## Цены для региона Россия {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}


<MDX>
  <PriceList
    serviceIds={['{{ pcs|postbox }}']}
    installationCode="ru"
    currency="RUB"
  />
</MDX>




{% note info %}

Если вы хотите отправлять более 100 000 000 писем в месяц, обратитесь в [техническую поддержку]({{ link-console-support }}) или к вашему аккаунт-менеджеру, чтобы обсудить индивидуальные условия сотрудничества.

{% endnote %}

