import Header from "@/components/header";
import ListOfProducts from "@/components/listOfProducts";

import { Inter } from "next/font/google";
const inter = Inter({ subsets: ["latin"] });

import { PRODUCTS } from "@/data/products";

// TODO: make call to API to return list of products
export async function getStaticProps(context) {
  try {
    const response = await axios.get("/api/resources");
    console.log(response.data);
  } catch (error) {
    console.error(error);
  }

  return {
    props: { products: PRODUCTS },
  };
}

export default function Home({ products }) {
  return (
    <main className={`${inter.className}`}>
      <Header />
      <ListOfProducts products={products} />
    </main>
  );
}
