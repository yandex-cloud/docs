# SSML markup


With the Speech Synthesis Markup Language (SSML), you can control how {{ speechkit-name }} synthesizes speech from text.

{% include [note-not-silence](../../../_includes/speechkit/note-not-silence.md) %}

SSML is supported only when using [API v1](../request.md).

To provide text in SSML format, use the `ssml` parameter in the request body and wrap the text itself in the `<speak>` tag:

{% include [ssml-example](../../../_includes/speechkit/ssml-example.md) %}

[Example of sending a request](../request.md#ssml).

## Supported SSML tags {#supported-SSML-tags}

Currently, {{ speechkit-name }} supports the following SSML tags:

| Description                                           | Tag         |
|----------------------------------------------------|-------------|
| [Add a pause](#break)                           | `<break>`   |
| [Add a pause between paragraphs](#p)             | `<p>`       |
| [Use phonetic pronunciation](#phoneme) | `<phoneme>` |
| [Root tag for SSML text](#speak)   | `<speak>`   |
| [Add a pause between sentences](#s)           | `<s>`       |
| [Abbreviation pronunciation](#sub)                   | `<sub>`     |

### break {#break}

Use the `<break>` tag to add a pause with a specified duration to the speech. The duration is specified using the `strength` and `time` attributes. If these attributes are not set, the `strength="medium"` value is used by default.

Attribute | Description
----- | -----
`strength` | Pause duration, depends on the context. Acceptable values:<br>* `weak`: Short pause up to 250 milliseconds.<br>* `medium`: Medium pause up to 400 milliseconds.<br>* `strong`: Equivalent to the pause after a fullstop or [sentence](#s).<br>* `x-strong`: Equivalent to the pause after a [paragraph](#p).<br>* `none` or `x-weak`: These are not adding any pause but are left for AWS API compatibility.
`time` | Pause duration in seconds or milliseconds, e.g., `2s` or `400ms`. The maximum pause duration is five seconds.<br>When synthesizing a pause of specified length, the possible error is 100-200 ms.

```xml
<speak>Hey, wait a second<break time="1s"/> What are you doing?</speak>
```

The `<break>` tag adds a pause even if it comes after other pause-adding elements, e.g., periods and commas.

### p {#p}

Use the `<p>` tag to add a pause between paragraphs. A pause is added after the closing tag.

A pause after a paragraph is longer than a pause after a [sentence](#s) or period. The duration of a pause depends on the selected voice, emotional tone, speed, and language.

```xml
<speak>
  <p>The executioner's argument was that you couldn't cut off something's head unless there was a trunk to sever it from.</p>
  <p>The King's argument was that anything that had a head could be beheaded, and that you weren't to talk nonsense.</p>
  <p>The Queen's argument was that if something wasn't done about it in less than no time, she'd have everyone beheaded all round. It was this last argument that had everyone looking so nervous and uncomfortable.</p>
</speak>
```

All pauses inside the tag are also taken into account. For example, an additional pause will be added for a period, even if it comes before the closing tag.

### phoneme {#phoneme}

Use the `<phoneme>` tag to control proper pronunciation using phonemes. The text specified in the `ph` attribute will be used for playback. In the `alphabet` attribute, specify the preferred standard: `ipa` or `x-sampa`.

* International phonetic alphabet ([IPA](https://en.wikipedia.org/wiki/International_Phonetic_Alphabet))

  ```xml
  <speak>
        In different regions of Russia, the letter <phoneme alphabet="ipa" ph="o">O</phoneme> is pronounced differently in words.
        
        In some areas, people say <phoneme alphabet="ipa" ph="məlɐko">молоко</phoneme>, while in others, <phoneme alphabet="ipa" ph="mələko">молоко</phoneme>.
        
  </speak>
  ```

* Extended Speech Assessment Methods Phonetic Alphabet ([X-SAMPA](https://en.wikipedia.org/wiki/X-SAMPA))

  ```xml
  <speak>
        In different regions of Russia, the letter <phoneme alphabet="x-sampa" ph="o">O</phoneme> is pronounced differently in words.
        
        In some areas, people say <phoneme alphabet="x-sampa" ph="m@l6ko">молоко</phoneme>, while in others, <phoneme alphabet="x-sampa" ph="m@l@ko">молоко</phoneme>.
        
  </speak>
  ```

You can find the list of supported phonemes [here](ssml-supported-phonemes.md).

### speak {#speak}

`<speak>` is the root tag. The whole text must be inside this tag.

```xml
<speak>My text in SSML format.</speak>
```

### s {#s}

Use the `<s>` tag to add a pause between sentences. A pause after a sentence is the same as a pause after a period. The duration of a pause depends on the selected voice, emotional tone, speed, and language.

```xml
<speak>
  <s>First sentence</s>
  <s>Second sentence</s>
</speak>
```

All pauses inside the tag are also taken into account. For example, an additional pause will be added in place of a period even if it is before the closing tag.

### sub {#sub}

Use the `<sub>` tag to replace one text with another when pronouncing it. For example, you could use it to correctly pronounce an abbreviation or the name of a chemical element.

```xml
<speak>
  My favorite chemical element is <sub alias="mercury">Hg</sub> because it is shiny.
</speak>
```
