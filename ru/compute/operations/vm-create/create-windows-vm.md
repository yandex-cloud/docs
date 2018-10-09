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
    
    Имя должно быть уникальным в рамках каталога. Имя может содержать строчные буквы латинского алфавита, цифры и дефисы. Первый символ должен быть буквой. Последний символ не должен быть дефисом. Максимальная длина имени — 63 символа.

    В метаданных задайте пароль, с которым можно будет войти на виртуальную машину по RDP. 
    
    Не используйте легко подбираемые пароли. Если ваш пароль смогут подобрать злоумышленники, они получат доступ к виртуальной машине от имени `Administrator`. Пароли должны соответствовать требованиям сложности политики безопасности Windows. Требования к сложности пароля применяются во время создания виртуальной машины и могут стать причиной отказа в доступе.

    Создание виртуальной машины и инициализация операционной системы Windows могут занять до 5 минут.

---

При создании виртуальной машине назначаются IP-адрес и FQDN. Эти данные можно использовать для доступа к виртуальной машине по RDP.

#### См. также
- [Политика паролей](https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh994562%28v%3dws.11%29)
