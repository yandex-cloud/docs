# Активация профиля {{ yandex-cloud }} CLI

Работа с несколькими профилями позволяет быстро переключать контекст выполнения команд. 

{% include [profile-name](../../../_includes/cli-profile-name.md) %}

1. Активируйте профиль с именем `test`:

    ```bash
    yc config profile activate test
    ```

    Результат:

    ```text
    Profile 'test' activated
    ```

1. Проверьте, что профиль активирован. Рядом с его названием будет указано `ACTIVE`:

    ```bash
    yc config profile list
    ```

    Результат:

    ```text
    prod
    test ACTIVE
    ```
