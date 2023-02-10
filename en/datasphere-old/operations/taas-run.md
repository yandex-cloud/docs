# Launching distributed training

{% note info %}

The distributed training feature is at the [Preview](../../overview/concepts/launch-stages.md) stage. To access the feature, contact support.

{% endnote %}

{% include [link-on-new-ui-datasphere-in-old-ui](../../_includes/datasphere/datasphere-old-note.md) %}

[Distributed training](../concepts/taas.md) supports PyTorch and PyTorch Lighting. By default, PyTorch version 1.6.0 is installed in {{ ml-platform-name }}. Update it to version 1.9.1 so that {{ taas }} runs correctly:

```bash
%pip install torch==1.9.1+cu111 torchvision==0.10.1+cu111 torchaudio==0.9.1 -f https://download.pytorch.org/whl/torch_stable.html
```

{% note warning %}

At the Preview stage, distributed training is only available on [g2.8](../concepts/configurations.md) instances. Request access to this configuration from [technical support]({{ link-console-support }}).

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

1. Start training:

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

## Examples {#examples}

### Distributed training using several GPUs {#pytorch-gpu}

1. [Create a new empty project](./projects/create.md) in **{{ ml-platform-name }}** and open it.
1. Create a new notebook by selecting **File** → **New** → **Notebook** from the menu.
1. Install the library required by {{ taas }}:
   1. On the notebook tab, select the first cell and copy the library install command into it:

   ```bash
   %pip install taas
   ```

   1. Run this cell. To do this, choose **Run** → **Run Selected Cells** or press **Shift**+**Enter**. Wait for the installation to complete. The result will be displayed in the field underneath the cell.
1. Import the required libraries:

   ```python
   import torch
   import torch.nn as nn
   import torch.nn.functional as F
   import torch.optim as optim
   from torchvision import datasets, transforms
   from torch.optim.lr_scheduler import StepLR
   import os
   import taas
   import time
   ```

1. Describe the neural network:

   ```python
   class Net(nn.Module):
       def __init__(self):
           super(Net, self).__init__()
           self.conv1 = nn.Conv2d(1, 32, 3, 1)
           self.conv2 = nn.Conv2d(32, 64, 3, 1)
           self.dropout1 = nn.Dropout2d(0.25)
           self.dropout2 = nn.Dropout2d(0.5)
           self.fc1 = nn.Linear(9216, 128)
           self.fc2 = nn.Linear(128, 10)
           self.batchnorm = nn.BatchNorm1d(128)

       def forward(self, x):
           x = self.conv1(x)
           x = F.relu(x)
           x = self.conv2(x)
           x = F.relu(x)
           x = F.max_pool2d(x, 2)
           x = self.dropout1(x)
           x = torch.flatten(x, 1)
           x = self.fc1(x)
           x = self.batchnorm(x)
           x = F.relu(x)
           x = self.dropout2(x)
           x = self.fc2(x)
           output = F.log_softmax(x, dim=1)
           return output
   ```

1. Select the next cell and add a function to train the neural network using the GPUs.

   ```python
   def train(model, device, train_loader, optimizer, epoch):
       model.train()
       for batch_idx, (data, target) in enumerate(train_loader):
           data, target = data.to(device), target.to(device)
           optimizer.zero_grad()
           output = model(data)
           loss = F.nll_loss(output, target)
           loss.backward()
           optimizer.step()
           if batch_idx % 200 == 0:
               print('Train Epoch: {} [{}/{} ({:.0f}%)]\tLoss: {:.6f}'.format(
                   epoch, batch_idx * len(data), len(train_loader.dataset),
                   100. * batch_idx / len(train_loader), loss.item()))
   ```

1. Add a function to test the neural network using the GPUs:

   ```python
   def test(model, device, test_loader):
       model.eval()
       test_loss = 0
       correct = 0
       with torch.no_grad():
           for data, target in test_loader:
               data, target = data.to(device), target.to(device)
               output = model(data)
               test_loss += F.nll_loss(output, target, reduction='sum').item()  # sum up batch loss
               pred = output.argmax(dim=1, keepdim=True)  # get the index of the max log-probability
               correct += pred.eq(target.view_as(pred)).sum().item()

       test_loss /= len(test_loader.dataset)

       print('\nTest set: Average loss: {:.4f}, Accuracy: {}/{} ({:.0f}%)\n'.format(
           test_loss, correct, len(test_loader.dataset),
           100. * correct / len(test_loader.dataset)))
   ```

1. Launch neural network training:

   ```python
   #!g2.8
   #pragma taas --gpus 8
   torch.manual_seed(1)

   device = torch.device("cuda")

   train_loader = torch.utils.data.DataLoader(
       datasets.MNIST('../data', train=True, download=True,
                      transform=transforms.Compose([
                          transforms.ToTensor(),
                          transforms.Normalize((0.1307,), (0.3081,))
                      ])),
       batch_size=64, shuffle=True, num_workers=1)
   test_loader = torch.utils.data.DataLoader(
       datasets.MNIST('../data', train=False, transform=transforms.Compose([
                          transforms.ToTensor(),
                          transforms.Normalize((0.1307,), (0.3081,))
                      ])),
       batch_size=1000, shuffle=True, num_workers=1)

   model = Net().to(device)

   if torch.cuda.device_count() > 1:
       print("We have available ", torch.cuda.device_count(), "GPUs!")
       model = nn.DataParallel(model)

   optimizer = optim.Adadelta(model.parameters(), lr=1.0)

   scheduler = StepLR(optimizer, step_size=1, gamma=0.7)

   start_train_time = time.time()
   for epoch in range(1, 10):
       train(model, device, train_loader, optimizer, epoch)
       test(model, device, test_loader)
       scheduler.step()

   finish_train_time = time.time()
   print(f"Total time: {round(finish_train_time - start_train_time, 2)} sec", flush=True)

   torch.save(model.state_dict(), "mnist_cnn.pt")
   ```

   Where:

   * `#!g2.8` is a [configuration](../concepts/configurations.md) prefix for the computing resources that will be used for the training.

      {% note warning %}

      At the Preview stage, distributed training is only available on [g2.8](../concepts/configurations.md) instances.

      {% endnote %}

   * `#pragma taas --gpus 8` is a prefix for the number of GPUs to be involved in the training. `--gpus 8` is the maximum number of VM GPUs in the g2.8 configuration. If you specify more GPUs, several VMs will be deployed.
