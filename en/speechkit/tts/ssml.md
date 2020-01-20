# Using SSML

With the Speech Synthesis Markup Language (SSML), you can control how {{ speechkit-name }} synthesizes speech from text.

To pass text in SSML format, use the `ssml` parameter in the request body and wrap the text in the `<speak>` tag:

{% include [ssml-example](../../_includes/speechkit/ssml-example.md) %}

[Example of sending a request](request.md#ssml).

## Supported SSML tags {#Supported-SSML-tags}

Currently, {{ speechkit-name }} supports the following SSML tags:

| Description | Tag |
| ----- | ----- |
| [Add a pause](#break) | `<break>` |
| [Add a pause between paragraphs](#p) | `<p>` |
| [Use phonetic pronunciation](#phoneme) | `<phoneme>` |
| [Root tag for SSML text](#speak) | `<speak>` |
| [Add a pause between sentences](#s) | `<s>` |
| [Abbreviation pronunciation](#sub) | `<sub>` |

### break {#break}

Use the `<break>` tag to add a pause with a specified duration to the speech. The duration is specified using the `strength` and `time` attributes. If these attributes aren't set, the `strength="medium"` value is used by default.

| Attribute | Description |
| ----- | ----- |
| `strength` | Pause duration. Acceptable values:<br>* `medium` or `weak` — Equivalent to the pause after a comma.<br>* `strong` — Equivalent to the pause after a period or a [sentence](#s).<br>* `x-strong` — Equivalent to the pause after a [paragraph](#p).<br>* `none` or `x-weak` — These values don't add any pause, they are kept for AWS API compatibility. |
| `time` | Pause duration in seconds or milliseconds, for example `2s` or `400ms`. The maximum pause duration is 5 seconds.<br>When synthesizing pauses for specified lengths, there may be an error of 100-200 ms. |

```xml
<speak>Hey, wait a second<break time="1s"/> What are you doing?</speak>
```

The `<break>` tag adds a pause even if it comes after other elements that already add a pause, such as periods and commas.

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

All pauses inside the tag are also taken into account. For example, an additional pause will be added in place of a period even if it's before the closing tag.

### phoneme {#phoneme}

Use the `<phoneme>` tag to check the proper pronunciation using phonemes. The text specified in the `ph` attribute will be used for playback. In the `alphabet` attribute, specify which standard to use: `ipa` or `x-sampa`.

* International phonetic alphabet ([IPA](https://en.wikipedia.org/wiki/International_Phonetic_Alphabet))

  ```xml
  <speak>
        In different regions of Russia, the letter
        <phoneme alphabet="ipa" ph="o">О</phoneme> when it's in a word is pronounced differently.
        Somewhere they say <phoneme alphabet="ipa" ph="məlɐko">молоко</phoneme>,
        whereas elsewhere they say <phoneme alphabet="ipa" ph="mələko">молоко</phoneme>.
  </speak>
  ```

* Extended Speech Assessment Methods Phonetic Alphabet ([X-SAMPA](https://en.wikipedia.org/wiki/X-SAMPA))

  ```xml
  <speak>
        In different regions of Russia, the letter
        <phoneme alphabet="x-sampa" ph="o">О</phoneme> when it's in a word is pronounced differently.
        Somewhere they say <phoneme alphabet="x-sampa" ph="m@l6ko">молоко</phoneme>,
        whereas elsewhere they say <phoneme alphabet="x-sampa" ph="m@l@ko">молоко</phoneme>.
  </speak>
  ```

[The list of supported phonemes for each language](supported-phonemes.md).

### speak {#speak}

`<speak>` is the root tag. The entire text must contained inside this tag.

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

All pauses inside the tag are also taken into account. For example, an additional pause will be added in place of a period even if it's before the closing tag.

### sub {#sub}

Use the `<sub>` tag to replace one text with another when pronouncing it. For example, to correctly pronounce an abbreviation or the name of a chemical element.

```xml
<speak>
  My favorite chemical element  is <sub alias="Mercury">Hg</sub> because it's shiny.
</speak>
```

