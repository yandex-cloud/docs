---
title: "Как привязать облако к платежному аккаунту"
description: "Следуя данной инструкции, вы сможете привязать облако к платежному аккаунту."
---

# Привязать облако к платежному аккаунту

{% include [pin-cloud-note](../_includes/pin-cloud-note.md) %}

## Что нужно для привязки облака

Перед привязкой облака убедитесь, что платежный аккаунт прошел активацию (статус `ACTIVE` или `TRIAL_ACTIVE`), а пользователь обладает одновременно ролями:
* [resource-manager.clouds.owner](../../iam/concepts/access-control/roles.md#owner) на облаке; 
* `billing.accounts.owner` или `editor` в платежном аккаунте. Подробнее о ролях читайте в разделе [Управление доступом](../security/index.md#roles-list).

## Как привязать облако {#bind-cloud}

Чтобы привязать облако или перенести существующее:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) нажмите ![image](../../_assets/main-menu.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_products }}**.

  1. Выберите сервис ![image](../../_assets/billing.svg) [**{{ billing-name }}**]({{ link-console-billing }}).

  1. Выберите аккаунт из списка. 

  1. Перейдите на страницу **{{ ui-key.yacloud.billing.account.switch_overview }}**.

  1. Нажмите ссылку **{{ ui-key.yacloud.billing.account.dashboard-resources.button_bind-cloud }}** в блоке **{{ ui-key.yacloud.billing.account.dashboard-resources.section_resources }}**.

  1. Выберите облако из списка.

  1. Нажмите кнопку **{{ ui-key.yacloud.billing.account.bind-cloud.button_bind }}** — добавленное облако появится в списке.

  1. Погасите задолженность на старом аккаунте, если переносили облако.

- {{ TF }}

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы привязать облако, у сервисного аккаунта должна быть [назначена роль](../security/index.md#set-role) `billing.accounts.owner` или `editor` на платежный аккаунт.
  
  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

      ```hcl
      resource "yandex_billing_cloud_binding" "mycloud" {
        billing_account_id = "<идентификатор_платежного_аккаунта>"
        cloud_id           = "<идентификатор_облака>"
      }
      ```

      Где:

      * `billing_account_id` — идентификатор платежного аккаунта, к которому вы хотите привязать облако.
      * `cloud_id` — идентификатор облака, к которому будет привязан платежный аккаунт.

      Более подробную информацию о параметрах ресурса `yandex_billing_cloud_binding` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/billing_cloud_binding).

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

  После этого облако будет привязано к платежному аккаунту. Проверить привязку облака к аккаунту можно на странице платежного аккаунта в [сервисе {{ billing-name }}]({{ link-console-billing }}).

{% endlist %}


{% include [account_scope.md](../_includes/account-scope.md) %}

Если вы переносите облако из-за того, что хотите перестать использовать старый платежный аккаунт, проверьте, что в нем подключен бесплатный тарифный план "Базовый". В противном случае даже если в нем не останется привязанных облаков, начисления за платный тарифный план продолжат списываться.
 
