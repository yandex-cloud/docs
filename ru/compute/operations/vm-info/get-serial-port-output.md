# Получить вывод последовательного порта

Вы можете получить информацию, которую виртуальная машина выводит в последовательный порт, и использовать ее, например, для диагностики неполадок.

---

**[!TAB Консоль управления]**

1. Выберите каталог, которому принадлежит виртуальная машина.
2. Нажмите плитку **Yandex Compute Cloud**.
3. Нажмите на строку с нужной виртуальной машиной.
4. Перейдите на вкладку **Последовательный порт**.

**[!TAB CLI]**

[!INCLUDE [default-catalogue](../../../_includes/default-catalogue.md)]

1. Посмотрите описание команды для получения вывода последовательного порта:

    ```
    $ yc compute instance get-serial-port-output --help
    ```

2. Выберите виртуальную машину, например `my-instance`:

    [!INCLUDE [cli-instance-list](../../_includes_service/cli-instance-list.md)]

3. Получите вывод последовательного порта. Вывод последовательного порта обычно длинный, поэтому его стоит писать в файл:

    ```
    $ yc compute instance get-serial-port-output my-instance > output.txt
    ```

**[!TAB API]**

Чтобы получить вывод последовательного порта, используйте метод [getSerialPortOutput](../../api-ref/Instance/getSerialPortOutput.md) ресурса [Instance](../../api-ref/Instance/index.md).

---