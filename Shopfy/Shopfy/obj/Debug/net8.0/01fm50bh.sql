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
ALTER TABLE [Products] ADD [SubCategoriesId] int NOT NULL DEFAULT 0;

CREATE INDEX [IX_Products_SubCategoriesId] ON [Products] ([SubCategoriesId]);

ALTER TABLE [Products] ADD CONSTRAINT [FK_Products_SubCategories_SubCategoriesId] FOREIGN KEY ([SubCategoriesId]) REFERENCES [SubCategories] ([SubCategoriesId]) ON DELETE CASCADE;

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20250319110346_SHOPIFY', N'9.0.3');

COMMIT;
GO

