Если у вас еще нет интерфейса командной строки {{ TR }}, установите его по [инструкции на официальном сайте {{ TR }}](https://trino.io/docs/current/client/cli.html#installation).

Чтобы подключиться к кластеру {{ mtr-name }}:

1. Создайте [IAM-токен](../../iam/concepts/authorization/iam-token.md) и поместите его в переменную окружения `TRINO_PASSWORD`:

   ```bash
   export TRINO_PASSWORD=$(yc iam create-token)
   ```

   IAM-токен, хранящийся в переменной `TRINO_PASSWORD`, служит паролем для подключения к кластеру {{ mtr-name }}. Чтобы использовать его, укажите при подключении флаг `--password`.

1. Подключитесь к кластеру {{ mtr-name }}:

   ```bash
   ./trino <URL_координатора> --user iam --password
   ```

   Вы можете скопировать URL координатора в поле **{{ ui-key.yacloud.trino.overview.title_resource-coordinator }}** на странице обзора кластера {{ TR }} в [Консоли управления]({{ link-console-main }}).
