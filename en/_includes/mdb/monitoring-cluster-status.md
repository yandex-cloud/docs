| Status | Description | Suggested actions |
:--- | :--- | :---
| **CREATING** | Preparing for the first launch | Wait a while and get started. The time it takes to create a cluster depends on the host class. |
| **RUNNING** | Cluster is operating normally | No action is required. |
| **STOPPING** | Stopping | After a while, the cluster's status will change to `STOPPED` and it will be disabled. No action is required. |
| **STOPPED** | Stopped | For instructions on how to restart it, see **Stopping and restarting a cluster**. |
| **STARTING** | Starting the cluster that was stopped earlier | After a while, the cluster's status will change to `RUNNING`. Wait a while and get started. |
| **UPDATING** | Updating the cluster status | After the update is completed, the cluster's status will change to `RUNNING`. Wait a while and get started. |
| **ERROR** | An error occurred that does not allow the cluster to continue working | Run the initial diagnostics:<ul><li>Analyze the cluster's [monitoring charts](#monitoring-cluster) and view operations that were performed in it.</li><li>Prepare a list of IDs of problem resources.</li></ul>If you cannot find the cause of the error yourself, [contact support]({{ link-console-support }}). |
| **STATUS_UNKNOWN** | Cluster is unable to determine its own status | Run the initial diagnostics:<ul><li>Analyze the cluster's [monitoring charts](#monitoring-cluster) and view operations that were performed in it.</li><li>Prepare a list of IDs of problem resources.</li></ul>If you cannot find the cause of the error yourself, [contact support]({{ link-console-support }}). |
