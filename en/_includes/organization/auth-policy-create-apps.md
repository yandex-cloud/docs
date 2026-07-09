Under **{{ ui-key.yacloud_org.organization.security-settings.AppsCard.title_hBXgK }}**, specify the [applications](*applications) for which authentication will be managed by the policy you are creating:

1. In the **{{ ui-key.yacloud_org.organization.security-settings.ScopeCardBlock.include_label_8Kp2A }}** field, select:

    * `{{ ui-key.yacloud_org.organization.security-settings.AppsCard.scope_all_iXjnP }}`: To ensure the policy applies to authentication by users connecting from any applications of the organization.
    * `{{ ui-key.yacloud_org.organization.security-settings.ScopeCardBlock.selected_resources_qvwZX }}`: To apply the policy only to authentication in selected applications.

        In the field that appears, select the applications you need. If required, use the search bar and enter the application name or ID.
1. Optionally, under **{{ ui-key.yacloud_org.organization.security-settings.ScopeCardBlock.exclude_label_4Mn7B }}**, select the applications for which the policy will not be applied to authentication.

    {% note info %}

    You cannot specify identical applications simultaneously in both inclusion and exclusion lists.

    {% endnote %}