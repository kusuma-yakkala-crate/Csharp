using Microsoft.EntityFrameworkCore;
using Shopfy.ShopfyDomain;
namespace Shopfy.Shopify.Repo
{
    public class ProductsRepo
    {
        private shopifydbcontext context;
        public ProductsRepo(shopifydbcontext context) { 
            this.context = context;
        }

        public List<Products> dispalyProducts()
        {
           var products = context.Products.ToList();
            return products;
        }

        public Products InsertProductsFunction(Products products)
        {

            var product = context.Products.Add(products);
            context.SaveChanges();
            return products;
        }

   

        public async Task<Products> GetProductById(int id) => await context.Products.FindAsync(id);
        public async Task AddProduct(Products product)
        {
        
            var subcategoryExists = await context.SubCategories.AnyAsync(s => s.SubCategoriesId == product.SubCategoriesId);
            if (!subcategoryExists)
            {
                throw new Exception($"Subcategory with ID {product.SubCategoriesId} does not exist.");
            }
            context.Products.Add(product);
            await context.SaveChangesAsync();
        }

        public async Task<IEnumerable<Products>> GetProductsByCategoryId(int categoryId)
        {
            return await context.Products.Where(p => p.SubCategoriesId == categoryId).ToListAsync();
        }


        //public Products InsertProductsFunction(Products product)
        //{

        //    var addedProduct = context.Products.Add(product);

        //        context.SaveChanges();

        //    return addedProduct;
        //}


        public async Task<IEnumerable<Products>> GetTrendingProducts()
        {
            return await context.Products
                .OrderByDescending(p => p.SalesCount)
                .Take(10)
                .ToListAsync();
        }
        public async Task<IEnumerable<Products>> GetNewArrivalProducts()
        {
            DateTime thirtyDaysAgo = DateTime.UtcNow.AddDays(-30);
            return await context.Products
                .Where(p => p.CreatedAt >= thirtyDaysAgo)
                .OrderByDescending(p => p.CreatedAt)
                .Take(10)
                .ToListAsync();
        }

        public async Task<IEnumerable<Products>> SearchProducts(string searchTerm)
        {
            if (string.IsNullOrWhiteSpace(searchTerm))
                return await context.Products.ToListAsync(); 
            return await context.Products
                .Where(p => p.productName.Contains(searchTerm) ||
                            p.discription.Contains(searchTerm) ||
                            p.SubCategories.SubCategoriesName.Contains(searchTerm))
                .ToListAsync();
        }
    }
}
