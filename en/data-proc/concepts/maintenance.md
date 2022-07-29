# Maintenance

Maintenance means:

* Changes to the host class and storage size.
* Other maintenance activities.

Maintenance is performed as follows:

1. `Compute` and `Data` hosts in [subclusters](./index.md) undergo maintenance consecutively. The subclusters and hosts are queued randomly. If a host needs to be restarted during maintenance, it becomes unavailable while it's being restarted.
1. A host with the `Master` role in the subcluster undergoes maintenance and gets updated. If a cluster needs to be restarted during maintenance, it becomes unavailable.
