# Evaluating the quality of STT models

Speech-to-Text (STT) recognition results on the {{ speechkit-full-name }} platform depend on the choice of [recognition model](../../speechkit/stt/models.md). To evaluate the quality of speech recognition, use a common [WER](https://en.wikipedia.org/wiki/Word_error_rate) metric. The lower the metric value, the more accurately a speech fragment is recognized. The metric in {{ speechkit-name}} is calculated using a special library named `stt_metrics`.

To calculate the WER metric in {{ ml-platform-full-name }} using this library:

1. [Upload the library](#satisfy-dependencies).
1. [Run the test case](#test-example).
1. [See how to fix speech recognition errors](#stt-errors-remove).
1. [Evaluate the recognition quality for multiple audio recordings at once](#wer-aggregate).

## Before you begin {#before-you-begin}

1. [Create a project](../operations/projects/create) in **{{ ml-platform-name }}** and open it.
1. [Clone](../operations/projects/work-with-git.md#clone) the Git repository that contains the notebooks with the {{ yandex-cloud }} API usage examples:

   ```
   https://github.com/yandex-cloud/examples.git
   ```

   Wait until cloning is complete. It may take some time. Once the operation is complete, the folder of the cloned repository will appear in the ![folder](../../_assets/datasphere/jupyterlab/folder.svg) **File Browser** section.
1. Open the `examples/speechkitpro/estimate_quality` folder and review the contents of the `estimate_quality.ipynb` notebook. At the beginning of the notebook, the task of checking the quality of STT models and the WER (Word Error Rate) metric are described.

## Upload the library {#satisfy-dependencies}

1. Select the cell with the code in the **Evaluating the quality of STT models** section:

   ```
   from stt_metrics import WER, ClusterReferences
   from stt_metrics.text_transform import Lemmatizer
   ```

1. Run the selected cell. To do this, choose **Run → Run Selected Cells** or press **Shift** + **Enter**.

1. Wait for the operation to complete.

As a result, modules for evaluating the quality of STT models are uploaded.

{% include [safe-state-warn](../../_includes/datasphere/safe-state.md) %}

## Run the test case {#test-example}

Go to the **WER metric usage example** section. The following operations are performed there:

1. Uploading examples of:
   - Recognized speech
   - Text with markup
1. Creating an object named `WER()` for processing data and calculating the metric.
1. Creating an object with information for WER calculation.
1. Calculating the WER metric to determine the recognition quality.
1. Displaying calculation results:
   - The number of recognition errors.
   - The number of words in the compared texts.
   - Text alignment results.
   - The WER metric value.

To calculate the WER metric:

1. Select all the cells with the code in the **WER metric usage example** section and run them.
1. Wait for the operation to complete.

## See how to fix speech recognition errors {#stt-errors-remove}

Speech recognition errors may occur for the following reasons:
- Markup artifacts. For example, spelling variants of the same word (such as <q>realize</q> and <q>realise</q>).
- Different spelling of phrases. For example, the phrase <q>theater center</q> can be marked up as <q>theater center</q>, <q>theatre center</q>, <q>theater centre</q>, or <q>theatre centre</q>.
- Variants of word forms. For example, gender and cases of pronouns, verb tenses, and so on.

To improve the value of the WER metric, fix the errors using the following techniques:

- Preprocessing of the marked-up text. For example, you can delete markup artifacts.
- Uploading a set of synonyms into the metric calculation model using the `ClusterReferences()` method.
- Reducing words to their base form (lemmatization) using the `Lemmatizer()` method. The base form of a word is:
   - For pronouns: Nominative case, singular.
   - For pronouns: Nominative case, singular.
   - For verbs: Infinitive.

To test the suggested techniques:

1. Select all the cells with the code in the **Fixing errors** section and run them.
1. Wait for the operation to complete.
1. Check that the WER metric value decreases from `0.27` to `0.2` and `0.13` with the sequential use of the methods.

## Evaluate the recognition quality for multiple audio recordings at once {#wer-aggregate}

Go to the **WER metric usage example (aggregate)** section. It shows how to calculate the WER metric simultaneously for multiple fragments of marked-up text using the `evaluate_wer` method. The example contains two pairs of audio files with marked-up text and recognized speech.

To test the suggested method:

1. Select all cells with code in the **WER metric usage example (aggregate)** section and run them.
1. Wait for the operation to complete.
1. Make sure that the WER metric is calculated for two marked-up texts.
