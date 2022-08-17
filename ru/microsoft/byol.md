# Использование своей лицензии для продуктов Microsoft

В {{ yandex-cloud }} можно использовать ваши личные лицензионные продукты Microsoft на [выделенных хостах](../compute/concepts/dedicated-host.md). При этом лицензионные отношения действуют только между вами как клиентом и Microsoft как вендором лицензии. Вы несете полную ответственность за соблюдение [условий лицензирования Microsoft](https://www.microsoft.com/en-us/licensing/product-licensing/products). 

Когда вы используете в {{ yandex-cloud }} лицензионные продукты, приобретенные у Microsoft, стоимость лицензии исключается из стоимости использования ВМ. Все вопросы, касающиеся лицензирования продуктов, необходимо решать с вашим поставщиком.

{% note info %}

Информация в этой статье не имеет юридической силы и несет ознакомительный характер.

{% endnote %}

## Какие лицензии можно использовать {#which-licenses}

Возможность использования лицензии в {{ yandex-cloud }} зависит от условий лицензирования конкретного продукта Microsoft. BYOL (Bring Your Own License, использование собственной лицензии) доступно, если лицензия приобретена по одному из следующих соглашений:

* Соглашение Microsoft Enterprise или соглашение о регистрации Microsoft Enterprise (EA).
* Соглашение Microsoft Server and Cloud Enrollment (SCE).
* Программа корпоративного лицензирования Microsoft Enterprise Subscription Agreement (EAS).
* Соглашение Microsoft Products and Services Agreement (MPSA).
* Программы Microsoft Open, Open Value и Open Value Subscription.
* Программы Microsoft Enrollment for Education Solutions (EES).

{% note info %}

Лицензии, приобретенные по программе Microsoft Cloud Solution Provider (CSP), не подходят для BYOL.

{% endnote %}

Обратите внимание, что список лицензий может меняться и оказаться неполным. Обязательно свяжитесь с Microsoft и запросите актуальный список программ лицензирования, подходящих для BYOL в облачных средах.

## Как перенести свои лицензии {#how-to-bring-licenses}

1. [Импортируйте нужный образ](#how-to-import).
1. [Создайте группу выделенных хостов](#create-host-group).
1. [Создайте виртуальную машину на выделенном хосте из импортированного образа](#create-vm).
1. [Убедитесь, что ВМ работает и активируйте лицензию](#test-vm).

### Импортируйте нужный образ {#how-to-import}

Вы можете импортировать образ, используя [REST API {{ compute-name }}](../compute/api-ref/Image/create). 

1. Выполните запрос вида:

   ```
   curl -H "Authorization: Bearer `yc iam create-token`" -H  "accept: application/json" -X POST https://compute.api.cloud.yandex.net/compute/v1/images -d '{"folderId": "<id вашего каталога>", "name": "<название образа>", "description": "<описание образа>", "os": {"type": "WINDOWS"}, "pooled": false, "uri": "<ссылка на образ в Object Storage>"}'
   ```

1. Откройте [консоль управления]({{ link-console-cloud }}), выберите каталог, ID которого вы указали в параметре `folderId` на первом шаге.
1. Перейдите в раздел {{ compute-name }} и выберите вкладку **Образы**.
1. Найдите импортируемый образ, он будет находиться в статусе `Creating`. Дождитесь смены статуса с `Creating` на `Ready`.

### Создайте группу выделенных хостов {#create-host-group}

Свяжитесь с вашим аккаунт-менеджером и получите квоту на группу выделенных хостов. Обратите внимание, что минимальное количество ядер vCPU на выделенных хостах — 128, все они оплачиваются.

Создайте группу выделенных хостов [по инструкции](../compute/operations/dedicated-host/create-host-group.md).

### Создайте ВМ из вашего образа на выделенном хосте {#create-vm}

1. Подготовьте файл с метаданными `metadata.yaml` и задайте в нем пароль администратора:

   ```
   #ps1
   net user Administrator "<пароль администратора>"
   ```

   Обратите внимание, что пароль должен соответствовать [требованиям к сложности](https://docs.microsoft.com/ru-ru/windows/security/threat-protection/security-policy-settings/password-must-meet-complexity-requirements) паролей Windows. 

1. Чтобы создать ВМ с загрузочным диском из импортированного образа, выполните команду:

   ```
   yc compute instance create \
   --host-id <идентификатор выделенного хоста> \
   --name 'win-test' \
   --folder-id <идентификатор каталога> \
   --cores <количество vCPU> \
   --core-fraction 100 \
   --memory <объем памяти в ГБ> \
   --network-interface subnet-id=<идентификатор подсети>,nat-ip-version=ipv4 \
   --create-boot-disk image-id=<идентификатор импортированного образа> \
   --zone <зона доступности> \
   --metadata-from-file user-data=metadata.yaml
   ```

## Проверьте работу ВМ {#test-vm}

Подождите 5-10 минут. Подключитесь к созданной ВМ [с помощью RDP](../compute/operations/vm-connect/rdp.md). После этого вы можете активировать свою лицензию.
