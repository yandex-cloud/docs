### Risk of data loss and cluster unavailability in the event of a zone failure {#opensearch_high_availability}

**Description**

The cluster does not provide high availability and is not covered by an SLA. The possible causes may include the following:

* Not enough hosts with the `DATA` or `MANAGER` role in the cluster.
* Hosts with the `DATA` or `MANAGER` role reside in the same availability zone.
* More than half of the hosts with the `DATA` or `MANAGER` role reside in the same availability zone.
* Cluster not protected: the system does not block risky changes to cluster and index settings, such as links to non-existent availability zones or node groups in shard placement rules, or indexes without replicas.
* Some checks for protection against risky changes to cluster and index settings are disabled, so cluster protection is not fully active.

To ensure SLA compliance, you must configure two or more hosts with the `DATA` role and three or more hosts with the `MANAGER` role; all in different availability zones, where no zone contains more than half of all hosts with each role. The cluster must also be protected against risky changes to cluster and index settings. For more information, see [High cluster availability](../../managed-opensearch/concepts/high-availability.md).

To check for possible risks, run this request:

```bash
curl \
    --user <username>:<password> \
    --cacert ~/.opensearch/root.crt \
    --request POST \
    --header 'Content-Type: application/json' \
    --url 'https://<FQDN_of_{{ OS }}_host_with_public_access>:{{ port-mos }}/_plugins/_security/availability_guard/analyze' \
    --data '{}'
```

Detected issues are listed in the `allocation_impacts` array in the response; the reason for each one is stated in the `reason` field. An empty request body (`{}`) means that the cluster's current state will be checked. To pre-evaluate the consequences of your changes (new cluster settings, another set of hosts, or availability zone failure), provide additional fields in the request body. For more information, see [Checking cluster settings](../../managed-opensearch/concepts/high-availability.md#analyze).

**Action**

To add a host to another zone:

1. [Navigate]({{ link-console-main }}/link/managed-opensearch) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
1. Click the name of your cluster and select the **{{ ui-key.yacloud.opensearch.cluster.node-groups.title_node-groups }}** tab.
1. Click ![image](../../_assets/console-icons/ellipsis.svg) in the row with the group you need and select **{{ ui-key.yacloud.opensearch.cluster.node-groups.action_edit }}**.
1. Update the host placement across availability zones.
1. Finish configuring the host and click **{{ ui-key.yacloud.mysql.hosts.dialog.button_choose }}**.

If the cluster is not protected or some protection checks are inactive, fix such cluster and index misconfigurations, then contact [support]({{ link-console-support }}) to activate protection.
