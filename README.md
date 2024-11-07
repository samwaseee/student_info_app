
# Student Information Management App

A Flutter application for managing student information, featuring functionalities to add, view, update, and delete student records. The app is developed using GetX for state management and incorporates input validation, database interaction using SQLite, and user feedback through snackbars.

## Features

- **Add New Student**: Users can add a new student with details such as name, ID, phone number, email, and location.
- **View All Students**: The app displays a list of all student records stored in the database.
- **Update Student Information**: Users can update an existing student’s details.
- **Delete Student**: Allows users to remove a student record after a confirmation prompt.
- **Input Validations**: Ensures that required fields are filled correctly when adding or updating a student.
- **Error Handling and Feedback**: Informative snackbars provide feedback for success, failure, and duplicate entries.

## Project Structure

The project is organized into the following structure:

```
lib/
├── controllers/
│   └── student_controller.dart
├── models/
│   └── student.dart
├── pages/
│   ├── add_student_page.dart
│   ├── all_students_page.dart
│   └── home_page.dart
├── services/
│   └── database_helper.dart
└── main.dart
```

- **controllers/student_controller.dart**: Manages the app’s state, fetching data, and database operations through methods like `addStudent`, `deleteStudent`, and `fetchStudents`.
- **models/student.dart**: Defines the Student model, representing each student as an object with properties like `name`, `studentId`, `phone`, `email`, and `location`.
- **pages**: Contains the UI pages for adding, viewing, and displaying all student records.
- **services/database_helper.dart**: Contains SQLite operations to initialize, insert, update, delete, and retrieve student data.
- **main.dart**: The entry point of the application, setting up GetX for navigation.

## Database Design

The SQLite database is structured as follows:

- **Database Name**: `students.db`
- **Table Name**: `students`
- **Columns**:
    - `id` (Primary Key, Auto-increment)
    - `name` (Text, Not Null)
    - `studentId` (Text, Unique, Not Null)
    - `phone` (Text, Not Null)
    - `email` (Text, Not Null)
    - `location` (Text, Not Null)

The app verifies if a student with a particular `studentId` already exists before insertion, ensuring no duplicate entries.

## Input Validations

To ensure data integrity, the following validations are applied:

- **Required Fields**: All fields must be completed before submission.
- **Unique Student ID**: When adding a new student, the app checks if a student with the provided `studentId` already exists in the database, prompting an error if found.
- **Data Constraints**: Phone number and email fields are validated to match common formats, though specific regex patterns can be added for further strictness.

## Snackbar Notifications

Snackbars provide feedback across the app for actions like adding, updating, or deleting a student. Specific error and success messages appear based on outcomes:
- **Success**: Displays upon successful addition or deletion.
- **Error**: Shows if an action fails.
- **Duplicate Entry**: If a duplicate student ID is detected, an error snackbar appears.

## Code Walkthrough

### Adding a New Student
The `add_student_page.dart` contains the input form, which calls `addStudent` from `StudentController` upon submission. The following logic provides feedback:

### Updating Student Information
The `updateStudent` method in `StudentController` allows editing an existing student’s data. Similar validation checks and snackbar notifications ensure a smooth user experience.

### Deleting a Student
The app prompts a confirmation dialog before allowing the user to delete a student, ensuring no accidental deletions.

## Getting Started

### Prerequisites
- Flutter SDK
- Android Studio or Visual Studio Code (with Flutter extension)

### Installation
1. Clone this repository:
   ```bash
   git clone https://github.com/samwaseee/student_info_app.git
   ```
2. Navigate to the project directory:
   ```bash
   cd student_info_app
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Run the app:
   ```bash
   flutter run
   ```

## Future Improvements

- **Enhanced Input Validation**: Further improve email and phone validation with regex patterns.
- **Search and Sort Functionality**: Allow searching students by name or ID and sorting options for better user experience.
- **Advanced Data Management**: Add export/import data functionality and support cloud storage.

