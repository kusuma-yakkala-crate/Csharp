using Microsoft.AspNetCore.Mvc;
using Shopfy.Shopify.Services;
using Shopfy.ShopfyDomain;
namespace Shopfy.Controllers
{

    [Route("api/[controller]")]
    [ApiController]
    public class CategoriesController : ControllerBase
    {

        private readonly CategoriesServices _categoriesServices;

        public CategoriesController(CategoriesServices categoriesServices)
        {
            _categoriesServices = categoriesServices;
        }



        [HttpGet]
        public ActionResult<List<Categories>> DisplayCategories()
        {
            var categories = _categoriesServices.DisplayCategoriesServices();

            return Ok(categories);
        }
        [HttpPost]

        public ActionResult<Categories> InsertCustomer(Categories categories)
        {
            if (categories == null)
            {
                return BadRequest("categories data is null.");
            }

            var categorie = _categoriesServices.InsertCategoriesService(categories);

            return Ok(categorie);
        }




    }
}

