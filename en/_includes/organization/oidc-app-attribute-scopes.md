* `{{ ui-key.yacloud_org.organization.apps.OauthAppEditForm.oauth-scope-openid_o99tx }}`: User ID. This is a required setting.
* `{{ ui-key.yacloud_org.organization.apps.OauthAppEditForm.oauth-scope-email_vYNmM }}`: User email address.
* `{{ ui-key.yacloud_org.organization.apps.OauthAppEditForm.oauth-scope-profile_sgdKX }}`: Additional user details.
* `{{ ui-key.yacloud_org.organization.apps.OauthAppEditForm.oauth-scope-groups_iZoa5 }}`: Organization [user groups](../../organization/concepts/groups.md) to which the user getting authenticated belongs. The possible values are:

    * `{{ ui-key.yacloud_org.organization.apps.field_group_all_uY9US }}`: Service provider will get all groups the user belongs to.

        The maximum number of groups is 1,000. If the user belongs to more groups than this, only the first thousand will go to the service provider. 
    * `{{ ui-key.yacloud_org.organization.apps.field_group_assigned_amGdu }}`: Of all the user's groups, the service provider will only get the ones explicitly specified in the **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.assignments_kKzJS }}** tab of the OIDC application.