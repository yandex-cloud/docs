# Data for {{ brand-voice-lite-name }}

{{ brand-voice-lite-name }} allows creating your unique voice based on a minimum of marked-up audio samples. As a result, you will have a fine-tuned model ID that you can access from your applications via API.


## What data is required for training {#data}

To create your own {{ brand-voice-lite-name }} voice, you need to prepare a training _dataset_ consisting of audio recordings and the texts they are based on. Each audio recording must strictly match the provided text.

The amount of data for training the model depends on the speaker's manner of speech and the purpose of the voice you are creating. For example, a voice used to narrate literary fiction would require more data than a voice for a virtual assistant. You need to provide at least 20 minutes of clean audio (without counting the silence in the beginning and in the end of each file); the recommended amount is 40 minutes or at least one hour to achieve best results. To create a voice with multiple [roles](../index.md#role), you need to record a separate dataset for each of them.

{% note tip %}

The result of {{ brand-voice-lite-name }} voice model training directly depends on training data. To get a high-quality {{ brand-voice-lite-name }} voice, adhere to all the recommendations we give for texts and audio recordings.

{% endnote %}

At least 30% of the training data should contain questions so that the trained voice could reproduce the interrogative tone in texts. You can use a ready-made [template](https://storage.yandexcloud.net/doc-files/ml/brand_voice_lite_text_example.tsv) prepared by the {{ speechkit-name }} team or prepare texts on your own. For recommendations on creating and formatting training texts, see [Requirements to texts](#text-technical-requirements).

You can upload a dataset with all audio recordings and transcripts [as a single archive](#zip) or record an audio for each phrase [in the management console](#console-record) using a browser. In either case, make sure you follow the [recommendations on making audio recordings](#audiotips) and listen through all of them to ensure the quality of the source data for training the voice model. Once you start training, you will no longer be able to edit your dataset.

## Text requirements {#text-technical-requirements}

The {{ speechkit-name }} team provides a ready-made pack of texts that you only need to read out. It contains narrative, interrogative, and exclamatory phrases and would suit you in most cases to create voices in Russian. You can also prepare texts for audio recordings yourself, but make sure that they meet these requirements:

* Texts must be free of grammatical errors.
* The recommended phrase length is no more than {{ tts-v3-count }}.
* Audio recordings should not include incomplete phrases.
  > _ing time! He won't be happy about that. If you hadn't had that argument, you could have asked for anything you wa._

{% include [text requirements](../../../_includes/speechkit/tts-text-requirements.md) %}

## Recommendations for audio recording {#audiotips}

Make your audio recordings in a quiet room without background noise. A fan, AC unit, or fridge, street noise, background music, and echo may be recorded and would dramatically affect the quality of the voice you are creating. A perfect place would be a room equipped with acoustic panels. If you are recording your voice in a household environment, you can reduce the echo with soft surfaces and furniture, such as carpet, upholstered sofa, etc.

You do not have to use professional equipment to record audio. If you do not have a studio microphone, use your laptop’s built-in microphone, your smartphone, or a headset. Noise reduction mode in most headsets cuts off the beginning and end of a phrase, so we recommend disabling it. Do not change the hardware settings until you finish recording. Your distance to microphone should be equal for all audio recordings.

For a certain period, unplug the device you are using from power supply if possible: interfering noises might occur while your battery is charging. Also, disable sound notifications and switch your smartphone to airplane mode in order to avoid recording interfering sounds.

Record the audio at the maximum quality without compression. If you are using special software for recording, make sure that file compression and additional filters are disabled.

Before you start, make sure that you are not hungry or thirsty, do not have excessive saliva flow or dry mouth. Remove all rattling objects and try not to move your hands and legs too often during the recording. Relax, straight out your back and neck, and breathe deeply and freely. Sounds of your breath should not overlap the audio being recorded.

Read the text so that it sounds as naturally as possible. Your emotions should match the text you are pronouncing. Keep your intonation the same while recording all samples for a certain role. For detailed recommendations on recording roles, see [{#T}](./roles-records.md).

If you have made a mistake in pronunciation, rewrite the whole phrase, but do not try to fix it within the same audio. No inaccuracies, micro repeats, reservations, and word substitutions are allowed. Any speech defects in the recordings made for synthesis models substantially degrade the quality of the synthesized speech.

After recording a phrase, listen to the audio you recorded. Make sure that all words are clear and distinct, there are small silence fragments at the beginning and end of the audio, and there is no background noise.

### Requirements for audio recordings {#requirements-audio}

If you are recording the audio using special software instead of recording in the management console via a browser, make sure that it meets the following criteria: 

| Requirement | Value |
| --- | --- |
| Sampling frequency | 48 kHz |
| Audio bit depth |  16 bit PCM |
| Number of channels | 1 (mono) |
| Format | [WAV](https://en.wikipedia.org/wiki/WAV) |
| Duration | Max. 15 seconds |
| Silence intervals at the beginning and end | 100–200 ms |

## How to record an audio via a browser {#console-record}

1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) you are going to use to work with {{ speechkit-name }}.
1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_speechkit }}**.
1. In the left-hand panel, click **{{ ui-key.yacloud.speechkit-common.brand-voice_51nd8 }}**.
1. Click **{{ ui-key.yacloud.speechkit-common.button_create-voice_nkMBz }}**.
1. Click **{{ ui-key.yacloud.speechkit-common.button_create-dataset_nLanW }}** ⟶ **{{ ui-key.yacloud.speechkit-common.brand-voice_create-dataset_option_title_record-audio_jvUMz }}**.
1. Select the data you want to record: click **Use a ready-made template** or **Upload your own texts**.
1. Click **Record audio** ⟶ **Record** next to the text and then read the text aloud.
1. Click ![circle-play](../../../_assets/console-icons/circle-play.svg) to listen to the result.
1. If your recording contains no background noise, the phrase was recorded fully, and you can hear it well, click ![floppy-disk](../../../_assets/console-icons/floppy-disk.svg) **Save**. To rerecord, click ![floppy-disk](../../../_assets/console-icons/arrow-rotate-left.svg) **New record**.
1. Record audio for the remaining texts.
1. Under **{{ ui-key.yacloud.speechkit-common.brand-voice_section_title_voice-usage_15pws }}**, read and confirm having read the [{{ speechkit-name }} Terms of Use](https://yandex.ru/legal/cloud_terms_speechkit).
1. Confirm that you have a written consent of the person whose voice is used in the audio for the use of this audio to create and use speech synthesis. 
1. Click **{{ ui-key.yacloud.speechkit-common.button_create-voice_nkMBz }}** to start creating a voice.

## How to upload a prepared dataset {#zip}

1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) you are going to use to work with {{ speechkit-name }}.
1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_speechkit }}**.
1. Click **{{ ui-key.yacloud.speechkit-common.button_create-voice_nkMBz }}**.
1. Click **{{ ui-key.yacloud.speechkit-common.button_create-dataset_nLanW }}** and select **{{ ui-key.yacloud.speechkit-common.brand-voice_create-dataset_option_title_upload-zip_nFtBR }}**.
1. Drag a ZIP archive to the upload area.

   A ZIP archive with a dataset for fine-tuning should contain:
   
   * Audio recordings in WAV format.
   * UTF-8 encoded [TSV](https://en.wikipedia.org/wiki/Tab-separated_values) table with the transcripts of recordings from the archive. The table should have two columns without headers:
      * Name of the audio file with the speaker's text.
      * Line with a verbatim transcript of the recording.

1. Under **{{ ui-key.yacloud.speechkit-common.brand-voice_section_title_voice-usage_15pws }}**, read and confirm having read the [{{ speechkit-name }} Terms of Use](https://yandex.ru/legal/cloud_terms_speechkit).
1. Confirm that you have a written consent of the person whose voice is used in the audio for the use of this audio to create and use speech synthesis. 
1. Click **{{ ui-key.yacloud.speechkit-common.button_create-voice_nkMBz }}** to start creating a voice.

If you are using [texts](https://storage.yandexcloud.net/doc-files/ml/brand_voice_lite_text_example.tsv) from the {{ speechkit-name }} command, add the name of the file with the relevant recording to the beginning of each line and delete the line with the table header.

### Example of prepared data {#example}

All texts in transcripts must fully match the ones recorded in the audio.

The table header is given as an example, it must be excluded from the uploaded file.

| recordings | text |
|---|---|
| 1.wav | Books are a uniquely portable magic. |
| 2.wav | We have an amazing book for you! |
| 3.wav | This book is suitable for children from the age of five. |

{% note warning %}

Each recording should contain a full phrase of one or several sentences. A recording cannot be longer than 15 seconds. The transcripts in the table must exactly match the text in the audio.

{% endnote %}

Each audio recording should start and end with silence, and any clipped sounds or words are not acceptable. You must not use a podcast recording cut into 15-second segments; doing so will split words and phrases, and the recordings will not match phrase boundaries. It is not possible to train a quality model on such data.

> A correct audio recording should be as follows: there are a few milliseconds of silence at the beginning and end of the audio, and the phrase is complete.

![good-audio](../../../_assets/speechkit/good-audio.png)

> A poor audio recording would be as follows: there are no silence intervals at the beginning and end of the audio, and the start and end of the phrase are cut off.

![bad-audio](../../../_assets/speechkit/bad-audio.png)

Such audio recordings will have distortions and are not suitable for model training.
