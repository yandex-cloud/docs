# Speechkit

## Text to speech

### *class* yandex\_ai\_studio\_sdk.\_speechkit.text\_to\_speech.result.**TextToSpeechResult**{#yandex_ai_studio_sdk._speechkit.text_to_speech.result.TextToSpeechResult}

A class representing result of a speech generation request.

In case of different run modes could contain one chunk of data or several data chunks. Class provides identical interface for both cases.

Also have a rich representation in Jupyter Notebooks.

**chunks**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[TextToSpeechChunk](#yandex_ai_studio_sdk._speechkit.text_to_speech.result.TextToSpeechChunk)*]... ,{#yandex_ai_studio_sdk._speechkit.text_to_speech.result.TextToSpeechResult.chunks}

*property* **data**\: *[bytes](https://docs.python.org/3/library/stdtypes.html#bytes)*{#yandex_ai_studio_sdk._speechkit.text_to_speech.result.TextToSpeechResult.data}

*property* **text**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._speechkit.text_to_speech.result.TextToSpeechResult.text}

*property* **start\_ms**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_ai_studio_sdk._speechkit.text_to_speech.result.TextToSpeechResult.start_ms}

*property* **length\_ms**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_ai_studio_sdk._speechkit.text_to_speech.result.TextToSpeechResult.length_ms}

*property* **end\_ms**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_ai_studio_sdk._speechkit.text_to_speech.result.TextToSpeechResult.end_ms}

*property* **size\_bytes**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_ai_studio_sdk._speechkit.text_to_speech.result.TextToSpeechResult.size_bytes}

*property* **audio\_format**\: *[AudioFormat](#yandex_ai_studio_sdk._speechkit.enums.AudioFormat) | [UnknownEnumValue](other.md#yandex_ai_studio_sdk._types.schemas.yandex_ai_studio_sdk._types.enum.UnknownEnumValue)[[AudioFormat](#yandex_ai_studio_sdk._speechkit.enums.AudioFormat)*]{#yandex_ai_studio_sdk._speechkit.text_to_speech.result.TextToSpeechResult.audio_format}

### *class* yandex\_ai\_studio\_sdk.\_speechkit.text\_to\_speech.result.**TextToSpeechChunk**{#yandex_ai_studio_sdk._speechkit.text_to_speech.result.TextToSpeechChunk}

Result chunk of text to speech generation

**data**\: *[bytes](https://docs.python.org/3/library/stdtypes.html#bytes)*{#yandex_ai_studio_sdk._speechkit.text_to_speech.result.TextToSpeechChunk.data}

**text**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._speechkit.text_to_speech.result.TextToSpeechChunk.text}

**start\_ms**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_ai_studio_sdk._speechkit.text_to_speech.result.TextToSpeechChunk.start_ms}

**length\_ms**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_ai_studio_sdk._speechkit.text_to_speech.result.TextToSpeechChunk.length_ms}

*property* **end\_ms**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_ai_studio_sdk._speechkit.text_to_speech.result.TextToSpeechChunk.end_ms}

*property* **size\_bytes**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_ai_studio_sdk._speechkit.text_to_speech.result.TextToSpeechChunk.size_bytes}

## Speech to text

### *class* yandex\_ai\_studio\_sdk.\_speechkit.speech\_to\_text.result.top\_containers.**Utterance**{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.Utterance}

A class representing result of speech recognition request for one utterance in specific audio channel.

Boundaries of this utterance is determined by end of utterance classifier setting, silence duration between utterances or external **stream.eou()** calls

**events**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[SpeechToTextStreamingEvent](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEvent)*]... ,{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.Utterance.events}

all events from this utterance for debugging purposes

**classifiers**\: *[dict](https://docs.python.org/3/library/stdtypes.html#dict)[[str](https://docs.python.org/3/library/stdtypes.html#str), [ClassifierResult](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.classifier.ClassifierResult)*]{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.Utterance.classifiers}

classifier results for this utterance, only on\_utterance classifiers

**speaker\_analysis**\: *[SpeakerAnalysis](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.speaker_analysis.SpeakerAnalysis) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.Utterance.speaker_analysis}

speker analysis for this utterance

**timespan**\: *[TimeSpan](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.utils.TimeSpan)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.Utterance.timespan}

Utterance time boundaries

**finals**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[Alternatives](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.alternatives.Alternatives)*]... ,{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.Utterance.finals}

All final alternatives from this utterance

**final\_refinements**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[FinalRefinement](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.alternatives.FinalRefinement)*]... ,{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.Utterance.final_refinements}

All refined final alternatives from this utterance

**final\_classifiers**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[FinalClassifierResult](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.classifier_final.FinalClassifierResult)*]... ,{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.Utterance.final_classifiers}

classifier results, tied to final event, only on\_final classifiers

*property* **final\_text**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.Utterance.final_text}

Joined text of all final events in this utterance`

*property* **final\_refinement\_text**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.Utterance.final_refinement_text}

Joined text of all final\_refinement events if there are any

*property* **text**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.Utterance.text}

final\_refinement\_text or final\_text

### *class* yandex\_ai\_studio\_sdk.\_speechkit.speech\_to\_text.result.top\_containers.**ChannelResult**{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.ChannelResult}

A class representing result of speech recognition request for one audio channel

**tag**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.ChannelResult.tag}

**utterances**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[Utterance](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.Utterance)*]... ,{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.ChannelResult.utterances}

All utterances from this channel

**speaker\_analysis**\: *[SpeakerAnalysis](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.speaker_analysis.SpeakerAnalysis) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.ChannelResult.speaker_analysis}

Speech statistics for this channel with window\_type=TOTAL

*property* **final\_text**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.ChannelResult.final_text}

Joined text of all final events in this channel

*property* **final\_refinement\_text**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.ChannelResult.final_refinement_text}

Joined text of all final\_refinement events if there are any

*property* **text**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.ChannelResult.text}

final\_refinement\_text or final\_text

**count**(*value*) → integer -- return number of occurrences of value{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.ChannelResult.count}

**index**(*value*[, *start*[, *stop*]]) → integer -- return first index of value.{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.ChannelResult.index}

Raises ValueError if the value is not present.

Supporting start and stop arguments is optional, but recommended.

### *class* yandex\_ai\_studio\_sdk.\_speechkit.speech\_to\_text.result.top\_containers.**SpeechToTextResult**{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.SpeechToTextResult}

A class representing result of speech recognition request.

Main thing it contains – one or more channel results. In case of one channel, you could use a proxy-properties to access channel result.

Lets assume we have a some speech to text result. It doesn’t matter how I creating it in this example, but I need to do it for doctesting purposes.

```python
>>> first_result = ChannelResult(utterances=(), speaker_analysis=None, tag="222_first")
>>> result = SpeechToTextResult(
...    _sdk=None,
...    uuid='123',
...    user_request_id='234',
...    conversation_analysis=None,
...    llm_post_process_result=None,
...    unknown_events=(),
...    status_events=(),
...    channels={
...        '222_first': first_result,
...    }
... )
```

Example of proxy-properties:

```python
>>> text = result.text
>>> final_text = result.text
```

Let’s add another channel result:

```python
>>> second_result = ChannelResult(utterances=(), speaker_analysis=1, tag="111_second")
>>> result.channels['111_second'] = second_result
```

```python
>>> text = result.text
Traceback (most recent call last):
    ...
