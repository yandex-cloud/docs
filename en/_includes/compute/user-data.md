   ```
   #cloud-config
   users:
     - name: <user name>
       groups: sudo
       shell: /bin/bash
       sudo: ['ALL=(ALL) NOPASSWD:ALL']
       ssh-authorized-keys:
         - ssh-rsa AAAAB3Nza......OjbSMRX user@example.com
         - ssh-rsa AAAAB3Nza......Pu00jRN user@desktop
   ```