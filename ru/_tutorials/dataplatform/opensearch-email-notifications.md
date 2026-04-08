# Отправка оповещений по электронной почте в {{ mos-full-name }}

Вы можете настроить отправку оповещений по почте с помощью [плагина](../../managed-opensearch/concepts/plugins.md) Notifications в [{{ mos-name }}](../../managed-opensearch/index.yaml). Для этого в веб-интерфейсе {{ OS }} Dashboards необходимо создать канал уведомлений, настроить SMTP отправителя и указать получателей. Пароль отправителя необходимо добавить в хранилище ключей {{ OS }}.

Чтобы настроить отправку оповещений по почте, выполните следующие действия:

1. [Подготовьте инфраструктуру](#infra).
1. [Создайте отправителя](#create-sender).
1. [Добавьте данные аутентификации в хранилище ключей {{ OS }}](#set-keystore-settings).
1. [Обновите настройки кластера](#reload_secure_settings).
1. [Создайте группу получателей](#create-recipient-group).
1. [Создайте канал уведомлений](#create-channel).
1. [Отправьте тестовое письмо](#send-email).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

* Кластер {{ mos-name }}: использование вычислительных ресурсов и объем хранилища (см. [тарифы {{ mos-name }}](../../managed-opensearch/pricing.md)).
* Публичные IP-адреса, если для хостов кластера включен публичный доступ (см. [тарифы {{ vpc-name }}](../../vpc/pricing.md)).


## Подготовьте инфраструктуру {#infra}


1. [Создайте кластер {{ mos-name }}](../../managed-opensearch/operations/cluster-create.md) с публичным доступом к группам хостов Dashboards и {{ OS }}.

1. Настройте группы безопасности кластера {{ mos-name }} следующим образом:

    1. [Создайте правила](../../managed-opensearch/operations/connect/index.md#security-groups) для доступа к группам хостов Dashboards и {{ OS }} через интернет.
    1. Создайте правило для исходящего трафика, разрешающее TCP-подключения на порт `465` или другой порт, который будет использоваться для отправки оповещений по почте.


## Создайте отправителя {#create-sender}

1. [Подключитесь к {{ OS }} Dashboards](../../managed-opensearch/operations/connect/clients.md#dashboards).
1. В левом верхнем углу {{ OS }} Dashboards нажмите на значок ![image](../../_assets/console-icons/bars.svg) и в блоке **Management** выберите **Notifications**.
1. На панели слева выберите пункт **Email senders**.
1. Нажмите кнопку **Create SMTP sender**.
1. В поле **Sender name** введите `my_sender`.
1. В поле **Email address** введите адрес почты, с которой будут отправляться оповещения.
1. Заполните поля **Host** и **Port**.
    
    Для указанного порта должен быть [разрешен](#infra) исходящий трафик в группах безопасности кластера.

1. В поле **Encryption method** выберите метод шифрования, который поддерживается SMTP-сервером отправителя.
1. Нажмите кнопку **Create**.

## Добавьте данные аутентификации в хранилище ключей {{ OS }} {#set-keystore-settings}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы добавить данные аутентификации в хранилище ключей {{ OS }}, выполните команду:

  ```bash
  {{ yc-mdb-os }} cluster update <имя_или_идентификатор_кластера> \
    --set-keystore-settings opensearch.notifications.core.email.my_sender.username=<почта_отправителя> \
    --set-keystore-settings opensearch.notifications.core.email.my_sender.password=<пароль>
  ```

  Имя и идентификатор кластера можно получить со [списком кластеров в каталоге](../../managed-opensearch/operations/cluster-list.md#list-clusters).

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../../managed-opensearch/api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}
  
  1. Воспользуйтесь методом [Cluster.Update](../../managed-opensearch/api-ref/Cluster/update.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

      ```bash
      curl \
        --request PATCH \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/<идентификатор_кластера>' \
        --data '{
                 "updateMask": "configSpec.opensearchSpec.setKeystoreSettings",
                 "configSpec": {
                   "opensearchSpec": {
                     "setKeystoreSettings": [
                       {
                         "name": "opensearch.notifications.core.email.my_sender.username",
                         "value": "<почта_отправителя>"
                       },
                       {
                         "name": "opensearch.notifications.core.email.my_sender.password",
                         "value": "<пароль>"
                       }
                     ]
                   }
                 }
               }'
      ```

      {% note warning %}

      Все настройки изменяемого объекта в кластере, которые не были явно переданы в запросе, будут переопределены на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask`.

      {% endnote %}
      
      Идентификатор кластера можно получить со [списком кластеров в каталоге](../../managed-opensearch/operations/cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../managed-opensearch/api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../../managed-opensearch/api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Воспользуйтесь вызовом [ClusterService.Update](../../managed-opensearch/api-ref/grpc/Cluster/update.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/opensearch/v1/cluster_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
             "cluster_id": "<идентификатор_кластера>",
             "update_mask": {
               "paths": [
                 "config_spec.opensearch_spec.set_keystore_settings"
                ]
             },
             "config_spec": {
               "opensearch_spec": {
                 "set_keystore_settings": [
                   {
                     "name": "opensearch.notifications.core.email.my_sender.username",
                     "value": "<почта_отправителя>"
                   },
                   {
                     "name": "opensearch.notifications.core.email.my_sender.password",
                     "value": "<пароль>"
                   }
                 ]
               }
             }
           }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.opensearch.v1.ClusterService.Update
        ```

        {% note warning %}

        Все настройки изменяемого объекта в кластере, которые не были явно переданы в запросе, будут переопределены на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `update_mask`.

        {% endnote %}

        Идентификатор кластера можно получить со [списком кластеров в каталоге](../../managed-opensearch/operations/cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../managed-opensearch/api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

После добавления ключей [обновите](#reload_secure_settings) защищенные настройки кластера.

## Обновите настройки кластера {#reload_secure_settings}

1. Установите SSL-сертификат:

    {% list tabs group=operating_system %}
    
    - Linux (Bash)/macOS (Zsh) {#linux-macos}
    
      ```bash
      mkdir -p ~/.opensearch && \
      wget "{{ crt-web-path }}" \
           --output-document ~/.opensearch/root.crt && \
      chmod 0600 ~/.opensearch/root.crt
      ```
    
      Сертификат будет сохранен в файле `~/.opensearch/root.crt`.
    
    - Windows (PowerShell) {#windows}

      ```powershell
      mkdir $HOME\.opensearch; curl.exe -o $HOME\.opensearch\root.crt {{ crt-web-path }}
      ```

      Сертификат будет сохранен в файле `$HOME\.opensearch\root.crt`.

      {% note warning %}
       
      Загрузка сертификата может быть ограничена корпоративными политиками или антивирусом.

      {% endnote %}
    
    {% endlist %}

1. Обновите защищенные настройки кластера:

    {% list tabs group=operating_system %}

    - Linux (Bash)/macOS (Zsh) {#linux-macos}

      ```bash
      curl \
        --user admin:<пароль>
        --cacert ~/.opensearch/root.crt \
        -X POST 'https://<FQDN_хоста_с_ролью_DATA>:{{ port-mos }}/_nodes/reload_secure_settings'
      ```

    - Windows (PowerShell) {#windows}

      ```powershell
      curl `
        -Certificate $HOME\.opensearch\root.crt `
        -Uri https://<FQDN_хоста_с_ролью_DATA>:{{ port-mos }}/_nodes/reload_secure_settings `
        -Method Post `
        -Credential admin
      ```

    {% endlist %}

    Подробнее о получении FQDN хоста читайте в разделе [{#T}](../../managed-opensearch/operations/connect/fqdn.md).

## Создайте группу получателей {#create-recipient-group}

1. В левом верхнем углу {{ OS }} Dashboards нажмите на значок ![image](../../_assets/console-icons/bars.svg) и в блоке **Management** выберите **Notifications**.
1. На панели слева выберите пункт **Email recipient groups**.
1. Нажмите кнопку **Create recipient group**.
1. В поле **Name** введите `my_recipient_group`.
1. В поле **Emails** выберите или введите почтовые адреса, которые вы хотите добавить в группу получателей оповещений.
1. Нажмите кнопку **Create**.

## Создайте канал уведомлений {#create-channel}

1. В левом верхнем углу {{ OS }} Dashboards нажмите на значок ![image](../../_assets/console-icons/bars.svg) и в блоке **Management** выберите **Notifications**.
1. Нажмите кнопку **Create channel**.
1. В поле **Name** введите `my_channel`.
1. В поле **Channel type** выберите `Email`.
1. В поле **Sender type** выберите `SMTP sender`.
1. В поле **SMTP sender** выберите `my_sender`.
1. В поле **Default recipients** выберите `my_recipient_group`.
1. Нажмите кнопку **Create**.

## Отправьте тестовое письмо {#send-email}

1. В левом верхнем углу {{ OS }} Dashboards нажмите на значок ![image](../../_assets/console-icons/bars.svg) и в блоке **Management** выберите **Notifications**.
1. В списке каналов нажмите на имя `my_channel`. 
1. В меню **Actions** выберите пункт **Send test message**.

{% note warning %}

Если параметры SMTP отправителя заданы неверно, оповещения отправляться не будут.

{% endnote %}

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

[Удалите кластер {{ mos-name }}](../../managed-opensearch/operations/cluster-delete.md).
