1. Получите IAM-токен для аутентификации в API и поместите токен в переменную среды окружения:

    {% include [api-auth-token](../../mdb/api-auth-token.md) %}

1. Получите идентификатор рекомендации, которую нужно скрыть, с помощью [метода](../../../api-design-guide/concepts/about-adviser.md) `Issue.List`.

1. Воспользуйтесь методом `Issue.Dismiss` и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

    ```bash
    curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://adviser.{{ api-host }}/adviser/v1/resourceIssues/<идентификатор_рекомендации>:dismiss' \
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
