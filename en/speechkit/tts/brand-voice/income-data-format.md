# Input data format for {{ brand-voice-full-name }} Adaptive

{{ brand-voice-name }} Adaptive is a platform for training interactive robots. It synthesizes phrases based on the recordings of the speaker's voice using templates. They consist of two parts:

* Static part: The structure and intonation of the spoken phrase.
* Dynamic part: A variable that depends on each specific dialog.

To train a voice model, you need:

* A ZIP archive of audio recordings in [WAV](https://en.wikipedia.org/wiki/WAV) format.
* Text transcripts of audio recordings in a [TSV](https://en.wikipedia.org/wiki/Tab-separated_values) table. The table with texts should consist of two columns:
   1. `recording`: The name of the audio file where the speaker recorded the spoken text (used as a template with a substituted variable).
   1. `text`: A line with a verbatim transcript of the audio recording. The variable part of the template must be in `{variable_name = variable_value}` format. The names of variables must be constant within the same template.

## Audio file requirements {#audio-requirements}

Audio files in [LPCM](https://en.wikipedia.org/wiki/Pulse-code_modulation) format with a WAV header are accepted as input data.

Audio features:

* Sampling: 48 kHz.
* Bit depth: 16-bit.
* Byte order: Reversed (little-endian).
* Audio data is stored as signed integers.
* Number of channels: 1 (mono).

## Text requirements {#text-requirements}

1. All data must be normalized, meaning that lines of text to be synthesized may not contain numbers or abbreviations like `10 Downing St.` or `USD 100`. Numbers must be written out in words and abbreviations must be spelled out.

1. In homographs where the stress may be ambiguous, it's necessary to explicitly indicate the stressed vowel with the `+` sign.

   > _<q>The +import of goods from foreign countries</q>_: The first syllable is stressed.
   > _<q>Goods they im+port from China</q>_: The second syllable is stressed.

1. In questions, it's necessary to specify which word should be \*\*logically stressed\*\* to indicate the intonation of an interrogative sentence.

   {% note warning %}

   The interrogative intonation should only be in the static part of a phrase.

   {% endnote %}

   > The sentence <q>Did the cat go to the forest?</q> can be read three different ways:
   > * Did the \*\*cat\*\* go to the forest?: This means <q>Who went to the forest? Was it really the cat?</q>
   > * Did the cat  \*\*go\*\* to the forest?: This means <q>Did the cat walk or run?</q> or <q>Was the action itself performed? Is the cat gone or not?</q>
   > * Did the cat go \*\*to the forest\*\*?: This means <q>Where did the cat go or what for? To the forest, outside, to look for a sausage?</q>

   > In all sentences, the logical stress emphasizes the main meaning of the sentence.

### Example of a summary text table {#example}

| recording | text |
| --- | --- |
| 0.wav | Did \*\*the cat\*\* go {place=outside}? |
| 1.wav | Did the \*\*cat\*\* go {place=to look for a sausage}? |
| 2.wav | We are offering the wonderful book {book_name=Russian folk tales} for just \{price=one thousand one hundred roubles}. |
| 3.wav | We are offering the wonderful book {book_name=Alice's Adventures in Wonderland} for just \{price=two dollars and ninety-nine cents}. |
| 4.wav | We are offering the wonderful book {book_name=Eugene Onegin} for just \{price=five hundred rubles forty-eight kopecks}. |
| 5.wav | You are scheduled for {date=tomorrow} at \{time=fifteen oh clock}. |
| 6.wav | You are scheduled for {date=October the fourth} at \{time=nine in the morning}. |
