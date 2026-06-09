# Как начать работать с Yandex Cloud SDK

[Yandex Cloud SDK](overview.md) — это комплект средств разработки для взаимодействия с облачной инфраструктурой.

Рассмотрим некоторые возможности SDK на примере пошагового создания [виртуальной машины](../../compute/concepts/vm.md) Yandex Compute Cloud.

Чтобы начать работать с Yandex Cloud SDK:
1. [Подготовьте облако к работе](#before-begin).
    1. [Создайте сервисный аккаунт](#create-sa).
    1. [Подготовьте Yandex Cloud CLI](#prepare-cli).
    1. [Получите исходные данные](#get-source-data).
1. [Настройте окружение](#prepare-project).
1. [Создайте файл конфигурации](#create-config).
1. [Подготовьте код скрипта](#prepare-code).
1. [Создайте ВМ с помощью скрипта](#run-code).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

Также см. [Примеры использования SDK](#examples).

## Подготовьте облако к работе {#before-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки ВМ, созданной с помощью SDK, входят:
* плата за вычислительные ресурсы ВМ (см. [тарифы Yandex Compute Cloud](../../compute/pricing.md#prices-instance-resources));
* плата за диски ВМ (см. [тарифы Yandex Compute Cloud](../../compute/pricing.md#prices-storage));
* плата за использование динамического внешнего IP-адреса (см. [тарифы Yandex Virtual Private Cloud](../../vpc/pricing.md#prices-public-ip)).

### Создайте сервисный аккаунт {#create-sa}

1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт.
1. [Назначьте](../../organization/operations/add-role.md) сервисному аккаунту [роли](../../iam/concepts/access-control/roles.md) в зависимости от сервисов, которыми вы хотите управлять с помощью Yandex Cloud SDK.

    В данном руководстве для создания ВМ вам понадобится роль [compute.admin](../../compute/security/index.md#compute-admin). 
    
    Если вы будете использовать **SDK для .NET**, также назначьте сервисному аккаунту роль [iam.serviceAccounts.admin](../../iam/security/index.md#iam-serviceAccounts-admin). Эта роль понадобится для получения [авторизованного ключа](../../iam/concepts/authorization/key.md).

### Подготовьте Yandex Cloud CLI {#prepare-cli}

1. [Установите](../../cli/operations/install-cli.md) Yandex Cloud CLI.
1. [Аутентифицируйтесь](../../cli/operations/authentication/service-account.md) в Yandex Cloud CLI от имени сервисного аккаунта.

    С помощью Yandex Cloud CLI будут получены данные для аутентификации в Yandex Cloud:
    * для Node.js, Go, Python, Java — [IAM-токен](../../iam/concepts/authorization/iam-token.md).
    * для .NET — [авторизованный ключ](../../iam/concepts/authorization/key.md).

### Получите исходные данные {#get-source-data}

1. [Получите](../../resource-manager/operations/folder/get-id.md) идентификатор каталога, внутри которого вы будете взаимодействовать с сервисами с помощью Yandex Cloud SDK.
1. [Подберите](../../compute/operations/images-with-pre-installed-software/get-list.md) подходящий образ для ВМ. Сохраните идентификатор [семейства образов](../../compute/concepts/image.md#family), например `ubuntu-2204-lts`.
1. [Создайте](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) пару SSH-ключей, чтобы использовать их для [подключения к ВМ](../../compute/operations/vm-connect/ssh.md). 

## Подготовьте рабочую директорию {#prepare-project}

{% list tabs group=instructions %}

- Node.js {#nodejs}

    1. В терминале проверьте версию Node.js с помощью команды: 

        ```bash
        node -v
        ```

        Yandex Cloud SDK поддерживает версию Node.js 12 и выше. Если Node.js не установлен или нужна более новая версия, выберите подходящий вариант установки на [сайте Node.js](https://nodejs.org/en/download/package-manager).
    1. Склонируйте [репозиторий с примерами Yandex Cloud SDK для Node.js](https://github.com/yandex-cloud-examples/yc-sdk-quickstart-node-js.git):

        ```bash
        git clone https://github.com/yandex-cloud-examples/yc-sdk-quickstart-node-js.git
        ```

    1. Перейдите в склонированный репозиторий и установите зависимости:

        ```bash
        cd yc-sdk-quickstart-node-js && npm i
        ```

- Go {#go}

    1. В терминале проверьте версию Go с помощью команды: 

        ```bash
        go version
        ```

        Если Go не установлен, выберите подходящий вариант установки на [сайте Go](https://go.dev/doc/install).
    1. Склонируйте [репозиторий с примерами Yandex Cloud SDK для Go](https://github.com/yandex-cloud-examples/yc-sdk-quickstart-go.git):

        ```bash
        git clone https://github.com/yandex-cloud-examples/yc-sdk-quickstart-go.git
        ```

    1. Перейдите в склонированный репозиторий и установите зависимости:

        ```bash
        cd yc-sdk-quickstart-go && go tidy
        ```
    
- Python {#python}

    1. В терминале проверьте версию Python с помощью команды для Linux и MacOS: 

        ```bash
        python3 --version
        ```

        или для Windows:

        ```bash
        python --version
        ```
        
        Если Python не установлен, выберите подходящий вариант установки на [сайте Python](https://www.python.org/downloads).
    1. Склонируйте [репозиторий с примерами Yandex Cloud SDK для Python](https://github.com/yandex-cloud-examples/yc-sdk-quickstart-python.git):

        ```bash
        git clone https://github.com/yandex-cloud-examples/yc-sdk-quickstart-python.git
        ```

    1. Перейдите в склонированный репозиторий и установите зависимости:

        ```bash
        cd yc-sdk-quickstart-python && pip install yandexcloud
        ```

- Java {#java}

    1. В терминале проверьте версию Java с помощью команды: 

        ```bash
        java --version
        ```

        Если Java не установлен, выберите подходящий вариант установки на [сайте Oracle](https://www.oracle.com/java/technologies/downloads/).
    1. Дополнительно [установите Apache Maven](https://maven.apache.org/install.html) для сборки проекта.
    1. Склонируйте [репозиторий с примерами Yandex Cloud SDK для Java](https://github.com/yandex-cloud-examples/yc-sdk-quickstart-java.git):

        ```bash
        git clone https://github.com/yandex-cloud-examples/yc-sdk-quickstart-java.git
        ```

    1. Перейдите в склонированный репозиторий:

        ```bash
        cd yc-sdk-quickstart-java
        ```

- .NET {#dotnet}

    1. В терминале проверьте версию .NET с помощью команды: 

        ```bash
        dotnet -version
        ```

        Если .NET не установлен, выберите подходящий вариант установки на [сайте Microsoft](https://dotnet.microsoft.com/en-us/download). Рекомендуем установить версию 9.0 так как она используется в данной инструкции. Если вы установите другую версию .NET, укажите ее в файле `YC-test`.
    1. Склонируйте [репозиторий с примерами Yandex Cloud SDK для .NET](https://github.com/yandex-cloud-examples/yc-sdk-quickstart-dotnet.git):

        ```bash
        git clone https://github.com/yandex-cloud-examples/yc-sdk-quickstart-dotnet.git
        ```

    1. В склонированном репозитории перейдите в директорию `yc-sdk-quickstart-dotnet`:

        ```bash
        cd yc-sdk-quickstart-dotnet
        ```

{% endlist %}

## Настройте файл конфигурации {#create-config}

{% list tabs group=instructions %}

- Node.js {#nodejs}

    Откройте файл `config.json`. В нем уже задана базовая конфигурация ВМ, но вы можете указать собственные параметры:

    ```json
    {
        "folder_id": "<идентификатор_каталога>",
        "username": "user",
        "resources": {
            "image": {
                "family": "ubuntu-2204-lts",
                "folder_family_id": "standard-images"
            },
            "name": "computer",
            "resources_spec": {
                "memory": 2147483648,
                "cores": 2
            },
            "boot_disk_spec": {
                "auto_delete": true,
                "disk_spec": {
                    "type_id": "network-hdd",
                    "size": 10737418240
                }
            },
            "zone_id": "ru-central1-d",
            "platform_id": "standard-v3",
            "subnet_id": "<идентификатор_подсети>"
        },
        "metadata": {
            "ssh-keys": "USERNAME:SSH_PUBLIC_KEY",
            "user-data": "#cloud-config\n    datasource:\n      Ec2:\n        strict_id: false\n    users:\n      - name: USERNAME\n        sudo: 'ALL=(ALL) NOPASSWD:ALL'\n        shell: /bin/bash\n        ssh_authorized_keys:\n          - SSH_PUBLIC_KEY"
        },
        "labels": {
            "yc-sdk": "yes"
        }
    }
    ```
    
    Где:  
    * `folder_id` — идентификатор [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder).
    * `username` — имя пользователя ВМ.
    * `family` — идентификатор [семейства образов](../../compute/concepts/image.md#family).
    * `folder_family_id` — идентификатор каталога, в котором размещены образы. Для [публичных образов](../../compute/concepts/image.md#public) — `standard-images`.
    * `name` — название ВМ.
    * `memory` — объем RAM в байтах.
    * `cores` — количество vCPU.
    * `auto_delete` — указание, что диск должен удаляться вместе с ВМ.
    * `type_id` — [тип диска](../../compute/concepts/disk.md#disks-types) ВМ.
    * `size` — объем диска в байтах.
    * `zone_id` — [зона доступности](../concepts/geo-scope.md), в которой вы хотите разместить ВМ.
    * `platform_id` — идентификатор [платформы](../../compute/concepts/vm-platforms.md).
    * `subnet_id` — идентификатор [подсети](../../vpc/concepts/network.md#subnet).
    * `metadata` — [метаданные ВМ](../../compute/concepts/vm-metadata.md).
    * `labels` — [метка](../../resource-manager/concepts/labels.md) ВМ.

- Go {#go}

    Откройте файл `config.json`. В нем уже задана базовая конфигурация ВМ, но вы можете указать собственные параметры:

    ```json
    {
        "folder_id": "<идентификатор_каталога>",
        "username": "user",
        "resources": {
            "image": {
                "family": "ubuntu-2204-lts",
                "folder_family_id": "standard-images"
            },
            "name": "computer",
            "resources_spec": {
                "memory": 2147483648,
                "cores": 2
            },
            "boot_disk_spec": {
                "auto_delete": true,
                "disk_spec": {
                    "type_id": "network-hdd",
                    "size": 10737418240
                }
            },
            "zone_id": "ru-central1-d",
            "platform_id": "standard-v3",
            "subnet_id": "<идентификатор_подсети>"
        },
        "metadata": {
            "ssh-keys": "USERNAME:SSH_PUBLIC_KEY",
            "user-data": "#cloud-config\n    datasource:\n      Ec2:\n        strict_id: false\n    users:\n      - name: USERNAME\n        sudo: 'ALL=(ALL) NOPASSWD:ALL'\n        shell: /bin/bash\n        ssh_authorized_keys:\n          - SSH_PUBLIC_KEY"
        },
        "labels": {
            "yc-sdk": "yes"
        }
    }
    ```
    
    Где:  
    * `folder_id` — идентификатор [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder).
    * `username` — имя пользователя ВМ.
    * `family` — идентификатор [семейства образов](../../compute/concepts/image.md#family).
    * `folder_family_id` — идентификатор каталога, в котором размещены образы. Для [публичных образов](../../compute/concepts/image.md#public) — `standard-images`.
    * `name` — название ВМ.
    * `memory` — объем RAM в байтах.
    * `cores` — количество vCPU.
    * `auto_delete` — указание, что диск должен удаляться вместе с ВМ.
    * `type_id` — [тип диска](../../compute/concepts/disk.md#disks-types) ВМ.
    * `size` — объем диска в байтах.
    * `zone_id` — [зона доступности](../concepts/geo-scope.md), в которой вы хотите разместить ВМ.
    * `platform_id` — идентификатор [платформы](../../compute/concepts/vm-platforms.md).
    * `subnet_id` — идентификатор [подсети](../../vpc/concepts/network.md#subnet).
    * `metadata` — [метаданные ВМ](../../compute/concepts/vm-metadata.md).
    * `labels` — [метка](../../resource-manager/concepts/labels.md) ВМ.

- Python {#python}

    Откройте файл `config.json`. В нем уже задана базовая конфигурация ВМ, но вы можете указать собственные параметры:

    ```json
    {
        "folder_id": "<идентификатор_каталога>",
        "username": "user",
        "resources": {
            "image": {
                "family": "ubuntu-2204-lts",
                "folder_family_id": "standard-images"
            },
            "name": "computer",
            "resources_spec": {
                "memory": 2147483648,
                "cores": 2
            },
            "boot_disk_spec": {
                "auto_delete": true,
                "disk_spec": {
                    "type_id": "network-hdd",
                    "size": 10737418240
                }
            },
            "zone_id": "ru-central1-d",
            "platform_id": "standard-v3",
            "subnet_id": "<идентификатор_подсети>"
        },
        "metadata": {
            "ssh-keys": "USERNAME:SSH_PUBLIC_KEY",
            "user-data": "#cloud-config\n    datasource:\n      Ec2:\n        strict_id: false\n    users:\n      - name: USERNAME\n        sudo: 'ALL=(ALL) NOPASSWD:ALL'\n        shell: /bin/bash\n        ssh_authorized_keys:\n          - SSH_PUBLIC_KEY"
        },
        "labels": {
            "yc-sdk": "yes"
        }
    }
    ```
    
    Где:  
    * `folder_id` — идентификатор [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder).
    * `username` — имя пользователя ВМ.
    * `family` — идентификатор [семейства образов](../../compute/concepts/image.md#family).
    * `folder_family_id` — идентификатор каталога, в котором размещены образы. Для [публичных образов](../../compute/concepts/image.md#public) — `standard-images`.
    * `name` — название ВМ.
    * `memory` — объем RAM в байтах.
    * `cores` — количество vCPU.
    * `auto_delete` — указание, что диск должен удаляться вместе с ВМ.
    * `type_id` — [тип диска](../../compute/concepts/disk.md#disks-types) ВМ.
    * `size` — объем диска в байтах.
    * `zone_id` — [зона доступности](../concepts/geo-scope.md), в которой вы хотите разместить ВМ.
    * `platform_id` — идентификатор [платформы](../../compute/concepts/vm-platforms.md).
    * `subnet_id` — идентификатор [подсети](../../vpc/concepts/network.md#subnet).
    * `metadata` — [метаданные ВМ](../../compute/concepts/vm-metadata.md).
    * `labels` — [метка](../../resource-manager/concepts/labels.md) ВМ.

- Java {#java}

    Откройте файл `config.json` в директории `src/main/resources/config`. В нем уже установлена базовая конфигурация ВМ и вам необходимо указать `folder_id` и `subnet_id`. Но вы можете установить собственные параметры и для других полей:

    ```json
    {
        "folder_id": "<идентификатор_каталога>",
        "username": "user",
        "resources": {
            "image": {
                "family": "ubuntu-2204-lts",
                "folder_family_id": "standard-images"
            },
            "name": "computer",
            "resources_spec": {
                "memory": 2147483648,
                "cores": 2
            },
            "boot_disk_spec": {
                "auto_delete": true,
                "disk_spec": {
                    "type_id": "network-hdd",
                    "size": 10737418240
                }
            },
            "zone_id": "ru-central1-d",
            "platform_id": "standard-v3",
            "subnet_id": "<идентификатор_подсети>"
        },
        "metadata": {
            "ssh-keys": "USERNAME:SSH_PUBLIC_KEY",
            "user-data": "#cloud-config\n    datasource:\n      Ec2:\n        strict_id: false\n    users:\n      - name: USERNAME\n        sudo: 'ALL=(ALL) NOPASSWD:ALL'\n        shell: /bin/bash\n        ssh_authorized_keys:\n          - SSH_PUBLIC_KEY"
        },
        "labels": {
            "yc-sdk": "yes"
        }
    }
    ```
    
    Где:  
    * `folder_id` — идентификатор [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder).
    * `username` — имя пользователя ВМ.
    * `family` — идентификатор [семейства образов](../../compute/concepts/image.md#family).
    * `folder_family_id` — идентификатор каталога, в котором размещены образы. Для [публичных образов](../../compute/concepts/image.md#public) — `standard-images`.
    * `name` — название ВМ.
    * `memory` — объем RAM в байтах.
    * `cores` — количество vCPU.
    * `auto_delete` — указание, что диск должен удаляться вместе с ВМ.
    * `type_id` — [тип диска](../../compute/concepts/disk.md#disks-types) ВМ.
    * `size` — объем диска в байтах.
    * `zone_id` — [зона доступности](../concepts/geo-scope.md), в которой вы хотите разместить ВМ.
    * `platform_id` — идентификатор [платформы](../../compute/concepts/vm-platforms.md).
    * `subnet_id` — идентификатор [подсети](../../vpc/concepts/network.md#subnet).
    * `metadata` — [метаданные ВМ](../../compute/concepts/vm-metadata.md).
    * `labels` — [метка](../../resource-manager/concepts/labels.md) ВМ.

- .NET {#dotnet}

    Откройте файл `config.json`. В нем уже задана базовая конфигурация ВМ, но вы можете указать собственные параметры:

    ```json
    {
        "folder_id": "<идентификатор_каталога>",
        "username": "user",
        "resources": {
            "image": {
                "family": "ubuntu-2204-lts",
                "folder_family_id": "standard-images"
            },
            "name": "computer",
            "resources_spec": {
                "memory": 2147483648,
                "cores": 2
            },
            "boot_disk_spec": {
                "auto_delete": true,
                "disk_spec": {
                    "type_id": "network-hdd",
                    "size": 10737418240
                }
            },
            "zone_id": "ru-central1-d",
            "platform_id": "standard-v3",
            "subnet_id": "<идентификатор_подсети>"
        },
        "metadata": {
            "ssh-keys": "USERNAME:SSH_PUBLIC_KEY",
            "user-data": "#cloud-config\n    datasource:\n      Ec2:\n        strict_id: false\n    users:\n      - name: USERNAME\n        sudo: 'ALL=(ALL) NOPASSWD:ALL'\n        shell: /bin/bash\n        ssh_authorized_keys:\n          - SSH_PUBLIC_KEY"
        },
        "labels": {
            "yc-sdk": "yes"
        }
    }
    ```
    
    Где:  
    * `folder_id` — идентификатор [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder).
    * `username` — имя пользователя ВМ.
    * `family` — идентификатор [семейства образов](../../compute/concepts/image.md#family).
    * `folder_family_id` — идентификатор каталога, в котором размещены образы. Для [публичных образов](../../compute/concepts/image.md#public) — `standard-images`.
    * `name` — название ВМ.
    * `memory` — объем RAM в байтах.
    * `cores` — количество vCPU.
    * `auto_delete` — указание, что диск должен удаляться вместе с ВМ.
    * `type_id` — [тип диска](../../compute/concepts/disk.md#disks-types) ВМ.
    * `size` — объем диска в байтах.
    * `zone_id` — [зона доступности](../concepts/geo-scope.md), в которой вы хотите разместить ВМ.
    * `platform_id` — идентификатор [платформы](../../compute/concepts/vm-platforms.md).
    * `subnet_id` — идентификатор [подсети](../../vpc/concepts/network.md#subnet).
    * `metadata` — [метаданные ВМ](../../compute/concepts/vm-metadata.md).
    * `labels` — [метка](../../resource-manager/concepts/labels.md) ВМ.

{% endlist %}

## Создайте ВМ с помощью скрипта {#run-code}

Проект уже настроен для создания ВМ с помощью консольных команд. С помощью комментариев в коде вы можете детальнее узнать из каких шагов состоит процесс создания ВМ.

{% list tabs group=instructions %}

- Node.js {#nodejs}

    Запустите файл `index.js` командой:

    ```bash
    IAM_TOKEN=$(yc iam create-token) \
    SSH_PUBLIC_KEY_PATH=./key.pub \
    node index.js   
    ```

    Где:
    * `IAM_TOKEN` — [IAM-токен](../../iam/concepts/authorization/iam-token.md), получаемый с помощью Yandex Cloud CLI. Подробнее о команде `yc iam create-token` см. в [справочнике CLI](../../iam/operations/iam-token/create-for-sa.md);
    * `SSH_PUBLIC_KEY_PATH` — путь к файлу с публичным SSH-ключом.
    
    {% note info %}
    
    Перезагрузка системы или оболочки терминала приведет к утрате всех созданных переменных окружения.
    
    {% endnote %}
    
    После начала создания ВМ в терминале вы увидите следующий текст:
    
    ```text
    Running Yandex.Cloud operation. ID: fv4qfujd49fc********
    ```
    
    Где `ID` — идентификатор [операции](../../api-design-guide/concepts/about-async.md) создания ВМ.
    
    Отслеживать статус операции вы можете в консоли управления, а также с помощью Yandex Cloud CLI и API. Подробнее см. на странице [Посмотреть операции с ресурсами сервиса Compute Cloud](../../compute/operations/operation-logs.md).
    
    Когда ВМ будет создана, вы увидите следующее сообщение:
    
    ```text
    Created with id fv4qfujd49fc********
    ```
    
    Где `id` — идентификатор ВМ.

- Go {#go}

    Запустите файл `main.go` командой:

    ```bash
    IAM_TOKEN=$(yc iam create-token) \
    SSH_PUBLIC_KEY_PATH=./key.pub \
    go run main.go
    ```

    Где:
    * `IAM_TOKEN` — [IAM-токен](../../iam/concepts/authorization/iam-token.md), получаемый с помощью Yandex Cloud CLI. Подробнее о команде `yc iam create-token` см. в [справочнике CLI](../../iam/operations/iam-token/create-for-sa.md);
    * `SSH_PUBLIC_KEY_PATH` — путь к файлу с публичным SSH-ключом.
    
    {% note info %}
    
    Перезагрузка системы или оболочки терминала приведет к утрате всех созданных переменных окружения.
    
    {% endnote %}
    
    После начала создания ВМ в терминале вы увидите следующий текст:
    
    ```text
    Running Yandex.Cloud operation. ID: fv4qfujd49fc********
    ```
    
    Где `ID` — идентификатор [операции](../../api-design-guide/concepts/about-async.md) создания ВМ.
    
    Отслеживать статус операции вы можете в консоли управления, а также с помощью Yandex Cloud CLI и API. Подробнее см. на странице [Посмотреть операции с ресурсами сервиса Compute Cloud](../../compute/operations/operation-logs.md).
    
    Когда ВМ будет создана, вы увидите следующее сообщение:
    
    ```text
    Created with id fv4qfujd49fc********
    ```
    
    Где `id` — идентификатор ВМ.

- Python {#python}

    Запустите файл `script.py` командой:

    ```bash
    IAM_TOKEN=$(yc iam create-token) \
    SSH_PUBLIC_KEY_PATH=./key.pub \
    python script.py
    ```

    Где:
    * `IAM_TOKEN` — [IAM-токен](../../iam/concepts/authorization/iam-token.md), получаемый с помощью Yandex Cloud CLI. Подробнее о команде `yc iam create-token` см. в [справочнике CLI](../../iam/operations/iam-token/create-for-sa.md);
    * `SSH_PUBLIC_KEY_PATH` — путь к файлу с публичным SSH-ключом.

    {% note info %}
    
    Перезагрузка системы или оболочки терминала приведет к утрате всех созданных переменных окружения.
    
    {% endnote %}

    Работа скрипта разделена на несколько этапов:

    * **Запуск скрипта для создания ВМ**. Если скрипт не нашел ошибок в формате переданных данных, вы увидите следующее сообщение:
    
      ```text
      INFO:yandexcloud._channels:Using endpoints from configuration, IAM iam.api.cloud.yandex.net:443, compute compute.api.cloud.yandex.net:443
      INFO:yandexcloud._channels:Using endpoints from configuration, IAM iam.api.cloud.yandex.net:443, compute compute.api.cloud.yandex.net:443
      INFO:root:Creating initiated
      ```

    * **Передача данных на сервер для валидации**. Если все данные были указаны корректно, вы увидите следующее сообщение:

      ```text
      INFO:root:Running Yandex.Cloud operation. ID: fv45g3nfq0bn********. Description: Create instance. Created at: 2024-12-19 15:52:59. Created by: ajeutahec4**********. Meta: instance_id: "fv4bi87d50**********".
      INFO:yandexcloud._channels:Using endpoints from configuration, IAM iam.api.cloud.yandex.net:443, operation operation.api.cloud.yandex.net:443
      ```
    
    * **Результат операции**. После создания ВМ вы получите информацию о ней:

      ```text
      INFO:root:Done Yandex.Cloud operation. ID: fv45g3nfq0bn********. Response: id: "fv42jgaq946dm8ibkjl6"
      folder_id: "b1g5hnqtug**********"
      created_at {
          seconds: 1734614895
      }
      name: "computer"
      zone_id: "ru-central1-d"
      platform_id: "standard-v3"
      resources {
          memory: 2147483648
          cores: 2
          core_fraction: 100
      }
      status: RUNNING
      metadata_options {
          gce_http_endpoint: ENABLED
          aws_v1_http_endpoint: ENABLED
          gce_http_token: ENABLED
          aws_v1_http_token: DISABLED
      }
      boot_disk {
          mode: READ_WRITE
          device_name: "fv4sd8kkspslntd0dpvn"
          auto_delete: true
          disk_id: "fv4sd8kkspslntd0dpvn"
      }
      network_interfaces {
          index: "0"
          mac_address: "d0:0d:29:c1:5a:49"
          subnet_id: "fl8b5ou7m8sihjbftcfk"
          primary_v4_address {
              address: "192.168.0.3"
              one_to_one_nat {
              address: "51.250.34.207"
              ip_version: IPV4
              }
          }
      }
      serial_port_settings {
          ssh_authorization: OS_LOGIN
      }
      gpu_settings {}
      fqdn: "fv42jgaq946dm8ibkjl6.auto.internal"
      scheduling_policy {}
      network_settings {
          type: STANDARD
      }
      placement_policy {}
      hardware_generation {
          legacy_features {
              pci_topology: PCI_TOPOLOGY_V1
          }
      }.
      WARNING: All log messages before absl::InitializeLog() is called are written to STDERR
      E0000 00:00:1734614936.026768 4332467 init.cc:229] grpc_wait_for_shutdown_with_timeout() timed out.
      ```

- Java {#java}

    1. Соберите проект командой:

        ```bash
        mvn clean package
        ```
    
    1. В корневой директории проекта запустите программу командой:

        ```bash
        IAM_TOKEN=$(yc iam create-token) \
        SSH_PUBLIC_KEY_PATH=key.pub \
        java -jar target/java-sdk-examples-2.6.4-jar-with-dependencies.jar  
        ```

        Где:
        * `IAM_TOKEN` — [IAM-токен](../../iam/concepts/authorization/iam-token.md), получаемый с помощью Yandex Cloud CLI. Подробнее о команде `yc iam create-token` см. в [справочнике CLI](../../iam/operations/iam-token/create-for-sa.md);
        * `SSH_PUBLIC_KEY_PATH` — путь к файлу с публичным SSH-ключом.
        
        {% note info %}
        
        Перезагрузка системы или оболочки терминала приведет к утрате всех созданных переменных окружения.
        
        {% endnote %}
        
        После начала создания ВМ в терминале вы увидите следующий текст:
        
        ```text
        Running Yandex.Cloud operation. ID: fv4qfujd49fc********
        ```
        
        Где `ID` — идентификатор [операции](../../api-design-guide/concepts/about-async.md) создания ВМ.
        
        Отслеживать статус операции вы можете в консоли управления, а также с помощью Yandex Cloud CLI и API. Подробнее см. на странице [Посмотреть операции с ресурсами сервиса Compute Cloud](../../compute/operations/operation-logs.md).
        
        Когда ВМ будет создана, вы увидите следующее сообщение:
        
        ```text
        Created with id fv4qfujd49fc********
        ```
        
        Где `id` — идентификатор ВМ.

- .NET {#dotnet}

    В корневой директории проекта запустите программу командой:

    ```bash
    yc iam key create \
      --output key.json \
      --service-account-name <имя_сервисного_аккаунта> && \
    AUTH_KEY=$(<key.json) && \
    rm key.json && \
    SSH_PUBLIC_KEY_PATH=~/key.pub \
    dotnet run
    ```

    Данная команда состоит из следующих частей:
    * `yc iam key create` — команда получения [авторизованного ключа](../../iam/concepts/authorization/key.md) в которой:
        * `--output` — путь к файлу для записи авторизованного ключа в формате JSON.
        * `--service-account-name` — имя сервисного аккаунта, для которого создается ключ.
    * `AUTH_KEY=$(<key.json)` — чтение файла с авторизованным ключом и размещение содержимого ключа в переменной `AUTH_KEY`.
    * `rm key.json` — удаление файла с авторизованным ключом. Вы можете пропустить эту часть команды, если планируете повторно использовать авторизованный ключ.
    * `SSH_PUBLIC_KEY_PATH=~/key.pub` — установка пути к файлу с публичным SSH-ключом в переменную окружения `SSH_PUBLIC_KEY_PATH`.
    * `dotnet run` — запуск скрипта.

    {% note info %}
    
    Перезагрузка системы или оболочки терминала приведет к утрате всех созданных переменных окружения.
    
    {% endnote %}
    
    После начала создания ВМ в терминале вы увидите следующий текст:
    
    ```text
    Running Yandex.Cloud operation. ID: fv4qfujd49fc********
    ```

    Где `ID` — идентификатор [операции](../../api-design-guide/concepts/about-async.md) создания ВМ.
    
    Отслеживать статус операции вы можете в консоли управления, а также с помощью Yandex Cloud CLI и API. Подробнее см. на странице [Посмотреть операции с ресурсами сервиса Compute Cloud](../../compute/operations/operation-logs.md).

{% endlist %}

Вы можете проверить, что ВМ была создана, в [консоли управления](https://console.yandex.cloud). У созданной ВМ должна быть [метка](../../resource-manager/concepts/labels.md) `yc-sdk:yes`.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы, [удалите](../../compute/operations/vm-control/vm-delete.md) ВМ из Compute Cloud.
 
# Примеры работы с SDK {#examples}

* [Node.js](https://github.com/yandex-cloud/nodejs-sdk/tree/master/examples)
* [Go](https://github.com/yandex-cloud/go-sdk/tree/master/examples)
* [Python](https://github.com/yandex-cloud/python-sdk/tree/master/examples)
* [Java](https://github.com/yandex-cloud/java-sdk/tree/master/java-sdk-examples)
* [.NET](https://github.com/yandex-cloud/dotnet-sdk/tree/master/Example)

## См. также {#see-also}

[Подключиться к виртуальной машине Linux по SSH](../../compute/operations/vm-connect/ssh.md)