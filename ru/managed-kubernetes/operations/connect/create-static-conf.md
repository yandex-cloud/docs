# Создание статического файла конфигурации

Статические файлы конфигурации позволяют получить доступ к [кластеру {{ managed-k8s-name }}](../../concepts/index.md#kubernetes-cluster) без использования [CLI](../../../glossary/cli.md), например из систем непрерывной интеграции.

{% include [tip-gitlab](../../../_includes/managed-kubernetes/tip-gitlab-integration.md) %}

Также с помощью статического файла конфигурации можно настроить доступ к нескольким кластерам {{ managed-k8s-name }}. Между описанными в конфигурациях кластерами {{ managed-k8s-name }} можно быстро переключаться с помощью команды `kubectl config use-context`. Подробнее о настройке доступа к нескольким кластерам {{ managed-k8s-name }} читайте в [документации {{ k8s }}](https://kubernetes.io/docs/tasks/access-application-cluster/configure-access-multiple-clusters/).

Чтобы создать файл конфигурации:
* [Получите уникальный идентификатор кластера](#k8s-id).
* [Подготовьте сертификат кластера {{ managed-k8s-name }}](#prepare-cert).
* [Создайте объект ServiceAccount](#create-sa).
* [Подготовьте токен объекта ServiceAccount](#prepare-token).
* [Создайте и заполните файл конфигурации](#create-conf-file).
* [Проверьте результат](#check-result).

Для выполнения bash-команд вам понадобится парсер JSON-файлов — [jq](https://stedolan.github.io/jq/download/).

## Перед началом работы {#before-you-begin}

1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md).
1. [Создайте кластер {{ managed-k8s-name }}](../kubernetes-cluster/kubernetes-cluster-create.md#kubernetes-cluster-create) любой подходящей конфигурации.
1. [Создайте группу узлов](../node-group/node-group-create.md) любой подходящей конфигурации.
1. [Установите kubectl]({{ k8s-docs }}/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](index.md#kubectl-connect). Учетные данные добавьте в конфигурационный файл `test.kubeconfig` с помощью параметра `--kubeconfig=test.kubeconfig`.

## Получите уникальный идентификатор кластера {#k8s-id}

Для обращения к кластеру {{ managed-k8s-name }} используйте его уникальный идентификатор. Запишите его в переменную для использования в других командах.
1. Узнайте уникальный идентификатор кластера {{ managed-k8s-name }}:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. Перейдите на страницу [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder) и выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
     1. Нажмите на имя нужного кластера {{ managed-k8s-name }}.

     В поле **{{ ui-key.yacloud.common.id }}** отобразится уникальный идентификатор кластера {{ managed-k8s-name }}.

   - CLI {#cli}

     ```bash
     yc managed-kubernetes cluster list
     ```

     Результат:

     ```text
     +----------------------+--------+---------------------+---------+---------+------------------------+--------------------+
     |          ID          |  NAME  |     CREATED AT      | HEALTH  | STATUS  |    EXTERNAL ENDPOINT   |  INTERNAL ENDPOINT |
     +----------------------+--------+---------------------+---------+---------+------------------------+--------------------+
     | catb3ppsdsh7******** | my-k8s | 2019-09-04 15:17:11 | HEALTHY | RUNNING | https://84.201.148.31/ | https://10.0.0.24/ |
     +----------------------+--------+---------------------+---------+---------+------------------------+--------------------+
     ```

    {% endlist %}

1. Запишите уникальный идентификатор кластера {{ managed-k8s-name }} в переменную:

   {% list tabs group=programming_language %}

   - Bash {#bash}

     ```bash
     export CLUSTER_ID=catb3ppsdsh7********
     ```

   - PowerShell {#powershell}

     ```shell script
     $CLUSTER_ID = "catb3ppsdsh7********"
     ```

   {% endlist %}

## Подготовьте сертификат кластера {#prepare-cert}

Сохраните сертификат кластера {{ managed-k8s-name }} в файл `ca.pem`. С помощью этого сертификата подтверждается подлинность кластера {{ managed-k8s-name }}.

{% list tabs group=programming_language %}

- Bash {#bash}

  Выполните команду, которая:
  * Получает информацию о кластере {{ managed-k8s-name }} в формате JSON.
  * Оставляет только информацию о сертификате и убирает лишние кавычки из содержимого сертификата.
  * Убирает лишние символы из содержимого сертификата.
  * Сохраняет сертификат в файл `ca.pem`.

  ```bash
  yc managed-kubernetes cluster get --id $CLUSTER_ID --format json | \
    jq -r .master.master_auth.cluster_ca_certificate | \
    awk '{gsub(/\\n/,"\n")}1' > ca.pem
  ```

- PowerShell {#powershell}

  1. Получите подробную информацию о кластере {{ managed-k8s-name }} в формате JSON и сохраните ее в переменную `$CLUSTER`:

     ```shell script
     $CLUSTER = yc managed-kubernetes cluster get --id $CLUSTER_ID --format json | ConvertFrom-Json
     ```

  1. Получите сертификат кластера {{ managed-k8s-name }} и сохраните его в файл `ca.pem`:

     ```shell script
     $CLUSTER.master.master_auth.cluster_ca_certificate | Set-Content ca.pem
     ```

{% endlist %}

## Создайте объект ServiceAccount {#create-sa}

Создайте объект `ServiceAccount` для взаимодействия с API {{ k8s }} внутри кластера {{ managed-k8s-name }}.
1. Сохраните следующую спецификацию для создания объекта `ServiceAccount` и секрета для него в YAML-файл с названием `sa.yaml`.

   Подробную спецификацию объекта `ServiceAccount` читайте в [документации {{ k8s }}](https://kubernetes.io/docs/reference/kubernetes-api/authentication-resources/service-account-v1/).

   {% list tabs %}

   - Версия {{ k8s }} 1.24 и выше

     ```yaml
     apiVersion: v1
     kind: ServiceAccount
     metadata:
       name: admin-user
       namespace: kube-system
     ---
     apiVersion: rbac.authorization.k8s.io/v1
     kind: ClusterRoleBinding
     metadata:
       name: admin-user
     roleRef:
       apiGroup: rbac.authorization.k8s.io
       kind: ClusterRole
       name: cluster-admin
     subjects:
     - kind: ServiceAccount
       name: admin-user
       namespace: kube-system
     ---
     apiVersion: v1
     kind: Secret
     type: kubernetes.io/service-account-token
     metadata:
       name: admin-user-token
       namespace: kube-system
       annotations:
         kubernetes.io/service-account.name: "admin-user"
     ```

   - Версия {{ k8s }} 1.23 и ниже

     ```yaml
     apiVersion: v1
     kind: ServiceAccount
     metadata:
       name: admin-user
       namespace: kube-system
     ---
     apiVersion: rbac.authorization.k8s.io/v1
     kind: ClusterRoleBinding
     metadata:
       name: admin-user
     roleRef:
       apiGroup: rbac.authorization.k8s.io
       kind: ClusterRole
       name: cluster-admin
     subjects:
     - kind: ServiceAccount
       name: admin-user
       namespace: kube-system
     ```

   {% endlist %}

1. Создайте объект `ServiceAccount` и секрет для него:

   ```bash
   kubectl create -f sa.yaml
   ```

## Подготовьте токен объекта ServiceAccount {#prepare-token}

Токен необходим для аутентификации объекта `ServiceAccount` в кластере {{ managed-k8s-name }}.

{% list tabs group=programming_language %}

- Bash {#bash}

  Выполните команду, которая:
  * Получает информацию о созданном [сервисном аккаунте](../../../iam/concepts/users/service-accounts.md) `admin-user` в формате JSON.
  * Оставляет только информацию о токене и убирает лишние кавычки из содержимого токена.
  * Раскодирует токен из формата Base64.
  * Записывает содержимое токена в переменную `SA_TOKEN`.

  ```bash
  export SA_TOKEN=$(kubectl -n kube-system get secret $(kubectl -n kube-system get secret | \
    grep admin-user-token | \
    awk '{print $1}') -o json | \
    jq -r .data.token | \
    base64 -d)
  ```

- PowerShell {#powershell}

  1. Получите токен объекта `ServiceAccount`. Кавычки из содержимого уберутся автоматически:

     ```shell script
     $SECRET = kubectl -n kube-system get secret -o json | `
       ConvertFrom-Json | `
       Select-Object -ExpandProperty items | `
       Where-Object { $_.metadata.name -like "*admin-user*" }
     ```

  1. Раскодируйте токен из формата Base64:

     ```shell script
     $SA_TOKEN = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($SECRET.data.token))
     ```

{% endlist %}

## Получите IP-адрес кластера {#get-cluster-ip}

Получите [IP-адрес](../../../vpc/concepts/address.md) кластера {{ managed-k8s-name }} и добавьте его в переменную `MASTER_ENDPOINT` для дальнейшего использования.

{% list tabs group=programming_language %}

- Bash {#bash}

  Выполните команду, которая:
  * Получает в формате JSON информацию о кластере {{ managed-k8s-name }} по его уникальному идентификатору.
  * Оставляет только IP-адрес кластера {{ managed-k8s-name }}.
  * Убирает лишние кавычки из содержимого.
  * Записывает IP-адрес в переменную `MASTER_ENDPOINT`.

  Для подключения к API кластера {{ managed-k8s-name }} из интернета (вне {{ yandex-cloud }}).

  ```bash
  export MASTER_ENDPOINT=$(yc managed-kubernetes cluster get --id $CLUSTER_ID \
    --format json | \
    jq -r .master.endpoints.external_v4_endpoint)
  ```

  Для подключения к API кластера {{ managed-k8s-name }} для подключения к [мастеру](../../concepts/index.md#master) из [облачных сетей](../../../vpc/concepts/network.md#network).

  ```bash
  export MASTER_ENDPOINT=$(yc managed-kubernetes cluster get --id $CLUSTER_ID \
    --format json | \
    jq -r .master.endpoints.internal_v4_endpoint)
  ```

- PowerShell {#powershell}

  Выполните команду для подключения к API кластера {{ managed-k8s-name }} из интернета (вне {{ yandex-cloud }}):

  ```shell script
  $MASTER_ENDPOINT = $CLUSTER.master.endpoints.external_v4_endpoint
  ```

  Для подключения к API кластера {{ managed-k8s-name }} из облачных сетей выполните команду:

  ```shell script
  $MASTER_ENDPOINT = $CLUSTER.master.endpoints.internal_v4_endpoint
  ```

{% endlist %}

## Дополните файл конфигурации {#create-conf-file}

1. Добавьте сведения о кластере {{ managed-k8s-name }} в файл конфигурации.

   {% list tabs group=programming_language %}

   - Bash {#bash}

     Выполните команду:

     ```bash
     kubectl config set-cluster sa-test2 \
       --certificate-authority=ca.pem \
       --embed-certs \
       --server=$MASTER_ENDPOINT \
       --kubeconfig=test.kubeconfig
     ```

   - PowerShell {#powershell}

     Выполните команду:

     ```bash
     kubectl config set-cluster sa-test2 `
       --certificate-authority=ca.pem `
       --embed-certs `
       --server=$MASTER_ENDPOINT `
       --kubeconfig=test.kubeconfig
     ```

   {% endlist %}

1. Добавьте информацию о токене для `admin-user` в файл конфигурации.

   {% list tabs group=programming_language %}

   - Bash {#bash}

     Выполните команду:

     ```bash
     kubectl config set-credentials admin-user \
       --token=$SA_TOKEN \
       --kubeconfig=test.kubeconfig
     ```

   - PowerShell {#powershell}

     Выполните команду:

     ```shell script
     kubectl config set-credentials admin-user `
       --token=$SA_TOKEN `
       --kubeconfig=test.kubeconfig
     ```

   {% endlist %}

1. Добавьте информацию о контексте в файл конфигурации.

   {% list tabs group=programming_language %}

   - Bash {#bash}

     Выполните команду:

     ```bash
     kubectl config set-context default \
       --cluster=sa-test2 \
       --user=admin-user \
       --kubeconfig=test.kubeconfig
     ```

   - PowerShell {#powershell}

     Выполните команду:

     ```shell script
     kubectl config set-context default `
       --cluster=sa-test2 `
       --user=admin-user `
       --kubeconfig=test.kubeconfig
     ```

   {% endlist %}

1. Используйте созданную конфигурацию для дальнейшей работы.

   {% list tabs group=programming_language %}

   - Bash {#bash}

     Выполните команду:

     ```bash
     kubectl config use-context default \
       --kubeconfig=test.kubeconfig
     ```

   - PowerShell {#powershell}

     Выполните команду:

     ```shell script
     kubectl config use-context default `
       --kubeconfig=test.kubeconfig
     ```

   {% endlist %}

## Проверьте результат {#check-result}

Проверьте, что конфигурация настроена верно, выполнив команду:

```bash
kubectl get namespace --kubeconfig=test.kubeconfig
```

Результат:

```bash
NAME     STATUS  AGE
default  Active  9d
```

С помощью полученного файла `test.kubeconfig` вы можете подключаться к кластеру без использования CLI, например из систем непрерывной интеграции, а также переключаться между разными кластерами с помощью команды `kubectl config use-context`.

{% note warning %}

Для хранения статического файла конфигурации используйте хранилище секретов или шифрование.

{% endnote %}
