# Удаление профиля

{% note warning %}

Вы не можете удалить профиль, если: 
- Это активный профиль.
- Это единственный профиль.

{% endnote %}

1. Получите список профилей: 
    
    ```
    $ yc config profile list
    prod ACTIVE
    test
    ```
1. Удалите профиль `test`: 
    ```
    $ yc config profile delete test
    Profile 'test' deleted
    ```
1. Проверьте, что профиль действительно удален:
    ```
    $ yc config profile list
    prod ACTIVE
    ```
