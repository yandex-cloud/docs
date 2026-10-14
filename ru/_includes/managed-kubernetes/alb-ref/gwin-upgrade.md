# Обновление контроллера Gwin

Чтобы обновить контроллер [{{ yandex-cloud }} Gwin](../../../managed-kubernetes/alb-ref/gwin-index.md) до новой версии, выполните следующие шаги:

1. [Сделайте резервную копию ресурсов Gwin](#backup).
1. [Обновите CRD (Custom Resource Definitions)](#update-crd).
1. [Обновите контроллер](#update-controller).

{% note warning %}

Сначала обновляйте [CRD](https://kubernetes.io/docs/tasks/extend-kubernetes/custom-resources/custom-resource-definitions/), а затем сам контроллер. Новая версия Gwin может ожидать появления новых полей или изменений в схеме CRD, которых нет в более ранних версиях. Если обновить контроллер раньше CRD, он может перейти в состояние `CrashLoopBackOff` или перестать обрабатывать ресурсы: API-сервер {{ k8s }} будет отклонять запросы с неизвестными полями.

{% endnote %}

## Перед началом работы {#before-you-begin}

Узнать актуальную версию Gwin можно в [карточке продукта {{ yandex-cloud }} Gwin](/marketplace/products/yc/gwin) в {{ marketplace-name }}.

Чтобы узнать текущую версию Gwin в кластере, выполните команду:

```bash
helm list --all-namespaces
```

Сравните текущую версию Gwin с версией в {{ marketplace-name }}. Если в {{ marketplace-name }} доступна более новая версия Gwin, выполните следующие шаги для обновления.

## Сделайте резервную копию ресурсов Gwin {#backup}

Перед обновлением сохраните текущую конфигурацию ресурсов Gwin и связанных с ним ресурсов [Ingress](../../../managed-kubernetes/alb-ref/ingress.md) и [Gateway API](../../../application-load-balancer/tools/k8s-gateway-api/index.md):

```bash
kubectl get all,ingress,gateway,httproute,yccertificate \
  -n <пространство_имен> \
  -o yaml > gwin-backup.yaml
```

Где `<пространство_имен>` — пространство имен {{ k8s }}, в котором установлен контроллер Gwin.

{% cut "Как узнать пространство имен" %}

{% list tabs group=instructions %}

- Консоль управления {#marketplace-namespace}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. [Перейдите]({{ link-console-main }}/link/managed-kubernetes) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Выберите [кластер {{ managed-k8s-name }}](../../../managed-kubernetes/concepts/index.md#kubernetes-cluster) и откройте вкладку **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}**.
  1. В разделе **{{ ui-key.yacloud.k8s.cluster.marketplace.section_releases }}** откройте карточку приложения {{ yandex-cloud }} Gwin.
  1. На вкладке **{{ ui-key.yacloud.k8s.cluster.marketplace.label_tab-general }}**, в разделе **{{ ui-key.yacloud.k8s.cluster.marketplace.label_product-settings }}**, найдите значение поля **{{ ui-key.yacloud.k8s.cluster.marketplace.label_app-namespace }}**.

- Helm {#helm-namespace}

  Выполните команду, чтобы вывести релизы во всех пространствах имен:

  ```bash
  helm list --all-namespaces
  ```

  Найдите строку, в которой значение поля `CHART` начинается с `gwin-chart`. Пространство имен указано в поле `NAMESPACE`, имя релиза — в поле `NAME`.

{% endlist %}

{% endcut %}

## Обновите CRD {#update-crd}

Команда `helm upgrade` автоматически не обновляет уже существующие CRD из каталога `crds/`. Обновите CRD вручную командой `kubectl apply`.

1. Скачайте и распакуйте Helm-чарт для новой версии Gwin:

   ```bash
   helm pull oci://{{ mkt-k8s-key.yc_gwin.helmChart.name }} \
     --version <новая_версия_gwin> \
     --untar
   ```

   Где `<новая_версия_gwin>` — версия Gwin, до которой вы хотите обновить контроллер. Например, `v1.11.0`.

   {% include [Support OCI](../note-helm-experimental-oci.md) %}

1. Примените CRD из скачанного чарта:

   ```bash
   kubectl apply --server-side --force-conflicts -f ./gwin-chart/crds
   ```

   Результат:

   ```text
   customresourcedefinition.apiextensions.k8s.io/backendtlspolicies.gateway.networking.k8s.io serverside-applied
   customresourcedefinition.apiextensions.k8s.io/gatewayclasses.gateway.networking.k8s.io serverside-applied
   customresourcedefinition.apiextensions.k8s.io/gateways.gateway.networking.k8s.io serverside-applied
   customresourcedefinition.apiextensions.k8s.io/grpcroutes.gateway.networking.k8s.io serverside-applied
   customresourcedefinition.apiextensions.k8s.io/httproutes.gateway.networking.k8s.io serverside-applied
   ...
   customresourcedefinition.apiextensions.k8s.io/yccertificates.gwin.yandex.cloud serverside-applied
   customresourcedefinition.apiextensions.k8s.io/ycstoragebuckets.gwin.yandex.cloud serverside-applied
   ```

## Обновите контроллер {#update-controller}

В зависимости от того, как вы установили Gwin, обновите контроллер с помощью Helm или консоли управления:

{% list tabs group=instructions %}

- Helm {#helm}

  Выполните команду `helm upgrade` и укажите в параметрах те же значения, что и при установке контроллера. Чтобы не указывать их повторно, используйте [параметр --reuse-values](https://helm.sh/docs/helm/helm_upgrade/):

  ```bash
  helm upgrade <имя_релиза_gwin> ./gwin-chart \
    --namespace <пространство_имен> \
    --reuse-values
  ```

  Где:
  * `<имя_релиза_gwin>` — имя, заданное при установке Gwin. Указано в поле `NAME` в выводе `helm list -n <пространство_имен>`.
  * `<пространство_имен>` — пространство имен {{ k8s }}, в котором установлен контроллер Gwin.

  Результат:

  ```text
  Release "gwin" has been upgraded. Happy Helming!
  NAME: gwin
  LAST DEPLOYED: Mon Aug 10 13:59:45 2026
  NAMESPACE: gwin-space
  STATUS: deployed
  REVISION: 2
  DESCRIPTION: Upgrade complete
  ```

- Консоль управления {#marketplace}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. [Перейдите]({{ link-console-main }}/link/managed-kubernetes) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Выберите [кластер {{ managed-k8s-name }}](../../../managed-kubernetes/concepts/index.md#kubernetes-cluster) и откройте вкладку **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}**.
  1. В разделе **{{ ui-key.yacloud.k8s.cluster.marketplace.section_releases }}** найдите установленное приложение {{ yandex-cloud }} Gwin. Если доступна новая версия Gwin, отобразится сообщение **{{ ui-key.yacloud.k8s.cluster.marketplace.label_new-version-available }}**.
  1. Нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) в строке приложения {{ yandex-cloud }} Gwin и выберите **{{ ui-key.yacloud.common.edit }}**.
  1. Выберите новую версию Gwin и нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

## Проверьте результат {#check-result}

1. Проверьте версию Gwin. Версия указана в поле `VERSION` в выводе команды:

   ```bash
   helm list --all-namespaces
   ```

1. Убедитесь, что [под](../../../managed-kubernetes/concepts/index.md#pod) контроллера Gwin перешел в состояние `Running`:

   ```bash
   kubectl get pods -n <пространство_имен>
   ```

   Где `<пространство_имен>` — пространство имен {{ k8s }}, в котором установлен контроллер Gwin.

   Результат:

   ```text
   NAME                    READY   STATUS    RESTARTS   AGE
   gwin-5f58847bdc-tzfnw   1/1     Running   0          12m
   nodecheck-4sgb4         1/1     Running   0          12m
   nodecheck-bbh57         1/1     Running   0          12m
   nodecheck-rzvtc         1/1     Running   0          12m
   ```

1. Убедитесь, что ресурсы Ingress или Gateway API продолжают обрабатываться и балансировщик {{ alb-name }} доступен.

   {% list tabs group=instructions %}

   - Gateway API {#gw}

     Выполните команду:

     ```bash
     kubectl get gateway,httproute -n <пространство_имен>
     ```

     Где `<пространство_имен>` — пространство имен {{ k8s }}, в котором установлен контроллер Gwin.

     Результат:

     ```text
     NAME                                                   CLASS          ADDRESS      PROGRAMMED   AGE
     gateway.gateway.networking.k8s.io/example-gateway      gwin-default   <IP-адрес>                32h

     NAME                                                             HOSTNAMES         AGE
     httproute.gateway.networking.k8s.io/example-httproute            ["example.com"]   32h
     httproute.gateway.networking.k8s.io/example-redirect-httproute   ["example.com"]   6m56s
     ```

   - Ingress {#ingress}

     Выполните команду:

     ```bash
     kubectl get ingress -n <пространство_имен>
     ```

     Результат:

     ```text
     NAME              CLASS          HOSTS         ADDRESS      PORTS     AGE
     example-ingress   gwin-default   example.com   <IP-адрес>   80, 443   31h
     ```

   {% endlist %}

   В поле `ADDRESS` должен быть указан IP-адрес балансировщика {{ alb-name }}.
