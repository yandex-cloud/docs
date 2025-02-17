To change the root password of the {{ baremetal-name }} server OS, run this command:

```bash
passwd root
```

When prompted by the system, enter and confirm the new password:

```bash
New password:
Retype new password:
```

Result:

```text
passwd: password updated successfully
```

{% note info %}

At this stage, you can also [add](../../../baremetal/operations/servers/add-new-ssh-key.md) a new user SSH key for access to the server or change any other server OS settings that may prevent the server from booting or accepting connections correctly, as well as diagnose and troubleshoot errors as needed.

{% endnote %}