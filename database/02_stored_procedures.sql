
-- ============================================================================
-- JoyGames - 02_stored_procedures.sql
-- Creates views and stored procedures for database operations.
-- Returns Code and Message for OperationResult.
-- ============================================================================

USE JoyGamesDb;
GO

-- ============================================================================
-- VIEWS
-- ============================================================================

CREATE OR ALTER VIEW dbo.vw_GamesDetail
AS
SELECT
    g.Id,
    g.Title,
    g.Description,
    g.CategoryId,
    c.Name AS CategoryName,
    g.CompanyId,
    co.Name AS CompanyName,
    g.ReleaseDate,
    g.SoldCopies,
    g.ImageUrl,
    g.TrailerUrl,
    g.CreatedAt
FROM dbo.Games g
INNER JOIN dbo.Categories c
    ON g.CategoryId = c.Id
INNER JOIN dbo.Companies co
    ON g.CompanyId = co.Id;
GO

CREATE OR ALTER VIEW dbo.vw_UsersDetail
AS
SELECT
    u.Id,
    u.Name,
    u.Email,
    u.UserName,
    u.UserRole,
    r.Name AS RoleName,
    u.UserState,
    s.Name AS StateName,
    u.CreatedAt
FROM dbo.Users u
INNER JOIN dbo.Roles r
    ON u.UserRole = r.Id
INNER JOIN dbo.States s
    ON u.UserState = s.Id;
GO

-- ============================================================================
-- GAME PROCEDURES
-- ============================================================================

CREATE OR ALTER PROCEDURE dbo.sp_InsertGame
    @Id          UNIQUEIDENTIFIER,
    @Title       NVARCHAR(150),
    @Description NVARCHAR(MAX),
    @CategoryId  INT,
    @CompanyId   INT,
    @ReleaseDate DATETIME2,
    @SoldCopies  BIGINT,
    @ImageUrl    NVARCHAR(500) = NULL,
    @TrailerUrl  NVARCHAR(500) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        IF EXISTS (
            SELECT 1
            FROM dbo.Games
            WHERE Title = @Title
              AND CompanyId = @CompanyId
        )
        BEGIN
            SELECT 0 AS Code,
                   N'Ya existe un juego con ese título para la misma compañía.' AS Message;
            RETURN;
        END

        INSERT INTO dbo.Games (
            Id,
            Title,
            Description,
            CategoryId,
            CompanyId,
            ReleaseDate,
            SoldCopies,
            ImageUrl,
            TrailerUrl
        )
        VALUES (
            @Id,
            @Title,
            @Description,
            @CategoryId,
            @CompanyId,
            @ReleaseDate,
            @SoldCopies,
            @ImageUrl,
            @TrailerUrl
        );

        SELECT 1 AS Code,
               N'El juego se registró correctamente.' AS Message;
    END TRY
    BEGIN CATCH
        SELECT 0 AS Code,
               N'No fue posible completar la operación. Inténtalo nuevamente.' AS Message;
    END CATCH
END
GO

CREATE OR ALTER PROCEDURE dbo.sp_UpdateGame
    @Id          UNIQUEIDENTIFIER,
    @Title       NVARCHAR(150),
    @Description NVARCHAR(MAX),
    @CategoryId  INT,
    @CompanyId   INT,
    @ReleaseDate DATETIME2,
    @SoldCopies  BIGINT,
    @ImageUrl    NVARCHAR(500) = NULL,
    @TrailerUrl  NVARCHAR(500) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        IF NOT EXISTS (
            SELECT 1
            FROM dbo.Games
            WHERE Id = @Id
        )
        BEGIN
            SELECT 0 AS Code,
                   N'No se encontró el juego solicitado.' AS Message;
            RETURN;
        END

        IF EXISTS (
            SELECT 1
            FROM dbo.Games
            WHERE Title = @Title
              AND CompanyId = @CompanyId
              AND Id <> @Id
        )
        BEGIN
            SELECT 0 AS Code,
                   N'Ya existe otro juego con ese título para la misma compañía.' AS Message;
            RETURN;
        END

        UPDATE dbo.Games
        SET
            Title       = @Title,
            Description = @Description,
            CategoryId  = @CategoryId,
            CompanyId   = @CompanyId,
            ReleaseDate = @ReleaseDate,
            SoldCopies  = @SoldCopies,
            ImageUrl    = COALESCE(@ImageUrl, ImageUrl),
            TrailerUrl  = COALESCE(@TrailerUrl, TrailerUrl)
        WHERE Id = @Id;

        SELECT 1 AS Code,
               N'El juego se actualizó correctamente.' AS Message;
    END TRY
    BEGIN CATCH
        SELECT 0 AS Code,
               N'No fue posible completar la operación. Inténtalo nuevamente.' AS Message;
    END CATCH
