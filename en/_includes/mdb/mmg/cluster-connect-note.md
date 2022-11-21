* Over the internet if you configured public access for the appropriate host when [creating your cluster](../../../managed-mongodb/operations/cluster-create.md). You can only connect to these hosts over an SSL connection.

{% if audience != "internal" %}

* From {{ yandex-cloud }} virtual machines located in the same [cloud network](../../../vpc/concepts/network.md). If there is no public access to a host, connections from this type of virtual machine don't need to be over SSL.

{% else %}

* From {{ yandex-cloud }} virtual machines located in the same cloud network. If there is no public access to a host, connections from this type of virtual machine don't need to be over SSL.

{% endif %}
