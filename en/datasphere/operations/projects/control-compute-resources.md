---
title: How to select computing resources
description: Follow this guide to configure your computing resources.
---

# Selecting computing resources

When you run your first computations, you can select a [configuration](../../concepts/configurations.md) for your notebook from the list of configurations available in the project. You will see utilization rates for each type of VM configurations. VMs marked in green are ready to start as soon as you select them. Those marked in yellow require further setup. The start time of such VMs will be longer. The configurations marked in red are currently in use and may take indefinite time to become available, as another user must release them first.

{% include [include](../../../_includes/datasphere/ui-before-begin.md) %}

## Changing the configuration {#config}

You cannot change the configuration of computing resources while preserving the interpreter state. However, you can add another configuration to your project and rerun the computations.

#### See also {#see-also}

* [{#T}](install-dependencies.md)
* [{#T}](export.md)
