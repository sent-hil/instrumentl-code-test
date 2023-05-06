import { useState } from "react";
import axios from "axios";

import ButtonWithSpinner, { BTN_STATES } from "./buttonWithSpinner";

export default function Header({ suffix }) {
  const [query, setQuery] = useState("");
  const [answer, setAnswer] = useState("");
  const [btnState, setBtnState] = useState(BTN_STATES.disabled);

  const hasQuery = query !== "";

  function onSubmit(e) {
    setBtnState(BTN_STATES.inflight);
    e.preventDefault();

    axios
      .get("/api/query", {
        params: { query: query },
      })
      .then((response) => {
        setAnswer(response.data.response);
      })
      .catch((error) => {
        setAnswer("I'm sorry, something went wrong. Please try again.");
        console.log(error);
      })
      .finally(() => {
        setBtnState(BTN_STATES.enabled);
      });
  }

  return (
    <header className="flex align-item justify-center flex-col items-center">
      <h1 className="text-5xl leading-none font-extrabold tracking-tight text-gray-900">
        Ask PDF {suffix && <span className="text-blue-700">{suffix}</span>}
      </h1>
      <h2 className="text-xl leading-7 font-normal max-w-screen-md text-center mt-5 text-gray-500">
        Proof of concept of interactively debugging problems in your physical
        products.
      </h2>
      <div className="max-w-xl">
        <form className="flex mt-10" onSubmit={onSubmit}>
          <input
            className="placeholder:text-slate-400 block bg-white w-full border border-gray-300 rounded-md py-2 pl-3 shadow-sm focus:outline-none focus:border-gray-200 focus:ring-gray-300 focus:ring-1"
            placeholder="How do I clean fujifilm lens?"
            type="text"
            name="search"
            size="50"
            onChange={(e) => setQuery(e.target.value.trim())}
          />
          <ButtonWithSpinner
            text={"Ask"}
            animate={btnState === BTN_STATES.inflight}
            disabled={!hasQuery || btnState === BTN_STATES.inflight}
          />
        </form>
        {answer && (
          <div className="mt-6 text-sm leading-5 font-normal">
            <p className="text-gray-500">Answer</p>
            <p className="text-gray-900">{answer}</p>
          </div>
        )}
      </div>
    </header>
  );
}
