{% note info %}

The configuration file uses [security groups](../../vpc/concepts/security-groups.md) that are at the {% if audience != "internal" %}[Preview stage](../../overview/concepts/launch-stages.md){% else %}Preview stage{% endif %}. [Contact support]({{ link-console-support }}/create-ticket) to request access to this feature or delete the `yandex_vpc_security_group` resource sections and the lines with the `security_group_ids` parameters in the configuration file.

{% endnote %}
