# Монтирование бакетов Yandex Object Storage к файловой системе хостов Yandex Data Processing

# Монтирование бакетов Yandex Object Storage к файловой системе хостов Yandex Data Processing


В сервисе Yandex Data Processing вы можете использовать для настройки хостов [скрипты инициализации](../concepts/init-action.md) (initialization actions).

С их помощью можно автоматизировать установку и настройку программы [GeeseFS](../../storage/tools/geesefs.md), позволяющей хостам кластера Yandex Data Processing монтировать бакеты Yandex Object Storage через [FUSE](https://ru.wikipedia.org/wiki/FUSE_(модуль_ядра)).

Чтобы настроить GeeseFS:

1. [Подготовьте инфраструктуру](#infra).
1. [Подготовьте скрипт инициализации](#prepare-init-scripts).
1. [Создайте кластер, использующий скрипт инициализации](#create-cluster).
1. [Проверьте доступность бакета](#check-availability).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Перед началом работы {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

* Кластер Yandex Data Processing: использование вычислительных ресурсов с наценкой за сервис Yandex Data Processing, использование сетевых дисков, получение и хранение логов, объем исходящего трафика ([тарифы Yandex Data Processing](../../data-proc/pricing.md)).
* Публичные IP-адреса, если для хостов кластера включен публичный доступ ([тарифы Yandex Virtual Private Cloud](../../vpc/pricing.md)).
* NAT-шлюз: почасовое использование шлюза и исходящий через него трафик ([тарифы Virtual Private Cloud](../../vpc/pricing.md)).
* Бакет Object Storage: использование хранилища и выполнение операций с данными ([тарифы Object Storage](../../storage/pricing.md)).


## Подготовьте инфраструктуру {#infra}

{% list tabs group=instructions %}

- Вручную {#manual}

  1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) с ролями `dataproc.agent` и `dataproc.provisioner`.

  1. [Создайте бакет](../../storage/operations/buckets/create.md) Object Storage.

  1. Предоставьте сервисному аккаунту доступ на чтение из бакета. Для этого воспользуйтесь одним из способов:

      * [Настройте ACL бакета](../../storage/operations/buckets/edit-acl.md) и выдайте сервисному аккаунту разрешение `READ`.

          Сервисный аккаунт получит доступ на чтение только к указанному бакету.

      * [Назначьте сервисному аккаунту роль](../../iam/operations/sa/assign-role-for-sa.md) `storage.viewer`.

          Сервисный аккаунт получит доступ на чтение ко всем бакетам в каталоге.

  1. Создайте [NAT-шлюз](../../vpc/operations/create-nat-gateway.md) для подсети, в которой будет создан кластер Yandex Data Processing.

- Terraform {#tf}

  1. Если у вас еще нет Terraform, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  1. [Получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
  1. [Настройте и инициализируйте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
  1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

  1. Скачайте в ту же рабочую директорию файл конфигурации [data-processing-init-actions-geesefs.tf](https://github.com/yandex-cloud-examples/yc-data-processing-init-actions/blob/main/data-processing-init-actions-geesefs.tf).

      В этом файле описаны:

      * [сеть](../../vpc/concepts/network.md#network);
      * [подсеть](../../vpc/concepts/network.md#subnet);
      * [таблица маршрутизации](../../vpc/concepts/routing.md#rt-vpc);
      * [NAT-шлюз](../../vpc/concepts/gateways.md);
      * [группа безопасности](../../vpc/concepts/security-groups.md) и правила, необходимые для подключения к кластеру Yandex Data Processing;
      * [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) с ролями, которые требуются для работы с бакетом Object Storage и кластером Yandex Data Processing;
      * [статический ключ](../../iam/concepts/authorization/access-key.md) сервисного аккаунта для управления бакетом Object Storage;
      * [бакет Object Storage](../../storage/concepts/bucket.md);
      * [кластер Yandex Data Processing](../concepts/index.md).

  1. Укажите в файле `data-processing-init-actions-geesefs.tf` значения параметров:

      * `dp_network_name` — имя сети для кластера Yandex Data Processing;
      * `dp_subnet_name` — имя подсети для кластера Yandex Data Processing;
      * `dp_sg_name` — имя группы безопасности для кластера Yandex Data Processing;
      * `dp_sa_folder_id` — идентификатор каталога, в котором будет создана инфраструктура и кластер Yandex Data Processing;
      * `dp_sa_name` — имя сервисного аккаунта для кластера Yandex Data Processing и бакета Object Storage;
      * `dp_bucket_name` — имя бакета Object Storage;
      * `dataproc_name` — имя кластера Yandex Data Processing;
      * `ssh-path` — путь к файлу публичного SSH-ключа для кластера Yandex Data Processing.

  1. Проверьте корректность файлов конфигурации Terraform с помощью команды:

      ```bash
      terraform validate
      ```

      Если в файлах конфигурации есть ошибки, Terraform на них укажет.

  1. Создайте необходимую инфраструктуру:

      1. Выполните команду для просмотра планируемых изменений:
      
         ```bash
         terraform plan
         ```
      
         Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
      
      1. Если вас устраивают планируемые изменения, внесите их:
         1. Выполните команду:
      
            ```bash
            terraform apply
            ```
      
         1. Подтвердите изменение ресурсов.
         1. Дождитесь завершения операции.

      В указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления](https://console.yandex.cloud).

{% endlist %}

## Подготовьте скрипт инициализации {#prepare-init-scripts}

1. Создайте файл скрипта инициализации `geesefs_mount.sh`, принимающий два позиционных аргумента — имя бакета Object Storage и директорию в файловой системе хоста, куда он должен быть смонтирован.

    ```bash
    #!/bin/bash

    set -e

    BUCKET=$1
    MOUNT_POINT=$2

    # Загрузка GeeseFS
    wget https://github.com/yandex-cloud/geesefs/releases/latest/download/geesefs-linux-amd64 -O /opt/geesefs
    chmod a+rwx /opt/geesefs
    mkdir -p "${MOUNT_POINT}"

    # Подготовка скрипта, выполняющегося при каждой загрузке
    BOOT_SCRIPT="/var/lib/cloud/scripts/per-boot/80-geesefs-mount.sh"
    echo "#!/bin/bash" >> ${BOOT_SCRIPT}
    echo "/opt/geesefs -o allow_other --iam ${BUCKET} ${MOUNT_POINT}" >> ${BOOT_SCRIPT}
    chmod 755 ${BOOT_SCRIPT}

    # Запуск скрипта
    ${BOOT_SCRIPT}
    ```

1. [Загрузите](../../storage/operations/objects/upload.md) файл `geesefs_mount.sh` в созданный ранее бакет Object Storage.

## Создайте кластер, использующий скрипт инициализации {#create-cluster}

{% list tabs group=instructions %}

- Вручную {#manual}

  [Создайте кластер Yandex Data Processing](../operations/cluster-create.md) со следующими параметрами:

  * В поле **Версия** выберите версию `2.0`.
  * В поле **Сервисный аккаунт** выберите сервисный аккаунт, [созданный ранее](#before-you-begin).
  * В поле **Пользовательские скрипты** нажмите кнопку **Добавить** и задайте параметры скрипта:

      * В поле **URI** укажите путь к файлу скрипта в бакете, например:

          ```http
          s3a://<имя_бакета>/geesefs_mount.sh
          ```

      * В поле **Аргументы** укажите имя [созданного ранее](#before-you-begin) бакета и точку монтирования `/mnt/test`. Аргументы указываются на отдельных строках:

          ```text
          <имя_бакета>
          /mnt/test
          ```

  * В поле **Имя бакета** выберите бакет, [созданный ранее](#before-you-begin).

  * В меню **Подкластеры** включите в настройках опцию **Публичный доступ**.

      {% note info %}
      
      Публичный доступ к хостам кластера нужен, если вы планируете подключаться к кластеру через интернет. Этот вариант подключения более простой, и его рекомендуется использовать для прохождения руководства. К хостам без публичного доступа тоже можно подключиться, но только с виртуальных машин Yandex Cloud, расположенных в той же облачной сети, что и кластер.
      
      {% endnote %}

- Terraform {#tf}

  1. В файле `data-processing-init-actions-geesefs.tf` укажите значение переменной `create_cluster` = `1`.

  1. Проверьте корректность файлов конфигурации Terraform с помощью команды:

      ```bash
      terraform validate
      ```

      Если в файлах конфигурации есть ошибки, Terraform на них укажет.

  1. Создайте необходимую инфраструктуру:

      1. Выполните команду для просмотра планируемых изменений:
      
         ```bash
         terraform plan
         ```
      
         Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
      
      1. Если вас устраивают планируемые изменения, внесите их:
         1. Выполните команду:
      
            ```bash
            terraform apply
            ```
      
         1. Подтвердите изменение ресурсов.
         1. Дождитесь завершения операции.

      В указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления](https://console.yandex.cloud).

{% endlist %}

## Проверьте доступность бакета {#check-availability}

1. После того, как кластер перейдет в статус **Alive**, [подключитесь](../operations/connect-ssh.md) по [SSH](../../glossary/ssh-keygen.md) от имени пользователя `ubuntu` к любому из его хостов.

1. Чтобы убедиться в успешном монтировании бакета, выполните команду:

    ```bash
    ls /mnt/test
    ```

    В результате будет выведен список объектов, хранящихся в корневом каталоге бакета. В данном случае — имя файла `geesefs_mount.sh`.

## Удалите созданные ресурсы {#clear-out}

{% note tip %}

Перед удалением инфраструктуры удалите вручную все объекты из бакета.

{% endnote %}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

{% list tabs group=instructions %}

- Вручную {#manual}

  1. [Удалите кластер Yandex Data Processing](../operations/cluster-delete.md).
  1. Если для доступа к хостам кластера использовались статические публичные IP-адреса, освободите и [удалите их](../../vpc/operations/address-delete.md).
  1. [Удалите бакет Object Storage](../../storage/operations/buckets/delete.md).
  1. [Удалите сервисный аккаунт](../../iam/operations/sa/delete.md).

- Terraform {#tf}

  1. В терминале перейдите в рабочую директорию с конфигурационным файлом `data-processing-init-actions-geesefs.tf`.
  1. Удалите ресурсы с помощью команды:

      ```bash
      terraform destroy
      ```

  1. Введите слово `yes` и нажмите **Enter**.

      Все ресурсы, которые были описаны в конфигурационном файле `data-processing-init-actions-geesefs.tf`, будут удалены.

{% endlist %}