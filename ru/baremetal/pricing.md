---
title: Правила тарификации для {{ baremetal-full-name }}
description: В статье содержатся правила тарификации сервиса {{ baremetal-name }}.
editable: false
---

# Правила тарификации для {{ baremetal-full-name }}



В сервисе {{ baremetal-name }} оплачивается срок аренды сервера [определенной конфигурации](concepts/server-configurations.md). Арендованный сервер тарифицируется в течение всего периода аренды, независимо от того, включен он или выключен.

Цены за месяц использования формируются из расчета 720 часов в месяц.

## Цены для региона Россия {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}


Все цены указаны за 1 месяц с включением НДС.

{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-servers.md](../_pricing/baremetal/rub-servers.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-servers.md](../_pricing/baremetal/kzt-servers.md) %}

{% endlist %}



