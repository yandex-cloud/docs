# Создание алерта

Чтобы создать алерт:

1. Откройте чарт с типом **Линейная диаграмма**. Если у вас нет такого чарта, [создайте его](../../visualization-ref/line-chart.md#create-diagram).

   {% note warning %}

   На оси X должны быть данные с типом `Дата` или `Дата и время`.

   {% endnote %}

1. Нажмите кнопку ![image](../../../_assets/datalens/horizontal-ellipsis.svg) справа вверху.
1. В выпадающем списке выберите **Алерты**.
1. Укажите параметры алерта:

   * В блоке **Основные**:

      * **Название**. Задайте имя алерта.
      * **Описание**. Задайте описание алерта.
      * **OAuth-токен**. Укажите OAuth-токен пользователя, от имени которого будут запрашиваться данные, или нажмите **Получить токен**.

   * В блоке **Метрики**:

      * **Ось Y**. Выберите ось, на которой откладываются значения графика.
      * **Серии**. Выберите показатель, значения которого будут отслеживаться.
      * **Условие срабатывания**. Укажите пороговое значение и условие, при котором должен сработать алерт. Доступны только абсолютные значения.
      * **Таймзона**. Укажите таймзону для временного ряда. Таймзона нужна, чтобы сервис правильно интерпретировал график и не отправлял устаревшие уведомления.

1. В блоке **Каналы уведомлений** добавьте получателей уведомления. Получателем могут быть сотрудники Яндекса или рассылки.

Когда алерт сработает, придет письмо на вашу корпоративную почту.