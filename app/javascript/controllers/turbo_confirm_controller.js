import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="turbo-confirm"
export default class extends Controller {
  static targets = ["dialog", "title", "body", "confirmButton", "cancelButton"]
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

      const modal = new bootstrap.Modal(this.dialogTarget)

      modal.show()
      // this.dialogTarget.classList.remove('hidden')

      // this.dialogTarget.showModal()

      // return new Promise((resolve, reject) => {
      //   this.dialogTarget.addEventListener("close", () => {
      //     // this.dialogTarget.classList.add('hidden')
      //     resolve(this.dialogTarget.returnValue === "confirm")
      //   }, { once: true })
      // })
    })
  }
}
