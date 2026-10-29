---
title: Configuring the target group management mode in {{ managed-k8s-full-name }}
description: How to configure the v2 target group management mode for a LoadBalancer service in {{ managed-k8s-name }}, check the composition of a network load balancer target group, and switch back to legacy mode.
---

# Configuring the management mode for network load balancer target groups

{% include [load-balancer-target-groups-intro](../../_includes/managed-kubernetes/load-balancer-target-groups-intro.md) %}

{% include [load-balancer-v2-availability](../../_includes/managed-kubernetes/load-balancer-v2-availability.md) %}

To configure the target group management mode:

1. [Get ready to work](#before-you-begin).
1. [Create a service](#create-service) of the `LoadBalancer` type or enable the `v2` [mode](#migrate-service) and the `Local` policy for an existing service.
1. [Check the target group composition and application availability](#verify).

## Getting started {#before-you-begin}

1. Make sure the cluster uses the `RAPID` [release channel](../concepts/release-channels-and-updates.md). This is currently the only channel supporting the `v2` mode with the `Local` policy.
1. Contact [support](../../support/overview.md). Specify the [cloud ID](../../resource-manager/operations/cloud/get-id.md) and [cluster ID](kubernetes-cluster/kubernetes-cluster-list.md#list). Request connecting the `v2` mode and wait for the confirmation.
1. [Install kubectl](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl/) and [configure it to work with the new {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/connect/index.md#kubectl-connect).
1. Check [{{ network-load-balancer-name }} quotas and limits](../../network-load-balancer/concepts/limits.md): in `v2` mode, a separate target group is created for each service that uses the `Local` policy. Request a quota increase if needed.
1. Check the cluster service account permissions and security group as described in [this infrastructure setup guide](create-load-balancer.md#before-you-begin).
1. Set up your application. The examples below use an application in the `default` namespace, whose pods have the `app: demo` label and accept TCP traffic on port `8080`. Replace these placeholders with your actual values.
1. Verify that your pods are ready and check their placement:

   ```bash
   kubectl -n default get pods -l app=demo -o wide
   ```

## Create a LoadBalancer type service {#create-service}

To create a `LoadBalancer` type service for which the controller will automatically create a network load balancer with a dedicated target group:

1. Save the service specification to `app-lb.yaml`:

   ```yaml
   apiVersion: v1
   kind: Service
   metadata:
     name: app-lb
     namespace: default
     annotations:
       yandex.cloud/controller-reconcile-mode: "v2"
   spec:
     type: LoadBalancer
     externalTrafficPolicy: Local
     selector:
       app: demo
     ports:
       - name: http
         port: 80
         targetPort: 8080
         protocol: TCP
   ```

   Where:

   * `type: LoadBalancer` under `spec`: Service type for which the controller automatically creates a network load balancer.
   * `yandex.cloud/controller-reconcile-mode: "v2"` under `metadata.annotations`: Annotation that enables the `v2` target group management mode.
   * `externalTrafficPolicy: Local` under `spec`: Policy routing external traffic only to application pods residing on the same node. Combined with the `v2` mode, the target group only includes nodes with pods chosen by the service selector.

   For additional properties, see the [Service reference](../nlb-ref/service.md).

1. Create a service:

   ```bash
   kubectl apply -f app-lb.yaml
   ```

1. Wait for the NLB IP address to appear in the `EXTERNAL-IP` field of the service:

   ```bash
   kubectl -n default get service app-lb --watch
   ```

   The fact that the address appears does not confirm the application is ready. [Check the result](#verify).

## Enable the v2 mode for an existing LoadBalancer service {#migrate-service}

Migration of an existing `LoadBalancer` service to `v2` is supported without downtime. To enable the `v2` management mode for an existing service:

1. Save the service configuration:

   ```bash
   kubectl -n default get service app-lb -o yaml > app-lb-backup.yaml
   ```

   Write down the load balancer address, target group composition, and results of availability checks. Make sure the application is available via the load balancer.

1. Check the traffic policy in the service settings:

   ```bash
   kubectl -n default get service app-lb -o jsonpath='{.spec.externalTrafficPolicy}'
   ```

   To make the target group smaller, you need the `Local` policy. If it is set to `Cluster`, [check whether the `Local` policy is compatible with your application](create-load-balancer.md#create-lb). To change the policy, update `spec.externalTrafficPolicy` in your source service manifest and apply the configuration. The `v2` mode does not reduce the target list if using the `Cluster` policy.

1. Add the annotation to the `Service` object:

   ```bash
   kubectl -n default annotate service app-lb \
     yandex.cloud/controller-reconcile-mode=v2 --overwrite
   ```

   The command does not change `externalTrafficPolicy`. The controller will update cloud resources and delete resources of the previous mode in case they are no longer used.

   If the service is managed via Helm or GitOps, save the annotation in the source configuration. Otherwise, subsequent syncs may revert it to the previous value.
   
1. [Check the result](#verify). When migrating multiple services, enable the `v2` mode for them one by one.

## Check the result {#verify}

After creating the service or changing its target group management mode, complete the following steps:

1. View the service configuration and events:

   ```bash
   kubectl -n default get service app-lb -o yaml
   kubectl -n default describe service app-lb
   ```

1. Check the placement of your application pods, pod details in the `EndpointSlice` objects associated with the service, and node addresses:

   ```bash
   kubectl -n default get pods -l app=demo -o wide
   kubectl -n default get endpointslices \
     -l kubernetes.io/service-name=app-lb -o yaml
   kubectl get nodes -o wide
   ```

1. Find the network load balancer created for the service and [check the targets in the attached target group](../../network-load-balancer/operations/target-group-list.md#get). For the `v2` and `Local` combination, targets must match the nodes with application pods chosen by the service selector. Compare the specific nodes rather than the number of pods or `EndpointSlice` records.

1. [Check the target health](../../network-load-balancer/operations/check-resource-health.md) and send a request to the application using the network load balancer address. If your application uses HTTP, run this command:

   ```bash
   curl http://<load_balancer_IP_address>/
   ```

Group changes and availability check results are updated asynchronously. To run a check on a test application, change the number of replicas or pod placement and make sure the group has updated.

## Switch back to legacy mode {#rollback}

For the network load balancer to use the shared target group containing all cluster nodes again, set the annotation value to `legacy` in the `Service` object:

```bash
kubectl -n default annotate service app-lb \
  yandex.cloud/controller-reconcile-mode=legacy --overwrite
```

If the service is managed via Helm or GitOps, make sure to save the changes in the source configuration as well. [Check the result](#verify).

## Troubleshooting {#troubleshooting}

If you fail to get the expected result, check the following conditions:

#|
|| **Issue** | **What to check** ||
|| All nodes remain in the group | Check the `externalTrafficPolicy` policy, exact annotation value, and that the mode was enabled via support and available for your cluster's release channel. Note that this is the expected behavior if the policy is set to `Cluster` or the pods are placed on all nodes. ||
|| A new node does not appear in the group | Check for pods in `EndpointSlice`, service events, and the status of cloud operations. ||
|| A node is in the group but fails health checks | Check pod readiness, service parameters, the health check port, and [security groups](connect/security-groups.md). ||
|| The service has no external address | Review service events, load balancer creation errors, quotas, and cluster service account permissions. ||
|#

If the group composition does not match the pod placement after operations are completed, save the service YAML description, events, and update time to submit them to [support](../../support/overview.md). Do not manually delete system records in the `metadata.finalizers` field or remove shared target groups.

#### Useful links {#see-also}

* [{#T}](../concepts/load-balancer-target-groups.md)
* [{#T}](create-load-balancer.md)
* [{#T}](../nlb-ref/service.md)
