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
ALTER TABLE [Products] DROP CONSTRAINT [FK_Products_SubCategories_SubCategoriesId];

DROP INDEX [IX_Products_SubCategoriesId] ON [Products];

DECLARE @var sysname;
SELECT @var = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Products]') AND [c].[name] = N'SubCategoriesId');
IF @var IS NOT NULL EXEC(N'ALTER TABLE [Products] DROP CONSTRAINT [' + @var + '];');
ALTER TABLE [Products] DROP COLUMN [SubCategoriesId];

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20250319110246_SHOPIFY', N'9.0.3');

COMMIT;
GO

