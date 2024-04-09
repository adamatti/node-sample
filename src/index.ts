import {PrismaClient} from "@prisma/client";  
import express from "express";

const PORT = process.env.PORT ?? 3000;
const app = express();
const prisma = new PrismaClient();

app.get("/orders", async (req, res) => {
  const orders = await prisma.order.findMany();
  res.json(orders);
});

app.post("/orders", async (req, res) => {
  const order = await prisma.order.create({data: { }});
  res.status(201).json(order);
});

app.listen(PORT, () => { 
  console.log(`Server is running on port ${PORT}`)
});