# Развертывание Active Directory

В сценарии приводится пример установки Active Directory в Яндекс.Облаке с помощью Terraform. Состояния Terraform будут храниться в Object Storage.

После установки Active Directory нужно настроить. Подробнее о конфигурации AD читайте [на официальном сайте](https://docs.microsoft.com/en-us/windows-server/identity/ad-ds/active-directory-domain-services).

Чтобы развернуть инфраструктуру Active Directory:

1. [Создайте сервисный аккаунт, ключи доступа и авторизованные ключи](#create-service-account)
1. [Подготовьте конфигурации Terraform и Active Directory](#prepare-tf-and-ad)
1. [Инициализируйте Terraform](#terraform-init)
1. [Задайте переменные Terraform](#tfvars)
1. [Разверните инфраструктуру](#terraform-plan)

## Подготовка к работе {#prepare}

1. Установите [интерфейс командной строки](../../cli/quickstart.md#install) Яндекс.Облака.
1. [Создайте](../../storage/operations/buckets/create.md) бакет Object Storage.

## 1. Создайте сервисный аккаунт и ключи {#create-service-account}

Для работы с Object Storage и создания ресурсов в облаке нужно создать сервисный аккаунт, ключи доступа и авторизованные ключи.

1. Создайте сервисный аккаунт:

   ```
   $ yc iam service-account create --name ad-sa
   ```

1. Создайте ключи доступа:
   
   ```
   $ yc iam access-key create --service-account-name ad-sa
   ```
   
   Сохраните значения полей `key_id` и `secret_key`, они будут использоваться для доступа Terraform к Object Storage.

1. Создайте авторизованные ключи и сохраните их в файл:

   ```
   $ yc iam key create --service-account-name ad-sa -o ad-sa.json
   ```

   После этого будет создан файл `ad-sa.json`, путь к которому нужно указать в конфигурации Terraform.

1. Получите список сервисных аккаунтов и их идентификаторов командой `yc iam service-account list`. Назначьте сервисному аккаунту `ad-sa` роль `editor` в каталоге, где будут выполняться операции:

   ```
   $ yc resource-manager folder add-access-binding <имя_каталога> \ 
     --role editor \
     --subject serviceAccount:<идентификатор сервисного аккаунта>
   ```

## 2. Подготовьте конфигурации Terraform и Active Directory {#prepare-tf-and-ad}

Склонируйте [репозиторий](https://github.com/yandex-cloud/examples) c примерами. 

Проект содержит следующие файлы:

* **Terraform**:
   * `main.tf` — конфигурация инфраструктуры.
   * `variables.tf` — описание переменных для конфигурации инфраструктуры. 
* **PowerShell**:
   * `bootstrap.ps1` — PowerShell-скрипт, который выполняется программой cloudbase-init до загрузки операционной системы. Скрипт создает пользователя и задание в планировщике задач Windows. По заданию запустится произвольный PowerShell скрипт в атрибуте `deploy`, который будет задан в [метаданных виртуальной машины](../../compute/concepts/vm-metadata.md).
   * `deploy-forestroot.ps1` — скрипт установки первого контроллера домена.
   * `deploy-domaincontroller.ps1` — скрипт установки контроллера домена.

## 3. Инициализируйте Terraform {#terraform-init}

Перейдите в директорию с проектом и выполните следующую команду:

```
$ terraform init \
  -backend-config="endpoint=storage.yandexcloud.net" \
  -backend-config="region=us-east-1" \
  -backend-config="bucket=<имя бакета>" \
  -backend-config="key=ad-sa.json" \
  -backend-config="access_key=<идентификатор ключа доступа — key_id>" \
  -backend-config="secret_key=<секретный ключ — secret_key>" \
  -backend-config="skip_region_validation=true" \
  -backend-config="skip_credentials_validation=true"
```

## 4. Задайте переменные Terraform {#tfvars}

Создайте файл `terraform.tfvars` и приведите его к следующему виду:

```
service_account_key_file = "<путь к файлу с авторизованным ключом>"
cloud_id                 = "<идентификатор облака>"
folder_id                = "<идентификатор каталога>"

##########
# vpc
##########

vpc_name         = "ad-demo"
subnet_cidr      = "10.0.0.0/16"
zone_names       = ["ru-central1-a", "ru-central1-b", "ru-central1-c"]
zone_short_names = ["rc1a", "rc1b", "rc1c"]

##########
# instance
##########

name      = "ad"
number    = 9
user      = "<имя пользователя Active Directory>"
pass      = "<пароль пользователя Active Directory>"
user_data = "powershell/bootstrap.ps1"

ad_smadminpass = "P@ssw0rd!1"
ad_domainname  = "mydomain.local"
ad_deploy_root = "powershell/deploy-forestroot.ps1"
ad_deploy_dc   = "powershell/deploy-domaincontroller.ps1"
```

Зоны доступности, в которых будут созданы виртуальные машины, определяются в строке `zone_names`, а их короткие имена — в строке `zone_short_names`. Если нужно создать ВМ только в двух зонах, то приведите эти строки к следующему виду:

```
zone_names       = ["ru-central1-a", "ru-central1-b"]
zone_short_names = ["rc1a", "rc1b"]
```

## 4. Разверните инфраструктуру {#terraform-plan}

Выполните команду:

```
$ terraform plan
```

Если конфигурация и переменные заданы верно, Terraform отобразит список создаваемых ресурсов.

> [!WARNING]
>
> Все созданные с помощью Terraform ресурсы тарифицируются, внимательно проверьте план.
>

Если конфигурация верна, выполните команду:

```
$ terraform apply
```

Введите `yes` в терминал, чтобы подтвердить создание инфраструктуры. 

Развертывание может занимать продолжительное время. Следить за процессом установки Active Directory можно в выводе последовательного порта:

```
$ yc compute instance get-serial-port-output <имя виртуальной машины>
```