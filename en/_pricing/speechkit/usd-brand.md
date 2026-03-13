| Service | Price per unit, without VAT |
| ----- | ----- |
| **{{ brand-voice-cc-name }}** | |
| Request | {{ sku|USD|speechkit.tts.v3_bvcc_request.v1|string }} |
| **{{ brand-voice-lite-name }}** | |
| One-time fee for creating one voice | {{ sku|USD|speechkit.tts_training.brand_voice_lite.v1|string }} |
| Hosting, first seven days ^1^ | {{ sku|USD|speechkit.tts_hosting.full_brand_voice.v1|string }} |
| Hosting, one voice, per month| {{ sku|USD|speechkit.tts_hosting.brand_voice_lite.v1|string }} |
| Hosting, second voice, per month| {{ sku|USD|speechkit.tts_hosting.brand_voice_lite.v1|pricingRate.1|string }} |
| Hosting, third voice, per month| {{ sku|USD|speechkit.tts_hosting.brand_voice_lite.v1|pricingRate.2|string }} |
| Hosting, fourth voice, per month| {{ sku|USD|speechkit.tts_hosting.brand_voice_lite.v1|pricingRate.3|string }} |
| Hosting, fifth voice, per month| {{ sku|USD|speechkit.tts_hosting.brand_voice_lite.v1|pricingRate.4|string }} |
| Hosting, sixth voice and more, per month| {{ sku|USD|speechkit.tts_hosting.brand_voice_lite.v1|pricingRate.5|string }} |
| Request | {{ sku|USD|speechkit.tts.v3_bvlite_request.v1|string }} |
| **{{ brand-voice-premium-name }}** | |
| Hosting, per month| Upon request |
| Request | {{ sku|USD|speechkit.tts.v3_bvprem_request.v1|string }} |

^1^ Hosting {{ brand-voice-lite }} is free of charge for the first seven days after creating the voice. This is to allow you to test it, assess its efficiency, and get the result approved. After this seven-day period ends, the prices above apply.