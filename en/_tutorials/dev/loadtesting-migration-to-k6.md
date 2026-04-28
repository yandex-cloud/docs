# Load testing migration from {{ load-testing-name }} to k6

{% include [loadtesting-sunset-warning](../../_includes/load-testing/sunset-warning.md) %}

{% include [k6-legal-note](../../_includes/load-testing/k6-legal-note.md) %}

As a replacement, we recommend [k6](https://k6.io/), which is an open-source load testing tool by Grafana Labs. k6 supports HTTP, gRPC, WebSocket, etc., easily integrates into CI/CD, and provides flexible tools for result analysis.

Follow this guide to migrate existing load testing scenarios to k6 while preserving the familiar features: load profiles, autostop, monitoring, and regression analysis.

To migrate load testing scenarios to k6:
1. [Study feature equivalency data](#overview).
1. [Set up your environment](#before-begin).
1. [Check the k6 installation](#quick-start).
1. [Set up the infrastructure for load generation](#agents).
1. [Migrate load profiles](#load-profiles).
1. [Migrate test data and scenarios](#test-data).
1. [Set up an autostop](#autostop).
1. [Configure visualization of results](#test-results).
1. [Configure regression analysis](#regression).
1. [Configure monitoring of generator resources](#monitoring).
1. [Configure running in CI/CD](#cicd).

## Feature equivalency between {{ load-testing-name }} and k6 {#overview}

#|
|| **{{ load-testing-name }} feature** | **Equivalent k6 feature** | **Read more** ||
|| **Agent**: Managed VM for load generation
| Any machine with k6 installed: a local computer, cloud-based VM, or CI/CD container
| [Load generation infrastructure](#agents) ||
|| **Load generators**: Pandora, Phantom, JMeter
| Universal built-in k6 generator with HTTP/1.1, HTTP/2, gRPC, and WebSocket support
| [Test data and scenarios](#test-data) ||
|| **Load profile**: `const`, `line`, `step`, `once`
| Scenarios with executors: `constant-arrival-rate`, `ramping-arrival-rate`, `shared-iterations`, etc.
| [Load profiles](#load-profiles) ||
|| **Testing threads**: Parallel connections for RPS generation
| Virtual users (VU): Each one executes a looped scenario; RPS = VU / iteration time
| [Load profiles](#load-profiles) ||
|| **Test data**: URI, HTTP_JSON, and GRPC_JSON formats, files from {{ objstorage-name }}
| Requests are described in a JS script; external data is loaded via `SharedArray`
| [Test data and scenarios](#test-data) ||
|| **Autostop**: Stopping the test based on response time, HTTP codes, quantiles
| Thresholds with `abortOnFail`: Similar stopping criteria
| [Autostop](#autostop) ||
|| **Test results**: Charts for quantiles, response codes, RPS
| Built-in summary in the terminal; visualization via Grafana + InfluxDB/Prometheus
| [Test results](#test-results) ||
|| **Regression dashboard**: Tracking degradation between runs
| Grafana dashboard with run history and threshold alerts
| [Regression analysis](#regression) ||
|| **Agent monitoring**: CPU, memory, disk, network via Telegraf/{{ monitoring-name }}
| Telegraf, node_exporter, and Prometheus or {{ monitoring-name }} for a cloud-based VM
| [Monitoring of generator resources](#monitoring) ||
|| **Management console**: Web interface to configure and run tests
| `k6 run` CLI for running; Grafana for visualization; CI/CD for automation
| [Running in CI/CD](#cicd) ||
|| **Test configuration**: YAML file with generator parameters
| JavaScript file with the `options` object: profiles, thresholds, and scenarios, all in the same place
| [Load profiles](#load-profiles) ||
|#

## Set up your environment {#before-begin}

1. [Install k6](https://grafana.com/docs/k6/latest/set-up/install-k6/) on the machine you plan to run tests from:

   {% list tabs %}

   - Linux

     ```bash
     sudo gpg -k
     sudo gpg --no-default-keyring --keyring /usr/share/keyrings/k6-archive-keyring.gpg \
       --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C5AD17C747E3415A3642D57D77C6C491D6AC1D69
     echo "deb [signed-by=/usr/share/keyrings/k6-archive-keyring.gpg] https://dl.k6.io/deb stable main" \
       | sudo tee /etc/apt/sources.list.d/k6.list
     sudo apt-get update && sudo apt-get install k6
     ```

   - macOS

     ```bash
     brew install k6
     ```

   - Docker

     ```bash
     docker pull grafana/k6
     ```

   {% endlist %}

1. If you want to visualize the results, get a monitoring stack ready, e.g., [Grafana](https://grafana.com/) with [InfluxDB](https://www.influxdata.com/) or [Prometheus](https://prometheus.io/).

## Check the k6 installation {#quick-start}

Make sure k6 is installed and operational. The following command will run a short test: 10 virtual users will be sending GET requests and check the response code for 30 seconds:

```bash
k6 run - << 'EOF'
import http from 'k6/http';
import { sleep, check } from 'k6';

export const options = {
  vus: 10,
  duration: '30s',
};

export default function () {
  const res = http.get('https://test.k6.io/');
  check(res, { 'status 200': (r) => r.status === 200 });
  sleep(1);
}
EOF
```

Once this completes, k6 will show the summary: number of requests, average response time, percentage of successful checks, and other metrics. This is the result format you will work with further on.

To see the full list of commands and flags, run this command:

```bash
k6 --help
```

## Set up the infrastructure for load generation {#agents}

{{ load-testing-name }} used to run tests on managed agents, i.e., VM instances that were created and configured automatically.

In k6, you can run the load generator on any machine: a local computer, cloud-based VM, or CI/CD pipeline container.

If your tests required access to the target application via the {{ yandex-cloud }} internal network, create a VM instance in the relevant subnet and run k6 on it.

Here are approximate recommendations on resources for the load generator (for simple HTTP scenarios without heavy processing of responses):

#|
|| **Load profile** | **vCPU** | **RAM** ||
|| Up to 10,000 RPS | 2 | 2 GB ||
|| Up to 20,000 RPS | 4 | 4 GB ||
|| Up to 40,000 RPS | 8 | 8 GB ||
|#

Scenarios involving JSON parsing, multiple checks, and large response bodies will require more resources. For more on running large-scale tests, see [this guide](https://grafana.com/docs/k6/latest/testing-guides/running-large-tests/).

For loads above 40,000 RPS, use [distributed k6 execution](https://grafana.com/docs/k6/latest/testing-guides/running-large-tests/).

## Migrate load profiles {#load-profiles}

In {{ load-testing-name }}, loads were specified in RPS units via the `line`, `const`, `step`, and `once` profiles. In k6, loads are managed via virtual user (VU) count and scenarios. Each VU executes a looped test scenario. The resulting RPS depends on VU count and execution time per iteration.

### const: Constant load {#profile-const}

{{ load-testing-name }}:

```yaml
load_profile:
  load_type: rps
  schedule:
    - {duration: 300s, type: const, ops: 10000}
```

k6: Fixed number of VUs:

```javascript
export const options = {
  scenarios: {
    constant_load: {
      executor: 'constant-vus',
      vus: 100,
      duration: '5m',
    },
  },
};
```

If you need precise RPS control, use the `constant-arrival-rate` executor:

```javascript
export const options = {
  scenarios: {
    constant_load: {
      executor: 'constant-arrival-rate',
      rate: 10000,
      timeUnit: '1s',
      duration: '5m',
      preAllocatedVUs: 200,
      maxVUs: 500,
    },
  },
};
```

### line: Linear growth {#profile-line}

{{ load-testing-name }}:

```yaml
load_profile:
  load_type: rps
  schedule:
    - {duration: 180s, type: line, from: 1, to: 10000}
```

k6:

```javascript
export const options = {
  scenarios: {
    ramp_up: {
      executor: 'ramping-arrival-rate',
      startRate: 1,
      timeUnit: '1s',
      preAllocatedVUs: 200,
      maxVUs: 500,
      stages: [
        { duration: '3m', target: 10000 },
      ],
    },
  },
};
```

### step: Stepwise growth {#profile-step}

{{ load-testing-name }}:

```yaml
load_profile:
  load_type: rps
  schedule:
    - {duration: 30s, type: step, from: 10, to: 100, step: 5}
```

k6: Equivalent via several stages. The source profile contains 18 steps (from 10 to 100 with an increment of 5) for 30 seconds, i.e., around 1.7 s per step:

```javascript
export const options = {
  scenarios: {
    stepped_load: {
      executor: 'ramping-arrival-rate',
      startRate: 10,
      timeUnit: '1s',
      preAllocatedVUs: 50,
      maxVUs: 200,
      stages: [
        { duration: '1.7s', target: 15 },
        { duration: '1.7s', target: 20 },
        { duration: '1.7s', target: 25 },
        { duration: '1.7s', target: 30 },
        { duration: '1.7s', target: 35 },
        { duration: '1.7s', target: 40 },
        { duration: '1.7s', target: 45 },
        { duration: '1.7s', target: 50 },
        { duration: '1.7s', target: 55 },
        { duration: '1.7s', target: 60 },
        { duration: '1.7s', target: 65 },
        { duration: '1.7s', target: 70 },
        { duration: '1.7s', target: 75 },
        { duration: '1.7s', target: 80 },
        { duration: '1.7s', target: 85 },
        { duration: '1.7s', target: 90 },
        { duration: '1.7s', target: 95 },
        { duration: '1.7s', target: 100 },
      ],
    },
  },
};
```

### once: Single-time surge {#profile-once}

{{ load-testing-name }}:

```yaml
load_profile:
  load_type: rps
  schedule:
    - {type: once, times: 133}
```

k6:

```javascript
export const options = {
  scenarios: {
    burst: {
      executor: 'shared-iterations',
      vus: 133,
      iterations: 133,
    },
  },
};
```

## Migrate test data and scenarios {#test-data}

### HTTP requests {#http}

If your tests were in URI or HTTP_JSON, import your requests to a k6 script:

```javascript
import http from 'k6/http';
import { check, sleep } from 'k6';

export default function () {
  // GET request
  const res = http.get('https://my-app.example.com/api/items');
  check(res, {
    'status 200': (r) => r.status === 200,
  });

  // POST request 
  const payload = JSON.stringify({ title: 'New task', completed: false });
  const params = { headers: { 'Content-Type': 'application/json' } };
  const postRes = http.post('https://my-app.example.com/api/items', payload, params);
  check(postRes, {
    'created': (r) => r.status === 201,
  });

  sleep(1);
}
```

### gRPC requests {#grpc}

If your gRPC services were tested via Pandora with GRPC_JSON format, use the built-in k6 module called `k6/net/grpc`.

{{ load-testing-name }} (GRPC_JSON format):

```json
{"tag": "/api.Adder/Add", "call": "api.Adder.Add", "metadata": {"Authorization": ["Bearer ..."]}, "payload": {"x": 21, "y": 12}}
```

k6:

```javascript
import grpc from 'k6/net/grpc';
import { check } from 'k6';

const client = new grpc.Client();
client.load(['proto'], 'adder.proto');

export default () => {
  if (__ITER === 0) {
    client.connect('my-grpc-service.example.com:8080', { plaintext: true });
  }

  const response = client.invoke('api.Adder/Add', { x: 21, y: 12 }, {
    metadata: { authorization: 'Bearer ...' },
  });

  check(response, {
    'Status OK': (r) => r.status === grpc.StatusOK,
  });

};
```

### Data from files {#data-from-files}

If your test data was stored in {{ objstorage-name }}, upload it locally and use it in the script via `SharedArray`:

```javascript
import http from 'k6/http';
import { SharedArray } from 'k6/data';

const data = new SharedArray('urls', function () {
  return JSON.parse(open('./test-data.json'));
});

export default function () {
  const item = data[Math.floor(Math.random() * data.length)];
  http.get(item.url);
}
```

## Set up an autostop {#autostop}

In {{ load-testing-name }}, an autostop used to interrupt the test if preset conditions were broken. In k6, the same function is served by [thresholds](https://grafana.com/docs/k6/latest/using-k6/thresholds/) with the `abortOnFail` parameter.

### Stop based on response time {#autostop-time}

{{ load-testing-name }}:

```yaml
autostop:
  - time(1s, 30s)
```

k6: Use a high quantile, e.g., p(99), to achieve a behavior close to the original, where the time of every request is checked:

```javascript
export const options = {
  thresholds: {
    http_req_duration: [
      { threshold: 'p(99)<1000', abortOnFail: true, delayAbortEval: '30s' },
    ],
  },
};
```

### Stop based on HTTP codes {#autostop-http}

{{ load-testing-name }}:

```yaml
autostop:
  - http(5xx, 10%, 30s)
```

The built-in `http_req_failed` metric counts all responses with codes >= `400` (`4xx` and `5xx`). To track `5xx` only, create a custom metric:

```javascript
import http from 'k6/http';
import { Rate } from 'k6/metrics';

const errors5xx = new Rate('errors_5xx');

export const options = {
  thresholds: {
    errors_5xx: [
      { threshold: 'rate<0.1', abortOnFail: true, delayAbortEval: '30s' },
    ],
  },
};

export default function () {
const res = http.get('https://my-app.example.com/api/endpoint');
errors5xx.add(res.status >= 500);
}
```

### Stop based on quantiles {#autostop-quantile}

{{ load-testing-name }}:

```yaml
autostop:
  - quantile(95, 100ms, 10s)
```

k6:

```javascript
export const options = {
  thresholds: {
    http_req_duration: [
      { threshold: 'p(95)<100', abortOnFail: true, delayAbortEval: '10s' },
    ],
  },
};
```

### Timeout {#autostop-limit}

{{ load-testing-name }}:

```yaml
autostop:
  - limit(10m)
```

k6: Specified via `duration` in the scenario parameters.

```javascript
export const options = {
  scenarios: {
    default: {
      executor: 'constant-vus',
      vus: 50,
      duration: '10m',
    },
  },
};
```

## Configure visualization of results {#test-results}

### Built-in output {#builtin-output}

Once the test is complete, k6 outputs a summary of the key metrics to the terminal:

* `http_req_duration`: Response time (avg, min, med, max, p90, p95).
* `http_req_failed`: Percentage of failed requests.
* `http_reqs`: Total number of requests and RPS.
* `iterations`: Number of completed iterations.
* `vus`: Number of virtual users.

### Export to JSON {#json-output}

To save detailed results, run this command:

```bash
k6 run --out json=results.json test.js
```

### Visualization in Grafana {#grafana}

To get charts similar to those provided in {{ load-testing-name }} (response time quantiles, response codes, RPS), configure the export of metrics to one of the supported systems.

**InfluxDB v1 + Grafana:**

```bash
k6 run --out influxdb=http://localhost:8086/k6 test.js
```

{% note warning %}

The built-in `--out influxdb` output supports only InfluxDB v1. For InfluxDB v2, use the [xk6-output-influxdb](https://github.com/grafana/xk6-output-influxdb) extension.

{% endnote %}

Use the ready-made [k6 dashboard](https://grafana.com/grafana/dashboards/2587-k6-load-testing-results/) in Grafana. It includes the following charts:

* Response time quantiles (similar to Quantiles in {{ load-testing-name }}).
* Number of virtual users (similar to Testing threads).
* HTTP response codes.
* RPS.

**Prometheus + Grafana:**

```bash
K6_PROMETHEUS_RW_SERVER_URL=http://localhost:9090/api/v1/write \
  k6 run -o experimental-prometheus-rw test.js
```

## Configure regression analysis {#regression}

In {{ load-testing-name }}, regression dashboards allowed tracking the degradation of measures from one run to another. In k6, you can achieve the same in two ways.

### Thresholds in CI/CD {#regression-ci}

Set thresholds in the script. If they are exceeded, k6 will terminate with a non-zero return code:

```javascript
export const options = {
  thresholds: {
    http_req_duration: ['p(95)<200', 'p(99)<500'],
    http_req_failed: ['rate<0.01'],
  },
};
```

Check the k6 return code in the CI/CD pipeline:

```yaml
load-test:
  script:
    - k6 run test.js
  # If the thresholds are exceeded, the job will terminate automatically.
```

### Storing history in Grafana {#regression-grafana}

When you export results to InfluxDB or Prometheus, the history of all runs is saved automatically. Configure the following in Grafana:

1. Dashboard with charts for key metrics (p95, p99, RPS, error percentage).
1. Threshold [alerts](https://grafana.com/docs/grafana/latest/alerting/).
1. Annotations to register test start times.

This visualizes the performance trend tracking, same as on {{ load-testing-name }} regression dashboards.

## Configure monitoring of generator resources {#monitoring}

{{ load-testing-name }} featured built-in agent monitoring (CPU, memory, disk, network). When using k6 to monitor the generator machine, use the standard tools:

* **Telegraf + Grafana**: If monitoring is already configured, the data collection will continue.
* **{{ monitoring-name }}**: If the generator is running on a {{ compute-name }} instance, its metrics are available in {{ monitoring-name }} without any additional setup.
* **node_exporter + Prometheus**: Standard approach for monitoring of Linux-based machines.

## Configure running in CI/CD {#cicd}

You can easily integrate k6 into any CI/CD pipeline.

Example for GitLab CI:

```yaml
load-test:
  stage: test
  image: grafana/k6
  script:
    - k6 run
        -u ${K6_VUS:-50}
        -d ${K6_DURATION:-5m}
        --env BASE_URL="${BASE_URL}"
        test.js
  artifacts:
    paths:
      -load-performance.json
```

To save the results to a file, use the `handleSummary()` function in your script:

```javascript
export function handleSummary(data) {
  return {
    'load-performance.json': JSON.stringify(data, null, 2),
  };
}
```

Example for GitHub Actions:

```yaml
- name: Load testing
  uses: grafana/k6-action@v0.3.1
  with:
    filename: test.js
    flags: -u 50 -d 5m
```

## What's next {#whats-next}

* [k6 guide](https://grafana.com/docs/k6/latest/): A complete guide on the tool’s features.
* [Examples of k6 scripts](https://github.com/grafana/k6/tree/master/examples): Ready-to-use scenarios for various protocols.
* [k6 Extensions](https://grafana.com/docs/k6/latest/extensions/): Extensions adding support of additional protocols (SQL, Kafka, Redis, etc.).
* [Grafana Cloud k6](https://grafana.com/products/cloud/k6/): Managed service used to run k6 with visualization and storage of results.
