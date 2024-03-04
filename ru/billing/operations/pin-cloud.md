---
title: "Как привязать облако к платежному аккаунту"
description: "Следуя данной инструкции, вы сможете привязать облако к платежному аккаунту."
---

# Привязать облако к платежному аккаунту

{% include [pin-cloud-note](../_includes/pin-cloud-note.md) %}

## Что нужно для привязки облака {#bind-roles}

Перед привязкой [облака](../../resource-manager/concepts/resources-hierarchy.md#cloud) убедитесь, что [платежный аккаунт](../concepts/billing-account.md) прошел активацию ([статус](../concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`), а пользователь обладает одновременно [ролями](../../iam/concepts/access-control/roles.md):
* [resource-manager.clouds.owner](../../iam/concepts/access-control/roles.md#owner) на облако.
* `billing.accounts.owner` или `editor` в платежном аккаунте. Подробнее о ролях читайте в разделе [Управление доступом](../security/index.md#roles-list).

## Как привязать облако {#bind-cloud}

Чтобы привязать облако или перенести существующее:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) нажмите ![image](../../_assets/console-icons/dots-9.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_products }}**.
  1. Выберите сервис ![image](../../_assets/console-icons/credit-card.svg) [**{{ billing-name }}**]({{ link-console-billing }}).
  1. Выберите платежный аккаунт из списка.
  1. Перейдите на страницу **{{ ui-key.yacloud.billing.account.switch_overview }}**.
  1. Нажмите ссылку **{{ ui-key.yacloud.billing.account.dashboard-resources.button_bind-cloud }}** в блоке **{{ ui-key.yacloud.billing.account.dashboard-resources.section_resources }}**.
  1. Выберите облако из списка.
  1. Нажмите кнопку **{{ ui-key.yacloud.billing.account.bind-cloud.button_bind }}** — добавленное облако появится в списке.
  1. Погасите задолженность на старом аккаунте, если переносили облако.

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы привязать облако, у [сервисного аккаунта](../../iam/concepts/users/service-accounts.md) должна быть [назначена роль](../security/index.md#set-role) `billing.accounts.owner` или `editor` на платежный аккаунт.
  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     ```hcl
     resource "yandex_billing_cloud_binding" "mycloud" {
       billing_account_id = "<идентификатор_платежного_аккаунта>"
       cloud_id           = "<идентификатор_облака>"
     }
     ```

     Где:
     * `billing_account_id` — идентификатор платежного аккаунта, к которому вы хотите привязать облако.
     * `cloud_id` — идентификатор облака, к которому будет привязан платежный аккаунт.

     Более подробную информацию о параметрах ресурса `yandex_billing_cloud_binding` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/billing_cloud_binding).
  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  После этого облако будет привязано к платежному аккаунту. Проверить привязку облака к аккаунту можно на странице платежного аккаунта в [сервисе {{ billing-name }}]({{ link-console-billing }}).

- API {#api}

  Чтобы привязать облако, воспользуйтесь методом REST API [bindBillableObject](../api-ref/BillingAccount/bindBillableObject.md) для ресурса [BillingAccount](../api-ref/BillingAccount/index.md) или вызовом gRPC API [BillingAccountService/BindBillableObject](../api-ref/grpc/billing_account_service.md#BindBillableObject).

{% endlist %}

Если вы переносите облако из-за того, что хотите перестать использовать старый платежный аккаунт, проверьте, что в нем подключен бесплатный тарифный план «Базовый». В противном случае даже если в нем не останется привязанных облаков, начисления за платный тарифный план продолжат списываться.

## Особенности управления ресурсами в организациях {#bind-cloud-organization}

1. После добавления вашего платежного аккаунта в [организацию](../concepts/organization.md) для привязки в [консоли управления](../../console/) будут доступны только те облака и экземпляры сервисов [{{ ml-platform-name }}](/services#ml-ai), [{{ datalens-full-name }}](../../datalens/) или [{{ tracker-full-name }}](../../tracker/), которые созданы в вашей организации. Так же вы сможете оплачивать и использовать ресурсы из других организаций, привязанных ранее к вашему платежному аккаунту.
1. {% include [account_scope.md](../_includes/account-scope.md) %}