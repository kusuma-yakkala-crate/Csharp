IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
CREATE TABLE [Customer] (
    [Id] int NOT NULL IDENTITY,
    [Name] nvarchar(max) NOT NULL,
    [Address] nvarchar(max) NOT NULL,
    [PhoneNumber] int NOT NULL,
    [Email] nvarchar(max) NOT NULL,
    CONSTRAINT [PK_Customer] PRIMARY KEY ([Id])
);

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20250312060541_intitialmigration', N'9.0.3');

CREATE TABLE [Categories] (
    [Id] int NOT NULL IDENTITY,
    [Beauty] nvarchar(max) NOT NULL,
    [Fragrances] nvarchar(max) NOT NULL,
    [Productid] nvarchar(max) NOT NULL,
    CONSTRAINT [PK_Categories] PRIMARY KEY ([Id])
);

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20250312061902_initial', N'9.0.3');

DECLARE @var sysname;
SELECT @var = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Customer]') AND [c].[name] = N'Address');
IF @var IS NOT NULL EXEC(N'ALTER TABLE [Customer] DROP CONSTRAINT [' + @var + '];');
ALTER TABLE [Customer] DROP COLUMN [Address];

DECLARE @var1 sysname;
SELECT @var1 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Categories]') AND [c].[name] = N'Beauty');
IF @var1 IS NOT NULL EXEC(N'ALTER TABLE [Categories] DROP CONSTRAINT [' + @var1 + '];');
ALTER TABLE [Categories] DROP COLUMN [Beauty];

DECLARE @var2 sysname;
SELECT @var2 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Categories]') AND [c].[name] = N'Fragrances');
IF @var2 IS NOT NULL EXEC(N'ALTER TABLE [Categories] DROP CONSTRAINT [' + @var2 + '];');
ALTER TABLE [Categories] DROP COLUMN [Fragrances];

EXEC sp_rename N'[Customer].[Id]', N'CustomerId', 'COLUMN';

EXEC sp_rename N'[Categories].[Productid]', N'CategoriesName', 'COLUMN';

EXEC sp_rename N'[Categories].[Id]', N'CategoriesId', 'COLUMN';

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20250319065207_shopify', N'9.0.3');

COMMIT;
GO

