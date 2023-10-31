1. Добавьте сведения о ключе статического доступа в [хранилище ключей]({{ links.es.docs }}/elasticsearch/reference/current/elasticsearch-keystore.html) (keystore) {{ ES }}.

   {% note info %}

   Выполните процедуру на всех хостах кластера-источника.

   {% endnote %}

   Добавьте:

   * **Идентификатор ключа**:

       ```bash
       $ES_PATH/bin/elasticsearch-keystore add s3.client.default.access_key
       ```

   * **Секретный ключ**:

       ```bash
       $ES_PATH/bin/elasticsearch-keystore add s3.client.default.secret_key
       ```

   {% note info %}

   Путь к {{ ES }} (`$ES_PATH`) зависит от выбранного способа установки. Найти путь к установленному {{ ES }} можно в [документации по установке]({{ links.es.docs }}/elasticsearch/reference/current/install-elasticsearch.html) (например, для [DEB]({{ links.es.docs }}/elasticsearch/reference/current/deb.html#deb-layout), [RPM]({{ links.es.docs }}/elasticsearch/reference/current/rpm.html#rpm-layout)).

   {% endnote %}

1. Загрузите данные из хранилища ключей:

   ```bash
   curl --request POST "https://<IP-адрес_или_FQDN_хоста_с_ролью_DATA_в_кластере-источнике>:{{ port-mes }}/_nodes/reload_secure_settings"
   ```

1. Зарегистрируйте репозиторий:

   ```bash
   curl --request PUT \
        "https://<IP-адрес_или_FQDN_хоста_с_ролью_DATA_в_кластере-источнике>:{{ port-mes }}/_snapshot/<имя_репозитория>" \
        --header 'Content-Type: application/json' \
        --data '{
          "type": "s3",
          "settings": {
            "bucket": "<имя_бакета>",
            "endpoint": "{{ s3-storage-host }}"
          }
        }'
   ```