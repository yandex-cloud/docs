If you do not specify a separate security group, the [default security group](../../vpc/concepts/security-groups.md#default-security-group) created in the instance network will be used.

[Configure](../../managed-gitlab/operations/configure-security-group.md) your security group so that the rules allow incoming and outgoing traffic from the relevant ports and IP addresses.
      
{% note warning %}

The security group's setup determines the {{ mgl-name }} instance performance and availability.

{% endnote %}

If you have issues with setting up a security group, contact [support]({{ link-console-support }}). 