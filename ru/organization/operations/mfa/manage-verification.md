---
title: Удаление MFA-факторов и сброс даты верификации пользователей в {{ org-full-name }}
description: Следуя данной инструкции, вы сможете удалять MFA-факторы, а также отслеживать и сбрасывать MFA-верификацию пользователей в {{ org-full-name }}.
---

# Удалить MFA-фактор и сбросить дату верификации

{% include [note-preview](../../../_includes/note-preview.md) %}

Администратор организации может просматривать дату последней верификации [федеративных](../../../iam/concepts/users/accounts.md#saml-federation) и [локальных](../../../iam/concepts/users/accounts.md#local) аккаунтов пользователей. Кроме того, в некоторых случаях администратору может потребоваться [сбросить](#reset-verification-date) дату верификации пользовательского аккаунта или [удалить](#remove-mfa-factor) имеющийся в нем [фактор аутентификации](../../concepts/mfa.md#mfa-factors).

{% include [mfa-check-last-verification-notice](../../../_includes/organization/mfa-check-last-verification-notice.md) %}

## Сбросьте дату верификации учетной записи пользователя {#reset-verification-date}

{% include [mfa-reset-last-verification-roles](../../../_includes/organization/mfa-reset-last-verification-roles.md) %}

Чтобы сбросить дату верификации пользователя:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![icon-users](../../../_assets/console-icons/person.svg) **{{ ui-key.yacloud_org.pages.users }}** и выберите нужного федеративного или локального пользователя.
  1. В правом верхнем углу страницы нажмите **{{ ui-key.yacloud_org.common.more }}** ![chevron-down](../../../_assets/console-icons/chevron-down.svg) и выберите ![arrow-rotate-left](../../../_assets/console-icons/arrow-rotate-left.svg) **{{ ui-key.yacloud_org.entity.user.action.reset-date }}**.
  1. В открывшемся окне подтвердите действие.

{% endlist %}

Дата верификации пользователя будет изменена на текущую дату.

## Удалите фактор аутентификации учетной записи пользователя {#remove-mfa-factor}

Удалить существующий [фактор аутентификации](../../concepts/mfa.md#mfa-factors) пользовательского аккаунта может пользователь, которому назначена [роль](../../../organization/security/index.md) `organization-manager.federations.userAdmin` или выше (для федеративного аккаунта) или `organization-manager.userpools.userAdmin` или выше (для локального аккаунта).

Чтобы удалить имеющийся в пользовательском аккаунте фактор аутентификации:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![icon-users](../../../_assets/console-icons/person.svg) **{{ ui-key.yacloud_org.pages.users }}** и выберите нужного федеративного или локального пользователя.
  1. Перейдите на вкладку **{{ ui-key.yacloud_org.organization.users.components.title_mfa_5CFwd }}**.
  1. В строке с имеющимся у пользователя фактором аутентификации нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
  1. Подтвердите удаление.

{% endlist %}

Фактор аутентификации пользователя будет удален, и при следующей аутентификации в {{ yandex-cloud }} пользователю придется вновь пройти [верификацию](../../concepts/mfa.md#mfa-factors).

#### См. также {#see-also}

* [{#T}](./create-policy.md)
* [{#T}](./update-policy.md)
* [{#T}](./add-users.md)
* [{#T}](./deactivate-reactivate-policy.md)
* [{#T}](./delete-policy.md)
* [{#T}](../../concepts/mfa.md)