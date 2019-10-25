# Instance statuses

Each instance in a group can have one of the following statuses:

| Status | Description |
| ----- | ----- |
| `CREATING_INSTANCE` | An instance is being created in {{ compute-full-name }}. |
| `UPDATING_INSTANCE` | The basic parameters or metadata are being updated without re-creating the instance. |
| `DELETING_INSTANCE` | An instance is being deleted from {{ compute-full-name }}. |
| `STARTING_INSTANCE` | The OS and user application are being started. |
| `STOPPING_INSTANCE` | The instance is being stopped. |
| `AWAITING_STARTUP_DURATION` | The instance was created and is waiting for the user application to start. |
| `CHECKING_HEALTH` | An instance health check is in progress. |
| `OPENING_TRAFFIC` | The instance is ready to receive traffic, from the viewpoint of the network load balancer. |
| `AWAITING_WARMUP_DURATION` | The instance is receiving traffic and waiting for the user application to warm up. |
| `CLOSING_TRAFFIC` | The instance no longer receives traffic, from the viewpoint of the network load balancer. |
| `RUNNING_ACTUAL` | The instance is running. |
| `RUNNING_OUTDATED` | The instance is running but will soon be updated or deleted. |
| `STOPPED` | The instance was stopped. |
| `DELETED` | The instance was deleted. |

