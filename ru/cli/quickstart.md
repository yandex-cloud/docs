# Начало работы с интерфейсом командной строки

_Интерфейс командной строки Яндекс.Облака (CLI)_ — скачиваемое программное обеспечение для управления вашими облачными ресурсами через командную строку.

## Установка {#install}


---

**[!TAB Linux]**

1. Выполните в командной строке:
   ```
   $ curl https://[!KEYREF s3-storage-host][!KEYREF yc-install-path] | bash
   ```
   Скрипт установит CLI и добавит путь до исполняемого файла в переменную окружения `PATH`.

   > [!NOTE]
   >
   > Скрипт дополнит переменную `PATH` только, если его запустить в командных оболочках `bash` или `zsh`.
   >
   > Если вы запустили скрипт в другой оболочке, добавьте путь до CLI в переменную `PATH` самостоятельно.

1. После завершения установки перезапустите командную оболочку.



**[!TAB macOS]**

1. Выполните в командной строке:
    ```
    $ curl https://[!KEYREF s3-storage-host][!KEYREF yc-install-path] | bash
    ```
    Скрипт установит CLI и добавит путь до исполняемого файла в переменную окружения `PATH`.
1. Перезапустите командную оболочку, чтобы перезагрузить переменные окружения.

CLI поддерживает автодополнение команд в командной оболочке `bash`. Чтобы автодополнение заработало:

