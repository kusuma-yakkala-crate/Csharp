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

CREATE TABLE [Address] (
    [AddressId] int NOT NULL IDENTITY,
    [city] nvarchar(max) NOT NULL,
    [state] nvarchar(max) NOT NULL,
    [country] nvarchar(max) NOT NULL,
    [postalCode] nvarchar(max) NOT NULL,
    [CustomerId] int NOT NULL,
    CONSTRAINT [PK_Address] PRIMARY KEY ([AddressId]),
    CONSTRAINT [FK_Address_Customer_CustomerId] FOREIGN KEY ([CustomerId]) REFERENCES [Customer] ([CustomerId]) ON DELETE CASCADE
);

CREATE TABLE [Cart] (
    [CartId] int NOT NULL IDENTITY,
    [CustomerId] int NOT NULL,
    CONSTRAINT [PK_Cart] PRIMARY KEY ([CartId]),
    CONSTRAINT [FK_Cart_Customer_CustomerId] FOREIGN KEY ([CustomerId]) REFERENCES [Customer] ([CustomerId]) ON DELETE CASCADE
);

CREATE TABLE [SubCategories] (
    [SubCategoriesId] int NOT NULL IDENTITY,
    [SubCategoriesName] nvarchar(max) NOT NULL,
    [CategoriesId] int NOT NULL,
    CONSTRAINT [PK_SubCategories] PRIMARY KEY ([SubCategoriesId]),
    CONSTRAINT [FK_SubCategories_Categories_CategoriesId] FOREIGN KEY ([CategoriesId]) REFERENCES [Categories] ([CategoriesId]) ON DELETE CASCADE
);

CREATE TABLE [Wishlist] (
    [WishlistId] int NOT NULL IDENTITY,
    [WishlistName] nvarchar(max) NOT NULL,
    [CustomerId] int NOT NULL,
    CONSTRAINT [PK_Wishlist] PRIMARY KEY ([WishlistId]),
    CONSTRAINT [FK_Wishlist_Customer_CustomerId] FOREIGN KEY ([CustomerId]) REFERENCES [Customer] ([CustomerId]) ON DELETE CASCADE
);

CREATE TABLE [Order] (
    [OrderId] int NOT NULL IDENTITY,
    [orderDate] int NOT NULL,
    [orderStatus] int NOT NULL,
    [totalPrice] int NOT NULL,
    [CustomerId] int NOT NULL,
    [AddressId] int NOT NULL,
    CONSTRAINT [PK_Order] PRIMARY KEY ([OrderId]),
    CONSTRAINT [FK_Order_Address_AddressId] FOREIGN KEY ([AddressId]) REFERENCES [Address] ([AddressId]) ON DELETE CASCADE,
    CONSTRAINT [FK_Order_Customer_CustomerId] FOREIGN KEY ([CustomerId]) REFERENCES [Customer] ([CustomerId]) ON DELETE CASCADE
);

CREATE TABLE [Products] (
    [Id] int NOT NULL IDENTITY,
    [productName] nvarchar(max) NOT NULL,
    [Image] varbinary(max) NOT NULL,
    [star] real NOT NULL,
    [NewPrice] int NOT NULL,
    [oldprice] int NOT NULL,
    [brand] nvarchar(max) NOT NULL,
    [stock] int NOT NULL,
    [discription] nvarchar(max) NOT NULL,
    [SubCategoriesId] int NOT NULL,
    CONSTRAINT [PK_Products] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_Products_SubCategories_SubCategoriesId] FOREIGN KEY ([SubCategoriesId]) REFERENCES [SubCategories] ([SubCategoriesId]) ON DELETE CASCADE
);

