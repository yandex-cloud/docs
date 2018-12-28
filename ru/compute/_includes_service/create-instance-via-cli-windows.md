1. Посмотрите описание команды CLI для создания виртуальной машины:

    ```
    $ yc compute instance create --help
    ```

1. Выберите один из публичных [образов](../operations/images-with-pre-installed-software/get-list.md) на базе операционной системы Windows.

    [!INCLUDE [standard-images](../../_includes/standard-images.md)]

1. Создайте виртуальную машину в каталоге по умолчанию:

    ```
    $ yc compute instance create \
        --name second-instance \
        --metadata user-data="#ps1\nnet user Administrator <пароль>" \
        --zone ru-central1-a \
        --public-ip \
        --create-boot-disk image-folder-id=standard-images,image-name=windows-2016-gvlk-1537967224
    ```

    Данная команда создаст виртуальную машину с OC Windows Server 2016, именем `second-instance`, пользователем `Administrator` в зоне `ru-central1-a` и публичным IP. Чтобы создать виртуальную машину без публичного IP, исключите флаг `--public-ip`.

    Задайте:

    - Имя виртуальной машины в флаге `--name`. Имя должно быть уникальным в рамках каталога. Может содержать строчные буквы латинского алфавита, цифры и дефисы. Первый символ должен быть буквой. Последний символ не может быть дефисом. Максимальная длина имени — 63 символа.
    - Пароль администратора в флаге `--metadata`. Пароль необходим для доступа на виртуальную машину по RDP. Не используйте легко подбираемые пароли. Пароли должны соответствовать требованиям сложности [политики безопасности](https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh994562%28v%3dws.11%29) Windows. Требования к сложности пароля применяются во время создания виртуальной машины и могут стать причиной отказа в доступе.


