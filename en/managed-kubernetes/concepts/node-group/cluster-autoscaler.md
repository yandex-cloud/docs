---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Cluster autoscaler

The cluster autoscaler resizes the node group based on resource requests for the pods running on the nodes of that group. The autoscaler is available as of {{ k8s }} version 1.15.

## How the autoscaler works {#how-scale}

You specify the minimum and maximum size of the node group, and the {{ k8s }} cluster periodically checks the status of the pods and nodes:

* If the pods can't be scheduled onto the existing nodes due to insufficient resources (vCPU, RAM), the number of nodes in the group gradually increases to the maximum specified.
* If the load on the nodes is insufficient and all pods can be scheduled onto fewer nodes in the group, the number of nodes gradually decreases to the minimum specified. If the pods in a node can't be evicted over the preset waiting time (7 minutes), the node is forcibly stopped. You can't change the waiting time.

The cluster autoscaler is different from [Horizontal Pod Autoscaler](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/). The Horizontal Pod Autoscaler uses a controller to periodically request resource usage based on the metrics defined in each {{ k8s }} API [HorizontalPodAutoscaler](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.17/#horizontalpodautoscaler-v1-autoscaling) object. You can use both mechanisms in parallel.

