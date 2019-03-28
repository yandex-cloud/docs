# Отключить доступ к серийной консоли

Включенный доступ к серийной консоли небезопасен: злоумышленники могут получить доступ к вашей виртуальной машине.

Чтобы отключить доступ к серийной консоли, установите в метаданных виртуальной машины параметр `serial-port-enable` в значение `0`.

[!INCLUDE [cli-install](../../../_includes/cli-install.md)]

[!INCLUDE [default-catalogue](../../../_includes/default-catalogue.md)]

1. Получите список виртуальных машин в каталоге по умолчанию:

    [!INCLUDE [compute-instance-list](../../_includes_service/compute-instance-list.md)]

1. Выберите `ID` или `NAME` нужной машины, например `first-instance`.

1. Установите в метаданных виртуальной машины параметр `serial-port-enable=0`:

    ```bash
    $ yc compute instance add-metadata \
        --name first-instance \
        --metadata serial-port-enable=0
    ```

    Данная команда запустит операцию деактивации серийной консоли на машины с именем `first-instance`.
