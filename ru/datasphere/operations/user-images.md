# Работа с Docker-образами

Вы можете настроить окружение для выполнения вашего кода, используя [Docker-образы](../concepts/docker.md).

{{ ml-platform-full-name }} позволяет создавать репозитории Docker-образов в проекте, а также выбирать образ для проекта. Выбранный образ будет использоваться при запуске кода во всех ноутбуках проекта.

## Создать Docker-образ {#create}

1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
1. В правом верхнем углу нажмите **{{ ui-key.yc-ui-datasphere.project-page.project-card.create-resource }}**. Во всплывающем окне выберите **{{ ui-key.yc-ui-datasphere.resources.docker }}**.
1. Выберите расположение Docker-образа:

   {% list tabs %}
   
   - {{ container-registry-name }}
   
     Образ будет собран в реестре [{{ container-registry-full-name }}](../../container-registry/). Запуск проекта с образом из реестра зависит от размера образа и занимает больше времени. Образ из реестра нельзя [опубликовать](#share) в сообществе.
   
     Для сборки образа в {{ container-registry-name }} администратор сообщества должен указать нужный реестр в [настройках сообщества](./community/manage-community-config.md) и включить [сервисного агента](./community/create-ssa.md).
   
     Заполните поля:

     * **{{ ui-key.yc-ui-datasphere.docker.tag }}** — имя и тег образа в формате `<имя>:<тег>`, например `tensorflow:1.0.0`.
     * **{{ ui-key.yc-ui-datasphere.docker.build-path }}** — путь к директории, содержимое которой необходимо иметь в контексте сборки Docker-образа. Все содержимое этой директории будет занимать место на диске для сборки образа. `.` — корневая директория.
     * **{{ ui-key.yc-ui-datasphere.common.description }}** — описание Docker-образа.
     * **{{ ui-key.yc-ui-datasphere.docker.docker-template }}** — шаблон с минимальным набором инструкций для сборки рабочего Docker-образа с выбранной версией Python.
     * **{{ ui-key.yc-ui-datasphere.docker.dockerfile }}** — набор инструкций для создания Docker-образа.

       Отредактируйте содержимое поля. Например, следующий код создаст Docker-образ с `python_3_8` на основе оригинального образа TensorFlow:
 
       ```bash
       FROM tensorflow/tensorflow:2.7.0-gpu
 
       RUN set -e \
         && useradd -ms /bin/bash --uid 1000 jupyter \
         && pip install --no-cache-dir --upgrade pip \
         && pip install --no-cache-dir nptyping==1.4.4 pandas==1.4.1 opencv-python-headless==4.5.5.62 scikit-learn==1.0.2 \
         && ln -s /usr/bin/python3 /usr/local/bin/python3
       ```
   
   - {{ ui-key.yc-ui-datasphere.docker.location.datasphere.title }}
   
     Docker-образ будет собран и оптимизирован для использования в проектах {{ ml-platform-name }}. Такой Docker-образ можно [опубликовать](#share) в сообществе. Ресурс будет размещен в выделенном хранилище, которое [тарифицируется](../pricing.md#storage) отдельно.

     Заполните поля:

     * **{{ ui-key.yc-ui-datasphere.docker.disk-size.label }}** — желаемый размер хранилища в ГБ.
     * **{{ ui-key.yc-ui-datasphere.docker.repository }}** — имя образа, например `tensorflow`.
     * **{{ ui-key.yc-ui-datasphere.docker.tag }}** — тег образа, например `1.0.0`.
     * **{{ ui-key.yc-ui-datasphere.docker.build-path }}** — путь внутри проекта, где будет размещаться созданный Docker-образ; `.` — корневая директория.
     * **{{ ui-key.yc-ui-datasphere.common.description }}** — описание Docker-образа.
     * **{{ ui-key.yc-ui-datasphere.docker.docker-template }}** — шаблон скрипта для установки Python.
     * **{{ ui-key.yc-ui-datasphere.docker.dockerfile }}** — набор инструкций для создания Docker-образа.

       Отредактируйте содержимое поля. Например, следующий код создаст Docker-образ с `python_3_8` на основе оригинального образа TensorFlow:
 
       ```bash
       FROM tensorflow/tensorflow:2.7.0-gpu
 
       RUN set -e \
         && useradd -ms /bin/bash --uid 1000 jupyter \
         && pip install --no-cache-dir --upgrade pip \
         && pip install --no-cache-dir nptyping==1.4.4 pandas==1.4.1 opencv-python-headless==4.5.5.62 scikit-learn==1.0.2 \
         && ln -s /usr/bin/python3 /usr/local/bin/python3
       ```
   
   {% endlist %}

1. (Опционально) Активируйте опцию **{{ ui-key.yc-ui-datasphere.docker.credentials-switcher-label }}** и укажите логин и пароль от аккаунта на Docker Hub.

1. Нажмите **{{ ui-key.yc-ui-datasphere.common.build }}**.

    Будет создан Docker-образ с пакетами библиотеки TensorFlow для использования GPU в расчетах.

1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** выберите ![docker](../../_assets/console-icons/logo-docker.svg) **{{ ui-key.yc-ui-datasphere.resources.docker }}**.

{% include [Docker hub limits](../../_includes/datasphere/dockerhub-limits.md) %}

## Применить Docker-образ для проекта {#set}

1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** выберите ![docker](../../_assets/console-icons/logo-docker.svg) **{{ ui-key.yc-ui-datasphere.resources.docker }}**.
1. Напротив нужного образа нажмите ![Options](../../_assets/console-icons/ellipsis.svg) и выберите ![Apply](../../_assets/console-icons/circle-check-fill.svg) **{{ ui-key.yc-ui-datasphere.common.activate }}**.
1. Откройте проект в {{ jlab }}Lab и дождитесь окончания загрузки.
1. Откройте вкладку с ноутбуком и убедитесь, что окружение пользовательского образа доступно в вашем проекте. Например, для образа TensorFlow создайте и запустите ячейку со следующим кодом:

    ```bash
    import tensorflow as tf
    tf.config.list_physical_devices('GPU')
    ```
1. Выберите конфигурацию ВМ. Например, для запуска образа TensorFlow выберите конфигурацию с GPU g1.1. В виджете ВМ в поле **Окружение** должно быть указано полное имя образа.

    Результат:

    ```bash
    ...
    [PhysicalDevice(name='/physical_device:GPU:0', device_type='GPU')]
    ```

Чтобы вернуться к окружению по умолчанию:
1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** выберите ![docker](../../_assets/console-icons/logo-docker.svg) **{{ ui-key.yc-ui-datasphere.resources.docker }}**.
1. Напротив образа по умолчанию нажмите ![Options](../../_assets/console-icons/ellipsis.svg) и выберите ![Apply](../../_assets/console-icons/circle-check-fill.svg) **{{ ui-key.yc-ui-datasphere.common.activate }}**.

## Поделиться Docker-образом {#share}

Поделиться Docker-образом в сообществе может только администратор сообщества, и только если образ был размещен в {{ ml-platform-name }}.

Подробнее о ролях, действующих в {{ ml-platform-name }}, см. в разделе [{#T}](../../datasphere/security/index.md).

1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** нажмите ![docker](../../_assets/console-icons/logo-docker.svg)**{{ ui-key.yc-ui-datasphere.resources.docker }}**.
1. Выберите нужный образ в списке.
1. Перейдите на вкладку **{{ ui-key.yc-ui-datasphere.common.access }}**.
1. Включите опцию видимости напротив названия сообщества, в котором нужно поделиться Docker-образом.

Чтобы Docker-образ стал доступен для работы в другом проекте, администратор проекта должен [добавить](./projects/use-shared-resource.md) его на вкладке **{{ ui-key.yc-ui-datasphere.common.shared-with-project-resources }}**.

## Удалить Docker-образ {#delete}

Нельзя удалить Docker-образ, если он доступен для всего сообщества.

1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** нажмите ![docker](../../_assets/console-icons/logo-docker.svg)**{{ ui-key.yc-ui-datasphere.resources.docker }}**.
1. В списке Docker-образов выберите тот, который хотите удалить.
1. Нажмите ![options](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yc-ui-datasphere.common.delete }}**.
1. Нажмите **{{ ui-key.yc-ui-datasphere.common.submit }}**.

Отобразится сообщение о том, что ресурс удален.

{% include [deletion-time](../../_includes/datasphere/deletion-time.md) %}
