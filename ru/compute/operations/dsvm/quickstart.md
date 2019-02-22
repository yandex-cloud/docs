# Создать виртуальную машину из публичного образа DSVM

Чтобы создать виртуальную машину:

1. Откройте каталог, в котором будет создана виртуальная машина.
1. Нажмите кнопку **Создать ресурс**.
1. Выберите **Виртуальная машина**.
1. В поле **Имя** введите имя виртуальной машины.

    [!INCLUDE [name-format](../../../_includes/name-format.md)]

1. Выберите [зону доступности](../../../overview/concepts/geo-scope.md), в которой будет находиться виртуальная машина.
1. Выберите публичный [образ](../images-with-pre-installed-software/get-list.md) DSVM.
1. В блоке **Вычислительные ресурсы**:
    - Выберите [тип виртуальной машины](../../concepts/vm-types.md) (легкая или стандартная).
    - Укажите необходимое количество vCPU и объем RAM.
1. В блоке **Сетевые настройки** выберите, к какой подсети необходимо подключить виртуальную машину при создании.
1. Укажите данные для доступа на виртуальную машину:
    - В поле **Логин** введите имя пользователя.
    - В поле **SSH ключ** вставьте содержимое файла открытого ключа.
        Пару ключей для подключения по SSH необходимо создать самостоятельно. Для создания ключей используйте сторонние инструменты, например утилиты `ssh-keygen` в Linux и macOS или [PuTTYgen](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html) в Windows.
1. Нажмите кнопку **Создать ВМ**.

[!INCLUDE [ip-fqdn-connection](../../../_includes/ip-fqdn-connection.md)]

## Подключиться к виртуальной машине DSVM по протоколу SSH {#first-login}

[!INCLUDE [vm-connect-ssh](../../../_includes/vm-connect-ssh.md)]

В приветственном сообщении вы увидите команды для активации окружения и запуска [Jupyter Notebook](http://jupyter.org/index.html) и [JupyterLab](https://jupyterlab.readthedocs.io/en/stable/):

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

To run public JupyterLab execute:
    jupyter lab --no-browser

To run public Jupyter notebook execute:
    jupyter notebook --no-browser

Description and help:
    https://cloud.yandex.ru/docs/compute/operations/dsvm/

#####################################################################
```
