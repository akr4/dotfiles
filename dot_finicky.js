module.exports = {
  defaultBrowser: "Safari",
  handlers: [
    {
      match: /^https?:\/\/linear\.app\//,
      url: ({ url }) => ({
        ...url,
        protocol: "linear",
      }),
      browser: "Linear",
    },
    {
      match: "mcp.linear.app/*",
      browser: "Google Chrome",
    },
    {
      match: "github.com/*",
      browser: "Firefox",
    },
  ],
};
