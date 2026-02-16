If the user does not add a second factor within the specified period, they will not be able to authenticate in {{ yandex-cloud }} on their own.

To enable a user who missed the deadline for adding a second factor to authenticate, the organization administrator must [reset the user verification date](../../organization/operations/mfa/manage-verification.md#reset-verification-date), restarting the period set in the **{{ ui-key.yacloud_org.form.mfa-enforcement.caption.creation_time }}** field of the MFA policy.

{% include [mfa-reset-last-verification-roles](./mfa-reset-last-verification-roles.md) %}

{% include [mfa-check-last-verification-notice](./mfa-check-last-verification-notice.md) %}