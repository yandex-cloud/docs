# Обучение языковых моделей для STT

Распознавание речи (Speech-To-Text, STT) — это процесс преобразования речи в текст. Для распознавания речи используется обученная модель. Результаты зависят от качества и размера набора данных, на котором обучается модель. Из этого сценария вы узнаете, как подготовить данные для обучения и как обучить на них модель, которую затем можно использовать для распознавания речи.

Чтобы обучить языковую модель:

1. [{#T}](#data-prepare).
1. [{#T}](#model-training).
1. [{#T}](#model-evaluate).

## Перед началом работы {#before-you-begin}

1. [Создайте проект](../datasphere-old/operations/projects/create.md) в {{ ml-platform-name }} и откройте его.
1. [Склонируйте](../datasphere-old/operations/projects/work-with-git.md#clone) Git-репозиторий, в котором находятся ноутбуки с примерами использования {{ yandex-cloud }} API:

    ```bash
    https://github.com/yandex-cloud/examples
    ```

    Дождитесь окончания клонирования, это может занять некоторое время. После завершения операции в блоке **File Browser** появится каталог склонированного репозитория `examples`.
1. Откройте каталог `/examples/speechkitpro/fit_lm/` и затем ноутбук `fit_lm.ipynb`.

    {% note info %}

    Для удобства изложения все пути и имена файлов в этом сценарии указываются относительно каталога `/examples/speechkitpro/fit_lm/`.

    {% endnote %}

## Подготовьте данные {#data-prepare}

Для обучения языковой модели подготовьте тексты, а также наборы из размеченных валидационных и тестовых аудиозаписей.

В этом сценарии используется следующая структура файлов и каталогов:
* `/raw_data/dataset.txt` — исходный набор текстов.
* `/raw_data/audio/` — каталог с аудиозаписями, которые будут использоваться для обучения и проверки алгоритма.
* `/raw_data/references/` — каталог с текстами аудиоразметки. Текст в каждом файле содержит расшифровку речи на соответствующей записи из каталога `/raw_data/audio/`.

    Аудиоразметка — это особый способ расшифровки аудиозаписей с оформлением результатов в текстовом виде. Воспользуйтесь [специальным сервисом](../datasphere-old/tutorials/markup.md), предоставляемым SpeechKit Pro, или сформируйте их самостоятельно.

### Подготовьте текст {#text-prepare}

Для обучения используется набор текстов в виде таблицы в формате TSV. Таблица состоит из двух столбцов, первый столбец содержит количество вхождений текста в исходный набор данных (файл `/raw_data/dataset.txt`), второй — сам текст.

Требования к текстам аудиоразметки и исходному набору данных:
* Используются только символы русского алфавита и пробелы.
* Текст приведен к нижнему регистру.
* Все буквы <q>ё</q> заменены на <q>е</q>.
* Нет пробелов в начале и конце строк.
* Все слова разделены только одним пробелом.

Чтобы сформировать из исходного набора данных TSV-файл, удовлетворяющий перечисленным требованиям:

1. Выделите все ячейки с кодом в разделе **Подготовка текстов**, удерживая **Shift** и нажимая слева от нужных ячеек:

    ```python
    import nltk
    nltk.download('punkt')

    import re
    ...
    ```
1. Запустите выбранные ячейки, выбрав в меню **Run → Run Selected Cells** (также можно использовать сочетание клавиш **Shift** + **Enter**).

    {% include [safe-state](../_includes/datasphere/safe-state.md) %}

1. Дождитесь завершения операции.

    В каталоге `/prepared_data/` появится файл `texts.tsv` с необходимыми данными.

### Подготовьте аудио {#audio-prepare}

В этом сценарии используются аудиозаписи из каталога `/raw_data/audio/` и соответствующие им файлы аудиоразметки из каталога `/raw_data/references/`. Половина файлов из каждого каталога будет использоваться в валидационном наборе, половина — в тестовом.

Требования к аудиозаписям:
* **формат файлов**: `wav`;
* **частота дискретизации**: `8000`, `16000` или `48000` Гц;
* **разрядность**: 16 бит, little endian.

Вместе с аудиозаписями должен храниться файл `records.json` с разметкой аудио в следующем формате:

   ```json
   {
      "<audio1_name>.wav": "разметка 1-ой записи",
      ...
      "<audioN_name>.wav": "разметка N-ой записи",
   }
   ```

Чтобы разделить записи на валидационные и тестовые:
1. Выделите все ячейки ноутбука в разделе **Подготовка аудио** и запустите.
1. Дождитесь завершения операции.

    В каталоге `/prepared_data/` появятся подкаталоги `test_audio/` и `val_audio/`, в каждом из которых будут содержаться файлы аудиозаписей и файл аудиоразметки `records.json`.

## Обучите модель {#model-training}

1. Используйте команду `sk_train_language_model` для запуска обучения модели:

    ```bash
    #!nirvana
    sk_train_language_model \
        --train-texts <путь к TSV-файлу> \
        --validation-dir <каталог с валидационными записями> \
        --test-dir <каталог с тестовыми записями> \
        --model <файл модели> \
        --recognitions <файл с результатами распознавания>
    ```

    Выделите ячейку ноутбука в разделе **Обучение модели** и запустите:

    ```json
    #!nirvana
    sk_train_language_model --train-texts ./examples/speechkitpro/fit_lm/prepared_data/texts.tsv --validation-dir ./examples/speechkitpro/fit_lm/prepared_data/val_audio --test-dir ./examples/speechkitpro/fit_lm/prepared_data/test_audio --model ./examples/speechkitpro/fit_lm/lm --recognitions ./examples/speechkitpro/fit_lm/recognitions.json
    ```
1. Дождитесь выполнения операции:

    ```text
    [Step 1/2] Preparing input data...
    Preparing training texts from ./examples/speechkitpro/fit_lm/prepared_data/texts.tsv
    Preparing validation audio files from ./examples/speechkitpro/fit_lm/prepared_data/val_audio
    Preparing test audio files from ./examples/speechkitpro/fit_lm/prepared_data/test_audio

    [Step 2/2] Running training process...

    100.0% [==================================================>]

    Training process has finished successfully.
    Language model is saved to ./examples/speechkitpro/fit_lm/lm
    Results calculated by this model and test data set are saved to ./examples/speechkitpro/fit_lm/recognitions.json
    ```

    В файл `lm` будет сохранена языковая модель, а в `recognitions.json` — результаты распознавания аудио.

{% note info %}

Для обучения языковой модели рекомендуется использовать не менее 1 МБ текстов, а также не менее 100 валидационных и тестовых аудиозаписей.

Время обучения зависит от количества предоставленных текстов и аудиозаписей.

{% endnote %}

## Оцените качество модели {#model-evaluate}

Чтобы оценить качество модели:

1. Выделите и запустите ячейку в разделе **Оценка качества модели**:

    ```python
    import json
    from pathlib import Path

    from stt_metrics import evaluate_wer
    ...
    ```
1. Дождитесь выполнения операции.

    Будет выведена информация о качестве распознавания:

    ```text
    Recognition params: {'noise_reduction': 'Heavy'}
    Mean WER: 0.35714285714285715

    Recognition params: {'noise_reduction': 'Normal'}
    Mean WER: 0.21885521885521886
    ```

Подробнее об оценке качества моделей см. [{#T}](../datasphere-old/tutorials/estimate-quality.md).
