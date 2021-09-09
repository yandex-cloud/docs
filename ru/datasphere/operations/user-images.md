# Создание пользовательского Docker-образа для проекта

Вы можете настроить окружение для выполнения вашего кода, используя Docker-образы.

{{ ml-platform-full-name }} позволяет создавать репозитории Docker-образов в проекте, а также выбирать образ для проекта. Выбранный образ будет использоваться при запуске кода во всех ноутбуках проекта.

Чтобы создать Docker-образ:

1. Перейдите во вкладку ![docker](../../_assets/datasphere/docker.svg) **Docker images**.
1. Нажмите кнопку ![plus-sign](../../_assets/plus-sign.svg).
1. На открывшейся вкладке:
    1. Введите имя репозитория, например `cuda`.
    1. Задайте тег образа, например `1.0.0`.
    1. Выберите шаблон скрипта для установки Python: `python_3_7` или `python_3_8`.
    1. Отредактируйте содержимое блока **Dockerfile**. Например, для установки пакетов платформы CUDA<sup>®</sup> добавьте следующий код после строки `# Write your instructions here`:

        ```bash
        ENV LD_LIBRARY_PATH /usr/local/cuda-11.2/lib64:/usr/local/nvidia/lib:/usr/local/nvidia/lib64:/usr/local/cuda/lib64
        RUN\
          apt-get update &&\
          apt-get install -y -q xserver-xorg-core wget &&\
          wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-ubuntu1804.pin -O /etc/apt/preferences.d/cuda-repository-pin-600 &&\
          apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub &&\
          add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/ /" &&\
          apt-get update &&\
          apt-get -y install cuda libcudnn8 &&\
          exit
        ```

    1. Нажмите кнопку **Build**.

        Будет создан Docker-образ c пакетами платформы CUDA<sup>®</sup> для использования GPU в расчетах.

    1. Чтобы использовать образ для проекта, нажмите кнопку **Set image to project**, затем **Ok**.

Убедитесь, что окружение пользовательского образа доступно в вашем проекте. Например, для образа с CUDA<sup>®</sup> создайте и запустите ячейку со следующим кодом:

```bash
#!g1.1
%pip install tensorflow==2.4.1
import tensorflow as tf
tf.config.list_physical_devices('GPU')
```

Результат выполнения:

```text
...
[PhysicalDevice(name='/physical_device:GPU:0', device_type='GPU')]
```

{% note info %}

Чтобы вернуться к окружению по умолчанию, нажмите кнопку **Reset docker image in project** на вкладке ![docker](../../_assets/datasphere/docker.svg) **Docker images**.

{% endnote %}
