import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    triggerSelector: String
  }

  connect() {
    if ( this.hasTriggerSelectorValue ) {
      const triggers = document.querySelectorAll(this.triggerSelectorValue)

      triggers.forEach(trigger => trigger.addEventListener("click", event => this.open(event)))
    }
  }

  open(event) {
    console.log("clicked")
    event.preventDefault()
    this.element.classList.remove("hidden")
  }

  close() {
    this.element.classList.add("hidden")
  }
}
