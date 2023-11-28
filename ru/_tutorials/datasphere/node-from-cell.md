# Развертывание сервиса на основе модели, обученной в {{ ml-platform-name }}

В {{ ml-platform-name }} вы можете не только обучить модель, но и [развернуть](../../datasphere/concepts/deploy/index.md) ее в качестве микросервиса, доступного для сторонних ресурсов.

В этом примере вы обучите модель классификации предметов одежды из библиотеки [Keras](https://keras.io/about/), а затем пройдете полный путь публикации сервиса, создав [ноду](../../datasphere/concepts/resource-model.md#resources) и [алиас](../../datasphere/concepts/resource-model.md#resources). 

Чтобы создать микросервис на основе обученной модели:
1. [Подготовьте инфраструктуру](#infra).
1. [Подготовьте модель](#get-model).
1. [Создайте контрольную точку](#checkpoint).
1. [Создайте ноду](#create-node).
1. [Отправьте тестовый запрос в ноду](#test-query).
1. [Создайте алиас](#create-alias).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin-datasphere.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость развертывания микросервиса на основе обученной модели входят:
* плата за время вычислений при обучении модели;
* плата за время работы каждого инстанса ноды;
* плата за исходящий трафик.

Подробнее см. [тарифы {{ ml-platform-full-name }}](../../datasphere/pricing.md).

## Подготовьте инфраструктуру {#infra}

{% include [intro](../../_includes/datasphere/infra-intro.md) %}

{% include [intro](../../_includes/datasphere/federation-disclaimer.md) %}

### Создайте каталог {#create-folder}

Создайте каталог, в котором ваш сервис будет хранить логи.

{% list tabs %}

- Консоль управления

   1. В [консоли управления]({{ link-console-main }}) выберите облако и нажмите кнопку ![create](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.console-dashboard.button_action-create-folder }}**.
   1. Введите имя каталога, например `data-folder`.
   1. Нажмите кнопку **{{ ui-key.yacloud.iam.cloud.folders-create.button_create }}**.

{% endlist %}

### Создайте сервисный аккаунт для проекта {{ ml-platform-name }} {#create-sa}

{% list tabs %}

- Консоль управления

   1. Перейдите в каталог `data-folder`.
   1. На вкладке **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}** нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
   1. Введите имя [сервисного аккаунта](../../iam/concepts/users/service-accounts.md), например `sa-with-network`.
   1. Нажмите **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** и назначьте сервисному аккаунту [роли](../../iam/concepts/access-control/roles.md):
      * `vpc.user` — для работы с сетью {{ ml-platform-name }}.
      * (опционально) `datasphere.user` — чтобы отправлять запросы в ноду.

   1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

{% endlist %}

### Создайте и настройте проект {{ ml-platform-name }} {#prepare-project}

1. [Создайте](../../datasphere/operations/projects/create.md) проект.
1. [В настройках проекта](../../datasphere/operations/projects/update.md) укажите сервисный аккаунт `sa-with-network` и каталог `data-folder`.
1. Выключите режим [автоматического сохранения состояния](../../datasphere/concepts/save-state.md#auto-save).

## Подготовьте модель {#get-model}

{% note info %}

Для обучения модели и развертывания ноды в примере используется базовая [конфигурация c1.4](../../datasphere/concepts/configurations.md). Библиотека [TensorFlow](https://www.tensorflow.org/), установленная в проекте, проверяет наличие драйверов и библиотек CUDA, но не использует их в данном примере. Такие проверки могут вызывать ошибки и предупреждения, которые не влияют на работу {{ ml-platform-name }} и Tensorflow.

{% endnote %}

В данном примере вы воспользуетесь моделью классификации изображений на основе [полносвязных слоев](https://ru.wikipedia.org/wiki/Свёрточная_нейронная_сеть#Полносвязная_нейронная_сеть). Модель возвращает 10 значений вероятностей, которые отображают уверенность сети в том, что поданное на вход изображение соответствует определенному классу.

1. Импортируйте в проект необходимые библиотеки. Для этого скопируйте код в ячейку и запустите ее исполнение, выбрав в меню **Run → Run Selected Cells** (также можно использовать сочетание клавиш **Shift** + **Enter**). Дождитесь завершения операции.

    ```python
    #!c1.4
    import tensorflow as tf
    import numpy as np
    import matplotlib.pyplot as plt
    import base64
    ```

1. Создайте модель. В этом примере используется [датасет](../../datasphere/concepts/dataset.md) подборки изображений с разными предметами одежды [Fashion MNIST](https://en.wikipedia.org/wiki/Fashion_MNIST). 

    ```python
    #!c1.4
    fashion_mnist = tf.keras.datasets.fashion_mnist

    (train_images, train_labels), (test_images, test_labels) = fashion_mnist.load_data()

    class_names = ['T-shirt/top', 'Trouser', 'Pullover', 'Dress', 'Coat',
                   'Sandal', 'Shirt', 'Sneaker', 'Bag', 'Ankle boot']

    model = tf.keras.Sequential([
        tf.keras.layers.Flatten(input_shape=(28, 28)),
        tf.keras.layers.Dense(128, activation='relu'),
        tf.keras.layers.Dense(10)
    ])
    ```

1. Настройте модель для обучения:

    ```python
    #!c1.4
    model.compile(optimizer='adam',
              loss=tf.keras.losses.SparseCategoricalCrossentropy(from_logits=True),
              metrics=['accuracy'])
    ```

1. Обучите модель:

    ```python
    #!c1.4
    model.fit(train_images, train_labels, epochs=10)
    ```

1. Проверьте точность обученной модели на тестовых данных:

    ```python
    #!c1.4
    test_loss, test_acc = model.evaluate(test_images,  test_labels, verbose=2)

    print('\nTest accuracy:', test_acc)
    ```

1. Чтобы использовать полученную модель, передайте в нее тестовые изображения (`test_images`). 

    ```python
    probability_model = tf.keras.Sequential([model, tf.keras.layers.Softmax()])
    predictions = probability_model.predict(test_images)
    np.argmax(predictions[0])
    ```

    Прогноз представляет из себя массив из 10 чисел. Они описывают вероятность соответствия изображения каждому из 10 разных видов одежды.

1. (Опционально) Проверьте, как работает модель. 
    * Создайте функции для отображения классифицируемого изображения и результата предсказания в графическом виде:
    
        ```python
        def plot_image(i, predictions_array, true_label, img):
            (true_label, img) = (true_label[i], img[i])
            plt.grid(False)
            plt.xticks([])
            plt.yticks([])

            plt.imshow(img, cmap=plt.cm.binary)

            predicted_label = np.argmax(predictions_array)
            if predicted_label == true_label:
                color = "blue"
            else:
                color = "red"

            plt.xlabel(
                "{} {:2.0f}% ({})".format(
                    class_names[predicted_label],
                    100 * np.max(predictions_array),
                    class_names[true_label],
                ),
                color=color,
            )


        def plot_value_array(i, predictions_array, true_label):
            true_label = true_label[i]
            plt.grid(False)
            plt.xticks(range(10))
            plt.yticks([])
            thisplot = plt.bar(range(10), predictions_array, color="#777777")
            plt.ylim([0, 1])
            predicted_label = np.argmax(predictions_array)

            thisplot[predicted_label].set_color("red")
            thisplot[true_label].set_color("blue")

        ```

    * Отобразите шестое изображение и результат предсказания:
    
        ```python
        i = 6
        plt.figure(figsize=(6,3))
        plt.subplot(1,2,1)
        plot_image(i, predictions[i], test_labels, test_images)
        plt.subplot(1,2,2)
        plot_value_array(i, predictions[i],  test_labels)
        plt.show()
        ```


## Создайте контрольную точку для развертывания микросервиса {#checkpoint}

1. Создайте массив изображений в кодировке [base64](https://ru.wikipedia.org/wiki/Base64). Этот массив будет использоваться для классификации изображений с использованием обученной ML-модели. 

    ```python
    #!c1.4
    encoded_images = [
        base64.b64encode(test_images[1].tobytes()),
        base64.b64encode(test_images[4].tobytes()),
        base64.b64encode(test_images[7].tobytes()),
        base64.b64encode(test_images[9].tobytes())
    ]
    print(encoded_images)
    ...
    ```
1. Определите входные и выходные параметры и работу развертываемого микросервиса:

    ```python
    #!c1.4
    # decode input
    images = np.stack([
        np.ndarray(
            (28, 28),
            buffer=base64.b64decode(encoded_img),
            dtype='uint8'
        )
        for encoded_img in encoded_images
    ])

    # apply model
    predictions = probability_model.predict(images)

    # prepare result
    labels = predictions.argmax(axis=1).tolist()
    ```    
    
    В проекте будет автоматически создана контрольная точка.
   
1. Закрепите контрольную точку:
    1. В навигационной цепочке в левом верхнем углу нажмите {{ jlab }}Lab и перейдите в раздел **{{ ui-key.yc-ui-datasphere.common.checkpoint }}**.
    1. Выберите в списке последнюю добавленную контрольную точку с именем `Cell run` и убедитесь, что в ней содержится нужный код из предыдущего шага.
    1. В правом верхнем углу нажмите кнопку ![Pin](../../_assets/datasphere/pin.svg) **{{ ui-key.yc-ui-datasphere.common.pin }}**.
    1. Во всплывающем окне введите имя контрольной точки, например `checkpoint-for-node`, и нажмите кнопку **{{ ui-key.yc-ui-datasphere.common.pin }}**.

## Создайте ноду {#create-node}

1. Чтобы создать ноду:
    1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
    1. В правом верхнем углу нажмите кнопку **{{ ui-key.yc-ui-datasphere.project-page.project-card.create-resource }}**. Во всплывающем окне выберите **{{ ui-key.yc-ui-datasphere.resources.node }}**.
    1. Задайте параметры ноды:
        * **{{ ui-key.yc-ui-datasphere.new-node.node-form-label.type }}** — **{{ ui-key.yc-ui-datasphere.common.cell }}**.
        * **{{ ui-key.yc-ui-datasphere.new-node.node-form-label.name }}** — имя ноды, например `classifier-node`.
        * В поле **{{ ui-key.yc-ui-datasphere.new-node.node-form-label.checkpoint }}** выберите контрольную точку `checkpoint-for-node`.
        * В блоке **{{ ui-key.yc-ui-datasphere.new-node.title.input-variables }}** нажмите кнопку ![Add](../../_assets/console-icons/plus.svg) **{{ ui-key.yc-ui-datasphere.common.add-new }}** и создайте переменную со следующими параметрами:
          * **{{ ui-key.yc-ui-datasphere.new-node.variables-form-placeholder.name }}** — `encoded_images`.
          * **Тип** — `{{ ui-key.yc-ui-datasphere.node-page.type.list }}`.
        * В блоке **{{ ui-key.yc-ui-datasphere.new-node.title.output-variables }}** нажмите кнопку ![Add](../../_assets/console-icons/plus.svg) **{{ ui-key.yc-ui-datasphere.common.add-new }}** и создайте переменную со следующими параметрами:
          * **{{ ui-key.yc-ui-datasphere.new-node.variables-form-placeholder.name }}** — `labels`.
          * **Тип** — `{{ ui-key.yc-ui-datasphere.node-page.type.list }}`.
        * В блоке **{{ ui-key.yc-ui-datasphere.new-node.title.kernel-docker-image }}** выберите `{{ ui-key.yc-ui-datasphere.common.default }} Python 3.8`.
    1. В блоке **{{ ui-key.yc-ui-datasphere.new-node.title.folder }}** выберите `data-folder`.
    1. В блоке **{{ ui-key.yc-ui-datasphere.new-node.title.provisioning }}** выберите:
        * **{{ ui-key.yc-ui-datasphere.new-node.provisioning-form-label.instance-spec }}** — `c1.4`.
        * В блоке настроек **{{ ui-key.yc-ui-datasphere.node-page.provisioning.distribution-by-zones }}** у вас уже выбрана зона доступности. Поле **{{ ui-key.yc-ui-datasphere.common.subnet }}** оставьте пустым, {{ ml-platform-name }} заполнит его значением по умолчанию.
        
          {% note info %}

          Если в настройках проекта указана подсеть, вы можете указать ее. Подсеть должна иметь [NAT-шлюз](../../vpc/concepts/gateways.md).

          Если в настройках проекта указана подсеть, время выделения ресурсов может быть увеличено.

          {% endnote %}

    1. Нажмите кнопку **{{ ui-key.yc-ui-datasphere.common.create }}**.

## Отправьте тестовый запрос в ноду {#test-query}

Вы можете отправлять запросы из интерфейса {{ ml-platform-name }} или из кода ноутбука.

{% list tabs %}

- Интерфейс {{ ml-platform-name }}

    {% note info %}
    
    {{ ml-platform-name }} отправляет тестовый запрос от имени сервисного аккаунта, привязанного к проекту. Сервисный аккаунт должен иметь права на каталог, в котором создана нода.
    
    {% endnote %}
    
    1. На странице ноды `classifier-node` перейдите на вкладку **{{ ui-key.yc-ui-datasphere.node-page.tab.request }}**.
    1. В блоке **{{ ui-key.yc-ui-datasphere.node-page.request.create-test-request }}** передайте изображение для классификации в формате base64:
        
        ```json
        {"encoded_image": ["AAAAAAAAAAAAAA1DAAAAADImAAAAAAAAAAAAAAAAAAAAAAAIeNHi9+3////37uusSAAAAAAAAAAAAAAAAACJ7/zz6uXu9Pbw5ujv+PvCAAAAAAAAAAAAAABm/+fk4+Tp5ubl5Ojo5+Pg/LMAAAAAAAAAAAAA6fHl5///7ufj7vbk5uPq6+XxFAAAAAAAAAAAAPjx5/+VL/zk//LY7uj/5Nzq+jYAAAAAAAAAAAD/8Oj/DwD/7b8AANb/DXv/6vxyAAAAAAAAAAAG/+7v/7EA//8AgnQvQSsl/+z5ogAAAAAAAAAAIP/s9f/MAP9UACUcHwAZDf/s+ccAAAAAAAAAADX/7Pr65wL/FQDd/+w29cbz7vXfAAAAAAAAAABQ/+368P8AACedAADXXhR+/+3v+gAAAAAAAAAAZf/r/fTzhYrQ/8nW/+YHrv/w7v8AAAAAAAAAAH7/6f/46f//8Ojz8+f7///+8+7/AwAAAAAAAACT/+n5tfPj4Obq5ubr5Ovez//s/yMAAAAAAAAAo//13Vb/6enr7Orq6ujy533/7P83AAAAAAAAALX+/8hF/+To6uvq6unr8e1G/+v2OQAAAAAAAADF9/+8bv/g6erq6urq6vD9Rf/s+E0AAAAAAAAAyPb/lZH/3+vq6+vr6u3p/y//7/liAAAAAAAAAMzz/2+t/+Pr6+zr6+vv5f8T4/b5bgAAAAAAAADE8P9t1frl6+vs6+3s7eL/N8v79XgAAAAAAAAAwPP/cujw6Ovr7Ort7Ovl/4ar/PSJAAAAAAAAAL37/5ru6ezq6+zr7uzr6P+mff/zjgAAAAAAAAC3/P+r9+jq6unp6Orp6unw34D/8pcAAAAAAAAAsvP/Oe7x7u7u7ezt7fDt/rA0/++dAAAAAAAAALzw+j7a/9ze3t7f3+De2v+aIP/svAAAAAAAAACC9fIYAAAAAAAAAAAAAAAAACLy9IcAAAAAAAAATP/5FgAAAAAAAAAAAAAAAAAn+f97AAAAAAAAADHNxQsABAECAgICAgICAgMAA669QwAAAA=="]}
        ```
        
        В ответе вернется код класса, к которому относится изображение.

- Python

    1. Определите параметры запроса:
    
        ```python
        #!c1.4
        import json
        import os
        import requests
    
        resp = requests.post(
            "https://datasphere.api.cloud.yandex.net/datasphere/v1/nodes/<идентификатор_ноды>:execute",
            data = json.dumps({
                'node_id': '<идентификатор_ноды>',
                'folder_id': '<идентификатор_каталога>',
                'input': {
                    'encoded_images': [
                        base64.b64encode(test_images[0].tobytes()).decode('ascii'),
                        base64.b64encode(test_images[1].tobytes()).decode('ascii'),
                        base64.b64encode(test_images[2].tobytes()).decode('ascii')
                    ]
                }
            }),
            headers = {
                'Authorization': f"Bearer <IAM-токен>" 
            }
        )
    
        # check response
        print(resp.status_code, resp.reason)
        print(resp.text)
        ```
    
        Где:
        - `<идентификатор_ноды>` — идентификатор ноды `classifier-node`;
        - `<IAM-токен>` — [IAM-токен](../../iam/operations/iam-token/create.md) вашего аккаунта;
        - `<идентификатор_каталога>` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md), в котором создана нода.
        
        {% note info %}

        {% include [iam-token-disclaimer](../../_includes/iam/iam-token-note.md) %}

        {% endnote %}
    
    1. Запустите выполнение ячейки. В ответе вернется список меток изображений в диапазоне от 0 до 9:
    
        ```json
        200 OK
        {
         "output": {
          "labels": [
           9,
           2,
           1
          ]
         }
        }
        ```

{% endlist %}

Для просмотра логов и проверки работоспособности ноды используйте вкладки **{{ ui-key.yc-ui-datasphere.node-page.tab.logs }}** и **{{ ui-key.yc-ui-datasphere.node-page.tab.monitoring }}** на странице ноды.


## Создайте алиас {#create-alias}

Вы можете распределять нагрузку между нодами и обновлять развернутые сервисы во время работы, используя [алиасы](../../datasphere/concepts/deploy/index.md#alias).

Чтобы создать алиас:
1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
1. В правом верхнем углу нажмите кнопку **{{ ui-key.yc-ui-datasphere.project-page.project-card.create-resource }}**. Во всплывающем окне выберите **{{ ui-key.yc-ui-datasphere.common.alias }}**.
1. Задайте параметры алиаса:
    * В поле **{{ ui-key.yc-ui-datasphere.common.name }}** укажите `fashion`.
    * В поле **{{ ui-key.yc-ui-datasphere.common.prefix }}** выберите доступный префикс алиаса.
    * В блоке **{{ ui-key.yc-ui-datasphere.new-alias.field.label-nodes }}** выберите `classifier-node`. Укажите процент запросов, который будет перенаправляться к ноде.
    * В блоке **{{ ui-key.yc-ui-datasphere.common.folder }}** выберите каталог, в котором будут создаваться новые ресурсы.
1. Нажмите кнопку **{{ ui-key.yc-ui-datasphere.common.save }}**.

Для проверки работоспособности алиаса нажмите на его имя и перейдите на вкладку **{{ ui-key.yc-ui-datasphere.node-page.tab.monitoring }}**.

Используйте алиас вместо эндпоинта ноды, чтобы сервис всегда оставался доступным.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:
* [удалите](../../datasphere/operations/deploy/alias-delete.md) алиас;
* [удалите](../../datasphere/operations/deploy/node-delete.md) ноду.
