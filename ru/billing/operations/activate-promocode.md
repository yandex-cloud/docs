---
title: Как активировать промокод в {{ billing-name }}
description: Следуя данной инструкции, вы сможете активировать промокод.
---

# Активировать промокод

Яндекс регулярно проводит маркетинговые кампании, в рамках которых пользователям могут приходить [промокоды](../concepts/promo-code.md). Чтобы воспользоваться промокодом, его необходимо активировать в сервисе {{ billing-name }} или в консоли управления.

{% note info %}

{% include [edit-required-roles](../_includes/edit-required-roles.md) %}

{% include [console-access-note](../_includes/console-access-roles.md) %}

{% endnote %}

Для активации:

{% list tabs group=instructions %}

- {{ billing-interface }} {#billing}

  1. Перейдите в сервис [**{{ billing-name }}**]({{ link-console-billing }}).
  1. Выберите аккаунт на странице **{{ ui-key.yacloud_billing.billing.title_accounts }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/flag.svg) **{{ ui-key.yacloud_org.billing.account.switch_overview }}** и нажмите кнопку **{{ ui-key.yacloud_billing.billing.account.dashboard-grants.button_activate-grant }}**. Эта кнопка появляется только, когда промокод стал доступен.
  1. Введите промокод и нажмите кнопку **{{ ui-key.yacloud_billing.billing.account.dashboard.popup-grant-activation_button_activate }}**.

  Вся информация о добавленном промокоде будет доступна в [сервисе {{ billing-name }}]({{ link-console-billing }}) в блоке **{{ ui-key.yacloud_billing.billing.account.dashboard-grants.section_grants }}**.

- Консоль управления {#console}

    1. Откройте [консоль управления]({{ link-console-main }}).
    1. В правом верхнем углу нажмите ![credit-card](../../_assets/console-icons/credit-card.svg).
    1. В открывшемся виджете нажмите **{{ ui-key.yacloud_billing_account.billing-widget.activate_promocode }}**.
    1. Введите промокод и нажмите кнопку **{{ ui-key.yacloud_billing.billing.account.dashboard.popup-grant-activation_button_activate }}**.

    В виджете отобразится информация о добавленном промокоде.

    {% include [hide-private-data](../_includes/billing-widget-hide-private-data.md) %}

{% endlist %}
