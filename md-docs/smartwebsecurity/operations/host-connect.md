# Подключить профиль безопасности к ресурсу

Подключите профиль безопасности к виртуальному хосту, домену или API-шлюзу, чтобы защитить ресурс с помощью Smart Web Security.

## Подключить к виртуальному хосту {#host}

Способ подключения зависит от способа управления балансировщиком [Yandex Application Load Balancer](../../application-load-balancer/concepts/index.md):

* Если балансировщик управляется вами, используйте интерфейсы Yandex Cloud.
* Если балансировщик управляется [контроллером](../../application-load-balancer/tools/index.md), используйте аннотацию.

    {% note warning %}

    Для Ingress-контроллера подключайте профиль безопасности только через аннотацию.

    Если подключить профиль через интерфейсы Yandex Cloud, а затем обновить ресурс Ingress, профиль безопасности отключится из‑за отсутствия аннотации.

    {% endnote %}

Для работы с профилем безопасности, который подключается к балансировщику, потребуется сервисный аккаунт с ролями `monitoring.editor`, `smart-web-security.admin`, `certificate-manager.admin` и `logging.writer`. Подробнее см. [Назначение роли сервисному аккаунту](../../iam/operations/sa/assign-role-for-sa.md).

Чтобы подключить профиль безопасности к виртуальному хосту:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится нужный [профиль безопасности](../concepts/profiles.md).
    1. Перейдите в сервис **Smart Web Security**.
    1. На панели слева выберите ![shield-check](../../_assets/console-icons/shield-check.svg) **Профили безопасности**.
    1. Выберите профиль безопасности, который вы хотите подключить к [виртуальному хосту](../../application-load-balancer/concepts/http-router.md#virtual-host) сервиса [Yandex Application Load Balancer](../../application-load-balancer/index.md).
    1. Нажмите кнопку ![plug](../../_assets/console-icons/plug-connection.svg) **Подключить к хосту**.
    1. В открывшемся окне нажмите **Добавить ресурс** и выберите **Виртуальный хост**.
    1. Последовательно установите значения в полях [**Балансировщик**](../../application-load-balancer/concepts/application-load-balancer.md), [**HTTP-роутер**](../../application-load-balancer/concepts/http-router.md) и [**Виртуальный хост**](../../application-load-balancer/concepts/http-router.md#virtual-host). Вы можете подключить профиль безопасности сразу к нескольким хостам.
  
        Чтобы подключить профиль к еще одному L7-балансировщику, нажмите кнопку **Добавить ресурс** и выберите **Виртуальный хост**.
      
    1. Нажмите кнопку **Подключить**. Если выбранные хосты уже подключены к другому профилю безопасности, подтвердите подключение.
  
        В разделе ![cubes-3-overlap](../../_assets/console-icons/cubes-3-overlap.svg) **Подключенные ресурсы** появятся подключенные виртуальные хосты.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Чтобы посмотреть список имеющихся профилей безопасности в каталоге по умолчанию, выполните команду:

     ```bash
     yc smartwebsecurity security-profile list
     ```
     
     Результат:
     
     ```text
     +----------------------+-------------------+---------------------+----------------+------------+-------------+
     |          ID          |       NAME        |       CREATED       | DEFAULT ACTION | CAPTCHA ID | RULES COUNT |
     +----------------------+-------------------+---------------------+----------------+------------+-------------+
     | fev3s055oq64******** | my-new-profile    | 2024-08-05 06:57:18 | DENY           |            |           1 |
     | fevlqk8vei9p******** | my-sample-profile | 2024-08-05 06:57:28 | DENY           |            |           2 |
     +----------------------+-------------------+---------------------+----------------+------------+-------------+
     ```

  1. Чтобы посмотреть список [HTTP-роутеров](../../application-load-balancer/concepts/http-router.md) в каталоге по умолчанию, выполните команду:

     ```bash
     yc application-load-balancer http-router list
     ```

     Результат:

     ```text
     +----------------------+-------------------+-------------+-------------+
     |          ID          |       NAME        | VHOST COUNT | ROUTE COUNT |
     +----------------------+-------------------+-------------+-------------+
     | ds7e9te73uak******** |  my-first-router  |           1 |           1 |
     +----------------------+-------------------+-------------+-------------+
     ```

  1. Чтобы посмотреть список [виртуальных хостов](../../application-load-balancer/concepts/http-router.md#virtual-host) выбранного HHTP-роутера, выполните команду:

     ```bash
     yc application-load-balancer http-router get <имя_или_идентификатор_HTTP-роутера>
     ```

     Результат:

     ```text
     id: ds7e9te73uak********
     name: my-first-router
     folder_id: b1gt6g8ht345********
     virtual_hosts:
       - name: test-virtual-host
         routes:
           - name: test-route
             http:
               match:
                 path:
                   prefix_match: /
               route:
                 backend_group_id: ds7a4niks9qv********
                 timeout: 60s
                 auto_host_rewrite: false
         route_options: {}
     created_at: "2024-08-05T08:34:03.973000654Z"
     ```

     Имена виртуальных хостов указаны в параметре `virtual_hosts.name`. В примере выше только один виртуальный хост — `test-virtual-host`.

  1. Чтобы подключить [профиль безопасности](../concepts/profiles.md) к виртуальному хосту, выполните команду:

     ```bash
     yc application-load-balancer virtual-host update <имя_виртуального_хоста> \
        --http-router-name <имя_HTTP-роутера> \
        --security-profile-id <идентификатор_профиля_безопасности>
     ```

     Где:

     * `<имя_виртуального_хоста>` — имя виртуального хоста, полученное на предыдущем шаге.
     * `--http-router-name` — имя HTTP-роутера. Обязательный параметр. Вместо имени HTTP-роутера вы можете передать его идентификатор в параметре `--http-router-id`.
     * `--security-profile-id` — идентификатор профиля безопасности. Обязательный параметр.

     Результат:

     ```text
     done (1s)
     name: test-virtual-host
     routes:
       - name: test-route
         http:
           match:
             path:
               prefix_match: /
           route:
             backend_group_id: ds7a4niks9qv********
             timeout: 60s
             auto_host_rewrite: false
     route_options:
       security_profile_id: fev3s055oq64********
      ```

  Подробнее о команде `yc application-load-balancer virtual-host update` читайте в [справочнике CLI](../../cli/cli-ref/application-load-balancer/cli-ref/virtual-host/update.md).


- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  Профиль безопасности Yandex Smart Web Security подключается к балансировщику [Yandex Application Load Balancer](../../application-load-balancer/concepts/index.md) в настройках виртуального хоста.

  1. В конфигурационном файле Terraform для ресурса `yandex_alb_virtual_host` в блокe `route_options` укажите параметр `security_profile_id` — идентификатор профиля безопасности.

      ```hcl
      resource "yandex_alb_virtual_host" "my-virtual-host" {
        name                    = "<имя_виртуального_хоста>"
        ...

        route_options {
          security_profile_id   = "<идентификатор_профиля_безопасности>"
        }
      }
      ```

  1. Примените изменения:

       1. В терминале перейдите в директорию с конфигурационным файлом.
       1. Проверьте корректность конфигурации с помощью команды:
       
          ```bash
          terraform validate
          ```
       
          Если конфигурация является корректной, появится сообщение:
       
          ```bash
          Success! The configuration is valid.
          ```
       
       1. Выполните команду:
       
          ```bash
          terraform plan
          ```
       
          В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
       1. Примените изменения конфигурации:
       
          ```bash
          terraform apply
          ```
       
       1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

  Проверить изменение ресурсов можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../cli/index.md):

  ```bash
  yc alb http-router get <идентификатор_HTTP-роутера>
  ```

- API {#api}

  Воспользуйтесь методом REST API [update](../../application-load-balancer/api-ref/VirtualHost/update.md) для ресурса [VirtualHost](../../application-load-balancer/api-ref/VirtualHost/index.md) или вызовом gRPC API [VirtualHostService/Update](../../application-load-balancer/api-ref/grpc/VirtualHost/update.md) сервиса Application Load Balancer.

- Аннотация {#annotation}

  {% note tip %}
  
  Вместо ALB Ingress-контроллера и Gateway API рекомендуется использовать новый контроллер [Yandex Cloud Gwin](../../application-load-balancer/tools/gwin/index.md).
  
  {% endnote %}

  Используйте аннотации:

  * для [контроллера Gwin](../../application-load-balancer/tools/gwin/index.md) — [HTTPRoute](../../application-load-balancer/gwin-ref/httproute.md#security-configuration) или [RoutePolicy](../../application-load-balancer/gwin-ref/routepolicy.md#cheatsheet);
  * для [Ingress-контроллера](../../application-load-balancer/tools/k8s-ingress-controller/index.md) — [аннотацию ресурса Ingress](../../application-load-balancer/k8s-ref/ingress.md#annot-security-profile-id).

      {% note info %}
      
      Для подключения профиля безопасности к виртуальному хосту Application Load Balancer у сервисного аккаунта, от имени которого работает Ingress-контроллер, должна быть роль [smart-web-security.editor](../security/index.md#smart-web-security-editor) на каталог, в котором размещены ресурсы Application Load Balancer и Smart Web Security. Подробнее см. [Назначение роли сервисному аккаунту](../../iam/operations/sa/assign-role-for-sa.md).
      
      {% endnote %}

{% endlist %}

{% note tip %}

Чтобы обеспечить доступность вашего сервиса при высоких нагрузках, рекомендуем настроить [автомасштабирование](../../application-load-balancer/concepts/application-load-balancer.md#lcu-scaling) L7-балансировщика. 

{% endnote %}

Профиль безопасности подключается к определенному виртуальному хосту L7-балансировщика, при этом анализируется весь трафик, поступающий на хост. Если трафик к некоторым маршрутам хоста анализировать не требуется, отключите профиль безопасности от этого маршрута. Это можно сделать при [добавлении](../../application-load-balancer/operations/http-router-update.md#add-virtual-host) или [изменении](../../application-load-balancer/operations/manage-routes.md) маршрута через CLI, API или Terraform с помощью параметра `--disable-security-profile` (`disableSecurityProfile`).

При добавлении маршрутов учитывайте их порядок: запрос будет направлен по первому маршруту, предикату которого он соответствует. Наиболее специфичные маршруты располагайте первыми в списке. Иначе общий маршрут может перехватить запросы и специфичные правила не будут применяться.

## Подключить к домену {#domain}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится нужный [профиль безопасности](../concepts/profiles.md).
     1. На панели слева выберите ![shield-check](../../_assets/console-icons/shield-check.svg) **Профили безопасности**.
     1. Выберите профиль безопасности, который вы хотите подключить к домену.
     1. Нажмите кнопку ![plug](../../_assets/console-icons/plug-connection.svg) **Подключить к хосту**.
     1. В открывшемся окне нажмите **Добавить ресурс** и выберите **Домен**.
     1. Последовательно установите значения в полях **Прокси-сервер** и **Домен**. Вы можете подключить профиль безопасности сразу к нескольким доменам.
     1. Нажмите кнопку **Подключить**.
   
         В разделе ![cubes-3-overlap](../../_assets/console-icons/cubes-3-overlap.svg) **Подключенные ресурсы** появятся подключенные домены.

{% endlist %}

## Подключить к API-шлюзу {#gateway}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится нужный [профиль безопасности](../concepts/profiles.md).
    1. На панели слева выберите ![shield-check](../../_assets/console-icons/shield-check.svg) **Профили безопасности**.
    1. Выберите профиль безопасности, который вы хотите подключить к API-шлюзу.
    1. Нажмите кнопку ![plug](../../_assets/console-icons/plug-connection.svg) **Подключить к хосту**.
    1. В открывшемся окне нажмите **Добавить ресурс** и выберите **API-шлюз**.
    1. Установите значение в поле **API-шлюз**.
    1. Нажмите кнопку **Подключить**.
  
        В разделе ![cubes-3-overlap](../../_assets/console-icons/cubes-3-overlap.svg) **Подключенные ресурсы** появятся подключенные API-шлюзы.

{% endlist %}

## См. также {#see-also}

* [Отключить профиль безопасности от ресурса](host-delete.md)