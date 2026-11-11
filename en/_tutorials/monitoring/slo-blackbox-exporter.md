# Web service SLO monitoring in {{ monium-name }}

SLO monitoring helps evaluating service reliability against a target level instead of solving faults individually. In this tutorial, you will set up SLO monitoring for a web service in [{{ monium-name }}]({{ link-monium }}). The web service may run in {{ yandex-cloud }}, another cloud, or on your own infrastructure.

An [SLO](../../monium/slo/index.md#basic-terms) (service level objective) is a target reliability level of a service, such as "99.9% requests have been processed successfully over 30 days". You can set an SLO depending on the service reliability requirements. Based on an SLO, {{ monium-name }} calculates the [error budget](../../monium/slo/index.md#basic-terms), the maximum allowed amount of errors over a period. A special command tracks error budget spending and responds to reliability reduction in advance.

This guide uses monitoring based on [Prometheus](https://prometheus.io/) exporters. You will set up synthetic checks for availability and response time, metric delivery to {{ monium-name }}, two SLOs, and error budget alerts. The guide will be useful for SREs, DevOps engineers, and developers in charge of web service reliability.

To collect and deliver metrics, you will need:

* [node_exporter](https://github.com/prometheus/node_exporter) to collect Linux system metrics. They help you diagnose the server’s state after an SLO alert.
* [blackbox_exporter](https://github.com/prometheus/blackbox_exporter) to run synthetic HTTP, TCP, and ICMP checks. Check metrics are used to calculate availability and response time [SLIs](../../monium/slo/index.md#basic-terms).
* [OpenTelemetry Collector](https://opentelemetry.io/docs/collector/) (OTel Collector) collects metrics from node_exporter and blackbox_exporter and sends them to {{ monium-name }}.

In this guide’s configuration, node_exporter runs on the application server named `app-server`, while blackbox_exporter and OTel Collector, on a separate monitoring server named `monitoring-server`. OTel Collector polls both exporters using Prometheus and sends metrics to {{ monium-name }}. This approach does not require any changes in the application and allows hosting servers in a private network.

{% include [slo-blackbox-exporter-scheme](../../_mermaid/other/monium/slo-blackbox-exporter-scheme.md) %}

{% note info %}

This guide does not describe installation of the web service. We assume that the web service is already deployed and available over the network. The node_exporter utility is installed on the application server, while blackbox_exporter and OTel Collector, on the monitoring server. For a simple configuration, all components can be installed together with the web service, eliminating the need for a separate monitoring server.

{% endnote %}

## Setup steps {#setup-steps}

1. [Get your cloud ready](#before-you-begin).
1. [Set up system metric collection in Linux](#node-exporter).
1. [Install and configure blackbox_exporter](#blackbox-setup).
1. [Set up metric delivery to {{ monium-name }}](#otel-setup).
1. [Configure an SLO for service availability](#slo-availability).
1. [Configure error budget alerts](#slo-alert).
1. [Configure an SLO for service response time](#slo-latency).
1. [Use system metrics for post-alert diagnostics](#diagnostics).

If you no longer need the resources you created, [delete them](#clear-out).

## Get your cloud ready {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The infrastructure support cost includes:

* Fee for using [{{ monium-name }}](../../monium/overview.md) (see [{{ monium-name }} pricing](../../monium/pricing.md)).
* Fee for continuously running [VMs](../../compute/concepts/vm.md) if the web service or monitoring server resides in {{ yandex-cloud }} (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).

### Set up your infrastructure {#deploy-infrastructure}

1. Get your web service ready for SLO monitoring. It can be deployed on any infrastructure. Specify its IP address and domain name in the examples. In this guide, the web service runs on the `app-server` VM with Linux Ubuntu 20.04 and is available at internal IP address `10.128.0.10`.
1. Create the monitoring server in [{{ compute-name }}](../../compute/operations/vm-create/create-linux-vm.md) or another infrastructure. This guide uses a {{ compute-name }} VM named `monitoring-server` with Linux Ubuntu 20.04. On it, you will install blackbox_exporter and OTel Collector to check the web service and deliver metrics to {{ monium-name }}.
1. To configure access for sending data to {{ monium-name }}, create a service account and API key. You can do this in the [{{ monium-name }} UI]({{ link-monium }}): on the left, select **Settings** → **Project settings** → **Configuring telemetry recording** → **OpenTelemetry**.

   * Click the **Create service account** link. Select the `monium.metrics.writer` or `monium.telemetry.writer` role.
   * Click the **Create API key** link. Select the `yc.monium.metrics.write` or `yc.monium.telemetry.write` scope.

   You can also follow the [{#T}](../../iam/operations/sa/create.md) and [{#T}](../../iam/operations/authentication/manage-api-keys.md#create-api-key) guides to create the service account and API key.

1. In case you deploy the web service and monitoring server in {{ yandex-cloud }}, [create a security group](../../vpc/operations/security-group-create.md) for the monitoring server and allow the following in it:
   * Outgoing TCP traffic on port `443` to send metrics to {{ monium-name }} via [OTel Collector](../../monium/collector/opentelemetry.md).
   * Incoming traffic to the web service endpoints for blackbox_exporter checks.


## Set up system metric collection in Linux {#node-exporter}

To diagnose incidents, you need the server state data for the moment the alert was triggered. Install [Prometheus node_exporter](https://github.com/prometheus/node_exporter) on the `app-server` VM. It collects CPU, memory, and disk metrics. Then, configure OTel Collector to send them to {{ monium-name }}.

### Install Prometheus node_exporter {#install-node-exporter}

1. Create a system user for node_exporter:

    ```bash
    sudo useradd --no-create-home --shell /bin/false node_exporter
    ```

1. Download and unpack the node_exporter archive:

    ```bash
    wget https://github.com/prometheus/node_exporter/releases/download/v1.11.1/node_exporter-1.11.1.linux-amd64.tar.gz
    tar zxvf node_exporter-1.11.1.linux-amd64.tar.gz
    ```

1. Install the binary:

    ```bash
    sudo install -m 0755 ./node_exporter-1.11.1.linux-amd64/node_exporter /usr/local/bin/node_exporter
    sudo chown node_exporter:node_exporter /usr/local/bin/node_exporter
    ```

### Create a systemd service for node_exporter {#node-exporter-service}

1. Create a file named `/etc/systemd/system/node_exporter.service`:

    ```ini
    [Unit]
    Description=Prometheus Node Exporter
    Wants=network-online.target
    After=network-online.target

    [Service]
    User=node_exporter
    Group=node_exporter
    Type=simple
    ExecStart=/usr/local/bin/node_exporter --web.listen-address=<server_private_IP_address>:9100
    Restart=on-failure

    [Install]
    WantedBy=multi-user.target
    ```

    Where `<server_private_IP_address>` is the address of `app-server` in the private network. If OTel Collector is running on the same server, specify `127.0.0.1`.
1. Run node_exporter:

    ```bash
    sudo systemctl daemon-reload
    sudo systemctl enable --now node_exporter
    ```

1. Make sure the service status has changed to `active (running)`:

    ```bash
    sudo systemctl status node_exporter
    ```

    Result:

    ```text
    ● node_exporter.service - Prometheus Node Exporter
         Loaded: loaded (/etc/systemd/system/node_exporter.service; enabled; preset: enabled)
         Active: active (running) <...>
    ```

1. Make sure that metrics are available:

    ```bash
    curl http://<server_private_IP_address>:9100/metrics
    ```

Instead of node_exporter, you can use {{ unified-agent-short-name }} on the application server. It collects system metrics and sends them directly to {{ monium-name }}, bypassing OTel Collector. In this case, metric configuration will be stored in different places. For more information, see [Delivering Linux system metrics]({{ link-docs }}/monium/operations/unified-agent/linux_metrics).


## Install and configure blackbox_exporter {#blackbox-setup}

[Blackbox_exporter](https://github.com/prometheus/blackbox_exporter) on the monitoring server runs synthetic HTTP, TCP, and ICMP checks and generates the `probe_success` and `probe_duration_seconds` metrics. You will need these for the availability and response time SLOs.

### Install and configure blackbox_exporter {#install-blackbox}

1. Create a system user:

    ```bash
    sudo useradd --no-create-home --shell /usr/sbin/nologin blackbox_exporter
    ```

1. Download and unpack the archive:

    ```bash
    wget -O /tmp/blackbox_exporter.tar.gz https://github.com/prometheus/blackbox_exporter/releases/download/v0.28.0/blackbox_exporter-0.28.0.linux-amd64.tar.gz
    tar -zxvf /tmp/blackbox_exporter.tar.gz
    sudo install -m 0755 ./blackbox_exporter-0.28.0.linux-amd64/blackbox_exporter /usr/local/bin/blackbox_exporter
    sudo chown blackbox_exporter:blackbox_exporter /usr/local/bin/blackbox_exporter
    ```

1. Create a folder for the configuration:

    ```bash
    sudo mkdir -p /etc/blackbox_exporter
    ```

### Set up blackbox_exporter configuration {#blackbox-config}

1. Create a file named `/etc/blackbox_exporter/blackbox.yml`:

    ```yaml
    modules:
      http_2xx:
        prober: http
        timeout: 5s
        http:
          method: GET
          valid_http_versions: ["HTTP/1.1", "HTTP/2.0"]
          preferred_ip_protocol: "ip4"
          follow_redirects: true
          fail_if_ssl: false
          fail_if_not_ssl: false
          tls_config:
            insecure_skip_verify: false

      http_2xx_tls:
        prober: http
        timeout: 5s
        http:
          method: GET
          follow_redirects: true
          fail_if_not_ssl: true
          preferred_ip_protocol: "ip4"

      tcp_connect:
        prober: tcp
        timeout: 3s

      icmp:
        prober: icmp
        timeout: 2s
    ```

    Where:

    * `http_2xx`: Basic check of HTTP endpoint availability. The check type is HTTP.
    * `http_2xx_tls`: Check that requires TLS, with the `fail_if_not_ssl: true` parameter. The check type is HTTP.
    * `tcp_connect`: TCP port availability check. The check type is TCP.
    * `icmp`: Check that the host is reachable in the network. The check type is ICMP.

1. Set up permissions for the configuration file:

    ```bash
    sudo chown -R blackbox_exporter:blackbox_exporter /etc/blackbox_exporter
    ```

### Create a systemd service for blackbox_exporter {#blackbox-service}

1. Create a file named `/etc/systemd/system/blackbox_exporter.service`:

    ```ini
    [Unit]
    Description=Prometheus Blackbox Exporter
    Wants=network-online.target
    After=network-online.target

    [Service]
    User=blackbox_exporter
    Group=blackbox_exporter
    Type=simple
    ExecStart=/usr/local/bin/blackbox_exporter \
      --config.file=/etc/blackbox_exporter/blackbox.yml \
      --web.listen-address=127.0.0.1:9115
    Restart=on-failure

    [Install]
    WantedBy=multi-user.target
    ```

1. Run blackbox_exporter and add it to the auto start:

    ```bash
    sudo systemctl daemon-reload
    sudo systemctl enable --now blackbox_exporter
    ```

1. Make sure the service status has changed to `active (running)`:

    ```bash
    sudo systemctl status blackbox_exporter
    ```

    Result:

    ```text
    ● blackbox_exporter.service - Prometheus Blackbox Exporter
         Loaded: loaded (/etc/systemd/system/blackbox_exporter.service; enabled; preset: enabled)
         Active: active (running) <...>
    ```

### Test blackbox_exporter {#check-blackbox}

Run tests:

```bash
curl "http://127.0.0.1:9115/probe?target=http://10.128.0.10&module=http_2xx" | grep probe_success
curl "http://127.0.0.1:9115/probe?target=10.128.0.10:80&module=tcp_connect" | grep probe_success
curl "http://127.0.0.1:9115/probe?target=10.128.0.10&module=icmp" | grep probe_success
```

Where `10.128.0.10` is your web service’s IP address.

Result:

```text
probe_success 1
```


## Set up metric delivery to {{ monium-name }} {#otel-setup}

OTel Collector sends metrics collected by blackbox_exporter and node_exporter to {{ monium-name }}.

### Install OTel Collector {#install-otel}

1. [Install OTel Collector](https://opentelemetry.io/docs/collector/install/binary/linux/):

    ```bash
    sudo apt-get update
    sudo apt-get -y install wget
    wget https://github.com/open-telemetry/opentelemetry-collector-releases/releases/download/v0.156.0/otelcol_0.156.0_linux_amd64.deb
    sudo dpkg -i otelcol_0.156.0_linux_amd64.deb
    ```

1. Edit the `/etc/otelcol/otelcol.conf` file:

    ```conf
    MONIUM_PROJECT=folder__<folder_ID>
    MONIUM_API_KEY=<API_key>
    OTELCOL_OPTIONS=--config=/etc/otelcol/config.yaml
    ```

    Where:
    * `MONIUM_PROJECT`: {{ monium-name }} project name, e.g., `folder__b1gg5f45su0k6rjr39s1`.
    * `MONIUM_API_KEY`: API key of the service account with the `monium.telemetry.writer` role.

### Set up OTel Collector configuration {#otel-config}

Create a file named `/etc/otelcol/config.yaml`:

```yaml
receivers:
  prometheus:
    config:
      scrape_configs:
        - job_name: blackbox_http_10_128_0_10
          scrape_interval: 30s
          metrics_path: /probe
          params:
            module: [http_2xx]
          static_configs:
            - targets:
                - http://10.128.0.10
              labels:
                probe_type: http
                target_name: lemp_http
          relabel_configs:
            - source_labels: [__address__]
              target_label: __param_target
            - source_labels: [__param_target]
              target_label: instance
            - target_label: __address__
              replacement: 127.0.0.1:9115

        - job_name: blackbox_tcp_10_128_0_10_80
          scrape_interval: 30s
          metrics_path: /probe
          params:
            module: [tcp_connect]
          static_configs:
            - targets:
                - 10.128.0.10:80
              labels:
                probe_type: tcp
                target_name: lemp_tcp_80
          relabel_configs:
            - source_labels: [__address__]
              target_label: __param_target
            - source_labels: [__param_target]
              target_label: instance
            - target_label: __address__
              replacement: 127.0.0.1:9115

        - job_name: blackbox_icmp_10_128_0_10
          scrape_interval: 30s
          metrics_path: /probe
          params:
            module: [icmp]
          static_configs:
            - targets:
                - 10.128.0.10
              labels:
                probe_type: icmp
                target_name: lemp_icmp
          relabel_configs:
            - source_labels: [__address__]
              target_label: __param_target
            - source_labels: [__param_target]
              target_label: instance
            - target_label: __address__
              replacement: 127.0.0.1:9115

        - job_name: node_exporter_lemp
          scrape_interval: 30s
          static_configs:
            - targets:
                - 10.128.0.10:9100
              labels:
                exporter: node_exporter
                target_name: lemp_node
                host: lemp

processors:
  batch:

exporters:
  otlp/monium:
    endpoint: {{ api-host-monium }}:443
    compression: zstd
    headers:
      Authorization: "Api-Key ${env:MONIUM_API_KEY}"
      x-monium-project: "${env:MONIUM_PROJECT}"
      x-monium-cluster: production
      x-monium-service: lemp

service:
  telemetry:
    logs:
      level: info

  pipelines:
    metrics:
      receivers: [prometheus]
      processors: [batch]
      exporters: [otlp/monium]
```

Where:

* `10.128.0.10`: IP address of your application server. Replace it with the actual one.
* `relabel_configs`: Label overwriting rules making Prometheus poll blackbox_exporter, not the target directly.
* `x-monium-cluster` and `x-monium-service` stand for the `cluster` and `service` labels that {{ monium-name }} assigns to all metrics from this OTel Collector. You will use them to find metrics and build SLOs. The example uses the `production` and `lemp` values (a webstack of Linux, Nginx, MySQL, and PHP). Replace these with the actual ones.

{% note info %}

The `probe_type` label can have the `http`, `tcp`, and `icmp` values. You can use it to conveniently filter metrics in {{ monium-name }} and build separate SLOs for each check type.

{% endnote %}

### Run OTel Collector {#start-otel}

1. Edit the `/etc/systemd/system/multi-user.target.wants/otelcol.service` file:

    ```ini
    [Unit]
    Description=OpenTelemetry Collector
    After=network.target

    [Service]
    EnvironmentFile=/etc/otelcol/otelcol.conf
    ExecStart=/usr/bin/otelcol $OTELCOL_OPTIONS
    ExecReload=/bin/kill -HUP $MAINPID
    KillMode=mixed
    Restart=on-failure
    Type=simple
    User=otel
    Group=otel

    [Install]
    WantedBy=multi-user.target
    ```

1. Run OTel Collector:

    ```bash
    sudo systemctl daemon-reload
    sudo systemctl enable --now otelcol
    sudo systemctl status otelcol
    ```

1. Make sure {{ monium-name }} receives the metrics:

    * Open [{{ monium-name }}]({{ link-monium }}).
    * In the left-hand menu, expand **Overview** and select **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}**.
    * In the search field, specify `service = "lemp"`, which is a value of the `service` label from the `x-monium-service` header in the OTel Collector configuration. If you have set another value, specify it.

    The list will show the `probe_success` and `probe_duration_seconds` metrics as well as node_exporter metrics.

{% include [data-lag](../../_includes/monium/data-lag.md) %}


## Configure an SLO for service availability {#slo-availability}

Blackbox_exporter returns a binary check result: `probe_success` equals `1` if the check succeeded or `0` if it failed. Based on this metric, create an availability SLO:

{% list tabs group=instructions %}

- {{ monium-name }} UI {#console}

  1. On the [{{ monium-name }}]({{ link-monium }}) home page, expand the ![image](../../_assets/console-icons/shield-exclamation.svg) **Alerts and SLOs** section on the left.
  1. Select ![image](../../_assets/console-icons/calculator.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.slo.title }}**.
  1. Click **{{ ui-key.yacloud_monitoring.actions.common.create }}**.
  1. Specify the SLO parameters:
  
      * **Name**, e.g., `SLO HTTP Availability 30d`.
      * **Evaluation window**: `30d`.
      * **Evaluation delay**: `2m`. The value must be greater than the metric collection interval: `2m` is sufficient for `scrape_interval: 30s`.
      * **SLO**: `99.9%`.
      * **Calculation Method**: `Good Events / Total Events`.
  
  1. Under **Good Events**, specify this query:
  
      ```js
      series_sum(
          {project = "folder__<folder_ID>", cluster = "production", service = "lemp", probe_type = "http", name = "probe_success"}
        )
      ```
  
  1. Under **Total Events**, specify this query:
  
      ```js
      series_count(
          {project = "folder__<folder_ID>", cluster = "production", service = "lemp", probe_type = "http", name = "probe_success"}
      )
      ```
  
  1. Click **{{ ui-key.yacloud_monitoring.actions.common.create }}**.

{% endlist %}

The error budget is calculated automatically once the SLO is created.


## Configure error budget alerts {#slo-alert}

Create two **{{ ui-key.yacloud_monitoring.monitoring-alerts.slo-type.error-budget-key-value }}** SLO alerts to monitor the error budget:

* Error budget remaining: Warns when the error budget is at risk of being exhausted.
* Error budget consumption: Shows the actual error budget consumption over a specified time window.

**{{ ui-key.yacloud_monitoring.monitoring-alerts.slo.alert-type.diff }}** checks the difference between the remaining budget at the beginning and end of the evaluation window. **Burn rate** alerts check the ratio of the bad events share to the allowed error share. For more on alert types and general settings, see [this guide on creating an SLO alert](../../monium/operations/alert/create-slo-alert.md).

### Create an alert for error budget remaining {#alert-budget-remaining}

{% list tabs group=instructions %}

- {{ monium-name }} UI {#console}

  1. On the [{{ monium-name }}]({{ link-monium }}) home page, expand the ![image](../../_assets/console-icons/shield-exclamation.svg) **Alerts and SLOs** section on the left.
  1. Select ![image](../../_assets/console-icons/megaphone.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.alerts.title }}**.
  1. Click **{{ ui-key.yacloud_monitoring.homepage.button_alerts-action }}** → **{{ ui-key.yacloud_monitoring.monitoring-alerts.button.create-slo-title }}**.
  1. Specify a name for the alert and select its severity level, e.g., `Critical`.
  1. In the **{{ ui-key.yacloud_monitoring.monitoring-alerts.label.slo-alert-type }}** field, select **{{ ui-key.yacloud_monitoring.monitoring-alerts.slo-type.error-budget-key-value }}**.
  1. Select the SLO you created in the previous step.
  1. In the **{{ ui-key.yacloud_monitoring.monitoring-alerts.slo.alert-type-key-value }}** field, select **{{ ui-key.yacloud_monitoring.monitoring-alerts.slo.alert-type.absolute }}**.
  1. Set the trigger conditions:
  
      * **{{ ui-key.yacloud_monitoring.monitoring-alerts.slo.warn-threshold }}**: `50%`.
      * **{{ ui-key.yacloud_monitoring.monitoring-alerts.slo.alarm-threshold }}**: `20%`.
  
  1. Click **{{ ui-key.yacloud_monitoring.actions.common.create }}**.

{% endlist %}

### Create an alert for error budget consumption {#alert-burn-rate}

{% list tabs group=instructions %}

- {{ monium-name }} UI {#console}

  1. On the [{{ monium-name }}]({{ link-monium }}) home page, expand the ![image](../../_assets/console-icons/shield-exclamation.svg) **Alerts and SLOs** section on the left.
  1. Select ![image](../../_assets/console-icons/megaphone.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.alerts.title }}**.
  1. Click **{{ ui-key.yacloud_monitoring.homepage.button_alerts-action }}** → **{{ ui-key.yacloud_monitoring.monitoring-alerts.button.create-slo-title }}**.
  1. Specify a name for the alert and select its severity level, e.g., `Disaster`.
  1. In the **{{ ui-key.yacloud_monitoring.monitoring-alerts.label.slo-alert-type }}** field, select **{{ ui-key.yacloud_monitoring.monitoring-alerts.slo-type.error-budget-key-value }}**.
  1. Select the SLO you created in the previous step.
  1. In the **{{ ui-key.yacloud_monitoring.monitoring-alerts.slo.alert-type-key-value }}** field, select **{{ ui-key.yacloud_monitoring.monitoring-alerts.slo.alert-type.diff }}**.
  1. Set the trigger conditions:
  
      * **{{ ui-key.yacloud_monitoring.monitoring-alerts.slo.warn-threshold }}**: `1%`.
      * **{{ ui-key.yacloud_monitoring.monitoring-alerts.slo.alarm-threshold }}**: `2%`.
      * **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.evaluation-window-key-value }}**: `1h`.
  
  1. Click **{{ ui-key.yacloud_monitoring.actions.common.create }}**.

{% endlist %}


## Configure an SLO for service response time {#slo-latency}

Blackbox_exporter uses the `probe_duration_seconds` metric to measure the time spent on synthetic checks. Create an SLO based on it: 99% of HTTP checks must be completed within 300 ms or less.

{% note info %}

If you need an SLO in the "p95 < 300 ms" format, use the application, ingress controller and load balancer metrics. Blackbox_exporter checks the service from the outside and shows degradations in the DNS, TLS, network, and load balancers.

{% endnote %}

The `probe_duration_seconds` metric shows the total check time, but does not specify what causes the delay. Blackbox_exporter breaks the check down into the following phases:

| **Metric**                            | **What is measured**               |
|----------------------------------------|--------------------------------|
| `probe_dns_lookup_time_seconds`        | DNS resolution time           |
| `probe_tcp_connect_duration_seconds`   | Time to establish TCP connection |
| `probe_tls_handshake_duration_seconds` | TLS handshake time          |
| `probe_http_duration_seconds`          | Time of HTTP request phases         |
| `probe_duration_seconds`               | Total check time       |

For visualization, add the phase metrics on your dashboard as a stacked chart. Build the SLOs and alerts based on the total `probe_duration_seconds` metric. In case of delay degradation, charts will show on which stage the problem has occured: DNS, TLS, or network route.

### Create a response time SLO {#create-slo-latency}

{% list tabs group=instructions %}

- {{ monium-name }} UI {#console}

  1. On the [{{ monium-name }}]({{ link-monium }}) home page, expand the ![image](../../_assets/console-icons/shield-exclamation.svg) **Alerts and SLOs** section on the left.
  1. Select ![image](../../_assets/console-icons/calculator.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.slo.title }}**.
  1. Click **{{ ui-key.yacloud_monitoring.actions.common.create }}**.
  1. Specify the SLO parameters:
  
      * **Name**, e.g., `SLO LATENCY HTTP 30d`.
      * **Evaluation window**: `30d`.
      * **SLO**: `99%`.
      * **Calculation Method**: `Good Events / Total Events`.
  
  1. Under **Good Events**, specify this query:
  
      ```js
      series_sum(
        heaviside(
          ({project="folder__<folder_ID>", cluster="production", service="lemp", probe_type="http", name="probe_duration_seconds"} * -1) + 0.3
        )
      )
      ```
  
      Where:
  
      * `0.3`: Delay threshold in seconds, 300 ms.
      * `heaviside()`: Function that selects threshold checks. Returns `1` if the delay is less than 300 ms or `0` if greater.
  
      Checks with exactly the 300 ms delay are counted as a half event, which does not actually affect the SLI calculation.
  
  1. Under **Total Events**, specify this query:
  
      ```js
      series_sum(
        {project="folder__<folder_ID>", cluster="production", service="lemp", probe_type="http", name="probe_duration_seconds"} * 0 + 1
      )
      ```
  
  1. Click **{{ ui-key.yacloud_monitoring.actions.common.create }}**.

{% endlist %}

## Use system metrics for diagnostics after an alert {#diagnostics}

Once an SLO alert is triggered, you need to understand what failure has happened on the server. Node_exporter system metrics can help you quickly find the cause:

| **Category**            | **Metrics**                                                                                                 | **What to check**                         |
|----------------------|---------------------------------------------------------------------------------------------------------|------------------------------------------|
| **CPU**              | `node_cpu_seconds_total` in the context of `iowait`, `idle`, and `steal` modes                                    | `steal` is especially important for virtualization  |
| **Memory**           | `node_memory_MemAvailable_bytes`                                                                        | Memory available for use       |
| **Disk**             | `node_disk_read_time_seconds_total`, `node_disk_write_time_seconds_total`, `node_disk_io_time_weighted_seconds_total` | Read/write delays, I/O queue |
| **File systems** | `node_filesystem_free_bytes`, `node_filesystem_files_free`                                              | Free space and inodes                 |
| **Network**             | `node_network_receive_bytes_total`, `node_network_transmit_bytes_total`, `node_network_receive_drop_total` | Traffic and drops by interfaces         |

If an SLO alert has been triggered by `probe_duration_seconds`, first of all, check network phases: `probe_dns_lookup_time_seconds` and `probe_tls_handshake_duration_seconds`. Then go to server metrics: `node_disk_io_time_weighted_seconds_total` and `node_cpu_seconds_total{mode="iowait"}`.


## Delete the resources you created {#clear-out}

To stop paying for the resources you created:
1. [Delete the alerts you created in {{ monium-name }}](../../monium/operations/alert/delete-alert.md).
1. [Delete the {{ compute-name }} VMs](../../compute/operations/vm-control/vm-delete.md).
1. [Delete the {{ iam-name }} service account](../../iam/operations/sa/delete.md).
1. [Delete the {{ vpc-name }} security group](../../vpc/operations/security-group-delete.md).

If you reserved public static IP addresses, [delete them](../../vpc/operations/address-delete.md).
