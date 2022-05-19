# Overview

{{ monitoring-name }} lets you collect and store metrics and display them as charts on dashboards.

{{ monitoring-name }} automatically collects data on the status of your resources in {{ yandex-cloud }} and displays them on service dashboards. You can use the API to upload custom metrics.

Use {{ monitoring-name }} to:
* Track the status of your services in {{ yandex-cloud }} on service dashboards. This lets you monitor the current load on resources and plan an increase in [quotas]({{ link-console-quotas }}).
* Upload your own metrics using the API. You can place the metrics of your application and the metrics of {{ yandex-cloud }} resources it uses on a single dashboard.
* Download resource metrics and custom metrics using the API.
* Create dashboards and charts to display metrics in a way that's convenient for you.

## How the service works {#how-it-works}

The {{ monitoring-name }} service collects and stores metrics as [time series]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/Временной_ряд){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/Time_series){% endif %}. The service uses labels to identify and describe the time series characteristics. They indicate whether a metric belongs to the service, describe the meaning of metrics, and so on. For more information, see [{#T}](data-model.md).

{{ monitoring-name }} displays metrics on charts. You can place a large number of interrelated charts on dashboards. For more information, see [{#T}](visualization/index.md).