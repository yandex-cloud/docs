# TTS markup

TTS markup grants the ability to control speech synthesis using special characters and SIL tags. This helps make synthesized speech more natural.

Support for TTS markup is available for Russian in [API v3](../../tts-v3/api-ref/grpc/) and [API v1](../request.md) for data in `text` format.

Pausing is available for testing in all languages the speech synthesis is supported for.

{% include [note-not-silence](../../../_includes/speechkit/note-not-silence.md) %}

## Markup components {#markup-elements}

| Description | Special characters and tags |
|---|---|
| [Apply stress](#a) | `+` |
| [Explicitly define a pause between sentences](#pause) | `sil<[t]>`, where t is the pause in milliseconds. |
| [Define a pause depending on the context](#context-pause) | `<[small]>`. Acceptable values: `tiny`, `small`, `medium`, `large`, `huge` |
| [Place emphasis](#accent) | `<[accented]>` or `**emphasized word**` |
| [Use phonetic pronunciation](#phoneme) | `[[ <word phonemes separated with spaces> ]]` |

### Apply stress {#a}

Use `+` before a stressed vowel any time you need to define the correct way to pronounce a word, such as:

```text
They signed the c+ontract the following day.
```

or

```text
If you contr+act malaria, you will have to spend a long time in a hospital.
```

### Explicitly define a pause between sentences {#pause}

To explicitly define a pause between sentences, you can add a special tag, `sil<[t]>`, where t is the duration of the pause in milliseconds:

```text
Stop. sil<[300]> Think about it!
```

{% note info %}

Text to synthesize may not contain markup characters only. You cannot use {{ speechkit-name }} to generate a file with silence instead of speech.

{% endnote %}

### Set a pause depending on the context {#context-pause}

Use cue words to automatically select the duration of pauses.

```
Frost and sun; <[medium]> a wonderful day!
```

### Place emphasis {#accent}

To define emphasis, you can use the `<[accented]>` tag or highlight a word like this: ``**accented**``. For example:

```text
Convenient interfaces for solving <[problems]>.
```

or

```text
You become responsible **forever** for what you have tamed.
```


### Use phonetic pronunciation {#phoneme}

Tag text with `[[ ]]` to check the proper pronunciation using phonemes. The following tagged text will be used for playback:

```text
Hello, My name is [[v a sʲ ʌ]]
```

You can find the list of supported phonemes [here](tts-supported-phonemes.md).

