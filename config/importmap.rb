# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "@hotwired--stimulus.js" # @3.2.1
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "slim-select" # @2.5.0
pin "@hotwired/stimulus", to: "@hotwired--stimulus.js" # @3.2.1
pin "trix"
pin "@rails/actiontext", to: "actiontext.js"
pin "flowbite" # @1.6.5
pin "@popperjs/core", to: "@popperjs--core.js" # @2.11.8
pin "stimulus-autocomplete" # @3.1.0
pin "tailwindcss-stimulus-components" # @3.0.4
pin "@rails/activestorage", to: "@rails--activestorage.js" # @7.0.5
