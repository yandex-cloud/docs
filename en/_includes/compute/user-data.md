```bash
#cloud-config
users:
  - name: <username>
    groups: sudo
    shell: /bin/bash
    sudo: 'ALL=(ALL) NOPASSWD:ALL'
    ssh-authorized-keys:
      - <public_SSH_key_1>
      - <public_SSH_key_2>
      - ...
```

Where:

* `name`: VM username.
* `ssh-authorized-keys`: List of public SSH keys for VM access.

   Sample key: `ssh-ed25519 AAAAB3Nza......Pu00jRN user@desktop`.
