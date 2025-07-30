Lease a server:

```bash
yc baremetal server create \
  --hardware-pool-id <pool> \
  --configuration-id <configuration_ID> \
  --storage "partition={type=<file_system>,size-gib=<partition_size>,mount-point=<mount_point>},raid-type=<RAID array level>,disk={id=<disk_number>,size-gib=<disk_size>,type=<disk_type>}" \
  --os-settings "image-id=<image_ID>,image-name=<image_name>,ssh-key-public=<public_SSH_key_contents>,ssh-key-user-id=<SSH_key_user_ID>,password-plain-text=<user_password>,password-lockbox-secret={secret-id=<secret_ID>,version-id=<secret_version>,key=<secret_key>}" \
  --rental-period-id <lease_period> \
  --network-interfaces private-subnet-id=<private_subnet_ID> \
  --network-interfaces public-subnet-id=<public_subnet_ID> \
  --name <server_name> \
  --description "<server_description>" \
  --labels <label_key>=<label_value>
```