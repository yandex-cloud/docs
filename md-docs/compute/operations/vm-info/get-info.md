# Получить информацию о виртуальной машине


Вы можете получить основную информацию о каждой созданной вами [виртуальной машине](../../concepts/vm.md) на странице ВМ в [консоли управления](https://console.yandex.cloud). Чтобы получить детальную информацию вместе с пользовательскими [метаданными](../../concepts/vm-metadata.md), воспользуйтесь [CLI](../../../cli/cli-ref/compute/cli-ref/instance/get.md) или [API](../../api-ref/Instance/get.md).

Также основную информацию и метаданные можно получить [изнутри ВМ](#inside-instance).

## Получить информацию снаружи ВМ {#outside-instance}

Этот способ предоставляет доступ ко [всем каталогам](../../concepts/metadata/directories.md) метаданных и некоторым ключам в них: 

* [каталог computeMetadata](../../concepts/metadata/directories.md#dir-compute) — для чтения доступны только ключи в `/instance/attributes/*`.
* [каталог user-data](../../concepts/metadata/directories.md#dir-user) доступен для чтения полностью.

{% list tabs group=instructions %}

- Консоль управления {#console}

  В сервисе **Compute Cloud**, на странице **Виртуальные машины**, приводится список ВМ в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) с краткой информацией о них.

  Для получения подробной информации о ВМ нажмите на строку с ее именем.

  На вкладке:
  * **Обзор** приводится общая информация о ВМ, в том числе [IP-адреса](../../../vpc/concepts/address.md), присвоенные ВМ.
  * **Диски и хранилища** приводится информация о [дисках](../../concepts/disk.md) и [файловых хранилищах](../../concepts/filesystem.md), подключенных к ВМ.
  * **Резервные копии** приводится информация о [резервных копиях](../../../backup/concepts/index.md) ВМ.
  * **Права доступа** приводится информация о [правах доступа](../../../iam/concepts/access-control/index.md) к ВМ.
  * **Операции** приводится список операций с ВМ и подключенными к ней ресурсами, например дисками.
  * **Мониторинг** приводится информация о потреблении ресурсов на ВМ. Эту информацию можно получить только в консоли управления или изнутри ВМ.
  * **Серийная консоль** предоставлен доступ к [серийной консоли](../../concepts/serial-console.md), если при [создании](../index.md#vm-create) ВМ вы разрешили к ней доступ.
  * **Последовательный порт** приводится информация, которую ВМ выводит в последовательный порт. Чтобы получить эту информацию через API или CLI, воспользуйтесь инструкцией [Получить вывод последовательного порта](get-serial-port-output.md).

- CLI {#cli}

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды для получения информации о ВМ:

     ```bash
     yc compute instance get --help
     ```

  1. Выберите ВМ, например `first-instance`:

     ```bash
     yc compute instance list
     ```
     
     Результат:
     ```text
     +----------------------+-----------------+---------------+---------+----------------------+
     |          ID          |       NAME      |    ZONE ID    | STATUS  |     DESCRIPTION      |
     +----------------------+-----------------+---------------+---------+----------------------+
     | fhm0b28lgfp4******** | first-instance  | ru-central1-a | RUNNING | my first vm via CLI  |
     | fhm9gk85nj7g******** | second-instance | ru-central1-a | RUNNING | my second vm via CLI |
     +----------------------+-----------------+---------------+---------+----------------------+
     ```

  1. Получите основную информацию о ВМ:

     ```bash
     yc compute instance get first-instance
     ```

     Чтобы получить информацию о ВМ вместе с метаданными, используйте флаг `--full`:

     ```bash
     yc compute instance get --full first-instance
     ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. Опишите в конфигурационном файле Terraform параметры ресурсов, которые необходимо создать:

     ```hcl
     data "yandex_compute_instance" "my_instance" {
       instance_id = "<идентификатор_ВМ>"
     }

     output "instance_external_ip" {
       value = "${data.yandex_compute_instance.my_instance.network_interface.0.nat_ip_address}"
     }
     ```

     Где:
     * `data "yandex_compute_instance"` — описание источника данных для получения информации о ВМ:
       * `instance_id` — идентификатор ВМ.
     * `output "instance_external_ip"` — [публичный IP-адрес](../../../vpc/concepts/address.md#public-addresses) ВМ, который будет выводиться в результате:
       * `value` — возвращаемое значение.

     Более подробную информацию о параметрах источника данных `yandex_compute_instance` см. в [документации провайдера](../../../terraform/data-sources/compute_instance.md).
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

     Terraform создаст все требуемые ресурсы и отобразит значения выходных переменных в терминале. Чтобы проверить результат, выполните команду:

     ```bash
     terraform output instance_external_ip
     ```

     Результат:

     ```text
     instance_external_ip = "158.160.50.228"
     ```

- API {#api}

  Чтобы получить основную информацию о ВМ, воспользуйтесь методом REST API [get](../../api-ref/Instance/get.md) для ресурса [Instance](../../api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/Get](../../api-ref/grpc/Instance/get.md).

  Основная информация не включает пользовательские метаданные, которые были переданы при создании или [изменении](../vm-control/vm-update.md) ВМ. Чтобы получить информацию вместе с метаданными, укажите в параметрах `view=FULL`.

{% endlist %}

## Получить информацию изнутри ВМ {#inside-instance}

Изнутри ВМ можно получить прямой доступ к метаданным ВМ. Этот способ предоставляет доступ ко [всем каталогам](../../concepts/metadata/directories.md) метаданных и всем ключам в них.

Получить прямой доступ (без аутентификации) к метаданным изнутри ВМ можно через специальный сервис метаданных. Сервис метаданных внутри ВМ доступен по URL `http://169.254.169.254`.

Все аутентифицированные пользователи ВМ могут получить доступ к сервису метаданных без ограничений. Ограничить доступ отдельного пользователя ВМ к метаданным нельзя.

Проверить работу сервиса метаданных можно с помощью утилиты [cURL](https://curl.haxx.se), предварительно [подключившись](../vm-connect/ssh.md) к ВМ по протоколу ssh:

```bash
curl \
  --header Metadata-Flavor:Google \
  169.254.169.254
```

В ответ сервис метаданных выдаст список доступных версий метаданных, например:

```bash
1.0
2007-01-19
2007-03-01
...
2023-02-15
2023-05-10
latest
```

Рекомендуется всегда использовать последнюю (`latest`) версию метаданных.

### HTTP-запрос {#gce-http}

```http request
GET http://169.254.169.254/computeMetadata/v1/instance/
  ? alt=<json|text>
  & recursive=<true|false>
  & wait_for_change=<true|false>
  & last_etag=<string>
  & timeout_sec=<int>
Metadata-Flavor: Google
```

Где:
* `alt` — формат ответа (по умолчанию `text`).
* `recursive` — если `true`, возвращает все значения по дереву рекурсивно. По умолчанию `false`.
* `wait_for_change` — если `true`, ответ будет возвращен только когда один из параметров метаданных изменится. По умолчанию `false`.
* `last_etag` — значение ETag из предыдущего ответа на аналогичный запрос. Используйте при `wait_for_change="true"`.
* `timeout_sec` — максимальное время ожидания запроса. Используйте при `wait_for_change="true"`.

В ответ сервис вернет актуальные значения [ключей](../../concepts/metadata/directories.md#dir-compute) метаданных каталога `computeMetadata`.

### Примеры запросов {#request-examples}

#### Получение FQDN {#example1}

Чтобы получить полное имя ВМ ([FQDN](../../concepts/network.md#hostname)) из каталога [computeMetadata](../../concepts/metadata/directories.md#dir-compute), [подключитесь](../vm-connect/ssh.md) к ВМ и выполните запрос:

```bash
curl \
  --header Metadata-Flavor:Google \
  169.254.169.254/computeMetadata/v1/instance/hostname
```

#### Получение метаданных ВМ в удобном для чтения формате {#example2}

Чтобы получить метаданные в удобном для чтения формате, [подключитесь](../vm-connect/ssh.md) к ВМ и выполните запрос, воспользовавшись утилитой [jq](https://stedolan.github.io/jq/):

```bash
  curl \
    --header Metadata-Flavor:Google \
    169.254.169.254/computeMetadata/v1/instance/?recursive=true | \
    jq -r '.'
```

#### Получение идентификационного документа {#example3}

Чтобы получить [идентификационный документ](../../concepts/metadata/identity-document.md) из каталога [computeMetadata](../../concepts/metadata/directories.md#dir-compute), [подключитесь](../vm-connect/ssh.md) к ВМ и выполните запрос:

```bash
curl \
  --header Metadata-Flavor:Google \
  169.254.169.254/computeMetadata/v1/instance/vendor/identity/document
```

#### Получение данных из каталога user-data {#example4}

Чтобы получить метаданные из каталога [user-data](../../concepts/metadata/directories.md#dir-user), [подключитесь](../vm-connect/ssh.md) к ВМ и выполните запрос:

```bash
curl \
  --header Metadata-Flavor:Google \
  169.254.169.254/latest/user-data
```

В ответ сервис метаданных вернет результат в формате YAML:

```yaml
#cloud-config
datasource:
 Ec2:
  strict_id: false
ssh_pwauth: no
users:
- name: admin
  sudo: ALL=(ALL) NOPASSWD:ALL
  shell: /bin/bash
  ssh_authorized_keys:
  - ssh-ed25519 AAAAC3Nza******l0pTWGO
```

Чтобы получить в выводе только значение определенного ключа (например, имени пользователя), воспользуйтесь инструментом [yq](https://github.com/mikefarah/yq).

```bash
curl \
  --silent \
  --fail \
  --header Metadata-Flavor:Google \
  169.254.169.254/latest/user-data | \
  yq .users[].name
```

#### Получение IAM-токена сервисного аккаунта {#example5}

При выполнении запросов к [API Yandex Cloud](../../../api-design-guide/index.md) необходим [IAM-токен](../../../iam/concepts/authorization/iam-token.md), выданный [сервисному аккаунту](../../../iam/concepts/users/service-accounts.md). Такой IAM-токен может быть получен через сервис метаданных изнутри ВМ. Для этого к виртуальной машине должен быть [привязан](../vm-connect/auth-inside-vm.md#link-sa-with-instance) сервисный аккаунт.

Чтобы получить IAM-токен из каталога [computeMetadata](../../concepts/metadata/directories.md#dir-compute), [подключитесь](../vm-connect/ssh.md) к ВМ и выполните запрос:

```bash
curl \
  --silent \
  --fail \
  --header Metadata-Flavor:Google \
  169.254.169.254/computeMetadata/v1/instance/service-accounts/default/token | \
  jq -r .access_token
```

#### Получение данных из каталога user-data снаружи ВМ {#example6}

Чтобы получить метаданные снаружи ВМ, воспользуйтесь инструментом [Yandex Cloud CLI](../../../cli/cli-ref/compute/cli-ref/instance/get.md):

```bash
yc compute instance get my-vm --full --jq .metadata
```

В ответ сервис метаданных вернет результат в формате JSON:

```json
{
  "install-unified-agent": "0",
  "serial-port-enable": "0",
  "ssh-keys": "admin:ssh-ed25519 AAAAC3N******l0pTWGO admin@my.domain\n",
  "user-data": "#cloud-config\ndatasource:\n Ec2:\n  strict_id: false\nssh_pwauth: no\nusers:\n- name: admin\n  sudo: ALL=(ALL) NOPASSWD:ALL\n  shell: /bin/bash\n  ssh_authorized_keys:\n  - ssh-ed25519 AAAAC3N******l0pTWGO"
}
```

Информацию о способах получить переданные через метаданные значения переменных и [секретов Yandex Lockbox](../../../lockbox/concepts/secret.md) см. в инструкциях [Создать виртуальную машину с метаданными из переменных окружения](../vm-create/create-with-env-variables.md) и [Создать ВМ с доступом к секрету Yandex Lockbox](../vm-create/create-with-lockbox-secret.md).