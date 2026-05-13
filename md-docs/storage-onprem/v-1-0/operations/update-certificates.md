# Обновление сертификатов

Чтобы обновить или установить сертификаты для S3 API или консоли управления:

1. Подключитесь к любому из мастеров кластера Kubernetes.
1. Скопируйте сертификат и приватный ключ на мастер Kubernetes.
1. Обновите поля секрета `init-secret` в пространстве имен `shared-secrets`:

    * `goose_web_tls_crt`, `goose_web_tls_key` — сертификат и ключ для S3 API.
    * `console_tls_crt`, `console_tls_key` — сертификат и ключ консоли управления.

    Для обновления поля секрета из файла выполните команду. Например, для обновления `goose_web_tls_crt` из файла `server.crt`:

    ```bash
    kubectl patch secret init-secret -n shared-secrets \
      --type=json \
      -p='[{"op": "replace", "path": "/data/goose_web_tls_crt", "value": "'$(cat ./server.crt | base64 | tr -d '\n')'"}]'
    ```

    Аналогично обновите другие поля секрета для соответствующих сертификатов и ключей.

1. Перезапустите сервис:

    {% note info %}

    При перезапуске применяются те же условия доступности и производительности, что и при выполнении обновления.

    {% endnote %}

    * Для S3 API:

        ```bash
        kubectl rollout restart deployment goose-proxy -n s3-goose-proxy
        ```

    * Для консоли управления:

        ```bash
        kubectl rollout restart deployment zitadel-console -n zitadel
        ```