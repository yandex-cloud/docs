#### How do I connect to a cluster? {#how-to-connect}

View the connection examples in [this guide](../../managed-mysql/operations/connect.md#connection-string) or on the cluster page in the [management console]({{ link-console-main }}) (click **{{ ui-key.yacloud.mdb.clusters.button_action-connect }}** in the top panel).

{{ MY }} hosts with public access only support connections with an [SSL certificate](../../managed-mysql/operations/connect.md#get-ssl-cert).

There are also special FQDNs pointing to the [current master](../../managed-mysql/operations/connect.md#fqdn-master) and [most recent replica](../../managed-mysql/operations/connect.md#fqdn-replica) of the cluster.

#### Why cannot I connect from the internet? {#from-internet}

Check whether your host is publicly accessible. To do this, in the [management console]({{ link-console-main }}):
1. Navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
1. Click the name of your cluster and open the **{{ ui-key.yacloud.mysql.cluster.switch_hosts }}** tab.
1. Check the **{{ ui-key.yacloud.mdb.cluster.hosts.host_column_public-ip }}** column value for your host.

{{ MY }} hosts with public access only support connections with an [SSL certificate](../../managed-mysql/operations/connect.md#get-ssl-cert).

Additionally, consider the following:
* If public access in your cluster is only enabled for certain hosts, automatic master failover can make the master unreachable from the internet.
* If you are using [special FQDNs](../../managed-mysql/operations/connect.md#fqdn-master), check the host list to make sure the current master or replica have public access.
* If you are using [{#T}](../../managed-mysql/concepts/network.md#security-groups), check their [settings](../../managed-mysql/operations/connect.md#configure-security-groups).

#### Why cannot I connect from {{ yandex-cloud }}? {#from-yc}

Make sure the {{ yandex-cloud }} VM you are connecting from is in the same virtual network as the {{ MY }} cluster.

To do this, in the management console:
1. Navigate to the folder dashboard, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**, and click the name of your cluster.
1. Check the **{{ ui-key.yacloud.mdb.cluster.overview.label_network }}** value and click the network’s name to see its subnets.
1. Make sure your VM is in one of the network’s subnets.

Additionally, consider the following:
* If you are connecting to a publicly accessible host, make sure to use an [SSL certificate](../../managed-mysql/operations/connect.md#get-ssl-cert).
* If you are using [special FQDNs](../../managed-mysql/operations/connect.md#fqdn-master), check the host list to make sure the current master or replica have public access.
* If you are using [{#T}](../../managed-mysql/concepts/network.md#security-groups), check their settings.

#### Why cannot I connect to a multi-host cluster? {#to-multi-host-cluster}

If public access in your cluster is only enabled for certain hosts, automatic master failover can make the master unreachable from the internet.

Check whether your host is publicly accessible. To do this, in the [management console]({{ link-console-main }}):
1. Navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
1. Click the name of your cluster and open the **{{ ui-key.yacloud.mysql.cluster.switch_hosts }}** tab.
1. Check the **{{ ui-key.yacloud.mdb.cluster.hosts.host_column_public-ip }}** column value for your host.

Additionally, consider the following:

* If you are using [special FQDNs](../../managed-mysql/operations/connect.md#fqdn-master), check the host list to make sure the current master or replica have public access.


* If you cannot connect to the host you added, check that the cluster [security group](../../managed-mysql/concepts/network.md#security-groups) is properly configured for the subnet containing your host.


#### Can I connect to cluster hosts over SSH or get superuser privileges on hosts? {#connect-ssh}

{% include [connect-via-ssh](../../_includes/mdb/connect-via-ssh.md) %}

#### What should I do if I get a revocation check error when using PowerShell to obtain an SSL certificate? {#get-ssl-error}

Here is the full text of the error message:

```text
curl: (35) schannel: next InitializeSecurityContext failed: Unknown error (0x80092012)
The revocation function was unable to check revocation for the certificate
```
This means that the service was unable to verify the site’s certificate against the revocation list during the connection attempt.

To fix this error:

* Make sure your corporate network policies are not blocking the verification.
* Run the following command with the `--ssl-no-revoke` flag:

   ```powershell
   mkdir $HOME\.mysql; curl.exe --ssl-no-revoke -o $HOME\.mysql\root.crt {{ crt-web-path }}
   ```

#### Why would the connection limit be exceeded? {#connection-limit}

The maximum number of concurrent connections to a {{ mmy-short-name }} cluster host is defined by the `max_connections` setting, which defaults to `<MB_of_RAM_per_host> ÷ 32` and cannot be lower than 100.

For example, for a {{ s1-micro }} host, the default `max_connections` value is `8,192 ÷ 32 = 256`.

You can [change](../../managed-mysql/operations/update.md#change-mysql-config) the **Max connections** value in the cluster settings.
