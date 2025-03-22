
using Microsoft.AspNetCore.Mvc;
using Shopfy.Shopify.Services;
using Shopfy.ShopfyDomain;

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

        //public async Task<IActionResult> AddProduct([FromBody] Products product)
        //{
        //    try
        //    {
        //        await _productsService.AddProduct(product);
        //        return CreatedAtAction(nameof(GetProductById), new { id = product.Id }, product);
        //    }
        //    catch (Exception ex)
        //    {
        //        return BadRequest(ex.Message);
        //    }
        //}


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
        public ActionResult<Products> AddProduct(string productName, string image, int star, decimal newPrice, decimal oldPrice, string brand, int stock, string description,int SubCategoriesId)
        {
         
            var product = new Products
            {
                productName = productName,
                Image = image,
                star = star,
                NewPrice = newPrice,
                oldprice = oldPrice,
                brand = brand,
                stock = stock,
                discription = description,
                SubCategoriesId = SubCategoriesId
            };

           
            var createdProduct = _productsService.InsertProductsService(product);

            
            if (createdProduct == null)
            {
                return StatusCode(500, "Product could not be created.");
            }

            return Ok(createdProduct);
        }


    }
}
