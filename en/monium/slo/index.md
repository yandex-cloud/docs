# Overview

_SLO (Service Level Objective)_ is the target service quality level expressed in certain metrics over a period of time. Unlike an SLA, an SLO is an internal objective, not a legal obligation.

## General terms {#basic-terms}

* _SLI (Service Level Indicator)_. Service reliability metric for a particular period of time. It is a periodically calculated indicator that provides insight into the service's reliability status and the viability of the user scenario. For event-based SLOs, it is calculated using this formula: *SLI = Good Events / Total Events \* 100%*. Expressed as a percentage.

* _SLO (Service Level Objective)_. Target value the calculated SLI is referenced against. If the SLI drops below the SLO and remains so for an extended period of time, it is best to put the development of the new functionality on hold and focus of improving overall reliability of the service. Expressed as a percentage.

* _Error Budget_ is the balance of the error budget. Error budget is the number of _Bad Events_ that can happen within a given period of time before the SLI drops bellow the SLO. The figure is calculated using this formula: *Error Budget = (100% - SLI) \* Total Events*. Error budget is expressed as a percentage.

{% note info %}

_SLA (Service Level Agreement)_ is an agreement between the service provider and the consumer establishing the level and quality of the service and the parties' responsibilities in the event of violations. An SLA can be viewed as a legal document based on an SLO. However, an SLA is not a replacement for either an SLO or SLI.

{% endnote %}

{% note warning %}

An SLO is not a replacement for alters that are used to keep an eye on the health metrics of the service.

Alerts can monitor individual metrics for urgent response, making them a tool of choice for duty or development staff.

An SLO, however, is an analytical tool that helps you with managerial decisions and the service's development roadmap based on reliability metrics.

{% endnote %}

## Calculation methods {#calc-methods}

There are several approaches to calculating metrics:

* *Event-based SLO*. The calculation is based on the number of events of a given type taking place in the service. The format is: *99.9% of requests for the last 30 days were processed successfully* or *in 99.95% of cases, the service responds within 100 ms*. The data sources for metric calculation consist of:
    * *Good Events*: Events interpreted as _good_, e.g., *HTTP Code 2xx in response* or *request processed in under 100 ms*.
    * *Bad Events*: Events interpreted as _bad_, e.g., *HTTP Code 5xx in response* or *request processed in over 100 ms*.
    * *Total Events*: Total number of events classified as valid by the service, e.g., *total requests processed by service*. Event validity is determined by the service. For example, *HTTP Code 500 in response* is a valid event: the request URL is correct even though the service failed to process the request due to an internal or data error. At the same time, an event is invalid if the URL is incorrect, as the system cannot map the request to a specific service component.
    
    You can choose one of these SLO calculation methods:
    
    * **Good Events / Total Events**: Good events and general events, e.g., successful service responses and total received requests.
    * **Bad Events / Total Events**: Bad events and general events, e.g., service error responses and total received requests.
    * **Good Events / Bad Events**: Good events and bad events, e.g., successful service responses and service responses with errors.
    
    The system automatically calculates unspecified events for any selected method. For example, if you choose to calculate only good and bad events, the total number of events will be the sum of those two categories.
* *Time-based SLO*: The metric calculation is based on the service's uptime time interval. The format is: *for the last 30 days, 95% of requests over a 1-minute interval were processed successfully* or *for the last 30 days, the service responded within 100 ms over a 1-minute interval for 99.95% of the time*. The uptime criteria are decided by the service itself.
* *Alert-based SLO*. The metric calculation is based on the status of the alerts. The format is: *for the last 30 days, the HHTP 5xx rate alert has been in OK status*. The service decides by itself which alerts to use to calculate the metrics.

{{ monium-name }} uses the **event-based** method.


## Evaluation window {#calc-window}

All service reliability level metrics are calculated for a particular period of time. These are dynamic metrics. You can use them to monitor the service's reliability over time.

Not all services require reliability to be monitored over short time intervals, because maintaining a high level of reliability over short intervals is a fairly difficult task. The reliability level range can be wide for such services.

For example, peak loads during office hours can cause high error rates in the service's responses, yet all metrics may be quite normal during the night or over weekends. A counter example: with a much lower number of incoming requests during the night, even a small number of errors in responses can cause a major SLI plunge. Therefore, it is recommended to use large enough calculation windows to smooth out such deviations.

There are two main methods of selecting the calculation window:

* *Calendar-aligned time window*: The calculation window covers a particular calendar period, e.g., a calendar month. On the upside, the calculation window always exactly coincides with a calendar period. This is also the downside: the calculation window is floating, especially if we are talking about months. With a calendar window, your error budget is reset at the beginning of the new period, yet a major incident at the beginning of the period can wipe your entire error budget forcing you to wait for the next period for it to be restored. And you can draw your conclusions on how reliable the service is only after the period ends.

