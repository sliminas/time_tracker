import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="turbo-confirm"
export default class extends Controller {
  static targets = ["dialog", "modal", "title", "body", "confirmButton", "cancelButton"]
  static values = {
    title: {
      type: String,
      default: "Are you sure?"
    },
    body: {
      type: String,
      default: "This action can't be undone"
    },
    confirmText: {
      type: String,
      default: "Confirm"
    },
    cancelText: {
      type: String,
      default: "Cancel"
    }
  }

  connect() {
    this.setupDialog()
  }

  setupDialog() {
    Turbo.setConfirmMethod((_, element) => {
      let {
        confirmTitle,
        confirmBody,
        confirmText,
        cancelText
      } = element.dataset

      this.titleTarget.innerText = confirmTitle || this.titleValue
      this.bodyTarget.innerText = confirmBody || this.bodyValue
      this.confirmButtonTarget.innerText = confirmText || this.confirmTextValue
      this.cancelButtonTarget.innerText = cancelText || this.cancelTextValue

      this.modalTarget.classList.add("d-block")
      this.dialogTarget.showModal()

      return new Promise((resolve, reject) => {
        this.dialogTarget.addEventListener(
          "close",
          () => resolve(this.dialogTarget.returnValue === "confirm"),
          { once: true }
        )
      })
    })
  }
}
