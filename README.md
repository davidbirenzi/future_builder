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

<img width="260" height="469" alt="fetch" src="https://github.com/user-attachments/assets/179b639b-97d7-408c-a6c2-55dd47bfc8b0" />

<img width="259" height="453" alt="news" src="https://github.com/user-attachments/assets/3200a374-323a-4d8e-acc3-22b418789c5e" />


