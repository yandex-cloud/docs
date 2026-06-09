# Изменить организацию платежного аккаунта


После добавления вашего платежного аккаунта в [организацию](../concepts/organization.md) для привязки в сервисе [**{{ billing-name }}**]({{ link-console-billing }}) будут доступны:
  * облака и экземпляры сервисов [{{ ml-platform-name }}](https://yandex.cloud/ru/services#ml-ai), [{{ datalens-full-name }}](../../datalens/index.md) или [{{ tracker-full-name }}]({{ link-yandex }}/support/tracker/{{ lang }}), которые созданы в вашей организации;
  * облака и сущности из других организаций, к которым был [выдан доступ](../../resource-manager/security/index.md).
  
Чтобы получить доступ к [тарифицируемым](../../organization/pricing.md#pricing-management) возможностям сервиса [{{ org-full-name }}](../../organization/index.md), [привяжите](../../organization/operations/manage-billing.md#add-billing-account) платежный аккаунт к инстансу {{ org-full-name }}.

Чтобы изменить [организацию](../concepts/organization.md) платежного аккаунта, пользователь должен обладать ролью [`billing.accounts.owner`](../security/index.md#billing-accounts-owner) на [платежный аккаунт](../security/index.md#set-role) и [`organization-manager.admin`](../../organization/security/index.md#organization-manager-admin) на [организацию](../../organization/security/index.md#add-role). Для изменения организации:

{% list tabs group=instructions %}

- {{ billing-interface }} {#billing}

  1. Перейдите в сервис [**{{ billing-name }}**]({{ link-console-billing }}).
  1. Выберите платежный аккаунт из списка.
  1. На странице ![image](../../_assets/console-icons/flag.svg) **{{ ui-key.yacloud_org.billing.account.switch_overview }}** в правом верхнем углу нажмите кнопку ![image](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.component.console-dashboard.button_action-change-org }}**.
  1. В появившемся окне выберите организацию из списка (будут показаны только те организации, [пользователем](../../organization/operations/add-account.md) которых вы являетесь), подтвердите смену организации и нажмите **Изменить**.

{% endlist %}