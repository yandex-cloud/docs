   ```bash
   #cloud-config
   users:
     - name: <имя_пользователя>
       groups: sudo
       shell: /bin/bash
       sudo: ['ALL=(ALL) NOPASSWD:ALL']
       ssh-authorized-keys:
         - <публичный_SSH-ключ_1>
         - <публичный_SSH-ключ_2>
         - ...
   ```

   Где:

   * `name` — имя пользователя ВМ.
   * `ssh-authorized-keys` — список публичных SSH-ключей для доступа к ВМ.
      
     Пример ключа: `ssh-ed25519 AAAAB3Nza......Pu00jRN user@desktop`.