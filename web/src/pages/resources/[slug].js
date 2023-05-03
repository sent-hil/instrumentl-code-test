import Header from "@/components/header";
import { PRODUCTS } from "@/data/products";

import { Disclosure } from "@headlessui/react";

import { Inter } from "next/font/google";
const inter = Inter({ subsets: ["latin"] });

// TODO: make call to API to return list of product slugs
export async function getStaticPaths() {
  const productPaths = PRODUCTS.map((product) => {
    return {
      params: {
        slug: product.slug,
      },
    };
  });
  return {
    paths: productPaths,
    fallback: false,
  };
}

// TODO: make call to API to return list of products and their faqs
export async function getStaticProps(context) {
  // TODO: get faqs from database.
  return {
    props: {
      resource: {
        slug: context.params.slug,
        faqs: [
          {
            question: "How do I clean the lens?",
            answer:
              "I don't know, but the flag is a big plus. Lorem ipsum dolor sit amet consectetur adipisicing elit. Quas cupiditate laboriosam fugiat.",
          },
          {
            question: "How do you make holy water?",
            answer:
              "I don't know, but the flag is a big plus. Lorem ipsum dolor sit amet consectetur adipisicing elit. Quas cupiditate laboriosam fugiat.",
          },
        ],
      },
    },
  };
}

export default function Resource({ resource }) {
  return (
    <main className={`${inter.className} max-w-3xl`}>
      <Header />
      <h1 className="text-4xl leading-10 font-extrabold mt-20 text-center">
        Frequently Asked Questions
      </h1>
      <section className="mt-12">
        {resource.faqs.map((faq) => {
          return (
            <>
              <Disclosure>
                <Disclosure.Button className="text-lg leading-7 font-medium text-gray-900">
                  {faq.question}
                </Disclosure.Button>
                <Disclosure.Panel className="text-gray-500 leading-6 mt-4">
                  {faq.answer}
                </Disclosure.Panel>
              </Disclosure>
              <div className="border-[0.5px] text-gray-200 bottom-t w-full my-8"></div>
            </>
          );
        })}
      </section>
    </main>
  );
}
