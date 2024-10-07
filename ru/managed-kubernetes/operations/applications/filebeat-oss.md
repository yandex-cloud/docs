# Установка Filebeat OSS


[Filebeat OSS](https://www.elastic.co/beats/filebeat) — плагин, который позволяет собирать и передавать логи в экосистему {{ OS }}. Filebeat OSS устанавливается в [кластер {{ managed-k8s-name }}](../../concepts/index.md#kubernetes-cluster), собирает логи кластера и [подов](../../concepts/index.md#pod), а затем отправляет их в сервис [{{ mos-full-name }}](../../../managed-opensearch/).

## Перед началом работы {#before-you-begin}

1. {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. Убедитесь, что кластер {{ managed-k8s-name }} расположен в той же [облачной сети](../../../vpc/concepts/network.md), что и [кластер {{ mos-name }}](../../../managed-opensearch/concepts/index.md).

1. {% include [check-sg-prerequsites](../../../_includes/managed-kubernetes/security-groups/check-sg-prerequsites-lvl3.md) %}

    {% include [sg-common-warning](../../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

1. Включите режим совместимости для поддержки клиента Filebeat OSS в {{ OS }}. Для этого выполните запрос:

   ```bash
   wget "{{ crt-web-path }}" && \
   curl \
   --user <имя_пользователя>:<пароль> --cacert CA.pem \
   --request PUT https://<имя_хоста_с_ролью_DATA>:{{ port-mos }}/_cluster/settings \
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
   * `<имя_пользователя>` — имя пользователя {{ OS }}.
   * `<пароль>` — пароль пользователя {{ OS }}.
   * `<имя_хоста>` — имя хоста {{ mos-name }} с [ролью DATA](../../../managed-opensearch/concepts/host-roles.md#data), например, `rc1a-6khpaeo31lacqo21.mdb.yandexcloud.net`.

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

## Установка с помощью {{ marketplace-full-name }} {#marketplace-install}

1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ managed-k8s-name }}**.
1. Нажмите на имя нужного кластера {{ managed-k8s-name }} и выберите вкладку ![image](../../../_assets/marketplace.svg) **{{ marketplace-short-name }}**.
1. В разделе **{{ ui-key.yacloud.marketplace-v2.label_available-products }}** выберите [Filebeat OSS](/marketplace/products/yc/filebeat-oss) и нажмите кнопку **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
1. Задайте настройки приложения:
   * **Пространство имен** — выберите [пространство имен](../../concepts/index.md#namespace) или создайте новое.
   * **Название приложения** — укажите название приложения, например `filebeat-oss`.
   * **Имя пользователя {{ OS }}** — введите имя учетной записи, под которой Filebeat OSS будет подключаться к кластеру {{ mos-name }}.
   * **Пароль для подключения к {{ OS }}** — введите пароль для учетной записи в кластере {{ mos-name }}.
   * **FQDN сервиса {{ OS }}** — укажите URL и порт для хоста кластера {{ mos-name }} с ролью DATA, например `https://rc1a-6khpaeo31lacqo21.mdb.yandexcloud.net:9200`. Подробнее о подключении к кластеру см. в [документации сервиса](../../../managed-opensearch/operations/connect.md).
1. Нажмите кнопку **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.
1. Дождитесь перехода приложения в статус `Deployed`.

## Установка с помощью Helm-чарта {#helm-install}

1. {% include [Установка Helm](../../../_includes/managed-kubernetes/helm-install.md) %}
1. {% include [Install and configure kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}
1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с Filebeat OSS выполните команду:

   ```bash
   helm pull oci://{{ mkt-k8s-key.yc_filebeat-oss.helmChart.name }} \
     --version {{ mkt-k8s-key.yc_filebeat-oss.helmChart.tag }} \
     --untar && \
   helm install \
     --namespace <пространство_имен> \
     --create-namespace \
     --set app.url='<URL_и_порт_для_хоста_кластера_Managed_Service_for_{{ OS }}_с_ролью_DATA>' \
     --set app.username='<имя_пользователя_в_кластере_{{ OS }}>' \
     --set app.password='<пароль_пользователя_в_кластере_{{ OS }}>' \
     filebeatoss ./filebeat-oss/
   ```

   Эта команда также создаст новое пространство имен, необходимое для работы Filebeat OSS.

   {% include [Support OCI](../../../_includes/managed-kubernetes/note-helm-experimental-oci.md) %}

1. Убедитесь, что под Filebeat OSS перешел в состояние `Running`:

   ```bash
   kubectl get pods --namespace=<пространство_имен> -l app=filebeatoss-filebeat-oss -w
   ```

## Примеры использования {#examples}

* [Мониторинг кластера {{ managed-k8s-name }} с помощью Filebeat OSS](../../tutorials/filebeat-oss-monitoring.md).

## См. также {#see-also}

* [Документация {{ mos-name }}](../../../managed-opensearch/).
* [Документация Filebeat](https://www.elastic.co/guide/en/beats/filebeat/master/index.html).
