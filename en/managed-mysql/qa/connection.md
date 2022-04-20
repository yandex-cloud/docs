# Connection

#### How do I connect to a cluster {#how-to-connect}

View the connection examples in the [documentation](../operations/connect.md#connection-string) or on the cluster page in the [management console]({{ link-console-main }}) (click **Connect** in the top panel).

{{ MY }} hosts with public access only support connections with an [SSL certificate](../operations/connect.md#get-ssl-cert).

There are also [{#T}](../concepts/network.md#special-fqdns) that point to the **Current master** and the cluster's **Least lagging replica**.

#### Cannot connect from the internet {#from-internet}

Check whether there is public access to the host. To do this, in the [management console]({{ link-console-main }}):
1. Go to the folder page and select **{{ mmy-short-name }}**.
1. Click on the name of the cluster you need and select the **Hosts** tab.
1. Look at the value in the desired host's **Public access** column.

{{ MY }} hosts with public access only support connections with an [SSL certificate](../operations/connect.md#get-ssl-cert).

Additional information:
* If public access is only configured for certain hosts in your cluster, automatic master change may make the master unavailable over the internet.
* If you are using [{#T}](../concepts/network.md#special-fqdns), check the host list to see that the current master or replica has public access.
* If you are using [{#T}](../concepts/network.md#security-groups), please check their [settings](../operations/connect.md#configure-security-groups).

#### Cannot connect from {{ yandex-cloud }} {#from-yc}

Please check that you are connecting from a {{ yandex-cloud }} virtual machine located on the same [virtual network](../../vpc/concepts/network.md) as the {{ MY }} cluster.

To do this, in the management console:
1. Go to the folder page, select **{{ mmy-short-name }}**, and click the name of the desired cluster.
1. Check the value of the **Cloud network** parameter and click the network name link to see its subnets.
1. Make sure the virtual machine is located in one of that network's subnets.

Additional information:
* If you are connecting to a host with public access, a connection can only be established with an [SSL certificate](../operations/connect.md#get-ssl-cert).
* If you are using [{#T}](../concepts/network.md#special-fqdns), make sure the current master or replica is available for public access.
* If you are using [{#T}](../concepts/network.md#security-groups), please check their [settings](../operations/connect.md#configure-security-groups).

#### Cannot connect to a multi-host cluster {#to-multi-host-cluster}

If public access is only configured for certain hosts in your cluster, automatic master change may make the master unavailable over the internet.

Check whether there is public access to the host. To do this, in the [management console]({{ link-console-main }}):
1. Go to the folder page and select **{{ mmy-short-name }}**.
1. Click on the name of the cluster you need and select the **Hosts** tab.
1. Look at the value in the desired host's **Public access** column.

Additional information:
* If you are using [{#T}](../concepts/network.md#special-fqdns), check the host list to see that the current master or replica have public access.
* If you cannot connect to a host after it is added, make sure that the cluster [security group](../concepts/network.md#security-groups) has the correct settings for the subnet in which the host is located.

#### Connection limit exceeded {#connection-limit}

The maximum number of parallel connections to a {{ mmy-short-name }} cluster host is defined by the `max_connections` setting, and is equal to `<amount of MB of host RAM> ÷ 32` by default, with a minimum of 100.

For example, for a {{ s1-micro }} host, the default value of the `max_connections` parameter is 8192 ÷ 32 = 256.

You can [edit](../operations/update.md#change-mysql-config) the **Max connections** value in the {{ MY }} cluster settings.
