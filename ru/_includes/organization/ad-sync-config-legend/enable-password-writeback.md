* `enable_password_writeback` — параметр, управляющий [обратной записью паролей](../../../organization/concepts/ad-sync/index.md#password-writeback) пользователей в {{ microsoft-idp.ad-short }}.

    {% include [pw-writeback-preview-notice](../pw-writeback-preview-notice.md) %}

    Возможные значения:

    * `true` — при попытке изменить пароль синхронизированного пользователя на стороне {{ org-full-name }} ([изменение пароля](../../../organization/operations/manage-account.md#edit-password) самим пользователем или [сброс пароля](../../../organization/operations/user-pools/reset-user-password.md#reset) администратором) агент сначала попытается изменить пароль соответствующего пользователя в {{ microsoft-idp.ad-short }}, и только в случае успеха этой операции пароль будет изменен в {{ org-full-name }}.
    * `false` — при изменении пароля синхронизированного пользователя на стороне {{ org-full-name }} пароль этого пользователя не будет изменен в {{ microsoft-idp.ad-short }}. Если после изменения пароля выполнить [полную синхронизацию](../../../organization/concepts/ad-sync/sync-agent.md#full-sync), агент заменит обновленный пароль в {{ org-full-name }} паролем, взятым из {{ microsoft-idp.ad-short }}. Это также поведение по умолчанию, если функциональность обратной записи не активирована.