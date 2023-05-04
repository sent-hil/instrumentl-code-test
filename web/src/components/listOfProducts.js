import Link from "next/link";

export default function ListOfProducts({ products }) {
  return (
    <section className="max-w-3xl m-8 mt-20">
      <div>
        <h1 className="leading-6 font-medium text-gray-900">
          The system is trained on the manuals of following products.
        </h1>
        <h2 className="text-sm leading-5 font-normal text-gray-500 mt-1">
          You can ask any questions about it
        </h2>
      </div>
      <div className="grid gap-4 mt-8 grid-cols-2">
        {products.map((p) => (
          <Link
            className="leading-6 font-medium text-blue-600 hover:underline"
            key={p.name}
            href={`/resources/${p.slug}`}
            target="_blank"
          >
            {p.name}
          </Link>
        ))}
      </div>
    </section>
  );
}
