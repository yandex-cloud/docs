To enable or disable access to nodes via {{ oslogin }}, [change the metadata value](../../managed-kubernetes/operations/node-group/node-group-update.md#update-metadata) with the `enable-oslogin` key:

* `true`: Access enabled.
* `false`: Access disabled.

{% include [note-oslogin-ssh-warning](./note-oslogin-ssh-warning.md) %}

{% include [configure-connect-oslogin](./configure-connect-oslogin.md) %}
