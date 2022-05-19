You can see the cluster state in the same-name section on the **Overview** page.

Availability indicates the total number of hosts that are `ALIVE`. It guarantees that the service will be provided if one or more hosts fail.

Each `Alive` host increases the overall availability by 1. If one of the hosts fails, the overall availability is reduced by 1.

| Status | Description | Suggested actions |
| :--- | :--- | :--- |
| **ALIVE** | Cluster is operating normally | No action is required. |
| **DEGRADED** | Cluster is not running at its full capacity<br>(the state of at least one of the hosts is other than `ALIVE`) | Perform self-diagnosis:<ul><li>Go to the list of hosts. Find out which of them are down.</li><li>View the list of operations. Some operation may still be running.</li><li>Make sure that the cluster is not under maintenance.</li></ul>If you couldn't find the cause, contact support. |
| **DEAD** | Cluster is out of order<br>(all of its hosts are down) | Send a request to the support service:<ul><li>Specify the cluster ID and the IDs of the last operations that were performed on it.</li><li>Checking against the availability charts, specify when exactly it switched to `DEAD`.</li></ul> |
| **UNKNOWN** | Cluster state is unknown | Send a request to the support service:<ul><li>Specify the cluster ID and the IDs of the last operations that were performed on it.</li><li>Checking against the [availability charts](#monitoring-cluster), specify when exactly it switched to `UNKNOWN`.</li></ul> |

