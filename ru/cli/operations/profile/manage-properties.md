# Управление параметрами профиля

Управлять параметрами профиля можно следующими способами: 
- [Добавить или изменить параметр профиля](#set).
- [Удалить параметр профиля](#unset).
- [Запустить команду с параметрами другого профиля](#another-profile).

## Добавить или изменить параметр профиля {#set}

Чтобы добавить или изменить параметр профиля, воспользуйтесь командой: 

```
yc config set <имя параметра> <значение параметра>
```

Например, измените каталог по умолчанию:
1. [Получите информацию о текущих параметрах профиля](profile-list.md#profile-get).
1. Измените каталог по умолчанию (параметр `folder-id`): 
    ```
    yc config set folder-id b1g68...
    ```
1. Проверьте, что параметр действительно изменен:
   
   {% if product == "yandex-cloud" %}
   
   ```
   yc config list
   token: AQAAAAAV6O...
   cloud-id: b1gvl...
   folder-id: b1g68...
   ```
   
   {% endif %}

   {% if product == "cloud-il" %}

   ```
   yc config list
   cloud-id: b1gvl...
   folder-id: b1g68...
   ```
   
   {% endif %}
    
Ознакомьтесь с полным [списоком параметров](../../concepts/core-properties.md) профиля. Также вы можете изменить параметры профиля с помощью [процесса интерактивного создания профиля](profile-create.md#interactive-create).

## Удалить параметр профиля {#unset}

Чтобы удалить параметр профиля, воспользуйтесь командой: 

```
yc config unset <имя параметра>
```

Например, удалите каталог по умолчанию:
1. [Получите информацию о текущих параметрах профиля](profile-list.md#profile-get).
1. Удалите каталог по умолчанию (параметр `folder-id`): 
    ```
    yc config unset folder-id
    ```
1.  Проверьте, что параметр действительно удален:
    
    {% if product == "yandex-cloud" %}

    ```
    yc config list
    token: AQAAAAAV6O...
    cloud-id: b1gvl...
    ```
   
    {% endif %}
   
    {% if product == "cloud-il" %}
   
    ```
    yc config list
    cloud-id: b1gvl...
    ```
   
    {% endif %}
    
## Запустить команду с параметрами другого профиля {#another-profile}

Чтобы запустить команду с параметрами другого профиля, добавьте к команде параметр `--profile <имя профиля>`.

Например, посмотрите параметры профиля `test`, не активируя его: 

{% if product == "yandex-cloud" %}

```
yc config list --profile test
token: AQAAAAAV6O...
cloud-id: aoegt...
folder-id: aoek4...
```

{% endif %}

{% if product == "cloud-il" %}

```
yc config list --profile test
cloud-id: aoegt...
folder-id: aoek4...
```

{% endif %}
