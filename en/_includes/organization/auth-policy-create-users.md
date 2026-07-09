Under **{{ ui-key.yacloud_org.organization.security-settings.UsersAndGroupsCard.title }}**, specify users or groups your policy will apply to:

1. In the **{{ ui-key.yacloud_org.organization.security-settings.ScopeCardBlock.include_label_8Kp2A }}** field, select:

    * `{{ ui-key.yacloud_org.organization.security-settings.UsersAndGroupsCard.scope_all }}`: Your newly created authentication policy will apply to all users of the [organization](*organization).
    * `{{ ui-key.yacloud_org.organization.security-settings.ScopeCardBlock.selected_resources_qvwZX }}`: Your policy will apply to selected users and/or user groups.

        Click **{{ ui-key.yacloud.common.add }}** to select users or user groups the policy will apply to. If required, use the search bar.
1. Optionally, in the **{{ ui-key.yacloud_org.organization.security-settings.ScopeCardBlock.exclude_label_4Mn7B }}** field, click **{{ ui-key.yacloud.common.add }}** to select users or user groups the policy will not apply to.

    {% note info %}

    You cannot specify the same users or user groups simultaneously in both inclusion and exclusion lists.

    {% endnote %}