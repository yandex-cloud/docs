[Документация Yandex Cloud](../../index.md) > [Yandex DataSphere](../index.md) > [Пошаговые инструкции](index.md) > Работа с ресурсами > Работа с шаблонами Yandex Data Processing

# Работа с шаблонами Yandex Data Processing

[Шаблоны Yandex Data Processing](../concepts/data-processing-template.md) позволяют заранее подготовить конфигурацию кластера для проекта и упростить развертывание временных кластеров. Список шаблонов доступен на странице проекта в блоке **Ресурсы проекта** → ![data-proc-template](../../_assets/data-processing/data-processing.svg) **Yandex Data&nbsp;Processing**, вкладка **Доступные**.

Для работы с кластерами Yandex Data Processing:

1. [Укажите в настройках проекта](projects/update.md) следующие параметры:

   * [Каталог по умолчанию](../../resource-manager/concepts/resources-hierarchy.md#folder) для интеграции с другими сервисами Yandex Cloud. В нем будет развернут кластер Yandex Data Processing в рамках текущих [квот](../../data-proc/concepts/limits.md) облака, а стоимость использования кластера будет списана с платежного аккаунта облака.
   * [Сервисный аккаунт](../../iam/concepts/users/service-accounts.md) с [ролью](../../iam/concepts/access-control/roles.md) `vpc.user`, от имени которого DataSphere будет работать с сетью кластера Yandex Data Processing.
   * [Подсеть](../../vpc/concepts/network.md#subnet) для связи DataSphere с кластером Yandex Data Processing. Указанная подсеть должна находиться в [зоне доступности](../../overview/concepts/geo-scope.md), в которой создано сообщество. Кластеру Yandex Data Processing необходим доступ в интернет, поэтому в подсети должен быть [настроен NAT-шлюз](../../vpc/operations/create-nat-gateway.md). После указания подсети время выделения вычислительных ресурсов может быть увеличено.

1. Создайте [сервисного агента](../../iam/concepts/service-control.md#service-agent):

   1. Чтобы разрешить сервисному агенту работать в DataSphere, попросите администратора или владельца вашего облака выполнить команду в Yandex Cloud CLI:
   
      ```bash
      yc iam service-control enable datasphere --cloud-id <идентификатор_облака>
      ```
   
      Где `--cloud-id` — [идентификатор облака](../../resource-manager/operations/cloud/get-id.md), с которым вы будете работать в сообществе DataSphere.

   1. Создайте сервисный аккаунт с ролями:

      * `dataproc.agent` — для использования кластеров Yandex Data Processing.
      * `dataproc.admin`— для создания кластеров из шаблонов Yandex Data Processing.
      * `vpc.user` — для работы с сетью кластера Yandex Data Processing.
      * `iam.serviceAccounts.user` — для создания ресурсов в каталоге от имени сервисного аккаунта.

   1. В настройках сообщества в блоке **Кластеры Spark** нажмите **Добавить сервисный аккаунт** и выберите созданный сервисный аккаунт.
   
{% note warning %}

Постоянный кластер Yandex Data Processing должен иметь настройку `livy:livy.spark.deploy-mode : client`.

{% endnote %}

## Создать шаблон Yandex Data Processing {#create}

1. Выберите нужный проект в своем сообществе или на [главной странице](https://datasphere.yandex.cloud) DataSphere во вкладке **Недавние проекты**.
1. В блоке **Ресурсы проекта** нажмите ![data-proc-template](../../_assets/data-processing/data-processing.svg) **Yandex Data&nbsp;Processing**.
1. Нажмите **Создать шаблон**.
1. В поле **Имя шаблона** задайте имя. Требования к имени:

    * длина — от 3 до 63 символов;
    * может содержать строчные буквы латинского алфавита, цифры и дефисы;
    * первый символ — буква, последний — не дефис.

1. Нажмите **Создать**. Откроется страница с информацией о созданном шаблоне.

## Активировать шаблон Yandex Data Processing {#activate}

1. Выберите нужный проект в своем сообществе или на [главной странице](https://datasphere.yandex.cloud) DataSphere во вкладке **Недавние проекты**.
1. В блоке **Ресурсы проекта** нажмите ![data-proc-template](../../_assets/data-processing/data-processing.svg) **Yandex Data&nbsp;Processing**.
1. Справа от нужного шаблона нажмите ![options](../../_assets/console-icons/ellipsis.svg) и выберите **Активировать**.

Кластер на основе активированного шаблона Yandex Data Processing будет создан при запуске проекта в IDE.

## Поделиться шаблоном Yandex Data Processing {#share}

1. Выберите нужный проект в своем сообществе или на [главной странице](https://datasphere.yandex.cloud) DataSphere во вкладке **Недавние проекты**.
1. В блоке **Ресурсы проекта** нажмите ![data-proc-template](../../_assets/data-processing/data-processing.svg) **Yandex Data&nbsp;Processing**.
1. Выберите нужный шаблон в списке.
1. Перейдите на вкладку **Доступ**.
1. Включите опцию видимости напротив названия сообщества, в котором нужно поделиться шаблоном.

Чтобы шаблон стал доступен для работы в другом проекте, администратор проекта должен [добавить](projects/use-shared-resource.md) его на вкладке **Доступные**.

## Изменить шаблон {#edit}

Вы можете изменить только имя уже созданного шаблона. Чтобы изменить конфигурацию, [создайте](#create) шаблон заново.

1. Выберите нужный проект в своем сообществе или на [главной странице](https://datasphere.yandex.cloud) DataSphere во вкладке **Недавние проекты**.
1. В блоке **Ресурсы проекта** нажмите ![data-proc-template](../../_assets/data-processing/data-processing.svg) **Yandex Data&nbsp;Processing**.
1. Выберите нужный шаблон в списке, нажмите ![options](../../_assets/console-icons/ellipsis.svg) и выберите **Редактировать**.
1. Измените имя и нажмите **Сохранить**.

## Удалить шаблон Yandex Data Processing {#delete}

1. Выберите нужный проект в своем сообществе или на [главной странице](https://datasphere.yandex.cloud) DataSphere во вкладке **Недавние проекты**.
1. В блоке **Ресурсы проекта** нажмите ![data-proc-template](../../_assets/datasphere/data-processing-template.svg) **Yandex Data&nbsp;Processing**.
1. Выберите в списке шаблон, который нужно удалить.
1. Нажмите ![options](../../_assets/console-icons/ellipsis.svg) и выберите **Удалить**.
1. Нажмите **Подтвердить**.

{% note warning %}

Фактически [удаление ресурсов](../../overview/concepts/data-deletion.md) может занимать до 72 часов.

{% endnote %}