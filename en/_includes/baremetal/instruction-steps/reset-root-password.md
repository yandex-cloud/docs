To change the root password on the {{ baremetal-name }} server OS, run this command:

```bash
passwd root
```

At the system prompt, enter and confirm the new password:

```bash
New password:
Retype new password:
```

Result:

```text
passwd: password updated successfully
```

{% note info %}

At this stage, you can also [add](../../../baremetal/operations/servers/add-new-ssh-key.md) a new SSH key, modify other server OS settings to ensure proper booting and network connectivity, and diagnose and troubleshoot errors.

{% endnote %}