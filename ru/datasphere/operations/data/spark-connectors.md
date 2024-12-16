# Работа с коннекторами Spark

В {{ ml-platform-name }} вы можете использовать [коннекторы Spark](../../concepts/spark-connector.md), чтобы работать с уже существующими или автоматически создаваемыми кластерами [{{ dataproc-full-name }}](../../../data-proc/).

## Перед началом работы {#before-begin}

{% include [settings-for-dataproc](../../../_includes/datasphere/settings-for-data-processing.md) %}

## Создать коннектор Spark {#create}

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** нажмите ![spark-connector](../../../_assets/console-icons/route.svg)**{{ ui-key.yc-ui-datasphere.common.spark-connector }}**.
1. Нажмите **{{ ui-key.yc-ui-datasphere.open-project.create-connector }}**.
1. В поле **{{ ui-key.yc-ui-datasphere.common.name }}** задайте имя коннектора. Формат имени:

   {% include [name-format](../../../_includes/name-format-2.md) %}

1. В блоке **{{ ui-key.yc-ui-datasphere.spark-connector.dataproc-cluster }}** выберите, с каким кластером вы планируете работать:

   * **{{ ui-key.yc-ui-datasphere.spark-connector.select-cluster.title }}** — выберите существующий кластер {{ dataproc-name }} или нажмите **{{ ui-key.yc-ui-datasphere.spark-connector.create-cluster-in-dataproc }}**, чтобы перейти в {{ dataproc-name }} и создать новый. Постоянный кластер {{ dataproc-name }} должен иметь настройку `livy:livy.spark.deploy-mode : client`.
   * **{{ ui-key.yc-ui-datasphere.spark-connector.create-temporary-cluster.title }}** — выберите, чтобы создать временный кластер {{ dataproc-name }}. Временный кластер будет создан при первом запуске вычислений в ноутбуке проекта.

1. (Опционально) В блоке **{{ ui-key.yc-ui-datasphere.spark-connector.s3-settings }}** укажите идентификатор [статического ключа доступа](../../../iam/operations/sa/create-access-key.md) и [секрет](../../concepts/secrets.md), в котором хранится секретная часть статического ключа для [коннектора S3](../../concepts/s3-connector.md).

   **{{ ui-key.yc-ui-datasphere.spark-connector.s3-settings }}** позволяет указать данные для подключения к бакету S3. Это рекомендуется при работе с бакетами {{ objstorage-name }} в любых кластерах, и крайне желательно для кластеров {{ dataproc-name }} без включенной опции HDFS.

1. В блоке **{{ ui-key.yc-ui-datasphere.spark-connector.spark-settings }}** выберите опцию **{{ ui-key.yc-ui-datasphere.spark-connector.use-default-settings.title }}**, чтобы использовать стандартные настройки кластера {{ dataproc-name }} или укажите параметры *{{ ui-key.yc-ui-datasphere.common.placeholder.key }}* и *{{ ui-key.yc-ui-datasphere.common.placeholder.value }}*, чтобы вручную дополнить или изменить параметры кластера {{ dataproc-name }}.

   {% note tip %}

   Для кластеров {{ dataproc-name }} без включенной опции HDFS задайте дополнительный параметр `spark.hadoop.fs.s3a.fast.upload.buffer` = `bytebuffer`.

   Для собственных кластеров с типом подключения Spark Connect задайте дополнительный параметр `dataproc:spark-connect` = `enabled`.

   {% endnote %}

1. Нажмите **{{ ui-key.yc-ui-datasphere.common.create }}**. Откроется страница с информацией о созданном коннекторе.

## Использовать кластер {{ dataproc-name }} в проекте {#usage}

{% include [dataproc-spark-connector](../../../_includes/datasphere/data-processing-spark-connector.md) %}

{% include [ui-before-begin](../../../_includes/datasphere/ui-before-begin.md) %}

1. Запустите любую ячейку, выбрав в меню **Run** ⟶ **Run Selected Cells** или использовав сочетание клавиш **Shift** + **Enter**.
1. В открывшемся окне **{{ ui-key.yc-ui-datasphere.open-project.select-configuration }}** перейдите на вкладку **{{ ui-key.yc-ui-datasphere.open-project.with-dataproc-cluster }}**.
1. Выберите необходимую конфигурацию и коннектор.
1. Нажмите **{{ ui-key.yc-ui-datasphere.common.select }}**.

Чтобы выключить временный кластер {{ dataproc-name }}, созданный с помощью коннектора Spark, остановите ВМ ноутбука.

Чтобы перестать платить за постоянный кластер {{ dataproc-name }}, [удалите его](../../../data-proc/operations/cluster-delete.md) в консоли управления.

## Изменить коннектор Spark {#change}

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** нажмите ![spark-connector](../../../_assets/console-icons/route.svg) **{{ ui-key.yc-ui-datasphere.common.spark-connector }}**.
1. В списке коннекторов Spark выберите тот, который вы хотите изменить. Нажмите ![pencil](../../../_assets/console-icons/pencil-to-line.svg) **{{ ui-key.yc-ui-datasphere.common.edit }}**.
1. Измените коннектор Spark: отредактируйте имя или параметры.
1. Нажмите **{{ ui-key.yc-ui-datasphere.common.save }}**.

## Поделиться коннектором Spark {#share}

{% include [zones](../../../_includes/datasphere/zones.md) %}

Чтобы поделиться коннектором Spark в сообществе, понадобятся роли `Editor` в проекте и `Developer` в сообществе. Подробнее о ролях, действующих в {{ ml-platform-name }}, см. в разделе [{#T}](../../security/index.md).

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** нажмите ![spark-connector](../../../_assets/console-icons/route.svg) **{{ ui-key.yc-ui-datasphere.common.spark-connector }}**.
1. Выберите нужный коннектор Spark в списке.
1. Перейдите на вкладку **{{ ui-key.yc-ui-datasphere.common.access }}**.
1. Включите опцию видимости напротив названия сообщества, с которым нужно поделиться коннектором Spark.

Чтобы коннектор Spark стал доступен для работы в другом проекте, администратор проекта должен [добавить](../projects/use-shared-resource.md) его на вкладке **{{ ui-key.yc-ui-datasphere.common.shared-with-project-resources }}**.

## Удалить коннектор Spark {#delete}

Вы можете удалить только коннектор, который недоступен в сообществе.

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** нажмите ![spark-connector](../../../_assets/console-icons/route.svg) **{{ ui-key.yc-ui-datasphere.common.spark-connector }}**.
1. В списке коннекторов Spark выберите тот, который хотите удалить. Нажмите **{{ ui-key.yc-ui-datasphere.common.delete }}**.
1. Нажмите **{{ ui-key.yc-ui-datasphere.common.submit }}**.

Отобразится сообщение о том, что коннектор удален.

{% include [deletion-time](../../../_includes/datasphere/deletion-time.md) %}
