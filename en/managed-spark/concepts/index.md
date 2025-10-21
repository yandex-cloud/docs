---
title: Resource relationships in {{ msp-full-name }}
description: '{{ msp-full-name }} is a managed service for deploying {{ SPRK }} clusters and running Spark/PySpark jobs in the {{ yandex-cloud }} infrastructure.'
---

# Resource relationships in {{ msp-full-name }}

{{ msp-full-name }} is a managed service for deploying {{ SPRK }} clusters and running Spark/PySpark jobs in the {{ yandex-cloud }} infrastructure.

{{ msp-full-name }} enables you to:
* Deploy clusters and manage them via the management console, {{ TF }}, and API, without the need to administer clusters and VMs manually. 
* Configure separate independent host pools for drivers and executors.
* Run jobs in Python, Scala, and Java while flexibly managing their settings.
* Define job dependencies in a declarative way, including pip, .deb, and Maven packages.
* Track job progress in the Spark app web interface and analyze results using logs in {{ cloud-logging-full-name }} and [Spark History Server](https://spark.apache.org/docs/latest/monitoring.html).
* Export job results to {{ objstorage-name }}, databases, and analytical data marts.
* Integrate with {{ metastore-full-name }} in the cluster configuration or in the job parameters.
* Set the preferred time and day of week for cluster maintenance.

## Concepts and entities {#concepts}

The main entity {{ msp-full-name }} operates is an _{{ SPRK }} cluster_.

Running a job in a cluster creates a Spark application. This applications includes the following processes:
* Driver: This is the coordinator process that creates the job plan, breaks the work down into stages and issues, tracks the order of tasks, and sends requests to create executors and releases them.
* Executors: These are processes handling individual tasks within a job.

### Host pools {#pools}

An {{ SPRK }} cluster consists of three host groups (pools):

* Driver host pool to run drivers and some service components (networking, logging, metrics, etc.).

* Executor host pool to run executors and some service components.

* Auxiliary pool to run Spark History Server and other system components.

You can configure the host pools for drivers and executors by specifying the number of hosts in each pool and [their class](instance-types.md). Number of hosts in each of the two pools can be either fixed or autoscalable. The pools are configured when you [create](../operations/cluster-create.md) or [update](../operations/cluster-update.md) an {{ SPRK }} cluster. 

## Job {#job}

A job is a specification for running a Spark application on the selected {{ SPRK }} cluster.

A job includes:
* Target {{ SPRK }} cluster.

  {% note info %}

  Some [cluster configuration](#cluster-configuration) elements set the default job parameters which can be overriden at the job level. You cannot override the following: network settings, service account, Deb-packages, use of Spark History Server, and logging settings.

  {% endnote %}

* Job type: `Spark` for Java and Scala or `PySpark` for Python.
* Executable module and entry point: JAR file or main class for a `Spark` job or a PY file for a `PySpark` job.
* Arguments for running the job.
* Spark properties: Job run resources, dynamic allocation and parallelism parameters, SQL parameters, etc.
* Libraries and files: JAR files, Maven packages, additional files and archives.

## Parallelism and autoscaling {#parallel}

One driver host may simultaneously run one or multiple jobs. The exact number depends on the following:
* [Driver host](instance-types.md) class, i.e., memory size and number of cores per host.
* Resources requested by each [job](#job).
* Host resources reserved for internal needs.

The number of driver hosts can be:
* Fixed, if autoscaling is disabled for driver hosts.
* Autoscalable, i.e., changing dynamically depending on the number of available cores and memory size, if autoscaling is enabled for driver hosts.

Overall, the number of jobs a {{ SPRK }} cluster can run simultaneously depends on the following factors:
* Specified number of driver hosts or autoscaling settings.
* Host class.
* Parameters of each job.
* Amount of resources reserved for internal needs.
