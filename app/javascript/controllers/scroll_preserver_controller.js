import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    storageKey: String // ใช้เก็บ key สำหรับ sessionStorage
  }

  connect() {
    this.restoreScroll()
    this.saveScrollOnUnload()
  }

  // เรียกคืนตำแหน่ง scroll ถ้ามี
  restoreScroll() {
    const key = this.storageKeyValue || "scroll-position"
    const scrollPos = sessionStorage.getItem(key)
    if (scrollPos) {
      window.scrollTo(0, parseInt(scrollPos, 10))
      sessionStorage.removeItem(key)
    }
  }

  // บันทึกตำแหน่ง scroll ก่อน reload หรือ leave หน้า
  saveScrollOnUnload() {
    const key = this.storageKeyValue || "scroll-position"
    window.addEventListener("beforeunload", () => {
      sessionStorage.setItem(key, window.scrollY)
    })
  }
}
