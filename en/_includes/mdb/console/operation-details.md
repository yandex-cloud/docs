{% note info %}

Operations where details are available have the ![image](../../../_assets/mdb/info.svg) icon next to their ID.

{% endnote %}

Operation details include a hierarchical list of the operation steps. The first-level items are actions with the cluster, and the second-level ones are actions with hosts. The list may vary for different operations:
  * If a step is running or has completed, its start date and time are displayed. 
  * If a step has not yet started, it has the **In queue** status.

The list displays the following actions:

* **Preparing metadata**: Preparing information and data for the operation.
* **Preparing backup storage**: Preparing storage for backups.
* **Creating cluster**: Creating a cluster.
* **Installing software**: Installing software (e.g., creating a database or installing auxiliary plugin packages).
* **Initializing database**: Initializing a database.
* **Infrastructure integration**: Creating connections between new objects and the {{ yandex-cloud }} infrastructure (e.g., DNS propagation, issuing certificates, adding hosts to the monitoring system).
* **Updating host groups**: Updating a host group.
* **Updating hosts**: Updating hosts.
* **Completing**: Completing the operation.

Actions with hosts:

* **Reserving resources**: Allocating resources for a host.
* **Creating host**: Creating a host.
* **Launching host**: Starting a host.
* **Preparing host**: Preparing a host.
* **Updating database software**: Updating software.
* **Updating database services**: Updating database services.
* **Creating DNS records**: Creating a DNS record.
* **Restarting database**: Restarting a database.
