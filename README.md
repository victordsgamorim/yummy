# Yummy - Delivery App

## Configuration

### Initial Setup

The application uses the http package to fetch data from the internet. To simulate this request and response, it's necessary to use json-server for simulation.

#### Steps:

1. Install json-server:
    ```bash
    npm install json-server
    ```

2. Run json-server pointing to the food fixture file:
    ```bash
    json-server --watch assets/fixture/food_fixture.json
    ```

3. Change the variable in the file `../yummy_app/lib/core/utils/constants/api.dart` from localhost to your internet IP:
   From: `http://localhost:3000/foods`
   To: `'http://11.111.111.111:3000/foods'`

#### Finding Your IP:

- **On macOS:**
    - Run the command `ifconfig` in the terminal and locate the `en0` section.
    - The IP will come right after `inet`, for example, `11.111.111.111`.

- **On Windows:**
    - Run the command `ipconfig` in the command prompt and copy the IP.

### Note:

If you encounter any errors during this process, don't worry because I've implemented a try-catch to directly fetch the JSON file from the assets.

## About the Project

In this project, I utilized an MVC architecture with the following directories:

- **core:** Contains necessary configurations for the entire application, such as routes, dependency injection, theme, etc.
- **feature:**
    - **model:** Contains models.
    - **bloc:** Bloc controllers.
    - **pages:** Includes pages.
- **data:** Contains repository and remote data source files.

This structure helps in organizing the project and separating concerns effectively.

## Flow

The flow of the application is as follows:

- **HomePage:** The starting page where users can navigate to either CartPage or FoodPage.
- **FoodPage:** Users can add items to the cart and navigate to CartPage.
- **CartPage:** Users can view their cart, proceed to checkout, and update their order.

