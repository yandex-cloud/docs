# Распознавание архива изображений в {{ vision-full-name }}

Используйте сервис [{{ vision-full-name }}](../../vision/) для распознавания текста на изображениях. Также вы можете использовать [{{ objstorage-full-name }}](../../storage/) для хранения исходных изображений и результатов распознавания.

Чтобы настроить инфраструктуру для распознавания текста с помощью {{ vision-name }} и автоматической выгрузки результатов в {{ objstorage-name }}:
1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте бакет](#create-bucket).
1. [Создайте виртуальную машину](#create-vm).
1. [Настройте виртуальную машину](#configure-vm).
1. [Создайте архив с изображениями](#create-archive).
1. [Подготовьте скрипт для распознавания и загрузки изображений](#prepare-script).
1. [Проверьте корректность распознавания](#check-result).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры для распознавания изображений и хранения данных входят:
* плата за вычислительные ресурсы и диски ВМ (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md));
* плата за хранение данных в бакете и операции с ними (см. [тарифы {{ objstorage-full-name }}](../../storage/pricing.md));
* плата за использование динамического или статического внешнего IP-адреса (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md));
* плата за использование {{ vision-full-name }} (см. [тарифы для {{ vision-full-name }}](../../vision/pricing.md)).


## Создайте бакет {#create-bucket}

Чтобы создать [бакет](../../storage/concepts/bucket.md) {{ objstorage-name }} для хранения исходных изображений и результатов распознавания:

{% list tabs %}

- Консоль управления

  1. Перейдите в [консоль управления]({{ link-console-main }}) {{ yandex-cloud }} и выберите каталог, в котором будете выполнять операции.
  1. На странице каталога нажмите кнопку **Создать ресурс** и выберите **Бакет**.
  1. В поле **Имя** введите имя бакета в соответствии с [правилами именования](../../storage/concepts/bucket.md#naming), например `vision-bucket`.
  1. В поле **Доступ к бакету** выберите **Ограниченный**.
  1. В поле **Класс хранилища** выберите **Холодное**.
  1. Нажмите кнопку **Создать бакет**.

{% endlist %}

## Создайте виртуальную машину {#create-vm}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) на странице каталога нажмите кнопку **Создать ресурс** и выберите **Виртуальная машина**.
  1. В поле **Имя** введите имя ВМ, например `vision-vm`. Требования к имени:

      {% include [name-format](../../_includes/name-format.md) %}

  1. Выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой будет находиться ВМ.
  1. В блоке **Выбор образа/загрузочного диска** перейдите на вкладку **{{ marketplace-name }}** и выберите публичный образ [CentOS 7](/marketplace/products/yc/centos-7).
  1. В блоке **Диски и файловые хранилища** выберите параметры:
      * **Тип** — SSD.
      * **Размер** — 19 ГБ.
  1. В блоке **Вычислительные ресурсы** выберите параметры:
      * **Платформа** — Intel Cascade Lake.
      * **Гарантированная доля vCPU** — 20%.
      * **vCPU** — 2.
      * **RAM** — 2 ГБ.
  1. В блоке **Сетевые настройки** выберите сеть и подсеть, к которым нужно подключить ВМ. Если сети нет, создайте ее:
      1. Выберите пункт ![image](../../_assets/plus-sign.svg) **Создать сеть**.
      1. В открывшемся окне укажите укажите имя сети и каталог, в котором она будет создана.
      1. (опционально) Для автоматического создания подсетей выберите опцию **Создать подсети**.
      1. Нажмите кнопку **Создать**.

          У каждой сети должна быть как минимум одна [подсеть](../../vpc/concepts/network.md#subnet). Если подсети нет, создайте ее, выбрав пункт ![image](../../_assets/plus-sign.svg) **Добавить подсеть**.
  1. В поле **Публичный адрес** оставьте значение **Автоматически**, чтобы назначить ВМ случайный внешний IP-адрес из пула {{ yandex-cloud }}, или выберите статический адрес из списка, если вы [зарезервировали](../../vpc/operations/get-static-ip.md) его заранее.
  1. Укажите данные для доступа на ВМ:
      * В поле **Логин** введите имя пользователя.
      * В поле **SSH-ключ** вставьте содержимое файла открытого ключа.

        Пару ключей для подключения по SSH необходимо создать самостоятельно, см. [{#T}](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
  1. Нажмите кнопку **Создать ВМ**.
  1. Дождитесь перехода ВМ в статус `Running` и сохраните ее публичный IP-адрес, он понадобится для SSH-подключения.

{% endlist %}

## Настройте виртуальную машину {#configure-vm}

### Настройте {{ yandex-cloud }} CLI {#configure-yc-cli}

1. [Подключитесь](../../compute/operations/vm-connect/ssh.md#vm-connect) к ВМ по протоколу SSH.
1. [Установите](../../cli/quickstart.md#install) на ВМ {{ yandex-cloud }} CLI и [создайте](../../cli/quickstart.md#initialize) профиль.
1. Убедитесь, что {{ yandex-cloud }} CLI функционирует корректно:

    {% list tabs %}

    - CLI

      На ВМ выполните команду:

      ```bash
      yc config list
      ```

      Результат:

      ```text
      token: AQ...gs
      cloud-id: b1gdtdqb1900f5rqqvli
      folder-id: b1gveg9vude9g3uioa50
      ```

      Сохраните идентификатор каталога — параметр `folder-id`, он понадобится для настройки сервисного аккаунта.

    {% endlist %}

### Настройте сервисный аккаунт {#configure-sa}

{% list tabs %}

- CLI

  1. Создайте [сервисный аккаунт](../../iam/concepts/users/service-accounts.md):

      ```bash
      yc iam service-account create \
        --name <имя_сервисного_аккаунта> \
        --description "<описание_сервисного_аккаунта>"
      ```

      Где:
      * `--name` — имя сервисного аккаунта, например `vision-sa`.
      * `--description` — описание сервисного аккаунта, например `this is vision service account`.

      Результат:

      ```text
      id: aje6aoc8hccuh5tp55bg
      folder_id: b1gv87ssvu497lpgjh5o
      created_at: "2022-10-12T14:04:43.198559512Z"
      name: vision-sa
      description: this is vision service account
      ```

      Сохраните идентификатор сервисного аккаунта — параметр `id`, он понадобится для дальнейшей настройки.

  1. Назначьте сервисному аккаунту [роль](../../iam/concepts/access-control/roles.md#editor) `editor`:

      ```bash
      yc resource-manager folder add-access-binding <идентификатор_каталога> \
        --role editor \
        --subject serviceAccount:<идентификатор_сервисного_аккаунта>
      ```

      Где:
      * `--role` — назначаемая роль.
      * `--subject serviceAccount` — идентификатор сервисного аккаунта.

  1. Создайте [статический ключ доступа](../../iam/concepts/authorization/access-key.md) для сервисного аккаунта:

      ```bash
      yc iam access-key create \
        --service-account-id <идентификатор_сервисного_аккаунта> \ 
        --description "<описание_ключа>"
      ```

      Где:
      * `--service-account-id` — идентификатор сервисного аккаунта.
      * `--description` — описание ключа, например `this key is for vision`.

      Результат:

      ```yaml
      access_key:
        id: ajen8d7fur27bt8losom
        service_account_id: aje6aoc8hccuh5tp55bg
        created_at: "2022-10-12T15:08:08.045280520Z"
        description: this key is for vision
        key_id: YC...li
      secret: YC...J5
      ```

      Сохраните следующие параметры, они понадобятся для конфигурации утилиты AWS CLI:
      * `key_id` — идентификатор статического ключ доступа.
      * `secret` — секретный ключ.

  1. Создайте [авторизованный ключ](../../iam/concepts/authorization/key.md) для сервисного аккаунта:

      ```bash
      yc iam key create \
        --service-account-id <идентификатор_сервисного_аккаунта> \ 
        --output key.json
      ```

      Где:
      * `--service-account-id` — идентификатор сервисного аккаунта.
      * `--output` — имя файла с авторизованным ключом в формате JSON.

      Результат:

      ```yaml
      id: aje3qc9pagb9kedkhdn5
      service_account_id: aje6aoc8hccuh5tp55bg
      created_at: "2022-10-13T12:53:04.810240976Z"
      key_algorithm: RSA_2048
      ```

  1. Создайте профиль {{ yandex-cloud }} CLI для работы от имени сервисного аккаунта, например `vision-profile`:

      ```bash
      yc config profile create vision-profile
      ```

      Результат:

      ```text
      Profile 'vision-profile' created and activated
      ```

  1. Укажите в конфигурации профиля авторизованный ключ сервисного аккаунта:

      ```bash
      yc config set service-account-key key.json
      ```

  1. Получите [IAM-токен](../../iam/concepts/authorization/iam-token.md) для сервисного аккаунта:

      ```bash
      yc iam create-token
      ```

      Сохраните IAM-токен, он понадобится для отправки изображений в {{ vision-name }}.

{% endlist %}

### Настройте AWS CLI {#configure-aws-cli}

1. Обновите пакеты, установленные в операционной системе ВМ, для этого выполните команду:

    ```bash
    sudo yum update -y
    ```
     
1. Установите AWS CLI:

    ```bash
    sudo yum install awscli -y
    ```

1. Настройте AWS CLI:

    ```bash
    aws configure
    ```

    Укажите значения параметров:
    * `AWS Access Key ID` — идентификатор статического ключа доступа `key_id`, который вы получили при [настройке сервисного аккаунта](#configure-sa).
    * `AWS Secret Access Key` — секретный ключ `secret`, который вы получили при [настройке сервисного аккаунта](#configure-sa).
    * `Default region name` — `{{ region-id }}`.
    * `Default output format` — `json`.

1. Проверьте, что файл `~/.aws/credentials` содержит правильные значения параметров `key_id` и `secret`:

    ```bash
    cat ~/.aws/credentials
    ```

1. Проверьте, что файл `~/.aws/config` содержит правильные значения параметров `Default region name` и `Default output format`:

    ```bash
    cat ~/.aws/config
    ```

## Создайте архив с изображениями {#create-archive}

1. [Загрузите](../../storage/operations/objects/upload.md) изображения с текстом в бакет.

    {% note tip %}

    Воспользуйтесь [примером изображения](https://storage.yandexcloud.net/vision/penguins_sample.jpg) дорожного знака, предупреждающего о пингвинах.

    {% endnote %}

1. Убедитесь, что изображения были загружены, указав в запросе имя бакета:

    ```bash
    aws --endpoint-url=https://{{ s3-storage-host }} s3 ls s3://<имя_бакета>/
    ```

1. Сохраните изображения из бакета на ВМ, например в директорию `my_pictures`:

     ```bash
    aws --endpoint-url=https://{{ s3-storage-host }} s3 cp s3://<имя_бакета>/ my_pictures --recursive
    ```

1. Запакуйте изображения в архив, например в `my_pictures.tar`:

    ```bash
    tar -cf my_pictures.tar my_pictures/*
    ```

1. Удалите директорию с изображениями:

    ```bash
    rm -rfd my_pictures
    ```

## Подготовьте скрипт для распознавания и загрузки изображений {#prepare-script}

### Настройте окружение {#prepare-environment}

1. Установите пакет `jq`, который понадобится для обработки результатов из {{ vision-name }}:

    ```bash
    sudo yum install jq -y
    ```

1. Установите текстовый редактор `nano`:

    ```bash
    sudo yum install nano -y
    ```

1. Задайте переменные окружения, необходимые для работы скрипта:

    ```bash
    export BUCKETNAME="<имя_бакета>"
    export FOLDERID="<идентификатор_каталога>"
    export IAMTOKEN="<IAM-токен>"
    ```

    Где:
    * `BUCKETNAME` — имя бакета.
    * `FOLDERID` — идентификатор каталога.
    * `IAMTOKEN` — IAM-токен, который вы получили при [настройке сервисного аккаунта](#configure-sa).

### Создайте скрипт {#create-script}

В скрипте выполняются следующие этапы:
1. Создаются необходимые директории.
1. Распаковывается архив с изображениями.
1. Последовательно обрабатываются все изображения:
    1. Изображение кодируется по стандарту Base64.
    1. Формируется тело запроса для конкретного изображения.
    1. Изображение отправляется в POST-запросе в {{ vision-name }} для распознавания.
    1. Полученный результат записывается в файл `output.json` в формате JSON.
    1. Из файла `output.json` выделяется распознанный текст и записывается в текстовый файл.
1. Полученные текстовые файлы запаковываются в архив.
1. Архив с текстовыми файлами загружается в {{ objstorage-name }}.
1. Удаляются служебные файлы.

Для удобства в текст скрипта добавлены комментарии к каждому этапу.

Чтобы реализовать скрипт:
1. Создайте файл, например `vision.sh`, и откройте его в текстовом редакторе `nano`:

    ```bash
    sudo nano vision.sh
    ```

1. Скопируйте в файл `vision.sh` текст скрипта:

    ```bash
    #!/bin/bash

    # Создать необходимые директории
     echo "Creating directories..."

    # Создать директорию для распознанного текста
    mkdir my_pictures_text

    # Распаковать архив с изображениями в созданную директорию
    echo "Extract pictures in my_pictures directory..."
    tar -xf my_pictures.tar

    # Распознать изображения из архива
    FILES=my_pictures/*
    for f in $FILES
    # В цикле для каждого файла из директории произвести следующие действия:
    do
        # Закодировать изображение по стандарту Base64 для отправки в {{ vision-name }}
        CODEIMG=$(base64 -i $f | cat)

        # Создать файл body.json, который будет отправляться в POST-запросе в {{ vision-name }}
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
        # Отправить изображение в {{ vision-name }} для распознавания и записать результат в файл output.json
        echo "Processing file $f in {{ vision-name }}..."
        curl -X POST --silent \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer ${IAMTOKEN}" \
        -d '@body.json' \
        https://vision.{{ api-host }}/vision/v1/batchAnalyze > output.json

        # Получить имя файла с изображением для дальнейшей подстановки
        IMAGE_BASE_NAME=$(basename -- "$f")
        IMAGE_NAME="${IMAGE_BASE_NAME%.*}"

        # Получить из файла output.json текстовые данные и записать их в TXT-файл с таким же именем, как у файла с изображением
        cat output.json | jq -r '.results[].results[].textDetection.pages[].blocks[].lines[].words[].text' | awk -v ORS=" " '{print}' > my_pictures_text/$IMAGE_NAME".txt"
    done

    # Запаковать содержимое директории с текстовыми файлами в архив
    echo "Packing text files to archive..."
    tar -cf my_pictures_text.tar my_pictures_text

    # Отправить архив с текстовыми файлами в бакет
    echo "Sending archive to Object Storage Bucket..."
    aws --endpoint-url=https://{{ s3-storage-host }} s3 cp my_pictures_text.tar s3://$BUCKETNAME/ > /dev/null

    # Удалить служебные файлы
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

## Проверьте корректность распознавания {#check-result}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) {{ yandex-cloud }} выберите каталог, в котором находится бакет с результатами распознавания.
  1. Выберите сервис **{{ objstorage-short-name }}**.
  1. Откройте бакет с результатами распознавания.
  1. Убедитесь, что в бакете появился архив `my_pictures_text.tar`.
  1. Скачайте и распакуйте архив.
  1. Убедитесь что текст в файлах `<имя_изображения>.txt` совпадает с текстом на соответствующих изображениях.

{% endlist %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:
1. [Удалите](../../storage/operations/objects/delete-all.md) все объекты в бакете.
1. [Удалите](../../storage/operations/buckets/delete.md) бакет.
1. [Удалите](../../compute/operations/vm-control/vm-delete.md) ВМ.
1. [Удалите](../../vpc/operations/address-delete.md) статический публичный IP-адрес, если вы его зарезервировали.