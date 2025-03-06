import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal", "openButton", "closeButton"]

  connect() {
  this.modal = this.modalTarget
    this.openButton = this.openButtonTarget
    this.closeButton = this.closeButtonTarget

    this.openButton.addEventListener("click", (event) => this.open(event))
    this.closeButton.addEventListener("click", () => this.close())

    this.modal.addEventListener("click", (event) => {
      if (event.target === this.modal) {
        this.close()
      }
    })
  }

  open(event) {
    event.preventDefault()
    this.modal.classList.remove("hidden")
  }

  close() {
    this.modal.classList.add("hidden")
  }
}
