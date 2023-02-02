---
title: "Viewing the execution log in {{ serverless-containers-full-name }}"
description: "You can view monitoring charts in {{ serverless-containers-full-name }} using the management console. To do this, select {{ serverless-containers-name }} and click the container whose execution log you want to view. In the window that opens, go to Logs and specify the time period. The default time period is 1 hour. Container runtime logs are stored for 14 days. Time in the log is shown in UTC."
---

# Viewing the execution log in {{ serverless-containers-name }}

Container runtime logs are stored for 14 days. The log uses [UTC](https://en.wikipedia.org/wiki/Coordinated_Universal_Time) time.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select **{{ serverless-containers-name }}**.
   1. Click on a container to view its runtime log.
   1. Go to the **Logs** tab and specify the period for which you wish to view logs. The default time period is 1 hour.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   {% include [timeslot](../../_includes/functions/timeslot.md) %}

   {% include [serverless-containers-list-note](../../_includes/serverless-containers/container-list-note.md) %}

   View the container runtime log:

   ```
   yc logging read --resource-ids=<container_ID>
   ```
   Result:
   ```
   	2021-12-07 10:39:03  INFO START RequestID: 24ad08bd-10f7-4e76-9f08-b2b14b04495b
   	2021-12-07 10:39:03       Hi, I'm inside
   	2021-12-07 10:39:03       runtime pid 76: exited with 0
   	...
   	2021-12-07 10:42:04  INFO END RequestID: 24ad08bd-10f7-4e76-9f08-b2b14b04495b
   ```

{% endlist %}

Learn more about working with logs in the [{{ cloud-logging-full-name }} documentation](../../logging/).