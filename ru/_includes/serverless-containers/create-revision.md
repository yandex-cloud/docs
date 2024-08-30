{% include [revision-service-account-note](./revision-service-account-note.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [контейнер](../../serverless-containers/concepts/container.md).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
  1. Выберите контейнер, [ревизию](../../serverless-containers/concepts/container.md#revision) которого хотите создать.
  1. Перейдите на вкладку **{{ ui-key.yacloud.serverless-containers.label_editor }}**.
  1. В разделе **{{ ui-key.yacloud.serverless-containers.section_image }}** вы можете дополнительно указать параметры ревизии:
      * **{{ ui-key.yacloud.serverless-containers.label_command }}** — команды, которые контейнер выполнит при запуске. Соответствует инструкции `ENTRYPOINT` в Dockerfile.
      * **{{ ui-key.yacloud.serverless-containers.label_args }}** — соответствует инструкции `CMD` в Dockerfile. Аргументы указываются в формате `ключ = значение`. Если не указано, будет использоваться значение `CMD` по умолчанию из Docker-образа.

          В контейнер можно передать несколько аргументов. Для этого нажмите **{{ ui-key.yacloud.common.add }}**.

      * **{{ ui-key.yacloud.serverless-containers.label_working-directory }}** — позволяет изменить рабочую директорию контейнера. Соответствует инструкции `WORKDIR` в Dockerfile. Рекомендуется устанавливать абсолютные пути к папкам.

  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-containers.button_deploy-revision }}**.

- CLI {#cli}

  Чтобы создать [ревизию](../../serverless-containers/concepts/container.md#revision) [контейнера](../../serverless-containers/concepts/container.md), выполните команду:

  ```bash
  yc serverless container revision deploy \
    --container-name <имя_контейнера> \
    --image <URL_Docker-образа> \
    --cores 1 \
    --memory 1GB \
    --concurrency 1 \
    --execution-timeout 30s \
    --service-account-id <идентификатор_сервисного_аккаунта> \
    --command '<команда_1>','<команда_2>' \
    --args '<ключ_1=значение_1>','<ключ_2=значение_2>'
  ```


  Где:
  * `--cores` — количество ядер, которые доступны контейнеру.
  * `--memory` — требуемая память. По умолчанию — 128 МБ.
  * `--concurrency` — максимальное количество одновременных вызовов одного экземпляра контейнера. По умолчанию — 1, максимальное значение — 16. Если вызовов контейнера больше, чем значение `concurrency`, {{ serverless-containers-name }} масштабирует контейнер — запускает его дополнительные экземпляры.

      {% include [quota-containers-requests](quota-containers-requests.md) %}

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
    image_url: {{ registry }}/crpd3cicopk7********/test-container:latest
    image_digest: sha256:de8e1dce7ceceeafaae122f7670084a1119c961cd9ea1795eae92bd********
  resources:
    memory: "1073741824"
    cores: "1"
  execution_timeout: 3s
  service_account_id: ajeqnasj95o7********
  status: ACTIVE
  ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  В {{ TF }} [ревизия](../../serverless-containers/concepts/container.md#revision) создается при каждом обновлении параметров работы ресурса.

  Чтобы создать ревизию:
  1. Обновите в конфигурационном файле параметры ресурса `yandex_serverless_container`:

     ```hcl
     resource "yandex_serverless_container" "test-container" {
       name               = "<имя_контейнера>"
       cores              = "<количество_ядер>"
       memory             = "<объем_памяти>"
       concurrency        = "<одновременные_вызовы>"
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
    * `concurrency` — максимальное количество одновременных вызовов одного экземпляра контейнера. По умолчанию — 1, максимальное значение — 16. Если вызовов контейнера больше, чем значение `concurrency`, {{ serverless-containers-name }} масштабирует контейнер — запускает его дополнительные экземпляры.

        {% include [quota-containers-requests](quota-containers-requests.md) %}

     * `command` — команды, которые контейнер выполнит при запуске. Указываются через запятую. Соответствует инструкции `ENTRYPOINT` в Dockerfile.
     * `args` — аргументы, соответствует инструкции `CMD` в Dockerfile. Указываются в формате `ключ = значение` через запятую. Если не указано, будет использоваться значение CMD по умолчанию из Docker-образа.
     * `work_dir` — позволяет изменить рабочую директорию контейнера. Соответствует инструкции `WORKDIR` в Dockerfile. Рекомендуется устанавливать абсолютные пути к папкам.

     Более подробную информацию о параметрах ресурса `yandex_serverless_container` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/serverless_container).

  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     После этого будет создана ревизия. Проверить создание ревизии можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/):

     ```bash
     yc serverless container revision list
     ```

- API {#api}

  Чтобы создать [ревизию](../../serverless-containers/concepts/container.md#revision) [контейнера](../../serverless-containers/concepts/container.md), воспользуйтесь методом REST API [deployRevision](../../serverless-containers/containers/api-ref/Container/deployRevision.md) для ресурса [Container](../../serverless-containers/containers/api-ref/Container/index.md) или вызовом gRPC API [ContainerService/DeployRevision](../../serverless-containers/containers/api-ref/grpc/container_service.md#DeployRevision).

{% endlist %}
