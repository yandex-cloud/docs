Minimum VM and {{ baremetal-name }} server specification to install and correctly run the {{ backup-name }} agent:

* Free disk space:

  * For Linux-based VMs: 2 GB.
  * For Windows-based VMs: 1.2 GB.

* RAM: For backups, 1 GB of RAM is required per 1 TB of backup. The RAM requirement depends on the amount and type of data processed by the [{{ backup-name }} agent](../../backup/concepts/agent.md).
