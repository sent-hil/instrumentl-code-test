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
          <div className="flex space-x-1 items-center" key={p.name}>
            <Link
              className="leading-6 font-medium text-blue-600 hover:underline"
              href={`/resources/${p.slug}`}
              target="_blank"
            >
              {p.name}
            </Link>
            <a href={p.url} target="_blank">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                fill="none"
                viewBox="0 0 24 24"
                strokeWidth="1.5"
                stroke="currentColor"
                className="w-4 h-4"
              >
                <path
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  d="M13.19 8.688a4.5 4.5 0 011.242 7.244l-4.5 4.5a4.5 4.5 0 01-6.364-6.364l1.757-1.757m13.35-.622l1.757-1.757a4.5 4.5 0 00-6.364-6.364l-4.5 4.5a4.5 4.5 0 001.242 7.244"
                />
              </svg>
            </a>
          </div>
        ))}
      </div>
    </section>
  );
}
