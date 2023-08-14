# Preparing and uploading data for {{ brand-voice-core }}

With [{{ brand-voice-core }}](index.md#ss), you can create a unique voice based on recorded audio. This voice is used for speech synthesis based on arbitrary text or [pattern-based text](../templates.md).

To create a custom {{ brand-voice-core }} voice:

1. [Prepare text data](#prepare-dataset).
1. [Record audio files](#record-audio).
1. [Upload your data](#upload).

{% note info %}

It takes up to one month to prepare a {{ brand-voice-core }} model using the uploaded data.

{% endnote %}

## Prepare text data {#prepare-dataset}

To create a {{ brand-voice-core }} voice, 5 hours of audio data with text transcripts are required. Find the volume of texts you need from your speaker's speech rate (words per minute).

> Example:
>
> The speaker's speech rate is 120 words per minute. The required volume of texts to build a model is `120 x 60 x 5 = 36,000` words.

If you plan to use pattern-based synthesis, distribute the volume of texts as follows:

* Three hours of speech for full-text synthesis.
* Two hours of speech for pattern-based synthesis.

Prepare audio transcripts as a [TSV](https://en.wikipedia.org/wiki/Tab-separated_values) table in UTF-8 encoding. The table must be without a header and consist of two columns:

1. `recording`: Name of the audio file with the speaker's text.
1. `text`: Line with a transcript of the audio recording.

>Example:
>
>The table header is given as an example, it must be excluded from the uploaded file.
>
>| recording | text |
>|---|---|
>| 0.wav | Did \*\*the cat\*\* go {place=to school}? |
>| 1.wav | Did \*\*the cat\*\* go {place=to the butcher's}? |
>| 2.wav | To stay tuned with our store's new arrivals, subscribe to our newsletter. |
>| 3.wav | We are offering the wonderful book {book_name=Alice's Adventures in Wonderland} for just \{price=two dollars and ninety-nine cents}. |
>| 4.wav | We are offering the wonderful book {book_name=Eugene Onegin} for just \{price=five hundred rubles forty-eight kopecks}. |
>| 5.wav | You are scheduled for {date=tomorrow} at \{time=fifteen oh clock}. |
>| 6.wav | You are scheduled for {date=October the fourth} at \{time=nine in the morning}. |

### Text requirements {#text-technical-requirements}

{% note info %}

The result of {{ brand-voice-core }} voice model training directly depends on training data. Be sure to meet the specified text requirements and recommendations to get a high-quality {{ brand-voice-core }} voice.

{% endnote %}

* The number of subject area terms in texts should amount to 20–30% without compromising linguistic diversity.
* The number of texts in the interrogative form should be at least 30%.
* The recommended length of a phrase is no more than {{ tts-v3-count }}.
* Texts must be free of grammatical errors.
* The text must match the one recorded in the audio file.
* If texts contain similar phrases, group them into patterns.

{% include [text requirements](../../../_includes/speechkit/tts-text-requirements.md) %}

### Pattern requirements {#pattern-requirements}

* The length of a phrase together with a variable part must not exceed {{ tts-v3-count }}.
* A pattern must contain one phrase and one or more variables for replacement.
* Variables must be marked up.

   > Pattern phrase: `Your flight is on September eight at eleven twenty, from London to Madrid`.
   > The list of variables is as follows: `variable_name = '{date}', variable_value = 'September eight at eleven twenty', `variable_name = '{route}', variable_value = 'London to Madrid'`.
   > The marked-up pattern text must be as follows: `Your flight is on {date = 'September eight at eleven twenty'}, from {route = 'London to Madrid'}.`
* For each pattern, at least 10 variable values must be provided of different duration of pronunciation.
   > Example:
   >
   > Hello, I'm **Anastasia** from **Yandex Cloud**.
   >
   > Hello, I'm **Anna** from **Yandex**.
* The names of variables must be constant within the same template.

## Record audio files {#record-audio}

{% include notitle [tips](../../../_includes/speechkit/audio-tips.md) %}

### Requirements for audio recordings {#requirements-audio}

| Requirement | Value |
| --- | --- |
| Sampling frequency | 48 kHz |
| Audio bit depth | 16 bit PCM |
| Number of channels | 1 (mono) |
| Format | [WAV](https://en.wikipedia.org/wiki/WAV) |

The silence at the beginning and end of a pattern audio recording must not be longer than one second.

Save all the audio recordings as a ZIP archive for uploading.

## Upload your data {#upload}

Use the [{{ ml-platform-full-name }}](../../../datasphere/index.yaml) interface to upload text data and audio files. For detailed guidelines on how to upload them, [fill out this form](#contact-form).

## Frequently asked questions {#faq}

#### Can I upload audio data with other characteristics? {#audio-non-standard}

You cannot upload audio data that does not meet the [requirements](#requirements-audio).

#### Where will the voice I create be available? {#where-to-get-voice}

In {{ yandex-cloud }} by `voice_id` provided in advance. Voices can be provided in {{ sk-hybrid-name }} format.

#### Can I upload a larger number of hours? {#more-hours}

Yes, you can. Potentially, this may even enhance the quality.

#### Can I upload less than 5 hours of audio? {#less-hours}

We do not recommend doing that, otherwise your {{ brand-voice-core }} voice training will be incomplete for inferior speech synthesis results.
