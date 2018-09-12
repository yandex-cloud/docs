# Начало работы с интерфейсом командной строки

_Интерфейс командной строки Яндекс.Облака (YC CLI)_ — скачиваемое программное обеспечение для управления вашими облачными ресурсами через командную строку.

## Установка {#install}


---

**[!TAB Windows]**

1. Скачайте исполняемый файл YC CLI для [Windows 64-bit]([!KEYREF yc-windows-path-amd64])/[Winodws 32-bit]([!KEYREF yc-windows-path-386]) и сохраните на своем компьютере, например, в директории `C:\Yandex-Cloud`. 

   <u>???Исполняемый файл доступен для скачивания только после аутентификации в консоли Яндекс.Облака.</u>
2. Добавить в переменную окружения **PATH** путь до директории с исполняемым файлом YC CLI:
   1. Нажмите комбинацию клавиш **Windows**+**R** и выполните команду ` control.exe /name Microsoft.System`.
   2. Перейдите по ссылке **Дополнительные параметры системы**.
   3. Нажмите на кнопку **Переменные среды**.
   4. Выберите переменную **PATH** и нажмите кнопку **Изменить**.
   5. В поле **Значение переменной** к текущему значению допишите символ `;` и путь до директории с исполняемым файлом YC CLI, например, `C:\Yandex-Cloud`.
   
      Нажмите **ОК** последовательно во окнах **Изменение пользовательской переменной**, **Переменные среды**, **Свойства системы**.
   


**[!TAB macOS и Linux]**

Выполните в командной строке:
   ```
   curl '[!KEYREF yc-install-path]' | bash -s -- -a
   ```
Программное обеспечение YC CLI установится автоматически. После завершения установки перезапустите shell. 


---


## Инициализация {#initialize}

Запустите команду `yc init`, чтобы выполнить настройку вашего профиля YC CLI:
  
  1. По запросу команды введите свой OAuth токен. Получить OAuth токен можно по [ссылке](https://oauth.yandex.ru/authorize?response_type=token&client_id=1a6990aa636648e9b2ef855fa7bec2fb).
     ```
     Please go to https://oauth.yandex.ru/authorize?response_type=token&client_id=1a6990aa636648e9b2ef855fa7bec2fb
      in order to obtain OAuth token.
     
     Please enter OAuth token: AaAaBbBbCcCcDdDdEeEeFfFfGgGg
     ```
  2. Выберите одно из предложенных облаков, в которых у вас есть права доступа:
     ```
     Please select cloud to use:
      [1] cloud1 (id = abcd1234)
      [2] cloud2 (id = efgh5678)
     Please enter your numeric choice: 2
     ```
  3. Выберите каталог по умолчанию:
     ```
     Please choose a folder to use:
      [1] folder1 (id = ijkl9012)
      [2] folder2 (id = mnop3456)
     Please enter your numeric choice: 1
     ```
  4. Выберите зону доступности по умолчанию для сервиса [!KEYREF compute-full-name]:
     ```
     Do you want to configure a default [!KEYREF compute-full-name] availability zone? [Y/n] Y
     Which zone do you want to use as a profile default?
      [1] ru-central1-a
      [2] ru-central1-b
      [3] ru-central1-c
      [4] Don't set default zone
     Please enter your numeric choice: 2
     ```

## Запуск команд {#run-commands}

1. Проверьте настройки вашего профиля YC CLI:
   ```
   yc config list
   
   token: AaAaBbBbCcCcDdDdEeEeFfFfGgGg
   cloud-id: efgh5678
   folder-id: ijkl9012
   compute-default-zone: ru-central1-b
   ```
2. Посмотрите описание команд YC CLI:
   ```
   yc --help
   
   yc vpc --help
   
   yc vpc network --help
   ```
3. Создайте облачную сеть в каталоге, указанном в вашем профиле YC CLI:
   ```
   yc vpc network create \
       --name my-yc-network \
       --labels my-label=my-value \
       --description "my first network via yc"
       
   id: c6449hbqqar1skesdqhk
   folder_id: ijkl9012
   created_at: "2018-09-05T09:55:36Z"
   name: my-yc-network
   description: my first network via yc
   labels:
     my-label: my-value
   ```
4. Создайте подсеть в облачной сети `my-yc-network`:
   ```
   yc vpc subnet create \
       --name my-yc-subnet-b \
       --zone ru-central1-b \
       --range 10.1.2.0/24 \
       --network-id c6449hbqqar1skesdqhk \
       --description: "my first subnet via yc"
    
   id: bb3osak50bltmgs6ulho
   folder_id: ijkl9012
   created_at: "2018-09-05T10:05:36Z"
   name: my-yc-subnet-b
   description: my first subnet via yc
   labels: {}
   network_id: c6449hbqqar1skesdqhk
   zone_id: ru-central1-b
   v4_cidr_blocks:
   - 10.1.2.0/24
   ```
5. Получите список всех облачных сетей в каталоге, указанном в вашем профиле YC CLI:
   ```
   yc vpc network list
   +------------------+----------------------+------------+-------------------------+
   |       NAME       |          ID          | FOLDER ID  |       DESCRIPTION       |
   +------------------+----------------------+------------+-------------------------+
   | my-ui-network    | skesdqhkc6449hbqqar1 | ijkl9012   | my first network via ui |
   | my-yc-network    | c6449hbqqar1skesdqhk | ijkl9012   | my first network via yc |
   +------------------+----------------------+------------+-------------------------+
   ```
   Получите тот же список c большим количеством деталей в формате yaml:
   ```
   yc vpc network list --format yaml
   
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
6. Удалите подсеть `my-yc-subnet-b` и сеть `my-yc-network`:
   ```
   yc vpc subnet delete my-yc-subnet-b
   yc vpc network delete my-yc-network
   ```
