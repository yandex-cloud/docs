---
title: Установка Argo CD
description: Следуя данной инструкции, вы сможете установить Agro CD.
---

# Установка Argo CD


[Argo CD](https://argo-cd.readthedocs.io) — декларативный инструмент для непрерывной доставки в {{ k8s }} по модели GitOps.

## Перед началом работы {#before-you-begin}

1. {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. {% include [check-sg-prerequsites](../../../_includes/managed-kubernetes/security-groups/check-sg-prerequsites-lvl3.md) %}

    {% include [sg-common-warning](../../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

1. {% include [Настройка kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}

## Установка с помощью {{ marketplace-full-name }} {#marketplace-install}

1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../../_assets/console-icons/shopping-cart.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}**.
1. В разделе **{{ ui-key.yacloud.marketplace-v2.label_available-products }}** выберите [Argo CD](/marketplace/products/yc/argo-cd) и нажмите кнопку **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
1. Задайте настройки приложения:
   * **Пространство имен** — выберите [пространство имен](../../concepts/index.md#namespace) для Argo CD или создайте новое.
   * **Название приложения** — укажите название приложения.
1. Нажмите кнопку **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.
1. Дождитесь перехода приложения в статус `Deployed`.

## Установка с помощью Helm-чарта {#helm-install}

1. {% include [Установка Helm](../../../_includes/managed-kubernetes/helm-install.md) %}
1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с Argo CD выполните команду:

   ```bash
   helm pull oci://{{ mkt-k8s-key.yc_argo-cd.helmChart.name }} \
     --version {{ mkt-k8s-key.yc_argo-cd.helmChart.tag }} \
     --untar && \
   helm install \
     --namespace <пространство_имен> \
     --create-namespace \
     argo-cd ./argo-cd/
   ```

   {% include [Support OCI](../../../_includes/managed-kubernetes/note-helm-experimental-oci.md) %}

## Доступ к приложению {#application-access}

Вы можете открыть приложение Argo CD через [localhost](#open-via-localhost) или [выделенный IP-адрес](#go-to-static-address). Первый способ проще в настройке и не требует дополнительных затрат на сетевой балансировщик нагрузки. Второй способ позволяет получить постоянный доступ к Argo CD. Через `localhost` приложение доступно, только пока активна переадресация портов.

Перед тем как настроить доступ к Argo CD, получите пароль администратора (`admin`):

```bash
kubectl --namespace <пространство_имен> get secret argocd-initial-admin-secret \
  --output jsonpath="{.data.password}" | base64 -d
```

Пароль понадобится для авторизации в Argo CD.

### Открыть приложение через localhost {#open-via-localhost}

1. Настройте переадресацию порта Argo CD на локальный компьютер:

   ```bash
   kubectl port-forward service/<название_приложения>-argocd-server \
     --namespace <пространство_имен> 8080:443
   ```

   В команде укажите название приложения, которое вы задали при установке.

1. Перейдите по ссылке `https://localhost:8080` и авторизуйтесь с учетными данными администратора.

### Открыть приложение по выделенному IP-адресу {#go-to-static-address}

1. Сохраните следующую спецификацию для создания сервиса типа `LoadBalancer` в файл `load-balancer.yaml`. В результате вы создадите балансировщик [{{ network-load-balancer-full-name }}](../../../network-load-balancer/index.yaml):

   ```yaml
   apiVersion: v1
   kind: Service
   metadata:
     name: argocd-load-balancer
     namespace: <пространство_имен>
   spec:
     type: LoadBalancer
     ports:
     - port: 443
       name: load-balancer-port-ssl
       targetPort: 8080
     # {{ k8s }}-метка селектора, использованная в объекте Deployment с именем <название_приложения>-argocd-server.
     selector:
       app.kubernetes.io/name: argocd-server
   ```

   В спецификации укажите пространство имен, в котором вы установили приложение Argo CD.

   Так как в спецификации не задан IP-адрес, балансировщику будет присвоен динамический публичный IP-адрес. Вы можете добавить поле `spec.loadBalancerIP` и указать в нем [заранее зарезервированный](../../../vpc/operations/get-static-ip.md) статический IP-адрес.

   Подробнее о спецификации см. в [справочнике сервиса](../../nlb-ref/service.md).

1. Примените спецификацию и создайте сетевой балансировщик нагрузки:

   ```bash
   kubectl apply -f load-balancer.yaml --namespace <пространство_имен>
   ```

1. Получите IP-адрес созданного балансировщика:

   {% list tabs group=instructions %}

   * Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите каталог, где развернут кластер {{ managed-k8s-name }}.
      1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.

         В разделе **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_list }}** отображен сетевой балансировщик нагрузки с префиксом `k8s` в имени и уникальным идентификатором кластера {{ k8s }} в описании.

      1. Скопируйте значение поля **{{ ui-key.yacloud.load-balancer.network-load-balancer.column_ip-address }}** для нужного балансировщика.

   {% endlist %}

1. Перейдите по ссылке `https://<IP-адрес_балансировщика>` и авторизуйтесь с учетными данными администратора.

## Примеры использования {#examples}

* [{#T}](../../tutorials/marketplace/argo-cd.md).

## См. также {#see-also}

* [Документация Argo CD](https://argo-cd.readthedocs.io/en/stable/operator-manual/).
