# Установка Loki


[Loki](https://grafana.com/oss/loki/) — горизонтально масштабируемая, высокодоступная многопользовательская система агрегации и хранения логов. Loki индексирует не содержимое логов, а набор меток для каждого потока логов.

## Перед началом работы {#before-you-begin}

1. Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

1. [Убедитесь](../connect/security-groups.md), что группы безопасности для кластера Managed Service for Kubernetes и его групп узлов настроены корректно. Если отсутствует какое-либо из правил — [добавьте](../../../vpc/operations/security-group-add-rule.md) его.

    {% note warning %}
    
    От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
    
    {% endnote %}

1. Подготовьтесь к установке Loki:

    1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md) с [ролями](../../../iam/concepts/access-control/roles.md) `storage.uploader` и `storage.viewer`. Он необходим для доступа к [Yandex Object Storage](../../../storage/index.md).
    1. [Создайте статический ключ доступа](../../../iam/operations/authentication/manage-access-keys.md#create-access-key) для [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md) в формате JSON:

        ```bash
        yc iam access-key create \
          --service-account-name=<имя_сервисного_аккаунта> \
          --format=json > sa-key.json
        ```

    1. [Создайте бакет](../../../storage/operations/buckets/create.md) с ограниченным доступом в Object Storage.

## Установка с помощью Yandex Cloud Marketplace {#marketplace-install}

1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
1. Перейдите в сервис **Managed Service for&nbsp;Kubernetes**.
1. Нажмите на имя нужного [кластера Managed Service for Kubernetes](../../concepts/index.md#kubernetes-cluster) и выберите вкладку ![image](../../../_assets/console-icons/shopping-cart.svg) **Marketplace**.
1. В разделе **Доступные для установки приложения** выберите [Loki](https://yandex.cloud/ru/marketplace/products/yc/loki) и нажмите кнопку **Перейти к установке**.
1. Задайте настройки приложения:

   * **Пространство имен** — создайте новое [пространство имен](../../concepts/index.md#namespace) (например, `loki-space`). Если вы оставите пространство имен по умолчанию, Loki может работать некорректно.
   * **Название приложения** — укажите название приложения.
   * **Имя бакета** — укажите имя [бакета](../../../storage/concepts/bucket.md) в Object Storage.
   * **Статический ключ для доступа** — скопируйте содержимое файла `sa-key.json`.
   * **Установить Promtail** — оставьте опцию включенной, чтобы поставлять локальные журналы инстансу Grafana Loki с помощью [агента Promtail](https://grafana.com/docs/loki/latest/clients/promtail/). Обычно агент используется для приложений, для которых нужен регулярный мониторинг.

1. Нажмите кнопку **Установить**.
1. Дождитесь перехода приложения в статус `Deployed`.

## Установка с помощью Helm-чарта {#helm-install}

1. [Установите менеджер пакетов Helm](https://helm.sh/ru/docs/intro/install/) версии не ниже 3.8.0.

1. [Установите kubectl](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](../connect/index.md#kubectl-connect).

1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с Loki выполните команду, указав в ней параметры ресурсов, созданных [ранее](#before-you-begin):

    ```bash
    helm pull oci://cr.yandex/yc-marketplace/yandex-cloud/grafana/loki/chart/loki \
      --version 1.2.0-7 \
      --untar && \
    helm install \
      --namespace <пространство_имен> \
      --create-namespace \
      --set global.bucketname=<имя_бакета> \
      --set-file global.serviceaccountawskeyvalue=<путь_к_файлу_sa-key.json> \
      loki ./loki/
    ```

    Если вы укажете в параметре `namespace` пространство имен по умолчанию, Loki может работать некорректно. Рекомендуем указывать значение, отличное от всех существующих пространств имен (например, `loki-space`).

    {% note info %}
    
    Если вы используете версию Helm ниже 3.8.0, добавьте в начало команды строку `export HELM_EXPERIMENTAL_OCI=1 && \`, чтобы включить поддержку [Open Container Initiative](https://opencontainers.org/) (OCI) в клиенте Helm.
    
    {% endnote %}

1. Убедитесь, что все поды Loki перешли в состояние `Running`:

    ```bash
    kubectl get pods -A -l "app.kubernetes.io/instance=loki"
    ```

## Подключение к Loki {#loki-connect}

После развертывания Loki будет доступен внутри кластера Managed Service for Kubernetes по следующему адресу:

```text
http://<имя_сервиса_Loki_gateway>.<пространство_имен>.svc.cluster.local
```

Чтобы узнать пространство имен и имя сервиса Loki gateway выполните команду:

```bash
kubectl get service -A | grep distributed-gateway
```

Результат:

```text
test-namespace   loki-loki-distributed-gateway   ClusterIP   10.96.168.88   <none>   80/TCP    15m
```

## Полезные ссылки {#see-also}

* [Документация Grafana Loki](https://grafana.com/docs/loki/latest/).