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
ALTER TABLE [Orders] ADD [CustomerId] int NOT NULL DEFAULT 0;

ALTER TABLE [OrderItems] ADD [OrdersId] int NOT NULL DEFAULT 0;

CREATE INDEX [IX_Orders_CustomerId] ON [Orders] ([CustomerId]);

CREATE INDEX [IX_OrderItems_OrdersId] ON [OrderItems] ([OrdersId]);

ALTER TABLE [OrderItems] ADD CONSTRAINT [FK_OrderItems_Orders_OrdersId] FOREIGN KEY ([OrdersId]) REFERENCES [Orders] ([Id]) ON DELETE CASCADE;

ALTER TABLE [Orders] ADD CONSTRAINT [FK_Orders_Customer_CustomerId] FOREIGN KEY ([CustomerId]) REFERENCES [Customer] ([Id]) ON DELETE NO ACTION;

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20250320111833_shopify', N'9.0.3');

COMMIT;
GO

