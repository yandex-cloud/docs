---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Overview

{{ monitoring-full-name }} lets you collect and store metrics and display them as charts on dashboards.

{{ monitoring-full-name }} automatically collects data on the status of your resources in {{ yandex-cloud }} and displays them on service dashboards. You can use the API to upload custom metrics.

Use {{ monitoring-full-name }} to:

- Track the status of your services in {{ yandex-cloud }} on service dashboards. This lets you monitor the current load on resources and plan an increase in quotas.
- Upload your own metrics using the API. You can place the metrics of your application and the metrics of {{ yandex-cloud }} resources it uses on a single dashboard.
- Download resource metrics and custom metrics using the API.
- Create dashboards and charts to display metrics in a way that's convenient for you.

## How the service works {#how-it-works}

The {{ monitoring-full-name }} service collects and stores metrics as [time series](https://en.wikipedia.org/wiki/Time_series). The service uses labels to identify and describe the time series characteristics. They indicate whether a metric belongs to the service, describe the meaning of metrics, and so on. For more information, see [{#T}](data-model.md).

{{ monitoring-full-name }} displays metrics on charts. You can place a large number of interrelated charts on dashboards. For more information, see [{#T}](visualization/index.md).

