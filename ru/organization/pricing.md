---
title: Правила тарификации для {{ org-full-name }}
description: В статье содержатся правила тарификации сервиса {{ org-name }}.
---

# Правила тарификации в {{ org-full-name }}

{% note info %}

Цены действуют с 1 декабря 2025 года.

{% endnote %}

Стоимость использования сервиса {{ org-full-name }} входит в стоимость оплачиваемых сервисов. Дополнительно тарифицируется только подключение к внешним приложениям.

## Из чего складывается стоимость использования {{ org-name }} {#rules}

Средства за выбранное количество пользователей списываются в начале каждого месяца.

При покупке лимита на определенное количество пользователей средства списываются сразу.

[Управлять тарификацией](#pricing-management) сервиса {{ org-name }} вы можете через [интерфейс {{ cloud-center }}]({{ link-org-cloud-center }}). Подробнее см. в разделе [{#T}](./operations/manage-billing.md).


## Цены для региона Россия {#prices}

{% include [prices-nds-note](../_includes/prices-nds-note.md) %}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub](../_pricing/organization/rub.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt](../_pricing/organization/kzt.md) %}

{% endlist %}





## Управление тарификацией {{ org-full-name }} {#pricing-management}

С помощью [SAML-приложений](./concepts/applications.md#saml) и [OIDC-приложений](./concepts/applications.md#oidc) пользователи {{ org-name }} могут аутентифицироваться во [внешних приложениях](./tutorials/single-sign-on/index.md), таких как [Grafana Cloud](https://grafana.com/products/cloud/), [Zabbix](https://www.zabbix.com) и др. Подключение пользователей {{ org-name }} к таким внешним приложениям [тарифицируется](#rules). [Управлять тарификацией](./operations/manage-billing.md) сервиса {{ org-name }} вы можете через [интерфейс {{ cloud-center }}]({{ link-org-cloud-center }}).

Чтобы управлять тарификацией {{ org-name }} и использовать тарифицируемые возможности сервиса, привяжите [платежный аккаунт](../billing/concepts/billing-account.md) к {{ org-name }}.

{% include [idp-org-to-ba-linking-role](../_includes/organization/idp-org-to-ba-linking-role.md) %}

### Месячный лимит подключений {#monthly-limit}

При первом входе в любое из внешних приложений пользователь {{ org-name }} начинает расходовать месячный _лимит подключений_ [организации](./concepts/organization.md). Далее, до конца месяца, этот пользователь может без ограничений входить в любые внешние приложения.

По умолчанию для организации установлен нетарифицируемый лимит в 15 пользователей в месяц, которые могут аутентифицироваться во внешних приложениях. После достижения этого лимита дополнительные пользователи не смогут входить во внешние приложения.

Вы в любой момент можете [посмотреть](./operations/manage-billing.md#view-stats) данные о пользователях, расходующих лимит подключений в текущем месяце. В начале каждого нового месяца данные о расходовании лимита подключений обнуляются.

{% include [idp-connection-limit-viewing-role](../_includes/organization/idp-connection-limit-viewing-role.md) %}

### Изменение лимита подключений {#modify-limit}

Вы можете в любой момент [увеличить](./operations/manage-billing.md#modify-limit) лимит подключений. При этом дополнительные пользователи сверх нетарифицируемого лимита будут [тарифицироваться](#rules). Увеличение лимита подключений происходит сразу после оплаты.

Вы также можете уменьшить лимит подключений. При этом уже оплаченные подключения продолжат действовать до конца текущего месяца, а изменения вступят в силу начиная с первого числа следующего месяца. Минимальное значение — 15 подключений

{% include [idp-connection-limit-modifying-role](../_includes/organization/idp-connection-limit-modifying-role.md) %}

#### См. также {#see-also}

* [{#T}](./operations/manage-billing.md)