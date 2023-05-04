import Header from "@/components/header";
import ListOfProducts from "@/components/listOfProducts";

import { Inter } from "next/font/google";
const inter = Inter({ subsets: ["latin"] });

import { httpClient } from "@/utils/http";

export async function getStaticProps(context) {
  try {
    const response = await httpClient.get("/resources");
    return {
      props: { products: response.data },
    };
  } catch (error) {
    console.error(error);
    return {
      props: { products: [] },
    };
  }
}

export default function Home({ products }) {
  return (
    <main className={`${inter.className}`}>
      <Header />
      <ListOfProducts products={products} />
    </main>
  );
}
