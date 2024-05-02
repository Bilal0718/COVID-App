COVID-19 Tracker App

Overview
COVID-19 Tracker is a mobile application built to track the global and country-wise statistics of COVID-19 cases. It provides real-time data sourced from the disease.sh API, allowing users to stay informed about the pandemic situation.

Features
Global Statistics: Displays global COVID-19 statistics including confirmed cases, deaths, and recoveries.
Country-wise Statistics: Allows users to select a country from a dropdown menu and view its specific COVID-19 statistics.
Real-time Data: Fetches data from the disease.sh API to ensure up-to-date information.
Technologies Used
Flutter: Cross-platform framework for building mobile applications.
Dart: Programming language used with Flutter for app development.
HTTP Package: Used for making HTTP requests to fetch data from the API.
Installation
To run this app locally, follow these steps:

Clone the repository:
bash
Copy code
git clone https://github.com/Bilal0718/COVID-App
Navigate to the project directory:
bash
Copy code
cd covid_app
Install dependencies:
bash
Copy code
flutter pub get
Run the app:
bash
Copy code
flutter run
API Usage
This app utilizes the disease.sh API to fetch COVID-19 data. The API endpoints used include:

/v3/covid-19/all: Retrieves global COVID-19 statistics.
/v3/covid-19/countries: Retrieves a list of countries and their COVID-19 statistics.
/v3/covid-19/countries/{country}: Retrieves COVID-19 statistics for a specific country.
For more details about the API, refer to the documentation.

Screenshots

Global COVID-19 Statistics


Country-wise COVID-19 Statistics

Contributing
Contributions are welcome! If you find any issues or have suggestions for improvement, please open an issue or submit a pull request.

