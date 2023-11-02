| Role | Permissions |
----- | -----
| `ai.vision.user` | The role enables you to use the service to analyze images. |
| `ai.auditor` | The role enables you to view quotas for {{ translate-name }}, {{ vision-name }}, {{ speechkit-name }}, and {{ yagpt-name }}, as well as folder metadata. |
| `ai.viewer` | The role enables you to view quotas for {{ translate-name }}, {{ vision-name }}, {{ speechkit-name }}, and {{ yagpt-name }}, as well as folder metadata. It includes all permissions of the `ai.auditor` role. |
| `ai.editor` | You can use {{ translate-name }}, {{ vision-name }}, {{ speechkit-name }}, and {{ yagpt-name }} if you have this role. It includes all permissions of the `ai.viewer`, `ai.speechkit-stt.user`, `ai.speechkit-tts.user`, `ai.vision.user`, `ai.translate.user`, and `ai.languageModels.user` roles. |
| `ai.admin` | You can use {{ translate-name }}, {{ vision-name }}, {{ speechkit-name }}, and {{ yagpt-name }} if you have this role. It includes all permissions of the `ai.editor` role. |