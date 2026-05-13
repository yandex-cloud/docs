# Подключение к Container Registry из Virtual Private Cloud


Для работы с [Container Registry](../../container-registry/index.md) облачным ресурсам требуется доступ в интернет. С помощью руководства вы развернете в Yandex Cloud облачную инфраструктуру для организации доступа к Container Registry для ресурсов, которые размещены в облачной сети [Virtual Private Cloud](../../vpc/concepts/index.md) и не имеют публичных IP-адресов или выхода в интернет через [NAT-шлюз](../../vpc/concepts/gateways.md).

Container Registry для хранения Docker-образов в реестре использует [Object Storage](../../storage/index.md). В этом решении также организован доступ к Object Storage для ресурсов в Virtual Private Cloud.

Схема решения представлена ниже.

![image](../../_assets/tutorials/cr-hld.svg)

После развертывания решения в Yandex Cloud будут созданы следующие ресурсы:

| Название | Описание |
| ---- | ---- |
| `cr-vpc` `*` | Облачная сеть с ресурсами, для которых организуется доступ к Container Registry. |
| `cr-nlb` | Внутренний сетевой балансировщик обеспечивает прием трафика к Container Registry. Балансировщик принимает TCP трафик с портом назначения 443 и распределяет его по ресурсам (ВМ) в целевой группе. |
| `nat-group` | Целевая группа балансировщиков с виртуальными машинами, на которых включена функция NAT. |
| `s3-nlb` | Внутренний сетевой балансировщик обеспечивает прием трафика к Object Storage. Балансировщик принимает TCP трафик с портом назначения 443 и распределяет его по ресурсам (ВМ) в целевой группе. |
| `nat-a1-vm`, `nat-b1-vm` | Виртуальные машины с NAT в зонах `ru-central1-a` и `ru-central1-b` для передачи трафика к Container Registry и Object Storage с трансляцией IP-адресов источников и получателей трафика, а также для передачи обратного трафика. | 
| `pub-ip-a1`, `pub-ip-b1` | Публичные IP-адреса ВМ, в которые облачная сеть VPC транслирует их внутренние IP-адреса. | 
| `DNS зоны и A-записи` | Внутренние DNS зоны `storage.yandexcloud.net.` и `cr.yandex.` в сети `cr-vpc` с ресурсными `A` записями, сопоставляющими доменные имена с IP-адресами внутренних сетевых балансировщиков. |
| `test-registry` | Реестр в Container Registry. |
| `container-registry-<id_реестра>` | Имя бакета в Object Storage для хранения Docker-образов, где `<id_реестра>` – идентификатор реестра. Сервис Container Registry автоматически создает в Object Storage бакет для реестра. |
| `cr-subnet-a`, `cr-subnet-b` | Облачные подсети для размещения ВМ с NAT в зонах `ru-central1-a` и `ru-central1-b`. |
| `test-cr-vm` | Тестовая ВМ для проверки доступа к Container Registry. |
| `test-cr-subnet-a` | Облачная подсеть для размещения тестовой ВМ. |

`*` *При развертывании можно также указать существующую облачную сеть*

Для облачной сети с размещаемыми ресурсами в сервисе [Cloud DNS](../../dns/concepts/index.md) создаются внутренние DNS-зоны:
* `cr.yandex.` и ресурсная запись типа A, сопоставляющая доменное имя `cr.yandex` сервиса Container Registry с IP-адресом [внутреннего сетевого балансировщика](../../network-load-balancer/concepts/nlb-types.md) `cr-nlb`. 
* `storage.yandexcloud.net.` и ресурсная запись типа A, сопоставляющая доменное имя `storage.yandexcloud.net` сервиса Object Storage с IP-адресом внутреннего сетевого балансировщика `s3-nlb`. 

Благодаря этим записям трафик от облачных ресурсов к Container Registry и Object Storage будет направляться на внутренние балансировщики, которые будут распределять нагрузку по виртуальным машинам с NAT.

