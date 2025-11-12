import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["submit"]

  connect() {
    if (this.hasSubmitTarget) {
      this.originalValue = this.submitTarget.value
    }
  }

  submit(event) {
    if (this.hasSubmitTarget) {
      this.submitTarget.disabled = true
      this.submitTarget.value = "Saving..."
    }
  }

  reset() {
    if (this.hasSubmitTarget) {
      this.submitTarget.disabled = false
      this.submitTarget.value = this.originalValue || "Submit"
    }
  }
}

