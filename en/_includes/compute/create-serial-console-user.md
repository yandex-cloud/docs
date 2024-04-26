Create a user to authenticate on the VM through the serial console and set a local password for it:

```bash
sudo useradd <username> && sudo passwd <username>
```

Where `<username>` is the name of the new user, e.g., `yc-user`.

When prompted by the system, enter your user password, then confirm it.

Result:

```text
passwd: password updated successfully
```
