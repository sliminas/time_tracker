import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="turbo-confirm"
export default class extends Controller {
  static targets = ["dialog", "backdrop", "modal", "title", "body", "confirmButton", "cancelButton"]
  static values = {
    title: {
      type: String,
      default: "Are you sure?"
    },
    body: {
      type: String,
      default: "This action can't be undone"
    },
    confirmLabel: {
      type: String,
      default: "Confirm"
    },
    cancelLabel: {
      type: String,
      default: "Cancel"
    }
  }

  connect() {
    this.setupDialog()
  }

  toggleModal() {
    this.dialogTarget.classList.toggle("hidden")
    this.backdropTarget.classList.toggle("hidden")
  }

  setupDialog() {
    Turbo.setConfirmMethod((_, element) => {
      let {
        confirmTitle,
        confirmBody,
        confirmVariant,
        confirmLabel,
        cancelLabel
      } = element.dataset

      this.titleTarget.innerText = confirmTitle || this.titleValue
      this.bodyTarget.innerText = confirmBody || this.bodyValue
      this.confirmButtonTarget.innerText = confirmLabel || this.confirmLabelValue
      this.cancelButtonTarget.innerText = cancelLabel || this.cancelLabelValue

      const confirmButtonClass = confirmVariant === 'primary' ? 'btn--primary' : 'btn--danger'
      this.confirmButtonTarget.classList.add(confirmButtonClass)

      this.toggleModal()

      return new Promise((resolve, _reject) => {
        this.confirmButtonTarget.addEventListener(
          "click",
          () => resolve(true),
          { once: true }
        )
      })
    })
  }
}
