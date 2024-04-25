```yml
#cloud-config
datasource:
  Ec2:
    strict_id: false
ssh_pwauth: no
users:
- name: <имя_пользователя_1>
  sudo: 'ALL=(ALL) NOPASSWD:ALL'
  shell: /bin/bash
  ssh_authorized_keys:
  - <публичный_SSH-ключ_1>
- name: <имя_пользователя_2>
  sudo: 'ALL=(ALL) NOPASSWD:ALL'
  shell: /bin/bash
  ssh_authorized_keys:
  - <публичный_SSH-ключ_2>
...
- name: <имя_пользователя_n>
  sudo: 'ALL=(ALL) NOPASSWD:ALL'
  shell: /bin/bash
  ssh_authorized_keys:
  - <публичный_SSH-ключ_n>
runcmd: []
```