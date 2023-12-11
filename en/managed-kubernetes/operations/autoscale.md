---
title: "How to configure autoscaling for a {{ k8s }} cluster in {{ managed-k8s-full-name }}"
description: "Follow this guide to configure autoscaling."
---

# Configuring autoscaling

{{ managed-k8s-name }} has three [autoscaling](../concepts/autoscale.md) methods available:
* [Cluster autoscaling](#ca)
* [Horizontal pod autoscaling](#hpa)
* [Vertical pod autoscaling](#vpa)

## Getting started {#before-you-begin}

1. [Create a {{ managed-k8s-name }} cluster](kubernetes-cluster/kubernetes-cluster-create.md) with any suitable configuration.

1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

## Configuring cluster autoscaling {#ca}

{% note warning %}

You can only enable automatic scaling of this type when creating a [{{ managed-k8s-name }} node group](../concepts/index.md#node-group).

{% endnote %}

To create an autoscalable {{ managed-k8s-name }} node group:

{% list tabs %}

- Management console

  [Create a {{ managed-k8s-name }} node group](../operations/node-group/node-group-create.md) with the following parameters:
  * Scaling **{{ ui-key.yacloud.k8s.node-groups.create.field_scale-type }}**: `{{ ui-key.yacloud.k8s.node-groups.create.value_scale-auto }}`.
  * **{{ ui-key.yacloud.k8s.node-groups.create.field_min-size }}**: Specify the number of {{ managed-k8s-name }} nodes to remain in the group at minimum load.
  * **{{ ui-key.yacloud.k8s.node-groups.create.field_max-size }}**: Specify the maximum number of {{ managed-k8s-name }} nodes allowed in the group.
  * **{{ ui-key.yacloud.k8s.node-groups.create.field_initial-size }}**: Number of {{ managed-k8s-name }} nodes to be created together with the group (this number must be between the minimum and the maximum number of nodes in the group).

- CLI

  1. {% include [cli-install](../../_includes/cli-install.md) %}

     {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Review the command to create a {{ managed-k8s-name }} node group:

     ```bash
     {{ yc-k8s }} node-group create --help
     ```

  1. Create an autoscalable {{ managed-k8s-name }} node group:

     ```bash
     {{ yc-k8s }} node-group create \
     ...
       --auto-scale min=<minimum_number_of_nodes>, max=<maximum_number_of_nodes>, initial=<initial_number_of_nodes>
     ```

- {{ TF }}

  1. {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

     {% include [terraform-install](../../_includes/terraform-install.md) %}
  1. Open the current {{ TF }} configuration file describing the node group.

     For more information about creating this file, see [{#T}](../operations/node-group/node-group-create.md).
  1. Add a description of the new node group by specifying the autoscaling settings under `scale_policy.auto_scale`:

     ```hcl
     resource "yandex_kubernetes_node_group" "<node_group_name>" {
     ...
       scale_policy {
         auto_scale {
           min     = <minimum_number_of_nodes_per_group>
           max     = <maximum_number_of_nodes_per_group>
           initial = <initial_number_of_nodes_per_group>
         }
       }
     }
     ```

  1. Make sure the configuration files are valid.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

{% endlist %}

For more information about {{ k8s-ca }}, see [{#T}](../concepts/autoscale.md#ca).

## Configuring horizontal pod autoscaling {#hpa}

{% list tabs %}

- CLI

  1. Create a {{ k8s-hpa }} for your application, for example:

     ```bash
     kubectl autoscale deployment/<application_name> --cpu-percent=50 --min=1 --max=3
     ```

     Where:
     * `--cpu-percent`: Expected [{{ managed-k8s-name }} pod](../concepts/index.md#pod) load on the vCPU.
     * `--min`: Minimum number of {{ managed-k8s-name }} pods.
     * `--max`: Maximum number of {{ managed-k8s-name }} pods.
  1. Check the {{ k8s-hpa }} status:

     ```bash
     kubectl describe hpa/<application_name>
     ```

{% endlist %}

For more information about {{ k8s-hpa }}, see [{#T}](../concepts/autoscale.md#hpa).

## Configuring vertical pod autoscaling {#vpa}

{% list tabs %}

- CLI

  1. Install {{ k8s-vpa }} from the following [repository](https://github.com/kubernetes/autoscaler/tree/master/vertical-pod-autoscaler):

     ```bash
     cd /tmp && \
       git clone https://github.com/kubernetes/autoscaler.git && \
       cd autoscaler/vertical-pod-autoscaler/hack && \
       ./vpa-up.sh
     ```

  1. Create a configuration file called `vpa.yaml` for your application:

     ```yaml
     apiVersion: autoscaling.k8s.io/v1
     kind: VerticalPodAutoscaler
     metadata:
       name: <application_name>
     spec:
       targetRef:
         apiVersion: "apps/v1"
         kind:       Deployment
         name:       <application_name>
     updatePolicy:
       updateMode: "<VPA_runtime_mode:_Auto_or_Off>"
     ```

     Set the {{ k8s-vpa }} runtime mode in the `updateMode` parameter: `Auto` or `Off`.
  1. Create a {{ k8s-vpa }} for your application:

     ```bash
     kubectl apply -f vpa.yaml
     ```

  1. Check the {{ k8s-vpa }} status:

     ```bash
     kubectl describe vpa <application_name>
     ```

{% endlist %}

For more information about {{ k8s-vpa }}, see [{#T}](../concepts/autoscale.md#vpa).

## Deleting Terminated pods {#delete-terminated}

Sometimes during autoscaling, {{ managed-k8s-name }} node pods are not deleted and stay in the **Terminated** status. This happens because the [Pod garbage collector (PodGC)](https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#pod-garbage-collection) fails to timely delete these pods.

You can delete the stuck {{ managed-k8s-name }} pods:
* [Manually](#manually)
* [Automatically using CronJob](#automatically-cronjob)

### Manually {#manually}

Run this command:

```bash
kubectl get pods --all-namespaces | grep -i Terminated \
| awk '{print $1, $2}' | xargs -n2 kubectl delete pod -n
```

### Automatically using CronJob {#automatically-cronjob}

To delete stuck {{ managed-k8s-name }} pods automatically:
1. [Set up a CronJob](#setup-cronjob).
1. [Check the results of your CronJob jobs](#check-cronjob).

If you no longer need the CronJob, [delete it](#delete-cronjob).

#### Setting up automatic deletion in a CronJob {#setup-cronjob}

1. Create a `cronjob.yaml` file with a specification for the [CronJob](https://kubernetes.io/docs/tasks/job/automated-tasks-with-cron-jobs/#creating-a-cron-job) and the resources needed to run it:

   ```yaml
   ---
   apiVersion: batch/v1
   kind: CronJob
   metadata:
     name: terminated-pod-cleaner
   spec:
     schedule: "*/5 * * * *"
     jobTemplate:
       spec:
         template:
           spec:
             serviceAccountName: terminated-pod-cleaner
             containers:
             - name: terminated-pod-cleaner
               image: bitnami/kubectl
               imagePullPolicy: IfNotPresent
               command: ["/bin/sh", "-c"]
               args: ["kubectl get pods --all-namespaces | grep -i Terminated | awk '{print $1, $2}' | xargs --no-run-if-empty -n2 kubectl delete pod -n"]
             restartPolicy: Never

   ---
   apiVersion: v1
   kind: ServiceAccount
   metadata:
     name: terminated-pod-cleaner

   ---
   apiVersion: rbac.authorization.k8s.io/v1
   kind: ClusterRole
   metadata:
     name: terminated-pod-cleaner
   rules:
     - apiGroups: [""]
       resources:
         - pods
       verbs: [list, delete]

   ---
   apiVersion: rbac.authorization.k8s.io/v1
   kind: ClusterRoleBinding
   metadata:
     name: terminated-pod-cleaner
   subjects:
   - kind: ServiceAccount
     name: terminated-pod-cleaner
     namespace: default
   roleRef:
     kind: ClusterRole
     name: terminated-pod-cleaner
     apiGroup: rbac.authorization.k8s.io
   ```

   The `schedule: "*/5 * * * *"` line defines a schedule in cron format: the job runs every 5 minutes. Change the interval if needed.
1. Create a CronJob and its resources:

   ```bash
   kubectl create -f cronjob.yaml
   ```

   Result:

   ```text
   cronjob.batch/terminated-pod-cleaner created
   serviceaccount/terminated-pod-cleaner created
   clusterrole.rbac.authorization.k8s.io/terminated-pod-cleaner created
   clusterrolebinding.rbac.authorization.k8s.io/terminated-pod-cleaner created
   ```

1. Check that the CronJob has been created:

   ```bash
   kubectl get cronjob terminated-pod-cleaner
   ```

   Result:

   ```text
   NAME                    SCHEDULE     SUSPEND  ACTIVE  LAST SCHEDULE  AGE
   terminated-pod-cleaner  */5 * * * *  False    0       <none>         4s
   ```

   After the interval specified in the `SCHEDULE`, a time value will appear in the `LAST SCHEDULE` column. This means that the task was successfully executed or ended with an error.

#### Checking the results of CronJob jobs {#check-cronjob}

1. Retrieve a list of jobs:

   ```bash
   kubectl get jobs
   ```

   Result:

   ```text
   NAME           COMPLETIONS  DURATION  AGE
   <job_name>  1/1          4s        2m1s
   ...
   ```

1. Get the name of the {{ managed-k8s-name }} pod that ran the job:

   ```bash
   kubectl get pods --selector=job-name=<job_name> --output=jsonpath={.items[*].metadata.name}
   ```

1. View the {{ managed-k8s-name }} pod logs:

   ```bash
   kubectl logs <pod_name>
   ```

   The log will include a list of deleted {{ managed-k8s-name }} pods. If the log is empty, this means that there were no {{ managed-k8s-name }} pods in the **Terminated** status when the job ran.

#### Deleting the CronJob {#delete-cronjob}

To delete the CronJob and its resources, run this command:

```bash
kubectl delete cronjob terminated-pod-cleaner && \
kubectl delete serviceaccount terminated-pod-cleaner && \
kubectl delete clusterrole terminated-pod-cleaner && \
kubectl delete clusterrolebinding terminated-pod-cleaner
```
