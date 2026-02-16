In the **{{ ui-key.yacloud.baremetal.servers.BandwidthRow.bandwidthTitle_wvZra }}** field, select a [server bandwidth](../../../baremetal/concepts/network-restrictions.md#bandwidth-for-pubic-network) package. Available bandwidth packages:

* `{{ ui-key.yacloud.baremetal.servers.BandwidthRow.plan10Tb_2BFQU }}`
* `{{ ui-key.yacloud.baremetal.servers.BandwidthRow.plan100Tb_4AB2b }}`

{% note info %}

You can select a bandwidth package only for configurations with a public IP address and network cards of 10 Gbps or higher.

You can reduce the connection capacity to 10 TB per day only as early as 24 hours after the server lease starts.

{% endnote %}