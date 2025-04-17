{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create your private connection.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. In the left-hand panel, select ![icon](../../_assets/console-icons/vector-square.svg) **{{ ui-key.yacloud.baremetal.label_networks }}** and select the virtual network segment you need.
  1. Under **Private connection to cloud networks**, click **Set up connection** and in the window that opens:

      1. In the **Setup method** field, select `Specify ID` and paste the routing instance private connection ID to the **Connection ID** field.

          You can also go for `Select from the folder`. In which case select a routing instance from the list that appears.

          You will see the CIDRs of {{ baremetal-name }} and {{ vpc-name }} subnets which will be [announced](../../interconnect/concepts/priv-con.md#prc-announce) in {{ interconnect-name }}.

          {% include [no-subnet-overlapping-warn](../../_tutorials/_tutorials_includes/bm-vrf-and-vpc-interconnect/no-subnet-overlapping-warn.md) %}
      1. To create a private connection with the specified subnet CIDRs, click **Save**.

{% endlist %}

The VRF information page will now display the new connection's ID and status under **Private connection to cloud networks**.

{% note info %}

Creating a private connection may take up to two business days. During this time, the connection status will be `Creating`. After it is created, the connection status will change to `Ready`.

{% endnote %}

A private connection to cloud networks can have one of the following statuses:

* `CREATING`: Connection is being created.
* `READY`: Connection is up and ready for use.
* `ERROR`: There is an issue with the private connection. To fix it, contact support.
* `DELETING`: Connection is being deleted.
* `UPDATING`: Private connection settings are being updated.