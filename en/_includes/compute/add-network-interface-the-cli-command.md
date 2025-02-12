```bash
yc compute instance attach-network-interface \
  --id <VM_ID> \
  --subnet-id <subnet_ID> \
  --network-interface-index <network_interface_number> \
  --security-group-id <security_group_ID> \
  --ipv4-address <internal_IP_address> \
  --nat-ip-version ipv4 \
  --nat-address <public_IP_address>
```

Where:
* `--id`: ID of the selected VM. Instead of the ID, you can use the `--name` parameter to specify the VM name.
* `--subnet-id`: ID of the subnet to connect to the network interface being added. Instead of the ID, you can use the `--subnet-name` parameter to specify the subnet name.
* `--network-interface-index`: Number of the VM network interface you are creating. Specify any number between `0` and `15` except the ones already used.
* `--security-group-id`: ID of the security group to bind to the network interface you are creating. You can bind up to five security groups to a single network interface by listing their IDs separated by commas.
* `--ipv4-address`: Internal IP address to assign to the network interface. It must be within the address range of the subnet you are connecting to the interface. Set it to `auto` to automatically assign an internal IP address from the pool of IP addresses available in the subnet.
* `--nat-ip-version ipv4`: Specify this parameter if you need to assign a [public IP address](../../vpc/concepts/address.md#public-addresses) to the network interface you are creating. If you omit `--nat-address`, a dynamic public IP address from the pool of available {{ yandex-cloud }} IP addresses will be assigned to your network interface.

    If your network interface does not need a public IP address, omit the `--nat-ip-version` parameter.

* `--nat-address`: Previously [reserved](../../vpc/operations/get-static-ip.md) static public IP address. You can only specify this parameter if `--nat-ip-version` is set. The IP address must be reserved in the same [availability zone](../../overview/concepts/geo-scope.md) as the VM.