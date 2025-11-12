import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["preview", "input"]

  connect() {
    if (this.hasInputTarget) {
      this.inputTarget.addEventListener("change", this.preview.bind(this))
    }
  }

  disconnect() {
    if (this.hasInputTarget) {
      this.inputTarget.removeEventListener("change", this.preview.bind(this))
    }
  }

  preview(event) {
    const file = event.target.files[0]
    if (file && file.type.startsWith("image/")) {
      const reader = new FileReader()
      reader.onload = (e) => {
        if (this.hasPreviewTarget) {
          this.previewTarget.src = e.target.result
          this.previewTarget.style.display = "block"
        }
      }
      reader.readAsDataURL(file)
    } else {
      if (this.hasPreviewTarget) {
        this.previewTarget.style.display = "none"
        this.previewTarget.src = ""
      }
    }
  }

  clear() {
    if (this.hasInputTarget) {
      this.inputTarget.value = ""
    }
    if (this.hasPreviewTarget) {
      this.previewTarget.style.display = "none"
      this.previewTarget.src = ""
    }
  }
}

