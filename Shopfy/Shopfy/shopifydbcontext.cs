//using System.Collections.Generic;
//using Microsoft.EntityFrameworkCore;
//using Shopfy.ShopfyDomain;

//namespace Shopfy
//{
//    public class shopifydbcontext : DbContext
//    {

//            protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
//            {
//                optionsBuilder.UseSqlServer("Data Source=(localdb)\\MSSQLLocalDB; Initial Catalog=Shopify_EfCore")

//                .LogTo(Console.WriteLine, new[] { DbLoggerCategory.Database.Command.Name }, LogLevel.Information)
//                .EnableSensitiveDataLogging();
//            }
//        public DbSet<Customer> Customer { get; set; }

//        public DbSet<Address> Address { get; set; }
//            public DbSet<Cart> Cart { get; set; }
//        public DbSet<CartItem> CartItem { get; set; }
//        public DbSet<Categories> Categories { get; set; }

//       public DbSet<Orders> Orders { get; set; }

//        public DbSet<OrderItems> OrderItems { get; set; }
//        public DbSet<Payment> Payment { get; set; }

//        public DbSet<Products> Products { get; set; }
//        public DbSet<Review> Review { get; set; }
//        public DbSet<SubCategories> SubCategories { get; set; }
//        public DbSet<Wishlist> Wishlist { get; set; }

//        public DbSet<WishlistItem> WishlistItem { get; set; }


//    }

//        }




using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Shopfy.ShopfyDomain;
using Microsoft.Extensions.Logging;

namespace Shopfy
{
    public class shopifydbcontext : DbContext
    {
        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            optionsBuilder.UseSqlServer("Data Source=(localdb)\\MSSQLLocalDB; Initial Catalog=ShopiIfy_EfCore")
                .LogTo(Console.WriteLine, new[] { DbLoggerCategory.Database.Command.Name }, LogLevel.Information)
                .EnableSensitiveDataLogging();
        }

        public DbSet<Customer> Customer { get; set; }
        public DbSet<Address> Address { get; set; }
        public DbSet<Cart> Cart { get; set; }
        public DbSet<CartItem> CartItem { get; set; }
        public DbSet<Categories> Categories { get; set; }
        public DbSet<Orders> Orders { get; set; }
        public DbSet<OrderItems> OrderItems { get; set; }
        public DbSet<Payment> Payment { get; set; }
        public DbSet<Products> Products { get; set; }
        public DbSet<Review> Review { get; set; }
        public DbSet<SubCategories> SubCategories { get; set; }
        public DbSet<Wishlist> Wishlist { get; set; }
        public DbSet<WishlistItem> WishlistItem { get; set; }

        // Configure the foreign key relationships
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder.Entity<Orders>()
                .HasOne(o => o.Customer)
                .WithMany(c => c.Orders)
                .HasForeignKey(o => o.CustomerId)
               .OnDelete(DeleteBehavior.Restrict);



        }
    }
}
