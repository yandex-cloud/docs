# Аналитика мобильного приложения на данных AppMetrica

Вы можете визуализировать и исследовать данные AppMetrica в {{ datalens-full-name }}, используя следующие подходы:

* Прямой доступ.
  {{ datalens-name }} напрямую подключается к AppMetrica. Этот метод проще и быстрее всего, однако набор поддерживаемых функций [ограничен](../../datalens/function-ref/availability.md).
* Экспорт в режиме реального времени из AppMetrica в {{ mch-name }}.
  Доступны сырые данные и есть возможность предагрегации и постобработки данных на уровне БД. Для реализации этого варианта [настройте экспорт](https://appmetrica.yandex.ru/docs/common/cloud/about.html) и [создайте подключение](https://cloud.yandex.ru/docs/datalens/operations/connection/create-clickhouse) {{ datalens-name }} к БД {{ CH }}.

В этом сценарии используется прямой доступ. В качестве источника данных будет использовано приложение, которое добавлено в сервис [AppMetrica](https://appmetrica.yandex.ru). Просмотреть список доступных вам приложений можно в разделе [Приложения](https://appmetrica.yandex.ru/application/list).

Если у вас нет доступных приложений, то перед выполнением сценария вам необходимо [добавить приложение](https://appmetrica.yandex.ru/docs/quick-start/concepts/quick-start.html) или использовать стандартный **Дашборд AppMetrica**. 

Для визуализации и исследования данных [подготовьте {{ datalens-short-name }} к работе](#before-you-begin), затем выполните следующие шаги:

1. [Создайте подключение и стандартный дашборд](#create-dashboard).
1. [Измените стандартный дашборд](#edit-dashboard).

 

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../includes/before-you-begin-datalens.md) %}


## Создайте подключение и стандартный дашборд {#create-dashboard}

{% note warning %}

Шаг доступен для пользователей, у которых есть приложение в сервисе AppMetrica. Если у вас нет приложений, откройте стандартный **Дашборд AppMetrica** и перейдите к [следующему шагу](#edit-dashboard).

{% endnote %}

1. Перейдите в [{{ datalens-short-name }}]({{ link-datalens-main }}) и нажмите кнопку **Создать подключение**.

    ![image](../../_assets/datalens/solution-06/02-create-connection.png)

1. Выберите подключение **AppMetrica**.

    ![image](../../_assets/datalens/solution-06/03-choose-appmetrica.png)

1. Введите имя подключения `My AppMetrica` и нажмите кнопку **Получить токен**.

    ![image](../../_assets/datalens/solution-06/get-token.png)

    Если вы впервые создаете подключение к приложению в AppMetrica, то предоставьте сервису необходимые разрешения.

1. Выберите необходимое приложение из выпадающего списка.

    ![image](../../_assets/datalens/solution-06/select-an-app.png)
    
1. Задайте настройки подключения:

    ![image](../../_assets/datalens/solution-06/specify-fields.png)

    1. Задайте точность данных (сэмплирование). Вы можете изменить точность после создания подключения.
    1. Выберите тип подключения **Прямой доступ**.
    1. Включите опцию **Автоматически создать дашборд на данном подключении**.

1. В правом верхнем углу нажмите кнопку **Создать**.

    После создания подключения откроется папка с дашбордом и набором датасетов и чартов.

    {% include [datalens-appmetrica-note](../../_includes/datalens/datalens-appmetrica-note.md) %}

## Измените стандартный дашборд {#edit-dashboard}

{% note warning %}

Если у вас нет приложения в AppMetrica и вы пропустили предыдущий шаг, используйте **Дашборд AppMetrica**.

{% endnote %}

Вы можете изменять стандартный [дашборд](../../datalens/concepts/dashboard.md) так, как вам удобно. Например, вы можете удалить чарт, изменить его размер, сменить тип визуализации.

1. Откройте дашборд.

1. Нажмите кнопку **Редактировать** в правом верхнем углу.

    ![image](../../_assets/datalens/solution-06/05-edit-dashboard.png)

1. Чтобы удалить виджет **Динамика клик**, нажмите значок ![image](../../_assets/datalens/cross.svg) в правом верхнем углу.

    ![image](../../_assets/datalens/solution-06/06-specify-widgets.png)

1. Чтобы изменить размер виджета **Динамика установки**, потяните его за правый нижний угол.

1. Нажмите кнопку **Сохранить** в правом верхнем углу и сохраните дашборд.

     ![image](../../_assets/datalens/solution-06/07-save-dashboard.png)

Вы можете отредактировать любой чарт на дашборде. Например, измените тип визуализации для чарта **Рекламные сети** из раздела **Привлечение пользователей**.

Чтобы поделиться дашбордом или чартом, воспользуйтесь одним из способов:

{% include [datalens-metrica-appmetrica-share](../../_includes/datalens/datalens-metrica-appmetrica-share.md) %}
