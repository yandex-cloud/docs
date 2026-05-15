# Редактирование изображений для сайтов с помощью приложения Thumbor в Yandex Managed Service for Kubernetes

# Редактирование изображений для сайтов с помощью приложения Thumbor


[Thumbor](https://thumbor.readthedocs.io/en/latest/) — проект с [открытым исходным кодом](https://github.com/thumbor/thumbor), предназначенный для обработки изображений по запросу. Thumbor содержит основные настройки для редактирования изображений. Например, можно изменить размер исходного изображения, увеличить контрастность, убрать эффект красных глаз.

Thumbor удобно использовать для подготовки изображений для сайтов. Например, можно создать миниатюры в качестве превью видео. Thumbor поддерживает кеширование изображений, что позволяет снизить трудозатраты на поддержку сайта.

В примере ниже изображения размещаются на сайте и редактируются с помощью Thumbor: меняется размер и добавляется водяной знак. Чтобы снизить время загрузки изображений, для сайта настраивается [CDN (сеть распространения контента)](../../glossary/cdn.md) с помощью сервиса [Yandex Cloud CDN](../../cdn/concepts/index.md).

Чтобы отредактировать изображения с помощью Thumbor и подключить CDN:

1. [Установите Thumbor](#install).
1. [Подготовьте изображения для тестирования Thumbor](#images).
1. [Настройте Cloud CDN](#cdn).
1. [Проверьте результат](#check-result).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за кластер Managed Service for Kubernetes: использование мастера и исходящий трафик (см. [тарифы Managed Service for Kubernetes](../../managed-kubernetes/pricing.md)).
* Плата за узлы кластера (ВМ): использование вычислительных ресурсов, операционной системы и хранилища (см. [тарифы Compute Cloud](../../compute/pricing.md)).
* Плата за публичный IP-адрес, если он назначен узлам кластера (см. [тарифы Virtual Private Cloud](../../vpc/pricing.md#prices-public-ip)).
* Плата за бакет Object Storage: хранение данных и выполнение операций с ними (см. [тарифы Object Storage](../../storage/pricing.md)).
* Плата за сервис Cloud CDN: исходящий трафик (см. [тарифы Object Storage](../../cdn/pricing.md)).


## Перед началом работы {#before-you-begin}

### Подготовьте инфраструктуру {#infra}

{% list tabs group=instructions %}

- Вручную {#manual}

   1. [Создайте сервисные аккаунты](../../iam/operations/sa/create.md):

      * Сервисный аккаунт для ресурсов с [ролями](../../managed-kubernetes/security/index.md#yc-api) `k8s.clusters.agent` и `vpc.publicAdmin` на каталог, в котором создается кластер Managed Service for Kubernetes. От имени этого аккаунта будут создаваться ресурсы для кластера Managed Service for Kubernetes.

      * Сервисный аккаунт для узлов с ролью [container-registry.images.puller](../../container-registry/security/index.md#required-roles) на каталог с [реестром](../../container-registry/concepts/registry.md) Docker-образов. От его имени узлы будут скачивать из реестра Docker-образы.

         Вы можете использовать один и тот же сервисный аккаунт для обеих операций.

      * Сервисный аккаунт `thumbor-sa` для работы с Thumbor.

   1. [Создайте группы безопасности](../../managed-kubernetes/operations/connect/security-groups.md) для кластера Managed Service for Kubernetes и входящих в него групп узлов.

        {% note warning %}
        
        От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
        
        {% endnote %}

   1. [Создайте кластер](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) Managed Service for Kubernetes и [группу узлов](../../managed-kubernetes/operations/node-group/node-group-create.md) любой подходящей конфигурации. При создании укажите группы безопасности, подготовленные ранее.
   1. [Cоздайте бакет](../../storage/operations/buckets/create.md) в Yandex Object Storage.
   1. [Предоставьте сервисному аккаунту](../../storage/operations/objects/edit-acl.md) `thumbor-sa` разрешение `READ` на бакет.

- Terraform {#tf}

   1. Если у вас еще нет Terraform, [установите его](../infrastructure-management/terraform-quickstart.md#install-terraform).
   1. [Получите данные для аутентификации](../infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
   1. [Настройте и инициализируйте провайдер](../infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
   1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

   1. Скачайте в ту же рабочую директорию файл конфигурации [k8s-for-thumbor.tf](https://github.com/yandex-cloud-examples/yc-mk8s-thumbor/blob/main/k8s-for-thumbor.tf).

      В этом файле описаны:

      * Сеть.
      * Подсеть.
      * Сервисные аккаунты для различных сервисов:

         * для работы кластера и группы узлов Managed Service for Kubernetes;
         * для приложения Thumbor;
         * для создания бакетов Object Storage.

      * Кластер Managed Service for Kubernetes.
      * Группа узлов.
      
      * [Группы безопасности](../../vpc/concepts/security-groups.md), которые содержат [необходимые правила](../../managed-kubernetes/operations/connect/security-groups.md) для кластера Managed Service for Kubernetes и входящих в него групп узлов.

        {% note warning %}
        
        От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
        
        {% endnote %}

      * Статический ключ доступа для создания бакета.
      * Бакет.

   1. Укажите в файле `k8s-for-thumbor.tf`:

      * [идентификатор каталога](../../resource-manager/operations/folder/get-id.md);
      * [версию Kubernetes](../../managed-kubernetes/concepts/release-channels-and-updates.md) для кластера и групп узлов Managed Service for Kubernetes.

   1. Проверьте корректность файла конфигурации Terraform с помощью команды:

      ```bash
      terraform validate
      ```

      Если в файле есть ошибки, Terraform на них укажет.

   1. Создайте инфраструктуру:

      1. Выполните команду для просмотра планируемых изменений:
      
         ```bash
         terraform plan
         ```
      
         Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
      
      1. Если вас устраивают планируемые изменения, внесите их:
         1. Выполните команду:
      
            ```bash
            terraform apply
            ```
      
         1. Подтвердите изменение ресурсов.
         1. Дождитесь завершения операции.

      В указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления](https://console.yandex.cloud).

{% endlist %}

### Установите дополнительные зависимости {#prepare}

1. Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

   По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

1. [Установите kubectl](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](../../managed-kubernetes/operations/connect/index.md#kubectl-connect).


## Добавьте сертификат в Certificate Manager {#add-certificate}

Поддерживаются сертификаты из [Yandex Certificate Manager](../../certificate-manager/index.md). Вы можете [выпустить новый сертификат Let's Encrypt®](../../certificate-manager/operations/managed/cert-create.md) или [загрузить собственный](../../certificate-manager/operations/import/cert-create.md).

Сертификат должен находиться в том же [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором расположен ваш CDN-ресурс.

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
   * **Статический ключ для доступа к Object Storage** — содержимое файла `sa-key.json`.
   * **URL без подписи** — разрешены.

## Подготовьте изображения для тестирования Thumbor {#images}

1. Скачайте изображения:

   * [poster_rodents_bunnysize.jpg](https://peach.blender.org/wp-content/uploads/poster_rodents_bunnysize.jpg);
   * [poster_bunny_bunnysize.jpg](https://peach.blender.org/wp-content/uploads/poster_bunny_bunnysize.jpg);
   * [cc.xlarge.png](https://mirrors.creativecommons.org/presskit/icons/cc.xlarge.png) (символ организации [Creative Commons](https://ru.wikipedia.org/wiki/Creative_Commons)).

1. Загрузите изображения в бакет:

   {% list tabs group=instructions %}

   - Вручную {#manual}

      1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в который нужно загрузить объект.
      1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Object Storage**.
      1. Нажмите на имя бакета.
      1. Нажмите кнопку **Загрузить**.
      1. В появившемся окне выберите необходимые файлы и нажмите кнопку **Открыть**.
      1. Нажмите кнопку **Загрузить**.
      1. Обновите страницу.

      В консоли управления информация о количестве объектов в бакете и занятом месте обновляется с задержкой в несколько минут.

   - Terraform {#tf}

      Загрузить объекты в бакет можно только после его создания, поэтому для загрузки изображений используется отдельный файл конфигурации.

      1. В рабочую директорию с файлом `k8s-for-thumbor.tf` скачайте файл конфигурации [images-for-thumbor.tf](https://github.com/yandex-cloud-examples/yc-mk8s-thumbor/blob/main/images-for-thumbor.tf). В этом файле описаны объекты Object Storage — скачанные изображения, которые будут загружены в бакет.
      1. Укажите в файле `images-for-thumbor.tf` относительные или абсолютные пути до изображений. Например, если изображения хранятся в одной директории с файлами конфигурации, укажите:

         * `poster_rodents_bunnysize.jpg`
         * `poster_bunny_bunnysize.jpg`
         * `cc.xlarge.png`

      1. Выполните команду `terraform init` в директории с конфигурационными файлами. Эта команда инициализирует провайдер, указанный в конфигурационных файлах, и позволяет работать с ресурсами и источниками данных провайдера.
      1. Проверьте корректность файла конфигурации Terraform с помощью команды:

         ```bash
         terraform validate
         ```

         Если в файле есть ошибки, Terraform на них укажет.

      1. Запустите загрузку изображений в бакет:

         1. Выполните команду для просмотра планируемых изменений:
         
            ```bash
            terraform plan
            ```
         
            Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
         
         1. Если вас устраивают планируемые изменения, внесите их:
            1. Выполните команду:
         
               ```bash
               terraform apply
               ```
         
            1. Подтвердите изменение ресурсов.
            1. Дождитесь завершения операции.

         В указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления](https://console.yandex.cloud).

   {% endlist %}

## Настройте CDN {#cdn}

1. Получите внешний IP-адрес Thumbor:

   ```bash
   kubectl -n thumbor get svc thumbor \
      -o jsonpath='{.status.loadBalancer.ingress[0].ip}'
   ```

1. Создайте группу источников в Cloud CDN:

   ```bash
   yc cdn origin-group create \
      --name thumbor \
      --origin source=<IP-адрес_Thumbor>,enabled=true
   ```

   Пример результата:

   ```text
   id: "123***"
   folder_id: b1g86q4m5vej********
   name: thumbor
   use_next: true
   origins:
     - id: "234****"
       origin_group_id: "345***"
       source: cdn.example.com
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

   Пример доменного имени ресурса: `cdn.example.com`.

   Пример результата:

   ```text
   id: bc855oumelrq********
   folder_id: b1g86q4m5vej********
   cname: cdn.example.com
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

1. В [консоли управления](https://console.yandex.cloud) на странице CDN-ресурса получите доменное имя CDN-провайдера, например `e1b83ae3********.topology.gslb.yccdn.ru`.

1. Настройте CNAME для своего домена:

   1. Перейдите в настройки DNS вашего домена на сайте компании, которая предоставляет вам услуги DNS-хостинга.
   1. Подготовьте CNAME-запись таким образом, чтобы она указывала на скопированный ранее адрес в домене `.yccdn.cloud.yandex.net`. Например, если доменное имя сайта — `cdn.example.com`, создайте CNAME-запись или замените уже существующую запись для `cdn`:

      ```http
      cdn CNAME e1b83ae3********.topology.gslb.yccdn.ru.
      ```

## Проверьте результат {#check-result}

Откройте ваш сайт по URL:

* `https://<доменное_имя_ресурса>/unsafe/300x400/filters:watermark(cc.xlarge.png,10,-10,80,20)/poster_bunny_bunnysize.jpg`
* `https://<доменное_имя_ресурса>/unsafe/600x800/filters:watermark(cc.xlarge.png,10,-10,80,20)/poster_bunny_bunnysize.jpg`
* `https://<доменное_имя_ресурса>/unsafe/400x300/filters:watermark(cc.xlarge.png,-10,10,80,15)/poster_rodents_bunnysize.jpg`
* `https://<доменное_имя_ресурса>/unsafe/800x600/filters:watermark(cc.xlarge.png,-10,10,80,15)/poster_rodents_bunnysize.jpg`

Отобразятся подготовленные изображения с различным размером. На каждом изображении есть водяной знак [Creative Commons](https://ru.wikipedia.org/wiki/Creative_Commons).

{% note info %}

Если ресурс недоступен по указанному URL, то [убедитесь](../../managed-kubernetes/operations/connect/security-groups.md), что группы безопасности для кластера Managed Service for Kubernetes и его групп узлов настроены корректно. Если отсутствует какое-либо из правил — [добавьте его](../../vpc/operations/security-group-add-rule.md).

{% endnote %}

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

1. [Удалите объекты](../../storage/operations/objects/delete.md) из бакетов.
1. Остальные ресурсы удалите в зависимости от способа их создания:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        1. [CDN-ресурс](../../cdn/operations/resources/delete-resource.md).
        1. [Группу источников CDN](../../cdn/operations/origin-groups/delete-group.md).
        1. [Группу узлов](../../managed-kubernetes/operations/node-group/node-group-delete.md).
        1. [Кластер Managed Service for Kubernetes](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
        1. [Публичный статический IP-адрес](../../vpc/operations/address-delete.md), если вы зарезервировали его для кластера.
        1. [Сервисные аккаунты](../../iam/operations/sa/delete.md).
        1. [Бакеты](../../storage/operations/buckets/delete.md).

    - Terraform {#tf}

        1. В терминале перейдите в директорию с планом инфраструктуры.
        
            {% note warning %}
        
            Убедитесь, что в директории нет Terraform-манифестов с ресурсами, которые вы хотите сохранить. Terraform удаляет все ресурсы, которые были созданы с помощью манифестов в текущей директории.
        
            {% endnote %}
        
        1. Удалите ресурсы:
        
            1. Выполните команду:
        
                ```bash
                terraform destroy
                ```
        
            1. Подтвердите удаление ресурсов и дождитесь завершения операции.
        
            Все ресурсы, которые были описаны в Terraform-манифестах, будут удалены.

    {% endlist %}