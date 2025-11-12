import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["toggleable"]

  toggle() {
    this.toggleableTargets.forEach(target => {
      target.classList.toggle("hidden")
    })
  }

  show() {
    this.toggleableTargets.forEach(target => {
      target.classList.remove("hidden")
    })
  }

  hide() {
    this.toggleableTargets.forEach(target => {
      target.classList.add("hidden")
    })
  }
}

