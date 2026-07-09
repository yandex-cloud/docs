Under **{{ ui-key.yacloud_org.organization.security-settings.NetworksCard.title_aSxuJ }}**, specify the IP addresses for the policy to allow or deny user authentication from:

1. In the **{{ ui-key.yacloud_org.organization.security-settings.ScopeCardBlock.include_label_8Kp2A }}** field, select:

    * `{{ ui-key.yacloud_org.organization.security-settings.NetworksCard.scope_all_1pGZE }}`: For the policy to apply to user authentication events from any IP address.
    * `{{ ui-key.yacloud_org.organization.security-settings.ScopeCardBlock.selected_resources_qvwZX }}`: For the policy to apply to user authentication events from IP addresses in specified ranges.

        In the field that appears, enter one or more IPv4 or IPv6 address ranges in [CIDR](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing) notation.
1. Optionally, in the **{{ ui-key.yacloud_org.organization.security-settings.ScopeCardBlock.exclude_label_4Mn7B }}** field, specify the IP address ranges to exclude from the policy.

    {% note info %}

    You cannot specify the same IP address ranges in both inclusion and exclusion lists at the same time.

    {% endnote %}