---
title: Как привязать облако к платежному аккаунту
description: Следуя данной инструкции, вы сможете привязать облако к платежному аккаунту.
---

# Привязать облако к платежному аккаунту

{% include [pin-cloud-note](../_includes/pin-cloud-note.md) %}

## Что нужно для привязки облака {#bind-roles}

Перед привязкой [облака](../../resource-manager/concepts/resources-hierarchy.md#cloud) убедитесь, что соблюдены следующие условия:
1. [Платежный аккаунт](../concepts/billing-account.md) прошел активацию (находится в [статусе](../concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`).
1. Пользователь обладает одновременно [ролями](../../iam/concepts/access-control/roles.md):
   * [resource-manager.clouds.owner](../../resource-manager/security/index.md#resource-manager-clouds-owner) на облако;
   * [billing.accounts.editor](../security/index.md##billing-accounts-editor) и выше в платежном аккаунте.

## Как привязать облако {#bind-cloud}

Чтобы привязать облако к платежному аккаунту или перепривязать облако к другому аккаунту:

{% list tabs group=instructions %}

- {{ billing-interface }} {#billing}

  1. {% include [move-to-billing-step](../_includes/move-to-billing-step.md) %}
  1. Выберите платежный аккаунт, к которому хотите привязать облако.
  1. На панели слева выберите ![image](../../_assets/console-icons/cloud.svg) **{{ ui-key.yacloud_org.billing.account.entities.label_title }}**.
  1. Нажмите ![image](../../_assets/console-icons/link.svg) **{{ ui-key.yacloud_billing.billing.account.bind-cloud.button_bind }}** в верхнем правом углу страницы.

     ![image](../../_assets/billing/billing-pin-cloud-1-4.png)
  
  1. В поле **{{ ui-key.yacloud_org.billing.account.entities.label_type }}** выберите нужный тип сущности из списка, а затем — ресурс, который хотите привязать к платежному аккаунту.
  1. Нажмите кнопку **{{ ui-key.yacloud_billing.billing.account.bind-cloud.button_bind }}** — добавленное облако или сервис появится в списке.
  1. Погасите задолженность на старом платежном аккаунте, если перепривязали облако.

     ![image](../../_assets/billing/billing-pin-cloud-5-6.png) 

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Для привязки облака у [сервисного аккаунта](../../iam/concepts/users/service-accounts.md) должна быть [назначена роль](../security/index.md#set-role) не ниже `billing.accounts.editor` на платежный аккаунт, к которому будет привязано облако.

  Чтобы привязать облако к платежному аккаунту:
  
  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     ```hcl
     resource "yandex_billing_cloud_binding" "mycloud" {
       billing_account_id = "<идентификатор_платежного_аккаунта>"
       cloud_id           = "<идентификатор_облака>"
     }
     ```

     Где:
     * `billing_account_id` — идентификатор платежного аккаунта, к которому вы хотите привязать облако.
     * `cloud_id` — идентификатор облака, которое вы хотите привязать к платежному аккаунту.

     Более подробную информацию о параметрах ресурса `yandex_billing_cloud_binding` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/billing_cloud_binding).
  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  После этого облако будет привязано к платежному аккаунту. Проверить привязку облака к аккаунту можно на странице платежного аккаунта в [сервисе {{ billing-name }}]({{ link-console-billing }}).

- API {#api}

  Чтобы привязать облако, воспользуйтесь методом REST API [bindBillableObject](../api-ref/BillingAccount/bindBillableObject.md) для ресурса [BillingAccount](../api-ref/BillingAccount/index.md) или вызовом gRPC API [BillingAccountService/BindBillableObject](../api-ref/grpc/BillingAccount/bindBillableObject.md).

{% endlist %}

Если вы хотите перестать использовать старый платежный аккаунт, проверьте, что в нем подключен бесплатный тарифный план «Базовый», чтобы предотвратить списания. В противном случае, даже если у аккаунта не останется привязанных облаков, начисления за платный тарифный план продолжат списываться.

{% note warning %}

Привязка облака или другого контейнера к [заблокированному аккаунту](../concepts/billing-account-statuses.md) приведет к остановке всех ваших ресурсов.

{% endnote %}

## Особенности управления ресурсами в организациях {#bind-cloud-organization}

1. {% include [cloud-to-pin.md](../_includes/clouds-to-pin.md) %}
1. {% include [account_scope.md](../_includes/account-scope.md) %}
