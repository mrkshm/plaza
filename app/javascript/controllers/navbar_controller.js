import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navbar"
export default class extends Controller {
  static targets = ["mobileMenu", "toggleButton"]

  connect() {}

  toggle() {
    const isHidden = this.mobileMenuTarget.classList.toggle("hidden")
    if (this.hasToggleButtonTarget) {
      this.toggleButtonTarget.setAttribute("aria-expanded", String(!isHidden))
    }
  }
}
