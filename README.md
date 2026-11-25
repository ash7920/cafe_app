# cafe_app

# Cafe App

A mobile cafe ordering app built with **Flutter** and **Dart**. Users sign up, browse a cafe menu, search and filter by category, view item details, add items to a cart, place orders and see their order history. I designed the screens in Figma and built the UI, state management, authentication and REST API integration as the sole developer (2024-25).

## Features
- **Authentication:** email and password sign-up and login with Firebase Authentication; user name and email stored in Cloud Firestore.
- **Menu:** all items fetched from a REST API, with search and category filters (All, Hot Beverages, Iced Beverages, Add-ins, Syrups, Food).
- **Item details:** description, ingredients and preparation steps for each item.
- **Cart:** add items, change quantities, remove items and place an order.
- **Order history:** a list of past orders with timestamps.
- **Profile:** shows the signed-in user's details, supports choosing a profile picture and sign-out.

## Tech stack
| Area | Tools |
|------|-------|
| Framework | Flutter, Dart |
| State management | Provider (`ChangeNotifier`) |
| Backend services | Firebase Authentication, Cloud Firestore |
| Networking | `http` package, REST APIs (JSON) |
| UI and design | Figma, Google Fonts, SVG assets |

## Project structure
```
lib/
  main.dart            App entry point, routes and auth wrapper
  auth.dart            Firebase sign-in, sign-up and sign-out
  pages/
    welcome_1.dart, login_1.dart, sign_up_1.dart, toggle.dart   Onboarding and auth screens
    homescreen.dart    Bottom navigation
    menu.dart          Menu, search and category filters
    fooddetails.dart   Item details
    cart.dart          Cart and checkout
    orderhistory.dart  Past orders
    profile.dart       User profile
    models/
      food.dart        Menu item model (JSON parsing)
      shop.dart        Menu, cart and order state; REST API calls
    components/        Reusable widgets
  theme/               Colours
assets/                Images and SVG graphics
```

## Getting started
1. Install [Flutter](https://docs.flutter.dev/get-started/install) (Dart SDK 3.4.4 or newer).
2. Clone the repo and install dependencies:
   ```
   git clone https://github.com/ash7920/cafe_app.git
   cd cafe_app
   flutter pub get
   ```
3. Run the app on an emulator or device:
   ```
   flutter run
   ```

## Note on live data
The menu data originally came from a hosted REST API. That API has since been discontinued, so the menu no longer loads live data and the app will show an empty menu. The API calls are all in `lib/pages/models/shop.dart`, so the data source can be swapped for a local JSON file or another API without changing the UI.


## What I learned
- Designing screens in Figma first, then turning them into Flutter widgets.
- Managing app state (menu, cart, orders) with Provider.
- Integrating REST APIs and parsing JSON, and what happens to an app when its backend goes away.
- Using Firebase Authentication and Cloud Firestore for user accounts.

## Author
Ashka Jain - [GitHub](https://github.com/ash7920) | [LinkedIn](https://linkedin.com/in/ashka-jain-715656331)
