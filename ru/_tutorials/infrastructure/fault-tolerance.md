# Настройка отказоустойчивой архитектуры в {{ yandex-cloud }}


С помощью этой инструкции вы настроите отказоустойчивую архитектуру в {{ yandex-cloud }} и проверите ее работу на различных тестовых сценариях.

Отказоустойчивость — это свойство системы сохранять свою работоспособность после отказа одной или нескольких ее составных частей.

Чтобы настроить и протестировать архитектуру:

1. [Подготовьте облако к работе](#before-begin).
1. [Настройте тестовый стенд](#prepare).
1. [Выполните тестовые сценарии](#run).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки отказоустойчивой архитектуры {{ yandex-cloud }} входит:

* Плата за [диски](../../compute/concepts/disk.md) и постоянно запущенные [ВМ](../../compute/concepts/vm.md) (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md)).
* Плата за постоянно запущенный [кластер {{ mpg-full-name }}](../../managed-postgresql/concepts/index.md) (см. [тарифы {{ mpg-name }}](../../managed-postgresql/pricing.md)).
* Плата за использование динамического или статического [публичного IP-адреса](../../vpc/concepts/address.md) (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).


## Настройте тестовый стенд {#prepare}

Описание тестового стенда:

* Приложение упаковано в [Docker-образ](../../container-registry/concepts/docker-image.md) и загружено в {{ container-registry-full-name }}.

  Docker-образы развернуты на четырех ВМ на основе [{{ coi }}](../../cos/). ВМ объединены в группу и расположены в двух различных [зонах доступности](../../overview/concepts/geo-scope.md).

* Кластер БД работает под управлением сервиса {{ mpg-name }} и состоит из двух хостов, расположенных в различных зонах доступности.
* Нагрузка генерируется приложением [{{ load-testing-name }} Tool](/marketplace/products/yc/load-testing) из {{ marketplace-full-name }} и подается на [{{ network-load-balancer-full-name }}](../../network-load-balancer/). Сетевой балансировщик нагрузки распределяет трафик по ВМ.

### Подготовьте контейнеры приложения TodoList {#create-app}

Чтобы подготовить приложение для запуска в {{ yandex-cloud }}:

1. Скачайте и распакуйте [репозиторий](https://github.com/glebmish/yandex-cloud-fault-tolerance-demo/archive/master.zip) с исходным кодом демо-приложения, {{ TF }}-спецификациями и скриптом для имитации сбоя приложения.
1. Перейдите в репозиторий:

   ```bash
   cd yandex-cloud-fault-tolerance-demo-master/app
   ```

1. [Аутентифицируйтесь](../../container-registry/operations/authentication.md) в {{ container-registry-name }}:

   ```bash
   yc container registry configure-docker
   ```

1. [Создайте реестр](../../container-registry/operations/registry/registry-create.md):

   ```bash
   yc container registry create --name todo-registry
   ```

1. [Создайте Docker-образ](../../container-registry/operations/docker-image/docker-image-create.md) с тегом `v1`:

   ```bash
   docker build . --tag {{ registry }}/<идентификатор_реестра>/todo-demo:v1 --platform linux/amd64
   ```

1. Создайте Docker-образ с тегом `v2` (для проверки сценария обновления приложения):

   ```bash
   docker build . --build-arg COLOR_SCHEME=dark --tag {{ registry }}/<идентификатор_реестра>/todo-demo:v2 --platform linux/amd64
   ```

1. [Загрузите Docker-образы](../../container-registry/operations/docker-image/docker-image-push.md) в {{ container-registry-name }}:

   ```bash
   docker push {{ registry }}/<идентификатор_реестра>/todo-demo:v1
   docker push {{ registry }}/<идентификатор_реестра>/todo-demo:v2
   ```

### Разверните инфраструктуру {#create-environment}

Чтобы подготовить окружение для запуска приложения в {{ yandex-cloud }}:

1. [Установите {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
1. Перейдите в директорию со спецификацией окружения:

   ```bash
   cd ../terraform/app
   ```

1. Инициализируйте {{ TF }} в директории со спецификацией:

   ```bash
   terraform init
   ```

1. Сохраните идентификатор каталога в переменную `YC_FOLDER` и [IAM-токен](../../iam/concepts/authorization/iam-token.md) — в переменную `YC_TOKEN`:

   ```bash
   export YC_FOLDER=<идентификатор_каталога>
   export YC_TOKEN=$(yc iam create-token)
   ```

1. Сгенерируйте ключ для [подключения к виртуальной машине по SSH](../../compute/operations/vm-connect/ssh.md):

   ```bash
   ssh-keygen -t ed25519
   ```

1. В файле `app/todo-service.tf` укажите путь к публичному SSH-ключу (значение по умолчанию `~/.ssh/id_ed25519.pub`).
1. Проверьте квоты в облаке, чтобы была возможность развернуть требуемые ресурсы.

   {% cut "Информация о количестве создаваемых ресурсов" %}

   Будут созданы следующие ресурсы:

   * [Сеть](../../vpc/concepts/network.md#network) {{ vpc-name }} с тремя [подсетями](../../vpc/concepts/network.md#subnet) во всех зонах доступности.
   * Два [сервисных аккаунта](../../iam/concepts/users/service-accounts.md):
     * Сервисный аккаунт для управления группой ВМ с ролью `editor`.
     * Сервисный аккаунт для скачивания Docker-образа на ВМ с [ролью](../../iam/concepts/access-control/roles.md) `container-registry.images.puller`.
   * Группа ВМ из четырех ВМ на базе {{ coi }} в зонах доступности `{{ region-id }}-b` и `{{ region-id }}-c`.
   * Кластер {{ mpg-name }} с двумя хостами в зонах доступности `{{ region-id }}-b` и `{{ region-id }}-c`.
   * Сетевой балансировщик нагрузки для распределения трафика по ВМ группы.

   {% endcut %}

1. Разверните и запустите приложение:

   ```bash
   terraform apply -var yc_folder=$YC_FOLDER -var yc_token=$YC_TOKEN -var user=$USER
   ```

   Где:

   * `yc_folder` — [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет развернуто приложение.
   * `yc_token` — [IAM-токен](../../iam/concepts/authorization/iam-token.md) пользователя, от имени которого будет развернуто приложение.

Для доступа к приложению перейдите по адресу `lb_address`, полученному в результате выполнения `terraform apply`.

### Подготовьте и запустите приложение {{ load-testing-name }} Tool {#create-load-testing-tool}

{% note warning %}

Перед созданием {{ load-testing-name }} Tool [подготовьте контейнеры приложения TodoList](#create-app) и [разверните инфраструктуру](#create-environment).

{% endnote %}

1. Перейдите в директорию со спецификацией {{ load-testing-name }} Tool:

   ```bash
   cd ../tank
   ```

1. Инициализируйте {{ TF }} в директории со спецификацией {{ load-testing-name }} Tool:

   ```bash
   terraform init
   ```

1. В файле `tank/main.tf` укажите путь к публичному и приватному SSH-ключам (значения по умолчанию `~/.ssh/id_ed25519.pub` и `~/.ssh/id_ed25519`).
1. Разверните и запустите ВМ:

   ```bash
   terraform apply -var yc_folder=$YC_FOLDER -var yc_token=$YC_TOKEN -var user=$USER -var overload_token=<overload_token>
   ```

   Где:

   * `yc_folder` — каталог, в котором будет развернуто {{ load-testing-name }} Tool.
   * `yc_token`— IAM-токен пользователя, от имени которого будет развернуто {{ load-testing-name }} Tool.
   * `overload_token` — токен для подключения к `<overload.yandex.net>`. Для получения токена нужно аутентифицироваться, после чего нажать справа вверху на свой профиль и в выпадающем меню выбрать **My api token**.

1. Подключитесь к созданной ВМ по [SSH](../../glossary/ssh-keygen.md). Адрес для подключения указан в выводе команды `terraform apply`:

   ```bash
   ssh <имя_пользователя>@<IP-адрес_ВМ>
   ```

1. Запустите {{ load-testing-name }} Tool:

   ```bash
   sudo yandex-tank -c load.yaml
   ```

1. Перейдите в `<overload.yandex.net>` и найдите там запущенную нагрузку: **Public tests** → **show my tests only**.

## Выполнение сценариев {#run}

### Сбой ВМ {#error-vm}

Как проявляется сбой: недоступна ВМ с приложением.

Возможные причины:

* Падение физического хоста, на котором была запущена ВМ.
* По ошибке удалена ВМ с приложением.

Для имитации сбоя удалите одну из ВМ группы:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог с вашей группой ВМ.
  1. В списке сервисов выберите **{{ compute-name }}**.
  1. На панели слева выберите ![image](../../_assets/compute/vm-group-pic.svg) **{{ ui-key.yacloud.compute.switch_groups }}**.
  1. Выберите группу `todo-ig`.
  1. Перейдите на панель **{{ ui-key.yacloud.compute.placement-group.switch_instances }}**.
  1. В строке с нужной ВМ нажмите значок ![image](../../_assets/options.svg) → **{{ ui-key.yacloud.common.delete }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.compute.instances.popup-confirm_button_delete }}**.

{% endlist %}

Реакция тестового стенда:

1. Сетевой балансировщик нагрузки и {{ ig-name }} получают информацию о сбое ВМ и выводят ее из балансировки — трафик перестает поступать на эту ВМ и распределяется между оставшимися ВМ в группе.
1. {{ ig-name }} [автоматически восстанавливается](../../compute/concepts/instance-groups/autohealing.md):
   1. Удаляет недоступную ВМ (в этом сценарии ВМ уже удалена, шаг будет пропущен).
   1. Создает новую ВМ.
   1. Ожидает запуска приложения на созданной ВМ.
   1. Добавляет ВМ в балансировку.

Балансировщику нагрузки и {{ ig-name }} требуется некоторое время, чтобы обнаружить проблему и отключить подачу трафика на неисправную ВМ. Из-за этого возможно появление ошибок Connection Timeout (HTTP-код `0` на графиках **Quantities** и **HTTP codes** в мониторинге {{ load-testing-name }} Tool).

После выведения недоступной ВМ из балансировки пользовательская нагрузка обрабатывается корректно.

### Сбой приложения {#error-app}

Как проявляется сбой: приложение не отвечает вовремя или работает некорректно с точки зрения пользователя.

Возможные причины:

* Утечка памяти привела к падению приложения.
* Приложение не может продолжить работу из-за потери связности с БД.
* Приложение не успевает обрабатывать запросы из-за большой нагрузки.

В соответствии с настройками [проверки состояния](../../compute/concepts/instance-groups/autohealing.md#setting-up-health-checks) {{ ig-name }} опрашивает ВМ группы по HTTP-протоколу. При нормальной работе обращение к конечной точке `/healthy` возвращается HTTP-код `200`. Иначе {{ ig-name }} запускает процедуру восстановления.

Для имитации сбоя в репозитории `yandex-cloud-fault-tolerance-demo-master` запустите скрипт:

```bash
fail_random_host.sh <идентификатор_группы_ВМ>
```

Случайная ВМ из группы начнет возвращать HTTP-код `503`.

Реакция тестового стенда:

1. {{ ig-name }} получает информацию о сбое приложения и выводит ВМ из балансировки — трафик перестает поступать на эту ВМ и распределяется между оставшимися ВМ в группе.
1. {{ ig-name }} [автоматически восстанавливается](../../compute/concepts/instance-groups/autohealing.md):
   1. Перезагружает неисправную ВМ.
   1. Ожидает запуска приложения на созданной ВМ.
   1. Добавляет ВМ в балансировку.

{{ ig-name }} несколько раз опрашивает ВМ прежде чем отключить трафик и запустить восстановление. Из-за этого возможно появление ошибок Service Unavailable (HTTP-код `503` на графиках **Quantities** и **HTTP codes** в мониторинге {{ load-testing-name }} Tool).

После выведения неисправной ВМ из балансировки пользовательская нагрузка обрабатывается корректно.

### Отключение зоны доступности {#zone-down}

Как проявляется сбой: недоступны несколько ВМ в одной зоне.

Возможные причины:

* Перебои в работе дата-центра.
* Плановые технические работы в дата-центре.

Чтобы перенести ресурсы в другой дата-центр:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог с вашей группой ВМ.
  1. В списке сервисов выберите **{{ compute-name }}**.
  1. На панели слева выберите ![image](../../_assets/compute/vm-group-pic.svg) **{{ ui-key.yacloud.compute.switch_groups }}**.
  1. Выберите группу `todo-ig`.
  1. В правом верхнем углу нажмите **{{ ui-key.yacloud.compute.groups.button_action-edit }}**.
  1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_allocation }}** снимите галочку с зоны доступности `{{ region-id }}-b`.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.groups.create.button_edit }}**.

{% endlist %}

Реакция тестового стенда:

1. {{ ig-name }} выводит из балансировки ВМ в зоне доступности `{{ region-id }}-b`.
1. Выведенные ВМ удаляются, одновременно с этим создаются ВМ в зоне `{{ region-id }}-c`.
1. {{ ig-name }} добавляет созданные ВМ в балансировку.

Количество одновременно создаваемых и удаляемых ВМ определяется [политикой развертывания](../../compute/concepts/instance-groups/policies/deploy-policy.md).

Во время выведения ВМ из балансировки возможно появление ошибок Connection Timeout (HTTP-код `0` на графиках **Quantities** и **HTTP codes** в мониторинге {{ load-testing-name }} Tool).

После выведения ВМ из балансировки пользовательская нагрузка обрабатывается корректно.

### Обновление приложения {#update-app}

Чтобы обновить приложение:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог с вашей группой ВМ.
  1. В списке сервисов выберите **{{ compute-name }}**.
  1. На панели слева выберите ![image](../../_assets/compute/vm-group-pic.svg) **{{ ui-key.yacloud.compute.switch_groups }}**.
  1. Выберите группу `todo-ig`.
  1. В правом верхнем углу нажмите **{{ ui-key.yacloud.compute.groups.button_action-edit }}**.
  1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_instance }}** нажмите значок ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) и выберите **{{ ui-key.yacloud.common.edit }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** перейдите на вкладку **{{ ui-key.yacloud.compute.instances.create.image_value_coi }}**.
  1. Выберите необходимый Docker-контейнер и нажмите ![image](../../_assets/options.svg) → **{{ ui-key.yacloud.common.edit }}**.
  1. В открывшемся окне в поле **{{ ui-key.yacloud.compute.instances.create.field_coi-image }}** укажите образ с новой версией приложения (тег `v2`).
  1. Нажмите кнопку **{{ ui-key.yacloud.common.apply }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.groups.create.button_edit }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}** на странице **{{ ui-key.yacloud.compute.group.edit.label_title }}**.

{% endlist %}

Реакция тестового стенда:

1. {{ ig-name }} выводит из балансировки две ВМ с устаревшей версией приложения ([статус](../../compute/concepts/instance-groups/statuses.md#vm-statuses) таких ВМ `RUNNING_OUTDATED`).
1. Удаляет выведенные ВМ, одновременно с этим создает ВМ с новой версией приложения.
1. Добавляет созданные ВМ в балансировку.
1. Действия повторяются для оставшихся двух ВМ с устаревшей версией приложения.

Обновите страницу приложения. Если сетевой балансировщик отправит ваш запрос на уже обновленную ВМ, то вы увидите версию приложения с темной цветовой схемой.

Количество одновременно создаваемых и удаляемых ВМ определяется [политикой развертывания](../../compute/concepts/instance-groups/policies/deploy-policy.md).

Во время выведения ВМ из балансировки возможно появление ошибок Connection Timeout (HTTP-код `0` на графиках **Quantities** и **HTTP codes** в мониторинге {{ load-testing-name }} Tool).

После выведения ВМ из балансировки пользовательская нагрузка обрабатывается корректно.

### Масштабирование конфигурации БД {#scaling-database}

Масштабирование БД может потребоваться, если:

* Производительности хостов в кластере не хватает для обработки запросов.
* Для данных требуется хранилище большего объема.

Чтобы масштабировать конфигурацию:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог с вашим кластером БД.
  1. В списке сервисов выберите **{{ mpg-name }}**.
  1. Выберите кластер `todo-postgresql`.
  1. Нажмите кнопку ![image](../../_assets/pencil.svg) **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}**.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_resource }}** выберите `s2.medium`.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

{% endlist %}

{{ mpg-name }} запустит операцию изменения кластера.

При переключении между мастером и репликой (в начале и в конце процесса изменения) возможно появление ошибок Internal Server Error (HTTP-код `500` на графиках **Quantities** и **HTTP codes** в мониторинге {{ load-testing-name }} Tool).

После переключения пользовательская нагрузка обрабатывается корректно.

## Удаление приложений и окружения {#clear-out}

{% note warning %}

Если создана ВМ с {{ load-testing-name }} Tool, необходимо сначала удалить ее, иначе удаление сети {{ vpc-name }} завершится с ошибкой.

{% endnote %}

Чтобы удалить приложение {{ load-testing-name }} Tool, перейдите в каталог `yandex-cloud-fault-tolerance-demo-master/terraform/tank` и выполните следующую команду:

```bash
terraform destroy -var yc_folder=$YC_FOLDER -var yc_token=$YC_TOKEN -var user=$USER -var overload_token=not-used
```

Чтобы удалить приложение TodoList, перейдите в каталог `yandex-cloud-fault-tolerance-demo-master/terraform/app` и выполните следующую команду:

```bash
terraform destroy -var yc_folder=$YC_FOLDER -var yc_token=$YC_TOKEN -var user=$USER
```
