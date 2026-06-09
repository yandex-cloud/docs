# Использование сервиса {{ msp-full-name }} в {{ ml-platform-name }}

# Использование сервиса {{ msp-full-name }} в {{ ml-platform-name }}

В {{ ml-platform-name }} вы можете использовать кластеры [{{ SPRK }}](../../managed-spark/index.md), развернутые в сервисе {{ msp-full-name }}. Подключение кластеров {{ SPRK }} выполняется с помощью [коннекторов Spark](../concepts/spark-connector.md). Для выполнения вычислений в кластере запускается задание с типом `SparkConnect`.

Чтобы в {{ ml-platform-name }} настроить интеграцию с сервисом {{ msp-name }}:

1. [Подготовьте инфраструктуру](#infra).
1. [Настройте проект {{ ml-platform-name }}](#project).
1. [Создайте кластер {{ msp-name }} и коннектор Spark](#create-spark).
1. [Запустите вычисления](#run-code).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

Перед началом работы нужно зарегистрироваться в {{ yandex-cloud }}, настроить [сообщество](../concepts/community.md) и привязать к нему [платежный аккаунт](../../billing/concepts/billing-account.md):
1. [На главной странице {{ ml-platform-name }}]({{ link-datasphere-main }}) нажмите **Попробовать бесплатно** и выберите аккаунт для входа — Яндекс ID или рабочий аккаунт в федерации (SSO).
1. Выберите [организацию {{ org-full-name }}](../../organization/index.md), в которой вы будете работать в {{ yandex-cloud }}.
1. [Создайте сообщество](../operations/community/create.md).
1. [Привяжите платежный аккаунт](../operations/community/link-ba.md) к сообществу {{ ml-platform-name }}, в котором вы будете работать. Убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, создайте его в интерфейсе {{ ml-platform-name }}.

### Необходимые платные ресурсы {#paid-resources}

* Кластер {{ msp-name }}: вычислительные ресурсы компонентов кластера (см. [тарифы {{ msp-name }}](../../managed-spark/pricing.md)).
* NAT-шлюз: почасовое использование шлюза и исходящий через него трафик (см. [тарифы {{ vpc-name }}](../../vpc/pricing.md)).

## Подготовьте инфраструктуру {#infra}

### Создайте каталог {#create-folder}

Создайте каталог, в котором будет работать ваш кластер {{ SPRK }}.

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) выберите облако и нажмите ![create](../../_assets/console-icons/plus.svg)**{{ ui-key.yacloud.component.console-dashboard.button_action-create-folder }}**.
   1. Введите имя каталога, например `data-folder`.
   1. Отключите опцию **{{ ui-key.yacloud.iam.cloud.folders-create.field_default-net }}**, чтобы создать сеть и подсети вручную.
   1. Нажмите **{{ ui-key.yacloud.iam.cloud.folders-create.button_create }}**.

{% endlist %}

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

### Создайте сеть {#create-network}

Создайте сеть, в которой будет работать кластер {{ SPRK }}.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог `data-folder`, [созданный ранее](#create-folder).
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. В правом верхнем углу нажмите **{{ ui-key.yacloud.vpc.networks.button_create }}**.
  1. В поле **{{ ui-key.yacloud.vpc.networks.create.field_name }}** укажите имя сети `data-network`.

      Вместе с ней автоматически будут созданы три подсети в разных зонах доступности.

  1. Нажмите **{{ ui-key.yacloud.vpc.networks.button_create }}**.

{% endlist %}

### Создайте и настройте NAT-шлюз для доступа в интернет {#create-nat}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В каталоге `data-folder` выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
   1. На панели слева выберите ![image](../../_assets/console-icons/arrows-opposite-to-dots.svg) **{{ ui-key.yacloud.vpc.switch_gateways }}**.
   1. Нажмите **{{ ui-key.yacloud.common.create }}** и задайте настройки шлюза:
      1. Введите имя шлюза, например `nat-for-cluster`.
      1. Выберите **{{ ui-key.yacloud.vpc.gateways.field_type }}** шлюза — **{{ ui-key.yacloud.vpc.gateways.value_gateway-type-egress-nat }}**.
      1. Нажмите **{{ ui-key.yacloud.common.save }}**.
   1. На панели слева выберите ![image](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.vpc.network.switch_route-table }}**.
   1. Нажмите **{{ ui-key.yacloud.common.create }}** и введите параметры таблицы маршрутизации:
      1. Введите имя, например `route-table`.
      1. Выберите сеть `data-network`.
      1. Нажмите **{{ ui-key.yacloud.vpc.route-table-form.label_add-static-route }}**.
      1. В открывшемся окне в поле **{{ ui-key.yacloud.vpc.add-static-route.field_next-hop-address }}** выберите **{{ ui-key.yacloud.vpc.add-static-route.value_gateway }}**.
      1. В поле **{{ ui-key.yacloud.vpc.add-static-route.value_gateway }}** выберите созданный NAT-шлюз. Префикс назначения заполнится автоматически.
      1. Нажмите **{{ ui-key.yacloud.vpc.add-static-route.button_add }}**.
      1. Нажмите **{{ ui-key.yacloud.vpc.route-table.create.button_create }}**.
   1. Привяжите таблицу маршрутизации к одной из подсетей, чтобы направить трафик из нее через NAT-шлюз:
      1. На панели слева выберите ![image](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.vpc.switch_networks }}**.
      1. В строке нужной подсети нажмите ![image](../../_assets/console-icons/ellipsis.svg).
      1. В открывшемся меню выберите пункт **{{ ui-key.yacloud.vpc.subnetworks.button_action-add-route-table }}**.
      1. В открывшемся окне выберите созданную таблицу в списке.
      1. Нажмите **{{ ui-key.yacloud.vpc.subnet.add-route-table.button_add }}**.

{% endlist %}

### Создайте сервисный аккаунт для кластера {{ msp-full-name }} {#create-sa}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. Перейдите в каталог `data-folder`.
   1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
   1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
   1. Введите имя [сервисного аккаунта](../../iam/concepts/users/service-accounts.md), например `sa-for-spark`.
   1. Нажмите **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** и назначьте сервисному аккаунту [роли](../../iam/concepts/access-control/roles.md):
      * `managed-spark.user` — для использования кластеров {{ SPRK }}.
      * `dataproc.agent` — для получения информации о заданиях.
      * `dataproc.user` — для запуска заданий в кластерах {{ SPRK }}.
      * `vpc.user` — для работы с сетью кластера {{ SPRK }}.
      * `iam.serviceAccounts.user` — для создания ресурсов в каталоге от имени сервисного аккаунта.

   1. Нажмите **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

{% endlist %}

## Настройте {{ ml-platform-name }} {#project}

Чтобы работать с кластерами {{ SPRK }} в {{ ml-platform-name }}, создайте и настройте проект.

### Создайте проект {#create-project}

1. Откройте [главную страницу]({{ link-datasphere-main }}) {{ ml-platform-name }}.
1. На панели слева выберите ![image](../../_assets/console-icons/circles-concentric.svg) **{{ ui-key.yc-ui-datasphere.common.spaces }}**.
1. Выберите сообщество, в котором вы хотите создать проект.
1. На странице сообщества нажмите кнопку ![image](../../_assets/console-icons/folder-plus.svg) **{{ ui-key.yc-ui-datasphere.projects.create-project }}**.
1. В открывшемся окне укажите имя и (опционально) описание проекта.
1. Нажмите кнопку **{{ ui-key.yc-ui-datasphere.common.create }}**.

### Измените настройки проекта {#change-settings}

1. Перейдите на вкладку **{{ ui-key.yc-ui-datasphere.project-page.tab.settings }}**.
1. В блоке **{{ ui-key.yc-ui-datasphere.edit-project-page.advanced-settings }}** нажмите кнопку ![pencil](../../_assets/console-icons/pencil-to-line.svg) **{{ ui-key.yc-ui-datasphere.common.edit }}**.
1. Укажите параметры:
   * **{{ ui-key.yc-ui-datasphere.project-page.settings.default-folder }}** — `data-folder`.
   * **{{ ui-key.yc-ui-datasphere.project-page.settings.service-account }}** — `sa-for-spark`.
   * **{{ ui-key.yc-ui-datasphere.project-page.settings.subnet }}** — подсеть `data-network-{{ region-id }}-a`.

     {% note info %}
     
     Если вы указали подсеть в настройках проекта, подготовка ВМ при первом запуске вычислений может занять больше времени.
     
     {% endnote %}

   * [Группы безопасности](../../vpc/concepts/security-groups.md), если они используются в вашей организации.

1. Нажмите **{{ ui-key.yc-ui-datasphere.common.save }}**.

### Измените настройки сообщества {#change-settings-community}

Чтобы настроить подключение к кластерам {{ SPRK }}:

1. Выберите сообщество, в котором вы [создали проект](#create-project).
1. Перейдите на вкладку **{{ ui-key.yc-ui-datasphere.common.settings-key-value }}**.
1. В блоке **{{ ui-key.yc-ui-datasphere.spaces-page.ssa.settings.title }}** нажмите **{{ ui-key.yc-ui-datasphere.spaces-page.ssa.add-service-account.button }}**.
1. В открывшемся окне выберите [созданный ранее](#create-sa) сервисный аккаунт и нажмите **{{ ui-key.yc-ui-datasphere.common.add }}**.
1. В блоке **{{ ui-key.yc-ui-datasphere.spaces-page.data-processing-sa.title }}** нажмите **{{ ui-key.yc-ui-datasphere.spaces-page.ssa.add-service-account.button }}** и выберите созданный ранее сервисный аккаунт.

## Создайте кластер {{ msp-name }} и коннектор Spark {#create-spark}

1. [Создайте кластер {{ msp-name }}](../../managed-spark/operations/cluster-create.md) любой подходящей конфигурации с параметрами:

    * **Сервисный аккаунт** — `sa-for-spark`.
    * **Сеть** — `data-network`.
    * **Подсеть** — `data-network-{{ region-id }}-a`.

1. Перейдите в [рабочее пространство {{ ml-platform-name }}]({{ link-datasphere-main }}).
1. На панели слева выберите ![image](../../_assets/console-icons/circles-concentric.svg) **{{ ui-key.yc-ui-datasphere.common.spaces }}**.
1. Откройте сообщество, в котором вы [создали проект](#create-project), и выберите нужный проект.
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** нажмите ![spark-connector](../../_assets/console-icons/route.svg) **{{ ui-key.yc-ui-datasphere.common.spark-connector }}**.
1. Нажмите **{{ ui-key.yc-ui-datasphere.open-project.create-connector }}**.
1. В поле **{{ ui-key.yc-ui-datasphere.common.name }}** задайте имя коннектора. Формат имени:

   * Длина — от 3 до 63 символов.
   * Может содержать строчные и заглавные буквы латинского и русского алфавита, цифры, дефисы, подчеркивания и пробелы.
   * Первый символ должен быть буквой. Последний символ не может быть дефисом, подчеркиванием или пробелом.

1. В блоке **{{ ui-key.yc-ui-datasphere.spark-connector.dataproc-cluster }}**:

   1. Нажмите на плитку **{{ ui-key.yc-ui-datasphere.spark-connector.select-cluster.title }}**.
   1. Выберите из списка созданный ранее кластер {{ msp-name }}.

1. (Опционально) Чтобы использовать бакет {{ objstorage-name }} в вычислениях, в блоке **{{ ui-key.yc-ui-datasphere.spark-connector.s3-settings }}** укажите идентификатор [статического ключа доступа](../../iam/operations/authentication/manage-access-keys.md#create-access-key) и [секрет](../concepts/secrets.md), в котором хранится секретная часть статического ключа.
1. В блоке **{{ ui-key.yc-ui-datasphere.spark-connector.spark-settings }}** укажите параметры задания SparkConnect:

    * Чтобы использовать стандартные настройки кластера {{ SPRK }} при выполнении вычислений, выберите опцию **{{ ui-key.yc-ui-datasphere.spark-connector.use-default-settings.title }}**.
    * Чтобы вручную дополнить или изменить параметры задания, укажите один или несколько параметров *{{ ui-key.yc-ui-datasphere.common.placeholder.key }}* и *{{ ui-key.yc-ui-datasphere.common.placeholder.value }}*.

1. Нажмите **{{ ui-key.yc-ui-datasphere.common.create }}**. Откроется страница с информацией о созданном коннекторе.

## Запустите вычисления {#run-code}

1. Откройте проект {{ ml-platform-name }}:
   
   1. Выберите нужный проект в своем сообществе или на [главной странице]({{ link-datasphere-main }}) {{ ml-platform-name }} во вкладке **{{ ui-key.yc-ui-datasphere.main-page.recent-projects }}**.
   1. Нажмите кнопку **{{ ui-key.yc-ui-datasphere.project-page.project-card.go-to-jupyter }}** и дождитесь окончания загрузки.
   1. Откройте вкладку с ноутбуком.
1. В ячейку вставьте код для вычисления, например:

   ```python
   df = spark.createDataFrame([(1, "Sarah"), (2, "Maria")]).toDF(*["id", "name"])
   df.show()
   ```

1. Выберите в меню **Run** → **Run Selected Cells** или используйте сочетание клавиш **Shift** + **Enter**.
1. В открывшемся окне **{{ ui-key.yc-ui-datasphere.open-project.select-configuration }}** перейдите на вкладку **{{ ui-key.yc-ui-datasphere.open-project.with-dataproc-cluster }}**.
1. Выберите необходимую конфигурацию и коннектор.
1. Нажмите **{{ ui-key.yc-ui-datasphere.common.select }}**.

   В ноутбуке через переменную `spark` станет доступна [локальная сессия PySpark](https://spark.apache.org/docs/3.5.6/api/python/reference/pyspark.sql/api/pyspark.sql.SparkSession.html). В кластере {{ SPRK }} будет создано и запущено [задание](../../managed-spark/concepts/index.md#job) SparkConnect для выполнения кода ячеек ноутбука.

Чтобы завершить задание в кластере {{ SPRK }}, остановите ВМ ноутбука.

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

1. [Кластер {{ msp-name }}](../../managed-spark/operations/cluster-delete.md).
1. [NAT-шлюз](../../vpc/operations/delete-nat-gateway.md#delete-nat-gateway).

{% endlist %}