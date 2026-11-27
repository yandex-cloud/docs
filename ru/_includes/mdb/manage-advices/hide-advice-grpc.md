1. Получите IAM-токен для аутентификации в API и поместите токен в переменную среды окружения:

    {% include [api-auth-token](../../mdb/api-auth-token.md) %}

1. {% include [grpc-api-setup-repo](../../mdb/grpc-api-setup-repo.md) %}

1. Получите идентификатор рекомендации, которую нужно скрыть, с помощью [вызова](../../../api-design-guide/concepts/about-adviser.md) `IssueService.List`.

1. Воспользуйтесь вызовом `IssueService.Dismiss` и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

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
        adviser.{{ api-host }}:{{ port-https }} \
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
