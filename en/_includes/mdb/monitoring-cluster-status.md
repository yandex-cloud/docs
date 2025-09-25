Status | Description | Suggested actions
:--- | :--- | :---
**CREATING** | Preparing for the first start | Wait a while and get started. The time it takes to create a cluster depends on the host class.
**RUNNING** | The cluster is operating normally | No action is required.
**STOPPING** | The cluster is stopping | After a while, the cluster status will switch to `STOPPED` and the cluster will be disabled. No action is required.
**STOPPED** | The cluster is stopped | Start the cluster to get it running again.
**STARTING** | Starting the cluster that was stopped earlier | After a while, the cluster status will switch to `RUNNING`. Wait a while and get started.
**UPDATING** | Updating the cluster's configuration | Once the update is complete, the cluster will get the status it had prior to the update: `RUNNING` or `STOPPED`.
**ERROR** | Error when performing an operation with the cluster or during a maintenance window | If the cluster remains in this status for a long time, [contact support]({{ link-console-support }}). You can see whether a cluster is available by its status.
**STATUS_UNKNOWN** | The cluster is unable to determine its status | If the cluster remains in this status for a long time, [contact support]({{ link-console-support }}).
