# Проверка DNS Challenge для сертификатов {{ lets-encrypt }} в {{ managed-k8s-full-name }}

# Проверка DNS Challenge для сертификатов {{ lets-encrypt }}


Чтобы добавить возможность пройти проверку DNS Challenge при выписывании [сертификатов {{ lets-encrypt }}](../../certificate-manager/concepts/managed-certificate.md):

1. [Создайте сертификат](#create-cert).
1. [Проверьте результат](#check-result).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за кластер {{ managed-k8s-name }}: использование мастера и исходящий трафик (см. [тарифы {{ managed-k8s-name }}](../../managed-kubernetes/pricing.md)).
* Плата за узлы кластера (ВМ): использование вычислительных ресурсов, операционной системы и хранилища (см. [тарифы {{ compute-name }}](../../compute/pricing.md)).
* Плата за публичный IP-адрес, если он назначен узлам кластера (см. [тарифы {{ vpc-name }}](../../vpc/pricing.md#prices-public-ip)).
* Плата за DNS-зону и DNS-запросы (см. [тарифы {{ dns-name }}](../../dns/pricing.md)).


## Перед началом работы {#before-begin}

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) с [ролью](../../iam/concepts/access-control/roles.md) `dns.editor` на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет находиться [доменная зона](../../dns/concepts/dns-zone.md).

1. [Создайте авторизованный ключ](../../iam/operations/authentication/manage-authorized-keys.md#create-authorized-key) для [сервисного аккаунта](../../iam/concepts/users/service-accounts.md) и сохраните его в виде JSON-файла:

   ```bash
   yc iam key create \
     --service-account-name <имя_сервисного_аккаунта> \
     --format json \
     --output key.json
   ```

1. [Зарегистрируйте публичную доменную зону и делегируйте домен](../../dns/operations/zone-create-public.md). Сертификат {{ lets-encrypt }} будет выписан для домена в этой зоне с прохождением [проверки DNS-01](https://letsencrypt.org/ru/docs/challenge-types/#проверка-dns-01).

1. [Создайте группы безопасности](../../managed-kubernetes/operations/connect/security-groups.md) для кластера {{ managed-k8s-name }} и входящих в него групп узлов.

    {% note warning %}
    
    От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
    
    {% endnote %}

1. [Добавьте](../../vpc/operations/security-group-add-rule.md) в группы безопасности следующие правила:
   
     * В [группу безопасности кластера](../../managed-kubernetes/operations/connect/security-groups.md#rules-master) добавьте правило для исходящего трафика, которое разрешает проверку сертификатов через веб-хук cert-manager:
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `10250`.
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.
     * В [группу безопасности группы узлов](../../managed-kubernetes/operations/connect/security-groups.md#rules-internal-nodegroup) добавьте правило для исходящего трафика, которое разрешает подключение к серверам Let's Encrypt® для выпуска сертификатов:
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `443`.
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.
1. [Создайте кластер {{ managed-k8s-name }}](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) и [группу узлов](../../managed-kubernetes/operations/node-group/node-group-create.md) любой подходящей конфигурации. При создании укажите группы безопасности, подготовленные ранее.

1. [Установите kubectl]({{ k8s-docs }}/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](../../managed-kubernetes/operations/connect/index.md#kubectl-connect).

## Создайте сертификат {#create-cert}

1. Установите приложение cert-manager c плагином {{ dns-full-name }} ACME webhook [по инструкции](../../managed-kubernetes/operations/applications/cert-manager-cloud-dns.md).

    При установке укажите сервисный аккаунт и авторизованный ключ, которые были созданы [перед началом работы](#before-begin).

1. Создайте файл `certificate.yaml`:

   ```yaml
   apiVersion: cert-manager.io/v1
   kind: Certificate
   metadata:
     name: example-com
     namespace: default
   spec:
     secretName: example-com-secret
     issuerRef:
       # ClusterIssuer, созданный вместе с {{ dns-full-name }} ACME webhook
       name: yc-clusterissuer
       kind: ClusterIssuer
     dnsNames:
       - <доменное_имя>
   ```

1. Передайте сертификат в кластер {{ managed-k8s-name }}:

   ```bash
   kubectl apply -f certificate.yaml
   ```

## Проверьте результат {#check-result}

1. Проверьте готовность сертификата:

    ```bash
    kubectl get certificate example-com
    ```

    Результат:

    ```text
    NAME         READY  SECRET              AGE
    example-com  True   example-com-secret  24h
    ```

    Статус `True` в колонке `READY` означает, что сертификат был выпущен успешно.

1. (Опционально) получите подробную информацию о сертификате:

    ```bash
    kubectl -n default describe certificate example-com
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

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

1. [Удалите кластер {{ managed-k8s-name }}](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
1. [Удалите публичную доменную зону](../../dns/operations/zone-delete.md).
1. [Удалите сервисный аккаунт](../../iam/operations/sa/delete.md).