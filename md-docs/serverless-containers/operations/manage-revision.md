# Создать ревизию контейнера

Создавать новую ревизию необходимо в следующих случаях:

* загрузка новой версии Docker-образа в [Yandex Container Registry](../../container-registry/index.md);
* изменение настроек ревизии.

{% note info %}

Для сохранения целостности связей изменение и удаление ревизий контейнера не предусмотрено.

{% endnote %}

Если [реестр](../../container-registry/concepts/registry.md) или [репозиторий](../../container-registry/concepts/repository.md) с Docker-образом не являются [публичными](../../container-registry/qa/index.md#public-registry), необходимо указать в настройках ревизии [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), у которого [есть права](../../iam/operations/sa/assign-role-for-sa.md) на скачивание Docker-образа. Например, роль `container-registry.images.puller` на каталог или реестр, в которых находится Docker-образ.

Если в настройках ревизии указан сервисный аккаунт, у пользователя или сервисного аккаунта, от имени которого создается ревизия, должна быть роль `iam.serviceAccounts.user`. Она подтверждает права на использование сервисного аккаунта.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [контейнер](../concepts/container.md).
  1. Перейдите в сервис **Serverless Containers**.
  1. Выберите контейнер, [ревизию](../concepts/container.md#revision) которого хотите создать.
  1. Перейдите на вкладку **Редактор**.
  1. В разделе **Параметры образа**:
      * Укажите URL Docker-образа из Yandex Container Registry.
      * Если необходимо, дополнительно укажите параметры ревизии:
          * **Команда** — команды, которые контейнер выполнит при запуске. Соответствует инструкции `ENTRYPOINT` в Dockerfile.
          * **Аргументы** — соответствует инструкции `CMD` в Dockerfile. Аргументы указываются в формате `ключ = значение`. Если не указано, будет использоваться значение `CMD` по умолчанию из Docker-образа.

              В контейнер можно передать несколько аргументов. Для этого нажмите **Добавить**.

          * **Рабочая директория** — позволяет изменить рабочую директорию контейнера. Соответствует инструкции `WORKDIR` в Dockerfile. Рекомендуется устанавливать абсолютные пути к папкам.

  1. Нажмите кнопку **Создать ревизию**.

- CLI {#cli}

  Чтобы создать [ревизию](../concepts/container.md#revision) [контейнера](../concepts/container.md), выполните команду:

  ```bash
  yc serverless container revision deploy \
    --container-name <имя_контейнера> \
    --image <URL_Docker-образа> \
    --cores 1 \
    --memory 1GB \
    --execution-timeout 30s \
    --service-account-id <идентификатор_сервисного_аккаунта> \
    --command '<команда_1>','<команда_2>' \
    --args '<ключ_1=значение_1>','<ключ_2=значение_2>'
  ```


  Где:
  * `--cores` — количество ядер, которые доступны контейнеру.
  * `--memory` — требуемая память. По умолчанию — 128 МБ.
  * `--execution-timeout` — таймаут. По умолчанию — 3 секунды.
  * `--service-account-id` — [идентификатор сервисного аккаунта](../../iam/operations/sa/get-id.md), у которого есть права на скачивание Docker-образа.
  * `--command` — команды, которые контейнер выполнит при запуске. Указываются через запятую. Соответствует инструкции `ENTRYPOINT` в Dockerfile.
  * `--args` — аргументы, соответствует инструкции `CMD` в Dockerfile. Указываются в формате `ключ = значение` через запятую. Если не указано, будет использоваться значение `CMD` по умолчанию из Docker-образа.

  Результат:

  ```text
  id: bbajn5q2d74c********
  container_id: bba3fva6ka5g********
  created_at: "2021-07-09T15:04:55.135Z"
  image:
    image_url: cr.yandex/crpd3cicopk7********/test-container:latest
    image_digest: sha256:de8e1dce7ceceeafaae122f7670084a1119c961cd9ea1795eae92bd********
  resources:
    memory: "1073741824"
    cores: "1"
  execution_timeout: 3s
  service_account_id: ajeqnasj95o7********
  status: ACTIVE
  ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  В Terraform [ревизия](../concepts/container.md#revision) создается при каждом обновлении параметров работы ресурса.

  Чтобы создать ревизию:
  1. Обновите в конфигурационном файле параметры ресурса `yandex_serverless_container`:

     ```hcl
     resource "yandex_serverless_container" "test-container" {
       name               = "<имя_контейнера>"
       cores              = "<количество_ядер>"
       memory             = "<объем_памяти>"
       service_account_id = "<идентификатор_сервисного_аккаунта>"
       image {
         url      = "<URL_Docker-образа>"
         command  = ["<команда_1>","<команда_2>"]
         args     = ["<ключ_1=значение_1>","ключ_2=значение_2"]
         work_dir = "<рабочая_директория>"
       }
     }
     ```

     Где:

     * `cores` — количество ядер, которые доступны контейнеру.
     * `memory` — требуемая память. По умолчанию — 128 МБ.
     * `command` — команды, которые контейнер выполнит при запуске. Указываются через запятую. Соответствует инструкции `ENTRYPOINT` в Dockerfile.
     * `args` — аргументы, соответствует инструкции `CMD` в Dockerfile. Указываются в формате `ключ = значение` через запятую. Если не указано, будет использоваться значение CMD по умолчанию из Docker-образа.
     * `work_dir` — позволяет изменить рабочую директорию контейнера. Соответствует инструкции `WORKDIR` в Dockerfile. Рекомендуется устанавливать абсолютные пути к папкам.

     Подробнее о параметрах ресурса `yandex_serverless_container` в [документации провайдера](../../terraform/resources/serverless_container.md).

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

     После этого будет создана ревизия. Проверить создание ревизии можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../cli/index.md):

     ```bash
     yc serverless container revision list
     ```

- API {#api}

  Чтобы создать [ревизию](../concepts/container.md#revision) [контейнера](../concepts/container.md), воспользуйтесь методом REST API [deployRevision](../containers/api-ref/Container/deployRevision.md) для ресурса [Container](../containers/api-ref/Container/index.md) или вызовом gRPC API [ContainerService/DeployRevision](../containers/api-ref/grpc/Container/deployRevision.md).

{% endlist %}