# Overview

The {{ monitoring-full-name }} service lets you collect and store metrics and display them as charts on
dashboards.

{{ monitoring-full-name }} automatically collects data on the status of your Yandex.Cloud resources
and displays it on service dashboards. You can use the API to write custom metrics.

Use {{ monitoring-full-name }} to:

- Track the status of your Yandex.Cloud services on service dashboards. This lets you monitor the current resource load and plan to increase quotas.
- Write your own metrics using the API. You can put your application metrics and Yandex.Cloud resource metrics on a single dashboard.
- Read resource metrics and custom metrics using the API.
- Create dashboards and charts to display metrics in a way that's convenient for you.

## How the service works {#how-it-works}

The {{ monitoring-full-name }} service collects and stores metrics as [time series](https://en.wikipedia.org/wiki/Time_series).
The service uses labels to identify and describe the time series characteristics. Labels indicate the resource that the metric belongs to, describe the meaning of metric, and so forth. For more information, see [#T](data-model.md).

{{ monitoring-full-name }} displays metrics on charts. You can place a large number of interrelated charts on dashboards. Charts and dashboards are available in the file navigation panel. For more information, see [#T](visualization/index.md).

