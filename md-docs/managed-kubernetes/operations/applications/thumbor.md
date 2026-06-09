# Установка Thumbor


[Thumbor](https://thumbor.readthedocs.io/en/latest/) — проект с [открытым исходным кодом](https://github.com/thumbor/thumbor), предназначенный для обработки изображений по запросу. Thumbor работает как HTTP-сервис и выполняет такие преобразования как обрезка изображений, масштабирование, [наложение фильтров](https://thumbor.readthedocs.io/en/latest/filters.html#available-filters) и [многие другие](https://thumbor.readthedocs.io/en/latest/imaging.html).

Возможности Thumbor:
* Поддержка всех популярных форматов изображений.
* Умная обрезка и масштабирование.
* Ускорение обработки изображений за счет кеширования.
* Поддержка различных типов хранилищ (локальный диск, {{ objstorage-full-name }} и другие).
* Распознавание лиц и предметов (очки, особенности внешности) на базе [технологии компьютерного зрения](https://github.com/opencv/opencv).
* Интеграция с различными языками программирования.

## Перед началом работы {#before-you-begin}

1. [Создайте бакет](../../../storage/operations/buckets/create.md) с ограниченным доступом в {{ objstorage-name }}.
1. [Загрузите изображения в бакет](../../../storage/operations/objects/upload.md#simple).
1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md), необходимый для работы Thumbor.
1. Создайте для него [статический ключ](../../../iam/operations/authentication/manage-access-keys.md#create-access-key) и сохраните в файл `sa-key.json`:

   ```bash
   yc iam access-key create \
     --service-account-name <имя_сервисного_аккаунта_для_Thumbor> \
     --format json > sa-key.json
   ```

1. [Задайте права доступа на чтение объектов бакета](../../../storage/operations/objects/edit-acl.md) для сервисного аккаунта.

1. [Убедитесь](../connect/security-groups.md), что группы безопасности для кластера {{ managed-k8s-name }} и его групп узлов настроены корректно. Если отсутствует какое-либо из правил — [добавьте](../../../vpc/operations/security-group-add-rule.md) его.

    {% note warning %}
    
    От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
    
    {% endnote %}

## Установка с помощью {{ marketplace-full-name }} {#marketplace-install}

1. В [консоли управления]({{ link-console-main }}) выберите каталог.
1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Нажмите на имя нужного кластера {{ k8s }} и выберите вкладку ![image](../../../_assets/console-icons/shopping-cart.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}**.
1. В разделе **{{ ui-key.yacloud.marketplace-v2.label_available-products }}** выберите [Thumbor](https://yandex.cloud/ru/marketplace/products/yc/thumbor) и нажмите кнопку **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
1. Задайте настройки приложения:
   * **Пространство имен** — создайте новое [пространство имен](../../concepts/index.md#namespace) (например, `thumbor-space`). Если вы оставите пространство имен по умолчанию, Thumbor может работать некорректно.
   * **Название приложения** — укажите название приложения.
   * **Имя бакета** — укажите [имя бакета](#before-you-begin), созданного ранее.
   * **Статический ключ для доступа к {{ objstorage-name }}** — вставьте содержимое файла `sa-key.json`.
   * (Опционально) **Ключ безопасности** — укажите ключ безопасности для подписывания URL.
   * **Разрешить URL без подписи (unsafe)** — выберите эту опцию, если вы не указывали ключ безопасности на предыдущем шаге.
   * **Подкаталог в бакете** — укажите имя каталога в бакете (без завершающего символа `/`), в котором находятся изображения.
   * (Опционально) **Публичный IP-адрес** — выберите эту опцию, чтобы выделить для сервиса публичный IP-адрес. Для обеспечения работы Thumbor будет автоматически создан сервис {{ k8s }} типа `LoadBalancer` и соответствующий ему [балансировщик {{ network-load-balancer-full-name }}](../../../network-load-balancer/index.md).
1. Нажмите кнопку **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.
1. Дождитесь перехода приложения в статус `Deployed`.

## Установка с помощью Helm-чарта {#helm-install}

1. [Установите менеджер пакетов Helm](https://helm.sh/ru/docs/intro/install/) версии не ниже 3.8.0.

1. [Установите kubectl]({{ k8s-docs }}/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](../connect/index.md#kubectl-connect).

1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с Thumbor выполните команду, указав в ней параметры ресурсов, созданных [ранее](#before-you-begin):

   {% list tabs %}

   - URL без подписи разрешены

     ```bash
     helm pull oci://{{ mkt-k8s-key.yc_thumbor.helmChart.name }} \
       --version {{ mkt-k8s-key.yc_thumbor.helmChart.tag }} \
       --untar && \
     helm install \
       --namespace <пространство_имен_для_Thumbor> \
       --create-namespace \
       --set bucket_name='<имя_бакета>' \
       --set allow_unsafe_url='true' \
       --set root_path='<имя_подкаталога_в_бакете>' \
       --set-file saAccessKeyFile='sa-key.json' \
       --set public_address='true' \
      thumbor ./thumbor
     ```

     Если вы укажете в параметре `namespace` пространство имен по умолчанию, Thumbor может работать некорректно. Рекомендуем указывать значение, отличное от всех существующих пространств имен (например, `thumbor-space`).

     {% note info %}
     
     Если вы используете версию Helm ниже 3.8.0, добавьте в начало команды строку `export HELM_EXPERIMENTAL_OCI=1 && \`, чтобы включить поддержку [Open Container Initiative](https://opencontainers.org/) (OCI) в клиенте Helm.
     
     {% endnote %}

   - URL без подписи запрещены

     ```bash
     helm pull oci://{{ mkt-k8s-key.yc_thumbor.helmChart.name }} \
       --version {{ mkt-k8s-key.yc_thumbor.helmChart.tag }} \
       --untar && \
     helm install \
       --namespace <пространство_имен_для_Thumbor> \
       --create-namespace \
       --set bucket_name='<имя_бакета>' \
       --set allow_unsafe_url='false' \
       --set security_key='<ключ_безопасности_для_подписывания_URL>' \
       --set root_path='<имя_подкаталога_в_бакете>' \
       --set-file saAccessKeyFile='sa-key.json' \
       --set public_address='true' \
      thumbor ./thumbor/
     ```

     Если вы укажете в параметре `namespace` пространство имен по умолчанию, Thumbor может работать некорректно. Рекомендуем указывать значение, отличное от всех существующих пространств имен (например, `thumbor-space`).

     {% note info %}
     
     Если вы используете версию Helm ниже 3.8.0, добавьте в начало команды строку `export HELM_EXPERIMENTAL_OCI=1 && \`, чтобы включить поддержку [Open Container Initiative](https://opencontainers.org/) (OCI) в клиенте Helm.
     
     {% endnote %}

   {% endlist %}

    Если в параметр `public_address` передано `true`, то для обеспечения работы Thumbor будет автоматически создан сервис {{ k8s }} типа `LoadBalancer` и соответствующий ему [балансировщик {{ network-load-balancer-name }}](../../../network-load-balancer/index.md).

## Получение доступа к приложению {#app-access}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
  1. Узнайте IP-адрес для балансировщика с описанием `cluster <имя_вашего_кластера>, service <пространство_имен>/thumbor`.
  1. В адресной строке браузера откройте ссылку `http://<IP-адрес_балансировщика>/unsafe/<имя_изображения_в_бакете>`.

- CLI {#cli}

  1. Узнайте IP-адрес балансировщика с помощью команды:

     ```bash
     kubectl get svc \
       --namespace <пространство_имен> \
       --output jsonpath='{.status.loadBalancer.ingress[0].ip}' thumbor
     ```

  1. В адресной строке браузера откройте ссылку `http://<IP-адрес_балансировщика>/unsafe/<имя_изображения_в_бакете>`.

{% endlist %}

{% note info %}

Если ресурс недоступен по указанному URL, то [убедитесь](../connect/security-groups.md), что группы безопасности для кластера {{ managed-k8s-name }} и его групп узлов настроены корректно. Если отсутствует какое-либо из правил — [добавьте его](../../../vpc/operations/security-group-add-rule.md).

{% endnote %}

Подробнее о работе с изображениями см. в [документации Thumbor](https://thumbor.readthedocs.io/en/latest/imaging.html).

## Что дальше {#what-is-next}

Узнайте, как использовать приложение Thumbor для редактирования изображений на вашем сайте. [Пример работы с Thumbor](../../tutorials/marketplace/thumbor.md), рассмотренный в документации, включает в себя настройку сервиса [{{ cdn-full-name }}](../../../cdn/concepts/index.md). Он позволяет снизить скорость загрузки изображений на сайте.

## См. также {#see-also}

* [Документация Thumbor](https://thumbor.readthedocs.io/en/latest/).
* [Документация {{ objstorage-name }}](../../../storage/index.md).
* [Документация {{ network-load-balancer-name }}](../../../network-load-balancer/index.md).