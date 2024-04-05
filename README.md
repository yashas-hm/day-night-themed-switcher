# Day and Night Themed Switcher

![Demo](./assets/demo.gif)

🎩✨ Behold, the marvel of simplicity meets elegance: the `day_night_themed_switcher` crafted purely in Dart! 🌗 With this widget, you can seamlessly toggle between the luminous radiance of daytime and the captivating allure of nighttime, right at your fingertips.

This nifty little creation not only adds functionality but also sprinkles a touch of charm to your app interface. Let your users revel in the joy of effortlessly transitioning between light and dark modes with just a tap.

So, why settle for mundane when you can dazzle your users with the magic of day and night? Add this widget to your arsenal and watch as your app shines bright like a diamond, day or night! ✨🌞🌙

### **Show some ❤️ and ⭐️ the Repo**

Resources:
- [GitHub Repo](https://github.com/yashas-hm/day-night-themed-switcher)
- [Example](https://github.com/yashas-hm/day-night-themed-switcher/tree/main/example)
- [Pub Package](https://pub.dev/packages/day_night_themed_switcher)

## How to Use?

Utilizing this Plugin is as smooth as a gentle breeze. Tailor your experience effortlessly with customizable parameters such as duration, initiallyDark, and size, allowing you to craft the perfect appearance and behavior to suit your needs. 🛠️💫  

```dart
DayNightSwitch(
  // duration: Duration(milliseconds: 800),
  // initiallyDark: true,
  size: 20,
  onChange: (dark) => setState(() {
    if (dark) {
      theme = ThemeMode.dark;
    } else {
      theme = ThemeMode.light;
    }
  }),
),
```

## Contributions
- [Fork it](https://github.com/yashas-hm/day-night-themed-switcher/fork) on GitHub
- [Submit](https://github.com/yashas-hm/day-night-themed-switcher/issues/new/choose) feedback or bug report


