# Интеграция генеративных моделей в Visual Studio Code

Вы можете облегчить процесс разработки в [Visual Studio Code](https://code.visualstudio.com/) с помощью моделей `Qwen3-235B-A22B`, `GPT-OSS-120b` и других. Модели способны генерировать код, конвертировать его в другие языки программирования, помогать с отладкой и поиском ошибок в коде, анализировать данные, писать документацию и другое.

В этом руководстве вы настроите интеграцию моделей в Visual Studio Code с помощью сервиса Yandex AI Studio и расширения [SourceCraft Code Assistant](https://sourcecraft.dev/portal/code-assistant/) или [Roo Code](https://roocode.com/).

{% note info %}

Расширение Roo Code доступно только в Visual Studio Code.

{% endnote %}

Чтобы использовать модели в качестве ассистента в редакторе кода:

1. [Подготовьте инфраструктуру](#infra).
1. [Создайте API-ключ для сервисного аккаунта](#create-key).
1. [Подключитесь к модели](#connection).
1. [Протестируйте модель](#test).

В стоимость поддержки инфраструктуры для подключения к модели из редактора кода входит плата за генерацию текста (см. [тарифы Yandex AI Studio](https://aistudio.yandex.ru/docs/ru/ai-studio/pricing)).

## Подготовьте инфраструктуру {#infra}

### Создайте каталог {#create-folder}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления](https://console.yandex.cloud) выберите облако и нажмите кнопку ![create](../../_assets/console-icons/plus.svg)**Создать каталог**.
   1. Введите имя каталога, например `aistudio`.
   1. Нажмите кнопку **Создать**.

{% endlist %}

### Создайте сервисный аккаунт {#create-sa}

[Сервисный аккаунт](../../iam/concepts/users/service-accounts.md) понадобится, чтобы получить [API-ключ](../../iam/concepts/authorization/api-key.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в каталог `aistudio`.
  1. Перейдите в сервис **Identity and Access Management**.
  1. Нажмите кнопку **Создать сервисный аккаунт**.
  1. Введите имя сервисного аккаунта, например `ai-model-user`.
  1. Нажмите **Добавить роль** и назначьте сервисному аккаунту [роль](https://aistudio.yandex.ru/docs/ru/ai-studio/security/index#languageModels-user) `ai.languageModels.user`.
  1. Нажмите кнопку **Создать**.

{% endlist %}

## Создайте API-ключ для сервисного аккаунта {#create-key}

Чтобы редактор кода мог получить доступ к модели, создайте API-ключ.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог `aistudio`.
  1. Перейдите в сервис **Identity and Access Management**.
  1. На панели слева выберите ![FaceRobot](../../_assets/console-icons/face-robot.svg) **Сервисные аккаунты**.
  1. В открывшемся списке выберите сервисный аккаунт `ai-model-user`.
  1. На панели сверху нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **Создать новый ключ** и выберите **Создать API-ключ**.
  1. В поле **Область действия** выберите `yc.ai.languageModels.execute`.
  1. Нажмите кнопку **Создать**.
  1. Сохраните идентификатор и секретный ключ.

{% endlist %}

## Подключитесь к модели {#connection}

{% list tabs group=instructions %}

- Visual Studio Code {#vscode}

  1. Установите расширение [SourceCraft Code Assistant](https://sourcecraft.dev/portal/code-assistant/) или [Roo Code](https://roocode.com/).
  1. Настройте расширение:

     {% cut "SourceCraft Code Assistant" %}

     1. В окне программы на панели слева нажмите **SourceCraft Code Assistant**.
     1. В нижней части окна чата нажмите ![chevron-up](../../_assets/console-icons/chevron-up.svg) **Выберите конфигурацию API** и нажмите **Yandex Cloud AI Studio**.
     1. Убедитесь, что в открывшемся окне настроек в поле **Провайдер API** выбрана опция `OpenAI Compatible`, а в поле **Базовый URL** указано значение `https://ai.api.cloud.yandex.net/v1`, затем закройте окно настроек.
     1. В нижней части окна чата нажмите ![chevron-up](../../_assets/console-icons/chevron-up.svg) **Выберите конфигурацию API** и нажмите кнопку **Добавить модель**.
     1. В открывшемся окне введите имя профиля и нажмите **Создать профиль**.
     1. В открывшемся окне настроек в поле **Провайдер API** выберите `OpenAI Compatible`.
     1. В поле **Базовый URL** укажите `https://ai.api.cloud.yandex.net/v1`.
     1. В поле **OpenAI API-ключ** вставьте секретное значение ключа, полученное на предыдущем [шаге](#create-key).
     1. В поле **Модель** укажите URI модели в формате `gpt://<идентификатор_каталога>/<идентификатор_модели>/latest`, где:

         * `<идентификатор_каталога>` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md) `aistudio`;
         * `<идентификатор_модели>` — [идентификатор модели](https://aistudio.yandex.ru/docs/ru/ai-studio/concepts/generation/models). Например: `qwen3-235b-a22b-fp8` или `gpt-oss-120b`.

         {% note info %}

         Выбранная модель будет использоваться только для работы ассистента. Функциональность автодополнения SourceCraft Code Assistant продолжит использовать модель по умолчанию.

         {% endnote %}

     {% endcut %}

     {% cut "Roo Code" %}

     1. В окне программы на панели слева нажмите **Roo Code**.
     1. В открывшемся окне в поле **API Provider** выберите **OpenAI Compatible**.
     1. В поле **Base URL** укажите `https://ai.api.cloud.yandex.net/v1`.
     1. В поле **API-key** вставьте секретное значение ключа, полученное на предыдущем [шаге](#create-key).
     1. В поле **Model** укажите URI модели в формате `gpt://<идентификатор_каталога>/<идентификатор_модели>/latest`, где:

         * `<идентификатор_каталога>` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md) `aistudio`;
         * `<идентификатор_модели>` — [идентификатор модели](https://aistudio.yandex.ru/docs/ru/ai-studio/concepts/generation/models). Например: `qwen3-235b-a22b-fp8` или `gpt-oss-120b`.
     1. Нажмите **Go!**.

     {% endcut %}

{% endlist %}

## Протестируйте модель {#test}

В качестве примера попросим модель сгенерировать скрипт обращения к модели через OpenAI SDK.

{% list tabs group=instructions %}

- Visual Studio Code {#vscode}

    {% cut "SourceCraft Code Assistant" %}

    1. На панели слева нажмите **SourceCraft Code Assistant**.
    1. В окне чата с ассистентом в нижней части экрана напишите промпт и нажмите ![arrow-up](../../_assets/console-icons/arrow-up.svg) **Отправить сообщение**:

        ```text
        Напиши скрипт test.py, который через Python OpenAI SDK делает потоковый вызов генерации стихотворения про Yandex Cloud. В качестве параметров принимается токен и идентификатор модели. В качестве эндпоинта — https://ai.api.cloud.yandex.net/v1
        ```

        Результат:

        ```py
        import sys
        from openai import OpenAI
        
        def main():
            if len(sys.argv) != 3:
                print("Usage: python test.py <token> <model_id>")
                return
        
            token = sys.argv[1]
            model_id = sys.argv[2]
        
            client = OpenAI(
                base_url="https://ai.api.cloud.yandex.net/v1",
                api_key=token
            )
        
            stream = client.chat.completions.create(
                model=model_id,
                messages=[
                    {"role": "user", "content": "Напиши стихотворение про Yandex Cloud"}
                ],
                stream=True
            )
        
            for chunk in stream:
                content = chunk.choices[0].delta.content
                if content:
                    print(content, end="")
        
        if __name__ == "__main__":
            main()
        ```

    {% endcut %}

    {% cut "Roo Code" %}

    1. На панели слева нажмите **Roo Code**.
    1. В открывшемся окне в поле ввода снизу напишите промпт и нажмите **Send message**:

        ```text
        Напиши скрипт test.py, который через Python OpenAI SDK делает потоковый вызов генерации стихотворения про Yandex Cloud. В качестве параметров принимается токен и идентификатор модели. В качестве эндпоинта — https://ai.api.cloud.yandex.net/v1
        ```

        Результат:

        ```py
        import sys
        from openai import OpenAI
        
        def main():
            if len(sys.argv) != 3:
                print("Usage: python test.py <token> <model_id>")
                return
        
            token = sys.argv[1]
            model_id = sys.argv[2]
        
            client = OpenAI(
                base_url="https://ai.api.cloud.yandex.net/v1",
                api_key=token
            )
        
            stream = client.chat.completions.create(
                model=model_id,
                messages=[
                    {"role": "user", "content": "Напиши стихотворение про Yandex Cloud"}
                ],
                stream=True
            )
        
            for chunk in stream:
                content = chunk.choices[0].delta.content
                if content:
                    print(content, end="")
        
        if __name__ == "__main__":
            main()
        ```
    
    {% endcut %}    

{% endlist %}