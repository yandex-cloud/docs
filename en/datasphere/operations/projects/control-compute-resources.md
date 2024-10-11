---
title: How to select computing resources
description: Follow this guide to configure your computing resources.
---

# Selecting computing resources

When you run the first computations, you can select a [configuration](../../concepts/configurations.md) for a notebook from the list of configurations available in the project. You will see utilization rates for every type of VM configurations. The VMs marked green can start immediately once selected. The configurations marked yellow require additional preparation. The start time of such VMs will be longer. The configurations marked red are busy at the moment. They may take indefinite time to allocate, because another user must release the VM first.

{% include [include](../../../_includes/datasphere/ui-before-begin.md) %}

## Change the configuration {#config}

You cannot change the configuration of computing resources while preserving the interpreter status. However, you can add another configuration to a project and run computations again.

#### See also {#see-also}

* [{#T}](install-dependencies.md)
* [{#T}](export.md)
