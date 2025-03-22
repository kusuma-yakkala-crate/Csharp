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
ALTER TABLE [Orders] DROP CONSTRAINT [FK_Orders_Customer_CustomerId];

DROP INDEX [IX_Orders_CustomerId] ON [Orders];

DECLARE @var sysname;
SELECT @var = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Orders]') AND [c].[name] = N'CustomerId');
IF @var IS NOT NULL EXEC(N'ALTER TABLE [Orders] DROP CONSTRAINT [' + @var + '];');
ALTER TABLE [Orders] DROP COLUMN [CustomerId];

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20250320104732_shopifys', N'9.0.3');

COMMIT;
GO

