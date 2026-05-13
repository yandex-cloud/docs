# Отправка оповещений по электронной почте в Yandex Managed Service for OpenSearch

# Отправка оповещений по электронной почте в Yandex Managed Service for OpenSearch

Вы можете настроить отправку оповещений по почте с помощью [плагина](../../managed-opensearch/concepts/plugins.md) Notifications в [Managed Service for OpenSearch](../../managed-opensearch/index.md). Для этого в веб-интерфейсе OpenSearch Dashboards необходимо создать канал уведомлений, настроить SMTP отправителя и указать получателей. Пароль отправителя необходимо добавить в хранилище ключей OpenSearch.

Чтобы настроить отправку оповещений по почте, выполните следующие действия:

1. [Подготовьте инфраструктуру](#infra).
1. [Создайте отправителя](#create-sender).
1. [Добавьте данные аутентификации в хранилище ключей OpenSearch](#set-keystore-settings).
1. [Обновите настройки кластера](#reload_secure_settings).
1. [Создайте группу получателей](#create-recipient-group).
1. [Создайте канал уведомлений](#create-channel).
1. [Отправьте тестовое письмо](#send-email).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

* Кластер Managed Service for OpenSearch: использование вычислительных ресурсов и объем хранилища (см. [тарифы Managed Service for OpenSearch](../../managed-opensearch/pricing.md)).
* Публичные IP-адреса, если для хостов кластера включен публичный доступ (см. [тарифы Virtual Private Cloud](../../vpc/pricing.md)).


## Подготовьте инфраструктуру {#infra}


1. [Создайте кластер Managed Service for OpenSearch](../../managed-opensearch/operations/cluster-create.md) с публичным доступом к группам хостов Dashboards и OpenSearch.

1. Настройте группы безопасности кластера Managed Service for OpenSearch следующим образом:

    1. [Создайте правила](../../managed-opensearch/operations/connect/index.md#security-groups) для доступа к группам хостов Dashboards и OpenSearch через интернет.
    1. Создайте правило для исходящего трафика, разрешающее TCP-подключения на порт `465` или другой порт, который будет использоваться для отправки оповещений по почте.


## Создайте отправителя {#create-sender}

1. [Подключитесь к OpenSearch Dashboards](../../managed-opensearch/operations/connect/clients.md#dashboards).
1. В левом верхнем углу OpenSearch Dashboards нажмите на значок ![image](../../_assets/console-icons/bars.svg) и в блоке **Management** выберите **Notifications**.
1. На панели слева выберите пункт **Email senders**.
1. Нажмите кнопку **Create SMTP sender**.
1. В поле **Sender name** введите `my_sender`.
1. В поле **Email address** введите адрес почты, с которой будут отправляться оповещения.
1. Заполните поля **Host** и **Port**.
    
    Для указанного порта должен быть [разрешен](#infra) исходящий трафик в группах безопасности кластера.

1. В поле **Encryption method** выберите метод шифрования, который поддерживается SMTP-сервером отправителя.
1. Нажмите кнопку **Create**.

## Добавьте данные аутентификации в хранилище ключей OpenSearch {#set-keystore-settings}

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы добавить данные аутентификации в хранилище ключей OpenSearch, выполните команду:

  ```bash
  yc managed-opensearch cluster update <имя_или_идентификатор_кластера> \
    --set-keystore-settings opensearch.notifications.core.email.my_sender.username=<почта_отправителя> \
    --set-keystore-settings opensearch.notifications.core.email.my_sender.password=<пароль>
  ```

  Имя и идентификатор кластера можно получить со [списком кластеров в каталоге](../../managed-opensearch/operations/cluster-list.md#list-clusters).

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../../managed-opensearch/api-ref/authentication.md) и поместите токен в переменную среды окружения:

      ```bash
      export IAM_TOKEN="<IAM-токен>"
      ```
  
  1. Воспользуйтесь методом [Cluster.Update](../../managed-opensearch/api-ref/Cluster/update.md) и выполните запрос, например с помощью [cURL](https://curl.se/):

      ```bash
      curl \
        --request PATCH \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://mdb.api.cloud.yandex.net/managed-opensearch/v1/clusters/<идентификатор_кластера>' \
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

      ```bash
      export IAM_TOKEN="<IAM-токен>"
      ```

  1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
     
     ```bash
     cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
     ```
     
     Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.

  1. Воспользуйтесь вызовом [ClusterService.Update](../../managed-opensearch/api-ref/grpc/Cluster/update.md) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

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
        mdb.api.cloud.yandex.net:443 \
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
      wget "https://storage.yandexcloud.net/cloud-certs/CA.pem" \
           --output-document ~/.opensearch/root.crt && \
      chmod 0600 ~/.opensearch/root.crt
      ```
    
      Сертификат будет сохранен в файле `~/.opensearch/root.crt`.
    
    - Windows (PowerShell) {#windows}

      ```powershell
      mkdir $HOME\.opensearch; curl.exe -o $HOME\.opensearch\root.crt https://storage.yandexcloud.net/cloud-certs/CA.pem
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
        -X POST 'https://<FQDN_хоста_с_ролью_DATA>:9200/_nodes/reload_secure_settings'
      ```

    - Windows (PowerShell) {#windows}

      ```powershell
      curl `
        -Certificate $HOME\.opensearch\root.crt `
        -Uri https://<FQDN_хоста_с_ролью_DATA>:9200/_nodes/reload_secure_settings `
        -Method Post `
        -Credential admin
      ```

    {% endlist %}

    Подробнее о получении FQDN хоста читайте в разделе [FQDN хостов OpenSearch](../../managed-opensearch/operations/connect/fqdn.md).

## Создайте группу получателей {#create-recipient-group}

1. В левом верхнем углу OpenSearch Dashboards нажмите на значок ![image](../../_assets/console-icons/bars.svg) и в блоке **Management** выберите **Notifications**.
1. На панели слева выберите пункт **Email recipient groups**.
1. Нажмите кнопку **Create recipient group**.
1. В поле **Name** введите `my_recipient_group`.
1. В поле **Emails** выберите или введите почтовые адреса, которые вы хотите добавить в группу получателей оповещений.
1. Нажмите кнопку **Create**.

## Создайте канал уведомлений {#create-channel}

1. В левом верхнем углу OpenSearch Dashboards нажмите на значок ![image](../../_assets/console-icons/bars.svg) и в блоке **Management** выберите **Notifications**.
1. Нажмите кнопку **Create channel**.
1. В поле **Name** введите `my_channel`.
1. В поле **Channel type** выберите `Email`.
1. В поле **Sender type** выберите `SMTP sender`.
1. В поле **SMTP sender** выберите `my_sender`.
1. В поле **Default recipients** выберите `my_recipient_group`.
1. Нажмите кнопку **Create**.

## Отправьте тестовое письмо {#send-email}

1. В левом верхнем углу OpenSearch Dashboards нажмите на значок ![image](../../_assets/console-icons/bars.svg) и в блоке **Management** выберите **Notifications**.
1. В списке каналов нажмите на имя `my_channel`. 
1. В меню **Actions** выберите пункт **Send test message**.

{% note warning %}

Если параметры SMTP отправителя заданы неверно, оповещения отправляться не будут.

{% endnote %}

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

[Удалите кластер Managed Service for OpenSearch](../../managed-opensearch/operations/cluster-delete.md).