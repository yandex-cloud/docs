# Устранение проблем с разрешением DNS-имен в {{ managed-k8s-name }}

## Описание проблемы {#issue-description}

Кластер {{ managed-k8s-name }} не резолвит FQDN-имена как изнутри самого кластера, так и имена внешних по отношению к кластеру ресурсов.

## Решение {#issue-resolution}

1. Проверьте используемую версию Kubernetes на мастер-узлах и worker-узлах.  
Для этого выполните команды:

```(text)

 yc managed-kubernetes cluster get $CLUSTER_ID | grep vers
 yc managed-kubernetes node-group get $NODE_GROUP_ID | grep vers

```

{% note alert %}

Eсли версия кластера/нодгруппы устарела и не входит в список актуальных версий (`yc managed-kubernetes list-versions`), следует выполнить обновление кластера и нод-группы, перед тем как продолжать диагностику.

{% endnote %}

2. Если кластер и нод-группа используют актуальную версию Kubernetes, проверьте корректно ли работает coreDNS в кластере.
Для диагностики Core DNS понадобится проанализировать состояние системных DNS-подов кластера командой `kubectl get pods -n kube-system -l k8s-app=kube-dns -o wide`.

{% cut "Примерный вывод команды `kubectl get pods -n kube-system -l k8s-app=kube-dns -o wide`" %}

```(text)

NAME                       READY   STATUS    RESTARTS   AGE   IP              NODE                        NOMINATED NODE   READINESS GATES
coredns-85fd96f799-2zzvw   1/1     Running   5          21d   10.96.138.252   cl1o3731vi3b389ntlvt-yxeg   <none>           <none>
coredns-85fd96f799-9lz6b   1/1     Running   3          20d   10.96.140.90    cl1o3731vi3b389ntlvt-icos   <none>           <none>
```

{% endcut %}

Обратите внимание на состояние подов в кластере. Если состояние отличается от `Running`, системные журналы всех DNS-подов в кластере командой `kubectl logs -l k8s-app=kube-dns -n kube-system --all-containers=true` и найти причину проблем в этих журналах.

3. Если проблему с корректностью работы coreDNS не удалось решить – воспользуйтесь одним из следующих методов:

{% list tabs %}

- Увеличьте количество подов coreDNS
  
  Обычно в кластере два пода coreDNS, или один, если кластер однонодовый.

  Вы можете увеличить число реплик coreDNS, изменив конфигурацию автомасштабирования деплоймента coreDNS и задав значение для параметра `linear`:

  {% cut "Пример деплоймента kube-dns-autoscaler (`kubectl -n kube-system edit cm kube-dns-autoscaler`)" %}

  ```(yaml)
  apiVersion: v1
  data:
  linear: '{"coresPerReplica":256,"nodesPerReplica":16,"preventSinglePointFailure":true}' # < это настройки масштабирования
  kind: ConfigMap
  metadata:
  name: kube-dns-autoscaler
  namespace: kube-system
  selfLink: /api/v1/namespaces/kube-system/configmaps/kube-dns-autoscaler
  ```

  {% endcut %}

  Более подробно про конфигурацию масштабирования можно узнать из материалов разработчиков Kubernetes на GitHub [по этой ссылке](https://github.com/kubernetes-sigs/cluster-proportional-autoscaler#control-patterns-and-configmap-formats)

- Используйте NodeLocal DNS 

  Чтобы снизить нагрузку по DNS-запросам в [кластере {{ managed-k8s-name }}], включите NodeLocal DNS Cache. 

  Если кластер {{ managed-k8s-name }} содержит более 50 узлов, используйте автоматическое масштабирование DNS.

  При включении NodeLocal DNS Cache в кластере {{ managed-k8s-name }} разворачивается [DaemonSet](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/). На каждом узле {{ managed-k8s-name }} начинает работу кеширующий агент (под `node-local-dns`). Поды пользователя теперь отправляют запросы к агенту на своем узле {{ managed-k8s-name }}.

   Если запрос в кеше агента, он возвращает прямой ответ. В ином случае создается TCP-соединение с `kube-dns` `ClusterIP`. По умолчанию кеширующий агент делает cache-miss запросы к `kube-dns` для [DNS-зоны](../../../dns/concepts/dns-zone.md) кластера {{ managed-k8s-name }} `cluster.local`.

   Установите [NodeLocal DNS](/marketplace/products/yc/node-local-dns) с помощью {{ marketplace-name }}, как описано в [инструкции](../../../managed-kubernetes/operations/applications/node-local-dns.md#marketplace-install) или [вручную](../../../managed-kubernetes/tutorials/node-local-dns.md).

{% endlist %}

{% note tip %}

Гарантированный результат при решении проблем с DNS в кластере также даст установка NodeLocal DNS Cache из {{ marketplace-full-name }} по следующим инструкциям:

* [Основы работы с Cloud Marketplace](../../../managed-kubernetes/operations/applications/marketplace.md)
* [Установка NodeLocal DNS](../../../managed-kubernetes/operations/applications/node-local-dns.md)

{% endnote %}

## Если проблема осталась {#if-issue-still-persists}

Если вышеописанные действия не помогли решить проблему, [создайте запрос в техническую поддержку]({{ link-console-support }}).
При создании запроса просим указать следующую информацию:

1. Идентификатор кластера {{ managed-k8s-name }}.
2. Журнал событий кластера {{ managed-k8s-name }} (вывод `kubectl get events`).
3. Журнал DNS-сервисов кластера (вывод `kubectl logs -l k8s-app=kube-dns -n kube-system --all-containers=true`)
4. Примеры ошибок при работе DNS-резолвинга в кластере с фиксацией даты и времени проявления проблемы.
