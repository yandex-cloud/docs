Если в течение заданного срока пользователь не добавит второй фактор, он не сможет самостоятельно пройти аутентификацию в {{ yandex-cloud }}.

Чтобы пользователь, пропустивший установленный срок добавления второго фактора, смог аутентифицироваться, администратор организации должен [сбросить дату верификации](../../organization/operations/mfa/manage-verification.md#reset-verification-date) этого пользователя, после чего течение периода, заданного в поле **{{ ui-key.yacloud_org.form.mfa-enforcement.caption.creation_time }}** политики MFA, начнется заново.

{% include [mfa-reset-last-verification-roles](./mfa-reset-last-verification-roles.md) %}

{% include [mfa-check-last-verification-notice](./mfa-check-last-verification-notice.md) %}