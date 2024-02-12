# Распознавание архива изображений в {{ vision-full-name }}

С помощью сервисов [{{ vision-name }}](../../vision/) и [{{ objstorage-full-name }}](../../storage/) можно организовать распознавание текста на изображениях и хранение архива исходных изображений и результатов распознавания.

Чтобы настроить инфраструктуру для распознавания текста с помощью {{ vision-name }} и автоматической выгрузки результатов в {{ objstorage-name }}:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте бакет](#create-bucket).
1. [Создайте виртуальную машину](#create-vm).
1. [Настройте ВМ](#configure-vm).
1. [Создайте архив с изображениями](#create-archive).
1. [Подготовьте скрипт для распознавания и загрузки изображений](#prepare-script).
1. [Проверьте корректность распознавания](#check-result).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры для распознавания изображений и хранения данных входят:
* Плата за вычислительные ресурсы и [диски](../../compute/concepts/disk.md) [ВМ](../../compute/concepts/vm.md) (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md)).
* Плата за хранение данных в [бакете](../../storage/concepts/bucket.md) и [операции](../../storage/operations/index.md) с ними (см. [тарифы {{ objstorage-name }}](../../storage/pricing.md)).
* Плата за использование динамического или статического [публичного IP-адреса](../../vpc/concepts/address.md#public-addresses) (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).
* Плата за использование {{ vision-name }} (см. [тарифы для {{ vision-name }}](../../vision/pricing.md)).


## Создайте бакет {#create-bucket}

Чтобы создать бакет {{ objstorage-name }} для хранения исходных изображений и результатов распознавания:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будете выполнять операции.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.storage.buckets.button_empty-create }}**.
  1. Введите имя бакета в соответствии с [правилами именования](../../storage/concepts/bucket.md#naming).
  1. В поле **{{ ui-key.yacloud.storage.bucket.settings.field_access-read }}** выберите **{{ ui-key.yacloud.storage.bucket.settings.access_value_private }}**.
  1. В поле **{{ ui-key.yacloud.storage.bucket.settings.field_class }}** выберите **{{ ui-key.yacloud.storage.bucket.settings.class_value_cold }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.

{% endlist %}

## Создайте ВМ {#create-vm}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будете выполнять операции.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. Введите имя ВМ. Требования к имени:

     {% include [name-format](../../_includes/name-format.md) %}

  1. Выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой будет находиться ВМ.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** перейдите на вкладку **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** и выберите публичный образ [CentOS 7](/marketplace/products/yc/centos-7).
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_storages }}** выберите параметры:
     * **{{ ui-key.yacloud.compute.disk-form.field_type }}** — SSD.
     * **{{ ui-key.yacloud.compute.disk-form.field_size }}** — 19 ГБ.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}** выберите параметры:
     * **{{ ui-key.yacloud.component.compute.resources.field_platform }}** — Intel Cascade Lake.
     * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}** — 20%.
     * **{{ ui-key.yacloud.component.compute.resources.field_cores }}** — 2.
     * **{{ ui-key.yacloud.component.compute.resources.field_memory }}** — 2 ГБ.
  1. В блоке **С{{ ui-key.yacloud.compute.instances.create.section_network }}** выберите [сеть](../../vpc/concepts/network.md#network) и [подсеть](../../vpc/concepts/network.md#subnet), к которым нужно подключить ВМ. Если сети нет, [создайте ее](../../vpc/operations/network-create.md).
  1. В поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}** оставьте значение **{{ ui-key.yacloud.component.compute.network-select.switch_auto }}**, чтобы назначить ВМ случайный публичный IP-адрес из пула {{ yandex-cloud }}, или выберите статический адрес из списка, если вы [зарезервировали](../../vpc/operations/get-static-ip.md) его заранее.
  1. Укажите данные для доступа к ВМ:
     * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя.
     * В поле **{{ ui-key.yacloud.compute.instances.create.field_key }}** вставьте содержимое файла открытого ключа.

       Пару ключей для подключения по [SSH](../../glossary/ssh-keygen.md) необходимо создать самостоятельно, см. [{#T}](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.
  1. Дождитесь перехода ВМ в статус `Running` и сохраните ее публичный IP-адрес, он понадобится для SSH-подключения.

{% endlist %}

## Настройте ВМ {#configure-vm}

### Настройте {{ yandex-cloud }} CLI {#configure-yc-cli}

1. [Подключитесь](../../compute/operations/vm-connect/ssh.md#vm-connect) к ВМ по протоколу SSH.
1. [Установите](../../cli/quickstart.md#install) на ВМ {{ yandex-cloud }} CLI и [создайте](../../cli/quickstart.md#initialize) профиль.
1. Убедитесь, что {{ yandex-cloud }} CLI функционирует корректно:

   {% list tabs group=instructions %}

   - CLI {#cli}

     На ВМ выполните команду:

     ```bash
     yc config list
     ```

     Результат:

     ```text
     token: AQ...gs
     cloud-id: b1gdtdqb1900********
     folder-id: b1gveg9vude9********
     ```

     Сохраните идентификатор каталога — параметр `folder-id`, он понадобится для настройки [сервисного аккаунта](../../iam/concepts/users/service-accounts.md).

   {% endlist %}

### Настройте сервисный аккаунт {#configure-sa}

{% list tabs group=instructions %}

- CLI {#cli}

  1. Создайте сервисный аккаунт:

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
     id: aje6aoc8hccu********
     folder_id: b1gv87ssvu49********
     created_at: "2022-10-12T14:04:43.198559512Z"
     name: vision-sa
     description: this is vision service account
     ```

     Сохраните идентификатор сервисного аккаунта — параметр `id`, он понадобится для дальнейшей настройки.
     
  1. Назначьте сервисному аккаунту [роль](../../iam/concepts/access-control/roles.md) `editor`:

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
       id: ajen8d7fur27********
       service_account_id: aje6aoc8hccu********
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
     id: aje3qc9pagb9********
     service_account_id: aje6aoc8hccu********
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

  1. Получите [{{ iam-full-name }}-токен](../../iam/concepts/authorization/iam-token.md) для сервисного аккаунта:

     ```bash
     yc iam create-token
     ```

     Сохраните {{ iam-name }}-токен, он понадобится для отправки изображений в {{ vision-name }}.

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

   Воспользуйтесь [примером изображения](https://{{ s3-storage-host }}/vision/penguins_sample.jpg) дорожного знака, предупреждающего о пингвинах.

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

1. Установите репозиторий дополнительных пакетов `epel`:

   ```bash
   sudo yum install epel-release -y
   ```

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
   * `IAMTOKEN` — {{ iam-name }}-токен, который вы получили при [настройке сервисного аккаунта](#configure-sa).

### Создайте скрипт {#create-script}

{% list tabs group=programming_language %}

- Bash {#bash}

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

   1. Скопируйте в файл `vision.sh` текст скрипта на Bash:

      ```bash
      #!/bin/bash

      # Создать необходимые директории.
      echo "Creating directories..."

      # Создать директорию для распознанного текста.
      mkdir my_pictures_text

      # Распаковать архив с изображениями в созданную директорию.
      echo "Extract pictures in my_pictures directory..."
      tar -xf my_pictures.tar

      # Распознать изображения из архива.
      FILES=my_pictures/*
      for f in $FILES
      # В цикле для каждого файла из директории произвести следующие действия:
      do
         # Закодировать изображение по стандарту Base64 для отправки в {{ vision-name }}.
         CODEIMG=$(base64 -i $f | cat)

         # Создать файл body.json, который будет отправляться в POST-запросе в {{ vision-name }}.
         cat <<EOF > body.json
      {
      "mimeType": "JPEG",
      "languageCodes": ["*"],
      "model": "page",
      "content": "$CODEIMG"
      }
      EOF
      # Отправить изображение в Vision для распознавания и записать результат в файл output.json.
      echo "Processing file $f in Vision..."
      curl -X POST \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer ${IAMTOKEN}" \
        -H "x-data-logging-enabled: true" \
        -H "x-folder-id: ${FOLDERID}" \
        -d '@body.json' \
        https://ocr.api.cloud.yandex.net/ocr/v1/recognizeText \
        -o output.json

      # Получить имя файла с изображением для дальнейшей подстановки.
      IMAGE_BASE_NAME=$(basename -- "$f")
      IMAGE_NAME="${IMAGE_BASE_NAME%.*}"

      # Получить из файла output.json текстовые данные и записать их в TXT-файл с таким же именем, как у файла с изображением.
      cat output.json | jq -r '.result[].blocks[].lines[].text' | awk -v ORS=" " '{print}' > my_pictures_text/$IMAGE_NAME".txt"
      done

      # Запаковать содержимое директории с текстовыми файлами в архив.
      echo "Packing text files to archive..."
      tar -cf my_pictures_text.tar my_pictures_text

      # Отправить архив с текстовыми файлами в бакет.
      echo "Sending archive to Object Storage Bucket..."
      aws --endpoint-url=https://{{ s3-storage-host }} s3 cp my_pictures_text.tar s3://$BUCKETNAME/ > /dev/null

      # Удалить служебные файлы.
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

{% endlist %}

## Проверьте корректность распознавания {#check-result}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) {{ yandex-cloud }} выберите каталог, в котором находится бакет с результатами распознавания.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
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
