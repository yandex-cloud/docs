1. Посмотрите описание команды CLI для создания виртуальной машины:

    ```
    $ yc compute instance create --help
    ```

1. Выберите один из публичных [образов](../operations/images-with-pre-installed-software/get-list.md) на базе операционной системы Windows.

    [!INCLUDE [standard-images](../../_includes/standard-images.md)]

1. Создайте YAML-файл (например, `metadata.yaml`) и укажите следующие данные:

    ```yaml
    #ps1
    net user administrator "<пароль>"
    ```

1. Создайте виртуальную машину в каталоге по умолчанию:

    ```
    $ yc compute instance create \
        --name second-instance \
        --metadata-from-file user-data=metadata.yaml \
        --zone ru-central1-a \
        --public-ip \
        --create-boot-disk image-folder-id=standard-images,image-family=windows-2016-gvlk
    ```

    Данная команда создаст виртуальную машину со следующими характеристиками:

    - С именем `second-instance`.
    - С OC Windows Server 2016.
    - В зоне доступности `ru-central1-a`.
    - С пользователем `administrator`.
    - С публичным IP.

    Чтобы создать виртуальную машину без публичного IP, исключите флаг `--public-ip`.

    Задайте:

    - Имя виртуальной машины в флаге `--name`.

        Имя должно быть уникальным в рамках каталога. Может содержать строчные буквы латинского алфавита, цифры и дефисы. Первый символ должен быть буквой. Последний символ не может быть дефисом. Максимальная длина имени — 63 символа.

        [!INCLUDE [name-fqdn](../../_includes/compute/name-fqdn.md)]

    - Пароль администратора в файле `metadata.yaml`. Пароль необходим для доступа на виртуальную машину по RDP. Не используйте легко подбираемые пароли. Пароли должны соответствовать требованиям сложности [политики безопасности](https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh994562%28v%3dws.11%29) Windows. Требования к сложности пароля применяются во время создания виртуальной машины и могут стать причиной отказа в доступе.


