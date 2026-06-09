# Создание виртуальной машины с GPU


В этом разделе приведена инструкция для создания [ВМ](../../concepts/vm.md) с GPU. Подробнее с конфигурациями ВМ вы можете ознакомиться в разделе [Графические ускорители GPU](../../concepts/gpus.md).

По умолчанию в [облаке](../../../resource-manager/concepts/resources-hierarchy.md#cloud) установлена нулевая [квота](../../concepts/limits.md#quotas) на создание ВМ с GPU. Чтобы изменить [квоту](https://console.yandex.cloud/cloud?section=quotas), обратитесь в [техническую поддержку](https://center.yandex.cloud/support).

Виртуальные машины на платформах Intel Broadwell with NVIDIA® Tesla® V100, Intel Cascade Lake with NVIDIA® Tesla® V100 и AMD EPYC™ with NVIDIA® Ampere® A100 можно создать в зонах доступности `ru-central1-a` и `ru-central1-b`.

{% note info %}

Чтобы создавать, изменять и редактировать [ВМ](../../concepts/vm.md), необходима _минимальная_ [роль](../../security/index.md#compute-editor) `compute.editor` на [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder). Для создания ВМ с лицензируемым образом дополнительно потребуется [роль](../../../marketplace/security/index.md#license-manager-viewer) `license-manager.viewer`.

Для создания ВМ с [публичным IP-адресом](../../../vpc/concepts/address.md#public-addresses) дополнительно потребуется [роль](../../../vpc/security/index.md#vpc-public-admin) `vpc.publicAdmin`.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  
  <iframe width="640" height="360" src="https://runtime.strm.yandex.ru/player/video/vplvyireo4fkd4k4i4au?autoplay=0&mute=0" allow="autoplay; fullscreen; picture-in-picture; encrypted-media" frameborder="0" scrolling="no"></iframe>

  [Смотреть видео на YouTube](https://www.youtube.com/watch?v=1gFAfVA4XRM&list=PL1x4ET76A10bW1KU3twrdm7hH376z8G5R&index=2&pp=iAQB).



  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создана ВМ.
  1. Перейдите в сервис **Compute Cloud**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/server.svg) **Виртуальные машины**.
  1. Нажмите кнопку **Создать виртуальную машину**.
  1. В блоке **Образ загрузочного диска** на вкладке **Marketplace** выберите один из [GPU-ориентированных образов](https://yandex.cloud/ru/marketplace?search=gpu) и версию операционной системы.
  
      Для виртуальных машин с GPU доступны специальные образы операционных систем с драйверами NVIDIA:
      
      Intel Broadwell with NVIDIA® Tesla® V100 и Intel Cascade Lake with NVIDIA® Tesla® V100
      
      : * [Ubuntu 18.04 LTS GPU](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-18-04-lts-gpu) (`ubuntu-1804-lts-gpu`)
        * [Ubuntu 20.04 LTS GPU](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-20-04-lts-gpu) (`ubuntu-2004-lts-gpu`)
      
      Intel Ice Lake with NVIDIA® Tesla® T4
      
      : * [Ubuntu 20.04 LTS GPU](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-20-04-lts-gpu) (`ubuntu-2004-lts-gpu`)
      
      Intel Ice Lake with T4i
      
      : * [Ubuntu 22.04 LTS GPU CUDA 12.2](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-2204-lts-cuda-12-2) (`ubuntu-2204-lts-cuda-12-2`)
      
      AMD EPYC™ with NVIDIA® Ampere® A100
      
      : * [Ubuntu 22.04 LTS GPU CUDA 12.2](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-2204-lts-cuda-12-2) (`ubuntu-2204-lts-cuda-12-2`)
      
        Для поддержки кластерного режима:
      : * [Ubuntu 20.04 LTS GPU Cluster](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-2004-lts-gpu-cluster)(`ubuntu-2004-lts-gpu-cluster`)
      
      Gen2
      
      : * [Ubuntu 20.04 LTS Secure Boot CUDA 12.2](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-2004-lts-secureboot-cuda-12-2) (`ubuntu-2004-lts-secureboot-cuda-12-2`)
      
      Мы рекомендуем использовать стандартный образ от Yandex Cloud. Вы также можете [установить драйверы](../vm-operate/install-nvidia-drivers.md) на другой стандартный образ самостоятельно или [создать собственный образ](../image-create/custom-image.md) с предустановленными драйверами.
      
      {% note info %}
      
      Compute Cloud проверяет работоспособность и рекомендует устанавливать только [LTS версии драйверов](https://docs.nvidia.com/datacenter/tesla/drivers/releases.json).
      
      При установке драйверов для платформы `gpu-standard-v3` (AMD EPYC™ with NVIDIA® Ampere® A100) указывайте совместимую версию драйвера — `535`.
      
      Мы рекомендуем использовать именно эту версию драйвера — обновление до других версий не поддерживается и может привести к нестабильной работе GPU.
      
      {% endnote %}
  
  1. В блоке **Расположение** выберите [зону доступности](../../../overview/concepts/geo-scope.md), в которой будет находиться ВМ.
  1. (Опционально) В блоке **Диски и файловые хранилища** настройте загрузочный [диск](../../concepts/disk.md):
  
      * Выберите [тип диска](../../concepts/disk.md#disks_types).
      * Задайте нужный размер диска.
      * (Опционально) Чтобы [зашифровать](../../concepts/encryption.md) загрузочный или дополнительный диск, в блоке **Диски и файловые хранилища** справа от имени диска нажмите значок ![image](../../../_assets/console-icons/pencil.svg) и задайте параметры шифрования для диска:
        
        * Выберите опцию **Зашифрованный диск**.
        * В поле **Ключ KMS** выберите [ключ](../../../kms/concepts/key.md), которым вы хотите зашифровать диск. Чтобы [создать](../../../kms/operations/key.md#create) новый ключ, нажмите кнопку **Создать**.
        
        Для создания зашифрованного диска нужна [роль](../../../kms/security/index.md#kms-keys-user) `kms.keys.user` или выше.
        
        {% note warning %}
        
        Задать настройки шифрования можно только при создании диска. Шифрование диска нельзя будет отключить или изменить. Также нельзя будет включить шифрование для уже созданного диска.
        
        {% endnote %}
        
        Если деактивировать ключ, которым были зашифрованы диск, снимок или образ, доступ к данным будет приостановлен, пока ключ не будет снова активирован.
        
        {% note alert %}
        
        Если удалить ключ или его [версию](../../../kms/concepts/version.md), которыми были зашифрованы диск, снимок или образ, то доступ к данным будет безвозвратно потерян. Подробнее см. [Удаление версии ключа](../../../kms/concepts/version.md#version-distruct).
        
        {% endnote %}
  
          Если вы создаете ВМ из существующего загрузочного диска, измените настройки этого диска на вкладке **Пользовательский** в блоке **Образ загрузочного диска** вверху формы.
  
  1. (Опционально) Добавьте дополнительный [диск](../../concepts/disk.md):
     
     * В блоке **Диски и файловые хранилища** нажмите кнопку **Добавить**.
     * В открывшемся окне выберите **Диск**. Вы можете выбрать существующий диск или создать новый диск — пустой или из снимка / образа.
     
         Например, чтобы создать новый пустой диск:
     
         * Выберите `Создать новый`.
         * В поле **Наполнение** выберите `Пустой`.
         * Укажите имя диска.
         * Выберите [тип диска](../../concepts/disk.md#disks_types).
         * Задайте нужные размер диска и размер блока.
         * (Опционально) В поле **Дополнительно** включите опцию **Удалять вместе с виртуальной машиной**, если вы хотите автоматически удалять этот диск при удалении ВМ.
         * Нажмите кнопку **Добавить диск**.
  1. (Опционально) Подключите [файловое хранилище](../../concepts/filesystem.md):
     
     * В блоке **Диски и файловые хранилища** нажмите кнопку **Добавить**.
     
         * В открывшемся окне выберите **Файловое хранилище** и в появившемся списке выберите хранилище, которое требуется подключить.
     
         * Нажмите кнопку **Добавить файловое хранилище**.
  1. В блоке **Вычислительные ресурсы**:
  
      * Перейдите на вкладку **GPU**.
      * Выберите одну из [платформ](../../concepts/vm-platforms.md#gpu-platforms):
  
          * Intel Broadwell with NVIDIA® Tesla® V100
          * Intel Cascade Lake with NVIDIA® Tesla® V100
          * AMD EPYC™ with NVIDIA® Ampere® A100
          * Intel Ice Lake with NVIDIA® Tesla® T4
          * Intel Ice Lake with T4i
  
      * Выберите одну из предлагаемых конфигураций с необходимым количеством GPU, vCPU и объемом RAM.
  
  1. В блоке **Сетевые настройки**:
     
     * В поле **Подсеть** укажите идентификатор подсети в зоне доступности создаваемой ВМ или выберите [облачную сеть](../../../vpc/concepts/network.md#network) из списка.
     
         * У каждой сети должна быть как минимум одна [подсеть](../../../vpc/concepts/network.md#subnet). Если подсети нет, создайте ее, выбрав **Создать подсеть**.
         * Если сети нет, нажмите **Создать сеть** и создайте ее:
     
             * В открывшемся окне укажите имя сети и выберите каталог, в котором она будет создана.
             * (Опционально) Выберите опцию **Создать подсети**, чтобы автоматически создать подсети во всех зонах доступности.
             * Нажмите **Создать сеть**.
     
     * В поле **Публичный IP-адрес** выберите способ назначения адреса:
     
         * `Автоматически` — чтобы назначить случайный IP-адрес из пула адресов Yandex Cloud. В этом случае можно включить [защиту от DDoS-атак](../../../vpc/ddos-protection/index.md) при помощи опции ниже.
         * `Список` — чтобы выбрать публичный IP-адрес из списка зарезервированных заранее статических адресов. Подробнее читайте в разделе [Сделать динамический публичный IP-адрес статическим](../../../vpc/operations/set-static-ip.md).
         * `Без адреса` — чтобы не назначать публичный IP-адрес.
     
     * Выберите [подходящие группы безопасности](../../../vpc/concepts/security-groups.md):
     
         * Чтобы подключаться к виртуальной машине по `SSH`, группа безопасности должна разрешать входящий сетевой трафик по протоколам `TCP` и `UDP` на порт `22`.
     
         * Чтобы подключаться к виртуальной машине по `RDP`, группа безопасности должна разрешать входящий сетевой трафик по протоколам `TCP` и `UDP` на порт `3389`.
         
         Если оставить поле пустым, виртуальной машине будет автоматически назначена [группа безопасности по умолчанию](../../../vpc/concepts/security-groups.md#default-security-group), позволяющая подключаться к ВМ по `SSH` и `RDP`.
     
     * Разверните блок **Дополнительно** и в поле **Внутренний IPv4 адрес** выберите способ назначения внутренних адресов:
     
         * `Автоматически` — чтобы назначить случайный IP-адрес из пула адресов, доступных в выбранной подсети.
         * `Вручную` — чтобы задать внутренний IP-адрес ВМ вручную.
         * При необходимости включите опцию **Защита от DDoS-атак**. Опция доступна, если ранее в настройках публичного адреса вы выбрали автоматический способ назначения адреса.
     
     * (Опционально) Создайте записи для ВМ в [зоне DNS](../../../dns/concepts/dns-zone.md):
     
         * Разверните блок **Настройки DNS для внутренних адресов** и нажмите **Добавить запись**.
         * Укажите зону, FQDN и время жизни записи. При указании FQDN для зоны доступна опция `Определять автоматически`.
           Вы можете добавить несколько записей во [внутренние зоны](../../../dns/concepts/dns-zone.md) DNS. Подробнее см. [Интеграция Cloud DNS с Compute Cloud](../../../dns/concepts/compute-integration.md).
         * Чтобы создать еще одну запись, нажмите кнопку **Добавить запись**.
     
     Если вы хотите добавить на ВМ дополнительный [сетевой интерфейс](../../concepts/network.md), нажмите кнопку **Добавить сетевой интерфейс** и в появившемся блоке настроек нового интерфейса повторите действия, описанные выше в этом шаге. На одну ВМ можно добавить до восьми сетевых интерфейсов.
  1. В блоке **Доступ**:
     
     * Выберите **Доступ по OS Login**, чтобы [подключаться](../vm-connect/os-login.md) к создаваемой ВМ и управлять доступом к ней с помощью [OS Login](../../../organization/concepts/os-login.md) в Yandex Identity Hub.
     
         Используя OS Login, вы сможете подключаться к ВМ по SSH-ключам и SSH-сертификатам с помощью стандартного SSH-клиента или [интерфейса командной строки Yandex Cloud](../../../cli/quickstart.md). OS Login позволяет ротировать SSH-ключи, используемые для доступа к ВМ, и является наиболее [безопасным](../../../security/domains/iaas-checklist.md#vm-security) вариантом доступа.
     
     * Если доступ по OS Login вам не подходит, выберите вариант **SSH-ключ** и укажите данные для доступа к ВМ:
     
         * В поле **Логин** введите имя пользователя.
     
             {% note alert %}
     
             Не используйте логин `root` или другие [имена, зарезервированные ОС](https://github.com/canonical/subiquity/blob/main/reserved-usernames). Для выполнения операций, требующих прав суперпользователя, используйте команду `sudo`.
     
             {% endnote %}
     
         * В поле **SSH-ключ** выберите SSH-ключ, сохраненный в вашем профиле [пользователя организации](../../../organization/concepts/membership.md).
           
           Если в вашем профиле нет сохраненных SSH-ключей или вы хотите добавить новый ключ:
           
           1. Нажмите кнопку **Добавить ключ**.
           1. Задайте имя SSH-ключа.
           1. Выберите вариант:
           
               * `Ввести вручную` — вставьте содержимое открытого [SSH](../../../glossary/ssh-keygen.md)-ключа. Пару SSH-ключей необходимо [создать](../vm-connect/ssh.md#creating-ssh-keys) самостоятельно.
               * `Загрузить из файла` — загрузите открытую часть SSH-ключа. Пару SSH-ключей необходимо создать самостоятельно.
               * `Сгенерировать ключ` — автоматическое создание пары SSH-ключей.
               
                 При добавлении сгенерированного SSH-ключа будет создан и загружен архив с парой ключей. В ОС на базе Linux или macOS распакуйте архив в папку `/home/<имя_пользователя>/.ssh`. В ОС Windows распакуйте архив в папку `C:\Users\<имя_пользователя>/.ssh`. Дополнительно вводить открытый ключ в консоли управления не требуется.
           
           1. Нажмите кнопку **Добавить**.
           
           SSH-ключ будет добавлен в ваш профиль пользователя организации. Если в организации [отключена](../../../organization/operations/os-login-access.md) возможность добавления пользователями SSH-ключей в свои профили, добавленный открытый SSH-ключ будет сохранен только в профиле пользователя внутри создаваемого ресурса.
     
     Если вы хотите добавить на ВМ одновременно нескольких пользователей с SSH-ключами, [задайте](../../concepts/metadata/sending-metadata.md) данные этих пользователей в блоке **Метаданные**. С помощью метаданных вы также можете [установить дополнительное ПО](create-with-cloud-init-scripts.md) на ВМ при ее создании.
     
     В публичных образах Linux, предоставляемых Yandex Cloud, возможность подключения по протоколу SSH с использованием логина и пароля по умолчанию отключена.
  
  1. В блоке **Общая информация** задайте имя ВМ:
  
      * длина — от 3 до 63 символов;
      * может содержать строчные буквы латинского алфавита, цифры и дефисы;
      * первый символ — буква, последний — не дефис.
  
      {% note info %}
      
      Имя виртуальной машины используется для генерации [внутреннего FQDN](../../concepts/network.md#hostname) единожды — при создании ВМ. Если для вас важен внутренний FQDN, учитывайте это и задавайте нужное имя ВМ при создании.
      
      {% endnote %}
  
  1. В блоке **Дополнительно**:
     
     * (Опционально) Выберите или создайте [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md). Использование сервисного аккаунта позволяет гибко настраивать права доступа к ресурсам.
     * (Опционально) Разрешите доступ к [серийной консоли](../../concepts/serial-console.md).
     * (Опционально) Чтобы настроить поставку [системных метрик Linux](../../../monitoring/operations/unified-agent/linux_metrics.md) и дополнительных метрик ваших приложений, в блоке **Мониторинг** включите опцию **Агент сбора метрик** и выберите:
       * **Yandex Monitoring** — [установить агент](../../../monitoring/concepts/data-collection/unified-agent/index.md) для сбора дополнительных метрик ВМ и приложений.
       * **Yandex Managed Service for Prometheus®** — [установить и настроить агент](../../../monitoring/operations/prometheus/ingestion/prometheus-agent.md) для сбора дополнительных метрик ВМ и приложений в формате Prometheus:
          * Выберите или создайте воркспейс, в котором будут храниться метрики.
          * (Опционально) Опишите в формате JSON [параметры поставки](../../../monitoring/operations/prometheus/ingestion/prometheus-agent.md) собственных метрик.
     * (Опционально) В блоке **Размещение** выберите [группу размещения](../../concepts/placement-groups.md) ВМ.
  1. Нажмите кнопку **Создать ВМ**.
  
  Виртуальная машина появится в списке.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды [CLI](../../../cli/index.md) для создания ВМ:

     ```bash
     yc compute instance create --help
     ```

  1. [Подготовьте](../vm-connect/ssh.md#creating-ssh-keys) пару ключей (открытый и закрытый) для [SSH-доступа](../../../glossary/ssh-keygen.md) на ВМ.
  1. Выберите один из публичных [образов](../images-with-pre-installed-software/get-list.md).

     Чтобы получить список доступных образов, выполните следующую команду:
     
     ```bash
     yc compute image list --folder-id standard-images
     ```
     
     Результат:
     
     ```text
     +----------------------+----------------------------------+-----------------------+----------------------+--------+
     |          ID          |               NAME               |         FAMILY        |     PRODUCT IDS      | STATUS |
     +----------------------+----------------------------------+-----------------------+----------------------+--------+
     ...
     | fdv7ooobjfl3******** | windows-2016-gvlk-gpu-1548913814 | windows-2016-gvlk-gpu | dqnnc72gj2is******** | READY  |
     | fdv4f5kv5cvf******** | ubuntu-1604-lts-gpu-1549457823   | ubuntu-1604-lts-gpu   | dqnnb6dc7640******** | READY  |
     ...
     +----------------------+----------------------------------+-----------------------+----------------------+--------+
     ```

     Для виртуальных машин с GPU доступны специальные образы операционных систем с драйверами NVIDIA:
     
     Intel Broadwell with NVIDIA® Tesla® V100 и Intel Cascade Lake with NVIDIA® Tesla® V100
     
     : * [Ubuntu 18.04 LTS GPU](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-18-04-lts-gpu) (`ubuntu-1804-lts-gpu`)
       * [Ubuntu 20.04 LTS GPU](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-20-04-lts-gpu) (`ubuntu-2004-lts-gpu`)
     
     Intel Ice Lake with NVIDIA® Tesla® T4
     
     : * [Ubuntu 20.04 LTS GPU](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-20-04-lts-gpu) (`ubuntu-2004-lts-gpu`)
     
     Intel Ice Lake with T4i
     
     : * [Ubuntu 22.04 LTS GPU CUDA 12.2](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-2204-lts-cuda-12-2) (`ubuntu-2204-lts-cuda-12-2`)
     
     AMD EPYC™ with NVIDIA® Ampere® A100
     
     : * [Ubuntu 22.04 LTS GPU CUDA 12.2](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-2204-lts-cuda-12-2) (`ubuntu-2204-lts-cuda-12-2`)
     
       Для поддержки кластерного режима:
     : * [Ubuntu 20.04 LTS GPU Cluster](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-2004-lts-gpu-cluster)(`ubuntu-2004-lts-gpu-cluster`)
     
     Gen2
     
     : * [Ubuntu 20.04 LTS Secure Boot CUDA 12.2](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-2004-lts-secureboot-cuda-12-2) (`ubuntu-2004-lts-secureboot-cuda-12-2`)
     
     Мы рекомендуем использовать стандартный образ от Yandex Cloud. Вы также можете [установить драйверы](../vm-operate/install-nvidia-drivers.md) на другой стандартный образ самостоятельно или [создать собственный образ](../image-create/custom-image.md) с предустановленными драйверами.
     
     {% note info %}
     
     Compute Cloud проверяет работоспособность и рекомендует устанавливать только [LTS версии драйверов](https://docs.nvidia.com/datacenter/tesla/drivers/releases.json).
     
     При установке драйверов для платформы `gpu-standard-v3` (AMD EPYC™ with NVIDIA® Ampere® A100) указывайте совместимую версию драйвера — `535`.
     
     Мы рекомендуем использовать именно эту версию драйвера — обновление до других версий не поддерживается и может привести к нестабильной работе GPU.
     
     {% endnote %}

  1. Создайте ВМ в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию:

     ```bash
     yc compute instance create \
       --name gpu-instance \
       --zone ru-central1-a \
       --platform=gpu-standard-v3 \
       --cores=8 \
       --memory=96 \
       --gpus=1 \
       --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
       --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts-gpu,kms-key-id=<идентификатор_ключа> \
       --ssh-key ~/.ssh/id_ed25519.pub
     ```

     Где:
     * `--name` – имя ВМ.

       {% note info %}
       
       Имя виртуальной машины используется для генерации [внутреннего FQDN](../../concepts/network.md#hostname) единожды — при создании ВМ. Если для вас важен внутренний FQDN, учитывайте это и задавайте нужное имя ВМ при создании.
       
       {% endnote %}

     * `--zone` – [зона доступности](../../../overview/concepts/geo-scope.md).

       Виртуальные машины на платформах Intel Broadwell with NVIDIA® Tesla® V100, Intel Cascade Lake with NVIDIA® Tesla® V100 и AMD EPYC™ with NVIDIA® Ampere® A100 можно создать в зонах доступности `ru-central1-a` и `ru-central1-b`.

     * `--platform` – идентификатор [платформы](../../concepts/vm-platforms.md):

       * `gpu-standard-v1` для платформы Intel Broadwell with NVIDIA® Tesla® V100.
       * `gpu-standard-v2` для платформы Intel Cascade Lake with NVIDIA® Tesla® V100.
       * `gpu-standard-v3` для платформы AMD EPYC™ with NVIDIA® Ampere® A100.
       * `standard-v3-t4` для платформы Intel Ice Lake with NVIDIA® Tesla® T4.
       * `standard-v3-t4i` для платформы Intel Ice Lake with T4i.

     * `--cores` – [количество vCPU](../../concepts/gpus.md).
     * `--memory` – размер RAM.
     * `--gpus` – количество GPU.
     * `--preemptible` – если нужно сделать ВМ [прерываемой](../../concepts/preemptible-vm.md).
     * `--network-interface` — настройки [сетевого интерфейса](../../concepts/network.md) ВМ:
         * `subnet-name` — имя выбранной подсети.
         * `nat-ip-version=ipv4` – [публичный IP-адрес](../../../vpc/concepts/address.md#public-addresses). Чтобы создать ВМ без публичного IP-адреса, исключите параметр.

         Если вы хотите добавить на ВМ несколько [сетевых интерфейсов](../../concepts/network.md), задайте параметр `--network-interface` необходимое количество раз. На одну ВМ можно добавить до восьми сетевых интерфейсов.

     * `--create-boot-disk` — [образ](../images-with-pre-installed-software/get-list.md) операционной системы:

         * `image-family` — [семейство образов](../../concepts/image.md#family), например, `ubuntu-1604-lts-gpu`. Эта опция позволит установить последнюю версию ОС из указанного семейства.
         * `kms-key-id` — идентификатор [симметричного ключа KMS](../../../kms/concepts/key.md) для создания зашифрованного загрузочного диска. Необязательный параметр.

           Для создания зашифрованного диска нужна [роль](../../../kms/security/index.md#kms-keys-user) `kms.keys.user` или выше.
           
           {% note warning %}
           
           Задать настройки шифрования можно только при создании диска. Шифрование диска нельзя будет отключить или изменить. Также нельзя будет включить шифрование для уже созданного диска.
           
           {% endnote %}

           Если деактивировать ключ, которым были зашифрованы диск, снимок или образ, доступ к данным будет приостановлен, пока ключ не будет снова активирован.
           
           {% note alert %}
           
           Если удалить ключ или его [версию](../../../kms/concepts/version.md), которыми были зашифрованы диск, снимок или образ, то доступ к данным будет безвозвратно потерян. Подробнее см. [Удаление версии ключа](../../../kms/concepts/version.md#version-distruct).
           
           {% endnote %}

     * `--ssh-key` — путь к файлу с [публичным SSH-ключом](../vm-connect/ssh.md#creating-ssh-keys). Для этого ключа на ВМ будет автоматически создан пользователь `yc-user`.

     Получите описание созданной ВМ:

     ```bash
     yc compute instance get --full gpu-instance
     ```

     Результат:

     ```text
     name: gpu-instance
     zone_id: ru-central1-a
     platform_id: gpu-standard-v3
     resources:
       memory: "103079215104"
       cores: "8"
       core_fraction: "100"
       gpus: "1"
     status: RUNNING
     ...
     ```

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     ```hcl
     resource "yandex_compute_disk" "boot-disk" {
       name     = "<имя_диска>"
       type     = "<тип_диска>"
       zone     = "<зона_доступности>"
       size     = "<размер_диска>"
       image_id = "<идентификатор_образа>"
     }

     resource "yandex_compute_instance" "vm-1" {
       name                      = "vm-with-gpu"
       allow_stopping_for_update = true
       platform_id               = "gpu-standard-v3"
       zone                      = "<зона_доступности>"

       resources {
         cores  = <количество_ядер_vCPU>
         memory = <объем_RAM_ГБ>
         gpus   = <количество_GPU>
       }

       boot_disk {
         disk_id = yandex_compute_disk.boot-disk.id
       }

       network_interface {
         subnet_id = "${yandex_vpc_subnet.subnet-1.id}"
         nat       = true
       }

       metadata = {
         ssh-keys = "<имя_пользователя>:<содержимое_SSH-ключа>"
       }
     }

     resource "yandex_vpc_network" "network-1" {
       name = "network1"
     }

     resource "yandex_vpc_subnet" "subnet-1" {
       name           = "subnet1"
       zone           = "<зона_доступности>"
       v4_cidr_blocks = ["192.168.1.0/24"]
       network_id     = "${yandex_vpc_network.network-1.id}"
     }
     ```

     Где:
     * `yandex_compute_disk` — описание загрузочного [диска](../../concepts/disk.md):
       * `name` — имя диска.
       * `type` — тип создаваемого диска.
       * `zone` — [зона доступности](../../../overview/concepts/geo-scope.md), в которой будет находиться диск.
       * `size` — размер диска в ГБ.
       * `image_id` — идентификатор образа для ВМ. Вы можете получить идентификатор образа из [списка публичных образов](../images-with-pre-installed-software/get-list.md).

         Для виртуальных машин с GPU доступны специальные образы операционных систем с драйверами NVIDIA:
         
         Intel Broadwell with NVIDIA® Tesla® V100 и Intel Cascade Lake with NVIDIA® Tesla® V100
         
         : * [Ubuntu 18.04 LTS GPU](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-18-04-lts-gpu) (`ubuntu-1804-lts-gpu`)
           * [Ubuntu 20.04 LTS GPU](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-20-04-lts-gpu) (`ubuntu-2004-lts-gpu`)
         
         Intel Ice Lake with NVIDIA® Tesla® T4
         
         : * [Ubuntu 20.04 LTS GPU](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-20-04-lts-gpu) (`ubuntu-2004-lts-gpu`)
         
         Intel Ice Lake with T4i
         
         : * [Ubuntu 22.04 LTS GPU CUDA 12.2](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-2204-lts-cuda-12-2) (`ubuntu-2204-lts-cuda-12-2`)
         
         AMD EPYC™ with NVIDIA® Ampere® A100
         
         : * [Ubuntu 22.04 LTS GPU CUDA 12.2](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-2204-lts-cuda-12-2) (`ubuntu-2204-lts-cuda-12-2`)
         
           Для поддержки кластерного режима:
         : * [Ubuntu 20.04 LTS GPU Cluster](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-2004-lts-gpu-cluster)(`ubuntu-2004-lts-gpu-cluster`)
         
         Gen2
         
         : * [Ubuntu 20.04 LTS Secure Boot CUDA 12.2](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-2004-lts-secureboot-cuda-12-2) (`ubuntu-2004-lts-secureboot-cuda-12-2`)
         
         Мы рекомендуем использовать стандартный образ от Yandex Cloud. Вы также можете [установить драйверы](../vm-operate/install-nvidia-drivers.md) на другой стандартный образ самостоятельно или [создать собственный образ](../image-create/custom-image.md) с предустановленными драйверами.
         
         {% note info %}
         
         Compute Cloud проверяет работоспособность и рекомендует устанавливать только [LTS версии драйверов](https://docs.nvidia.com/datacenter/tesla/drivers/releases.json).
         
         При установке драйверов для платформы `gpu-standard-v3` (AMD EPYC™ with NVIDIA® Ampere® A100) указывайте совместимую версию драйвера — `535`.
         
         Мы рекомендуем использовать именно эту версию драйвера — обновление до других версий не поддерживается и может привести к нестабильной работе GPU.
         
         {% endnote %}

     * `yandex_compute_instance` — описание ВМ:
       * `name` — имя ВМ.
       * `allow_stopping_for_update` — разрешение на остановку работы виртуальной машины для внесения изменений. Установите значение `true`, если планируете изменять сетевые настройки или вычислительные ресурсы ВМ с помощью Terraform. Значение по умолчанию `false`.
       * `zone` — зона доступности, в которой будет находиться ВМ.

         Виртуальные машины на платформах Intel Broadwell with NVIDIA® Tesla® V100, Intel Cascade Lake with NVIDIA® Tesla® V100 и AMD EPYC™ with NVIDIA® Ampere® A100 можно создать в зонах доступности `ru-central1-a` и `ru-central1-b`.

       * `platform_id` — идентификатор [платформы](../../concepts/vm-platforms.md):

         * `gpu-standard-v1` для платформы Intel Broadwell with NVIDIA® Tesla® V100.
         * `gpu-standard-v2` для платформы Intel Cascade Lake with NVIDIA® Tesla® V100.
         * `gpu-standard-v3` для платформы AMD EPYC™ with NVIDIA® Ampere® A100.
         * `standard-v3-t4` для платформы Intel Ice Lake with NVIDIA® Tesla® T4.
         * `standard-v3-t4i` для платформы Intel Ice Lake with T4i.

       * `resources` — количество ядер vCPU и объем RAM, доступные ВМ. Значения должны соответствовать выбранной [платформе](../../concepts/vm-platforms.md).
       * `boot_disk` — настройки загрузочного диска. Укажите идентификатор диска.
       * `network_interface` — настройки [сетевого интерфейса](../../concepts/network.md) ВМ. Укажите идентификатор выбранной [подсети](../../../vpc/concepts/network.md#subnet). Чтобы автоматически назначить ВМ [публичный IP-адрес](../../../vpc/concepts/address.md#public-addresses), укажите `nat = true`.

           Если вы хотите добавить на ВМ несколько [сетевых интерфейсов](../../concepts/network.md), задайте блок `network_interface` необходимое количество раз.

       * `metadata` — в метаданных необходимо передать открытый ключ для SSH-доступа на ВМ. Подробнее в разделе [Метаданные виртуальной машины](../../concepts/vm-metadata.md).
     * `yandex_vpc_network` — описание облачной сети.
     * `yandex_vpc_subnet` — описание подсети, к которой будет подключена ВМ.

     {% note info %}

     Если у вас уже есть подходящие ресурсы (облачная сеть и подсеть), описывать их повторно не нужно. Используйте их имена и идентификаторы в соответствующих параметрах.

     {% endnote %}

     Более подробную информацию о ресурсах, которые вы можете создать с помощью Terraform, см. в [документации провайдера](../../../terraform/index.md).
  1. Создайте ресурсы:

     1. В терминале перейдите в директорию с конфигурационным файлом.
     1. Проверьте корректность конфигурации с помощью команды:
     
        ```bash
        terraform validate
        ```
     
        Если конфигурация является корректной, появится сообщение:
     
        ```bash
        Success! The configuration is valid.
        ```
     
     1. Выполните команду:
     
        ```bash
        terraform plan
        ```
     
        В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
     1. Примените изменения конфигурации:
     
        ```bash
        terraform apply
        ```
     
     1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

     После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления](https://console.yandex.cloud).

- API {#api}

  Чтобы создать ВМ, воспользуйтесь методом REST API [create](../../api-ref/Instance/create.md) для ресурса [Instance](../../api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/Create](../../api-ref/grpc/Instance/create.md).

{% endlist %}

При создании виртуальной машине назначаются [IP-адрес](../../../vpc/concepts/address.md#public-addresses) и [доменное имя](../../../vpc/concepts/address.md#fqdn) (FQDN).

#### См. также {#see-also}

* [Изменить конфигурацию ВМ](../vm-control/vm-update-resources.md)
* [Вопросы про GPU](../../qa/gpu.md)