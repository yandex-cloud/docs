{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create your private connection.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. In the left-hand panel, select ![icon](../../_assets/console-icons/vector-square.svg) **{{ ui-key.yacloud.baremetal.label_networks }}** and then select the virtual network segment you need.
  1. Under **Private connection to cloud networks**, click **Set up connection** and do the following in the window that opens:

      1. In the **Setup method** field, select `Specify ID` and enter the routing instance ID in the **Connection ID** field.

          Alternatively, you can choose `Select from the folder` and select a routing instance from the list that appears.

          You will see the CIDR blocks of {{ baremetal-name }} and {{ vpc-name }} subnets that will be [advertised](../../interconnect/concepts/priv-con.md#prc-announce) over {{ interconnect-name }}.

          {% include [no-subnet-overlapping-warn](../../_tutorials/_tutorials_includes/bm-vrf-and-vpc-interconnect/no-subnet-overlapping-warn.md) %}
      1. To create a private connection for the specified CIDR blocks, click **Save**.

{% endlist %}

As a result, the VRF information page will display the newly created connection ID and its status under **Private connection to cloud networks**.

{% note info %}

Setting up a private connection may take up to two business days. During this period, the connection status will display as `Creating`. Once the connection is created, its status will change to `Ready`.

{% endnote %}

Private cloud netweork connections may show one of the following statuses:

* `CREATING`: Connection creation in progress.
* `READY`: Connection is up and ready to use.
* `ERROR`: Connection failure. Contact support.
* `DELETING`: Connection deletion in progress.
* `UPDATING`: Connection settings update in progress.