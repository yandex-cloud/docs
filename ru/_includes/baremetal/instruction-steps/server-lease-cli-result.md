Результат:

```text
done (22m45s)
id: ly52dtzdi55r********
cloud_id: b1gia87mbaom********
folder_id: b1g0ijbfaqsn********
name: demo-baremetal-server
description: My first BareMetal server
zone_id: ru-central1-m
hardware_pool_id: ru-central1-m4
status: PROVISIONING
os_settings:
  image_id: ly5vhn4lapev********
  ssh_public_key: ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGcM4tRfRHJGrlLMT+YJFr+aOdSQYnYYjAoj********
  storages:
    - partitions:
        - type: EXT3
          size_gib: "999"
          mount_point: /
        - type: EXT4
          size_gib: "499"
          mount_point: /root
      raid:
        type: RAID0
        disks:
          - id: ly5ual3jbnhr********
            type: HDD
            size_gib: "1862"
          - id: ly54qfjw55d4********
            type: HDD
            size_gib: "1862"
    - partitions:
        - type: EXT3
          size_gib: "999"
          mount_point: /boot
        - type: SWAP
          size_gib: "9"
      disk:
        id: ly5ojffpngul********
        type: HDD
        size_gib: "1862"
network_interfaces:
  - id: ly5wbsiklrtd********
    mac_address: 00:25:90:92:fa:48
    private_subnet:
      private_subnet_id: ly5ztavbezrf********
  - id: ly5ygl4loyy6********
    mac_address: 00:25:90:92:fa:49
    public_subnet:
      public_subnet_id: ly5o6l7pxmk2********
configuration_id: ly5lymxdltk3xitpkrmi
created_at: "2025-07-06T21:53:46.186130Z"
labels:
  env: test
```