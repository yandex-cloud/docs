### The serial console is either controlled or not used {#serial-console}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | medium | access.serial-console ||
|#

#### Description

{% note tip "**Automatic verification**" %}

This control automatically checks for serial console access on virtual machines.

{% endnote %}

On VMs, access to the serial console is disabled by default. For risks of using the serial console, see [Getting started with a serial console](https://yandex.cloud/en/docs/compute/operations/serial-console/) in the Yandex Compute Cloud documentation.

When working with a serial console:

* Make sure that critical data is not output to the serial console.
* If SSH access to the serial console is enabled, make sure that both the credentials management routine and the password used to log in to the operating system locally are as per the regulatory standards. For example, in an infrastructure for storing payment card data, passwords must meet the PCI DSS requirements: they must contain both letters and numbers, be at least 7 characters long, and be changed at least once every 90 days.
* It is not recommend using access to the serial console unless it is absolutely necessary.

Evaluate the risk of enabling access through the serial console, considering the following factors:

* The VM will be accessible for management from the internet even if there is no external IP address.
* A user successfully authenticated in the Yandex Cloud management console with appropriate VM permissions will be able to access the VM's serial console from the Yandex Cloud management console. Access to the VM's serial console from an [SSH client](https://yandex.cloud/en/docs/compute/operations/vm-connect/ssh) (e.g., Putty) or [CLI](https://yandex.cloud/en/docs/cli) is also possible by authenticating via an SSH key. Therefore, it is necessary to carefully control the SSH key and terminate the web session to reduce the risks of its interception.
* The session will be available simultaneously to all users who have the right to access the serial console.
* Actions of one user will be visible to other users if they are viewing the serial console output at the same time.
* An unfinished session can be used by another user.

We recommend enabling the serial console only in case of extreme necessity, granting such access to a narrow circle of people, and using strong passwords to access the VM.

[Do not forget to disable access](https://yandex.cloud/en/docs/compute/operations/serial-console/disable) after working with the serial console.

#### Guides and solutions

Guides and solutions to use:

* It is recommended to disable access to the serial console: <https://yandex.cloud/en/docs/compute/operations/serial-console/disable>