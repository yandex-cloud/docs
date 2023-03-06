# Pattern-based speech synthesis

Pattern-based synthesis allows you to synthesize speech based on specially prepared phrases, or _patterns_, with changeable key parts called _variables_. In pattern-based synthesis, a new phrase is synthesized integrally rather than combined of multiple pre-recorded and synthesized blocks. Speech intonations are copied from the pattern. As a result, the speech sounds naturally and cannot be told apart from real human speech.

Pattern-based synthesis is only available for [{{ brand-voice-name }}](brand-voice/index.md) voices. To get started with pattern-based synthesis, [fill out the form](#contact-form).

## Source data for pattern-based synthesis {#income-data}

Each request sent for pattern-based synthesis must include:
* An audio recording of the pattern phrase.
* Text template with markup of variable parts.
* Values of variables for synthesizing a new phrase.
* Timestamp of the beginning and end of each variable part.

> For example, let's assume you need to synthesize this phrase: `Давайте проверим бронирование. Ваш рейс восьмого сентября в одиннадцать двадцать по маршруту Москва Санкт-Петербург. Аэропорт вылета Домодедово, аэропорт прилета Пулково. Все верно?`
> Meanwhile, your pattern audio recording includes the following phrase: `Давайте проверим бронирование. Ваш рейс двадцать третьего марта в двадцать один ноль ноль по маршруту Екатеринбург Владивосток. Аэропорт вылета Кольцово, аэропорт прилета Кневичи. Все верно?`.
> The text pattern should look like this: `Let's check your booking. Ваш рейс {date} по маршруту {route}. Аэропорт вылета {source}, аэропорт прилета {destination}. Все верно?`
> The list of variables is as follows: `variable_name = '{date}', variable_value = 'восьмого сентября в одиннадцать двадцать'`, `variable_name = '{route}', variable_value = 'Москва Санкт-Петербург'`, `variable_name = '{source}', variable_value = 'Домодедово'`, `variable_name = '{destination}', variable_value = 'Пулково'`.

See examples of pattern-based synthesis in [{#T}](api/tts-templates.md).

### Requirements for pattern recordings {#requirements-audio}

| Requirement | Value |
| --- | --- |
| Sampling frequency | 48 kHz for {{ brand-voice-core-name }} and {{ brand-voice-premium-name }}</br>{{ tts-cc-quality }} or above for {{ brand-voice-cc-name }} |
| Audio bit depth | 16 bit PCM |
| Number of channels | 1 (mono) |
| Format | [WAV](https://en.wikipedia.org/wiki/WAV) |

Pattern audio recordings should not include extraneous noise or echo. Minimum post-processing of audio recordings is acceptable. The silence at the beginning and end of a recording must not be longer than one second.

### Recommendations for audio recording {#tips}

{% include notitle [tips](../../_includes/speechkit/audio-tips.md) %}

### Requirements for synthesized texts {#requirements-text}

The pattern must match the desired script.

The pattern must contain one or more variables to replace. The length of the variable portion must match the sample in the pattern. If the audio length of variable parts may vary substantially, we recommend recording several patterns with examples of different lengths.

> For example, if in the pattern `Hi, my name is Iris, I work at {company}.`, the length of the `company` variable may vary substantially (e.g., `Thunderclouds`, `Reliable Bank`, `a regional office of a well-known international company`), you will need to record two patterns: for short and for long values. Use a suitable pattern depending on the placeholder value length. This way, you can keep your synthesized speech natural.

Divide long utterances into independent sentences and different patterns. The synthesized phrase cannot exceed {{ tts-v3-time }} and {{ tts-v3-count }}.

When recording Russian speech, make sure to use the letter <q>ё</q> when needed in the pattern text. It is not acceptable to use <q>е</q> instead of <q>ё</q> in any synthesized text. In homographs where the stress may be ambiguous, you must explicitly indicate the stressed vowel with the `+` sign.
> _<q>The +import of goods from foreign countries</q>_: Stress falls on the first syllable.
> _<q>Goods they im+port from China.</q>_: Stress falls on the second syllable.

All data should be denormalized: the text strings being synthesized should not include numbers or abbreviations, such as <q>15 Smith st., bl. 3</q> or <q>RUB 13.10</q>. Make sure to speel out digits, numbers, and abbreviations. Acronyms can be left as they are.

In questions, specify which word should be \*\*logically stressed\*\* to indicate the intonation of an interrogative sentence.

{% note warning %}

The logical stress should not fall on the variable part of the phrase.

{% endnote %}

> The sentence <q>Did the cat go to the forest?</q> can be read three different ways:
> * Did the \*\*cat\*\* go to the forest? Meaning, <q>Who was it that went to the forest? Was it really the cat?</q>
> * Did the cat \*\*go\*\* to the forest? Meaning, <q>Did the cat walk or run?</q> or <q>Was the action itself performed? Is the cat gone or not?</q>
> * Did the cat go \*\*to the forest\*\*? Meaning <q>Where did the cat go and why? To the forest, outside, to look for a sausage?</q>
>
> In all sentences, the logical stress emphasizes the main meaning of the sentence.

## How to use pattern-based synthesis {#templates-implementation} 

Pattern-based synthesis is only available for [API v3](../tts-v3/api-ref/grpc/). [Example of pattern-based synthesis](api/tts-templates.md).