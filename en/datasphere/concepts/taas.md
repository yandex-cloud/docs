# Distributed training in {{ ml-platform-name }}

{% note info %}

The distributed training feature is at the [Preview](../../overview/concepts/launch-stages.md) stage. To access the feature, contact support.

{% endnote %}

{{ taas-name }} lets you quickly train a model using a <q>turnkey</q> distributed training solution. You don't need any special skills to use {{ taas }} in {{ ml-platform-name }}: the platform will help you optimally scale your training model designed for one GPU across multiple accelerators of one or more virtual machine instances.

{% note info %}

Distributed training across multiple VMs may be limited by the network bandwidth between VMs.

{% endnote %}

## Distributed data delivery for training {#distributed-dataloader}

When you train a model on a GPU-enabled instance, the graphics accelerator is often idle because preparing and reading data takes longer than computing itself. {{ taas }} solves this problem by loading and processing the training data on separate, cheaper CPU-enabled instances. You can run data preparation on a CPU-enabled VM and data training on a GPU-enabled VM both in sequence and in parallel: when some of the data is prepared, it's delivered to the GPU-enabled VM.

{{ taas }} lets you use your GPU efficiently and save money on training resource-intensive models.

To implement distributed data delivery, the PyTorch data loader must meet the following criteria:

* It must be created in a separate cell.
* It must be registered.
* It must be infinitely iterable (be <q>unlimited</q>).

#### See also

* [{#T}](../operations/taas-run.md)

