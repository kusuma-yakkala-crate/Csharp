using Shopfy;
using Shopfy.Shopify.Repo;
using Shopfy.Shopify.Services;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddDbContext<shopifydbcontext>(ServiceLifetime.Scoped);
builder.Services.AddScoped<ProductsRepo>();
builder.Services.AddScoped<ProductsService>();

builder.Services.AddScoped<CustomerRepo>();
builder.Services.AddScoped<CustomerService>();

builder.Services.AddScoped<CategoriesRepo>();
builder.Services.AddScoped<CategoriesServices>();


builder.Services.AddScoped<SubCategoriesRepo>();
builder.Services.AddScoped<SubCategoriesServices>();

builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAll",
        b => b.AllowAnyOrigin()
                .AllowAnyHeader()
                .AllowAnyMethod());
});
var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}
app.UseCors("AllowAll");
app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
