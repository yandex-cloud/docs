# TTS markup


TTS markup grants the ability to control speech synthesis using special characters and SIL tags. This helps make synthesized speech more natural.

TTS markup is supported for Russian in the [API v3](../../tts-v3/api-ref/grpc/) and [API v1](../request.md) for data in `text` format.

Pausing is available for testing in all languages the speech synthesis is supported for.

{% include [note-not-silence](../../../_includes/speechkit/note-not-silence.md) %}

## Markup components {#markup-elements}

| Description | Special characters and tags |
|---|---|
| [Mark the stress](#a) | `+` |
| [Set a pause between sentences explicitly](#pause) | `sil<[t]>`, where `t` is the pause duration in milliseconds. |
| [Set a pause depending on the context](#context-pause) | `<[small]>`. Acceptable values: `tiny`, `small`, `medium`, `large`, and `huge`. |
| [Place emphasis](#accent) | `<[accented]>` or `**emphasized word**` |
| [Use phonetic pronunciation](#phoneme) | `[[ <word_phonemes_separated_by_spaces> ]]` |

{% include [note-templates-markup](../../../_includes/speechkit/note-templates-markup.md) %}

### Mark the stress {#a}

Currently, this feature works only for Russian.

Use `+` before a stressed vowel any time you need to define the correct way to pronounce a word. Here is an example:

```text
They signed the c+ontract the following day.
```

or

```text
If you contr+act malaria, you will have to spend a long time in a hospital.
```

### Set a pause between sentences explicitly {#pause}

To set a pause between sentences explicitly, you can add a special tag, `sil<[t]>`, where `t` is the pause duration in milliseconds:

```text
Stop! sil<[300]> Think about it!
```

{% note info %}

Text to synthesize may not contain markup characters only. You cannot use {{ speechkit-name }} to generate a file with silence instead of speech.

Pauses set at the beginning and end of a sentence will be ignored.

{% endnote %}

### Set a pause depending on the context {#context-pause}

Use cue words to automatically select the duration of pauses.

```text
Frost and sun; <[medium]> a wonderful day!
```

### Place emphasis {#accent}

Currently, this feature works only for Russian.

To place emphasis on a word, you can prepend it with `<[accented]>`. For example:

```text
Convenient interfaces for your <[accented]> needs.
```

You can also use asterisks to place emphasis on one or more words (`**word**`). For example:

```text
We are **forever** responsible for what we have tamed.
```

### Use phonetic pronunciation {#phoneme}

Tag text with `[[ ]]` to ensure proper pronunciation using phonemes. The following tagged text will be used for playback:

```text
Hi! My name is [[v a sʲ ʌ]]
```

You can find the list of supported phonemes [here](tts-supported-phonemes.md).
