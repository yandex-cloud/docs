# Extending a speech recognition model

{{ speechkit-name }} provides two ways to improve speech recognition.

## Autotuning {#autotuning}

By default, {{ speechkit-name }} doesn't save data passed by users. However, the most effective way to improve a speech recognition model is to train it on real user data.

To improve the quality of speech recognition, you can use the _autotuning_ model. With autotuning enabled, we can save user data and use it for further training. To enable it, set the `x-data-logging-enabled: true` flag in API request headers. For a sample request with logging turned on, see [{#T}](../../speechkit/concepts/support-headers.md).

Autotuning helps improve recognition quality while a model is running.

## Model retraining {#advanced-training}

The basic speech recognition model is designed to work with everyday language, but it may not be sufficient to recognize specific vocabulary. Retraining can help teach a model to recognize domain-specific terms from different fields:

* Medicine: Diagnoses, biological terms, and drug names.
* Business: Company names.
* Trade: Product ranges (jewelry, electrical goods, and so on).
* Finance: Banking terms and names of banking products.

### Data required for retraining {#data}

The following data is required for model retraining:

* _Glossary_: A full list of terms. The glossary may contain words from audio recordings used for testing and other vocabulary. The glossary should be provided in a separate file, with each term placed on a separate line.
* _Text patterns_: Homogeneous phrases that the model will use to synthesize utterances. The length of a pattern together with variables must not exceed 200 characters.

{% include [data-formats](../../_includes/speechkit/training-data-format.md) %}

Text data will be generated from the received files. Glossary terms are inserted into the variable part of the templates. Retraining will be effective if a sufficient amount of data is used:

* At least 1 thousand utterances.
* At least 3 to 5 phrases, preferably in proportion to the frequency of a term's use in real life.

For example, the `first-name.tsv`, `middle-name.tsv`, and `last-name.tsv` glossary files used for retraining a call center model may contain the first, middle, and last names of customers.

| first-name.tsv | middle-name.tsv | last-name.tsv |
| --- | --- | --- |
| John<br>Tom<br>Peter<br>... <br> | Wendell<br>Sean<br>Larry<br>... <br> | Thompson<br>Carter<br>Smith<br>... <br> |

If the pattern phrases suggest that the glossary terms may be in possessive case forms, you need to create a separate glossary file for each form. For example, files with names in the possessive case will contain the following entries:

| first-name-possessive.tsv | middle-name-possessive.tsv | last-name-possessive.tsv |
| --- | --- | --- |
| John<br>Tom<br>Peter<br>... <br> | Wendell<br>Sean<br>Larry<br>... <br> | Thompson's<br>Carter's<br>Smith's<br>... <br> |

Then the `templates.tsv` file will contain entries like

```
Hello, are you {first-name=first-names.tsv} {middle-name=middle-names.tsv} {last-name=last-names.tsv}?
Hello, can I talk to {first-name=first-names-possessive.tsv} {last-name=last-names-possessive.tsv} representative?
```

## Importing retraining data {#import-data}

For information on importing retraining data, see [{#T}](import-training-data.md).

### Testing the quality of retraining {#testing}

A trained model is tested using the following data sets:

1. A basket for evaluating a specific task that is created based on the received audio recordings.
1. A basket for evaluating everyday language.
1. (Optional) Audio recordings that are at least 1 hour long to evaluate the quality of model retraining. The structure of the recorded utterances should repeat the provided patterns.

The quality of speech recognition is evaluated based on the [WER](https://en.wikipedia.org/wiki/Word_error_rate) (Word Error Rate) metric. The lower the resulting metric value, the more accurately a speech fragment is recognized. Model retraining is considered successful if the quality of recognition of specific vocabulary has significantly improved, while the quality of recognition of everyday language has either improved or remained unchanged. You can judge the quality of speech recognition for yourself using [{{ ml-platform-full-name }}](../../datasphere/tutorials/speech-recognition.md).

If a new version of the model meets the requirements of the quality evaluation metrics after retraining, it will be prepared for release in the `general:rc` status.

### Model availability dates

Changes are made to the `general:rc` model within 4 weeks of the standard release preparation cycle.
