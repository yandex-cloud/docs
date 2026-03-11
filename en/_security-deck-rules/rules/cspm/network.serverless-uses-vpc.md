### Serverless Containers/Cloud Functions uses the VPC internal network {#serverless-uses-vpc}

#|
|| **kind** | **severity** | **ID** ||
|| manual | information | network.serverless-uses-vpc ||
|#

#### Description

By default, the function is launched in an isolated IPv4 network with NAT gateway enabled. For this reason, only public IPv4 addresses are available. You cannot fix the address.

Networking between two functions, as well as between functions and user resources, is limited:

* Incoming connections are not supported. For example, you cannot access the internal components of a function over the network, even if you know the IP address of its instance.
* Outgoing connections are supported via TCP, UDP, and ICMP. For example, a function can access a Yandex Compute Cloud VM or a Yandex Managed Service for YDB DB on the user's network.
* Functions are cross-zoned: you cannot explicitly specify a subnet or select an availability zone to run a function.

If necessary, you can specify a cloud network in the function settings. In such case:

* The function will be executed in the specified cloud network.
* While being executed, the function will get an IP address in the relevant subnet and access to all the network resources.
* The function will have access not only to the internet but also to user resources located in the specified network, such as databases, virtual machines, etc.
* The function will have an IP address within the `198.19.0.0/16` range when accessing user resources.
* You can only specify a single network for functions, containers, and API gateways that reside in the same cloud.

#### Guides and solutions to use

1. In the [management console](https://console.yandex.cloud/), select the cloud or folder to check functions in.
2. Go to Cloud Functions.
3. Open the function.
4. In the object settings, go to the **Edit function version** tab.
5. In the **Network** field, select the cloud network you need.
6. Click **Save changes**.