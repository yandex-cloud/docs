---
title: "Viewing the execution log in Yandex Serverless Containers"
description: "You can view the monitoring schedule in Yandex Serverless Containersusing the management console. To do this, select the Serverless Containers service, click on the container whose execution log you want to view. In the window that opens, go to the Logs section and specify the period. By default, the period is set in 1 hour. The function execution logs are stored for 14 days. The time in the log is specified in UTC."
---

# Viewing the execution log

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