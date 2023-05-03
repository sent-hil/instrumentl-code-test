import { Html, Head, Main, NextScript } from "next/document";

export default function Document() {
  return (
    <Html lang="en">
      <Head>
        <title>Ask PDF</title>
      </Head>
      <body
        className={"mt-40 flex align-item justify-center flex-col items-center"}
      >
        <Main />
        <NextScript />
      </body>
    </Html>
  );
}
