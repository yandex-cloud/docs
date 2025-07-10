{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create your private connection.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. In the left-hand panel, select ![icon](../../_assets/console-icons/vector-square.svg) **{{ ui-key.yacloud.baremetal.label_networks }}** and then select the virtual network segment you need.
  1. Under **{{ ui-key.yacloud.baremetal.title_vrf-interconnect-section }}**, click **{{ ui-key.yacloud.baremetal.action_add-vrf-interconnect }}**, and in the window that opens:

      1. In the **{{ ui-key.yacloud.baremetal.label_vrf-interconnect-select-type }}** field, select `{{ ui-key.yacloud.baremetal.field_interconnect-direct-id }}` and paste the `Routing Instance` private connection ID to the **{{ ui-key.yacloud.baremetal.label_vrf-interconnect-direct-type }}** field.

          You can also select the `{{ ui-key.yacloud.baremetal.field_interconnect-from-folder }}` option. In this case, select the `Routing Instance` you need from the list that opens.

          As a result, you will see the CIDR blocks of {{ vpc-name }} subnets that will be [advertised](../../interconnect/concepts/priv-con.md#prc-announce) over {{ interconnect-name }}.

          {% include [no-subnet-overlapping-warn](../../_tutorials/_tutorials_includes/bm-vrf-and-vpc-interconnect/no-subnet-overlapping-warn.md) %}
      1. To create a private connection for the specified CIDR subnets, click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

As a result, the VRF information page will display the newly created connection ID and its status under **{{ ui-key.yacloud.baremetal.title_vrf-interconnect-section }}**.

{% note info %}

Setting up a private connection may take up to two business days. During this period, the connection status will display as `Creating`. Once the connection is created, its status will change to `Ready`.

{% endnote %}

Private cloud netweork connections may show one of the following statuses:

* `CREATING`: Connection creation in progress.
* `READY`: Connection is up and ready to use.
* `ERROR`: Connection failure. Contact support.
* `DELETING`: Connection deletion in progress.
* `UPDATING`: Connection settings update in progress.