# Vertical application scaling in a cluster

{{ managed-k8s-name }} supports several types of autoscaling. In this article you will learn how to configure the automatic management of [pod](../concepts/index.md#pod) resources with [{{ k8s-vpa }}](../concepts/autoscale.md#vpa):
* [{#T}](#create-vpa-workload).
* [{#T}](#test-vpa).

## Before you begin {#before-you-begin}

1. {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

1. [Create security groups](../operations/connect/security-groups.md) for the [{{ k8s }} master](../concepts/index.md#master) and its [nodes](../concepts/index.md#node-group):
   * `sg-k8s`: For [master and node group](../operations/connect/security-groups.md#rules-internal).
   * `k8s-public-services`: For [public access to services from the internet](../operations/connect/security-groups.md#rules-nodes).
   * `k8s-master-whitelist`: For [accessing the {{ k8s }} API](../operations/connect/security-groups.md#rules-master).
1. [Create a {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) and a [node group](../../managed-kubernetes/operations/node-group/node-group-create.md) in any suitable configuration. When creating a cluster and a group of nodes:
   * Use the previously created security groups.
   * Select automatic as your [public address](../../vpc/concepts/address.md#public-addresses) assignment method.

1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

## Create {{ k8s-vpa }} and a test application {#create-vpa-workload}

1. Create a file called `app.yaml` with the `nginx` test application and load balancer settings:

   {% cut "app.yaml" %}

   ```yaml
   ---
   ### Deployment
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: nginx
     labels:
       app: nginx
   spec:
     replicas: 1
     selector:
       matchLabels:
         app: nginx
     template:
       metadata:
         name: nginx
         labels:
           app: nginx
       spec:
         containers:
           - name: nginx
             image: k8s.gcr.io/hpa-example
             resources:
               requests:
                 memory: "256Mi"
                 cpu: "500m"
               limits:
                 memory: "500Mi"
                 cpu: "1"
   ---
   ### Service
   apiVersion: v1
   kind: Service
   metadata:
     name: nginx
   spec:
     selector:
       app: nginx
     ports:
       - protocol: TCP
         port: 80
         targetPort: 80
     type: LoadBalancer
   ```

   {% endcut %}

1. Create a file called `vpa.yaml` with the {{ k8s-vpa }} configuration:

   {% cut "vpa.yaml" %}

   ```yaml
   ---
   apiVersion: autoscaling.k8s.io/v1
   kind: VerticalPodAutoscaler
   metadata:
     name: nginx
   spec:
     targetRef:
       apiVersion: "apps/v1"
       kind:       Deployment
       name:       nginx
     updatePolicy:
       updateMode: "Auto"
   ```

   {% endcut %}

1. Create objects:

   ```bash
   kubectl apply -f app.yaml && \
   kubectl apply -f vpa.yaml
   ```

1. Make sure that the {{ k8s-vpa }} and `nginx` pods have changed their status to `Running`:

   ```bash
   kubectl get pods -n kube-system | grep vpa && \
   kubectl get pods | grep nginx
   ```

   Result:

   ```text
   vpa-admission-controller-58cf99779c-qmxtv  1/1  Running  0  44h
   vpa-recommender-678f4f6d4b-jqvgt           1/1  Running  0  44h
   vpa-updater-64ddd67787-xqsts               1/1  Running  0  44h
   nginx-6c5cbfc6d9-62j7w                     1/1  Running  0  42h
   nginx-6c5cbfc6d9-6t4nz                     1/1  Running  0  42h
   ```

   {% note info %}

   For {{ k8s-vpa }} to run properly, a minimum of two `nginx` pods are required.

   {% endnote %}

## Test {{ k8s-vpa }} {#test-vpa}

To test {{ k8s-vpa }}, `nginx` application workload will be simulated.
1. Review the recommendations provided by {{ k8s-vpa }} prior to creating the workload:

   ```bash
   kubectl describe vpa nginx
   ```

   Note the low `Cpu` values in the `Status.Recommendation.Container Recommendations` metrics:

   ```yaml
   Name:         nginx
   Namespace:    default
   Labels:       <none>
   Annotations:  <none>
   API Version:  autoscaling.k8s.io/v1
   Kind:         VerticalPodAutoscaler
   ...
   Status:
     Conditions:
       Last Transition Time:  2022-03-18T08:02:04Z
       Status:                True
       Type:                  RecommendationProvided
     Recommendation:
       Container Recommendations:
         Container Name:  nginx
         Lower Bound:
           Cpu:     25m
           Memory:  262144k
         Target:
           Cpu:     25m
           Memory:  262144k
         Uncapped Target:
           Cpu:     25m
           Memory:  262144k
         Upper Bound:
           Cpu:     25m
           Memory:  262144k
   ```

1. Make sure that {{ k8s-vpa }} is managing the `nginx` application pod resources:

   ```bash
   kubectl get pod <name of an nginx pod> --output yaml
   ```

   Result:

   ```yaml
   apiVersion: v1
   kind: Pod
   metadata:
     annotations:
       vpaObservedContainers: nginx
       vpaUpdates: 'Pod resources updated by nginx: container 0: cpu request, memory
         request, cpu limit, memory limit'
   ...
   spec:
     containers:
     ...
       name: nginx
       resources:
         limits:
           cpu: 50m
           memory: 500000Ki
         requests:
           cpu: 25m
           memory: 262144k
   ```

1. Run the workload simulation process in a separate window:

   ```bash
   URL=$(kubectl get service nginx -o json \
     | jq -r '.status.loadBalancer.ingress[0].ip') && \
     while true; do wget -q -O- http://$URL; done
   ```

   {% note tip %}

   To increase load and accelerate scenario progress, run several processes in separate windows.

   {% endnote %}

1. After several minutes, review the recommendation provided by {{ k8s-vpa }} after the workload is created:

   ```bash
   kubectl describe vpa nginx
   ```

   {{ k8s-vpa }} allocated additional resources to the pods as the workload increased. Note the increased `Cpu` values in the `Status.Recommendation.Container Recommendations` metrics:

   ```yaml
   Name:         nginx
   Namespace:    default
   Labels:       <none>
   Annotations:  <none>
   API Version:  autoscaling.k8s.io/v1
   Kind:         VerticalPodAutoscaler
   ...
   Status:
    Conditions:
       Last Transition Time:  2022-03-18T08:02:04Z
       Status:                True
       Type:                  RecommendationProvided
     Recommendation:
       Container Recommendations:
         Container Name:  nginx
         Lower Bound:
           Cpu:     25m
           Memory:  262144k
         Target:
           Cpu:     410m
           Memory:  262144k
         Uncapped Target:
           Cpu:     410m
           Memory:  262144k
         Upper Bound:
           Cpu:     28897m
           Memory:  1431232100
   ```

1. Stop simulating the workload. Within a few minutes, the `Status.Recommendation.Container Recommendations` metric values will return to their original values.

## Delete the resources you created {#clear-out}

Delete the resources you no longer need to avoid paying for them:
1. [Delete the {{ k8s }} cluster](../operations/kubernetes-cluster/kubernetes-cluster-delete.md).
1. If static public IP addresses were used for cluster and node access, release and [delete](../../vpc/operations/address-delete.md) them.