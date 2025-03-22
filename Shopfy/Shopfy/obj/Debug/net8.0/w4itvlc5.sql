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
CREATE TABLE [Categories] (
    [Id] int NOT NULL IDENTITY,
    [CategoriesName] nvarchar(max) NOT NULL,
    CONSTRAINT [PK_Categories] PRIMARY KEY ([Id])
);

CREATE TABLE [Customer] (
    [Id] int NOT NULL IDENTITY,
    [Name] nvarchar(max) NOT NULL,
    [PhoneNumber] nvarchar(max) NOT NULL,
    [Email] nvarchar(max) NOT NULL,
    CONSTRAINT [PK_Customer] PRIMARY KEY ([Id])
);

CREATE TABLE [SubCategories] (
    [SubCategoriesId] int NOT NULL IDENTITY,
    [SubCategoriesName] nvarchar(max) NOT NULL,
    [CategoriesId] int NOT NULL,
    CONSTRAINT [PK_SubCategories] PRIMARY KEY ([SubCategoriesId]),
    CONSTRAINT [FK_SubCategories_Categories_CategoriesId] FOREIGN KEY ([CategoriesId]) REFERENCES [Categories] ([Id]) ON DELETE CASCADE
);

CREATE TABLE [Address] (
    [Id] int NOT NULL IDENTITY,
    [City] nvarchar(max) NOT NULL,
    [State] nvarchar(max) NOT NULL,
    [Country] nvarchar(max) NOT NULL,
    [PostalCode] nvarchar(max) NOT NULL,
    [CustomerId] int NOT NULL,
    CONSTRAINT [PK_Address] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_Address_Customer_CustomerId] FOREIGN KEY ([CustomerId]) REFERENCES [Customer] ([Id]) ON DELETE CASCADE
);

CREATE TABLE [Cart] (
    [Id] int NOT NULL IDENTITY,
    [CustomerId] int NOT NULL,
    CONSTRAINT [PK_Cart] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_Cart_Customer_CustomerId] FOREIGN KEY ([CustomerId]) REFERENCES [Customer] ([Id]) ON DELETE CASCADE
);

CREATE TABLE [Orders] (
    [Id] int NOT NULL IDENTITY,
    [totalamount] decimal(18,2) NOT NULL,
    [ordersstatus] nvarchar(max) NOT NULL,
    [orderedDate] datetime2 NOT NULL,
    [CustomerId] int NOT NULL,
    CONSTRAINT [PK_Orders] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_Orders_Customer_CustomerId] FOREIGN KEY ([CustomerId]) REFERENCES [Customer] ([Id]) ON DELETE NO ACTION
);

CREATE TABLE [Wishlist] (
    [Id] int NOT NULL IDENTITY,
    [WishlistName] nvarchar(max) NOT NULL,
    [CustomerId] int NOT NULL,
    CONSTRAINT [PK_Wishlist] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_Wishlist_Customer_CustomerId] FOREIGN KEY ([CustomerId]) REFERENCES [Customer] ([Id]) ON DELETE CASCADE
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
    [Id] int NOT NULL IDENTITY,
    [Amount] int NOT NULL,
    [status] int NOT NULL,
    [OrderId] int NOT NULL,
    [CustomerId] int NOT NULL,
    CONSTRAINT [PK_Payment] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_Payment_Customer_CustomerId] FOREIGN KEY ([CustomerId]) REFERENCES [Customer] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_Payment_Orders_OrderId] FOREIGN KEY ([OrderId]) REFERENCES [Orders] ([Id]) ON DELETE CASCADE
);

CREATE TABLE [CartItem] (
    [Id] int NOT NULL IDENTITY,
    [total] int NOT NULL,
    [quantity] int NOT NULL,
    [ProductId] int NOT NULL,
    [ProductsId] int NOT NULL,
    [CartId] int NOT NULL,
    CONSTRAINT [PK_CartItem] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_CartItem_Cart_CartId] FOREIGN KEY ([CartId]) REFERENCES [Cart] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_CartItem_Products_ProductsId] FOREIGN KEY ([ProductsId]) REFERENCES [Products] ([Id]) ON DELETE CASCADE
);

CREATE TABLE [OrderItems] (
    [Id] int NOT NULL IDENTITY,
    [quantity] int NOT NULL,
    [price] int NOT NULL,
    [OrdersId] int NOT NULL,
    [ProductId] int NOT NULL,
    [ProductsId] int NOT NULL,
    CONSTRAINT [PK_OrderItems] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_OrderItems_Orders_OrdersId] FOREIGN KEY ([OrdersId]) REFERENCES [Orders] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_OrderItems_Products_ProductsId] FOREIGN KEY ([ProductsId]) REFERENCES [Products] ([Id]) ON DELETE CASCADE
);

CREATE TABLE [Review] (
    [Id] int NOT NULL IDENTITY,
    [rating] real NOT NULL,
    [CustomerId] int NOT NULL,
    [ProductId] int NOT NULL,
    [ProductsId] int NOT NULL,
    CONSTRAINT [PK_Review] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_Review_Customer_CustomerId] FOREIGN KEY ([CustomerId]) REFERENCES [Customer] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_Review_Products_ProductsId] FOREIGN KEY ([ProductsId]) REFERENCES [Products] ([Id]) ON DELETE CASCADE
);

CREATE TABLE [WishlistItem] (
    [Id] int NOT NULL IDENTITY,
    [WishlistId] int NOT NULL,
    [ProductId] int NOT NULL,
    [ProductsId] int NOT NULL,
    CONSTRAINT [PK_WishlistItem] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_WishlistItem_Products_ProductsId] FOREIGN KEY ([ProductsId]) REFERENCES [Products] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_WishlistItem_Wishlist_WishlistId] FOREIGN KEY ([WishlistId]) REFERENCES [Wishlist] ([Id]) ON DELETE CASCADE
);

CREATE INDEX [IX_Address_CustomerId] ON [Address] ([CustomerId]);

CREATE INDEX [IX_Cart_CustomerId] ON [Cart] ([CustomerId]);

CREATE INDEX [IX_CartItem_CartId] ON [CartItem] ([CartId]);

CREATE INDEX [IX_CartItem_ProductsId] ON [CartItem] ([ProductsId]);

CREATE INDEX [IX_OrderItems_OrdersId] ON [OrderItems] ([OrdersId]);

CREATE INDEX [IX_OrderItems_ProductsId] ON [OrderItems] ([ProductsId]);

CREATE INDEX [IX_Orders_CustomerId] ON [Orders] ([CustomerId]);

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
VALUES (N'20250319084800_shopifywebsite', N'9.0.3');

COMMIT;
GO

