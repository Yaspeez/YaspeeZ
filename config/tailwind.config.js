const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      colors: {
        "code-400": "#fefcf9",
        "code-600": "#3c455b",
        "deep-blue": "#000272",
        "dark-blue": "#0003bf",
        "yaspeez-blue": "#0004ff",
        "lockmara": "#0072c0",
        "lockrama": "#0085e0",
        "doger-blue": "#0097ff",
        "pampas": "f3f0ec",
        "silver-green": "#5ca284",
      },
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
  ]
}
