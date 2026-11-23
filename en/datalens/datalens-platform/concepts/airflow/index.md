---
title: Pipelines in {{ datalens-platform-full-name }}
description: 'With pipelines in {{ datalens-platform-full-name }}, you can manage data processing: set dependencies across tasks, run processing manually and on schedule, monitor the results.'
---

# Pipelines in {{ datalens-platform-full-name }}

A _pipeline_ is a description of a data processing flow, i.e., actions to perform, order of these actions, and specific conditions to meet. Pipelines help automate repeat operations, such us checking source data, converting this data, and creating tables for analysis.

In {{ datalens-platform-full-name }}, pipelines are managed by {{ AF }}, a platform for creating, planning, and monitoring workflows. {{ AF }} pipelines are designed for batch data processing. Under ![image](../../../../_assets/router.svg) **Orchestrator**, you can view the structure of processes, run them, monitor their execution, and find causes of errors.

[Data transfers](../data-transfer/index.md) allow uploading data from sources to a REST catalog. With pipelines, you can arrange further processing: join multiple operations into a single process, set dependencies across them, and regularly update resulting tables.

## Tasks and dependencies {#tasks-and-dependencies}

In {{ AF }}, a pipeline is written as a _DAG_ (directed acyclic graph). Its nodes are _tasks_, and links between them set dependencies and the order of execution. A task is a separate operation, e.g., running an SQL query or processing data using {{ SPRK }}.

Dependencies allow coordinating task execution. For example, a data check must be complete before data is converted, and the resulting table may be created after completing all the required conversions. A DAG defines conditions for running tasks. Independent tasks may run in parallel.

For clearer presentation, you can join related tasks in the DAG code into _task groups_. In the UI, groups are shown as separate graph’s sections. Learn more about DAGs in [this {{ AF }} guide](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dags.html).

## Defining and running a pipeline {#definition-and-execution}

Pipelines are defined in _DAG files_ in Python. These files set tasks, dependencies, schedules, and execution parameters. Code is written in an editor or local development environment, and then saved to a Git repository connected to an {{ AF }} cluster. The cluster uploads DAG files from the specified folder in the selected repository branch.

This approach is called _Workflows as code_, i.e., defining workflows as code. It allows storing a pipeline change history in the version control system, check changes, and test code before running it.


To change the processing logic, set of tasks or schedule, update the file in the cluster’s DAG file storage. After syncing, changes become available in {{ AF }}. For more information, see [Adding a pipeline](../../operations/airflow/manage-airflow.md#add-pipeline).

An {{ AF }} cluster manages pipeline execution: it considers schedules and dependencies, runs tasks, and monitors their status. Tasks may access other {{ datalens-platform-short-name }} components, e.g., run SQL queries in a {{ TR }} cluster or run data processing in a {{ SPRK }} cluster. To use pipelines, [{{ AF }} create an {{ AF }} cluster](../../operations/airflow/manage-airflow.md#create-cluster) in your environment.

Make sure your {{ AF }}, {{ TR }}, and {{ SPRK }} clusters as well as REST catalogs used by pipelines reside in the same cloud and environment.

## Running a pipeline {#runs}

A _pipeline run_ is a separate DAG execution. A single pipeline may have many runs, each with its own status and execution time. Within a run, each separate task execution is monitored. If a task runs once more, an attempt history is saved for that task.

You can run pipelines [manually](../../operations/airflow/manage-airflow.md#run-pipeline) or on schedule set in a DAG file. Use manual runs to check a pipeline or process data on request. A schedule allows running processing on a regular basis, e.g., every day.

Use a _backfill_ to process data for past time periods. It creates runs for the selected period according to the DAG’s schedule. A backfill helps recover missing runs or recalculate data after changing the processing logic. For more information, see [Recalculating data for the past time periods](../../operations/airflow/manage-airflow.md#backfill).

A pipeline state determines whether new runs are created on schedule. If a pipeline is disabled, new scheduled runs are not created, while running tasks keep running. Learn more in [Enabling and disabling a pipeline](../../operations/airflow/manage-airflow.md#activate-pipeline).

## Execution monitoring {#monitoring}

In the {{ datalens-platform-short-name }} UI, you can view the run history and task graph. The graph shows task states in the selected run. You can check execution of the entire pipeline or view a separate task.

Task _logs_ are used for detecting error causes. When viewing logs, you can select an execution attempt and filter entries by level and source. DAG file upload errors are shown separately: they can prevent a pipeline from appearing in the list even before its first run. For more information, see these guides: [Viewing runs and tasks](../../operations/airflow/manage-airflow.md#view-runs), [Viewing logs and XCom](../../operations/airflow/manage-airflow.md#view-logs), and [DAG file upload errors](../../operations/airflow/manage-airflow.md#dag-import-errors).

## Accessing pipelines and data {#access}

An {{ AF }} cluster resides in a collection. [Access to the cluster and its collection](../../security/roles.md#object-roles) determines whether a user is allowed to work with pipelines.

When creating a cluster, a _service account_ is created automatically, one for all its pipelines. Tasks access {{ datalens-platform-short-name }} objects on its behalf. This account requires permissions for data and objects in use in the collections, i.e., connections, saved scripts, computing clusters. User permissions for managing pipelines and the service account’s permissions to run tasks are configured separately.

You can find a service account ID in the same-named card on the **Orchestrator** page. From the card menu, you can [go to requesting access](../../operations/airflow/manage-airflow.md#service-account-access).
