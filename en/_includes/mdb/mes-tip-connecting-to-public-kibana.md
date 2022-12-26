{% note tip %}

{% if audience != "internal" %}

You can use Kibana even if you can't request public access to the hosts (for example, for security reasons). To do this, proxy the connections via the virtual machine in {{ compute-full-name }} that is hosted in the same [network](../../vpc/concepts/network.md#network) as the cluster. For more information, see [{#T}](../../managed-elasticsearch/operations/cluster-connect.md).

{% else %}

You can use Kibana even if you can't request public access to the hosts (for example, for security reasons). To do this, proxy the connections via the virtual machine in {{ compute-full-name }} that is hosted in the same network as the cluster. For more information, see [{#T}](../../managed-elasticsearch/operations/cluster-connect.md).

{% endif %}

{% endnote %}