CREATE TABLE [Payment] (
    [PaymentId] int NOT NULL IDENTITY,
    [Amount] int NOT NULL,
    [status] int NOT NULL,
    [OrderId] int NOT NULL,
    [CustomerId] int NOT NULL,
    CONSTRAINT [PK_Payment] PRIMARY KEY ([PaymentId]),
    CONSTRAINT [FK_Payment_Customer_CustomerId] FOREIGN KEY ([CustomerId]) REFERENCES [Customer] ([CustomerId]) ON DELETE CASCADE,
    CONSTRAINT [FK_Payment_Order_OrderId] FOREIGN KEY ([OrderId]) REFERENCES [Order] ([OrderId]) ON DELETE CASCADE
);

CREATE TABLE [CartItem] (
    [CartItemId] int NOT NULL IDENTITY,
    [total] int NOT NULL,
    [quantity] int NOT NULL,
    [ProductId] int NOT NULL,
    [ProductsId] int NOT NULL,
    [CartId] int NOT NULL,
    CONSTRAINT [PK_CartItem] PRIMARY KEY ([CartItemId]),
    CONSTRAINT [FK_CartItem_Cart_CartId] FOREIGN KEY ([CartId]) REFERENCES [Cart] ([CartId]) ON DELETE CASCADE,
    CONSTRAINT [FK_CartItem_Products_ProductsId] FOREIGN KEY ([ProductsId]) REFERENCES [Products] ([Id]) ON DELETE CASCADE
);

CREATE TABLE [OrderItems] (
    [OrderItemsId] int NOT NULL IDENTITY,
    [quantity] int NOT NULL,
    [price] int NOT NULL,
    [OrderId] int NOT NULL,
    [ProductId] int NOT NULL,
    [ProductsId] int NOT NULL,
    CONSTRAINT [PK_OrderItems] PRIMARY KEY ([OrderItemsId]),
    CONSTRAINT [FK_OrderItems_Order_OrderId] FOREIGN KEY ([OrderId]) REFERENCES [Order] ([OrderId]) ON DELETE CASCADE,
    CONSTRAINT [FK_OrderItems_Products_ProductsId] FOREIGN KEY ([ProductsId]) REFERENCES [Products] ([Id]) ON DELETE CASCADE
);

CREATE TABLE [Review] (
    [ReviewId] int NOT NULL IDENTITY,
    [rating] real NOT NULL,
    [CustomerId] int NOT NULL,
    [ProductId] int NOT NULL,
    [ProductsId] int NOT NULL,
    CONSTRAINT [PK_Review] PRIMARY KEY ([ReviewId]),
    CONSTRAINT [FK_Review_Customer_CustomerId] FOREIGN KEY ([CustomerId]) REFERENCES [Customer] ([CustomerId]) ON DELETE CASCADE,
    CONSTRAINT [FK_Review_Products_ProductsId] FOREIGN KEY ([ProductsId]) REFERENCES [Products] ([Id]) ON DELETE CASCADE
);

CREATE TABLE [WishlistItem] (
    [WishlistItemId] int NOT NULL IDENTITY,
    [WishlistId] int NOT NULL,
    [ProductId] int NOT NULL,
    [ProductsId] int NOT NULL,
    CONSTRAINT [PK_WishlistItem] PRIMARY KEY ([WishlistItemId]),
    CONSTRAINT [FK_WishlistItem_Products_ProductsId] FOREIGN KEY ([ProductsId]) REFERENCES [Products] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_WishlistItem_Wishlist_WishlistId] FOREIGN KEY ([WishlistId]) REFERENCES [Wishlist] ([WishlistId]) ON DELETE CASCADE
);

CREATE INDEX [IX_Address_CustomerId] ON [Address] ([CustomerId]);

CREATE INDEX [IX_Cart_CustomerId] ON [Cart] ([CustomerId]);

CREATE INDEX [IX_CartItem_CartId] ON [CartItem] ([CartId]);

CREATE INDEX [IX_CartItem_ProductsId] ON [CartItem] ([ProductsId]);

CREATE INDEX [IX_Order_AddressId] ON [Order] ([AddressId]);

CREATE INDEX [IX_Order_CustomerId] ON [Order] ([CustomerId]);

