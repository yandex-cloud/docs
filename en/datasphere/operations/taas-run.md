# Launching distributed training

{% note info %}

The distributed training feature is at the [Preview](../../overview/concepts/launch-stages.md) stage. To access the feature, contact support.

{% endnote %}

[Distributed training](../concepts/taas.md) supports PyTorch and PyTorch Lighting. By default, PyTorch version 1.6.0 is installed in {{ ml-platform-name }}. Update it to version 1.9.1 so that {{ taas }} runs correctly:

```bash
%pip install torch==1.9.1+cu111 torchvision==0.10.1+cu111 torchaudio==0.9.1 -f https://download.pytorch.org/whl/torch_stable.html
```

{% note warning %}

At the Preview stage, distributed training is only available on [g2.8](../concepts/configurations.md) instances.

{% endnote %}

## {{ taas }} on multiple GPUs {#few-gpus}

1. Prepare the training code and define the DataLoader for PyTorch.

1. If you are using PyTorch, initialize distributed training based on the environment variables:

   ```python
   torch.distributed.init_process_group(backend='nccl', init_method='env://')
   ```

   If you are using PyTorch Lightning, skip this step: you don't need any additional initialization.

1. In a separate cell, call the `#pragma taas` service command. Enter the number of GPUs to distribute training among.

   ```bash
   #!g2.8
   #pragma taas --gpus 8

   <launch training>
   ```

When you run training using multiple processes, only the process with the `RANK=0` environment variable will be able to write to the {{ ml-platform-name }} project repository. Keep this in mind when saving the model during your training process.

## {{ taas }} with distributed data delivery {#distributed-dataloader}

Besides distributed training across multiple GPUs, {{ taas }} provides an option to optimize data loading and prepare the data for training. This may be useful if you store large amounts of data in cloud storage that accesses data substantially slower than you process it.

1. Define the PyTorch DataLoader in a separate cell and register it.

   ```python
   import taas

   data_loader=DataLoader(DataSet)
   taas.register(data_loader)
   ```

   The registered DataLoader will be launched on multiple c1.4 VM instances to prepare the data before training is started on costly GPU resources. After preparation, the data is delivered to the GPU-enabled VM, and loading can now continue in parallel with calculations and training.

   To cancel registration, call:

   ```python
   taas.unregister(data_loader)
   ```

2. Start training:

   ```python
   #!g2.8
   #pragma taas --gpus 8 --cpus 1 --units 20480000

    <launch training>
   ```

   * `gpus`: Number of GPUs. The parameter can take the values:
      * 8: One VM
      * 16: Two VMs
      * 32: Four VMs
   * `cpus`: The number of c1.4 VMs on which each registered data loader will be launched. The parameter value is from 1 to 8.
   * `units`: The number of elements to be extracted from the data loader.

