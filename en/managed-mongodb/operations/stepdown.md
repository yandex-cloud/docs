# Selecting a different primary replica

If a cluster has [several replicas](../concepts/replication.md), you can select a different primary replica (master) as required.

Switching takes on average less than a minute. The cluster may be unavailable for writing for several seconds while switching is taking place.

For more information about switching the primary replica, see the [{{ MG }}](https://docs.mongodb.com/manual/reference/method/rs.stepDown/) documentation.

To select a different primary replica:

{% list tabs %}

- Management console
    1. Go to the [folder page]({{ link-console-main }}) and select **{{ mmg-name }}**.
    1. Click on the name of the cluster you want and select the **Hosts** tab.
    1. Click ![options](../../_assets/horizontal-ellipsis.svg) in the `PRIMARY` host line and select **Change master**.

{% endlist %}

