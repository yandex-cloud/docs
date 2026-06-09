# Развертывание сервиса в Yandex DataSphere из модели ONNX

# Развертывание сервиса из модели ONNX

DataSphere позволяет разворачивать и эксплуатировать сервисы на основе обученной в проекте [модели](../../datasphere/concepts/models/index.md).

В этом практическом руководстве вы развернете сервис из модели в формате ONNX. Модель `fast-neural-style-mosaic-onnx` преобразует изображение в соответствии с заданным стилем. Модель взята из [хранилища моделей ONNX](https://github.com/onnx/models/).

1. [Подготовьте инфраструктуру](#infra).
1. [Создайте модель](#create-model).
1. [Создайте ноду](#create-node).
1. [Проверьте работу развернутого сервиса](#check-node).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

Перед началом работы нужно зарегистрироваться в Yandex Cloud, настроить [сообщество](../../datasphere/concepts/community.md) и привязать к нему [платежный аккаунт](../../billing/concepts/billing-account.md):
1. [На главной странице DataSphere](https://datasphere.yandex.cloud) нажмите **Попробовать бесплатно** и выберите аккаунт для входа — Яндекс ID или рабочий аккаунт в федерации (SSO).
1. Выберите [организацию Yandex Identity Hub](../../organization/index.md), в которой вы будете работать в Yandex Cloud.
1. [Создайте сообщество](../../datasphere/operations/community/create.md).
1. [Привяжите платежный аккаунт](../../datasphere/operations/community/link-ba.md) к сообществу DataSphere, в котором вы будете работать. Убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, создайте его в интерфейсе DataSphere.

### Необходимые платные ресурсы {#paid-resources}

В стоимость развертывания сервиса из модели входят:

* плата за постоянно запущенные инстансы ноды (см. [тарифы DataSphere](../../datasphere/pricing.md));
* плата за запуск ячеек с кодом для проверки работы развернутого сервиса.

## Подготовьте инфраструктуру {#infra}

Войдите в [консоль управления](https://console.yandex.cloud) Yandex Cloud и выберите организацию, в которой вы работаете с DataSphere. На странице [**Yandex Cloud Billing**](https://center.yandex.cloud/billing/accounts) убедитесь, что у вас подключен платежный аккаунт.

Если у вас есть активный платежный аккаунт, на [странице облака](https://console.yandex.cloud/cloud) вы можете создать или выбрать каталог, в котором будет работать ваша инфраструктура.

{% note info %}

Если вы работаете с Yandex Cloud через [федерацию удостоверений](../../organization/concepts/add-federation.md), вам может быть недоступна платежная информация. В этом случае обратитесь к администратору вашей организации в Yandex Cloud.

{% endnote %}

### Создайте каталог {#create-folder}

Создайте каталог, в котором вы развернете всю необходимую инфраструктуру, а ваш сервис будет хранить логи.

{% note info %}

В примере инфраструктура Yandex Cloud и развернутый сервис работают в одном каталоге Yandex Cloud, однако это не обязательно.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления](https://console.yandex.cloud) выберите облако и нажмите кнопку ![create](../../_assets/console-icons/plus.svg)**Создать каталог**.
   1. Введите имя каталога, например `data-folder`.
   1. Нажмите кнопку **Создать**.

{% endlist %}

### Создайте сервисный аккаунт для проекта DataSphere {#create-sa}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. Перейдите в каталог `data-folder`.
   1. [Перейдите]( ../../console/operations/select-service.md#select-service) в сервис **Identity and Access Management**.
   1. Нажмите кнопку **Создать сервисный аккаунт**.
   1. Введите имя [сервисного аккаунта](../../iam/concepts/users/service-accounts.md), например `datasphere-sa`.
   1. Нажмите **Добавить роль** и назначьте сервисному аккаунту [роли](../../iam/concepts/access-control/roles.md):
      * `vpc.user` — для работы с сетью DataSphere.
      * `datasphere.user` — чтобы отправлять запросы в ноду.

   1. Нажмите кнопку **Создать**.

{% endlist %}

## Создайте модель {#create-model}

Модель `fast-neural-style-mosaic-onnx` — это одна из моделей переноса стиля, разработанная для преобразования изображения под стиль другого изображения.

1. Откройте проект DataSphere:
   
   1. Выберите нужный проект в своем сообществе или на [главной странице](https://datasphere.yandex.cloud) DataSphere во вкладке **Недавние проекты**.
   1. Нажмите кнопку **Открыть проект в JupyterLab** и дождитесь окончания загрузки.
   1. Откройте вкладку с ноутбуком.

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

1. Выберите нужный проект в своем сообществе или на [главной странице](https://datasphere.yandex.cloud) DataSphere во вкладке **Недавние проекты**.
1. В правом верхнем углу нажмите кнопку **Создать ресурс**. Во всплывающем окне выберите **Нода**.
1. В поле **Имя** введите имя ноды.
1. В блоке **Тип** укажите тип ресурса — **Модель**.
1. В поле **Модели** выберите модель `onnx-model`.
1. В блоке **Каталог** выберите каталог `data-folder`.
1. В блоке **Обеспечение** выберите [конфигурацию](../../datasphere/concepts/configurations.md) вычислительных ресурсов [инстанса](../../datasphere/concepts/deploy/index.md), [зону доступности](../../overview/concepts/geo-scope.md) и идентификатор [подсети](../../vpc/concepts/network.md#subnet) в которых будет размещен инстанс.
1. В блоке **Список управления доступом (ACL)** нажмите кнопку ![Add](../../_assets/console-icons/plus.svg) **Добавить ACL** и укажите [идентификаторы каталогов](../../resource-manager/operations/folder/get-id.md), из которых можно будет подключаться к ноде. По умолчанию указывается идентификатор каталога пользователя, создающего ноду.
1. Нажмите кнопку **Создать**.

## Проверьте работу развернутого сервиса {#check-node}

1. [Создайте секреты](../../datasphere/operations/data/secrets.md#create) для проверки работы ноды:

   * `IAM_SECRET` со значением [IAM-токена](../../iam/concepts/authorization/iam-token.md).
   * `NODE_ID` с идентификатором ноды.
   * `FOLDER_ID` с [идентификатором каталога](../../resource-manager/operations/folder/get-id.md).

1. Откройте проект DataSphere:
   
   1. Выберите нужный проект в своем сообществе или на [главной странице](https://datasphere.yandex.cloud) DataSphere во вкладке **Недавние проекты**.
   1. Нажмите кнопку **Открыть проект в JupyterLab** и дождитесь окончания загрузки.
   1. Откройте вкладку с ноутбуком.

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

При развертывании и эксплуатации моделей вы платите за время работы каждого инстанса ноды — от момента запуска до момента удаления.

Если развернутый сервис вам больше не нужен, удалите ноду.

1. [Удалите ноду](../../datasphere/operations/deploy/node-delete.md).
1. [Удалите секреты](../../datasphere/operations/data/secrets.md#delete).