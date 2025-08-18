{% note info %}

You can add any type of [user accounts](../../iam/concepts/users/accounts.md) to the MFA policy target groups, but the policy will only apply to [federated](../../iam/concepts/users/accounts.md#saml-federation) and [local](../../iam/concepts/users/accounts.md#local) user accounts.

If a group added to an MFA policy includes users with different account types, the policy will only apply to users with federated and local accounts.

{% endnote %}