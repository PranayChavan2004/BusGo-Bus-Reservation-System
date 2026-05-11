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
