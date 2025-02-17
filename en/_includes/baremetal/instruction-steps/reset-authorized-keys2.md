Replace the `authorized_keys` file contents with your new public SSH key:

```bash
echo "<new_SSH_key>" | tee authorized_keys
```

If you want to add a new key without deleting the old one, include the `-a` parameter to the `tee` command:

```bash
echo "<new_SSH_key>" | tee -a authorized_keys
```

{% note info %}

At this stage, you can also [change](../../../baremetal/operations/servers/reset-password.md) the root user password for access to the server or change any other server OS settings that may prevent the server from booting or accepting connections correctly, as well as diagnose and troubleshoot errors as needed.

{% endnote %}