# Классификация изображений на видеокадрах

{{ ml-platform-full-name }} позволяет строить [модели машинного обучения](../../glossary/ml-models.md), используя интерфейс {{ jlab }} Notebook.

В этом руководстве решена задача бинарной классификации изображений. Такая задача возникает при определении типа транспортного средства по изображению с камеры видеонаблюдения. Предполагается, что система управления видеомониторингом захватывает изображения с камеры при обнаружении движения и сохраняет их в бакет {{ objstorage-full-name }}.

Чтобы познакомиться с решением задачи:
1. [Подготовьте инфраструктуру](#deploy-infrastructure).
1. [Настройте {{ ml-platform-name }}](#project).
1. [Создайте секреты](#create-secrets).
1. [Подготовьте ноутбуки](#set-notebooks).
1. [Установите зависимости](#satisfy-dependencies).
1. [Загрузите и разметьте данные](#load-dataset).
1. [Подготовьте ML-модель и вычислите признаки](#get-cnn-model).
1. [Обучите классификатор на полученных признаках](#classifier-fit).
1. [Получите результаты предсказания признака на тестовом изображении](#model-test).
1. [Посмотрите варианты практического применения модели](#model-apply).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin-datasphere.md) %}


### Необходимые платные ресурсы {#paid-resources}

В стоимость работы модели входит:

* плата за использование бакета (см. [тарифы {{ objstorage-full-name }}](../../storage/pricing.md)).
* плата за использование вычислительных ресурсов (см. [тарифы {{ ml-platform-full-name }}](../../datasphere/pricing.md)).


## Подготовьте инфраструктуру {#deploy-infrastructure}

{% include [intro](../../_includes/datasphere/infra-intro.md) %}

{% include [intro](../../_includes/datasphere/federation-disclaimer.md) %}

### Создайте каталог для работы {#create-folder}

Создайте [каталог](../../resource-manager/concepts/resources-hierarchy.md) и [сеть](../../vpc/concepts/network.md#network) с подсетями в каждой [зоне доступности](../../overview/concepts/geo-scope.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) выберите облако и нажмите кнопку ![create](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.console-dashboard.button_action-create-folder }}**.
   1. Введите имя каталога, например `data-folder`.
   1. Нажмите кнопку **{{ ui-key.yacloud.iam.cloud.folders-create.button_create }}**.

{% endlist %}

### Создайте сервисный аккаунт {#create-sa}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. Перейдите в каталог `data-folder`.
   1. На вкладке **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}** нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
   1. Введите имя [сервисного аккаунта](../../iam/concepts/users/service-accounts.md), например `sa-for-project`.
   1. Нажмите **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** и назначьте сервисному аккаунту [роли](../../iam/concepts/access-control/roles.md):
      * `storage.viewer` — для чтения данных из бакета {{ objstorage-name }}.
      * `vpc.gateways.user` — для работы с подсетью.

   1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

{% endlist %}

### Создайте статический ключ доступа для сервисного аккаунта {#create-key}

Чтобы сервисный аккаунт мог аутентифицироваться в {{ objstorage-name }}, создайте [статический ключ доступа](../../iam/concepts/authorization/access-key.md). 

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В каталоге `data-folder` перейдите на вкладку **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}**.
  1. Выберите сервисный аккаунт `sa-for-project` и нажмите на строку с его именем.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** на верхней панели.
  1. Выберите пункт **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_service-account-key }}**.
  1. Задайте описание ключа, чтобы потом было проще найти его в консоли управления.
  1. Сохраните идентификатор и секретный ключ: секретный ключ не сохраняется в {{ yandex-cloud }}, поэтому его нельзя будет посмотреть в консоли управления.

{% endlist %}

### Создайте NAT-шлюз для доступа в интернет {#create-nat}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В каталоге `data-folder` выберите сервис **{{ vpc-name }}**.
   1. На панели слева выберите **{{ ui-key.yacloud.vpc.switch_gateways }}**.
   1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}** и задайте настройки шлюза:
      * Введите имя шлюза, например `nat-for-cluster`.
      * **{{ ui-key.yacloud.vpc.gateways.field_type }}** шлюза — **{{ ui-key.yacloud.vpc.gateways.value_gateway-type-egress-nat }}**.
      * Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

   Создайте таблицу маршрутизации:

   1. На панели слева выберите **{{ ui-key.yacloud.vpc.network.switch_route-table }}**.
   1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}** и введите параметры таблицы маршрутизации:
      1. Введите имя, например `route-table`.
      1. Выберите сеть каталога `data-folder`.
      1. Нажмите кнопку **{{ ui-key.yacloud.vpc.route-table-form.label_add-static-route }}**.
         * В открывшемся окне в поле **{{ ui-key.yacloud.vpc.route-table-form.label_next-hop-address }}** выберите **{{ ui-key.yacloud.vpc.add-static-route.value_gateway }}**.
         * В поле **{{ ui-key.yacloud.vpc.add-static-route.value_gateway }}** выберите созданный NAT-шлюз. Префикс назначения заполнится автоматически.
         * Нажмите кнопку **{{ ui-key.yacloud.vpc.add-static-route.button_add }}**.
   1. Нажмите кнопку **{{ ui-key.yacloud.vpc.route-table.create.button_create }}**.

   Привяжите таблицу маршрутизации к одной из подсетей, чтобы направить трафик из нее через NAT-шлюз:

   1. На панели слева выберите ![image](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.vpc.switch_networks }}**.
   1. В строке нужной подсети нажмите кнопку ![image](../../_assets/console-icons/ellipsis.svg).
   1. В открывшемся меню выберите пункт **{{ ui-key.yacloud.vpc.subnetworks.button_action-add-route-table }}**.
   1. В открывшемся окне выберите созданную таблицу в списке.
   1. Нажмите кнопку **{{ ui-key.yacloud.vpc.subnet.add-route-table.button_add }}**.

{% endlist %}

### Создайте S3-бакет {#create-bucket}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. Перейдите в каталог `data-folder`.
   1. В списке сервисов выберите **{{ objstorage-name }}**.
   1. Нажмите **{{ ui-key.yacloud.storage.buckets.button_empty-create }}**.
   1. На странице создания бакета:
      1. Введите имя бакета в соответствии с [правилами именования](../../storage/concepts/bucket.md#naming).
      
         {% note warning %}

         Не используйте для подключения бакеты, содержащие точку в имени. 

         {% endnote %}

      1. В полях **{{ ui-key.yacloud.storage.bucket.settings.field_access-read }}**, **{{ ui-key.yacloud.storage.bucket.settings.field_access-list }}** и **{{ ui-key.yacloud.storage.bucket.settings.field_access-config-read }}** выберите **{{ ui-key.yacloud.storage.bucket.settings.access_value_private }}**.
      1. При необходимости ограничьте максимальный размер бакета.
   1. Нажмите **{{ ui-key.yacloud.storage.buckets.create.button_create }}** для завершения операции.

{% endlist %}

## Настройте {{ ml-platform-name }} {#project}

### Создайте проект {#create-project}

{% include [include](../../_includes/datasphere/ui-create-project.md) %}

### Измените настройки проекта {#change-settings}

1. {% include [include](../../_includes/datasphere/ui-find-project.md) %}
1. Перейдите на вкладку **{{ ui-key.yc-ui-datasphere.project-page.tab.settings }}**.
1. В блоке **{{ ui-key.yc-ui-datasphere.edit-project-page.advanced-settings }}** нажмите кнопку **![pencil](../../_assets/console-icons/pencil-to-line.svg) {{ ui-key.yc-ui-datasphere.common.edit }}**.
1. Укажите параметры:
   * **{{ ui-key.yc-ui-datasphere.project-page.settings.default-folder }}** — `data-folder`.
   * **{{ ui-key.yc-ui-datasphere.project-page.settings.service-account }}** — `sa-for-project`.
   * **{{ ui-key.yc-ui-datasphere.project-page.settings.subnet }}** — подсеть зоны доступности `{{region-id}}-a` в каталоге `data-folder`.

   {% include [subnet-create](../../_includes/subnet-create.md) %}

   * **{{ ui-key.yc-ui-datasphere.edit-project-page.security-group }}** — укажите [группу безопасности](../../vpc/concepts/security-groups.md), если они используются в вашей организации.
1. Нажмите **{{ ui-key.yc-ui-datasphere.common.save }}**.

## Создайте секреты {#create-secrets}

Создайте [секреты](../../datasphere/concepts/secrets.md) для хранения идентификатора и секретной части статического ключа доступа: 

1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** на странице проекта нажмите ![secret](../../_assets/console-icons/shield-check.svg)**{{ ui-key.yc-ui-datasphere.resources.secret }}**.
1. Нажмите кнопку **{{ ui-key.yc-ui-datasphere.common.create }}**.
1. В поле **{{ ui-key.yc-ui-datasphere.secret.name }}** задайте имя секрета. Секрет с идентификатором статического ключа назовите `token`, а секрет с секретной частью — `key_value`.
1. В поле **{{ ui-key.yc-ui-datasphere.secret.content }}** введите значение, которое будет храниться в зашифрованном виде.
1. Нажмите кнопку **{{ ui-key.yc-ui-datasphere.common.create }}**. Откроется страница с информацией о созданном секрете.

## Подготовьте ноутбуки {#set-notebooks}

Склонируйте Git-репозиторий, в котором находятся ноутбуки с примерами обучения и тестирования модели машинного обучения:
   1. В верхнем меню нажмите **Git** и выберите **Clone**.
   1. В открывшемся окне введите URI репозитория `https://github.com/yandex-cloud-examples/yc-datasphere-video-recognition.git` и нажмите кнопку **Clone**.
   
   Дождитесь окончания клонирования, это может занять некоторое время. Папка cклонированного репозитория появится в разделе ![folder](../../_assets/datasphere/jupyterlab/folder.svg) **File Browser**.

В репозитории содержатся два ноутбука: 

* `model-building.ipynb` — для настройки окружения и обучения модели с использованием подхода [Convolutional Neural Network](https://ru.wikipedia.org/wiki/Свёрточная_нейронная_сеть) (CNN) под названием ResNet50;
* `model-testing.ipynb` — для тестирования модели.

## Установите зависимости {#satisfy-dependencies}

{% note info %}

В примере обучение и тестирование модели производится на [конфигурации](../../datasphere/concepts/configurations.md) вычислительных ресурсов g1.1. Вы можете использовать другую конфигурацию с GPU. Для этого измените конфигурацию в коде на желаемую во всех ячейках ноутбуков.

{% endnote %}

1. Откройте каталог **ML** и затем ноутбук **model-building.ipynb**.
1. Выделите первую ячейку, кликнув на нее:

   ```
   #!g1.1
   %matplotlib inline
   import matplotlib
   import matplotlib.pyplot as plt
   import os
   import io
   from os import path
   ...
   ```

1. Чтобы запустить ячейку, нажмите ![run](../../_assets/datasphere/jupyterlab/run.svg) (также можно использовать сочетание клавиш **Shift** + **Enter**).
1. Дождитесь завершения операции.

В решении используется [интерфейс Keras](https://keras.io/about/) библиотеки TensorFlow с [CNTK-бэкендом](https://docs.microsoft.com/en-us/cognitive-toolkit/). Пакет `boto3` необходим для подключения к бакету с изображениями. Также в ячейке задаются переменные окружения, необходимые для работы с CNTK-бэкендом и подключения к бакету.

Указанные в ячейке пакеты уже установлены в {{ ml-platform-name }} и импортируются с помощью команды `import`. Полный список предустановленных в {{ ml-platform-name }} пакетов см. в разделе [{#T}](../../datasphere/concepts/preinstalled-packages.md).

## Загрузите и разметьте данные {#load-dataset}

Перейдите к разделу **Connect S3**. В нем выполняются следующие операции:

1. Настраивается подключение к S3-бакету.
1. Загружается список объектов (изображений) автомобилей и автобусов. Они будут использоваться при обучении модели.
1. Определяется функция для извлечения изображения по ключу (названию).

В следующем разделе **Labeling** выполняется разметка данных:
* Изображения маркируются в соответствии со значением ключа (именем папки).
* Изображения автобусов помечаются меткой `0`, автомобилей — `1`.

Чтобы загрузить и разметить данные:

1. В первой ячейке измените значение переменной `bucket_name` на название созданного вами бакета. По умолчанию указано значение `bucketwithvideo`.
1. Выделите все ячейки с кодом в разделах **Connect S3** и **Labeling**, удерживая **Shift** и кликая слева от нужных ячеек:

   ```
   #!g1.1

   session = boto3.session.Session()
   ...
   ```

1. Запустите выделенные ячейки.
1. Дождитесь завершения операции. По завершении операции выводится одно из изображений для проверки корректности загрузки и разметки данных.

## Подготовьте ML-модель и вычислите признаки {#get-cnn-model}

Перейдите к разделу **Calculating the characteristics**. В нем выполняются следующие операции:

1. Из пакета Keras загружается модель ResNet50 с весами, предварительно подобранными на наборе данных ImageNet. Этот набор содержит 1.2 миллиона изображений, которые разнесены по 1000 категорий.
1. Определяется функция `featurize_images`, которая разделяет список изображений на порции (chunks) по 32 в каждой, преобразует их до размера 224×224 пикселя, а затем конвертирует в четырехмерный [тензор](https://ru.wikipedia.org/wiki/Тензор) для загрузки в модель Keras. Далее функция вычисляет признаки и возвращает их в массиве NumPy.
1. С помощью функции вычисляются бинарные признаки (`1` — автомобиль, `0` — иное) и сохраняются в файл. Этот шаг может занять 10-15 минут. [Подробнее про модель ResNet50](https://www.kaggle.com/keras/resnet50).

Чтобы подготовить модель и вычислить признаки:

1. Выделите все ячейки с кодом в разделе **Calculating the characteristics**:

   ```
   #!g1.1
   model = ResNet50(weights='imagenet',  input_shape=(224, 224, 3))
   ...
   ```

1. Запустите выделенные ячейки.
1. Дождитесь завершения операции.

## Обучите классификатор на полученных признаках {#classifier-fit}

В этом разделе вы будете обучать классификатор LightGBM на признаках, вычисленных в предыдущем разделе. Для характеризации модели выполняется кросс-валидация. 

Используется метод [K-fold](http://scikit-learn.org/0.16/modules/generated/sklearn.cross_validation.StratifiedKFold.html) пакета scikit-learn. Части обучающей выборки (фолды) формируются по заданному проценту данных из каждого класса. 

Это важно, когда в ваших данных число изображений одной из категорий существенно меньше, чем из другой категории. Здесь используется кросс-валидация с пятью фолдами. Вы можете задать другое число фолдов в параметре `n_splits`.

Перейдите к разделам **Training and cross-validation** и **Saving the model**. В них выполняются следующие операции:

1. Определяется объект для кросс-валидации результатов обучения методом **K-fold**.
1. Готовится таблица для сохранения метрик качества классификации.
1. Определяется функция вычисления выбранных метрик `classification_metrics`.
1. Запускается обучение классификатора LightGBM. В данном примере используется кросс-валидация с пятью фолдами:
   1. Обучающая выборка разбивается на пять непересекающихся одинаковых по объему частей.
   1. Выполняется пять итераций. На каждой итерации выполняются следующие шаги:
      1. Модель обучается на четырех частях выборки.
      1. Модель тестируется на части выборки, которая не участвовала в обучении.
      1. Выводятся выбранные метрики качества.
1. Классификатор обучается на полном наборе данных и выводится итоговая матрица ошибок.

Для обучения классификатора запустите последовательно все ячейки в разделах **Training and cross-validation** и **Saving the model**.

В результате обученная модель будет сохранена в отдельный файл.

## Получите результаты предсказания признаков на тестовых данных {#model-test}

Чтобы использовать полученную модель:

1. Откройте каталог **ML** и затем ноутбук **model-testing.ipynb**.

   В этом ноутбуке используется ранее обученный классификатор LightGBM для подготовки необходимых сущностей для иллюстрации применения вашей модели.

   {% note info %}

   Для использования модели нужно существенно меньше ресурсов, чем для ее обучения, поэтому здесь оставлена минимальная конфигурация c1.4 (по умолчанию).

   {% endnote %}

1. Во второй ячейке измените значение переменной `bucket_name` на название созданного вами бакета. По умолчанию указано значение `bucketwithvideo`.
1. Запустите первые три ячейки. В этих ячейках:
   1. Импортируются необходимые для теста пакеты.
   1. Определяется имя бакета, в котором хранятся изображения.
   1. Настраивается подключение к бакету с изображениями из сервиса видеомониторинга.
1. Задайте тестовое изображение с автомобилем:

   ```
   test_image = 'car/electric-cars-17.jpeg'
   ```

   {% note info %}

   Если вы повторно запускаете ячейку, укажите новое изображение.

   {% endnote %}

1. В ячейке из раздела **Prediction** загрузите модель ResNet50 и подготовленный классификатор LightGBM и вычислите вероятность предсказанного значения бинарного признака (`1` соответствует автомобилю).

   В первый раз ячейка с вычислением предсказания обрабатывается дольше, так как модели загружаются в память. При последующих запусках ячейка будет выполняться быстрее:

   ```
   %%time
   clf = lgb.Booster(model_file='ImageClassificationML/lightgbm_classifier.model')
   model = ResNet50(weights='imagenet',  input_shape=(224, 224, 3))
   ...
   ```

1. Убедитесь, что значение вероятности близко к единице (должно получиться `≈0.98`).
1. Поменяйте код в ячейке перед загрузкой модели:

   ```
   test_image = 'bus/electric_bus-183.jpeg'
   ```

   Это тестовое изображение, на котором нет автомобиля. 

1. Выполните ячейку.
1. Повторите вычисление вероятности и убедитесь, что значение существенно меньше `0.5`.

Таким образом, классификатор успешно предсказывает признак для этих двух изображений.

{% note info %}

Вы можете [поделиться](../../datasphere/operations/projects/publication.md) готовым ноутбуком с расчетами или [экспортировать проект](../../datasphere/operations/projects/export.md) целиком.

{% endnote %}

## Практическое применение модели {#model-apply}

Есть несколько вариантов практического применения построенной модели:

* На основе кода предлагаемого решения можно запустить веб-сервис с помощью [{{ sf-full-name }}](../../functions/) и анализировать изображения при наступлении соответствующего события в видеомониторинге.
* Для параллельной обработки изображений, приходящих с большого количества видеокамер в S3-бакет, можно загрузить код в кластер Apache Spark™ в [{{ dataproc-full-name }}](../../data-proc/) с помощью пакета PySpark.


## Как удалить созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы остановить работу модели и перестать платить за созданные ресурсы, удалите те из них, которые вы больше не будете использовать:

1. [Удалите все объекты из бакета](../../storage/operations/objects/delete.md).
1. [Удалите бакет](../../storage/operations/buckets/delete.md).
1. [Удалите проект](../../datasphere/operations/projects/delete.md).
1. [Удалите таблицу маршрутизации](../../vpc/operations/delete-route-table.md).
1. [Удалите NAT-шлюз](../../vpc/operations/delete-nat-gateway.md).
