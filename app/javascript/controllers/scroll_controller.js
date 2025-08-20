// app/javascript/controllers/scroll_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { targetId: String }

  connect() {
    if (this.hasTargetIdValue) {
      const el = document.getElementById(this.targetIdValue)
      if (el) el.scrollIntoView({ behavior: "smooth", block: "start" })
    }
  }
}
