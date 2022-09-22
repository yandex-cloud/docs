# Конфигурация окружения с помощью Docker-образа

Вы можете настроить окружение для выполнения вашего кода, используя [Docker-образы](../concepts/resource-model.md#resources).

{{ ml-platform-full-name }} позволяет создавать репозитории Docker-образов в проекте, а также выбирать образ для проекта. Выбранный образ будет использоваться при запуске кода во всех ноутбуках проекта.

## Требования к Docker-образу {#requirements}

Чтобы Docker-образ запускался и корректно работал в {{ ml-platform-name }}, он должен содержать:
* установку Python 3.7 или Python 3.8;
* установку pip;
* пользователя Jupiter.

{% note info %}

Шаблоны Docker-образов, представленные в {{ ml-platform-name }}, уже удовлетворяют требованиям. Если вы загружаете образ из стороннего источника или пишите свой, добавьте в него необходимые команды. 

{% endnote %}

## Создать Docker-образ {#create}

Чтобы создать Docker-образ:
1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
1. В правом верхнем углу нажмите кнопку **Создать ресурс**. Во всплывающем окне выберите **Docker**.
1. Заполните поля:
    * **Путь к образу внутри проекта** — путь внутри проекта, где будет размещаться созданный Docker-образ; `.` — корневая директория.
    * **Имя образа** — имя образа, например `cuda`.
    * **Тег** — тег образа, например `1.0.0`.
    * **Шаблон Docker-образа** — шаблон скрипта для установки Python: `python_3_7` или `python_3_8`.
    * **Файл Docker** — набор инструкций для создания Docker-образа.    

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

1. Нажмите кнопку **Собрать**.

    Будет создан Docker-образ c пакетами платформы CUDA<sup>®</sup> для использования GPU в расчетах.

Чтобы посмотреть все созданные Docker-образы:
1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
1. В блоке **Ресурсы** выберите **Docker**.

