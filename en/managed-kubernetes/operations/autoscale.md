# Configuring autoscaling

{{ managed-k8s-name }} has 3 autoscaling methods available:
* [Cluster autoscaling](#ca).
* [Horizontal pod autoscaling](#hpa).
* [Vertical pod autoscaling](#vpa).

For more information, see [{#T}](../concepts/autoscale.md).

## Before you start {#before-you-begin}

1. [Create a cluster](kubernetes-cluster/kubernetes-cluster-create.md) with any suitable configuration.
1. Install the [{{ k8s }} CLI (kubectl)](https://kubernetes.io/docs/tasks/tools/install-kubectl/). And [configure](kubernetes-cluster/kubernetes-cluster-get-credetials.md) it to work with your cluster.

## Configuring cluster autoscaling {#ca}

{% note warning %}

You can only enable automatic scaling of this type when creating a node group.

{% endnote %}

To create an autoscalable node group:

{% list tabs %}

- Management console

  [Create a node group](../operations/node-group/node-group-create.md) with the following parameters:
  * **Type of scaling**: `Automatic`.
  * **Minimum number of nodes**: Specify the number of nodes that the group must include at minimum load.
  * **Maximum number of nodes**: Specify the maximum number of nodes allowed in the group.
  * **Initial number of nodes**: The number of nodes to create along with the group (must be between the minimum and the maximum number of nodes in the group).

- CLI

  1. {% include [cli-install](../../_includes/cli-install.md) %}

     {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Review the command to create a node group:

     ```bash
     {{ yc-k8s }} node-group create --help
     ```

  1. Create an autoscalable node group:

     ```bash
     {{ yc-k8s }} node-group create \
       ...
       --auto-scale min=<minimum number of nodes>, max=<maximum number of nodes>, initial=<initial number of nodes>
     ```

- {{ TF }}

  1. {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

     If you don't have Terraform, [install it and configure the provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. Open the current Terraform configuration file with the node group description.

     For more information about creating this file, see [{#T}](../operations/node-group/node-group-create.md).

  1. Add a description of the new node group by specifying the autoscaling settings under `scale_policy.auto_scale`:

     ```hcl
     resource "yandex_kubernetes_node_group" "<node group name>" {
       ...
       scale_policy {
         auto_scale {
           min     = <minimum number of nodes in group>
           max     = <maximum number of nodes in group>
           initial = <initial number of nodes in group>
         }
       }
     }
     ```

  1. Make sure that the configuration files are correct.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm the update of resources.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

{% endlist %}

Learn more about {{ k8s-ca }} in [{#T}](../concepts/autoscale.md#ca).

## Configuring horizontal pod autoscaling {#hpa}

{% list tabs %}

- CLI

  1. Create a {{ k8s-hpa }} for your application, for example:

     ```bash
     kubectl autoscale deployment/<application name> --cpu-percent=50 --min=1 --max=3
     ```

     Where:
     * `--cpu-percent`: The desired pod load on the vCPU.
     * `--min`: The minimum number of pods.
     * `--max`: The maximum number of pods.

  1. Check the {{ k8s-hpa }} status:

     ```bash
     kubectl describe hpa/<application name>
     ```

{% endlist %}

Learn more about {{ k8s-hpa }} in [{#T}](../concepts/autoscale.md#hpa).

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
     ---
     apiVersion: autoscaling.k8s.io/v1
     kind: VerticalPodAutoscaler
     metadata:
       name: <application name>
     spec:
       targetRef:
         apiVersion: "apps/v1"
         kind:       Deployment
         name:       <application name>
       updatePolicy:
         updateMode: "<VPA runtime mode: Auto or Off>"
     ```

     Set the {{ k8s-vpa }} runtime mode in the `updateMode` parameter: `Auto` or `Off`.

  1. Create a {{ k8s-vpa }} for your application:

     ```bash
     kubectl apply -f vpa.yaml
     ```

  1. Check the {{ k8s-vpa }} status:

     ```bash
     kubectl describe vpa <application name>
     ```

{% endlist %}

Learn more about {{ k8s-vpa }} in [{#T}](../concepts/autoscale.md#vpa).