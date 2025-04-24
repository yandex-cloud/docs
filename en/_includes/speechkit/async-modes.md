[Asynchronous recognition](../../{{ speechkit-slug }}/stt/transcribation.md) is available in two modes:
1. In standard mode, recognition is processed in a standard priority queue. This mode works when the `general` model is selected.
1. In deferred mode, the audio file for recognition is placed in a low priority queue and processed at the least busy time. [Special pricing](../../{{ speechkit-slug }}/pricing.md#prices-stt) applies to deferred recognition. For recognition in deferred mode, specify the `deferred-general` model.

Asynchronous recognition of audio files takes no more than 24 hours, depending on the current system workload.