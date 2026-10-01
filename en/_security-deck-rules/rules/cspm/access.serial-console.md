### The serial console is either controlled or not used {#serial-console}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | medium | access.serial-console ||
|#

#### Description

**How this rule works:** The rule finds VMs where access to the serial console is enabled, so you can confirm that this was a planned change.

By default, access to the serial console of a virtual machine in Yandex Compute Cloud is disabled. The serial console gives a low-level connection to the OS — it shows boot logs, system messages, and accepts local logins.

When access is enabled, several risks appear:

* Sensitive data (credentials, keys, configuration) can leak through the console output.
* Anyone with the role for serial console access can connect, and several users can share the same session at once.
* A session left open can be picked up by another user.

Read more in [Getting started with the serial console](https://yandex.cloud/en/docs/compute/operations/serial-console/) in the Yandex Compute Cloud documentation.

**Risks if the rule is not followed:** Enabled serial console access can expose sensitive data through console output, allow unauthorized users to connect to the VM's OS, and enable session hijacking — all without leaving traces in standard access logs.

#### Instructions and solutions

For each VM where serial console access is enabled, decide whether it is needed:

* If it is not, [disable access](https://yandex.cloud/en/docs/compute/operations/serial-console/disable) on the VM.
* If it must stay enabled, grant the `compute.editor` or `compute.admin` role only to a small group of administrators who actually need it, use a strong password for local OS login and rotate it regularly, make sure secrets are not written to the console output, and after work in the management console sign out of Yandex Cloud or close the browser tab to end the session.
