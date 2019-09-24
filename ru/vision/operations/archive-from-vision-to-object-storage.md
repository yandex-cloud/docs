# Оцифровка архива в Yandex Vision

[Yandex Vision](https://cloud.yandex.ru/docs/vision/) — сервис компьютерного зрения для анализа изображений.

С помощью этой инструкции вы выполните:
* настройку окружения Яндекс.Облака для работы с Yandex Vision;
* распознавание текста в изображениях с помощью Yandex Vision;
* загрузите результат на [Yandex Object Storage](https://cloud.yandex.ru/docs/storage/).

1. [Подготовьте облако к работе](#before-begin).
1. [Создайте и настройте виртуальную машину](#create-vm).
1. [Настройте AWS CLI](#aws-cli).
1. [Настройте доступ в Object Storage](#object-storage-access).
1. [Создайте архив с изображениями](#create-archive).
1. [Создайте скрипт для оцифровки и загрузки изображений](#create-script).
1. [Проверьте корректность оцифровки](#check).
1. [Удалите созданные облачные ресурсы](#cleanup).


## Подготовьте облако к работе {#before-begin}

Перед тем, как создать виртуальную машину, нужно зарегистрироваться в Облаке и создать платежный аккаунт:

{% include [prepare-register-billing](../_solutions_includes/prepare-register-billing.md) %}

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать каталог, в котором будет работать ваша виртуальная машина. Перейдите на [страницу облака](https://console.cloud.yandex.ru/cloud) и выберите или создайте каталог, в котором вы хотите создать виртуальную машину для вашего сервера. [Подробнее об иерархии ресурсов Облака](../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы

* плата за постоянно запущенную виртуальную машину (см. [тарифы Yandex Compute Cloud](https://cloud.yandex.ru/docs/compute/pricing)).
* плата за использование динамического или статического внешнего IP-адреса (см. [тарифы Yandex Virtual Private Cloud](https://cloud.yandex.ru/docs/vpc/pricing)).
* плата за использование Object Storage (см. [тарифы для Object Storage](https://cloud.yandex.ru/docs/storage/pricing))
* плата за использование Yandex Vision (см. [тарифы для Yandex Vision](https://cloud.yandex.ru/docs/vision/pricing))


## Создайте и настройте виртуальную машину {#create-vm}

### Создайте виртуальную машину:

1. На странице каталога в [консоли управления]({{ link-console-main }}) нажмите кнопку **Создать ресурс** и выберите пункт **Виртуальная машина**.
1. В поле **Имя** введите имя виртуальной машины.

    {% include [name-format](../../_includes/name-format.md) %}

1. Выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой должна находиться виртуальная машина.
1. В блоке **Публичные образы** выберите образ Centos 7.

1. В блоке **Диски** выберите:
    * SSD
    * 19 Гб
   
1. В блоке **Вычислительные ресурсы**:
    - Выберите [платформу](../../compute/concepts/vm-platforms.md) виртуальной машины.
    - Укажите необходимое количество vCPU и объем RAM.

   Для запуска виртуальной машины выберите:
   * **Платформа** — Intel Cascade Lake.
   * **Гарантированная доля vCPU** — 20%.
   * **vCPU** — 2.
   * **RAM** — 2 ГБ.

1. В блоке **Сетевые настройки** нужно выбрать сеть и подсеть, к которым нужно подключить виртуальную машину. Если нужной сети или подсети еще нет, вы можете создать их прямо на странице создания виртуальной машины.

1. В поле **Публичный адрес** оставьте значение **Автоматически**, чтобы назначить виртуальной машине случайный внешний IP-адрес из пула Яндекс.Облака. Чтобы внешний IP-адрес не изменялся после остановки виртуальной машины, [сделайте его статическим](https://cloud.yandex.ru/docs/vpc/operations/set-static-ip).

1. Укажите данные для доступа на виртуальную машину:
    - В поле **Логин** введите имя пользователя.
    - В поле **SSH-ключ** вставьте содержимое файла открытого ключа.
      
      Пару ключей для подключения по SSH необходимо создать самостоятельно, см. [раздел о подключении к виртуальным машинам по SSH](../../compute/operations/vm-connect/ssh.md).
      
    {% note alert %}
    
     IP-адрес и имя хоста (FQDN) для подключения к машине будут назначены ей при создании. Если вы выбрали вариант **Без адреса** в поле **Публичный адрес**, вы не сможете обращаться к виртуальной машине из интернета.
    
    {% endnote %}

1. Нажмите кнопку **Создать ВМ**.

Создание виртуальной машины может занять несколько минут. 


### Настройте Yandex CLI

1. Зайдите на виртуальную машину по SSH.
1. Установите Yandex CLI по [инструкции](https://cloud.yandex.ru/docs/cli/quickstart):
    1. Выполните установку.
    1. Выполните инициализацию.
1. Убедитесь, что Yandex CLI функционирует корректно:
    ```bash
    yc config list
    ```
    Результатом должен быть вывод настроек произведенных на этапе конфигурации.
    
### Настройте сервисный аккаунт

1. Создайте сервисный аккаунт, назовите его, например `vision`:
    ```bash
    yc iam service-account create --name vision --description "this is vision service account"
    ```
1. Узнайте идентификатор каталога по [инструкции](https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id):
1. Узнайте идентификатор вашего сервисного аккаунта, подставив соответствующий идентификатор каталога:
    ```bash
    yc iam service-account --folder-id <FOLDER-ID>  get vision
    ```
    На выводе вы получите одну из строк вида:
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
    
1. Получите IAM-токен для сервисного аккаунта с помощью CLI по [инструкции](https://cloud.yandex.ru/docs/iam/operations/iam-token/create-for-sa) {#iam-token}:

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
    * `AWS Access Key ID` - это значение `key_id` из предыдущего раздела пункта "Создайте статический ключ доступа для сервисного аккаунта".
    * `AWS Secret Access Key` - это значение `secret` там же.
    * `Default region name` - введите `ru-central1`
    * `Default output format` - введите `json`
1. Проверьте, что файл `~/.aws/credentials` содержит правильные значения:
    ```bash
    cat ~/.aws/credentials
    ```
1. Проверьте, что файл `~/.aws/config` содержит правильные значения:
    ```bash
    cat ~/.aws/config
    ```

## Настройте доступ в Object Storage {#object-storage-access}
1. Создайте Object Storage бакет по [инструкции](https://cloud.yandex.ru/docs/storage/operations/buckets/create):
    * Максимальный размер оставьте по умолчанию.
    * Доступ к бакету - Ограниченный.
    * Класс хранилища - Холодное.
1. Зайдите в консоль Яндекс.Облака и убедитесь, что бакет отображается в списке:
    ```https://console.cloud.yandex.ru/folders/<FOLDER-ID>/storage```
 
## Создайте архив с изображениями {#create-archive}
1. Загрузите произвольные картинки с текстом на ваш бакет по [инструкции](https://cloud.yandex.ru/docs/storage/operations/objects/upload) 
1. Убедитесь, что картинки загрузились корректно:
    ```bash
    aws --endpoint-url=https://storage.yandexcloud.net s3 ls s3://<BUCKET-NAME>/
    ```
    `<BUCKET-NAME>` - название вашего бакета
1. Скачайте картинки на виртуальную машину, например, в папку `my_pictures`:
     ```bash
    aws --endpoint-url=https://storage.yandexcloud.net s3 cp s3://<BUCKET-NAME>/ my_pictures --recursive
    ```
1. Запакуйте картинки в архив с названием, например `my_pictures`:    
    ```bash
    tar -cf my_pictures.tar my_pictures/*
    ```
1. Удалите папку с картинками:
    ```bash
    rm -rfd my_pictures
    ```
  
## Создайте скрипт для оцифровки и загрузки изображений {#create-script}
### Подготовка
1. Установите пакет `jq`, который понадобится в скрипте для обработки результатов из Vision:
    ```bash
    yum install jq -y    
    ```
1. Создайте переменные окружения, необходимые для работы скрипта:
    ```bash
    export BUCKETNAME="<BUCKET-NAME>"
    export FOLDERID="<FOLDER-ID>"
    export IAMTOKEN="<IAM-TOKEN>"
    ```
    * `BUCKETNAME` - название вашего бакета.
    * `FOLDERID` - название каталога.
    * `IAMTOKEN`- IAM-токен полученный в [этом разделе](#iam-token).

### Написание скрипта
В данном скрипте реализуются следующие этапы:
1. Создание необходимых директорий.
1. Распаковка архива с картинками.
1. Обработка изображений в цикле:
    1. Кодирование изображения для пересылки в POST-запросе в Vision.
    1. Формирование тела запроса для данного изображения.
    1. Пересылка изображения в Vision с последующей обработкой.
    1. Запись полученного результата в `output.json`.
    1. Парсинг текста из `output.json` и запись в текстовый файл.
1. Запаковка в архив всех текстовых файлов, полученных после обработки картинок.
1. Перемещение оцифрованного архива в Object Storage.
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
        -d @body.json \
        https://vision.api.cloud.yandex.net/vision/v1/batchAnalyze > output.json
    
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
    aws --endpoint-url=https://storage.yandexcloud.net s3 cp my_pictures_text.tar s3://$BUCKETNAME/ > /dev/null
    
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
1. Зайдите в Object Storage в консоли Яндекс.Облака.
1. Убедитесь, что в вашем бакете появился архив `my_pictures_text.tar`.
1. Скачайте и распакуйте архив.
1. Убедитесь что текст в файле `<имя картинки>.txt` совпадает с текстом на соответствующей картинке.


## Удалите созданные облачные ресурсы {#cleanup}
Если вам больше не нужны облачные ресурсы, созданные в процессе оцифровки архива:

* [Удалите виртуальную машину](https://cloud.yandex.ru/docs/compute/operations/vm-control/vm-delete).
* [Удалите статический IP адрес](https://cloud.yandex.ru/docs/vpc/operations/address-delete), если он был вами создан.
* [Удалите Object Storage Bucket](https://cloud.yandex.ru/docs/storage/operations/buckets/delete)