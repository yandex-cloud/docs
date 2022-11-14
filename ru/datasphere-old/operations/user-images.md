# Создание пользовательского Docker-образа для проекта

{% include [link-on-new-ui-datasphere-in-old-ui](../../_includes/datasphere/datasphere-old-note.md) %}

Вы можете настроить окружение для выполнения вашего кода, используя Docker-образы.

{{ ml-platform-full-name }} позволяет создавать репозитории Docker-образов в проекте, а также выбирать образ для проекта. Выбранный образ будет использоваться при запуске кода во всех ноутбуках проекта.

## Требования к Docker-образу {#requirements}

Чтобы {% if lang == "ru" %}[Docker-образ](https://cloud.yandex.ru/blog/posts/2022/03/docker-containers){% else %}Docker-образ{% endif %} запускался и корректно работал в {{ ml-platform-name }}, он должен содержать:

* установку Python 3.7 или Python 3.8;
* установку pip;
* пользователя {{ jlab }}.

{% note info %}

Шаблоны Docker-образов, представленные в {{ ml-platform-name }}, уже удовлетворяют требованиям. Если вы загружаете образ из стороннего источника или пишите свой, добавьте в него необходимые команды. 

{% endnote %}

## Создать Docker-образ {#create}

Чтобы создать Docker-образ:

1. Перейдите во вкладку ![docker](../../_assets/datasphere/docker.svg)**Docker images**.
1. Нажмите кнопку ![plus-sign](../../_assets/plus-sign.svg).
1. На открывшейся вкладке:
    1. Введите имя репозитория, например `cuda`.
    1. Задайте тег образа, например `1.0.0`.
    1. Выберите шаблон скрипта для установки Python: `python_3_7` или `python_3_8`.
    1. Отредактируйте содержимое блока **Dockerfile**. Например, чтобы установить пакеты платформы CUDA<sup>®</sup>, потребуется шаблон образа python 3.8 и следующий код:

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
         apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub &&\
         add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/ /" &&\
         apt-get update &&\
         apt-get -y install cuda libcudnn8 nvidia-cuda-toolkit &&\
         exit
        RUN pip install tensorflow-gpu==2.6
        ```

    1. Нажмите кнопку **Build**.

        Будет создан Docker-образ c пакетами платформы CUDA<sup>®</sup> для использования GPU в расчетах.

    1. Чтобы использовать образ для проекта, нажмите кнопку **Set image to project**, затем **Ok**.

Убедитесь, что окружение пользовательского образа доступно в вашем проекте. Например, для образа с CUDA<sup>®</sup> создайте и запустите ячейку со следующим кодом:

```bash
#!g1.1
import tensorflow as tf
tf.config.list_physical_devices('GPU')
```

Результат:

```text
...
[PhysicalDevice(name='/physical_device:GPU:0', device_type='GPU')]
```

{% note info %}

Чтобы вернуться к окружению по умолчанию, перейдите на вкладку ![docker](../../_assets/datasphere/docker.svg) **Docker images** и нажмите кнопку **Set image to project**.

{% endnote %}
