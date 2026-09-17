# Web service SLO monitoring in {{ monium-name }}

SLO monitoring helps you evaluate service reliability against a target level instead of responding to isolated incidents. In this tutorial, you will set up SLO monitoring for a web service in [{{ monium-name }}]({{ link-monium }}). The web service can run in {{ yandex-cloud }}, other cloud environments, or on your on-premise infrastructure.

An [SLO](../../monium/slo/index.md#basic-terms) (service level objective) is the target reliability level of your service, e.g., _99.9% of successfully processed requests over a 30-day period_. You define SLOs based on your service reliability requirements. {{ monium-name }} uses SLOs to calculate the [error budget](../../monium/slo/index.md#basic-terms), which represents the maximum allowed error rate over a certain period. This enables your team to track error budget consumption and proactively address reliability drops.

This guide relies on [Prometheus](https://prometheus.io/) exporters to implement monitoring. You will configure synthetic checks for availability and response time, metric delivery to {{ monium-name }}, two SLOs, and error budget alerts. This tutorial is designed for SREs, DevOps engineers, and developers responsible for maintaining web service reliability.

To collect and deliver metrics, you will need the following components:

* [node_exporter](https://github.com/prometheus/node_exporter): Collects Linux system metrics. These metrics help you diagnose server health after an SLO alert.
* [blackbox_exporter](https://github.com/prometheus/blackbox_exporter): Performs synthetic HTTP, TCP, and ICMP checks. The obtained metrics are used to calculate [SLIs](../../monium/slo/index.md#basic-terms) for availability and response time.
* [OpenTelemetry Collector](https://opentelemetry.io/docs/collector/) (OTel Collector): Collects metrics from node_exporter and blackbox_exporter and sends them to {{ monium-name }}.

In this tutorial, node_exporter is configured to run on your application server (`app-server`), while blackbox_exporter and OTel Collector run on a dedicated monitoring server (`monitoring-server`). OTel Collector polls both exporters using Prometheus and sends metrics to {{ monium-name }}. This approach does not require any changes in the application and allows you to host services in a private network.

{% include [slo-blackbox-exporter-scheme](../../_mermaid/other/monium/slo-blackbox-exporter-scheme.md) %}

{% note info %}

This guide does not cover the initial deployment of the web service. It assumes your service is already up, running, and network-accessible. Install node_exporter on the application server, and blackbox_exporter and OTel Collector, on the monitoring server. For a simpler architecture, you can install all components on the same server as your web service, eliminating the need for a separate monitoring server.

{% endnote %}

## Setup steps {#setup-steps}

1. [Get your cloud ready](#before-you-begin).
1. [Set up system metric collection in Linux](#node-exporter).
1. [Install and configure blackbox_exporter](#blackbox-setup).
1. [Set up metric delivery to {{ monium-name }}](#otel-setup).
1. [Configure a service availability SLO](#slo-availability).
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

1. Get your web service ready for SLO monitoring. The service can reside in any infrastructure; simply substitute your actual IP address or domain name in the examples. In this guide, the web service runs on an Ubuntu 20.04 Linux VM named `app-server` and is accessible via the internal IP address `10.128.0.10`.
1. Create a monitoring server in [{{ compute-name }}](../../compute/operations/vm-create/create-linux-vm.md) or another infrastructure. This guide uses an Ubuntu 20.04 Linux {{ compute-name }} VM named `monitoring-server`. You will install blackbox_exporter and OTel Collector on this VM to check the web service and deliver metrics to {{ monium-name }}.
1. To enable data delivery to {{ monium-name }}, create a service account and API key. You can do this in the [{{ monium-name }} UI]({{ link-monium }}): on the left, select **Settings** → **Project settings** → **Configuring telemetry recording** → **OpenTelemetry**.

   * Click the **Create a service account** link. Select the `monium.metrics.writer` or `monium.telemetry.writer` role.
   * Click the **Create an API key** link. Select the `yc.monium.metrics.write` or `yc.monium.telemetry.write` scope.

   Alternatively, use these guides: [{#T}](../../iam/operations/sa/create.md) and [{#T}](../../iam/operations/authentication/manage-api-keys.md#create-api-key).

1. If you are deploying your web service and monitoring server within {{ yandex-cloud }}, [create a security group](../../vpc/operations/security-group-create.md) for the monitoring server and allow:
   * Outgoing TCP traffic on port `443` to send metrics to {{ monium-name }} via [OTel Collector](../../monium/collector/opentelemetry.md).
   * Outgoing traffic to your web service endpoints for blackbox_exporter checks.


## Set up system metric collection in Linux {#node-exporter}

To diagnose incidents, you need data on server state from the exact moment an alert triggers. Install [Prometheus node_exporter](https://github.com/prometheus/node_exporter) on the `app-server` VM. It collects CPU, memory, and disk metrics. Then configure OTel Collector to send these metrics to {{ monium-name }}.

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

Instead of node_exporter, you can use {{ unified-agent-short-name }} on the application server. It collects system metrics and sends them directly to {{ monium-name }}, bypassing OTel Collector. In this setup, your metric configuration will be stored across multiple locations. For more information, see [Delivering Linux system metrics]({{ link-docs }}/monium/operations/unified-agent/linux_metrics).


## Install and configure blackbox_exporter {#blackbox-setup}

[Blackbox_exporter](https://github.com/prometheus/blackbox_exporter) runs on your monitoring server to perform synthetic HTTP, TCP, and ICMP checks. It generates the `probe_success` and `probe_duration_seconds` metrics, which are used in the availability and response time SLOs.

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

### Configure blackbox_exporter {#blackbox-config}

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

    * `http_2xx`: Basic check of HTTP endpoint availability. Check type: HTTP.
    * `http_2xx_tls`: Check with mandatory TLS enforced via `fail_if_not_ssl: true`. Check type: HTTP.
    * `tcp_connect`: TCP port availability check. Check type: TCP.
    * `icmp`: Network reachability check for the host. Check type: ICMP.

1. Set permissions for the configuration file:

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

1. Check that the service status is `active (running)`:

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

Run the following tests:

```bash
curl "http://127.0.0.1:9115/probe?target=http://10.128.0.10&module=http_2xx" | grep probe_success
curl "http://127.0.0.1:9115/probe?target=10.128.0.10:80&module=tcp_connect" | grep probe_success
curl "http://127.0.0.1:9115/probe?target=10.128.0.10&module=icmp" | grep probe_success
```

Where `10.128.0.10` is your web service IP address.

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

### Configure OTel Collector {#otel-config}

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

* `10.128.0.10`: Placeholder IP address of your application server. Replace it with the actual one.
* `relabel_configs`: Label overwriting rules for Prometheus to poll blackbox_exporter instead of the target.
* `x-monium-cluster` and `x-monium-service`: `cluster` and `service` labels that {{ monium-name }} assigns to all metrics from this OTel Collector. You will use these labels to find metrics and define your SLOs. The example uses the `production` and `lemp` values (Linux, Nginx, MySQL, and PHP stack). Replace these to match your environment.

{% note info %}

The `probe_type` label can have the `http`, `tcp`, and `icmp` values. This label allows you to filter metrics in {{ monium-name }} and define separate SLOs for each check type.

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
    * In the search field, specify `service = "lemp"`, which is the `service` label value from the `x-monium-service` header in the OTel Collector configuration. If you have set a different value, specify it instead.

    The list will show the `probe_success` and `probe_duration_seconds` metrics as well as node_exporter metrics.

{% include [data-lag](../../_includes/monium/data-lag.md) %}


## Configure a service availability SLO {#slo-availability}

Blackbox_exporter returns a binary check result: `probe_success` equals `1` for a successful check and `0` for a failure. Use this metric to create an availability SLO:

1. On the [{{ monium-name }}]({{ link-monium }}) home page, expand ![image](../../_assets/console-icons/shield-exclamation.svg) **Alerts and SLOs** in the left menu.
1. Select ![image](../../_assets/console-icons/calculator.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.slo.title }}**.
1. Click **{{ ui-key.yacloud_monitoring.actions.common.create }}**.
1. Specify the SLO parameters:

    * **Name**: For example, `SLO HTTP Availability 30d`.
    * **Evaluation window**: `30d`.
    * **Evaluation delay**: `2m`. This value must be greater than your metric collection interval: for `scrape_interval: 30s`, `2m` is sufficient.
    * **SLO**: `99.9%`.
    * **Calculation Method**: `Good Events / Total Events`.

1. Under **Good Events**, specify the following query:

    ```js
    series_sum(
        {project = "folder__<folder_ID>", cluster = "production", service = "lemp", probe_type = "http", name = "probe_success"}
      )
    ```

1. Under **Total Events**, specify the following query:

    ```js
    series_count(
        {project = "folder__<folder_ID>", cluster = "production", service = "lemp", probe_type = "http", name = "probe_success"}
      )
    ```

1. Click **{{ ui-key.yacloud_monitoring.actions.common.create }}**.

The error budget is calculated automatically once the SLO is created.


## Configure error budget alerts {#slo-alert}

Create alerts to track your error budget consumption:

* Remaining error budget: Indicates that your service reliability is gradually degrading.
* Error budget consumption rate: Indicates spikes in the number of errors.

### Create an alert for remaining error budget {#alert-budget-remaining}

1. On the [{{ monium-name }}]({{ link-monium }}) home page, expand ![image](../../_assets/console-icons/shield-exclamation.svg) **Alerts and SLOs** in the left menu.
1. Select ![image](../../_assets/console-icons/megaphone.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.alerts.title }}**.
1. Click **{{ ui-key.yacloud_monitoring.homepage.button_alerts-action }}** → **SLO**.
1. Specify an alert name and level, e.g., `Critical`: remaining error budget indicates gradual degradation.
1. Select the SLO you created in the previous step.
1. In the **Evaluation method** field, select `Error Budget Remaining`.
1. Set the trigger conditions:

    * **Warning**: `50%`.
    * **Alarm**: `20%`.

1. Click **{{ ui-key.yacloud_monitoring.actions.common.create }}**.

### Create an alert for error budget consumption rate {#alert-burn-rate}

1. On the [{{ monium-name }}]({{ link-monium }}) home page, expand ![image](../../_assets/console-icons/shield-exclamation.svg) **Alerts and SLOs** in the left menu.
1. Select ![image](../../_assets/console-icons/megaphone.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.alerts.title }}**.
1. Click **{{ ui-key.yacloud_monitoring.homepage.button_alerts-action }}** → **SLO**.
1. Specify an alert name and level, e.g., `Disaster`: a high error budget consumption rate indicates an emergency incident.
1. Select the SLO you created in the previous step.
1. In the **Evaluation method** field, select `Error Budget Exhaustion Rate`.
1. Set the trigger conditions:

    * **Warning**: `1%`.
    * **Alarm**: `2%`.
    * **Evaluation window**: `1h`.

1. Click **{{ ui-key.yacloud_monitoring.actions.common.create }}**.


## Configure an SLO for service response time {#slo-latency}

Blackbox_exporter measures the duration of synthetic checks using the `probe_duration_seconds` metric. Use this metric to create an SLO: 99% of HTTP checks must complete in under 300 ms.

{% note info %}

If you need to define an SLO in `p95 < 300 ms` format, use metrics from your application, ingress controller, or load balancer. Blackbox_exporter checks your service externally and shows degradation across DNS, TLS, network, and load balancers.

{% endnote %}

The `probe_duration_seconds` metric shows total check duration but does not isolate where delays occur. Blackbox_exporter breaks down each check into the phases:

| **Metric**                             | **What is measured**            |
|----------------------------------------|--------------------------------|
| `probe_dns_lookup_time_seconds`        | DNS resolution duration          |
| `probe_tcp_connect_duration_seconds`   | Time to establish TCP connection |
| `probe_tls_handshake_duration_seconds` | TLS handshake duration          |
| `probe_http_duration_seconds`          | HTTP request phase duration     |
| `probe_duration_seconds`               | Total check duration       |

To visualize these phases, add these metrics to a dashboard as a stacked area chart. For the SLO and alerts, use the aggregate `probe_duration_seconds` metric. If latency degrades, the charts will pinpoint exactly where the bottleneck occurred: DNS, TLS, or network routing.

### Create a response time SLO {#create-slo-latency}

1. On the [{{ monium-name }}]({{ link-monium }}) home page, expand ![image](../../_assets/console-icons/shield-exclamation.svg) **Alerts and SLOs** in the left menu.
1. Select ![image](../../_assets/console-icons/calculator.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.slo.title }}**.
1. Click **{{ ui-key.yacloud_monitoring.actions.common.create }}**.
1. Specify the SLO parameters:

    * **Name**: For example, `SLO LATENCY HTTP 30d`.
    * **Evaluation window**: `30d`.
    * **SLO**: `99%`.
    * **Calculation Method**: `Good Events / Total Events`.

1. Under **Good Events**, specify the following query:

    ```js
    series_sum(
      heaviside(
        ({project="folder__<folder_ID>", cluster="production", service="lemp", probe_type="http", name="probe_duration_seconds"} * -1) + 0.3
      )
    )
    ```

    Where:

    * `0.3`: Latency threshold in seconds, 300 ms.
    * `heaviside()`: Function that filters checks against the threshold. Returns `1` if latency is less than 300 ms or `0` if it is greater.

    Checks with a latency of exactly 300 ms evaluate to `0.5`, which does not affect the SLI calculation.

1. Under **Total Events**, specify the following query:

    ```js
    series_sum(
      {project="folder__<folder_ID>", cluster="production", service="lemp", probe_type="http", name="probe_duration_seconds"} * 0 + 1
    )
    ```

1. Click **{{ ui-key.yacloud_monitoring.actions.common.create }}**.


## Use system metrics for post-alert diagnostics {#diagnostics}.

When an SLO alert triggers, you must isolate the failure on the server side. Use node_exporter system metrics to quickly identify the root cause:

| **Category**            | **Metrics**                                                                                                 | **What to check**                         |
|----------------------|---------------------------------------------------------------------------------------------------------|------------------------------------------|
| **CPU**              | `node_cpu_seconds_total` grouped by modes, e.g., `iowait`, `idle`, and `steal`                                    | `steal` is especially important for virtualized environments  |
| **Memory**           | `node_memory_MemAvailable_bytes`                                                                        | Available memory       |
| **Disk**             | `node_disk_read_time_seconds_total`, `node_disk_write_time_seconds_total`, `node_disk_io_time_weighted_seconds_total` | Read/write latency, I/O queue |
| **File systems** | `node_filesystem_free_bytes`, `node_filesystem_files_free`                                              | Free space and inodes                 |
| **Network**             | `node_network_receive_bytes_total`, `node_network_transmit_bytes_total`, `node_network_receive_drop_total` | Traffic and drops by interfaces         |

If an SLO alert has been triggered by `probe_duration_seconds`, check network phases first: `probe_dns_lookup_time_seconds` and `probe_tls_handshake_duration_seconds`. Then review server metrics: `node_disk_io_time_weighted_seconds_total` and `node_cpu_seconds_total{mode="iowait"}`.


## Delete the resources you created {#clear-out}

To stop paying for the resources you created:
1. [Delete the alerts you created in {{ monium-name }}](../../monium/operations/alert/delete-alert.md).
1. [Delete the {{ compute-name }} VMs](../../compute/operations/vm-control/vm-delete.md).
1. [Delete the {{ iam-name }} service account](../../iam/operations/sa/delete.md).
1. [Delete the {{ vpc-name }} security group](../../vpc/operations/security-group-delete.md).

If you reserved public static IP addresses, [delete them](../../vpc/operations/address-delete.md).
