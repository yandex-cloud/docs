# Preparing and uploading data for {{ brand-voice-lite-name }}

Create your unique voice with {{ brand-voice-lite-name }} by uploading a minimum of marked up audio samples. As a result, you will have a fine-tuned model URI you can access from your applications via API.


## What data is required for training {#results}

To create your own {{ brand-voice-lite-name }} voice, you need to prepare and upload the training data: audio recordings and the texts they are based on. The amount of data needed to train the model depends on how you intend to use the voice and the speaker's manner of speech. For example, a voice used to narrate literary fiction would require more data than a voice for a virtual assistant.

You need to provide at least 20 minutes of training data; the recommended amount is 40 minutes or at least one hour to achieve best results. To train a model with several roles, create a dataset for each role by specifying its name in parameters.

Upload the training data as a single ZIP archive containing:

1. Audio recordings in WAV format.
1. UTF-8 encoded [TSV](https://en.wikipedia.org/wiki/Tab-separated_values) table with the transcripts of recordings from the archive. The table should have two columns without headers:
   * Name of the audio file with the speaker's text.
   * Line with a verbatim transcript of the recording.

{% note warning %}

Each recording should contain a full phrase of one or several sentences. A recording cannot be longer than 15 seconds. The transcripts in the table must exactly match the text in the audio.

{% endnote %}

Each audio recording should start and end with silence, and any clipped sounds or words are not acceptable. You must not use a podcast recording cut into 15-second segments; doing so will split words and phrases, and the recordings will not match phrase boundaries. It is not possible to train a quality model on such data.

> A correct audio recording should be as follows: there are a few milliseconds of silence at the beginning and end of the audio, and the phrase is complete.

![good-audio](../../../_assets/speechkit/good-audio.png)

> A poor audio recording would be as follows: there are no silence intervals at the beginning and end of the audio, and the start and end of the phrase are cut off.

![bad-audio](../../../_assets/speechkit/bad-audio.png)

Such audio recordings will have distortions and are not suitable for model training.

### Example of prepared data {#example}

Before uploading data to create a voice, place all _audio files_ (1.wav, 2.wav, 3.wav) and the _TSV table_ matching the audio files with their transcripts into a ZIP archive.

   The table header is given as an example, it must be excluded from the uploaded file.

   | recordings | text |
   |---|---|
   | 1.wav | Books are a uniquely portable magic. |
   | 2.wav | We have an amazing book for you! |
   | 3.wav | This book is suitable for children from the age of five. |

## Prepare data {#prepare-dataset}

### Texts for model training {#texts}

At least 30% of the training data should contain questions so that the trained voice could reproduce the interrogative tone in texts.

To train your model, you can use texts prepared by the {{ speechkit-name }} team or create them yourself. If you are using the {{ speechkit-name }} [example](https://storage.yandexcloud.net/doc-files/ml/brand_voice_lite_text_example.tsv), add the names of the corresponding audio files to the beginning of each row and then delete the row with the table header.

#### Requirements for all texts {#text-technical-requirements}

{% note tip %}

The result of {{ brand-voice-lite-name }} voice model training directly depends on training data. Make sure to meet the specified text requirements and recommendations to get a high-quality {{ brand-voice-lite-name }} voice.

{% endnote %}

* Each audio recording must have an absolutely accurate text transcript.
* The recommended phrase length is no more than {{ tts-v3-count }}.
* Audio recordings should not include incomplete phrases.
  > _ing time! He won't be happy about that. If you hadn't had that argument, you could have asked for anything you wa._

* Texts must be free of grammatical errors.

{% include [text requirements](../../../_includes/speechkit/tts-text-requirements.md) %}

## Record audio files {#record-audio}

### General recommendations for audio recording {#audiotips}

{% include notitle [tips](../../../_includes/speechkit/audio-tips.md) %}

### Requirements for audio recordings {#requirements-audio}

| Requirement | Value |
| --- | --- |
| Sampling frequency | 48 kHz |
| Audio bit depth |  16 bit PCM |
| Number of channels |  1 (mono) |
| Format | [WAV](https://en.wikipedia.org/wiki/WAV) |
| Duration | max. 15 seconds |
| Silence intervals at the beginning and end | 100–200 ms |

Save all the audio recordings as a ZIP archive to upload them together with the TSV table with texts.

## Upload your data {#upload}

Use the [management console]({{ link-console-main }}/link/speechkit/brand-voice) interface to upload the archive with text data and audio files.
