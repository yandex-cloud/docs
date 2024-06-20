Чтобы включить или выключить доступ к узлам через {{ oslogin }}, [измените значение метаданных](../../managed-kubernetes/operations/node-group/node-group-update.md#update-metadata) с ключом `enable-oslogin`:

* `true` — доступ включен;
* `false` — доступ выключен.

{% include [note-oslogin-ssh-warning](./note-oslogin-ssh-warning.md) %}

{% include [configure-connect-oslogin](./configure-connect-oslogin.md) %}