Для развертывания ВМ с NAT используется [образ из Marketplace](https://yandex.cloud/ru/marketplace/products/yc/nat-instance-ubuntu-22-04-lts), который транслирует IP-адреса источника и назначения, чтобы обеспечить маршрутизацию трафика до публичных IP-адресов Container Registry и Object Storage.

Разместив ВМ с NAT в нескольких [зонах доступности](../../overview/concepts/geo-scope.md), можно получить отказоустойчивость доступа к Container Registry. Увеличивая количество ВМ с NAT, можно масштабировать решение при возрастании нагрузки. При расчете количества ВМ с NAT следует учитывать [локальность при обработке трафика внутренним балансировщиком](../../network-load-balancer/concepts/specifics.md#nlb-int-locality). 

Доступ к реестру открыт только для облачных ресурсов, использующих данное решение. [Политика доступа для реестра](../../container-registry/operations/registry/registry-access.md) разрешает действия с реестром только с публичных IP-адресов ВМ с NAT. Доступ к реестру с других IP-адресов запрещен. При необходимости это ограничение можно отключить с помощью параметра в Terraform.

Более подробное описание приведено в [репозитории проекта](https://github.com/yandex-cloud-examples/yc-cr-private-endpoint). 

Чтобы развернуть облачную инфраструктуру для организации доступа к Container Registry для ресурсов, которые размещены в облачной сети VPC:

1. [Подготовьте облако к работе](#prepare-cloud).
1. [Настройте профиль CLI](#setup-profile).
1. [Подготовьте окружение](#prepare-environment).
1. [Разверните ресурсы](#create-resources).
1. [Протестируйте работоспособность решения](#test-functionality).
1. [Рекомендации по развертыванию решения в продуктивной среде](#deployment-requirements)

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#prepare-cloud}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входит:

* плата за постоянно работающие ВМ (см. [тарифы Yandex Compute Cloud](../../compute/pricing.md));
* плата за использование Network Load Balancer (см. [тарифы Yandex Network Load Balancer](../../network-load-balancer/pricing.md));
* плата за хранение загруженных Docker-образов (см. [тарифы Container Registry](../../container-registry/pricing.md));
* плата за использование публичных IP-адресов и исходящий трафик (см. [тарифы Yandex Virtual Private Cloud](../../vpc/pricing.md)).

### Необходимые квоты {#required-quotes}

Убедитесь, что в облаке достаточно [квот](../../overview/concepts/quotas-limits.md) и они не заняты ресурсами для других задач.

{% cut "Количество занимаемых ресурсов, создаваемых в сценарии" %}

| Ресурс | Количество |
| ----------- | ----------- |
| Виртуальные машины | 3 |
| vCPU виртуальных машин | 6 |
| RAM виртуальных машин | 6 ГБ |
| Диски | 3 |
| Объем HDD дисков | 30 ГБ |
| Объем SSD дисков | 20 ГБ |
| Сетевой балансировщик | 2 |
| Целевая группа для балансировщика | 1 |
| Сети | 1`*` |
| Подсети | 3 |
| Статические публичные IP-адреса | 2 |
| Группы безопасности | 1 |
| Зона DNS | 2 |
| Реестр | 1 |
| Сервисный аккаунт | 1 |

`*` *Если в `terraform.tfvars` не указать идентификатор существующей сети.*

{% endcut %}

## Настройте профиль CLI {#setup-profile}

1. Если у вас еще нет интерфейса командной строки Yandex Cloud, [установите](../../cli/quickstart.md) его и авторизуйтесь от имени пользователя.
1. Создайте сервисный аккаунт:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

      1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором хотите создать сервисный аккаунт.
      1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Identity and Access Management**.
      1. Нажмите кнопку **Создать сервисный аккаунт**.
      1. Введите имя сервисного аккаунта, например, `sa-terraform`.
      1. Нажмите кнопку **Создать**.

   - CLI {#cli}

      По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

      Выполните команду для создания сервисного аккаунта, указав имя `sa-terraform`:

      ```bash
      yc iam service-account create --name sa-terraform
      ```

      Где `name` — имя сервисного аккаунта.

      Результат:
      ```text
      id: ajehr0to1g8b********
      folder_id: b1gv87ssvu49********
      created_at: "2023-06-20T09:03:11.665153755Z"
      name: sa-terraform
      ```

   - API {#api}

      Чтобы создать сервисный аккаунт, воспользуйтесь вызовом gRPC API [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md) или методом [create](../../iam/api-ref/ServiceAccount/create.md) для ресурса `ServiceAccount` REST API.

   {% endlist %}

1. Назначьте сервисному аккаунту [роль](../../iam/concepts/access-control/roles.md) администратора на каталог: 

   {% list tabs group=instructions %}

   - Консоль управления {#console}

      1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится сервисный аккаунт.
      1. Перейдите на вкладку ![image](../../_assets/console-icons/persons-lock.svg) **Права доступа**.
      1. В списке аккаунтов выберите `sa-terraform` и нажмите значок ![image](../../_assets/options.svg) → ![image](../../_assets/console-icons/pencil.svg) **Изменить роли**.
      1. В открывшемся диалоге нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **Добавить роль** и выберите роль `admin`.

   - CLI {#cli}

      Выполните команду:
      ```
      yc resource-manager folder add-access-binding <идентификатор_каталога> \
         --role admin \
         --subject serviceAccount:<идентификатор_сервисного_аккаунта>
      ```

   - API {#api}

      Чтобы назначить сервисному аккаунту роль на каталог, воспользуйтесь методом REST API [setAccessBindings](../../iam/api-ref/ServiceAccount/setAccessBindings.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/SetAccessBindings](../../iam/api-ref/grpc/ServiceAccount/setAccessBindings.md).

   {% endlist %}

1. Настройте профиль CLI для выполнения операций от имени сервисного аккаунта:

   {% list tabs group=instructions %}

   - CLI {#cli}

      1. Создайте [авторизованный ключ](../../iam/concepts/authorization/key.md) для сервисного аккаунта и запишите его в файл:
         ```
         yc iam key create \
         --service-account-id <идентификатор_сервисного_аккаунта> \
         --folder-id <id_каталога_с_сервисным_аккаунтом> \
         --output key.json
         ```
         Где:
         * `service-account-id` — идентификатор сервисного аккаунта.
         * `folder-id` — идентификатор каталога, в котором создан сервисный аккаунт.
         * `output` — имя файла с авторизованным ключом.

         Результат:
         ```
         id: aje8nn871qo4********
         service_account_id: ajehr0to1g8b********
         created_at: "2023-06-20T09:16:43.479156798Z"
         key_algorithm: RSA_2048
         ```

      1. Создайте профиль CLI для выполнения операций от имени сервисного аккаунта:
         ```
         yc config profile create sa-terraform
         ```

         Результат:
         ```
         Profile 'sa-terraform' created and activated
         ```

      1. Задайте конфигурацию профиля:
         ```
         yc config set service-account-key key.json
         yc config set cloud-id <идентификатор_облака>
         yc config set folder-id <идентификатор_каталога>
         ```

         Где:
         * `service-account-key` — файл с авторизованным ключом сервисного аккаунта.
         * `cloud-id` — [идентификатор облака](../../resource-manager/operations/cloud/get-id.md).
         * `folder-id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md).

      1. Добавьте аутентификационные данные в переменные окружения:
         ```
         export YC_TOKEN=$(yc iam create-token)
         ```

   {% endlist %}

## Подготовьте окружение {#prepare-environment}

### Установите необходимые утилиты {#install-utilities}

1. Установите [Git](https://ru.wikipedia.org/wiki/Git) с помощью команды:

   ```bash
   sudo apt install git
   ```

1. [Установите Terraform](../infrastructure-management/terraform-quickstart.md#install-terraform).

## Разверните ресурсы {#create-resources}

1. Клонируйте [репозиторий](https://github.com/yandex-cloud-examples/yc-cr-private-endpoint/) из GitHub и перейдите в папку сценария `yc-cr-private-endpoint`:
   
   ```bash
   git clone https://github.com/yandex-cloud-examples/yc-cr-private-endpoint.git
   cd yc-cr-private-endpoint
   ```

1. Откройте файл `terraform.tfvars` и отредактируйте:

   1. Строку, содержащую идентификатор каталога:

      ```text
      folder_id = "<идентификатор_каталога>"
      ```

   1. Строку, содержащую список агрегированных префиксов облачных подсетей, для которых разрешен доступ к Container Registry:

      ```text
      trusted_cloud_nets = ["10.0.0.0/8", "192.168.0.0/16"]
      ```

   {% cut "Описание переменных в terraform.tfvars" %}

   | Название<br>параметра | Нужно<br>изменение | Описание | Тип | Пример |
   | --- | --- | --- | --- | --- |
   | `folder_id` | да | ID каталога для размещения компонентов решения. | `string` | `b1gentmqf1ve9uc54nfh` |
   | `vpc_id` | - | ID облачной сети, для которой организуется доступ к Container Registry. Если не указано, то сеть будет создана. | `string` | `enp48c1ndilt42veuw4x` |
   | `yc_availability_zones` | - | Список [зон доступности](../../overview/concepts/geo-scope.md) для развертывания ВМ с NAT.  | `list(string)` | `["ru-central1-a", "ru-central1-b"]` |
   | `subnet_prefix_list` | - | Список префиксов облачных подсетей для размещения ВМ с NAT (по одной подсети в каждой зоне доступности из списка `yc_availability_zones`, перечисленных в том же порядке). | `list(string)` | `["10.10.1.0/24", "10.10.2.0/24"]` |
   | `nat_instances_count` | - | Количество разворачиваемых ВМ с NAT. Рекомендуется указывать четное число для равномерного распределения ВМ по зонам доступности. | `number` | `2` |
   | `registry_private_access` | - | Ограничить доступ к реестру только с публичных IP-адресов ВМ с NAT. Используется значение `true` для ограничения, `false` для отмены ограничения. | `bool` | `true` |
   | `trusted_cloud_nets` | да | Список агрегированных префиксов облачных подсетей, для которых разрешен доступ к Container Registry. Используется во входящем правиле групп безопасности для ВМ с NAT.  | `list(string)` | `["10.0.0.0/8", "192.168.0.0/16"]` |
   | `vm_username` | - | Имя пользователя для ВМ с NAT и тестовой ВМ. | `string` | `admin` |
   | `cr_ip` | - | Публичный IP-адрес сервиса Container Registry. | `string` | `84.201.171.239` |
   | `cr_fqdn` | - | Доменное имя сервиса Container Registry. | `string` | `cr.yandex` | 
   | `s3_ip` | - | Публичный IP-адрес сервиса Object Storage. | `string` | `213.180.193.243` |
   | `s3_fqdn` | - | Доменное имя сервиса Object Storage. | `string` | `storage.yandexcloud.net` |

   {% endcut %}

1. Разверните ресурсы в облаке с помощью Terraform:

   1. Выполните инициализацию Terraform:

      ```bash
      terraform init
      ```

   1. Проверьте конфигурацию Terraform файлов:

      ```bash
      terraform validate
      ```

   1. Проверьте список создаваемых облачных ресурсов:

      ```bash
      terraform plan
      ```

   1. Создайте ресурсы:

      ```bash
      terraform apply
      ```

1. После завершения процесса `terraform apply` в командной строке будет выведена информация для подключения к тестовой ВМ и тестирования работы с Container Registry. В дальнейшем его можно будет посмотреть с помощью команды `terraform output`:

   {% cut "Посмотреть информацию о развернутых ресурсах" %}

   | Название | Описание | Пример значения |
   | ----------- | ----------- | ----------- |
   | `cr_nlb_ip_address` | IP-адрес внутреннего балансировщика для Container Registry. | `10.10.1.100` |
   | `cr_registry_id` | Идентификатор реестра в Container Registry. | `crp1r4h00mj*********` |
   | `path_for_private_ssh_key` | Файл с приватным ключом для подключения по протоколу SSH к ВМ с NAT и тестовой ВМ. | `./pt_key.pem` |
   | `s3_nlb_ip_address` | IP-адрес внутреннего балансировщика для Object Storage. | `10.10.1.200` |
   | `test_vm_password` | Пароль пользователя `admin` для тестовой ВМ. | `v3RСqUrQN?x)` |
   | `vm_username` | Имя пользователя для ВМ с NAT и тестовой ВМ. | `admin` |

   {% endcut %}

## Протестируйте работоспособность решения {#test-functionality}

1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором ранее были созданы ресурсы.

1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Compute Cloud**.

1. В списке виртуальных машин выберите ВМ `test-cr-vm`.

1. В меню слева выберите ![image](../../_assets/console-icons/terminal.svg) **Серийная консоль**.

1. Нажмите кнопку **Подключиться**.

1. Введите логин `admin` и пароль из вывода команды `terraform output test_vm_password` (укажите значение без кавычек).

1. Выполните команду:

   ```bash
   dig cr.yandex storage.yandexcloud.net
   ```

1. Убедитесь, что в ответе от DNS-сервера доменному имени сервиса Object Storage и Container Registry соответствуют IP-адреса внутренних балансировщиков. Результат вывода ресурсных записей типа `A`:

   ```text
   ;; ANSWER SECTION:
   cr.yandex.               300    IN      A       10.10.1.100

   ;; ANSWER SECTION:
   storage.yandexcloud.net. 300    IN      A       10.10.1.200
   ```

1. Посмотрите список доступных для загрузки Docker-образов: 

   ```bash
   docker image list
   ```

   Результат:
   ```text
   REPOSITORY    TAG       IMAGE ID       CREATED        SIZE
   golang        1.20.5    342*********   8 months ago   777MB
   hello-world   latest    9c7*********   9 months ago   13.3kB
   ```

1. Присвойте Docker-образу URL вида `cr.yandex/<идентификатор_реестра>/<имя_Docker-образа>:<тег>`. Идентификатор реестра будет получен из переменной среды на тестовой ВМ:

   ```bash
   docker tag hello-world cr.yandex/$REGISTRY_ID/hello-world:demo

   docker image list
   ```

   Результат:
   ```text
   REPOSITORY                                   TAG       IMAGE ID       CREATED        SIZE
   golang                                       1.20.5    342*********   8 months ago   777MB
   cr.yandex/crp1r4h00mj*********/hello-world   demo      9c7*********   9 months ago   13.3kB
   hello-world                                  latest    9c7*********   9 months ago   13.3kB
   ```

   {% note info %}

   Загрузить в Container Registry можно только Docker-образы с URL вида `cr.yandex/<идентификатор_реестра>/<имя_Docker-образа>:<тег>`.

   {% endnote %}

1. Загрузите необходимый Docker-образ в реестр:

   ```bash
   docker push cr.yandex/$REGISTRY_ID/hello-world:demo
   ```

   Результат:
   ```text
   The push refers to repository [cr.yandex/crp1r4h00mj*********/hello-world]
   01bb4*******: Pushed 
   demo: digest: sha256:7e9b6e7ba284****************** size: 525
   ```

1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором ранее были созданы ресурсы.

1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Container Registry**.

1. Выберите реестр `test-registry`.

1. Убедитесь, что в реестре появился репозиторий `hello-world` с Docker-образом.

## Рекомендации по развертыванию решения в продуктивной среде {#deployment-requirements}

* При развертывании ВМ с NAT в нескольких зонах доступности указывайте четное число ВМ для их равномерного распределения по зонам доступности;
* Выбирая количество ВМ с NAT, учитывайте [локальность при обработке трафика внутренним балансировщиком](../../network-load-balancer/concepts/specifics.md#nlb-int-locality);
* После ввода решения в эксплуатацию уменьшайте количество ВМ с NAT или изменяйте список зон доступности в параметре `yc_availability_zones` только в заранее запланированный период времени. В процессе применения изменений возможны прерывания в обработке трафика;
* Если при возрастании нагрузки к Container Registry внутри ВМ с NAT наблюдается большое значение метрики `CPU steal time`, то для ВМ с NAT рекомендуется включить [программно ускоренную сеть](../../vpc/concepts/software-accelerated-network.md);
* Если вы используете собственный DNS-сервер, в его настройках создайте ресурсные записи типа `A` следующего вида:

   | Имя | Тип | Значение |
   | ----------- | ----------- | ----------- |
   | `cr.yandex.` | `A` | `<IP-адрес внутреннего балансировщика для Container Registry из вывода команды terraform output cr_nlb_ip_address>` |
   | `storage.yandexcloud.net.` | `A` | `<IP-адрес внутреннего балансировщика для Object Storage из вывода команды terraform output s3_nlb_ip_address>` |

* Сохраните приватный SSH-ключ `pt_key.pem`, используемый для подключения к ВМ с NAT, в надежное место либо пересоздайте его отдельно от Terraform;
* После развертывания решения доступ по SSH к ВМ с NAT будет закрыт. Чтобы разрешить доступ к ВМ с NAT по протоколу SSH, добавьте входящее правило для SSH-трафика (`TCP/22`) в [группе безопасности](../../vpc/concepts/security-groups.md) `cr-nat-sg`, чтобы разрешить доступ только с определенных IP-адресов рабочих мест администраторов;
* После проверки работоспособности удалите тестовую ВМ и ее подсеть.

## Удалите созданные ресурсы {#clear-out}

* Вручную {#manual}

    1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором ранее были созданы ресурсы.
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Container Registry**.
    1. Выберите реестр `test-registry`.
    1. Выберите репозиторий `hello-world`.
    1. Для каждого Docker-образа в репозитории нажмите значок ![image](../../_assets/console-icons/ellipsis.svg).
    1. В открывшемся меню нажмите кнопку **Удалить**.
    1. В открывшемся окне нажмите кнопку **Удалить**.

* С помощью Terraform {#tf}

    1. В терминале перейдите в директорию с планом инфраструктуры.
    
        {% note warning %}
    
        Убедитесь, что в директории нет Terraform-манифестов с ресурсами, которые вы хотите сохранить. Terraform удаляет все ресурсы, которые были созданы с помощью манифестов в текущей директории.
    
        {% endnote %}
    
    1. Удалите ресурсы:
    
        1. Выполните команду:
    
            ```bash
            terraform destroy
            ```
    
        1. Подтвердите удаление ресурсов и дождитесь завершения операции.
    
        Все ресурсы, которые были описаны в Terraform-манифестах, будут удалены.