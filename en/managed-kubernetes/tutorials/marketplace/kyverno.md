# Setting up Kyverno & Kyverno Policies

The [Kyverno](https://kyverno.io) application and its [Kyverno policies](https://github.com/kyverno/kyverno/tree/main/charts/kyverno-policies) extension are used for managing {{ k8s }} security policies. They appear in Kyverno as {{ k8s }} resources.

To integrate [Kyverno & Kyverno Policies](/marketplace/products/yc/kyverno) into {{ managed-k8s-name }}:

1. [Install the Kyverno & Kyverno Policies application](#install-kyverno).
1. [Check how the policy works for the baseline profile](#check-baseline).
1. [Create and test your own Kyverno policy](#create-check-policies).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

1. Create a {{ managed-k8s-name }} [cluster](../../../managed-kubernetes/concepts/index.md#kubernetes-cluster) and [node group](../../../managed-kubernetes/concepts/index.md#node-group).

   {% list tabs group=instructions %}

   - Manually {#manual}

     1. If you do not have a [network](../../../vpc/concepts/network.md#network) yet, [create one](../../../vpc/operations/network-create.md).
     1. If you do not have any [subnets](../../../vpc/concepts/network.md#subnet) yet, [create them](../../../vpc/operations/subnet-create.md) in the [availability zones](../../../overview/concepts/geo-scope.md) where your {{ k8s }} cluster and node group will be created.
     1. {% include [configure-sg-manual](../../../_includes/managed-kubernetes/security-groups/configure-sg-manual-lvl3.md) %}

        {% include [sg-common-warning](../../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

     1. [Create a {{ managed-k8s-name }} cluster](../../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) and a [node group](../../../managed-kubernetes/operations/node-group/node-group-create.md) in any suitable configuration. When creating them, specify the security groups prepared earlier.

   - {{ TF }} {#tf}

     1. {% include [terraform-install-without-setting](../../../_includes/mdb/terraform/install-without-setting.md) %}
     1. {% include [terraform-authentication](../../../_includes/mdb/terraform/authentication.md) %}
     1. {% include [terraform-setting](../../../_includes/mdb/terraform/setting.md) %}
     1. {% include [terraform-configure-provider](../../../_includes/mdb/terraform/configure-provider.md) %}

     1. Download the [k8s-cluster.tf](https://github.com/yandex-cloud-examples/yc-mk8s-cluster-infrastructure/blob/main/k8s-cluster.tf) cluster configuration file to the same working directory. The file describes:
        * [Network](../../../vpc/concepts/network.md#network).
        * [Subnet](../../../vpc/concepts/network.md#subnet).
        * {{ managed-k8s-name }} cluster.
        * [Service account](../../../iam/concepts/users/service-accounts.md) required for the {{ managed-k8s-name }} cluster and node group.
        * {% include [configure-sg-terraform](../../../_includes/managed-kubernetes/security-groups/configure-sg-tf-lvl3.md) %}

            {% include [sg-common-warning](../../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

     1. Specify the following in the configuration file:
        * [Folder ID](../../../resource-manager/operations/folder/get-id.md).
        * [{{ k8s }} version](../../concepts/release-channels-and-updates.md) for the {{ managed-k8s-name }} cluster and node groups.
        * {{ k8s }} cluster CIDR.
        * Service account name. It must be unique within the folder.
     1. Check that the {{ TF }} configuration files are correct using this command:

        ```bash
        terraform validate
        ```

        If there are any errors in the configuration files, {{ TF }} will point them out.
     1. Create the required infrastructure:

        {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../../_includes/mdb/terraform/explore-resources.md) %}

   {% endlist %}

1. {% include [kubectl-install-links](../../../_includes/managed-kubernetes/kubectl-install.md) %}

## Install the Kyverno & Kyverno Policies application {#install-kyverno}

Follow this [guide](../../operations/applications/kyverno.md) to install [Kyverno & Kyverno Policies](/marketplace/products/yc/kyverno) with the following settings:

* **Pod Security Standard profile**: `baseline`.
* **Validation failure action**: `enforce`.

The `baseline` [Pod Security Standard profile](https://kubernetes.io/docs/concepts/security/pod-security-standards/) already contains a minimum restriction policy that prevents known privilege abuses.

## Check how the policy works for the baseline profile {#check-baseline}

* Create a pod named `nginx` with standard parameters:

  ```bash
  kubectl run nginx --image nginx
  ```

  Result:

  ```text
  pod/nginx created
  ```

  Such a pod will satisfy the policy requirements for the `baseline` profile.

* Create a pod named `nginx` in privileged mode:

  ```bash
  kubectl run nginx --image nginx --privileged=true
  ```

  Result:

  ```text
  Error from server: admission webhook "validate.kyverno.svc-fail" denied the request:

  policy Pod/default/nginx for resource violation:

  disallow-privileged-containers:
    privileged-containers: 'validation error: Privileged mode is disallowed. The fields
      spec.containers[*].securityContext.privileged and spec.initContainers[*].securityContext.privileged
      must be unset or set to `false`. rule privileged-containers failed at path /spec/containers/0/securityContext/privileged/'
  ```

  The policy rules for the `baseline` profile prohibit creating pods in privileged mode.

{% note info %}

Although the policies are designed for pods, Kyverno applies them to any resources able to create pods.

{% endnote %}

## Create your own Kyverno policy and check how it works {#create-check-policies}

1. Create a policy that will require all [pods](../../concepts/index.md#pod) to have the `app.kubernetes.io/name` [label](../../../resource-manager/concepts/labels.md):
   1. Save the `ClusterPolicy` creation specification to a YAML file named `policy.yaml`:

      ```yaml
      apiVersion: kyverno.io/v1
      kind: ClusterPolicy
      metadata:
        name: require-labels
      spec:
        validationFailureAction: Enforce
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

   1. Run this command:

      ```bash
      kubectl apply -f policy.yaml
      ```

      Result:

      ```text
      clusterpolicy.kyverno.io/require-labels created
      ```
1. {% include [install policy reporter](../../../_includes/managed-kubernetes/install-policy-reporter.md) %}

## Test Kyverno & Kyverno Policies {#check-apps}

* Create a pod named `nginx` with no `app.kubernetes.io/name` {{ k8s }} label:

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

* Create a pod named `nginx` with the `app.kubernetes.io/name` label:

  ```bash
  kubectl run nginx --image nginx --labels app.kubernetes.io/name=nginx
  ```

  Result:

  ```text
  pod/nginx created
  ```

## Delete the resources you created {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

{% list tabs group=instructions %}

- Manually {#manual}

  1. [Delete the {{ k8s }} cluster](../../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
  1. [Delete the created subnets](../../../vpc/operations/subnet-delete.md) and [networks](../../../vpc/operations/network-delete.md).
  1. [Delete the created service account](../../../iam/operations/sa/delete.md).

- {{ TF }} {#tf}

  1. In the command line, go to the directory with the current {{ TF }} configuration file with an infrastructure plan.
  1. Delete the `k8s-cluster.tf` configuration file.
  1. Check that the {{ TF }} configuration files are correct using this command:

     ```bash
     terraform validate
     ```

     If there are any errors in the configuration files, {{ TF }} will point them out.
  1. Confirm updating the resources.

     {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

     All the resources described in the `k8s-cluster.tf` configuration file will be deleted.

{% endlist %}
