# Получить информацию о функции

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится функция.
    1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. На панели слева выберите ![image](../../../_assets/console-icons/curly-brackets-function.svg) **{{ ui-key.yacloud.serverless-functions.switch_list }}**.
    1. Выберите функцию.
    1. На странице **{{ ui-key.yacloud.serverless-functions.item.overview.label_title }}** отобразится подробная информация о функции.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы узнать имя или уникальный идентификатор функции, [получите](function-list.md) список функций в каталоге.

    Чтобы получить подробную информацию о функции, выполните команду:

    ```bash
    yc serverless function get <идентификатор_функции>
    ```
    Результат:
    ```json
    id: d4e155orh3nu********
	folder_id: b1gc1t4cb638********
	created_at: "2020-10-09T11:53:19.815Z"
	name: test-function
	log_group_id: ckg9ndpthgnu********
	http_invoke_url: https://{{ sf-url }}/d4e155orh3nu********
	status: ACTIVE
    ```

- API {#api}

    Чтобы получить подробную информацию о функции, воспользуйтесь методом REST API [get](../../functions/api-ref/Function/get.md) для ресурса [Function](../../functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionService/Get](../../functions/api-ref/grpc/Function/get.md).


{% endlist %}