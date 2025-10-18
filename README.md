FutureBuilder Widget!

The FutureBuilder widget is like a helper that waits for a task to finish and then shows the result.

How to Run the Project
Clone the repo:
git clone https://github.com/davidbirenzi/future_builder.git

Navigate to the project directory:
cd future_builder

Get dependencies:
flutter pub get

Run the app:
flutter run


Attributes Explained

FutureBuilder: future
Defines the asynchronous operation (in this case, an API call) that provides the data for the widget to build its UI.

FutureBuilder: builder
Determines how the UI responds to the different states of the Future (loading, success, or error).

ListView: scrollDirection
Controls the scrolling axis (vertical or horizontal). In this demo, the news list scrolls vertically.

Screenshot of UI
