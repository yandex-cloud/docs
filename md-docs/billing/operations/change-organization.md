[Документация Yandex Cloud](../../index.md) > [Yandex Cloud Billing](../index.md) > [Пошаговые инструкции](index.md) > Управление платежным аккаунтом > Изменить организацию платежного аккаунта

# Изменить организацию платежного аккаунта


После добавления вашего платежного аккаунта в [организацию](../concepts/organization.md) для привязки в сервисе [**Yandex Cloud Billing**](https://center.yandex.cloud/billing/accounts) будут доступны:
  * облака и экземпляры сервисов [DataSphere](https://yandex.cloud/ru/services#ml-ai), [Yandex DataLens](../../datalens/index.md) или [Яндекс Трекер](https://yandex.ru/support/tracker/ru), которые созданы в вашей организации;
  * облака и сущности из других организаций, к которым был [выдан доступ](../../resource-manager/security/index.md).
  
Чтобы получить доступ к [тарифицируемым](../../organization/pricing.md#pricing-management) возможностям сервиса [Yandex Identity Hub](../../organization/index.md), [привяжите](../../organization/operations/manage-billing.md#add-billing-account) платежный аккаунт к инстансу Yandex Identity Hub.

Чтобы изменить [организацию](../concepts/organization.md) платежного аккаунта, пользователь должен обладать ролью [`billing.accounts.owner`](../security/index.md#billing-accounts-owner) на [платежный аккаунт](../security/index.md#set-role) и [`organization-manager.admin`](../../organization/security/index.md#organization-manager-admin) на [организацию](../../organization/security/index.md#add-role). Для изменения организации:

{% list tabs group=instructions %}

- Интерфейс Yandex Cloud Billing {#billing}

  1. Перейдите в сервис [**Yandex Cloud Billing**](https://center.yandex.cloud/billing/accounts).
  1. Выберите платежный аккаунт из списка.
  1. На странице ![image](../../_assets/console-icons/flag.svg) **Аккаунт** в правом верхнем углу нажмите кнопку ![image](../../_assets/console-icons/persons.svg) **Изменить организацию**.
  1. В появившемся окне выберите организацию из списка (будут показаны только те организации, [пользователем](../../organization/operations/add-account.md) которых вы являетесь), подтвердите смену организации и нажмите **Изменить**.

{% endlist %}