```yml
#cloud-config
datasource:
  Ec2:
    strict_id: false
ssh_pwauth: no
users:
- name: <username_1>
  sudo: 'ALL=(ALL) NOPASSWD:ALL'
  shell: /bin/bash
  ssh_authorized_keys:
  - <public_SSH_key_1>
- name: <username_2>
  sudo: 'ALL=(ALL) NOPASSWD:ALL'
  shell: /bin/bash
  ssh_authorized_keys:
  - <public_SSH_key_2>
...
- name: <username_n>
  sudo: 'ALL=(ALL) NOPASSWD:ALL'
  shell: /bin/bash
  ssh_authorized_keys:
  - <public_SSH_key_n>
runcmd: []
```
