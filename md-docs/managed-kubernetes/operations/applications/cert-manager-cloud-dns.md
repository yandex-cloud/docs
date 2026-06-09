# Установка cert-manager c плагином {{ dns-full-name }} ACME webhook


[cert-manager](https://cert-manager.io) — приложение, которое добавляет сертификаты и эмитентов сертификатов в качестве типов ресурсов в [кластерах {{ managed-k8s-name }}](../../concepts/index.md#kubernetes-cluster) и упрощает процесс получения, обновления и использования этих сертификатов. Например, при получении сертификатов [Let's Encrypt®](https://letsencrypt.org/) можно пройти следующие виды [проверок](https://letsencrypt.org/ru/docs/challenge-types) для подтверждения владения доменом:

* [DNS-01](https://letsencrypt.org/ru/docs/challenge-types/#проверка-dns-01). Для прохождения проверки используется сервис [{{ dns-full-name }}](../../../dns/index.md). Вместе с cert-manager устанавливается плагин {{ dns-full-name }} ACME webhook, который обеспечивает интеграцию с сервисом.
* [HTTP-01](https://letsencrypt.org/ru/docs/challenge-types/#проверка-http-01). Для прохождения проверки используется Ingress-контроллер, который нужно установить в кластер.

{% note info %}

Приложение cert-manager c плагином {{ dns-full-name }} ACME webhook поддерживает работу с [Wildcard-сертификатами](../../../glossary/ssl-certificate.md#types).

{% endnote %}

## Перед началом работы {#before-you-begin}

1. Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

   По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

1. Убедитесь, что кластер {{ managed-k8s-name }} расположен в том же [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder), что и [публичная зона {{ dns-name }}](../../../dns/concepts/dns-zone.md#public-zones).

1. [Убедитесь](../connect/security-groups.md), что группы безопасности для кластера {{ managed-k8s-name }} и его групп узлов настроены корректно. Если отсутствует какое-либо из правил — [добавьте](../../../vpc/operations/security-group-add-rule.md) его.

    {% note warning %}
    
    От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
    
    {% endnote %}

1. [Добавьте](../../../vpc/operations/security-group-add-rule.md) в группы безопасности следующие правила:
   
     * В [группу безопасности кластера](../connect/security-groups.md#rules-master) добавьте правило для исходящего трафика, которое разрешает проверку сертификатов через веб-хук cert-manager:
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `10250`.
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.
     * В [группу безопасности группы узлов](../connect/security-groups.md#rules-internal-nodegroup) добавьте правило для исходящего трафика, которое разрешает подключение к серверам Let's Encrypt® для выпуска сертификатов:
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `443`.
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.
1. [Установите kubectl]({{ k8s-docs }}/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](../connect/index.md#kubectl-connect).
1. [Создайте](../../../iam/operations/sa/create.md) сервисный аккаунт, необходимый для работы cert-manager.
1. [Назначьте](../../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту роль `dns.editor` на каталог, где расположена публичная зона DNS.
1. [Создайте](../../../iam/operations/authentication/manage-authorized-keys.md#create-authorized-key) авторизованный ключ для этого сервисного аккаунта и сохраните ключ в файл `key.json`.

## Установка с помощью {{ marketplace-full-name }} {#marketplace-install}

1. В [консоли управления]({{ link-console-main }}) выберите каталог.
1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Нажмите на имя нужного кластера {{ managed-k8s-name }} и выберите вкладку ![image](../../../_assets/console-icons/shopping-cart.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}**.
1. В разделе **{{ ui-key.yacloud.marketplace-v2.label_available-products }}** выберите [cert-manager c плагином {{ dns-full-name }} ACME webhook](https://yandex.cloud/ru/marketplace/products/yc/cert-manager-webhook-yandex) и нажмите кнопку **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
1. Задайте настройки приложения:
   * **Пространство имен** — создайте новое [пространство имен](../../concepts/index.md#namespace) (например, `cert-manager-dns-space`). Если вы оставите пространство имен по умолчанию, cert-manager с плагином {{ dns-full-name }} может работать некорректно.
   * **Название приложения** — укажите название приложения, например, `cert-manager`.
   * **Ключ сервисной учетной записи** — вставьте содержимое файла `key.json` или создайте новый [ключ](../../../iam/concepts/authorization/key.md).
   * **ID каталога** — укажите идентификатор каталога, в котором находится зона {{ dns-name }}, для подтверждения владения доменом при проверке DNS-01.
   * **Адрес электронной почты для получения уведомлений от Let's Encrypt** — укажите адрес электронной почты для получения оповещений от Let's Encrypt®.
   * **Адрес сервера Let's Encrypt** — выберите из списка адрес сервера Let's Encrypt®:
     * `https://acme-v02.api.letsencrypt.org/directory` — основной URL.
     * `https://acme-staging-v02.api.letsencrypt.org/directory` — тестовый URL.
1. Нажмите кнопку **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.
1. Дождитесь перехода приложения в статус `Deployed`.

## Установка с помощью Helm-чарта {#helm-install}

1. [Установите менеджер пакетов Helm](https://helm.sh/ru/docs/intro/install/) версии не ниже 3.8.0.
1. [Установите kubectl]({{ k8s-docs }}/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](../connect/index.md#kubectl-connect).
1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с cert-manager и плагином {{ dns-full-name }} выполните команду:

   ```bash
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

   Если вы укажете в параметре `namespace` пространство имен по умолчанию, cert-manager может работать некорректно. Рекомендуем указывать значение, отличное от всех существующих пространств имен (например, `cert-manager-dns-space`).

   {% note info %}
   
   Если вы используете версию Helm ниже 3.8.0, добавьте в начало команды строку `export HELM_EXPERIMENTAL_OCI=1 && \`, чтобы включить поддержку [Open Container Initiative](https://opencontainers.org/) (OCI) в клиенте Helm.
   
   {% endnote %}

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

    В выводе команды будут содержаться подобные события (events):
    
    ```text
    Events:
      Type    Reason     Age   From                                       Message
      ----    ------     ----  ----                                       -------
      Normal  Issuing    ...   cert-manager-certificates-trigger          Issuing certificate as Secret does not exist
      Normal  Generated  ...   cert-manager-certificates-key-manager      Stored new private key in temporary Secret resource...
    ```
    
    Сертификаты [используются в связке с соответствующими им секретами Kubernetes](https://cert-manager.io/docs/), которые хранят пары ключей и служебную информацию. В случае отсутствия секрета сертификат перевыпускается автоматически с созданием нового секрета, о чем и сообщается в событиях. Подробнее о причинах, которые могут привести к перевыпуску сертификата, см. в [документации cert-manager](https://cert-manager.io/docs/faq/#when-do-certs-get-re-issued).
    
    Поскольку сертификат выпускается впервые, то соответствующий ему секрет отсутствует. Наличие событий, сообщающих об этом, не является ошибкой.

## Примеры использования {#examples}

* [{#T}](../../tutorials/dnschallenge.md).
* [{#T}](../../tutorials/ingress-cert-manager.md).

## См. также {#see-also}

* [Документация Let's Encrypt®](https://letsencrypt.org/docs/client-options/).
* [Документация cert-manager](https://cert-manager.io/docs/configuration/).