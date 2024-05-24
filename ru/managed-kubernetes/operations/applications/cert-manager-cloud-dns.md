# Установка cert-manager c плагином {{ dns-full-name }} ACME webhook


[cert-manager](https://cert-manager.io) — приложение, которое добавляет сертификаты и эмитентов сертификатов в качестве типов ресурсов в [кластерах {{ managed-k8s-name }}](../../concepts/index.md#kubernetes-cluster) и упрощает процесс получения, обновления и использования этих сертификатов. Например, при получении сертификатов [Let's Encrypt®](https://letsencrypt.org/) можно пройти следующие виды [проверок](https://letsencrypt.org/ru/docs/challenge-types) для подтверждения владения доменом:

* [DNS-01](https://letsencrypt.org/ru/docs/challenge-types/#проверка-dns-01). Для прохождения проверки используется сервис [{{ dns-full-name }}](../../../dns/). Вместе с cert-manager устанавливается плагин {{ dns-full-name }} ACME webhook, который обеспечивает интеграцию с сервисом.
* [HTTP-01](https://letsencrypt.org/ru/docs/challenge-types/#проверка-http-01). Для прохождения проверки используется Ingress-контроллер, который нужно установить в кластер.

## Перед началом работы {#before-you-begin}

1. {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. Убедитесь, что кластер {{ managed-k8s-name }} расположен в том же [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder), что и [публичная зона {{ dns-name }}](../../../dns/concepts/dns-zone.md#public-zones).

1. {% include [check-sg-prerequsites](../../../_includes/managed-kubernetes/security-groups/check-sg-prerequsites-lvl3.md) %}

    {% include [sg-common-warning](../../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

1. {% include [Настройка kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}
1. [Создайте](../../../iam/operations/sa/create.md) сервисный аккаунт, необходимый для работы cert-manager.
1. [Назначьте](../../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту роль `dns.editor` на каталог, где расположена публичная зона DNS.
1. [Создайте](../../../iam/operations/authorized-key/create.md) авторизованный ключ для этого сервисного аккаунта и сохраните ключ в файл `key.json`.

## Установка с помощью {{ marketplace-full-name }} {#marketplace-install}

1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Нажмите на имя нужного кластера {{ managed-k8s-name }} и выберите вкладку ![image](../../../_assets/console-icons/shopping-cart.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}**.
1. В разделе **Доступные для установки приложения** выберите [cert-manager c плагином {{ dns-full-name }} ACME webhook](/marketplace/products/yc/cert-manager-webhook-yandex) и нажмите кнопку **{{ ui-key.yacloud.marketplace-v2.button_use }}**.
1. Задайте настройки приложения:
   * **Пространство имен** — выберите [пространство имен](../../concepts/index.md#namespace) или создайте новое.
   * **Название приложения** — укажите название приложения, например, `cert-manager`.
   * **Ключ сервисной учетной записи** — вставьте содержимое файла `key.json` или создайте новый [ключ](../../../iam/concepts/authorization/key.md).
   * **ID каталога** — укажите идентификатор каталога, в котором находится зона {{ dns-name }}, для подтверждения владением доменом при проверке DNS-01.
   * **Адрес электронной почты для получения уведомлений от Let's Encrypt** — укажите адрес электронной почты для получения оповещений от Let's Encrypt®.
   * **Адрес сервера Let's Encrypt** — выберите из списка адрес сервера Let's Encrypt®:
     * `https://acme-v02.api.letsencrypt.org/directory` — основной URL.
     * `https://acme-staging-v02.api.letsencrypt.org/directory` — тестовый URL.
1. Нажмите кнопку **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.
1. Дождитесь перехода приложения в статус `{{ ui-key.yacloud.k8s.cluster.marketplace.label_release-status-DEPLOYED }}`.

## Установка с помощью Helm-чарта {#helm-install}

1. {% include [Установка Helm](../../../_includes/managed-kubernetes/helm-install.md) %}

1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с cert-manager и плагином {{ dns-full-name }} выполните команду:

   ```bash
   export HELM_EXPERIMENTAL_OCI=1 && \
   helm pull oci://{{ mkt-k8s-key.yc_cert-manager-webhook-yandex.helmChart.name }} \
     --version {{ mkt-k8s-key.yc_cert-manager-webhook-yandex.helmChart.tag }} \
     --untar && \
   helm install \
     --namespace <пространство_имен> \
     --create-namespace \
     --set-file config.auth.json=key.json \
     --set config.email='<адрес_электронной_почты_для_уведомлений_от_Lets_Encrypt>' \
     --set config.folder_id='<идентификатор_каталога_с_зоной_Cloud_DNS>' \
     --set config.server='URL_сервера_Lets_Encrypt' \
     cert-manager-webhook-yandex ./cert-manager-webhook-yandex/
   ```

   В качестве URL сервера Let's Encrypt® используйте:
   * `https://acme-v02.api.letsencrypt.org/directory` — основной URL.
   * `https://acme-staging-v02.api.letsencrypt.org/directory` — тестовый URL.

   Эта команда также создаст новое пространство имен, необходимое для работы cert-manager.
1. Убедитесь, что [под](../../concepts/index.md#pod) cert-manager перешел в состояние `Running`:

   ```bash
   kubectl get pods --namespace=<пространство_имен> -l app=cert-manager-webhook-yandex -w
   ```

## Получение тестового сертификата {#issue-certificate}

Чтобы проверить работоспособность установленного приложения, получите тестовый сертификат. Для выпуска сертификата будет использоваться эмитент `yc-clusterissuer`. Он создается при установке cert-manager и уже настроен на работу с провайдером Let's Encrypt®.

1. Создайте файл `certificate.yaml`, содержащий запрос на тестовый сертификат:

   ```yaml
   apiVersion: cert-manager.io/v1
   kind: Certificate
   metadata:
     name: domain-name
     namespace: <пространство_имен>
   spec:
     secretName: domain-name-secret
     issuerRef:
       # ClusterIssuer, созданный вместе с {{ dns-full-name }} ACME webhook.
       name: yc-clusterissuer
       kind: ClusterIssuer
     dnsNames:
       # Домен должен входить в вашу публичную зону {{ dns-name }}.
       # Указывается имя домена (например, test.example.com), а не имя DNS-записи.
       - <имя_домена>
   ```

1. Установите сертификат в кластер {{ managed-k8s-name }}:

   ```bash
   kubectl apply -f certificate.yaml
   ```

1. Проверьте готовность сертификата:

   ```bash
   kubectl get certificate
   ```

   Результат:

   ```text
   NAME         READY  SECRET              AGE
   domain-name  True   domain-name-secret  45m
   ```

    Статус `True` в колонке `READY` означает, что сертификат был выпущен успешно.

1. (Опционально) получите подробную информацию о сертификате:

    ```bash
    kubectl -n <пространство_имен> describe certificate domain-name
    ```

    {% include [События cert-manager при выпуске сертификата](../../../_includes/managed-kubernetes/cert-manager-events-explained.md) %}

## Примеры использования {#examples}

* [{#T}](../../tutorials/dnschallenge.md).
* [{#T}](../../tutorials/ingress-cert-manager.md).

## См. также {#see-also}

* [Документация Let's Encrypt®](https://letsencrypt.org/docs/client-options/).
* [Документация cert-manager](https://cert-manager.io/docs/configuration/).
