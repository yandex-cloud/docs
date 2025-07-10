Вы можете облегчить процесс разработки в [Visual Studio Code](https://code.visualstudio.com/) с помощью модели Qwen3-235B-A22B. Модель способна генерировать код, конвертировать его на другие языки программирования, помогать с отладкой и поиском ошибок в коде, анализировать данные, писать документацию и другое.

В этом руководстве вы настроите интеграцию модели Qwen3-235B-A22B в среду разработки Visual Studio Code с помощью сервиса {{ foundation-models-full-name }} и расширения [Roo Code](https://roocode.com/).

Чтобы использовать модель Qwen3-235B-A22B в качестве ассистента в Visual Studio Code:

1. [Подготовьте инфраструктуру](#infra).
1. [Создайте API-ключ для сервисного аккаунта](#create-key).
1. [Подключитесь к модели](#connection).
1. [Протестируйте модель](#test).

В стоимость поддержки инфраструктуры для подключения к модели Qwen3-235B-A22B из Visual Studio Code входит плата за генерацию текста (см. [тарифы {{ foundation-models-full-name }}](../../foundation-models/pricing.md)).

## Подготовьте инфраструктуру {#infra}

### Создайте каталог {#create-folder}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) выберите облако и нажмите кнопку ![create](../../_assets/console-icons/plus.svg)**{{ ui-key.yacloud.component.console-dashboard.button_action-create-folder }}**.
   1. Введите имя каталога, например `aistudio`.
   1. Нажмите кнопку **{{ ui-key.yacloud.iam.cloud.folders-create.button_create }}**.

{% endlist %}

### Создайте сервисный аккаунт {#create-sa}

[Сервисный аккаунт](../../iam/concepts/users/service-accounts.md) понадобится, чтобы получить [API-ключ](../../iam/concepts/authorization/api-key.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в каталог `aistudio`.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Введите имя сервисного аккаунта, например `qwen-user`.
  1. Нажмите **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** и назначьте сервисному аккаунту роль `{{ roles-yagpt-user }}`.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

{% endlist %}

## Создайте API-ключ для сервисного аккаунта {#create-key}

Чтобы Visual Studio Code могла получить доступ к модели, создайте API-ключ.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог `aistudio`.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. На панели слева выберите ![FaceRobot](../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}**.
  1. В открывшемся списке выберите сервисный аккаунт `qwen-user`.
  1. На панели сверху нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** и выберите **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_api_key }}**.
  1. В поле **{{ ui-key.yacloud.iam.folder.service-account.overview.field_key-scope }}** выберите `yc.ai.languageModels.execute`.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
  1. Сохраните идентификатор и секретный ключ.

{% endlist %}

## Подключитесь к модели {#connection}

1. Установите расширение [Roo Code](https://roocode.com/) в Visual Studio Code.
1. В окне программы на панели слева нажмите **Roo Code**.
1. В открывшемся окне в поле **API Provider** выберите **OpenAI Compatible**.
1. В поле **Base URL** укажите `https://{{ api-host-llm }}/v1`.
1. В поле **API-key** вставьте секретное значение ключа, полученное на предыдущем [шаге](#create-key).
1. В поле **Model** укажите `gpt://<идентификатор_каталога>/Qwen3-235b-a22b-fp8/latest`, где `<идентификатор_каталога>` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md) `aistudio`.
1. Нажмите **Go!**.

## Протестируйте модель {#test}

В качестве примера попросим модель сгенерировать скрипт обращения к модели через {{ openai }} SDK.

1. В Visual Studio Code на панели слева нажмите **Roo Code**.
1. В открывшемся окне в поле ввода снизу напишите промт и нажмите **Send message**:

   ```text
   Напиши скрипт test.py, который через Python {{ openai }} SDK делает потоковый вызов генерации стихотворения про Yandex Cloud. В качестве параметров принимается токен и идентификатор модели. В качестве эндпоинта — https://{{ api-host-llm }}/v1
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
           base_url="https://{{ api-host-llm }}/v1",
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
