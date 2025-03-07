   ```bash
   #cloud-config
   users:
     - name: <username>
       groups: sudo
       shell: /bin/bash
       sudo: 'ALL=(ALL) NOPASSWD:ALL'
       ssh_authorized_keys:
         - <public_SSH_key_1>
         - <public_SSH_key_2>
         - ...
   ```

   Where:

   * `name`: VM user name.
   * `ssh_authorized_keys`: List of public SSH keys for VM access.
      
     Key example: `ssh-ed25519 AAAAB3Nza...Pu00jRN`.