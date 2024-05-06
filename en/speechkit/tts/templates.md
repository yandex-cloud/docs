# Pattern-based speech synthesis

With pattern-based synthesis, you can synthesize speech based on pre-edited phrases, or _patterns_, with changeable key parts called _variables_. A new phrase is synthesized integrally instead of combining multiple pre-recorded and synthesized blocks. Speech intonations are copied from the pattern. This makes speech sound natural – just like real human speech.

Pattern-based synthesis is only available for [{{ brand-voice-name }}](brand-voice/index.md) voices.


{% note warning %}

Access to the {{ brand-voice-name }} service is available on request. To get access to the technology, [fill out this form](#contact-form).

{% endnote %}


Currently, this feature works only for Russian.

## Source data for pattern-based synthesis {#income-data}

Each request sent for pattern-based synthesis must include:

* An audio recording of the pattern phrase.
* Text template with markup of variable parts.
* Values of variables for synthesizing a new phrase.
* Timestamp of the beginning and end of each variable part.

> Let's assume you need to synthesize this phrase: `Let's check your booking. Your flight is at eleven twenty, September eight, from London to Madrid. You depart from Heathrow and arrive at Barajas. Is everything correct?`
> Your pattern audio recording contains the following phrase: `Let's check your booking. Your flight is at nine, March twenty-three, from Paris to Lisbon. You depart from Charles de Gaulle and arrive at Humberto Delgado. Is everything correct?`
> The text pattern should look like this: `Let's check your booking. Your flight is at {date}, {route}. You depart from {source} and arrive at {destination}. Is everything correct?`
> List of variables: `variable_name = '{date}', variable_value = 'eleven twenty, September eight'`, `variable_name = '{route}', variable_value = 'from London to Madrid'`, `variable_name = '{source}', variable_value = 'Heathrow'`, `variable_name = '{destination}', variable_value = 'Barajas'`.

Learn more about [examples of pattern-based synthesis](#templates-implementation).

### Requirements for pattern recordings {#requirements-audio}

| Requirement | Value |
| --- | --- |
| Sampling frequency | 48 kHz for {{ brand-voice-core-name }} and {{ brand-voice-premium-name }}</br>{{ tts-cc-quality }} or above for {{ brand-voice-cc-name }} |
| Audio bit depth | 16 bit PCM |
| Number of channels | 1 (mono) |
| Format | [WAV](https://en.wikipedia.org/wiki/WAV) |
| Minimum pattern audio recording duration | 1 second |

Pattern audio recordings should not include extraneous noise or echo. Minimum post-processing of audio recordings is acceptable. The silence at the beginning and end of a recording must not be longer than one second.

### Recommendations for audio recording {#tips}

{% include notitle [tips](../../_includes/speechkit/audio-tips.md) %}

### Requirements for synthesized texts {#requirements-text}

The pattern must match the desired script.

The pattern must contain one or more variables to replace. The length of the variable portion must match the sample in the pattern. If the audio length of variable parts may vary substantially, we recommend recording several patterns with examples of different lengths.

> For example, if in the pattern `Hi, my name is Iris, I work at {company}.`, the length of the `company` variable may vary substantially (e.g., `Thunderclouds`, `Reliable Bank`, `a regional office of a well-known international company`), you will need to record two patterns: for short and for long values. Use a suitable pattern depending on the placeholder value length. This way, you can keep your synthesized speech natural.

Divide long utterances into independent sentences and different patterns. The synthesized phrase cannot exceed {{ tts-v3-time }} and {{ tts-v3-count }}.

{% include [text requirements](../../_includes/speechkit/tts-text-requirements.md) %}

{% note warning %}

The logical stress should not fall on the variable part of the phrase.

{% endnote %}

## How to use pattern-based synthesis {#templates-implementation}

* API v3:

   * [{{ brand-voice-premium }} and {{ brand-voice-core }}](api/tts-templates.md).
   * [{{ brand-voice-cc-name }}](api/tts-templates-bvcc.md)​.

