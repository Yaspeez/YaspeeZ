import { Application } from "@hotwired/stimulus"
import { Autocomplete } from "stimulus-autocomplete"
import { Toggle } from "tailwindcss-stimulus-components"

const application = Application.start()
application.register("autocomplete", Autocomplete)
application.register("toggle", Toggle)

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
