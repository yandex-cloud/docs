Rent a server:

```bash
yc baremetal server create \
  --folder-id <folder_ID> \
  --hardware-pool-id <pool> \
  --configuration-id <configuration_ID> \
  --os-settings-spec "image-id=<image_ID>,storages=[{partitions=[{type=<file_system>,size-gib=<partition_size>,mount-point=<mount_point>}],storage-type={raid={type=<RAID_array_level>,disks=[{id=<disk_number>,size-gib=<disk_size>,type=<disk_type>}]}}}],ssh-key={ssh-public-key=<SSH_public_key_contents>},password={password-plain-text=<user_password>}" \
  --rental-period-id <lease_period> \
  --network-interfaces '{interface={private-interface={native-subnet-id=<private_subnet_ID>}}}' \
  --network-interfaces '{interface={public-interface={native-subnet-config={native-subnet={subnet-id=<public_subnet_ID>}}}}}' \
  --name <server_name> \
  --description "<server_description>" \
  --labels <label_key>=<label_value>
```
