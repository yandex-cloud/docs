---
title: "{{ ml-platform-full-name }}. Answers"
description: "How do I get the logs of my activity in {{ ml-platform-full-name }}? Find the answer to this and other questions in this article."
---

# General questions about {{ ml-platform-name }}

{% include [logs](../../_qa/logs.md) %}

#### What do I do if I can't install a package in my project or don't have internet access? {#error-connection}

You might have connection issues if you added a subnet to your project that doesn't have internet access.

If you need a subnet for your project, [set up NAT](../../vpc/operations/enable-nat.md) to get internet access.

You can [update or disable](../operations/projects/update.md) the subnet through project settings.

#### Can I close a tab with a notebook? {#close-notebook-tab}

Yes. If you close the notebook tab, current computations will continue running and the [interpreter state](../concepts/save-state.md), all variables, and computation results will be saved. You can continue working when you reopen your project.

#### Why can't I simultaneously start multiple notebooks in my project? {#parallel-run}

Running notebooks have access to the project storage and can edit files. To avoid conflicts between notebooks accessing the same files during computations, {{ ml-platform-name }} prevents you from starting multiple notebooks at the same time.

However, you can parallelize [special background operations](../concepts/repeat.md#parallel) that have read-only access to storage.

#### How do I specify the configuration type for my project? {#instance-type}

Project cells in {{ ml-platform-name }} run with the minimum [resource configuration](../concepts/configurations.md): **c1.4** (4 vCPUs). You can [change configurations](../operations/projects/control-compute-resources.md#config) while using your notebook. The state of the interpreter, variables, and computation results will be saved.

#### How do I resolve the error: <q>The following variables can't be serialized</q>? {#error-variables}

The error says that the system can't serialize the variable. It means that you can't move it when switching to another resource configuration. To avoid the error, run all your computations in the same configuration.

#### If I delete a running cell, will computations stop? {#delete-cell}

No, computations will continue even if you delete a cell from the notebook. Before deleting a cell, stop it. If you have deleted a running cell, stop ongoing computations. To do this, select **File ⟶ Stop IDE executions** in {{ jlab }}Lab and click **Stop IDE executions** in the **Running operations** widget on the project page.
