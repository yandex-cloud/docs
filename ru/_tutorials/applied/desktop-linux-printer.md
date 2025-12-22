# Настройка печати с {{ cloud-desktop-full-name }} на локальный принтер в Linux


Это руководство поможет настроить печать файлов из [{{ cloud-desktop-full-name }}](../../cloud-desktop/) на принтер, подключенный к локальной машине под управлением Linux. Решение основано на использовании общего каталога: задания на печать из облачной среды сохраняются в общий каталог, а локальная система перехватывает их и направляет на физический принтер.

{% note info %}

В руководстве приведен пример подключения виртуального принтера для печати в PDF-файл. Чтобы распечатывать на принтере, который подключен к вашей локальной машине (серверу), добавьте этот принтер в сервере печати [CUPS](https://docs.freebsd.org/ru/articles/cups/). При этом не потребуется установка драйвера печати в PDF `printer-driver-cups-pdf`, настройка `/etc/cups/cups-pdf.conf` и создание каталога `/tmp/cups-pdf-output`, а также раздел проверки PDF-файлов.

{% endnote %}

Чтобы настроить печать с рабочего стола {{ cloud-desktop-name }} на локальном принтере в Linux:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Подготовьте инфраструктуру](#create-infrastructure).
1. [Настройте локальную машину](#config-local).
1. [Настройте рабочий стол](#config-desktop).
1. [Проверьте результат](#check-result).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входят:

* Плата за использование вычислительных ресурсов, дисков и исходящий трафик рабочего стола (см. [тарифы {{ cloud-desktop-full-name }}](../../cloud-desktop/pricing.md)).
* Плата за время использования [NAT-шлюза](../../vpc/concepts/gateways.md) и исходящий через него трафик (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).


## Подготовьте инфраструктуру {#create-infrastructure}

Если у вас еще нет рабочего стола, создайте его:

1. Создайте [сеть](../../vpc/operations/network-create.md) и [подсеть](../../vpc/operations/subnet-create.md) для рабочего стола.
1. [Настройте](../../vpc/operations/create-nat-gateway.md) NAT-шлюз для рабочего стола.
1. [Создайте](../../cloud-desktop/operations/desktop-groups/create.md) группу рабочих столов. При создании выберите образ с ОС на базе Linux, например Ubuntu 20.04.
1. [Создайте](../../cloud-desktop/operations/desktops/create.md) рабочий стол.


## Настройте локальную машину {#config-local}

Настройте локальную машину для приема файлов с рабочего стола.

{% list tabs group=operating_system %}

- Linux {#linux}

  1. Установите необходимые инструменты:

      * Утилиту [inotify-tools](https://github.com/inotify-tools/inotify-tools/blob/master/README.md).
      * Сервер печати [CUPS](https://ru.wikipedia.org/wiki/Common_UNIX_Printing_System).
      * Пакет printer-driver-cups-pdf — для проверки печати на виртуальном принтере PDF. Для настройки физического принтера установите драйвер этого принтера.
      * Пакет [Samba](https://ru.wikipedia.org/wiki/Samba).

      Для этого выполните команды:

      ```bash
      sudo apt update
      sudo apt install inotify-tools cups printer-driver-cups-pdf samba
      ```

  1. Создайте общий каталог `/srv/printdrop` и настройте к нему доступ:

      ```bash
      sudo mkdir -p /srv/printdrop
      sudo chown lp:lp /srv/printdrop
      sudo chmod 0770 /srv/printdrop
      ```

      Каталог предназначен для обмена файлами между рабочим столом и локальной машиной.

  1. Настройте Samba:
      1. Откройте файл `/etc/samba/smb.conf`:

          ```bash
          sudo nano /etc/samba/smb.conf
          ```

      1. Добавьте код в конце файла:

          ```text
          [printdrop]
            path = /srv/printdrop
            browseable = yes
            writable = yes
            guest ok = yes
            force user = lp
            force group = lp
            create mask = 0660
            directory mask = 0770
          ```

  1. Настройте CUPS:
      1. Откройте файл `/etc/cups/cups-pdf.conf`:

          ```bash
          sudo nano /etc/cups/cups-pdf.conf
          ```

      1. Найдите строку `Out ${HOME}/PDF` или `#Out ${HOME}/PDF` и замените ее на следующую:

          ```text
          Out /tmp/cups-pdf-output
          ```

  1. Создайте каталог `/tmp/cups-pdf-output` и настройте к нему доступ:

      ```bash
      sudo mkdir -p /tmp/cups-pdf-output
      sudo chown lp:lp /tmp/cups-pdf-output
      sudo chmod 755 /tmp/cups-pdf-output
      ```

      Каталог предназначен для хранения файлов, отправленных на печать.

     {% note info %}
    
     Для физического принтера не надо настраивать `/etc/cups/cups-pdf.conf` и `/tmp/cups-pdf-output`. Добавьте принтер в CUPS через интерфейс администрирования `http://localhost:631`, выбрав **Administration → Add Printer** или командой `lpadmin`. Затем узнайте имя очереди (имя физического принтера) командой `lpstat -p`.
    
     {% endnote %}

  1. Настройте сервис для слежения за общим каталогом:
      1. Создайте файл `print-watcher.sh`:

          ```bash
          sudo nano /usr/local/bin/print-watcher.sh
          ```

      1. Вставьте код в файл `print-watcher.sh`:

          ```text
          #!/bin/bash
          WATCH_DIR="/srv/printdrop"
            PRINTER="PDF" # локально установленный принтер
            USER="lp" # пользователь, для которого инициируется печать
            inotifywait -m -e close_write,moved_to --format '%w%f' "$WATCH_DIR" | while read FILE; do
              if [[ "${FILE,,}" == *.pdf ]]; then
                lp -U "$USER" -d "$PRINTER" "$FILE" && rm -f "$FILE"
              fi
            done
          ```
         {% note info %}
    
         Для физического принтера в параметре PRINTER="PDF" вместо PDF укажите имя физического принтера (имя очереди).
    
         {% endnote %}

      1. Сделайте файл исполняемым:

          ```bash
          sudo chmod +x /usr/local/bin/print-watcher.sh
          ```

      1. Создайте сервисный файл `print-watcher.service`:

          ```bash
          sudo nano /etc/systemd/system/print-watcher.service
          ```
      
      1. Вставьте код в файл `print-watcher.service`:

          ```text
          [Unit]
            Description=Watch printdrop and print files
            
            [Service]
            ExecStart=/usr/local/bin/print-watcher.sh
            Restart=always
            User=lp
            Group=lp
            
            [Install]
            WantedBy=multi-user.target
          ```

  1. Активируйте службу и перезапустите сервисы печати и обмена файлами:

      ```bash
      sudo systemctl daemon-reload
      sudo systemctl restart cups
      sudo systemctl restart smbd
      sudo systemctl enable --now print-watcher.service
      ```

      Результат:

      ```text
      Created symlink /etc/systemd/system/multi-user.target.wants/print-watcher.service → /etc/systemd/system/print-watcher.service.
      ```

  1. Проверьте работу сервиса, выполнив команду:

      ```bash
      systemctl status print-watcher.service
      ```

      Результат:

      ```text
      ● print-watcher.service - Watch printdrop and print files
          Loaded: loaded (/etc/systemd/system/print-watcher.service; enabled; preset: enabled)
          Active: active (running) since ...
          ...
      ```

  1. Сохраните публичный IPv4-адрес вашей локальной машины. Вы можете узнать его, например, с помощью сервиса [Яндекс Интернетометр](https://yandex.ru/internet/). Этот адрес потребуется для монтирования общего каталога на рабочем столе.

{% endlist %}


## Настройте рабочий стол {#config-desktop}

Настройте рабочий стол для отправки файлов на локальную машину.

{% list tabs group=operating_system %}

- Linux {#linux}

  1. [Подключитесь](../../cloud-desktop/operations/desktops/connect.md) к рабочему столу.
  1. Установите сервер CUPS и пакет cifs-utils:

        ```bash
        sudo apt update
        sudo apt install cups
        sudo apt-get install cifs-utils
        ```

  1. Настройте бэкенд для виртуального принтера:
      1. Создайте файл `/usr/lib/cups/backend/printdrop`:

          ```bash
          sudo nano /usr/lib/cups/backend/printdrop
          ```

      1. Вставьте код в файл:

          ```text
          #!/bin/bash
          export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
          if test "$#" = "0"; then
            echo 'file printdrop:/printdrop "PrintDrop" "/printdrop"'
            exit 0
          fi

          DROP_DIR="/home/<имя_пользователя_стола>/printdrop"
          mkdir -p /tmp/cups-shared

          JOBFILE="$6"  # если CUPS передал файл как аргумент
          TS=$(date +%s)-$RANDOM
          OUT="$DROP_DIR/job-$TS.pdf"
          SHARED_OUT="/tmp/cups-shared/job-$TS.pdf"

          if [ -n "$JOBFILE" ] && [ -f "$JOBFILE" ]; then
            cp "$JOBFILE" "$SHARED_OUT"
            chmod -R 777 /tmp/cups-shared
            sudo -u <имя_пользователя_стола> /usr/local/bin/copy-as-user.sh "$SHARED_OUT" "$OUT"
          else
            cat - > "$SHARED_OUT"
            sudo -u <имя_пользователя_стола> /usr/local/bin/copy-as-user.sh "$SHARED_OUT" "$OUT"
          fi
          ```

          Укажите имя пользователя рабочего стола, от имени которого вы будете отправлять файлы на печать.

      1. Настройте доступ к файлу:

          ```bash
          sudo chmod 755 /usr/lib/cups/backend/printdrop
          sudo chown root:root /usr/lib/cups/backend/printdrop
          ```

  1. Настройте доступ к общему каталогу:
      1. Создайте файл `/usr/local/bin/copy-as-user.sh`:

          ```bash
          sudo nano /usr/local/bin/copy-as-user.sh
          ```

      1. Вставьте код вспомогательного скрипта:

          ```text
          #!/bin/bash
          mv "$1" "$2.tmp"
          mv "$2.tmp" "$2"
          ```

      1. Настройте доступ к файлу:

          ```bash
          sudo chmod +x /usr/local/bin/copy-as-user.sh
          sudo chown root:root /usr/local/bin/copy-as-user.sh
          ```

      1. Настройте права:

          ```bash
          sudo visudo
          ```

      1. В конце открывшегося файла вставьте строку:

          ```text
          lp ALL=(<имя_пользователя_стола>) NOPASSWD: /usr/local/bin/copy-as-user.sh
          ```

          Укажите имя пользователя рабочего стола, от имени которого вы будете отправлять файлы на печать.

  1. Создайте виртуальный принтер и активируйте его:

      ```bash
      sudo lpadmin -p DropPrinter -E -v printdrop:/printdrop
      sudo cupsenable DropPrinter
      sudo cupsaccept DropPrinter
      ```

      В результате появится сообщение о добавлении нового принтера.

  1. Создайте каталог для монтирования общего каталога:

      ```bash
      sudo mkdir -p ~/printdrop
      ```

  1. Смонтируйте общий каталог:

      ```bash
      sudo mount -t cifs //<IP-адрес_локальной_машины>/printdrop ~/printdrop -o guest,uid=$(id -u),gid=$(id -g)
      ```

      Укажите сохраненный ранее IPv4-адрес.

{% endlist %}


## Проверьте результат {#check-result}

Чтобы проверить результат, отправьте на печать PDF-файл.

{% list tabs group=operating_system %}

- Linux {#linux}

  1. На рабочем столе создайте или [скачайте](https://pdfobject.com/pdf/sample.pdf) любой PDF-файл.
  1. На рабочем столе отправьте на печать PDF-файл, выбрав созданный виртуальный принтер.

      В результате отобразится сообщение о поступлении файла в очередь печати.

  1. На локальной машине проверьте очередь печати виртуального принтера PDF.

{% endlist %}


### Диагностика ошибок {#errors}

Для диагностики воспользуйтесь следующими командами на локальной машине.

{% list tabs group=operating_system %}

- Linux {#linux}

  * Посмотреть логи CUPS, связанные с получением заданий на печать:

      ```bash
      sudo tail -n 10 /var/log/cups/access_log
      ```

      Результат:

      ```text
      ...
      localhost - - [15/Nov/2025:21:55:01 +0000] "POST /printers/PDF HTTP/1.1" 200 394 Create-Job successful-ok
      localhost - - [15/Nov/2025:21:55:01 +0000] "POST /printers/PDF HTTP/1.1" 200 408591 Send-Document successful-ok
      ```

  * Посмотреть логи ошибок CUPS:

      ```bash
      sudo tail -n 10 /var/log/cups/error_log
      ```

      Подобные записи сообщают об ошибках:

      ```text
      ...
      W [15/Nov/2025:21:55:01 +0000] [Job 34] Backend cups-pdf returned status 5 (cancel job)
      ```

  * Посмотреть PDF-файлы, созданные виртуальным принтером:

      ```bash
      sudo ls -l /tmp/cups-pdf-output/
      ```

      Результат:

      ```text
      total 472
      -rw------- 1 lp lp 239840 Nov 17 19:37 job-1763408227-8471-job_2.pdf
      ...
      ```

{% endlist %}


## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. [Удалите](../../vpc/operations/delete-nat-gateway.md) NAT-шлюз.
1. [Удалите](../../cloud-desktop/operations/desktops/delete.md) рабочий стол.

При необходимости удалите [подсети](../../vpc/operations/subnet-delete.md), [сеть](../../vpc/operations/network-delete.md) и [группу рабочих столов](../../cloud-desktop/operations/desktop-groups/delete.md).