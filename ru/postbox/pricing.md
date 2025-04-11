---
title: Правила тарификации для {{ postbox-full-name }}
description: В статье содержатся правила тарификации сервиса {{ postbox-name }}.
editable: false
---

# Правила тарификации для {{ postbox-name }}


{% note tip %}


Чтобы рассчитать стоимость использования сервиса, воспользуйтесь [калькулятором](https://yandex.cloud/ru/prices?state=fdaa4b020385#calculator) на сайте {{ yandex-cloud }} или ознакомьтесь с тарифами в этом разделе.




{% endnote %}




Стоимость использования сервиса {{ postbox-name }} зависит от количества отправленных писем в месяц. Тарифицируются все письма, принятые для отправления, независимо от того, будут они фактически доставлены или нет. Если одно письмо отправляется нескольким получателям, количество исходящих писем считается по количеству получателей.

{% note info %}

По умолчанию в сервисе действуют квоты (например, на количество отправляемых писем), которые можно увеличить по запросу в техническую поддержку. Подробнее см. [{#T}](concepts/limits.md).

{% endnote %}

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

{% note warning %}

Цены действуют с 24 сентября 2024 года.

{% endnote %}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub.md](../_pricing/postbox/rub.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt.md](../_pricing/postbox/kzt.md) %}

{% endlist %}



{% note info %}

Если вы хотите отправлять более 500 000 писем в месяц, обратитесь в [техническую поддержку]({{ link-console-support }}) или к вашему аккаунт-менеджеру, чтобы обсудить индивидуальные условия сотрудничества.

{% endnote %}

