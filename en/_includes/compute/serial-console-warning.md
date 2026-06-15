{% note warning %}

When assessing the risks associated with enabling VM access via the serial console, keep in mind the following:

* The VM will remain manageable over the internet even without an external IP address.

    A user who has successfully authenticated in the {{ yandex-cloud }} [management console]({{ link-console-main }}) and has the required [access permissions](../../compute/security/index.md) for the VM will be able to access the serial console.
    
    One can also access the VM serial console via [SSH](../../compute/operations/vm-connect/ssh.md) client applications, such as PuTTY, or through the [CLI](../../cli/index.yaml) by authenticating with an SSH key. Therefore, make sure to prevent any unauthorized access to your SSH key and always end the web session to reduce interception risks.

* Your serial console session will simultaneously be shared by all users who have access to the serial console. Users will be able to see each other's actions if concurrently viewing the serial console output.
* A valid serial console session can be accessed by another user.

We recommend enabling serial console access only when absolutely necessary, granting access permissions to a limited group of trusted users, and using strong VM passwords.

{% include [disable-serial-console-tip](./disable-serial-console-tip.md) %}

{% endnote %}