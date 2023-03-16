const express = require('express');
const axios = require('axios');
const app = express();
const port = 3000;

// endpoint pour la liste des clients
app.get('/customers', async (req, res) => {
  try {
    // appel de l'API pour récupérer la liste des clients
    const response = await axios.get('https://615f5fb4f7254d0017068109.mockapi.io/api/v1/customers');
    const customers = response.data;
    // réponse en JSON
    res.json(customers);
  } catch (error) {
    console.error(error);
    res.status(500).send('Erreur serveur');
  }
});

// endpoint pour la liste des commandes d'un client
app.get('/customers/:customerId/orders', async (req, res) => {
  try {
    // appel de l'API pour récupérer la liste des commandes du client
    const customerId = req.params.customerId;
    const response = await axios.get(`https://615f5fb4f7254d0017068109.mockapi.io/api/v1/customers/${customerId}/orders`);
    const orders = response.data;
    // réponse en JSON
    res.json(orders);
  } catch (error) {
    console.error(error);
    res.status(500).send('Erreur serveur');
  }
});

// endpoint pour la liste de produits d'une commande
app.get('/customers/:customerId/orders/:orderId/products', async (req, res) => {
  try {
    // appel de l'API pour récupérer la liste de produits de la commande
    const customerId = req.params.customerId;
    const orderId = req.params.orderId;
    const response = await axios.get(`https://615f5fb4f7254d0017068109.mockapi.io/api/v1/customers/${customerId}/orders/${orderId}/products`);
    const products = response.data;
    // réponse en JSON
    res.json(products);
  } catch (error) {
    console.error(error);
    res.status(500).send('Erreur serveur');
  }
});

// démarrage du serveur
app.listen(port, () => {
  console.log(`Serveur démarré sur le port ${port}`);
});
