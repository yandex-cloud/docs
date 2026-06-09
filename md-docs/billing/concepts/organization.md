# Организация

_Организация_ — это рабочее пространство, которое объединяет разные типы ресурсов Yandex Cloud и пользователей.

Члены [организации](../../organization/quickstart.md) — [пользователи](../../overview/roles-and-resources.md#users), которые состоят в организации и могут получать доступ к сервисам внутри организации.
Пользователи, не являющиеся членами организации, не имеют доступа к ресурсам внутри организации.

Способ работы с платежными аккаунтами в сервисе Yandex Cloud Billing зависит от того, был ли добавлен платежный аккаунт в организацию.


![](../../_assets/billing/organization.svg)

См. разделы:

* [Привязка облака](../operations/pin-cloud.md#bind-cloud-organization)
* [Управление доступом](../security/index.md)

Платежный аккаунт может принадлежать только одной организации, однако он может быть использован для оплаты ресурсов других организаций.

После добавления вашего платежного аккаунта в [организацию](organization.md) для привязки в сервисе [**Yandex Cloud Billing**](https://center.yandex.cloud/billing/accounts) будут доступны:
  * облака и экземпляры сервисов [DataSphere](https://yandex.cloud/ru/services#ml-ai), [Yandex DataLens](../../datalens/index.md) или [Яндекс Трекер](https://yandex.ru/support/tracker/ru), которые созданы в вашей организации;
  * облака и сущности из других организаций, к которым был [выдан доступ](../../resource-manager/security/index.md).
  
Чтобы получить доступ к [тарифицируемым](../../organization/pricing.md#pricing-management) возможностям сервиса [Yandex Identity Hub](../../organization/index.md), [привяжите](../../organization/operations/manage-billing.md#add-billing-account) платежный аккаунт к инстансу Yandex Identity Hub.

## Как понять, добавлен ли платежный аккаунт в организацию {#check-organization}

{% list tabs group=instructions %}

- Интерфейс Yandex Cloud Billing {#billing}

  1. Перейдите в сервис [**Yandex Cloud Billing**](https://center.yandex.cloud/billing/accounts).
  1. У аккаунтов, [добавленных в организацию](organization.md), появится ее идентификатор в столбце **Организация**.
  1. Выберите платежный аккаунт.
  1. На странице ![image](../../_assets/console-icons/flag.svg) **Аккаунт** в разделе **Общие сведения** вы увидите ссылку на организацию. На этой же странице вы сможете [изменить организацию](../operations/change-organization.md) вашего платежного аккаунта.

{% endlist %}

Если у вас возникли вопросы по работе с вашим платежным аккаунтом в организации, [создайте запрос в техническую поддержку](https://center.yandex.cloud/support).