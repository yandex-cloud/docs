{% note warning %}

Assess the risk of enabling access via the serial console considering the following:

* The user will be able to manage the VM from the internet even if there is no external IP address.

    To access the VM serial console from the {{ yandex-cloud }} management console, the user must be authenticated in the {{ yandex-cloud }} management console and have the proper rights to the VM. The user can also access the VM serial console from an SSH client application (such as PuTTY) or the YC CLI via SSH key authentication. In this regard, to reduce the risk of web session hijacking, the user needs to carefully monitor the SSH key and end the web session.

* The session will be simultaneously shared by all users who have access to the serial console.

    Users will be able to see each other's actions when they're watching the serial console's output.

* A valid session can be exploited by another user.

We recommend using the serial console only when absolutely necessary, grant access to a narrow group of people, and use strong VM passwords.
Make sure you [disable access](../../compute/operations/serial-console/disable.md) when you finish working with the serial console.

[Federated users](../../organization/add-federation.md) can only connect to the serial console using the [CLI](../../cli/) or [SSH](../../compute/operations/vm-connect/ssh.md). These users can't access the serial console from the {{ yandex-cloud }} management console.

{% endnote %}
