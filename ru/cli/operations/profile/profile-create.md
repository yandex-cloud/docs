# Создание профиля


Создать профиль можно двумя способами:
- [Создание пустого профиля и добавление параметров вручную](#create).
    
    Будет создан и активирован пустой профиль — все необходимые [параметры надо будет задать отдельно](manage-properties.md).
- [Интерактивное создание профиля с базовыми параметрами](#interactive-create).
    
    CLI будет поэтапно предлагать задать базовые параметры профиля. С помощью этого способа можно переопределить параметры уже существующего профиля. Способ не подходит для сервисных аккаунтов.

## Создание пустого профиля и добавление параметров вручную {#create}

Создайте профиль с именем `test`:
1. Выполните команду: 
   
   ```
   yc config profile create test
   ```
   
   Результат:
   
   ```
   Profile 'test' created and activated
   ```
   
   
1. Добавьте необходимые параметры профиля, например каталог: 
    
    ```
    yc config set folder-id <ID каталога>
    ```
    
    Ознакомьтесь с полным [списоком параметров](../../concepts/core-properties.md) профиля, а также как ими [управлять](manage-properties.md).

## Интерактивное создание профиля с базовыми параметрами {#interactive-create}



В процессе интерактивного создания профиля CLI будет поэтапно предлагать задать базовые параметры профиля: 
- Имя профиля.
- OAuth-токен.
- Облако, в котором у вас есть права доступа.
- Каталог по умолчанию.
- Зона доступности по умолчанию, в которой будут создаваться ресурсы сервиса {{ compute-full-name }}.

Вы можете прервать процесс создания профиля в любой момент. В профиле будут сохранены настройки, которые вы успели задать до прерывания.

### Получите OAuth-токен {#get-token}

Получите OAuth-токен: нажмите кнопку **Разрешить** в [сервисе Яндекс.OAuth]({{ link-cloud-oauth }}). 

### Создайте профиль {#create-profile}

Чтобы создать профиль: 
1. Выполните команду `yc init`. 
1. Введите свой OAuth-токен:

    Если вы выполняете команду `yc init` не в первый раз, этот шаг будет отсутствовать.

    ```
    Please go to {{ link-cloud-oauth }}
     in order to obtain OAuth token.
    
    Please enter OAuth token: AaAaBbBbCcCcDdDdEeEeFfFfGgGg
    ```
1. Выберите действие: создать новый профиль или переопределить параметры текущего профиля.
    
    После установки CLI у вас уже создан профиль по умолчанию — `default`. CLI предложит вам создать новый профиль или переопределить параметры текущего профиля.
    
    ```
    Welcome! This command will take you through the configuration process.
    Pick desired action:
     [1] Re-initialize this profile 'default' with new settings
     [2] Create a new profile
    ```
    
    В зависимости от выбранного варианта, вам будет предложено ввести имя профиля или OAuth-токен соответственно.  
1. Введите имя для нового профиля:

    ```
    Enter profile name. Names start with a lower case letter and contain only lower case letters a-z, digits 0-9, and hyphens '-':
    ```
1. Введите свой OAuth-токен: 

    ```
    Please go to {{ link-cloud-oauth }}
    in order to obtain OAuth token.
    
    Please enter OAuth token: AaAaBbBbCcCcDdDdEeEeFfFfGgGg
    ```
1. Выберите одно из предложенных облаков, в которых у вас есть права доступа:

    {% include [include](../../../_includes/cli/choose-cloud.md) %}
	
1. Выберите каталог по умолчанию:

    ```
    Please choose a folder to use:
    [1] folder1 (id = cvatao4faoe2bmdrg22b)
    [2] folder2 (id = tao4faoe2cvabmdrg22b)
    [3] Create a new folder
    Please enter your numeric choice: 1
    ```
1. Выберите зону доступности по умолчанию для сервиса {{ compute-full-name }}:

    ```
    Do you want to configure a default {{ compute-full-name }} availability zone? [Y/n] Y
    Which zone do you want to use as a profile default?
    [1] {{ region-id }}-a
    [2] {{ region-id }}-b
    [3] {{ region-id }}-c
    [4] Don't set default zone
    Please enter your numeric choice: 2
    ```
    
### Проверьте настройки вашего профиля {#get}

Выполните команду:
 
```
yc config profile get <имя профиля>
token: AQAAAAAV6O...
cloud-id: b1gvl...
folder-id: b1g88...
```


