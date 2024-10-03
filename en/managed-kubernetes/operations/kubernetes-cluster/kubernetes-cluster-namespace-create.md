---
title: How to create a namespace in a {{ k8s }} cluster in {{ managed-k8s-full-name }}
description: Follow this guide to create a namespace in a {{ managed-k8s-name }} cluster.
---

# Creating a namespace in a {{ k8s }} cluster

To create a namespace in a {{ managed-k8s-name }} cluster:

{% list tabs group=instructions %}

- Management console {#console}

   1. Open **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}** in the folder where you want to change the {{ k8s }} cluster.
   1. Select the appropriate cluster from the list.
   1. Go to the **{{ ui-key.yacloud.k8s.cluster.switch_namespaces }}** tab.
   1. In the top-right corner, click **{{ ui-key.yacloud.k8s.namespaces.button_create }}**.
   1. Specify a **{{ ui-key.yacloud.k8s.namespaces.popup-add_field_name }}** for the namespace. It must be compliant with [RFC 1123](https://datatracker.ietf.org/doc/html/rfc1123):

      {% include [namespace-name](../../../_includes/managed-kubernetes/namespace-name.md) %}

      {% include [note-namespace-kube](../../../_includes/managed-kubernetes/note-namespace-kube.md) %}

   1. Click **{{ ui-key.yacloud.common.add }}**.

- kubectl CLI {#kubectl}

   {% include [Install and configure kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}

   Run the following command:

   ```bash
   kubectl create namespace <namespace_name>
   ```

   The namespace name must comply with [RFC 1123](https://datatracker.ietf.org/doc/html/rfc1123):

   {% include [namespace-name](../../../_includes/managed-kubernetes/namespace-name.md) %}

   {% include [note-namespace-kube](../../../_includes/managed-kubernetes/note-namespace-kube.md) %}

{% endlist %}