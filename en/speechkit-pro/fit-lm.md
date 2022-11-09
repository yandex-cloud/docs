# Training language models for STT

Speech recognition (Speech-to-Text, STT) is the process of converting speech to text. A trained model is used for speech recognition. The results depend on the quality and size of the dataset that the model is trained on. In this use case, you'll learn how to prepare data for model training and how to train a model on this data to then use it for speech recognition.

To train a language model:

1. [{#T}](#data-prepare).
1. [{#T}](#model-training).
1. [{#T}](#model-evaluate).

## Before you begin {#before-you-begin}

1. [Create a project](../datasphere-old/operations/projects/create.md) in {{ ml-platform-name }} and open it.
1. [Clone](../datasphere-old/operations/projects/work-with-git.md#clone) the Git repository that contains the notebooks with the {{ yandex-cloud }} API usage examples:

   ```bash
   https://github.com/yandex-cloud/examples
   ```

   Wait until cloning is complete. It may take some time. Once the operation is complete, the **File Browser** section will show the `examples` folder of the cloned repository.
1. Open the `/examples/speechkitpro/fit_lm/` folder and then the `fit_lm.ipynb` notebook.

   {% note info %}

   For ease of presentation, all file paths and names in this use case are given relative to the `/examples/speechkitpro/fit_lm/` folder.

   {% endnote %}

## Prepare data {#data-prepare}

To train a language model, prepare texts and sets of marked-up validation and test audio recordings.

In this use case, the following file and folder structure is used:
* `/raw_data/dataset.txt`: The source dataset with texts.
* `/raw_data/audio/`: A folder with audio recordings to be used for training and testing the algorithm.
* `/raw_data/references/`: A folder with audio markup texts. Text in each file contains a transcript of the speech in the corresponding audio recording from the `/raw_data/audio/` folder.

   Audio markup is a special way to transcribe audio recordings and represent the results as text. Use the [service](../datasphere-old/tutorials/markup.md) provided by SpeechKit Pro or generate the resulting texts yourself.

### Prepare texts {#text-prepare}

For training, use a set of texts in the form of a table in TSV format. The table consists of two columns, the first one containing the number of occurrences of text in the source dataset (the `/raw_data/dataset.txt` file) and the second one the text itself.

Requirements for audio markup texts and the source dataset:
* Only Latin characters and spaces are used.
* The text is given in lowercase.
* Spelling must be accurate, and incorrect homophones, such as <q>red</q> instead of <q>read</q>, are not acceptable.
* No spaces at the beginning and at the end of lines.
* All words are separated by only one space.

To generate a TSV file from the source dataset that meets the requirements listed above:

1. Select all cells with code in the **Preparing texts** section by holding **Shift** and clicking to the left of the desired cells:

   ```python
   import nltk
   nltk.download('punkt')

   import re
   ...
   ```
1. Run the selected cells. To do this, choose **Run → Run Selected Cells** or press **Shift** + **Enter**.

   {% include [safe-state](../_includes/datasphere/safe-state.md) %}

1. Wait for the operation to complete.

   As a result, the `texts.tsv` file with the necessary data appears in the `/prepared_data/` folder.

### Prepare audio recordings {#audio-prepare}

In this use case, the audio recordings from the `/raw_data/audio/` folder and the corresponding audio files from the `/raw_data/references/` folder are used. Half of the files from each folder are used in the validation dataset and the other half in the test dataset.

Requirements for audio recordings:
* **File format**: `WAV`.
* **Sample rate**: `8000`, `16000`, or `48000` Hz.
* **Bit depth**: 16 bit, little endian.

A file named `records.json` must be stored along with the audio recordings with audio markup in the following format:

```json
{
   "<audio1_name>.wav": "markup of the 1st audio",
   ...
   "<audioN_name>.wav": "markup of the Nth audio",
}
```

To divide the audio recordings into validation and test ones:
1. Select all notebook cells in the **Preparing audio files** section and run them.
1. Wait for the operation to complete.

   As a result, the `/prepared_data/` folder will contain subfolders named `test_audio/` and `val_audio/`, each of them with audio files and the `records.json` audio markup file.

## Train the model {#model-training}

1. Use the `sk_train_language_model` command to start training the model:

   ```bash
   #!nirvana
   sk_train_language_model \
       --train-texts <path to the TSV file> \
       --validation-dir <directory with validation audio recordings> \
       --test-dir <directory with test audio recordings> \
       --model <model file> \
       --recognitions <file with recognition results>
   ```

   Select the notebook cell in the **Model training** section and run it:

   ```json
   #!nirvana
   sk_train_language_model --train-texts ./examples/speechkitpro/fit_lm/prepared_data/texts.tsv --validation-dir ./examples/speechkitpro/fit_lm/prepared_data/val_audio --test-dir ./examples/speechkitpro/fit_lm/prepared_data/test_audio --model ./examples/speechkitpro/fit_lm/lm --recognitions ./examples/speechkitpro/fit_lm/recognitions.json
   ```
1. Wait for the operation to complete:

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

   As a result, the language model is saved to the `lm` file and audio recognition results to the `recognitions.json` file.

{% note info %}

To train language models, use at least 1 MB of text and at least 100 validation and test audio recordings.

The training time depends on the number of texts and audio recordings provided.

{% endnote %}

## Evaluate the quality of the model {#model-evaluate}

To evaluate the quality of the model:

1. Select and run the cell in the **Evaluating model quality** section:

   ```python
   import json
   from pathlib import Path

   from stt_metrics import evaluate_wer
   ...
   ```
1. Wait for the operation to complete.

   It outputs information about the recognition quality:

   ```text
   Recognition params: {'noise_reduction': 'Heavy'}
   Mean WER: 0.35714285714285715

   Recognition params: {'noise_reduction': 'Normal'}
   Mean WER: 0.21885521885521886
   ```

For more information about evaluating the quality of models, see [{#T}](../datasphere-old/tutorials/estimate-quality.md).
