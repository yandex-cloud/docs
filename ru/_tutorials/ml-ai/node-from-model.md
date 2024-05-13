# Развертывание сервиса из модели ONNX

{{ ml-platform-name }} позволяет разворачивать и эксплуатировать сервисы на основе обученной в проекте [модели](../../datasphere/concepts/models/index.md).

В этом практическом руководстве вы развернете сервис из модели в формате ONNX. Модель `fast-neural-style-mosaic-onnx` преобразует изображение в соответствии с заданным стилем. Модель взята из [хранилища моделей ONNX](https://github.com/onnx/models/).

1. [Подготовьте инфраструктуру](#infra).
1. [Создайте модель](#create-model).
1. [Создайте ноду](#create-node).
1. [Проверьте работу развернутого сервиса](#check-node).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin-datasphere.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость развертывания сервиса из модели входят:

* плата за постоянно запущенные инстансы ноды (см. [тарифы {{ ml-platform-name }}](../../datasphere/pricing.md));
* плата за запуск ячеек с кодом для проверки работы развернутого сервиса.

## Подготовьте инфраструктуру {#infra}

{% include [intro](../../_includes/datasphere/infra-intro.md) %}

{% include [intro](../../_includes/datasphere/federation-disclaimer.md) %}

### Создайте каталог {#create-folder}

Создайте каталог, в котором вы развернете всю необходимую инфраструктуру, а ваш сервис будет хранить логи.

{% note info %}

В примере инфраструктура {{ yandex-cloud }} и развернутый сервис работают в одном каталоге {{ yandex-cloud }}, однако это не обязательно.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) выберите облако и нажмите кнопку ![create](../../_assets/console-icons/plus.svg)**{{ ui-key.yacloud.component.console-dashboard.button_action-create-folder }}**.
   1. Введите имя каталога, например `data-folder`.
   1. Нажмите кнопку **{{ ui-key.yacloud.iam.cloud.folders-create.button_create }}**.

{% endlist %}

### Создайте сервисный аккаунт для проекта {{ ml-platform-name }} {#create-sa}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. Перейдите в каталог `data-folder`.
   1. На вкладке **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}** нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
   1. Введите имя [сервисного аккаунта](../../iam/concepts/users/service-accounts.md), например `datasphere-sa`.
   1. Нажмите **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** и назначьте сервисному аккаунту [роли](../../iam/concepts/access-control/roles.md):
      * `vpc.user` — для работы с сетью {{ ml-platform-name }}.
      * `datasphere.user` — чтобы отправлять запросы в ноду.

   1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

{% endlist %}

## Создайте модель {#create-model}

Модель `fast-neural-style-mosaic-onnx` — это одна из моделей переноса стиля, разработанная для преобразования изображения под стиль другого изображения.

1. {% include [include](../../_includes/datasphere/ui-before-begin.md) %}

1. Установите модуль `onnx`:

   ```python
   %pip install onnx
   ```

1. Скачайте файл `mosaic.onnx`:

   ```python
   !wget -O "mosaic.onnx" "https://github.com/onnx/models/raw/main/validated/vision/style_transfer/fast_neural_style/model/mosaic-8.onnx"
   ```

1. Загрузите модель в переменную и проверьте ее согласованность:

   ```python
   import onnx

   onnx_model = onnx.load("mosaic.onnx")
   onnx.checker.check_model(onnx_model)
   ```

1. На панели справа выберите ![models](../../_assets/console-icons/nodes-right.svg). В появившемся окне нажмите **Создать модель**.
1. Выберите имя переменной, из которой вы хотите создать модель. 
1. Введите имя модели, например `onnx-model`. 
1. Нажмите кнопку **Создать**.

## Создайте ноду {#create-node}

1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
1. В правом верхнем углу нажмите кнопку **{{ ui-key.yc-ui-datasphere.project-page.project-card.create-resource }}**. Во всплывающем окне выберите **{{ ui-key.yc-ui-datasphere.resources.node }}**.
1. В поле **{{ ui-key.yc-ui-datasphere.new-node.node-form-label.name }}** введите имя ноды.
1. В блоке **{{ ui-key.yc-ui-datasphere.new-node.node-form-label.type }}** укажите тип ресурса — **{{ ui-key.yc-ui-datasphere.common.model }}**.
1. В поле **{{ ui-key.yc-ui-datasphere.common.models }}** выберите модель `onnx-model`.
1. В блоке **{{ ui-key.yc-ui-datasphere.new-node.title.folder }}** выберите каталог `data-folder`.
1. В блоке **{{ ui-key.yc-ui-datasphere.new-node.title.provisioning }}** выберите [конфигурацию](../../datasphere/concepts/configurations.md) вычислительных ресурсов [инстанса](../../datasphere/concepts/deploy/index.md), [зону доступности](../../overview/concepts/geo-scope.md) и идентификатор [подсети](../../vpc/concepts/network.md#subnet) в которых будет размещен инстанс.
1. В блоке **{{ ui-key.yc-ui-datasphere.new-node.title.acl }}** нажмите кнопку ![Add](../../_assets/console-icons/plus.svg) **{{ ui-key.yc-ui-datasphere.new-node.add-acl }}** и укажите [идентификаторы каталогов](../../resource-manager/operations/folder/get-id.md), из которых можно будет подключаться к ноде. По умолчанию указывается идентификатор каталога пользователя, создающего ноду.
1. Нажмите кнопку **{{ ui-key.yc-ui-datasphere.common.create }}**.

## Проверьте работу развернутого сервиса {#check-node}

1. [Создайте секреты](../../datasphere/operations/data/secrets.md#create) для проверки работы ноды:

   * `IAM_SECRET` со значением [IAM-токена](../../iam/concepts/authorization/iam-token.md).
   * `NODE_ID` с идентификатором ноды.
   * `FOLDER_ID` с [идентификатором каталога](../../resource-manager/operations/folder/get-id.md).

1. {% include [include](../../_includes/datasphere/ui-before-begin.md) %}

1. Установите модуль `tritonclient`:

   ```python
   %pip install tritonclient[http]
   ```

1. Импортируйте необходимые библиотеки:

   ```python
   import numpy as np 
   import matplotlib.pyplot as plt
   from PIL import Image 
   import requests
   import urllib
   import os 
   %matplotlib inline
   ```

1. Подготовьте изображение:

   ```python
   url, filename = ("https://github.com/pytorch/hub/raw/master/images/dog.jpg", "dog.jpg")
   try: urllib.URLopener().retrieve(url, filename)
   except: urllib.request.urlretrieve(url, filename)

   # loading input and resize if needed
   onnx_image = Image.open(filename)

   size_reduction_factor = 5
   onnx_image = onnx_image.resize((224, 224))

   # Preprocess image
   x = np.array(onnx_image).astype('float32')
   x = np.transpose(x, [2, 0, 1])
   onnx_input = np.expand_dims(x, axis=0) 

   plt.figure(figsize=(15, 15))
   plt.imshow(onnx_image)
   plt.show()
   ```

1. Аутентифицируйтесь, используя ранее созданные секреты:

   ```python
   IAM_SECRET = os.environ['IAM_SECRET']
   NODE_ID = os.environ['NODE_ID']
   FOLDER_ID = os.environ['FOLDER_ID']

   headers = {
       "Authorization": f"Bearer {IAM_SECRET}", # get IAM token from secrets
       "x-node-id": f"{NODE_ID}", # sample node
       "x-folder-id": f"{FOLDER_ID}" # node folder ID
   }
   ```

1. Отправьте тестовые запросы, подставив идентификатор модели:

   ```python
   import tritonclient.http as httpclient

   model="<идентификатор_модели_в_DataSphere>"

   # request model config with model ready status
   print(f"""model_name: {model},\n
         model_ready: {triton_client.is_model_ready(model_name=model, headers=headers)},\n
         model_config: {triton_client.get_model_config(model_name=model, headers=headers)}\n""")
   ```

1. Подготовьте изображение и отправьте запрос в ноду:

   ```python
   payload = httpclient.InferInput("input1", list(onnx_input.shape), "FP32")
   payload.set_data_from_numpy(onnx_input, binary_data=False)
   results = triton_client.infer(model, inputs=[payload], headers=headers)
   ```

1. Получите результат преобразования изображения:

   ```python
   output = results.as_numpy("output1")[0]
   output = np.clip(output, 0, 255)
   output = output.transpose(1,2,0).astype("uint8")
   img = Image.fromarray(output)
   img
   ```

   В ответе вы получите преобразованное изображение.

## Как удалить созданные ресурсы {#clear-out}

{% include [node warning](../../_includes/datasphere/nodes-pricing-warn.md) %}

1. [Удалите ноду](../../datasphere/operations/deploy/node-delete.md).
1. [Удалите секреты](../../datasphere/operations/data/secrets.md#delete).