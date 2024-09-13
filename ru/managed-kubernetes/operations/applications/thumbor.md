# Установка Thumbor


[Thumbor](https://thumbor.readthedocs.io/en/latest/) — проект с [открытым исходным кодом](https://github.com/thumbor/thumbor), предназначенный для обработки изображений по запросу. Thumbor работает как HTTP-сервис и выполняет такие преобразования как обрезка изображений, масштабирование, [наложение фильтров](https://thumbor.readthedocs.io/en/latest/filters.html#available-filters) и [многие другие](https://thumbor.readthedocs.io/en/latest/imaging.html).

Возможности Thumbor:
* Поддержка всех популярных форматов изображений.
* Умная обрезка и масштабирование.
* Ускорение обработки изображений за счет кэширования.
* Поддержка различных типов хранилищ (локальный диск, {{ objstorage-full-name }} и другие).
* Распознавание лиц и предметов (очки, особенности внешности) на базе [технологии компьютерного зрения](https://github.com/opencv/opencv).
* Интеграция с различными языками программирования.

## Перед началом работы {#before-you-begin}

1. [Создайте бакет](../../../storage/operations/buckets/create.md) с ограниченным доступом в {{ objstorage-name }}.
1. [Загрузите изображения в бакет](../../../storage/operations/objects/upload.md#simple).
1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md), необходимый для работы Thumbor.
1. Создайте для него [статический ключ](../../../iam/operations/sa/create-access-key.md) и сохраните в файл `sa-key.json`:

   ```bash
   yc iam access-key create \
     --service-account-name <имя_сервисного_аккаунта_для_Thumbor> \
     --format json > sa-key.json
   ```

1. [Задайте права доступа на чтение объектов бакета](../../../storage/operations/objects/edit-acl.md) для сервисного аккаунта.

1. {% include [check-sg-prerequsites](../../../_includes/managed-kubernetes/security-groups/check-sg-prerequsites-lvl3.md) %}

    {% include [sg-common-warning](../../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

## Установка с помощью {{ marketplace-full-name }} {#marketplace-install}

1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Нажмите на имя нужного кластера {{ k8s }} и выберите вкладку ![image](../../../_assets/console-icons/shopping-cart.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}**.
1. В разделе **{{ ui-key.yacloud.marketplace-v2.label_available-products }}** выберите [Thumbor](/marketplace/products/yc/thumbor) и нажмите кнопку **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
1. Задайте настройки приложения:
   * **Пространство имен** — выберите [пространство имен](../../concepts/index.md#namespace) для Thumbor или создайте новое.
   * **Название приложения** — укажите название приложения.
   * **Имя бакета** — укажите [имя бакета](#before-you-begin), созданного ранее.
   * **Статический ключ для доступа к {{ objstorage-name }}** — вставьте содержимое файла `sa-key.json`.
   * (Опционально) **Ключ безопасности** — укажите ключ безопасности для подписывания URL.
   * **Разрешить URL без подписи (unsafe)** — выберите эту опцию, если вы не указывали ключ безопасности на предыдущем шаге.
   * **Подкаталог в бакете** — укажите имя каталога в бакете (без завершающего символа `/`), в котором находятся изображения.
1. Нажмите кнопку **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.

    Для обеспечения работы Thumbor будет автоматически создан сервис {{ k8s }} типа `LoadBalancer` и соответствующий ему [балансировщик {{ network-load-balancer-full-name }}](../../../network-load-balancer).

1. Дождитесь перехода приложения в статус `Deployed`.

## Установка с помощью Helm-чарта {#helm-install}

1. {% include [Установка Helm](../../../_includes/managed-kubernetes/helm-install.md) %}

1. {% include [Настройка kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}

1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с Thumbor выполните команду:

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
      thumbor ./thumbor
     ```

     {% include [Support OCI](../../../_includes/managed-kubernetes/note-helm-experimental-oci.md) %}

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
      thumbor ./thumbor/
     ```

     {% include [Support OCI](../../../_includes/managed-kubernetes/note-helm-experimental-oci.md) %}

   {% endlist %}

    Для обеспечения работы Thumbor будет автоматически создан сервис {{ k8s }} типа `LoadBalancer` и соответствующий ему [балансировщик {{ network-load-balancer-full-name }}](../../../network-load-balancer).

## Получение доступа к приложению {#app-access}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
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

{% include [Настройка групп безопасности при недоступности ресурса](../../../_includes/managed-kubernetes/security-groups/check-sg-if-url-unavailable-lvl3.md) %}

Подробнее о работе с изображениями см. в [документации Thumbor](https://thumbor.readthedocs.io/en/latest/imaging.html).

## Что дальше {#what-is-next}

Узнайте, как использовать приложение Thumbor для редактирования изображений на вашем сайте. [Пример работы с Thumbor](../../tutorials/marketplace/thumbor.md), рассмотренный в документации, включает в себя настройку сервиса [{{ cdn-full-name }}](../../../cdn/concepts/index.md). Он позволяет снизить скорость загрузки изображений на сайте.

## См. также {#see-also}

* [Документация Thumbor](https://thumbor.readthedocs.io/en/latest/).
* [Документация {{ objstorage-name }}](../../../storage/).
* [Документация {{ network-load-balancer-name }}](../../../network-load-balancer/).
