# Требования к шифрованию данных и управлению ключами и секретами

## 4. Шифрование данных и управление ключами {#data-encryption-and-key-management}


Yandex Cloud предоставляет встроенные функции шифрования при использовании ряда сервисов. В зоне ответственности клиента находится включение шифрования в этих сервисах, а также самостоятельная реализация шифрования в других компонентах обработки критичных данных. Для шифрования данных и управления ключами шифрования предназначен сервис [Key Management Service](../../kms/index.md) (KMS).

API сервисов Yandex Cloud поддерживают наборы алгоритмов (cipher suits) и версии протокола TLS, отвечающие требованиям стандарта PCI DSS и другим стандартам.

### Шифрование в состоянии покоя (at rest) {#at-rest}

По умолчанию все пользовательские данные в состоянии покоя (at rest) зашифрованы на уровне Yandex Cloud. Шифрование на уровне Yandex Cloud является реализацией одной из лучших практик по защите данных пользователей и выполняется на ключах Yandex Cloud.

Если ваша корпоративная политика информационной безопасности предъявляет требования к длине ключа или частоте [ротации ключей](../../kms/operations/key.md#rotate), вы можете шифровать данные собственными ключами. Для этого можно использовать сервис KMS и его интеграцию с другими сервисами Yandex Cloud, либо реализовать шифрование на уровне Data plane полностью самостоятельно.

Yandex Cloud предоставляет функции шифрования в состоянии покоя (at rest) для следующих сервисов:
* Compute Cloud (шифрование дисков ВМ);
* Object Storage (шифрование бакетов);
* Managed Service for Kubernetes (шифрование секретов).

#### 4.1 Включено шифрование дисков в Yandex Compute Cloud {#compute-encryption}

| ID требования | Критичность |
| --- | --- |
| CRYPT17 | Высокая |

**Поиск зашифрованных дисков ВМ:**

{% list tabs group=instructions %}

- Проверка через CLI {#cli}

  1. Посмотрите доступные вам организации и зафиксируйте необходимый ID:

     ```bash
     yc organization-manager organization list
     ```

  1. Выполните команду для поиска зашифрованных дисков:

      {% cut "**Bash**" %}

      ```bash
      export ORG_ID=<ID_организации>
      CLOUDS=$(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id')

      echo "Encrypted disks:"
      for CLOUD_ID in $CLOUDS
        do
        FOLDERS=$(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id')
        for FOLDER_ID in $FOLDERS
        do
          DISKS=$(yc compute disk list --folder-id $FOLDER_ID --format=json | jq -r '.[] | select(.kms_key.key_id)' | jq -r '.id')

          if [[ -n "$DISKS" ]]; then
            for DISK in $DISKS
            do
              DISKDATA=$(yc compute disk get --id $DISK --folder-id $FOLDER_ID --format=json)
              VM_ID=$(echo $DISKDATA| jq -r '.instance_ids[]')

              VMDATA=""

              if [[ -n "$VM_ID" ]]; then
                VMDATA=$(yc compute instance get --id $VM_ID --folder-id $FOLDER_ID --format=json)
              fi

              echo "------------"
              echo "CLOUD_ID:" $CLOUD_ID
              echo "FOLDER_ID:" $FOLDER_ID
              echo "DISK_ID: "$(echo $DISKDATA | jq -r '.id')
              echo "DISK_NAME: "$(echo $DISKDATA | jq -r '.name')
              echo "DISK_TYPE: "$(echo $DISKDATA | jq -r '.type_id')
              echo "DISK_ZONE: "$(echo $DISKDATA | jq -r '.zone_id')
              echo "DISK_SIZE: "$(echo $DISKDATA | jq -r '.size')
              echo "DISK_KEY: "$(echo $DISKDATA | jq -r '.kms_key')

              if [[ -n "$VMDATA" ]]; then
                echo "VM_ID: "$(echo $VMDATA | jq -r '.id')
                echo "VM_NAME: "$(echo $VMDATA | jq -r '.name')
                echo "VM_STATUS: "$(echo $VMDATA | jq -r '.status')
              fi
              echo "------------"
            done
          fi
        done
      done
      ```

      {% endcut %}

      {% cut "**PowerShell**" %}

      ```powershell
      $ORG_ID = "<ID_организации>"

      $Clouds = yc resource-manager cloud list --organization-id=$ORG_ID --format=json | ConvertFrom-Json | Select @{n="CloudID";e={$_.id}}, created_at, @{n="CloudName";e={$_.name}}, organization_id

      $EncryptedVMs = @()
      $VMDisks = @()

      foreach ($Cloud in $Clouds) {
        $Folders = yc resource-manager folder list --cloud-id $Cloud.CloudID --format=json | ConvertFrom-Json

        foreach($Folder in $Folders) {
          $FolderDiskList = yc compute disk list --folder-id $Folder.id --format=json | ConvertFrom-Json | where{$_.kms_key}

          foreach($Disk in $FolderDiskList) {
            $VMData = $null

            if($Disk.instance_ids) {
              $VMData = yc compute instance get --id $Disk.instance_ids --folder-id $Folder.id --format=json | ConvertFrom-Json
            }

            $EncryptedVMs += $Disk | Select @{n="CloudID";e={$Cloud.CloudID}}, @{n="CloudName";e={$Cloud.CloudName}}, @{n="FolderID";e={$Folder.id}}, @{n="FolderName";e={$Folder.name}}, @{n="DiskID";e={$_.id}}, @{n="DiskName";e={$_.name}}, @{n="DiskType";e={$_.type_id}}, zone_id, @{n="DiskSize";e={$_.size/1GB}}, kms_key, @{n="VMID";e={$VMData.id}}, @{n="VMName";e={$VMData.name}}, @{n="VMStatus";e={$VMData.status}}
          }
        }
      }

      $EncryptedVMs
      ```

      {% endcut %}

{% endlist %}

Проверьте список возвращенных зашифрованных дисков. Если список соответствует вашей модели угроз, то дополнительных действий не требуется. Если какие-либо диски отсутствуют в списке, то выполните следующие действия:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится диск.
  1. В списке сервисов выберите **Compute Cloud**.
  1. На панели слева выберите ![image](../../_assets/console-icons/hard-drive.svg) **Диски** и найдете в списке диск, который требуется зашифровать.

      Если диск присоединен к ВМ и ВМ включена, рекомендуется выключить ее.
  1. [Создайте](../../compute/operations/disk-control/create-snapshot.md) снимок диска.
  1. Создайте из полученного снимка новый зашифрованный диск:

      1. Нажмите кнопку **Создать диск**.
      1. В открывшейся форме:
          1. В поле **Имя** задайте имя диска.
          1. В поле **Зона доступности** укажите нужную [зону доступности](../../overview/concepts/geo-scope.md).
          1. В поле **Наполнение** выберите `Снимок` и выберите созданный ранее снимок.
          1. В поле **Тип** задайте необходимый [тип диска](../../compute/concepts/disk.md#disks-types).
          1. В блоке **Шифрование** включите опцию **Зашифрованный диск** и выберите или создайте [ключ шифрования](../../kms/concepts/key.md) KMS.
          1. Нажмите кнопку **Создать диск**.
  1. После создания зашифрованного диска присоедините его к нужной ВМ вместо незашифрованного.

{% endlist %}

#### 4.2 В Yandex Object Storage включено шифрование данных at rest с ключом KMS {#storage-kms}

Для защиты критичных данных в Yandex Object Storage рекомендуется использовать шифрование бакета на стороне сервера с помощью ключей Yandex Key Management Service (server-side encryption). Такое шифрование защищает от случайной или намеренной публикации содержимого бакета в интернете. Подробнее см. в разделе [Шифрование](../../storage/concepts/encryption.md) документации Object Storage.

| ID требования | Критичность |
| --- | --- |
| CRYPT1 | Средняя |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В консоли управления выберите облако или каталог, в которых необходимо проверить бакеты.
  1. В списке сервисов выберите **Object Storage**.
  1. Перейдите в настройки бакета.
  1. Перейдите на вкладку **Шифрование**.
  1. Убедитесь, что шифрование включено и указан KMS ключ шифрования.
  1. Если шифрование включено, рекомендация выполняется. В противном случае перейдите к п. «Инструкции и решения по выполнению».

- Проверка через CLI {#cli}

  1. [Настройте](../../storage/tools/aws-cli.md) AWS CLI на работу с облаком.
  1. Выполните команду, чтобы проверить, что шифрование включено:

     ```bash
     aws --endpoint-url=https://storage.yandexcloud.net/ \
     s3api get-bucket-encryption \
     --bucket <имя бакета>
     ```

  1. Если шифрование включено, рекомендация выполняется. В противном случае перейдите к п. «Инструкции и решения по выполнению».

{% endlist %}

**Инструкции и решения по выполнению:**

Настройте шифрование бакета согласно [инструкции](../../storage/operations/buckets/encrypt.md).

### Шифрование в состоянии передачи (in transit) {#in-transit}

В большинстве случаев соединение с сервисами Yandex Cloud возможно только с использованием HTTPS. Однако в некоторых сценариях data plane доступ к сервисам может быть осуществлен и по HTTP, без шифрования соединения на прикладном уровне. Во всех таких сценариях у пользователя есть возможность выбрать в настройках сервиса, какой протокол использовать при data plane-операциях: HTTP или HTTPS, а в случае выбора HTTPS указать собственный TLS-сертификат.

{% note info %}

Убедитесь, что используете для работы (или соединения) с API сервисов Yandex Cloud протокол TLS версии 1.2 и выше, так как более ранние версии подвержены уязвимостям.

Например, использование gRPC-интерфейсов Yandex Cloud гарантирует работу по TLS 1.2 и выше, так как протокол HTTP/2, на основе которого работает gRPC, устанавливает TLS 1.2 в качестве минимальной поддерживаемой версии протокола TLS.

Поддержка устаревших протоколов TLS в сервисах Yandex Cloud [будет постепенно прекращена](../security-bulletins/index.md).

{% endnote %}

Yandex Cloud предоставляет возможность использования собственных TLS-сертификатов для следующих сервисов:
* Object Storage;
* Application Load Balancer;
* API Gateway;
* Cloud CDN.

#### 4.3 В Yandex Object Storage включено HTTPS для хостинга статического сайта {#storage-https}

[Object Storage](../../storage/index.md) поддерживает безопасное подключение по протоколу HTTPS. Вы можете загрузить собственный сертификат безопасности, если к сайту в Object Storage требуется доступ по протоколу HTTPS. Также доступна интеграция с сервисом [Certificate Manager](../../certificate-manager/index.md). См. инструкции в документации Object Storage:
* [Настройка HTTPS](../../storage/operations/hosting/certificate.md)
* [Бакет](../../storage/concepts/bucket.md)

При работе с сервисом [Object Storage](../../storage/index.md) необходимо убедиться, что в клиенте отключена поддержка протоколов TLS ниже версии 1.2. При помощи политики (bucket policy) [`aws:securetransport`](../../storage/s3/api-ref/policy/conditions.md) необходимо проверить, что для бакета настроен запрет на работу без протокола TLS.

| ID требования | Критичность |
| --- | --- |
| CRYPT2 | Высокая |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) в списке сервисов выберите **Object Storage** и перейдите в нужный бакет.
  1. На панели слева выберите ![image](../../_assets/console-icons/persons-lock.svg) **Безопасность**.
  1. Выберите вкладку **HTTPS**.
  1. Убедитесь, что доступ по протоколу HTTPS включен и указан TLS-сертификат.
  1. Если доступ по HTTPS включен, рекомендация выполняется. В противном случае перейдите к п. «Инструкции и решения по выполнению».

- Проверка через CLI {#cli}

  Выполните команду, указав имя нужного бакета:

  ```bash
  yc storage bucket get-https <имя_бакета>
  ```

  Если в поле `certificate_id` команда вернула идентификатор сертификата, значит доступ по протоколу HTTPS включен и рекомендация выполняется. В противном случае перейдите к п. «Инструкции и решения по выполнению».

{% endlist %}

**Инструкции и решения по выполнению:**

[Включите](../../storage/operations/hosting/certificate.md) доступ по HTTPS, если бакет используется для хостинга статического сайта.

#### 4.4 В Yandex Application Load Balancer используется HTTPS {#alb-https}

Сервис [Application Load Balancer](../../application-load-balancer/index.md) поддерживает HTTPS-обработчик с загрузкой [сертификата](../../certificate-manager/concepts/imported-certificate.md) из Certificate Manager. См. [описание настройки обработчика](../../application-load-balancer/concepts/application-load-balancer.md#listener) в документации Yandex Application Load Balancer.

| ID требования | Критичность |
| --- | --- |
| CRYPT3 | Высокая |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}
 
  1. В консоли управления выберите облако или каталог, в которых необходимо проверить балансировщики.
  1. В списке сервисов выберите **Application Load Balancer**.
  1. Перейдите в настройки балансировщика.
  1. Убедитесь, что у обработчика указан протокол **HTTPS**.
  1. Если указан HTTPS, рекомендация выполняется. Если нет, перейдите к п. «Инструкции и решения по выполнению».

- Проверка через CLI {#cli}

  1. Посмотрите доступные вам организации и зафиксируйте необходимый ID:

     ```bash
     yc organization-manager organization list
     ```

  1. Выполните команду для вывода списка всех балансировщиков без https:

      {% cut "**Bash**" %}

      ```bash
      export ORG_ID=<ID_организации>
      CLOUDS=$(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id')
      for CLOUD_ID in $CLOUDS
      do
        FOLDERS=$(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id')
        for FOLDER_ID in $FOLDERS
        do
          yc application-load-balancer load-balancer list --folder-id $FOLDER_ID --format=json | jq -r '.[] | select(.listeners[0].tls | not)' | jq -r '.'
        done
      done
      ```

      {% endcut %}

      {% cut "**PowerShell**" %}

      ```powershell
      $ORG_ID = "<ID_организации>"

      $Clouds = yc resource-manager cloud list --organization-id $ORG_ID --format=json | ConvertFrom-Json | Select @{n="CloudID";e={$_.id}}, created_at, @{n="CloudName";e={$_.name}}, organization_id

      $ALBWithoutTLS = @()

      foreach ($Cloud in $Clouds) {
        $Folders = yc resource-manager folder list --cloud-id $Cloud.CloudID --format=json | ConvertFrom-Json

        foreach($Folder in $Folders) {
          $ALBWithoutTLS += yc application-load-balancer load-balancer list --folder-id $Folder.id --format=json | ConvertFrom-Json | where{!$_.listeners.tls}
        }
      }

      $ALBWithoutTLS
      ```

      {% endcut %}

  1. Если выведен пустой список, рекомендация выполняется. В противном случае перейдите к п. «Инструкции и решения по выполнению».

{% endlist %}

**Инструкции и решения по выполнению:**

Включите HTTPS обработчик согласно [инструкции](../../application-load-balancer/tutorials/tls-termination/index.md).

#### 4.5 В Yandex API Gateway используется HTTPS и собственный домен {#api-gateway-https}

[API Gateway](../../api-gateway/index.md) обеспечивает безопасное подключение по протоколу HTTPS. Вы можете привязать собственный домен и загрузить собственный сертификат безопасности для доступа к вашему [API-шлюзу](../../api-gateway/concepts/index.md) по протоколу HTTPS.

| ID требования | Критичность |
| --- | --- |
| CRYPT4 | Средняя |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В консоли управления выберите облако или каталог, в которых необходимо проверить шлюзы.
  1. В списке сервисов выберите **API Gateway → Настройки шлюза → Домены**.
  1. Убедитесь, что домен и сертификат подключены.
  1. Если домен и сертификат активны, рекомендация выполняется. В противном случае перейдите к п. «Инструкции и решения по выполнению».

- Проверка через CLI {#cli}

  1. Посмотрите доступные вам организации и зафиксируйте необходимый ID:

     ```bash
     yc organization-manager organization list
     ```

  1. Выполните команду для вывода списка всех api gateway без подключенных доменов и сертификатов:

     ```bash
     export ORG_ID=<ID организации>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
     do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
     do for APIGW in $(yc serverless api-gateway list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id'); \
     do yc serverless api-gateway get --id $APIGW --format json | jq -r '. | select(.attached_domains[0].certificate_id | not)' | jq -r '.id'
     done;
     done;
     done
     ```

  1. Если выведен пустой список, рекомендация выполняется. В противном случае перейдите к п. «Инструкции и решения по выполнению».

{% endlist %}

**Инструкции и решения по выполнению:**

1. В консоли управления выберите облако или каталог, в которых необходимо подключить домены и сертификаты.
1. В списке сервисов выберите **API Gateway → Настройки шлюза → Домены**.
1. Подключите домены и сертификаты.

#### 4.6 В Yandex Cloud CDN используется HTTPS и собственный SSL-сертификат {#cdn-https}

[Cloud CDN](../../cdn/index.md) поддерживает безопасное подключение по протоколу HTTPS к источникам. Также вы можете загрузить собственный сертификат безопасности для доступа к вашему [CDN-ресурсу](../../cdn/concepts/resource.md) по протоколу HTTPS.

| ID требования | Критичность |
| --- | --- |
| CRYPT5 | Низкая |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В консоли управления выберите облако или каталог, в которых необходимо проверить ресурсы.
  1. В списке сервисов выберите **Cloud CDN**.
  1. Перейдите в настройки ресурса, на вкладку **Дополнительно**.
  1. Убедитесь, что в поле **Протокол для источников** указан протокол **HTTPS**.
  1. Убедитесь, что в поле **Сертификат** указан собственный сертификат либо **Let’s encrypt**.
  1. Если указан HTTPS и собственный сертификат, рекомендация выполняется. В противном случае перейдите к п. «Инструкции и решения по выполнению».

- Проверка через CLI {#cli}

  1. Посмотрите доступные вам организации и зафиксируйте необходимый ID:

     ```bash
     yc organization-manager organization list
     ```

  1. Выполните команду для вывода списка всех ресурсов без подключенных сертификатов и HTTPS до источников:

     ```bash
     export ORG_ID=<ID организации>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
     do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
     do for CDN in $(yc cdn resource list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id'); \
     do yc cdn resource get --id $CDN --format json | jq -r '. | select(.origin_protocol=="HTTPS" and .ssl_certificate.type=="CM" | not)' | jq -r '.id' 
     done;
     done;
     done
     ```

  1. Если выведен пустой список, рекомендация выполняется. В противном случае перейдите к п. «Инструкции и решения по выполнению».

{% endlist %}

**Инструкции и решения по выполнению:**

[Подключите](../../cdn/operations/resources/configure-basics.md) сертификат и HTTPS согласно инструкции.

### Самостоятельное шифрование {#self-encryption}

**При использовании сервисов, которые не имеют встроенных функций шифрования, шифрование критичных данных является ответственностью клиента.**

#### 4.7 Используется шифрование данных на уровне приложения {#self-data-app}

Для шифрования данных на уровне приложения (client-side encryption) перед их отправкой в бакет Yandex Object Storage вы можете использовать следующие подходы:
* Интеграция Object Storage с сервисом Key Management Service для шифрования данных на уровне приложения (client-side encryption). Подробнее смотрите в разделе «Рекомендуемые криптографические библиотеки».
* Шифрование данных на уровне приложения перед отправкой их в Object Storage с помощью сторонних библиотек. При использовании сторонних библиотек и собственных способов управления ключами следует убедиться, что схема работы, используемые алгоритмы и длины ключей соответствуют требованиям регуляторов.

Для шифрования данных на уровне приложения (client-side encryption) рекомендуется использовать следующие библиотеки:
* AWS Encryption SDK и его [интеграцию с KMS](../../kms/tutorials/encrypt/aws-encryption-sdk.md);
* Google Tink и ее [интеграцию с KMS](../../kms/tutorials/encrypt/google-tink.md);
* [SDK Yandex Cloud](../../kms/tutorials/encrypt/sdk.md) вместе с любой другой криптографической библиотекой, совместимой с PCI DSS или другими стандартами, применяемыми в вашей компании.

Сравнение библиотек представлено в разделе [Какой способ шифрования выбрать](../../kms/tutorials/encrypt/index.md) документации KMS.

| ID требования | Критичность |
| --- | --- |
| CRYPT7 | Высокая |

{% list tabs group=instructions %}

- Ручная проверка {#manual}

  Убедитесь, что данные хранятся в зашифрованном виде.

{% endlist %}

#### 4.8 Используется шифрование дисков и снимков виртуальных машин {#managed-vm-kms}

По умолчанию все данные на дисках Yandex Compute Cloud шифруются на уровне базы данных хранилища с помощью системного ключа. Это позволяет защитить данные от компрометации в случае физической кражи дисков из дата-центров Yandex Cloud. 

Рекомендуем также использовать шифрование дисков и [снимков дисков](../../compute/concepts/snapshot.md) с помощью пользовательских [симметричных ключей](../../kms/concepts/key.md) Yandex Key Management Service. Такой подход позволяет:
* Защищаться от потенциальных угроз нарушения изоляции и компрометации данных на уровне виртуальной инфраструктуры.
* Контролировать шифрование и жизненный цикл ключей KMS, а также управлять ими. Подробнее см. в разделе [Управление ключами](../../kms/operations/key.md).
* Повысить уровень контроля доступа к данным на диске за счет необходимости прав на ключ KMS. Подробнее см. в разделе [Настройка прав доступа к симметричному ключу шифрования](../../kms/operations/key-access.md).
* Отслеживать операции шифрования и расшифрования вашим ключом KMS с помощью сервиса Yandex Audit Trails. Подробнее см. в разделе [Аудит использования ключей](../../kms/concepts/index.md#keys-audit).

Вы можете зашифровать диски следующих типов:
* Сетевой SSD-диск (`network-ssd`).
* Сетевой HDD-диск (`network-hdd`).
* Нереплицируемый SSD-диск (`network-ssd-nonreplicated`).
* Сверхбыстрое сетевое хранилище с тремя репликами (SSD) (`network-ssd-io-m3`).

| ID требования | Критичность |
| --- | --- |
| CRYPT8 | Средняя |

{% list tabs group=instructions %}

- Ручная проверка {#manual}

  При [создании диска](../../compute/operations/disk-create/empty.md) убедитесь, что включена опция **Зашифрованный диск**.

{% endlist %}

**Инструкции и решения по выполнению:**

[Зашифруйте](../../compute/operations/disk-control/disk-encrypt.md) диск виртуальной машины Yandex Compute Cloud.

### Управление ключами {#keys}

Для шифрования данных и управления ключами рекомендуется использовать [Key Management Service](../../kms/tutorials/encrypt/sdk.md). KMS предназначен для защиты данных в инфраструктуре Yandex Cloud, а также подходит для шифрования и расшифровки любых ваших данных.

KMS использует схему шифрования AES-GCM. Вы можете выбрать длину ключа: 128, 192 или 256 — и настроить период ротации ключей в зависимости от своих потребностей.

#### 4.9 Ключи Key Management Service хранятся в аппаратном модуле безопасности (HSM) {#keys-hsm}

В продакшн-среде рекомендуется использовать отдельные ключи, все крипто-операции с которыми будут выполняться только внутри специализированного аппаратного устройства. Подробнее см. статью [Аппаратный модуль безопасности (HSM)](../../kms/concepts/hsm.md).

Чтобы использовать HSM, при создании ключа выберите тип алгоритма AES-256 HSM. Все операции с этим ключом будут выполняться внутри HSM, дополнительные действия не требуются.

Рекомендуется использовать HSM для ключей KMS, это увеличивает уровень безопасности.

| ID требования | Критичность |
| --- | --- |
| CRYPT9 | Информационная |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В консоли управления выберите облако или каталог, в которых необходимо проверить ключи.
  1. В списке сервисов выберите **Key Management Service**.
  1. Перейдите на вкладку **Ключи**.
  1. Убедитесь, что в поле **Алгоритм шифрования** указан **AES-256 HSM**.
  1. Если указан AES-256 HSM, рекомендация выполняется. В противном случае перейдите к п. «Инструкции и решения по выполнению».

- Проверка через CLI {#cli}

  1. Посмотрите доступные вам организации и зафиксируйте необходимый ID:

     ```bash
     yc organization-manager organization list
     ```

  1. Выполните команду для вывода списка всех ключей KMS организации и их алгоритмов шифрования:

     ```bash
     export ORG_ID=<ID организации>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
     do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
     do yc kms symmetric-key list --folder-id=$FOLDER_ID --format json | jq -r '.[] | "KEY_ID " + .id + "FOLDER_ID " + .folder_id + "ALGORITM_ID " + .default_algorithm' 
     done;
     done
     ```

  1. Если алгоритм шифрования содержит AES-256 HSM, рекомендация выполняется. В противном случае перейдите к п. «Инструкции и решения по выполнению».

{% endlist %}

**Инструкции и решения по выполнению:**

[Установите](../../kms/operations/symmetric-encryption.md) алгоритм шифрования для ключей KMS «AES-256 HSM».

#### 4.10 Права на управление ключами в KMS выданы контролируемым пользователям {#keys-controlled-users}

Для доступа к сервису KMS необходимо использовать [IAM-токен](../../iam/concepts/authorization/iam-token.md).

В случае автоматизации работы с KMS рекомендуется создать [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) и выполнять команды и скрипты от его имени. Если вы используете виртуальные машины, получите IAM-токен для сервисного аккаунта через механизм [назначения сервисного аккаунта](../../compute/operations/vm-connect/auth-inside-vm.md) виртуальной машине. Другие способы получения IAM-токена для сервисного аккаунта приведены в статье [Получение IAM-токена для сервисного аккаунта](../../iam/operations/iam-token/create-for-sa.md) документации IAM.

Рекомендуется выдавать пользователям и сервисным аккаунтам гранулярные доступы на конкретные ключи сервиса KMS. Подробнее см. статью [Управление доступом в Key Management Service](../../kms/security/index.md) документации KMS.

Подробнее о мерах безопасности при управлении доступом читайте в статье [Аутентификация и управление доступом](authentication.md).

Для того чтобы проверить права доступа к ключу KMS, необходимо проверить, у кого есть права:
* на организацию, облако, каталоги с правами: `admin`, `editor`, `kms.admin`, `kms.editor`, `kms.keys.encrypterDecrypter`;
* на ключи: `kms.keys.encrypterDecrypter` и `kms.editor`.

| ID требования | Критичность |
| --- | --- |
| CRYPT10 | Средняя |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}
 
  1. В консоли управления выберите облако или каталог, в которых необходимо проверить права на ключ.
  1. Перейдите на вкладку **Права доступа**.
  1. Убедитесь, что роли `admin`, `editor`, `kms.admin`, `kms.editor`, `kms.keys.encrypterDecrypter` имеют только контролируемые пользователи.
  1. Проверить права доступа к самим ключам возможно только через CLI.

- Проверка через CLI {#cli}

  1. Посмотрите доступные вам организации и зафиксируйте необходимый ID:

     ```bash
     yc organization-manager organization list
     ```

  1. Выполните команду для поиска учетных записей на уровне организации:

     ```bash
     export ORG_ID=<ID организации>
     yc organization-manager organization list-access-bindings --id=${ORG_ID} --format=json | jq -r '.[] | select(.role_id=="admin" or .role_id=="editor" or .role_id=="kms.admin" or .role_id=="kms.editor" or .role_id=="kms.keys.encrypterDecrypter")'
     ```

  1. Если в списке отсутствуют учетные записи, рекомендация выполнена. В противном случае перейдите к п. «Инструкции и решения по выполнению».

  1. Найдите учетные записи с назначенными ролями на уровне облаков:

     ```bash
     export ORG_ID=<ID организации>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
     do yc resource-manager cloud list-access-bindings --id=$CLOUD_ID --format=json | jq -r '.[] | select(.role_id=="admin" or .role_id=="editor" or .role_id=="kms.admin" or .role_id=="kms.editor" or .role_id=="kms.keys.encrypterDecrypter")'
     done
     ```

  1. Если в списке отсутствуют учетные записи, рекомендация выполнена. В противном случае перейдите к п. «Инструкции и решения по выполнению».

  1. Выполните команду для поиска учетных записей с назначенными примитивными ролями на уровне всех каталогов в ваших облаках:

     ```bash
     export ORG_ID=<ID организации>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
     do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); \
     do yc resource-manager folder list-access-bindings --id=$FOLDER_ID --format=json | jq -r '.[] | select(.role_id=="admin" or .role_id=="editor" or .role_id=="kms.admin" or .role_id=="kms.editor" or .role_id=="kms.keys.encrypterDecrypter")' && echo $FOLDER_ID
     done;
     done
     ```

  1. Если в списке отсутствуют учетные записи, рекомендация выполнена. В противном случае перейдите к п. «Инструкции и решения по выполнению».

  1. Найдите учетные записи с назначенными ролями на уровне ключей:

     ```bash
     export ORG_ID=<ID организации>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
     do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
     do for KEY in $(yc kms symmetric-key list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id'); \
     do yc kms symmetric-key list-access-bindings --id $KEY --format json 
     done;
     done;
     done
     ```

{% endlist %}

**Инструкции и решения по выполнению:**

Проконтролируйте, кому предоставлен доступ к ключам KMS.

#### 4.11 Для KMS ключей включена ротация {#keys-rotation}

Для повышения безопасности инфраструктуры рекомендуется разделить ключи шифрования на две группы:
* Ключи для сервисов, которые обрабатывают критичные данные, но не хранят их. Например, Message Queue, Cloud Functions.
* Ключи для сервисов, которые хранят критичные данные. Например, Managed Services for Databases.

Для первой группы рекомендуется настроить автоматическую ротацию с периодом ротации больше, чем срок обработки данных в этих сервисах. По истечении периода ротации старые версии должны быть удалены. При автоматической ротации и удалении старых версий ключей ранее обработанные данные не могут быть восстановлены и расшифрованы.

Для сервисов хранения данных рекомендуется использовать либо ручные процедуры ротации, либо автоматическую ротацию ключей в зависимости от внутренних процедур обработки критичных данных.

Безопасным значением для AES-GCM является шифрование 4 294 967 296 (= 2<sup>32</sup>) блоков. После достижения этого количества шифрованных блоков необходимо создать новую версию ключа шифрования данных. Подробнее про режим работы AES-GCM см. в [материалах NIST](https://nvlpubs.nist.gov/nistpubs/Legacy/SP/nistspecialpublication800-38d.pdf).

{% note info %}

Удаление какой-либо версии ключа равносильно уничтожению всех данных, зашифрованных с ее помощью. Ключ можно защитить от удаления с помощью установки параметра deletionProtection, однако этот параметр не защищает от удаления отдельных версий.	 

{% endnote %}

Подробнее о ротации ключей см. в разделе [Версия ключа](../../kms/concepts/version.md) документации KMS.

| ID требования | Критичность |
| --- | --- |
| CRYPT11 | Высокая |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В консоли управления выберите облако или каталог, в которых необходимо проверить ключи.
  1. В списке сервисов выберите **Key Management Service**.
  1. Перейдите в настройки ключа.
  1. Найдите параметр **Период ротации**.
  1. Если в параметре указано любое значение, отличное от **Нет ротации**, рекомендация выполняется. В противном случае перейдите к п. «Инструкции и решения по выполнению».

- Проверка через CLI {#cli}

  1. Посмотрите доступные вам организации и зафиксируйте необходимый ID:

     ```bash
     yc organization-manager organization list
     ```

  1. Выполните команду для вывода списка всех ключей KMS организации и их алгоритмов шифрования:

     ```bash
     export ORG_ID=<ID организации>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
     do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
     do yc kms symmetric-key list --folder-id=$FOLDER_ID --format=json | jq -r '.[] | select(.rotation_period | not)' | jq -r '.id' 
     done;
     done
     ```

  1. Если выведен пустой список, то рекомендация выполняется. Если нет, перейдите к п. «Инструкции и решения по выполнению».

{% endlist %}

**Инструкции и решения по выполнению:**

Установите период ротации для ключей.

#### 4.12 Для ключей KMS включена защита от удаления {#keys-deletion-protection}

Удаление KMS ключа приводит к гарантированному удалению данных, поэтому необходимо защищать ключи от непреднамеренного удаления. В KMS существует соответствующая функция.

| ID требования | Критичность |
| --- | --- |
| CRYPT12 | Высокая |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В консоли управления выберите облако или каталог, в которых необходимо проверить ключи.
  1. В списке сервисов выберите **Key Management Service**.
  1. Перейдите в настройки ключа.
  1. Найдите параметр **Защита от удаления**.
  1. Если в параметре указано **Да**, рекомендация выполняется. В противном случае перейдите к п. «Инструкции и решения по выполнению».

- Проверка через CLI {#cli}

  1. Посмотрите доступные вам организации и зафиксируйте необходимый ID:

     ```bash
     yc organization-manager organization list
     ```

  1. Выполните команду для вывода списка всех ключей KMS без защиты от удаления:

     ```bash
     export ORG_ID=<ID организации>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
     do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
     do yc kms symmetric-key list --folder-id=$FOLDER_ID --format=json | jq -r '.[] | select(.deletion_protection | not)' | jq -r '.id' 
     done;
     done
     ```

  1. Если выведен пустой список, рекомендация выполняется. В противном случае перейдите к п. «Инструкции и решения по выполнению».

{% endlist %}

**Инструкции и решения по выполнению:**

Установите защиту от удаления.

### Управление секретами {#secrets}

Критичные данные и секреты для доступа к данным (токены аутентификации, API-ключи, ключи шифрования и т. п.) не следует использовать в открытом виде в коде, в названиях и описаниях объектов облака, в метаданных виртуальных машин и т. д. Вместо этого используйте сервисы для хранения секретов, такие как Lockbox или HashiCorp Vault.

#### 4.13 В организации используется Yandex Lockbox для безопасного хранения секретов {#secrets-lockbox}

Критичные данные и секреты для доступа к данным (токены аутентификации, API-ключи, ключи шифрования и т. п.) не следует использовать в открытом виде в коде, в названиях и описаниях объектов облака, в метаданных виртуальных машин и т. д. Вместо этого используйте сервисы для хранения секретов, такие как Lockbox.

Сервис Lockbox обеспечивает безопасное хранение секретов только в зашифрованном виде. Шифрование выполняется с помощью KMS. Для разграничения доступа к секретам используйте сервисные роли.

Инструкции по работе с сервисом см. в [документации](../../lockbox/index.md) Lockbox.

{% note info %}

При работе в Terraform рекомендуем [заполнять](../../terraform/resources/lockbox_secret_version.md) содержимое секрета скриптом. В таком случае содержимое не останется в файле `.tfstate`.

{% endnote %}

| ID требования | Критичность |
| --- | --- |
| CRYPT13 | Высокая |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В консоли управления выберите облако или каталог, в которых необходимо проверить секреты.
  1. В списке сервисов выберите **Lockbox**.
  1. Убедитесь, что используется как минимум один секрет Lockbox.
  1. Если используется Lockbox, рекомендация выполняется. В противном случае перейдите к п. «Инструкции и решения по выполнению».

- Проверка через CLI {#cli}

  1. Посмотрите доступные вам организации и зафиксируйте необходимый ID:

     ```bash
     yc organization-manager organization list
     ```

  1. Выполните команду для поиска как минимум одного секрета Lockbox:
 
     ```bash
     export ORG_ID=<ID организации>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
     do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
     do yc lockbox secret list --folder-id=$FOLDER_ID --format=json 
     done;
     done
     ```

  1. Если выведен пустой список, рекомендация выполняется. Если нет, перейдите к п. «Инструкции и решения по выполнению».

{% endlist %}

**Инструкции и решения по выполнению:**

Храните секреты в Lockbox.

#### 4.14 Для Serverless Containers и Cloud Functions используются секреты Lockbox {#secrets-serverless-functions}

При работе с Serverless Containers или Cloud Functions часто возникает необходимость использовать секрет (токен, пароль и т.д.).

Если указать секретную информацию в переменных окружения, она может быть доступна для просмотра любому пользователю облака с правами на просмотр и использование функции и влечет за собой риски ИБ.

Рекомендуется использовать для этих целей интеграцию Serverless с Lockbox. Вы можете указать конкретный секрет из сервиса Yandex Lockbox и сервисный аккаунт с правами на данный секрет для использования его в функции или контейнере. 

Рекомендуется убедиться, что секреты используются именно таким образом. 

| ID требования | Критичность |
| --- | --- |
| CRYPT14 | Средняя |

{% list tabs group=instructions %}

- Проверка в консоли управления {#console}

  1. В консоли управления выберите облако или каталог, в которых необходимо проверить функции.
  1. В списке сервисов выберите **Cloud Functions**.
  1. Перейдите в настройки функции, на вкладку **Редактор**.
  1. Найдите параметр **Секреты Lockbox**.
  1. Если в параметрах каждого объекта указано **Секреты Lockbox** или отсутствуют env с секретными данными, рекомендация выполняется. В противном случае перейдите к п. «Инструкции и решения по выполнению».

- Проверка через CLI {#cli}

  1. Выполните команду для поиска всех облачных функций, которые не используют секреты Lockbox и убедитесь, что в данных функциях не используются секретные данные в env:

     ```bash
     export ORG_ID=<ID организации>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
     do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
     do for VER in $(yc serverless function version list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id'); \
     do yc serverless function version get $VER --format=json | jq -r '. | select(.secrets | not)' | jq -r '.id' 
     done;
     done;
     done
     ```

  1. Если выведен пустой список, рекомендация выполняется. В противном случае перейдите к п. «Инструкции и решения по выполнению».

{% endlist %}

**Инструкции и решения по выполнению:**

Удалите секретные данные из env и воспользуйтесь функционалом интеграции с Lockbox:
* [Передать секреты Yandex Lockbox в контейнер](../../serverless-containers/operations/lockbox-secret-transmit.md).
* [Передать секреты Yandex Lockbox в функцию](../../functions/operations/function/lockbox-secret-transmit.md).

#### 4.15 При работе Container Optimized Image используется шифрование секретов {#secrets-coi}

KMS предоставляет возможность шифрования секретов, используемых в конфигурации Terraform, в частности, для передачи секретов на виртуальную машину в зашифрованном виде. См. инструкцию в разделе [Шифрование секретов в HashiCorp Terraform](../../kms/tutorials/terraform-secret.md) документации KMS. Передача секретов через переменные окружения в открытом виде небезопасна, поскольку они отображаются в свойствах ВМ.

| ID требования | Критичность |
| --- | --- |
| CRYPT15 | Высокая |

**Инструкции и решения по выполнению:**

[Шифрование секретов в Terraform для передачи на ВМ с Container Optimized Image](https://github.com/yandex-cloud-examples/yc-encrypt-coi-secrets).

Другие рекомендации по безопасному использованию Terraform см. в статье [Безопасная конфигурация: Terraform](virtualenv-safe-config.md#tf-using).

#### 4.16 Администратор облака имеет инструкцию по действиям в случае компрометации секретов его облака {#secrets-scanning}

В Yandex Cloud по умолчанию для всех включен [Secret Scanning Service](../operations/search-secrets.md).
Источники для обнаружения облачных структурированных секретов в открытом доступе:

* [Партнерская программа поиска секретов Yandex Cloud](../operations/search-secrets.md#leak-detection-affiliate-program).
* [GitHub Secret scanning partner program](../operations/search-secrets.md#github-secret-scanning).
* [GitLab Secret Detection](../operations/search-secrets.md#gitlab-secret-detection).
* [Поисковый индекс Яндекс](../operations/search-secrets.md#secret-is-leaked).
* [Helm-чарты в Yandex Cloud Marketplace](../operations/search-secrets.md#helm-charts).

Список облачных секретов для обнаружения:

* [API-ключи](../../iam/concepts/authorization/api-key.md).
* [IAM Cookies](../../iam/concepts/authorization/cookie.md).
* [IAM-токены](../../iam/concepts/authorization/iam-token.md).
* [Статические ключи доступа](../../iam/concepts/authorization/access-key.md).
* [OAuth-токен](../../iam/concepts/authorization/oauth-token.md).
* [Серверные ключи SmartCaptcha](../../smartcaptcha/concepts/keys.md).
* [Refresh-токены](../../iam/concepts/authorization/refresh-token.md).
* [Секреты OIDC-приложений](../../organization/concepts/applications.md#oidc-secret).

Сервис автоматически уведомляет клиента о найденном секрете, который относится к его инфраструктуре:

* по электронной почте;
* с помощью [событий](../../audit-trails/concepts/events.md) Yandex Audit Trails.

| ID требования | Критичность |
| --- | --- |
| CRYPT16 | Информационная |

**Инструкции и решения по выполнению:**

Убедитесь, что:

* [Контактные данные ответственного за организацию актуальны](authentication.md#org-contacts).
* [Включен сервис Yandex Audit Trails на уровне организации](audit-logs.md#audit-trails).
* Администратор ознакомлен с [инструкцией](../operations/search-secrets.md#secret-is-leaked) по действиям при компрометации секретов.