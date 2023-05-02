# Работа с Docker-образами

Вы можете настроить окружение для выполнения вашего кода, используя [Docker-образы](../concepts/docker.md).

{{ ml-platform-full-name }} позволяет создавать репозитории Docker-образов в проекте, а также выбирать образ для проекта. Выбранный образ будет использоваться при запуске кода во всех ноутбуках проекта.

## Создать Docker-образ {#create}

1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
1. В правом верхнем углу нажмите **{{ ui-key.yc-ui-datasphere.project-page.project-card.create-resource }}**. Во всплывающем окне выберите **{{ ui-key.yc-ui-datasphere.resources.docker }}**.
1. Заполните поля:
    * **{{ ui-key.yc-ui-datasphere.docker.build-path }}** — путь внутри проекта, где будет размещаться созданный Docker-образ; `.` — корневая директория.
    * **{{ ui-key.yc-ui-datasphere.docker.repository }}** — имя образа, например `cuda`.
    * **{{ ui-key.yc-ui-datasphere.docker.tag }}** — тег образа, например `1.0.0`.
    * **{{ ui-key.yc-ui-datasphere.docker.docker-template }}** — шаблон скрипта для установки Python: `python_3_7` или `python_3_8`.
    * **{{ ui-key.yc-ui-datasphere.docker.dockerfile }}** — набор инструкций для создания Docker-образа.    

      Отредактируйте содержимое поля. Например, чтобы установить пакеты платформы CUDA<sup>®</sup>, потребуется шаблон образа `python_3_8` и следующий код:

      ```bash
      FROM ubuntu:18.04
      ENV DEBIAN_FRONTEND noninteractive
      RUN useradd -ms /bin/bash --uid 1000 jupyter\
       && apt update\
       && apt install -y python3.8-dev python3.8-distutils gnupg wget software-properties-common curl\
       && ln -s /usr/bin/python3.8 /usr/local/bin/python3\
       && curl https://bootstrap.pypa.io/get-pip.py | python3
      ENV LD_LIBRARY_PATH /usr/local/cuda-11.2/lib64:/usr/local/nvidia/lib:/usr/local/nvidia/lib64:/usr/local/cuda/lib64:/usr/local/cuda/extras/CUPTI/lib64
      RUN apt-get update &&\
       apt-get install -y -q xserver-xorg-core wget &&\
       wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-ubuntu1804.pin -O /etc/apt/preferences.d/cuda-repository-pin-600 &&\
       apt-key adv --fetch-keys <публичный GPG-ключ> &&\
       add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/ /" &&\
       apt-get update &&\
       apt-get -y install cuda libcudnn8 nvidia-cuda-toolkit &&\
       exit
      RUN pip install tensorflow-gpu==2.4.1
      ```

      Вместо `<публичный GPG-ключ>` укажите ссылку на актуальный GPG-ключ для работы с платформой CUDA<sup>®</sup>, например `https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/3bf863cc.pub`. См. подробности в [блоге Nvidia](https://developer.nvidia.com/blog/updating-the-cuda-linux-gpg-repository-key/).

1. Нажмите **{{ ui-key.yc-ui-datasphere.common.build }}**.

    Будет создан Docker-образ с пакетами платформы CUDA<sup>®</sup> для использования GPU в расчетах.

1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** выберите ![docker](../../_assets/datasphere/docker.svg) **{{ ui-key.yc-ui-datasphere.resources.docker }}**.

## Применить Docker-образ для проекта {#set}

1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** выберите ![docker](../../_assets/datasphere/docker.svg) **{{ ui-key.yc-ui-datasphere.resources.docker }}**.
1. Напротив нужного образа нажмите ![Options](../../_assets/options.svg) и выберите ![Apply](../../_assets/datasphere/apply.svg) **{{ ui-key.yc-ui-datasphere.common.activate }}**.
1. Откройте проект в {{ jlab }}Lab и дождитесь окончания загрузки.
1. Откройте вкладку с ноутбуком и убедитесь, что окружение пользовательского образа доступно в вашем проекте. Например, для образа с CUDA<sup>®</sup> создайте и запустите ячейку со следующим кодом:

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
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** нажмите ![docker](../../_assets/datasphere/docker.svg).**{{ ui-key.yc-ui-datasphere.resources.docker }}**.
1. В списке Docker-образов выберите тот, который хотите удалить.
1. Нажмите ![options](../../_assets/options.svg) и выберите **{{ ui-key.yc-ui-datasphere.common.delete }}**.
1. Нажмите **{{ ui-key.yc-ui-datasphere.common.submit }}**.

Отобразится сообщение о том, что ресурс удален.
