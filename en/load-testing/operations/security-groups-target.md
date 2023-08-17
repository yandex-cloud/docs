# Set up the test target security group

{% note info %}

{% include [security-groups-note](../../_includes/vpc/security-groups-note-services.md) %}

{% endnote %}

{% include [security-groups-target](../../_includes/load-testing/security-groups-target.md) %}

{% note info %}

You can set more detailed rules for security groups, such as allowing traffic in only specific subnets.

It is important to have security groups properly configured for all subnets hosting test targets.

{% endnote %}