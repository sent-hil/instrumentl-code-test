/** @type {import('next').NextConfig} */

console.log(`${process.env.NEXT_PUBLIC_API_URL}/:path*`);

module.exports = {
  reactStrictMode: true,
  async rewrites() {
    return [
      {
        source: "/api/:path*",
        destination: `${process.env.NEXT_PUBLIC_API_URL}/:path*`,
      },
    ];
  },
};