END
GO

-- ============================================================================
-- USER PROCEDURES
-- ============================================================================

CREATE OR ALTER PROCEDURE dbo.sp_InsertUser
    @Id        UNIQUEIDENTIFIER,
    @Name      NVARCHAR(100),
    @Email     NVARCHAR(150),
    @UserName  NVARCHAR(50),
    @Password  NVARCHAR(255),
    @UserRole  INT,
    @UserState INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        IF EXISTS (
            SELECT 1
            FROM dbo.Users
            WHERE Email = @Email
        )
        BEGIN
            SELECT 0 AS Code,
                   N'El correo electrónico ya está registrado.' AS Message;
            RETURN;
        END

        IF EXISTS (
            SELECT 1
            FROM dbo.Users
            WHERE UserName = @UserName
        )
        BEGIN
            SELECT 0 AS Code,
                   N'El nombre de usuario ya está en uso.' AS Message;
            RETURN;
        END

        INSERT INTO dbo.Users (
            Id,
            Name,
            Email,
            UserName,
            Password,
            UserRole,
            UserState
        )
        VALUES (
            @Id,
            @Name,
            @Email,
            @UserName,
            @Password,
            @UserRole,
            @UserState
        );

        SELECT 1 AS Code,
               N'El usuario se registró correctamente.' AS Message;
    END TRY
    BEGIN CATCH
        SELECT 0 AS Code,
               N'No fue posible completar la operación. Inténtalo nuevamente.' AS Message;
    END CATCH
END
GO

CREATE OR ALTER PROCEDURE dbo.sp_UpdateUser
    @Id        UNIQUEIDENTIFIER,
    @Name      NVARCHAR(100),
    @Email     NVARCHAR(150),
    @UserName  NVARCHAR(50),
    @Password  NVARCHAR(255),
    @UserRole  INT,
    @UserState INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        IF NOT EXISTS (
            SELECT 1
            FROM dbo.Users
            WHERE Id = @Id
        )
        BEGIN
            SELECT 0 AS Code,
                   N'No se encontró el usuario solicitado.' AS Message;
            RETURN;
        END

        IF EXISTS (
            SELECT 1
            FROM dbo.Users
            WHERE Email = @Email
              AND Id <> @Id
        )
        BEGIN
            SELECT 0 AS Code,
                   N'El correo electrónico ya está registrado en otra cuenta.' AS Message;
            RETURN;
        END

        IF EXISTS (
            SELECT 1
            FROM dbo.Users
            WHERE UserName = @UserName
              AND Id <> @Id
        )
        BEGIN
            SELECT 0 AS Code,
                   N'El nombre de usuario ya está en uso por otra cuenta.' AS Message;
            RETURN;
        END

        UPDATE dbo.Users
        SET
            Name      = @Name,
            Email     = @Email,
            UserName  = @UserName,
            Password  = @Password,
            UserRole  = @UserRole,
            UserState = @UserState
        WHERE Id = @Id;

        SELECT 1 AS Code,
               N'El usuario se actualizó correctamente.' AS Message;
    END TRY
    BEGIN CATCH
        SELECT 0 AS Code,
               N'No fue posible completar la operación. Inténtalo nuevamente.' AS Message;
    END CATCH
END
GO

-- ============================================================================
-- CONTACT PROCEDURES
-- ============================================================================

CREATE OR ALTER PROCEDURE dbo.sp_InsertContact
    @Id      UNIQUEIDENTIFIER,
    @Message NVARCHAR(1000),
    @Email   NVARCHAR(150),
    @State   INT,
    @SentAt  DATETIME2 = NULL
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        INSERT INTO dbo.Contacts (
            Id,
            Message,
            Email,
            State,
            SentAt
        )
        VALUES (
            @Id,
            @Message,
            @Email,
            @State,
            COALESCE(@SentAt, SYSUTCDATETIME())
        );

        SELECT 1 AS Code,
               N'Tu mensaje se envió correctamente.' AS Message;
    END TRY
    BEGIN CATCH
        SELECT 0 AS Code,
               N'No fue posible completar la operación. Inténtalo nuevamente.' AS Message;
    END CATCH
END
GO
