   ```bash
   #cloud-config
   users:
     - name: <имя пользователя>
       groups: sudo
       shell: /bin/bash
       sudo: ['ALL=(ALL) NOPASSWD:ALL']
       ssh_authorized_keys:
         - ssh-ed25519 AAAAB3Nza......OjbSMRX user@example.com
         - ssh-ed25519 AAAAB3Nza......Pu00jRN user@desktop
   ```
