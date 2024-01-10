# Редактирование изображений для сайтов с помощью приложения Thumbor

[Thumbor](https://thumbor.readthedocs.io/en/latest/) — проект с [открытым исходным кодом](https://github.com/thumbor/thumbor), предназначенный для обработки изображений по запросу. Thumbor содержит основные настройки для редактирования изображений. Например, можно изменить размер исходного изображения, увеличить контрастность, убрать эффект красных глаз.

Thumbor удобно использовать для подготовки изображений для сайтов. Например, можно создать миниатюры в качестве превью видео. Thumbor поддерживает кеширование изображений, что позволяет снизить трудозатраты на поддержку сайта.

В примере ниже изображения размещаются на сайте и редактируются с помощью Thumbor: меняется размер и добавляется водяной знак. Чтобы снизить время загрузки изображений, для сайта настраивается [CDN (сеть распространения контента)](../../glossary/cdn.md) с помощью сервиса [{{ cdn-full-name }}](../../cdn/concepts/index.md).

Чтобы отредактировать изображения с помощью Thumbor и подключить CDN:

1. [Установите Thumbor](#install).
1. [Подготовьте изображения для тестирования Thumbor](#images).
1. [Настройте {{ cdn-name }}](#cdn).
1. [Проверьте результат](#check-result).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

### Подготовьте инфраструктуру {#infra}

{% list tabs group=instructions %}

- Вручную {#manual}

   1. [Создайте сервисные аккаунты](../../iam/operations/sa/create.md):

      * Сервисный аккаунт для ресурсов с [ролями](../../managed-kubernetes/security/index.md#yc-api) `k8s.clusters.agent` и `vpc.publicAdmin` на каталог, в котором создается кластер {{ managed-k8s-name }}. От имени этого аккаунта будут создаваться ресурсы для кластера {{ managed-k8s-name }}.

      * Сервисный аккаунт для узлов с ролью [{{ roles-cr-puller }}](../../container-registry/security/index.md#required-roles) на каталог с [реестром](../../container-registry/concepts/registry.md) Docker-образов. От его имени узлы будут скачивать из реестра Docker-образы.

         Вы можете использовать один и тот же сервисный аккаунт для обеих операций.

      * Сервисный аккаунт `thumbor-sa` для работы с Thumbor.

   1. [Создайте кластер](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) {{ managed-k8s-name }} и [группу узлов](../../managed-kubernetes/operations/node-group/node-group-create.md) любой подходящей конфигурации.
   1. [Cоздайте бакет](../../storage/operations/buckets/create.md) в {{ objstorage-full-name }}.
   1. [Предоставьте сервисному аккаунту](../../storage/operations/objects/edit-acl.md) `thumbor-sa` разрешение `READ` на бакет.

- {{ TF }} {#tf}

   1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
   1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
   1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
   1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

   1. Скачайте в ту же рабочую директорию файл конфигурации [k8s-for-thumbor.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/managed-kubernetes/k8s-for-thumbor.tf).

      В этом файле описаны:

      * Сеть.
      * Подсеть.
      * [Группы безопасности и правила](../../managed-kubernetes/operations/connect/security-groups.md) для нескольких функций:

         * сетевой балансировщик нагрузки;
         * передача трафика между [мастером](../../managed-kubernetes/concepts/index.md#master) и [узлами](../../managed-kubernetes/concepts/index.md#node-group);
         * передача трафика между [подами](../../managed-kubernetes/concepts/index.md#pod) и [сервисами](../../managed-kubernetes/concepts/index.md#service);
         * проверка работоспособности узлов с помощью ICMP-запросов из подсетей внутри {{ yandex-cloud }};
         * подключение к сервисам из интернета.

      * Сервисные аккаунты для различных сервисов:

         * для работы кластера и группы узлов {{ managed-k8s-name }};
         * для приложения Thumbor;
         * для создания бакетов {{ objstorage-name }}.

      * Кластер {{ managed-k8s-name }}.
      * Группа узлов.
      * Статический ключ доступа для создания бакета.
      * Бакет.

   1. Укажите в файле `k8s-for-thumbor.tf`:

      * [идентификатор каталога](../../resource-manager/operations/folder/get-id.md);
      * [версию {{ k8s }}](../../managed-kubernetes/concepts/release-channels-and-updates.md) для кластера и групп узлов {{ managed-k8s-name }}.

   1. Проверьте корректность файла конфигурации {{ TF }} с помощью команды:

      ```bash
      terraform validate
      ```

      Если в файле есть ошибки, {{ TF }} на них укажет.

   1. Создайте инфраструктуру:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

### Установите дополнительные зависимости {#prepare}

1. {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

1. {% include [install-kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}


## Добавьте сертификат в {{ certificate-manager-name }} {#add-certificate}

Выпустите и [добавьте](../../certificate-manager/operations/managed/cert-create.md) в {{ certificate-manager-name }} сертификат Let's Encrypt® или [загрузите](../../certificate-manager/operations/import/cert-create.md) собственный сертификат.

Для сертификата Let's Encrypt® пройдите [проверку прав](../../certificate-manager/operations/managed/cert-validate.md) на домен, который указан в сертификате.


## Установите Thumbor {#install}

1. Создайте [статический ключ доступа](../../iam/concepts/authorization/access-key.md) для сервисного аккаунта `thumbor-sa` и сохраните ключ в файл `sa-key.json`:

   ```bash
   yc iam access-key create --service-account-name thumbor-sa \
      --format json > sa-key.json
   ```

1. [Установите приложение Thumbor](../../managed-kubernetes/operations/applications/thumbor.md) с параметрами:

   * **Пространство имен** — `thumbor`.
   * **Название приложения** — `thumbor`.
   * **Имя бакета** — бакет, в который вы загрузили изображения.
   * **Статический ключ для доступа к {{ objstorage-name }}** — содержимое файла `sa-key.json`.
   * **URL без подписи** — разрешены.

## Подготовьте изображения для тестирования Thumbor {#images}

1. Скачайте изображения:

   * [poster_rodents_bunnysize.jpg](https://peach.blender.org/wp-content/uploads/poster_rodents_bunnysize.jpg);
   * [poster_bunny_bunnysize.jpg](https://peach.blender.org/wp-content/uploads/poster_bunny_bunnysize.jpg);
   * [cc.xlarge.png](https://mirrors.creativecommons.org/presskit/icons/cc.xlarge.png) (символ организации [Creative Commons](https://ru.wikipedia.org/wiki/Creative_Commons)).

1. Загрузите изображения в бакет:

   {% list tabs group=instructions %}

   - Вручную {#manual}

      1. В [консоли управления]({{ link-console-main }}) выберите каталог, в который нужно загрузить объект.
      1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
      1. Нажмите на имя бакета.
      1. Нажмите кнопку **{{ ui-key.yacloud.storage.bucket.button_upload }}**.
      1. В появившемся окне выберите необходимые файлы и нажмите кнопку **Открыть**.
      1. Нажмите кнопку **{{ ui-key.yacloud.storage.button_upload }}**.
      1. Обновите страницу.

      В консоли управления информация о количестве объектов в бакете и занятом месте обновляется с задержкой в несколько минут.

   - {{ TF }} {#tf}

      Загрузить объекты в бакет можно только после его создания, поэтому для загрузки изображений используется отдельный файл конфигурации.

      1. В рабочую директорию с файлом `k8s-for-thumbor.tf` скачайте файл конфигурации [images-for-thumbor.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/managed-kubernetes/images-for-thumbor.tf). В этом файле описаны объекты {{ objstorage-name }} — скачанные изображения, которые будут загружены в бакет.
      1. Укажите в файле `images-for-thumbor.tf` относительные или абсолютные пути до изображений. Например, если изображения хранятся в одной директории с файлами конфигурации, укажите:

         * `poster_rodents_bunnysize.jpg`
         * `poster_bunny_bunnysize.jpg`
         * `cc.xlarge.png`

      1. Выполните команду `terraform init` в директории с конфигурационными файлами. Эта команда инициализирует провайдер, указанный в конфигурационных файлах, и позволяет работать с ресурсами и источниками данных провайдера.
      1. Проверьте корректность файла конфигурации {{ TF }} с помощью команды:

         ```bash
         terraform validate
         ```

         Если в файле есть ошибки, {{ TF }} на них укажет.

      1. Запустите загрузку изображений в бакет:

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

         {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

   {% endlist %}

## Настройте CDN {#cdn}

1. Активируйте CDN-провайдер для вашего каталога:

   ```bash
   yc cdn provider activate --type=gcore --folder-id=<идентификатор_каталога>
   ```

1. Получите доменное имя CDN-провайдера:

   ```bash
   yc cdn resource get-provider-cname
   ```

   Пример результата:

   ```text
   cname: {{ cname-example }}
   folder_id: {{ folder-id-example }}
   ```

   Доменное имя указано в параметре `cname`.

1. Настройте CNAME для своего домена:

   1. Перейдите в настройки DNS вашего домена на сайте компании, которая предоставляет вам услуги DNS-хостинга.
   1. Подготовьте CNAME-запись таким образом, чтобы она указывала на скопированный ранее адрес в домене `.edgecdn.ru`. Например, если доменное имя сайта — `{{ domain-name-example }}`, создайте CNAME-запись или замените уже существующую запись для `cdn`:

      ```http
      cdn CNAME {{ cname-example }}.
      ```

1. Получите внешний IP-адрес Thumbor:

   ```bash
   kubectl -n thumbor get svc thumbor \
      -o jsonpath='{.status.loadBalancer.ingress[0].ip}'
   ```

1. Создайте группу источников в {{ cdn-name }}:

   ```bash
   yc cdn origin-group create \
      --name thumbor \
      --origin source=<IP-адрес_Thumbor>,enabled=true
   ```

   Пример результата:

   ```text
   id: "123***"
   folder_id: {{ folder-id-example }}
   name: thumbor
   use_next: true
   origins:
     - id: "234****"
       origin_group_id: "345***"
       source: {{ domain-name-example }}
       enabled: true
   ```

   В результате возвращается идентификатор группы источников в параметре `origin_group_id`. Этот идентификатор понадобится в следующем шаге.

1. Создайте CDN-ресурс и подключите к нему группу источников:

   ```bash
   yc cdn resource create \
      --cname <доменное_имя_ресурса> \
      --origin-group-id=<идентификатор_группы_источников> \
      --origin-protocol=https \
      --ignore-query-string \
      --cert-manager-ssl-cert-id <идентификатор_сертификата> \
      --forward-host-header
   ```

   Пример доменного имени ресурса: `{{ domain-name-example }}`.

   Пример результата:

   ```text
   id: bc855oumelrq********
   folder_id: {{ folder-id-example }}
   cname: {{ domain-name-example }}
   created_at: "2022-01-15T15:13:42.827643Z"
   updated_at: "2022-01-15T15:13:42.827671Z"
   active: true
   options:
     edge_cache_settings:
       enabled: true
       default_value: "345600"
     query_params_options:
       ignore_query_string:
         enabled: true
         value: true
     host_options:
       forward_host_header:
         enabled: true
         value: true
     stale:
       enabled: true
       value:
         - error
         - updating
   origin_group_id: "345***"
   origin_group_name: thumbor
   origin_protocol: HTTPS
   ssl_certificate:
     type: CM
     status: CREATING
   ```

   Подключение CDN-ресурса занимает от 15 до 30 минут.

## Проверьте результат {#check-result}

Откройте ваш сайт по URL:

* `https://<доменное_имя_ресурса>/unsafe/300x400/filters:watermark(cc.xlarge.png,10,-10,80,20)/poster_bunny_bunnysize.jpg`
* `https://<доменное_имя_ресурса>/unsafe/600x800/filters:watermark(cc.xlarge.png,10,-10,80,20)/poster_bunny_bunnysize.jpg`
* `https://<доменное_имя_ресурса>/unsafe/400x300/filters:watermark(cc.xlarge.png,-10,10,80,15)/poster_rodents_bunnysize.jpg`
* `https://<доменное_имя_ресурса>/unsafe/800x600/filters:watermark(cc.xlarge.png,-10,10,80,15)/poster_rodents_bunnysize.jpg`

Отобразятся подготовленные изображения с различным размером. На каждом изображении есть водяной знак [Creative Commons](https://ru.wikipedia.org/wiki/Creative_Commons).

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

{% list tabs group=instructions %}

- Вручную {#manual}

   Удалите:

   1. [CDN-ресурс](../../cdn/operations/resources/delete-resource.md).
   1. [Группу источников CDN](../../cdn/operations/origin-groups/delete-group.md).
   1. [Группу узлов](../../managed-kubernetes/operations/node-group/node-group-delete.md).
   1. [Кластер {{ managed-k8s-name }}](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
   1. [Публичный статический IP-адрес](../../vpc/operations/address-delete.md), если вы зарезервировали его для кластера.
   1. [Сервисные аккаунты](../../iam/operations/sa/delete.md).
   1. [Бакеты](../../storage/operations/buckets/delete.md) и [объекты в них](../../storage/operations/objects/delete.md).

- {{ TF }} {#tf}

   1. В терминале перейдите в директорию с планом инфраструктуры.
   1. Удалите конфигурационный файл `images-for-thumbor.tf`. Чтобы удалить бакет, сначала удалите объекты в нем.
   1. Проверьте корректность изменений с помощью команды:

      ```bash
      terraform validate
      ```

      Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

   1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   1. Удалите конфигурационный файл `k8s-for-thumbor.tf`.
   1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

      ```bash
      terraform validate
      ```

      Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

   1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      Все ресурсы, которые были описаны в конфигурационном файле `k8s-for-thumbor.tf`, будут удалены.

{% endlist %}
