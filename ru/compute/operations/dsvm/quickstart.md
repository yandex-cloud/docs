# Создать виртуальную машину из публичного образа DSVM

Чтобы создать виртуальную машину:

1. Откройте каталог, в котором будет создана виртуальная машина.
1. Нажмите кнопку **Создать ресурс**.
1. Выберите **Виртуальная машина**.
1. В поле **Имя** введите имя виртуальной машины.

    [!INCLUDE [name-format](../../../_includes/name-format.md)]

1. Выберите [зону доступности](../../../overview/concepts/geo-scope.md), в которой будет находиться виртуальная машина.
1. Выберите публичный [образ](../images-with-pre-installed-software/get-list.md) DSVM.
1. В блоке **Вычислительные ресурсы** выберите [тип использования ядра](../../concepts/vm-types.md) (частичное или полное), укажите необходимое количество vCPU и объем RAM.
1. В блоке **Сетевые настройки** выберите, к какой подсети необходимо подключить виртуальную машину при создании.
1. Укажите данные для доступа на виртуальную машину:
    - В поле **Логин** введите имя пользователя.
    - В поле **SSH ключ** вставьте содержимое файла открытого ключа.
        Пару ключей для подключения по SSH необходимо создать самостоятельно. Для создания ключей используйте сторонние инструменты, например утилиты `ssh-keygen` в Linux и macOS или [PuTTygen](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html) в Windows.
1. Нажмите кнопку **Создать ВМ**.

При создании виртуальной машине назначаются IP-адрес и имя хоста (FQDN). Эти данные можно использовать для доступа к виртуальной машине по SSH.

## Подключиться к виртуальной машине DSVM по протоколу SSH {#first-login}

[!INCLUDE [vm-connect-ssh](../../../_includes/vm-connect-ssh.md)]

В приветственном сообщении вы увидите команды для активации окружения и запуска [Jupyter Notebook](http://jupyter.org/index.html) и [JupyterLab](https://jupyterlab.readthedocs.io/en/stable/):

```
#####################################################################
Welcome to Yandex Data Science Virtual Machine
...

Please use one of the following commands to activate
the environment with the framework of your choice:
    for Python2 ______________________ source activate py27
    for Python3 ______________________ source activate py36

...

To run public Jupyter notebook execute:
    jupyter notebook --ip=* --no-browser

To run public JupyterLab execute:
    jupyter lab --ip=* --no-browser

Description and help:
    docs.cloud.yandex.ru/dsvm

#####################################################################
```
