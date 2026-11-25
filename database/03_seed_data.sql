
-- ============================================================================
-- JoyGames - 03_seed_data.sql
-- Inserts initial data synchronized with JoyGames.Core.
-- ============================================================================

USE JoyGamesDb;
GO

-- ============================================================================
-- ROLES
-- ============================================================================

-- Role IDs must match the UserRole enum.
UPDATE r
SET r.Name = v.Name
FROM dbo.Roles r
INNER JOIN (VALUES
    (0, N'Admin'),
    (1, N'Operator'),
    (2, N'Supervisor'),
    (3, N'Technician'),
    (4, N'User')
) AS v(Id, Name)
    ON r.Id = v.Id;

INSERT INTO dbo.Roles (Id, Name)
SELECT v.Id, v.Name
FROM (VALUES
    (0, N'Admin'),
    (1, N'Operator'),
    (2, N'Supervisor'),
    (3, N'Technician'),
    (4, N'User')
) AS v(Id, Name)
WHERE NOT EXISTS (
    SELECT 1
    FROM dbo.Roles r
    WHERE r.Id = v.Id
);
GO

-- ============================================================================
-- STATES
-- ============================================================================

-- UserState: 0, 1, 2 | ContactState: 50, 52.
UPDATE s
SET s.Name = v.Name
FROM dbo.States s
INNER JOIN (VALUES
    (0,  N'Active'),
    (1,  N'Inactive'),
    (2,  N'Deleted'),
    (50, N'Pending'),
    (52, N'Answered')
) AS v(Id, Name)
    ON s.Id = v.Id;

INSERT INTO dbo.States (Id, Name)
SELECT v.Id, v.Name
FROM (VALUES
    (0,  N'Active'),
    (1,  N'Inactive'),
    (2,  N'Deleted'),
    (50, N'Pending'),
    (52, N'Answered')
) AS v(Id, Name)
WHERE NOT EXISTS (
    SELECT 1
    FROM dbo.States s
    WHERE s.Id = v.Id
);
GO

-- ============================================================================
-- CATEGORIES
-- ============================================================================

-- Base categories synchronized with CategoryEnum.
SET IDENTITY_INSERT dbo.Categories ON;

UPDATE c
SET c.Name = v.Name
FROM dbo.Categories c
INNER JOIN (VALUES
    (1, N'Platforms'),
    (2, N'Adventures')
) AS v(Id, Name)
    ON c.Id = v.Id;

INSERT INTO dbo.Categories (Id, Name)
SELECT v.Id, v.Name
FROM (VALUES
    (1, N'Platforms'),
    (2, N'Adventures')
) AS v(Id, Name)
WHERE NOT EXISTS (
    SELECT 1
    FROM dbo.Categories c
    WHERE c.Id = v.Id
);

SET IDENTITY_INSERT dbo.Categories OFF;
GO

-- ============================================================================
-- COMPANIES
-- ============================================================================

-- Sample companies.
INSERT INTO dbo.Companies (Name, Country)
SELECT v.Name, v.Country
FROM (VALUES
    (N'Nintendo', N'Japón'),
    (N'Sony Interactive Entertainment', N'Japón'),
    (N'Capcom', N'Japón'),
    (N'Valve', N'Estados Unidos')
) AS v(Name, Country)
WHERE NOT EXISTS (
    SELECT 1
    FROM dbo.Companies c
    WHERE c.Name = v.Name
);
GO
