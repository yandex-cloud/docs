# Миграция сервисов с балансировщика NLB с целевыми ресурсами из кластера {{ managed-k8s-full-name }} на L7-балансировщик ALB с помощью консоли управления


Чтобы мигрировать сервис с сетевого балансировщика на L7-балансировщик:

1. [Ознакомьтесь с рекомендациями по миграции сервисов](#recommendations).
1. [Выполните подготовительные действия](#before-you-begin).
1. [Создайте профиль безопасности {{ sws-name }}](#create-profile-sws).
1. [Установите Ingress-контроллер {{ alb-name }} и создайте ресурсы в кластере {{ managed-k8s-name }}](#install-ingress-nginx). На этом этапе вы подключите профиль безопасности {{ sws-name }} к L7-балансировщику.
1. [Мигрируйте пользовательскую нагрузку с сетевого балансировщика на L7-балансировщик](#migration-nlb-to-alb).

## Рекомендации по миграции сервисов {#recommendations}

{% include [k8s-recommendations](../_tutorials_includes/migration-from-nlb-to-alb/k8s-recommendations.md) %}

## Перед началом работы {#before-you-begin}

1. [Создайте подсети](../../vpc/operations/subnet-create.md) в трех зонах доступности. Эти подсети будут использоваться для L7-балансировщика.

1. Создайте [группы безопасности](../../application-load-balancer/tools/k8s-ingress-controller/security-groups.md), которые разрешают L7-балансировщику получать входящий трафик и отправлять его на целевые ресурсы, а также разрешают целевым ресурсам получать входящий трафик от балансировщика.

1. При использовании протокола HTTPS [добавьте TLS-сертификат](../../certificate-manager/operations/import/cert-create.md#create-certificate) вашего сервиса в [{{ certificate-manager-full-name }}](../../certificate-manager/).

1. [Зарезервируйте публичный статический IP-адрес с защитой от DDoS](../../vpc/operations/get-static-ip.md) на уровне L3-L4 для L7-балансировщика. См. [рекомендации по миграции сервисов](#recommendations).

1. Сервисы {{ managed-k8s-name }}, используемые в качестве бэкендов, должны иметь тип `NodePort`. Если ваши сервисы используют другой тип, измените его на `NodePort`. Подробнее об этом типе см. в документации [{{ k8s }}](https://kubernetes.io/docs/concepts/services-networking/service/#type-nodeport).

## Создайте профиль безопасности {{ sws-name }} {#create-profile-sws}

[Создайте профиль безопасности](../../smartwebsecurity/operations/profile-create.md) {{ sws-name }}, выбрав вариант создания **{{ ui-key.yacloud.smart-web-security.title_default-template }}**.

При создании профиля задайте настройки:

* В поле **{{ ui-key.yacloud.smart-web-security.form.label_default-action }}** выберите `{{ ui-key.yacloud.smart-web-security.form.label_action-allow }}`.
* Для правила **{{ ui-key.yacloud.smart-web-security.overview.label_smart-protection-rule }}** включите опцию **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }} (dry run)**.

С этими настройками будет выполняться только логирование информации о трафике без применения к нему каких-либо действий. Это позволит снизить риск отключения пользователей из-за проблем в настройке профиля. Постепенно вы сможете отключить опцию **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }} (dry run)** и настроить правила с запрещающими действиями в профиле безопасности для вашего сценария.

## Установите Ingress-контроллер {{ alb-name }} и создайте ресурсы в кластере {{ managed-k8s-name }} {#install-ingress-nginx}

{% include [k8s-install-ingress-nginx](../_tutorials_includes/migration-from-nlb-to-alb/k8s-install-ingress-nginx.md) %}

1. {% include [test](../_tutorials_includes/migration-from-nlb-to-alb/test.md) %}

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

1. Чтобы мигрировать пользовательскую нагрузку с сетевого балансировщика на L7-балансировщик, в DNS-сервисе, обслуживающем публичную зону вашего домена, измените значение А-записи для доменного имени сервиса на публичный IP-адрес L7-балансировщика. Если публичная зона домена была создана в [{{ dns-full-name }}](../../dns/), то измените запись [по инструкции](../../dns/operations/resource-record-update.md).

    {% note info %}

    Распространение изменений в записи DNS зависит от значения времени жизни записи (TTL) и количества звеньев цепочки DNS-запросов. Это может занять продолжительное время.

    {% endnote %}

1. По мере распространения изменений в записи DNS наблюдайте за ростом запросов, поступающих на L7-балансировщик:

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится кластер {{ managed-k8s-name }}.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
    1. Выберите нужный кластер.
    1. Слева выберите ![image](../../_assets/console-icons/timestamps.svg) **{{ ui-key.yacloud.k8s.cluster.switch_network }}**, а в правой части — вкладку **{{ ui-key.yacloud.k8s.network.label_ingress }}**. Для вашего `Ingress`-ресурса в столбце **Балансировщик** перейдите по ссылке на L7-балансировщик.
    1. Наблюдайте за пользовательской нагрузкой, поступающей на L7-балансировщик, на графиках [статистики работы балансировщика](../../application-load-balancer/operations/application-load-balancer-get-stats.md).

1. Наблюдайте за снижением нагрузки на сетевой балансировщик с помощью [метрик балансировщика](../../monitoring/metrics-ref/network-load-balancer-ref.md) `processed_bytes` и `processed_packets`. Для визуализации этих метрик можно [создать дашборд](../../monitoring/operations/dashboard/create.md). Отсутствие нагрузки на сетевом балансировщике в течение продолжительного времени свидетельствует о том, что перенос пользовательской нагрузки на L7-балансировщик завершен.

1. (Опционально) После переноса пользовательской нагрузки на L7-балансировщик [удалите сетевой балансировщик](../../network-load-balancer/operations/load-balancer-delete.md).
