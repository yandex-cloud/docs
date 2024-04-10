---
title: "Как изменить организацию платежного аккаунта"
description: "Следуя данной инструкции, вы сможете изменить организацию платежного аккаунта."
---

# Изменить организацию платежного аккаунта


Изменить [организацию](../concepts/organization.md) платежного аккаунта может пользователь с ролями `billing.accounts.owner` и `organizations.billingAccountSetter`. Чтобы изменить организацию:

{% list tabs group=instructions %}

- {{ billing-interface }} {#billing}

  1. Перейдите в сервис [**{{ billing-name }}**](https://billing.yandex.cloud/accounts/).
  1. Выберите платежный аккаунт из списка.
  1. На странице **{{ ui-key.yacloud_billing.billing.account.switch_overview }}** в правом верхнем углу нажмите кнопку ![image](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.component.console-dashboard.button_action-change-org }}**.
  1. В появившемся окне выберите организацию из списка (будут показаны только те организации, [пользователем](../../organization/operations/add-account) которых вы являетесь), подтвердите смену организации и нажмите **Изменить**.

{% endlist %}
