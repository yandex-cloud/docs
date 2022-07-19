# Настройка контроллера сетевых политик Calico

Чтобы настроить [контроллер сетевых политик Calico](https://www.projectcalico.org/), выполните следующие действия.

## Создайте кластер {{ k8s }} с поддержкой Calico {#create-cluster}

При создании кластера {{ k8s }} задействуйте контроллер сетевых политик Calico:
* В консоли управления, выбрав опцию **Включить сетевые политики**.
* С помощью CLI, указав флаг `--enable-network-policy`.
* С помощью метода [create](../api-ref/Cluster/create.md) для ресурса [Cluster](../api-ref/Cluster).

{% cut "Как создать кластер {{ k8s }}" %}

{% list tabs %}

- Консоль управления

  {% include [create-cluster](../../_includes/managed-kubernetes/cluster-create.md) %}

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Создайте кластер {{ k8s }}:

  ```bash
  yc managed-kubernetes cluster create
    --name cluster-np \
    --service-account-name k8s \
    --node-service-account-name docker \
    --zone {{ region-id }}-a \
    --network-name network \
    --enable-network-policy
  ```

  Где:

  * `--name` — имя кластера {{ k8s }}.
  * `--service-account-id` — уникальный идентификатор сервисного аккаунта для ресурсов. От его имени будут создаваться ресурсы, необходимые кластеру {{ k8s }}.
  * `--node-service-account-id` — уникальный идентификатор сервисного аккаунта для узлов. От его имени узлы будут скачивать из реестра необходимые Docker-образы.
  * `--zone` — зона доступности.
  * `--network-name` — имя сети.
  * `--enable-network-policy` — опция включения сетевых политик.

   Результат:

   ```
   done (8m52s)
   id: abcdef1ghi23jklmno4
   folder_id: p5q67rs89tuv1wxyzab
   ...
   release_channel: REGULAR
   network_policy:
     provider: CALICO
   ```

- API

  Чтобы создать кластер {{ k8s }}, воспользуйтесь методом [create](../api-ref/Cluster/create.md) для ресурса [Cluster](../api-ref/Cluster).

{% endlist %}

{% endcut %}

## Создайте пространство имен {{ k8s }} {#configure-namespace}

Создайте пространство имен с помощью объект API {{ k8s }} [Namespace]({{ k8s-docs }}/concepts/overview/working-with-objects/namespaces/):

```
kubectl create ns policy-test
```

Результат:

```
namespace/policy-test created
```

## Создайте сервис nginx {#create-pod}

Чтобы создать под, используйте объект API {{ k8s }} [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/).
1. Создайте под с веб-сервером nginx в пространстве имен `policy-test`:

   ```
   kubectl create deployment --namespace=policy-test nginx --image=nginx
   ```

   Результат:
   
   ```
   deployment.apps/nginx created
   ```

1. Запустите под с nginx как сервис {{ k8s }}:

   ```
   kubectl expose --namespace=policy-test deployment nginx --port=80
   ```

   Результат:

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
   ...
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

### Проверьте, что сетевая изоляция для других подов работает {#check-isolation}

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

   Результат:

   ```
   namespace "policy-test" deleted
   ```