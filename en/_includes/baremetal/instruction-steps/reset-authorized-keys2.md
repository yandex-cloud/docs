Replace the `authorized_keys` file contents with your new public SSH key:

```bash
echo "<new_SSH_key>" | tee authorized_keys
```

To add a new key while keeping exising ones, use the `-a` flag with the `tee` command:

```bash
echo "<new_SSH_key>" | tee -a authorized_keys
```

{% note info %}

At this stage, you can also [change](../../../baremetal/operations/servers/reset-password.md) the root password, modify other server OS settings to ensure proper booting and network connectivity, and diagnose and troubleshoot errors.

{% endnote %}