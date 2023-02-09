1. Посмотрите описание команды CLI для создания виртуальной машины:

    ```
    yc compute instance create --help
    ```

1. Выберите один из публичных образов на базе операционной системы Windows.

    {% include [standard-images](../../_includes/standard-images.md) %}

1. Создайте YAML-файл (например, `metadata.yaml`) и укажите следующие данные:

    ```yaml
    #ps1
    net user administrator '<пароль>'
    ```

1. Создайте виртуальную машину в каталоге по умолчанию:

    ```
    yc compute instance create \
      --name second-instance \
      --metadata-from-file user-data=metadata.yaml \
      --zone {{ region-id }}-a \
      --public-ip \
      --create-boot-disk image-folder-id=standard-images,image-family=windows-2016-gvlk
    ```

    Данная команда создаст виртуальную машину со следующими характеристиками:

    - С именем `second-instance`.
    - С OC Windows Server 2016.
    - В зоне доступности `{{ region-id }}-a`.
    - С пользователем `Administrator`.
    - С публичным IP.

    Чтобы создать виртуальную машину без публичного IP, исключите флаг `--public-ip`.

    Задайте:

    - Имя виртуальной машины в флаге `--name`.

        Имя должно быть уникальным в рамках каталога. Может содержать строчные буквы латинского алфавита, цифры и дефисы. Первый символ должен быть буквой. Последний символ не может быть дефисом. Максимальная длина имени — 63 символа.

        {% include [name-fqdn](../../_includes/compute/name-fqdn.md) %}

    - Пароль администратора в файле `metadata.yaml`. Пароль необходим для доступа на виртуальную машину по RDP.

        {% include [password-requirements](../../_includes/compute/password-requirements.md) %}


