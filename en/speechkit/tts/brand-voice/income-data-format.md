# Input data format for {{ brand-voice-full-name }} Adaptive

{{ brand-voice-name }} Adaptive is a platform for training interactive robots. It synthesizes phrases based on the recordings of the speaker's voice using templates.

## Audio sample requirements {#recording}

| Requirement | Value |
| --- | --- |
| Sampling frequency | 48 kHz |
| Bit rate | 16 bit PCM |
| Channel | Mono |
| Format | .wav |

The following conditions must also be met:

* No echo.
* No background noise.
* Minimal post-processing.

### Equipment and recording requirements {#hardware}

Background noise and echo during recording directly affect the resulting quality of speech synthesis. A room equipped with acoustic panels is a great place to record audio. If recording in a household environment, echo can be reduced by soft surfaces and furniture, such as a carpet, upholstered sofa, and so on.

We recommend that you make all recordings in the same conditions and in the same room. This applies to both recording the speaker's source audio files needed for training the voice model and recording patterns.

### Speaker requirements {#dictor}

* The volume of speech in all recordings must be the same.
* All phrases must be spoken in the same manner and with the same emotion.

**Recommendations:**

* If the speaker is not a professional, we recommend recording speech for no more than 2 hours a day.
* If the speaker can't understand a phrase or they don't like it, they should skip it.
* If the speaker is not sure how to pronounce a phrase correctly or thinks that it sounds unnatural, they should skip this phrase.

## Requirements for resulting data {#data}

To train a voice model, you need:

* ZIP archive of audio recordings in [WAV](https://en.wikipedia.org/wiki/WAV) format, including:
   1. The main set (the basic bucket) consists of phrases specially prepared by the {{ yandex-cloud }} team. They must be spoken and recorded. You can't change this set. You can only skip some phrases.
   1. A set for making phrases (a specific bucket). Recorded patterns are used as texts. They are then synthesized, taking variables into account. This set is based on user data and must be reviewed before recording.

* Text transcripts of audio recordings in [TSV](https://en.wikipedia.org/wiki/Tab-separated_values) table format. The table with texts should consist of two columns:
   1. `recording`: The name of the audio file where the speaker recorded the spoken text (used as a template with a substituted variable).
   1. `text`: A line with a verbatim transcript of the audio recording. The variable part of the template must be in `{variable_name = variable_value}` format. The names of variables must be constant within the same template.

The text transcript must be in UTF-8 encoding, the table must have no title.

### Basic requirements for both datasets {#dataset-requirements}

* One phrase to one recorded audio file.
* No inaccuracies, micro repeats, reservations, and word substitutions are allowed.
* Each audio recording must have an absolutely accurate text transcript.
* Transcripts must not have any grammatical errors.
* To name files, use phrase numbers.
* Spelling must be accurate.<q></q>
* Misspelt words, such as <q>necessery</q> instead of <q>necessary</q> are not acceptable.
* Abbreviations must be denormalized (BBC -> <q>biːbiːsiː</q>) or expanded.

### Pattern requirements {#pattern-requirements}

* The pattern must match the desired script.
* The pattern must contain one or more variables to be replaced.
* The duration of a variable must match the sample in the pattern. If variables vary greatly in length, we recommend recording several patterns with examples of different lengths.
* Divide long utterances into independent sentences and different patterns.
* For each pattern, there must be at least 10 options of variables with different durations of pronunciation.
For example:

    >Hello, I'm **Anastasia** from **Yandex Cloud**.
    >
    >Hello, I'm **Anna** from **Yandex**.

### Text requirements {#text-requirements}

1. All data must be normalized, meaning that lines of text to be synthesized may not contain numbers or abbreviations like `10 Downing St.` or `USD 100`. Numbers must be written out in words and abbreviations must be spelled out.

1. In homographs where the stress may be ambiguous, it's necessary to explicitly indicate the stressed vowel with the `+` sign.

   > _<q>The +import of goods from foreign countries</q>_: The first syllable is stressed.
   > _<q>Goods they im+port from China</q>_: The second syllable is stressed.

1. In questions, it's necessary to specify which word should be \*\*logically stressed\*\* to indicate the intonation of an interrogative sentence.

   {% note warning %}

   The logical stress should not fall on the variable part of the phrase.

   {% endnote %}

   > The sentence <q>Did the cat go to the forest?</q> can be read three different ways:
   > * Did the \*\*cat\*\* go to the forest?: This means <q>Who went to the forest? Was it really the cat?</q>
   > * Did the cat  \*\*go\*\* to the forest?: This means <q>Did the cat walk or run?</q> or <q>Was the action itself performed? Is the cat gone or not?</q>
   > * Did the cat go \*\*to the forest\*\*?: This means <q>Where did the cat go or what for? To the forest, outside, to look for a sausage?</q>
   >
   > In all sentences, the logical stress emphasizes the main meaning of the sentence.

### Example of a summary text table {#example}

The table title is given as an example, it must be excluded from the uploaded file.
The file encoding is UTF-8.

| recording | text |
| --- | --- |
| 0.wav | Did \*\*the cat\*\* go {place=outside}? |
| 1.wav | Did the \*\*cat\*\* go {place=to look for a sausage}? |
| 2.wav | We are offering the wonderful book {book_name=Russian folk tales} for just \{price=one thousand one hundred roubles}. |
| 3.wav | We are offering the wonderful book {book_name=Alice's Adventures in Wonderland} for just \{price=two dollars and ninety-nine cents}. |
| 4.wav | We are offering the wonderful book {book_name=Eugene Onegin} for just \{price=five hundred rubles forty-eight kopecks}. |
| 5.wav | You are scheduled for {date=tomorrow} at \{time=fifteen oh clock}. |
| 6.wav | You are scheduled for {date=October the fourth} at \{time=nine in the morning}. |
