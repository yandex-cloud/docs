# Метаданные виртуальной машины

Сведения о виртуальных машинах доступны в сервисе метаданных. Вы можете передавать любые ключи и значения в метаданных, а затем запрашивать метаданные [изнутри](../operations/vm-info/get-info.md#inside-instance) виртуальной машины или [снаружи](../operations/vm-info/get-info.md#outside-instance). Подробнее о настройке сервиса метаданных см. в разделе [{#T}](../operations/vm-info/get-info.md#metadata-options).

Метаданные также используются программами, которые запускаются при старте виртуальной машины.

## Формат метаданных, поддерживаемых изнутри ВМ {#metadata-formats}

Изнутри виртуальной машины метаданные доступны в следующих форматах:
* [Google Compute Engine](../operations/vm-info/get-info.md#gce-metadata) (поддерживаются не все поля).
* [Amazon EC2](../operations/vm-info/get-info.md#ec2-metadata) (поддерживаются не все поля).

## Как передать метаданные {#how-to-send-metadata}

Вы можете передать метаданные при создании и [изменении](../operations/vm-control/vm-update.md#change-metadata) виртуальной машины. Данные для подключения к виртуальной машине нельзя изменить и необходимо передать при создании:
* [Для виртуальной машины Linux](../operations/vm-create/create-linux-vm.md) необходимо передать открытый ключ SSH для подключения к ней.


{% list tabs %}

- CLI

  В CLI метаданные можно указать в любом из трех параметров:
  * `--metadata-from-file` в виде файла, например `--metadata-from-file key=path/to/file`. Таким образом удобно передать значение из нескольких строк.
  * `--metadata` — список пар `ключ=значение`, разделенных запятой, например `--metadata foo1=bar,foo2=baz`.

      Если в значении несколько строк, используйте `\n` в качестве разделителя: `--metadata user-data="#ps1\nnet user Administrator Passw0rd"`
  * `--ssh-key` — SSH-ключ. Только для виртуальных машин Linux.

      {{ compute-short-name }} создаст пользователя `yc-user` и добавит указанный SSH-ключ в список авторизованных ключей. После создания виртуальной машины вы сможете подключиться к ней по SSH с помощью этого ключа.

  Вы можете комбинировать эти параметры, например:

  ```bash
  yc compute instance create \
    --name my-instance \
    --metadata-from-file user-data=metadata.yaml \
    --metadata serial-port-enable=1
  ...
  ```

- {{ TF }}

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

      ```hcl
      #cloud-config
      users:
        - name: <имя_пользователя>
          groups: sudo
          shell: /bin/bash
          sudo: ['ALL=(ALL) NOPASSWD:ALL']
          ssh_authorized_keys:
            - <содержимое_SSH-ключа>
      ```

      {% endcut %}

  * В блоке `metadata` в виде строки с пользовательскими метаданными. Если в значении несколько строк, используйте `\n` в качестве разделителя. Например:

      ```hcl
      ...
      metadata = {
        user-data = "#cloud-config\nusers:\n  - name: <имя_пользователя>\n    groups: sudo\n    shell: /bin/bash\n    sudo: ['ALL=(ALL) NOPASSWD:ALL']\n    ssh-authorized-keys:\n      - <содержимое_SSH-ключа>")}"
      }
      ...
      ```

  * Только для виртуальных машин Linux. В блоке `ssh-keys` указывается имя пользователя и SSH-ключ для доступа на виртуальные машины Linux. Укажите имя пользователя и содержимое SSH-ключа в виде:

      ```hcl
      ...
      metadata = {
        ssh-keys = "<имя_пользователя>:<содержимое_SSH-ключа>"
      }
      ...
      ```

      Если вы используете готовый публичный образ из {{ marketplace-name }}, то указанное имя пользователя не играет роли. Ключ будет присвоен пользователю, который задан в конфигурации `cloud-init` по умолчанию. В разных образах это разные пользователи.


      Если вы не знаете, какой пользователь задан по умолчанию, найдите в [выводе последовательного порта](../operations/vm-info/get-serial-port-output.md) строку, содержащую слова `Authorized keys from`. В ней будет указано имя пользователя, которому присвоены авторизованные ключи.

      Если такой строки не найдено, но есть строка `no authorized ssh keys fingerprints found for user`, значит вы неправильно передали SSH-ключ. Проверьте еще раз формат или попробуйте передать ключи SSH в поле `user-data`.

- API

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

## Ключи, обрабатываемые в публичных образах {#keys-processed-in-public-images}

Список ключей, которые обрабатываются в публичных образах {{ yandex-cloud }}, зависит от операционной системы.

{% list tabs %}

- Linux

  * `serial-port-enable` — флаг, включающий доступ к серийной консоли. 1 — включить, 0 (по умолчанию) — выключить.
  * `user-data` — строка с пользовательскими метаданными, которые будут обработаны агентом [cloud-init](https://cloud-init.io), запущенным на виртуальной машине.

      Cloud-init поддерживает разные [форматы](https://cloudinit.readthedocs.io/en/latest/topics/format.html) передачи метаданных, например [cloud-config](https://cloudinit.readthedocs.io/en/latest/topics/examples.html). В этом формате вы можете передать SSH-ключи и указать, какому пользователю принадлежит каждый ключ. Для этого укажите их в элементе `users/ssh_authorized_keys`:

      {% include [user-data](../../_includes/compute/user-data.md) %}

      Чтобы передать эти данные в запросе, замените переносы строки символом `\n`:

      ```json
      "metadata": {
        "user-data": "#cloud-config\nusers:\n  - name: user\n    groups: sudo\n    shell: /bin/bash\n    sudo: ['ALL=(ALL) NOPASSWD:ALL']\n    ssh-authorized-keys:\n      - ssh-ed25519 AAAAB3Nza......OjbSMRX user@example.com\n      - ssh-ed25519 AAAAB3Nza......Pu00jRN user@desktop"
      }
      ```

  * `ssh-keys` — ключ для доставки SSH-ключа на виртуальные машины Linux через {{ TF }}. Указывается в формате `<имя_пользователя>:<содержимое_SSH-ключа>`, например `user:ssh-ed25519 AAC4NzaC1 user@example.com`. Если указать несколько ключей, будет использован только первый из них.

- Windows

  `user-data` — строка с пользовательскими метаданными, которые будут обработаны агентом [Cloudbase-Init](https://cloudbase.it/cloudbase-init/). Этот агент поддерживает различные [форматы данных](https://cloudbase-init.readthedocs.io/en/latest/userdata.html), например PowerShell-скрипт, задающий пароль администратора:

  ```json
  "metadata": {
    "user-data": "#ps1\nnet user Administrator Passw0rd"
  }
  ```

{% endlist %}