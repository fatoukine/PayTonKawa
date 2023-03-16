const axios = require('axios');
const chai = require('chai');
const expect = chai.expect;

describe('API REST', () => {
  // endpoint pour la liste des clients
  describe('GET /customers', () => {
    it('devrait renvoyer une liste de clients', async () => {
      const response = await axios.get('http://localhost:3000/customers');
      expect(response.status).to.equal(200);
      expect(response.data).to.be.an('array');
      expect(response.data[0]).to.have.property('id');
      expect(response.data[0]).to.have.property('name');
      expect(response.data[0]).to.have.property('email');
    });
  });

  // endpoint pour la liste des commandes d'un client
  describe('GET /customers/:customerId/orders', () => {
    it('devrait renvoyer une liste de commandes', async () => {
      const customerId = 1;
      const response = await axios.get(`http://localhost:3000/customers/${customerId}/orders`);
      expect(response.status).to.equal(200);
      expect(response.data).to.be.an('array');
      expect(response.data[0]).to.have.property('id');
      expect(response.data[0]).to.have.property('date');
      expect(response.data[0]).to.have.property('customerId');
    });
  });

  // endpoint pour la liste de produits d'une commande
  describe('GET /customers/:customerId/orders/:orderId/products', () => {
    it('devrait renvoyer une liste de produits', async () => {
      const customerId = 1;
      const orderId = 1;
      const response = await axios.get(`http://localhost:3000/customers/${customerId}/orders/${orderId}/products`);
      expect(response.status).to.equal(200);
      expect(response.data).to.be.an('array');
      expect(response.data[0]).to.have.property('id');
      expect(response.data[0]).to.have.property('name');
      expect(response.data[0]).to.have.property('price');
    });
  });
});
