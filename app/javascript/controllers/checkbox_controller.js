import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="checkbox"
export default class extends Controller {
  submit(event) {
    event.preventDefault() // ป้องกัน form submit ปกติ
    const form = this.element.closest("form")

    fetch(form.action, {
      method: form.method.toUpperCase(),
      body: new FormData(form),
      headers: { "Accept": "text/vnd.turbo-stream.html" }
    })
  }
}
