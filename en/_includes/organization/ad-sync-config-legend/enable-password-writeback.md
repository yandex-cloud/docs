* `enable_password_writeback`: Manages user [password writeback](../../../organization/concepts/ad-sync/index.md#password-writeback) in {{ microsoft-idp.ad-short }}.

    {% include [pw-writeback-preview-notice](../pw-writeback-preview-notice.md) %}

    The possible values are:

    * `true`: When attempting to change the password of a synchronized user in {{ org-full-name }} ([password change](../../../organization/operations/manage-account.md#edit-password) by the user or [password reset](../../../organization/operations/user-pools/reset-user-password.md#reset) by the administrator), the agent first attempts to change the password of the corresponding user in {{ microsoft-idp.ad-short }}; only if this operation is successful will the password be changed in {{ org-full-name }}.
    * `false`: When changing the password of a synchronized user in {{ org-full-name }}, the user's password remains unchanged in {{ microsoft-idp.ad-short }}. If you perform a [full sync](../../../organization/concepts/ad-sync/sync-agent.md#full-sync) after changing the password, the agent replaces the updated password in {{ org-full-name }} with the one from {{ microsoft-idp.ad-short }}. This is also the default behavior where writeback is not enabled.