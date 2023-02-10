# {{ dataproc-name }} maintenance

Maintenance means:

* Changes to the host class and storage size.
* Other maintenance activities.

Maintenance is performed as follows:

1. Data storage and processing [subcluster](./index.md) hosts undergo maintenance consecutively. The subclusters and hosts are queued randomly. If a host needs to be restarted during maintenance, it becomes unavailable while it's being restarted.
1. A master host undergoes maintenance and gets updated. If a cluster needs to be restarted during maintenance, it becomes unavailable.
