# Установка Filebeat

[Filebeat](https://www.elastic.co/beats/filebeat) — плагин, который позволяет собирать и передавать логи в экосистему Elastic Stack: {{ ES }}, Kibana, Logstash. [Filebeat](/marketplace/products/yc/filebeat) устанавливается в [кластер {{ managed-k8s-name }}](../../concepts/index.md#kubernetes-cluster), собирает логи кластера и [подов](../../concepts/index.md#pod), а затем отправляет их в сервис [{{ mes-full-name }}](../../../managed-elasticsearch/).

## Перед началом работы {#before-you-begin}

1. {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. Убедитесь, что кластер {{ managed-k8s-name }} расположен в той же [облачной сети](../../../vpc/concepts/network.md), что и кластер {{ mes-name }}.

## Установка с помощью {{ marketplace-full-name }} {#marketplace-install}

1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ managed-k8s-name }}**.
1. Нажмите на имя нужного кластера {{ k8s }} и выберите вкладку ![image](../../../_assets/marketplace.svg) **{{ marketplace-short-name }}**.
1. В разделе **Доступные для установки приложения** выберите [Filebeat](/marketplace/products/yc/filebeat) и нажмите кнопку **Использовать**.
1. Задайте настройки приложения:
   * **Пространство имен** — выберите [пространство имен](../../concepts/index.md#namespace) или создайте новое.
   * **Название приложения** — укажите название приложения, например `filebeat`.
   * **Имя пользователя {{ ES }}** — введите имя учетной записи, под которой Filebeat будет подключаться к кластеру {{ mes-name }}.
   * **Пароль для подключения к {{ ES }}** — введите пароль для учетной записи в кластере {{ mes-name }}.
   * **FQDN сервиса {{ ES }}** — укажите URL и порт для кластера {{ mes-name }}, например `https://c-c9q07rjo9c11q4e1p0om.rw.mdb.yandexcloud.net:9200`. Подробнее о подключении к кластеру см. в [документации сервиса](../../../managed-elasticsearch/operations/cluster-connect.md).
1. Нажмите кнопку **Установить**.
1. [Подключитесь к веб-интерфейсу Kibana](../../../managed-elasticsearch/quickstart.md#connect-kibana) и убедитесь, что события кластера {{ k8s }} начали поступать.

## Установка с помощью Helm-чарта {#helm-install}

1. {% include [Установка Helm](../../../_includes/managed-kubernetes/helm-install.md) %}

1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с Filebeat выполните команду:

   ```bash
   export HELM_EXPERIMENTAL_OCI=1 && \
   helm pull oci://{{ registry }}/yc-marketplace/yandex-cloud/filebeat/chart/filebeat \
     --version <версия Helm-чарта> \
     --untar && \
   helm install \
     --namespace <пространство имен> \
     --create-namespace \
     --set app.url='<URL и порт кластера {{ mes-name }}>' \
     --set app.username='<имя пользователя в кластере {{ ES }}>' \
     --set app.password='<пароль пользователя в кластере {{ ES }}>' \
     filebeat ./filebeat/
   ```

   Актуальную версию Helm-чарта можно посмотреть на [странице приложения](/marketplace/products/yc/filebeat#docker-images).

   Эта команда также создаст новое пространство имен, необходимое для работы Filebeat.
1. Убедитесь, что под Filebeat перешел в состояние `Running`:

   ```bash
   kubectl get pods --namespace=filebeat -l app=filebeat-filebeat -w
   ```

1. [Подключитесь к веб-интерфейсу Kibana](../../../managed-elasticsearch/quickstart.md#connect-kibana) и убедитесь, что события кластера {{ k8s }} начали поступать.

## См. также {#see-also}

* [Документация {{ mes-name }}](../../../managed-elasticsearch/).
* [Документация Filebeat](https://www.elastic.co/guide/en/beats/filebeat/master/index.html).