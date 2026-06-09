# Решения для {{ iam-name }}

## Примеры конфигураций и сценариев {{ iam-name }} {#configuration-examples}

* [Как изменить владельца облака](how-to/change-cloud-owner.md)
* [Как отменить удаление облака](how-to/cancel-pending-deletion.md)
* [Как изменить владельца организации](how-to/change-organization-owner.md)
* [Какое время жизни сессии при аутентификации федеративного пользователя](how-to/cookie-expire-time.md)
* [Какую минимальную роль необходимо выдать пользователю для доступа к Консоли управления](how-to/minimal-accessing-role-for-console.md)
* [Как удалить организацию](how-to/deleting-organization.md)

## Решения для известных проблем {{ iam-name }} {#known-issues-resolving}

* [Устранение ошибок при назначении роли `{{ roles-cloud-owner }}` пользователю облака](known-issues/resource-manager-clouds-owner-is-only-applicable-to-resources-of-type-resource-manager-cloud.md)
* [Устранение ошибок при работе с приглашениями в облачную организацию](known-issues/error-when-users-accepts-invite-to-organisation.md)
* [Устранение ошибки `The signature of response or assertion was invalid` при аутентификации через федеративный аккаунт](known-issues/error-the-signature-of-response-or-assertion-was-invalid-when-using-federatadion-login.md)
* [Устранение ошибки `publicAccessBindings` при переносе облака между разными организациями](known-issues/move-org-public-access-bindings-error.md)
* [Устранение проблем при создании OAuth-токенов от имени учетных записей Яндекс ID](known-issues/unauthorised-client-issue.md)
* [Устранение ошибки `OAuth token is invalid or expired`](known-issues/error-oauth-token-is-invalid-or-expired.md)
* [Устранение ошибки `Обратитесь к администратору организации за новым приглашением`](known-issues/invitation-already-accepted.md)
* [Устранение ошибки `Service account is not available`](known-issues/service-account-is-not-available.md)
* [Устранение ошибки `PROHIBITED_BILLING_ACCOUNT_USAGE_STATUS`](known-issues/error-prohibited-billing-account-status.md)
* [Устранение ошибки `Validation failed: - access_binding_deltas: Number of elements must be in the range of 1 to 1000`](known-issues/error-validation-failed.md)
* [В списке пользователей организации не отображается федеративный пользователь](known-issues/federative-user-is-not-visible.md)
* [Пользователь не видит приглашение в организацию или роль `{{ roles-admin }}`](known-issues/invitation-or-admin-role-not-seen.md)
* [Появление неизвестного пользователя в организации](known-issues/unknown-user.md)
* [Устранение ошибки `Такой логин не подойдет`](known-issues/invalid-login.md)
* [Устранение ошибки `Response is invalid in a general way` при авторизации через SAML-провайдер](known-issues/error-bad-request.md)
* [Устранение ошибки `Forbidden` при работе от имени сервисного аккаунта](known-issues/error-forbidden.md)