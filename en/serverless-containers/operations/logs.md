---
title: Viewing the execution log in {{ serverless-containers-full-name }}
description: You can view monitoring charts in {{ serverless-containers-full-name }} using the management console. To do this, navigate to {{ serverless-containers-name }} and click the container whose execution log you want to view. In the window that opens, go to Logs and specify the time period. The default time period is one hour. All times in the log are UTC.
---

# Viewing container logs

All times in the log are [UTC](https://en.wikipedia.org/wiki/Coordinated_Universal_Time).

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) with your container.
    1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
    1. Click the container to view its execution log.
    1. Navigate to the **{{ ui-key.yacloud.common.logs }}** tab and specify the period for which you want to view logs. The default period is one hour.
    
- CLI {#cli}
    
    {% include [cli-install](../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../_includes/default-catalogue.md) %} 

    {% include [timeslot](../../_includes/functions/timeslot.md) %}
   
    {% include [serverless-containers-list-note](../../_includes/serverless-containers/container-list-note.md) %}

    View the container execution log:

    ```bash
    yc logging read --resource-ids=<container_ID>
    ```
    Result:
    ```text
	2021-12-07 10:39:03  INFO START RequestID: 24ad08bd-10f7-4e76-9f08-b2b1********
	2021-12-07 10:39:03       Hi, I'm inside
	2021-12-07 10:39:03       runtime pid 76: exited with 0
	...
	2021-12-07 10:42:04  INFO END RequestID: 24ad08bd-10f7-4e76-9f08-b2b1********
    ```

{% endlist %}

To learn more about working with logs, see [this {{ cloud-logging-full-name }} article](../../logging/).