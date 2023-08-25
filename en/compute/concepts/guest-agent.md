# Password reset agent on Windows Server VMs

{{ yandex-cloud }} provides _agents_, which are a special kind of software that runs as a Windows Server service for password resets on Windows Server VMs. An agent generates a new VM user password and securely delivers it to the {{ yandex-cloud }} user that requested a password reset. For a detailed description of how agents work, see below.

The password reset agent and agent update software are part of standard Windows Server images. If you are using a custom image, follow [this guide](../operations/vm-guest-agent/install.md) to install the password reset agent and its update software.

{% include [password-reset-linux](../../_includes/compute/password-reset-linux.md) %}

The following items are required to reset passwords using an agent:

{% include [vm-reset-password-windows-reqs](../../_includes/compute/vm-reset-password-windows-reqs.md) %}

Agent runtime logs, including status messages generated every minute, are available on serial port 4 (COM4).

## How an agent resets a password {#reset-flow}

When a {{ yandex-cloud }} user requests a password reset:

1. On the user side (in a browser, if the reset is requested in the management console or through PowerShell), the [RSA](https://en.wikipedia.org/wiki/RSA_(cryptosystem)) algorithm is used to generate a public-private key pair. A request containing the public key and the VM username, for which the password is to be reset, is sent to the agent over an HTTPS connection.
1. The agent on the VM performs the following:

   * Obtains and verifies user request.
   * Generates a new password.
   * Creates a new user with administrator access, if a user with the specified name does not exist.
   * Assigns the generated password to the VM user.
   * Encrypts the password with the public key received in the request.
   * Sends the password to the {{ yandex-cloud }} user over an HTTPS connection.

1. On the user side, the received password is decrypted with the private key and displayed in the management console or PowerShell.

#### See also {#see-also}

* [Resetting a VM user password](../operations/vm-control/vm-reset-password.md)
* [Verifying agent operation](../operations/vm-guest-agent/check.md)
* [Installing the agent](../operations/vm-guest-agent/install.md)
* [Deleting the agent](../operations/vm-guest-agent/uninstall.md)

