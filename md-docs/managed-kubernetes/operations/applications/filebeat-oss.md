# Установка Filebeat OSS


[Filebeat OSS](https://www.elastic.co/beats/filebeat) — плагин, который позволяет собирать и передавать логи в экосистему OpenSearch. Filebeat OSS устанавливается в [кластер Managed Service for Kubernetes](../../concepts/index.md#kubernetes-cluster), собирает логи кластера и [подов](../../concepts/index.md#pod), а затем отправляет их в сервис [Yandex Managed Service for OpenSearch](../../../managed-opensearch/index.md).

## Перед началом работы {#before-you-begin}

1. Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

   По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

1. Убедитесь, что кластер Managed Service for Kubernetes расположен в той же [облачной сети](../../../vpc/concepts/network.md), что и [кластер Managed Service for OpenSearch](../../../managed-opensearch/concepts/index.md).

1. [Убедитесь](../connect/security-groups.md), что группы безопасности для кластера Managed Service for Kubernetes и его групп узлов настроены корректно. Если отсутствует какое-либо из правил — [добавьте](../../../vpc/operations/security-group-add-rule.md) его.

    {% note warning %}
    
    От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
    
    {% endnote %}

1. Включите режим совместимости для поддержки клиента Filebeat OSS в OpenSearch. Для этого выполните запрос:

   ```bash
   wget "https://storage.yandexcloud.net/cloud-certs/CA.pem" && \
   curl \
   --user <имя_пользователя>:<пароль> --cacert CA.pem \
   --request PUT https://<имя_хоста_с_ролью_DATA>:9200/_cluster/settings \
   --header "Content-Type: application/json" \
   --data \
   '{
   "persistent": {
     "compatibility": {
       "override_main_response_version": true
     }
   }
   }'
   ```

   Где:
   * `<имя_пользователя>` — имя пользователя OpenSearch.
   * `<пароль>` — пароль пользователя OpenSearch.
   * `<имя_хоста>` — имя хоста Managed Service for OpenSearch с [ролью DATA](../../../managed-opensearch/concepts/host-roles.md#data), например, `rc1a-7hkolet********.mdb.yandexcloud.net`.

   Успешный ответ приходит в виде:

   ```json
   {
     "acknowledged":true,
     "persistent":
     {
       "compatibility":
       {
         "override_main_response_version":"true"
       }
     },
     "transient":{}
   }
   ```

## Установка с помощью Yandex Cloud Marketplace {#marketplace-install}

1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
1. Перейдите в сервис **Managed Service for&nbsp;Kubernetes**.
1. Нажмите на имя нужного кластера Managed Service for Kubernetes и выберите вкладку ![image](../../../_assets/marketplace.svg) **Marketplace**.
1. В разделе **Доступные для установки приложения** выберите [Filebeat OSS](https://yandex.cloud/ru/marketplace/products/yc/filebeat-oss) и нажмите кнопку **Перейти к установке**.
1. Задайте настройки приложения:
   * **Пространство имен** — создайте новое [пространство имен](../../concepts/index.md#namespace) (например, `filebeat-oss-space`). Если вы оставите пространство имен по умолчанию, Filebeat OSS может работать некорректно.
   * **Название приложения** — укажите название приложения, например `filebeat-oss`.
   * **Имя пользователя OpenSearch** — введите имя учетной записи, под которой Filebeat OSS будет подключаться к кластеру Managed Service for OpenSearch.
   * **Пароль для подключения к OpenSearch** — введите пароль для учетной записи в кластере Managed Service for OpenSearch.
   * **FQDN сервиса OpenSearch** — укажите URL и порт для хоста кластера Managed Service for OpenSearch с ролью DATA, например `https://rc1a-7hkolet********.mdb.yandexcloud.net:9200`. Подробнее о подключении к кластеру в [документации сервиса](../../../managed-opensearch/operations/connect/index.md).
1. Нажмите кнопку **Установить**.
1. Дождитесь перехода приложения в статус `Deployed`.

## Установка с помощью Helm-чарта {#helm-install}

1. [Установите менеджер пакетов Helm](https://helm.sh/ru/docs/intro/install/) версии не ниже 3.8.0.
1. [Установите kubectl](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](../connect/index.md#kubectl-connect).
1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с Filebeat OSS выполните команду:

   ```bash
   helm pull oci://cr.yandex/yc-marketplace/yandex-cloud/filebeat-oss/chart/filebeat-oss \
     --version 7.12.1-1 \
     --untar && \
   helm install \
     --namespace <пространство_имен> \
     --create-namespace \
     --set app.url='<URL_и_порт_для_хоста_кластера_Managed_Service_for_OpenSearch_с_ролью_DATA>' \
     --set app.username='<имя_пользователя_в_кластере_OpenSearch>' \
     --set app.password='<пароль_пользователя_в_кластере_OpenSearch>' \
     filebeatoss ./filebeat-oss/
   ```

   Эта команда также создаст новое пространство имен, необходимое для работы Filebeat OSS.

   Если вы укажете в параметре `namespace` пространство имен по умолчанию, Filebeat OSS может работать некорректно. Рекомендуем указывать значение, отличное от всех существующих пространств имен (например, `filebeat-oss-space`).

   {% note info %}
   
   Если вы используете версию Helm ниже 3.8.0, добавьте в начало команды строку `export HELM_EXPERIMENTAL_OCI=1 && \`, чтобы включить поддержку [Open Container Initiative](https://opencontainers.org/) (OCI) в клиенте Helm.
   
   {% endnote %}

1. Убедитесь, что под Filebeat OSS перешел в состояние `Running`:

   ```bash
   kubectl get pods --namespace=<пространство_имен> -l app=filebeatoss-filebeat-oss -w
   ```

## Примеры использования {#examples}

* [Мониторинг кластера Managed Service for Kubernetes с помощью Filebeat OSS](../../tutorials/filebeat-oss-monitoring.md).

## Полезные ссылки {#see-also}

* [Документация Managed Service for OpenSearch](../../../managed-opensearch/index.md).
* [Документация Filebeat](https://www.elastic.co/guide/en/beats/filebeat/master/index.html).