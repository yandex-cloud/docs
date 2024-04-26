---
title: "Как запускать задания {{ ml-platform-name }} Jobs"
description: "Следуя данной инструкции, вы сможете удаленно запускать Python- и bash-скрипты и исполняемые бинарные файлы, которые будут выполняться на ВМ {{ ml-platform-name }}."
---

# Запуск заданий {{ ml-platform-name }} Jobs

Вы можете удаленно запускать [задания](../../concepts/jobs/index.md) (jobs) — Python- и bash-скрипты и исполняемые бинарные файлы, которые будут выполняться на ВМ {{ ml-platform-full-name }}.

Задания создаются и выполняются в [проектах](../../concepts/project.md), но не зависят от ноутбуков и запущенных ВМ в проекте. 

Для запуска задания необходимо [установить](../../../cli/quickstart.md) и сконфигурировать [интерфейс командной строки {{ yandex-cloud }}](../../../cli/), чтобы с его помощью аутентифицироваться в {{ yandex-cloud }}. Также нужно установить библиотеку `datasphere` в свое окружение Python командой `pip install datasphere`.

{% include [vscode-extension-info](../../../_includes/datasphere/vscode-extension-info.md) %}

При запуске задания библиотека `datasphere` анализирует окружение, собирает зависимости кода и может передавать их в {{ ml-platform-name }} для развертывания окружения на ВМ в облаке. Чтобы избежать лишних системных зависимостей, которые могут нарушить работу задания, рекомендуем использовать виртуальное окружение [venv](https://docs.python.org/3/library/venv.html) или [conda](https://docs.conda.io/en/latest/#).

{% include [jobs-info](../../../_includes/datasphere/jobs-environment.md) %}

## Создайте задание {#create-job}

1. Установите библиотеку `datasphere`:

    ```bash
    pip install datasphere
    ```

1. Подготовьте скрипт или исполняемый бинарный файл.

1. Подготовьте файл с входящими данными.

1. Настройте параметры задания. В файле `config.yaml` укажите ресурсы для выполнения задания и конфигурацию, на которой его нужно запустить:

    ```yaml
    name: <название_задания>
    desc: <описание_задания>
    cmd: > 
        python <исполняемый_файл> --data ${DATA} --result ${OUTPUT}
    env:
      python: auto
    inputs:
      - <входящие_данные>: DATA
    outputs:
      - <результаты>: OUTPUT
    cloud-instance-type: <конфигурация_вычислительных_ресурсов>
    ```

    Где: 

    * `name` — название задания.
    * `desc` — описание задания.
    * `cmd` — файл со скриптом и переменные для входящих данных и результатов.
    * `env` — параметры окружения. Значение `python: auto` означает, что необходимо передавать в {{ ml-platform-name }} код и зависимости `pip`.
    * `inputs` — файл с входящими данными. Название переменной `DATA` можно изменить.
    * `outputs` — файл с результатами. Название переменной `OUTPUT` можно изменить.
    * `cloud-instance-type` — [конфигурация вычислительных ресурсов](../../concepts/configurations.md).

1. Откройте командную оболочку в папке с подготовленными файлами и запустите задание:

    ```bash
    datasphere project job execute -p <идентификатор_проекта> -c config.yaml
    ```

Вы сможете отслеживать прогресс выполнения заданий на странице проекта в интерфейсе {{ ml-platform-name }}.

## Пример {#example}

Рассмотрим пример обучения модели классификации на датасете MNIST, содержащем образцы рукописных цифр. Запуск обучения в {{ ml-platform-name }} происходит удаленно, после чего файл с обученной моделью возвращается в качестве результата. Другие примеры для запуска заданий доступны в [репозитории](https://github.com/yandex-cloud-examples/yc-datasphere-jobs-examples) на GitHub.

{% note warning %}

Для запуска задания требуется Python 3.10.0 и TensorFlow 2.12.0.

{% endnote %}

1. Установите библиотеку `tensorflow`:

    ```bash
    pip install tensorflow==2.12.0 
    ```

1. Подготовьте скрипт в файле `example.py`:

    ```python
    import argparse
    import json
    import os
    import shutil
    import tensorflow as tf

    parser = argparse.ArgumentParser(prog='example')
    parser.add_argument('-i', '--input', required=True, help='Input file')
    parser.add_argument('-m', '--model', required=True, help='Output file')

    def make_archive(source, destination):
        base = os.path.basename(destination)
        name = base.split(".")[0]
        fmt = base.split(".")[1]
        shutil.make_archive(name, fmt, source)

    def main(epoch_count, model_file):
        print("TensorFlow version: ", tf.__version__)
        print("")
        print(os.system("nvidia-smi"))
        print("")

        print("Load MNIST dataset...")
        mnist = tf.keras.datasets.mnist
        (x_train, y_train), (x_test, y_test) = mnist.load_data()
        x_train, x_test = x_train / 255.0, x_test / 255.0

        print("Build Sequential model...")
        model = tf.keras.models.Sequential([
          tf.keras.layers.Flatten(input_shape=(28, 28)),
          tf.keras.layers.Dense(128, activation="relu"),
          tf.keras.layers.Dropout(0.2),
          tf.keras.layers.Dense(10)
        ])

        #predictions = model(x_train[:1]).numpy()
        #tf.nn.softmax(predictions).numpy()

        loss_fn = tf.keras.losses.SparseCategoricalCrossentropy(from_logits=True)
        #loss_fn(y_train[:1], predictions).numpy()

        print("Compile model...")
        model.compile(optimizer="adam", loss=loss_fn, metrics=["accuracy"])

        print("Fit...")
        model.fit(x_train, y_train, epochs=epoch_count)

        print("Evaluate...")
        model.evaluate(x_test,  y_test, verbose=2)

        print(f"Save model to '{model_file}'")
        tf.keras.models.save_model(model, "model", save_format="tf")
        make_archive("model", model_file)

        print("Done")


    if __name__ == "__main__":
        args = parser.parse_args()

        epoch_count = 5

        with open(args.input) as f:
            data = json.load(f)
            epoch_count = int(data["epoch_count"])

        main(epoch_count, args.model)
    ```

1. Подготовьте файл с входящими данными `input.json`:

    ```python
    {
        "epoch_count" : 3
    }
    ```

1. Создайте файл `config.yaml` с параметрами задания:

    ```yaml
    name: simple-tf-script
    desc: Simple TF script
    cmd: python example.py --input ${INPUT} --model ${MODEL}
    env:
      python: auto
    inputs:
      - input.json: INPUT
    outputs:
      - model.zip: MODEL
    cloud-instance-type: g1.1
    ```

1. Запустите задание:

    ```bash
    datasphere project job execute -p <идентификатор_проекта> -c config.yaml
    ```

Модель сохранится в архив `model.zip` в папке задания.

#### См. также {#see-also}

* [{#T}](../../concepts/jobs/index.md)
* [GitHub-репозиторий](https://github.com/yandex-cloud-examples/yc-datasphere-jobs-examples) с примерами для запуска заданий.
