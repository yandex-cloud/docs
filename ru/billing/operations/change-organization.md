---
title: "Как изменить организацию платежного аккаунта"
description: "Следуя данной инструкции, вы сможете изменить организацию платежного аккаунта."
---

# Изменить организацию платежного аккаунта


Чтобы изменить [организацию](../concepts/organization.md) платежного аккаунта, пользователь должен обладать ролью `billing.accounts.owner` на платежный аккаунт и `organization-manager.admin` на организацию. Для изменения организации:

{% list tabs group=instructions %}

- {{ billing-interface }} {#billing}

  1. Перейдите в сервис [**{{ billing-name }}**](https://billing.yandex.cloud/accounts/).
  1. Выберите платежный аккаунт из списка.
  1. На странице **{{ ui-key.yacloud_billing.billing.account.switch_overview }}** в правом верхнем углу нажмите кнопку ![image](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.component.console-dashboard.button_action-change-org }}**.
  1. В появившемся окне выберите организацию из списка (будут показаны только те организации, [пользователем](../../organization/operations/add-account) которых вы являетесь), подтвердите смену организации и нажмите **Изменить**.

{% endlist %}
