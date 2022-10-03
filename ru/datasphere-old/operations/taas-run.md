# Запуск распределенного обучения

{% note info %}

Возможность распределенного обучения находится на стадии [Preview](../../overview/concepts/launch-stages.md). Доступ предоставляется по запросу в техническую поддержку.

{% endnote %}

{% include [link-on-new-ui-datasphere-in-old-ui](../../_includes/datasphere/datasphere-old-note.md) %}

[Распределенное обучение](../concepts/taas.md) поддерживает PyTorch и PyTorch Lighting. По умолчанию в {{ ml-platform-name }} установлена версия PyTorch 1.6.0. Обновите ее до версии 1.9.1, чтобы {{ taas }} мог работать корректно:

```bash
%pip install torch==1.9.1+cu111 torchvision==0.10.1+cu111 torchaudio==0.9.1 -f https://download.pytorch.org/whl/torch_stable.html
```

{% note warning %}

На стадии Preview распределенное обучение доступно только на ВМ [конфигурации g2.8](../concepts/configurations.md). Запросите доступ к данной конфигурации в [технической поддержке]({{ link-console-support }}).

{% endnote %}

## {{ taas }} на нескольких GPU {#few-gpus}

1. Подготовьте код обучения и опишите загрузку данных (DataLoader) для PyTorch. 

1. Если вы используете PyTorch, инициализируйте распределенное обучение на основе набора переменных окружения:
   
   ```python
   torch.distributed.init_process_group(backend='nccl', init_method='env://')
   ```
   
   Если вы используете PyTorch Lightning, пропустите этот шаг: дополнительная инициализация не требуется. 

1. В отдельной ячейке вызовите служебную команду `#pragma taas`. Укажите количество GPU, между которыми будет распределено обучение.
   
   ```bash
   #!g2.8
   #pragma taas --gpus 8
   
   <запуск обучения>
   ```
   
При запуске обучения в нескольких процессах хранилище проекта {{ ml-platform-name }} будет доступно для записи только тому процессу, для которого переменная окружения `RANK=0`. Учитывайте это при сохранении модели в процессе обучения. 

## {{ taas }} с распределенной доставкой данных {#distributed-dataloader}

Помимо распределения обучения между несколькими GPU {{ taas }} предоставляет возможность оптимизировать загрузку и подготовку данных для обучения. Это может быть полезно, если большие данные находятся в облачном хранилище, скорость доступа к которому серьезно уступает скорости обработки этих данных.

1. Опишите загрузчик данных (DataLoader) PyTorch в отдельной ячейке и зарегистрируйте его. 

   ```python
   import taas
   
   data_loader=DataLoader(DataSet)
   taas.register(data_loader)
   ```

   Зарегистрированный загрузчик данных будет запущен на нескольких ВМ c1.4 и подготовит данные до запуска обучения на дорогих ресурсах GPU. После подготовки данные будут доставлены на ВМ с GPU, а загрузка может продолжиться параллельно с вычислениями и обучением.

   Для отмены регистрации вызовите:
   
   ```python
   taas.unregister(data_loader)
   ```
   
1. Запустите обучение:

   ```python
   #!g2.8
   #pragma taas --gpus 8 --cpus 1 --units 20480000
   
    <запуск обучения>
   ```

   * `gpus` — количество GPU. Параметр может принимать значения: 
     * 8 — одна ВМ 
     * 16 — две ВМ
     * 32 — четыре ВМ
   * `cpus` — количество ВМ c1.4, на которых будет запущен каждый зарегистрированный загрузчик данных. Значение параметра — от 1 до 8.
   * `units` — количество элементов, которое необходимо извлечь из загрузчика данных.

## Примеры {#examples}

### Распределенное обучение на нескольких GPU {#pytorch-gpu}

1. [Создайте новый пустой проект](./projects/create.md) в **{{ ml-platform-name }}** и откройте его.
1. Создайте новый ноутбук, выбрав в меню **File** → **New** → **Notebook**.
1. Установите библиотеку, необходимую для работы c {{ taas }}:
    1. Во вкладке с ноутбуком выберите первую ячейку и скопируйте туда команду для установки библиотеки:
    
    ```bash
    %pip install taas
    ```

    1. Запустите эту ячейку, выбрав в меню **Run** → **Run Selected Cells** (также можно использовать сочетание клавиш **Shift** + **Enter**). Дождитесь завершение установки, результат будет отображен в поле под ячейкой.
1. Импортируйте необходимые библиотеки:
    
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

1. Опишите нейронную сеть:

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

1. Перейдите в следующую ячейку и добавьте функцию для обучения нейронной сети на GPU. 

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

1. Добавьте функцию тестирования нейронной сети на GPU:

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

1. Запустите обучение нейронной сети:

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

    Где:

    * `#!g2.8` — префикс [конфигурации](../concepts/configurations.md) вычислительных ресурсов, на которых будет развернуто обучение.
      
      {% note warning %}

      На стадии Preview распределенное обучение доступно только на ВМ [конфигурации g2.8](../concepts/configurations.md). 

      {% endnote %}

    * `#pragma taas --gpus 8` — префикс количества GPU, которые будут задействованы в обучении. `--gpus 8` — максимальное количество GPU для ВМ в конфигурации g2.8. Если указать больше GPU, будет развернуто несколько ВМ.
