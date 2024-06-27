---
title: "Как активировать промокод в {{ billing-name }}"
description: "Следуя данной инструкции, вы сможете активировать промокод."
---

# Активировать промокод

Яндекс регулярно проводит маркетинговые кампании, в рамках которых пользователям могут приходить [промокоды](../concepts/promo-code.md). Если вы получили промокод, активируйте его:

{% list tabs group=instructions %}

- {{ billing-interface }} {#billing}

  1. Перейдите в сервис [**{{ billing-name }}**]({{ link-console-billing }}).
  1. Выберите аккаунт на странице **{{ ui-key.yacloud_billing.billing.title_accounts }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/flag.svg) **{{ ui-key.yacloud_billing.billing.account.switch_overview }}** и нажмите кнопку **{{ ui-key.yacloud_billing.billing.account.dashboard-grants.button_activate-grant }}**. Эта кнопка появляется только, когда промокод стал доступен.
  1. Введите промокод и нажмите кнопку **{{ ui-key.yacloud_billing.billing.account.dashboard.popup-grant-activation_button_activate }}**.

  Вся информация о добавленном промокоде будет доступна в [сервисе {{ billing-name }}]({{ link-console-billing }}) в блоке **{{ ui-key.yacloud_billing.billing.account.dashboard-grants.section_grants }}**.

{% endlist %}
