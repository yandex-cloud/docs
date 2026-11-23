---
title: Managing pipelines in {{ datalens-platform-full-name }}
description: Create an {{ AF }} cluster, add pipelines, configure their runs, and view the results in {{ datalens-platform-full-name }}.
---

# Managing pipelines

Under ![image](../../../../_assets/router.svg) **Orchestrator**, you can manage [DAG](../../concepts/airflow/index.md#tasks-and-dependencies) runs in {{ AF }}: start data processing manually or on a schedule, backfill, and troubleshoot errors.

* [{#T}](#before-you-begin)
* [{#T}](#create-cluster)


* [{#T}](#service-account-access)
* [{#T}](#add-pipeline)
* [{#T}](#view-pipelines)
* [{#T}](#activate-pipeline)
* [{#T}](#run-pipeline)
* [{#T}](#backfill)
* [{#T}](#view-runs)
* [{#T}](#view-logs)
* [{#T}](#manage-runs)
* [{#T}](#view-code)
* [{#T}](#dag-import-errors)
* [{#T}](#cluster-health)

## Getting started {#before-you-begin}

Set up the following:

* [{{ datalens-platform-short-name }} environment](../clusters/manage-environment.md).
* Git repository with your DAG files and an SSH key to access it.
* [Collection](../../../workbooks-collections/collections-operations.md#create-collections) to host the {{ AF }} cluster. Make sure you have the required permissions to create objects in the collection.

To work with an existing cluster, [obtain the required permissions](../../security/roles.md#object-roles) for the cluster or the collection where it resides. If you see an access denied message, contact your administrator.

<!-- TODO: Determine the minimum role required to run a pipeline and change its state. -->


Before running pipelines, [make sure the cluster’s service account has the required access permissions](#service-account-access) the data and computing resources they use.

## Creating an {{ AF }} cluster {#create-cluster}

If you already have a cluster, proceed to [adding a pipeline](#add-pipeline).

To create a cluster:

1. In the left-hand panel, select ![image](../../../../_assets/router.svg) **Orchestrator** and click **Enable Airflow**.
1. Under **General settings**, specify the Git repository settings:

   * **Repository address**: SSH connection address.
   * **Path to files directory**: Path to the directory containing DAG files in the Git repository.
   * **Branch**: Branch to fetch DAG files from.
   * **SSH key**: Private key content. The matching public key must grant read access to the Git repository.


1. In the **Environment field**, select the environment already set up or [create a new one](../clusters/manage-environment.md#create-environment).

   Make sure your {{ AF }} cluster and the platform objects used by its pipelines reside in the same cloud and environment.

1. If your DAGs require additional Python dependencies, specify them in the **Pip packages** field under **Other settings**. List each dependency on a separate line either as a package name alone or as a package name followed by `==` and the exact version. You can specify additional package components, such as follows:

   ```text
   numpy
   requests[security,socks]
   ```

1. Click **Create cluster**.
1. In the **Select collection** window, select where to locate the new cluster and click **Create cluster**.
1. Wait for the operation to complete. After the cluster is created, you will see a list of pipelines.

{{ AF }} and Python versions are set by {{ datalens-platform-short-name }}.


## Service account access {#service-account-access}

The service account is created automatically with the cluster and used by all its pipelines. If a pipeline accesses {{ datalens-platform-short-name }} objects, the service account needs access permissions for those objects. For example, running a saved SQL query requires permissions to access the script, connection, data, and computing resources used in the {{ TR }} cluster. {{ SPRK }} jobs require access permissions for data and computing resources in the associated cluster. User permissions for managing pipelines do not replace the service account’s permissions.

To find the cluster’s service account and request access:

1. In the left-hand panel, select ![image](../../../../_assets/router.svg) **Orchestrator**.
1. At the top of the page, locate the **Service account** card. It specifies the ID of the account used to run pipeline tasks.
1. In the card, click ![image](../../../../_assets/console-icons/ellipsis.svg) and select **Request access**.

Learn more about configuring object access permissions [here](../../security/manage-access.md#set-access).

## Adding a pipeline {#add-pipeline}

A pipeline is defined in a DAG file, which specifies the tasks, dependencies between them, and the schedule. {{ AF }} fetches DAG files from the Git repository connected to the cluster.

To add a pipeline:

1. Create a DAG file describing the data processing workflow.
1. Add the file to the Git repository directory specified when creating the cluster. Use the branch selected for the cluster.
1. Push your changes to the Git repository and wait for synchronization with the cluster.
1. In {{ datalens-platform-short-name }}, open the ![image](../../../../_assets/router.svg) **Orchestrator** section and find the pipeline you added in the **Pipelines** tab.

If the pipeline is missing, check for [DAG file import errors](#dag-import-errors).


## Viewing a list of pipelines {#view-pipelines}

To open a list of pipelines, select ![image](../../../../_assets/router.svg) **Orchestrator** in the left-hand panel. The top of the page displays the following cards:

* {{ AF }} cluster: Cluster name, {{ AF }} version, and status, such as **Running**.
* **Service account**: ID of the account used to run pipeline tasks. The card menu provides the **Request access** option.
* **Git repository**: URL of the connected repository and branch name for the DAG files.

The page displays the following tabs:

* **Pipelines**: List of imported DAGs.
* **Pipeline runs**: Execution history for all pipelines.
* **Task runs**: Execution history for individual tasks.

To find a pipeline, enter its name in the **Search by name** field on the **Pipelines** tab. Select **Active** or **Stopped** to filter pipelines by status. To clear the status filter, select **All**. Additional filtering options include **Last run** and **Filter by tag**.

To quickly access recently opened or favorite pipelines, use **Recent** and **Favorites**. To add a pipeline to your favorites, click ![image](../../../../_assets/console-icons/star.svg) to the left of its name.

The table shows each pipeline’s name, status, description, schedule, and next and last runs. In the **Last run** column, you can check the execution result and open a specific run by clicking the date link. To customize the table columns, click ![image](../../../../_assets/console-icons/gear.svg) to the right of the column headers.

To open a pipeline, click its name. At the top of the pipeline page, you will see its schedule, last and next runs, tags, and latest version.

## Enabling and disabling a pipeline {#activate-pipeline}

To enable a pipeline:

1. In the left-hand panel, select ![image](../../../../_assets/router.svg) **Orchestrator** and go to the **Pipelines** tab.
1. Find the pipeline and turn on the toggle next to it.

{{ AF }} will create pipeline runs based on the schedule defined in the DAG file. To change the schedule, update the file in the cluster’s DAG file storage and wait for synchronization to complete.

To disable a pipeline, turn off the relevant toggle in the list or open the pipeline page and click **Disable** in the top-right corner. This disables future scheduled runs without interrupting tasks that are already running.

To enable the pipeline, turn on the toggle. Depending on the `catchup` parameter in the DAG file, enabling the pipeline may trigger runs for missed periods. Learn more about `catchup` in [this {{ AF }} guide](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dag-run.html#catchup).

## Running a pipeline manually {#run-pipeline}

To run a pipeline manually:

1. In the left-hand panel, select ![image](../../../../_assets/router.svg) **Orchestrator**, go to the **Pipelines** tab, and find the pipeline.
1. If the pipeline is disabled, [enable it](#activate-pipeline).
1. Open the pipeline, go to the **Runs** tab, and click **Manual run**.
1. In the **Run type** field, select **Manual run**.
1. Specify the **Logical run date**. It is used in the DAG context and may differ from the actual execution time. This field does not schedule the pipeline to run at a later time.
1. If the pipeline accepts parameters, provide them in the **JSON configuration** field. The available parameters are determined by the DAG code.
1. Click **Execute**.
1. Navigate to the **Runs** tab, locate the run you created, and check its status.

Learn more about the logical date and providing parameter in [this {{ AF }} guide](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dag-run.html).

## Backfill {#backfill}

Backfill creates pipeline runs for the selected period based on the schedule specified in the DAG file. Use it to process missing data or rerun processing for past dates. Backfill requires DAGs to have a time-based schedule.

To create a backfill:

1. In the left-hand panel, select ![image](../../../../_assets/router.svg) **Orchestrator**, go to the **Pipelines** tab, and find the pipeline.
1. If the pipeline is disabled, [enable it](#activate-pipeline).
1. Open the pipeline, go to the **Runs** tab, and click **Manual run**.
1. In the **Run type** field, select **Backfill**.
1. In the **Period** field, specify the start and end dates.
1. In the **Which runs to create** field, select a reprocess behavior:

   * **Missing**: Create only missing runs.
   * **Missing and errored**: Create missing runs and retry errored runs.
   * **All**: Create missing runs and rerun all completed runs, including successful ones.

1. In the **Max active runs** field, set the maximum number of concurrent backfill runs.
1. Optionally, enable the following:

   * **Run backwards**: To process later dates first.
   * **Run with the latest package version**: To use the latest version of the code.

1. Click **Run**.
1. To check the backfill you created, open the **Backfills** tab on the pipeline page. You can also view individual runs on the **Runs** tab by selecting **Run type** → **Backfill** in the filters.

If a run for the selected logical date is already in progress or queued, no new run is created for that date. For more on backfill, see [this {{ AF }} guide](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/backfill.html).

## Viewing runs and tasks {#view-runs}

To check the pipeline’s execution:

1. In the left-hand panel, select ![image](../../../../_assets/router.svg) **Orchestrator**, go to the **Pipelines** tab, and find the pipeline.
1. Open the pipeline and navigate to the **Runs** tab.
1. Select a period. Optionally, use search and the **Status** and **Run type** filters.
1. Select the run row in the table. The graph on the right shows the tasks and their statuses for the selected run. You can also select the run from the list above the graph.
1. To open the run details, click the run ID in the table on the left.

The run page shows the run’s status, type, execution time, duration, logical date, and version, as well as a list of tasks. To investigate a task error, open the relevant task from the list. For details on how to view logs, see [Viewing logs and XCom](#view-logs).

To view the pipeline structure, navigate to the **Tasks** tab. The table lists task names, trigger rules, maximum number of retry attempts, and operators. Select a task in the table to highlight it in the graph. Task groups are shown as separate blocks.

To view run history across all pipelines, return to ![image](../../../../_assets/router.svg) **Orchestrator** and open the **Pipeline runs** or **Task runs** tab.

## Viewing logs and XCom {#view-logs}

To investigate why a task failed:

1. Open the [pipeline run page](#view-runs).
1. In the task list, select the task and open its page.
1. On the **Logs** tab, select an execution attempt if the task ran multiple times.
1. Optionally, filter messages by level and source using the **All levels** and **All sources** dropdowns.
1. Review the error messages. To customize the log display, click **Log settings**.

To save the logs to a file, click ![image](../../../../_assets/console-icons/arrow-down-to-line.svg) **Download logs**.

The **XCom** tab displays the values the task shared through {{ AF }} XCom. Learn more about XCom in [this {{ AF }} guide](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/xcoms.html).

## Managing runs {#manage-runs}

To view the available actions for existing runs, select ![image](../../../../_assets/router.svg) **Orchestrator** in the left-hand panel, navigate to the **Pipeline runs** tab, and click ![image](../../../../_assets/console-icons/ellipsis.svg) in the row with the run in question.

### Rerunning {#rerun}

To rerun a pipeline execution:

1. Find the run and select **Rerun** from its menu.
1. Confirm the action in the dialog that opens.

This will reset the run’s task states and rerun the tasks.

### Changing a status {#change-run-status}

To change a run status manually:

1. Find the run and select **Change status** from its menu.
1. Under **New status**, select **Success** or **Failed**.
1. Optionally, enter a comment in the **Comment** field.
1. Click **Change status**.

{% note info %}

Manually changing the status does not process any data or resolve the cause of the failure.

{% endnote %}

### Deleting a run {#delete-run}

{% note warning %}

Deleting a run permanently removes it and its associated data from {{ AF }}.

{% endnote %}

To delete a run:

1. Find the run and select **Delete** from its menu.
1. In the window that opens, confirm the deletion.

## Viewing pipeline code and parameters {#view-code}

To view a DAG file, open the pipeline and go to the **Code** tab. To change the processing logic, set of tasks or schedule, update the file in the [cluster’s DAG file storage](#add-pipeline) and wait for synchronization to complete.

To view the pipeline’s parameters and execution statistics, go to the **Details** tab.

## DAG file import errors {#dag-import-errors}

If a DAG file contains an error or lacks a required dependency, the pipeline may not appear in the list. The **DAG file import errors** message is displayed in the ![image](../../../../_assets/router.svg) **Orchestrator** section even if no pipelines have loaded successfully.

To view the errors:

1. Click **Details** in the error message.
1. In the window that opens, find the file using the **Search by file** field.
1. Expand the entry for the file. Check the error timestamp, package name, and stack trace.
1. Fix the code or dependencies and wait for the DAG file to re-import.
1. Make sure the error is gone and the pipeline appears in the list.

## Checking the cluster health {#cluster-health}

To check the {{ AF }} status, click ![image](../../../../_assets/router.svg) **Orchestrator** in the left-hand panel and hover over the status in the cluster card. The tooltip displays the status of these components:

* **Metadata database**
* **Scheduler**
* **Trigger**
* **DAG processor**

If the data fails to load, click **Retry** when the button appears. If the issue persists, provide the details of the unavailable components and the error message to the the administrator.
