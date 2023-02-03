# GeeseFS

[GeeseFS](https://github.com/yandex-cloud/geesefs) — программа для Linux и macOS, позволяющая монтировать бакеты {{ objstorage-name }} через [FUSE]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/FUSE_(модуль_ядра)){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/Filesystem_in_Userspace){% endif %}. Программа разработана командой {{ yandex-cloud }} как ответвление от [goofys](goofys.md). Она обеспечивает высокую производительность и POSIX-совместимость.

## Функциональность {#features}

### Производительность {#performance}

По сравнению с goofys и [s3fs](s3fs.md) GeeseFS работает с большими количествами малых файлов (размером до 1 МБ) на порядки быстрее, а с большими файлами — на аналогичной скорости или быстрее. Подробнее о тестах производительности см. в [репозитории GeeseFS на GitHub](https://github.com/yandex-cloud/geesefs/tree/master/bench).

Чтобы GeeseFS работала быстрее, в ней реализованы:

* Параллельное опережающее чтение (parallel readahead).
* Эвристическое опережающее чтение при случайном доступе: если размер нескольких запрошенных подряд блоков ниже порога, для следующих запросов GeeseFS будет скачивать из хранилища меньшие блоки.
* Параллельная [составная загрузка](../concepts/multipart.md) объектов в хранилище (parallel multipart upload).
* Оптимизированное изменение объектов: клиент и хранилище обмениваются только измененными частями объекта.
* Фоновая загрузка малых деревьев объектов и [папок](../concepts/object.md#folder): при запросе папки GeeseFS скачает все дерево за одно обращение к хранилищу.
* Асинхронная запись, переименование и удаление объектов.
* Использование дискового кеша для чтения и записи.   

### POSIX-совместимость {#posix-compatibility}

Помимо базовых функций из стандартов POSIX (`open`, `read`, `write`, `close` и т. д.), GeeseFS поддерживает следующие возможности:

* Корректное чтение объектов сразу после записи в них (read-after-write consistency).
* Частичная запись (обратите внимание: в [версионируемых](../concepts/versioning.md) бакетах при частичной записи могут появляться промежуточные версии объекта).
* `fsync` — синхронизация содержимого объекта или папки между памятью машины и хранилищем.
* `truncate` — произвольное изменение размера объекта.
* Символические (мягкие) ссылки.
* `xattr` — расширенные атрибуты файлов.
* Переименование папок.
* `readdir` — чтение метаинформации о папках.

### Ограничения {#restrictions}

В GeeseFS не поддерживаются:

* Работа с правами доступа к файлам и папкам, в том числе команды `chmod` и `chown`. 

  При монтировании файловой системы вы можете указать:
 
  * Права доступа ко всем файлам или папкам в значениях опций `--file-mode` и `--dir-mode` соответственно.
  * Идентификатор пользователя — владельца всех файлов и папок в значении опции `--uid`.
  * Идентификатор группы, к которой относятся все файлы и папки, в значении опции `--gid`.
  
  Например:
  
  ```bash
  geesefs <имя бакета> <точка монтирования> \
    --file-mode=0666 \
    --dir-mode=0777 \
    --uid=1000
  ```
  
* Жесткие ссылки.
* Блокировка файлов.
* Корректное время последнего доступа к файлу (`atime`) и последнего изменения атрибутов файла (`ctime`). В обоих полях всегда содержится время последнего изменения файла — то же, что и в поле `mtime`.
* Создание файлов размером больше 1 ТБ.

## Подготовка к работе {#before-you-begin}

{% include [aws-tools-prepare](../../_includes/aws-tools/aws-tools-prepare.md) %}

## Установка {#installation}

{% list tabs %}

- Linux

  1. Установите утилиты для работы FUSE. Например:
  
     * Debian, Ubuntu:
     
       ```bash
       sudo apt-get install fuse fuse3
       ```
       
     * CentOS:
     
       ```bash
       sudo yum install fuse fuse3
       ```
     
  1. Скачайте и установите GeeseFS:
  
     ```bash
     wget https://github.com/yandex-cloud/geesefs/releases/latest/download/geesefs-linux-amd64
     chmod a+x geesefs-linus-amd64
     sudo cp geesefs-linux-amd64 /usr/bin/geesefs
     ```

- macOS

  1. Установите пакет [macFUSE](https://osxfuse.github.io/). Подробнее см. в [инструкции по установке](https://github.com/osxfuse/osxfuse/wiki/FAQ#2-installuninstall-questions) в репозитории macFUSE на GitHub.
  1. Скачайте и установите GeeseFS:

     ```bash
     platform='arm64'
     if [[ $(uname -m) == 'x86_64' ]]; then platform='amd64'; fi
     wget https://github.com/yandex-cloud/geesefs/releases/latest/download/geesefs-mac-$platform
     chmod a+x geesefs-mac-$platform
     sudo cp geesefs-mac-$platform /usr/bin/geesefs
     ```

{% endlist %}

Также вы можете самостоятельно собрать GeeseFS из исходного кода. Подробнее см. в [инструкции](https://github.com/yandex-cloud/geesefs#installation) в репозитории GeeseFS на GitHub.


## Аутентификация {#authentication}

GeeseFS использует {% if audience != "internal" %}[статический ключ доступа](../../iam/concepts/authorization/access-key.md){% else %}статический ключ доступа{% endif %} к {{ objstorage-name }}, хранящийся в файле `.aws/credentials`. Также можно поместить ключ в переменные окружения `AWS_ACCESS_KEY_ID` и `AWS_SECRET_ACCESS_KEY`.

При работе с GeeseFS на виртуальной машине {{ compute-name }}, к которой {% if audience != "internal" %}[привязан сервисный аккаунт](../../compute/operations/vm-connect/auth-inside-vm.md#link-sa-with-instance){% else %}привязан сервисный аккаунт{% endif %}, вы можете включить упрощенную аутентификацию, без статического ключа доступа. Для этого при монтировании бакета используйте опцию `--iam`.

## Монтирование бакета {#bucket-mounting}

1. Выберите каталог, в который вы будете монтировать бакет, и убедитесь, что у вас достаточно прав для операции монтирования.
1. Для разового монтирования бакета выполните команду вида:

    ```
    geesefs <имя бакета> <точка монтирования>
    ```

Чтобы бакет монтировался автоматически при запуске системы, добавьте в файл `/etc/fstab` строку вида:

```
<имя бакета>    <точка монтирования>    fuse.geesefs    _netdev,allow_other,--file-mode=0666,--dir-mode=0777    0   0
```

При монтировании бакета вы можете указать настройки GeeseFS, в том числе связанные с [производительностью](#performance) и правами доступа к объектам, с помощью опций командной строки. Чтобы посмотреть список опций и их описания, выполните команду `geesefs --help`.
