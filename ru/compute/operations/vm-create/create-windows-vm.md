# Создать виртуальную машину с Windows

---

**[!TAB Консоль управления]**

[!INCLUDE [create-instance-via-concole-windows](../../_includes_service/create-instance-via-concole-windows.md)]

**[!TAB CLI]**

Чтобы создать виртуальную машину:

1. Посмотрите описание команд CLI для создания виртуальной машины:

    ```
    yc compute instance create --help
    ```

2. Выберите один из публичных [образов](../../concepts/images.md) на базе операционной системы Windows. Получить список образов можно с помощью команды:

    ```
    yc compute image list --folder-id standard-images
    ```

3. Создайте текстовый файл следующего содержания:

    ```
    #ps1
    net user Administrator <пароль>
    ```

    Где:

    - 



4. Создайте виртуальную машину:

    ```
    yc compute instance create \
    --name my-yc-vm \
    --metadata-from-file user-data=path/to/file \
    --description "my first vm via yc" \
    --zone ru-central1-a \
    --public-ip \
    --create-boot-disk image-folder-id=standard-images,image-name=windows-2012-r2-eval-1537434603 
    ```

Данная команда создаст виртуальную машину с Windows Server 2012R2, именем `my-yc-vm` в зоне `ru-central1-a`.

---