* *Rolling time window*: The calculation window is expressed as a fixed time interval, e.g., last 30 days. On the upside, we are not tied to the calendar and can always be sure that our metrics are calculated over the same time interval. On the downside, it is more difficult to associate such a calculation window with a specific calendar period, because the error budget is restored each time the metrics are recalculated.

{{ monium-name }} uses the **rolling time window** method.

## General recommendations {#howto}

First, you should decide what metrics to track and what time window to use.
 
Let's cover a few basic metrics we can use to conclude about the service's reliability:

1. **Availability**. Measured based on quantitative metrics of request processing by the service. Events are counted, for example, based on HTTP or gRPC response codes from the service's API. It is equivalent to the Errors signal, one of the four [golden signals][golden-sgnals] from the Google SRE Book.

    {% cut "Example of Good Events metrics" %}
        
    * Metrics based on the number of successful responses from {{ monium-name }} alerting received over the gRPC API:
        ```
        series_sum({project = '<project_name>', cluster = '<cluster_name>', service = 'gateway', host = '<host_name>', sensor = 'grpc.server.call.status', clientId = 'total', endpoint = 'alerting_api_total', code != 'UNKNOWN|INTERNAL|DATA_LOSS|UNAVAILABLE|CANCELLED|DEADLINE_EXCEEDED|UNIMPLEMENTED|RESOURCE_EXHAUSTED'})
        ```
    * Metrics based on the number of successful responses from {{ monium-name }} alerting received over the HTTP API:
        ```
        series_sum({project = '<project_name>', cluster = '<cluster_name>', service = 'gateway', host = '<host_name>', sensor = 'http.server.call.status', client_id = 'total', endpoint = 'alerting_api_total', code != '5??|429'})
        ```
    
    {% endcut %}

    {% cut "Example of Total Events metrics" %}
        
    * Metrics based on the total number of responses from {{ monium-name }} alerting received over the gRPC API:
        ```
        series_sum({project = '<project_name>', cluster = '<cluster_name>', service = 'gateway', host = '<host_name>', sensor = 'grpc.server.call.status', clientId = 'total', endpoint = 'alerting_api_total'})
        ```
    * Metrics based on the total number of responses from {{ monium-name }} alerting received over the HTTP API:
        ```
        series_sum({project = '<project_name>', cluster = '<cluster_name>', service = 'gateway', host = '<host_name>', sensor = 'http.server.call.status', client_id = 'total', endpoint = 'alerting_api_total'})
        ```
    
    {% endcut %}

1. **Latency**. Measured based on quantitative metrics of time it takes the service to process a given operation. It is equivalent to the Latency signal, one of the four [golden signals][golden-sgnals] from the Google SRE Book.

    {% cut "Example of Good Events metrics" %}
        
    * Metric write latency if delivered via the Push API, no more than 2,000 ms:
        ```
        histogram_count(0, 2000, series_sum("bin", {project = "<project_name>", cluster = "<cluster_name>", service = "gateway", host = "<host_name>", sensor = "http.server.call.elapsedTimeMs", endpoint = "/api/v2/push|/monitoring/v2/data/write", client_id = "total"}))
        ```

    {% endcut %}

    {% cut "Example of Total Events metrics" %}
        
    * Total metric write latency if delivered via the Push API:
        ```
        histogram_count(series_sum("bin", {project = "<project_name>", cluster = "<cluster_name>", service = "gateway", host = "<host_name>", sensor = "http.server.call.elapsedTimeMs", endpoint = "/api/v2/push|/monitoring/v2/data/write", client_id = "total"}))
        ```

    {% endcut %}

1. **Saturation**. Measured based on quantitative metrics of resource utilization by the service. It is equivalent to the Saturation signal, one of the four [golden signals][golden-sgnals] from the Google SRE Book.

    {% cut "Example of Good Events metrics" %}
        
    * Thread count metrics for selected deploy stage:
        ```
        {project = "<project_name>", service = "<service_name>", cluster = "<cluster_name>", name = "cpu.thread_count", host = "cluster", deploy.unit = "total", deploy.stage = "monitoring-ui-prod", deploy.box = "total", deploy.workload = "total"}
        ```

    {% endcut %}

    {% cut "Example of Total Events metrics" %}
        
    * Thread count limit metrics for selected deploy stage:
        ```
        {project = "<project_name>", service = "<service_name>", cluster = "<cluster_name>", name = "cpu.thread_limit", host = "<host_name>", deploy.unit = "total", deploy.stage = "monitoring-ui-prod", deploy.box = "total", deploy.workload = "total"}
        ```

    {% endcut %}

We recommend selecting a large enough window, e.g., 30 days, to eliminate the impact of peak loads and drops over short periods to make your metrics less noisy.

When calculating *Total Events*, count only valid events (e.g., requests with correct URLs). Invalid events must not affect the SLI.

{% include [ttl_warning](../../_includes/monium/ttl_warning.md) %}

[golden-sgnals]: https://sre.google/sre-book/monitoring-distributed-systems/#xref_monitoring_golden-signals
