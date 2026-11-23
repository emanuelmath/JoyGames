<div align="center">

# 🎮 JoyGames
### Video Game Catalog and Management Platform in .NET 10

[![C#](https://img.shields.io/badge/C%23_14-239120?style=for-the-badge&logo=c-sharp&logoColor=white)](https://learn.microsoft.com/en-us/dotnet/csharp/)
[![.NET](https://img.shields.io/badge/.NET_10-512BD4?style=for-the-badge&logo=dotnet&logoColor=white)](https://dotnet.microsoft.com/en-us/download/dotnet/10.0)
[![SQL Server](https://img.shields.io/badge/SQL_Server-CC292B?style=for-the-badge&logo=microsoftsqlserver&logoColor=white)](https://www.microsoft.com/sql-server)
[![Bootstrap](https://img.shields.io/badge/Bootstrap_5-7952B3?style=for-the-badge&logo=bootstrap&logoColor=white)](https://getbootstrap.com/)
[![CI](https://github.com/emanuelmath/JoyGames/actions/workflows/ci.yml/badge.svg)](https://github.com/emanuelmath/JoyGames/actions/workflows/ci.yml)
![Status](https://img.shields.io/badge/Status-In_Progress-success?style=for-the-badge)

</div>

---

## 📋 About This Project

**JoyGames** is a web platform built with **ASP.NET Core MVC** to explore, organize, and manage a video game catalog. Users can browse titles by category or developer company, check sales statistics, watch official trailers, and send contact or account registration requests.

### 💡 Project Background
This project started as a university assignment to learn backend fundamentals with **SQL Server**, **Stored Procedures**, and **ADO.NET**. Instead of leaving it as a basic class exercise, I refactored the entire solution into **Clean Architecture** and **SOLID principles**, separating business logic, data access, and presentation while keeping the performance of stored procedures.

---

## ✨ Main Features

### 🎮 Game Catalog & Media
- **Detailed Game Profiles:** Displays cover images, descriptions, release dates, developer studios, categories, and total copies sold.
- **Trailer Integration:** Embedded YouTube trailer player inside game detail views.
- **Dynamic Filtering:** Browse and filter games by developer company and category.
- **Flexible Image Storage:** Supports local disk storage for development and **Cloudinary** cloud storage for production.

### 🔐 Security & Access Control
- **BCrypt Password Hashing:** Secure password encryption through a dedicated hashing service.
- **Cookie & Claims Authentication:** Role-based access control using custom claims extensions, avoiding extra database queries on every request.
- **Clean Configuration:** Sensitive credentials are excluded from the repository using `appsettings.Example.json` and .NET User Secrets.

### 🏢 Catalog, Companies & Requests
- **Company & Category Management:** Organize partner developer studios and game genres.
- **Contact & Account Requests:** Structured workflows to receive user inquiries and manage new account applications, including automated SMTP email notifications.

### ⚙️ Code Quality & Automation
- **Unit Testing:** Automated tests with **xUnit** covering services and repositories.
- **Continuous Integration:** Automated build and test pipeline using **GitHub Actions** on every push.

---

## 📂 Solution Structure

The solution is split into independent projects (`.csproj`) following **Clean Architecture**:

```text
📦 JoyGames
├── 📁 .github/
│   └── 📁 workflows/
│       └── ci.yml                   # GitHub Actions CI pipeline (build & test)
│
├── 📁 database/                     # SQL scripts (Tables, Views, Stored Procedures, Seeds)
│   ├── 01_schema.sql
│   ├── 02_stored_procedures.sql
│   └── 03_seed_data.sql
│
├── 📁 src/
│   ├── 🧠 JoyGames.Core/            # Domain layer (Pure C#, no external dependencies)
│   │   ├── Common/                  # Shared helpers (OperationResult)
│   │   ├── Entities/                # Juego, Usuario, Categoria, Companhia, Solicitud, Contacto
│   │   └── Interfaces/              # Repository and Service contracts
│   │
│   ├── ⚙️ JoyGames.Infrastructure/  # Data access & external services
│   │   ├── Data/                    # DbConnectionFactory & Repositories (ADO.NET / Dapper)
│   │   ├── Options/                 # Strongly-typed settings (SmtpOptions, StorageOptions)
│   │   └── Services/                # SMTP email, BCrypt hasher, Local & Cloudinary storage
│   │
│   └── 🌐 JoyGames.Web/             # Presentation layer (ASP.NET Core MVC)
│       ├── Controllers/             # Home, Juego, Usuario, Solicitud controllers
│       ├── Extensions/              # TempData and ClaimsPrincipal helpers
│       ├── ViewModels/              # Typed models for views and forms
│       ├── Views/                   # Razor Views with Bootstrap 5 (Dark Theme)
│       ├── wwwroot/                 # Static assets (CSS, JS, base images)
│       └── appsettings.Example.json # Configuration template
│
└── 🧪 tests/
    └── JoyGames.Tests/              # Unit tests for services and repositories (xUnit)
```

---

## 🛠️ Technologies Used

- **Language:** C# 14 (.NET 10)
- **Architecture:** Clean Architecture + SOLID
- **Web Framework:** ASP.NET Core MVC (Razor Views, TagHelpers)
- **Database:** SQL Server (Stored Procedures + ADO.NET / Dapper)
- **Security:** BCrypt Password Hashing, Cookie Authentication with Claims
- **External Services:** SMTP Email, Cloudinary (optional cloud storage)
- **Frontend:** Bootstrap 5 (Dark Theme), DataTables, Toastr, FontAwesome 6, jQuery
- **Testing & CI/CD:** xUnit, GitHub Actions

---

## 🚀 How to Run

### Prerequisites
- [.NET 10 SDK](https://dotnet.microsoft.com/download/dotnet/10.0)
- [SQL Server](https://www.microsoft.com/sql-server) (LocalDB, Express, or Docker)
- [Visual Studio 2022 / 2026](https://visualstudio.microsoft.com/) or VS Code with C# Dev Kit

### Setup Steps

1. **Clone this repository:**
   ```bash
   git clone [https://github.com/emanuelmath/JoyGames.git](https://github.com/emanuelmath/JoyGames.git)
   cd JoyGames
   ```

2. **Set up the database:**
   - Open SQL Server Management Studio (SSMS) or Azure Data Studio.
   - Run the scripts inside `/database` in order:
     1. `01_schema.sql`
     2. `02_stored_procedures.sql`
     3. `03_seed_data.sql`

3. **Configure application settings:**
   - Copy `src/JoyGames.Web/appsettings.Example.json` to `appsettings.json` (or use .NET User Secrets) and set your connection string, SMTP, and storage options:
   ```bash
   cd src/JoyGames.Web
   dotnet user-secrets set "ConnectionStrings:DefaultConnection" "Server=localhost;Database=JoyGamesDb;Trusted_Connection=True;TrustServerCertificate=True;"
   ```

4. **Build and run the application:**
   ```bash
   dotnet build
   dotnet run --project src/JoyGames.Web/JoyGames.Web.csproj
   ```

5. Open your browser at the local URL shown in the terminal (e.g., `https://localhost:5001`).

---

Any feedback or suggestions are more than welcome! 🫂🎮