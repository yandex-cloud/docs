В [{{ ml-platform-full-name }}]({{ link-datasphere-main }}) с помощью API можно запускать исполнение кода, не заходя в проект. Это может быть полезно, если нужно автоматизировать рутинные операции, дообучить нейросеть или развернуть сервис, который не требует быстрого ответа по API.

В практическом руководстве на примере простой сверточной нейронной сети [CNN](https://ru.wikipedia.org/wiki/Свёрточная_нейронная_сеть) показано, как организовать эксплуатацию модели, обученной в {{ ml-platform-name }}, с помощью [{{ sf-full-name }}](../../functions/index.yaml). Результат работы модели будет записываться в хранилище проекта {{ ml-platform-name }}.

Если вы хотите развернуть сервис, который будет возвращать результаты по API, см. [{#T}](../../datasphere/tutorials/node-from-cell.md).

{% note info %}

Пример будет работать только в режиме {{ ml-platform-name }} [{{ ds }}](../../datasphere/concepts/project.md#serverless). В {{ ml-platform-name }} [{{ dd }}](../../datasphere/concepts/project.md#dedicated) работа с API недоступна.

{% endnote %}

1. [Подготовьте инфраструктуру](#infra).
1. [Подготовьте ноутбуки](#set-notebooks).
1. [Обучите нейросеть](#ai-training).
1. [Загрузите архитектуру модели и веса](#load-data).
1. [Создайте {{ sf-name }}](#create-function).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin-datasphere.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость реализации регулярных запусков входят:

* плата за использование [вычислительных ресурсов {{ ml-platform-name }}](../../datasphere/pricing.md);
* плата за количество вызовов функции [{{ sf-name }}](../../functions/pricing.md).


## Подготовьте инфраструктуру {#infra}

{% include [intro](../../_includes/datasphere/infra-intro.md) %}

{% include [intro](../../_includes/datasphere/federation-disclaimer.md) %}

### Создайте каталог {#create-folder}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) выберите облако и нажмите кнопку ![create](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.console-dashboard.button_action-create-folder }}**.
   1. Введите имя каталога, например, `data-folder`.
   1. Нажмите кнопку **{{ ui-key.yacloud.iam.cloud.folders-create.button_create }}**.

{% endlist %}

### Создайте сервисный аккаунт для проекта {{ ml-platform-name }} {#create-sa}

Для доступа к проекту {{ ml-platform-name }} из функции {{ sf-name }} вам понадобится [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) с ролью `{{ roles-datasphere-project-editor }}`.

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) перейдите в каталог `data-folder`.
   1. На вкладке **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}** нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
   1. Введите имя сервисного аккаунта, например, `datasphere-sa`.
   1. Нажмите **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** и назначьте сервисному аккаунту роль `{{ roles-datasphere-project-editor }}`.
   1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

{% endlist %}

### Добавьте сервисный аккаунт в проект {#sa-to-project}

Чтобы сервисный аккаунт мог запускать проект {{ ml-platform-name }}, добавьте его в список участников проекта:

1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
1. На вкладке **{{ ui-key.yc-ui-datasphere.project-page.tab.members }}** нажмите **{{ ui-key.yc-ui-datasphere.common.add-member }}**.
1. Выберите аккаунт `datasphere-sa` и нажмите **{{ ui-key.yc-ui-datasphere.common.add }}**.

## Подготовьте ноутбуки и архитектуру нейросети {#set-notebooks}

Склонируйте Git-репозиторий, в котором находятся ноутбуки с примерами обучения и тестирования модели машинного обучения:
   1. В верхнем меню нажмите **Git** и выберите **Clone**.
   1. В открывшемся окне введите URI репозитория `https://github.com/yandex-cloud-examples/yc-datasphere-batch-execution.git` и нажмите кнопку **Clone**.
   
   Дождитесь окончания клонирования, это может занять некоторое время. Папка cклонированного репозитория появится в разделе ![folder](../../_assets/datasphere/jupyterlab/folder.svg) **File Browser**.

В репозитории содержатся два ноутбука и архитектура нейросети:

* `train_classifier.ipynb` — для скачивания обучающей выборки датасета `CIFAR10` и обучения простой нейронной сети;
* `test_classifier.ipynb` — для тестирования модели;
* `my_nn_model.py` — архитектура нейросети. Для классификации на вход нейросети подаются трехканальные изображения. Она содержит два сверточных слоя с `maxpool` слоем между ними и три линейных слоя:

    ```python
    import torch.nn as nn
    import torch.nn.functional as F
    import torch

    class Net(nn.Module):
        def __init__(self):
            super().__init__()
            self.conv1 = nn.Conv2d(3, 6, 5)
            self.pool = nn.MaxPool2d(2, 2)
            self.conv2 = nn.Conv2d(6, 16, 5)
            self.fc1 = nn.Linear(16 * 5 * 5, 120)
            self.fc2 = nn.Linear(120, 84)
            self.fc3 = nn.Linear(84, 10)

        def forward(self, x):
            x = self.pool(F.relu(self.conv1(x)))
            x = self.pool(F.relu(self.conv2(x)))
            x = torch.flatten(x, 1) # flatten all dimensions except batch
            x = F.relu(self.fc1(x))
            x = F.relu(self.fc2(x))
            x = self.fc3(x)
            return x
    ```

## Обучите нейросеть {#ai-training}

В ноутбуке `train_classifier.ipynb` вы скачаете обучающую выборку датасета `CIFAR10` и обучите простую нейронную сеть. Веса обученной модели сохраняются в хранилище проекта под названием `cifar_net.pth`.

1. {% include [include](../../_includes/datasphere/ui-before-begin.md) %}

1. Импортируйте библиотеки, необходимые для обучения модели:

    ```python
    import torch
    import torchvision
    import torchvision.transforms as transforms
    import torch.optim as optim
    from my_nn_model import Net
    ```

1. Загрузите датасет `CIFAR10` для обучения модели. Изображения в датасете относятся к 10 категориям:

    ```python
    transform = transforms.Compose(
        [transforms.ToTensor(),
        transforms.Normalize((0.5, 0.5, 0.5), (0.5, 0.5, 0.5))])

    batch_size = 4

    trainset = torchvision.datasets.CIFAR10(root='./data', train=True,
                                            download=True, transform=transform)
    trainloader = torch.utils.data.DataLoader(trainset, batch_size=batch_size,
                                            shuffle=True, num_workers=2)

    classes = ('plane', 'car', 'bird', 'cat',
            'deer', 'dog', 'frog', 'horse', 'ship', 'truck')
    ```

1. Выведите на экран примеры изображений, которые содержатся в датасете:

    ```python
    import matplotlib.pyplot as plt
    import numpy as np

    def imshow(img):
        img = img / 2 + 0.5     # unnormalize
        npimg = img.numpy()
        plt.imshow(np.transpose(npimg, (1, 2, 0)))
        plt.show()

    dataiter = iter(trainloader)
    images, labels = next(dataiter)
    imshow(torchvision.utils.make_grid(images))
    print(' '.join(f'{classes[labels[j]]:5s}' for j in range(batch_size)))
    ```

1. Создайте функцию потерь и оптимизатор, необходимые для обучения нейросети:

    ```python
    #!g1.1
    device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')
    net = Net()
    net.to(device)

    criterion = nn.CrossEntropyLoss()
    optimizer = optim.SGD(net.parameters(), lr=0.001, momentum=0.9)
    ```

1. Запустите процесс обучения на 5 эпохах: 

    ```python
    #!g1.1
    for epoch in range(5): 
        running_loss = 0.0
        for i, data in enumerate(trainloader, 0):
            inputs, labels = data[0].to(device), data[1].to(device)

            optimizer.zero_grad()

            outputs = net(inputs)
            loss = criterion(outputs, labels)
            loss.backward()
            optimizer.step()

            running_loss += loss.item()
            if i % 2000 == 1999:
                print(f'[{epoch + 1}, {i + 1:5d}] loss: {running_loss / 2000:.3f}')
                running_loss = 0.0

    print('Finished Training')
    ```

1. Сохраните полученную модель на проектный диск:

    ```python
    #!g1.1
    torch.save(net.state_dict(), './cifar_net.pth')
    ```

## Загрузите архитектуру модели и веса {#load-data}

В ноутбуке `test_classifier.ipynb` вы загрузите архитектуру модели и веса, созданные во время работы файла [`train_classifier.ipynb`](#ai-training). Загруженная модель используется для прогнозов на тестовой выборке. Результаты прогноза сохраняются в файле `test_predictions.csv`.

1. {% include [include](../../_includes/datasphere/ui-before-begin.md) %}

1. Импортируйте библиотеки, необходимые для работы с моделью и создания прогнозов:

    ```python
    #!g1.1
    import torch
    import torchvision
    import torchvision.transforms as transforms
    from my_nn_model import Net
    import pandas as pd
    ```

1. Подготовьте объекты, которые позволят обращаться к тестовой выборке:

    ```python
    #!g1.1
    transform = transforms.Compose(
        [transforms.ToTensor(),
        transforms.Normalize((0.5, 0.5, 0.5), (0.5, 0.5, 0.5))])

    batch_size = 4

    testset = torchvision.datasets.CIFAR10(root='./data', train=False,
                                        download=True, transform=transform)
    testloader = torch.utils.data.DataLoader(testset, batch_size=batch_size,
                                            shuffle=False, num_workers=2)

    classes = ('plane', 'car', 'bird', 'cat',
            'deer', 'dog', 'frog', 'horse', 'ship', 'truck')
    ```

1. Определите конфигурацию ресурсов, на которой будет выполняться модель — СPU или GPU:

    ```python
    #!g1.1
    device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')
    ```

1. Загрузите веса обученной модели и сделайте прогнозы на тестовой выборке:

    ```python
    #!g1.1
    net = Net()
    net.to(device)
    net.load_state_dict(torch.load('./cifar_net.pth'))

    predictions = []
    predicted_labels = []
    with torch.no_grad():
        for data in testloader:
            images, labels = data[0].to(device), data[1].to(device)
            outputs = net(images)
            _, predicted = torch.max(outputs.data, 1)
            predictions.append(predicted.tolist())
            predicted_labels.append([classes[predicted[j]] for j in range(batch_size)])
    ```

1. Сохраните прогнозы в формате `pandas.DataFrame`:

    ```python
    #!g1.1
    final_pred = pd.DataFrame({'class_idx': [item for sublist in predictions for item in sublist],
                               'class': [item for sublist in predicted_labels for item in sublist]})
    ```

1. Сохраните прогнозы модели в файл:

    ```python
    #!g1.1
    final_pred.to_csv('test_predictions.csv')
    ```

## Создайте {{ sf-name }} {#create-function}

Чтобы запускать исполнение ячеек, не открывая {{ jlab }}Lab, вам понадобится {{ sf-name }}, которая будет инициировать запуск вычислений в ноутбуке по API.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать функцию.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
    1. Введите имя функции, например, `ai-function`.
    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-function }}**.

{% endlist %}

### Создайте версию {{ sf-name }} {#create-function-ver}

[Версия](../../functions/concepts/function.md#version) содержит код функции, параметры запуска и все необходимые зависимости.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится функция.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. Выберите функцию, версию которой хотите создать.
    1. В разделе **{{ ui-key.yacloud.serverless-functions.item.overview.label_title-latest-version }}** нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.overview.button_editor-create }}**.
    1. Выберите среду выполнения **Python**. Не выбирайте опцию **{{ ui-key.yacloud.serverless-functions.item.editor.label_with-template }}**.
    1. Выберите способ **{{ ui-key.yacloud.serverless-functions.item.editor.value_method-editor }}**.
    1. Нажмите **{{ ui-key.yacloud.serverless-functions.item.editor.create-file }}** и введите имя файла, например `index`.
    1. Введите код функции, подставив идентификаторы вашего проекта и ноутбука `test_classifier.ipynb`:
    
        ```python
        import requests
    
        def handler(event, context):

            url = 'https://datasphere.api.cloud.yandex.net/datasphere/v2/projects/<идентификатор_проекта>:execute'
            body = {"notebookId": "<идентификатор_ноутбука>"}
            headers = {"Content-Type" : "application/json",
                       "Authorization": "Bearer {}".format(context.token['access_token'])}
            resp = requests.post(url, json = body, headers=headers)

            return {
            'body': resp.json(),
            }
        ```

       Где:

       * `<идентификатор_проекта>` — идентификатор проекта {{ ml-platform-name }}, который расположен на странице проекта под названием.
       * `<идентификатор_ноутбука>` — [идентификатор ноутбука](../../datasphere/operations/projects/get-notebook-cell-ids.md#get-notebook-id) `test_classifier.ipynb`.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-params }}** задайте параметры версии:
       * **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}**: `index.handler`.
       * **{{ ui-key.yacloud.forms.label_service-account-select }}**: `datasphere-sa`.
    1. В правом верхнем углу нажмите **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

{% endlist %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:
* [Удалите](../../functions/operations/function/function-delete.md) функцию.
* [Удалите](../../datasphere/operations/projects/delete.md) проект.
