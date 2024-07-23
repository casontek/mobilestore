# mobilestore

e-commerce mobile application challenge

# Overview

## State Management with BLoC Pattern

In this app, I have implemented the BLoC (Business Logic Component) pattern for state management. 
BLoC is widely regarded as one of the best patterns for managing state in Flutter applications due to its separation of business logic from UI code, 
which promotes code reuse and testability. 
By using streams and reactive programming principles, BLoC helps in managing the state of the app efficiently and makes the app more scalable and maintainable.

## Authentication with SQLite

For authentication purposes, this app uses SQLite. Since this is a dummy test app and not intended for production use, SQLite is a suitable choice. 
SQLite is a lightweight and disk-based database, and it integrates well with Flutter, making it easy to store and retrieve user data locally. 
While it may not be the best choice for production apps due to its limitations in handling concurrent write operations and scaling, 
it serves well for testing and development purposes.

---

By integrating the BLoC pattern, SQLite, and ListView, 
this app demonstrates a robust structure for state management, 
local storage, and efficient UI rendering, making it a solid foundation for more complex Flutter applications.

