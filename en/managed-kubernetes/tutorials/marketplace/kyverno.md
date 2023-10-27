# Setting up Kyverno & Kyverno Policies

The [Kyverno](https://kyverno.io) application and its [Kyverno policies](https://github.com/kyverno/kyverno/tree/main/charts/kyverno-policies) extension are used for managing {{ k8s }} security policies. They appear in Kyverno as {{ k8s }} resources.

To integrate [Kyverno & Kyverno Pоlicies](/marketplace/products/yc/kyverno) into {{ managed-k8s-name }}:
1. [{#T}](#kyverno-policies)
1. [{#T}](#check-apps)

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

1. Create a {{ managed-k8s-name }} [cluster](../../../managed-kubernetes/concepts/index.md#kubernetes-cluster) and [node group](../../../managed-kubernetes/concepts/index.md#node-group).

   {% list tabs %}

   - Manually

     1. If you do not have a [network](../../../vpc/concepts/network.md#network) yet, [create one](../../../vpc/operations/network-create.md).
     1. If you do not have any [subnets](../../../vpc/concepts/network.md#subnet), [create them](../../../vpc/operations/subnet-create.md) in the [availability zones](../../../overview/concepts/geo-scope.md) where your {{ k8s }} cluster and node group will be created.
     1. [Create a {{ managed-k8s-name }} cluster](../../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) and a [node group](../../../managed-kubernetes/operations/node-group/node-group-create.md) in any suitable configuration.
     1. [Create a rule for connecting to the services from the internet](../../../managed-kubernetes/operations/connect/security-groups.md#rules-nodes) and apply it to the {{ managed-k8s-name }} cluster's node group.

   - Using {{ TF }}

      1. {% include [terraform-install](../../../_includes/terraform-install.md) %}
      1. Download [the file with provider settings](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Place it in a separate working directory and [specify the parameter values](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
      1. Download the cluster configuration file [k8s-cluster.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/managed-kubernetes/k8s-cluster.tf) to the same working directory. The file describes:
         * [Network](../../../vpc/concepts/network.md#network).
         * [Subnet](../../../vpc/concepts/network.md#subnet).
         * [Security group](../../operations/connect/security-groups.md) and rules required for the cluster, node group, and {{ managed-k8s-name }} instance to run:
            * Rules for service traffic.
            * Rules for accessing the {{ k8s }} API and managing the cluster with `kubectl` through ports 443 and 6443.
            * Rules for connecting to services from the internet.
         * {{ managed-k8s-name }} cluster.
         * [Service account](../../../iam/concepts/users/service-accounts.md) required to use the {{ managed-k8s-name }} cluster and node group.
      1. Specify the following in the configuration file:
         * [Folder ID](../../../resource-manager/operations/folder/get-id.md).
         * [{{ k8s }} version](../../concepts/release-channels-and-updates.md) for the {{ managed-k8s-name }} cluster and node groups.
         * {{ k8s }} cluster CIDR.
         * Name of the service account. It must be unique within the folder.
      1. Run the `terraform init` command in the directory with the configuration files. This command initializes the provider specified in the configuration files and enables you to use the provider resources and data sources.
      1. Make sure the {{ TF }} configuration files are correct using this command:

         ```bash
         terraform validate
         ```

         If there are any errors in the configuration files, {{ TF }} will point them out.
      1. Create the required infrastructure:

         {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

         {% include [explore-resources](../../../_includes/mdb/terraform/explore-resources.md) %}

   {% endlist %}

1. {% include [kubectl-install-links](../../../_includes/managed-kubernetes/kubectl-install.md) %}

## Create a Kyverno policy {#kyverno-policies}

1. Install the [Kyverno & Kyverno Policies](/marketplace/products/yc/kyverno) application by following the [instructions](../../operations/applications/kyverno.md).
1. Create a policy that will require that all [pods](../../concepts/index.md#pod) have the `app.kubernetes.io/name` [label](../../../resource-manager/concepts/labels.md).
   1. Save the specification for `ClusterPolicy` creation in a YAML file named `policy.yaml`:

      ```yaml
      apiVersion: kyverno.io/v1
      kind: ClusterPolicy
      metadata:
        name: require-labels
      spec:
        validationFailureAction: enforce
        rules:
        - name: check-for-labels
          match:
            any:
            - resources:
                kinds:
                - Pod
          validate:
            message: "label 'app.kubernetes.io/name' is required"
            pattern:
              metadata:
                labels:
                  app.kubernetes.io/name: "?*"
      ```

   1. Run the following command:

      ```bash
      kubectl apply -f ./policy.yaml
      ```

      Result:

      ```text
      clusterpolicy.kyverno.io/require-labels created
      ```

1. {% include [install policy reporter](../../../_includes/managed-kubernetes/install-policy-reporter.md) %}

## Test Kyverno & Kyverno Policies {#check-apps}

* Create a pod with no `app.kubernetes.io/name` label:

   ```bash
   kubectl run nginx --image nginx
   ```

   Result:

   ```text
   Error from server: admission webhook "validate.kyverno.svc-fail" denied the request:

   resource Pod/default/nginx was blocked due to the following policies

   require-labels:
     check-for-labels: 'validation error: label ''app.kubernetes.io/name'' is required.
       Rule check-for-labels failed at path /metadata/labels/app.kubernetes.io/name/'
   ```

* Create a pod with the `app.kubernetes.io/name` label:

   ```bash
   kubectl run nginx --image nginx --labels app.kubernetes.io/name=nginx
   ```

   Result:

   ```text
   pod/nginx created
   ```

{% note info %}

Although the policies are designed for pods, Kyverno applies them to any resources that can create pods.

{% endnote %}

## Delete the resources you created {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

{% list tabs %}

- Manually

   1. [Delete the {{ k8s }} cluster](../../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
   1. [Delete the created subnets](../../../vpc/operations/subnet-delete.md) and [networks](../../../vpc/operations/network-delete.md).
   1. [Delete the created service account](../../../iam/operations/sa/delete.md).

- Using {{ TF }}

   1. In the command line, go to the directory with the current {{ TF }} configuration file with an infrastructure plan.
   1. Delete the `k8s-cluster.tf` configuration file.
   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point them out.
   1. Confirm updating the resources.

      {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

      All the resources described in the `k8s-cluster.tf` configuration file will be deleted.

{% endlist %}