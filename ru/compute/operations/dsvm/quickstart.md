# Создание виртуальной машины из публичного образа DSVM

Создайте [виртуальную машину](../../concepts/vm.md) DSVM с помощью сервиса {{ compute-name }} в консоли управления {{ yandex-cloud }} и подключитесь к ней по протоколу SSH.

## Перед началом работы {#before-you-begin}

{% include [before-you-begin-linux](../../../_includes/compute/before-you-begin-linux.md) %}

## Создать виртуальную машину из публичного образа DSVM {#create-dsvm}

{% include [create-instance-via-console-dsvm](../../_includes_service/create-instance-via-console-dsvm.md) %}

## Подключиться к виртуальной машине по протоколу SSH {#first-login}

Вы можете подключиться к виртуальной машине по протоколу SSH, когда она будет запущена (в статусе `RUNNING`). Для этого можно использовать утилиту `ssh` в Linux и macOS и программу [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/) для Windows.

Подробнее по подключение по протоколу SSH читайте в разделе [Подключение к виртуальной машине](../../quickstart/quick-create-linux.md#connect-to-vm).

После подключения в приветственном сообщении вы увидите команды для активации окружения и запуска [Jupyter Notebook](http://jupyter.org/index.html) и [JupyterLab](https://jupyterlab.readthedocs.io/en/stable/):

```
#####################################################################
Welcome to Yandex Data Science Virtual Machine
Image Build: ...

Please use one of the following commands to activate
the environment with the framework of your choice:
    for Python2 ______________________ source activate py27
    for Python3 ______________________ source activate py36

Packages installed in each environment:
    catboost, xgboost, lightgbm,
    tensorflow, pytorch,
    jupyter, matplotlib,
    numpy, scipy, scikit-learn

To run public {{ jlab }}Lab execute:
    jupyter lab --no-browser

To run public {{ jlab }} notebook execute:
    jupyter notebook --no-browser

Description and help:
    https://cloud.yandex.ru/docs/compute/operations/dsvm/

#####################################################################
```
