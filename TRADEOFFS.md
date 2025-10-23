### **Overview**

This document explains the trade-offs and design decisions made while building the **Biometric Dashboard** for the Unfold AI assessment.
Each choice balanced **functionality, performance, maintainability, and delivery time**.

---

## **1. Feature Scope**

### ✅ Implemented

* Synchronized HRV, RHR, and Steps charts
* Rolling mean and ±1σ bands for HRV
* Range switching (7d, 30d, 90d)
* Data decimation (LTTB algorithm)
* Journal annotations
* Loading, error, and empty states
* Large dataset simulation for performance testing
* Responsive layout (mobile + web)
* Firebase Hosting deployment

### ⚠️ Deferred / Cut

| Feature                                  | Reason                                                                                                                  |
| ---------------------------------------- | ----------------------------------------------------------------------------------------------------------------------- |
| Chart **pan/zoom** interaction           | Added complexity with limited UX value for static biometric visualization; hover/crosshair provided sufficient insight. |
| Real backend API integration             | Mock data used to isolate visualization logic and performance behavior under controlled conditions.                     |
| Authentication / user profiles           | Not required for the assignment scope; would add unnecessary setup time.                                                |
| Unit tests for every widget              | Focused testing effort on key logic (decimation, rolling stats, bloc behavior) due to time constraints.                 |
| Animated transitions between time ranges | Chose instant updates for better clarity and performance control.                                                       |

---

## **2. Architecture Choices**

### ✅ Chosen: **Clean Architecture + Bloc**

* Provides predictable state transitions and testability.
* Easier to reason about data flow across multiple charts.

### ❌ Considered: **Riverpod / Cubit**

* Riverpod would reduce boilerplate but require re-architecting blocs; not worth it within limited time.
* Cubit was avoided to maintain separation between UI and logic for more complex event handling.

---

## **3. Performance Decisions**

| Decision                          | Rationale                                                                          |
| --------------------------------- | ---------------------------------------------------------------------------------- |
| **Used LTTB data decimation**     | Needed to maintain <16 ms frame rendering with 10k+ points.                        |
| **No async chart rendering**      | Avoided unnecessary complexity; dataset size manageable with current optimization. |
| **Shimmer loading vs. skeletons** | Shimmer conveys loading states clearly without external dependencies.              |

---

## **4. UI/UX Trade-offs**

| Decision                               | Rationale                                                                                    |
| -------------------------------------- | -------------------------------------------------------------------------------------------- |
| **One crosshair active (Steps chart)** | Simplified interaction logic—crosshair demonstrates feature without complicating chart sync. |
| **Minimal animations**                 | Ensures smooth performance across all platforms including web.                               |
| **Fixed light/dark themes**            | Full theming possible, but static palette aligned with assessment goals.                     |

---

## **5. Deployment Choices**

| Decision                          | Rationale                                                         |
| --------------------------------- | ----------------------------------------------------------------- |
| **Firebase Hosting for web demo** | Simple, free, and integrates easily with Flutter build artifacts. |
| **No CI/CD pipeline**             | Not required for assessment scope; manual deploy sufficient.      |

---

## **6. Testing Trade-offs**

| Decision                            | Rationale                                                                             |
| ----------------------------------- | ------------------------------------------------------------------------------------- |
| Focused on core logic tests         | Ensures correctness in decimation and bloc states.                                    |
| Skipped integration test automation | UI interactions were verified manually due to time focus on performance optimization. |

---

## **7. Time vs. Completeness**

Given limited time, emphasis was placed on:

* Smooth **performance** under heavy data.
* Solid **architecture** for extensibility.
* Polished **visualization UX** over peripheral features.

---

## **Summary**

This solution optimizes for **clarity, performance, and maintainability** under realistic assessment constraints.
All trade-offs were intentional to ensure a **high-quality, stable, and performant demo**.

---