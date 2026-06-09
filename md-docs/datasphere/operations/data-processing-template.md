# Работа с шаблонами {{ dataproc-name }}

[Шаблоны {{ dataproc-name }}](../concepts/data-processing-template.md) позволяют заранее подготовить конфигурацию кластера для проекта и упростить развертывание временных кластеров. Список шаблонов доступен на странице проекта в блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** → ![data-proc-template](../../_assets/data-processing/data-processing.svg) **{{ ui-key.yc-ui-datasphere.resources.dataProc }}**, вкладка **{{ ui-key.yc-ui-datasphere.common.shared-with-project-resources }}**.

Для работы с кластерами {{ dataproc-name }}:

1. [Укажите в настройках проекта](projects/update.md) следующие параметры:

   * [Каталог по умолчанию](../../resource-manager/concepts/resources-hierarchy.md#folder) для интеграции с другими сервисами {{ yandex-cloud }}. В нем будет развернут кластер {{ dataproc-name }} в рамках текущих [квот](../../data-proc/concepts/limits.md) облака, а стоимость использования кластера будет списана с платежного аккаунта облака.
   * [Сервисный аккаунт](../../iam/concepts/users/service-accounts.md) с [ролью](../../iam/concepts/access-control/roles.md) `vpc.user`, от имени которого {{ ml-platform-name }} будет работать с сетью кластера {{ dataproc-name }}.
   * [Подсеть](../../vpc/concepts/network.md#subnet) для связи {{ ml-platform-name }} с кластером {{ dataproc-name }}. Указанная подсеть должна находиться в [зоне доступности](../../overview/concepts/geo-scope.md), в которой создано сообщество. Кластеру {{ dataproc-name }} необходим доступ в интернет, поэтому в подсети должен быть [настроен NAT-шлюз](../../vpc/operations/create-nat-gateway.md). После указания подсети время выделения вычислительных ресурсов может быть увеличено.

1. Создайте [сервисного агента](../../iam/concepts/service-control.md#service-agent):

   1. Чтобы разрешить сервисному агенту работать в {{ ml-platform-name }}, попросите администратора или владельца вашего облака выполнить команду в {{ yandex-cloud }} CLI:
   
      ```bash
      yc iam service-control enable datasphere --cloud-id <идентификатор_облака>
      ```
   
      Где `--cloud-id` — [идентификатор облака](../../resource-manager/operations/cloud/get-id.md), с которым вы будете работать в сообществе {{ ml-platform-name }}.

   1. Создайте сервисный аккаунт с ролями:

      * `dataproc.agent` — для использования кластеров {{ dataproc-name }}.
      * `dataproc.admin`— для создания кластеров из шаблонов {{ dataproc-name }}.
      * `vpc.user` — для работы с сетью кластера {{ dataproc-name }}.
      * `iam.serviceAccounts.user` — для создания ресурсов в каталоге от имени сервисного аккаунта.

   1. В настройках сообщества в блоке **{{ ui-key.yc-ui-datasphere.spaces-page.data-processing-sa.title }}** нажмите **{{ ui-key.yc-ui-datasphere.spaces-page.ssa.add-service-account.button }}** и выберите созданный сервисный аккаунт.
   
{% note warning %}

Постоянный кластер {{ dataproc-name }} должен иметь настройку `livy:livy.spark.deploy-mode : client`.

{% endnote %}

## Создать шаблон {{ dataproc-name }} {#create}

1. Выберите нужный проект в своем сообществе или на [главной странице]({{ link-datasphere-main }}) {{ ml-platform-name }} во вкладке **{{ ui-key.yc-ui-datasphere.main-page.recent-projects }}**.
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** нажмите ![data-proc-template](../../_assets/data-processing/data-processing.svg) **{{ ui-key.yc-ui-datasphere.resources.dataProc }}**.
1. Нажмите **{{ ui-key.yc-ui-datasphere.data-proc.create-template }}**.
1. В поле **{{ ui-key.yc-ui-datasphere.data-proc.template-name }}** задайте имя. Требования к имени:

    * длина — от 3 до 63 символов;
    * может содержать строчные буквы латинского алфавита, цифры и дефисы;
    * первый символ — буква, последний — не дефис.

1. Нажмите **{{ ui-key.yc-ui-datasphere.common.create }}**. Откроется страница с информацией о созданном шаблоне.

## Активировать шаблон {{ dataproc-name }} {#activate}

1. Выберите нужный проект в своем сообществе или на [главной странице]({{ link-datasphere-main }}) {{ ml-platform-name }} во вкладке **{{ ui-key.yc-ui-datasphere.main-page.recent-projects }}**.
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** нажмите ![data-proc-template](../../_assets/data-processing/data-processing.svg) **{{ ui-key.yc-ui-datasphere.resources.dataProc }}**.
1. Справа от нужного шаблона нажмите ![options](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yc-ui-datasphere.common.activate }}**.

Кластер на основе активированного шаблона {{ dataproc-name }} будет создан при запуске проекта в IDE.

## Поделиться шаблоном {{ dataproc-name }} {#share}

1. Выберите нужный проект в своем сообществе или на [главной странице]({{ link-datasphere-main }}) {{ ml-platform-name }} во вкладке **{{ ui-key.yc-ui-datasphere.main-page.recent-projects }}**.
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** нажмите ![data-proc-template](../../_assets/data-processing/data-processing.svg) **{{ ui-key.yc-ui-datasphere.resources.dataProc }}**.
1. Выберите нужный шаблон в списке.
1. Перейдите на вкладку **{{ ui-key.yc-ui-datasphere.common.access }}**.
1. Включите опцию видимости напротив названия сообщества, в котором нужно поделиться шаблоном.

Чтобы шаблон стал доступен для работы в другом проекте, администратор проекта должен [добавить](projects/use-shared-resource.md) его на вкладке **{{ ui-key.yc-ui-datasphere.common.shared-with-project-resources }}**.

## Изменить шаблон {#edit}

Вы можете изменить только имя уже созданного шаблона. Чтобы изменить конфигурацию, [создайте](#create) шаблон заново.

1. Выберите нужный проект в своем сообществе или на [главной странице]({{ link-datasphere-main }}) {{ ml-platform-name }} во вкладке **{{ ui-key.yc-ui-datasphere.main-page.recent-projects }}**.
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** нажмите ![data-proc-template](../../_assets/data-processing/data-processing.svg) **{{ ui-key.yc-ui-datasphere.resources.dataProc }}**.
1. Выберите нужный шаблон в списке, нажмите ![options](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yc-ui-datasphere.common.edit }}**.
1. Измените имя и нажмите **{{ ui-key.yc-ui-datasphere.common.save }}**.

## Удалить шаблон {{ dataproc-name }} {#delete}

1. Выберите нужный проект в своем сообществе или на [главной странице]({{ link-datasphere-main }}) {{ ml-platform-name }} во вкладке **{{ ui-key.yc-ui-datasphere.main-page.recent-projects }}**.
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** нажмите ![data-proc-template](../../_assets/datasphere/data-processing-template.svg) **{{ ui-key.yc-ui-datasphere.resources.dataProc }}**.
1. Выберите в списке шаблон, который нужно удалить.
1. Нажмите ![options](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yc-ui-datasphere.common.delete }}**.
1. Нажмите **{{ ui-key.yc-ui-datasphere.common.submit }}**.

{% note warning %}

Фактически [удаление ресурсов](../../overview/concepts/data-deletion.md) может занимать до 72 часов.

{% endnote %}