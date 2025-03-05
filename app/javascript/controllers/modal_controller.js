import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal"]

  connect() {
    this.modal = document.getElementById("terms-modal")
    this.openButton = document.getElementById("open-modal")
    this.closeButton = document.getElementById("close-modal")

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
