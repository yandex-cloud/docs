### Risk of data loss and cluster unavailability in the event of a zone failure {#opensearch_high_availability}

**Description**

The cluster does not provide high availability and is not covered by an SLA. Most hosts reside in a single availability zone. The cluster is not protected: the system does not block risky changes to cluster and index settings, such as specifying links to non-existent availability zones or node groups in shard placement rules. Enable protection to prevent dangerous changes. To ensure SLA compliance, you must configure two or more hosts with the `DATA` role and three or more hosts with the `MANAGER` role; all in different availability zones, where no zone contains more than half of all hosts with each role.

To check for possible risks, run this command:

`curl --user user:pass -X POST https://url/_plugins/_security/availability_guard/analyze -d '{}'`

**Action**

To add a host to another zone:

1. [Navigate]({{ link-console-main }}/link/managed-opensearch) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
1. Click the name of your cluster and select the **{{ ui-key.yacloud.opensearch.cluster.node-groups.title_node-groups }}** tab.
1. Click ![image](../../_assets/console-icons/ellipsis.svg) in the row with the group you need and select **{{ ui-key.yacloud.opensearch.cluster.node-groups.action_edit }}**.
1. Update the host placement across availability zones.
1. Finish configuring the host and click **{{ ui-key.yacloud.mysql.hosts.dialog.button_choose }}**.


