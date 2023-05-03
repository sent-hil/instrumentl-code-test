import { useState } from "react";

export default function Header() {
  // TODO: probably want to lift this state up, since we want to disable button
  // while the request is in flight.
  const [disabled, setDisabled] = useState(true);

  function onInputChange(e) {
    if (e.target.value !== "") setDisabled(false);
    else setDisabled(true);
  }

  return (
    <header className="flex align-item justify-center flex-col items-center">
      <h1 className="text-6xl leading-none font-extrabold tracking-tight text-gray-900">
        Ask PDF
      </h1>
      <h2 className="text-xl leading-7 font-normal max-w-screen-md text-center mt-5 text-gray-500">
        Proof of concept of interactively debugging problems in your physical
        products. The system has been trained on a limited number of products
        only.
      </h2>
      <form className="flex mt-10 max-w-lg">
        <input
          class="placeholder:text-slate-400 block bg-white w-full border border-gray-300 rounded-md py-2 pl-3 shadow-sm focus:outline-none focus:border-gray-200 focus:ring-gray-300 focus:ring-1"
          placeholder="How do I clean the lens?"
          type="text"
          name="search"
          size="50"
          onChange={onInputChange}
        />
        <button
          type="submit"
          className="bg-blue-600 text-white rounded-md ml-2 px-8 hover:bg-blue-700 disabled:bg-gray-300 disabled:cursor-not-allowed"
          disabled={disabled}
        >
          Ask
        </button>
      </form>
    </header>
  );
}
