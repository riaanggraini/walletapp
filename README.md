# Project Name

**Project Name** is a Ruby on Rails application designed to [brief description of what your project does]. This project [explain why this project exists or what problems it solves].

## Table of Contents

- [Features](#features)
- [Getting Started](#getting-started)
- [Installation](#installation)
- [Usage](#usage)
- [Authentication](#authentication)
- [API Documentation](#api-documentation)
- [API Endpoints](#api-endpoints)
- [Technologies Used](#technologies-used)
---

## Features

- Custom user authentication using tokens
- Transaction handling between entities (e.g., transfer, history)
- Real-time stock price fetching and syncing
- Wallet management, including balance fetching
- Health check endpoint for uptime monitoring
- [Add more features]

---

## Getting Started

Follow these instructions to get the project up and running on your local machine for development and testing purposes.

### Prerequisites

Make sure you have the following installed:

- **Ruby** version: `3.x.x`
- **Rails** version: `6.x.x` or `7.x.x`
- **Bundler**: `gem install bundler`
- **PostgreSQL** or other relational databases (depending on your setup)

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/your_username/project_name.git
   cd project_name

2. To install the necessary dependencies, run:

    ```bash
    bundle install
3. Set up the database, include seedings:

     ```bash
    rails db:create
    rails db:migrate
    rails db:seed
4. Start the Rails server:

    ```bash
    rails server
5. Visit http://localhost:3000 in your browser.

## Authentication
- Login: The app uses a custom authentication system. Users can log in by sending a POST request to the /login endpoint.
- Tokens are generated on successful login and should be included in subsequent requests in the Authorization header as:
    ```bash
    Authorization: <token>
## API Documentation
The API is documented using Swagger and can be browsed through the Swagger UI.
To view the documentation:

1. Start the Rails server.
2. Visit the following URL in your browser: http://localhost:3000/api-docs.
You can also access the Swagger specification directly via:

   ```bash
   http://localhost:3000/api-docs/v1/swagger.yaml
## API Endpoints
1. Sessions (Authentication)

   ```
   POST /login: Authenticates a user and generates an authentication token.
2. Transactions

   ```
   POST /transaction/create: Initiates a new transaction (e.g., fund transfer).
   GET /transactions/history: Retrieves a list of transaction history for the authenticated user.
   GET /transactions/history/:id: Retrieves detailed information about a specific transaction by ID.
2. Stock Prices
   ```
   GET /stock/price/all: Fetches the current prices of all stocks.
   GET /stock/price/:symbol: Fetches the price of a specific stock based on its symbol.
   GET /stock/prices/:symbols: Fetches prices for multiple stocks by their symbols (comma-separated).
   POST /stock/sync: Synchronizes stock prices with the external data source.
4. Wallet
   ```
   GET /wallet/balances: Retrieves the wallet balances of the authenticated user.
### Technologies Used
- Ruby on Rails: Web framework for building the application.
- PostgreSQL: Relational database management system.
- Swagger (Rswag): Used to generate and view API documentation.
