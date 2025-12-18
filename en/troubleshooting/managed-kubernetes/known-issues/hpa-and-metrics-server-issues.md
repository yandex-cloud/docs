# Troubleshooting HPA issues in {{ managed-k8s-name }}


## Issue description {#issue-description}

* `metrics.k8s.io` and `custom.metrics.k8s.io` API method calls time out with the `no context deadline exceeded` error message.
* The node running the metrics server pod is experiencing low RAM, triggering `oom-killer`. OOM killer messages show up in the {{ managed-k8s-name }} node serial console.
* Running `kubectl describe hpa` to get HPA status info in a {{ managed-k8s-name }} cluster returns the following messages:
  
  ```
  Warning  FailedGetResourceMetric horizontal-pod-autoscaler  failed to get memory utilization: unable to get metrics for resource memory: unable to fetch metrics from resource metrics API: an error on the server ("Internal Server Error: \"/apis/metrics.k8s.io/v1beta1/namespaces/jaeger/pods: Post net/http: request canceled (Client.Timeout exceeded while awaiting headers)") has prevented the request from succeeding (get pods.metrics.k8s.io)

  Warning  FailedGetResourceMetric  horizontal-pod-autoscaler  failed to get cpu utilization: unable to get metrics for resource cpu: unable to fetch metrics from resource metrics API: an error on the server ("Internal Server Error: Post: net/http: request canceled (Client.Timeout exceeded while awaiting headers)") has prevented the request from succeeding (get pods.metrics.k8s.io)
  ```

## Solution {#issue-resolution}

Follow these steps to solve the issue:

1. If the issue persists, change the configuration of the metrics server pod using [this tutorial](../../../managed-kubernetes/operations/connect/security-groups.md#apply).
1. Manually move the metrics server pod to a less loaded node within the {{ managed-k8s-name }} cluster.

## If the issue persists {#if-issue-still-persists}

If the above actions did not help, [create a support ticket]({{ link-console-support }}). Provide the following information in your ticket:

1. ID of the {{ managed-k8s-name }} cluster in question.
1. ID of the {{ managed-k8s-name }} cluster pod in question.
1. `kubectl describe hpa` output for the {{ managed-k8s-name }} cluster in question.