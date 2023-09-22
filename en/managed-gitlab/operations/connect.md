# Connecting to {{ mgl-name }} instances

## Configuring security groups {#configuring-security-groups}

{{ mgl-name }} uses the [default security group](../../vpc/concepts/security-groups.md#default-security-group) for the selected [network](../../vpc/concepts/network.md#network). You cannot create a different security group when creating an instance.

Set up the default security group for the selected network to allow incoming traffic from any IP addresses on ports 22, 2222, 80, 443, and 5050. To do this, [create rules](../../vpc/operations/security-group-add-rule.md) for incoming traffic:

To access your Git repository over SSH:
* Protocol: `TCP`.
* Port range: `22`.
* Source type: `CIDR`.
* Source: `0.0.0.0/0`.

To access your Git repository over SSH:
* Protocol: `TCP`.
* Port range: `2222`.
* Source type: `CIDR`.
* Source: `0.0.0.0/0`.

For receiving HTTP traffic:
* Protocol: `TCP`.
* Port range: `80`.
* Source type: `CIDR`.
* Source: `0.0.0.0/0`.

For receiving HTTPS traffic:
* Protocol: `TCP`.
* Port range: `443`.
* Source type: `CIDR`.
* Source: `0.0.0.0/0`.

To connect to [{{ container-registry-full-name }}](../../container-registry/).
* Protocol: `TCP`.
* Port range: `5050`.
* Source type: `CIDR`.
* Source: `0.0.0.0/0`.

## Connecting to {#connect} instances

1. Set the administrator password. For this, follow the link sent to your administrator's mailbox that you specified when registering the instance.
1. Open the link to the instance's web interface in your browser. You can find it in the email you received in your administrator's mailbox and in the [instance details](instance/instance-list.md#get).
1. Log in using the administrator's username and password.