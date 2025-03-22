
using Microsoft.AspNetCore.Mvc;
using Shopfy.Shopify.Services;
using Shopfy.ShopfyDomain;
using Microsoft.AspNetCore.Http.HttpResults;
using System;

namespace Shopfy.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProductsController : ControllerBase
    {
        private readonly ProductsService _productsService;

    
        public ProductsController(ProductsService productsService)
        {
            _productsService = productsService;
        }

      
        [HttpGet]
        public ActionResult<List<Products>> DisplayProducts()
        {
            var products = _productsService.displayProductsService();

            return Ok(products);
        }


        [HttpGet("{id}")]
        public async Task<IActionResult> GetProductById(int id)
        {
            var product = await _productsService.GetProductById(id);
            if (product == null) return NotFound();
            return Ok(product);
        }


        //[HttpPost]
        //public ActionResult<Products> AddProduct(Products product)
        //{
        //    if (product == null)
        //    {
        //        return BadRequest("Product data is null.");
        //    }
        //    Console.WriteLine(product);
        //    var createdProduct = _productsService.insertProductsService(product);

        //    return Ok(createdProduct);
        //}

        [HttpGet("category/{categoryId}")]
        public async Task<IActionResult> GetProductsByCategoryId(int categoryId)
        {
            var products = await _productsService.GetProductsByCategoryId(categoryId);
            if (!products.Any()) return NotFound($"No products found for category ID {categoryId}");
            return Ok(products);
        }


        [HttpPost]
        public ActionResult<Products> AddProduct(string productName,string ProductTittle, string image, int star, decimal newPrice, decimal oldPrice, string brand, int stock, string description,string Reviewdiscription,int SalesCount, DateTime CreatedAt,int SubCategoriesId,string SubCategoriesName)
        {
         
            var product = new Products
            {
                productName = productName,
                ProductTittle = ProductTittle,
                Image = image,
                star = star,
                NewPrice = newPrice,
                oldprice = oldPrice,
                brand = brand,
                stock = stock,
                discription = description,
                Reviewdiscription = Reviewdiscription,
                SalesCount = SalesCount,
                CreatedAt = CreatedAt,
                SubCategoriesId = SubCategoriesId,
                SubCategoriesName = SubCategoriesName
            };

           
            var createdProduct = _productsService.InsertProductsService(product);

            
            if (createdProduct == null)
            {
                return StatusCode(500, "Product could not be created.");
            }

            return Ok(createdProduct);
        }


        [HttpGet("trending")]
        public async Task<IActionResult> GetTrendingProducts()
        {
            var products = await _productsService.GetTrendingProducts();
            return Ok(products);
        }
        [HttpGet("new-arrivals")]
        public async Task<IActionResult> GetNewArrivalProducts()
        {
            var products = await _productsService.GetNewArrivalProducts();
            return Ok(products);
        }


        [HttpGet("search")]

        public async Task<IActionResult> SearchProducts(string productName)

        {

            var products = await _productsService.SearchProducts(productName);

            if (products == null || !products.Any())

                return NotFound($"No products found for '{productName}'");

            return Ok(products);
        }

    }
}
