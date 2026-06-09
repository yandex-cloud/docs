# Организация

_Организация_ — это рабочее пространство, которое объединяет разные типы ресурсов {{ yandex-cloud }} и пользователей.

Члены [организации](../../organization/quickstart.md) — [пользователи](../../overview/roles-and-resources.md#users), которые состоят в организации и могут получать доступ к сервисам внутри организации.
Пользователи, не являющиеся членами организации, не имеют доступа к ресурсам внутри организации.

Способ работы с платежными аккаунтами в сервисе {{ billing-name }} зависит от того, был ли добавлен платежный аккаунт в организацию.


![](../../_assets/billing/organization.svg)

См. разделы:

* [Привязка облака](../operations/pin-cloud.md#bind-cloud-organization)
* [Управление доступом](../security/index.md)

Платежный аккаунт может принадлежать только одной организации, однако он может быть использован для оплаты ресурсов других организаций.

После добавления вашего платежного аккаунта в [организацию](organization.md) для привязки в сервисе [**{{ billing-name }}**]({{ link-console-billing }}) будут доступны:
  * облака и экземпляры сервисов [{{ ml-platform-name }}](https://yandex.cloud/ru/services#ml-ai), [{{ datalens-full-name }}](../../datalens/index.md) или [{{ tracker-full-name }}]({{ link-yandex }}/support/tracker/{{ lang }}), которые созданы в вашей организации;
  * облака и сущности из других организаций, к которым был [выдан доступ](../../resource-manager/security/index.md).
  
Чтобы получить доступ к [тарифицируемым](../../organization/pricing.md#pricing-management) возможностям сервиса [{{ org-full-name }}](../../organization/index.md), [привяжите](../../organization/operations/manage-billing.md#add-billing-account) платежный аккаунт к инстансу {{ org-full-name }}.

## Как понять, добавлен ли платежный аккаунт в организацию {#check-organization}

{% list tabs group=instructions %}

- {{ billing-interface }} {#billing}

  1. Перейдите в сервис [**{{ billing-name }}**]({{ link-console-billing }}).
  1. У аккаунтов, [добавленных в организацию](organization.md), появится ее идентификатор в столбце **{{ ui-key.yacloud_billing.billing.account.overview.account-data_label_organization }}**.
  1. Выберите платежный аккаунт.
  1. На странице ![image](../../_assets/console-icons/flag.svg) **{{ ui-key.yacloud_org.billing.account.switch_overview }}** в разделе **{{ ui-key.yacloud_billing.billing.account.overview.section_account-data }}** вы увидите ссылку на организацию. На этой же странице вы сможете [изменить организацию](../operations/change-organization.md) вашего платежного аккаунта.

{% endlist %}

Если у вас возникли вопросы по работе с вашим платежным аккаунтом в организации, [создайте запрос в техническую поддержку]({{ link-console-support }}).