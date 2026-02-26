{% cut "Metadata example" %}

```yaml
#cloud-config
datasource:
 Ec2:
  strict_id: false
disable_root: false
users:
- name: <username>
  sudo: ALL=(ALL) NOPASSWD:ALL
  shell: /bin/bash
  ssh_authorized_keys:
  - ssh-rsa <public_key_for_VM_access>
```

{% endcut %}