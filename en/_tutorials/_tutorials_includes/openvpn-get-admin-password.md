## Get the administrator password {#get-admin-password}

The openvpn user with administrator privileges was created on the `OpenVPN` server in advance. The password is generated automatically when you create a [VM](../../compute/concepts/vm.md).

You can get the password in the [serial port output](../../compute/operations/vm-info/get-serial-port-output) or the serial console. The password will display in the following string:

```text
To log in, please use the `openvpn` account with the <password> password.
```

Where `<password>` is the `openvpn` user password.

Log in to the admin panel using the `openvpn` username and the obtained password.

If you do not get the password after [launching the VPN server](#create-vpn-server) for the first time, you need to re-create the VM running [OpenVPN Access Server](/marketplace/products/yc/openvpn-access-server). The password will not display when reboot.