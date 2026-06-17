# Удалить окружение Security Deck

{% note info %}

Функциональность находится на стадии [Preview](../../../overview/concepts/launch-stages.md).

{% endnote %}

Чтобы удалить [окружение](../../concepts/workspace.md) Security Deck:

{% list tabs group=instructions %}

- Интерфейс Security Deck {#cloud-sd}

  1. Перейдите в сервис [Yandex Security Deck](https://center.yandex.cloud/security/).
  1. На панели слева выберите ![sliders](../../../_assets/console-icons/sliders.svg) **Параметры Security Deck** и перейдите на вкладку **Окружения**.

      {% note tip %}

      Чтобы быстрее найти нужное окружение, воспользуйтесь фильтром.

      {% endnote %}

  1. В строке с нужным окружением нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **Удалить**.
  1. В открывшемся окне подтвердите удаление. Для этого в текстовом поле введите имя удаляемого окружения и нажмите кнопку **Удалить**.

{% endlist %}

В результате окружение будет удалено без возможности восстановления. Все проверки согласно правилам контроля прекратятся, компоненты модулей Security Deck будут удалены. [Коннектор](../../concepts/workspace.md#connectors) и [приемник алертов](../../concepts/workspace.md#alert-sinks), использовавшиеся в окружении, будут сохранены.

#### Полезные ссылки {#see-also}

* [Окружения Security Deck](../../concepts/workspace.md)
* [Создать окружение Security Deck](create.md)
* [Посмотреть дашборд и операции с окружением Security Deck](view-dashboard.md)
* [Изменить окружение Security Deck и его компоненты](update.md)
* [Настроить права доступа к окружению Security Deck](manage-access.md)