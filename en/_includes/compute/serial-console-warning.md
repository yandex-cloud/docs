{% note warning %}

When assessing the risks associated with enabling serial console access, consider the following:

* The VM will remain manageable over the internet even without an external IP address.
  A user who has successfully authenticated in the {{ yandex-cloud }} management console and has the required permissions for the VM will be able to access the VM serial console from the {{ yandex-cloud }} management console. One can also access the VM serial console via [SSH](../../compute/operations/vm-connect/ssh.md) client applications, such as PuTTY, or through the [YC CLI](../../cli/) by authenticating with an SSH key. To reduce the risk of session hijacking, you should securely manage your SSH key and terminate web sessions.

* Your session will simultaneously be shared by all users who have access to the serial console.
  Users will be able to see each other's actions if concurrently viewing the serial console output.

* A valid session can be accessed by another user.

We recommend enabling the serial console only when absolutely necessary, granting access permissions to a limited group of users, and using strong VM passwords.

Make sure to [disable access](../../compute/operations/serial-console/disable.md) after you finish using the serial console.

{% endnote %}