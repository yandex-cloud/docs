Create a user to authenticate on the VM through the serial console and set a local password for it:

```bash
sudo useradd <username> && sudo passwd <username>
```

Where `<username>` is the new username, e.g., `yc-user`.

When prompted by the system, enter your user password and confirm it.

Result:

```text
passwd: password updated successfully
```