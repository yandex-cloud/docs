In [{{ ml-platform-full-name }}]({{ link-datasphere-main }}), you can run code using the API without opening your project. This might be handy when you need to automate routine operations, additionally train a neural network, or deploy a service that does not require quick responses via the API.

Using a simple convolutional neural network ([CNN](https://en.wikipedia.org/wiki/Convolutional_neural_network)) as an example, this tutorial describes how to deploy a model trained in {{ ml-platform-name }} with [{{ sf-full-name }}](../../functions/index.yaml). The model's output will be saved to {{ ml-platform-name }} project storage.

For information on how to deploy a service returning results via the API, see [{#T}](../../datasphere/tutorials/node-from-docker-fast-api.md).

1. [Prepare your infrastructure](#infra).
1. [Prepare notebooks](#set-notebooks).
1. [Train a neural network](#ai-training).
1. [Upload the model architecture and weights](#load-data).
1. [Create a {{ sf-name }}](#create-function).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin-datasphere.md) %}

### Required paid resources {#paid-resources}

The cost of implementing regular runs includes:

* Fee for [{{ ml-platform-name }} computing resource](../../datasphere/pricing.md) usage.
* Fee for the number of [{{ sf-name }}](../../functions/pricing.md) function calls.

## Prepare the infrastructure {#infra}

{% include [intro](../../_includes/datasphere/infra-intro.md) %}

{% include [intro](../../_includes/datasphere/federation-disclaimer.md) %}

### Create a folder {#create-folder}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select a cloud and click ![create](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.console-dashboard.button_action-create-folder }}**.
   1. Give your folder a name, e.g., `data-folder`.
   1. Click **{{ ui-key.yacloud.iam.cloud.folders-create.button_create }}**.

{% endlist %}

### Create a service account for the {{ ml-platform-name }} project {#create-sa}

To access a {{ ml-platform-name }} project from a {{ sf-name }} function, you need a [service account](../../iam/concepts/users/service-accounts.md) with the `{{ roles-datasphere-project-editor }}` role.

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), go to `data-folder`.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
   1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
   1. Enter a name for the service account, e.g., `datasphere-sa`.
   1. Click **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and assign the service account the `{{ roles-datasphere-project-editor }}` role.
   1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

{% endlist %}

### Add the service account to a project {#sa-to-project}

To enable the service account to run a {{ ml-platform-name }} project, add it to the list of project members:

1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
1. In the **{{ ui-key.yc-ui-datasphere.project-page.tab.members }}** tab, click **{{ ui-key.yc-ui-datasphere.common.add-member }}**.
1. Select the `datasphere-sa` account and click **{{ ui-key.yc-ui-datasphere.common.add }}**.

## Prepare notebooks and your neural network's architecture {#set-notebooks}

Clone the Git repository containing the notebooks with the examples of the ML model training and testing:
   1. In the top menu, click **Git** and select **Clone**.
   1. In the window that opens, enter `https://github.com/yandex-cloud-examples/yc-datasphere-batch-execution.git` and click **Clone**.
   
   Wait until cloning is complete. It may take some time. You will see the cloned repository folder in the ![folder](../../_assets/datasphere/jupyterlab/folder.svg) **File Browser** section.

The repository contains two notebooks and the neural network architecture:

* `train_classifier.ipynb`: Notebook for downloading a training sample of the `CIFAR10` dataset and training a simple neural network.
* `test_classifier.ipynb`: Notebook for testing the model.
* `my_nn_model.py`: Neural network architecture. For classification, three-dimensional images are input to the neural network. It contains two convolutional layers with the `maxpool` layer between them and three linear layers:

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

## Train a neural network {#ai-training}

In the `train_classifier.ipynb` notebook, you will download a training sample of the `CIFAR10` dataset and train a simple neural network. The trained model's weights will be saved to the project storage named `cifar_net.pth`.

1. {% include [include](../../_includes/datasphere/ui-before-begin.md) %}

1. Import the libraries required to train the model:

    ```python
    import torch
    import torchvision
    import torchvision.transforms as transforms
    import torch.optim as optim
    from my_nn_model import Net
    ```

1. Upload the `CIFAR10` dataset to train the model. Images in the dataset are of 10 categories:

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

1. Output sample images from the dataset:

    ```python
    import matplotlib.pyplot as plt
    import numpy as np

    def imshow(img):
        img = img / 2 + 0.5 # unnormalize
        npimg = img.numpy()
        plt.imshow(np.transpose(npimg, (1, 2, 0)))
        plt.show()

    dataiter = iter(trainloader)
    images, labels = next(dataiter)
    imshow(torchvision.utils.make_grid(images))
    print(' '.join(f'{classes[labels[j]]:5s}' for j in range(batch_size)))
    ```

1. Create a loss function and an optimizer required to train the neural network:

    ```python
    device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')
    net = Net()
    net.to(device)

    criterion = nn.CrossEntropyLoss()
    optimizer = optim.SGD(net.parameters(), lr=0.001, momentum=0.9)
    ```

1. Run training on five epochs:

    ```python
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

1. Save the resulting model to the project disk:

    ```python
    torch.save(net.state_dict(), './cifar_net.pth')
    ```

## Upload the model architecture and weights {#load-data}

In the `test_classifier.ipynb` notebook, you will upload the model architecture and weights created while running the [`train_classifier.ipynb`](#ai-training) file. The uploaded model is used for predictions based on the test sample. Prediction results are saved to a file named `test_predictions.csv`.

1. {% include [include](../../_includes/datasphere/ui-before-begin.md) %}

1. Import the libraries required to run the model and make predictions:

    ```python
    import torch
    import torchvision
    import torchvision.transforms as transforms
    from my_nn_model import Net
    import pandas as pd
    ```

1. Prepare the objects that will enable you to access the test sample:

    ```python
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

1. Set the resource configuration to run the model on, СPU or GPU:

    ```python
    device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')
    ```

1. Upload the trained model's weights and make predictions based on the test sample:

    ```python
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

1. Save the predictions in `pandas.DataFrame` format:

    ```python
    final_pred = pd.DataFrame({'class_idx': [item for sublist in predictions for item in sublist],
                               'class': [item for sublist in predicted_labels for item in sublist]})
    ```

1. Save the model predictions to a file:

    ```python
    final_pred.to_csv('/home/jupyter/datasphere/project/test_predictions.csv')
    ```

## Create a {{ sf-name }} {#create-function}

To run cells without opening {{ jlab }}Lab, you need a {{ sf-name }} that will trigger computations in a notebook via the API.

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder where you want to create a function.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. Click **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
    1. Enter a name for the function, e.g., `ai-function`.
    1. Click **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-function }}**.

{% endlist %}

### Create a {{ sf-name }} version {#create-function-ver}

[Versions](../../functions/concepts/function.md#version) contain the function code, run parameters, and all required dependencies.

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder containing the function.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. Select the function to create a version of.
    1. Under **{{ ui-key.yacloud.serverless-functions.item.overview.label_title-latest-version }}**, click **{{ ui-key.yacloud.serverless-functions.item.overview.button_editor-create }}**.
    1. Select the **Python** runtime environment. Do not select the **{{ ui-key.yacloud.serverless-functions.item.editor.label_with-template }}** option.
    1. Choose the **{{ ui-key.yacloud.serverless-functions.item.editor.value_method-editor }}** method.
    1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.create-file }}** and specify a file name, e.g., `index`.
    1. Enter the function code by inserting your project ID and the absolute path to the project notebook:
    
        ```python
        import requests
    
        def handler(event, context):

            url = 'https://datasphere.{{ api-host }}/datasphere/v2/projects/<project_ID>:execute'
            body = {"notebookId": "/home/jupyter/datasphere/project/test_classifier.ipynb"}
            headers = {"Content-Type" : "application/json",
                       "Authorization": "Bearer {}".format(context.token['access_token'])}
            resp = requests.post(url, json = body, headers=headers)

            return {
            'body': resp.json(),
            }
        ```

       Where:
       * `<project_ID>`: ID of the {{ ml-platform-name }} project displayed on the project page under its name.
       * `notebookId`: Absolute path to the project notebook.

    1. Under **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-params }}**, set the version parameters:
       * **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}**: `index.handler`.
       * **{{ ui-key.yacloud.forms.label_service-account-select }}**: `datasphere-sa`.
    1. In the top-right corner, click **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

{% endlist %}

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:
* [Delete](../../functions/operations/function/function-delete.md) the function.
* [Delete](../../datasphere/operations/projects/delete.md) the project.
