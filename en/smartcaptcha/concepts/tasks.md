# Task types

[User validation](./validation.md) consists of two steps. The first step includes a basic check where the user is asked to complete the [main task](#main-task). After completing the main task, the user's request is automatically sent to {{ captcha-name }}. If the service considers the request suspicious, it will offer the user to solve an [additional task](#additional-task).

## Main task {#main-task}

The basic check is carried out when the main task is performed.

You can choose between these two types of main tasks in {{ captcha-name }}:

* **Checkbox**: User must click the **I am not a robot** button.

  {% cut "Checkbox" %}

  ![image](../../_assets/smartcaptcha/checkbox-task.gif)

  {% endcut %}

* **Slider**: User must move the slider from left to right.

  {% note info %}

  The slider is in the [Preview](../../overview/concepts/launch-stages.md) stage, so it may not work correctly on some types of devices. For example, on TV sets.

  {% endnote %}

  {% cut "Slider" %}

  ![image](../../_assets/smartcaptcha/slider-task.gif =370x93)

  {% endcut %}

## Additional task {#additional-task}

If the service considers the result of the main task suspicious, it offers to the user an additional task. In this case, the service analyzes user behavior in more detail.

There are several types of additional tasks in {{ captcha-name }}:

* ![image](../../_assets/console-icons/text.svg) **Text recognition**: The user has to type a distorted text from the picture into a special field.

  {% cut "Text recognition" %}

  ![image](../../_assets/smartcaptcha/text-task.gif =370x401)

  {% endcut %}

* ![image](../../_assets/console-icons/picture.svg) **Silhouettes**: The user has to mark several icons from the picture in a particular order.

  {% note info %}

  The silhouettes are in the [Preview](../../overview/concepts/launch-stages.md) stage, so they may not work correctly on some types of devices. For example, on TV sets.

  {% endnote %}

  {% cut "Silhouettes" %}

  ![image](../../_assets/smartcaptcha/silhouette-task.gif)

  {% endcut %}

* ![image](../../_assets/console-icons/layout-cells-large.svg) **Kaleidoscope**: The user has to build a picture from individual parts by shuffling them using a slider. To complete the task, the user has to move the slider to a position in which the image parts are arranged correctly.

  {% note info %}

  The Kaleidoscope is in the [Preview](../../overview/concepts/launch-stages.md) stage, so it may not work correctly on some types of devices. For example, on TV sets.

  {% endnote %}

  {% cut "Kaleidoscope" %}

  ![image](../../_assets/smartcaptcha/kaleidoscope-task.gif =370x415)

  {% endcut %}
