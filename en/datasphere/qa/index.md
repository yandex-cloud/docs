---
title: "Yandex DataSphere. FAQ"
description: "How to get the logs of my work in the Yandex DataSphere service? Answers to this and other questions in this article."
---

# General questions about {{ ml-platform-name }}

{% include [qa-logs.md](../../_includes/qa-logs.md) %}

#### What do I do if I can't install a package in my project or don't have internet access? {#error-connection}

You might have connection issues if you added a subnet to your project that doesn't have internet access.

If you need a subnet for your project, set up [NAT](../../vpc/operations/enable-nat.md) to get internet access.

You can disable a subnet if you don't need it for your project:

1. In the [management console]({{ link-console-main }}), select the folder where the project is located.
1. Select **{{ ml-platform-name }}**.
1. Click ![image](../../_assets/horizontal-ellipsis.svg) next to the project name and select **Edit**.
1. Under **Advanced settings**, click the drop-down list in the **Subnet** field.
1. Click the subnet name.
1. Click **Save**.

#### Can I close a tab with a notebook? {#close-notebook-tab}

Yes. If you close the notebook tab, current computations will continue running and the [interpreter state](../concepts/save-state.md), all variables, and computation results will be saved. You can continue working when you reopen your project.

#### Why can't I simultaneously start multiple notebooks in my project? {#parallel-run}

Running notebooks have access to the project storage and can edit files. To avoid conflicts between notebooks accessing the same files during computations, {{ ml-platform-name }} prevents you from starting multiple notebooks at the same time.

However, you can parallelize [special background operations](../early-access/repeat.md#parallel) that have read-only access to storage.

#### How do I specify the configuration type for my project? {#instance-type}

Project cells in {{ ml-platform-name }} run with the minimum [resource configuration](../concepts/configurations.md): **c1.4** (4 vCPUs). You can [change configurations](../operations/projects/control-compute-resources.md#config) while using your notebook. The state of the interpreter, variables, and computation results will be saved.

#### How do I resolve the error: <q>The following variables can't be serialized</q>? {#error-connection}

The error says that the system can't serialize the variable. It means that you can't move it when switching to another resource configuration. To avoid the error, run all your computations in the same configuration.

#### If I delete a running cell, will computations stop? {#delete-cell}

No, computations will continue even if you delete a cell from the notebook. Before deleting a cell, stop it. If you already deleted a running cell, stop the running computations by selecting **File ⟶ Stop project and return to console**.