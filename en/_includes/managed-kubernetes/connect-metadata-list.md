Use metadata to configure the method of connecting to nodes in a node group. You can configure one method only because they are mutually exclusive.

To connect to nodes in a node group, specify metadata for the selected connection method:

* To connect to nodes via {{ oslogin }}, add metadata with the `enable-oslogin` key set to `true`.

   {% include [configure-connect-oslogin](./configure-connect-oslogin.md) %}

* To connect to nodes using SSH keys, add metadata with the `ssh-keys` key and its value listing the connection details.

   {% include [configure-connect-ssh](./configure-connect-ssh.md) %}
