To prepare a template:

1. Make an audio recording of your pattern phrase.
1. Mark up the text of the pattern phrase according to the [requirements](../../speechkit/tts/templates.md#requirements-text) and enclose the variable parts in `{}` (curly brackets).

    > Marked-up text example: `This is to remind you that a waste collection truck will arrive at your place on {date} at {time}.`
    > List of variables: `variable_name = '{date}', variable_value = 'tomorrow'`, `variable_name = '{time}', variable_value = 'fourteen hours'`.

1. For each variable part, set its start time and duration in the audio recording (in milliseconds).
