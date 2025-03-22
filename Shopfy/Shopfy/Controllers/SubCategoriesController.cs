using Microsoft.AspNetCore.Mvc;
using Shopfy.Shopify.Services;
using Shopfy.ShopfyDomain;
namespace Shopfy.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class SubCategoriesController : ControllerBase
    {
        private readonly SubCategoriesServices _SubCategoriesServices;

        public SubCategoriesController(SubCategoriesServices SubCategoriesServices)
        {
            _SubCategoriesServices = SubCategoriesServices;
        }



        [HttpGet]
        public ActionResult<List<SubCategories>> DisplaySubCategories()
        {
            var SubCategorie = _SubCategoriesServices.displaySubCategoriesService();

            return Ok(SubCategorie);
        }
        //[HttpPost]

        //public ActionResult<SubCategories> InsertSubCategories(SubCategories subCategories)
        //{
        //    if (subCategories == null)
        //    {
        //        return BadRequest("SubCategories data is null.");
        //    }

        //    var subCategorie = _SubCategoriesServices.insertSubCategoriesService(subCategories);

        //    return Ok(subCategorie);
        //}


        [HttpPost]
        public ActionResult<SubCategories> InsertSubCategories(string SubCategoriesName, int CategoriesId)
        {

            var subCategories = new SubCategories
            {
                SubCategoriesName = SubCategoriesName,
                CategoriesId = CategoriesId
            };


            var createdSubCategories = _SubCategoriesServices.insertSubCategoriesService(subCategories);


            if (createdSubCategories == null)
            {
                return StatusCode(500, "Product could not be created.");
            }

            return Ok(createdSubCategories);
        }



    }
}


