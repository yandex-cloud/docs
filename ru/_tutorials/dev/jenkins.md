# Автоматизация сборки образов с помощью Jenkins и Packer

На основе заданной конфигурации [Packer](https://www.packer.io/) создает [образы дисков виртуальной машины](../../compute/concepts/image.md) в сервисе [{{ compute-full-name }}](../../compute/). [Jenkins](https://www.jenkins.io/) позволяет построить процесс [непрерывной интеграции (Continuous integration, CI)](/blog/posts/2022/10/ci-cd).

Образы можно использовать при создании облачной инфраструктуры, например, с помощью [{{ TF }}](https://www.terraform.io/language#about-the-terraform-language).

Чтобы установить и настроить Jenkins, Packer, GitHub и {{ TF }} для совместной работы:
1. [Подготовьте облако к работе](#before-you-begin).
1. [Настройте окружение](#prepare).
1. [Создайте сервисный аккаунт](#create-service-account).
1. [Создайте ВМ с Jenkins](#create-jenkins-vm).
1. [Установите Packer на ВМ](#install-packer).
1. [Настройте Jenkins](#configure-jenkins).
1. [Настройте задачу для Jenkins](#jenkins-job).
1. [Настройте GitHub-репозиторий](#configure-github-repo).
1. [Создайте образ с помощью Jenkins](#create-image).
1. [Разверните образы с помощью {{ TF }}](#deploy-image).

Если созданные ВМ и образы больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входят:
* Плата за постоянно запущенные ВМ (см. [тарифы {{ compute-name }}](../../compute/pricing.md)).
* Плата за хранение созданных образов (см. [тарифы {{ compute-name }}](../../compute/pricing#prices-storage)).
* Плата за использование динамических [публичных IP-адресов](../../vpc/concepts/address.md#public-addresses) (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).

## Настройте окружение {#prepare}

Подготовьте программы для работы:
* [Установите](../../cli/operations/install-cli.md) интерфейс командной строки {{ yandex-cloud }}.
* [Установите](https://www.terraform.io/downloads) {{ TF }}. См. также раздел [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md).
* [Загрузите](https://stedolan.github.io/jq/download/) утилиту jq.
* [Настройте](https://gitforwindows.org) Git. Если вы работаете под Windows, используйте Git Bash.
* [Создайте](https://github.com/yandex-cloud-examples/yc-marketplace-vm-image-packer) ответвление репозитория с примерами в своем аккаунте на GitHub.
* [Подготовьте](../../compute/operations/vm-connect/ssh.md) [SSH-ключ](../../glossary/ssh-keygen.md) для доступа к ВМ.

## Создайте сервисный аккаунт {#create-service-account}

С помощью [сервисного аккаунта](../../iam/concepts/users/service-accounts.md) Jenkins сможет выполнять действия в вашем [облаке](../../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder). Чтобы [создать сервисный аккаунт](../../iam/operations/sa/create.md):
1. Получите идентификаторы каталога и облака, выполнив команду `yc config list`.
1. Создайте сервисный аккаунт и передайте его идентификатор в переменную окружения, выполнив команды:

   ```bash
   yc iam service-account create --name <имя_пользователя>
   yc iam key create --service-account-name <имя_пользователя> -o <имя_пользователя.json>
   SERVICE_ACCOUNT_ID=$(yc iam service-account get --name <имя_пользователя> --format json | jq -r .id)
   ```

   В текущем каталоге будет создан JSON-файл, содержащий авторизационные данные.
1. [Назначьте](../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту [роль](../../iam/concepts/access-control/roles.md) `admin` на каталог, где будут выполняться операции:

   ```bash
   yc resource-manager folder add-access-binding <имя_каталога> --role admin --subject serviceAccount:$SERVICE_ACCOUNT_ID
   ```

## Создайте ВМ с Jenkins {#create-jenkins-vm}

Jenkins будет получать изменения в конфигурациях образов ВМ из GitHub, а затем с помощью Packer создавать образы в облаке.

Чтобы создать ВМ с Jenkins:

1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создана ВМ.
1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
1. На панели слева выберите ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.switch_instances }}**.
1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_create }}**.
1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** перейдите на вкладку **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}**, нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_show-all-marketplace-products }}** и выберите образ [Jenkins](/marketplace/products/yc/jenkins).

    {% note info %}

    В случае самостоятельной настройки ВМ с Jenkins воспользуйтесь [инструкцией](https://www.jenkins.io/doc/book/installing/linux/).

    {% endnote %}

1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}** выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой будет находиться ВМ.
1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_storages }}** задайте размер загрузочного [диска](../../compute/concepts/disk.md) `15 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}** перейдите на вкладку **{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}** и укажите параметры:

    * **{{ ui-key.yacloud.component.compute.resources.field_platform }}** — `Intel Ice Lake`.
    * **{{ ui-key.yacloud.component.compute.resources.field_cores }}** — `2`.
    * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}** — `20%`.
    * **{{ ui-key.yacloud.component.compute.resources.field_memory }}** — `2 {{ ui-key.yacloud.common.units.label_gigabyte }}`.

1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

    * В поле **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** укажите идентификатор подсети в зоне доступности создаваемой ВМ или выберите [облачную сеть](../../vpc/concepts/network.md#network) из списка.

        * У каждой сети должна быть как минимум одна [подсеть](../../vpc/concepts/network.md#subnet). Если подсети нет, создайте ее, выбрав **{{ ui-key.yacloud.component.vpc.network-select.button_create-subnetwork }}**.
        * Если сети нет, нажмите **{{ ui-key.yacloud.component.vpc.network-select.button_create-network }}** и создайте ее:

            * В открывшемся окне укажите имя сети и выберите каталог, в котором она будет создана.
            * (Опционально) Выберите опцию **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**, чтобы автоматически создать подсети во всех зонах доступности.
            * Нажмите **{{ ui-key.yacloud.vpc.networks.create.button_create }}**.

    * В поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}** выберите `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`, чтобы назначить виртуальной машине случайный внешний IP-адрес из пула {{ yandex-cloud }}, или выберите статический адрес из списка, если вы зарезервировали его заранее.

1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** выберите **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** и укажите данные для доступа к ВМ:

    * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя, который будет создан на виртуальной машине, например `yc-user`.

        {% note alert %}

        Не используйте логин `root` или другие имена, зарезервированные операционной системой. Для выполнения операций, требующих прав суперпользователя, используйте команду `sudo`.

        {% endnote %}

    * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}** задайте имя ВМ: `jenkins-tutorial`.
1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

## Установите Packer {#install-packer}

Packer позволяет создавать образы дисков ВМ с заданными в конфигурационном файле параметрами.

{% note info %}

Для работы с {{ yandex-cloud }} требуется Packer версии 1.5 и выше.

{% endnote %}

1. Скачайте дистрибутив [Packer](https://packer.io/downloads) для Linux. Также вы можете скачать дистрибутив Packer для вашей платформы из [зеркала](https://hashicorp-releases.yandexcloud.net/packer/).
1. Загрузите Packer на созданную ВМ:

   ```bash
   scp packer_<версия_Packer>_linux_amd64.zip <логин>@<публичный_IP-адрес_ВМ>:~/
   ```

1. [Подключитесь](../../compute/operations/vm-connect/ssh.md) к ВМ по протоколу SSH. Для этого можно использовать утилиту `ssh` в Linux и macOS и программу `PuTTY` для Windows.
1. Создайте новую директорию, переместите в нее исполняемые файлы Packer и распакуйте архив:

   ```bash
   sudo mkdir /opt/yandex-packer/
   sudo mv packer_<версия_Packer>_linux_amd64.zip /opt/yandex-packer/
   unzip packer_<версия_Packer>_linux_amd64.zip
   ```

1. Настройте [плагин Yandex Compute Builder](https://developer.hashicorp.com/packer/plugins/builders/yandex):

    1. Создайте файл `config.pkr.hcl` в директории `/opt/yandex-packer/` со следующим содержанием:
        
        ```hcl
        packer {
          required_plugins {
            yandex = {
              version = ">= 1.1.2"
              source  = "{{ packer-source-link }}"
            }
          }
        }
        ```

    1. Установите плагин:

        ```bash
        packer init <путь_к_файлу_config.pkr.hcl>
        ```

        Результат:

        ```text
        Installed plugin github.com/hashicorp/yandex v1.1.2 in ...
        ```

1. Все действия системы Jenkins будут выполняться от имени пользователя `jenkins`. Дайте этому пользователю права на запуск Packer:

   ```bash
   sudo chmod u+x /opt/yandex-packer/packer*
   sudo chown jenkins:jenkins /opt/yandex-packer/packer*
   ```

## Настройте Jenkins {#configure-jenkins}

Чтобы собирать образы по конфигурациям из GitHub, настройте Jenkins:
1. Подключитесь к ВМ по протоколу SSH. Для этого можно использовать утилиту `ssh` в Linux и macOS и программу `PuTTY` для Windows.
1. Откройте файл пароля для запуска настройки и скопируйте пароль:

   ```bash
   sudo cat /var/lib/jenkins/secrets/initialAdminPassword
   ```

1. Перейдите в браузере по адресу `http://<публичный_IP-адрес_ВМ_с_Jenkins>`. Откроется консоль управления Jenkins.
1. Введите в поле **Administrator password** скопированный пароль и нажмите кнопку **Continue**.
1. Выберите **Select plugins to install**.

   Вам потребуются следующие плагины:
   * `Pipeline` — плагин для получения исходного кода из [системы контроля версий](../../glossary/vcs.md), его сборки, тестирования и развертывания.
   * `Git` — плагин для работы с Git-репозиториями.
   * `Credentials Binding` — плагин для создания переменных окружения, содержащих авторизационные данные.
1. Нажмите кнопку **Install**. Начнется установка выбранных компонентов.
1. После завершения установки вам будет предложено создать учетную запись администратора. Заполните поля формы и нажмите кнопку **Save and Continue**.
1. Вам будет предложено создать URL для Jenkins. Оставьте URL вида `http://<публичный_IP-адрес_ВМ>/`. Нажмите кнопку **Save and finish**.
1. Нажмите кнопку **Start using Jenkins**, чтобы завершить установку и перейти на административную панель Jenkins.

## Настройте задачу для Jenkins {#jenkins-job}

Чтобы Jenkins мог выполнять сборки образов, следует указать авторизационные данные для {{ yandex-cloud }} и создать задачу на получение изменений из репозитория GitHub. Авторизационные данные будут использоваться в переменных, находящихся в конфигурационных файлах Packer.
1. Откройте административную панель Jenkins.
1. В правом верхнем углу нажмите на имя пользователя.
1. Выберите пункт **Credentials**.
1. В блоке **Stores scoped to Jenkins** нажмите на ссылку `Global`.
1. Получите идентификатор подсети, в которой будут собираться образы, выполнив команду `yc vpc subnet list`.
1. Нажмите кнопку **Add credentials**. Укажите следующие параметры:
   1. В списке **Kind** выберите пункт `Secret text`.
   1. В списке **Scope** оставьте `Global`.
   1. В поле **Secret** укажите идентификатор вашего каталога.
   1. В поле **Id** укажите `YC_FOLDER_ID`. Нажмите кнопку **OK**.
1. Создайте еще один секрет со следующими параметрами:
   1. **Kind**: `Secret text`.
   1. **Scope**: `Global`.
   1. **Secret**: идентификатор подсети, в которой находится ВМ с Jenkins.
   1. **ID**: `YC_SUBNET_ID`.
1. Создайте еще один секрет со следующими параметрами:
   1. **Kind**: `Secret file`.
   1. **Scope**: `Global`.
   1. **File**: файл `<имя_пользователя>.json` из [шага 1](#create-service-account).
   1. **ID**: `YC_ACCOUNT_KEY_FILE`.
1. Вернитесь на главную страницу административной панели и выберите пункт **New item**.
1. Введите название для задачи: `jenkins-tutorial` и выберите тип задачи **Pipeline**. Нажмите кнопку **OK**.
1. В открывшемся окне поставьте флаг **GitHub hook trigger for GITScm polling**. Эта опция позволяет запускать сборку по каждому выполнению команды `push` в ветку `master` Git-репозитория.
1. В блоке **Pipeline** в списке **Definition** выберите `Pipeline script from SCM`.
1. В списке **SCM** выберите `Git`.
1. В поле **Repository URL** укажите URL вашего ответвления из GitHub.
1. В поле **Script path** укажите `Jenkinsfile`.
1. Оставьте остальные поля без изменений и нажмите **Сохранить**.

## Настройте GitHub-репозиторий {#configure-github-repo}

В настройках репозитория GitHub включите webhook для запуска сборки в Jenkins и добавьте публичный SSH-ключ для авторизации.

### Включите Webhook {#configure-webhook}

1. Откройте ответвление репозитория на GitHub в браузере.
1. Выберите вкладку **Settings**.
1. Выберите пункт **Webhooks** и нажмите кнопку **Add webhook**.
1. В поле **Payload URL** введите `http://<публичный_IP-адрес_ВМ>/github-webhook/`.
1. Нажмите кнопку **Add webhook**.

### Добавьте на GitHub SSH-ключ {#add-ssh-key}

1. Нажмите на ваш аватар на GitHub. В открывшемся меню выберите пункт **Settings**.
1. Выберите пункт **SSH and GPG keys**.
1. Нажмите кнопку **New SSH key**.
1. В поле **Title** введите любое имя ключа.
1. Скопируйте в поле **Key** ваш SSH-ключ.
1. Нажмите кнопку **Add SSH key**.

## Создайте образ с помощью Jenkins {#create-image}

Сборка образа в Jenkins запускается автоматически после выполнения команды `push` в ветке `master` GitHub-репозитория.
1. Склонируйте на ваш компьютер ответвление репозитория [examples](https://github.com/yandex-cloud-examples/yc-marketplace-vm-image-packer), которое вы создали во время [подготовки к работе](#before-you-begin):

   ```bash
   git clone https://github.com/<логин_на_GitHub>/yc-marketplace-vm-image-packer.git
   ```

1. Внесите изменения в шаблоны Packer, находящиеся в директории `packer`. Документацию шаблонов Packer можно найти на [сайте](http://packer.io/docs/templates/index.html) разработчика. В параметрах `image_family` и `source_image_family` указываются [семейства образов](../../compute/concepts/image#family), которые будет собирать Jenkins.
1. Внесите изменения в файл описания Pipeline для Jenkins `Jenkinsfile`, расположенный в корневой директории репозитория. Документацию Pipeline см. на [сайте](https://jenkins.io/doc/book/pipeline/syntax/) разработчика.
1. Загрузите изменения на GitHub:

   ```bash
   git add -A
   git commit -m "Build update"
   git push
   ```

1. Откройте административную панель Jenkins и проверьте состояние задачи.
1. Если все настройки выполнены верно, то запустится сборка образов. Результат выполнения можно увидеть в логах сборки.

{% note info %}

При настройке задачи Jenkins в разделе **GitHub Hook log** возможно появление ошибки `Polling has not run yet`. В этом случае следует первый раз запустить сборку вручную.

{% endnote %}

После этого в разделе **{{ ui-key.yacloud.compute.switch_images }}** сервиса **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}** появятся три новых образа:
* `Debian` — базовый образ с последними обновлениями.
* `Nginx` — образ с веб-сервером nginx, базирующийся на образе `Debian`.
* `Django` — образ с фреймворком Django, базирующийся на образе `Debian`.

## Разверните образы {#deploy-image}

После того как образы будут созданы, их можно использовать для создания ВМ. Создайте тестовую инфраструктуру с помощью {{ TF }}:
1. В директории с ответвлением перейдите в директорию с файлами {{ TF }}:

   ```bash
   cd examples/jenkins-packer/terraform
   ```

1. Переименуйте файл `terraform.tfvars_example`:

   ```bash
   mv terraform.tfvars_example terraform.tfvars
   ```

1. Заполните поля файла требуемыми значениями. См. также документацию [{{ TF }}](https://www.terraform.io/language#about-the-terraform-language) и [провайдера {{ yandex-cloud }}]({{ tf-provider-link }}).
1. Инициализируйте провайдера {{ TF }} командой `terraform init`.
1. Выполните команду `terraform plan -var-file="terraform.tfvars"`. Проверьте созданную конфигурацию.
1. Выполните команду `terraform apply` и подтвердите создание инфраструктуры, введя `yes` в терминале.

После этого будут созданы:
1. [Облачная сеть](../../vpc/concepts/network.md#network).
1. Подсети во всех зонах доступности.
1. ВМ из образов, созданных с помощью Packer. ВМ с nginx получат публичные IP-адреса. Все ВМ будут подключены к подсетям.

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:
* [Удалите созданные ВМ](../../compute/operations/vm-control/vm-delete.md).
* [Удалите созданные образы](../../compute/operations/image-control/delete.md).
* [Удалите сервисный аккаунт](../../iam/operations/sa/delete.md) и файл `<имя_пользователя.json>`.
* [Удалите сеть и подсеть](../../vpc/operations/network-delete.md).

Для удаления созданных с помощью {{ TF }} используйте команду `terraform destroy`.