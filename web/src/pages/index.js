import { Inter } from "next/font/google";

import Header from "@/components/header";
import ListOfProducts from "@/components/listOfProducts";
import { httpClient } from "@/utils/http";

const inter = Inter({ subsets: ["latin"] });

export async function getStaticProps(_) {
  let products = [];

  try {
    const response = await httpClient.get("/resources");
    products = response.data;
  } catch (error) {
    console.error("ERROR: fetching /resoures from API", error);
  }

  return {
    props: { products: products },
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
