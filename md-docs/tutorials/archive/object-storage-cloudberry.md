# Резервное копирование в Yandex Object Storage с помощью MSP360 Backup (CloudBerry Desktop Backup)

Yandex Object Storage можно использовать для резервного копирования и восстановления данных с помощью утилиты [MSP360 Backup](https://www.msp360.com/msp360-free-backup/).

Утилита MSP360 Backup (ранее CloudBerry Desktop Backup) предназначена для резервного копирования и восстановления данных, в том числе в облачных хранилищах. Бесплатная версия MSP360 Backup позволяет создавать резервные копии объемом не более 200 ГБ.

Чтобы настроить резервное копирование в Object Storage с помощью MSP360 Backup:
1. [Подготовьте облако к работе](#prepare-cloud).
1. [Настройте сервисный аккаунт](#prepare-service-account).
1. [Создайте бакет](#create-bucket).
1. [Установите MSP360 Backup](#install-cloudberry).
1. [Настройте MSP360 Backup](#configure-cloudberry).
1. [Протестируйте резервное копирование](#test-backup).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#prepare-cloud}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки резервного копирования с помощью MSP360 Backup входят:
* плата за хранение данных;
* плата за операции с данными;
* плата за исходящий трафик из Yandex Cloud в интернет.

[Подробнее о тарифах Yandex Object Storage](../../storage/pricing.md#prices).

## Настройте сервисный аккаунт {#prepare-service-account}

Резервное копирование в Object Storage выполняется от имени [сервисного аккаунта](../../iam/concepts/users/service-accounts.md). Если у вас еще нет сервисного аккаунта, [создайте](../../iam/operations/sa/create.md) его.

Чтобы настроить сервисный аккаунт:
1. [Назначьте](../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту [роль](../../iam/roles-reference.md#editor) `editor`.
1. [Создайте](../../iam/operations/authentication/manage-access-keys.md#create-access-key) статический ключ доступа. Сразу сохраните [идентификатор и секретный ключ](../../iam/concepts/authorization/access-key.md#access-key-format). После того, как вы закроете окно, секретный ключ будет недоступен.


## Создайте бакет {#create-bucket}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) Yandex Cloud выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будете выполнять операции.
  1. На странице каталога нажмите ![plus](../../_assets/console-icons/plus.svg) **Создать ресурс** и выберите **Бакет**.
  1. В поле **Имя** укажите имя [бакета](../../storage/concepts/bucket.md) в соответствии с [правилами именования](../../storage/concepts/bucket.md#naming).
  1. В полях **Чтение объектов**, **Чтение списка объектов** и **Чтение настроек** выберите `С авторизацией`.
  1. Укажите максимальный размер бакета в ГБ.
  1. Нажмите **Создать бакет**.

{% endlist %}

## Установите MSP360 Backup {#install-cloudberry}

{% list tabs group=operating_system %}

- Windows {#windows}

  1. (опционально) [Установите](https://dotnet.microsoft.com/en-us/download) Microsoft .NET Framework.
  1. [Установите](https://www.msp360.com/cloudberry-backup/download/cbbbm/) MSP360 Backup Desktop Edition. Для загрузки введите необходимые реквизиты и нажмите **Download**.
  1. Запустите MSP360 Backup и выберите опцию **Use Home Edition (free)**. Нажмите **Next**.
  1. Нажмите **Start Free Trial**.

- Linux/macOS {#linux-macos}

  1. Установите MSP360 Backup. Для загрузки выберите опрационную систему:  
       * [macOS](https://www.msp360.com/cloudberry-backup/download/cbbmac/)
       * [Ubuntu, Debian](https://www.msp360.com/cloudberry-backup/download/cbbub1214/)
       * [SUSE, Red Hat, Fedora, CentOS](https://www.msp360.com/cloudberry-backup/download/cbbrh6/)
       
       Введите необходимые реквизиты и нажмите **Download**.
  1. Запустите MSP360 Backup и выберите опцию **Use Home Edition (free)**. Нажмите **Next**.
  1. Введите адрес электронной почты и нажмите **Finish**.
  1. В открывшемся окне нажмите **OK**.

{% endlist %}

## Настройте MSP360 Backup {#configure-cloudberry}

{% list tabs group=operating_system %}

- Windows {#windows}

  1. Запустите MSP360 Backup.
  1. Чтобы открыть главное меню, нажмите на логотип MSP360 Backup в левом верхнем углу.
  1. Выберите **Add Storage Account**.
  1. В списке провайдеров выберите **S3 Compatible**.
  1. В открывшемся окне введите параметры хранилища:
      * **Display Name** — `Yandex Cloud`.
      * **Access Key** — идентификатор статического ключа доступа.
      * **Secret Key** — закрытый ключ.
      * **Service point** — `http://storage.yandexcloud.net/`. В поле **Bucket name** должен отобразиться список ваших бакетов.
      * **Bucket name** — бакет, в котором будут храниться резервные копии.

      Нажмите **OK**. Если все настроено верно, хранилище `Yandex Cloud` появится в окне **Storaged accounts**. Закройте окно.
  1. Перейдите на вкладку **Home**.
  1. Выберите **Local to Cloud**. В открывшемся окне нажмите **Next**.
  1. Выберите хранилище **Yandex Cloud** и нажмите **Next**.
  1. Укажите имя плана резервного копирования: `cloud-backup-plan` и нажмите **Next**.
  1. Оставьте опции, установленные по умолчанию, и нажмите **Next**.
  1. В дереве файлов укажите те директории и файлы, которым требуется резервное копирование. Нажмите **Next**.
  1. Чтобы сделать копию всех файлов в выбранных папках, выберите опцию **Backup all files in selected folders**. Нажмите **Next**.
  1. На экране с предупреждением о невозможности сжатия и шифрования резервных копий в бесплатной версии нажмите **Next**.
  1. Чтобы проверялась целостность резервных копий оставьте опцию **Enable Full Consistency Check** включенной. Нажмите **Next**.
  1. По умолчанию резервное копирование производится вручную. Если требуется задать расписание копирования, выберите **Enable schedule** и задайте расписание. Нажмите **Next**.
  1. Задайте настройки продолжительности хранения файлов. По умолчанию резервные копии хранятся постоянно. Нажмите **Next**.
  1. На экране **Pre / Post Actions** (действия перед и после копирования) оставьте настройки по умолчанию и нажмите **Next**.
  1. Чтобы получать уведомления о результатах копирования, выберите опцию **I want to receive a notification email** и укажите в каких случаях:
      * **When the backup plan fails or finished with warnings** — при неудачном завершении копирования или при наличии предупреждений.
      * **In all cases** — во всех случаях.

      Укажите почту, имя и тему письма. Нажмите **Next**. В появившемся окне с информацией о необходимости подтверждения почты для получения уведомлений нажмите **Ok**. Перейдите по ссылке из полученного письма для подтверждения электронной почты. 
  1. Проверьте план и нажмите **Next**.
  1. Нажмите **Finish**.

- Linux/macOS {#linux-macos}

  1. Запустите MSP360 Backup.
  1. Нажмите **Back up files**.
  1. Нажмите **+** и выберите **S3 Compatible**. 
  1. В открывшемся окне введите параметры хранилища:
     * **Display Name** — `Yandex Cloud`.
     * **Access Key** — идентификатор статического ключа доступа.
     * **Secret Key** — закрытый ключ.
     * **Endpoint** — `http://storage.yandexcloud.net/`. В поле **Bucket** отобразится список ваших бакетов.
     * **Bucket** — бакет, в котором будут храниться резервные копии.
     * **Advanced settings** — дополнительные настройки. Оставьте значения по умолчанию.

     Нажмите **OK**. Если все настроено верно, в окне **Backup plan: cloud storage** появится хранилище `Yandex Cloud`.
  1. Выберите хранилище **Yandex Cloud** и нажмите **Continue**.
  1. Укажите имя плана резервного копирования: `cloud-backup-plan`. Нажмите **Continue**.
  1. В дереве файлов укажите те директории и файлы, которым требуется резервное копирование. Нажмите **Continue**.
  1. Чтобы добавить в резервную копию все файлы из выбранных директорий, оставьте переключатель в положении **Backup all files in selected folders**. Нажмите **Continue**.
  1. На экране с предупреждением о невозможности сжатия и шифрования резервных копий в бесплатной версии нажмите **Continue**.
  1. Чтобы проверялась целостность резервных копий, оставьте опцию **Enable Full Consistency Check** включенной. Нажмите **Continue**.
  1. По умолчанию резервное копирование производится вручную. Если требуется задать расписание копирования, выберите **Enable schedule** и задайте расписание. Нажмите **Continue**.
  1. Задайте настройки продолжительности хранения файлов. По умолчанию хранение резервных копий не ограничено по времени. Нажмите **Continue**.
  1. Чтобы получать уведомления о результатах копирования, выберите опцию **I want to receive a notification email when plan completes** и укажите в каких случаях:
      * **In all cases** — во всех случаях;
      * **When plan fails** — при неудачном завершении копирования или при наличии предупреждений.

      Укажите почту, имя и тему письма. Если нужен детальный отчет, выберите опцию **Generate detailed report**. Нажмите **Next**. Перейдите по ссылке из полученного письма для подтверждения электронной почты. 
  1. Проверьте план и нажмите **Done**.

{% endlist %}

## Протестируйте резервное копирование {#test-backup}

{% list tabs group=operating_system %}

- Windows {#windows}

  1. В приложении MSP360 Backup выберите вкладку **Backup plans**.
  1. Чтобы запустить резервное копирование, нажмите ![image](../../_assets/console-icons/play-fill.svg) в строке с планом `cloud-backup-plan`.
  1. В [консоли управления](https://console.yandex.cloud) Yandex Cloud выберите каталог, в котором находится бакет с резервными копиями.
  1. Выберите сервис **Object Storage**.
  1. В списке бакетов выберите бакет с резервными копиями и проверьте, что все нужные файлы были скопированы.

- Linux/macOS {#linux-macos}

  1. В приложении MSP360 Backup на панели слева выберите вкладку **Backup plans**.
  1. Чтобы запустить резервное копирование, выберите план `cloud-backup-plan` и нажмите **Start**.
  1. В [консоли управления](https://console.yandex.cloud) Yandex Cloud выберите каталог, в котором находится бакет с резервными копиями.
  1. Выберите сервис **Object Storage**.
  1. В списке бакетов выберите бакет с резервными копиями и проверьте, что все нужные файлы были скопированы.

{% endlist %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. [Удалите](../../storage/operations/objects/delete-all.md) [объекты](../../storage/concepts/object.md) в [бакете](../../storage/concepts/bucket.md).
1. [Удалите](../../storage/operations/buckets/delete.md) бакет.