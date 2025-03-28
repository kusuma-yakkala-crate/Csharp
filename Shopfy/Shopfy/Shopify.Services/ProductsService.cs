﻿using Shopfy.Shopify.Repo;
using Shopfy.ShopfyDomain;
using Microsoft.EntityFrameworkCore;

namespace Shopfy.Shopify.Services
{

    public class ProductsService
    {
        private readonly ProductsRepo _productsRepo;

        public ProductsService(ProductsRepo productsRepo)
        {

            this._productsRepo = productsRepo;
        }

        public List<Products> displayProductsService()
        {

            var products = _productsRepo.dispalyProducts();
            return products;
        }

        //public Products insertProductsService(Products Products)
        //{
        //    var products = _productsRepo.insertProductsFunction(Products);

        //    return products;



        //}

        public Products InsertProductsService(Products product)
        {

            var createdProduct = _productsRepo.InsertProductsFunction(product);

            return createdProduct;
        }



        public async Task<Products> GetProductById(int id) => await _productsRepo.GetProductById(id);

        public async Task AddProduct(Products product)
        {

            await _productsRepo.AddProduct(product);
        }

        public async Task<IEnumerable<Products>> GetProductsByCategoryId(int categoryId)

        {
            return await _productsRepo.GetProductsByCategoryId(categoryId);
        }

        public async Task<IEnumerable<Products>> GetTrendingProducts()
        {
            return await _productsRepo.GetTrendingProducts();
        }

        public async Task<IEnumerable<Products>> GetNewArrivalProducts()
        {
            return await _productsRepo.GetNewArrivalProducts();
        }

        public async Task<IEnumerable<Products>> SearchProducts(string searchTerm)
        {
            return await _productsRepo.SearchProducts(searchTerm);

        }
    }

}