* `{{ ui-key.yacloud_org.organization.apps.OauthAppEditForm.oauth-scope-openid_o99tx }}`: User ID. This is a required parameter.
* `{{ ui-key.yacloud_org.organization.apps.OauthAppEditForm.oauth-scope-email_vYNmM }}`: User email address.
* `{{ ui-key.yacloud_org.organization.apps.OauthAppEditForm.oauth-scope-profile_sgdKX }}`: Additional user details.
* `{{ ui-key.yacloud_org.organization.apps.OauthAppEditForm.oauth-scope-groups_iZoa5 }}`: [User groups](../../organization/concepts/groups.md) in the organization whose member the user getting authenticated is. The possible values are:

    * `{{ ui-key.yacloud_org.field-data.attributes.update_dialog.field_group_all }}`: Security provider will get all groups the user belongs to.

        The maximum number of sent groups: 1,000. If the user belongs to more groups, only the first thousand of them will be communicated to the service provider. 
    * `{{ ui-key.yacloud_org.field-data.attributes.update_dialog.field_group_assigned }}`: Of all groups the user belongs to, the service provider will only get the ones explicitly specified on the **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.assignments_kKzJS }}** tab of the OIDC app.