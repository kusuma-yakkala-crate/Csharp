using Microsoft.AspNetCore.Mvc;
using Shopfy.dTO;
using Shopfy.ShopfyDomain;
using Shopfy.Shopify.Services;

namespace Shopfy.Controllers
{

    [Route("api/[controller]")]
    [ApiController]
    public class CustomerController : ControllerBase
    {
        private readonly CustomerService _customerService;

        public CustomerController(CustomerService customerService)
        {
            _customerService = customerService;
        }


        [HttpGet]
        public ActionResult<List<Customer>> DisplayCustomer()
        {
            var customer = _customerService.displayCustomerService();



            return Ok(customer);
        }
        [HttpPost]

        public ActionResult<CustomerDto> InsertCustomer(CustomerDto CustomerDto)
        {
            if (CustomerDto == null)
            {
                return BadRequest("customer data is null.");
            }

            var customers = _customerService.InsertServiceFunction(CustomerDto);

            return Ok(customers);
        }


    }
}

