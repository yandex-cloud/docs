# Zones of control between the {{ dataproc-full-name }} users and {{ yandex-cloud }}

{{ dataproc-full-name }} users should be aware of how responsibilities are shared between [{{ dataproc-full-name }}](#cloud-responsibilities) and the [{{ yandex-cloud }} customer](#customer-responsibilities). Understanding these zones of control makes you an efficient user of cloud resources and helps avoid potential cluster-related issues.

## {{ yandex-cloud }} control zone {#cloud-responsibilities}

* **Hardware and virtualization layer**. Maintaining the health of physical servers (CPU, disks, RAM, and network), VMs, hypervisor, virtual disks, and VM connectivity. This includes ensuring both the declared performance and speed.

* **Recovery from infrastructure failures**. Recovery from infrastructure failures at the {{ yandex-cloud }} level and replacement of failed VMs as a resource.

* **Guest OS version updates**. Maintaining up-to-date versions of the guest OS and kernel.

* **{{ dataproc-name }} images**. Providing and supporting {{ dataproc-name }} images with pre-tested versions of Hadoop, Spark, and ecosystem components. This includes vulnerability patching of new images and regular release of updated images with fixes.

* **Cluster operations**. Ensuring performance of cluster operations described in the [{{ dataproc-name }} documentation](../../data-proc/index.yaml) and available through the [management console](../../console/index.yaml), [API](../../api-design-guide/index.yaml), [CLI](../../cli/index.yaml), or [Terraform](../../terraform/index.yaml). This excludes cases where the customer modifies operation objects directly rather than via {{ dataproc-name }} interfaces, e.g., deletes or changes VMs, networks, and security groups used in {{ dataproc-name }} operations.

* **{{ yandex-cloud }} tools**. Ensuring performance of monitoring, notification, and logging tools provided by {{ yandex-cloud }}. Provision of platform-level metrics and logs, integration with {{ monitoring-full-name }} and {{ cloud-logging-full-name }}.

* **Cluster provisioning and orchestration**. Provisioning and orchestration of {{ dataproc-name }} clusters including pre-installation of Hadoop, Spark, Hive, and other components for the selected image version.

* **Setting up new clusters**. Applying optimal default settings in new clusters to improve cluster stability in {{ yandex-cloud }} as well as data reliability in line with the universal load profile.

* **Cluster setup when upgrading the version**. Applying optimal settings to improve {{ yandex-cloud }} cluster stability and data reliability in line with the universal load profile during version upgrades of Hadoop, Spark and vendor-managed ecosystem components.

* **User documentation**. Maintaining up-to-date documentation for managed solutions. Documentation for Hadoop, Spark and ecosystem components is sourced directly from the relevant Apache projects.

* **API availability**. Ensuring availability of the {{ dataproc-name }} API for running jobs and integration with cloud-based orchestration services.

## {{ yandex-cloud }} customer control zone {#customer-responsibilities}

* **Operations with clusters**. Self-management of clusters through available interfaces, i.e., [management console](../../console/index.yaml), [API](../../api-design-guide/index.yaml), [CLI](../../cli/index.yaml), or [Terraform](../../terraform/index.yaml), and handling cluster operations. This includes selecting availability zones, isolation of projects, defining folder structure, choosing VM and disk types, defining subcluster size and topology, configuring autoscaling policies, and planning for capacity, performance, and cost.

* **Cluster resources**. Maintaining the cluster resources (host class, number of hosts, replicas, and cluster shards) aligned with the cluster user load and the managed solution's service load (collecting and sending metrics, logs, and data for performance diagnostics, cluster maintenance operations, internal health checks).

* **Component configuration**. Self-configuration of Hadoop, Spark, Hive and other components available to the customer in line with the relevant Apache project documentation, while being aware that these settings may affect health, availability, integrity, and speed of data processing.

* **Load analysis**. Analyzing and managing the cluster load profile and responding to monitoring events triggered by excessive load.

* **Spark jobs**. Writing, using, debugging, and optimizing Spark jobs; diagnosing active and inactive jobs; analyzing the result and speed of job execution.

* **Access management**. Managing user account privileges and permissions, their assignment to cluster objects in line with the {{ yandex-cloud }} resource model. This includes controlling who can create and delete clusters, run jobs, and read logs and metrics.

* **Cluster version updates**. Maintaining up-to-date cluster versions to ensure the cluster runs on a supported version within the timelines defined by {{ yandex-cloud }}. This includes pre-upgrade steps such as analysis of the changes and whether the client software is ready for those changes. Planning updates and cluster recreations from new images; testing compatibility of new library versions and user jobs.

* **Operation in deprecated state**. Resolving issues and mitigating risks arising from the continued use of outdated clusters and delayed version upgrades.

* **Cluster service onfiguration**. Configuring cluster services (HDFS, YARN, Spark, and Hive), NameNode and DataNode parameters, YARN queues; setting up the Spark driver and job runner as well as HDFS replication.

* **Job code**. Developing job logic (Spark, MapReduce, and Hive); building artifacts; managing dependencies and containers, if required.

* **Job planning and orchestration**. Planning and orchestration of jobs and SLA pipelines.

* **Fault tolerance**. Designing high-availability clusters and testing failure scenarios.

* **Pipeline orchestration**. Pipeline orchestration and dependency management; {{ lockbox-full-name }} secret policies; code reviews of configurations.

{% note info %}

If a customer lacks the expertise to independently perform actions within their control, they can contact their account manager.

{% endnote %}