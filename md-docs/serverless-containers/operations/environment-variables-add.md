# Добавить переменные окружения контейнеру

При добавлении переменных окружения создается новая ревизия контейнера. В существующую ревизию переменные окружения добавить нельзя.

{% list tabs group=instructions %}

- Консоль управления {#console}
    
    1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором находится контейнер.
    1. Перейдите в сервис **Serverless Containers**.
    1. Выберите контейнер, для ревизии которого хотите добавить переменную окружения.
    1. Перейдите на вкладку **Редактор**.
    1. В открывшемся окне в блоке **Параметры образа** укажите переменную окружения и нажмите **Добавить**. Можно добавить несколько переменных окружения.
    1. Нажмите кнопку **Создать ревизию**. Будет создана новая ревизия контейнера с указанными переменными окружения.
    
- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы добавить переменные окружения, выполните команду:

    {% note warning %}

    Если в прошлой ревизии уже были переменные окружения, они перезапишутся.

    {% endnote %}

    ```
    yc serverless container revision deploy \
      --container-name <имя_контейнера> \
      --image <URL_Docker-образа> \
      --cores 1 \
      --memory 1GB \
      --service-account-id <идентификатор_сервисного_аккаунта> \
      --environment <переменные_окружения>
    ```

    Где:

    * `--cores` — количество ядер, которые доступны контейнеру.
    * `--memory` — требуемая память. По умолчанию — 128 МБ.
    * `--environment` — переменные окружения в формате `key=value`. Можно указать несколько пар через запятую.

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  Чтобы добавить переменные окружения:

  1. Откройте файл конфигурации Terraform и для ресурса `yandex_serverless_container` в блок `image` добавьте список `environment` с переменными окружения:

     ```hcl
     ...
     resource "yandex_serverless_container" "test-container" {
       name               = "my-container"
       memory             = 256
       service_account_id = "ajecvjv1lv01********"
       image {
           url = "cr.yandex/yc/test-image:v1"
           environment = {
               <ключ> = "<значение>"
           }
       }
     }
     ...
     ```

     Где `environment` — переменные окружения в формате `key="value"`. Можно указать несколько пар.

	 Подробнее о параметрах ресурса `yandex_serverless_container` в [документации провайдера](../../terraform/resources/serverless_container.md).

  1. Проверьте конфигурацию командой:
     ```
     terraform validate
     ```
     
     Если конфигурация является корректной, появится сообщение:
     
     ```
     Success! The configuration is valid.
     ```

  1. Выполните команду:
     ```
     terraform plan
     ```
  
     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.

  1. Примените изменения конфигурации:
     ```
     terraform apply
     ```
     
  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

  Проверить создание переменных окружения можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../cli/index.md):

  ```
  yc serverless container revision get <идентификатор_ревизии>
  ```

- API {#api}

  Чтобы добавить переменную окружения в ревизию контейнера, воспользуйтесь методом REST API [deployRevision](../containers/api-ref/Container/deployRevision.md) для ресурса [Container](../containers/api-ref/Container/index.md) или вызовом gRPC API [ContainerService/DeployRevision](../containers/api-ref/grpc/Container/deployRevision.md).

{% endlist %}

## Полезные ссылки {#see-also}

* [Переменные окружения](../concepts/runtime.md#environment-variables).