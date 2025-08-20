import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { targetId: String }

  scrollToTarget() {
    if (this.targetIdValue) {
      const el = document.getElementById(this.targetIdValue)
      if (el) {
        el.scrollIntoView({ behavior: "smooth", block: "start" })
      }
    }
  }
}

// ฟัง custom event จาก Turbo Stream
document.addEventListener("quest:created", (event) => {
  const el = document.getElementById(event.detail.id)
  if (el) el.scrollIntoView({ behavior: "smooth", block: "start" })
})
