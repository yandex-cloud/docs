{% note alert %}

Если бакет зарегистрирован в кластере {{ OS }} как репозиторий [снапшотов](../../glossary/snapshot.md), не изменяйте содержимое бакета вручную — это нарушит работу механизма снапшотов {{ OS }}.

{% endnote %}

1. [Подключитесь](../../managed-opensearch/operations/connect/index.md) к кластеру.
1. Зарегистрируйте бакет как репозиторий снапшотов, используя публичный [API {{ OS }}]({{ os.docs }}/opensearch/snapshot-restore/#register-repository):

    ```http
    PUT --cacert ~/.opensearch/root.crt https://admin:<пароль>@<идентификатор_хоста_{{ OS }}_с_ролью_DATA>.{{ dns-zone }}:{{ port-mos }}/_snapshot/<имя_репозитория>
    ```

    В параметрах запроса укажите бакет, связанный с сервисным аккаунтом кластера:

    ```bash
    curl --request PUT \
         "https://admin:<пароль>@<идентификатор_хоста_{{ OS }}_с_ролью_DATA>.{{ dns-zone }}:{{ port-mos }}/_snapshot/<имя_репозитория>" \
         --cacert ~/.opensearch/root.crt \
         --header "Content-Type: application/json" \
         --data '{
           "type": "s3",
           "settings": {
             "endpoint": "{{ s3-storage-host }}",
             "bucket": "<имя_бакета>"
           }
         }'
    ```
