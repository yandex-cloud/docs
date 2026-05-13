# Изменить виртуальную машину

После создания ВМ вы можете изменить ее имя, описание, метки, платформу или метаданные.

Как изменить конфигурацию ВМ, читайте в разделе [Изменить вычислительные ресурсы виртуальной машины](vm-update-resources.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы изменить ВМ:
  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, которому принадлежит ВМ.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Compute Cloud**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/server.svg) **Виртуальные машины** и нажмите на имя нужной ВМ.
  1. Нажмите кнопку ![image](../../../_assets/pencil.svg) **Изменить ВМ**.
  1. Измените параметры ВМ, например, переименуйте машину, отредактировав поле **Имя**.
  1. Нажмите **Сохранить изменения**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для обновления параметров ВМ:

     ```bash
     yc compute instance update --help
     ```

  1. Получите список ВМ в каталоге по умолчанию:

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

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужной машины, например `first-instance`.
  1. Измените параметры ВМ, например, переименуйте машину:

     ```bash
     yc compute instance update first-instance \
       --new-name windows-vm
     ```

- API {#api}

  Чтобы изменить ВМ, воспользуйтесь методом REST API [update](../../api-ref/Instance/update.md) для ресурса [Instance](../../api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/Update](../../api-ref/grpc/Instance/update.md).

{% endlist %}

{% note info %}

При изменении имени ВМ, имя хоста и, соответственно, FQDN не изменяются. Подробнее про генерацию имени FQDN читайте в разделе [Имя хоста и внутренний FQDN](../../concepts/network.md#hostname).

{% endnote %}

## Примеры {#examples}

### Просмотреть список изменяемых параметров {#viewing-a-list-of-configurable-parameters}

Чтобы просмотреть список изменяемых параметров, выполните команду:

{% list tabs group=instructions %}

- CLI {#cli}

  ```bash
  yc compute instance update --help
  ```

{% endlist %}

### Изменить имя и описание {#changing-the-name-and-description}

Чтобы изменить имя и описание ВМ, выполните следующие шаги:

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Получите список ВМ в каталоге по умолчанию:

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

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужной машины, например `first-instance`.
  1. Измените имя и описание ВМ:

     ```bash
     yc compute instance update first-instance \
       --new-name first-vm \
       --description "changed description vm via CLI"
     ```

- API {#api}

  Воспользуйтесь методом REST API [update](../../api-ref/Instance/update.md) для ресурса [Instance](../../api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/Update](../../api-ref/grpc/Instance/update.md).

{% endlist %}

{% note alert %}

Не изменяйте имя ВМ, если она принадлежит [группе узлов](../../../managed-kubernetes/concepts/index.md#node-group) кластера Managed Service for Kubernetes. Имя для такой ВМ генерируется автоматически, и его изменение нарушит работу кластера.

{% endnote %}

### Изменить метаданные {#changing-metadata}

При внесении изменений в метаданные ВМ с помощью команды Yandex Cloud CLI [`yc compute instance update`](../../../cli/cli-ref/compute/cli-ref/instance/update.md), метода REST API [update](../../api-ref/Instance/update.md) для ресурса [Instance](../../api-ref/Instance/index.md) или вызова gRPC API [InstanceService/Update](../../api-ref/grpc/Instance/update.md) весь имеющийся набор [метаданных](../../concepts/vm-metadata.md) в каталоге [user-data](../../concepts/metadata/directories.md#dir-user) и в пути `instance/attributes/*` каталога [computeMetadata](../../concepts/metadata/directories.md#dir-compute) полностью перезаписывается переданным обновленным набором.

Чтобы добавить, изменить или удалить отдельные ключи в пути `instance/attributes/*` каталога `computeMetadata` воспользуйтесь командами Yandex Cloud CLI [`yc compute instance add-metadata`](../../../cli/cli-ref/compute/cli-ref/instance/add-metadata.md) и [`yc compute instance remove-metadata`](../../../cli/cli-ref/compute/cli-ref/instance/remove-metadata.md), методом REST API [updateMetadata](../../api-ref/Instance/updateMetadata.md) для ресурса [Instance](../../api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/UpdateMetadata](../../api-ref/grpc/Instance/updateMetadata.md). При этом в каталоге `user-data` метаданные всегда полностью перезаписываются новым набором значений.

Чтобы изменить метаданные ВМ:

{% list tabs group=instructions %}

- Консоль управления {#console}

  {% note info %}

  При создании пользователей ВМ через метаданные с помощью ключа `user-data` все пользователи будут перезаписаны, в том числе пользователь по умолчанию, заданный в блоке **Доступ**. Чтобы этого избежать, передавайте в значении ключа `user-data` данные всех пользователей, в том числе и данные пользователя, заданного в блоке **Доступ**.

  {% endnote %}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, которому принадлежит ВМ.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Compute Cloud**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/server.svg) **Виртуальные машины**.
  1. В строке с нужной ВМ нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../_assets/console-icons/pencil.svg) **Редактировать**.
  1. В блоке **Метаданные** передайте метаданные в формате `Ключ:Значение`.

      Например, чтобы создать в ОС виртуальной машины нескольких пользователей, добавьте ключ `user-data` и в его значении укажите конфигурацию:

      ```yml
      #cloud-config
      datasource:
        Ec2:
          strict_id: false
      ssh_pwauth: no
      users:
      - name: <имя_пользователя_1>
        sudo: 'ALL=(ALL) NOPASSWD:ALL'
        shell: /bin/bash
        ssh_authorized_keys:
        - <публичный_SSH-ключ_1>
      - name: <имя_пользователя_2>
        sudo: 'ALL=(ALL) NOPASSWD:ALL'
        shell: /bin/bash
        ssh_authorized_keys:
        - <публичный_SSH-ключ_2>
      ...
      - name: <имя_пользователя_n>
        sudo: 'ALL=(ALL) NOPASSWD:ALL'
        shell: /bin/bash
        ssh_authorized_keys:
        - <публичный_SSH-ключ_n>
      runcmd: []
      ```

  1. Нажмите **Сохранить изменения**.

- CLI {#cli}

  {% note info %}

  При создании пользователей ВМ через метаданные с помощью ключа `user-data` все пользователи будут перезаписаны, в том числе пользователь по умолчанию, заданный в параметре `--ssh-key`. Чтобы этого избежать, передавайте в значении ключа `user-data` данные всех пользователей, в том числе и данные пользователя, заданного в параметре `--ssh-key`.

  {% endnote %}

  В [Yandex Cloud CLI](../../../glossary/cli.md) метаданные можно передать в любом из трех параметров:

  * `--metadata-from-file` — в виде файла конфигурации в формате `--metadata-from-file key=<путь_к_файлу>`. Этим способом удобно передавать значение, состоящее одновременно из нескольких строк.

      Например, чтобы добавить на ВМ одновременно нескольких пользователей, опишите конфигурацию в файле в формате [YAML](https://yaml.org/):

      ```yml
      #cloud-config
      datasource:
        Ec2:
          strict_id: false
      ssh_pwauth: no
      users:
      - name: <имя_пользователя_1>
        sudo: 'ALL=(ALL) NOPASSWD:ALL'
        shell: /bin/bash
        ssh_authorized_keys:
        - <публичный_SSH-ключ_1>
      - name: <имя_пользователя_2>
        sudo: 'ALL=(ALL) NOPASSWD:ALL'
        shell: /bin/bash
        ssh_authorized_keys:
        - <публичный_SSH-ключ_2>
      ...
      - name: <имя_пользователя_n>
        sudo: 'ALL=(ALL) NOPASSWD:ALL'
        shell: /bin/bash
        ssh_authorized_keys:
        - <публичный_SSH-ключ_n>
      runcmd: []
      ```

  * `--metadata` — в виде списка пар `ключ=значение`, разделенных запятой, например `--metadata foo1=bar,foo2=baz`.

      Если в значении несколько строк, используйте `\n` в качестве разделителя: `--metadata user-data="#ps1\nnet user Administrator Passw0rd"`.
  * `--ssh-key` — SSH-ключ. Только для ВМ Linux.

    Compute Cloud создаст пользователя `yc-user` и добавит указанный SSH-ключ в список авторизованных ключей. После создания ВМ вы сможете подключиться к ней по SSH с помощью этого ключа.

  Вы можете комбинировать эти параметры, например:

  ```bash
  yc compute instance update \
    --name my-instance \
    --metadata-from-file user-data=metadata.yaml \
    --metadata serial-port-enable=1
  ...
  ```

- Terraform {#tf}

  {% note info %}

  При создании пользователей ВМ через метаданные с помощью ключа `user-data` все пользователи будут перезаписаны, в том числе пользователь по умолчанию, заданный в параметре `ssh-keys`. Чтобы этого избежать, передавайте в значении ключа `user-data` данные всех пользователей, в том числе и данные пользователя, заданного в параметре `ssh-keys`.

  {% endnote %}

  В Terraform метаданные можно указать любым из трех способов:
  * В виде отдельного файла с пользовательскими метаданными, который будет обработан агентом cloud-init. Для этого в блоке `metadata` укажите путь к файлу с пользовательскими метаданными, например к `cloud-init.yaml`:

    ```hcl
    ...
    metadata = {
      user-data = "${file("cloud-init.yaml")}"
    }
    ...
    ```

    {% cut "Пример содержимого файла `cloud-init.yaml`" %}

    ```yml
    #cloud-config
    datasource:
      Ec2:
        strict_id: false
    ssh_pwauth: no
    users:
    - name: <имя_пользователя_1>
      sudo: 'ALL=(ALL) NOPASSWD:ALL'
      shell: /bin/bash
      ssh_authorized_keys:
      - <публичный_SSH-ключ_1>
    - name: <имя_пользователя_2>
      sudo: 'ALL=(ALL) NOPASSWD:ALL'
      shell: /bin/bash
      ssh_authorized_keys:
      - <публичный_SSH-ключ_2>
    ...
    - name: <имя_пользователя_n>
      sudo: 'ALL=(ALL) NOPASSWD:ALL'
      shell: /bin/bash
      ssh_authorized_keys:
      - <публичный_SSH-ключ_n>
    runcmd: []
    ```

    {% endcut %}

  * В блоке `metadata` в виде строки с пользовательскими метаданными. Если в значении несколько строк, используйте `\n` в качестве разделителя. Например:

    ```hcl
    ...
    metadata = {
      user-data = "#cloud-config\nusers:\n  - name: <имя_пользователя>\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh_authorized_keys:\n      - <содержимое_SSH-ключа>"
    }
    ...
    ```

  * Только для ВМ Linux. В блоке `ssh-keys` указывается имя пользователя и SSH-ключ для доступа на ВМ Linux. Укажите имя пользователя и содержимое SSH-ключа в виде:

    ```hcl
    ...
    metadata = {
      ssh-keys = "<имя_пользователя>:<содержимое_SSH-ключа>"
    }
    ...
    ```

    Если вы используете готовый публичный [образ](../../concepts/image.md) из Yandex Cloud Marketplace, указанное имя пользователя не играет роли. Ключ будет присвоен пользователю, который задан в конфигурации `cloud-init` по умолчанию. В разных образах это разные пользователи.

    Если вы не знаете, какой пользователь задан по умолчанию, найдите в [выводе последовательного порта](../vm-info/get-serial-port-output.md) строку, содержащую слова `Authorized keys from`. В ней будет указано имя пользователя, которому присвоены авторизованные ключи.

    Если такой строки не найдено, но есть строка `no authorized ssh keys fingerprints found for user`, значит вы неправильно передали SSH-ключ. Проверьте еще раз формат или попробуйте передать ключи SSH в поле `user-data`.

- API {#api}

  В API вы указываете метаданные в свойстве `metadata` в виде JSON-объекта, например так:

  ```json
  "metadata": {
    "ssh-keys": "ssh-ed25519 AAAAB3Nza... user@example.com",
    "serial-port-enable": "1"
  }
  ```

  Для переноса строки в значениях используйте символ `\n`.

{% endlist %}

{% note warning %}

Метаданные, в том числе пользовательские, доступны в незашифрованном виде. Если вы размещаете в метаданных конфиденциальную информацию, примите меры для ее защиты — например, зашифруйте.

{% endnote %}

### Удалить SSH-ключи из метаданных {#delete-keys-from-metadata}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, которому принадлежит ВМ.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Compute Cloud**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/server.svg) **Виртуальные машины**.
  1. В строке с нужной ВМ нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../_assets/console-icons/pencil.svg) **Редактировать**.
  1. Раскройте секцию **Метаданные** и удалите ключи, нажав ![image](../../../_assets/console-icons/xmark.svg).
  1. Нажмите **Сохранить изменения**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для удаления метаданных:

      ```bash
      yc compute instance remove-metadata --help
      ```

  1. Удалите ключи:

      ```bash
      yc compute instance remove-metadata <идентификатор_ВМ> --keys <имя_SSH-ключа>
      ```

- API {#api}

  Чтобы удалить SSH-ключи из метаданных ВМ, воспользуйтесь методом REST API [updateMetadata](../../api-ref/Instance/updateMetadata.md) для ресурса [Instance](../../api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/UpdateMetadata](../../api-ref/grpc/Instance/updateMetadata.md).

  В запросе передайте параметр `delete` с SSH-ключом.

  **Пример запроса для REST API**

  ```bash
  curl \
    --request POST \
    --header "Authorization: Bearer <IAM-токен>" \
    --data '{"delete":["<имя_SSH-ключа>"]}' \
    https://compute.api.cloud.yandex.net/compute/v1/instances/<идентификатор_ВМ>/updateMetadata
  ```

{% endlist %}

### Включить доступ по OS Login {#enable-oslogin-access}

Чтобы к ВМ можно было [подключиться](../vm-connect/os-login.md) по [OS Login](../../../organization/concepts/os-login.md), необходимо включить эту опцию в ее настройках:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, которому принадлежит ВМ.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Compute Cloud**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/server.svg) **Виртуальные машины**.
  1. В строке с нужной ВМ нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../_assets/console-icons/pencil.svg) **Редактировать**.
  1. В блоке **Доступ** выберите вариант **Доступ по OS Login**.
  1. Нажмите **Сохранить изменения**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для обновления параметров ВМ:

     ```bash
     yc compute instance update --help
     ```

  1. Получите список ВМ в каталоге по умолчанию:

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

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужной машины, например `first-instance`.

  1. Включите доступ по OS Login:

     ```bash
     yc compute instance update first-instance \
       --metadata enable-oslogin=true
     ```

- API {#api}

  Передайте в поле `metadata` пару `enable-oslogin=true` в методе REST API [update](../../api-ref/Instance/update.md) для ресурса [Instance](../../api-ref/Instance/index.md) или в вызове gRPC API [InstanceService/Update](../../api-ref/grpc/Instance/update.md).

{% endlist %}

{% note info %}

Для пользователей, добавленных через метаданные:

* после включения доступа к ВМ по OS Login из метаданных удаляются ключи, указанные в `user-data` и `ssh-keys`;
* после отключения доступа к ВМ по OS Login удаленные ключи пересоздаются.

{% endnote %}