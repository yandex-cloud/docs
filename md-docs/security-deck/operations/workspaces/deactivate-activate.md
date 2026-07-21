[Документация Yandex Cloud](../../../index.md) > [Yandex Security Deck](../../index.md) > [Пошаговые инструкции](../index.md) > [Окружения Security Deck](index.md) > Деактивировать и активировать окружение

# Деактивировать и активировать окружение

## Деактивируйте окружение {#deactivate}

Чтобы приостановить проверки безопасности, деактивируйте окружение:

* все параметры и данные окружения сохранятся;
* изменение параметров будет недоступно;
* создание новых ресурсов станет невозможным, но существующие ресурсы окружения можно удалять;
* будет тарифицироваться только хранение собранных данных. Гарантированный срок хранения — не более 90 дней.

{% list tabs group=instructions %}

- Интерфейс Security Deck {#cloud-sd}

  1. Перейдите в сервис [Yandex Security Deck](https://center.yandex.cloud/security/).
  1. На панели слева выберите ![vector-circle](../../../_assets/console-icons/vector-circle.svg) **Окружение**.
  1. В верхней части окна выберите нужное [окружение](../../concepts/workspace.md).
  1. Справа от имени окружения нажмите ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![alt text](../../../_assets/console-icons/ban.svg) **Деактивировать**.
  1. В открывшемся окне подтвердите деактивацию.

{% endlist %}

## Активируйте окружение {#activate}

{% list tabs group=instructions %}

- Интерфейс Security Deck {#cloud-sd}

  1. Перейдите в сервис [Yandex Security Deck](https://center.yandex.cloud/security/).
  1. На панели слева выберите ![vector-circle](../../../_assets/console-icons/vector-circle.svg) **Окружение**.
  1. В верхней части окна выберите нужное окружение.
  1. Нажмите кнопку **Активировать**.
  1. В открывшемся окне подтвердите активацию.

{% endlist %}

#### Полезные ссылки {#see-also}

* [Окружения Security Deck](../../concepts/workspace.md)
* [Создать окружение Security Deck](create.md)
* [Изменить окружение Security Deck и его компоненты](update.md)
* [Посмотреть дашборд и операции с окружением Security Deck](view-dashboard.md)
* [Настроить права доступа к окружению Security Deck](manage-access.md)
* [Удалить окружение Security Deck](delete.md)