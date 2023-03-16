# TTS markup

TTS markup grants the ability to control speech synthesis using special characters and SIL tags. This helps make synthesized speech more natural.

{% if product == "yandex-cloud" %}
Support for TTS markup is available for Russian in the [API v1](request.md) when transmitting data in `text` format and in the API v3.
{% endif %}

## Markup components {#markup-elements}

| Description | Special characters and tags |
|---------------------------------------------------------| -------------------------------------------------------------- |
| [Apply stress](#a) | `+` |
| [Explicitly define a pause between sentences](#pause) | `sil<[t]>`, where t is the pause in milliseconds. |
| [Define a pause depending on the context](#context-pause) | `<[small]>`. Acceptable values: `tiny`, `small`, `medium`, `large`, `huge` |
| [Place emphasis](#accent) | `<[accented]>` or `**emphasized word**` |

### Apply stress {#a}

Use `+` before a stressed vowel any time you need to define the correct way to pronounce a word, such as:

```
They signed the c+ontract the following day.
```

or

```
If you contr+act malaria, you will have to spend a long time in a hospital.
```

### Explicitly define a pause between sentences {#pause}

To explicitly define a pause between sentences, you can add a special tag, `sil<[t]>`, where t is the duration of the pause in milliseconds:

```
Stop. sil<[300]> Think about it!
```

### Set a pause depending on the context {#context-pause}

Use cue words to automatically select the duration of pauses.

```
Frost and sun; <[medium]> a wonderful day!
```

### Place emphasis {#accent}

To define emphasis, you can use the `<[accented]>` tag or highlight a word like this: ``**accented**``. For example:

```
Convenient interfaces for solving <[problems]>.
```

or

```
You become responsible **forever** for what you have tamed.
```

