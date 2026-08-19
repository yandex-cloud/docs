# Zones of control between the {{ maf-full-name }} users and {{ yandex-cloud }}

{{ maf-full-name }} users should be aware of how responsibilities are shared between [{{ yandex-cloud }}](#cloud-responsibilities) as a cloud provider and the [{{ yandex-cloud }} customer](#customer-responsibilities). Understanding these zones of control enables you to use {{ maf-full-name }} efficiently and streamline your interactions with support.

{{ yandex-cloud }} support only handles issues that fall within the {{ yandex-cloud }} scope of responsibility. Requests to troubleshoot problems within the customer's zone of control are outside the scope of support provided by {{ yandex-cloud }}.

## Service architecture {#architecture}

Each [{{ AF }} cluster](../../managed-airflow/concepts/index.md#cluster) runs in a dedicated {{ managed-k8s-full-name }} node group isolated from other clusters via virtual networks and native {{ k8s }} tools. Node groups are managed by a shared {{ k8s }} master controlled by {{ yandex-cloud }}.

A shared {{ PG }} cluster managed by {{ yandex-cloud }} stores {{ AF }} metadata. Access to this cluster is restricted.

## {{ yandex-cloud }} control zone {#cloud-responsibilities}

* **Physical and virtual infrastructure**. Maintaining the health of physical servers, virtual machines, disks, and network connectivity utilized by the service components.

* **{{ k8s }} infrastructure** Maintaining the health of the shared {{ k8s }} master and node group network infrastructure comprising a virtual network, security group, and service account. Isolation of node groups between clusters.

* **Managed {{ PG }} cluster for metadata**. Ensuring the health, availability, and backups of the shared {{ PG }} cluster used to store {{ AF }} metadata.

* **{{ AF }} components managed by {{ yandex-cloud }}**. Maintaining the health of the core [{{ AF }} components](../../managed-airflow/concepts/index.md#components):

  * Web server
  * Scheduler
  * DAG processor
  * Workers
  * Triggerer

* **Backup and recovery**. Backup and recovery of the {{ AF }} cluster database with metadata. Recovery from a backup is not guaranteed if the problem is caused by an error on the component provider's side or data architecture issues. In such cases, {{ yandex-cloud }} support will identify the cause of the problem and provide recommendations to prevent the issue from recurring.

* **Cluster operations**. Cluster management through available cloud interfaces, including creating, modifying, scaling, updating, and deleting a cluster, as well as updating individual component configurations.

* **DAG file storage**. Ensuring platform-level integration between the {{ AF }} cluster and {{ objstorage-full-name }}.

* **Platform-level monitoring and logging**. Providing access to {{ AF }} component health metrics via {{ monitoring-full-name }}. Providing platform-specific {{ AF }} component logs via {{ cloud-logging-full-name }}.

* **Maintenance and updates**. Applying security updates to platform components and guest OS nodes. Applying optimal default settings when creating new clusters and updating {{ AF }} versions.

* **Integrations with {{ yandex-cloud }} services**. Providing platform integration with {{ yandex-cloud }} services:

  * {{ objstorage-full-name }}: Storing DAG files and task logs.
  * {{ iam-full-name }}: Managing platform-level access to the service.
  * {{ vpc-full-name }}: Cluster network isolation.
  * {{ lockbox-full-name }}: Storing secrets, connections, and variables.
  * {{ cloud-logging-full-name }} and {{ monitoring-full-name }}: Collecting platform logs and metrics.

* **User documentation**. Developing and updating documentation for {{ maf-full-name }}. {{ AF }} documentation is provided by the Apache Software Foundation.

## {{ yandex-cloud }} customer control zone {#customer-responsibilities}

* **Writing DAG files**. Developing, testing, debugging, and optimizing DAG files and {{ AF }} operators.

* **Task logic**. Ensuring proper business logic within operators, hooks, and sensors.

* **Python dependencies**. Managing custom Python libraries installed on the cluster. It is the customer’s responsibility to ensure these libraries are compatible with each other as well as with Python and {{ AF }} versions provided by {{ maf-full-name }}.

  The Python version depends on the version of {{ AF }} provided by {{ yandex-cloud }} and may change after a cluster upgrade. Following an upgrade, the customer must verify that custom libraries remain compatible with the new Python and {{ AF }} versions. {{ yandex-cloud }} does not guarantee compatibility of custom libraries with any given version of Python or {{ AF }}.

* **Task Instance diagnostics**. Analyzing task statuses, reviewing task logs, and diagnosing failure root causes at the code level.

* **Schedule planning**. Correctly configuring DAG schedule parameters, including `schedule_interval`, `start_date`, `catchup`, `max_active_runs`, etc.

* **DAG performance**. Optimizing DAGs in terms of the task count, parallel execution, and execution time. Preventing overload of the scheduler, DAG processor, and worker pool.

* **DAG file storage in {{ objstorage-full-name }}**. Uploading, versioning, and managing DAG files in a {{ objstorage-full-name }} bucket. Setting up and running CI/CD pipelines to deliver DAG files to the bucket. Ensuring the cluster service account has correct permissions to access the bucket.

* **Using {{ GL }} as a DAG storage**. Ensuring stable operation of {{ GL }}. Platform-level {{ maf-full-name }} errors related to {{ GL }} fall within the {{ yandex-cloud }} scope of responsibility.

* **Cluster resources**. Ensuring that the cluster configuration matches the actual load. This includes selecting the appropriate resource types, number of component instances, minimum and maximum number of workers.

* **{{ AF }} settings**. Configuring {{ AF }} settings available to the customer. The customer assumes full risk if deviating from the recommended default values.

* **Maintenance window**. Scheduling a window for cluster maintenance.

* **Connections and variables**. Creating, configuring, and maintaining {{ AF }} connections and variables. Setting up integration with {{ lockbox-full-name }} or other secret storage backends. Managing secret lifecycle.

* **Access management**. Setting up roles and service accounts for access to {{ AF }}.

* **Monitoring and responding to events**. Analyzing cluster performance metrics and responding promptly to alerts. Setting up additional alerts for custom task and DAG metrics. Analyzing task logs available via the {{ AF }} UI and {{ cloud-logging-full-name }}.

* **External systems**. Ensuring the availability and correct operation of external systems with which {{ AF }} tasks interface.

* **Network connectivity with external systems**. Configuring security groups, routing, and NAT to enable cluster access to target external resources.

* **Third-party software**. Configuring and operating CI/CD tools for DAG deployment and third-party monitoring systems.

* **Version upgrades**. Preparing for an {{ AF }} version update upon receiving an alert or reviewing the [{{ AF }} versioning policy](../../managed-airflow/concepts/update-policy.md). This includes analyzing the release notes and and verifying that DAGs, operators, and dependencies are compatible with the target version.

  The customer must verify the compatibility of custom Python libraries with both the Python and {{ AF }} versions provided with the new cluster version before and after the upgrade. Updating or replacing incompatible libraries is also the customer's responsibility.

* **Pre-upgrade testing in production clusters**. Testing DAGs on the new {{ AF }} version before applying the upgrade to the production cluster.

* **Use of an outdated {{ AF }} version**. Resolving operational issues that arise from using an outdated version of {{ AF }} after the {{ yandex-cloud }} support windows have expired.

## Common scenarios {#scenarios}

| Scenario | Control zone |
| --- | --- |
| The {{ AF }} web server is down and the web UI is inaccessible. | {{ yandex-cloud }} |
| A task instance fails with an error in custom code. | Customer |
| The DAG processor fails to parse a DAG due to a platform error. | {{ yandex-cloud }} |
| The DAG processor fails to parse a DAG due to a syntax error in the DAG file. | Customer |
| The scheduler fails to run tasks due to an incorrect `schedule_interval` or `start_date`. | Customer |
| KEDA fails to scale workers due to a platform error. | {{ yandex-cloud }} |
| An error occurred during a cluster operation, such as creation or scaling via the API. | {{ yandex-cloud }} |
| Error connecting to an external database from an {{ AF }} task. | Customer |
| A DAG file was not uploaded to the target {{ objstorage-full-name }} bucket. | Customer |
| The native integration with {{ lockbox-full-name }} malfunctions. | {{ yandex-cloud }} |
| A custom Python library is incompatible with the current {{ AF }} or Python version. | Customer |
| A custom Python library breaks following a cluster {{ AF }} or Python version upgrade. | Customer |
| Metadata database backup fails at the platform level. | {{ yandex-cloud }} |
| {{ GL }} is unavailable. | Customer |
| The {{ GL }} connection fails due to a {{ maf-full-name }} platform error. | {{ yandex-cloud }} |

## Requesting support {#support}

{{ yandex-cloud }} support only addresses issues that fall within the {{ yandex-cloud }} scope of responsibility.

If your issue falls within the customer's zone of control, our support team cannot full investigation or resolution. Such issues include debugging DAGs, optimizing tasks, configuring connections, analyzing custom logs, ensuring compatibility of Python libraries, configuring {{ GL }} CI/CD pipelines, and handling other operational tasks.

{% note info %}

If a customer lacks the expertise to independently perform actions within their control, they can contact their account manager. Your account manager will provide options for engaging certified partners or professional {{ yandex-cloud }} services.

{% endnote %}