CREATE INDEX [IX_OrderItems_OrderId] ON [OrderItems] ([OrderId]);

CREATE INDEX [IX_OrderItems_ProductsId] ON [OrderItems] ([ProductsId]);

CREATE INDEX [IX_Payment_CustomerId] ON [Payment] ([CustomerId]);

CREATE INDEX [IX_Payment_OrderId] ON [Payment] ([OrderId]);

CREATE INDEX [IX_Products_SubCategoriesId] ON [Products] ([SubCategoriesId]);

CREATE INDEX [IX_Review_CustomerId] ON [Review] ([CustomerId]);

CREATE INDEX [IX_Review_ProductsId] ON [Review] ([ProductsId]);

CREATE INDEX [IX_SubCategories_CategoriesId] ON [SubCategories] ([CategoriesId]);

CREATE INDEX [IX_Wishlist_CustomerId] ON [Wishlist] ([CustomerId]);

CREATE INDEX [IX_WishlistItem_ProductsId] ON [WishlistItem] ([ProductsId]);

CREATE INDEX [IX_WishlistItem_WishlistId] ON [WishlistItem] ([WishlistId]);

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20250319071239_ShopifyWebsite', N'9.0.3');

EXEC sp_rename N'[WishlistItem].[WishlistItemId]', N'Id', 'COLUMN';

EXEC sp_rename N'[Wishlist].[WishlistId]', N'Id', 'COLUMN';

EXEC sp_rename N'[Review].[ReviewId]', N'Id', 'COLUMN';

EXEC sp_rename N'[Payment].[PaymentId]', N'Id', 'COLUMN';

EXEC sp_rename N'[OrderItems].[OrderItemsId]', N'Id', 'COLUMN';

EXEC sp_rename N'[Order].[OrderId]', N'Id', 'COLUMN';

EXEC sp_rename N'[Customer].[CustomerId]', N'Id', 'COLUMN';

EXEC sp_rename N'[Categories].[CategoriesId]', N'Id', 'COLUMN';

EXEC sp_rename N'[CartItem].[CartItemId]', N'Id', 'COLUMN';

EXEC sp_rename N'[Cart].[CartId]', N'Id', 'COLUMN';

EXEC sp_rename N'[Address].[AddressId]', N'Id', 'COLUMN';

DECLARE @var3 sysname;
SELECT @var3 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Order]') AND [c].[name] = N'orderStatus');
IF @var3 IS NOT NULL EXEC(N'ALTER TABLE [Order] DROP CONSTRAINT [' + @var3 + '];');
ALTER TABLE [Order] ALTER COLUMN [orderStatus] nvarchar(max) NOT NULL;

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20250319072016_ShopifyWebsites', N'9.0.3');

EXEC sp_rename N'[Order].[totalPrice]', N'TotalPrice', 'COLUMN';

EXEC sp_rename N'[Order].[orderStatus]', N'OrderStatus', 'COLUMN';

EXEC sp_rename N'[Order].[orderDate]', N'OrderDate', 'COLUMN';

DECLARE @var4 sysname;
SELECT @var4 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Order]') AND [c].[name] = N'TotalPrice');
IF @var4 IS NOT NULL EXEC(N'ALTER TABLE [Order] DROP CONSTRAINT [' + @var4 + '];');
ALTER TABLE [Order] ALTER COLUMN [TotalPrice] decimal(18,2) NOT NULL;

DECLARE @var5 sysname;
SELECT @var5 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Order]') AND [c].[name] = N'OrderDate');
IF @var5 IS NOT NULL EXEC(N'ALTER TABLE [Order] DROP CONSTRAINT [' + @var5 + '];');
ALTER TABLE [Order] ALTER COLUMN [OrderDate] datetime2 NOT NULL;

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20250319072528_ShopifyWebsitess', N'9.0.3');

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20250319072922_ShopifyWebsitesss', N'9.0.3');

COMMIT;
GO

