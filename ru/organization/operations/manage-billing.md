---
title: Как управлять тарификацией {{ org-full-name }}
description: Из статьи вы узнаете, как управлять тарификацией подключения пользователей {{ org-name }} к внешним приложениям через интерфейс {{ org-full-name }}.
---

# Управлять тарификацией {{ org-full-name }}

Подключение пользователей {{ org-name }} к внешним приложениям [тарифицируется](../pricing.md#rules). [Управлять тарификацией](../pricing.md#pricing-management) сервиса {{ org-name }} вы можете через [интерфейс {{ cloud-center }}]({{ link-org-cloud-center }}).

## Привязать платежный аккаунт к {{ org-name }} {#add-billing-account}

По умолчанию для [организации](../concepts/organization.md) {{ org-name }} установлен нетарифицируемый лимит подключений в 15 пользователей, которые могут аутентифицироваться во внешних приложениях в течение календарного месяца. Чтобы использовать тарифицируемые возможности сервиса и [изменить](#modify-limit) этот лимит подключений, привяжите [платежный аккаунт](../../billing/concepts/billing-account.md) к {{ org-name }}:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).

      {% include [idp-org-to-ba-linking-role](../../_includes/organization/idp-org-to-ba-linking-role.md) %}

  1. На панели слева выберите ![credit-card](../../_assets/console-icons/credit-card.svg) **{{ ui-key.yacloud_org.pages.organization-billing }}**.
  1. Чтобы впервые привязать платежный аккаунт:
  
      1. В правом верхнем углу нажмите кнопку **{{ ui-key.yacloud_org.organization.billing.layout.bind_account_action }}** и в открывшемся окне:

          1. В списке платежных аккаунтов выберите нужный.

              Если у вас нет платежного аккаунта или вы хотите создать новый, нажмите кнопку **{{ ui-key.yacloud_org.billing.accounts.dialog_button_create }}** и создайте новый платежный аккаунт по инструкции [{#T}](../../billing/operations/create-new-account.md).
          1. Нажмите кнопку **{{ ui-key.yacloud_billing.billing.account.bind-cloud.button_bind }}**.

  1. Чтобы изменить привязанный к {{ org-name }} платежный аккаунт:

      1. В правом верхнем углу нажмите кнопку **{{ ui-key.yacloud_org.organization.billing.layout.change_account_action }}** и в открывшемся окне:

          1. В списке платежных аккаунтов выберите нужный.

              Если вы хотите создать новый платежный аккаунт, нажмите кнопку **{{ ui-key.yacloud_org.billing.accounts.dialog_button_create }}** и создайте новый платежный аккаунт по инструкции [{#T}](../../billing/operations/create-new-account.md).
          1. Нажмите кнопку **{{ ui-key.yacloud_billing.billing.account.bind-cloud.button_bind }}**.

{% endlist %}

В результате нужный платежный аккаунт будет привязан к {{ org-name }}, и вы сможете пользоваться тарифицируемыми возможностями {{ org-name }} и управлять ими.

## Посмотреть статистику расходования лимита {#view-stats}

Чтобы посмотреть статистику расходования пользователями организации [лимита](../pricing.md#monthly-limit) на подключения:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).

      {% include [idp-connection-limit-viewing-role](../../_includes/organization/idp-connection-limit-viewing-role.md) %}

  1. На панели слева выберите ![credit-card](../../_assets/console-icons/credit-card.svg) **{{ ui-key.yacloud_org.pages.organization-billing }}**.
  1. В блоке **{{ ui-key.yacloud_org.organization.billing.LoggedUsersBlock.title }}** вы можете увидеть текущий размер лимита и его расходование.

      Разверните блок **{{ ui-key.yacloud_org.organization.billing.LoggedUsersBlock.title }}**, чтобы посмотреть список пользователей, расходующих лимит подключений в текущем месяце. В списке указаны имена и идентификаторы пользователей, а также даты и время, когда эти пользователи впервые в текущем месяце аутентифицировались во внешних приложениях.

      {% note tip %}

      Чтобы быстрее найти информацию о конкретном пользователе, воспользуйтесь строкой поиска по логину или идентификатору.

      {% endnote %}

{% endlist %}

## Изменить лимит подключений {#modify-limit}

Чтобы изменить лимит подключений:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).

      {% include [idp-connection-limit-modifying-role](../../_includes/organization/idp-connection-limit-modifying-role.md) %}

  1. На панели слева выберите ![credit-card](../../_assets/console-icons/credit-card.svg) **{{ ui-key.yacloud_org.pages.organization-billing }}**.
  1. Если ваш [платежный аккаунт](../../billing/concepts/billing-account.md) еще не привязан к {{ org-name }}, [привяжите](#add-billing-account) его, чтобы иметь возможность использовать тарифицируемые возможности сервиса.
  1. Нажмите кнопку **{{ ui-key.yacloud_org.organization.billing.ChangeLimitsBlock.change_limit_action }}** и в открывшемся окне:

      1. Чтобы увеличить лимит подключений:
      
          1. В поле **{{ ui-key.yacloud_org.organization.billing.UpdateLimitDialog.new_limit }}** увеличьте лимит подключений и нажмите кнопку **{{ ui-key.yacloud_org.organization.billing.UpdateLimitDialog.action }}**.

              Дополнительные пользователи сверх нетарифицируемого лимита будут [тарифицироваться](../pricing.md#rules).
          1. В открывшемся окне проверьте оплачиваемую сумму и нажмите кнопку **{{ ui-key.yacloud_org.organization.billing.UpdateLimitDialog.confirm_action }}**, чтобы подтвердить оплату.

              Необходимая сумма будет списана с вашего платежного аккаунта, а лимит подключений — изменен сразу после оплаты.
      2. Чтобы уменьшить лимит подключений:

          1. В поле **{{ ui-key.yacloud_org.organization.billing.UpdateLimitDialog.new_limit }}** уменьшите лимит подключений и нажмите кнопку **{{ ui-key.yacloud_org.organization.billing.UpdateLimitDialog.downgrade_action }}**.

              Уже оплаченные подключения продолжат действовать до конца текущего месяца, а внесенные изменения вступят в силу, начиная с первого числа следующего месяца.

              {% note info %}

              Уменьшить лимит можно лишь до нетарифицируемого уровня в 15 подключений.

              {% endnote %}

{% endlist %}

#### См. также {#see-also}

* [{#T}](../pricing.md)