# Метаданные виртуальной машины

Сведения о [ВМ](vm.md) доступны в сервисе метаданных. Вы можете передавать любые ключи и значения в метаданных, а затем запрашивать метаданные [изнутри](../operations/vm-info/get-info.md#inside-instance) ВМ или [снаружи](../operations/vm-info/get-info.md#outside-instance). Подробнее о настройке сервиса метаданных см. в разделе [{#T}](../operations/vm-info/get-info.md#metadata-options).

Метаданные также используются программами, которые запускаются при старте ВМ.

## Формат метаданных, поддерживаемых изнутри ВМ {#metadata-formats}

Изнутри ВМ метаданные доступны в следующих форматах:
* [Google Compute Engine](../operations/vm-info/get-info.md#gce-metadata) (поддерживаются не все поля).
* [Amazon EC2](../operations/vm-info/get-info.md#ec2-metadata) (поддерживаются не все поля).

## Как передать метаданные {#how-to-send-metadata}

Вы можете передать метаданные при создании и [изменении](../operations/vm-control/vm-update.md#change-metadata) ВМ. Данные для подключения к ВМ можно передать только при создании, причем в [ВМ с ОС Linux](../operations/vm-create/create-linux-vm.md) для каждого пользователя необходимо также передавать открытый [SSH-ключ](../../glossary/ssh-keygen.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  Метаданные передаются в блоке **{{ ui-key.yacloud.common.metadata }}** в формате `Ключ:Значение`.
  
  Например, чтобы создать в ОС виртуальной машины нескольких пользователей, добавьте ключ `user-data` и в его значении укажите конфигурацию:

  {% include [users-from-metadata-example](../../_includes/compute/users-from-metadata-example.md) %}

  При создании пользователей через метаданные указывайте в ключе `user-data` данные всех пользователей, в том числе и данные пользователя, заданного в блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}**.

- CLI {#cli}

  В [CLI](../../glossary/cli.md) метаданные можно передать в любом из трех параметров:

  * `--metadata-from-file` — в виде файла конфигурации в формате `--metadata-from-file key=<путь_к_файлу>`. Этим способом удобно передавать значение, состоящее одновременно из нескольких строк.

      Например, чтобы добавить на ВМ одновременно нескольких пользователей, опишите конфигурацию в файле в формате `YAML`:

      {% include [users-from-metadata-example](../../_includes/compute/users-from-metadata-example.md) %}

  * `--metadata` — в виде списка пар `ключ=значение`, разделенных запятой, например `--metadata foo1=bar,foo2=baz`.

      Если в значении несколько строк, используйте `\n` в качестве разделителя: `--metadata user-data="#ps1\nnet user Administrator Passw0rd"`.
  * `--ssh-key` — SSH-ключ. Только для ВМ Linux.

    {{ compute-name }} создаст пользователя `yc-user` и добавит указанный SSH-ключ в список авторизованных ключей. После создания ВМ вы сможете подключиться к ней по SSH с помощью этого ключа.

  Вы можете комбинировать эти параметры, например:

  ```bash
  yc compute instance create \
    --name my-instance \
    --metadata-from-file user-data=metadata.yaml \
    --metadata serial-port-enable=1
  ...
  ```

- {{ TF }} {#tf}

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

    {% include [users-from-metadata-example](../../_includes/compute/users-from-metadata-example.md) %}

    {% endcut %}

  * В блоке `metadata` в виде строки с пользовательскими метаданными. Если в значении несколько строк, используйте `\n` в качестве разделителя. Например:

    ```hcl
    ...
    metadata = {
      user-data = "#cloud-config\nusers:\n  - name: <имя_пользователя>\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh-authorized-keys:\n      - <содержимое_SSH-ключа>"
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

    Если вы используете готовый публичный [образ](../concepts/image.md) из {{ marketplace-full-name }}, указанное имя пользователя не играет роли. Ключ будет присвоен пользователю, который задан в конфигурации `cloud-init` по умолчанию. В разных образах это разные пользователи.

    Если вы не знаете, какой пользователь задан по умолчанию, найдите в [выводе последовательного порта](../operations/vm-info/get-serial-port-output.md) строку, содержащую слова `Authorized keys from`. В ней будет указано имя пользователя, которому присвоены авторизованные ключи.

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

## Ключи, обрабатываемые в публичных образах {#keys-processed-in-public-images}

Список ключей, которые обрабатываются в публичных образах {{ yandex-cloud }}, зависит от операционной системы.

{% list tabs group=operating_system %}

- Linux {#linux}

  * `serial-port-enable` — флаг, включающий доступ к [серийной консоли](../operations/serial-console/index.md). `1` — включить, `0` (по умолчанию) — выключить.
  * `user-data` — строка с пользовательскими метаданными, которые будут обработаны агентом [cloud-init](https://cloud-init.io), запущенным на ВМ.
  * `enable-oslogin` — флаг, включающий доступ через [OS Login](../operations/vm-connect/os-login.md). `true` — включить, `false` (по умолчанию) — выключить.

    Cloud-init поддерживает разные [форматы](https://cloudinit.readthedocs.io/en/latest/topics/format.html) передачи метаданных, например [cloud-config](https://cloudinit.readthedocs.io/en/latest/topics/examples.html). В этом формате вы можете передать SSH-ключи и указать, какому пользователю принадлежит каждый ключ. Для этого укажите их в элементе `users/ssh-authorized-keys`:

    {% include [user-data](../../_includes/compute/user-data.md) %}

    Чтобы передать эти данные в запросе, замените переносы строки символом `\n`:

    ```json
    "metadata": {
      "user-data": "#cloud-config\nusers:\n  - name: user\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh-authorized-keys:\n      - ssh-ed25519 AAAAB3Nza......OjbSMRX user@example.com\n      - ssh-ed25519 AAAAB3Nza...Pu00jRN user@desktop"
    }
    ```

  * `ssh-keys` — ключ для доставки SSH-ключа на ВМ Linux через {{ TF }}. Указывается в формате `<имя_пользователя>:<содержимое_SSH-ключа>`, например `user:ssh-ed25519 AAC4NzaC1... user@example.com`. Если указать несколько ключей, будет использован только первый из них.

- Windows {#windows}

  `user-data` — строка с пользовательскими метаданными, которые будут обработаны агентом [Cloudbase-Init](https://cloudbase.it/cloudbase-init/). Этот агент поддерживает различные [форматы данных](https://cloudbase-init.readthedocs.io/en/latest/userdata.html), например PowerShell-скрипт, задающий пароль администратора:

  ```json
  "metadata": {
    "user-data": "#ps1\nnet user Administrator Passw0rd"
  }
  ```

{% endlist %}

## Идентификационный документ {#identity-document}

При создании ВМ формируется идентификационный документ (identity document), в котором хранятся сведения о самой ВМ: идентификаторы ВМ, продукта Marketplace, образа диска и т.д. Виртуальные машины могут запрашивать у сервиса метаданных информацию о самих себе.

Чтобы запросить идентификационный документ:

1. Подключитесь к ВМ:

   ```bash
   ssh <IP-адрес_ВМ>
   ```

1. Идентификационный документ можно получить в форматах [Google Compute Engine](../operations/vm-info/get-info.md#gce-metadata) и [Amazon EC2](../operations/vm-info/get-info.md#ec2-metadata). Выполните команду:
   
   {% list tabs %}
   
   - GCE

     ```bash
     curl -H Metadata-Flavor:Google 169.254.169.254/computeMetadata/v1/instance/vendor/identity/document
     ```

   - EC2

     ```bash
     curl http://169.254.169.254/latest/vendor/instance-identity/document
     ```
     
   {% endlist %}   

   Пример ответа: 
   
   ```
   {"instanceId":"fhmm5252k8vl********","productCodes":null,"imageId":"fd8evlqsgg4e********","productIds":["f2e3ia802lab********"],"createdAt":"2023-05-29T09:46:59Z","version":"2023-03-01"}
   ```

{% note info %}

Если ВМ была создана до 09.06.2023 и вы не можете получить идентификационный документ, остановите и снова запустите ВМ. 

{% endnote %}

### Подписанные идентификационные документы {#signed-identity-documents}

Если вы намерены использовать содержимое идентификационного документа для задач, имеющих большое значение, вам следует проверить содержимое и подлинность документа перед использованием.

Сервис метаданных виртуальной машины кроме самого идентификационного документа предоставляет его криптографические подписи. Вы можете использовать эти подписи для проверки происхождения, подлинности и целостности документа.

{% list tabs %}

- RSA

  1. Подключитесь к ВМ:

     ```bash
     ssh <IP-адрес_ВМ>
     ```

  1. Получите RSA-подпись из метаданных ВМ и сохраните ее в файл `rsa2048`: 
     
     * **GCE**:

       ```bash
       curl -H Metadata-Flavor:Google 169.254.169.254/computeMetadata/v1/instance/vendor/identity/rsa > rsa2048
       ```

     * **EC2**:

       ```bash
       curl http://169.254.169.254/latest/vendor/instance-identity/rsa > rsa2048
       ```
  
  1. Создайте файл `certificate` и добавьте в него публичный сертификат:

     

     ```
     -----BEGIN CERTIFICATE-----
     MIIC4TCCAcmgAwIBAgIUP0zcGO1MeRwze8VdSMEt/OdBXoIwDQYJKoZIhvcNAQEL
     BQAwADAeFw0yMzA2MDcwNjU4MTBaFw0zMzA2MDQwNjU4MTBaMAAwggEiMA0GCSqG
     SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDw6TvAvrbJvY4tzIIuDnLEVfRUW4BZJD3y
     K8fyyxXrYDvC69RKCKk9+TQhnUOLhZNlDST4HFfSPlakOjXUduyJE5M1EmoLAstN
     81aP3TejseDavxmaNijXRsa9E731T5H+zo44PgAHfQJmiD7rtcr+QOIosKUB2dwp
     F2acp9hLKd389BfNctziG0Oxq7hlISTDBnhzBg7eKuqWtShjVW5RqQvp3bARfUPa
     RWdYjmZvR+AnmozV1SGnpAnatzhnF6tNAb5XSEw49tumsX1D4A11J6mtrafO6bsP
     wdIPwy9W15iCszUNlFcdBaZhESc34VbyCyLMvA5T0Uj1FJHz1RFlAgMBAAGjUzBR
     MB0GA1UdDgQWBBQq0z6Vcmjcn8wnRTwKGSm5YGas9TAfBgNVHSMEGDAWgBQq0z6V
     cmjcn8wnRTwKGSm5YGas9TAPBgNVHRMBAf8EBTADAQH/MA0GCSqGSIb3DQEBCwUA
     A4IBAQBplippQ/Pxn7AkuwOTSwSTeJ7S+rMSb6iSL9chNHetanft0Ikr5BDsSrd6
     TeHV0sEMilDIjX0EjSNHwYtYrDPk6cGjkzDTYb6/U10c5Xhwi0g7/lMH/RPihPz5
     co80VEqXWlgfgHuE7/cAiTJ61PiFD9oI494bQcIISQNDfbUUiYfn32+8nK20rn8C
     w7PbGoIv6zz6A0c6DJT7yXJF5sAHgX4M03Oi9edzQ077ZOboXSuUKe4VfHIpjTjZ
     0sM/NbG5BFstyetVc3FZOGWGukTRb0C0GSASOm6hCyh5ctmpwlS4menc/OAx9BYO
     r9ZBjEa0oLFVV0pP5Tj4Gf1DDpuJ
     -----END CERTIFICATE-----
     ```
     




  1. Проверьте подпись и сохраните содержимое документа в файл `document`:

     ```bash
     openssl smime -verify -in rsa2048 -inform PEM -certfile certificate -noverify | tee document
     ```

     Если подпись верна, появится сообщение `Verification successful`. 

- DSA

  1. Подключитесь к ВМ:

     ```bash
     ssh <IP-адрес_ВМ>
     ```

  1. Получите dsa2048-подпись из метаданных ВМ и сохраните ее в файл `dsa2048`: 
   
     * **GCE**:

       ```bash
       curl -H Metadata-Flavor:Google 169.254.169.254/computeMetadata/v1/instance/vendor/identity/dsa > dsa2048
       ```

     * **EC2**:

       ```bash
       curl http://169.254.169.254/latest/vendor/instance-identity/dsa > dsa2048
       ```

  1. Создайте файл `certificate` и сохраните в него публичный сертификат:

     

     ```
     -----BEGIN CERTIFICATE-----
     MIIERjCCA+ugAwIBAgIULIUmuptqf9Pz7nMGMHeW+BPNneYwCwYJYIZIAWUDBAMC
     MAAwHhcNMjMwNjA3MDY1NjI0WhcNMzMwNjA0MDY1NjI0WjAAMIIDRjCCAjkGByqG
     SM44BAEwggIsAoIBAQDFyteKPnUOauqiHzsLCw2Z//c1IjSqVVPpIbETQ1NUCsUI
     o6+at1VkxJ76K/HqvFlhC87nSGWuQMgflQXcVIEQ8c0wnQGRj4lwkkjm8WClo4xv
     t/FsNyv4uEcPgcz45A2YxE4+5odjicKMCz4pPW+kc9t4BiKw4I9uGySBhA1p21e+
     fmR4AzDSHdHGRlvlYOfYANZlVeWm+qLsb+VfyeETTOD+ooMA9Y4ue3dw2l8Clib8
     WummF2PNRnnOeEFGbwZErtdObla2TjdNzFWc6QWo1EcqqkBXG1TutY/FgNcTj+Ps
     nFoUu4ZIy7o8p8YgzyffSCQbP5ppRGpfh4DuIS+vAiEA8tkwKyKmcCxTWnpRNWlY
     O6kUanHgEQczpLtP3mDvcdUCggEAMhbW4syX5p7X1qs0OnFCLcd4tYA2DnR1dLu3
     ZPusUh6c9+cH3ICEnK22KB1nplMAHDyXjtV2rCvIGlNUcT6OkSulnkvNE185cfM0
     UKofG4t6VJNpa8bngF7Ccyf6QBPcUzigHv+QDQDZuA4k3IcQp0hC9ppOaN6J9rKp
     5cSPyLzJ2vyY6mG650omxgnwG4OGZSRX8c1JN/MvIj79m3LqM7civ8l6ljnC+LNm
     1T7mcgZcf9iYc5+OWICoeDtFUdr+qsNIXonIMku6FpJu0pBgVgE6GI+nD4oaXSQS
     bckxB24DEYvTlVALuXqPS8MZyQZz5ltoI8xnbEOMqtU3IPox1AOCAQUAAoIBADcS
     Pt2SC+cGUCKNhrPquESB2/dZKUDuyEtYIYMidfoyoBGhz2QuqOqf5tEcLY9gCeMP
     NxmaXW1AQtcAX/+tyCZrVxEc31btW3alLmu/NtKxmb6PRshsASI/LIE1wH82TV8C
     4ymFDyKUGCb5AWN+Ziv5AP5/6Q08awQ7YAuz/sw0xOMqDuUfYkLerPEuQg5Sozs0
     DWucS/ex7l+VqNAZUBZykta961bhplIDTRG05YD3Lz0w/WIBMdZzzolA7F3jgFJg
     rCfZwQeDbf1iorfxRS5DqR0Vt7XE6/yqRUzDjOMctKY68jLZGFfOfTQ9iX2R9K/f
     7kJPxaHnA+WWo13ExwGjUzBRMB0GA1UdDgQWBBTj+x+t2VJhAWI57o9xRwMOeTFj
     mzAfBgNVHSMEGDAWgBTj+x+t2VJhAWI57o9xRwMOeTFjmzAPBgNVHRMBAf8EBTAD
     AQH/MAsGCWCGSAFlAwQDAgNIADBFAiAX2ABj/9ea1Q4ssAgIGkA4vJywoUoT4Sbg
     LFFIJGlNWgIhAO0b749SY5+6UMEOLsxgvNzKKcv58BKADfBdJAXE6fRk
     -----END CERTIFICATE-----
     ```
     



  1. Проверьте подпись и сохраните содержимое документа в файл `document`:

     ```bash
     openssl smime -verify -in dsa2048 -inform PEM -certfile certificate -noverify | tee document
     ```

     Если подпись верна, появится сообщение `Verification successful`. 

- BASE64

  1. Подключитесь к ВМ:

     ```bash
     ssh <IP-адрес_ВМ>
     ```

  1. Получите base64-подпись из метаданных ВМ и сохраните ее в файл `signature`: 
   
     * **GCE**:

       ```bash
       curl -H Metadata-Flavor:Google 169.254.169.254/computeMetadata/v1/instance/vendor/identity/base64 | base64 -d >> signature
       ```

     * **EC2**:

       ```bash
       curl http://169.254.169.254/latest/vendor/instance-identity/base64 | base64 -d >> signature
       ```
  
  1. Получите идентификационный документ и сохраните его в файл `document`:

     * **GCE**:

       ```bash
       curl -H Metadata-Flavor:Google 169.254.169.254/computeMetadata/v1/instance/vendor/identity/document > document
       ```

     * **EC2**:

       ```bash
       curl http://169.254.169.254/latest/vendor/instance-identity/document > document
       ```

  1. Создайте файл `certificate` и сохраните в него публичный сертификат:

     

     ```
     -----BEGIN CERTIFICATE-----
     MIIC4TCCAcmgAwIBAgIUP0zcGO1MeRwze8VdSMEt/OdBXoIwDQYJKoZIhvcNAQEL
     BQAwADAeFw0yMzA2MDcwNjU4MTBaFw0zMzA2MDQwNjU4MTBaMAAwggEiMA0GCSqG
     SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDw6TvAvrbJvY4tzIIuDnLEVfRUW4BZJD3y
     K8fyyxXrYDvC69RKCKk9+TQhnUOLhZNlDST4HFfSPlakOjXUduyJE5M1EmoLAstN
     81aP3TejseDavxmaNijXRsa9E731T5H+zo44PgAHfQJmiD7rtcr+QOIosKUB2dwp
     F2acp9hLKd389BfNctziG0Oxq7hlISTDBnhzBg7eKuqWtShjVW5RqQvp3bARfUPa
     RWdYjmZvR+AnmozV1SGnpAnatzhnF6tNAb5XSEw49tumsX1D4A11J6mtrafO6bsP
     wdIPwy9W15iCszUNlFcdBaZhESc34VbyCyLMvA5T0Uj1FJHz1RFlAgMBAAGjUzBR
     MB0GA1UdDgQWBBQq0z6Vcmjcn8wnRTwKGSm5YGas9TAfBgNVHSMEGDAWgBQq0z6V
     cmjcn8wnRTwKGSm5YGas9TAPBgNVHRMBAf8EBTADAQH/MA0GCSqGSIb3DQEBCwUA
     A4IBAQBplippQ/Pxn7AkuwOTSwSTeJ7S+rMSb6iSL9chNHetanft0Ikr5BDsSrd6
     TeHV0sEMilDIjX0EjSNHwYtYrDPk6cGjkzDTYb6/U10c5Xhwi0g7/lMH/RPihPz5
     co80VEqXWlgfgHuE7/cAiTJ61PiFD9oI494bQcIISQNDfbUUiYfn32+8nK20rn8C
     w7PbGoIv6zz6A0c6DJT7yXJF5sAHgX4M03Oi9edzQ077ZOboXSuUKe4VfHIpjTjZ
     0sM/NbG5BFstyetVc3FZOGWGukTRb0C0GSASOm6hCyh5ctmpwlS4menc/OAx9BYO
     r9ZBjEa0oLFVV0pP5Tj4Gf1DDpuJ
     -----END CERTIFICATE-----
     ```
     



  1. Извлеките из сертификата публичный ключ и сохраните его в файл `key`:

     ```bash
     openssl x509 -pubkey -noout -in certificate >> key
     ```

  1. Проверьте подпись и сохраните содержимое документа в файл `document`:

     ```bash
     openssl dgst -sha256 -verify key -signature signature document
     ```

     Если подпись верна, появится сообщение `Verified OK`. 

{% endlist %}

Сопоставьте идентификационный документ из метаданных ВМ с документом, сохраненным в файле:

```
curl http://169.254.169.254/latest/vendor/instance-identity/document | openssl dgst -sha256
```

```
openssl dgst -sha256 < document
```

Если хеш совпадает, идентификационный документ, сохраненный в файле, соответствует документу в метаданных ВМ.

#### См. также {#see-also}

* [{#T}](instance-groups/instance-template.md).