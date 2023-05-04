import { Inter } from "next/font/google";
import { Disclosure } from "@headlessui/react";

import Header from "@/components/header";
import { httpClient } from "@/utils/http";

const inter = Inter({ subsets: ["latin"] });

export async function getStaticPaths() {
  try {
    const response = await httpClient.get("/resources");
    const productPaths = response.data.map((product) => {
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
  } catch (error) {
    console.log("Error fetching paths.");
    return {
      paths: [],
      fallback: false,
    };
  }
}

// TODO: make call to API to return list of products and their faqs
export async function getStaticProps(context) {
  try {
    const response = await httpClient.get(`/resources/${context.params.slug}`);
    return {
      props: {
        resource: response.data,
      },
    };
  } catch (error) {
    return {};
  }
}

export default function Resource({ resource }) {
  return (
    <main className={`${inter.className} max-w-3xl`}>
      <Header suffix={resource.name} />
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
