# Работа с Docker-образами

Вы можете настроить окружение для выполнения вашего кода, используя [Docker-образы](../concepts/docker.md).

{{ ml-platform-full-name }} позволяет создавать репозитории Docker-образов в проекте, а также выбирать образ для проекта. Выбранный образ будет использоваться при запуске кода во всех ноутбуках проекта.

## Создать Docker-образ {#create}

1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
1. В правом верхнем углу нажмите **{{ ui-key.yc-ui-datasphere.project-page.project-card.create-resource }}**. Во всплывающем окне выберите **{{ ui-key.yc-ui-datasphere.resources.docker }}**.
1. Заполните поля:
    * **{{ ui-key.yc-ui-datasphere.docker.build-path }}** — путь внутри проекта, где будет размещаться созданный Docker-образ; `.` — корневая директория.
    * **{{ ui-key.yc-ui-datasphere.docker.repository }}** — имя образа, например `tensorflow`.
    * **{{ ui-key.yc-ui-datasphere.docker.tag }}** — тег образа, например `1.0.0`.
    * **{{ ui-key.yc-ui-datasphere.docker.docker-template }}** — шаблон скрипта для установки Python: `python_3_7` или `python_3_8`.
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

1. (опционально) В блоке **{{ ui-key.yc-ui-datasphere.docker.credentials-switcher-label }}** укажите логин и пароль от аккаунта на Docker Hub.

1. Нажмите **{{ ui-key.yc-ui-datasphere.common.build }}**.

    Будет создан Docker-образ с пакетами библиотеки TensorFlow для использования GPU в расчетах.

1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** выберите ![docker](../../_assets/datasphere/docker.svg) **{{ ui-key.yc-ui-datasphere.resources.docker }}**.

{% include [Docker hub limits](../../_includes/datasphere/dockerhub-limits.md) %}

## Применить Docker-образ для проекта {#set}

1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** выберите ![docker](../../_assets/datasphere/docker.svg) **{{ ui-key.yc-ui-datasphere.resources.docker }}**.
1. Напротив нужного образа нажмите ![Options](../../_assets/options.svg) и выберите ![Apply](../../_assets/datasphere/apply.svg) **{{ ui-key.yc-ui-datasphere.common.activate }}**.
1. Откройте проект в {{ jlab }}Lab и дождитесь окончания загрузки.
1. Откройте вкладку с ноутбуком и убедитесь, что окружение пользовательского образа доступно в вашем проекте. Например, для образа TensorFlow создайте и запустите ячейку со следующим кодом:

    ```bash
    #!g1.1
    import tensorflow as tf
    tf.config.list_physical_devices('GPU')
    ```

    Результат:

    ```bash
    ...
    [PhysicalDevice(name='/physical_device:GPU:0', device_type='GPU')]
   ```
Чтобы вернуться к окружению по умолчанию:
1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** выберите ![docker](../../_assets/datasphere/docker.svg) **{{ ui-key.yc-ui-datasphere.resources.docker }}**.
1. Напротив образа по умолчанию нажмите ![Options](../../_assets/options.svg) и выберите ![Apply](../../_assets/datasphere/apply.svg) **{{ ui-key.yc-ui-datasphere.common.activate }}**.

{% note warning %}

Системный образ Python 3.7 не работает с [конфигурациями](../../datasphere/concepts/configurations.md) g2.x (GPU A100).

{% endnote %}

## Поделиться Docker-образом {#share}

Поделиться Docker-образом в сообществе может только администратор сообщества.

Подробнее о ролях, действующих в {{ ml-platform-name }}, см. в разделе [{#T}](../../datasphere/security/index.md). 

1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** нажмите ![docker](../../_assets/datasphere/docker.svg)**{{ ui-key.yc-ui-datasphere.resources.docker }}**.
1. Выберите нужный образ в списке.
1. Перейдите на вкладку **{{ ui-key.yc-ui-datasphere.common.access }}**.
1. Включите опцию видимости напротив названия сообщества, в котором нужно поделиться Docker-образом.

## Удалить Docker-образ {#delete}

1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** нажмите ![docker](../../_assets/datasphere/docker.svg)**{{ ui-key.yc-ui-datasphere.resources.docker }}**.
1. В списке Docker-образов выберите тот, который хотите удалить.
1. Нажмите ![options](../../_assets/options.svg) и выберите **{{ ui-key.yc-ui-datasphere.common.delete }}**.
1. Нажмите **{{ ui-key.yc-ui-datasphere.common.submit }}**.

Отобразится сообщение о том, что ресурс удален.