ValueError: property proxy ... is not available in case of 2+ channels in result
```

And here is example for how to access channel results from result:

We can get it by channel tag:

```python
>>> assert result['222_first'] == result.channels['222_first'] is first_result
```

We can access it by channel “index” which we calculate based on alphabetical sorting of channel tags (catch is, usually tags is match indices i.e. when tag==’0’, corresponding index will be also 0, but in this example I intentionally put reversed tags):

```python
>>> assert result[0] == result.get_channel(0) is second_result
>>> assert result[-1] == result.get_channel(-1) is first_result
```

Also you can use slices:

```python
>>> assert result[0:2] == (second_result, first_result)
```

And you could iterate over channels:

```python
>>> assert list(result) == [second_result, first_result]
```

**unknown\_events**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[SpeechToTextStreamingEvent](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEvent)*]... ,{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.SpeechToTextResult.unknown_events}

**status\_events**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[SpeechToTextStreamingEvent](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEvent)*]... ,{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.SpeechToTextResult.status_events}

**channels**\: *[dict](https://docs.python.org/3/library/stdtypes.html#dict)[[str](https://docs.python.org/3/library/stdtypes.html#str), [ChannelResult](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.ChannelResult)*]{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.SpeechToTextResult.channels}

**get\_channel**(*sequential\_number*){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.SpeechToTextResult.get_channel}

Get channel by it’s sequential number among all channels, sorted by its tags

#|
|| Parameters | **sequential\_number** ([*int*](https://docs.python.org/3/library/functions.html#int)) ||
|| Return type | [*ChannelResult*](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.ChannelResult) ||
|#

*property* **final\_text**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.SpeechToTextResult.final_text}

Return final text of first channel.

Raises if result have more than one channel.

*property* **final\_refinement\_text**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.SpeechToTextResult.final_refinement_text}

Return final text of first channel.

Raises if result have more than one channel.

*property* **text**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.SpeechToTextResult.text}

Return final text of first channel.

Raises if result have more than one channel.

*property* **speaker\_analysis**\: *[SpeakerAnalysis](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.speaker_analysis.SpeakerAnalysis) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.SpeechToTextResult.speaker_analysis}

Return speaker\_analysis for the first channel.

Raises if result have more than one channel.

**count**(*value*) → integer -- return number of occurrences of value{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.SpeechToTextResult.count}

**index**(*value*[, *start*[, *stop*]]) → integer -- return first index of value.{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.SpeechToTextResult.index}

Raises ValueError if the value is not present.

Supporting start and stop arguments is optional, but recommended.

**role**\: *ClassVar[[str](https://docs.python.org/3/library/stdtypes.html#str)*] = *'user'*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.SpeechToTextResult.role}

Field role is required to be compatible with TextMessage Protocol, to other part of SDK could use this object an input.

**uuid**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.SpeechToTextResult.uuid}

Internal session identifier.

**user\_request\_id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.SpeechToTextResult.user_request_id}

User session identifier.

**conversation\_analysis**\: *[ConversationAnalysis](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.conversation_analysis.ConversationAnalysis) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.SpeechToTextResult.conversation_analysis}

Conversation statistics

**llm\_post\_process\_result**\: *[LLMPostProcessResult](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.llm_post_process_result.LLMPostProcessResult) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.SpeechToTextResult.llm_post_process_result}

Result of llm post\_process, may be also known as *Summarization* at some old documentation.

### *class* yandex\_ai\_studio\_sdk.\_speechkit.speech\_to\_text.result.top\_containers.**DeferredSpeechToTextBaseResult**{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.DeferredSpeechToTextBaseResult}

DeferredSpeechToTextBaseResult(\_sdk: ‘SDKType’, uuid: ‘str’, user\_request\_id: ‘str’, conversation\_analysis: ‘ConversationAnalysis | None’, llm\_post\_process\_result: ‘LLMPostProcessResult | None’, unknown\_events: ‘tuple[SpeechToTextStreamingEvent, …]’, status\_events: ‘tuple[SpeechToTextStreamingEvent, …]’, channels: ‘dict[str, ChannelResult]’, operation\_id: ‘str’)

**operation\_id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.DeferredSpeechToTextBaseResult.operation_id}

**count**(*value*) → integer -- return number of occurrences of value{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.DeferredSpeechToTextBaseResult.count}

*property* **final\_refinement\_text**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.DeferredSpeechToTextBaseResult.final_refinement_text}

Return final text of first channel.

Raises if result have more than one channel.

*property* **final\_text**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.DeferredSpeechToTextBaseResult.final_text}

Return final text of first channel.

Raises if result have more than one channel.

**get\_channel**(*sequential\_number*){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.DeferredSpeechToTextBaseResult.get_channel}

Get channel by it’s sequential number among all channels, sorted by its tags

#|
|| Parameters | **sequential\_number** ([*int*](https://docs.python.org/3/library/functions.html#int)) ||
|| Return type | [*ChannelResult*](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.ChannelResult) ||
|#

**index**(*value*[, *start*[, *stop*]]) → integer -- return first index of value.{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.DeferredSpeechToTextBaseResult.index}

Raises ValueError if the value is not present.

Supporting start and stop arguments is optional, but recommended.

**role**\: *ClassVar[[str](https://docs.python.org/3/library/stdtypes.html#str)*] = *'user'*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.DeferredSpeechToTextBaseResult.role}

Field role is required to be compatible with TextMessage Protocol, to other part of SDK could use this object an input.

*property* **speaker\_analysis**\: *[SpeakerAnalysis](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.speaker_analysis.SpeakerAnalysis) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.DeferredSpeechToTextBaseResult.speaker_analysis}

Return speaker\_analysis for the first channel.

Raises if result have more than one channel.

*property* **text**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.DeferredSpeechToTextBaseResult.text}

Return final text of first channel.

Raises if result have more than one channel.

**unknown\_events**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[SpeechToTextStreamingEvent](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEvent)*]... ,{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.DeferredSpeechToTextBaseResult.unknown_events}

**status\_events**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[SpeechToTextStreamingEvent](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEvent)*]... ,{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.DeferredSpeechToTextBaseResult.status_events}

**channels**\: *[dict](https://docs.python.org/3/library/stdtypes.html#dict)[[str](https://docs.python.org/3/library/stdtypes.html#str), [ChannelResult](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.ChannelResult)*]{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.DeferredSpeechToTextBaseResult.channels}

**uuid**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.DeferredSpeechToTextBaseResult.uuid}

Internal session identifier.

**user\_request\_id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.DeferredSpeechToTextBaseResult.user_request_id}

User session identifier.

**conversation\_analysis**\: *[ConversationAnalysis](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.conversation_analysis.ConversationAnalysis) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.DeferredSpeechToTextBaseResult.conversation_analysis}

Conversation statistics

**llm\_post\_process\_result**\: *[LLMPostProcessResult](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.llm_post_process_result.LLMPostProcessResult) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.DeferredSpeechToTextBaseResult.llm_post_process_result}

Result of llm post\_process, may be also known as *Summarization* at some old documentation.

### *class* yandex\_ai\_studio\_sdk.\_speechkit.speech\_to\_text.result.top\_containers.**AsyncDeferredSpeechToTextResult**{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.AsyncDeferredSpeechToTextResult}

*async* **delete**(*timeout=60*){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.AsyncDeferredSpeechToTextResult.delete}

Deletes results of asynchronous recognition.

#|
|| Parameters | **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) ||
|| Return type | None ||
|#

**count**(*value*) → integer -- return number of occurrences of value{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.AsyncDeferredSpeechToTextResult.count}

*property* **final\_refinement\_text**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.AsyncDeferredSpeechToTextResult.final_refinement_text}

Return final text of first channel.

Raises if result have more than one channel.

*property* **final\_text**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.AsyncDeferredSpeechToTextResult.final_text}

Return final text of first channel.

Raises if result have more than one channel.

**get\_channel**(*sequential\_number*){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.AsyncDeferredSpeechToTextResult.get_channel}

Get channel by it’s sequential number among all channels, sorted by its tags

#|
|| Parameters | **sequential\_number** ([*int*](https://docs.python.org/3/library/functions.html#int)) ||
|| Return type | [*ChannelResult*](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.ChannelResult) ||
|#

**index**(*value*[, *start*[, *stop*]]) → integer -- return first index of value.{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.AsyncDeferredSpeechToTextResult.index}

Raises ValueError if the value is not present.

Supporting start and stop arguments is optional, but recommended.

**role**\: *ClassVar[[str](https://docs.python.org/3/library/stdtypes.html#str)*] = *'user'*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.AsyncDeferredSpeechToTextResult.role}

Field role is required to be compatible with TextMessage Protocol, to other part of SDK could use this object an input.

*property* **speaker\_analysis**\: *[SpeakerAnalysis](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.speaker_analysis.SpeakerAnalysis) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.AsyncDeferredSpeechToTextResult.speaker_analysis}

Return speaker\_analysis for the first channel.

Raises if result have more than one channel.

*property* **text**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.AsyncDeferredSpeechToTextResult.text}

Return final text of first channel.

Raises if result have more than one channel.

**operation\_id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.AsyncDeferredSpeechToTextResult.operation_id}

**unknown\_events**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[SpeechToTextStreamingEvent](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEvent)*]... ,{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.AsyncDeferredSpeechToTextResult.unknown_events}

**status\_events**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[SpeechToTextStreamingEvent](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEvent)*]... ,{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.AsyncDeferredSpeechToTextResult.status_events}

**channels**\: *[dict](https://docs.python.org/3/library/stdtypes.html#dict)[[str](https://docs.python.org/3/library/stdtypes.html#str), [ChannelResult](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.ChannelResult)*]{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.AsyncDeferredSpeechToTextResult.channels}

**uuid**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.AsyncDeferredSpeechToTextResult.uuid}

Internal session identifier.

**user\_request\_id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.AsyncDeferredSpeechToTextResult.user_request_id}

User session identifier.

**conversation\_analysis**\: *[ConversationAnalysis](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.conversation_analysis.ConversationAnalysis) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.AsyncDeferredSpeechToTextResult.conversation_analysis}

Conversation statistics

**llm\_post\_process\_result**\: *[LLMPostProcessResult](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.llm_post_process_result.LLMPostProcessResult) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.AsyncDeferredSpeechToTextResult.llm_post_process_result}

Result of llm post\_process, may be also known as *Summarization* at some old documentation.

### *class* yandex\_ai\_studio\_sdk.\_speechkit.speech\_to\_text.result.top\_containers.**DeferredSpeechToTextResult**{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.DeferredSpeechToTextResult}

**count**(*value*) → integer -- return number of occurrences of value{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.DeferredSpeechToTextResult.count}

*property* **final\_refinement\_text**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.DeferredSpeechToTextResult.final_refinement_text}

Return final text of first channel.

Raises if result have more than one channel.

*property* **final\_text**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.DeferredSpeechToTextResult.final_text}

Return final text of first channel.

Raises if result have more than one channel.

**get\_channel**(*sequential\_number*){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.DeferredSpeechToTextResult.get_channel}

Get channel by it’s sequential number among all channels, sorted by its tags

#|
|| Parameters | **sequential\_number** ([*int*](https://docs.python.org/3/library/functions.html#int)) ||
|| Return type | [*ChannelResult*](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.ChannelResult) ||
|#

**index**(*value*[, *start*[, *stop*]]) → integer -- return first index of value.{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.DeferredSpeechToTextResult.index}

Raises ValueError if the value is not present.

Supporting start and stop arguments is optional, but recommended.

**role**\: *ClassVar[[str](https://docs.python.org/3/library/stdtypes.html#str)*] = *'user'*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.DeferredSpeechToTextResult.role}

Field role is required to be compatible with TextMessage Protocol, to other part of SDK could use this object an input.

*property* **speaker\_analysis**\: *[SpeakerAnalysis](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.speaker_analysis.SpeakerAnalysis) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.DeferredSpeechToTextResult.speaker_analysis}

Return speaker\_analysis for the first channel.

Raises if result have more than one channel.

*property* **text**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.DeferredSpeechToTextResult.text}

Return final text of first channel.

Raises if result have more than one channel.

**operation\_id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.DeferredSpeechToTextResult.operation_id}

**unknown\_events**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[SpeechToTextStreamingEvent](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEvent)*]... ,{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.DeferredSpeechToTextResult.unknown_events}

**status\_events**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[SpeechToTextStreamingEvent](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEvent)*]... ,{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.DeferredSpeechToTextResult.status_events}

**channels**\: *[dict](https://docs.python.org/3/library/stdtypes.html#dict)[[str](https://docs.python.org/3/library/stdtypes.html#str), [ChannelResult](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.ChannelResult)*]{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.DeferredSpeechToTextResult.channels}

**uuid**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.DeferredSpeechToTextResult.uuid}

Internal session identifier.

**user\_request\_id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.DeferredSpeechToTextResult.user_request_id}

User session identifier.

**conversation\_analysis**\: *[ConversationAnalysis](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.conversation_analysis.ConversationAnalysis) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.DeferredSpeechToTextResult.conversation_analysis}

Conversation statistics

**llm\_post\_process\_result**\: *[LLMPostProcessResult](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.llm_post_process_result.LLMPostProcessResult) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.DeferredSpeechToTextResult.llm_post_process_result}

Result of llm post\_process, may be also known as *Summarization* at some old documentation.

**delete**(*timeout=60*){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.DeferredSpeechToTextResult.delete}

Deletes results of asynchronous recognition.

#|
|| Parameters | **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) ||
|| Return type | None ||
|#

yandex\_ai\_studio\_sdk.\_speechkit.speech\_to\_text.result.top\_containers.**DeferredSpeechToTextResultTypeT** = *TypeVar(DeferredSpeechToTextResultTypeT, bound=DeferredSpeechToTextBaseResult)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.DeferredSpeechToTextResultTypeT}

**Type:**[**TypeVar**](https://docs.python.org/3/library/typing.html#typing.TypeVar)

Invariant [**TypeVar**](https://docs.python.org/3/library/typing.html#typing.TypeVar) bound to [**yandex\_ai\_studio\_sdk.\_speechkit.speech\_to\_text.result.top\_containers.DeferredSpeechToTextBaseResult**](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.DeferredSpeechToTextBaseResult).

### *class* yandex\_ai\_studio\_sdk.\_speechkit.speech\_to\_text.result.event.**SpeechToTextStreamingEventType**{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEventType}

Type of speech to text streaming event

**partial** = *'partial'*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEventType.partial}

**final** = *'final'*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEventType.final}

**eou\_update** = *'eou\_update'*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEventType.eou_update}

**final\_refinement** = *'final\_refinement'*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEventType.final_refinement}

**status\_code** = *'status\_code'*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEventType.status_code}

**classifier\_update** = *'classifier\_update'*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEventType.classifier_update}

**speaker\_analysis** = *'speaker\_analysis'*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEventType.speaker_analysis}

**conversation\_analysis** = *'conversation\_analysis'*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEventType.conversation_analysis}

**llm\_post\_process\_result** = *'llm\_post\_process\_result'*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEventType.llm_post_process_result}

**sdk\_unknown** = *'sdk\_unknown'*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEventType.sdk_unknown}

In case of backend adding new fields

**\_\_new\_\_**(*value*){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEventType.__new__i}

**encode**(*encoding='utf-8'*, *errors='strict'*){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEventType.encode}

Encode the string using the codec registered for encoding.

encoding

  : The encoding in which to encode the string.

errors

  : The error handling scheme to use for encoding errors. The default is ‘strict’ meaning that encoding errors raise a UnicodeEncodeError.  Other possible values are ‘ignore’, ‘replace’ and ‘xmlcharrefreplace’ as well as any other name registered with codecs.register\_error that can handle UnicodeEncodeErrors.

**replace**(*old*, *new*, *count=-1*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEventType.replace}

Return a copy with all occurrences of substring old replaced by new.

> countMaximum number of occurrences to replace. -1 (the default value) means replace all occurrences.

If the optional argument count is given, only the first count occurrences are replaced.

**split**(*sep=None*, *maxsplit=-1*){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEventType.split}

Return a list of the substrings in the string, using sep as the separator string.

> sepThe separator used to split the string.When set to None (the default value), will split on any whitespace character (including n r t f and spaces) and will discard empty strings from the result.maxsplitMaximum number of splits. -1 (the default value) means no limit.

Splitting starts at the front of the string and works to the end.

Note, str.split() is mainly useful for data that has been intentionally delimited.  With natural text that includes punctuation, consider using the regular expression module.

**rsplit**(*sep=None*, *maxsplit=-1*){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEventType.rsplit}

Return a list of the substrings in the string, using sep as the separator string.

> sepThe separator used to split the string.When set to None (the default value), will split on any whitespace character (including n r t f and spaces) and will discard empty strings from the result.maxsplitMaximum number of splits. -1 (the default value) means no limit.

Splitting starts at the end of the string and works to the front.

**join**(*iterable*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEventType.join}

Concatenate any number of strings.

The string whose method is called is inserted in between each given string. The result is returned as a new string.

Example: ‘.’.join([‘ab’, ‘pq’, ‘rs’]) -> ‘ab.pq.rs’

**capitalize**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEventType.capitalize}

Return a capitalized version of the string.

More specifically, make the first character have upper case and the rest lower case.

**casefold**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEventType.casefold}

Return a version of the string suitable for caseless comparisons.

**title**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEventType.title}

Return a version of the string where each word is titlecased.

More specifically, words start with uppercased characters and all remaining cased characters have lower case.

**center**(*width*, *fillchar=' '*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEventType.center}

Return a centered string of length width.

Padding is done using the specified fill character (default is a space).

**count**(*sub*[, *start*[, *end*]]) → [int](https://docs.python.org/3/library/functions.html#int){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEventType.count}

Return the number of non-overlapping occurrences of substring sub in string S[start:end].  Optional arguments start and end are interpreted as in slice notation.

**expandtabs**(*tabsize=8*){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEventType.expandtabs}

Return a copy where all tab characters are expanded using spaces.

If tabsize is not given, a tab size of 8 characters is assumed.

**find**(*sub*[, *start*[, *end*]]) → [int](https://docs.python.org/3/library/functions.html#int){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEventType.find}

Return the lowest index in S where substring sub is found, such that sub is contained within S[start:end].  Optional arguments start and end are interpreted as in slice notation.

Return -1 on failure.

**partition**(*sep*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEventType.partition}

Partition the string into three parts using the given separator.

This will search for the separator in the string.  If the separator is found, returns a 3-tuple containing the part before the separator, the separator itself, and the part after it.

If the separator is not found, returns a 3-tuple containing the original string and two empty strings.

**index**(*sub*[, *start*[, *end*]]) → [int](https://docs.python.org/3/library/functions.html#int){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEventType.index}

Return the lowest index in S where substring sub is found, such that sub is contained within S[start:end].  Optional arguments start and end are interpreted as in slice notation.

Raises ValueError when the substring is not found.

**ljust**(*width*, *fillchar=' '*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEventType.ljust}

Return a left-justified string of length width.

Padding is done using the specified fill character (default is a space).

**lower**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEventType.lower}

Return a copy of the string converted to lowercase.

**lstrip**(*chars=None*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEventType.lstrip}

Return a copy of the string with leading whitespace removed.

If chars is given and not None, remove characters in chars instead.

**rfind**(*sub*[, *start*[, *end*]]) → [int](https://docs.python.org/3/library/functions.html#int){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEventType.rfind}

Return the highest index in S where substring sub is found, such that sub is contained within S[start:end].  Optional arguments start and end are interpreted as in slice notation.

Return -1 on failure.

**rindex**(*sub*[, *start*[, *end*]]) → [int](https://docs.python.org/3/library/functions.html#int){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEventType.rindex}

Return the highest index in S where substring sub is found, such that sub is contained within S[start:end].  Optional arguments start and end are interpreted as in slice notation.

Raises ValueError when the substring is not found.

**rjust**(*width*, *fillchar=' '*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEventType.rjust}

Return a right-justified string of length width.

Padding is done using the specified fill character (default is a space).

**rstrip**(*chars=None*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEventType.rstrip}

Return a copy of the string with trailing whitespace removed.

If chars is given and not None, remove characters in chars instead.

**rpartition**(*sep*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEventType.rpartition}

Partition the string into three parts using the given separator.

This will search for the separator in the string, starting at the end. If the separator is found, returns a 3-tuple containing the part before the separator, the separator itself, and the part after it.

If the separator is not found, returns a 3-tuple containing two empty strings and the original string.

**splitlines**(*keepends=False*){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEventType.splitlines}

Return a list of the lines in the string, breaking at line boundaries.

Line breaks are not included in the resulting list unless keepends is given and true.

**strip**(*chars=None*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEventType.strip}

Return a copy of the string with leading and trailing whitespace removed.

If chars is given and not None, remove characters in chars instead.

**swapcase**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEventType.swapcase}

Convert uppercase characters to lowercase and lowercase characters to uppercase.

**translate**(*table*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEventType.translate}

Replace each character in the string using the given translation table.

> tableTranslation table, which must be a mapping of Unicode ordinals to Unicode ordinals, strings, or None.

The table must implement lookup/indexing via \_\_getitem\_\_, for instance a dictionary or list.  If this operation raises LookupError, the character is left untouched.  Characters mapped to None are deleted.

**upper**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEventType.upper}

Return a copy of the string converted to uppercase.

**startswith**(*prefix*[, *start*[, *end*]]) → [bool](https://docs.python.org/3/library/functions.html#bool){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEventType.startswith}

Return True if S starts with the specified prefix, False otherwise. With optional start, test S beginning at that position. With optional end, stop comparing S at that position. prefix can also be a tuple of strings to try.

**endswith**(*suffix*[, *start*[, *end*]]) → [bool](https://docs.python.org/3/library/functions.html#bool){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEventType.endswith}

Return True if S ends with the specified suffix, False otherwise. With optional start, test S beginning at that position. With optional end, stop comparing S at that position. suffix can also be a tuple of strings to try.

**removeprefix**(*prefix*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEventType.removeprefix}

Return a str with the given prefix string removed if present.

If the string starts with the prefix string, return string[len(prefix):]. Otherwise, return a copy of the original string.

**removesuffix**(*suffix*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEventType.removesuffix}

Return a str with the given suffix string removed if present.

If the string ends with the suffix string and that suffix is not empty, return string[:-len(suffix)]. Otherwise, return a copy of the original string.

**isascii**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEventType.isascii}

Return True if all characters in the string are ASCII, False otherwise.

ASCII characters have code points in the range U+0000-U+007F. Empty string is ASCII too.

**islower**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEventType.islower}

Return True if the string is a lowercase string, False otherwise.

A string is lowercase if all cased characters in the string are lowercase and there is at least one cased character in the string.

**isupper**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEventType.isupper}

Return True if the string is an uppercase string, False otherwise.

A string is uppercase if all cased characters in the string are uppercase and there is at least one cased character in the string.

**istitle**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEventType.istitle}

Return True if the string is a title-cased string, False otherwise.

In a title-cased string, upper- and title-case characters may only follow uncased characters and lowercase characters only cased ones.

**isspace**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEventType.isspace}

Return True if the string is a whitespace string, False otherwise.

A string is whitespace if all characters in the string are whitespace and there is at least one character in the string.

**isdecimal**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEventType.isdecimal}

Return True if the string is a decimal string, False otherwise.

A string is a decimal string if all characters in the string are decimal and there is at least one character in the string.

**isdigit**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEventType.isdigit}

Return True if the string is a digit string, False otherwise.

A string is a digit string if all characters in the string are digits and there is at least one character in the string.

**isnumeric**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEventType.isnumeric}

Return True if the string is a numeric string, False otherwise.

A string is numeric if all characters in the string are numeric and there is at least one character in the string.

**isalpha**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEventType.isalpha}

Return True if the string is an alphabetic string, False otherwise.

A string is alphabetic if all characters in the string are alphabetic and there is at least one character in the string.

**isalnum**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEventType.isalnum}

Return True if the string is an alpha-numeric string, False otherwise.

A string is alpha-numeric if all characters in the string are alpha-numeric and there is at least one character in the string.

**isidentifier**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEventType.isidentifier}

Return True if the string is a valid Python identifier, False otherwise.

Call keyword.iskeyword(s) to test whether string s is a reserved identifier, such as “def” or “class”.

**isprintable**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEventType.isprintable}

Return True if all characters in the string are printable, False otherwise.

A character is printable if repr() may use it in its output.

**zfill**(*width*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEventType.zfill}

Pad a numeric string with zeros on the left, to fill a field of the given width.

The string is never truncated.

**format**(*\*args*, *\*\*kwargs*) → [str](https://docs.python.org/3/library/stdtypes.html#str){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEventType.format}

Return a formatted version of S, using substitutions from args and kwargs. The substitutions are identified by braces (‘{’ and ‘}’).

**format\_map**(*mapping*) → [str](https://docs.python.org/3/library/stdtypes.html#str){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEventType.format_map}

Return a formatted version of S, using substitutions from mapping. The substitutions are identified by braces (‘{’ and ‘}’).

*static* **maketrans**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEventType.maketrans}

Return a translation table usable for str.translate().

If there is only one argument, it must be a dictionary mapping Unicode ordinals (integers) or characters to Unicode ordinals, strings or None. Character keys will be then converted to ordinals. If there are two arguments, they must be strings of equal length, and in the resulting dictionary, each character in x will be mapped to the character at the same position in y. If there is a third argument, it must be a string, whose characters will be mapped to None in the result.

### *class* yandex\_ai\_studio\_sdk.\_speechkit.speech\_to\_text.result.event.**SpeechToTextStreamingEvent**{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEvent}

A class representing streaming event of speech recognition request.

**event\_type**\: *[SpeechToTextStreamingEventType](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEventType)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEvent.event_type}

str/enum representation of event type

**response\_wall\_time\_ms**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEvent.response_wall_time_ms}

Wall clock on server side. This is time when server wrote results to stream.

**audio\_cursors**\: *[AudioCursors](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.audio_cursors.AudioCursors)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEvent.audio_cursors}

Progress bar for stream session recognition: how many data we obtained; final and partial times; etc

**channel\_tag**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEvent.channel_tag}

Tag for distinguish audio channels.

**partial**\: *[Alternatives](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.alternatives.Alternatives) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEvent.partial}

Partial results, server will send them regularly after enough audio data was received from user. This is the current text estimation from *final\_time\_ms* to *partial\_time\_ms*. Could change after new data will arrive.

**final**\: *[Alternatives](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.alternatives.Alternatives) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEvent.final}

Final results, the recognition is now fixed until *final\_time\_ms*. For now, final is sent only if the EOU event was triggered. This behavior could be changed in future releases.

**final\_refinement**\: *[FinalRefinement](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.alternatives.FinalRefinement) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEvent.final_refinement}

For each final, if normalization is enabled, sent the normalized text (or some other advanced post-processing). Final normalization will introduce additional latency.

**eou\_update\_ms**\: *[float](https://docs.python.org/3/library/functions.html#float) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEvent.eou_update_ms}

After EOU classifier, send the message with final, send the EouUpdate with time of EOU before eou\_update we send final with the same time. there could be several finals before eou update. EOU estimated time.

**status\_code**\: *[StatusCode](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.status_code.StatusCode) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEvent.status_code}

Status messages, send by server with fixed interval (keep-alive).

**classifier\_update**\: *[ClassifierUpdate](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.classifier.ClassifierUpdate) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEvent.classifier_update}

Update on result of the triggered classifier.

**speaker\_analysis**\: *[SpeakerAnalysis](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.speaker_analysis.SpeakerAnalysis) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEvent.speaker_analysis}

Speech statistics for every speaker

*property* **final\_text**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEvent.final_text}

Helper for **result.final.text if result.final else None**

*property* **final\_refinement\_text**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEvent.final_refinement_text}

Helper for **result.final\_refinement.text if result.final\_refinement else None**

*property* **partial\_text**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEvent.partial_text}

Helper for **result.partial.text if result.partial else None**

*property* **text**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEvent.text}

Helper for getting refined, final or partial text if event have any

**role**\: *ClassVar[[str](https://docs.python.org/3/library/stdtypes.html#str)*] = *'user'*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEvent.role}

Field role is required to be compatible with TextMessage Protocol, to other part of SDK could use this object an input.

**uuid**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEvent.uuid}

Internal session identifier.

**user\_request\_id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEvent.user_request_id}

User session identifier.

**conversation\_analysis**\: *[ConversationAnalysis](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.conversation_analysis.ConversationAnalysis) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEvent.conversation_analysis}

Conversation statistics

**llm\_post\_process\_result**\: *[LLMPostProcessResult](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.llm_post_process_result.LLMPostProcessResult) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEvent.llm_post_process_result}

Result of llm post\_process, may be also known as *Summarization* at some old documentation.

### *class* yandex\_ai\_studio\_sdk.\_speechkit.speech\_to\_text.result.alternatives.**Word**{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.alternatives.Word}

Recognized word

**text**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.alternatives.Word.text}

Word text.

**timespan**\: *[TimeSpan](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.utils.TimeSpan)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.alternatives.Word.timespan}

Estimation of word boundaries

### *class* yandex\_ai\_studio\_sdk.\_speechkit.speech\_to\_text.result.alternatives.**Alternative**{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.alternatives.Alternative}

Recognition of specific time frame.

**words**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[Word](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.alternatives.Word)*]{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.alternatives.Alternative.words}

Words in time frame.

**text**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.alternatives.Alternative.text}

Text in time frame.

**confidence**\: *[float](https://docs.python.org/3/library/functions.html#float)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.alternatives.Alternative.confidence}

The hypothesis confidence. Currently is not used.

**languages**\: *[dict](https://docs.python.org/3/library/stdtypes.html#dict)[[str](https://docs.python.org/3/library/stdtypes.html#str), [float](https://docs.python.org/3/library/functions.html#float)] | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.alternatives.Alternative.languages}

Distribution over possible languages.

**timespan**\: *[TimeSpan](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.utils.TimeSpan)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.alternatives.Alternative.timespan}

alternative’s time frame

### *class* yandex\_ai\_studio\_sdk.\_speechkit.speech\_to\_text.result.alternatives.**BaseAlternatives**{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.alternatives.BaseAlternatives}

BaseAlternatives(alternatives: ‘tuple[Alternative, …]’)

**alternatives**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[Alternative](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.alternatives.Alternative)*]... ,{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.alternatives.BaseAlternatives.alternatives}

*property* **words**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[Word](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.alternatives.Word)*]{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.alternatives.BaseAlternatives.words}

Synonym for .words attribute of first alternative

*property* **text**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.alternatives.BaseAlternatives.text}

Synonym for .text attribute of first alternative

*property* **timespan**\: *[TimeSpan](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.utils.TimeSpan)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.alternatives.BaseAlternatives.timespan}

Synonym for .timespan attribute of first alternative

*property* **confidence**\: *[float](https://docs.python.org/3/library/functions.html#float)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.alternatives.BaseAlternatives.confidence}

Synonym for .confidence attribute of first alternative

*property* **languages**\: *[dict](https://docs.python.org/3/library/stdtypes.html#dict)[[str](https://docs.python.org/3/library/stdtypes.html#str), [float](https://docs.python.org/3/library/functions.html#float)] | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.alternatives.BaseAlternatives.languages}

Synonym for .languages attribute of first alternative

**count**(*value*) → integer -- return number of occurrences of value{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.alternatives.BaseAlternatives.count}

**index**(*value*[, *start*[, *stop*]]) → integer -- return first index of value.{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.alternatives.BaseAlternatives.index}

Raises ValueError if the value is not present.

Supporting start and stop arguments is optional, but recommended.

### *class* yandex\_ai\_studio\_sdk.\_speechkit.speech\_to\_text.result.alternatives.**Alternatives**{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.alternatives.Alternatives}

Class-wrapper for [**Alternative**](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.alternatives.Alternative) list, which is allows to use this object not only as list, but as first Alternative.

*property* **confidence**\: *[float](https://docs.python.org/3/library/functions.html#float)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.alternatives.Alternatives.confidence}

Synonym for .confidence attribute of first alternative

**count**(*value*) → integer -- return number of occurrences of value{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.alternatives.Alternatives.count}

**index**(*value*[, *start*[, *stop*]]) → integer -- return first index of value.{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.alternatives.Alternatives.index}

Raises ValueError if the value is not present.

Supporting start and stop arguments is optional, but recommended.

*property* **languages**\: *[dict](https://docs.python.org/3/library/stdtypes.html#dict)[[str](https://docs.python.org/3/library/stdtypes.html#str), [float](https://docs.python.org/3/library/functions.html#float)] | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.alternatives.Alternatives.languages}

Synonym for .languages attribute of first alternative

*property* **text**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.alternatives.Alternatives.text}

Synonym for .text attribute of first alternative

*property* **timespan**\: *[TimeSpan](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.utils.TimeSpan)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.alternatives.Alternatives.timespan}

Synonym for .timespan attribute of first alternative

*property* **words**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[Word](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.alternatives.Word)*]{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.alternatives.Alternatives.words}

Synonym for .words attribute of first alternative

**alternatives**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[Alternative](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.alternatives.Alternative)*]... ,{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.alternatives.Alternatives.alternatives}

### *class* yandex\_ai\_studio\_sdk.\_speechkit.speech\_to\_text.result.alternatives.**FinalRefinement**{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.alternatives.FinalRefinement}

Class-wrapper for [**Alternative**](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.alternatives.Alternative) list, which is allows to use this object not only as list, but as first Alternative.

**final\_index**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.alternatives.FinalRefinement.final_index}

*property* **confidence**\: *[float](https://docs.python.org/3/library/functions.html#float)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.alternatives.FinalRefinement.confidence}

Synonym for .confidence attribute of first alternative

**count**(*value*) → integer -- return number of occurrences of value{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.alternatives.FinalRefinement.count}

**index**(*value*[, *start*[, *stop*]]) → integer -- return first index of value.{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.alternatives.FinalRefinement.index}

Raises ValueError if the value is not present.

Supporting start and stop arguments is optional, but recommended.

*property* **languages**\: *[dict](https://docs.python.org/3/library/stdtypes.html#dict)[[str](https://docs.python.org/3/library/stdtypes.html#str), [float](https://docs.python.org/3/library/functions.html#float)] | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.alternatives.FinalRefinement.languages}

Synonym for .languages attribute of first alternative

*property* **text**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.alternatives.FinalRefinement.text}

Synonym for .text attribute of first alternative

*property* **timespan**\: *[TimeSpan](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.utils.TimeSpan)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.alternatives.FinalRefinement.timespan}

Synonym for .timespan attribute of first alternative

*property* **words**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[Word](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.alternatives.Word)*]{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.alternatives.FinalRefinement.words}

Synonym for .words attribute of first alternative

**alternatives**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[Alternative](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.alternatives.Alternative)*]... ,{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.alternatives.FinalRefinement.alternatives}

### *class* yandex\_ai\_studio\_sdk.\_speechkit.speech\_to\_text.structures.**ProtoBasedWithBoolDefault**{#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.ProtoBasedWithBoolDefault}

### *class* yandex\_ai\_studio\_sdk.\_speechkit.speech\_to\_text.structures.**TextNormalization**{#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.TextNormalization}

Class which encapsulates [text normaliztion options](https://aistudio.yandex.ru/docs/speechkit/stt/normalization).

Usage of object of this class itself in speech to text configuration is turning on normalization. Options of this class have different defaults at backend, i.e. some options could turn on the feature and others could turn it off.

>> TextNormalization() TextNormalization()

```python
>>> TextNormalization(phone_formatting=False)
TextNormalization(phone_formatting=False, profanity_filter=Undefined, literature_text=Undefined)
```

**phone\_formatting**\: *[bool](https://docs.python.org/3/library/functions.html#bool) | [Undefined](other.md#yandex_ai_studio_sdk._types.misc.Undefined)* = *Undefined*{#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.TextNormalization.phone_formatting}

Phone formatting

**profanity\_filter**\: *[bool](https://docs.python.org/3/library/functions.html#bool) | [Undefined](other.md#yandex_ai_studio_sdk._types.misc.Undefined)* = *Undefined*{#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.TextNormalization.profanity_filter}

Profanity filter

**literature\_text**\: *[bool](https://docs.python.org/3/library/functions.html#bool) | [Undefined](other.md#yandex_ai_studio_sdk._types.misc.Undefined)* = *Undefined*{#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.TextNormalization.literature_text}

Rewrite text in literature style

**\_\_init\_\_**(*phone\_formatting=Undefined*, *profanity\_filter=Undefined*, *literature\_text=Undefined*){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.TextNormalization.__init__i}

#|
|| Parameters | 

- **phone\_formatting** ([*bool*](https://docs.python.org/3/library/functions.html#bool) *\|* [*Undefined*](other.md#yandex_ai_studio_sdk._types.misc.Undefined))
- **profanity\_filter** ([*bool*](https://docs.python.org/3/library/functions.html#bool) *\|* [*Undefined*](other.md#yandex_ai_studio_sdk._types.misc.Undefined))
- **literature\_text** ([*bool*](https://docs.python.org/3/library/functions.html#bool) *\|* [*Undefined*](other.md#yandex_ai_studio_sdk._types.misc.Undefined)) ||
|| Return type | None ||
|#

### *class* yandex\_ai\_studio\_sdk.\_speechkit.speech\_to\_text.structures.**EndOfUtteranceSensitivity**{#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.EndOfUtteranceSensitivity}

Level of EOU sensitivity

**DEFAULT** = *1*{#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.EndOfUtteranceSensitivity.DEFAULT}

Default and more conservative EOU detector.

**HIGH** = *2*{#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.EndOfUtteranceSensitivity.HIGH}

A high-sensitive and fast EOU detector, which may produce more false positives.

*classmethod* **Unknown**(*name*, *value*){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.EndOfUtteranceSensitivity.Unknown}

#|
|| Parameters | 

- **name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str))
- **value** ([*int*](https://docs.python.org/3/library/functions.html#int)) ||
|#

**\_\_new\_\_**(*value*){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.EndOfUtteranceSensitivity.__new__i}

**conjugate**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.EndOfUtteranceSensitivity.conjugate}

Returns self, the complex conjugate of any int.

**bit\_length**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.EndOfUtteranceSensitivity.bit_length}

Number of bits necessary to represent self in binary.

```python
>>> bin(37)
'0b100101'
>>> (37).bit_length()
6
```

**bit\_count**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.EndOfUtteranceSensitivity.bit_count}

Number of ones in the binary representation of the absolute value of self.

Also known as the population count.

```python
>>> bin(13)
'0b1101'
>>> (13).bit_count()
3
```

**as\_integer\_ratio**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.EndOfUtteranceSensitivity.as_integer_ratio}

Return a pair of integers, whose ratio is equal to the original int.

The ratio is in lowest terms and has a positive denominator.

```python
>>> (10).as_integer_ratio()
(10, 1)
>>> (-10).as_integer_ratio()
(-10, 1)
>>> (0).as_integer_ratio()
(0, 1)
```

**is\_integer**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.EndOfUtteranceSensitivity.is_integer}

Returns True. Exists for duck type compatibility with float.is\_integer.

**real**{#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.EndOfUtteranceSensitivity.real}

the real part of a complex number

**imag**{#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.EndOfUtteranceSensitivity.imag}

the imaginary part of a complex number

**numerator**{#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.EndOfUtteranceSensitivity.numerator}

the numerator of a rational number in lowest terms

**denominator**{#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.EndOfUtteranceSensitivity.denominator}

the denominator of a rational number in lowest terms

**\_\_init\_\_**(*\*args*, *\*\*kwds*){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.EndOfUtteranceSensitivity.__init__i}

### *class* yandex\_ai\_studio\_sdk.\_speechkit.speech\_to\_text.structures.**EndOfUtteranceClassifier**{#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.EndOfUtteranceClassifier}

Class which encapsulates settings [end of utterance classifier](https://aistudio.yandex.ru/docs/speechkit/stt/eou).

Usage this class object in speech to text configuration turning on default end-of-utterance classification.

```python
>>> EndOfUtteranceClassifier()
EndOfUtteranceClassifier(sensitivity=Undefined, max_pause_between_words_hint_ms=Undefined)
```

```python
>>> EndOfUtteranceClassifier(sensitivity='high')
EndOfUtteranceClassifier(sensitivity=<EndOfUtteranceSensitivity.HIGH: 2>, ...)
```

```python
>>> EndOfUtteranceClassifier(max_pause_between_words_hint_ms=10)
EndOfUtteranceClassifier(sensitivity=Undefined, max_pause_between_words_hint_ms=10)
```

**sensitivity**\: *[EndOfUtteranceSensitivity](#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.EndOfUtteranceSensitivity) | [UnknownEnumValue](other.md#yandex_ai_studio_sdk._types.schemas.yandex_ai_studio_sdk._types.enum.UnknownEnumValue)[[EndOfUtteranceSensitivity](#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.EndOfUtteranceSensitivity)] | [str](https://docs.python.org/3/library/stdtypes.html#str) | [int](https://docs.python.org/3/library/functions.html#int) | [Undefined](other.md#yandex_ai_studio_sdk._types.misc.Undefined)* = *Undefined*{#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.EndOfUtteranceClassifier.sensitivity}

EOU sensitivity

**max\_pause\_between\_words\_hint\_ms**\: *[int](https://docs.python.org/3/library/functions.html#int) | [Undefined](other.md#yandex_ai_studio_sdk._types.misc.Undefined)* = *Undefined*{#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.EndOfUtteranceClassifier.max_pause_between_words_hint_ms}

Hint for max pause between words. SpeechKit EOU detector could use this information to adjust the speed of the EOU detection. For example, a long pause between words will help distinguish between the end of utterance from slow speech like **One <long pause> two <long pause> three**. A short pause can be helpful if the speaker is speaking quickly and does not emphasize pauses between sentences.

**\_\_init\_\_**(*sensitivity=Undefined*, *max\_pause\_between\_words\_hint\_ms=Undefined*){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.EndOfUtteranceClassifier.__init__i}

#|
|| Parameters | 

- **sensitivity** ([*EndOfUtteranceSensitivity*](#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.EndOfUtteranceSensitivity) *\|* [*UnknownEnumValue*](other.md#yandex_ai_studio_sdk._types.schemas.yandex_ai_studio_sdk._types.enum.UnknownEnumValue)*[*[*EndOfUtteranceSensitivity*](#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.EndOfUtteranceSensitivity)*] \|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](other.md#yandex_ai_studio_sdk._types.misc.Undefined))
- **max\_pause\_between\_words\_hint\_ms** ([*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](other.md#yandex_ai_studio_sdk._types.misc.Undefined)) ||
|| Return type | None ||
|#

### *class* yandex\_ai\_studio\_sdk.\_speechkit.speech\_to\_text.structures.**RecognitionTriggerType**{#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.RecognitionTriggerType}

Type of recognition classifier trigger.

**ON\_UTTERANCE** = *1*{#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.RecognitionTriggerType.ON_UTTERANCE}

Apply classifier to utterance responses.

**ON\_FINAL** = *2*{#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.RecognitionTriggerType.ON_FINAL}

Apply classifier to final responses.

**ON\_PARTIAL** = *3*{#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.RecognitionTriggerType.ON_PARTIAL}

Apply classifier to partial responses.

*classmethod* **Unknown**(*name*, *value*){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.RecognitionTriggerType.Unknown}

#|
|| Parameters | 

- **name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str))
- **value** ([*int*](https://docs.python.org/3/library/functions.html#int)) ||
|#

**\_\_new\_\_**(*value*){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.RecognitionTriggerType.__new__i}

**conjugate**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.RecognitionTriggerType.conjugate}

Returns self, the complex conjugate of any int.

**bit\_length**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.RecognitionTriggerType.bit_length}

Number of bits necessary to represent self in binary.

```python
>>> bin(37)
'0b100101'
>>> (37).bit_length()
6
```

**bit\_count**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.RecognitionTriggerType.bit_count}

Number of ones in the binary representation of the absolute value of self.

Also known as the population count.

```python
>>> bin(13)
'0b1101'
>>> (13).bit_count()
3
```

**as\_integer\_ratio**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.RecognitionTriggerType.as_integer_ratio}

Return a pair of integers, whose ratio is equal to the original int.

The ratio is in lowest terms and has a positive denominator.

```python
>>> (10).as_integer_ratio()
(10, 1)
>>> (-10).as_integer_ratio()
(-10, 1)
>>> (0).as_integer_ratio()
(0, 1)
```

**is\_integer**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.RecognitionTriggerType.is_integer}

Returns True. Exists for duck type compatibility with float.is\_integer.

**real**{#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.RecognitionTriggerType.real}

the real part of a complex number

**imag**{#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.RecognitionTriggerType.imag}

the imaginary part of a complex number

**numerator**{#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.RecognitionTriggerType.numerator}

the numerator of a rational number in lowest terms

**denominator**{#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.RecognitionTriggerType.denominator}

the denominator of a rational number in lowest terms

**\_\_init\_\_**(*\*args*, *\*\*kwds*){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.RecognitionTriggerType.__init__i}

### *class* yandex\_ai\_studio\_sdk.\_speechkit.speech\_to\_text.structures.**WellKnownRecognitionClassifiers**{#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.WellKnownRecognitionClassifiers}

Well known names of recognition classifier triggers.

More on the topic in [article](https://aistudio.yandex.ru/docs/speechkit/stt/analysis#classifier).

**formal\_greeting** = *'formal\_greeting'*{#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.WellKnownRecognitionClassifiers.formal_greeting}

**informal\_greeting** = *'informal\_greeting'*{#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.WellKnownRecognitionClassifiers.informal_greeting}

**formal\_farewell** = *'formal\_farewell'*{#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.WellKnownRecognitionClassifiers.formal_farewell}

**informal\_farewell** = *'informal\_farewell'*{#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.WellKnownRecognitionClassifiers.informal_farewell}

**insult** = *'insult'*{#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.WellKnownRecognitionClassifiers.insult}

**profanity** = *'profanity'*{#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.WellKnownRecognitionClassifiers.profanity}

**gender** = *'gender'*{#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.WellKnownRecognitionClassifiers.gender}

**negative** = *'negative'*{#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.WellKnownRecognitionClassifiers.negative}

**answerphone** = *'answerphone'*{#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.WellKnownRecognitionClassifiers.answerphone}

**\_\_new\_\_**(*value*){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.WellKnownRecognitionClassifiers.__new__i}

**encode**(*encoding='utf-8'*, *errors='strict'*){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.WellKnownRecognitionClassifiers.encode}

Encode the string using the codec registered for encoding.

encoding

  : The encoding in which to encode the string.

errors

  : The error handling scheme to use for encoding errors. The default is ‘strict’ meaning that encoding errors raise a UnicodeEncodeError.  Other possible values are ‘ignore’, ‘replace’ and ‘xmlcharrefreplace’ as well as any other name registered with codecs.register\_error that can handle UnicodeEncodeErrors.

**replace**(*old*, *new*, *count=-1*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.WellKnownRecognitionClassifiers.replace}

Return a copy with all occurrences of substring old replaced by new.

> countMaximum number of occurrences to replace. -1 (the default value) means replace all occurrences.

If the optional argument count is given, only the first count occurrences are replaced.

**split**(*sep=None*, *maxsplit=-1*){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.WellKnownRecognitionClassifiers.split}

Return a list of the substrings in the string, using sep as the separator string.

> sepThe separator used to split the string.When set to None (the default value), will split on any whitespace character (including n r t f and spaces) and will discard empty strings from the result.maxsplitMaximum number of splits. -1 (the default value) means no limit.

Splitting starts at the front of the string and works to the end.

Note, str.split() is mainly useful for data that has been intentionally delimited.  With natural text that includes punctuation, consider using the regular expression module.

**rsplit**(*sep=None*, *maxsplit=-1*){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.WellKnownRecognitionClassifiers.rsplit}

Return a list of the substrings in the string, using sep as the separator string.

> sepThe separator used to split the string.When set to None (the default value), will split on any whitespace character (including n r t f and spaces) and will discard empty strings from the result.maxsplitMaximum number of splits. -1 (the default value) means no limit.

Splitting starts at the end of the string and works to the front.

**join**(*iterable*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.WellKnownRecognitionClassifiers.join}

Concatenate any number of strings.

The string whose method is called is inserted in between each given string. The result is returned as a new string.

Example: ‘.’.join([‘ab’, ‘pq’, ‘rs’]) -> ‘ab.pq.rs’

**capitalize**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.WellKnownRecognitionClassifiers.capitalize}

Return a capitalized version of the string.

More specifically, make the first character have upper case and the rest lower case.

**casefold**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.WellKnownRecognitionClassifiers.casefold}

Return a version of the string suitable for caseless comparisons.

**title**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.WellKnownRecognitionClassifiers.title}

Return a version of the string where each word is titlecased.

More specifically, words start with uppercased characters and all remaining cased characters have lower case.

**center**(*width*, *fillchar=' '*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.WellKnownRecognitionClassifiers.center}

Return a centered string of length width.

Padding is done using the specified fill character (default is a space).

**count**(*sub*[, *start*[, *end*]]) → [int](https://docs.python.org/3/library/functions.html#int){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.WellKnownRecognitionClassifiers.count}

Return the number of non-overlapping occurrences of substring sub in string S[start:end].  Optional arguments start and end are interpreted as in slice notation.

**expandtabs**(*tabsize=8*){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.WellKnownRecognitionClassifiers.expandtabs}

Return a copy where all tab characters are expanded using spaces.

If tabsize is not given, a tab size of 8 characters is assumed.

**find**(*sub*[, *start*[, *end*]]) → [int](https://docs.python.org/3/library/functions.html#int){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.WellKnownRecognitionClassifiers.find}

Return the lowest index in S where substring sub is found, such that sub is contained within S[start:end].  Optional arguments start and end are interpreted as in slice notation.

Return -1 on failure.

**partition**(*sep*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.WellKnownRecognitionClassifiers.partition}

Partition the string into three parts using the given separator.

This will search for the separator in the string.  If the separator is found, returns a 3-tuple containing the part before the separator, the separator itself, and the part after it.

If the separator is not found, returns a 3-tuple containing the original string and two empty strings.

**index**(*sub*[, *start*[, *end*]]) → [int](https://docs.python.org/3/library/functions.html#int){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.WellKnownRecognitionClassifiers.index}

Return the lowest index in S where substring sub is found, such that sub is contained within S[start:end].  Optional arguments start and end are interpreted as in slice notation.

Raises ValueError when the substring is not found.

**ljust**(*width*, *fillchar=' '*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.WellKnownRecognitionClassifiers.ljust}

Return a left-justified string of length width.

Padding is done using the specified fill character (default is a space).

**lower**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.WellKnownRecognitionClassifiers.lower}

Return a copy of the string converted to lowercase.

**lstrip**(*chars=None*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.WellKnownRecognitionClassifiers.lstrip}

Return a copy of the string with leading whitespace removed.

If chars is given and not None, remove characters in chars instead.

**rfind**(*sub*[, *start*[, *end*]]) → [int](https://docs.python.org/3/library/functions.html#int){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.WellKnownRecognitionClassifiers.rfind}

Return the highest index in S where substring sub is found, such that sub is contained within S[start:end].  Optional arguments start and end are interpreted as in slice notation.

Return -1 on failure.

**rindex**(*sub*[, *start*[, *end*]]) → [int](https://docs.python.org/3/library/functions.html#int){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.WellKnownRecognitionClassifiers.rindex}

Return the highest index in S where substring sub is found, such that sub is contained within S[start:end].  Optional arguments start and end are interpreted as in slice notation.

Raises ValueError when the substring is not found.

**rjust**(*width*, *fillchar=' '*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.WellKnownRecognitionClassifiers.rjust}

Return a right-justified string of length width.

Padding is done using the specified fill character (default is a space).

**rstrip**(*chars=None*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.WellKnownRecognitionClassifiers.rstrip}

Return a copy of the string with trailing whitespace removed.

If chars is given and not None, remove characters in chars instead.

**rpartition**(*sep*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.WellKnownRecognitionClassifiers.rpartition}

Partition the string into three parts using the given separator.

This will search for the separator in the string, starting at the end. If the separator is found, returns a 3-tuple containing the part before the separator, the separator itself, and the part after it.

If the separator is not found, returns a 3-tuple containing two empty strings and the original string.

**splitlines**(*keepends=False*){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.WellKnownRecognitionClassifiers.splitlines}

Return a list of the lines in the string, breaking at line boundaries.

Line breaks are not included in the resulting list unless keepends is given and true.

**strip**(*chars=None*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.WellKnownRecognitionClassifiers.strip}

Return a copy of the string with leading and trailing whitespace removed.

If chars is given and not None, remove characters in chars instead.

**swapcase**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.WellKnownRecognitionClassifiers.swapcase}

Convert uppercase characters to lowercase and lowercase characters to uppercase.

**translate**(*table*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.WellKnownRecognitionClassifiers.translate}

Replace each character in the string using the given translation table.

> tableTranslation table, which must be a mapping of Unicode ordinals to Unicode ordinals, strings, or None.

The table must implement lookup/indexing via \_\_getitem\_\_, for instance a dictionary or list.  If this operation raises LookupError, the character is left untouched.  Characters mapped to None are deleted.

**upper**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.WellKnownRecognitionClassifiers.upper}

Return a copy of the string converted to uppercase.

**startswith**(*prefix*[, *start*[, *end*]]) → [bool](https://docs.python.org/3/library/functions.html#bool){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.WellKnownRecognitionClassifiers.startswith}

Return True if S starts with the specified prefix, False otherwise. With optional start, test S beginning at that position. With optional end, stop comparing S at that position. prefix can also be a tuple of strings to try.

**endswith**(*suffix*[, *start*[, *end*]]) → [bool](https://docs.python.org/3/library/functions.html#bool){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.WellKnownRecognitionClassifiers.endswith}

Return True if S ends with the specified suffix, False otherwise. With optional start, test S beginning at that position. With optional end, stop comparing S at that position. suffix can also be a tuple of strings to try.

**removeprefix**(*prefix*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.WellKnownRecognitionClassifiers.removeprefix}

Return a str with the given prefix string removed if present.

If the string starts with the prefix string, return string[len(prefix):]. Otherwise, return a copy of the original string.

**removesuffix**(*suffix*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.WellKnownRecognitionClassifiers.removesuffix}

Return a str with the given suffix string removed if present.

If the string ends with the suffix string and that suffix is not empty, return string[:-len(suffix)]. Otherwise, return a copy of the original string.

**isascii**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.WellKnownRecognitionClassifiers.isascii}

Return True if all characters in the string are ASCII, False otherwise.

ASCII characters have code points in the range U+0000-U+007F. Empty string is ASCII too.

**islower**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.WellKnownRecognitionClassifiers.islower}

Return True if the string is a lowercase string, False otherwise.

A string is lowercase if all cased characters in the string are lowercase and there is at least one cased character in the string.

**isupper**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.WellKnownRecognitionClassifiers.isupper}

Return True if the string is an uppercase string, False otherwise.

A string is uppercase if all cased characters in the string are uppercase and there is at least one cased character in the string.

**istitle**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.WellKnownRecognitionClassifiers.istitle}

Return True if the string is a title-cased string, False otherwise.

In a title-cased string, upper- and title-case characters may only follow uncased characters and lowercase characters only cased ones.

**isspace**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.WellKnownRecognitionClassifiers.isspace}

Return True if the string is a whitespace string, False otherwise.

A string is whitespace if all characters in the string are whitespace and there is at least one character in the string.

**isdecimal**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.WellKnownRecognitionClassifiers.isdecimal}

Return True if the string is a decimal string, False otherwise.

A string is a decimal string if all characters in the string are decimal and there is at least one character in the string.

**isdigit**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.WellKnownRecognitionClassifiers.isdigit}

Return True if the string is a digit string, False otherwise.

A string is a digit string if all characters in the string are digits and there is at least one character in the string.

**isnumeric**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.WellKnownRecognitionClassifiers.isnumeric}

Return True if the string is a numeric string, False otherwise.

A string is numeric if all characters in the string are numeric and there is at least one character in the string.

**isalpha**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.WellKnownRecognitionClassifiers.isalpha}

Return True if the string is an alphabetic string, False otherwise.

A string is alphabetic if all characters in the string are alphabetic and there is at least one character in the string.

**isalnum**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.WellKnownRecognitionClassifiers.isalnum}

Return True if the string is an alpha-numeric string, False otherwise.

A string is alpha-numeric if all characters in the string are alpha-numeric and there is at least one character in the string.

**isidentifier**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.WellKnownRecognitionClassifiers.isidentifier}

Return True if the string is a valid Python identifier, False otherwise.

Call keyword.iskeyword(s) to test whether string s is a reserved identifier, such as “def” or “class”.

**isprintable**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.WellKnownRecognitionClassifiers.isprintable}

Return True if all characters in the string are printable, False otherwise.

A character is printable if repr() may use it in its output.

**zfill**(*width*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.WellKnownRecognitionClassifiers.zfill}

Pad a numeric string with zeros on the left, to fill a field of the given width.

The string is never truncated.

**format**(*\*args*, *\*\*kwargs*) → [str](https://docs.python.org/3/library/stdtypes.html#str){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.WellKnownRecognitionClassifiers.format}

Return a formatted version of S, using substitutions from args and kwargs. The substitutions are identified by braces (‘{’ and ‘}’).

**format\_map**(*mapping*) → [str](https://docs.python.org/3/library/stdtypes.html#str){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.WellKnownRecognitionClassifiers.format_map}

Return a formatted version of S, using substitutions from mapping. The substitutions are identified by braces (‘{’ and ‘}’).

*static* **maketrans**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.WellKnownRecognitionClassifiers.maketrans}

Return a translation table usable for str.translate().

If there is only one argument, it must be a dictionary mapping Unicode ordinals (integers) or characters to Unicode ordinals, strings or None. Character keys will be then converted to ordinals. If there are two arguments, they must be strings of equal length, and in the resulting dictionary, each character in x will be mapped to the character at the same position in y. If there is a third argument, it must be a string, whose characters will be mapped to None in the result.

**\_\_init\_\_**(*\*args*, *\*\*kwds*){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.WellKnownRecognitionClassifiers.__init__i}

### *class* yandex\_ai\_studio\_sdk.\_speechkit.speech\_to\_text.structures.**RecognitionClassifier**{#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.RecognitionClassifier}

Classifier to use in speech recognition.

For detailed information refer to [classification documentation](https://aistudio.yandex.ru/docs/speechkit/stt/analysis).

You can pass a string as a trigger:

```python
>>> RecognitionClassifier('insult', 'on_final')
RecognitionClassifier(name='insult', triggers=(<RecognitionTriggerType.ON_FINAL: 2>,))
```

Or any iterable of strings to declare few triggers:

```python
>>> RecognitionClassifier('insult', ['on_final', 'on_partial'])
RecognitionClassifier(..., triggers=(...ON_FINAL: 2>, <...ON_PARTIAL: 3>))
```

You could also use alternative constructors when you have only one trigger:

```python
>>> RecognitionClassifier.on_utterance('insult')
RecognitionClassifier(name='insult', triggers=(<RecognitionTriggerType.ON_UTTERANCE: 1>,))
```

There are special *RecognitionClassifier.WellKnown* enum with well-known classifier names:

```python
>>> RecognitionClassifier(RecognitionClassifier.WellKnown.gender, 'on_final')
RecognitionClassifier(name=<WellKnownRecognitionClassifiers.gender: 'gender'>, ...)
```

On unknown trigger names there will be exception raised:

```python
>>> RecognitionClassifier('insult', ['on_something'])
Traceback (most recent call last):
    ...
