# Creating a namespace in a {{ k8s }} cluster

{% note info %}

Creating [namespaces](../../concepts/index.md#namespace) in a {{ k8s }} cluster using the management console is in the [Preview](../../../overview/concepts/launch-stages.md) stage.

{% endnote %}

To create a namespace in a {{ managed-k8s-name }} cluster:

{% list tabs %}

- Management console

  1. Open **{{ managed-k8s-name }}** in the folder where you want to change the {{ k8s }} cluster.
  1. Select the appropriate cluster from the list.
  1. Click the **Namespace** tab.
  1. In the upper-right corner, click **Create**.
  1. Specify a **Name** for the namespace. It must be compliant with [RFC 1123](https://datatracker.ietf.org/doc/html/rfc1123):

     {% include [name-format-2](../../../_includes/name-format-2.md) %}

     {% include [note-namespace-kube](../../../_includes/managed-kubernetes/note-namespace-kube.md) %}

  1. Click **Add**.

- kubectl

  {% include [Install and configure kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}

  Run the following command:

  ```bash
  kubectl create namespace <namespace name>
  ```

  The namespace name must comply with [RFC 1123](https://datatracker.ietf.org/doc/html/rfc1123):

  {% include [name-format-2](../../../_includes/name-format-2.md) %}

  {% include [note-namespace-kube](../../../_includes/managed-kubernetes/note-namespace-kube.md) %}

{% endlist %}
