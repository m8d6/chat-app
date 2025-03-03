import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    url: String
  }

  async open() {
    const response = await fetch(this.urlValue, {
      headers: {
        Accept: "text/vnd.turbo-stream.html"
      }
    })
    const html = await response.text()
    document.getElementById("modal-container").innerHTML = html
  }

  close(event) {
    event.preventDefault()
    const modal = document.getElementById("modal-container")
    modal.innerHTML = ""
  }
} 