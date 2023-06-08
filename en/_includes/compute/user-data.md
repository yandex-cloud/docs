```bash
#cloud-config
users:
  - name: <user name>
    groups: sudo
    shell: /bin/bash
    sudo: ['ALL=(ALL) NOPASSWD:ALL']
    ssh-authorized-keys:
      - ssh-ed25519 AAAAB3Nza......OjbSMRX user@example.com
      - ssh-ed25519 AAAAB3Nza......Pu00jRN user@desktop
```
