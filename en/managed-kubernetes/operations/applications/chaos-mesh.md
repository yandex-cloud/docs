---
title: Installing Chaos Mesh
description: Follow this guide to install Chaos Mesh.
---

# Installing Chaos Mesh


[Chaos Mesh](https://chaos-mesh.org/) is an open-source platform that you can use to simulate various failures and faults in your {{ k8s }} clusters. You can perform simulation at different development and testing stages, as well as after release. You can use Chaos Mesh to detect and eliminate potential threats and set up security policies, e.g., using [Kyverno](kyverno.md).

{% note warning %}

Orchestrate fault scenarios on a test cluster first so that you do not compromise the performance of the production cluster.

{% endnote %}

## Getting started {#before-you-begin}

1. [Create a node group](../node-group/node-group-create.md) with at least 14 GB of RAM.

1. {% include [check-sg-prerequsites](../../../_includes/managed-kubernetes/security-groups/check-sg-prerequsites-lvl3.md) %}

    {% include [sg-common-warning](../../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

## Installation from {{ marketplace-full-name }} {#marketplace-install}

1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Click the name of the [{{ managed-k8s-name }} cluster](../../concepts/index.md#kubernetes-cluster) you need and select the ![image](../../../_assets/console-icons/shopping-cart.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}** tab.
1. Under **{{ ui-key.yacloud.marketplace-v2.label_available-products }}**, select [Chaos Mesh](/marketplace/products/yc/chaos-mesh) and click **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
1. Configure the application:

   * **Namespace**: Create a new [namespace](../../concepts/index.md#namespace), e.g., `chaos-mech-space`. If you leave the default namespace, Chaos Mesh may work incorrectly.
   * **Application name**: Specify the application name.

1. Click **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.
1. Wait for the application status to change to `Deployed`.

## Installation using a Helm chart {#helm-install}

1. {% include [helm-install](../../../_includes/managed-kubernetes/helm-install.md) %}
1. {% include [Install and configure kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}

1. To install a [Helm chart](https://helm.sh/docs/topics/charts/) with Chaos Mesh, run this command:

   ```bash
   helm pull oci://{{ mkt-k8s-key.yc_chaos-mesh.helmChart.name }} \
     --version {{ mkt-k8s-key.yc_chaos-mesh.helmChart.tag }} \
     --untar && \
   helm install \
     --namespace <namespace> \
     --create-namespace \
     chaos-mesh ./chaos-mesh/
   ```

   If you set `namespace` to the default namespace, Chaos Mesh may work incorrectly. We recommend specifying a value different from all the existing namespaces, e.g., `chaos-mesh-space`.

   {% include [Support OCI](../../../_includes/managed-kubernetes/note-helm-experimental-oci.md) %}

You can check the current version of the Helm chart on the [application page](/marketplace/products/yc/chaos-mesh#docker-images).

## Chaos Mesh web interface and authorization {#interface-and-authorization}

Once you install Chaos Mesh, use its web interface to go through the authorization process. Proceed as follows:

1. [Connect to your cluster](../connect/index.md#kubectl-connect).
1. Forward the `http://localhost:8080` URL to the Chaos Mesh web interface:

   ```bash
   kubectl port-forward service/chaos-dashboard 8080:2333 \
      --namespace <namespace>
   ```

   In the command, specify the namespace you selected when installing the application.

   Result:

   ```text
   Forwarding from 127.0.0.1:8080 -> 2333
   Forwarding from [::1]:8080 -> 2333
   ```

1. In your browser, go to [http://localhost:8080](http://localhost:8080). This will open the authorization window of the Chaos Mesh web interface.
1. To log in, you need a {{ k8s }} account and token. Get them using one of the two methods:

   * [Create an account and token](https://chaos-mesh.org/docs/manage-user-permissions/) for Chaos Mesh. For the account, you can set up access permissions in a specific namespace.
   * For {{ k8s }} clusters 1.24 or higher, use a {{ k8s }} service account and create a token for it:

      1. View a list of available {{ k8s }} service accounts:

         ```bash
         kubectl get serviceAccounts
         ```

         Each account has its own access permissions.

      1. Select the account you need and create a token:

         ```bash
         kubectl create token <account_name>
         ```

## Working with {{ yandex-cloud }} resources {#yandex-cloud-resources}

The application features the `YCChaos` scenario for simulation of VM node failures, e.g., restarts or stops. You can use it to check fault tolerance of systems dependent on the cloud infrastructure.

For example, to use `YCChaos` to simulate a VM node restart:

1. [Create a service account](../../../iam/operations/sa/create.md) and [assign](../../../iam/operations/sa/assign-role-for-sa.md) it the `compute.operator` role.
1. [Issue an authorized key](../../../iam/operations/authentication/manage-authorized-keys.md#create-authorized-key) and save it to a file named `sa-key.json`.
1. Create a namespace named `chaos-testing`.
1. Create a {{ k8s }} secret based on the authorized key you created:

   ```shell
   kubectl create secret generic yc-sa-secret \
       --from-file=sa-key.json=./sa-key.json \
       -n chaos-testing
   ```

1. Save the workflow example with the `YCChaos` scenario to the `chaos.yaml` file:

   {% cut "chaos.yaml" }

   ```yaml
   apiVersion: chaos-mesh.org/v1alpha1
   kind: Workflow
   metadata:
     name: yc-random-batch
     namespace: chaos-testing
   spec:
     entry: parallel
     templates:
     - name: parallel
       templateType: Parallel
       children: [yc-1, yc-2]

     - name: yc-1
       templateType: YCChaos
       deadline: 5m
       ycChaos:
         action: compute-restart
         computeInstance: <VM_1_ID>
         secretName: yc-sa-secret

     - name: yc-2
       templateType: YCChaos
       deadline: 5m
       ycChaos:
         action: compute-restart
         computeInstance: <VM_2_ID>
         secretName: yc-sa-secret
   ```

   {% endcut %}

1. Create a workflow using this command:

   ```shell
   kubectl apply -f chaos.yaml
   ```

1. Make sure the specified VMs restart after you create the workflow.

   You can view the workflow results in the [Chaos Mesh web interface](#interface-and-authorization).

{% note info %}

You can experiment with the `YCChaos` scenario directly in the Chaos Mesh web interface.

{% endnote %}

## See also {#see-also}

* [Chaos Mesh documentation](https://chaos-mesh.org/docs/)
