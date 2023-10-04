# Создание статического файла конфигурации

Статические файлы конфигурации позволяют получить доступ к кластеру {{ k8s }} без использования [CLI](../../../glossary/cli.md), например из систем непрерывной интеграции.

Также с помощью статического файла конфигурации можно настроить доступ к нескольким кластерам {{ k8s }}. Между описанными в конфигурациях кластерами {{ k8s }} можно быстро переключаться с помощью команды `kubectl config use-context`. Подробнее о настройке доступа к нескольким кластерам {{ k8s }} читайте в [документации {{ k8s }}](https://kubernetes.io/docs/tasks/access-application-cluster/configure-access-multiple-clusters/).

Чтобы создать файл конфигурации:
* [Подготовьте сертификат кластера {{ k8s }}](#prepare-cert).
* [Создайте объект ServiceAccount](#create-sa).
* [Подготовьте токен объекта ServiceAccount](#prepare-token).
* [Создайте и заполните файл конфигурации](#create-conf-file).
* [Проверьте результат](#check-result).

Для выполнения bash-команд вам понадобится парсер JSON-файлов — [jq](https://stedolan.github.io/jq/download/).

## Получите уникальный идентификатор кластера {{ k8s }} {#k8s-id}

Для обращения к кластеру {{ k8s }} используйте его уникальный идентификатор. Запишите его в переменную для использования в других командах.
1. Узнайте уникальный идентификатор кластера {{ k8s }}:

   {% list tabs %}

   - Консоль управления

     1. Перейдите на страницу каталога и выберите {{ managed-k8s-name }}.
     1. Нажмите на имя нужного кластера {{ k8s }}.

     В блоке **Общая информация** отобразится уникальный идентификатор кластера {{ k8s }}.

   - CLI

     ```bash
     yc managed-kubernetes cluster list
     ```

     Результат:

     ```bash
     +----------------------+----------+---------------------+---------+---------+-------------------------+----------------------+
     |          ID          |   NAME   |     CREATED AT      | HEALTH  | STATUS  |    EXTERNAL ENDPOINT    |  INTERNAL ENDPOINT   |
     +----------------------+----------+---------------------+---------+---------+-------------------------+----------------------+
     | catb3ppsdsh7vajr216f | my-k8s   | 2019-09-04 15:17:11 | HEALTHY | RUNNING | https://84.201.148.31/  | https://10.0.0.24/   |
     +----------------------+----------+---------------------+---------+---------+-------------------------+----------------------+
     ```

    {% endlist %}

1. Запишите уникальный идентификатор кластера {{ k8s }} в переменную:

   {% list tabs %}

   - Bash

     ```bash
     CLUSTER_ID=catb3ppsdsh7vajr216f
     ```

   - PowerShell

     ```shell script
     $CLUSTER_ID = "catb3ppsdsh7vajr216f"
     ```

   {% endlist %}

## Подготовьте сертификат кластера {{ k8s }} {#prepare-cert}

Сохраните сертификат кластера {{ k8s }} в файл `ca.pem`. С помощью этого сертификата подтверждается подлинность кластера {{ k8s }}.

{% list tabs %}

- Bash

  Выполните команду, которая:
  * Получает информацию о кластере в формате JSON.
  * Оставляет только информацию о сертификате и убирает лишние кавычки из содержимого сертификата.
  * Убирает лишние символы из содержимого сертификата.
  * Сохраняет сертификат в файл `ca.pem`.

  ```bash
  yc managed-kubernetes cluster get --id $CLUSTER_ID --format json | \
    jq -r .master.master_auth.cluster_ca_certificate | \
    awk '{gsub(/\\n/,"\n")}1' > ca.pem
  ```

- PowerShell

  1. Получите подробную информацию о кластере {{ k8s }} в формате JSON и сохраните ее в переменную `$CLUSTER`:

     ```shell script
     $CLUSTER = yc managed-kubernetes cluster get --id $CLUSTER_ID --format json | ConvertFrom-Json
     ```

  1. Получите сертификат кластера {{ k8s }} и сохраните его в файл `ca.pem`:

     ```shell script
     $CLUSTER.master.master_auth.cluster_ca_certificate | Set-Content ca.pem
     ```

{% endlist %}

## Создайте объект ServiceAccount {#create-sa}

Создайте объект `ServiceAccount` для взаимодействия с API {{ k8s }} внутри кластера {{ k8s}}.

1. Сохраните следующую спецификацию для создания объекта `ServiceAccount` в YAML-файл с названием `sa.yaml`.

   Подробную спецификацию объекта `ServiceAccount` читайте в [документации {{ k8s }}](https://kubernetes.io/docs/reference/kubernetes-api/authentication-resources/service-account-v1/).

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

1. Создайте объект `ServiceAccount`:

   ```bash
   kubectl create -f sa.yaml
   ```

## Подготовьте токен объекта ServiceAccount {#prepare-token}

Токен необходим для аутентификации объекта `ServiceAccount` в кластере {{ k8s }}.

{% list tabs %}

- Bash

  Выполните команду, которая:
  * Получает информацию о сервисном аккаунте `admin-user` в формате JSON.
  * Оставляет только информацию о сертификате и убирает лишние кавычки из содержимого токена.
  * Раскодирует токен из формата Base64.
  * Записывает содержимое токена в переменную `SA_TOKEN`.

  ```bash
  SA_TOKEN=$(kubectl -n kube-system get secret $(kubectl -n kube-system get secret | \
    grep admin-user-token | \
    awk '{print $1}') -o json | \
    jq -r .data.token | \
    base64 --d)
  ```

- PowerShell

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

## Получите IP-адрес кластера {{ k8s }} {#get-cluster-ip}

Получите IP-адрес кластера {{ k8s }} и добавьте его в переменную `MASTER_ENDPOINT` для дальнейшего использования.

{% list tabs %}

- Bash

  Выполните команду, которая:
  * Получает информацию о кластере {{ k8s }} с уникальным идентификатором `c497ipckbqppifcvrnrk` в формате JSON.
  * Оставляет только IP-адрес кластера {{ k8s }}.
  * Убирает лишние кавычки из содержимого.
  * Записывает IP-адрес в переменную `MASTER_ENDPOINT`.

  Для подключения к API кластера {{ k8s }} из интернета (вне {{ yandex-cloud }}).

  ```bash
  MASTER_ENDPOINT=$(yc managed-kubernetes cluster get --id $CLUSTER_ID \
    --format json | \
    jq -r .master.endpoints.external_v4_endpoint)
  ```

  Для подключения к API кластера {{ k8s }} для подключения к мастеру из облачных сетей.

  ```bash
  MASTER_ENDPOINT=$(yc managed-kubernetes cluster get --id $CLUSTER_ID \
    --format json | \
    jq -r .master.endpoints.internal_v4_endpoint)
  ```

- PowerShell

  Выполните команду для подключения к API кластера {{ k8s }} из интернета (вне {{ yandex-cloud }}):

  ```shell script
  $MASTER_ENDPOINT = $CLUSTER.master.endpoints.external_v4_endpoint
  ```

  Для подключения к API кластера {{ k8s }} из облачных сетей выполните команду:

  ```shell script
  $MASTER_ENDPOINT = $CLUSTER.master.endpoints.internal_v4_endpoint
  ```

{% endlist %}

## Создайте и заполните файл конфигурации {#create-conf-file}

1. Добавьте сведения о кластере {{ k8s }} в файл конфигурации.

   {% list tabs %}

   - Bash

     Выполните команду:

     ```bash
     kubectl config set-cluster sa-test2 \
       --certificate-authority=ca.pem \
       --server=$MASTER_ENDPOINT \
       --kubeconfig=test.kubeconfig
     ```

   - PowerShell

     ```bash
     kubectl config set-cluster sa-test2 `
       --certificate-authority=ca.pem `
       --server=$MASTER_ENDPOINT `
       --kubeconfig=test.kubeconfig
     ```

   {% endlist %}

1. Добавьте информацию о токене для `admin-user` в файл конфигурации.

   {% list tabs %}

   - Bash

     Выполните команду:

     ```bash
     kubectl config set-credentials admin-user \
       --token=$SA_TOKEN \
       --kubeconfig=test.kubeconfig
     ```

   - PowerShell

     Выполните команду:

     ```shell script
     kubectl config set-credentials admin-user `
       --token=$SA_TOKEN `
       --kubeconfig=test.kubeconfig
     ```

   {% endlist %}

1. Добавьте информацию о контексте в файл конфигурации.

   {% list tabs %}

   - Bash

     Выполните команду:

     ```bash
     kubectl config set-context default \
       --cluster=sa-test2 \
       --user=admin-user \
       --kubeconfig=test.kubeconfig
     ```

   - PowerShell

     Выполните команду:

     ```shell script
     kubectl config set-context default `
       --cluster=sa-test2 `
       --user=admin-user `
       --kubeconfig=test.kubeconfig
     ```

   {% endlist %}

1. Используйте созданную конфигурацию для дальнейшей работы.

   {% list tabs %}

   - Bash

     Выполните команду:

     ```bash
     kubectl config use-context default \
       --kubeconfig=test.kubeconfig
     ```

   - PowerShell

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
