{% note warning %}

When assessing the risk of enabling access via the serial console, consider the following:

* The VM can still be managed from the internet even if there is no external IP address.
   To access the VM serial console from the {{ yandex-cloud }} management console, a user must be authenticated in the {{ yandex-cloud }} management console and have the proper permissions to the VM. One can access the VM serial console from an [SSH](../../compute/operations/vm-connect/ssh.md) client application, such as PuTTY, or the [YC CLI](../../cli/) via SSH key authentication. To reduce the risk of web session hijacking, you should closely monitor your SSH key and make sure you terminate the web session.

* The session will be simultaneously shared by all users who have access to the serial console.
   Users will be able to see each other's actions if concurrently watching the serial console's output.

* A valid session can be exploited by another user.

We recommend using the serial console only when absolutely necessary, grant access to a narrow group of people, and use strong VM passwords.

Make sure you [disable access](../../compute/operations/serial-console/disable.md) after you finish using the serial console.

{% endnote %}