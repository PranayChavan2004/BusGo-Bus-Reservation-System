# 🚌 BusGo — Bus Reservation System

A complete **bus reservation management** built using **Spring Boot**, **Spring Security**, **JSP** and **MySQL**.  
The system allows operators to register buses, manage routes, schedule trips and enables passengers to search buses and reserve seats with real-time availability tracking.

---

# 🚀 Features

- 🔐 Secure authentication with Spring Security
- 🔑 Google OAuth2 login integration
- 🚌 Dynamic bus registration and seat layout generation
- 🗺️ Route and stop management
- 📅 Trip scheduling with overlap validation
- 🎟️ Real-time seat booking system
- 📊 Seat availability tracking
- ⏱️ Automated trip status scheduler
- ✅ Input validation using Bean Validation
- ⚠️ Global exception handling
- 🎨 Responsive user interface using Bootstrap 5

---

# 🧱 Tech Stack

## ⚙️ Backend

- Java 17
- Spring Boot 2.7.14
- Spring MVC
- Spring Security
- Spring Data JPA
- Hibernate ORM
- Spring Validation
- OAuth2 Client

## 🗄️ Database

- MySQL 8

## 🎨 Frontend

- JSP
- JSTL
- HTML5
- CSS3
- Bootstrap 5.3

## 🔐 Authentication & Security

- Form-Based Authentication
- BCrypt Password Encryption
- Google OAuth2 Authentication

## 🛠️ Build & Deployment

- Maven
- WAR Packaging
- Embedded Tomcat Server

---

# 📸 Screenshots

## Home Page

![Home Page](./screenshots/home.png)
![Home Page](./screenshots/home_page.png)

## Login Page

![Login Page](./screenshots/login.png)

## Book Ticket Page

![Signup Page](./screenshots/book_ticket.png)

## Register Bus 

![Search Bus](./screenshots/bus_register.png)

## Bus Details & Seat Layout

![Bus Details](./screenshots/bus_details.png)

## Trip Scheduling Page

![Trip Scheduling](./screenshots/schedule_trip.png)

---

# 📁 Project Structure

```text
BusApp/
│
├── .mvn/                               # Maven wrapper files
├── src/
│   ├── main/
│   │   ├── java/com/busreservation/
│   │   │   ├── config/                 # Security & exception configuration
│   │   │   ├── controller/             # MVC and REST controllers
│   │   │   ├── dto/                    # Request/response DTO classes
│   │   │   ├── model/                  # JPA entity classes
│   │   │   ├── repository/             # Spring Data JPA repositories
│   │   │   ├── scheduler/              # Automated schedulers
│   │   │   ├── service/                # Business logic layer
│   │   │   └── BusReservationApplication.java
│   │   │
│   │   ├── resources/
│   │   │   └── application.properties
│   │   │
│   │   └── webapp/
│   │       └── WEB-INF/views/          # JSP frontend pages
│   │
│   └── test/
│       └── java/com/busreservation/    # Unit and integration tests
│
├── screenshots/                        # Application screenshots
├── pom.xml                             # Maven dependencies
├── mvnw
├── mvnw.cmd
└── README.md
 ```

---
## Setup

### Prerequisites

- JDK 17
- Maven 3.6+
- MySQL 8 running locally

### 1. Database

```sql
CREATE DATABASE bus_reservation_db;
```

Default credentials in `application.properties` are `root` / `root`. Change username and password accroding to need.

### 2. Google OAuth (optional)

Get credentials from [Google Cloud Console](https://console.cloud.google.com/apis/credentials):

1. Create a new OAuth 2.0 Client ID (type: Web application)
2. Add `http://localhost:8080/login/oauth2/code/google` to authorized redirect URIs
3. Copy the client ID and secret

Set them as environment variables before running:

```bash
export GOOGLE_CLIENT_ID="your-client-id.apps.googleusercontent.com"
export GOOGLE_CLIENT_SECRET="your-client-secret"
```

If you skip this, email/password login still works fine — the Google button will just fail with an OAuth error.

### 3. Run

```bash
mvn clean spring-boot:run
```

Or build and run the WAR:

```bash
mvn clean package -DskipTests
java -jar target/bus-reservation-system-1.0.0.war
```

App runs at `http://localhost:8080`. You will be redirected to `/login` first.


## API Endpoints

| Method | Path | Purpose |
|--------|------|---------|
| POST | `/api/auth/signup` | Register new user |
| POST | `/api/bus/register` | Register a bus |
| GET  | `/api/bus/check-plate` | Check plate availability |
| GET  | `/api/bus/details` | Get bus info + trips |
| POST | `/api/bus/search` | Search available trips |
| POST | `/api/trip/schedule` | Schedule a trip |
| POST | `/api/seats/layout` | Get seat layout for a trip |
| POST | `/api/booking/confirm` | Confirm seat booking |

## Contributor

- **Pranay Chavan** 
