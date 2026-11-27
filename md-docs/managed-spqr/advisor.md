[Документация Yandex Cloud](../index.md) > [Yandex Managed Service for Sharded PostgreSQL](index.md) > Инспекции и рекомендации

# Инспекции и рекомендации в Managed Service for Sharded PostgreSQL 

На кластере управляемой базы данных регулярно проводится диагностика с целью выявления возможных проблем, повышения надежности его работы и повышения производительности. Результаты этих проверок отображаются в виде набора инспекций в разделе **Рекомендации**. Вы можете увидеть уведомления об успешно пройденных проверках и рекомендации для устранения выявленных рисков. Обязанность по устранению выявленных проблем находится в [зоне контроля пользователя](../overview/concepts/mdb-responsibilities.md) Yandex Cloud.

Все проверки имеют определенный уровень критичности:

* Высокий уровень — критерии высокой доступности кластера, значительные риски падения производительности, риски потери данных. Такие проверки требуют особого внимания и выполнения рекомендованных действий. 
* Умеренный уровень — возможные риски падения производительности, неоптимальное использование памяти и дискового пространства.
* Низкий уровень — потенциальные риски и ограничения работы кластера.

Список рекомендаций регулярно обновляется. Для каждой рекомендации фиксируются временные метки: дата первого выявления риска и дата последнего обновления статуса по этой проблеме. Если рекомендация кажется избыточной или некорректной, вы можете скрыть ее, указав причину. По истечении срока скрытия рекомендация автоматически станет доступна вновь — при условии, что проблема по-прежнему актуальна.

Рекомендации доступны на уровне кластера, каталога и облака и содержат советы по всем вашим ресурсам. Однако отсутствие рекомендаций не означает, что кластер работает оптимально: перечень проверок постоянно расширяется, но остается неисчерпывающим и не заменяет мониторинг, поскольку **нацелен на выявление паттернов, а не отдельных проблем**. Вы можете дополнительно продиагностировать производительность кластера и проанализировать метрики мониторинга.

Для управления рекомендациями в Managed Service for Sharded PostgreSQL требуется роль [managed-spqr.editor или выше](security.md).

## Доступные инспекции в Managed Service for Sharded PostgreSQL {#mspqr-recommendations}

