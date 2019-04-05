# Получить вывод последовательного порта

Вы можете получить информацию, которую виртуальная машина выводит в последовательный порт, и использовать ее, например, для диагностики неполадок.

---

**[!TAB Консоль управления]**

1. Выберите каталог, которому принадлежит виртуальная машина.
1. Нажмите плитку **Compute Cloud**.
1. Нажмите на строку с нужной виртуальной машиной.
1. Перейдите на вкладку **Последовательный порт**.

**[!TAB CLI]**

[!INCLUDE [default-catalogue](../../../_includes/default-catalogue.md)]

1. Посмотрите описание команды для получения вывода последовательного порта:

    ```
    $ yc compute instance get-serial-port-output --help
    ```

1. Выберите виртуальную машину, например `first-instance`:

    [!INCLUDE [compute-instance-list](../../_includes_service/compute-instance-list.md)]

1. Получите вывод последовательного порта. Вывод последовательного порта обычно длинный, поэтому его стоит писать в файл:

    ```
    $ yc compute instance get-serial-port-output first-instance > output.txt
    ```

**[!TAB API]**

Чтобы получить вывод последовательного порта, используйте метод [getSerialPortOutput](../../api-ref/Instance/getSerialPortOutput.md) ресурса [Instance](../../api-ref/Instance/index.md).

---
