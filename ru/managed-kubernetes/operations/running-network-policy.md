# Работа с сетевыми политиками кластера {{ k8s }}

Чтобы проверить работу сетевых политик {{ k8s }}, выполните следующие действия.

## Создайте кластер {{ k8s }} {#create-cluster}

При создании кластера {{ k8s }} необходимо включить использование сетевых политик, чтобы задействовать контроллер сетевых политик [Calico](https://www.projectcalico.org/):

* В консоли управления, выбрав опцию **Включить сетевые политики**.
* С помощью CLI, указав флаг `--enable-network-policy`.
* С помощью метода [create](../api-ref/Cluster/create.md) для ресурса [Cluster](../api-ref/Cluster).

{% cut "Как создать кластер {{ k8s }}" %}

{% list tabs %}
   
- Консоль управления
   
   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создан кластер {{ k8s }}.
   1. В списке сервисов выберите **{{ managed-k8s-name }}**.
   1. Нажмите кнопку **Создать кластер**.
   1. Введите имя кластера {{ k8s }}.
   1. Укажите **Сервисный аккаунт для ресурсов**, который будет использоваться для создания ресурсов.
   1. Укажите **Сервисный аккаунт для узлов**, который будет использоваться узлами для доступа к реестру Docker-образов.
   1. Укажите [релизный канал](../concepts/release-channels-and-updates.md).
   1. В блоке **Конфигурация мастера**:
       - В поле **Версия {{ k8s }}** выберите версию {{ k8s }}, которая будет установлена на мастере.
       - В поле **Публичный адрес** выберите способ назначения адреса:
          - **Автоматически** — чтобы назначить случайный IP-адрес из пула адресов {{ yandex-cloud }}.
          - **Без адреса** — чтобы не назначать публичный IP-адрес.
       - В поле **Тип мастера** выберите тип мастера: 
          - **Зональный** — создается в подсети в одной зоне доступности.
          - **Региональный** — создается распределенно в трех подсетях в каждой зоне доступности.
       - Выберите [Зону доступности](../../overview/concepts/geo-scope.md), в которой будет создан [мастер](../concepts/index.md#master).
               
          Шаг доступен только для зонального мастера.
       - В поле **Облачная сеть** выберите сеть, в которой будет создан мастер.
       - В поле **Подсеть** выберите подсеть, в которой будет создан мастер. 
               
         Для регионального мастера необходимо указать три подсети в каждой зоне доступности.
   1. В блоке **Настройки окна обновлений**:
       - В поле **Частота обновлений / Отключение** настройте окно для обновлений:
           - **Отключено** — отключение автоматических обновлений.
           - **В любое время** — обновления разрешены в любое время.
           - **Ежедневно** — обновления будут происходить во временном интервале, указанном в поле **Время (UTC) и продолжительность**.
           - **В выбранные дни** — обновления будут происходить во временном интервале, указанном в поле **Расписание по дням**.
   1. В блоке **Сетевые настройки кластера**:
       - Выберите опцию **Включить сетевые политики** для кластера {{ k8s }}, чтобы задействовать контроллер сетевых политик Calico.
   1. Нажмите кнопку **Создать кластер**.
       
- CLI
   
   {% include [cli-install](../../_includes/cli-install.md) %}
           
   {% include [default-catalogue](../../_includes/default-catalogue.md) %}    
   
   Создайте кластер {{ k8s }}:
       
   ```
   yc managed-kubernetes cluster create 
     --name cluster-np \
     --service-account-name k8s \
     --node-service-account-name docker \
     --zone ru-central1-a \     
     --network-name network \
     --enable-network-policy
   ```

   Где: 
   - `--name` — имя кластера {{ k8s }}.
   - `--service-account-id` — уникальный идентификатор сервисного аккаунта для ресурсов. От его имени будут создаваться ресурсы, необходимые кластеру {{ k8s }}.
   - `--node-service-account-id` — уникальный идентификатор сервисного аккаунта для узлов. От его имени узлы будут скачивать из реестра необходимые Docker-образы.
   - `--zone` — зона доступности.       
   - `--network-name` — имя сети.
   - `--enable-network-policy` — опция включения сетевых политик.

   Результат выполнения команды:

   ```
   done (8m52s)
   id: abcdef1ghi23jklmno4
   folder_id: p5q67rs89tuv1wxyzab
   created_at: "2020-09-14T15:56:31Z"
   name: k8s-np
   status: RUNNING
   health: HEALTHY
   network_id: cdefghig01klmnopqrs1
   master:
     zonal_master:
       zone_id: ru-central1-a
       internal_v4_address: 10.130.0.24
     version: "1.17"
     endpoints:
       internal_v4_endpoint: https://10.130.0.24
     master_auth:
       cluster_ca_certificate: |
         -----BEGIN CERTIFICATE-----
         MIICyDCCAbCgAwIBAgIBADANBgkqhkiG9w0BAQsFADAVMRMwEQYDVQQDEwprdWJl
         ...
         IyO849nznkMKNHzxvQKnXSNNTmbPu9DmPx8MsdI2vcklBbtkiHtc6U3y25I=
         -----END CERTIFICATE-----
     version_info:
       current_version: "1.17"
     maintenance_policy:
       auto_upgrade: true
       maintenance_window:
         anytime: {}
   ip_allocation_policy:
     cluster_ipv4_cidr_block: 10.112.0.0/16
     node_ipv4_cidr_mask_size: "24"
     service_ipv4_cidr_block: 10.96.0.0/16
   service_account_id: ajedclfluactb5868n99
   node_service_account_id: ajeo8f063dmnicot7t7j
   release_channel: REGULAR
   network_policy:
     provider: CALICO
   ```

- API 
   
   Чтобы создать  кластер {{ k8s }}, воспользуйтесь методом [create](../api-ref/Cluster/create.md) для ресурса [Cluster](../api-ref/Cluster).
   
{% endlist %}

{% endcut %}

## Создайте пространство имен {{ k8s }} {#сonfigure-namespace}

Создайте пространство имен с помощью объект API {{ k8s }} [Namespace](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/):

```
kubectl create ns policy-test
```

Результат выполнения команды:

```
namespace/policy-test created
```

## Создайте сервис nginx {#create-pod}

Чтобы создать под, используйте объект API {{ k8s }} [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/).

1. Создайте под с веб-сервером nginx в пространстве имен `policy-test`:

   ```
   kubectl create deployment --namespace=policy-test nginx --image=nginx
   ```

   Результат выполнения команды:
   
   ```
   deployment.apps/nginx created
   ```

1. Запустите под с nginx как сервис {{ k8s }}:

   ```
   kubectl expose --namespace=policy-test deployment nginx --port=80
   ```

   Результат выполнения:

   ```
   service/nginx exposed
   ```

1. Убедитесь, что веб-сервер nginx доступен. Для этого создайте под `access`:

   ```
   kubectl run --namespace=policy-test access --rm -ti --image busybox /bin/sh
   ```

   На поде `access` откроется shell-сессия:

   ```
   If you don't see a command prompt, try pressing enter.
   / #
   ```

1. Подключитесь к веб-серверу nginx через сессию на поде `access`:

   ```
   wget -q nginx -O -
   ```

   Веб-сервер nginx доступен:

   ```
   <!DOCTYPE html>
   <html>
   <head>
   <title>Welcome to nginx!</title>
   <style>
       body {
           width: 35em;
           margin: 0 auto;
           font-family: Tahoma, Verdana, Arial, sans-serif;
       }
   </style>
   </head>
   <body>
   <h1>Welcome to nginx!</h1>
   <p>If you see this page, the nginx web server is successfully installed and
   working. Further configuration is required.</p>
   
   <p>For online documentation and support please refer to
   <a href="http://nginx.org/">nginx.org</a>.<br/>
   Commercial support is available at
   <a href="http://nginx.com/">nginx.com</a>.</p>
   
   <p><em>Thank you for using nginx.</em></p>
   </body>
   </html>
   ```

1. Выйдите из пода:

   ```
   / # exit
   ```

   Под удален:

   ```
   Session ended, resume using 'kubectl attach access -c access -i -t' command when the pod is running
   pod "access" deleted
   ```

## Изолируйте поды с помощью сетевых политик {#enable-isolation}

Изолируйте пространство имен `policy-test`. После этого контроллер сетевых политик Calico предотвратит подключения к подам в этом пространстве имен:

```
kubectl create -f - <<EOF
kind: NetworkPolicy
apiVersion: networking.k8s.io/v1
metadata:
  name: deny
  namespace: policy-test
spec:
  podSelector:
  matchLabels: {}
EOF
```

Сетевые политики созданы:

```
networkpolicy.networking.k8s.io/default-deny created
```

### Протестируйте изоляцию {#test-isolation}

1. Сетевые политики изолировали веб-сервер nginx. Чтобы это проверить, создайте под `access`:

   ```
   kubectl run --namespace=policy-test access --rm -ti --image busybox /bin/sh
   ```

   На поде `access` откроется shell-сессия:

   ```
   If you don't see a command prompt, try pressing enter.
   / #
   ```

1. Проверьте, есть ли у пода `access` доступ к веб-серверу nginx:

   ```
   wget -q --timeout=5 nginx -O -
   ```

   Соединение не установлено:

   ```
   wget: download timed out
   / #
   ```

1. Выйдите из пода:

   ```
   / # exit
   ```

   Под удален:

   ```
   Session ended, resume using 'kubectl attach access -c access -i -t' command when the pod is running
   pod "access" deleted
   ```

## Создайте сетевые политики, разрешающие доступ к сервису {#create-policy}

Разрешите доступ к веб-серверу nginx с помощью сетевых политик. Сетевые политики разрешат подключаться только поду `access`.

1. Создайте сетевые политики `access-nginx`:

   ```
   kubectl create -f - <<EOF
   kind: NetworkPolicy
   apiVersion: networking.k8s.io/v1
   metadata:
     name: access-nginx
     namespace: policy-test
   spec:
     podSelector:
       matchLabels:
         app: nginx
     ingress:
       - from:
         - podSelector:
             matchLabels:
               run: access
   EOF
   ```

   {% note info %}
   
   Сетевые политики разрешат трафик от подов с меткой `run: access` к подам с меткой `app: nginx`. Метки автоматически добавляются утилитой kubectl и основаны на имени ресурса.
   
   {% endnote %}
   
   Сетевые политики созданы:
   
   ```
   networkpolicy.networking.k8s.io/access-nginx created
   ```

1. Создайте под `access`:

   ```
   kubectl run --namespace=policy-test access --rm -ti --image busybox /bin/sh
   ```

   На поде `access` откроется shell-сессия:

   ```
   If you don't see a command prompt, try pressing enter.
   / #
   ```

1. Проверьте, есть ли у пода `access` доступ к веб-серверу nginx:
   
   ```
   wget -q --timeout=5 nginx -O -
   ```
   
   Соединение установлено:
   
   ```
   <!DOCTYPE html>
   <html>
   <head>
   <title>Welcome to nginx!</title>
   ...
   ```

1. Выйдите из пода:

   ```
   / # exit
   ```

   Под удален:

   ```
   Session ended, resume using 'kubectl attach access -c access -i -t' command when the pod is running
   pod "access" deleted
   ```

### Проверьте, что сетевая изоляция для других подов работает {#сheck-isolation}

В созданных сетевых политиках `access-nginx` разрешено подключаться подам с меткой `run: access`.

1. Создайте под без метки `run: access`:

   ```
   kubectl run --namespace=policy-test cant-access --rm -ti --image busybox /bin/sh
   ```

   На поде `cant-access` откроется shell-сессия:

   ```
   If you don't see a command prompt, try pressing enter.
   / #
   ```

1. Проверьте, есть ли у пода `cant-access` доступ к веб-серверу nginx:

   ```
   wget -q --timeout=5 nginx -O -
   ```

   Соединение не установлено:

   ```
   wget: download timed out
   / #
   ```

1. Выйдите из пода:

   ```
   / # exit
   ```

   Под удален:

   ```
   Session ended, resume using 'kubectl attach access -c access -i -t' command when the pod is running
   pod "cant-access" deleted
   ```

1. Чтобы удалить данные примера, удалите пространство имен:

   ```
   kubectl delete ns policy-test
   ```

   Результат выполнения команды:

   ```
   namespace "policy-test" deleted
   ```