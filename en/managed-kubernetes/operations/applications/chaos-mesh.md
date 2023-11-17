# Installing Chaos Mesh

[Chaos Mesh](https://chaos-mesh.org/) is an open-source platform that you can use to simulate various failures and faults in your {{ k8s }} clusters. Simulation can be performed at different development and testing stages and after release. You can use Chaos Mesh to detect and eliminate potential threats and set up security policies (for example, using [Kyverno](kyverno.md)).

{% note warning %}

Test failure scenarios on a test cluster first to make sure they do not affect the performance of the main cluster.

{% endnote %}

Before you start, [create a node group](../node-group/node-group-create.md) with at least 14 GB of RAM.

## Installation using {{ marketplace-full-name }} {#marketplace-install}

1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Click the [{{ managed-k8s-name }} cluster](../../concepts/index.md#kubernetes-cluster) name and select the ![image](../../../_assets/marketplace.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}** tab.
1. Under **Applications available for installation**, select [Chaos Mesh](/marketplace/products/yc/chaos-mesh) and click **{{ ui-key.yacloud.marketplace-v2.button_use }}**.
1. Configure the application:

   * **Namespace**: Select or create a [namespace](../../concepts/index.md#namespace) for Chaos Mesh.
   * **Application name**: Enter an application name.

1. Click **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.
1. Wait for the application to change its status to `Deployed`.

## Installation using a Helm chart {#helm-install}

1. {% include [helm-install](../../../_includes/managed-kubernetes/helm-install.md) %}

1. [Install the latest version of kubectl]({{ k8s-docs }}/tasks/tools/install-kubectl) and [configure it to work with the created cluster](../connect/index.md#kubectl-connect).

1. To install a [Helm chart](https://helm.sh/docs/topics/charts/) with Chaos Mesh, run this command:

   ```bash
   export HELM_EXPERIMENTAL_OCI=1 && \
   helm pull oci://{{ mkt-k8s-key.yc_chaos-mesh.helmChart.name }} \
     --version {{ mkt-k8s-key.yc_chaos-mesh.helmChart.tag }} \
     --untar && \
   helm install \
     --namespace <namespace> \
     --create-namespace \
     chaos-mesh ./chaos-mesh/
   ```

You can check the current version of the Helm chart on the [application page](/marketplace/products/yc/chaos-mesh#docker-images).

## Web interface and authorization in Chaos Mesh {#interface-and-authorization}

Once you install Chaos Mesh, you can get started with it in its web interface and go through the authorization process. To do this:

1. [Connect to your cluster](../connect/index.md#kubectl-connect).
1. Forward the `http://localhost:8080` URL to the Chaos Mesh web interface:

   ```bash
   kubectl port-forward service/chaos-dashboard 8080:2333 \
      --namespace <namespace>
   ```

   In the command, specify the namespace that you selected when installing the application.

   Result:

   ```text
   Forwarding from 127.0.0.1:8080 -> 2333
   Forwarding from [::1]:8080 -> 2333
   ```

1. In your browser, open [http://localhost:8080](http://localhost:8080). You will see the authorization window of the Chaos Mesh web interface.
1. To log in, you need a {{ k8s }} account and token. Get them using one of the two methods:

   * [Create an account and token](https://chaos-mesh.org/docs/manage-user-permissions/) for Chaos Mesh. For the account, you can set up access rights in a specific namespace.
   * For {{ k8s }} clusters 1.24 or higher, use a {{ k8s }} service account and create a token for it:

      1. View a list of available {{ k8s }} service accounts:

         ```bash
         kubectl get serviceAccounts
         ```

         Each account has its own set of access rights.

      1. Select the account you need and create a token:

         ```bash
         kubectl create token <account_name>
         ```

## See also {#see-also}

* [Chaos Mesh documentation](https://chaos-mesh.org/docs/).
