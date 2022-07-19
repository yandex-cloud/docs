# Оцифровка архива в {{ vision-full-name }}

[{{ vision-full-name }}](https://cloud.yandex.ru/docs/vision/) — сервис компьютерного зрения для анализа изображений.

С помощью этой инструкции вы выполните:
* настройку окружения {{ yandex-cloud }} для работы с {{ vision-full-name }};
* распознавание текста в изображениях с помощью {{ vision-full-name }};
* загрузите результат на [{{ objstorage-full-name }}](https://cloud.yandex.ru/docs/storage/).

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте и настройте виртуальную машину](#create-vm).
1. [Настройте AWS CLI](#aws-cli).
1. [Настройте доступ в Object Storage](#object-storage-access).
1. [Создайте архив с изображениями](#create-archive).
1. [Создайте скрипт для оцифровки и загрузки изображений](#create-script).
1. [Проверьте корректность оцифровки](#check).
1. [Удалите созданные облачные ресурсы](#cleanup).


## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}



### Необходимые платные ресурсы

В стоимость поддержки инфраструктуры распознавания и хранения данных входит:

* плата за постоянно запущенную виртуальную машину (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md));
* плата за использование динамического или статического внешнего IP-адреса (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md));
* плата за использование обектного хранилища (см. [тарифы для {{ objstorage-full-name }}](../../storage/pricing.md));
* плата за использование {{ vision-full-name }} (см. [тарифы для {{ vision-full-name }}](../../vision/pricing.md)).



## Создайте и настройте виртуальную машину {#create-vm}

### Создайте виртуальную машину:

1. На странице каталога в [консоли управления]({{ link-console-main }}) нажмите кнопку **Создать ресурс** и выберите пункт **Виртуальная машина**.
1. В поле **Имя** введите имя виртуальной машины.

    {% include [name-format](../../_includes/name-format.md) %}

1. Выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой должна находиться виртуальная машина.
1. В блоке **Выбор образа/загрузочного диска** перейдите на вкладку **{{ marketplace-name }}** и выберите образ [CentOS 7](/marketplace/products/yc/centos-7).

1. В блоке **Диски** выберите:
    * SSD
    * 19 Гб

1. В блоке **Вычислительные ресурсы**:
    - Выберите [платформу](../../compute/concepts/vm-platforms.md) виртуальной машины.
    - Укажите необходимое количество vCPU и объем RAM:
      * **Платформа** — Intel Cascade Lake.
      * **Гарантированная доля vCPU** — 20%.
      * **vCPU** — 2.
      * **RAM** — 2 ГБ.

1. В блоке **Сетевые настройки** выберите сеть и подсеть, к которым нужно подключить виртуальную машину. Если нужной сети или подсети еще нет, вы можете создать их на странице создания виртуальной машины.

1. В поле **Публичный адрес** оставьте значение **Автоматически**, чтобы назначить виртуальной машине случайный внешний IP-адрес из пула {{ yandex-cloud }}. Чтобы внешний IP-адрес не изменялся после остановки виртуальной машины, [сделайте его статическим](https://cloud.yandex.ru/docs/vpc/operations/set-static-ip).

1. Укажите данные для доступа на виртуальную машину:
    - В поле **Логин** введите имя пользователя.
    - В поле **SSH-ключ** вставьте содержимое файла открытого ключа.

      Пару ключей для подключения по SSH необходимо создать самостоятельно, см. [раздел о подключении к виртуальным машинам по SSH](../../compute/operations/vm-connect/ssh.md).

    {% note alert %}

     IP-адрес и имя хоста (FQDN) для подключения к машине будут назначены ей при создании. Если вы выбрали вариант **Без адреса** в поле **Публичный адрес**, вы не сможете обращаться к виртуальной машине из интернета.

    {% endnote %}

1. Нажмите кнопку **Создать ВМ**.

Создание виртуальной машины может занять несколько минут.


### Настройте YC CLI

1. Зайдите на виртуальную машину по SSH.
1. Установите YC CLI по [инструкции](../../cli/quickstart.md):
    1. Выполните установку.
    1. Выполните инициализацию.
1. Убедитесь, что YC CLI функционирует корректно:
    ```bash
    yc config list
    ```
    Результатом должен быть вывод настроек, произведенных на этапе конфигурации.

### Настройте сервисный аккаунт

1. Создайте сервисный аккаунт, назовите его, например `vision`:
    ```bash
    yc iam service-account create --name vision --description "this is vision service account"
    ```
1. Узнайте идентификатор каталога по [инструкции](../../resource-manager/operations/folder/get-id.md).
1. Узнайте идентификатор вашего сервисного аккаунта, подставив соответствующий идентификатор каталога:
    ```bash
    yc iam service-account --folder-id <FOLDER-ID>  get vision
    ```

    В результате вы получите одну из строк вида:
    ```
    id: <SERVICE-ACCOUNT-ID>
    ```
1. Настройте роль `editor` для вашего сервисного аккаунта, подставив соответствующее значение:
    ```bash
    yc resource-manager folder add-access-binding default --role editor --subject serviceAccount:<SERVICE-ACCOUNT-ID>
    ```
1. Создайте статический ключ доступа для вашего сервисного аккаунта:
    ```bash
    yc iam access-key create --service-account-name vision --description "this key is for vision"
    ```
    Сохраните следующие значения, они понадобятся для конфигурации AWS CLI:
    * `key_id`
    * `secret`

1. Получите IAM-токен для сервисного аккаунта с помощью CLI по [инструкции](../../iam/operations/iam-token/create-for-sa.md):

    ```bash
    yc iam key create --service-account-name vision --output key.json
    yc config profile create vision-profile
    yc config set service-account-key key.json
    yc iam create-token
    ```

    Сохраните значение IAM-токена, полученного после ввода команды `yc iam create-token`. В дальнейшем это значение понадобится для пересылки изображений в Vision.

## Настройте AWS CLI {#aws-cli}

1. Установите `yum` репозиторий:
    ```bash
    sudo yum install epel-release -y
    ```
1. Установите pip:
    ```bash
    sudo yum install python-pip -y
    ```
1. Установите AWS CLI:
    ```bash
    sudo pip install awscli --upgrade
    ```
1. Настройте AWS CLI:
    ```bash
    aws configure
    ```

    При запросе значений параметров:
    * `AWS Access Key ID` - укажите значение `key_id` из предыдущего раздела пункта "Создайте статический ключ доступа для сервисного аккаунта".
    * `AWS Secret Access Key` - укажите значение `secret` там же.
    * `Default region name` - введите `{{ region-id }}`.
    * `Default output format` - введите `json`.
1. Проверьте, что файл `~/.aws/credentials` содержит правильные значения:
    ```bash
    cat ~/.aws/credentials
    ```
1. Проверьте, что файл `~/.aws/config` содержит правильные значения:
    ```bash
    cat ~/.aws/config
    ```

## Настройте доступ в Object Storage {#object-storage-access}
1. Создайте Object Storage бакет по [инструкции](../../storage/operations/buckets/create.md):
    * Максимальный размер оставьте по умолчанию.
    * Доступ к бакету - **Ограниченный**.
    * Класс хранилища - **Холодное**.
1. Зайдите в консоль {{ yandex-cloud }} и убедитесь, что бакет отображается в списке:
    
    ```
    {{ link-console-main }}/folders/<FOLDER-ID>/storage
    ```

## Создайте архив с изображениями {#create-archive}
1. Загрузите изображения с текстом в ваш бакет по [инструкции](../../storage/operations/objects/upload.md).
1. Убедитесь, что изображения были загружены:
    ```bash
    aws --endpoint-url=https://{{ s3-storage-host }} s3 ls s3://<BUCKET-NAME>/
    ```
    Где `<BUCKET-NAME>` - название вашего бакета.
1. Скачайте изображения на виртуальную машину, например, в папку `my_pictures`:
     ```bash
    aws --endpoint-url=https://{{ s3-storage-host }} s3 cp s3://<BUCKET-NAME>/ my_pictures --recursive
    ```
1. Запакуйте изображения в архив с названием, например `my_pictures`:
    ```bash
    tar -cf my_pictures.tar my_pictures/*
    ```
1. Удалите папку с изображениями:
    ```bash
    rm -rfd my_pictures
    ```

## Создайте скрипт для оцифровки и загрузки изображений {#create-script}

### Подготовка
1. Установите пакет `jq`, который понадобится в скрипте для обработки результатов из {{ vision-name }}:
    ```bash
    yum install jq -y
    ```
1. Создайте переменные окружения, необходимые для работы скрипта:
    ```bash
    export BUCKETNAME="<BUCKET-NAME>"
    export FOLDERID="<FOLDER-ID>"
    export IAMTOKEN="<IAM-TOKEN>"
    ```

    Где:

    * `BUCKETNAME` - название вашего бакета.
    * `FOLDERID` - название каталога.
    * `IAMTOKEN`- IAM-токен полученный в [этом разделе](#iam-token).

### Написание скрипта
В данном скрипте реализуются следующие этапы:
1. Создание необходимых директорий.
1. Распаковка архива с картинками.
1. Обработка изображений в цикле:
    1. Кодирование изображения для пересылки в POST-запросе в {{ vision-name }}.
    1. Формирование тела запроса для данного изображения.
    1. Пересылка изображения в Vision с последующей обработкой.
    1. Запись полученного результата в `output.json`.
    1. Парсинг текста из `output.json` и запись в текстовый файл.
1. Запаковка в архив всех текстовых файлов, полученных после обработки картинок.
1. Перемещение оцифрованного архива в {{ objstorage-name }}.
1. Удаление ненужных файлов.

Для удобства в теле скрипта добавлены комментарии по каждому шагу.

1. Создайте файл, c произвольныйм названием, например `vision.sh`. Откройте это файл в текстовом редакторе, например `vi`:
    ```bash
    vi vision.sh
    ```
1. Скопируйте туда скрипт:
    ```bash
    #!/bin/bash

    # Создайте необходимые директории.
     echo "Creating directories..."

    # Создайте директорию для распознанного текста.
    mkdir my_pictures_text

    # Распакуйте архив с картинками в созданную папку.
    echo "Extract pictures in my_pictures directory..."
    tar -xf my_pictures.tar

    # Оцифруйте картинки из архива.
    FILES=my_pictures/*
    for f in $FILES
    # В цикле для каждого файла из папки с архивом произведите следующие действия:
    do
        # Закодируйте картинку в base64 для отправки на сервер Vision.
        CODEIMG=$(base64 -i $f | cat)

        # Создайте файл body.json, который будет отправляться в POST запросе на сервер Vision.
        cat <<EOF > body.json
    {
    "folderId": "$FOLDERID",
    "analyze_specs": [{
    "content": "$CODEIMG",
    "features": [{
    "type": "TEXT_DETECTION",
    "text_detection_config": {
    "language_codes": ["en","ru"]
    }
    }]
    }]
    }
    EOF
        # Отправьте картинку на сервер Vision для обработки и запишите результат в файл output.json.
        echo "Processing file $f in Vision..."
        curl -X POST --silent \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer ${IAMTOKEN}" \
        -d '@body.json' \
        https://vision.{{ api-host }}/vision/v1/batchAnalyze > output.json

        # Получите название картинки для дальнейшей подстановки.
        IMAGE_BASE_NAME=$(basename -- "$f")
        IMAGE_NAME="${IMAGE_BASE_NAME%.*}"

        # Получите из JSON файла с результатом обработки текстовые данные и запишите их в текстовый файл с названием аналогичным файлу картинки, изменив расширение на ".txt".
        cat output.json | jq -r '.results[].results[].textDetection.pages[].blocks[].lines[].words[].text' | awk -v ORS=" " '{print}' > my_pictures_text/$IMAGE_NAME".txt"
    done

    # Запакуйте содержимое папки с текстовыми файлами в архив.
    echo "Packing text files to archive..."
    tar -cf my_pictures_text.tar my_pictures_text

    # Переместите полученный архив с текстовыми файлами на ваш бакет.
    echo "Sending archive to Object Storage Bucket..."
    aws --endpoint-url=https://{{ s3-storage-host }} s3 cp my_pictures_text.tar s3://$BUCKETNAME/ > /dev/null

    # Удалите ненужные файлы.
    echo "Cleaning up..."
    rm -f body.json
    rm -f output.json
    rm -rfd my_pictures
    rm -rfd my_pictures_text
    rm -r my_pictures_text.tar
    ```
1. Установите разрешения на запуск скрипта:
    ```bash
    sudo chmod 755 vision.sh
    ```
1. Запустите скрипт:
    ```bash
    ./vision.sh
    ```

## Проверьте корректность оцифровки {#check}
1. Зайдите в {{ vision-name }} в консоли {{ yandex-cloud }}.
1. Убедитесь, что в вашем бакете появился архив `my_pictures_text.tar`.
1. Скачайте и распакуйте архив.
1. Убедитесь что текст в файле `<имя изображения>.txt` совпадает с текстом на соответствующем изображении.


## Удалите созданные облачные ресурсы {#cleanup}
Если вам больше не нужны облачные ресурсы, созданные в процессе оцифровки архива:

* [Удалите виртуальную машину](../../compute/operations/vm-control/vm-delete.md).
* [Удалите статический IP адрес](../../vpc/operations/address-delete.md), если он был вами создан.
* [Удалите бакет Object Storage](../../storage/operations/buckets/delete.md).
