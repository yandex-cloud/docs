[Документация Yandex Cloud](../../../index.md) > [Интерфейс командной строки](../../index.md) > [Пошаговые инструкции](../index.md) > Управление профилем > Удаление

# Удаление профиля Yandex Cloud CLI

{% note warning %}

Вы не можете удалить профиль, если:
- Это активный профиль.
- Это единственный профиль.

Если профиль единственный, последовательно [удалите](manage-properties.md#unset) его параметры.

{% endnote %}

1. Получите список профилей:
    
    ```bash
    yc config profile list
    ```

    Результат:

    ```text
    prod ACTIVE
    test
    ```
1. Удалите профиль `test`:

    ```bash
    yc config profile delete test
    ```

    Результат:

    ```text
    Profile 'test' deleted
    ```
1. Проверьте, что профиль действительно удален:

    ```bash
    yc config profile list
    ```

    Результат:

    ```text
    prod ACTIVE
    ```