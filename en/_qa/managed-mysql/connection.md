# Connection to a {{ MY }} cluster

#### How do I connect to a cluster? {#how-to-connect}

View the connection examples in the [documentation](../../managed-mysql/operations/connect.md#connection-string) or on the cluster page in the [management console]({{ link-console-main }}) (click **Connect** in the top panel).

{{ MY }} hosts with public access only support connections with an [SSL certificate](../../managed-mysql/operations/connect.md#get-ssl-cert).

There are also [{#T}](../../managed-mysql/operations/connect.md#special-fqdns) pointing to the **Current master** and the **Least lagging replica** in the cluster.

#### Why can't I connect from the internet? {#from-internet}

Check whether there is public access to the host. To do this, in the [management console]({{ link-console-main }}):
1. Go to the folder page and select **{{ mmy-short-name }}**.
1. Click on the name of the cluster you need and select the **Hosts** tab.
1. Look at the value in the desired host's **Public access** column.

{{ MY }} hosts with public access only support connections with an [SSL certificate](../../managed-mysql/operations/connect.md#get-ssl-cert).

Additional information:
* If public access is only configured for certain hosts in your cluster, automatic master change may make the master unavailable over the internet.
* If you are using [{#T}](../../managed-mysql/operations/connect.md#special-fqdns), check the host list to see that the current master or replica have public access.
* If you are using [{#T}](../../managed-mysql/concepts/network.md#security-groups), please check their [settings](../../managed-mysql/operations/connect.md#configure-security-groups).

#### Why can't I connect from {{ yandex-cloud }}? {#from-yc}

Please check that you are connecting from a {{ yandex-cloud }} VM located on the same virtual network as the {{ MY }} cluster.

To do this, in the management console:
1. Go to the folder page, select **{{ mmy-short-name }}**, and click the name of the desired cluster.
1. Check the value of the **Cloud network** parameter and click the network name link to see its subnets.
1. Make sure the virtual machine is located on of that network's subnets.

Additional information:
* If you are connecting to a host with public access, a connection can only be established with an [SSL certificate](../../managed-mysql/operations/connect.md#get-ssl-cert).
* If you are using [{#T}](../../managed-mysql/operations/connect.md#special-fqdns), check the host list to see that the current master or replica have public access.
* If you are using [{#T}](../../managed-mysql/concepts/network.md#security-groups), please check their settings.

#### Why can't I connect to a multi-host cluster? {#to-multi-host-cluster}

If public access is only configured for certain hosts in your cluster, automatic master change may make the master unavailable over the internet.

Check whether there is public access to the host. To do this, in the [management console]({{ link-console-main }}):
1. Go to the folder page and select **{{ mmy-short-name }}**.
1. Click on the name of the cluster you need and select the **Hosts** tab.
1. Look at the value in the desired host's **Public access** column.

Additional information:

* If you are using [{#T}](../../managed-mysql/operations/connect.md#special-fqdns), check the host list to see that the current master or replica have public access.


* If you can't connect to the added host, check that the cluster's [security group](../../managed-mysql/concepts/network.md#security-groups) is configured correctly for the subnet where you placed the host.


#### Why would the connection limit be exceeded? {#connection-limit}

The maximum number of concurrent connections to a {{ mmy-short-name }} cluster host depends on `max_connections` and is `<amount of RAM in MB on one host> ÷ 32`. The minimum value is 100 by default.

For example, for a host of the {{ s1-micro }} class, the default `max_connections` parameter value is: 8192 ÷ 32 = 256.

You can [edit](../../managed-mysql/operations/update.md#change-mysql-config) the **Max connections** value in the cluster settings.
