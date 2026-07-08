Если в результате перезапуска работоспособность агента {{ backup-name }} не восстановилась, выполните следующие действия, чтобы вручную пересобрать модуль ядра SnapAPI в нужной версии:

1. Узнайте версию ядра Linux:

    ```bash
    uname -r
    ```

    Результат:

    ```text
    6.8.0-110-generic
    ```

    Как видно из результата, версия ядра Linux — `6.8.0-110-generic`. Это значение понадобится при обновлении модуля.

1. Узнайте версию модуля SnapAPI, при необходимости предварительно установив утилиту `dkms` для вашей операционной системы:

    ```bash
    sudo dkms status | grep snapapi
    ```

    Результат:

    ```text
    snapapi26/2.0.6, 5.15.0-119-generic, x86_64: built
    snapapi26/2.0.6, 6.8.0-48-generic, x86_64: built
    ```

    Как видно из результата, версия модуля SnapAPI — `snapapi26/2.0.6`. Это значение понадобится при обновлении модуля.

1. Обновите модуль SnapAPI, указав в команде полученные ранее версии модуля SnapAPI и ядра Linux:

    ```bash
    sudo dkms install snapapi26/2.0.6 -k 6.8.0-110-generic
    ```

    Результат: 

    ```text
    Building module:
    cleaning build area...
    ...
    - Installation
      - Installing to /lib/modules/6.8.0-110-generic/updates/dkms/
    depmod.......
    ```
1. Повторно выполните команду, чтобы проверить установленную версию модуля SnapAPI:

    ```bash
    sudo dkms status | grep snapapi
    ```

    Результат:

    ```text
    snapapi26/2.0.6, 5.15.0-119-generic, x86_64: built
    snapapi26/2.0.6, 6.8.0-110-generic, x86_64: installed
    snapapi26/2.0.6, 6.8.0-48-generic, x86_64: built
    ```
1. Перезапустите операционную систему:

    ```bash
    sudo reboot
    ```