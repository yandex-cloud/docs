# Создать виртуальную машину с Windows

---

**[!TAB Консоль управления]**

[!INCLUDE [create-instance-via-concole-windows](../../_includes_service/create-instance-via-concole-windows.md)]

**[!TAB CLI]**

[!INCLUDE [default-catalogue](../../../_includes/default-catalogue.md)]

Чтобы создать виртуальную машину:

1. Посмотрите описание команд CLI для создания виртуальной машины:

    ```
    yc compute instance create --help
    ```

2. Выберите один из публичных [образов](../../concepts/images.md) на базе операционной системы Windows. Получить список доступных образов можно с помощью команды:

    ```
    yc compute image list --folder-id standard-images
    ```

4. Создайте виртуальную машину в каталоге по умолчанию:

    ```
    yc compute instance create \
        --name my-yc-vm \
        --metadata user-data="#ps1\nnet user Administrator <пароль>" \
        --description "my first vm via yc" \
        --zone ru-central1-a \
        --public-ip \
        --create-boot-disk image-folder-id=standard-images,image-name=windows-2016-gvlk-1537967224
    ```

    Данная команда создаст виртуальную машину с OC Windows Server 2016, именем `my-yc-vm`, пользователем `Administrator` в зоне `ru-central1-a`. 
    
    [!INCLUDE [name-format](../../../_includes/name-format.md)]

    В метаданных задайте пароль, с которым можно будет войти на виртуальную машину по RDP. [!INCLUDE [password-requirements](../../../_includes/password-requirements.md)]

    Создание виртуальной машины и инициализация операционной системы Windows могут занять до 5 минут.

---

При создании виртуальной машине назначаются IP-адрес и FQDN. Эти данные можно использовать для доступа к виртуальной машине по RDP.
