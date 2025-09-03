
# Дообучение моделей в {{ ml-platform-name }} Notebooks

Вы можете [дообучать](../../foundation-models/concepts/tuning/index.md) языковые модели {{ foundation-models-full-name }}, чтобы они лучше понимали специфику ваших задач, через API или {{ ml-sdk-name }}. Дообучение удобно запускать в ноутбуках [{{ ml-platform-full-name }}](../../datasphere/).

В этом руководстве вы дообучите модель в {{ ml-platform-name }} с помощью SDK. Вы также можете склонировать [репозиторий](https://github.com/yandex-cloud-examples/yc-foundation-models-datasphere-tuning) и запустить ноутбук локально, изменив [параметры аутентификации](../../foundation-models/sdk/index.md).

Чтобы дообучить модель:

1. [Подготовьте инфраструктуру](#infra).
1. [Создайте API-ключ для сервисного аккаунта](#create-key).
1. [Создайте секреты](#create-secrets).
1. [Дообучите модель](#fine-tuning).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin-datasphere.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры для дообучения модели входит:

* плата за использование [вычислительных ресурсов {{ ml-platform-name }}](../../datasphere/pricing.md);
* плата за [генерацию текста](../../foundation-models/pricing.md) моделью.

## Подготовьте инфраструктуру {#infra}

{% include [intro](../../_includes/datasphere/infra-intro.md) %}

{% include [intro](../../_includes/datasphere/federation-disclaimer.md) %}

### Создайте каталог {#create-folder}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) выберите облако и нажмите кнопку ![create](../../_assets/console-icons/plus.svg)**{{ ui-key.yacloud.component.console-dashboard.button_action-create-folder }}**.
   1. Введите имя каталога, например `data-folder`.
   1. Нажмите кнопку **{{ ui-key.yacloud.iam.cloud.folders-create.button_create }}**.

{% endlist %}

### Создайте сервисный аккаунт для проекта {{ ml-platform-name }} {#create-sa}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в каталог `data-folder`.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Введите имя [сервисного аккаунта](../../iam/concepts/users/service-accounts.md), например `gpt-user`.
  1. Нажмите **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** и назначьте сервисному аккаунту роль `{{ roles-yagpt-user }}`.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

{% endlist %}

### Добавьте сервисный аккаунт в проект {#sa-to-project}

Чтобы сервисный аккаунт мог обращаться к модели из ноутбука, добавьте его в список участников проекта.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
  1. На вкладке **{{ ui-key.yc-ui-datasphere.project-page.tab.members }}** нажмите **{{ ui-key.yc-ui-datasphere.common.add-member }}**.
  1. Выберите аккаунт `gpt-user` и нажмите **{{ ui-key.yc-ui-datasphere.common.add }}**.

{% endlist %}

## Создайте API-ключ для сервисного аккаунта {#create-key}

Чтобы сервисный аккаунт мог получить доступ к модели, создайте [API-ключ](../../iam/concepts/authorization/api-key.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог `data-folder`.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. На панели слева выберите ![FaceRobot](../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}**.
  1. В открывшемся списке выберите сервисный аккаунт `gpt-user`.
  1. На панели сверху нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** и выберите пункт **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_api_key }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
  1. Сохраните идентификатор и секретный ключ.

{% endlist %}

## Создайте секреты {#create-secrets}

Чтобы получить API-ключ и идентификатор каталога из ноутбука, создайте [секреты](../../datasphere/concepts/secrets.md) с идентификаторами ключа и каталога.

1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** нажмите ![secret](../../_assets/console-icons/shield-check.svg)**{{ ui-key.yc-ui-datasphere.resources.secret }}**.
1. Нажмите **{{ ui-key.yc-ui-datasphere.common.create }}**.
1. В поле **{{ ui-key.yc-ui-datasphere.secret.name }}** задайте имя секрета — `API_KEY`.
1. В поле **{{ ui-key.yc-ui-datasphere.secret.content }}** вставьте идентификатор ключа.
1. Нажмите **{{ ui-key.yc-ui-datasphere.common.create }}**.
1. Создайте еще один секрет `FOLDER_ID` с идентификатором каталога.

## Дообучите модель {#fine-tuning}

Код для дообучения запускается из ноутбука {{ ml-platform-name }}. [Данные для дообучения](../../foundation-models/concepts/resources/dataset.md#generating) хранятся в формате [JSON Lines](https://jsonlines.org/).

1. Откройте ноутбук с кодом по ссылке ниже:

   <a href="{{ link-datasphere-main }}/import-ipynb?path=https://raw.githubusercontent.com/yandex-cloud-examples/yc-foundation-models-datasphere-tuning/main/LoRA-train-YandexGPT.ipynb"><img src="https://storage.yandexcloud.net/datasphere-assets/datasphere_badge_v2_ru.svg" 
     alt="Открыть в {{ ml-platform-name }}"/></a>

1. Скачайте файл `generations.jsonlines` из репозитория на [GitHub](https://github.com/yandex-cloud-examples/yc-foundation-models-datasphere-tuning) и поместите его рядом с ноутбуком.

1. Установите {{ ml-platform-name }} SDK, запустив код в ячейке ноутбука:

   ```python
   %pip install yandex-cloud-ml-sdk --upgrade
   ```

1. Импортируйте необходимые библиотеки:

   ```python
   import pathlib
   import uuid
   import os
   from __future__ import annotations

   from yandex_cloud_ml_sdk import YCloudML
   import urllib.request
   import zipfile   
   ```

1. Загрузите [TensorBoard](https://www.tensorflow.org/tensorboard?hl={{ lang }}). Он понадобится, чтобы посмотреть метрики дообучения:

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
   sdk = YCloudML(
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

1. Выберите базовую модель, которую хотите дообучить, и запустите дообучение. В примере — {{ gpt-lite }}:

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