[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Functions](../../index.md) > [Пошаговые инструкции](../index.md) > Управление функцией > Добавить переменные окружения

# Добавить переменные окружения функции

При добавлении переменных окружения создается новая версия функции. В существующую версию переменные добавить нельзя.

{% list tabs group=instructions %}

- Консоль управления {#console}
    
    1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором находится функция.
    1. Перейдите в сервис **Cloud Functions**.
    1. Выберите функцию, для версии которой хотите добавить переменную окружения.
    1. Перейдите на вкладку **Редактор**.
    1. В блоке **Параметры** укажите переменную окружения и нажмите **Добавить**. Можно добавить несколько переменных окружения.
    1. Нажмите кнопку **Сохранить изменения**. Будет создана новая версия функции с указанными переменными окружения.
    
- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы добавить переменные окружения, выполните команду:

    {% note warning %}

    Если в прошлой версии уже были переменные окружения, они перезапишутся.

    {% endnote %}

    ```bash
    yc serverless function version create \
      --function-name=<имя_функции> \
      --runtime <среда_выполнения> \
      --entrypoint <точка_входа> \
      --memory 128m \
      --execution-timeout 5s \
      --source-version-id <идентификатор_версии> \
      --environment <переменные_окружения>
    ```

    Где:

    * `--function-name` — имя функции.
    * `--runtime` — среда выполнения.
    * `--entrypoint` — точка входа, указывается в формате `<имя_файла_с_функцией>.<имя_обработчика>`.
    * `--memory` — объем RAM.
    * `--execution-timeout` — максимальное время выполнения функции до таймаута.
    * `--source-version-id` — идентификатор версии функции, код которой вы хотите скопировать.
    * `--environment` — переменные окружения в формате `key=value`. Можно указать несколько пар через запятую.

- Terraform {#tf}

    [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
    
    Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
    
    Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

    Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
    
    
    Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

    Чтобы добавить переменные окружения:

    1. В конфигурационном файле добавьте блок `environment` для ресурса `yandex_function` и укажите список переменных окружения в формате `<ключ> = "<значение>"`.

       Пример описания функции в конфигурации Terraform:
      
        ```hcl
        resource "yandex_function" "test-function" {
            name               = "test-function"
            description        = "Test function"
            user_hash          = "first-function"
            runtime            = "python37"
            entrypoint         = "main"
            memory             = "128"
            execution_timeout  = "10"
            service_account_id = "<идентификатор_сервисного_аккаунта>"
            tags               = ["my_tag"]
            environment = {
                <ключ_переменной_окружения> = "<значение_переменной_окружения>"
            }
            content {
                zip_filename = "<путь_к_ZIP-архиву>"
            }
        }
        ```

        Подробнее о параметрах ресурса `yandex_function` в [документации провайдера](../../../terraform/resources/function.md).

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
      
    Проверить появление переменных окружения можно в [консоли управления](https://console.yandex.cloud).

- API {#api}

    Чтобы добавить переменные окружения, воспользуйтесь методом REST API [createVersion](../../functions/api-ref/Function/createVersion.md) для ресурса [Function](../../functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionService/CreateVersion](../../functions/api-ref/grpc/Function/createVersion.md).


{% endlist %}


## Полезные ссылки {#see-also}

* [Переменные окружения](../../concepts/runtime/environment-variables.md#env).