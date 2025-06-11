При внесении изменений в метаданные ВМ с помощью команды {{ yandex-cloud }} CLI [`yc compute instance update`](../../../cli/cli-ref/compute/cli-ref/instance/update.md), метода REST API [update](../../../compute/api-ref/Instance/update.md) для ресурса [Instance](../../../compute/api-ref/Instance/index.md) или вызова gRPC API [InstanceService/Update](../../../compute/api-ref/grpc/Instance/update.md) весь имеющийся набор [метаданных](../../../compute/concepts/vm-metadata.md) в каталоге [user-data](../../../compute/concepts/metadata/directories.md#dir-user) и в пути `instance/attributes/*` каталога [computeMetadata](../../../compute/concepts/metadata/directories.md#dir-compute) полностью перезаписывается переданным обновленным набором.

Чтобы добавить, изменить или удалить отдельные ключи в пути `instance/attributes/*` каталога `computeMetadata` воспользуйтесь командами {{ yandex-cloud }} CLI [`yc compute instance add-metadata`](../../../cli/cli-ref/compute/cli-ref/instance/add-metadata.md) и [`yc compute instance remove-metadata`](../../../cli/cli-ref/compute/cli-ref/instance/remove-metadata.md), методом REST API [updateMetadata](../../../compute/api-ref/Instance/updateMetadata.md) для ресурса [Instance](../../../compute/api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/UpdateMetadata](../../../compute/api-ref/grpc/Instance/updateMetadata.md). При этом в каталоге `user-data` метаданные всегда полностью перезаписываются новым набором значений.

Чтобы изменить метаданные ВМ:

{% list tabs group=instructions %}

- Консоль управления {#console}

  {% note info %}

  При создании пользователей ВМ через метаданные с помощью ключа `user-data` все пользователи будут перезаписаны, в том числе пользователь по умолчанию, заданный в блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}**. Чтобы этого избежать, передавайте в значении ключа `user-data` данные всех пользователей, в том числе и данные пользователя, заданного в блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}**.

  {% endnote %}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит ВМ.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}**.
  1. В строке с нужной ВМ нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. В блоке **{{ ui-key.yacloud.common.metadata }}** передайте метаданные в формате `Ключ:Значение`.

      Например, чтобы создать в ОС виртуальной машины нескольких пользователей, добавьте ключ `user-data` и в его значении укажите конфигурацию:

      {% include [users-from-metadata-example](../users-from-metadata-example.md) %}

  1. Нажмите **{{ ui-key.yacloud.compute.instance.edit.button_update }}**.

- CLI {#cli}

  {% note info %}

  При создании пользователей ВМ через метаданные с помощью ключа `user-data` все пользователи будут перезаписаны, в том числе пользователь по умолчанию, заданный в параметре `--ssh-key`. Чтобы этого избежать, передавайте в значении ключа `user-data` данные всех пользователей, в том числе и данные пользователя, заданного в параметре `--ssh-key`.

  {% endnote %}

  В [{{ yandex-cloud }} CLI](../../../glossary/cli.md) метаданные можно передать в любом из трех параметров:

  * `--metadata-from-file` — в виде файла конфигурации в формате `--metadata-from-file key=<путь_к_файлу>`. Этим способом удобно передавать значение, состоящее одновременно из нескольких строк.

      Например, чтобы добавить на ВМ одновременно нескольких пользователей, опишите конфигурацию в файле в формате [YAML](https://yaml.org/):

      {% include [users-from-metadata-example](../users-from-metadata-example.md) %}

  * `--metadata` — в виде списка пар `ключ=значение`, разделенных запятой, например `--metadata foo1=bar,foo2=baz`.

      Если в значении несколько строк, используйте `\n` в качестве разделителя: `--metadata user-data="#ps1\nnet user Administrator Passw0rd"`.
  * `--ssh-key` — SSH-ключ. Только для ВМ Linux.

    {{ compute-name }} создаст пользователя `yc-user` и добавит указанный SSH-ключ в список авторизованных ключей. После создания ВМ вы сможете подключиться к ней по SSH с помощью этого ключа.

  Вы можете комбинировать эти параметры, например:

  ```bash
  yc compute instance update \
    --name my-instance \
    --metadata-from-file user-data=metadata.yaml \
    --metadata serial-port-enable=1
  ...
  ```

- {{ TF }} {#tf}

  {% note info %}

  При создании пользователей ВМ через метаданные с помощью ключа `user-data` все пользователи будут перезаписаны, в том числе пользователь по умолчанию, заданный в параметре `ssh-keys`. Чтобы этого избежать, передавайте в значении ключа `user-data` данные всех пользователей, в том числе и данные пользователя, заданного в параметре `ssh-keys`.

  {% endnote %}

  В {{ TF }} метаданные можно указать любым из трех способов:
  * В виде отдельного файла с пользовательскими метаданными, который будет обработан агентом cloud-init. Для этого в блоке `metadata` укажите путь к файлу с пользовательскими метаданными, например к `cloud-init.yaml`:

    ```hcl
    ...
    metadata = {
      user-data = "${file("cloud-init.yaml")}"
    }
    ...
    ```

    {% cut "Пример содержимого файла `cloud-init.yaml`" %}

    {% include [users-from-metadata-example](../users-from-metadata-example.md) %}

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

    Если вы используете готовый публичный [образ](../../../compute/concepts/image.md) из {{ marketplace-full-name }}, указанное имя пользователя не играет роли. Ключ будет присвоен пользователю, который задан в конфигурации `cloud-init` по умолчанию. В разных образах это разные пользователи.

    Если вы не знаете, какой пользователь задан по умолчанию, найдите в [выводе последовательного порта](../../../compute/operations/vm-info/get-serial-port-output.md) строку, содержащую слова `Authorized keys from`. В ней будет указано имя пользователя, которому присвоены авторизованные ключи.

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