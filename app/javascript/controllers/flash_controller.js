import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.startHidingTimer();
  }

  startHidingTimer() {
    setTimeout(() => {
      this.hideElement();
    }, 5000); 
  }

  hideElement() {
    this.element.style.opacity = '0';
    this.element.addEventListener("transitionend", () => this.removeElement(), { once: true });
  }

  removeElement() {
    this.element.remove();
  }
}
