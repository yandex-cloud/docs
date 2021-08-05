---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---
# Запуск примеров кода в ноутбуке

В ноутбуке представлены небольшие примеры кода для загрузки данных из разных источников.

## Перед началом {#before-begin}

Если проект уже открыт, откройте вкладку с ноутбуком.

Если нет, откройте проект:

1. {% include [include](../../../_includes/datasphere/first-step.md) %}
1. Перейдите во вкладку **Проекты**.
1. Выберите проект, который хотите открыть и нажмите значок ![image](../../../_assets/datalens/horizontal-ellipsis.svg).
1. Выберите **Открыть** и дождитесь открытия проекта.

## Запустите пример кода {#run}

Чтобы запустить пример кода:

1. На верхней панели в окне проекта нажмите кнопку **Snippets**.
1. В открывшемся меню нажмите **Yandex Disk**.
1. В открывшемся меню нажмите на пример, который необходимо запустить.
1. Код примера будет вставлен в ячейку ноутбука.
    1. Выполните шаги, указанные в примере.
    1. Выполните ячейку. Для этого нажмите значок ![Run](../../../_assets/datasphere/jupyterlab/run.svg).

### Примеры кода для загрузки данных из разных источников {#code}

Для выполнения примеров кода вам потребуется ID приложения и secret. 
Чтобы их получить:
1. Перейдите по ссылке: `https://oauth.yandex.ru/client/new`.
1. Заполните поле **Название приложения**.
1. В блоке **Платформы** выберите **Веб-сервисы**.
1. В появившемся поле **Callback URI #1** укажите `https://oauth.yandex.ru/verification_code`.
1. В блоке **Доступы** отметьте доступы для Яндекс.Диска.

**Загрузка содержимого удаленного файла в локальный файл**

```
from cloud_ml.storage.api import Storage

disk = Storage.ya_disk(application_id='ID', application_secret='secret')

disk.get('path/to/file/within/ya/disk/file.txt', 'path/to/file.txt')
```

**Загрузка содержимого удаленного каталога в локальный файл**

```
from cloud_ml.storage.api import Storage

disk = Storage.ya_disk(application_id='ID', application_secret='secret')

disk.get_dir('path/to/dir/within/ya/disk', 'path/to/dir')
```

**Загрузка содержимого локального файла в удаленный файл**

```
from cloud_ml.storage.api import Storage

disk = Storage.ya_disk(application_id='ID', application_secret='secret')

disk.put('path/to/file.txt', 'path/to/file/within/ya/disk/file.txt')
```

**Загрузка содержимого локального каталога в удаленный каталог**

```
from cloud_ml.storage.api import Storage

disk = Storage.ya_disk(application_id='ID', application_secret='secret')

disk.put_dir('path/to/dir', 'path/to/dir/within/ya/disk')
```

#### Что дальше {#what-is-next}

* [{#T}](checkpoints.md)
