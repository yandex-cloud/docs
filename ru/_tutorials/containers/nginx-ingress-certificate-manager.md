# Установка Ingress-контроллера NGINX с сертификатом из {{ certificate-manager-full-name }}

Управляйте [TLS-сертификатом](../../certificate-manager/concepts/index.md) для Ingress-контроллера NGINX через [{{ certificate-manager-full-name }}](../../certificate-manager/).

[External Secrets Operator](https://external-secrets.io/v0.5.8/provider-yandex-certificate-manager/) синхронизирует сертификат с [секретом {{ k8s }}](../../managed-kubernetes/concepts/encryption.md). Это позволяет управлять сертификатом развернутого приложения через {{ certificate-manager-name }}: добавить самоподписанный сертификат и обновлять его самостоятельно или выпустить сертификат от Let's Encrypt®, который будет обновляться автоматически.

## Перед началом работы {#before-you-begin}

1. {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

1. [Установите менеджер пакетов Helm](https://helm.sh/ru/docs/intro/install/).
1. Установите утилиту `jq`:

   ```bash
   sudo apt update && sudo apt install jq
   ```

1. [Создайте сервисные аккаунты](../../iam/operations/sa/create.md):
   * `eso-service-account` — для взаимодействия External Secrets Operator с {{ certificate-manager-name }}.
   * `k8s-sa` с [ролями](../../iam/concepts/access-control/roles.md) `k8s.clusters.agent`, `vpc.publicAdmin`, `container-registry.images.puller` и `load-balancer.admin` на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder) — для создания ресурсов [кластера {{ managed-k8s-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) и скачивания [Docker-образов](../../container-registry/concepts/docker-image.md). Роль `load-balancer.admin` нужна для создания [сетевого балансировщика нагрузки](../../network-load-balancer/concepts/index.md).
1. Создайте [авторизованный ключ](../../iam/concepts/authorization/access-key.md) для [сервисного аккаунта](../../iam/concepts/users/service-accounts.md) и сохраните его в файл `authorized-key.json`:

   ```bash
   yc iam key create \
     --service-account-name eso-service-account \
     --output authorized-key.json
   ```

1. {% include [configure-sg-manual](../../_includes/managed-kubernetes/security-groups/configure-sg-manual-lvl3.md) %}

    {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

1. [Создайте кластер {{ managed-k8s-name }}](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) и [группу узлов](../../managed-kubernetes/operations/node-group/node-group-create.md) любой подходящей конфигурации. В настройках кластера {{ managed-k8s-name }} укажите сервисный аккаунт `k8s-sa` и группы безопасности, подготовленные ранее.

1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входит:
* Использование [мастера {{ managed-k8s-name }}](../../managed-kubernetes/concepts/index.md#master) и исходящий трафик (см. [тарифы {{ managed-k8s-name }}](../../managed-kubernetes/pricing.md)).
* Использование [узлов](../../managed-kubernetes/concepts/index.md#node-group) кластера {{ managed-k8s-name }} (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md)).
* Использование [публичных IP-адресов](../../vpc/concepts/address.md#public-addresses) (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md#prices-public-ip)).
* Входящий трафик, обработанный балансировщиком, и использование [сетевого балансировщика](../../network-load-balancer/concepts/index.md) (см. [тарифы {{ network-load-balancer-full-name }}](../../network-load-balancer/pricing.md)).

## Добавьте сертификат в {{ certificate-manager-name }}

1. Выпустите и [добавьте](../../certificate-manager/operations/managed/cert-create.md) в {{ certificate-manager-name }} сертификат Let's Encrypt® или [загрузите](../../certificate-manager/operations/import/cert-create.md) собственный сертификат.
1. Для сертификата Let's Encrypt® пройдите [проверку прав](../../certificate-manager/operations/managed/cert-validate.md) на домен, который указан в сертификате.
1. Назначьте [роль](../../iam/concepts/access-control/roles.md) `certificate-manager.certificates.downloader` [сервисному аккаунту](../../iam/concepts/users/service-accounts.md) `eso-service-account`, чтобы он мог читать содержимое сертификата:

   ```bash
   yc cm certificate add-access-binding \
     --id <идентификатор_сертификата> \
     --service-account-name eso-service-account \
     --role certificate-manager.certificates.downloader
   ```

1. Проверьте, что права назначены:

   ```bash
   yc cm certificate list-access-bindings --id <идентификатор_сертификата>
   ```

   Результат:

   ```text
   +---------------------------------------------+----------------+-------------------------------------+
   |                   ROLE ID                   |  SUBJECT TYPE  |              SUBJECT ID             |
   +---------------------------------------------+----------------+-------------------------------------+
   | certificate-manager.certificates.downloader | serviceAccount | <идентификатор_сервисного_аккаунта> |
   +---------------------------------------------+----------------+-------------------------------------+
   ```

## Установите External Secrets Operator {#install-eso}

{% list tabs group=instructions %}


- {{ marketplace-full-name }} {#marketplace}

    Установите приложение [External Secrets Operator с поддержкой {{ lockbox-name }}](/marketplace/products/yc/external-secrets) из {{ marketplace-name }} [по инструкции](../../managed-kubernetes/operations/applications/external-secrets-operator.md#marketplace-install) со следующими параметрами:

    * **Пространство имен** — создайте новое [пространство имен](../../managed-kubernetes/concepts/index.md#namespace) `external-secrets`.
    * **Ключ сервисной учетной записи** — вставьте содержимое файла `authorized-key.json`, созданного [ранее](#before-you-begin).


- Вручную {#manual}

    1. Добавьте Helm-репозиторий `external-secrets`:

        ```bash
        helm repo add external-secrets https://charts.external-secrets.io
        ```

    1. Установите External Secrets Operator в кластер {{ managed-k8s-name }}:

        ```bash
        helm install external-secrets \
          external-secrets/external-secrets \
          --namespace external-secrets \
          --create-namespace
        ```

        Эта команда создаст новое [пространство имен](../../managed-kubernetes/concepts/index.md#namespace) `external-secrets`, необходимое для работы External Secrets Operator.

        Результат:

        ```text
        NAME: external-secrets
        LAST DEPLOYED: Sun Sep 19 11:20:58 2021
        NAMESPACE: external-secrets
        STATUS: deployed
        REVISION: 1
        TEST SUITE: None
        NOTES:
        external-secrets has been deployed successfully!
        ...
        ```

{% endlist %}

## Настройте кластер {{ managed-k8s-name }} {#configure-cluster}

1. Создайте пространство имен `ns` для объектов External Secrets Operator:

   ```bash
   kubectl create namespace ns
   ```

1. Создайте секрет `yc-auth`, содержащий в себе [ключ](../../iam/concepts/authorization/key.md) сервисного аккаунта `eso-service-account`:

   ```bash
   kubectl --namespace ns create secret generic yc-auth \
     --from-file=authorized-key=authorized-key.json
   ```

1. Узнайте поддерживаемые `apiVersion` для [хранилища секретов (SecretStore)](https://external-secrets.io/v0.5.8/api-secretstore/):

   ```bash
   kubectl get crd secretstores.external-secrets.io \
     -o json | jq -r '.spec.versions[].name'
   ```

1. Создайте хранилище секретов с именем `secret-store`, содержащее секрет `yc-auth`, указав поддерживаемую `apiVersion`:


   ```bash
   kubectl --namespace ns apply -f - <<< '
   apiVersion: external-secrets.io/v1beta1
   kind: SecretStore
   metadata:
     name: secret-store
   spec:
     provider:
       yandexcertificatemanager:
         auth:
           authorizedKeySecretRef:
             name: yc-auth
             key: authorized-key'
   ```



## Создайте ExternalSecret {#create-externalsecret}

1. Узнайте поддерживаемые `apiVersion` для [ExternalSecret](https://external-secrets.io/v0.5.8/api-externalsecret/):

   ```bash
   kubectl get crd externalsecrets.external-secrets.io \
     -o json | jq -r '.spec.versions[].name'
   ```

1. Создайте объект ExternalSecret с именем `external-secret`, указывающий на сертификат из {{ certificate-manager-name }}, указав поддерживаемую `apiVersion`:

   ```bash
   kubectl --namespace ns apply -f - <<< '
   apiVersion: external-secrets.io/v1beta1
   kind: ExternalSecret
   metadata:
     name: external-secret
   spec:
     refreshInterval: 1h
     secretStoreRef:
       name: secret-store
       kind: SecretStore
     target:
       name: k8s-secret
       template:
         type: kubernetes.io/tls
     data:
     - secretKey: tls.crt
       remoteRef:
         key: <идентификатор_сертификата>
         property: chain
     - secretKey: tls.key
       remoteRef:
         key: <идентификатор_сертификата>
         property: privateKey'
   ```

   Где:
   * `k8s-secret` — имя секрета, в который External Secret Operator поместит сертификат из {{ certificate-manager-name }}.
   * `tls.crt` — параметр секрета `k8s-secret`, который будет содержать сертификат.
   * `tls.key` — параметр секрета `k8s-secret`, который будет содержать закрытый ключ сертификата.

   Доступны следующие значения параметра `property`:
   * `chain` — получить цепочку сертификатов в формате PEM.
   * `privateKey` — получить закрытый ключ в формате PEM.
   * `chainAndPrivateKey` или пустое значение — получить и цепочку сертификатов, и закрытый ключ.

   External Secrets Operator получит сертификат из {{ certificate-manager-name }} и поместит его в секрет `k8s-secret`.
1. Проверьте, что сертификат попал в секрет `k8s-secret`:

   ```bash
   kubectl -n ns get secret k8s-secret -ojson \
     | jq '."data"."tls.crt"' -r \
     | base64 --decode
   ```

   Пример результата:

   ```text
   -----BEGIN CERTIFICATE-----
   MIIFKTCCBBGgAwIBAgISBAlQtxTUnXa75N1TnPYRWbSLMA0GCSqGSIb3DQEBCwUA
   MDIxCzAJBgNVBAYTAlVTMRYwFAYDVQQKEw1MZXQncyBFbmNyeXB0MQswCQYDVQQD
   EwJSMzAeFw0yMjA3MTMxNDMxNTVaFw0yMjEwMTExNDMxNTRaMB0xGzAZBgNVBAMT
   EmRkb3Mtd2ViLm5yay5tZS51azCCASIwDQYJKoZIhvcNAQEBBQADggEPADCC…
   ```

   Чтобы просмотреть сертификат в удобном виде, выполните команды:

   ```bash
   kubectl -n ns get secret k8s-secret -ojson | jq '."data"."tls.crt"' -r \
     | base64 --decode > cert.pem
   ```

   ```bash
   openssl x509 -in cert.pem -text
   ```

   Пример результата:

   ```text
   Certificate:
       Data:
           Version: 3 (0x2)
           Serial Number:
               04:09:50:b7:14:d4:9d:76:bb:e4:dd:53:9c:f6:11:59:b4:8b
           Signature Algorithm: sha256WithRSAEncryption
           Issuer: C = US, O = Let's Encrypt, CN = R3
           Validity
               Not Before: Jul 13 14:31:55 2022 GMT
               Not After : Oct 11 14:31:54 2022 GMT
           Subject: CN = example.com
   ...
   ```

## Установите Ingress-контроллер NGINX {#install-nginx-ingress}

{% list tabs group=instructions %}


- {{ marketplace-full-name }} {#marketplace}

  Установите приложение [Ingress NGINX](/marketplace/products/yc/ingress-nginx) из {{ marketplace-name }} [по инструкции](../../managed-kubernetes/operations/applications/ingress-nginx.md).

  SSL-сертификат будет доступен только в пространстве имен `ns`, где создан секрет с этим сертификатом. Чтобы Ingress мог использовать этот сертификат в любом пространстве имен, добавьте в конфигурацию контроллера параметр `--default-ssl-certificate`:

  1. Выполните команду:

     ```bash
     kubectl edit deployment ingress-nginx-controller
     ```

  1. В открывшемся окне добавьте параметр `--default-ssl-certificate`:

     ```bash
     spec:
       template:
         spec:
           containers:
           - args:
             - /nginx-ingress-controller
             ...
             - --default-ssl-certificate=ns/k8s-secret
     ```

  При изменении параметра `--default-ssl-certificate` перезапустите Ingress-контроллер NGINX.


- Вручную {#manual}

  1. Добавьте в Helm-репозиторий для NGINX:

     ```bash
     helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
     ```

     Результат:

     ```text
     "ingress-nginx" has been added to your repositories
     ```

  1. Обновите набор данных для создания экземпляра приложения в кластере {{ managed-k8s-name }}:

     ```bash
     helm repo update
     ```

     Результат:

     ```text
     Hang tight while we grab the latest from your chart repositories...
     ...Successfully got an update from the "ingress-nginx" chart repository
     Update Complete. ⎈Happy Helming!⎈
     ```

  1. Установите контроллер. Он будет установлен вместе с {{ network-load-balancer-name }}:

     ```bash
     helm install ingress-nginx ingress-nginx/ingress-nginx
     ```

     SSL-сертификат будет доступен только в пространстве имен `ns`, где создан секрет с этим сертификатом. Чтобы Ingress мог использовать этот сертификат в любом пространстве имен, установите контроллер с параметром `default-ssl-certificate`:

     ```bash
     helm install ingress-nginx ingress-nginx/ingress-nginx \
       --set controller.extraArgs.default-ssl-certificate="ns/k8s-secret"
     ```

     Результат:

     ```text
     NAME: ingress-nginx
     LAST DEPLOYED: Sun Jul 18 22:35:37 2021
     NAMESPACE: default
     STATUS: deployed
     REVISION: 1
     TEST SUITE: None
     NOTES:
     The ingress-nginx controller has been installed.
     It may take a few minutes for the LoadBalancer IP to be available.
     You can watch the status by running 'kubectl --namespace default get services -o wide -w ingress-nginx-controller'
     ...
     ```

     При изменении параметра `default-ssl-certificate` перезапустите Ingress-контроллер NGINX.

  Чтобы настроить конфигурацию контроллера самостоятельно, обратитесь к [документации Helm](https://helm.sh/ru/docs/intro/using_helm/#настройка-chart-а-перед-установкой) и отредактируйте файл [values.yaml](https://github.com/kubernetes/ingress-nginx/blob/master/charts/ingress-nginx/values.yaml).

{% endlist %}

Чтобы пробросить определенные порты при установке Ingress-контроллера NGINX, следуйте [инструкции](../../managed-kubernetes/operations/create-load-balancer-with-ingress-nginx.md#port-forwarding).

## Создайте веб-ресурс в вашем кластере {{ managed-k8s-name }} {#create-web-app}

Создайте [объект](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) Deployment с NGINX и [сервис](https://kubernetes.io/docs/concepts/services-networking/service/) для него:

```bash
kubectl --namespace ns apply -f - <<< '
apiVersion: v1
kind: Service
metadata:
  name: app
spec:
  selector:
    app: app
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: app-deployment
  labels:
    app: app
spec:
  replicas: 1
  selector:
    matchLabels:
      app: app
  template:
    metadata:
      labels:
        app: app
    spec:
      containers:
      - name: app
        image: nginx:latest
        ports:
        - containerPort: 80'
```

## Настройте DNS-запись для Ingress-контроллера {#configure-dns-record}

1. Узнайте IP-адрес Ingress-контроллера (значение в колонке `EXTERNAL-IP`):

   ```bash
   kubectl get svc
   ```

   Результат:

   ```text
   NAME                      TYPE          CLUSTER-IP     EXTERNAL-IP     PORT(S)                     AGE
   ...
   ingress-nginx-controller  LoadBalancer  10.96.164.252  84.201.153.122  80:31248/TCP,443:31151/TCP  2m19s
   ...
   ```

1. Разместите у своего DNS-провайдера или на собственном DNS-сервере [A-запись](../../dns/concepts/resource-record.md#a-a), указывающую на публичный IP-адрес Ingress-контроллера:

   ```bash
   <имя_домена> IN A 84.201.153.122
   ```

{% note info %}

Регистрация сертификата Let's Encrypt® и A-записи может занять несколько минут.

{% endnote %}

## Создайте ресурс Ingress {#create-ingress}

Создайте ресурс [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/), который использует сертификат из `k8s-secret` для HTTPS:

```bash
kubectl --namespace ns apply -f - <<< '
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: nginx-test
  namespace: ns
spec:
  tls:
    - hosts:
      - <имя_домена>
      secretName: k8s-secret
  ingressClassName: nginx
  rules:
    - host: <имя_домена>
      http:
        paths:
        - path: /
          pathType: Prefix
          backend:
            service:
              name: app
              port:
                number: 80'
```

Где `<имя_домена>` — доменное имя, для которого выпущен сертификат.

## Проверьте доступность ресурса {#check-service-availability}

Выполните GET-запрос к ресурсу по HTTPS, например, командой:

```bash
curl https://<ваш_домен> -vv
```

Пример результата:

```text
* Trying 51.250.64.86:443...
* Connected to <имя_домена> (51.250.64.86) port 443 (#0)
...
* SSL connection using TLSv1.3 / TLS_AES_256_GCM_SHA384
* ALPN, server accepted to use h2
* Server certificate:
*  subject: CN=<имя_домена>
*  start date: Jul 13 14:31:55 2022 GMT
*  expire date: Oct 11 14:31:54 2022 GMT
*  subjectAltName: host "<имя_домена>" matched cert's "<имя_домена>"
...
* SSL certificate verify ok.
```

{% include [Настройка групп безопасности при недоступности ресурса](../../_includes/managed-kubernetes/security-groups/check-sg-if-url-unavailable-lvl3.md) %}

Сертификат от Let's Encrypt® должен обновляться автоматически вслед за [обновлением сертификата](../../certificate-manager/operations/managed/cert-update.md) в {{ certificate-manager-name }}.

Вы можете задать таймаут синхронизации в параметре `refreshInterval` объекта [ExternalSecret](#create-externalsecret).

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:
1. [Удалите](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md) кластер {{ managed-k8s-name }}.
1. [Удалите](../../network-load-balancer/operations/load-balancer-delete.md) {{ network-load-balancer-name }}.
1. [Удалите](../../certificate-manager/operations/managed/cert-delete.md) сертификат.
1. Если для доступа к кластеру {{ managed-k8s-name }} или узлам использовались статические публичные IP-адреса, освободите и [удалите](../../vpc/operations/address-delete.md) их.
