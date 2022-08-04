{% if audience != "internal" %}

Make sure the settings for the network hosting the cluster allow public connections from IP addresses [used by {{ data-transfer-name }}]({{ dt-white-ip-list-uri }}).

{% else %}

Make sure the security groups for the network hosting the cluster allow incoming traffic from and outgoing traffic to a network called `_YTVANGANETS_`.

{% endif %}
