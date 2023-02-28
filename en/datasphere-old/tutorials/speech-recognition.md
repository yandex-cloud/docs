# Voice biometrics

{% include [link-on-new-ui-datasphere-in-old-ui](../../_includes/datasphere/datasphere-old-note.md) %}

{{ ml-platform-full-name }} lets you build machine learning (ML) models using the {{ jlab }} Notebook interface. Take a look at the case of speaker voice recognition using speech signal modeling with numerical features:

1. [Install dependencies](#satisfy-dependencies).
1. [Upload a dataset and extract features](#load-dataset).
1. [Train a model on voice data](#model-fit).
1. [Get the results of feature prediction based on test data](#model-test).

## Before you begin {#before-you-begin}

1. [Create a project](../operations/projects/create.md) in **{{ ml-platform-name }}** and open it.
1. [Clone](../operations/projects/work-with-git.md#clone) the Git repository that contains the prepared notebook with the dataset:

   ```text
   https://github.com/yandex-cloud/examples
   ```

   Wait for the cloning to complete. It may take some time. Once the operation is complete, the folder of the cloned repository will appear in the **File Browser** section.

1. Open the **examples/datasphere/** folder and review the contents of the **speech-recognition.ipynb** notebook. At the beginning of the notebook, you'll see the basic principles of speech signal modeling with audio features.

   {% include [safe-state-warn](../../_includes/datasphere/safe-state.md) %}

## Install dependencies {#satisfy-dependencies}

1. Select all cells with code in the **Installing and importing required packages** section by holding **Shift** and clicking to the left of the desired cells:

   ```python
   %pip install numba==0.48.0
   %pip install librosa
   %pip install cffi==1.14.2
   %pip show numba
   import time
   import os
   from tqdm import tqdm
   ...
   ```

1. Run the selected cells. To do this, choose **Run → Run Selected Cells** or press **Shift**+**Enter**.
1. Wait for the operation to complete.
1. Restart the kernel. To do this, choose **Kernel → Restart kernel**.

Some packages are already installed and imported using the `import` command. Other are installed using the `%pip install` command and imported after that. For the full list of packages pre-installed in {{ ml-platform-name }}, see [{#T}](../concepts/preinstalled-packages.md).

## Upload the dataset from audio files {#load-dataset}

Go to the **Generating audio features** section. The following operations are performed there:

1. Defining a function for extracting audio features from the dataset (using the [`librosa` library](https://librosa.org/doc/latest/index.html)).
1. Uploading a test dataset of short 10-second audio fragments. This function is used to extract audio features. Since the data is distributed across folders related to different speakers, you can uniquely match a set of features and a specific speaker.
1. The resulting array of features is normalized.

To upload and process data:

1. Select all cells with code in the **Generating audio features** section and run them.
1. Wait for the operation to complete.

## Train a model on voice data {#model-fit}

Go to the cell with the model training code in the **Model training** section. In this cell, the following operations are run in the loop for each speaker:

1. The model is trained on fragments of a speaker's speech.
1. The `pickle` module saves the trained model's object to a file in the `./data/speaker-models` folder.

To train the model:

1. Select the cell with code in the **Model training** section.
1. Run the cell.
1. Wait for the operation to complete.

Pay attention to the first row in the cell with code:

```python
#!c1.8

start = time.time()
...
```

Training a model is a resource-intensive operation. To make sure it's executed efficiently, the [computing resource configuration](../concepts/configurations.md) is increased to **c1.8**.

## Get the results of feature prediction based on test data {#model-test}

Go to the **Testing on a test sample** section. The following operations are performed there:

1. Uploading the trained models from the `pickle` files.
1. Audio files from the test dataset are uploaded and processed the same way as for the [training dataset](#load-dataset).
1. Each model predicts the speaker by features.
1. The best prediction result determines the speaker's choice.
1. The accuracy of determining the speaker selected in the test is displayed.

To get the test results:

1. Select a cell in the **Testing on a test sample** section.
1. Run the cell.
1. Wait for the operation to complete.
1. Make sure that the resulting accuracy of speaker recognition is at least 98%.

{% note info %}

You can [share](../operations/projects/publication.md) the available notebook containing the computations or [export the entire project](../operations/projects/export.md).

{% endnote %}
