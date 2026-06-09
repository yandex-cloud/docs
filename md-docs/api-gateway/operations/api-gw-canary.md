# Настроить канареечный релиз

Настройка канареечного релиза возможна только для [спецификаций OpenAPI](https://ru.wikipedia.org/wiki/OpenAPI_(спецификация)) с переменными (см. раздел [Параметризация спецификации](../concepts/extensions/parametrization.md)).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [API-шлюз](../concepts/index.md).
  1. Перейдите в сервис **API Gateway**.
  1. В строке с API-шлюзом нажмите кнопку ![image](../../_assets/options.svg) и выберите ![image](../../_assets/console-icons/pencil.svg) **Редактировать**.
  1. В блоке **Управление переменными** включите [канареечный релиз](../concepts/extensions/canary.md).
  1. В поле **Доля запросов в канареечном релизе** укажите процент запросов, который будет обрабатываться канареечным релизом.
  1. В поле **Переменные для канареечного релиза** перечислите переменные и их значения, которые будут применяться в канареечном релизе.
  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы настроить [канареечный релиз](../concepts/extensions/canary.md):
  1. При необходимости внесите изменения в файл спецификации OpenAPI или подготовьте новый файл.
  1. Посмотрите описание команды CLI для изменения [API-шлюза](../concepts/index.md):

     ```bash
     yc serverless api-gateway update --help
     ```

  1. Укажите в команде идентификатор или имя API-шлюза, а также параметры канареечного релиза:

     ```bash
     yc serverless api-gateway update \
       --id <идентификатор_API-шлюза> \
       --canary-weight <процент_запросов> \
       --canary-variables=<список_переменных>
     ```

     Где:
     * `--canary-weight` — процент запросов, которые будут обработаны канареечным релизом.
     * `--canary-variables` — переменные для канареечного релиза в формате `ключ=значение`.

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  Чтобы настроить [канареечный релиз](../concepts/extensions/canary.md):
  1. Откройте файл конфигурации Terraform и добавьте в него блок `canary`:

     ```hcl
     resource "yandex_api_gateway" "<имя_API-шлюза>" {
     ...
     canary {
       weight    = <процент_запросов>
       variables = {
         <список_переменных>
       }
     }
     ```

     Где:
     * `weight` — процент запросов, которые будут обработаны канареечным релизом.
     * `variables` — переменные для канареечного релиза в формате `ключ=значение`.

     Более подробную информацию о параметрах ресурса `yandex_api_gateway` в Terraform см. в [документации провайдера](../../terraform/resources/api_gateway.md).
  1. Проверьте конфигурацию командой:

     ```bash
     terraform validate
     ```

     Если конфигурация является корректной, появится сообщение:

     ```text
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

  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

  Проверить, что [API-шлюз](../concepts/index.md) изменился, можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../cli/quickstart.md):

  ```bash
  yc serverless api-gateway get <имя API-шлюза>
  ```

- API {#api}

  Чтобы настроить [канареечный релиз](../concepts/extensions/canary.md), воспользуйтесь методом REST API [update](../apigateway/api-ref/ApiGateway/update.md) для ресурса [ApiGateway](../apigateway/api-ref/ApiGateway/index.md) или вызовом gRPC API [ApiGatewayService/Update](../apigateway/api-ref/grpc/ApiGateway/update.md).

{% endlist %}

## См. также

* [Что такое канареечный релиз](../concepts/extensions/canary.md).
* [Канареечный релиз функции Cloud Functions](../tutorials/canary-release.md).