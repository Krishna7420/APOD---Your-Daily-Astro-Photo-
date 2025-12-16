# 🚀 NASA APOD iOS App (UIKit + MVVM)

An iOS application built using **UIKit and Swift** that fetches and displays NASA’s **Astronomy Picture of the Day (APOD)** using NASA’s public API.  
The project follows a **clean MVVM architecture**, focusing on separation of concerns, scalability, and production-ready iOS development practices.

---

## 📱 Features
- Fetch and display **Astronomy Picture of the Day**
- Show **title, image/video, description, date, and copyright**
- **Date selection** using month picker and calendar view
- **Loading state** handling during API calls
- **Favourite functionality** to save APODs locally
- **Bottom tab navigation** (Home & Favourite)
- Space-themed **dark UI**
- Graceful handling of **invalid dates and API errors**

---

## 🧠 Architecture – MVVM

### 🔹 Model
- Represents API responses using `Codable`
- Handles data decoding and error mapping
- Independent of UI and networking logic

### 🔹 ViewModel
- Contains business logic and API interaction
- Communicates with `APIService` to fetch APOD data
- Validates dates and manages loading/error states
- Exposes data to the View using closures

### 🔹 View (UIKit)
- `UIViewController` responsible only for UI rendering
- Observes ViewModel outputs and updates UI
- No networking or business logic inside Views

---

## 🌐 Networking
- Implemented using `URLSession`
- Centralized `APIService` layer
- Custom `NetworkError` handling
- Supports both **image** and **video** media types

---

## 🛠 Tech Stack
- Swift
- UIKit
- MVVM Architecture
- URLSession
- Codable
- Auto Layout
- Dark Mode

---

## 📷 UI Highlights
- Loader during API calls
- Calendar-based date selection
- Dynamic APOD image rendering
- Favourite toggle with visual feedback
- Smooth navigation between Home & Favourite screens

---

## 🎯 Why MVVM?
- Clear separation of concerns
- Easier testing and debugging
- Scalable and maintainable architecture
- Industry-standard iOS development pattern

---

## 📌 Future Improvements
- Image caching
- Share APOD functionality
- Full-screen image viewer with pinch-to-zoom
- Unit tests for ViewModels

---

## 🔗 API Reference
NASA APOD API  
https://api.nasa.gov/planetary/apod

---

## 👨‍💻 Author
**Shrikrishna Thodsare**  
iOS Developer | Swift | UIKit | MVVM
