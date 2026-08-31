# Equifax User Registration & Login POC

A Flutter-based mobile application demonstrating a 5-step registration wizard, user login authentication, local multi-user persistence, and a post-registration dashboard. Built strictly adhering to clean architecture principles, state management via Riverpod, and declarative routing with GoRouter.

---

## 📌 Deliverables

* **GitHub Repository:** [AbishekAB21/equifax_poc](https://github.com/AbishekAB21/equifax_poc)
* **Release APK:** [Download app-release.apk](./app-release.apk) (Located in root directory)

---

## 🛠️ Technical Stack & Architecture

* **Framework:** Flutter 3.44.4 (Stable Channel) / Dart 3.12.2
* **Target Platforms:** Android (minSdk 21, targetSdk 34) & iOS (12.0+)
* **Navigation:** `go_router` (Declarative routing)
* **State Management:** `flutter_riverpod` with `riverpod_annotation` & code generation
* **Data Access Layer:** Repository Pattern returning `fpdart` `Either<Failure, T>` types
* **Architecture:** Clean Architecture + MVVM Pattern (Presentation, Domain, Data layers)
* **Local Persistence:** `shared_preferences` with JSON Multi-User Storage

---

## ⚡ Key Features & Requirements

### 1. Authentication & Login
* Login via 6-digit numeric **Emp ID / Login ID** OR **Email Address**.
* Password masking with visibility toggle.
* Validation-gated "Sign In" button with error feedback via contextual `SnackBar` widgets.

### 2. 5-Step Registration Wizard
* **Step 1 (Personal Info):** Name (min 3 chars), Email, Gender selection switch, Date of Birth picker (18–100 years constraint with auto-calculated age badge), and 10-digit primary mobile number (+91 prefix).
* **Step 2 (Education & Work):** Highest Qualification, Institution/University searchable bottom-sheet, Passing Year picker dialog, Autocomplete Occupation field, and Experience range selection.
* **Step 3 (Address):** Street Address, Landmark, City, State, 6-digit Zip Code, and fixed Country (`India`).
* **Step 4 (Credentials):** Emp ID / Email format validation and Password setup with real-time 5-point criteria strength evaluation.
* **Step 5 (Review & Submit):** Structured summary cards with section edit navigation jumps prior to final persistence.

### 3. Post-Registration Dashboard
* **Home Tab:** Welcome banner, profile completeness score badge, statistics overview, and action controls.
* **Profile Tab:** Comprehensive profile view with editable fields (Name, Email, Address, Education) and locked read-only fields (Gender, DOB, Mobile, Login ID).

---

## 📏 Code Quality & Structural Constraints

* **Strict File Length Limit:** Every single Dart file under `lib/` strictly maintains $\le 150$ lines of code across all 61+ project files for modularity and maintainability.
* **Input Formatters:** Prevents consecutive spaces, denies spaces completely in Emails, Zip Codes, IDs, and Passwords. Sequential `Next` / `Done` keyboard focus traversal.
* **Zero Warnings / Errors:** Verified via `flutter analyze` clean output and unit test suite verification (`flutter test`).

---

## 📁 Directory Layout

```text
lib/
├── main.dart
├── core/
│   ├── errors/
│   ├── formatters/
│   └── theme/
├── domain/
│   ├── entities/
│   ├── failures/
│   └── repositories/
├── data/
│   ├── datasources/
│   ├── models/
│   └── repositories/
└── presentation/
    ├── controllers/
    ├── screens/
    └── widgets/