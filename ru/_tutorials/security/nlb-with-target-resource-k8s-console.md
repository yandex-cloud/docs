# Миграция сервисов с балансировщика NLB с целевыми ресурсами из кластера {{ managed-k8s-full-name }} на L7-балансировщик ALB с помощью консоли управления


Чтобы мигрировать сервис с сетевого балансировщика на L7-балансировщик:

1. [Ознакомьтесь с рекомендациями по миграции сервисов](#recommendations).
1. [Создайте инфраструктуру для миграции](#before-you-begin).
1. [Создайте профиль безопасности {{ sws-name }}](#create-profile-sws).
1. [Установите Ingress-контроллер {{ alb-name }} и создайте ресурсы в кластере {{ managed-k8s-name }}](#install-ingress-nginx). На этом этапе вы подключите профиль безопасности {{ sws-name }} к L7-балансировщику.
1. [Проверьте работу L7-балансировщика](#test).
1. [Мигрируйте пользовательскую нагрузку с сетевого балансировщика на L7-балансировщик](#migration-nlb-to-alb).

## Рекомендации по миграции сервисов {#recommendations}

{% include [k8s-recommendations](../_tutorials_includes/migration-from-nlb-to-alb/k8s-recommendations.md) %}

## Создайте инфраструктуру {#before-you-begin}

1. [Создайте подсети](../../vpc/operations/subnet-create.md) в трех зонах доступности. Эти подсети будут использоваться для L7-балансировщика.

1. Создайте [группы безопасности](../../application-load-balancer/tools/k8s-ingress-controller/security-groups.md), которые разрешают L7-балансировщику получать входящий трафик и отправлять его на целевые ресурсы, а также разрешают целевым ресурсам получать входящий трафик от балансировщика.

1. При использовании протокола HTTPS [добавьте TLS-сертификат](../../certificate-manager/operations/import/cert-create.md#create-certificate) вашего сервиса в [{{ certificate-manager-full-name }}](../../certificate-manager/).

1. (Опционально) [Зарезервируйте публичный статический IP-адрес с защитой от DDoS](../../vpc/operations/get-static-ip.md) на уровне L3-L4 для L7-балансировщика.

1. Сервисы {{ managed-k8s-name }}, которые используются в качестве бэкендов, должны иметь тип `NodePort`. Если ваши сервисы используют другой тип, измените его на `NodePort`. Подробнее об этом типе см. в документации [{{ k8s }}](https://kubernetes.io/docs/concepts/services-networking/service/#type-nodeport).

## Создайте профиль безопасности {{ sws-name }} {#create-profile-sws}

{% include [create-profile-sws](../_tutorials_includes/migration-from-nlb-to-alb/create-profile-sws.md) %}

## Установите Ingress-контроллер {{ alb-name }} и создайте ресурсы в кластере {{ managed-k8s-name }} {#install-ingress-nginx}

{% include [Gwin](../../_includes/application-load-balancer/ingress-to-gwin-tip.md) %}

{% include [k8s-install-ingress-nginx](../_tutorials_includes/migration-from-nlb-to-alb/k8s-install-ingress-nginx.md) %}

## Проверьте работу L7-балансировщика {#test}

{% include [test](../_tutorials_includes/migration-from-nlb-to-alb/test.md) %}

## Мигрируйте пользовательскую нагрузку с сетевого балансировщика на L7-балансировщик {#migration-nlb-to-alb}

Выберите один из вариантов миграции:

* [Сохранить публичный IP-адрес для вашего сервиса](#save-public-ip).
* [Не сохранять публичный IP-адрес для вашего сервиса](#not-save-public-ip).

### Сохранить публичный IP-адрес для вашего сервиса {#save-public-ip}

1. Если у сетевого балансировщика используется динамический публичный IP-адрес, [сделайте его статическим](../../vpc/operations/set-static-ip.md).

1. В сетевом балансировщике [удалите все обработчики](../../network-load-balancer/operations/listener-remove.md) для освобождения статического публичного IP-адреса. После этого ваш сервис не будет доступен через сетевой балансировщик.

1. В L7-балансировщике назначьте обработчику публичный IP-адрес, который ранее был у сетевого балансировщика:

    1. Откройте YAML-файл с описанием ресурса `Ingress`.
    1. В разделе `annotations` для поля `ingress.alb.yc.io/external-ipv4-address` укажите публичный IP-адрес, который ранее был у сетевого балансировщика.
    1. Примените изменения с помощью команды:

        ```bash
        kubectl apply -f <файл_с_ресурсом_Ingress>
        ```

1. Дождитесь завершения изменения публичного IP-адреса у ресурса `Ingress`. Посмотреть информацию о ресурсе вы можете с помощью команды:

    ```bash
    kubectl get ingress <имя_ресурса_Ingress> -w
    ```

    После изменения IP-адреса восстановится доступность вашего сервиса через L7-балансировщик.

1. Перейдите в L7-балансировщик:

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится кластер {{ managed-k8s-name }}.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
    1. Выберите нужный кластер.
    1. Слева выберите ![image](../../_assets/console-icons/timestamps.svg) **{{ ui-key.yacloud.k8s.cluster.switch_network }}**, а в правой части — вкладку **{{ ui-key.yacloud.k8s.network.label_ingress }}**. Для вашего `Ingress`-ресурса в столбце **Балансировщик** перейдите по ссылке на L7-балансировщик.
    1. Наблюдайте за пользовательской нагрузкой, поступающей на L7-балансировщик, на графиках [статистики работы балансировщика](../../application-load-balancer/operations/application-load-balancer-get-stats.md).

1. Удалите освободившийся статический публичный IP-адрес, который был зарезервирован для L7-балансировщика.

1. (Опционально) После переноса пользовательской нагрузки на L7-балансировщик [удалите сетевой балансировщик](../../network-load-balancer/operations/load-balancer-delete.md).

### Не сохранять публичный IP-адрес для вашего сервиса {#not-save-public-ip}

{% include [k8s-not-save-public-ip](../_tutorials_includes/migration-from-nlb-to-alb/k8s-not-save-public-ip.md) %}
