---
title: Установка Ingress NGINX
description: Узнайте, как установить приложение Ingress NGINX в кластере {{ managed-k8s-name }}.
---

# Установка Ingress NGINX


[Ingress NGINX](https://docs.nginx.com/nginx-ingress-controller/overview/about/) — Ingress-контроллер для NGINX, который балансирует нагрузку между приложениями WebSocket, gRPC, TCP или UDP. Ingress NGINX устанавливается в кластере {{ managed-k8s-name }} и настраивается с помощью объектов {{ k8s }} [ConfigMap](https://docs.nginx.com/nginx-ingress-controller/configuration/global-configuration/configmap-resource/) и [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/), включая его [аннотации](https://docs.nginx.com/nginx-ingress-controller/configuration/ingress-resources/advanced-configuration-with-annotations/).

## Перед началом работы {#before-you-begin}

1. {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. {% include [check-sg-prerequsites](../../../_includes/managed-kubernetes/security-groups/check-sg-prerequsites-lvl3.md) %}

   {% include [sg-common-warning](../../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

## Установка с помощью {{ marketplace-full-name }} {#marketplace-install}

1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../../_assets/console-icons/shopping-cart.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}**.
1. В разделе **{{ ui-key.yacloud.marketplace-v2.label_available-products }}** выберите [Ingress NGINX](/marketplace/products/yc/ingress-nginx) и нажмите кнопку **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
1. Задайте настройки приложения:

   * **Пространство имен** — создайте новое [пространство имен](../../concepts/index.md#namespace) (например, `ingress-nginx-space`). Если вы оставите пространство имен по умолчанию, Ingress NGINX может работать некорректно.
   * **Название приложения** — укажите название приложения.
   * **Количество реплик контроллера** — настройте число реплик Ingress-контроллера, чтобы повысить отказоустойчивость. Если используется только одна реплика, в случае ее отказа будут недоступны приложения, развернутые с помощью Ingress-контроллера.

      Значение по умолчанию — `1`.

   * **IP-адрес контроллера** — укажите зарезервированный IP-адрес. Вы можете [зарезервировать его](../../../vpc/operations/get-static-ip) с помощью {{ vpc-full-name }}.

      Если не заполнить поле, Ingress-контроллеру будет присвоен динамический IP-адрес.

   * **Политика управления трафиком** — выберите политику управления внешним трафиком. Она соответствует параметру `externalTrafficPolicy` в спецификациях {{ k8s }}. Возможные значения:

      * **Cluster** — трафик направляется на разные узлы {{ k8s }} (значение по умолчанию). В результате трафик распределяется равномерно, но у такого подхода есть недостатки:

         * Пакет может прийти на прокси одного узла и без необходимости перенаправиться на другой узел. Такое поведение вызвает задержки во время выполнения операций и отправки пакетов.
         * Под, который получает пакет, видит IP-адрес проксирующего узла, а не клиента. В результате исходный IP-адрес клиента не сохраняется.

      * **Local** — трафик проксируется и распределяется между подами на одном и том же узле. Трафик направляется на узел через порт, указанный в объекте {{ k8s }} `Service` [типа LoadBalancer или NodePort](https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types).

         Так как трафик приходит на конкретный узел, он распределяется между узлами неравномерно. Зато IP-адрес клиента сохраняется.

      Подробнее о политиках управления внешним трафиком читайте в [документации {{ k8s }}](https://kubernetes.io/docs/reference/networking/virtual-ips/#external-traffic-policy).

1. Нажмите кнопку **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.
1. Дождитесь перехода приложения в статус `Deployed`.

## Установка с помощью Helm-чарта {#helm-install}

1. {% include [Установка Helm](../../../_includes/managed-kubernetes/helm-install.md) %}
1. {% include [Настройка kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}
1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с Ingress NGINX выполните команду:

   ```bash
   helm pull oci://{{ mkt-k8s-key.yc_ingress-nginx.helmChart.name }} \
      --version {{ mkt-k8s-key.yc_ingress-nginx.helmChart.tag }} \
      --untar && \
   helm install \
      --namespace <пространство_имен> \
      --create-namespace \
      ingress-nginx ./ingress-nginx/
   ```

   Если вы укажете в параметре `namespace` пространство имен по умолчанию, Ingress NGINX может работать некорректно. Рекомендуем указывать значение, отличное от всех существующих пространств имен (например, `ingress-nginx-space`).

   {% include [Support OCI](../../../_includes/managed-kubernetes/note-helm-experimental-oci.md) %}

## Примеры использования {#examples}

* [{#T}](../create-load-balancer-with-ingress-nginx.md)
* [{#T}](../../tutorials/ingress-cert-manager.md)
* [{#T}](../../tutorials/nginx-ingress-certificate-manager.md)

## См. также {#see-also}

* [Документация Ingress NGINX](https://docs.nginx.com/nginx-ingress-controller/)
* [Документация на GitHub](https://github.com/kubernetes/ingress-nginx)
* [Примеры использования Ingress NGINX](https://github.com/kubernetes/ingress-nginx/tree/main/docs/examples)
* [Известные проблемы](https://github.com/kubernetes/ingress-nginx/issues)
