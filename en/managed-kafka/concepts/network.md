# Network in {{ mkf-name }}

{% if audience != "internal" %}

When creating a cluster, you can:

* Set the network for cluster hosts.
* Specify the availability zones where the cluster hosts should reside.

{% note alert %}

You can only create a cluster if the selected network has no more than one subnet in the selected availability zones.

{% endnote %}

{% else %}

All the clusters are created within the `_PGAASINTERNALNETS_` network macro. To connect to the created database, request access in [Puncher](https://puncher.yandex-team.ru/). To connect to {{ CH }}, specify ports 8443 (HTTPS) and 9440 (native TLS-enabled protocol) in your request.

{% endif %}

## Hostname and FQDN {#hostname}

{{ mkf-short-name }} generates the name of each cluster host during creation. This name will be the host's fully qualified domain name (FQDN). The hostname and, consequently, the FQDN cannot be changed.

{% if audience != "internal" %}

You can use the FQDN to access the host within a single cloud network. Read more in the [{{ vpc-full-name }} documentation](../../vpc/).

{% endif %}