ValueError: wrong value "on_something" for use as an alias ...; known values: ('ON_UTTERANCE', ...)
```

**name**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.RecognitionClassifier.name}

Classifier name.

**triggers**\: *[Sequence](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence)[[RecognitionTriggerType](#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.RecognitionTriggerType) | [UnknownEnumValue](other.md#yandex_ai_studio_sdk._types.schemas.yandex_ai_studio_sdk._types.enum.UnknownEnumValue)[[RecognitionTriggerType](#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.RecognitionTriggerType)] | [str](https://docs.python.org/3/library/stdtypes.html#str) | [int](https://docs.python.org/3/library/functions.html#int)] | [RecognitionTriggerType](#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.RecognitionTriggerType) | [UnknownEnumValue](other.md#yandex_ai_studio_sdk._types.schemas.yandex_ai_studio_sdk._types.enum.UnknownEnumValue)[[RecognitionTriggerType](#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.RecognitionTriggerType)] | [str](https://docs.python.org/3/library/stdtypes.html#str) | [int](https://docs.python.org/3/library/functions.html#int)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.RecognitionClassifier.triggers}

Describes the types of responses to which the classification results will come. Classification responses will follow the responses of the specified types.

**WellKnown**{#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.RecognitionClassifier.WellKnown}

Well known names of recognition classifier triggers.

alias of [**WellKnownRecognitionClassifiers**](#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.WellKnownRecognitionClassifiers)

*classmethod* **on\_utterance**(*name*){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.RecognitionClassifier.on_utterance}

Alternative constructor to use onle ‘on\_utterance’ trigger

#|
|| Parameters | **name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) ||
|| Return type | [*Self*](https://docs.python.org/3/library/typing.html#typing.Self) ||
|#

*classmethod* **on\_final**(*name*){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.RecognitionClassifier.on_final}

Alternative constructor to use onle ‘on\_final’ trigger

#|
|| Parameters | **name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) ||
|| Return type | [*Self*](https://docs.python.org/3/library/typing.html#typing.Self) ||
|#

*classmethod* **on\_partial**(*name*){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.RecognitionClassifier.on_partial}

Alternative constructor to use onle ‘on\_partial’ trigger

#|
|| Parameters | **name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) ||
|| Return type | [*Self*](https://docs.python.org/3/library/typing.html#typing.Self) ||
|#

**\_\_init\_\_**(*name*, *triggers*){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.RecognitionClassifier.__init__i}

#|
|| Parameters | 

- **name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str))
- **triggers** ([*Sequence*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence)*[*[*RecognitionTriggerType*](#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.RecognitionTriggerType) *\|* [*UnknownEnumValue*](other.md#yandex_ai_studio_sdk._types.schemas.yandex_ai_studio_sdk._types.enum.UnknownEnumValue)*[*[*RecognitionTriggerType*](#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.RecognitionTriggerType)*] \|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*int*](https://docs.python.org/3/library/functions.html#int)*] \|* [*RecognitionTriggerType*](#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.RecognitionTriggerType) *\|* [*UnknownEnumValue*](other.md#yandex_ai_studio_sdk._types.schemas.yandex_ai_studio_sdk._types.enum.UnknownEnumValue)*[*[*RecognitionTriggerType*](#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.RecognitionTriggerType)*] \|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*int*](https://docs.python.org/3/library/functions.html#int)) ||
|| Return type | None ||
|#

### *class* yandex\_ai\_studio\_sdk.\_speechkit.speech\_to\_text.structures.**SpeechAnalysis**{#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.SpeechAnalysis}

Class which encapsulates [speech analysis settings](https://aistudio.yandex.ru/docs/speechkit/stt/analysis)

**speaker\_analysis**\: *[bool](https://docs.python.org/3/library/functions.html#bool) | [Undefined](other.md#yandex_ai_studio_sdk._types.misc.Undefined)* = *Undefined*{#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.SpeechAnalysis.speaker_analysis}

Analyse speech for every speaker

**conversation\_analysis**\: *[bool](https://docs.python.org/3/library/functions.html#bool) | [Undefined](other.md#yandex_ai_studio_sdk._types.misc.Undefined)* = *Undefined*{#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.SpeechAnalysis.conversation_analysis}

Analyse conversation of two speakers

**descriptive\_statistics\_quantiles**\: *[Sequence](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence)[[float](https://docs.python.org/3/library/functions.html#float)] | [Undefined](other.md#yandex_ai_studio_sdk._types.misc.Undefined)* = *Undefined*{#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.SpeechAnalysis.descriptive_statistics_quantiles}

Quantile levels in range (0, 1) for descriptive statistics

**\_\_init\_\_**(*speaker\_analysis=Undefined*, *conversation\_analysis=Undefined*, *descriptive\_statistics\_quantiles=Undefined*){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.SpeechAnalysis.__init__i}

#|
|| Parameters | 

- **speaker\_analysis** ([*bool*](https://docs.python.org/3/library/functions.html#bool) *\|* [*Undefined*](other.md#yandex_ai_studio_sdk._types.misc.Undefined))
- **conversation\_analysis** ([*bool*](https://docs.python.org/3/library/functions.html#bool) *\|* [*Undefined*](other.md#yandex_ai_studio_sdk._types.misc.Undefined))
- **descriptive\_statistics\_quantiles** ([*Sequence*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence)*[*[*float*](https://docs.python.org/3/library/functions.html#float)*] \|* [*Undefined*](other.md#yandex_ai_studio_sdk._types.misc.Undefined)) ||
|| Return type | None ||
|#

### *class* yandex\_ai\_studio\_sdk.\_speechkit.speech\_to\_text.structures.**LLMPostProcessingInstruction**{#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.LLMPostProcessingInstruction}

Class for encapsulating exactly one post processing settings.

**instruction**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.LLMPostProcessingInstruction.instruction}

Instruction for model.

**response\_format**\: *[Literal](https://docs.python.org/3/library/typing.html#typing.Literal)['json'] | [JsonSchemaResponseType](other.md#yandex_ai_studio_sdk._types.schemas.JsonSchemaResponseType) | [type](https://docs.python.org/3/library/functions.html#type) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.LLMPostProcessingInstruction.response_format}

Format of the response returned by the model. Format could be described as:

- *None* for usual text response (default);
- ‘*json*’ string to tell a model to return JSON object;
- dictionary with a JsonSchema to enforce a specific JSON structure for the model’s response based on a provided schema;
- pydantic model or pydantic dataclass (which will be transformed into JsonSchema by SDK);

**\_\_init\_\_**(*instruction*, *response\_format*){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.LLMPostProcessingInstruction.__init__i}

#|
|| Parameters | 

- **instruction** ([*str*](https://docs.python.org/3/library/stdtypes.html#str))
- **response\_format** ([*Literal*](https://docs.python.org/3/library/typing.html#typing.Literal)*['json'] \| ~yandex\_ai\_studio\_sdk.\_types.schemas.JsonSchemaResponseType \| type \| None*) ||
|| Return type | None ||
|#

### *class* yandex\_ai\_studio\_sdk.\_speechkit.speech\_to\_text.structures.**LLMPostProcessing**{#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.LLMPostProcessing}

Class for encapsulating [transcription llm post processing settings](https://aistudio.yandex.ru/docs/speechkit/stt/llm-results)

You could pass a full model uri:

```python
>>> llm_post_processor = LLMPostProcessing('gpt://<folder_id>/yandexgt/latest')
```

You could use model name, in this case model uri will be built using configurated folder\_id:

```python
>>> llm_post_processor = LLMPostProcessing('yandexgt')
```

You could also pass a model version, which have ‘latest’ by default:

```python
>>> llm_post_processor = LLMPostProcessing('yandexgt', model_version='latest')
```

After post processor object creation you should add some instructions into it by using **.with\_instruction** method (which is not mutates the object, but creates a copy):

```python
>>> llm_post_processor = llm_post_processor.with_instruction("Make a short review")
>>> llm_post_processor = llm_post_processor.with_instruction(
...     "What the conversation topic",
...     response_format="json"
... )
```

Created object will looks like this:

```python
>>> llm_post_processor
LLMPostProcessing(model_name='yandexgt', model_version='latest', ...)
>>> llm_post_processor
LLMPostProcessing(..., instructions=(LLMPostProcessingInstruction(...), LLMPostProcessingInstruction(...)))
```

You also can use pydantic model or pydantic dataclass as response format.

**model\_name**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.LLMPostProcessing.model_name}

The [ID of the model](https://aistudio.yandex.ru/docs/foundation-models/concepts/yandexgpt/models) Model name to be used for completion generation; If the name contains ‘://’, it is treated as a full URI. Otherwise constructs a URI in the form ‘gpt://<folder\_id>/<model\_name>/<model\_version>’

**model\_version**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)* = *'latest'*{#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.LLMPostProcessing.model_version}

The version of the model to use. Defaults to ‘latest’

**instructions**\: *[Sequence](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence)[[LLMPostProcessingInstruction](#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.LLMPostProcessingInstruction)*] = *()*{#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.LLMPostProcessing.instructions}

A list of instructions to perform with transcription.

**with\_instruction**(*instruction*, *response\_format=None*){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.LLMPostProcessing.with_instruction}

Creates a new LLMPostProcessing object, but with given instruction appended.

#|
|| Parameters | 

- **instruction** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) – instruction for model.
- **response\_format** ([*Literal*](https://docs.python.org/3/library/typing.html#typing.Literal)*['json'] \| ~yandex\_ai\_studio\_sdk.\_types.schemas.JsonSchemaResponseType \| type \| None*) – format of the response returned by the model. Format could be described as:
- *None* for usual text response (default);
- ’*json*’ string to tell a model to return JSON object;
- dictionary with a JsonSchema to enforce a specific JSON structure for the model’s response based on a provided schema;
- pydantic model or pydantic dataclass (which will be transformed into JsonSchema by SDK);
 ||
|| Return type | [*LLMPostProcessing*](#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.LLMPostProcessing) ||
|#

**\_\_init\_\_**(*model\_name*, *model\_version='latest'*, *instructions=()*){#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.LLMPostProcessing.__init__i}

#|
|| Parameters | 

- **model\_name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str))
- **model\_version** ([*str*](https://docs.python.org/3/library/stdtypes.html#str))
- **instructions** ([*Sequence*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence)*[*[*LLMPostProcessingInstruction*](#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.LLMPostProcessingInstruction)*]*) ||
|| Return type | None ||
|#

### *class* yandex\_ai\_studio\_sdk.\_speechkit.speech\_to\_text.result.audio\_cursors.**AudioCursors**{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.audio_cursors.AudioCursors}

AudioCursors(received\_data\_ms: ‘int’, reset\_time\_ms: ‘int’, partial\_time\_ms: ‘int’, final\_time\_ms: ‘int’, final\_index: ‘int’, eou\_time\_ms: ‘int’)

**received\_data\_ms**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.audio_cursors.AudioCursors.received_data_ms}

Amount of audio chunks server received. This cursor is moved after each audio chunk was received by server.

**reset\_time\_ms**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.audio_cursors.AudioCursors.reset_time_ms}

Input stream reset data.

**partial\_time\_ms**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.audio_cursors.AudioCursors.partial_time_ms}

How much audio was processed. This time includes trimming silences as well. This cursor is moved after server received enough data to update recognition results (includes silence as well).

**final\_time\_ms**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.audio_cursors.AudioCursors.final_time_ms}

Time of last final. This cursor is moved when server decides that recognition from start of audio until *final\_time\_ms* will not change anymore. Usually this event is followed by EOU detection. This behavior could change in future.

**final\_index**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.audio_cursors.AudioCursors.final_index}

This is index of last final server send. Incremented after each new final.

**eou\_time\_ms**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.audio_cursors.AudioCursors.eou_time_ms}

Estimated time of EOU. Cursor is updated after each new EOU is sent. For external classifier this equals to [received\_data\_ms] at the moment EOU event arrives. For internal classifier this is estimation of time. The time is not exact and has the same guarantees as word timings.

### *class* yandex\_ai\_studio\_sdk.\_speechkit.speech\_to\_text.result.status\_code.**StatusCode**{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.status_code.StatusCode}

StatusCode(message: ‘str’, code\_type: ‘EnumWithUnknownAlias[CodeType]’)

**message**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.status_code.StatusCode.message}

Human readable message

**code\_type**\: *[CodeType](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.status_code.CodeType) | [UnknownEnumValue](other.md#yandex_ai_studio_sdk._types.schemas.yandex_ai_studio_sdk._types.enum.UnknownEnumValue)[[CodeType](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.status_code.CodeType)*]{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.status_code.StatusCode.code_type}

Code type

### *class* yandex\_ai\_studio\_sdk.\_speechkit.speech\_to\_text.result.status\_code.**CodeType**{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.status_code.CodeType}

**WORKING** = *1*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.status_code.CodeType.WORKING}

All good.

**WARNING** = *2*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.status_code.CodeType.WARNING}

For example, if speech is sent not in real-time or context is unknown and we’ve made fallback.

**CLOSED** = *3*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.status_code.CodeType.CLOSED}

After session was closed.

*classmethod* **Unknown**(*name*, *value*){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.status_code.CodeType.Unknown}

#|
|| Parameters | 

- **name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str))
- **value** ([*int*](https://docs.python.org/3/library/functions.html#int)) ||
|#

**\_\_new\_\_**(*value*){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.status_code.CodeType.__new__i}

**conjugate**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.status_code.CodeType.conjugate}

Returns self, the complex conjugate of any int.

**bit\_length**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.status_code.CodeType.bit_length}

Number of bits necessary to represent self in binary.

```python
>>> bin(37)
'0b100101'
>>> (37).bit_length()
6
```

**bit\_count**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.status_code.CodeType.bit_count}

Number of ones in the binary representation of the absolute value of self.

Also known as the population count.

```python
>>> bin(13)
'0b1101'
>>> (13).bit_count()
3
```

**as\_integer\_ratio**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.status_code.CodeType.as_integer_ratio}

Return a pair of integers, whose ratio is equal to the original int.

The ratio is in lowest terms and has a positive denominator.

```python
>>> (10).as_integer_ratio()
(10, 1)
>>> (-10).as_integer_ratio()
(-10, 1)
>>> (0).as_integer_ratio()
(0, 1)
```

**is\_integer**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.status_code.CodeType.is_integer}

Returns True. Exists for duck type compatibility with float.is\_integer.

**real**{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.status_code.CodeType.real}

the real part of a complex number

**imag**{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.status_code.CodeType.imag}

the imaginary part of a complex number

**numerator**{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.status_code.CodeType.numerator}

the numerator of a rational number in lowest terms

**denominator**{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.status_code.CodeType.denominator}

the denominator of a rational number in lowest terms

**\_\_init\_\_**(*\*args*, *\*\*kwds*){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.status_code.CodeType.__init__i}

### *class* yandex\_ai\_studio\_sdk.\_speechkit.speech\_to\_text.result.classifier.**PhraseHighlight**{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.classifier.PhraseHighlight}

PhraseHighlight(text: ‘str’, timespan: ‘TimeSpan’)

**text**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.classifier.PhraseHighlight.text}

Text transcription of the highlighted audio segment.

**timespan**\: *[TimeSpan](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.utils.TimeSpan)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.classifier.PhraseHighlight.timespan}

highlighted audio segment boundaries

**\_\_init\_\_**(*text*, *timespan*){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.classifier.PhraseHighlight.__init__i}

#|
|| Parameters | 

- **text** ([*str*](https://docs.python.org/3/library/stdtypes.html#str))
- **timespan** ([*TimeSpan*](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.utils.TimeSpan)) ||
|| Return type | None ||
|#

### *class* yandex\_ai\_studio\_sdk.\_speechkit.speech\_to\_text.result.classifier.**ClassifierBase**{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.classifier.ClassifierBase}

ClassifierBase(name: ‘str’, highlights: ‘tuple[PhraseHighlight, …]’, labels: ‘dict[str, float]’, timespan: ‘TimeSpan’)

**name**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.classifier.ClassifierBase.name}

Name of the triggered classifier.

**highlights**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[PhraseHighlight](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.classifier.PhraseHighlight)*]... ,{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.classifier.ClassifierBase.highlights}

List of highlights, i.e. parts of phrase that determine the result of the classification

**labels**\: *[dict](https://docs.python.org/3/library/stdtypes.html#dict)[[str](https://docs.python.org/3/library/stdtypes.html#str), [float](https://docs.python.org/3/library/functions.html#float)*]{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.classifier.ClassifierBase.labels}

Classifier predictions

**timespan**\: *[TimeSpan](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.utils.TimeSpan)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.classifier.ClassifierBase.timespan}

Audio segment used for classification boundaries

*property* **confidence**\: *[float](https://docs.python.org/3/library/functions.html#float)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.classifier.ClassifierBase.confidence}

Synonym for easy access to ‘confidence’ label if it exists

**\_\_init\_\_**(*name*, *highlights*, *labels*, *timespan*){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.classifier.ClassifierBase.__init__i}

#|
|| Parameters | 

- **name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str))
- **highlights** ([*tuple*](https://docs.python.org/3/library/stdtypes.html#tuple)*[*[*PhraseHighlight*](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.classifier.PhraseHighlight)*, ...]*)
- **labels** ([*dict*](https://docs.python.org/3/library/stdtypes.html#dict)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*,* [*float*](https://docs.python.org/3/library/functions.html#float)*]*)
- **timespan** ([*TimeSpan*](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.utils.TimeSpan)) ||
|| Return type | None ||
|#

### *class* yandex\_ai\_studio\_sdk.\_speechkit.speech\_to\_text.result.classifier.**ClassifierUpdate**{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.classifier.ClassifierUpdate}

Result of the triggered classifier

##### *class* **WindowType**{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.classifier.ClassifierUpdate.WindowType}

**LAST\_UTTERANCE** = *1*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.classifier.ClassifierUpdate.WindowType.LAST_UTTERANCE}

The result of applying the classifier to the last utterance response.

**LAST\_FINAL** = *2*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.classifier.ClassifierUpdate.WindowType.LAST_FINAL}

The result of applying the classifier to the last final response.

**LAST\_PARTIAL** = *3*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.classifier.ClassifierUpdate.WindowType.LAST_PARTIAL}

The result of applying the classifier to the last partial response.

*classmethod* **Unknown**(*name*, *value*){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.classifier.ClassifierUpdate.WindowType.Unknown}

#|
|| Parameters | 

- **name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str))
- **value** ([*int*](https://docs.python.org/3/library/functions.html#int)) ||
|#

**\_\_new\_\_**(*value*){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.classifier.ClassifierUpdate.WindowType.__new__i}

**conjugate**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.classifier.ClassifierUpdate.WindowType.conjugate}

Returns self, the complex conjugate of any int.

**bit\_length**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.classifier.ClassifierUpdate.WindowType.bit_length}

Number of bits necessary to represent self in binary.

```python
>>> bin(37)
'0b100101'
>>> (37).bit_length()
6
```

**bit\_count**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.classifier.ClassifierUpdate.WindowType.bit_count}

Number of ones in the binary representation of the absolute value of self.

Also known as the population count.

```python
>>> bin(13)
'0b1101'
>>> (13).bit_count()
3
```

**as\_integer\_ratio**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.classifier.ClassifierUpdate.WindowType.as_integer_ratio}

Return a pair of integers, whose ratio is equal to the original int.

The ratio is in lowest terms and has a positive denominator.

```python
>>> (10).as_integer_ratio()
(10, 1)
>>> (-10).as_integer_ratio()
(-10, 1)
>>> (0).as_integer_ratio()
(0, 1)
```

**is\_integer**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.classifier.ClassifierUpdate.WindowType.is_integer}

Returns True. Exists for duck type compatibility with float.is\_integer.

**real**{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.classifier.ClassifierUpdate.WindowType.real}

the real part of a complex number

**imag**{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.classifier.ClassifierUpdate.WindowType.imag}

the imaginary part of a complex number

**numerator**{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.classifier.ClassifierUpdate.WindowType.numerator}

the numerator of a rational number in lowest terms

**denominator**{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.classifier.ClassifierUpdate.WindowType.denominator}

the denominator of a rational number in lowest terms

**\_\_init\_\_**(*\*args*, *\*\*kwds*){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.classifier.ClassifierUpdate.WindowType.__init__i}

**window\_type**\: *[EnumWithUnknownAlias](other.md#yandex_ai_studio_sdk._types.schemas.yandex_ai_studio_sdk._types.enum.EnumWithUnknownAlias)[[WindowType](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.classifier.ClassifierUpdate.WindowType)*]{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.classifier.ClassifierUpdate.window_type}

Response window type.

**\_\_init\_\_**(*name*, *highlights*, *labels*, *timespan*, *window\_type*){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.classifier.ClassifierUpdate.__init__i}

#|
|| Parameters | 

- **name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str))
- **highlights** ([*tuple*](https://docs.python.org/3/library/stdtypes.html#tuple)*[*[*PhraseHighlight*](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.classifier.PhraseHighlight)*, ...]*)
- **labels** ([*dict*](https://docs.python.org/3/library/stdtypes.html#dict)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*,* [*float*](https://docs.python.org/3/library/functions.html#float)*]*)
- **timespan** ([*TimeSpan*](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.utils.TimeSpan))
- **window\_type** ([*EnumWithUnknownAlias*](other.md#yandex_ai_studio_sdk._types.schemas.yandex_ai_studio_sdk._types.enum.EnumWithUnknownAlias)*[*[*WindowType*](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.classifier.ClassifierUpdate.WindowType)*]*) ||
|| Return type | None ||
|#

*property* **confidence**\: *[float](https://docs.python.org/3/library/functions.html#float)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.classifier.ClassifierUpdate.confidence}

Synonym for easy access to ‘confidence’ label if it exists

**name**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.classifier.ClassifierUpdate.name}

Name of the triggered classifier.

**highlights**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[PhraseHighlight](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.classifier.PhraseHighlight)*]... ,{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.classifier.ClassifierUpdate.highlights}

List of highlights, i.e. parts of phrase that determine the result of the classification

**labels**\: *[dict](https://docs.python.org/3/library/stdtypes.html#dict)[[str](https://docs.python.org/3/library/stdtypes.html#str), [float](https://docs.python.org/3/library/functions.html#float)*]{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.classifier.ClassifierUpdate.labels}

Classifier predictions

**timespan**\: *[TimeSpan](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.utils.TimeSpan)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.classifier.ClassifierUpdate.timespan}

Audio segment used for classification boundaries

### *class* yandex\_ai\_studio\_sdk.\_speechkit.speech\_to\_text.result.classifier.**ClassifierResult**{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.classifier.ClassifierResult}

Result of a classifier, tied to SpeechToTextResult object hierarchy

**\_\_init\_\_**(*name*, *highlights*, *labels*, *timespan*){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.classifier.ClassifierResult.__init__i}

#|
|| Parameters | 

- **name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str))
- **highlights** ([*tuple*](https://docs.python.org/3/library/stdtypes.html#tuple)*[*[*PhraseHighlight*](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.classifier.PhraseHighlight)*, ...]*)
- **labels** ([*dict*](https://docs.python.org/3/library/stdtypes.html#dict)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*,* [*float*](https://docs.python.org/3/library/functions.html#float)*]*)
- **timespan** ([*TimeSpan*](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.utils.TimeSpan)) ||
|| Return type | None ||
|#

*property* **confidence**\: *[float](https://docs.python.org/3/library/functions.html#float)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.classifier.ClassifierResult.confidence}

Synonym for easy access to ‘confidence’ label if it exists

**name**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.classifier.ClassifierResult.name}

Name of the triggered classifier.

**highlights**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[PhraseHighlight](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.classifier.PhraseHighlight)*]... ,{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.classifier.ClassifierResult.highlights}

List of highlights, i.e. parts of phrase that determine the result of the classification

**labels**\: *[dict](https://docs.python.org/3/library/stdtypes.html#dict)[[str](https://docs.python.org/3/library/stdtypes.html#str), [float](https://docs.python.org/3/library/functions.html#float)*]{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.classifier.ClassifierResult.labels}

Classifier predictions

**timespan**\: *[TimeSpan](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.utils.TimeSpan)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.classifier.ClassifierResult.timespan}

Audio segment used for classification boundaries

### *class* yandex\_ai\_studio\_sdk.\_speechkit.speech\_to\_text.result.classifier\_final.**FinalClassifierResult**{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.classifier_final.FinalClassifierResult}

Result of a classifier, tied to SpeechToTextResult object hierarchy and to specific final

**final**\: *[SpeechToTextStreamingEvent](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEvent)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.classifier_final.FinalClassifierResult.final}

corresponding final event to on\_final classifier result

**\_\_init\_\_**(*name*, *highlights*, *labels*, *timespan*, *final*){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.classifier_final.FinalClassifierResult.__init__i}

#|
|| Parameters | 

- **name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str))
- **highlights** ([*tuple*](https://docs.python.org/3/library/stdtypes.html#tuple)*[*[*PhraseHighlight*](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.classifier.PhraseHighlight)*, ...]*)
- **labels** ([*dict*](https://docs.python.org/3/library/stdtypes.html#dict)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*,* [*float*](https://docs.python.org/3/library/functions.html#float)*]*)
- **timespan** ([*TimeSpan*](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.utils.TimeSpan))
- **final** ([*SpeechToTextStreamingEvent*](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEvent)) ||
|| Return type | None ||
|#

*property* **confidence**\: *[float](https://docs.python.org/3/library/functions.html#float)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.classifier_final.FinalClassifierResult.confidence}

Synonym for easy access to ‘confidence’ label if it exists

**name**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.classifier_final.FinalClassifierResult.name}

Name of the triggered classifier.

**highlights**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[PhraseHighlight](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.classifier.PhraseHighlight)*]... ,{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.classifier_final.FinalClassifierResult.highlights}

List of highlights, i.e. parts of phrase that determine the result of the classification

**labels**\: *[dict](https://docs.python.org/3/library/stdtypes.html#dict)[[str](https://docs.python.org/3/library/stdtypes.html#str), [float](https://docs.python.org/3/library/functions.html#float)*]{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.classifier_final.FinalClassifierResult.labels}

Classifier predictions

**timespan**\: *[TimeSpan](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.utils.TimeSpan)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.classifier_final.FinalClassifierResult.timespan}

Audio segment used for classification boundaries

### *class* yandex\_ai\_studio\_sdk.\_speechkit.speech\_to\_text.result.descriptive\_statistics.**DescriptiveStatistics**{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.descriptive_statistics.DescriptiveStatistics}

DescriptiveStatistics(min: ‘float’, max: ‘float’, mean: ‘float’, std: ‘float’, quantiles: ‘dict[float, float]’)

**min**\: *[float](https://docs.python.org/3/library/functions.html#float)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.descriptive_statistics.DescriptiveStatistics.min}

Minimum observed value.

**max**\: *[float](https://docs.python.org/3/library/functions.html#float)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.descriptive_statistics.DescriptiveStatistics.max}

Maximum observed value.

**mean**\: *[float](https://docs.python.org/3/library/functions.html#float)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.descriptive_statistics.DescriptiveStatistics.mean}

Estimated mean of distribution.

**std**\: *[float](https://docs.python.org/3/library/functions.html#float)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.descriptive_statistics.DescriptiveStatistics.std}

Estimated standard deviation of distribution.

**quantiles**\: *[dict](https://docs.python.org/3/library/stdtypes.html#dict)[[float](https://docs.python.org/3/library/functions.html#float), [float](https://docs.python.org/3/library/functions.html#float)*]{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.descriptive_statistics.DescriptiveStatistics.quantiles}

List of evaluated quantiles.

### *class* yandex\_ai\_studio\_sdk.\_speechkit.speech\_to\_text.result.speaker\_analysis.**SpeakerAnalysis**{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.speaker_analysis.SpeakerAnalysis}

Speech statistics for every speaker.

##### *class* **WindowType**{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.speaker_analysis.SpeakerAnalysis.WindowType}

**LAST\_UTTERANCE** = *2*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.speaker_analysis.SpeakerAnalysis.WindowType.LAST_UTTERANCE}

Stats for last utterance

**TOTAL** = *1*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.speaker_analysis.SpeakerAnalysis.WindowType.TOTAL}

Stats for all received audio

*classmethod* **Unknown**(*name*, *value*){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.speaker_analysis.SpeakerAnalysis.WindowType.Unknown}

#|
|| Parameters | 

- **name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str))
- **value** ([*int*](https://docs.python.org/3/library/functions.html#int)) ||
|#

**\_\_new\_\_**(*value*){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.speaker_analysis.SpeakerAnalysis.WindowType.__new__i}

**conjugate**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.speaker_analysis.SpeakerAnalysis.WindowType.conjugate}

Returns self, the complex conjugate of any int.

**bit\_length**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.speaker_analysis.SpeakerAnalysis.WindowType.bit_length}

Number of bits necessary to represent self in binary.

```python
>>> bin(37)
'0b100101'
>>> (37).bit_length()
6
```

**bit\_count**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.speaker_analysis.SpeakerAnalysis.WindowType.bit_count}

Number of ones in the binary representation of the absolute value of self.

Also known as the population count.

```python
>>> bin(13)
'0b1101'
>>> (13).bit_count()
3
```

**as\_integer\_ratio**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.speaker_analysis.SpeakerAnalysis.WindowType.as_integer_ratio}

Return a pair of integers, whose ratio is equal to the original int.

The ratio is in lowest terms and has a positive denominator.

```python
>>> (10).as_integer_ratio()
(10, 1)
>>> (-10).as_integer_ratio()
(-10, 1)
>>> (0).as_integer_ratio()
(0, 1)
```

**is\_integer**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.speaker_analysis.SpeakerAnalysis.WindowType.is_integer}

Returns True. Exists for duck type compatibility with float.is\_integer.

**real**{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.speaker_analysis.SpeakerAnalysis.WindowType.real}

the real part of a complex number

**imag**{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.speaker_analysis.SpeakerAnalysis.WindowType.imag}

the imaginary part of a complex number

**numerator**{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.speaker_analysis.SpeakerAnalysis.WindowType.numerator}

the numerator of a rational number in lowest terms

**denominator**{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.speaker_analysis.SpeakerAnalysis.WindowType.denominator}

the denominator of a rational number in lowest terms

**\_\_init\_\_**(*\*args*, *\*\*kwds*){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.speaker_analysis.SpeakerAnalysis.WindowType.__init__i}

**timespan**\: *[TimeSpan](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.utils.TimeSpan)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.speaker_analysis.SpeakerAnalysis.timespan}

Audio segment boundaries

**speaker\_tag**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.speaker_analysis.SpeakerAnalysis.speaker_tag}

Speaker tag.

**window\_type**\: *[EnumWithUnknownAlias](other.md#yandex_ai_studio_sdk._types.schemas.yandex_ai_studio_sdk._types.enum.EnumWithUnknownAlias)[[WindowType](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.speaker_analysis.SpeakerAnalysis.WindowType)*]{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.speaker_analysis.SpeakerAnalysis.window_type}

Response window type.

**total\_speech\_ms**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.speaker_analysis.SpeakerAnalysis.total_speech_ms}

Total speech duration.

**speech\_ratio**\: *[float](https://docs.python.org/3/library/functions.html#float)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.speaker_analysis.SpeakerAnalysis.speech_ratio}

Speech ratio within audio segment.

**total\_silence\_ms**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.speaker_analysis.SpeakerAnalysis.total_silence_ms}

Total duration of silence.

**silence\_ratio**\: *[float](https://docs.python.org/3/library/functions.html#float)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.speaker_analysis.SpeakerAnalysis.silence_ratio}

Silence ratio within audio segment.

**words\_count**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.speaker_analysis.SpeakerAnalysis.words_count}

Number of words in recognized speech.

**letters\_count**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.speaker_analysis.SpeakerAnalysis.letters_count}

Number of letters in recognized speech.

**words\_per\_second**\: *[DescriptiveStatistics](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.descriptive_statistics.DescriptiveStatistics)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.speaker_analysis.SpeakerAnalysis.words_per_second}

Descriptive statistics for words per second distribution.

**letters\_per\_second**\: *[DescriptiveStatistics](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.descriptive_statistics.DescriptiveStatistics)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.speaker_analysis.SpeakerAnalysis.letters_per_second}

Descriptive statistics for letters per second distribution.

**words\_per\_utterance**\: *[DescriptiveStatistics](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.descriptive_statistics.DescriptiveStatistics)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.speaker_analysis.SpeakerAnalysis.words_per_utterance}

Descriptive statistics for words per utterance distribution.

**letters\_per\_utterance**\: *[DescriptiveStatistics](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.descriptive_statistics.DescriptiveStatistics)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.speaker_analysis.SpeakerAnalysis.letters_per_utterance}

Descriptive statistics for letters per utterance distribution.

**utterance\_count**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.speaker_analysis.SpeakerAnalysis.utterance_count}

Number of utterances

**utterance\_duration\_estimation**\: *[DescriptiveStatistics](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.descriptive_statistics.DescriptiveStatistics)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.speaker_analysis.SpeakerAnalysis.utterance_duration_estimation}

Descriptive statistics for utterance duration distribution

**\_\_init\_\_**(*timespan*, *speaker\_tag*, *window\_type*, *total\_speech\_ms*, *speech\_ratio*, *total\_silence\_ms*, *silence\_ratio*, *words\_count*, *letters\_count*, *words\_per\_second*, *letters\_per\_second*, *words\_per\_utterance*, *letters\_per\_utterance*, *utterance\_count*, *utterance\_duration\_estimation*){#yandex_ai_studio_sdk._speechkit.speech_to_text.result.speaker_analysis.SpeakerAnalysis.__init__i}

#|
|| Parameters | 

- **timespan** ([*TimeSpan*](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.utils.TimeSpan))
- **speaker\_tag** ([*str*](https://docs.python.org/3/library/stdtypes.html#str))
- **window\_type** ([*EnumWithUnknownAlias*](other.md#yandex_ai_studio_sdk._types.schemas.yandex_ai_studio_sdk._types.enum.EnumWithUnknownAlias)*[*[*WindowType*](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.speaker_analysis.SpeakerAnalysis.WindowType)*]*)
- **total\_speech\_ms** ([*int*](https://docs.python.org/3/library/functions.html#int))
- **speech\_ratio** ([*float*](https://docs.python.org/3/library/functions.html#float))
- **total\_silence\_ms** ([*int*](https://docs.python.org/3/library/functions.html#int))
- **silence\_ratio** ([*float*](https://docs.python.org/3/library/functions.html#float))
- **words\_count** ([*int*](https://docs.python.org/3/library/functions.html#int))
- **letters\_count** ([*int*](https://docs.python.org/3/library/functions.html#int))
- **words\_per\_second** ([*DescriptiveStatistics*](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.descriptive_statistics.DescriptiveStatistics))
- **letters\_per\_second** ([*DescriptiveStatistics*](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.descriptive_statistics.DescriptiveStatistics))
- **words\_per\_utterance** ([*DescriptiveStatistics*](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.descriptive_statistics.DescriptiveStatistics))
- **letters\_per\_utterance** ([*DescriptiveStatistics*](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.descriptive_statistics.DescriptiveStatistics))
- **utterance\_count** ([*int*](https://docs.python.org/3/library/functions.html#int))
- **utterance\_duration\_estimation** ([*DescriptiveStatistics*](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.descriptive_statistics.DescriptiveStatistics)) ||
|| Return type | None ||
|#

### *class* yandex\_ai\_studio\_sdk.\_speechkit.speech\_to\_text.result.conversation\_analysis.**InterruptsEvaluation**{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.conversation_analysis.InterruptsEvaluation}

Interrupt description

**speaker\_tag**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.conversation_analysis.InterruptsEvaluation.speaker_tag}

Speaker tag.

**interrupts\_count**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.conversation_analysis.InterruptsEvaluation.interrupts_count}

Number of interrupts made by the speaker.

**interrupts\_duration\_ms**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.conversation_analysis.InterruptsEvaluation.interrupts_duration_ms}

Total duration of all interrupts.

**interrupts**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[TimeSpan](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.utils.TimeSpan)*]... ,{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.conversation_analysis.InterruptsEvaluation.interrupts}

Boundaries for every interrupt.

### *class* yandex\_ai\_studio\_sdk.\_speechkit.speech\_to\_text.result.conversation\_analysis.**ConversationAnalysis**{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.conversation_analysis.ConversationAnalysis}

Conversation statistics.

**timespan**\: *[TimeSpan](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.utils.TimeSpan)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.conversation_analysis.ConversationAnalysis.timespan}

Audio segment boundaries

**total\_simultaneous\_silence\_duration\_ms**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.conversation_analysis.ConversationAnalysis.total_simultaneous_silence_duration_ms}

Total simultaneous silence duration.

**total\_simultaneous\_silence\_ratio**\: *[float](https://docs.python.org/3/library/functions.html#float)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.conversation_analysis.ConversationAnalysis.total_simultaneous_silence_ratio}

Simultaneous silence ratio within audio segment.

**simultaneous\_silence\_duration\_estimation**\: *[DescriptiveStatistics](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.descriptive_statistics.DescriptiveStatistics)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.conversation_analysis.ConversationAnalysis.simultaneous_silence_duration_estimation}

Descriptive statistics for simultaneous silence duration distribution.

**total\_simultaneous\_speech\_duration\_ms**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.conversation_analysis.ConversationAnalysis.total_simultaneous_speech_duration_ms}

Total simultaneous speech duration.

**total\_simultaneous\_speech\_ratio**\: *[float](https://docs.python.org/3/library/functions.html#float)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.conversation_analysis.ConversationAnalysis.total_simultaneous_speech_ratio}

Simultaneous speech ratio within audio segment.

**simultaneous\_speech\_duration\_estimation**\: *[DescriptiveStatistics](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.descriptive_statistics.DescriptiveStatistics)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.conversation_analysis.ConversationAnalysis.simultaneous_speech_duration_estimation}

Descriptive statistics for simultaneous speech duration distribution.

**speaker\_interrupts**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[InterruptsEvaluation](#yandex_ai_studio_sdk._speechkit.speech_to_text.result.conversation_analysis.InterruptsEvaluation)*]... ,{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.conversation_analysis.ConversationAnalysis.speaker_interrupts}

Interrupts description for every speaker.

**total\_speech\_duration\_ms**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.conversation_analysis.ConversationAnalysis.total_speech_duration_ms}

Total speech duration, including both simultaneous and separate speech.

**total\_speech\_ratio**\: *[float](https://docs.python.org/3/library/functions.html#float)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.conversation_analysis.ConversationAnalysis.total_speech_ratio}

Total speech ratio within audio segment.

### *class* yandex\_ai\_studio\_sdk.\_speechkit.speech\_to\_text.result.llm\_post\_process\_result.**LLMPostProcessResult**{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.llm_post_process_result.LLMPostProcessResult}

Result of the LLM postprocessing

**usage**\: *[Usage](model_results.md#yandex_ai_studio_sdk._models.completions.result.Usage)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.llm_post_process_result.LLMPostProcessResult.usage}

A set of statistics describing the number of content tokens used by the completion model.

**texts**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[str](https://docs.python.org/3/library/stdtypes.html#str)*]... ,{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.llm_post_process_result.LLMPostProcessResult.texts}

text results returned by model

**instructions**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[str](https://docs.python.org/3/library/stdtypes.html#str), ...] | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.llm_post_process_result.LLMPostProcessResult.instructions}

instructions given to model

*property* **by\_instructions**\: *[dict](https://docs.python.org/3/library/stdtypes.html#dict)[[str](https://docs.python.org/3/library/stdtypes.html#str), [str](https://docs.python.org/3/library/stdtypes.html#str)*]{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.llm_post_process_result.LLMPostProcessResult.by_instructions}

**count**(*value*) → integer -- return number of occurrences of value{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.llm_post_process_result.LLMPostProcessResult.count}

**index**(*value*[, *start*[, *stop*]]) → integer -- return first index of value.{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.llm_post_process_result.LLMPostProcessResult.index}

Raises ValueError if the value is not present.

Supporting start and stop arguments is optional, but recommended.

### *class* yandex\_ai\_studio\_sdk.\_speechkit.speech\_to\_text.result.utils.**TimeSpan**{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.utils.TimeSpan}

TimeSpan(start\_time\_ms: ‘int’, end\_time\_ms: ‘int’)

**start\_time\_ms**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.utils.TimeSpan.start_time_ms}

Audio segment start time.

**end\_time\_ms**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.utils.TimeSpan.end_time_ms}

Audio segment end time.

*property* **length\_ms**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.result.utils.TimeSpan.length_ms}

Return length of given time span in milliseconds

## Enum-like settings

yandex\_ai\_studio\_sdk.\_speechkit.enums.**AudioFormatOptionsTypeT** = *TypeVar(AudioFormatOptionsTypeT, AudioFormatOptions, AudioFormatOptions)*{#yandex_ai_studio_sdk._speechkit.enums.AudioFormatOptionsTypeT}

**Type:**[**TypeVar**](https://docs.python.org/3/library/typing.html#typing.TypeVar)

Invariant [**TypeVar**](https://docs.python.org/3/library/typing.html#typing.TypeVar) constrained to **yandex.cloud.ai.stt.v3.stt\_pb2.AudioFormatOptions** and **yandex.cloud.ai.tts.v3.tts\_pb2.AudioFormatOptions**.

### *class* yandex\_ai\_studio\_sdk.\_speechkit.enums.**PCM16**{#yandex_ai_studio_sdk._speechkit.enums.PCM16}

*static* **\_\_new\_\_**(*cls*, *sample\_rate\_hertz*, *channels*){#yandex_ai_studio_sdk._speechkit.enums.PCM16.__new__i}

#|
|| Parameters | 

- **sample\_rate\_hertz** ([*int*](https://docs.python.org/3/library/functions.html#int))
- **channels** ([*int*](https://docs.python.org/3/library/functions.html#int)) ||
|#

**\_\_init\_\_**(*sample\_rate\_hertz*, *channels*){#yandex_ai_studio_sdk._speechkit.enums.PCM16.__init__i}

#|
|| Parameters | 

- **sample\_rate\_hertz** ([*int*](https://docs.python.org/3/library/functions.html#int))
- **channels** ([*int*](https://docs.python.org/3/library/functions.html#int)) ||
|#

*property* **sample\_rate\_hertz**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_ai_studio_sdk._speechkit.enums.PCM16.sample_rate_hertz}

*property* **channels**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_ai_studio_sdk._speechkit.enums.PCM16.channels}

*property* **value**\: *[Never](https://docs.python.org/3/library/typing.html#typing.Never)*{#yandex_ai_studio_sdk._speechkit.enums.PCM16.value}

**as\_integer\_ratio**(){#yandex_ai_studio_sdk._speechkit.enums.PCM16.as_integer_ratio}

Return a pair of integers, whose ratio is equal to the original int.

The ratio is in lowest terms and has a positive denominator.

```python
>>> (10).as_integer_ratio()
(10, 1)
>>> (-10).as_integer_ratio()
(-10, 1)
>>> (0).as_integer_ratio()
(0, 1)
```

**bit\_count**(){#yandex_ai_studio_sdk._speechkit.enums.PCM16.bit_count}

Number of ones in the binary representation of the absolute value of self.

Also known as the population count.

```python
>>> bin(13)
'0b1101'
>>> (13).bit_count()
3
```

**bit\_length**(){#yandex_ai_studio_sdk._speechkit.enums.PCM16.bit_length}

Number of bits necessary to represent self in binary.

```python
>>> bin(37)
'0b100101'
>>> (37).bit_length()
6
```

**conjugate**(){#yandex_ai_studio_sdk._speechkit.enums.PCM16.conjugate}

Returns self, the complex conjugate of any int.

**denominator**{#yandex_ai_studio_sdk._speechkit.enums.PCM16.denominator}

the denominator of a rational number in lowest terms

*property* **enum\_type**\: *[type](https://docs.python.org/3/library/functions.html#type)[[ProtoBasedEnumTypeT](other.md#yandex_ai_studio_sdk._types.enum.ProtoBasedEnumTypeT)*]{#yandex_ai_studio_sdk._speechkit.enums.PCM16.enum_type}

**imag**{#yandex_ai_studio_sdk._speechkit.enums.PCM16.imag}

the imaginary part of a complex number

**is\_integer**(){#yandex_ai_studio_sdk._speechkit.enums.PCM16.is_integer}

Returns True. Exists for duck type compatibility with float.is\_integer.

*property* **name**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._speechkit.enums.PCM16.name}

**numerator**{#yandex_ai_studio_sdk._speechkit.enums.PCM16.numerator}

the numerator of a rational number in lowest terms

**real**{#yandex_ai_studio_sdk._speechkit.enums.PCM16.real}

the real part of a complex number

### *class* yandex\_ai\_studio\_sdk.\_speechkit.enums.**AudioFormat**{#yandex_ai_studio_sdk._speechkit.enums.AudioFormat}

**MP3** = *3*{#yandex_ai_studio_sdk._speechkit.enums.AudioFormat.MP3}

Data is encoded using MPEG-1/2 Layer III and compressed using the MP3 container format

**WAV** = *1*{#yandex_ai_studio_sdk._speechkit.enums.AudioFormat.WAV}

Audio bit depth 16-bit signed little-endian (Linear PCM) packed into WAV container format

**OGG\_OPUS** = *2*{#yandex_ai_studio_sdk._speechkit.enums.AudioFormat.OGG_OPUS}

Data is encoded using the OPUS audio codec and compressed using the OGG container format

*classmethod* **PCM16**(*sample\_rate\_hertz*, *channels=1*){#yandex_ai_studio_sdk._speechkit.enums.AudioFormat.PCM16}

Audio bit depth 16-bit signed little-endian (Linear PCM).

#|
|| Parameters | 

- **sample\_rate\_hertz** ([*int*](https://docs.python.org/3/library/functions.html#int))
- **channels** ([*int*](https://docs.python.org/3/library/functions.html#int)) ||
|| Return type | [*PCM16*](#yandex_ai_studio_sdk._speechkit.enums.PCM16) ||
|#

*classmethod* **Unknown**(*name*, *value*){#yandex_ai_studio_sdk._speechkit.enums.AudioFormat.Unknown}

#|
|| Parameters | 

- **name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str))
- **value** ([*int*](https://docs.python.org/3/library/functions.html#int)) ||
|#

**\_\_new\_\_**(*value*){#yandex_ai_studio_sdk._speechkit.enums.AudioFormat.__new__i}

**conjugate**(){#yandex_ai_studio_sdk._speechkit.enums.AudioFormat.conjugate}

Returns self, the complex conjugate of any int.

**bit\_length**(){#yandex_ai_studio_sdk._speechkit.enums.AudioFormat.bit_length}

Number of bits necessary to represent self in binary.

```python
>>> bin(37)
'0b100101'
>>> (37).bit_length()
6
```

**bit\_count**(){#yandex_ai_studio_sdk._speechkit.enums.AudioFormat.bit_count}

Number of ones in the binary representation of the absolute value of self.

Also known as the population count.

```python
>>> bin(13)
'0b1101'
>>> (13).bit_count()
3
```

**as\_integer\_ratio**(){#yandex_ai_studio_sdk._speechkit.enums.AudioFormat.as_integer_ratio}

Return a pair of integers, whose ratio is equal to the original int.

The ratio is in lowest terms and has a positive denominator.

```python
>>> (10).as_integer_ratio()
(10, 1)
>>> (-10).as_integer_ratio()
(-10, 1)
>>> (0).as_integer_ratio()
(0, 1)
```

**is\_integer**(){#yandex_ai_studio_sdk._speechkit.enums.AudioFormat.is_integer}

Returns True. Exists for duck type compatibility with float.is\_integer.

**real**{#yandex_ai_studio_sdk._speechkit.enums.AudioFormat.real}

the real part of a complex number

**imag**{#yandex_ai_studio_sdk._speechkit.enums.AudioFormat.imag}

the imaginary part of a complex number

**numerator**{#yandex_ai_studio_sdk._speechkit.enums.AudioFormat.numerator}

the numerator of a rational number in lowest terms

**denominator**{#yandex_ai_studio_sdk._speechkit.enums.AudioFormat.denominator}

the denominator of a rational number in lowest terms

**\_\_init\_\_**(*\*args*, *\*\*kwds*){#yandex_ai_studio_sdk._speechkit.enums.AudioFormat.__init__i}

### *class* yandex\_ai\_studio\_sdk.\_speechkit.enums.**LoudnessNormalization**{#yandex_ai_studio_sdk._speechkit.enums.LoudnessNormalization}

**MAX\_PEAK** = *1*{#yandex_ai_studio_sdk._speechkit.enums.LoudnessNormalization.MAX_PEAK}

The type of normalization, wherein the gain is changed to bring the highest PCM sample value or analog signal peak to a given level.

**LUFS** = *2*{#yandex_ai_studio_sdk._speechkit.enums.LoudnessNormalization.LUFS}

The type of normalization based on EBU R 128 recommendation

*classmethod* **Unknown**(*name*, *value*){#yandex_ai_studio_sdk._speechkit.enums.LoudnessNormalization.Unknown}

#|
|| Parameters | 

- **name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str))
- **value** ([*int*](https://docs.python.org/3/library/functions.html#int)) ||
|#

**\_\_new\_\_**(*value*){#yandex_ai_studio_sdk._speechkit.enums.LoudnessNormalization.__new__i}

**conjugate**(){#yandex_ai_studio_sdk._speechkit.enums.LoudnessNormalization.conjugate}

Returns self, the complex conjugate of any int.

**bit\_length**(){#yandex_ai_studio_sdk._speechkit.enums.LoudnessNormalization.bit_length}

Number of bits necessary to represent self in binary.

```python
>>> bin(37)
'0b100101'
>>> (37).bit_length()
6
```

**bit\_count**(){#yandex_ai_studio_sdk._speechkit.enums.LoudnessNormalization.bit_count}

Number of ones in the binary representation of the absolute value of self.

Also known as the population count.

```python
>>> bin(13)
'0b1101'
>>> (13).bit_count()
3
```

**as\_integer\_ratio**(){#yandex_ai_studio_sdk._speechkit.enums.LoudnessNormalization.as_integer_ratio}

Return a pair of integers, whose ratio is equal to the original int.

The ratio is in lowest terms and has a positive denominator.

```python
>>> (10).as_integer_ratio()
(10, 1)
>>> (-10).as_integer_ratio()
(-10, 1)
>>> (0).as_integer_ratio()
(0, 1)
```

**is\_integer**(){#yandex_ai_studio_sdk._speechkit.enums.LoudnessNormalization.is_integer}

Returns True. Exists for duck type compatibility with float.is\_integer.

**real**{#yandex_ai_studio_sdk._speechkit.enums.LoudnessNormalization.real}

the real part of a complex number

**imag**{#yandex_ai_studio_sdk._speechkit.enums.LoudnessNormalization.imag}

the imaginary part of a complex number

**numerator**{#yandex_ai_studio_sdk._speechkit.enums.LoudnessNormalization.numerator}

the numerator of a rational number in lowest terms

**denominator**{#yandex_ai_studio_sdk._speechkit.enums.LoudnessNormalization.denominator}

the denominator of a rational number in lowest terms

**\_\_init\_\_**(*\*args*, *\*\*kwds*){#yandex_ai_studio_sdk._speechkit.enums.LoudnessNormalization.__init__i}

### *class* yandex\_ai\_studio\_sdk.\_speechkit.enums.**LanguageCode**{#yandex_ai_studio_sdk._speechkit.enums.LanguageCode}

**auto** = *'auto'*{#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.auto}

[Automatic language detection](https://aistudio.yandex.ru/docs/speechkit/stt/models#language-labels)

**de\_DE** = *'de-DE'*{#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.de_DE}

German

**en\_US** = *'en-US'*{#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.en_US}

English

**es\_ES** = *'es-ES'*{#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.es_ES}

Spanish

**fi\_FI** = *'fi-FI'*{#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.fi_FI}

Finnish

**fr\_FR** = *'fr-FR'*{#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.fr_FR}

French

**he\_IL** = *'he-IL'*{#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.he_IL}

Hebrew

**it\_IT** = *'it-IT'*{#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.it_IT}

Italian

**kk\_KZ** = *'kk-KZ'*{#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.kk_KZ}

Kazakh

**nl\_NL** = *'nl-NL'*{#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.nl_NL}

Dutch

**pl\_PL** = *'pl-PL'*{#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.pl_PL}

Polish

**pt\_PT** = *'pt-PT'*{#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.pt_PT}

Portuguese

**pt\_BR** = *'pt-BR'*{#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.pt_BR}

Brazilian Portuguese

**ru\_RU** = *'ru-RU'*{#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.ru_RU}

Russian (default)

**sv\_SE** = *'sv-SE'*{#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.sv_SE}

Swedish

**tr\_TR** = *'tr-TR'*{#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.tr_TR}

Turkish

**uz\_UZ** = *'uz-UZ'*{#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.uz_UZ}

Uzbek (Latin script)

**\_\_new\_\_**(*value*){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.__new__i}

**encode**(*encoding='utf-8'*, *errors='strict'*){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.encode}

Encode the string using the codec registered for encoding.

encoding

  : The encoding in which to encode the string.

errors

  : The error handling scheme to use for encoding errors. The default is ‘strict’ meaning that encoding errors raise a UnicodeEncodeError.  Other possible values are ‘ignore’, ‘replace’ and ‘xmlcharrefreplace’ as well as any other name registered with codecs.register\_error that can handle UnicodeEncodeErrors.

**replace**(*old*, *new*, *count=-1*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.replace}

Return a copy with all occurrences of substring old replaced by new.

> countMaximum number of occurrences to replace. -1 (the default value) means replace all occurrences.

If the optional argument count is given, only the first count occurrences are replaced.

**split**(*sep=None*, *maxsplit=-1*){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.split}

Return a list of the substrings in the string, using sep as the separator string.

> sepThe separator used to split the string.When set to None (the default value), will split on any whitespace character (including n r t f and spaces) and will discard empty strings from the result.maxsplitMaximum number of splits. -1 (the default value) means no limit.

Splitting starts at the front of the string and works to the end.

Note, str.split() is mainly useful for data that has been intentionally delimited.  With natural text that includes punctuation, consider using the regular expression module.

**rsplit**(*sep=None*, *maxsplit=-1*){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.rsplit}

Return a list of the substrings in the string, using sep as the separator string.

> sepThe separator used to split the string.When set to None (the default value), will split on any whitespace character (including n r t f and spaces) and will discard empty strings from the result.maxsplitMaximum number of splits. -1 (the default value) means no limit.

Splitting starts at the end of the string and works to the front.

**join**(*iterable*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.join}

Concatenate any number of strings.

The string whose method is called is inserted in between each given string. The result is returned as a new string.

Example: ‘.’.join([‘ab’, ‘pq’, ‘rs’]) -> ‘ab.pq.rs’

**capitalize**(){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.capitalize}

Return a capitalized version of the string.

More specifically, make the first character have upper case and the rest lower case.

**casefold**(){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.casefold}

Return a version of the string suitable for caseless comparisons.

**title**(){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.title}

Return a version of the string where each word is titlecased.

More specifically, words start with uppercased characters and all remaining cased characters have lower case.

**center**(*width*, *fillchar=' '*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.center}

Return a centered string of length width.

Padding is done using the specified fill character (default is a space).

**count**(*sub*[, *start*[, *end*]]) → [int](https://docs.python.org/3/library/functions.html#int){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.count}

Return the number of non-overlapping occurrences of substring sub in string S[start:end].  Optional arguments start and end are interpreted as in slice notation.

**expandtabs**(*tabsize=8*){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.expandtabs}

Return a copy where all tab characters are expanded using spaces.

If tabsize is not given, a tab size of 8 characters is assumed.

**find**(*sub*[, *start*[, *end*]]) → [int](https://docs.python.org/3/library/functions.html#int){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.find}

Return the lowest index in S where substring sub is found, such that sub is contained within S[start:end].  Optional arguments start and end are interpreted as in slice notation.

Return -1 on failure.

**partition**(*sep*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.partition}

Partition the string into three parts using the given separator.

This will search for the separator in the string.  If the separator is found, returns a 3-tuple containing the part before the separator, the separator itself, and the part after it.

If the separator is not found, returns a 3-tuple containing the original string and two empty strings.

**index**(*sub*[, *start*[, *end*]]) → [int](https://docs.python.org/3/library/functions.html#int){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.index}

Return the lowest index in S where substring sub is found, such that sub is contained within S[start:end].  Optional arguments start and end are interpreted as in slice notation.

Raises ValueError when the substring is not found.

**ljust**(*width*, *fillchar=' '*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.ljust}

Return a left-justified string of length width.

Padding is done using the specified fill character (default is a space).

**lower**(){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.lower}

Return a copy of the string converted to lowercase.

**lstrip**(*chars=None*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.lstrip}

Return a copy of the string with leading whitespace removed.

If chars is given and not None, remove characters in chars instead.

**rfind**(*sub*[, *start*[, *end*]]) → [int](https://docs.python.org/3/library/functions.html#int){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.rfind}

Return the highest index in S where substring sub is found, such that sub is contained within S[start:end].  Optional arguments start and end are interpreted as in slice notation.

Return -1 on failure.

**rindex**(*sub*[, *start*[, *end*]]) → [int](https://docs.python.org/3/library/functions.html#int){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.rindex}

Return the highest index in S where substring sub is found, such that sub is contained within S[start:end].  Optional arguments start and end are interpreted as in slice notation.

Raises ValueError when the substring is not found.

**rjust**(*width*, *fillchar=' '*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.rjust}

Return a right-justified string of length width.

Padding is done using the specified fill character (default is a space).

**rstrip**(*chars=None*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.rstrip}

Return a copy of the string with trailing whitespace removed.

If chars is given and not None, remove characters in chars instead.

**rpartition**(*sep*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.rpartition}

Partition the string into three parts using the given separator.

This will search for the separator in the string, starting at the end. If the separator is found, returns a 3-tuple containing the part before the separator, the separator itself, and the part after it.

If the separator is not found, returns a 3-tuple containing two empty strings and the original string.

**splitlines**(*keepends=False*){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.splitlines}

Return a list of the lines in the string, breaking at line boundaries.

Line breaks are not included in the resulting list unless keepends is given and true.

**strip**(*chars=None*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.strip}

Return a copy of the string with leading and trailing whitespace removed.

If chars is given and not None, remove characters in chars instead.

**swapcase**(){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.swapcase}

Convert uppercase characters to lowercase and lowercase characters to uppercase.

**translate**(*table*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.translate}

Replace each character in the string using the given translation table.

> tableTranslation table, which must be a mapping of Unicode ordinals to Unicode ordinals, strings, or None.

The table must implement lookup/indexing via \_\_getitem\_\_, for instance a dictionary or list.  If this operation raises LookupError, the character is left untouched.  Characters mapped to None are deleted.

**upper**(){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.upper}

Return a copy of the string converted to uppercase.

**startswith**(*prefix*[, *start*[, *end*]]) → [bool](https://docs.python.org/3/library/functions.html#bool){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.startswith}

Return True if S starts with the specified prefix, False otherwise. With optional start, test S beginning at that position. With optional end, stop comparing S at that position. prefix can also be a tuple of strings to try.

**endswith**(*suffix*[, *start*[, *end*]]) → [bool](https://docs.python.org/3/library/functions.html#bool){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.endswith}

Return True if S ends with the specified suffix, False otherwise. With optional start, test S beginning at that position. With optional end, stop comparing S at that position. suffix can also be a tuple of strings to try.

**removeprefix**(*prefix*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.removeprefix}

Return a str with the given prefix string removed if present.

If the string starts with the prefix string, return string[len(prefix):]. Otherwise, return a copy of the original string.

**removesuffix**(*suffix*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.removesuffix}

Return a str with the given suffix string removed if present.

If the string ends with the suffix string and that suffix is not empty, return string[:-len(suffix)]. Otherwise, return a copy of the original string.

**isascii**(){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.isascii}

Return True if all characters in the string are ASCII, False otherwise.

ASCII characters have code points in the range U+0000-U+007F. Empty string is ASCII too.

**islower**(){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.islower}

Return True if the string is a lowercase string, False otherwise.

A string is lowercase if all cased characters in the string are lowercase and there is at least one cased character in the string.

**isupper**(){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.isupper}

Return True if the string is an uppercase string, False otherwise.

A string is uppercase if all cased characters in the string are uppercase and there is at least one cased character in the string.

**istitle**(){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.istitle}

Return True if the string is a title-cased string, False otherwise.

In a title-cased string, upper- and title-case characters may only follow uncased characters and lowercase characters only cased ones.

**isspace**(){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.isspace}

Return True if the string is a whitespace string, False otherwise.

A string is whitespace if all characters in the string are whitespace and there is at least one character in the string.

**isdecimal**(){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.isdecimal}

Return True if the string is a decimal string, False otherwise.

A string is a decimal string if all characters in the string are decimal and there is at least one character in the string.

**isdigit**(){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.isdigit}

Return True if the string is a digit string, False otherwise.

A string is a digit string if all characters in the string are digits and there is at least one character in the string.

**isnumeric**(){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.isnumeric}

Return True if the string is a numeric string, False otherwise.

A string is numeric if all characters in the string are numeric and there is at least one character in the string.

**isalpha**(){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.isalpha}

Return True if the string is an alphabetic string, False otherwise.

A string is alphabetic if all characters in the string are alphabetic and there is at least one character in the string.

**isalnum**(){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.isalnum}

Return True if the string is an alpha-numeric string, False otherwise.

A string is alpha-numeric if all characters in the string are alpha-numeric and there is at least one character in the string.

**isidentifier**(){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.isidentifier}

Return True if the string is a valid Python identifier, False otherwise.

Call keyword.iskeyword(s) to test whether string s is a reserved identifier, such as “def” or “class”.

**isprintable**(){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.isprintable}

Return True if all characters in the string are printable, False otherwise.

A character is printable if repr() may use it in its output.

**zfill**(*width*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.zfill}

Pad a numeric string with zeros on the left, to fill a field of the given width.

The string is never truncated.

**format**(*\*args*, *\*\*kwargs*) → [str](https://docs.python.org/3/library/stdtypes.html#str){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.format}

Return a formatted version of S, using substitutions from args and kwargs. The substitutions are identified by braces (‘{’ and ‘}’).

**format\_map**(*mapping*) → [str](https://docs.python.org/3/library/stdtypes.html#str){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.format_map}

Return a formatted version of S, using substitutions from mapping. The substitutions are identified by braces (‘{’ and ‘}’).

*static* **maketrans**(){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.maketrans}

Return a translation table usable for str.translate().

If there is only one argument, it must be a dictionary mapping Unicode ordinals (integers) or characters to Unicode ordinals, strings or None. Character keys will be then converted to ordinals. If there are two arguments, they must be strings of equal length, and in the resulting dictionary, each character in x will be mapped to the character at the same position in y. If there is a third argument, it must be a string, whose characters will be mapped to None in the result.

**\_\_init\_\_**(*\*args*, *\*\*kwds*){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.__init__i}