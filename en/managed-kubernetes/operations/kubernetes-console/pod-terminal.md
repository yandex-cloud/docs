---
title: Connecting to the terminal of a running container in {{ managed-k8s-full-name }}
description: In this tutorial, you will learn how to connect to the terminal of a running {{ k8s }} container using the management console in {{ yandex-cloud }} without kubectl.
---

# Connecting to the terminal of a running container

You can use the {{ managed-k8s-name }} management console to connect to a container running in a pod and run commands without restarting or stopping the container. This approach is equivalent to `kubectl exec -it <pod_name> -- <shell_name>` and enables you to inspect logs during debugging, restart services, and modify configurations.

To connect to the terminal:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Navigate]({{ link-console-main }}/link/managed-kubernetes) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Select the {{ managed-k8s-name }} cluster and open the **{{ ui-key.yacloud.k8s.cluster.switch_workloads }}** tab.
  1. In the pod row, click ![ellipsis](../../../_assets/console-icons/ellipsis.svg) and select ![Terminal](../../../_assets/console-icons/terminal.svg) **{{ ui-key.yacloud.k8s.WorkloadsActions.pod-exec_jwJ3R }}**.

      The terminal will open at the bottom of the screen.
  1. Note that for multi-container pods, the terminal will open for the first container specified under `spec.containers` in the pod manifest.
  
      To switch to a shell of another container, select it from the drop-down menu in the top-left corner of the terminal window.

  The container’s default command shell will open.

  {% note warning %}

  The following error occurs when attempting to access the terminal of containers deployed from [minimal or distroless images](https://docs.docker.com/dhi/core-concepts/distroless/) that do not have a shell:
  
  `Connection failed. Terminal shell is not found`
    
  In such cases, we recommend you use [ephemeral containers](https://kubernetes.io/docs/concepts/workloads/pods/ephemeral-containers/) for connecting.

  {% endnote %}

{% endlist %}

#### Useful links {#see-also}

[{#T}](../../concepts/index.md#pod)
