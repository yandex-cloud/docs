[Документация Yandex Cloud](../../index.md) > [Практические руководства](../index.md) > [Машинное обучение и искусственный интеллект](index.md) > Разработка с помощью DataSphere > Дообучение моделей в DataSphere

# Дообучение моделей в DataSphere Notebooks

Вы можете [дообучать](https://aistudio.yandex.ru/docs/ru/ai-studio/concepts/tuning/index) языковые модели Yandex AI Studio, чтобы они лучше понимали специфику ваших задач, через API или AI SDK. Дообучение удобно запускать в ноутбуках [Yandex DataSphere](../../datasphere/index.md).

В этом руководстве вы дообучите модель в DataSphere с помощью SDK. Вы также можете склонировать [репозиторий](https://github.com/yandex-cloud-examples/yc-foundation-models-datasphere-tuning) и запустить ноутбук локально, изменив [параметры аутентификации](https://aistudio.yandex.ru/docs/ru/ai-studio/sdk/index).

Чтобы дообучить модель:

1. [Подготовьте инфраструктуру](#infra).
1. [Создайте API-ключ для сервисного аккаунта](#create-key).
1. [Создайте секреты](#create-secrets).
1. [Дообучите модель](#fine-tuning).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

Перед началом работы нужно зарегистрироваться в Yandex Cloud, настроить [сообщество](../../datasphere/concepts/community.md) и привязать к нему [платежный аккаунт](../../billing/concepts/billing-account.md):
1. [На главной странице DataSphere](https://datasphere.yandex.cloud) нажмите **Попробовать бесплатно** и выберите аккаунт для входа — Яндекс ID или рабочий аккаунт в федерации (SSO).
1. Выберите [организацию Yandex Identity Hub](../../organization/index.md), в которой вы будете работать в Yandex Cloud.
1. [Создайте сообщество](../../datasphere/operations/community/create.md).
1. [Привяжите платежный аккаунт](../../datasphere/operations/community/link-ba.md) к сообществу DataSphere, в котором вы будете работать. Убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, создайте его в интерфейсе DataSphere.

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры для дообучения модели входит:

* плата за использование [вычислительных ресурсов DataSphere](../../datasphere/pricing.md);
* плата за [генерацию текста](https://aistudio.yandex.ru/docs/ru/ai-studio/pricing) моделью.

## Подготовьте инфраструктуру {#infra}

Войдите в [консоль управления](https://console.yandex.cloud) Yandex Cloud и выберите организацию, в которой вы работаете с DataSphere. На странице [**Yandex Cloud Billing**](https://center.yandex.cloud/billing/accounts) убедитесь, что у вас подключен платежный аккаунт.

Если у вас есть активный платежный аккаунт, на [странице облака](https://console.yandex.cloud/cloud) вы можете создать или выбрать каталог, в котором будет работать ваша инфраструктура.

{% note info %}

Если вы работаете с Yandex Cloud через [федерацию удостоверений](../../organization/concepts/add-federation.md), вам может быть недоступна платежная информация. В этом случае обратитесь к администратору вашей организации в Yandex Cloud.

{% endnote %}

### Создайте каталог {#create-folder}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления](https://console.yandex.cloud) выберите облако и нажмите кнопку ![create](../../_assets/console-icons/plus.svg)**Создать каталог**.
   1. Введите имя каталога, например `data-folder`.
   1. Нажмите кнопку **Создать**.

{% endlist %}

### Создайте сервисный аккаунт для проекта DataSphere {#create-sa}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в каталог `data-folder`.
  1. [Перейдите]( ../../console/operations/select-service.md#select-service) в сервис **Identity and Access Management**.
  1. Нажмите кнопку **Создать сервисный аккаунт**.
  1. Введите имя [сервисного аккаунта](../../iam/concepts/users/service-accounts.md), например `gpt-user`.
  1. Нажмите **Добавить роль** и назначьте сервисному аккаунту роль `ai.languageModels.user`.
  1. Нажмите кнопку **Создать**.

{% endlist %}

### Добавьте сервисный аккаунт в проект {#sa-to-project}

Чтобы сервисный аккаунт мог обращаться к модели из ноутбука, добавьте его в список участников проекта.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Выберите нужный проект в своем сообществе или на [главной странице](https://datasphere.yandex.cloud) DataSphere во вкладке **Недавние проекты**.
  1. На вкладке **Участники** нажмите **Добавить участника**.
  1. Выберите аккаунт `gpt-user` и нажмите **Добавить**.

{% endlist %}

## Создайте API-ключ для сервисного аккаунта {#create-key}

Чтобы сервисный аккаунт мог получить доступ к модели, создайте [API-ключ](../../iam/concepts/authorization/api-key.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог `data-folder`.
  1. [Перейдите]( ../../console/operations/select-service.md#select-service) в сервис **Identity and Access Management**.
  1. На панели слева выберите ![FaceRobot](../../_assets/console-icons/face-robot.svg) **Сервисные аккаунты**.
  1. В открывшемся списке выберите сервисный аккаунт `gpt-user`.
  1. На панели сверху нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **Создать новый ключ** и выберите пункт **Создать API-ключ**.
  1. Нажмите кнопку **Создать**.
  1. Сохраните идентификатор и секретный ключ.

{% endlist %}

## Создайте секреты {#create-secrets}

Чтобы получить API-ключ и идентификатор каталога из ноутбука, создайте [секреты](../../datasphere/concepts/secrets.md) с идентификаторами ключа и каталога.

1. Выберите нужный проект в своем сообществе или на [главной странице](https://datasphere.yandex.cloud) DataSphere во вкладке **Недавние проекты**.
1. В блоке **Ресурсы проекта** нажмите ![secret](../../_assets/console-icons/shield-check.svg)**Секрет**.
1. Нажмите **Создать**.
1. В поле **Имя** задайте имя секрета — `API_KEY`.
1. В поле **Значение** вставьте идентификатор ключа.
1. Нажмите **Создать**.
1. Создайте еще один секрет `FOLDER_ID` с идентификатором каталога.

## Дообучите модель {#fine-tuning}

Код для дообучения запускается из ноутбука DataSphere. [Данные для дообучения](https://aistudio.yandex.ru/docs/ru/ai-studio/concepts/resources/dataset#generating) хранятся в формате [JSON Lines](https://jsonlines.org/).

1. Откройте ноутбук с кодом по ссылке ниже:

   <a href="https://datasphere.yandex.cloud/import-ipynb?path=https://raw.githubusercontent.com/yandex-cloud-examples/yc-foundation-models-datasphere-tuning/main/LoRA-train-YandexGPT.ipynb"><img src="https://storage.yandexcloud.net/datasphere-assets/datasphere_badge_v2_ru.svg" 
     alt="Открыть в DataSphere"/></a>

1. Скачайте файл `generations.jsonlines` из репозитория на [GitHub](https://github.com/yandex-cloud-examples/yc-foundation-models-datasphere-tuning) и поместите его рядом с ноутбуком.

1. Установите DataSphere SDK, запустив код в ячейке ноутбука:

   ```python
   %pip install yandex-ai-studio-sdk --upgrade
   ```

1. Импортируйте необходимые библиотеки:

   ```python
   import pathlib
   import uuid
   import os
   from __future__ import annotations

   from yandex_ai_studio_sdk import AIStudio
   import urllib.request
   import zipfile   
   ```

1. Загрузите [TensorBoard](https://www.tensorflow.org/tensorboard?hl=ru). Он понадобится, чтобы посмотреть метрики дообучения:

   ```python
   def download_tensorboard(url):
       urllib.request.urlretrieve(url, "tensorboard.zip")
       with zipfile.ZipFile('tensorboard.zip', 'r') as zip_ref:
           zip_ref.extractall("tensorboard")
   ```

1. Загрузите данные для дообучения:

   ```python
   def local_path(path: str) -> pathlib.Path:
       return pathlib.Path(path)

   dataset_path = local_path("generations.jsonlines")
   print(dataset_path)

   print("Данные датасета для дообучения")
   print(dataset_path.read_text())
   ```

1. Создайте объект SDK, содержащий параметры для авторизации:

   ```python
   sdk = AIStudio(
       folder_id=os.environ['FOLDER_ID'], # Идентификатор каталога, сохраненный в секрете DataSphere
       auth=os.environ['API_KEY'] # API-ключ сервисного аккаунта, сохраненный в секрете DataSphere
   )
   ```

1. Создайте датасет для дообучения и запустите его загрузку и валидацию:

   ```python
   dataset_draft = sdk.datasets.draft_from_path(
       task_type='TextToTextGeneration',
       path=dataset_path,
       upload_format='jsonlines',
       name='test-generations'
   )

   dataset = dataset_draft.upload()
   print('Датасет загружается и валидируется')
   print(f'Новый датасет {dataset=} \n')
   ```

1. Выберите базовую модель, которую хотите дообучить, и запустите дообучение. В примере — YandexGPT Lite:

   ```python
   base_model = sdk.models.completions('yandexgpt-lite')

   tuning_task = base_model.tune_deferred(
       dataset,
       name=str(uuid.uuid4()),
       n_samples=10000 
   )
   
   print(f'Дообучение началось {tuning_task} \n')

   # Дообучение может длиться до нескольких часов
   # Дожидаемся завершения операции обучения и получаем новую модель
   new_model = tuning_task.wait()
   print(f'Дообучение закончилось, новая модель = {new_model} \n')
   ```

1. Получите дообученную модель:

   ```python
   # Если вы закрыли ноутбук, по task_id можно проверить статус операции
   tuning_task = sdk.tuning.get(task_id)
   print(tuning_task.get_task_info())

   new_model = tuning_task.get_result()
   print({new_model})
   ```

1. Протестируйте новую модель:

   ```python
   print('Посылаем запросы в новую модель\n')
   # Примеры запросов в модель
   completion_result = new_model.run("Как тебя зовут?")
   print(f'{completion_result=} \n')

   # Дообученную модель можно использовать, указав ее URI
   tuned_uri = new_model.uri 
   model = sdk.models.completions(tuned_uri)

   completion_result = model.run("Откуда ты?")
   print(f'{completion_result=} \n')
   ```

   Модель сгенерирует и вернет ответы с учетом дообучения.

1. Загрузите метрики дообучения:

   ```python
   # Получаем ссылку с данными для TensorBoard и скачиваем файлы
   metrics_url = new_model.get_metrics_url()
   download_tensorboard(metrics_url)
   ```

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы, [удалите проект](../../datasphere/operations/projects/delete.md).