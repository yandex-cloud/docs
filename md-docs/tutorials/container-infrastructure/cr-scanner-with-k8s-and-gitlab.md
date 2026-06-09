# Сканирование уязвимостей при непрерывном развертывании приложений {{ managed-k8s-name }} с помощью {{ GL }}

# Сканирование уязвимостей {{ container-registry-name }} при непрерывном развертывании приложений {{ managed-k8s-name }} с помощью {{ GL }}


Вы можете [сканировать уязвимости](../../container-registry/concepts/vulnerability-scanner.md) [Docker-образов](../../container-registry/concepts/docker-image.md) в [{{ container-registry-full-name }}](../../container-registry/index.md) при непрерывном развертывании приложений [{{ managed-k8s-full-name }}](../../managed-kubernetes/index.md) через {{ GL }}.

Для этого с помощью непрерывной интеграции ([Continuous Integration](https://yandex.cloud/ru/blog/posts/2022/10/ci-cd), CI) в {{ GL }} создается специальный сценарий, который запускается после каждого коммита:
1. Сборка приложения в Docker-образ и загрузка образа в {{ container-registry-name }}.
1. Сканирование Docker-образа в {{ container-registry-name }} на наличие уязвимостей.
1. Развертывание приложения из Docker-образа в [кластере {{ managed-k8s-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) с помощью инструментов {{ yandex-cloud }}.

Чтобы настроить сканер уязвимостей:
1. [Создайте инстанс {{ GL }}](#create-gitlab).
1. [Настройте {{ GL }}](#configure-gitlab).
1. [Создайте тестовое приложение](#app-create).
1. [Создайте {{ GLR }}](#runners).
1. [Настройте сценарий CI](#ci).
1. [Проверьте результат](#check-result).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входит:

* Плата за [диски](../../compute/concepts/disk.md) и постоянно запущенные ВМ (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md)).
* Плата за хранение созданных Docker-образов и сканер уязвимостей (см. [тарифы {{ container-registry-name }}](../../container-registry/pricing.md)).
* Плата за использование [мастера {{ managed-k8s-name }}](../../managed-kubernetes/concepts/index.md#master) (см. [тарифы {{ managed-k8s-name }}](../../managed-kubernetes/pricing.md)).
* Плата за использование [публичных IP-адресов](../../vpc/concepts/address.md#public-addresses) (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md#prices-public-ip)).

## Перед началом работы {#before-begin}

### Подготовьте инфраструктуру {#deploy-infrastructure}

{% list tabs group=instructions %}

- Вручную {#manual}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Если у вас еще нет [сети](../../vpc/concepts/network.md#network), [создайте ее](../../vpc/operations/network-create.md).
  1. Если у вас еще нет [подсетей](../../vpc/concepts/network.md#subnet), [создайте их](../../vpc/operations/subnet-create.md) в [зонах доступности](../../overview/concepts/geo-scope.md), где будут созданы [кластер {{ managed-k8s-full-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) и [группа узлов](../../managed-kubernetes/concepts/index.md#node-group).
  1. [Создайте сервисные аккаунты](../../iam/operations/sa/create.md):
     * Для ресурсов с [ролями](../../iam/concepts/access-control/roles.md) `k8s.clusters.agent` и `vpc.publicAdmin` на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создается кластер {{ managed-k8s-name }}. От его имени будут создаваться ресурсы, необходимые кластеру {{ managed-k8s-name }}.
     * Для узлов с ролями [{{ roles-cr-puller }}](../../container-registry/security/index.md#container-registry-images-puller) и [{{ roles-cr-pusher }}](../../container-registry/security/index.md#container-registry-images-pusher) на каталог с [реестром](../../container-registry/concepts/registry.md) [Docker-образов](../../container-registry/concepts/docker-image.md). От его имени узлы {{ managed-k8s-name }} будут загружать в реестр собранные в {{ GL }} Docker-образы, а также скачивать их для запуска [подов](../../managed-kubernetes/concepts/index.md#pod).

     {% note tip %}

     Вы можете использовать один и тот же [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) для обеих операций.

     {% endnote %}

  1. [Создайте группы безопасности](../../managed-kubernetes/operations/connect/security-groups.md) для кластера {{ managed-k8s-name }} и входящих в него групп узлов.

        {% note warning %}
        
        От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
        
        {% endnote %}

  1. [Создайте группу безопасности](../../managed-gitlab/operations/configure-security-group.md) для работы [инстанса {{ mgl-name }}](../../managed-gitlab/concepts/index.md#instance).

  1. [Создайте кластер {{ managed-k8s-name }}](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md#kubernetes-cluster-create) и [группу узлов](../../managed-kubernetes/operations/node-group/node-group-create.md). При создании кластера {{ managed-k8s-name }} укажите ранее созданные сервисные аккаунты для ресурсов и узлов и группы безопасности.

  1. [Создайте реестр {{ container-registry-full-name }}](../../container-registry/operations/registry/registry-create.md).
  1. [Создайте авторизованный ключ](../../iam/operations/authentication/manage-authorized-keys.md#create-authorized-key) для сервисного аккаунта с ролью `{{ roles-cr-pusher }}` и сохраните в файл `key.json`:

     ```bash
     yc iam key create \
       --service-account-name <имя_сервисного_аккаунта> \
       --output key.json
     ```

     Ключ необходим для доступа к реестру из {{ GL }}.

- {{ TF }} {#tf}

  1. Если у вас еще нет {{ TF }}, [установите его](../infrastructure-management/terraform-quickstart.md#install-terraform).
  1. [Получите данные для аутентификации](../infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
  1. [Настройте и инициализируйте провайдер](../infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
  1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

  1. Скачайте в ту же рабочую директорию файл конфигурации [k8s-and-registry-for-gitlab.tf](https://github.com/yandex-cloud-examples/yc-mk8s-cr-gitlab/blob/main/k8s-and-registry-for-gitlab.tf).

     В этом файле описаны:
     * [Сеть](../../vpc/concepts/network.md#network).
     * [Подсеть](../../vpc/concepts/network.md#subnet).
     * [Кластер {{ managed-k8s-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster).
     * [Сервисный аккаунт](../../iam/concepts/users/service-accounts.md), необходимый для работы кластера {{ managed-k8s-name }} и [группы узлов](../../managed-kubernetes/concepts/index.md#node-group).
     * [Группы безопасности](../../vpc/concepts/security-groups.md), которые содержат [необходимые правила](../../managed-kubernetes/operations/connect/security-groups.md) для кластера {{ managed-k8s-name }} и входящих в него групп узлов.

        {% note warning %}
        
        От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
        
        {% endnote %}

     * [Группа безопасности по умолчанию](../../vpc/concepts/security-groups.md#default-security-group) и правила, необходимые для работы [инстанса {{ mgl-name }}](../../managed-gitlab/concepts/index.md#instance).
     * [Реестр](../../container-registry/concepts/registry.md) [{{ container-registry-full-name }}](../../container-registry/index.md).
     * [Авторизованный ключ](../../iam/concepts/authorization/key.md) для сервисного аккаунта. Ключ необходим для доступа к реестру из {{ GL }}.
     * Локальный файл `key.json` с данными авторизованного ключа.
  1. Укажите в файле `k8s-and-registry-for-gitlab.tf`:
     * [Идентификатор каталога](../../resource-manager/operations/folder/get-id.md).
     * [Версию {{ k8s }}](../../managed-kubernetes/concepts/release-channels-and-updates.md) для кластера {{ managed-k8s-name }} и групп узлов.
     * Имя сервисного аккаунта кластера {{ managed-k8s-name }}.
     * Имя реестра {{ container-registry-name }}.
  1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

     ```bash
     terraform validate
     ```

     Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.
  1. Создайте необходимую инфраструктуру:

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

     В указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

{% endlist %}

{% note warning %}

Для реальных приложений доступ сервисных аккаунтов кластера {{ managed-k8s-name }} к загрузке Docker-образов в реестр должен быть ограничен по соображениям безопасности. В этом случае создайте отдельный сервисный аккаунт с ролью `{{ roles-cr-pusher }}` и указывайте его для развертывания приложений.

{% endnote %}

Дополнительно [назначьте](../../iam/operations/sa/assign-role-for-sa.md#binding-role-resource) сервисному аккаунту для узлов роль `container-registry.images.scanner`. Она позволяет сканировать Docker-образы на наличие уязвимостей.

### Установите дополнительные зависимости {#prepare}

Установите в локальном окружении:
* [Утилиту потоковой обработки JSON-файлов `jq`](https://stedolan.github.io/jq/).
* [Инструмент командной строки kubectl]({{ k8s-docs }}/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером {{ managed-k8s-name }}](../../managed-kubernetes/operations/connect/index.md#kubectl-connect).

## Создайте инстанс {{ GL }} {#create-gitlab}

Создайте [инстанс {{ mgl-name }}](../../managed-gitlab/concepts/index.md#instance) или [виртуальную машину](../../compute/concepts/vm.md) с [образом](../../compute/concepts/image.md) {{ GL }} в той же [облачной сети](../../vpc/concepts/network.md#network), где расположен [кластер {{ managed-k8s-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster).

{% list tabs group=gl_installation %}

- Инстанс {{ mgl-name }} {#instance-mgl}

  Создайте инстанс {{ mgl-name }} [согласно инструкции](../../managed-gitlab/quickstart.md#instance-create).

- ВМ с образом {{ GL }} {#gl-image-vm}

  Запустите {{ GL }} на ВМ с [публичным IP-адресом](../../vpc/concepts/address.md#public-addresses).

  1. На странице [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder) в [консоли управления]({{ link-console-main }}) нажмите кнопку **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** и выберите `{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}`.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** в поле **{{ ui-key.yacloud.compute.instances.create.placeholder_search_marketplace-product }}** введите `Gitlab` и выберите публичный образ [{{ GL }}](https://yandex.cloud/ru/marketplace/products/yc/gitlab).
  1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}** выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой будет находиться ВМ. Если вы не знаете, какая зона доступности вам нужна, оставьте выбранную по умолчанию.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}** перейдите на вкладку `{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}` и укажите необходимую [платформу](../../compute/concepts/vm-platforms.md), количество vCPU и объем RAM:
  
      * **{{ ui-key.yacloud.component.compute.resources.field_platform }}** — `Intel Ice Lake`.
      * **{{ ui-key.yacloud.component.compute.resources.field_cores }}** — `4`.
      * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}** — `100%`.
      * **{{ ui-key.yacloud.component.compute.resources.field_memory }}** — `8 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
  
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:
      
      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** выберите сеть и подсеть, к которым нужно подключить ВМ. Если нужной [сети](../../vpc/concepts/network.md#network) или [подсети](../../vpc/concepts/network.md#subnet) еще нет, [создайте их](../../vpc/operations/subnet-create.md).
      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}** оставьте значение `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`, чтобы назначить ВМ случайный внешний IP-адрес из пула {{ yandex-cloud }}, или выберите статический адрес из списка, если вы зарезервировали его заранее.
  
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** выберите вариант **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** и укажите данные для доступа на ВМ:
  
      * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя. Не используйте имя `root` или другие имена, зарезервированные ОС. Для выполнения операций, требующих прав суперпользователя, используйте команду `sudo`.
      * В поле **{{ ui-key.yacloud.compute.instances.create.field_key }}** выберите SSH-ключ, сохраненный в вашем профиле [пользователя организации](../../organization/concepts/membership.md).
        
        Если в вашем профиле нет сохраненных SSH-ключей или вы хотите добавить новый ключ:
        
        1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_add-ssh-key }}**.
        1. Задайте имя SSH-ключа.
        1. Выберите вариант:
        
            * `{{ ui-key.yacloud_components.ssh-key-add-dialog.value_radio-manual }}` — вставьте содержимое открытого [SSH](../../glossary/ssh-keygen.md)-ключа. Пару SSH-ключей необходимо [создать](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) самостоятельно.
            * `{{ ui-key.yacloud_components.ssh-key-add-dialog.value_radio-upload }}` — загрузите открытую часть SSH-ключа. Пару SSH-ключей необходимо создать самостоятельно.
            * `{{ ui-key.yacloud_components.ssh-key-add-dialog.value_radio-generate }}` — автоматическое создание пары SSH-ключей.
            
              При добавлении сгенерированного SSH-ключа будет создан и загружен архив с парой ключей. В ОС на базе Linux или macOS распакуйте архив в папку `/home/<имя_пользователя>/.ssh`. В ОС Windows распакуйте архив в папку `C:\Users\<имя_пользователя>/.ssh`. Дополнительно вводить открытый ключ в консоли управления не требуется.
        
        1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.
        
        SSH-ключ будет добавлен в ваш профиль пользователя организации. Если в организации [отключена](../../organization/operations/os-login-access.md) возможность добавления пользователями SSH-ключей в свои профили, добавленный открытый SSH-ключ будет сохранен только в профиле пользователя внутри создаваемого ресурса.
  
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}** задайте имя ВМ: `ci-tutorial-gitlab`.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.
  
  Создание ВМ может занять несколько минут. Когда ВМ перейдет в статус `RUNNING` и запустится {{ GL }}, настройте его.

{% endlist %}

## Настройте {{ GL }} {#configure-gitlab}

Чтобы настроить {{ GL }} и подготовить процесс непрерывной интеграции ([Continuous Integration](https://yandex.cloud/ru/blog/posts/2022/10/ci-cd), CI), создайте новый проект и введите параметры для аутентификации в CI:

{% list tabs group=gl_installation %}

- Инстанс {{ mgl-name }} {#instance-mgl}

  1. Авторизуйтесь в веб-интерфейсе [инстанса {{ mgl-name }}](../../managed-gitlab/concepts/index.md#instance).
  1. Нажмите кнопку **Create a project**.
  1. Нажмите кнопку **Create blank project**.
  1. Заполните поля:
     * **Project name** — `gitlab-test`.
     * **Project URL** — выберите пользователя-администратора в поле рядом с FQDN инстанса {{ mgl-name }}.

     Остальные поля оставьте без изменений.
  1. Нажмите кнопку **Create project**.

- ВМ с образом {{ GL }} {#gl-image-vm}

  1. На странице сервиса {{ compute-full-name }} выберите созданную [ВМ](../../compute/concepts/vm.md) и скопируйте ее [публичный IP-адрес](../../vpc/concepts/address.md#public-addresses).
  1. [Подключитесь](../../compute/operations/vm-connect/ssh.md) к ВМ по протоколу SSH.
  1. Получите пароль администратора {{ GL }} с помощью команды ВМ:

     ```bash
     sudo cat /etc/gitlab/initial_root_password
     ```

  1. Скопируйте пароль из строки `Password` (исключая пробелы) в буфер обмена или отдельный файл.
  1. Откройте в браузере ссылку `http://<публичный_IP-адрес_ВМ>`. Откроется веб-интерфейс {{ GL }}.
  1. Войдите в систему с учетной записью администратора:
     * **Username or email** — `root`.
     * **Password** — пароль, скопированный ранее.

     Если вы не можете войти, [сбросьте пароль учетной записи администратора](https://docs.gitlab.com/security/reset_user_password/#reset-your-root-password).
  1. [Смените пароль учетной записи администратора](https://docs.gitlab.com/user/profile/user_passwords/#change-your-password).
  1. Повторно войдите в систему с учетной записью администратора, используя новый пароль.
  1. Выберите **Create a project**.
  1. Задайте имя проекта: `gitlab-test`.
  1. Нажмите кнопку **Create project**.

{% endlist %}

## Создайте тестовое приложение {#app-create}

Создайте тестовое приложение, которое можно будет развернуть в [кластере {{ managed-k8s-full-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster):
1. Добавьте в проект `Dockerfile`:
   1. Авторизуйтесь в {{ GL }}.
   1. Откройте проект {{ GL }}.
   1. В строке навигации по репозиторию нажмите кнопку ![image](../../_assets/console-icons/plus.svg) и в выпадающем меню выберите пункт **New file**.
   1. Назовите файл `Dockerfile` и добавьте в него код:

      ```Dockerfile
      FROM alpine:3.10
      CMD echo "Hello"
      ```

   1. Напишите комментарий к коммиту в поле **Commit message**: `Dockerfile for test application`.
   1. Нажмите кнопку **Commit changes**.
1. Добавьте в проект манифест создания ресурсов кластера {{ managed-k8s-name }}:
   1. Откройте проект {{ GL }}.
   1. В строке навигации по репозиторию нажмите кнопку ![image](../../_assets/console-icons/plus.svg) и в выпадающем меню выберите пункт **New file**.
   1. Назовите файл `k8s.yaml`:

      {% cut "k8s.yaml" %}

      ```yaml
      apiVersion: v1
      kind: Namespace
      metadata:
        name: hello-world
      ---
      apiVersion: apps/v1
      kind: Deployment
      metadata:
        name: hello-world-deployment
        namespace: hello-world
      spec:
        replicas: 1
        selector:
          matchLabels:
            app: hello
        template:
          metadata:
            namespace: hello-world
            labels:
              app: hello
          spec:
            containers:
              - name: hello-world
                image: __VERSION__
                imagePullPolicy: Always
       ```

      {% endcut %}

   1. Напишите комментарий к коммиту в поле **Commit message**: `Docker image deployment config`.
   1. Нажмите кнопку **Commit changes**.

## Создайте {{ GLR }} {#runners}

Чтобы запускать задачи сборки в [кластере {{ managed-k8s-full-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster), создайте [{{ GLR }}](https://docs.gitlab.com/runner/install/kubernetes/). Для этого установите приложение {{ GLR }} согласно [инструкции](../../managed-kubernetes/operations/applications/gitlab-runner.md).

После установки вы можете запускать автоматизированные сборки внутри своего [кластера {{ managed-k8s-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster).

Подробнее про установку и настройку {{ GLR }} читайте в [документации {{ GL }}](https://docs.gitlab.com/runner/install/).

## Настройте аутентификацию {{ k8s }} в {{ GL }} {#gitlab-authentication}

Настроить аутентификацию в {{ GL }} можно с помощью токена сервисного аккаунта {{ k8s }} или приложения [{{ GLA }}](https://yandex.cloud/ru/marketplace/products/yc/gitlab-agent):

{% list tabs group=gl_auth %}

- Токен сервисного аккаунта {#token}

  ### Получите токен сервисного аккаунта {{ k8s }} для аутентификации в {{ GL }} {#k8s-get-token}
  
  {% note info %}
  
  [Сервисный аккаунт {{ k8s }}](../../managed-kubernetes/concepts/index.md#service-accounts) отличается от [сервисного аккаунта {{ iam-full-name }}](../../iam/concepts/users/service-accounts.md).
  
  {% endnote %}
  
  Чтобы получить токен сервисного аккаунта {{ k8s }}:
  1. [Создайте сервисный аккаунт](../../managed-kubernetes/operations/connect/create-static-conf.md#create-sa).
  1. [Получите токен сервисного аккаунта](../../managed-kubernetes/operations/connect/create-static-conf.md#prepare-token).
  1. Сохраните полученный токен — он понадобится для следующих шагов.

- {{ GLA }} {#gla}

  ## Создайте {{ GLA }} {#agent}
  
  Чтобы подключить [кластер {{ managed-k8s-full-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) к {{ GL }}, создайте [{{ GLA }}](https://docs.gitlab.com/ee/user/clusters/agent/).  Для этого установите приложение {{ GLA }} согласно [инструкции](../../managed-kubernetes/operations/applications/gitlab-agent.md).
  
  После установки вы можете подключать [кластер {{ managed-k8s-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) к [инстансу {{ GL }}](../../managed-gitlab/concepts/index.md#instance).
  
  Подробнее про установку и настройку {{ GLA }} читайте в [документации {{ GL }}](https://docs.gitlab.com/ee/user/clusters/agent/).

{% endlist %}

## Настройте сценарий CI {#ci}

1. Создайте [переменные окружения {{ GL }}]({{ gl.docs }}/ee/ci/variables/):
   1. На панели слева в {{ GL }} перейдите в раздел **Settings** и во всплывающем списке выберите пункт **CI/CD**.
   1. Нажмите кнопку **Expand** напротив пункта **Variables**.
   1. Добавьте переменные окружения в зависимости от способа аутентификации {{ managed-k8s-name }} в {{ GL }}:

      {% list tabs group=gl_auth %}

      - Токен сервисного аккаунта {#token}

        * `KUBE_URL` — адрес [мастера {{ managed-k8s-name }}](../../managed-kubernetes/concepts/index.md#master). Узнайте его с помощью команды:

          ```bash
          yc managed-kubernetes cluster get <имя_или_идентификатор_кластера> --format=json \
             | jq -r .master.endpoints.external_v4_endpoint
          ```

        * `KUBE_TOKEN` — токен, который {{ GL }} будет использовать для применения конфигурации. Используйте токен, полученный ранее.

      - {{ GLA }} {#gla}

      {% endlist %}

      * `CI_REGISTRY` — адрес созданного ранее [реестра](../../container-registry/concepts/registry.md) в формате `{{ registry }}/<идентификатор_реестра>`.
      * `CI_REGISTRY_KEY` — ключ, который {{ GL }} будет использовать для доступа к реестру. Скопируйте содержимое файла статического ключа `key.json` для доступа к реестру, полученного ранее.

      Для добавления переменной:
      * Нажмите кнопку **Add variable**.
      * В появившемся окне в поле **Key** укажите имя переменной, в поле **Value** — значение переменной.
      * Нажмите кнопку **Add variable**.
1. Создайте файл конфигурации сценария CI:
   1. Откройте проект `gitlab-test`.
   1. В строке навигации по репозиторию нажмите кнопку ![image](../../_assets/console-icons/plus.svg) и в выпадающем меню выберите пункт **New file**.
   1. Назовите файл `.gitlab-ci.yml`. Добавьте в него шаги сборки и загрузки Docker-образа, его сканирования на наличие уязвимостей и обновления конфигурации приложения в кластере {{ managed-k8s-name }}. Структура файла зависит от способа аутентификации {{ k8s }} в {{ GL }}:

      {% list tabs group=gl_auth %}

      - Токен сервисного аккаунта {#token}

        {% cut ".gitlab-ci.yml" %}

        ```yaml
        stages:
          - build
          - test
          - deploy

        build_docker_image:
          stage: build
          variables:
            DOCKER_CUSTOM_SUBFOLDER: "" # Specify a custom path (if any) to your folder with docker files.
          image:
            name: gcr.io/kaniko-project/executor:debug
            entrypoint: [""]
          script:
            - mkdir -p /kaniko/.docker
            - echo "{\"auths\":{\"${CI_REGISTRY}\":{\"auth\":\"$(echo -n "json_key:${CI_REGISTRY_KEY}" | base64 | tr -d '\n' )\"}}}" > /kaniko/.docker/config.json
            - >-
              /kaniko/executor
              --context "${CI_PROJECT_DIR}"/"${DOCKER_CUSTOM_SUBFOLDER}"
              --dockerfile "${CI_PROJECT_DIR}/"${DOCKER_CUSTOM_SUBFOLDER}"/Dockerfile"
              --destination "${CI_REGISTRY}/${CI_COMMIT_REF_SLUG}:${CI_COMMIT_SHA}"

        container_scanning_free_yc:
          image: 
            name: pindar/jq
            entrypoint: [""]
          stage: test
          artifacts:
            when: always
            paths:
              - gl-container-scanning-report-yc.json
          script:
            - export CI_COMMIT_SHA=${CI_COMMIT_SHA}
            # Install CLI.
            - curl https://{{ s3-storage-host-cli }}{{ yc-install-path }} | bash -s -- -a && cp /root/yandex-cloud/bin/yc /usr/bin/
            # Start scanning.
            - echo "Scanning image $IMAGE_NAME ${CI_REGISTRY}/${CI_COMMIT_REF_SLUG}:${CI_COMMIT_SHA}..."
            - export IMAGE_ID=$(yc container image list --registry-id (${CI_REGISTRY} | cut -d/ -f2) --format=json | jq -r --arg CI_COMMIT_SHA $CI_COMMIT_SHA '.[] | select(.tags[0]==$CI_COMMIT_SHA) | .id ')
            # Make a report.
            - export SCAN_RESULT=$(yc container image scan $IMAGE_ID --format=json)
            - export CRIT_VULN=$(echo $SCAN_RESULT | jq -r '.vulnerabilities.critical // 0')
            - export HIGH_VULN=$(echo $SCAN_RESULT | jq -r '.vulnerabilities.high // 0')
            - export SCAN_ID=$(echo $SCAN_RESULT | jq -r '.id')
            - echo "Scan results:"
            - yc container image list-vulnerabilities --scan-result-id="${SCAN_ID}" --format json | jq -r '.[] | select(.severity=="CRITICAL", .severity=="HIGH")'
            - yc container image list-vulnerabilities --scan-result-id="${SCAN_ID}" --format json | jq -r '.[] | select(.severity=="CRITICAL", .severity=="HIGH")' > gl-container-scanning-report-yc.json
            # Check the result.
            - (( SUM = $CRIT_VULN + $HIGH_VULN )) && (( RES = (SUM >= 1) )) && echo $RES && echo "image has $CRIT_VULN critical vulns and $HIGH_VULN high vulns" && exit 1 || echo "image has no high or crit vulns" exit 0

        deploy:
          image: gcr.io/cloud-builders/kubectl:latest
          stage: deploy
          script:
            - kubectl config set-cluster k8s --server="$KUBE_URL" --insecure-skip-tls-verify=true
            - kubectl config set-credentials admin --token="$KUBE_TOKEN"
            - kubectl config set-context default --cluster=k8s --user=admin
            - kubectl config use-context default
            - sed -i "s,__VERSION__,${CI_REGISTRY}/${CI_COMMIT_REF_SLUG}:${CI_COMMIT_SHA}," k8s.yaml
            - kubectl apply -f k8s.yaml
        ```

        {% endcut %}

      - {{ GLA }} {#gla}

        {% cut ".gitlab-ci.yml" %}

        ```yaml
        stages:
          - build
          - test
          - deploy

        build_docker_image:
          stage: build
          variables:
            DOCKER_CUSTOM_SUBFOLDER: "" # Specify a custom path (if any) to your folder with docker files.
          image:
            name: gcr.io/kaniko-project/executor:debug
            entrypoint: [""]
          script:
            - mkdir -p /kaniko/.docker
            - echo "{\"auths\":{\"${CI_REGISTRY}\":{\"auth\":\"$(echo -n "json_key:${CI_REGISTRY_KEY}" | base64 | tr -d '\n' )\"}}}" > /kaniko/.docker/config.json
            - >-
              /kaniko/executor
              --context "${CI_PROJECT_DIR}"/"${DOCKER_CUSTOM_SUBFOLDER}"
              --dockerfile "${CI_PROJECT_DIR}/"${DOCKER_CUSTOM_SUBFOLDER}"/Dockerfile"
              --destination "${CI_REGISTRY}/${CI_COMMIT_REF_SLUG}:${CI_COMMIT_SHA}"

        container_scanning_free_yc:
          image: 
            name: pindar/jq
            entrypoint: [""]
          stage: test
          artifacts:
            when: always
            paths:
              - gl-container-scanning-report-yc.json
          script:
            - export CI_COMMIT_SHA=${CI_COMMIT_SHA}
            # Install CLI.
            - curl https://{{ s3-storage-host-cli }}{{ yc-install-path }} | bash -s -- -a && cp /root/yandex-cloud/bin/yc /usr/bin/
            # Start scanning.
            - echo "Scanning image $IMAGE_NAME ${CI_REGISTRY}/${CI_COMMIT_REF_SLUG}:${CI_COMMIT_SHA}..."
            - export IMAGE_ID=$(yc container image list --registry-id (${CI_REGISTRY} | cut -d/ -f2) --format=json | jq -r --arg CI_COMMIT_SHA $CI_COMMIT_SHA '.[] | select(.tags[0]==$CI_COMMIT_SHA) | .id ')
            # Make a report.
            - export SCAN_RESULT=$(yc container image scan $IMAGE_ID --format=json)
            - export CRIT_VULN=$(echo $SCAN_RESULT | jq -r '.vulnerabilities.critical // 0')
            - export HIGH_VULN=$(echo $SCAN_RESULT | jq -r '.vulnerabilities.high // 0')
            - export SCAN_ID=$(echo $SCAN_RESULT | jq -r '.id')
            - echo "Scan results:"
            - yc container image list-vulnerabilities --scan-result-id="${SCAN_ID}" --format json | jq -r '.[] | select(.severity=="CRITICAL", .severity=="HIGH")'
            - yc container image list-vulnerabilities --scan-result-id="${SCAN_ID}" --format json | jq -r '.[] | select(.severity=="CRITICAL", .severity=="HIGH")' > gl-container-scanning-report-yc.json
            # Check the result.
            - (( SUM = $CRIT_VULN + $HIGH_VULN )) && (( RES = (SUM >= 1) )) && echo $RES && echo "image has $CRIT_VULN critical vulns and $HIGH_VULN high vulns" && exit 1 || echo "image has no high or crit vulns" exit 0

        deploy:
          image: bitnamilegacy/kubectl:latest
          stage: deploy
          script:
            - kubectl config use-context ${CI_PROJECT_PATH}:<имя_GitLab_Agent>
            - cat k8s.yaml | sed -e "s,__VERSION__,${CI_REGISTRY}/${CI_COMMIT_REF_SLUG}:${CI_COMMIT_SHA}," | kubectl apply -f -
        ```

        {% endcut %}

        Вместо `<имя_GitLab_Agent>` укажите имя агента в {{ mgl-name }}.

      {% endlist %}

   1. Напишите комментарий к коммиту в поле **Commit message**: `CI scripts`.
   1. Нажмите кнопку **Commit changes**.

   В файле `.gitlab-ci.yml` описаны следующие шаги сценария CI:
   * Сборка Docker-образа с использованием `Dockerfile` и загрузка образа в {{ container-registry-name }}.
   * Сканирование Docker-образа на наличие уязвимостей в {{ container-registry-name }}.
   * Настройка окружения для работы с {{ k8s }} и применение конфигурации `k8s.yaml` к кластеру {{ managed-k8s-name }}. Таким образом приложение развертывается на созданном ранее кластере {{ managed-k8s-name }}.

## Проверьте результат {#check-result}

После сохранения файла конфигурации `.gitlab-ci.yml` запустится сценарий сборки. Чтобы проверить результаты его выполнения, на панели слева в проекте `gitlab-test` выберите пункт **Build**, в выпадающем меню выберите пункт **Pipelines**. Сканирование уязвимостей происходит на втором этапе `test`.

## Удалите созданные ресурсы {#clear-out}

Если созданные ресурсы вам больше не нужны, удалите их:
1. [Удалите инстанс {{ mgl-name }}](../../managed-gitlab/operations/instance/instance-delete.md) или [созданную виртуальную машину с образом {{ GL }}](../../compute/operations/vm-control/vm-delete.md).
1. [Удалите все Docker-образы](../../container-registry/operations/docker-image/docker-image-delete.md) из [реестра](../../container-registry/concepts/registry.md) {{ container-registry-name }}.

Остальные ресурсы удалите в зависимости от способа их создания:

{% list tabs group=instructions %}

- Вручную {#manual}

  1. [Удалите кластер {{ managed-k8s-name }}](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
  1. Если вы зарезервировали для [кластера {{ managed-k8s-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) [публичный статический IP-адрес](../../vpc/concepts/address.md#public-addresses), [удалите его](../../vpc/operations/address-delete.md).
  1. [Удалите сервисные аккаунты](../../iam/operations/sa/delete.md).
  1. [Удалите реестр {{ container-registry-name }}](../../container-registry/operations/registry/registry-delete.md).
  1. [Удалите подсети](../../vpc/operations/subnet-delete.md) и [сеть](../../vpc/operations/network-delete.md).

- {{ TF }} {#tf}

  1. В терминале перейдите в директорию с планом инфраструктуры.
  
      {% note warning %}
  
      Убедитесь, что в директории нет {{ TF }}-манифестов с ресурсами, которые вы хотите сохранить. {{ TF }} удаляет все ресурсы, которые были созданы с помощью манифестов в текущей директории.
  
      {% endnote %}
  
  1. Удалите ресурсы:
  
      1. Выполните команду:
  
          ```bash
          terraform destroy
          ```
  
      1. Подтвердите удаление ресурсов и дождитесь завершения операции.
  
      Все ресурсы, которые были описаны в {{ TF }}-манифестах, будут удалены.

{% endlist %}