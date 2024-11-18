---
title: '{{ maf-full-name }} release notes'
description: This section contains {{ maf-name }} release notes.
---

# {{ maf-full-name }} release notes

## September 2024 {#sep-2024}

* On July 16, 2024, {{ maf-name }} entered the [General Availability](../overview/concepts/launch-stages.md) stage and is now charged according to the [pricing policy](pricing.md).
* Added the ability to run operations on an {{ AF }} cluster using the [{{ yandex-cloud }} CLI](../cli/cli-ref/managed-services/managed-airflow/index.md), [{{ TF }}](tf-ref.md), and [API](api-ref/authentication.md).

## June 2024 {#jun-2024}

* Now {{ AF }} job logs are stored in {{ objstorage-full-name }}. This addresses the issue of unavailable logs on disabled workers after autoscaling is over.
* In {{ lockbox-full-name }}, you can now store the connections, variables, and configuration data used in DAG files. For more information, see [Storing connections and variables in {{ lockbox-full-name }}](tutorials/lockbox-secrets-in-maf-cluster.md).

## May 2024 {#may-2024}

Now you can assign to a cluster a service account it will use to access other {{ yandex-cloud }} services, e.g., {{ cloud-logging-name }}, {{ monitoring-full-name }}, and {{ lockbox-full-name }}. It also enables the use of the full {{ yandex-cloud }} SDK functionality when writing DAG scripts with no need for additional authorization setup.

## April 2024 {#apr-2024}

* Now you can install deb packages as dependencies when [creating](operations/cluster-create.md) or [updating](operations/cluster-update.md) a cluster.
* Now you will get a clear error text in case of issues when installing pip and deb dependencies. Moreover, if you specified incorrect packages, the update cluster operation will roll back, allowing you to edit the input without contacting support.
* Scripts in DAG files now run faster.