| **Категория** | **Проверка** | **Риск** | **Критичность** |
|---------------------|---------------------|-----------------------------------------------------------------------------|-----------------|
| Производительность | Загрузка CPU | [Обнаружена высокая загрузка CPU](#spqr_cpu_idle) | Высокая |

### Обнаружена высокая загрузка CPU {#spqr_cpu_idle}

**Описание**

Хост постоянно использует весь ресурс CPU, что может приводить к замедлению обработки запросов. Проверьте [нагрузку](../storedoc/operations/performance-diagnostics.md) и оптимизируйте запросы (в том числе с [AI-ассистентом](../websql/operations/ai-assistant.md) в WebSQL) или увеличьте вычислительные ресурсы кластера.

**Действие**

Чтобы увеличить вычислительные ресурсы кластера:

1. [Перейдите](https://console.yandex.cloud/link/managed-spqr) в сервис **Yandex Managed Service for Sharded&nbsp;PostgreSQL**.
1. Выберите кластер и нажмите кнопку **Редактировать** на панели сверху.
1. В разделе **Инфраструктура** выберите класс хоста с нужным количеством vCPU.
1. Нажмите **Сохранить изменения**.

## Управление рекомендациями {#manage-advices}

### Посмотреть рекомендации {#get-advices}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
  1. [Перейдите](https://console.yandex.cloud/link/managed-spqr) в сервис **Yandex Managed Service for Sharded&nbsp;PostgreSQL**.
  1. Перейдите в раздел ![bulb](../_assets/console-icons/bulb.svg) **Рекомендации**.
  1. Нажмите на нужную рекомендацию — на панели справа отобразится подробная информация.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../cli/quickstart.md#install).
  
  По умолчанию используется каталог, указанный при [создании](../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.
  
  1. Посмотрите описание команды для получения списка рекомендаций:
  
      ```bash
      yc adviser issue list --help
      ```
  
  1. Получите список рекомендаций:
  
      ```bash
      yc adviser issue list
      ```
  
      Чтобы получить рекомендации для конкретного ресурса, укажите его идентификатор в параметре `--resource-id`.
  
      Результат:
  
      ```text
      +---------+---------------+--------------+----------+--------+-----------------+------------+--------------------------------+--------------------------------+
      |   ID    | RESOURCE TYPE | RESOURCE ID  | SEVERITY | STATE  |    CATEGORY     | VISIBILITY |             TITLE              |          DESCRIPTION           |
      +---------+---------------+--------------+----------+--------+-----------------+------------+--------------------------------+--------------------------------+
      | 1928... | MANAGED_<DB>  | c9qs90gna... | INFO     | ACTIVE | FAULT_TOLERANCE | VISIBLE    | Возможность                    | В шарде data-manager не        |
      |         |               |              |          |        |                 |            | автомасштабирования            | настроено автомасштабирование  |
      |         |               |              |          |        |                 |            |                                | дискового пространства.        |
      |         |               |              |          |        |                 |            |                                | Настройте автомасштабирование  |
      |         |               |              |          |        |                 |            |                                | для предотвращения             |
      |         |               |              |          |        |                 |            |                                | переполнения диска.            |
      | 3746... | MANAGED_<DB>  | c9qs90gna... | CRITICAL | ACTIVE | FAULT_TOLERANCE | VISIBLE    | Высокая доступность кластера   | Кластер не обеспечивает        |
      |         |               |              |          |        |                 |            | при отказе зоны                | высокую доступность и не       |
      |         |               |              |          |        |                 |            |                                | подпадает под действие SLA...  |
      ```

- REST API {#api}

  1. Получите IAM-токен для аутентификации в API и поместите токен в переменную среды окружения:
  
      ```bash
      export IAM_TOKEN="<IAM-токен>"
      ```
  
  1. Воспользуйтесь [методом](../api-design-guide/concepts/about-adviser.md) `Issue.List` и выполните запрос, например, с помощью [cURL](https://curl.se/):
  
      ```bash
      curl \
          --request GET \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --url 'https://adviser.api.cloud.yandex.net/adviser/v1/resourceIssues' \
          --url-query cloudId=<идентификатор_облака>&folderId=<идентификатор_каталога>&resourceId=<идентификатор_кластера>
      ```
  
      Где:
  
      * `cloudId` — идентификатор облака. Обязательный параметр.
      * `folderId` — идентификатор каталога. Если параметр не указан, сервер вернет рекомендации для всех каталогов облака.
      * `resourceId` — идентификатор кластера. Если параметр не указан, сервер вернет рекомендации для всех ресурсов каталога или облака.
  
  1. Убедитесь, что запрос был выполнен успешно, изучив ответ сервера.
  
      {% cut "Пример ответа" %}
  
      ```json
      {
        "issues": [
          {
            "id": "1090...",
            "resource": {
              "type": "RESOURCE_TYPE_MANAGED_<DB>",
              "resourceId": "c9ql6kum9...",
              "folderId": "b1g681qpe...",
              "cloudId": "b1gia87mb..."
            },
            "createdAt": "2026-11-26T19:34:44.232731Z",
            "updatedAt": "2026-11-26T19:34:44.232731Z",
            "state": "ISSUE_STATE_ACTIVE",
            "severity": "ISSUE_SEVERITY_INFO",
            "category": "ISSUE_CATEGORY_FAULT_TOLERANCE",
            "visibility": "ISSUE_VISIBILITY_VISIBLE",
            "service": "mdb_adviser_cp_agent",
            "slug": "<db>_disk_autoscaling",
            "shortDescr": "Автомасштабирование дискового пространства не настроено",
            "fullDescr": "В шарде data-manager не настроено автомасштабирование дискового пространства. Настройте автомасштабирование для предотвращения переполнения диска.",
            "docUrl": "<ссылка_на_документацию>",
            "title": "Возможность автомасштабирования"
          },
          ...
        ]
      }
      ```
  
      {% endcut %}

- gRPC API {#grpc-api}

  1. Получите IAM-токен для аутентификации в API и поместите токен в переменную среды окружения:
  
      ```bash
      export IAM_TOKEN="<IAM-токен>"
      ```
  
  1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
     
     ```bash
     cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
     ```
     
     Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.
  
  1. Воспользуйтесь [вызовом](../api-design-guide/concepts/about-adviser.md) `IssueService.List` и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):
  
      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/adviser/v1/issue_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                  "cloud_id": "<идентификатор_облака>",
                  "folder_id": "<идентификатор_каталога>",
                  "resource_id": "<идентификатор_кластера>"
              }' \
          adviser.api.cloud.yandex.net:443 \
          yandex.cloud.adviser.v1.IssueService.List
      ```
  
      Где:
  
      * `cloud_id` — идентификатор облака. Обязательный параметр.
      * `folder_id` — идентификатор каталога. Если параметр не указан, сервер вернет рекомендации для всех каталогов облака.
      * `resource_id` — идентификатор кластера. Если параметр не указан, сервер вернет рекомендации для всех ресурсов каталога или облака.
  
  1. Убедитесь, что запрос был выполнен успешно, изучив ответ сервера.
  
      {% cut "Пример ответа" %}
  
      ```json
      {
        "issues": [
          {
            "id": "1090...",
            "resource": {
              "type": "RESOURCE_TYPE_MANAGED_<DB>",
              "resourceId": "c9ql6kum9...",
              "folderId": "b1g681qpe...",
              "cloudId": "b1gia87mb..."
            },
            "createdAt": "2026-11-26T19:34:44.232731Z",
            "updatedAt": "2026-11-26T19:34:44.232731Z",
            "state": "ISSUE_STATE_ACTIVE",
            "severity": "ISSUE_SEVERITY_INFO",
            "category": "ISSUE_CATEGORY_FAULT_TOLERANCE",
            "visibility": "ISSUE_VISIBILITY_VISIBLE",
            "service": "mdb_adviser_cp_agent",
            "slug": "<db>_disk_autoscaling",
            "shortDescr": "Автомасштабирование дискового пространства не настроено",
            "fullDescr": "В шарде data-manager не настроено автомасштабирование дискового пространства. Настройте автомасштабирование для предотвращения переполнения диска.",
            "docUrl": "<ссылка_на_документацию>",
            "title": "Возможность автомасштабирования"
          },
          ...
        ]
      }
      ```
  
      {% endcut %}

{% endlist %}

### Скрыть рекомендацию {#hide-advice}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
  1. [Перейдите](https://console.yandex.cloud/link/managed-spqr) в сервис **Yandex Managed Service for Sharded&nbsp;PostgreSQL**.
  1. Перейдите в раздел ![bulb](../_assets/console-icons/bulb.svg) **Рекомендации**.
  1. В строке с нужной рекомендацией нажмите ![ellipsis](../_assets/console-icons/ellipsis.svg) → ![eye-slash](../_assets/console-icons/eye-slash.svg) **Скрыть для всех**.
  1. В открывшемся окне укажите настройки скрытия:
     
     * Выберите причину:
     
         * `Некорректная рекомендация`
         * `Не планирую применять рекомендации`
         * `Планирую применить рекомендации`
         * `Другое`
     
     * Укажите время в днях, неделях или месяцах, на которое нужно скрыть рекомендацию. Максимальное значение — один год.
     * Напишите комментарий. Обязательно, если вы выбрали причину `Другое`.
  1. Нажмите **Скрыть**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../cli/quickstart.md#install).
  
  По умолчанию используется каталог, указанный при [создании](../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.
  
  1. Посмотрите описание команды для скрытия рекомендации:
  
      ```bash
      yc adviser issue dismiss --help
      ```
  
  1. [Получите](#get-advices) список рекомендаций, чтобы узнать идентификатор рекомендации:
  
      ```bash
      yc adviser issue list
      ```
  
  1. Скройте рекомендацию:
  
      ```bash
      yc adviser issue dismiss \
        --id <идентификатор_рекомендации> \
        --reason "<причина>" \
        --comment "<комментарий>" \
        --duration <время_скрытия>
      ```
  
      Где:
  
      * `--id` — идентификатор рекомендации. Обязательный параметр.
      * `--reason` — причина, по которой вы скрываете рекомендацию. Обязательный параметр. Возможные значения:
  
          * `dismiss-issue-reason-incorrect` — некорректная рекомендация.
          * `dismiss-issue-reason-wont-fix` — не планируется применять изменения.
          * `dismiss-issue-reason-accepted` — планируется применять изменения.
          * `dismiss-issue-reason-other` — другая причина.
  
      * `--comment` — комментарий в свободной форме. Обязательно, если выбрана причина `dismiss-issue-reason-other`.
      * `--duration` — время, на которое нужно скрыть рекомендацию, например `720h`. Максимальное значение — один год. Обязательный параметр.
  
      При успешном выполнении команды сервер вернет пустой ответ — `{}`.

- REST API {#api}

  1. Получите IAM-токен для аутентификации в API и поместите токен в переменную среды окружения:
  
      ```bash
      export IAM_TOKEN="<IAM-токен>"
      ```
  
  1. Получите идентификатор рекомендации, которую нужно скрыть, с помощью [метода](../api-design-guide/concepts/about-adviser.md) `Issue.List`.
  
  1. Воспользуйтесь методом `Issue.Dismiss` и выполните запрос, например, с помощью [cURL](https://curl.se/):
  
      ```bash
      curl \
          --request POST \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://adviser.api.cloud.yandex.net/adviser/v1/resourceIssues/<идентификатор_рекомендации>:dismiss' \
          --data '{
              "reason": "<причина_скрытия>",
              "duration": "<время_скрытия>",
              "comment": "<комментарий>"
          }'
      ```
  
      Где:
  
      * `reason` — причина, по которой вы скрываете рекомендацию. Обязательный параметр. Возможные значения:
  
          * `DISMISS_ISSUE_REASON_INCORRECT` — некорректная рекомендация.
          * `DISMISS_ISSUE_REASON_WONT_FIX` — не планируется применять изменения.
          * `DISMISS_ISSUE_REASON_ACCEPTED` — планируется применять изменения.
          * `DISMISS_ISSUE_REASON_OTHER` — другая причина.
  
      * `duration` — время, на которое нужно скрыть рекомендацию, в формате [google.protobuf.Duration](https://protobuf.dev/reference/protobuf/google.protobuf#duration), например `2592000s` (30 дней). Максимальное значение — один год (`31536000s`). Обязательный параметр.
      * `comment` — комментарий в свободной форме. Обязателен, если выбрана причина `DISMISS_ISSUE_REASON_OTHER`.
  
  1. Убедитесь, что запрос был выполнен успешно, изучив ответ сервера.
  
      При успешном выполнении запроса сервер вернет пустой ответ — `{}`.

- gRPC API {#grpc-api}

  1. Получите IAM-токен для аутентификации в API и поместите токен в переменную среды окружения:
  
      ```bash
      export IAM_TOKEN="<IAM-токен>"
      ```
  
  1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
     
     ```bash
     cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
     ```
     
     Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.
  
  1. Получите идентификатор рекомендации, которую нужно скрыть, с помощью [вызова](../api-design-guide/concepts/about-adviser.md) `IssueService.List`.
  
  1. Воспользуйтесь вызовом `IssueService.Dismiss` и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):
  
      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/adviser/v1/issue_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                  "id": "<идентификатор_рекомендации>",
                  "reason": "<причина_скрытия>",
                  "duration": "<время_скрытия>",
                  "comment": "<комментарий>"
              }' \
          adviser.api.cloud.yandex.net:443 \
          yandex.cloud.adviser.v1.IssueService.Dismiss
      ```
  
      Где:
  
      * `id` — идентификатор рекомендации, которую нужно скрыть. Обязательный параметр.
      * `reason` — причина, по которой вы скрываете рекомендацию. Обязательный параметр. Возможные значения:
  
          * `DISMISS_ISSUE_REASON_INCORRECT` — некорректная рекомендация.
          * `DISMISS_ISSUE_REASON_WONT_FIX` — не планируется применять изменения.
          * `DISMISS_ISSUE_REASON_ACCEPTED` — планируется применять изменения.
          * `DISMISS_ISSUE_REASON_OTHER` — другая причина.
  
      * `duration` — время, на которое нужно скрыть рекомендацию, в формате [google.protobuf.Duration](https://protobuf.dev/reference/protobuf/google.protobuf#duration), например `2592000s` (30 дней). Максимальное значение — один год (`31536000s`). Обязательный параметр.
      * `comment` — комментарий в свободной форме. Обязателен, если выбрана причина `DISMISS_ISSUE_REASON_OTHER`.
  
  1. Убедитесь, что запрос был выполнен успешно, изучив ответ сервера.
  
      При успешном выполнении запроса сервер вернет пустой ответ — `{}`.

{% endlist %}

### Посмотреть скрытые рекомендации {#get-hidden-advices}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
  1. [Перейдите](https://console.yandex.cloud/link/managed-spqr) в сервис **Yandex Managed Service for Sharded&nbsp;PostgreSQL**.
  1. Перейдите в раздел ![bulb](../_assets/console-icons/bulb.svg) **Рекомендации**.
  1. На панели сверху выберите **Скрытые**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../cli/quickstart.md#install).
  
  По умолчанию используется каталог, указанный при [создании](../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.
  
  1. Посмотрите описание команды для получения списка рекомендаций:
  
      ```bash
      yc adviser issue list --help
      ```
  
  1. Получите список скрытых рекомендаций:
  
      ```bash
      yc adviser issue list \
        --visibility dismissed
      ```
  
      Где `--visibility` — режим отображения рекомендаций. Возможные значения:
  
      * `visible` — видимые рекомендации.
      * `dismissed` — скрытые рекомендации.
  
      Результат:
  
      ```text
      +---------+---------------+--------------+----------+--------+-----------------+------------+---------------------+--------------------------------+
      |   ID    | RESOURCE TYPE | RESOURCE ID  | SEVERITY | STATE  |    CATEGORY     | VISIBILITY |        TITLE        |          DESCRIPTION           |
      +---------+---------------+--------------+----------+--------+-----------------+------------+---------------------+--------------------------------+
      | 1928... | MANAGED_<DB>  | c9qs90gna... | INFO     | ACTIVE | FAULT_TOLERANCE | DISMISSED  | Возможность         | В шарде data-manager не        |
      |         |               |              |          |        |                 |            | автомасштабирования | настроено автомасштабирование  |
      |         |               |              |          |        |                 |            |                     | дискового пространства.        |
      |         |               |              |          |        |                 |            |                     | Настройте автомасштабирование  |
      |         |               |              |          |        |                 |            |                     | для предотвращения             |
      |         |               |              |          |        |                 |            |                     | переполнения диска.            |
      ```

- REST API {#api}

  1. Получите IAM-токен для аутентификации в API и поместите токен в переменную среды окружения:
  
      ```bash
      export IAM_TOKEN="<IAM-токен>"
      ```
  
  1. Воспользуйтесь [методом](../api-design-guide/concepts/about-adviser.md) `Issue.List` и выполните запрос, например, с помощью [cURL](https://curl.se/), указав в параметре `visibilityFilter` значение `ISSUE_VISIBILITY_DISMISSED`:
  
      ```bash
      curl \
          --request GET \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --url 'https://adviser.api.cloud.yandex.net/adviser/v1/resourceIssues' \
          --url-query cloudId=<идентификатор_облака>&folderId=<идентификатор_каталога>&resourceId=<идентификатор_кластера>&visibilityFilter=ISSUE_VISIBILITY_DISMISSED
      ```
  
      Где:
  
      * `cloudId` — идентификатор облака. Обязательный параметр.
      * `folderId` — идентификатор каталога. Если параметр не указан, сервер вернет рекомендации для всех каталогов облака.
      * `resourceId` — идентификатор кластера. Если параметр не указан, сервер вернет рекомендации для всех ресурсов каталога или облака.
      * `visibilityFilter` — фильтр видимости рекомендаций. Чтобы получить скрытые рекомендации, укажите значение `ISSUE_VISIBILITY_DISMISSED`.
  
  1. Убедитесь, что запрос был выполнен успешно, изучив ответ сервера.
  
      {% cut "Пример ответа" %}
  
      ```json
      {
        "issues": [
          {
            "id": "1090...",
            "resource": {
              "type": "RESOURCE_TYPE_MANAGED_<DB>",
              "resourceId": "c9ql6kum9...",
              "folderId": "b1g681qpe...",
              "cloudId": "b1gia87mb..."
            },
            "createdAt": "2026-11-26T19:34:44.232731Z",
            "updatedAt": "2026-11-26T19:34:44.232731Z",
            "state": "ISSUE_STATE_ACTIVE",
            "severity": "ISSUE_SEVERITY_INFO",
            "category": "ISSUE_CATEGORY_FAULT_TOLERANCE",
            "visibility": "ISSUE_VISIBILITY_DISMISSED",
            "service": "mdb_adviser_cp_agent",
            "slug": "<db>_disk_autoscaling",
            "shortDescr": "Автомасштабирование дискового пространства не настроено",
            "fullDescr": "В шарде data-manager не настроено автомасштабирование дискового пространства. Настройте автомасштабирование для предотвращения переполнения диска.",
            "docUrl": "<ссылка на документацию>",
            "dismissalId": "...",
            "title": "Возможность автомасштабирования"
          },
          ...
        ]
      }
      ```
  
      {% endcut %}

- gRPC API {#grpc-api}

  1. Получите IAM-токен для аутентификации в API и поместите токен в переменную среды окружения:
  
      ```bash
      export IAM_TOKEN="<IAM-токен>"
      ```
  
  1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
     
     ```bash
     cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
     ```
     
     Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.
  
  1. Воспользуйтесь [вызовом](../api-design-guide/concepts/about-adviser.md) `IssueService.List` и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl), указав в поле `visibilityFilter` значение `ISSUE_VISIBILITY_DISMISSED`:
  
      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/adviser/v1/issue_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                  "cloud_id": "<идентификатор_облака>",
                  "folder_id": "<идентификатор_каталога>",
                  "resource_id": "<идентификатор_кластера>",
                  "visibilityFilter": "ISSUE_VISIBILITY_DISMISSED"
              }' \
          adviser.api.cloud.yandex.net:443 \
          yandex.cloud.adviser.v1.IssueService.List
      ```
  
      Где:
  
      * `cloud_id` — идентификатор облака. Обязательный параметр.
      * `folder_id` — идентификатор каталога. Если параметр не указан, сервер вернет рекомендации для всех каталогов облака.
      * `resource_id` — идентификатор кластера. Если параметр не указан, сервер вернет рекомендации для всех ресурсов каталога или облака.
      * `visibilityFilter` — фильтр видимости рекомендаций. Чтобы получить скрытые рекомендации, укажите значение `ISSUE_VISIBILITY_DISMISSED`.
  
  1. Убедитесь, что запрос был выполнен успешно, изучив ответ сервера.
  
      {% cut "Пример ответа" %}
  
      ```json
      {
        "issues": [
          {
            "id": "1090...",
            "resource": {
              "type": "RESOURCE_TYPE_MANAGED_<DB>",
              "resourceId": "c9ql6kum9...",
              "folderId": "b1g681qpe...",
              "cloudId": "b1gia87mb..."
            },
            "createdAt": "2026-11-26T19:34:44.232731Z",
            "updatedAt": "2026-11-26T19:34:44.232731Z",
            "state": "ISSUE_STATE_ACTIVE",
            "severity": "ISSUE_SEVERITY_INFO",
            "category": "ISSUE_CATEGORY_FAULT_TOLERANCE",
            "visibility": "ISSUE_VISIBILITY_DISMISSED",
            "service": "mdb_adviser_cp_agent",
            "slug": "<db>_disk_autoscaling",
            "shortDescr": "Автомасштабирование дискового пространства не настроено",
            "fullDescr": "В шарде data-manager не настроено автомасштабирование дискового пространства. Настройте автомасштабирование для предотвращения переполнения диска.",
            "docUrl": "<ссылка_на_документацию>",
            "dismissalId": "...",
            "title": "Возможность автомасштабирования"
          },
          ...
        ]
      }
      ```
  
      {% endcut %}

{% endlist %}