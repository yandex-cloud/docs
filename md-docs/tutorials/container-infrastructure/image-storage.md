# Хранение Docker-образов из проектов {{ mgl-full-name }}

# Хранение Docker-образов из {{ mgl-full-name }} в {{ container-registry-full-name }}


В {{ GL }} интегрирован сервис [{{ container-registry-name }}](https://docs.gitlab.com/ee/user/packages/container_registry/). Он позволяет хранить Docker-образы для каждого проекта в {{ GL }}.

Вместо {{ GL }} {{ container-registry-name }} вы можете использовать [{{ container-registry-full-name }}](../../container-registry/index.md). Этот сервис позволяет хранить Docker-образы в облаке и распространять их между управляемыми сервисами {{ yandex-cloud }}, например, [{{ managed-k8s-full-name }}](../../managed-kubernetes/index.md) или [{{ mgl-full-name }}](../../managed-gitlab/index.md).

Использование {{ container-registry-full-name }} для хранения образов из проектов {{ GL }} обладает несколькими преимуществами:

* {{ GL }} {{ container-registry-name }} хранит образы и теги на диске [инстанса {{ GL }}](../../managed-gitlab/concepts/index.md#instance). Когда место на диске заканчивается, возникает ошибка с HTTP-кодом 500, инстанс становится недоступным. Восстановить его можно только через обращение в техническую поддержку.

   {{ container-registry-full-name }} хранит образы и теги в [реестрах](../../container-registry/concepts/registry.md), для которых выделяются [отдельные квоты](../../container-registry/concepts/limits.md). Поэтому накопление Docker-образов и тегов не влияет на место на диске инстанса.

* Образы в {{ container-registry-full-name }} остаются доступными, даже если {{ mgl-name }} недоступен.

* {{ container-registry-full-name }} поддерживает [сканер уязвимостей Docker-образов](../../container-registry/concepts/vulnerability-scanner.md). С его помощью можно обнаружить уязвимости и устранить их до развертывания приложения. Подробнее о сканировании см. в [блоге {{ yandex-cloud }}](https://yandex.cloud/ru/blog/posts/2023/04/vulnerability-scanner-and-yandex-container-registry).

Чтобы настроить хранение Docker-образов из {{ mgl-name }} в {{ container-registry-full-name }}:

1. [Создайте инстанс {{ GL }}](#create-gitlab).
1. [Настройте {{ GL }}](#configure-gitlab).
1. [Создайте тестовое приложение](#app-create).
1. [Создайте {{ GLR }}](#runners).
1. [Создайте переменные окружения {{ GL }}](#add-variables).
1. [Создайте файл конфигурации сценария CI](#add-ci).
1. [Проверьте результат](#check-result).
1. [Включите политику автоматического удаления Docker-образов](#lifecycle-policy).
1. (Опционально) [Отсканируйте Docker-образы на наличие уязвимостей](#vulnerability-scanner).

Если инстанс {{ mgl-full-name }} уже настроен для непрерывной интеграции ([Continuous Integration](https://yandex.cloud/ru/blog/posts/2022/10/ci-cd), CI), убедитесь, что [инфраструктура для хранения Docker-образов](#deploy-infrastructure) подготовлена. Затем начните настройку с [создания переменных окружения](#add-variables).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

{% note info %}

По умолчанию {{ GL }} {{ container-registry-name }} отключен при создании инстанса {{ mgl-name }}.

{% endnote %}

## Перед началом работы {#before-you-begin}

Зарегистрируйтесь в {{ yandex-cloud }} и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь.
1. На странице **[{{ ui-key.yacloud_billing.billing.label_service }}]({{ link-console-billing }})** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака]({{ link-console-cloud }}).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входит плата за следующие ресурсы:

* Диски и постоянно запущенные виртуальные машины (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md)).
* Использование динамического публичного IP-адреса (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md#prices-public-ip)).
* Хранение созданных Docker-образов и сканер уязвимостей, если вы его [активируете](#vulnerability-scanner) (см. [тарифы {{ container-registry-name }}](../../container-registry/pricing.md)).
* Использование мастера {{ managed-k8s-name }} (см. [тарифы {{ managed-k8s-name }}](../../managed-kubernetes/pricing.md)).

### Подготовьте инфраструктуру {#deploy-infrastructure}

{% list tabs group=instructions %}

- Вручную {#manual}

   1. Если у вас еще нет [сети](../../vpc/concepts/network.md#network), [создайте ее](../../vpc/operations/network-create.md).
   1. Если у вас еще нет [подсетей](../../vpc/concepts/network.md#subnet), [создайте их](../../vpc/operations/subnet-create.md) в [зонах доступности](../../overview/concepts/geo-scope.md), где будут созданы [кластер {{ managed-k8s-full-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) и [группа узлов](../../managed-kubernetes/concepts/index.md#node-group).
   1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) `account-for-container-registry` с [ролями](../../iam/concepts/access-control/roles.md) на каталог:

      * `{{ roles-editor }}`
      * `{{ roles-cr-pusher }}`
      * `{{ roles-cr-puller }}`

   1. [Создайте кластер {{ managed-k8s-name }}](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md#kubernetes-cluster-create) с базовым мастером и [группу узлов](../../managed-kubernetes/operations/node-group/node-group-create.md). При создании кластера укажите созданный ранее сервисный аккаунт.
   1. Настройте группу безопасности для работы [кластера {{ managed-k8s-name }}](../../managed-kubernetes/operations/connect/security-groups.md) и [инстанса {{ mgl-name }}](../../managed-gitlab/operations/configure-security-group.md).

   1. [Создайте реестр {{ container-registry-full-name }}](../../container-registry/operations/registry/registry-create.md).

- {{ TF }} {#tf}

   1. Если у вас еще нет {{ TF }}, [установите его](../infrastructure-management/terraform-quickstart.md#install-terraform).
   1. [Получите данные для аутентификации](../infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
   1. [Настройте и инициализируйте провайдер](../infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
   1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

   1. Скачайте в ту же рабочую директорию файл конфигурации [container-registry-and-gitlab.tf](https://github.com/yandex-cloud-examples/yc-gitlab-cr-integration/blob/main/container-registry-and-gitlab.tf).

      В этом файле описаны:

      * [Сеть](../../vpc/concepts/network.md#network).
      * [Подсеть](../../vpc/concepts/network.md#subnet).
      * [Группа безопасности](../../vpc/concepts/security-groups.md) и правила, необходимые для работы инстанса {{ mgl-name }} и [кластера {{ managed-k8s-full-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster).
      * Кластер {{ managed-k8s-name }} с базовым мастером.
      * [Группа узлов для кластера](../../managed-kubernetes/concepts/index.md#node-group).
      * [Сервисный аккаунт](../../iam/concepts/users/service-accounts.md), необходимый для работы кластера и группы узлов {{ managed-k8s-name }}.
      * Реестр {{ container-registry-full-name }}.

   1. Укажите в файле `container-registry-and-gitlab.tf`:

      * [Идентификатор облака](../../resource-manager/operations/cloud/get-id.md).
      * [Идентификатор каталога](../../resource-manager/operations/folder/get-id.md).
      * [Версию {{ k8s }}](../../managed-kubernetes/concepts/release-channels-and-updates.md) для кластера и групп узлов {{ managed-k8s-name }}.

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

Создайте тестовое приложение, которое можно будет развернуть в кластере {{ managed-k8s-name }}. Для этого добавьте в проект `Dockerfile`:

   1. Авторизуйтесь в {{ GL }}.
   1. Откройте проект {{ GL }}.
   1. В строке навигации по репозиторию нажмите кнопку ![image](../../_assets/console-icons/plus.svg) и в выпадающем меню выберите пункт **New file**.
   1. Назовите файл `Dockerfile` и добавьте в него код:

      ```Dockerfile
      FROM alpine:3.10
      CMD echo "Hello"
      ```

   1. Напишите комментарий к коммиту в поле **Commit message**: `Dockerfile for a test application`.
   1. Нажмите кнопку **Commit changes**.

## Создайте {{ GLR }} {#runners}

Чтобы запускать задачи сборки в [кластере {{ managed-k8s-full-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster), создайте [{{ GLR }}](https://docs.gitlab.com/runner/install/kubernetes/). Для этого установите приложение {{ GLR }} согласно [инструкции](../../managed-kubernetes/operations/applications/gitlab-runner.md).

После установки вы можете запускать автоматизированные сборки внутри своего [кластера {{ managed-k8s-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster).

Подробнее про установку и настройку {{ GLR }} читайте в [документации {{ GL }}](https://docs.gitlab.com/runner/install/).

## Создайте переменные окружения {{ GL }} {#add-variables}

Чтобы разрешить сервису {{ mgl-name }} сохранять Docker-образы и их теги в {{ container-registry-full-name }}, создайте [переменные окружения {{ GL }}](https://docs.gitlab.com/ee/ci/variables/index.html):

1. Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

   По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

1. Создайте [авторизованный ключ](../../iam/concepts/authorization/key.md) для сервисного аккаунта `account-for-container-registry`, [созданного ранее](#before-you-begin):

   ```bash
   yc iam key create --service-account-name account-for-container-registry -o key.json
   ```

   Ключ сохраняется в файле `key.json` в папке, где была запущена команда.

1. Откройте свой проект в {{ GL }}.

1. На панели слева перейдите в раздел **Settings** и во всплывающем списке выберите пункт **CI/CD**.

1. Разверните раздел **Variables**.

1. Добавьте переменные окружения с выключенной опцией защиты:

   | **Переменная**        | **Ее значение**                    |
   | --------------------- | ---------------------------------- |
   | `CI_REGISTRY`         | `{{ registry }}/<идентификатор_реестра>`. Укажите идентификатор созданного ранее реестра {{ container-registry-full-name }}. |
   | `CI_REGISTRY_KEY`     | Содержимое файла `key.json`.       |

   Для добавления переменной:

   1. Нажмите кнопку **Add variable**.
   1. Для переменной `CI_REGISTRY_KEY` в поле **Visibility** выберите вариант **Visible**.

      {% note warning %}

      Файл `key.json` содержит пробелы и переносы строк, маскирование которых не поддерживается в {{ GL }}. При этом в приведенном [примере CI-пайплайна](#add-ci), переменная `CI_REGISTRY_KEY` в явном виде не выводится, поэтому ее маскирование не требуется.

      {% endnote %}

   1. В появившемся окне в поле **Key** укажите имя переменной, в поле **Value** — значение переменной.
   1. Выключите опцию **Protect variable**.
   1. Нажмите кнопку **Add variable**.

## Создайте файл конфигурации сценария CI {#add-ci}

Для сборки образов из Dockerfile без Docker используется [kaniko](https://github.com/GoogleContainerTools/kaniko).

Чтобы публиковать Docker-образы из проекта {{ GL }} в {{ container-registry-full-name }}, создайте сценарий CI:

1. Откройте проект `gitlab-test`.
1. В строке навигации по репозиторию нажмите кнопку ![image](../../_assets/console-icons/plus.svg) и в выпадающем меню выберите пункт **New file**.
1. Назовите файл `.gitlab-ci.yml`. Добавьте в него шаги сборки Docker-образа и его загрузки в {{ container-registry-full-name }}:

   {% cut ".gitlab-ci.yml" %}

   ```yaml
   build:
      stage: build
      # Использование kaniko для создания контейнера внутри контейнера для большей безопасности.
      image:
         name: gcr.io/kaniko-project/executor:debug
         entrypoint: [""]
      script:
         - mkdir -p /kaniko/.docker
         # Отправка образа контейнера в реестр. Образ отмечен хэшем коммита.
         - echo "{\"auths\":{\"$CI_REGISTRY\":{\"auth\":\"$(echo -n "json_key:${CI_REGISTRY_KEY}" | base64 | tr -d '\n' )\"}}}" > /kaniko/.docker/config.json
         - >-
            /kaniko/executor
            --context "${CI_PROJECT_DIR}"
            --dockerfile "${CI_PROJECT_DIR}/Dockerfile"
            --destination "${CI_REGISTRY}/${CI_PROJECT_PATH}:${CI_COMMIT_SHORT_SHA}"
   ```

   {% endcut %}

   Файл содержит переменные:

   * `CI_REGISTRY` и `CI_REGISTRY_KEY` — добавлены в GitLab на [предыдущем шаге](#add-variables).
   * `CI_PROJECT_DIR`, `CI_PROJECT_PATH` и `CI_COMMIT_SHORT_SHA` — [предопределены в GitLab](https://docs.gitlab.com/ee/ci/variables/predefined_variables.html).

1. Напишите комментарий к коммиту в поле **Commit message**: `Create a CI pipeline`.
1. Нажмите кнопку **Commit changes**.

## Проверьте результат {#check-result}

После каждого коммита запускается сценарий сборки. Чтобы проверить результаты его выполнения:

1. На панели слева в проекте `gitlab-test` выберите пункт **Build**, в выпадающем меню выберите пункт **Pipelines**.

1. Убедитесь, что этап `build` принимает статус `passed`. Это означает, что сценарий CI выполнился успешно.

1. Перейдите в [консоль управления]({{ link-console-main }}/), затем откройте реестр {{ container-registry-full-name }}.

   При успешном выполнении сценария появляется новый репозиторий в реестре. Он пополняется Docker-образами из проекта {{ GL }} при каждом коммите.

## Включите политику автоматического удаления Docker-образов {#lifecycle-policy}

Чтобы не хранить устаревшие Docker-образы и их теги, используйте [политику автоматического удаления Docker-образов](../../container-registry/concepts/lifecycle-policy.md). Она применяется к образам в [репозитории {{ container-registry-name }}](../../container-registry/concepts/repository.md) и позволяет своевременно очищать место в нем. Так вы не переплачиваете за [хранение устаревших образов](../../container-registry/pricing.md#prices-storage).

Чтобы создать политику, [следуйте инструкции](../../container-registry/operations/lifecycle-policy/lifecycle-policy-create.md).

Особенности работы с политикой:

* Внешние {{ container-registry-name }} и политика удаления образов [влияют на производительность сценариев CI](https://docs.gitlab.com/ee/user/packages/container_registry/reduce_container_registry_storage.html#use-with-external-container-registries).

* Для политики действует [лимит](../../container-registry/concepts/limits.md#container-registry-limits) на максимальное количество образов, которые можно проверить за один запуск политики. Если количество образов в репозитории {{ container-registry-name }} превышает этот лимит, запустите политику несколько раз. Так будут проверены все образы.

## Отсканируйте Docker-образы на наличие уязвимостей {#vulnerability-scanner}

Чтобы отслеживать уязвимости Docker-образов, вы можете дополнительно активировать [сканер уязвимостей](../../container-registry/concepts/vulnerability-scanner.md) в {{ container-registry-full-name }}. Сканер сравнивает версии пакетов, установленных в образах, с базами уязвимостей [CVE](https://cve.mitre.org/).

Чтобы включить сканирование, дополните сценарий CI в своем проекте {{ GL }}:

1. Откройте проект `gitlab-test`.
1. Откройте файл `.gitlab-ci.yml`.
1. Добавьте в него шаги сканирования Docker-образа на наличие уязвимостей:

   {% cut ".gitlab-ci.yml" %}

   ```yaml
   stages:
      - build
      - test

   <блок_build_добавленный_ранее_в_файл>

   container_scanning_free_yc:
      stage: test
      # Использование утилиты jq для поиска идентификатора и записи логов.
      image: 
         name: pindar/jq
         entrypoint: [""]
      artifacts:
         when: always
         paths:
            - gl-container-scanning-report-yc.json
      variables:
         # Укажите идентификатор созданного ранее реестра.
         CI_REGISTRY_ID: "<идентификатор_реестра>"
      script:
         - export CI_COMMIT_SHORT_SHA=${CI_COMMIT_SHORT_SHA}
         # Установка Yandex Cloud CLI.
         - curl https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash -s -- -a && cp /root/yandex-cloud/bin/yc /usr/bin/
         # Начало сканирования.
         - echo "Scanning image ${CI_REGISTRY}/${CI_PROJECT_PATH}:${CI_COMMIT_SHORT_SHA}..."
         - export IMAGE_ID=$(yc container image list --registry-id $CI_REGISTRY_ID --format=json | jq -r --arg CI_COMMIT_SHORT_SHA $CI_COMMIT_SHORT_SHA '.[] | select(.tags[0]==$CI_COMMIT_SHORT_SHA) | .id ')
         # Запись логов.
         - export SCAN_RESULT=$(yc container image scan $IMAGE_ID --format=json)
         - export CRIT_VULN=$(echo $SCAN_RESULT | jq -r '.vulnerabilities.critical // 0')
         - export HIGH_VULN=$(echo $SCAN_RESULT | jq -r '.vulnerabilities.high // 0')
         - export SCAN_ID=$(echo $SCAN_RESULT | jq -r '.id')
         - echo "Scan results:"
         - yc container image list-vulnerabilities --scan-result-id="${SCAN_ID}" --format json | jq -r '.[] | select(.severity=="CRITICAL", .severity=="HIGH")'
         - yc container image list-vulnerabilities --scan-result-id="${SCAN_ID}" --format json | jq -r '.[] | select(.severity=="CRITICAL", .severity=="HIGH")' > gl-container-scanning-report-yc.json
         # Проверка результата.
         - (( SUM = $CRIT_VULN + $HIGH_VULN )) && (( RES = (SUM >= 1) )) && echo $RES && echo "image has $CRIT_VULN critical vulnerabilities and $HIGH_VULN high vulnerabilities" && exit 1 || echo "image has no high or critical vulnerabilities" exit 0
   ```

   {% endcut %}

1. Напишите комментарий к коммиту в поле **Commit message**: `Turn on a vulnerability scanner`.
1. Нажмите кнопку **Commit changes**. После этого запустится обновленный сценарий.

Чтобы убедиться, что сканирование образов прошло успешно:

1. На панели слева в проекте `gitlab-test` выберите пункт **Build**, в выпадающем меню выберите пункт **Pipelines**.
1. Убедитесь, что этапы `build` и `test` принимают статус `passed`. Это означает, что сценарий CI выполнился успешно.
1. Перейдите в [консоль управления]({{ link-console-main }}/), затем откройте реестр {{ container-registry-full-name }}.
1. Откройте репозиторий с Docker-образами из проекта {{ GL }}.
1. Перейдите в папку с названием проекта {{ GL }}.
1. Убедитесь, что в столбце **{{ ui-key.yacloud.cr.image.label_scan-status }}** указано **{{ ui-key.yacloud.cr.registry.label_scan-status-READY }}**.
1. В столбце **{{ ui-key.yacloud.cr.image.label_last-scan-time }}** нажмите ссылку со временем сканирования.

   Откроются результаты сканирования. Если в образе выявлены уязвимости, они отображаются в полученных результатах.

## Удалите созданные ресурсы {#clear-out}

Если созданные ресурсы вам больше не нужны, удалите их:

1. [Удалите инстанс {{ mgl-name }}](../../managed-gitlab/operations/instance/instance-delete.md) или [созданную виртуальную машину с образом {{ GL }}](../../compute/operations/vm-control/vm-delete.md).
1. [Удалите все Docker-образы](../../container-registry/operations/docker-image/docker-image-delete.md) из реестра {{ container-registry-name }}.

Остальные ресурсы удалите в зависимости от способа их создания:

{% list tabs group=instructions %}

- Вручную {#manual}

   1. [Удалите кластер {{ managed-k8s-name }}](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
   1. Если вы зарезервировали для кластера {{ managed-k8s-name }} публичный IP-адрес, [удалите его](../../vpc/operations/address-delete.md).
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