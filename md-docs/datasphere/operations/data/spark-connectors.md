# Работа с коннекторами Spark

В {{ ml-platform-name }} вы можете использовать [коннекторы Spark](../../concepts/spark-connector.md), чтобы работать с уже существующими или автоматически создаваемыми кластерами [{{ dataproc-full-name }}](../../../data-proc/index.md).

## Перед началом работы {#before-begin}

Для работы с кластерами {{ dataproc-name }}:

1. [Укажите в настройках проекта](../projects/update.md) следующие параметры:

   * [Каталог по умолчанию](../../../resource-manager/concepts/resources-hierarchy.md#folder) для интеграции с другими сервисами {{ yandex-cloud }}. В нем будет развернут кластер {{ dataproc-name }} в рамках текущих [квот](../../../data-proc/concepts/limits.md) облака, а стоимость использования кластера будет списана с платежного аккаунта облака.
   * [Сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) с [ролью](../../../iam/concepts/access-control/roles.md) `vpc.user`, от имени которого {{ ml-platform-name }} будет работать с сетью кластера {{ dataproc-name }}.
   * [Подсеть](../../../vpc/concepts/network.md#subnet) для связи {{ ml-platform-name }} с кластером {{ dataproc-name }}. Указанная подсеть должна находиться в [зоне доступности](../../../overview/concepts/geo-scope.md), в которой создано сообщество. Кластеру {{ dataproc-name }} необходим доступ в интернет, поэтому в подсети должен быть [настроен NAT-шлюз](../../../vpc/operations/create-nat-gateway.md). После указания подсети время выделения вычислительных ресурсов может быть увеличено.

1. Создайте [сервисного агента](../../../iam/concepts/service-control.md#service-agent):

   1. Чтобы разрешить сервисному агенту работать в {{ ml-platform-name }}, попросите администратора или владельца вашего облака выполнить команду в {{ yandex-cloud }} CLI:
   
      ```bash
      yc iam service-control enable datasphere --cloud-id <идентификатор_облака>
      ```
   
      Где `--cloud-id` — [идентификатор облака](../../../resource-manager/operations/cloud/get-id.md), с которым вы будете работать в сообществе {{ ml-platform-name }}.

   1. Создайте сервисный аккаунт с ролями:

      * `dataproc.agent` — для использования кластеров {{ dataproc-name }}.
      * `dataproc.admin`— для создания кластеров из шаблонов {{ dataproc-name }}.
      * `vpc.user` — для работы с сетью кластера {{ dataproc-name }}.
      * `iam.serviceAccounts.user` — для создания ресурсов в каталоге от имени сервисного аккаунта.

   1. В настройках сообщества в блоке **{{ ui-key.yc-ui-datasphere.spaces-page.data-processing-sa.title }}** нажмите **{{ ui-key.yc-ui-datasphere.spaces-page.ssa.add-service-account.button }}** и выберите созданный сервисный аккаунт.
   
{% note warning %}

Постоянный кластер {{ dataproc-name }} должен иметь настройку `livy:livy.spark.deploy-mode : client`.

{% endnote %}

## Создать коннектор Spark {#create}

1. Выберите нужный проект в своем сообществе или на [главной странице]({{ link-datasphere-main }}) {{ ml-platform-name }} во вкладке **{{ ui-key.yc-ui-datasphere.main-page.recent-projects }}**.
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** нажмите ![spark-connector](../../../_assets/console-icons/route.svg)**{{ ui-key.yc-ui-datasphere.common.spark-connector }}**.
1. Нажмите **{{ ui-key.yc-ui-datasphere.open-project.create-connector }}**.
1. В поле **{{ ui-key.yc-ui-datasphere.common.name }}** задайте имя коннектора. Формат имени:

   * Длина — от 3 до 63 символов.
   * Может содержать строчные и заглавные буквы латинского и русского алфавита, цифры, дефисы, подчеркивания и пробелы.
   * Первый символ должен быть буквой. Последний символ не может быть дефисом, подчеркиванием или пробелом.

1. В блоке **{{ ui-key.yc-ui-datasphere.spark-connector.dataproc-cluster }}** выберите, с каким кластером вы планируете работать:

   * **{{ ui-key.yc-ui-datasphere.spark-connector.select-cluster.title }}** — выберите существующий кластер {{ dataproc-name }} или нажмите **{{ ui-key.yc-ui-datasphere.spark-connector.create-cluster-in-dataproc }}**, чтобы перейти в {{ dataproc-name }} и создать новый. Постоянный кластер {{ dataproc-name }} должен иметь настройку `livy:livy.spark.deploy-mode : client`.
   * **{{ ui-key.yc-ui-datasphere.spark-connector.create-temporary-cluster.title }}** — выберите, чтобы создать временный кластер {{ dataproc-name }}. Временный кластер будет создан при первом запуске вычислений в ноутбуке проекта.

1. (Опционально) В блоке **{{ ui-key.yc-ui-datasphere.spark-connector.s3-settings }}** укажите идентификатор [статического ключа доступа](../../../iam/operations/authentication/manage-access-keys.md#create-access-key) и [секрет](../../concepts/secrets.md), в котором хранится секретная часть статического ключа для [коннектора S3](../../concepts/s3-connector.md).

   **{{ ui-key.yc-ui-datasphere.spark-connector.s3-settings }}** позволяет указать данные для подключения к бакету S3. Это рекомендуется при работе с бакетами {{ objstorage-name }} в любых кластерах, и крайне желательно для кластеров {{ dataproc-name }} без включенной опции HDFS.

1. В блоке **{{ ui-key.yc-ui-datasphere.spark-connector.spark-settings }}** выберите опцию **{{ ui-key.yc-ui-datasphere.spark-connector.use-default-settings.title }}**, чтобы использовать стандартные настройки кластера {{ dataproc-name }} или укажите параметры *{{ ui-key.yc-ui-datasphere.common.placeholder.key }}* и *{{ ui-key.yc-ui-datasphere.common.placeholder.value }}*, чтобы вручную дополнить или изменить параметры кластера {{ dataproc-name }}.

   {% note tip %}

   Для кластеров {{ dataproc-name }} без включенной опции HDFS задайте дополнительный параметр `spark.hadoop.fs.s3a.fast.upload.buffer` = `bytebuffer`.

   Для собственных кластеров с типом подключения Spark Connect задайте дополнительный параметр `dataproc:spark-connect` = `enabled`.

   {% endnote %}

1. Нажмите **{{ ui-key.yc-ui-datasphere.common.create }}**. Откроется страница с информацией о созданном коннекторе.

## Использовать кластер {{ dataproc-name }} в проекте {#usage}

{% note warning %}

Если вы работаете с кластерами {{ dataproc-name }} с помощью коннектора Spark, вместо стандартного окружения проекта в ноутбуке будет использоваться специальное окружение для работы с кластером.

{% endnote %}

Откройте проект {{ ml-platform-name }}:

1. Выберите нужный проект в своем сообществе или на [главной странице]({{ link-datasphere-main }}) {{ ml-platform-name }} во вкладке **{{ ui-key.yc-ui-datasphere.main-page.recent-projects }}**.
1. Нажмите кнопку **{{ ui-key.yc-ui-datasphere.project-page.project-card.go-to-jupyter }}** и дождитесь окончания загрузки.
1. Откройте вкладку с ноутбуком.

1. Запустите любую ячейку, выбрав в меню **Run** ⟶ **Run Selected Cells** или использовав сочетание клавиш **Shift** + **Enter**.
1. В открывшемся окне **{{ ui-key.yc-ui-datasphere.open-project.select-configuration }}** перейдите на вкладку **{{ ui-key.yc-ui-datasphere.open-project.with-dataproc-cluster }}**.
1. Выберите необходимую конфигурацию и коннектор.
1. Нажмите **{{ ui-key.yc-ui-datasphere.common.select }}**.

Чтобы выключить временный кластер {{ dataproc-name }}, созданный с помощью коннектора Spark, остановите ВМ ноутбука.

Чтобы перестать платить за постоянный кластер {{ dataproc-name }}, [удалите его](../../../data-proc/operations/cluster-delete.md) в консоли управления.

## Изменить коннектор Spark {#change}

1. Выберите нужный проект в своем сообществе или на [главной странице]({{ link-datasphere-main }}) {{ ml-platform-name }} во вкладке **{{ ui-key.yc-ui-datasphere.main-page.recent-projects }}**.
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** нажмите ![spark-connector](../../../_assets/console-icons/route.svg) **{{ ui-key.yc-ui-datasphere.common.spark-connector }}**.
1. В списке коннекторов Spark выберите тот, который вы хотите изменить. Нажмите ![pencil](../../../_assets/console-icons/pencil-to-line.svg) **{{ ui-key.yc-ui-datasphere.common.edit }}**.
1. Измените коннектор Spark: отредактируйте имя или параметры.
1. Нажмите **{{ ui-key.yc-ui-datasphere.common.save }}**.

## Поделиться коннектором Spark {#share}

{% note info %}

Делиться ресурсами можно только в рамках одной организации между сообществами, созданными в одной [зоне доступности](../../../overview/concepts/geo-scope.md).

{% endnote %}

Чтобы поделиться коннектором Spark в сообществе, понадобятся роли `Editor` в проекте и `Developer` в сообществе. Подробнее о ролях, действующих в {{ ml-platform-name }}, см. в разделе [{#T}](../../security/index.md).

1. Выберите нужный проект в своем сообществе или на [главной странице]({{ link-datasphere-main }}) {{ ml-platform-name }} во вкладке **{{ ui-key.yc-ui-datasphere.main-page.recent-projects }}**.
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** нажмите ![spark-connector](../../../_assets/console-icons/route.svg) **{{ ui-key.yc-ui-datasphere.common.spark-connector }}**.
1. Выберите нужный коннектор Spark в списке.
1. Перейдите на вкладку **{{ ui-key.yc-ui-datasphere.common.access }}**.
1. Включите опцию видимости напротив названия сообщества, с которым нужно поделиться коннектором Spark.

Чтобы коннектор Spark стал доступен для работы в другом проекте, администратор проекта должен [добавить](../projects/use-shared-resource.md) его на вкладке **{{ ui-key.yc-ui-datasphere.common.shared-with-project-resources }}**.

## Удалить коннектор Spark {#delete}

Вы можете удалить только коннектор, который недоступен в сообществе.

1. Выберите нужный проект в своем сообществе или на [главной странице]({{ link-datasphere-main }}) {{ ml-platform-name }} во вкладке **{{ ui-key.yc-ui-datasphere.main-page.recent-projects }}**.
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** нажмите ![spark-connector](../../../_assets/console-icons/route.svg) **{{ ui-key.yc-ui-datasphere.common.spark-connector }}**.
1. В списке коннекторов Spark выберите тот, который хотите удалить. Нажмите **{{ ui-key.yc-ui-datasphere.common.delete }}**.
1. Нажмите **{{ ui-key.yc-ui-datasphere.common.submit }}**.

Отобразится сообщение о том, что коннектор удален.

{% note warning %}

Фактически [удаление ресурсов](../../../overview/concepts/data-deletion.md) может занимать до 72 часов.

{% endnote %}