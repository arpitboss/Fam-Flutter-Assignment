# Contextual Cards Component

This repository contains a Flutter component for rendering **Contextual Cards** dynamically based on API responses. It is designed to be flexible, reusable, and easy to integrate into any Flutter project.

---

## 🌟 **Features**

- **Dynamic UI Rendering**: Cards are generated dynamically based on API data.
- **Deeplink Handling**: Supports deeplink actions for text, buttons, and cards.
- **Swipe to Refresh**: Pull-to-refresh functionality to fetch the latest updates.
- **Action Buttons**:
  - **Remind Later**: Temporarily hide a card (returns on app restart).
  - **Dismiss Now**: Permanently remove a card.
- **Error and Loading States**: Proper UI feedback for loading or errors.
- **Customizable UI**: Designed to accommodate additional card types in the API.

---

## 🔧 **Project Structure**

```plaintext
lib/
├── main.dart
├── views/
│   ├── presentation/
│   │   ├── clicks/        # Handles user click events
│   │   ├── screens/       # Screens for Contextual Cards
│   │   ├── widgets/       # Reusable card components
├── utils/
│   ├── constants/         # App constants and static values
│   ├── dependencies/      # Dependency injection setup
├── models/
│   ├── services/
│   │   ├── api_service.dart      # Handles API interactions
│   │   ├── storage_service.dart  # Handles local storage for cards
│   │   ├── url_service.dart      # Manages URL and deeplink interactions
│   ├── many model files          # Data models for Contextual Cards
├── controllers/
│   ├── card_controller.dart      # Business logic for card handling
```

---

## 📺 **Demo**

https://github.com/user-attachments/assets/6b2b364e-b897-432b-954b-e57563a3692a

- The demo showcases:
  - **Dynamic rendering** of cards based on API responses.
  - **Swipe actions** for "Remind Later" and "Dismiss Now."
  - **Error and loading states.**

---

## 🕊 **API Used**

The app consumes data from the following endpoint:

[API Link](https://polyjuice.kong.fampay.co/mock/famapp/feed/home_section/?slugs=famx-paypage)

The API provides structured JSON data with properties for card rendering.

---

## ✍️ **Setup Instructions**

1. Clone the repository:
   ```bash
   git clone https://github.com/arpitboss/Fam-Flutter-Assignment.git
   ```

2. Navigate to the project directory:
   ```bash
   cd fam_flutter_assignment
   ```

3. Install dependencies:
   ```bash
   flutter pub get
   ```

4. Run the app:
   ```bash
   flutter run
   ```

---

## ⚡ **Key Functionalities**

### 1. **Dynamic Rendering**
- Cards are generated dynamically from the API data, supporting multiple card types such as HC1, HC3, HC5, HC6, and HC9.

### 2. **Action Handling**
- "Remind Later" stores the card state locally and reloads it on app restart.
- "Dismiss Now" ensures the card is permanently removed.

### 3. **Swipe to Refresh**
- Pull-down gesture triggers an API refresh.

### 4. **Error States**
- Displays a fallback UI in case of network issues or invalid data.

---

## 🛠️ **Tech Stack**

- **Flutter**: For building the user interface.
- **Dart**: The programming language used.
- **GetX**: For state management, providing reactive programming.
- **Get It**: For dependency injection, ensuring clean and maintainable code.
- **HTTP**: For making API requests.
- **Shared Preferences**: For local storage of card states.

---

## 🧠 **My Learnings**

- **State Management with GetX**: I gained a deeper understanding of how to manage state in Flutter using GetX, which made handling the dynamic nature of the cards more efficient.
- **Dependency Injection with Get It**: Implementing dependency injection with Get It helped me keep the code modular and easier to test.
- **API Integration**: Working with HTTP requests and handling different API responses improved my ability to handle real-world data fetching scenarios.
- **Local Storage with Shared Preferences**: Learning how to persist data locally was crucial for implementing the "Remind Later" feature.
- **UI Responsiveness**: Ensuring that the UI adapts to different card types and handles various states (loading, error, success) was a great exercise in building robust UI components.

---

## 🛠️ **Contributing**

We welcome contributions! Please follow these steps:

1. Fork the repository.
2. Create a new branch:
   ```bash
   git checkout -b feature-name
   ```
3. Commit your changes:
   ```bash
   git commit -m "Add feature-name"
   ```
4. Push to the branch:
   ```bash
   git push origin feature-name
   ```
5. Open a pull request.

---

## ❤️ **Acknowledgments**

- Special thanks to [Fampay](https://www.famapp.in/) for providing the assignment and resources.
- API Documentation and UI guidelines referenced from the Assignment Details.

---

Happy Coding! 🚀