1. Установите менеджер пакетов [Homebrew](https://brew.sh).
1. Установите пакет `bash-completion`:
   ```
   $ brew install bash-completion
   ```
1. После завершения установки добавьте в файл ` ~/.bash_profile` строки:
   ```
   if [ -f $(brew --prefix)/etc/bash_completion ]; then
   . $(brew --prefix)/etc/bash_completion
   fi
   ```
1. Перезапустите командную оболочку.


**[!TAB Windows]**

Для Windows CLI можно установить с помощью PowerShell и `cmd`:

* Для установки с помощью PowerShell: 
    
    1. Выполните команду:
    
        ```
        iex (New-Object System.Net.WebClient).DownloadString('https://storage.yandexcloud.net/yandexcloud-yc/install.ps1')
        ```
	
    1. Скрипт установки спросит, нужно ли добавить путь до `yc` в переменную PATH:
        
        ```
        Add yc installation dir to your PATH? [Y/n]
        ```
        
    1. Введите `Y`. После этого CLI Яндекс.Облака можно пользоваться, командную оболочку перезапускать не нужно.

* Для установки с помощью `cmd`:
    
    1. Выполните команду:
        
        ```
        @"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://storage.yandexcloud.net/yandexcloud-yc/install.ps1'))" && SET "PATH=%PATH%;%USERPROFILE%\yandex-cloud\bin"
        ```
    
    1. Скрипт установки спросит, нужно ли добавить путь до `yc` в переменную PATH:
    
        ```
        Add yc installation dir to your PATH? [Y/n]
        ```
    
    1. Введите `Y`.

    1. Перезапустите командную оболочку, чтобы перезагрузить переменные окружения.

---


## Инициализация {#initialize}

  1. Получите OAuth-токен в сервисе Яндекс.OAuth. Для этого перейдите по [ссылке](https://oauth.yandex.ru/authorize?response_type=token&client_id=1a6990aa636648e9b2ef855fa7bec2fb) и нажмите **Разрешить**.
  1. Запустите команду `yc init`, чтобы выполнить настройку вашего профиля CLI.
  1. По запросу команды введите свой OAuth токен.
     ```
     Please go to https://oauth.yandex.ru/authorize?response_type=token&client_id=1a6990aa636648e9b2ef855fa7bec2fb
      in order to obtain OAuth token.

     Please enter OAuth token: AaAaBbBbCcCcDdDdEeEeFfFfGgGg
     ```
  1. Выберите одно из предложенных облаков, в которых у вас есть права доступа:
     ```
     Please select cloud to use:
      [1] cloud1 (id = aoe2bmdcvatao4frg22b)
      [2] cloud2 (id = dcvatao4faoe2bmrg22b)
     Please enter your numeric choice: 2
     ```
  1. Выберите каталог по умолчанию:
     ```
     Please choose a folder to use:
      [1] folder1 (id = cvatao4faoe2bmdrg22b)
      [2] folder2 (id = tao4faoe2cvabmdrg22b)
      [3] Create a new folder
     Please enter your numeric choice: 1
     ```
  1. Выберите зону доступности по умолчанию для сервиса [!KEYREF compute-full-name]:
     ```
     Do you want to configure a default [!KEYREF compute-full-name] availability zone? [Y/n] Y
     Which zone do you want to use as a profile default?
      [1] ru-central1-a
      [2] ru-central1-b
      [3] ru-central1-c
      [4] Don't set default zone
     Please enter your numeric choice: 2
     ```
  1. Проверьте настройки вашего профиля CLI:
     ```
     $ yc config list
     ```

## Примеры команд {#example}

Ниже описана последовательность действий для создания облачной сети, подсети и виртуальной машины, подключенной к этой подсети.

1. Посмотрите описание команд CLI для работы с облачными сетями:
   ```
   $ yc vpc network --help
   ```
1. Создайте облачную сеть в каталоге, указанном в вашем профиле CLI:
   ```
   $ yc vpc network create \
       --name my-yc-network \
       --labels my-label=my-value \
       --description "my first network via yc"
   ```
1. Создайте подсеть в облачной сети `my-yc-network`:
   ```
   $ yc vpc subnet create \
       --name my-yc-subnet-b \
       --zone ru-central1-b \
       --range 10.1.2.0/24 \
       --network-name my-yc-network \
       --description "my first subnet via yc"
   ```
1. Получите список всех облачных сетей в каталоге, указанном в вашем профиле CLI:
   ```
   $ yc vpc network list

   +----------------------+------------------+-------------------------+
   |          ID          |       NAME       |       DESCRIPTION       |
   +----------------------+------------------+-------------------------+
   | skesdqhkc6449hbqqar1 | my-ui-network    | my first network via ui |
   | c6449hbqqar1skesdqhk | my-yc-network    | my first network via yc |
   +----------------------+------------------+-------------------------+
   ```
   Получите тот же список c большим количеством деталей в формате YAML:
   ```
   $ yc vpc network list --format yaml

   - id: skesdqhkc6449hbqqar1
     folder_id: ijkl9012
     created_at: "2018-09-05T09:51:16Z"
     name: my-ui-network
     description: "my first network via ui"
     labels: {}
   - id: c6449hbqqar1skesdqhk
     folder_id: ijkl9012
     created_at: "2018-09-05T09:55:36Z"
     name: my-yc-network
     description: "my first network via yc"
     labels:
       my-label: my-value
   ```
1. Создайте виртуальную машину и подключите к подсети `my-yc-subnet-b`:
   1. Подготовьте пару ключей (открытый и закрытый) для SSH-доступа на виртуальную машину.
   1. Создайте виртуальную машину:
      ```
      $ yc compute instance create \
          --name my-yc-instance \
          --network-interface subnet-name=my-yc-subnet-b,nat-ip-version=ipv4 \
          --ssh-key ~/.ssh/id_rsa.pub
      ```
      В параметре `ssh-key` передайте путь к открытому ключу для SSH-доступа. В ОС виртуальной машины будет автоматически создан пользователь `yc-user` с указанным открытым ключом.
1. Подключитесь к виртуальной машине по SSH:
   1. Узнайте публичный IP-адрес виртуальной машины. Для этого посмотрите подробную информацию о вашей виртуальной машине:
      ```
      $ yc compute instance get my-yc-instance
      ```
      В выводе команды найдите адрес виртуальной машины в блоке `one_to_one_nat`:
      ```
      one_to_one_nat:
          address: 130.193.32.90
          ip_version: IPV4
      ```
   2. Подключитесь к виртуальной машине по SSH от имени пользователя `yc-user`, используя закрытый ключ:
      ```
      $ ssh yc-user@130.193.32.90
      ```
1. Удалите виртуальную машину `my-yc-instance`, подсеть `my-yc-subnet-b` и сеть `my-yc-network`:
   ```
   $ yc compute instance delete my-yc-instance
   $ yc vpc subnet delete my-yc-subnet-b
   $ yc vpc network delete my-yc-network
   ```
